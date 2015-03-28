"# .vimrc

""
"  pathogen settings
""
execute pathogen#infect()
syntax on
filetype plugin indent on

""
" My settings
""

" For ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" NerdTree
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if !argc() | NERDTreeMirror | endif

set nocompatible
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
au BufNewFile,BufRead *.gradle setf groovy
au BufRead,BufNewFile *.yml set filetype=ansible
