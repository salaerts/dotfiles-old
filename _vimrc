" Disable vi-compatibility
set nocompatible

" Required for Vundle
filetype off

" Allow cursor keys in insert mode
set esckeys

" Line numbering
set number

if has("unix")
    set rtp+=~/.vim/bundle/vundle/
elseif has("win32")
    set rtp+=~/.vim/bundle/vundle/
endif

call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" Github repo plugins
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'bingaman/vim-sparkup'
" Bundle 'Lokaltog/vim-powerline' (TODO: obsolete?)
Bundle 'ervandew/supertab'
" Bundle 'MarcWeber/vim-addon-mw-utils'
" Bundle 'tomtom/tlib_vim'
" Bundle 'honza/snipmate-snippets'
" Bundle 'garbas/vim-snipmate'

Bundle 'bling/vim-airline'

" Fuzzy file search
Bundle 'kien/ctrlp.vim'

" Syntax validation (make sure to install linters, checkers, ... into $PATH)
Bundle 'scrooloose/syntastic'

" Load unix-only plugins
if has("unix")
    Bundle 'wincent/Command-T'
    Bundle 'tpope/vim-rails'
    " Load win32-only plugins
elseif has("win32")
endif

Bundle 'salaerts/vim-indent'

" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
" Always show the status line
set laststatus=2
" Necessary to show Unicode glyps
set encoding=utf-8
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
" highlight current line
set cursorline
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79

if has("unix")
    " This makes RVM work inside Vim. I have no idea why.
    set shell=bash
endif

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" Explicitly tell Vin that the terminal supports 256 colors
set t_Co=256
" keep more context when scrolling off the end of a buffer
set scrolloff=3

if has("unix")
    " Store temporary files in a central spot
    set backup
    set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
    set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
endif
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable syntax highlighting
syntax on

" Make the current window big, but leave others context
set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype on
filetype plugin on
filetype indent on     " required!

" Enhance command-line completion
set wildmenu
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set t_Co=256 " 256 colors
let g:solarized_termcolors=256
:set background=dark
colorscheme solarized

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline 
let Powerline_symbols = 'fancy'

let g:airline_powerline_fonts = 1 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

let localleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>y "*y
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Switch between last two files
nnoremap <leader><leader> <c-^>
" Map %% to the current directory path
cnoremap %% <C-R>=expand('%:h').'/'<cr>
" Edit or view files in same directory as current file
" map <leader>e :edit %%
" map <leader>v :view %%
" Surround currently selected word with quotes
nnoremap <Leader>" viw<esc>a"<esc>hbi"<esc>lel

" Display taglist
nnoremap <C-t> :TlistToggle<cr><c-w>j

" Edit vimrc
nnoremap <leader>ve :vsplit $MYVIMRC<cr>
" Source vimrc
nnoremap <leader>vs :source $MYVIMRC<cr>

" toggle word under cursor between upper and lower case
nnoremap <leader>ct viw~
" make word under cursor upper case
nnoremap <leader>cu viwU
" make word under cursor lowe case
nnoremap <leader>cl viwu

nnoremap <leader>cc <esc>:call WordToCamelCase()<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" REFACTORING TOOLS
" Switch to camel case
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! WordToCamelCase()
    let currentWord = expand("<cword>")
    let cased = substitute(currentWord, '_\(\l\)', '\u\1', 'g')
    exe "normal viwx"
    exe "normal i" . cased
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrap visual selection in an HTML tag.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType xml,html,php vnoremap <Buffer> <localleader>w <Esc>:call VisualHTMLTagWrap()<CR>

function! VisualHTMLTagWrap()
    let tag = input("Tag to wrap block: ")
    if len(tag) > 0
        normal `>
        if &selection == 'exclusive'
            exe "normal i</".tag.">"
        else
            exe "normal a</".tag.">"
        endif
        normal `<
        exe "normal i<".tag.">"
        normal `<
    endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ARROW KEYS ARE UNACCEPTABLE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

