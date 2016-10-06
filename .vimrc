set rtp+=~/.vim/bundle/Vundle.vim
colorscheme flattown

nmap <silent> <C-D> :NERDTreeToggle<CR>
let g:user_emmet_expandabbr_key = '<C-D>'

call vundle#begin()

filetype plugin indent on 
syntax on 

Plugin 'gmarik/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'scrooloose/syntastic'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
Plugin 'easymotion/vim-easymotion'

Plugin 'Valloric/YouCompleteMe'
Plugin 'ternjs/tern_for_vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fatih/vim-go'

call vundle#end() 


"JSBeauty
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
" Html Beautify
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

"vim syntax checker
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_javascript_checkers = ['jscs']

"Vim configs
set termencoding=utf-8
set encoding=utf-8
set laststatus=2
set number
set foldmethod=indent
"use system's clipboard, using this you can
set clipboard=unnamedplus
