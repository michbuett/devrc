﻿"=================================================
" =>  Basic Setup
"=================================================
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
set completeopt=menuone,longest,noselect,noinsert
set signcolumn=yes
set autoread

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
        hi StatusLineMode guibg=#639bff
    endfunction

    function! g:ColorVisualMode() abort
        hi Cursor guibg=#fbf236
        hi StatusLineMode guibg=#fbf236
    endfunction

    function! g:ColorReplaceMode() abort
        hi Cursor guibg=#d95763
        hi StatusLineMode guibg=#d95763
    endfunction

    function! g:ColorNormalMode() abort
        hi Cursor guibg=#6abe30 ctermbg=28
        hi StatusLineMode gui=bold guifg=#222034 guibg=#6abe30
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

    function! LinterOk() abort
      return SyntasticStatuslineFlag() != '' ? '' : '[✓]'
      " let l:counts = ale#statusline#Count(bufnr(''))
      " if l:counts.error + l:counts.warning > 0
      "   return ''
      " endif
      " return '[✓]'
    endfunction

    function! LinterErrors() abort
      return SyntasticStatuslineFlag()
      " let l:bnum = bufnr('')
      " let l:counts = ale#statusline#Count(l:bnum)

      " if l:counts.error > 0
      "   let l:first = ale#statusline#FirstProblem(l:bnum, 'error')
      "   return printf('[E(%d):%d]', l:counts.error, l:first.lnum)
      " endif

      " if l:counts.warning > 0
      "   let l:first = ale#statusline#FirstProblem(l:bnum, 'warning')
      "   return printf('[W(%d):%d]', l:counts.warning, l:first.lnum)
      " endif

      " return ''
    endfunction

    set statusline=         "reset
    set statusline+=%#StatusLineMode#[%{g:ProcessCurrentMode(mode())}]%*
    set statusline+=\ %{fugitive#statusline()}▸  "git branch
    set statusline+=%w      "Preview window flag
    set statusline+=%r      "Readonly flag
    set statusline+=%h      "help flag
    set statusline+=%<      "cut from here if line is too long
    set statusline+=\ %t    "relative path of the filename
    set statusline+=%m      "Modified flag
    set statusline+=%=      "left/right separator
    " set statusline+=%{&fenc}\|%{&ff}\|%{&ft} "encoding|file format|file type
    set statusline+=\ %c:%l/%L     "cursor column:cursor line/total lines
    " set statusline+=\ %{LinterStatus()}
    " set statusline+=\ %{g:SyntasticCheckOk()}
    set statusline+=\ %#StatusLineOk#%{LinterOk()}%*
    set statusline+=%#StatusLineErrors#%{LinterErrors()}%*

    function! s:EnterWindow() abort
        setlocal statusline<
        setlocal synmaxcol<
        set cursorline
    endfunction

    function! s:LeaveWindow() abort
        setlocal statusline=[[[\ \ \  "reset
        setlocal statusline+=%n:%f
        setlocal statusline+=%<
        setlocal statusline+=\ %h%r%w%=]]]
        setlocal synmaxcol=1
        set nocursorline
        redraw
    endfunction

    autocmd BufEnter,WinEnter * :call s:EnterWindow()
    autocmd WinLeave * :call s:LeaveWindow()
endif

"=========================================================
" => Manage plugins (https://github.com/junegunn/vim-plug)
"=========================================================
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --rust-completer --ts-completer
  endif
endfunction

" ===== own plugins =====
Plug 'michbuett/vim-keys'

" ===== 3rd party plugins =====
Plug 'iCyMind/NeoSolarized'
Plug 'christoomey/vim-tmux-navigator'
Plug 'joonty/vdebug'
Plug 'justinmk/vim-sneak'

"Plug 'kien/ctrlp.vim'
if filereadable('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
endif
Plug 'junegunn/fzf.vim'

Plug 'terryma/vim-expand-region'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
" Plug 'dense-analysis/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
"Plug 'prabirshrestha/vim-lsp'

" HTML/CSS/SCSS/JS
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
" purescript
Plug 'purescript-contrib/purescript-vim'
Plug 'FrigoEU/psc-ide-vim'
" elm
Plug 'elmcast/elm-vim'
" PHP
" Plug 'StanAngeloff/php.vim'
" Plug '2072/PHP-Indenting-for-VIm'
" Plug 'rafi/vim-phpspec'
" Plug 'shawncplus/phpcomplete.vim'
" TypeScript
Plug 'leafgarland/typescript-vim'
Plug 'Quramy/tsuquyomi'
" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

call plug#end()


"=================================================
" => Colors and Fonts
"=================================================
set termguicolors
set cursorline
set background=dark

let g:fzf_colors =
\ { 'fg':      ['fg', 'CursorLine'],
  \ 'bg':      ['bg', 'CursorLine'],
  \ 'hl':      ['fg', 'Keyword'],
  \ 'fg+':     ['fg', 'Error' ],
  \ 'bg+':     ['bg', 'CursorLine' ] }

colorscheme NeoSolarized

hi Normal guibg=NONE
hi StatusLineMode gui=bold cterm=bold guibg=#6abe30 guifg=#222034
hi StatusLineOk guibg=#6abe30 guifg=#222034
hi StatusLineErrors guibg=#ac3232 guifg=#fbf236
hi WildMenu gui=underline guibg=#222034 guifg=#fbf236
hi VertSplit ctermbg=NONE guibg=NONE


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

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
autocmd FileType php setlocal shiftwidth=4 tabstop=4
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

" let g:psc_ide_syntastic_mode = 1
let g:psc_ide_import_on_completion = v:false

let g:purescript_indent_case = 2
let g:purescript_indent_where = 2
let g:purescript_indent_do = 2

" let g:ale_linters = {'rust': ['rls']}
" " Write this in your vimrc file
" let g:ale_set_loclist = 0
" let g:ale_set_quickfix = 1
" let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = "E>"
let g:syntastic_warning_symbol = "W>"
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = " /!\\ %E{E(%e):%fe}%B{, }%W{W(%w):%fw} "
let g:syntastic_javascript_checkers = ["eslint"]
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi'] " You shouldn't use 'tsc' checker.
"
" hi SyntasticError guibg=#ac3232 guifg=#fbf236
" hi SyntasticWarnin guibg=#fbf236 guifg=#ac3232

let g:DisableAutoPHPFolding = 1

let g:startify_session_before_save = [
            \ 'echo "Cleaning up before saving.."',
            \ 'silent! NERDTreeClose'
            \ ]
let g:startify_session_persistence = 1
let g:startify_list_order = ['sessions', 'files', 'dir', 'bookmarks', 'commands']

let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_use_ultisnips_completer = 0
let g:ycm_rust_src_path = expand('~/Workspace/rust/src')

let g:racer_experimental_completer = 1

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  command! -nargs=+ Search execute 'silent lgrep! <args>' | lopen 10
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
