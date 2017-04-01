" vim: set sw=4 ts=4 sts=4 et tw=78

""
"  load vim-plug to manage plugins
""
call plug#begin('~/.local/share/nvim/plugged')
Plug 'pearofducks/ansible-vim', { 'commit': '8540ad7ff0f8da2b31b5c55e6ae52ad87221e918' }
Plug 'scrooloose/nerdtree', { 'tag': '5.0.0' }
Plug 'kien/ctrlp.vim', { 'commit': 'c1646e3c28d75bcc834af4836f4c6e12296ba891' }
Plug 'ekalinin/Dockerfile.vim', { 'commit': '1fc71e1c82e1b818d3353c8f1c28afece5e20046' }
Plug 'tpope/vim-commentary', { 'tag': 'v1.2' }
Plug 'airblade/vim-gitgutter', { 'commit': '339f8ba079ed7d465ca442c9032b36bc56c21f61' }
Plug 'bling/vim-airline', { 'tag': 'v0.7' }
Plug 'majutsushi/tagbar', { 'tag': 'v2.6.1' }
Plug 'SirVer/ultisnips', { 'tag': '3.0' }
Plug 'rking/ag.vim', { 'commit': 'f755abfb1c4e4e3f59f6cfa25ce16edb5af9e516' }
call plug#end()

""
" My settings
""

" For ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" NerdTree
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd BufEnter * if !argc() | NERDTreeMirror | endif
nmap <F5> :NERDTreeToggle<CR>
nmap <F6> :NERDTreeFind<CR>

" Ag.vim
nmap <F7> :NERDTreeClose<CR>:Ag 

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
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '☗'
let g:gitgutter_sign_modified_removed = '☖'

" Tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

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
set nojoinspaces					" Prevents inserting two spaces after a J
set list							" Show hidden chars
set listchars-=eol:$				" Hide eol
set listchars+=tab:→\ 				" Show tabs
set listchars+=trail:■
set t_Co=256
set mouse=c

" misc maps
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Easier movements between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Map spacebar to leader
nnoremap <SPACE> <Nop>				" Disable spacebar
let mapleader = " "					" Set spacebar to leader

" syntax
syntax on
colorscheme desert
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad cterm=underline ctermfg=red
hi SpellRare cterm=underline ctermfg=magenta
hi SpellLocal cterm=underline ctermfg=cyan

" default formatting rules
set ts=4 sts=4 sw=4 noexpandtab

au BufRead,BufNewFile *.rb,*.rhtml,*.yml,Vagrantfile set sts=2 sw=2 expandtab
au BufRead,BufNewFile *.py,*.py.*,*.java,*.c,*.h,*.cpp set expandtab
au BufNewFile,BufRead *.gradle setf groovy
au BufRead,BufNewFile *.yml set filetype=ansible spell
au BufRead,BufNewFile *.md set filetype=markdown spell
au BufRead,BufNewFile COMMIT_EDITMSG set spell
au FileType vim set spell