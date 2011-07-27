"# .vimrc

set nocompatible
set autoindent
set smartindent
"set shiftwidth=4
"set softtabstop=4
set showmatch
set incsearch

set background=dark

set cursorcolumn
set cursorline

set number
"set expandtab
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

au BufRead,BufNewFile *.rb,*.rhtml set shiftwidth=2
au BufRead,BufNewFile *.rb,*.rhtml set softtabstop=2
