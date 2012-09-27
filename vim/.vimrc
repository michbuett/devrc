"======================================================================================================================
" =>  Basic Setup
"======================================================================================================================
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

if has("statusline") && !&cp
    set laststatus=2  " always show the status bar

    " Start the status line
    set statusline=%f\ %m\ %r
    set statusline+=Line:%l/%L[%p%%]
    set statusline+=Col:%v
    set statusline+=Buf:#%n
    set statusline+=[%b][0x%B
endif

"======================================================================================================================
" => Manage plugins (Vundle)
"----------------------------------------------------------------------------------------------------------------------
"
" Setup Vundle (https://github.com/gmarik/vundle/)
" $ git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"
"----------------------------------------------------------------------------------------------------------------------
"
" Brief help
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
"----------------------------------------------------------------------------------------------------------------------
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"
"======================================================================================================================
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
" === underlays the hexadecimal CSS colorcodes with their real color. The foreground color is selected appositely. So #FF0000 will look as hot as a fire engine!
Bundle 'ap/vim-css-color'
" === Supertab is a vim plugin which allows you to use <Tab> for all your insert completion needs (:help ins-completion).
Bundle 'ervandew/supertab'
" === jslint validator for vim
Bundle 'hallettj/jslint.vim'
" === mustache.vim is a simple plugin for working with mustache templates. It has both syntax hilighting and indenting, which just borrows from html
" indent plugin.
Bundle 'juvenn/mustache.vim'
" === Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
Bundle 'kien/ctrlp.vim'
" === Tagbar is a vim plugin for browsing the tags of source code files.
Bundle 'majutsushi/tagbar'
" === Vim text objects provide a convenient way to select and operate on various types of objects. These objects 
"include regions surrounded by various types of brackets and various parts of language (ie sentences, paragraphs, etc). 
Bundle 'michaeljsmith/vim-indent-object'
" === JavaScript bundle for vim, this bundle provides syntax and indent plugins.
Bundle 'pangloss/vim-javascript'
" === UltiSnips is the Ultimate solution for snippets under Vim
Bundle 'SirVer/ultisnips'
" === The NERD tree allows you to explore your filesystem and to open files and directories.
Bundle 'scrooloose/nerdtree'
" === Syntastic is a syntax checking plugin that runs files through external syntax checkers and displays any resulting errors to the user.
Bundle 'scrooloose/syntastic'
" === Vim runtime files for Haml, Sass, and SCSS
Bundle 'tpope/vim-haml'
" === fugitive.vim may very well be the best Git wrapper of all time.
Bundle 'tpope/vim-fugitive'

" DISABLED
" === The NERD commenter provides many different commenting operations and styles which are invoked via key mappings and a menu
" Bundle 'scrooloose/nerdcommenter'
" === Surround.vim is all about surroundings: parentheses, brackets, quotes, XML tags, and more. The plugin provides
" mappings to easily delete, change and add such surroundings in pairs.
" Bundle 'tpope/vim-surround'
" === Bebop is a tool for rapid web development. Using vim-bebop you can evaluate code in Vim directly in a browser,
" introspect, and even get completions for both Javascript and Coffeescript files.
" does not work so far -> Bundle 'zeekay/vim-bebop'
filetype plugin indent on     " required!


"======================================================================================================================
" => Colors and Fonts
"======================================================================================================================

if has("gui_running")
    colorscheme desert
else
    set t_Co=256
    colorscheme desert256
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"======================================================================================================================
" => Files, backups and undo
"======================================================================================================================
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"======================================================================================================================
" => Text, tab and indent related
"======================================================================================================================
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set list
" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is off
" and the line continues beyond the right of the screen


"======================================================================================================================
" => Key bindings
"======================================================================================================================

exe 'source  ' . expand($DEVRC_HOME) . '/vim/.vimrc.keys'


"======================================================================================================================
" => various other settings
"======================================================================================================================

let g:UltiSnipsSnippetDirectories=[expand("$DEVRC_HOME/vim/snippets/js-core"), expand("$DEVRC_HOME/vim/snippets/js-jasmine"), expand("$DEVRC_HOME/vim/snippets/js-alchemy")]


"======================================================================================================================
" => local settings
"======================================================================================================================

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif
