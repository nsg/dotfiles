" vim: set sw=4 ts=4 sts=4 et tw=78

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

" Airline
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'

" Git Gutter
let g:gitgutter_sign_added = '★'
let g:gitgutter_sign_modified = '☆'
let g:gitgutter_sign_removed = '⚫'
let g:gitgutter_sign_removed_first_line = '☗'
let g:gitgutter_sign_modified_removed = '☖'

" vim-ansible-yaml
let g:ansible_options = {'ignore_blank_lines': 1}

" Set/remove options
set nocompatible					" Enable fancy improved stuff!
set autoindent						" Automatic ident
set smartindent						" Smart idents
set showmatch						" Show matching brackets
set incsearch						" Search while we type
set background=dark					" We like dark backgrounds
set number							" Show line numbers
set shiftround						" Round indent to multiple of 'shiftwidth'
set foldenable						" Enable folds
set showcmd							" Show partial commands in status line and
									" Selected characters/lines in visual mode
set smarttab						" Smarter tab idents
set backup							" Enable vim backups
set backupdir=~/.vim/backup			" Set vim backup directory
set directory=~/.vim/tmp			" Set vim temporary directory
set nojoinspaces					" Prevents inserting two spaces after a J
set list							" Show hidden chars
set listchars-=eol:$				" Hide eol
set listchars+=tab:→\ 				" Show tabs
set listchars+=trail:■
set t_Co=256

" misc maps
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
inoremap fd <esc>					" Type fd to enter normal mode

" Map spacebar to leader
nnoremap <SPACE> <Nop>				" Disable spacebar
let mapleader = " "					" Set spacebar to leader

" syntax
syntax on
colorscheme desert

" formatting rules
set ts=4 sts=4 sw=4 noexpandtab

au BufRead,BufNewFile *.rb,*.rhtml,*.yml,Vagrantfile set sts=2 sw=2 expandtab
au BufRead,BufNewFile *.py,*.py.* set sts=4 sw=4 expandtab
au BufNewFile,BufRead *.gradle setf groovy
au BufRead,BufNewFile *.yml set filetype=ansible

