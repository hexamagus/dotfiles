set nocompatible
filetype off
let mapleader = "-"
let maplocalleader = "\\"
nnoremap <leader>d dd
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
"Plugin 'valloric/youcompleteme'
Plugin 'larsbs/vimterial_dark'
Plugin 'jnurmine/Zenburn'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'Lokaltog/vim-powerline'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/nerdtree'
Bundle 'topfunky/PeepOpen-EditorSupport', {'rtp': 'vim-peepopen/'}
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'nvie/vim-flake8'
Plugin 'vim-syntastic/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'

filetype plugin indent on

" ==========================================================
" Shortcuts
" ==========================================================
" Seriously, guys. It's not like :W is bound to anything anyway.
command! W :w

" Allow pasting blocks of code without indenting
set pastetoggle=<F2>

"Fix Shift+Tab
nmap <S-Tab> <<
imap <S-Tab> <Esc><<i
inoremap jk <Esc>

nmap <Leader>t :TagbarToggle<CR>
nmap <Leader>n :NERDTreeToggle<CR>

" Let me save files with sudo
cmap w!! w !sudo tee % >/dev/null

let NERDTreeIgnore = ['\.pyc$']

set tw=0
set wm=0
set nowrap
set linebreak

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set showcmd

set colorcolumn=80

" don't bell or blink
"set noerrorbells
"set vb t_vb=


" don't outdent hashes
inoremap # #

set tabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set smartindent
set fileformat=unix
"set mouse=a


set ls=2  "Always show status line"


set ruler

set hidden

set nolazyredraw
set showmatch
set encoding=utf8

set backspace=indent,eol,start

set nobackup
set noswapfile

language en_US.UTF-8

set undodir=~/.vim_runtime/undodir
set undofile

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>.,trail:.,precedes:<,extends:>
set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    colorscheme desert
    " Remove menu bar
    set guioptions-=m
    set guifont=Menlo:h14
    "set guifont=Monaco:h14

    " Remove toolbar
    set guioptions-=T
else
    colorscheme desert
endif


" ===========================================================
" FileType specific changes
" ============================================================
" Javascript
au BufRead *.js set makeprg=jslint\ %
" Use tab to scroll through autocomplete menus
"autocmd VimEnter * imap <expr> <Tab> pumvisible() ? "<C-N>" : "<Tab>"
"autocmd VimEnter * imap <expr> <S-Tab> pumvisible() ? "<C-P>" : "<S-Tab>"
autocmd filetype javascript set sw=2 ts=2 expandtab
let g:acp_completeoptPreview=1

" Mako/HTML
autocmd BufNewFile,BufRead *.mako,*.mak,*.jinja2 setlocal ft=html
autocmd FileType html,xhtml,xml,css setlocal expandtab shiftwidth=2 tabstop=2

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
au FileType python set foldmethod=indent foldlevel=99

"rope options
map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0

" Run pyflake8
autocmd FileType python map <Leader>8 :call Flake8()<CR>
" Run when saving py files
autocmd BufWritePost *.py call Flake8()
" Ignore Errors
let g:flake8_ignore="E501,W293"

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set wildignore+=eggs/**
set wildignore+=*.egg-info/**

" Add the virtualenv's site-packages to vim path
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

" Load up virtualenv's vimrc if it exists
if filereadable($VIRTUAL_ENV . '/.vimrc')
    source $VIRTUAL_ENV/.vimrc
endif

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_start_level=2
"let g:indent_guides_guide_size=1

set ts=2 sw=2 noet

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

"python with virtualenv support
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF

let python_highlight_all=1

autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

