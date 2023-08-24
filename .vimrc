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

let autoupdate = 1

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

" Auto Update RC
if ($autoupdate == 1)
    autocmd! VimEnter * silent execute '!curl -fLo ~/.vimrc https://raw.githubusercontent.com/DylanKirbs/vimrc/master/.vimrc'
endif

" }}}

" BASIC CONFIG ------------------------------------------------ {{{

set nocompatible

colorscheme molokai

" Set the tab width to 4 spaces
set number
set shiftwidth=4
set tabstop=4
set expandtab

" Custom Backup
set nobackup
set history=1000

" Scroll and wrap
set scrolloff=10
set nowrap

" Autocompletion
set complete+=kspell
set completeopt=menuone,longest
set shortmess+=c

" Modify language specific configs /after/ftplugin/{filetype}.vim
" Eg:
"   ~/.vim/after/ftplugin/python.vim
"   setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
filetype on
filetype plugin on
filetype indent on

" Modify language specific syntax /syntax/{filetype}.vim
" Eg:
"   ~/.vim/syntax/python.vim
syntax on

" Cursor Type
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
set cursorline
set nocursorcolumn
set ttymouse=xterm2
set mouse=a

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

" Autocomplete Popup
Plug 'vim-scripts/AutoComplPop'

" Clang Complete
Plug 'xavierd/clang_complete'

call plug#end()

" Plugin Config
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$'] 
let g:clang_library_path='/usr/lib/llvm-14/lib/libclang-14.so.1'

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

" Autocomplete menu
" Navigate (Up, Down)
inoremap <expr> <Down> pumvisible() ? "<C-n>" :"<Down>"
inoremap <expr> <Up> pumvisible() ? "<C-p>" :"<Up>"
" Select choice (Right, Tab)
inoremap <expr> <Right> pumvisible() ? "<C-y>" :"<Right>"
inoremap <expr> <Tab> pumvisible() ? "<C-y>" :"<Tab>"
" Cancel choice (Left)
inoremap <expr> <Left> pumvisible() ? "<C-e>" :"<Left>"

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
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_right_sep = ''
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
    let g:airline_section_a = airline#section#create(['mode','branch'])
    let g:airline_section_b = airline#section#create_left(['ffenc','%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['Hex: %B'])
    let g:airline_section_z = airline#section#create_right(['l: %l','c: %c','%p%%'])

  let g:airline_filetype_overrides = {
      \ 'coc-explorer':  [ 'CoC Explorer', '' ],
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
      \ }

endfunction
autocmd User AirlineAfterInit call AirlineInitConfig()

" }}}

