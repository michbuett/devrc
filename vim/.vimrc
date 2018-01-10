"===============================================================================
" =>  Basic Setup
"===============================================================================
set nocompatible      " Use vim, no vi defaults
set number            " Show line numbers
set ruler             " Show line and column number
syntax enable         " Turn on syntax highlighting allowing local overrides
set backspace=indent,eol,start    " backspace through everything in insert mode
set wmh=0             " sets min height of windows to zero
set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter
set tags=./tags;/
set iskeyword+=-
set wildmenu
set wildmode=longest:full,full
set showmatch
set colorcolumn=80
set cursorline
set fillchars=vert:\│,fold:-
set relativenumber
set scrolloff=999
let $PATH .= (":" . $HOME . "/.cabal/bin" . ":" . $HOME . "/.local/bin")

if has("gui_running")
    set guioptions-=r
    set guioptions-=L
    setlocal spell spelllang=en_us
else
    set mouse=a
endif

if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

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
        hi Cursor guibg=#639bff
        hi StatusLineMode guibg=#639bff ctermbg=33
    endfunction

    function! g:ColorVisualMode() abort
        hi Cursor guibg=#fbf236
        hi StatusLineMode guibg=#fbf236 ctermbg=220 ctermfg=Black
    endfunction

    function! g:ColorReplaceMode() abort
        hi Cursor guibg=#d95763
        hi StatusLineMode guibg=#d95763 ctermbg=Darkred
    endfunction

    function! g:ColorNormalMode() abort
        hi Cursor guibg=#6abe30 ctermbg=28
        hi StatusLineMode gui=bold guifg=#222034 guibg=#6abe30 ctermbg=28 ctermfg=White
    endfunction

    function! g:ProcessCurrentMode(mode) abort
        let l:m = get(g:currentmode, mode(), 'N')

        if (match(l:m, '^I') >= 0)
            call g:ColorInsertMode()
        elseif (match(l:m, 'V') >= 0)
            call g:ColorVisualMode()
        elseif (match(l:m, 'R') >= 0)
            call g:ColorReplaceMode()
        else
            call g:ColorNormalMode()
        endif

        redraw
        return l:m
    endfunction

    set statusline=         "reset
    set statusline+=%#StatusLineMode#[%{g:ProcessCurrentMode(mode())}]%*
    set statusline+=\ %{fugitive#head()}  "git branch
    set statusline+=%w      "Preview window flag
    set statusline+=%r      "Readonly flag
    set statusline+=%h      "help flag
    set statusline+=%<      "cut from here if line is too long
    set statusline+=\ %t    "relative path of the filename
    set statusline+=%m      "Modified flag
    set statusline+=%=      "left/right separator
    set statusline+=%{&fenc}\|%{&ff}\|%{&ft} "encoding|file format|file type
    set statusline+=\ %c:%l/%L     "cursor column:cursor line/total lines
    " Errors and warnings from Syntastic
    set statusline+=\ %#StatusLineWarnings#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    function! s:EnterWindow() abort
        setlocal statusline<
        setlocal synmaxcol<
        set cursorline
    endfunction

    function! s:LeaveWindow() abort
        setlocal statusline=>>\  "reset
        setlocal statusline+=%n:%f
        setlocal statusline+=%<
        setlocal statusline+=\ %h%r%w%=<<
        setlocal synmaxcol=1
        set nocursorline
    endfunction

    autocmd BufEnter,WinEnter * :call s:EnterWindow()
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
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'joonty/vdebug.git'
Bundle 'justinmk/vim-sneak'
Bundle 'kien/ctrlp.vim'
Bundle 'terryma/vim-expand-region'
Bundle 'mhinz/vim-startify'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-commentary'
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
" TypeScript
Bundle 'leafgarland/typescript-vim'
Bundle 'Quramy/tsuquyomi'

filetype plugin indent on     " required!


"===============================================================================
" => Colors and Fonts
"===============================================================================
colorscheme solarized

set cursorline

hi StatusLine guifg=#222034 guibg=#eee8d5 ctermfg=236
hi StatusLineNC gui=underline guifg=#93a1a1 guibg=#fdf6e3 ctermbg=7 ctermfg=14
hi StatusLineMode gui=bold guibg=#6abe30 guifg=#222034 cterm=bold
hi StatusLineWarnings gui=bold guibg=#ac3232 guifg=#fbf236
hi WildMenu gui=underline cterm=underline guibg=#222034 guifg=#fbf236 ctermfg=220 ctermbg=236
hi VertSplit ctermbg=NONE guibg=NONE

if has("gui_running")
    set background=light
    hi CursorLine guibg=#eee8d5
else
    set background=dark
    hi Normal ctermbg=NONE
    hi CursorLine ctermbg=NONE cterm=underline
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

let g:indent_guides_color_change_percent = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_default_mapping = 0

let g:psc_ide_syntastic_mode = 1

let g:syntastic_always_populate_loc_list = 1

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target|vendor)$',
  \ 'file': '\v\.(css)$'
  \ }
let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_max_files = 100000
let g:ctrlp_max_depth = 100
let g:ctrlp_match_window = 'top,order:btt,min:1,max:25,results:50'

let g:DisableAutoPHPFolding = 1

let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1

set completeopt=menuone,longest

let g:startify_session_before_save = [
            \ 'echo "Cleaning up before saving.."',
            \ 'silent! NERDTreeClose'
            \ ]
let g:startify_session_persistence = 1
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks', 'commands']

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  command! -nargs=+ Search execute 'silent lgrep! <args>' | lopen 10

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


"===============================================================================
" => debugging
"===============================================================================
map ‘ :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"===============================================================================
" => local settings
"===============================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
