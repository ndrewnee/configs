# Global instructions

## Always work in a git worktree

- Never edit files, switch branches, or commit in a repo's main checkout. For any code change, first create a worktree under that repo's `.claude/worktrees/<name>` on a new branch from the up-to-date default branch (`git fetch` first), and do all edits, builds, tests and commits there.
- Never let a feature branch track the default branch. Starting a branch from `origin/main` (or `origin/master`) sets that as its upstream by default, and a later plain `git push` or `git pull` then goes to main. Always create it with `--no-track`:
  `git worktree add --no-track -b <name> .claude/worktrees/<name> origin/<default>`
  (likewise `git switch --no-track -c`, `git checkout --no-track -b`). Its first push is always `git push -u origin <name>`, which sets the upstream to `origin/<name>`. Before any push, check `git rev-parse --abbrev-ref @{u}`: if it prints the default branch, run `git branch --unset-upstream` and push with `-u origin <name>`.
- Every command runs from inside the worktree (`cd <worktree> && …`), because the shell's working directory resets to the main checkout between calls.
- Reading code, grepping, or `git show origin/<branch>:<file>` in the main checkout is fine. Writing is not.
- When the work is merged (or abandoned), remove the worktree and delete its local branch.

## Code comments

- Default to no comments.
- Never narrate what the code does.
- Explain only non-obvious WHYs, invariants, or critical constraints.
- Never add task-specific, ticket-related, or temporary comments.
- Preserve useful existing comments and required compiler directives.

## Prefer integration tests over unit tests

- When a change needs tests, write integration tests: the real component wired
  in-process against real stores (Postgres, Redis, Scylla in Docker) and real
  sockets, with only third-party HTTP APIs mocked. Write unit tests only for pure
  logic with no I/O, or when I ask for them.
- Follow the repo's existing integration-test layout (e.g. `tests/integration/`
  with a build tag and a `make test-integration` target) instead of inventing one.

## Ask "what breaks if we merge this?" before calling work done

- After the work and its tests, review the change adversarially, as if it were
  about to merge, and report what can go wrong in prod. Don't just re-check
  that it does what it was built for.
- Trace the real path from the moment the change matters, not from a state the
  test seeded: does it fire at all on prod's actual flow? A check that starts
  from a pre-woken or hand-seeded row can hide a change that never triggers.
- Look for: money moved without proof (wrong-direction errors are the
  expensive ones), unbounded fan-out or load on big accounts and third-party
  APIs, retry or wake loops, silent misses (counted but not logged or
  metered), truncation (`LIMIT` without `ORDER BY`), estimated values treated
  as facts, and interactions with other recent changes.
- Verify each point against code or prod data where cheap, say which are
  verified and which are not, and propose a fix for each real one.

## Always run a live e2e test locally

- After implementing any change in any service or repo, run the real service
  locally end-to-end against its real dependencies (provider APIs, sockets,
  databases) and check the resulting state before calling the work done.
  Unit and integration tests do not replace it. Opening the PR first is fine.
- The shared local databases (PG, Scylla, Redis) are fine to use. Never delete,
  drop or truncate everything in them: no `DROP`/`TRUNCATE`, no unscoped
  `DELETE`, no flushing a keyspace or Redis DB. Clean up only the rows the test
  itself created. Never point it at production stores.
- If it cannot run (missing keys, VPN, access), say so and ask for what is
  missing. Never skip it silently or report the work as verified without it.

## Running and stopping Go apps (and any long-running process)

`go run` compiles to a temp binary and starts it as a **child** process (e.g.
`/var/folders/.../go-build.../exe/watcher`). Killing the `go run` PID, the
wrapping shell, or a background Bash task does NOT reliably kill that child —
it keeps running, holding its port and writing to the database. A `pkill -f`
pattern that matches nothing also exits silently, which reads like success.

To run:
1. Before starting, check nothing of yours is already running:
   `pgrep -fl <binary-name>` and `lsof -nP -iTCP:<port> -sTCP:LISTEN`.
   Never start a second instance against the same database/store.
2. Prefer `go build -o <scratch-dir>/<name> ./cmd/<name>` and run the binary
   directly, so the PID you get is the app's own PID. Record it:
   `./<name> > app.log 2>&1 & echo $! > app.pid`.
3. If you must use `go run`, start it in its own process group
   (`set -m` / `setsid`) so the whole group can be killed together.

