﻿"===============================================================================
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

if has("gui_running")
    setlocal spell spelllang=en_us
endif

if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

    " Start the status line
    set statusline=%f\ %m\ %r
    set statusline+=Line:%l/%L[%p%%]
    set statusline+=Col:%v
    set statusline+=Buf:#%n
    set statusline+=[%b][0x%B
endif

"===============================================================================
" => Manage plugins (Vundle)
"-------------------------------------------------------------------------------
"
" Setup Vundle (https://github.com/gmarik/vundle/)
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
"-------------------------------------------------------------------------------
"
" Brief help
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
"-------------------------------------------------------------------------------
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
"===============================================================================
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" Add Bundles here:
" Examples:
" * original repos on github
"     Bundle 'ap/vim-css-color'
" * vim-scripts repos
"     Bundle 'L9'
"     Bundle 'FuzzyFinder'
" * non github repos
"     Bundle 'git://git.wincent.com/command-t.git'
"
" ===== own plugins =====
" Bundle 'michbuett/vim-colorschemes'
Bundle 'michbuett/vim-keys'
" Bundle 'michbuett/vim-snippets'
" Bundle 'michbuett/PIV'

" ===== 3rd party plugins =====
Bundle 'altercation/vim-colors-solarized'
Bundle 'bling/vim-airline'
Bundle 'ervandew/supertab'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'joonty/vdebug.git'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'terryma/vim-expand-region'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-speeddating'

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
else
    colorscheme industry
    set background=dark
endif

set cursorline
hi clear CursorLine
autocmd InsertEnter * hi CursorLine guibg=grey30 ctermbg=238
autocmd InsertLeave * hi clear CursorLine


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

function! s:UpdateTags() abort
    let s:tagfiles = tagfiles()
    for s:file in s:tagfiles
        let s:path = fnamemodify(s:file, ':p:h')
        "echom 'Update tag file at ' . s:path
        let s:cmd = 'node ' . g:jsdoc_tags_path . ' -qpis -d ' . s:path . ' ' . expand('%:p')
        "echom s:cmd
        let s:result = system(s:cmd)
        if s:result != ''
            echoerr s:result
        endif
    endfor
endfunction

if exists('g:jsdoc_tags_path') && filereadable(expand(g:jsdoc_tags_path))
    autocmd BufWritePost *.js :call s:UpdateTags()
endif

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|target)$',
  \ 'file': '\v\.(css)$'
  \ }
let g:ctrlp_cmd = 'CtrlPTag'
let g:ctrlp_max_files = 100000
let g:ctrlp_max_depth = 100
let g:ctrlp_match_window = 'top,order:btt,min:1,max:25,results:50'

let g:airline_powerline_fonts = 1

let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

let g:DisableAutoPHPFolding = 1

let g:UltiSnipsExpandTrigger = "<c-space>"
let g:UltiSnipsListSnippets = "<c-s-space>"

set completeopt+=longest

"===============================================================================
" => local settings
"===============================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
