"===============================================================================
" =>  Basic Setup
"===============================================================================
set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set backspace=indent,eol,start    " backspace through everything in insert mode
set wmh=0             " sets min height of windows to zero
" searching
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set tags=./tags;/
set iskeyword+=-
set wildmenu
set showmatch
set colorcolumn=80
set cursorline

if has("gui_running")
    setlocal spell spelllang=en_us
endif

if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " STATUS LINE (won't see much unless we disable Airline)
    " see: :help 'statusline
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:currentmode={
        \ 'n'  : 'N',
        \ 'no' : 'N',
        \ 'v'  : 'V',
        \ 'V'  : 'V·Line',
        \ '' : 'V·Block',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'Rv' : 'R·Virtual',
        \}

    function! g:ColorInsertMode() abort
        hi CursorLine gui=underline guibg=#eee8d5 ctermbg=238
        hi StatusLineMode guibg=#639bff
    endfunction

    function! g:ColorVisualMode() abort
        hi StatusLineMode guibg=#fbf236
    endfunction

    function! g:ColorReplaceMode() abort
        hi StatusLineMode guibg=#d95763
    endfunction

    function! g:ColorNormalMode() abort
        hi clear CursorLine
        hi StatusLineMode guibg=#6abe30
    endfunction

    function! g:ProcessCurrentMode(mode) abort
        let l:m = get(g:currentmode, mode(), 'N')

        if (match(l:m, 'I') >= 0)
            call g:ColorInsertMode()
        elseif (match(l:m, 'V') >= 0)
            call g:ColorVisualMode()
        elseif (match(l:m, 'R') >= 0)
            call g:ColorReplaceMode()
        else
            call g:ColorNormalMode()
        endif

        return l:m
    endfunction

    set statusline=         "reset
    set statusline+=%#StatusLineMode#
    set statusline+=[%{g:ProcessCurrentMode(mode())}]
    set statusline+=%*
    set statusline+=\ %{fugitive#head()}  "git branch
    set statusline+=%<      "cut from here if line is too long
    set statusline+=\ %f    "relative path of the filename
    set statusline+=%m      "Modified flag
    set statusline+=%w      "Preview window flag
    set statusline+=%r      "Readonly flag
    set statusline+=%=      "left/right separator
    set statusline+=%{&fenc}\|%{&ff}\|%{&ft} "encoding|file format|file type
    set statusline+=\ %c:%l/%L     "cursor column:cursor line/total lines
    " Errors and warnings from Syntastic
    set statusline+=\ %#StatusLineWarnings#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    function! s:EnterWindow() abort
        setlocal statusline<
    endfunction

    function! s:LeaveWindow() abort
        setlocal statusline=\  "reset
        setlocal statusline+=%f%m%r%w
        setlocal statusline+=%=
        setlocal statusline+=%r%w
        setlocal statusline+=%{&fenc}\|%{&ff}\|%{&ft}
    endfunction

    autocmd WinEnter * :call s:EnterWindow()
    autocmd WinLeave * :call s:LeaveWindow()
endif

"===============================================================================
" => Manage plugins (Vundle)
"===============================================================================
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle (required!)
Bundle 'gmarik/vundle'

" Add Bundles here:
" ===== own plugins =====
" Bundle 'michbuett/vim-colorschemes'
Bundle 'michbuett/vim-keys'
" Bundle 'michbuett/vim-snippets'
" Bundle 'michbuett/PIV'

" ===== 3rd party plugins =====
Bundle 'altercation/vim-colors-solarized'
Bundle 'joonty/vdebug.git'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-expand-region'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'
Bundle 'Valloric/YouCompleteMe'

" HTML/CSS/SCSS/JS
Bundle 'ap/vim-css-color'
Bundle 'pangloss/vim-javascript'
" purescript
Bundle 'raichoo/purescript-vim'
Bundle 'FrigoEU/psc-ide-vim'
" elm
Bundle 'elmcast/elm-vim'
" PHP
Bundle 'StanAngeloff/php.vim'
Bundle '2072/PHP-Indenting-for-VIm'
Bundle 'rafi/vim-phpspec'
Bundle 'shawncplus/phpcomplete.vim'

filetype plugin indent on     " required!


"===============================================================================
" => Colors and Fonts
"===============================================================================

if has("gui_running")
    colorscheme solarized
    set background=light

    set cursorline
    hi clear CursorLine

    hi StatusLine guifg=#222034 guibg=#eee8d5
    hi StatusLineNC guibg=#93a1a1 guifg=#eee8d5
    hi StatusLineMode gui=bold guibg=#6abe30 guifg=#222034
    hi StatusLineWarnings gui=bold guibg=#ac3232 guifg=#fbf236
    hi WildMenu gui=underline guibg=#222034 guifg=#fbf236
else
    colorscheme industry
    set background=dark
endif


"===============================================================================
" => Files, backups and undo
"===============================================================================
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"===============================================================================
" => Text, tab and indent related
"===============================================================================
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
autocmd FileType elm setlocal shiftwidth=2 tabstop=2
autocmd FileType purescript setlocal shiftwidth=2 tabstop=2
autocmd FileType php setlocal iskeyword=@,48-57,_,192-255

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set list
" List chars
set listchars=""            " Reset the listchars
set listchars=tab:>-        " a tab should display as ">-"
set listchars+=trail:·      " show trailing spaces as middle dots
set listchars+=extends:>    " The character to show in the last column when wrap
                            " is off and the line continues beyond the right of
                            " the screen
set listchars+=precedes:<   " The character to show in the last column when wrap
                            " is off and the line continues beyond the right of
                            " the screen

" remove trailing spaces when saving buffer
autocmd BufWritePre * :%s/\s\+$//e

"===============================================================================
" => various other settings
"===============================================================================

let g:syntastic_always_populate_loc_list = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target|vendor)$',
  \ 'file': '\v\.(css)$'
  \ }
let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_max_files = 100000
let g:ctrlp_max_depth = 100
let g:ctrlp_match_window = 'top,order:btt,min:1,max:25,results:50'

let g:airline_powerline_fonts = 1

let g:DisableAutoPHPFolding = 1

let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

set completeopt+=longest

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"===============================================================================
" => local settings
"===============================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
