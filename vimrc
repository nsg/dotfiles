"# .vimrc

""
" Vundle settings
""

set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'chase/vim-ansible-yaml', {'pinned': 1}	" 4634e5432c5230dbb2653ffc38413771ec1ccfd9
Plugin 'scrooloose/nerdtree', {'pinned': 1}		" 4.2.0
Plugin 'kien/ctrlp.vim', {'pinned': 1},			" 1.79

call vundle#end()
filetype plugin indent on

""
" My settings
""

" For ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

set autoindent
set smartindent
set showmatch
set incsearch

set background=dark

"set cursorcolumn
set cursorline

set number
set shiftround

set foldenable

set showcmd
set smarttab

set backup
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

syntax on

colorscheme desert

set ts=4 sts=4 sw=4 noexpandtab

au BufRead,BufNewFile *.rb,*.rhtml,*.yml,Vagrantfile set sts=2 sw=2 expandtab