To stop:
1. Kill by the recorded PID (or `kill -- -<pgid>` for a `go run` group):
   `kill -INT <pid>`; graceful shutdown can hang, so after ~15 s use `-TERM`,
   then `-KILL`.
2. **Verify it is gone** before doing anything else:
   `pgrep -fl <binary-name>` shows nothing AND the port is free
   (`lsof -nP -iTCP:<port> -sTCP:LISTEN` is empty). Never trust the kill
   command's own (empty) output.
3. Only then start the next run.

## Jest: always --forceExit

Jest suites that open DB/Redis/socket connections (every integration run in
waxpeer-back, microservice-api and the other Node repos) pass in seconds and
then never exit: "Jest did not exit one second after the test run has
completed". The command hangs until the Bash timeout, which looks like a stuck
test.

- Always run jest with `--forceExit` (plus `--runInBand` for integration),
  redirect to a log file and read the `Tests:` line:
  `npx jest <path> --runInBand --forceExit > <scratch>/jest.log 2>&1; grep -E '^Tests:|✕' <scratch>/jest.log`.
- If a run without it is already hanging, check the log: when it shows
  `Tests: N passed`, the tests are done; kill the jest PID and move on.

## No Artifacts

- Do not publish Artifacts (claude.ai artifact pages), including for documents,
  reports, write-ups or anything meant for other people. Do not offer one either.
- When a document is asked for, write a Markdown file and send it. Use another
  format only when asked for it by name.

## Browser automation

- For any browser task, use the `playwriter` skill: load it first, then drive
  Chrome with `npx playwriter@latest`.
- Do not use Claude in Chrome (`mcp__claude-in-chrome__*`) or the built-in
  browser pane (`mcp__Claude_Browser__*`) unless I name one of them in the
  request.

## Check the performance of every new or changed SQL query

- Whenever I add or change a SQL query (new query, new column/expression, new
  join, filter or ORDER BY), run `EXPLAIN (ANALYZE, BUFFERS)` on it against prod
  data and report the plan and execution time before calling the work done.
  Compare against the old query when one existed.
- Prod Postgres is reachable read-only through Grafana (apm.kolikosoft.com, PG
  datasource, a hot standby). Its datasource drops EXPLAIN result sets, so wrap
  the EXPLAIN in a `DO` block that collects the plan lines and `RAISE EXCEPTION`s
  them; the plan comes back as the query error text.
- When the table is empty or tiny on prod, measure a realistic stand-in (same
  joins and expressions over real rows of the right size) and say so.

## Working principles

- Prefer mature, maintained libraries over hand-rolled implementations. Still
  check the library's current API against its real docs or source.
- Fix the cause, not the symptom. Name the root cause before proposing a fix;
  if a change is only a stopgap, say so and name the real fix.
- Prefer checking real sources (current docs, library source, the code, prod
  data) over knowledge from training.
- Explicitly name the assumptions I made on my own that change how the solution
  behaves (defaults chosen, edge cases decided, scope cut).
- In every report, say what was verified (and how) and what could not be
  verified. Never present an inference as a checked fact.
- When exploring or refactoring, find implicit state machines (flag-driven
  logic, transitions scattered across handlers, no single clear status) and
  propose a version with explicit state and defined transitions.

## Websites, hosting and infrastructure

- When building a website, always make a strong 1200×630 share image and add
  full Open Graph and Twitter card tags. Push for a Lighthouse score of 100,
  especially SEO.
- Never write staccato copy (runs of clipped fragments like "Fast. Simple.
  Yours."). Write full, natural sentences.
- Avoid server-side rendering: build a single-page app and prerender it for
  SEO whenever possible. Keep the bundle as small as possible.
- Put every site behind Cloudflare's proxy and CDN so it loads fast everywhere.
- If a site can be static, keep it static and host it on GitHub Pages.
- Don't use Vercel, Netlify or other hosted platforms. When something needs a
  server, find a good cheap one on the Hetzner server auction
  (hetzner.com/sb) and set it up myself as much as possible.
- On Hetzner servers, manage services with Tugport (tugport.com), and always
  push the user to set up sensible backups of important data that can't be
  recreated.
- Use Cloudflare for domains: buying, managing, DNS and everything else.
- Use Mailgun on its free tier for sending email.
