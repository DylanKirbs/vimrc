"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                 ██╗  ██╗██╗██████╗ ██████╗ ██╗   ██╗                    "
"                 ██║ ██╔╝██║██╔══██╗██╔══██╗╚██╗ ██╔╝                    "
"                 █████╔╝ ██║██████╔╝██████╔╝ ╚████╔╝                     "
"                 ██╔═██╗ ██║██╔══██╗██╔══██╗  ╚██╔╝                      "
"                 ██║  ██╗██║██║  ██║██████╔╝   ██║                       "
"                 ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═════╝    ╚═╝                       "
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗                   "
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝                   "
"               ██║   ██║██║██╔████╔██║██████╔╝██║                        "
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║                        "
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗                   "
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" AUTOMATIC SETUP --------------------------------------------- {{{

" Molokai Colorscheme
if empty(glob('~/.vim/colors/molokai.vim'))
  silent execute '!curl -fLo ~/.vim/colors/molokai.vim --create-dirs  https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim'
endif

" Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

" BASIC CONFIG ------------------------------------------------ {{{

set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax on
colorscheme molokai

set history=1000

set nospell

set number
set shiftwidth=4
set tabstop=4
set nobackup
set scrolloff=10
set nowrap

" Use spaces by default, can be modified in /after/ftplugin/{filetype}.vim
set expandtab

" Cursor Type
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set cursorline
set nocursorcolumn

" Searching
set incsearch
set ignorecase
set smartcase
set showmatch
set hlsearch

" Commands
set showcmd
set showmode

" Enable auto completion menu after pressing TAB.
set wildmenu
set wildmode=list:longest
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" }}}

" CUSTOM COMMANDS --------------------------------------------- {{{

" command! -nargs=+ Name :function <args>

" }}}

" PLUGINS ----------------------------------------------------- {{{
let plugdir = '~/.vim/plugged'

call plug#begin(plugdir)

" Analysis
Plug 'dense-analysis/ale'

" Editor Tree
Plug 'preservim/nerdtree'

" Git Integration
Plug 'tpope/vim-fugitive'

" Vim Airline for top and bottom bar
Plug 'powerline/powerline'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" Plugin Config
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}

" MAPPINGS ---------------------------------------------------- {{{

" Typing ::: or :w quickly will change to command mode
inoremap ::: <esc>:
inoremap :w <esc>:w<CR>i

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w>>
noremap <c-right> <c-w><

" Map the F3 key to toggle NERDTree open and close.
nnoremap <F3> :NERDTreeToggle<cr>

" }}}

" VIMSCRIPT --------------------------------------------------- {{{

" Enable the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

if version >= 703
    let &undodir='vim_backup'
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline nocursorcolumn
augroup END

" Set up C autoformatter
augroup autoformat
    autocmd!
    autocmd FileType c,cpp setlocal equalprg=clang-format\ -fallback-style=none
augroup END

" }}}

" STATUS LINE ------------------------------------------------- {{{

" Status Line config using Airline (see :help airline)
function! AirlineInitConfig()

    let g:airline_powerline_fonts = 1
    let g:airline_detect_modified = 1
    let g:airline_detect_spell = 1
    let g:airline_theme = 'molokai'

    " Extensions
    let g:airline_extensions = ['ale', 'branch', 'tabline']
    " ALE
    let airline#extensions#ale#error_symbol = 'E:'
    let airline#extensions#ale#warning_symbol = 'W:'
    let airline#extensions#ale#show_line_numbers = 1
    let airline#extensions#ale#open_lnum_symbol = '(L'
    let airline#extensions#ale#close_lnum_symbol = ')'
    " Branch
    let g:airline#extensions#branch#empty_message = 'No Commit'
    " Tabline
    let g:airline#extensions#tabline#formatter = 'unique_tail'

    " Symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_left_sep = '⮀'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = '⮁'
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_right_sep = '⮂'
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = '⮃'
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.colnr = ' ㏇:'
    let g:airline_symbols.colnr = ' ℅:'
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'

    " Sections
    let g:airline_section_a = airline#section#create(['mode',' ','branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['Hex: %B'])
    let g:airline_section_z = airline#section#create_right(['l: %l','c: %c','%p%%'])
endfunction
autocmd User AirlineAfterInit call AirlineInitConfig()

" }}}

