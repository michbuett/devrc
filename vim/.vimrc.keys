:let mapleader = ","

" easier commands with german keyboard layout
nmap ö :

" common saving
"nmap: <C-s> :w<CR>

" avoid <Esc>
:map <C-c> <Esc>

" format entire file
:map <leader>fa gg=G

" copy/paste from system register
:vmap <A-y> "*y
:nmap <A-p> "*p

" map keys for tabs
:map <C-tab> :tabnext<CR>
:map <C-S-tab> :tabprevious<CR>
:map <C-t> :tabnew<CR>
:imap <C-tab> <Esc>:tabnext<CR>
:imap <C-S-tab> <Esc>:tabprevious<CR>
:imap <C-t> <Esc>:tabnew<CR>

" Bubble single lines
nmap <A-k> :m-2<CR>==
nmap <A-Up> :m-2<CR>==
nmap <A-j> :m+<CR>==
nmap <A-Down> :m+<CR>==

" Bubble multiple lines
vmap <A-k> :m-2<CR>gv=gv
vmap <A-Up> :m-2<CR>gv=gv
vmap <A-j> :m'>+<CR>gv=gv
vmap <A-Down> :m'>+<CR>gv=gv

" Indent lines using <Left> and <Right>
vmap <A-Right> >gv
vmap <A-l> >gv
nmap <A-Right> >>
nmap <A-l> >>
imap <A-Right> <Esc>>>i
imap <A-l> <Esc>>>i
vmap <A-Left> <gv
vmap <A-h> <gv
nmap <A-Left> <<
nmap <A-h> <<
imap <A-Left> <Esc><<i
imap <A-h> <Esc><<i

" Select text using <shift> + arrow keys
map <S-Up> <Esc>v<Up>
map <S-k> <Esc>v<Up>
map <S-Down> <Esc>v<Down>
map <S-j> <Esc>v<Down>
map <S-Left> <Esc>v<Left>
map <S-h> <Esc>v<Left>
map <S-Right> <Esc>v<Right>
map <S-l> <Esc>v<Right>
" swallow <shift> in visual mode
vmap <S-Up> <Up>
vmap <S-k> <Up>
vmap <S-Down> <Down>
vmap <S-j> <Down>
vmap <S-Left> <Left>
vmap <S-h> <Left>
vmap <S-Right> <Right>
vmap <S-l> <Right>

" Remap window commands
map <leader>ws <Esc>:wincmd s<CR>
map <leader>wv <Esc>:wincmd v<CR>
map <leader>wc <Esc>:wincmd c<CR>
map <leader>wn <Esc>:wincmd n<CR>
map <leader>wo <Esc>:wincmd o<CR>
map <leader>w+ <Esc>:wincmd _<CR>
map <leader>w- <Esc>:wincmd <Bar><CR>
map <leader>w= <Esc>:wincmd =<CR>
nmap + :vertical resize +20<CR>
nmap - :vertical resize -20<CR>
map <C-S--> <Esc>:wincmd ><CR>
map <C-Down> <Esc>:wincmd j<CR>:wincmd _<CR>
map <C-j> <Esc>:wincmd j<CR>:wincmd _<CR>
map <C-Up> <Esc>:wincmd k<CR>:wincmd _<CR>
map <C-k> <Esc>:wincmd k<CR>:wincmd _<CR>
map <C-Left> <Esc>:wincmd h<CR>
map <C-h> <Esc>:wincmd h<CR>
map <C-Right> <Esc>:wincmd l<CR>
map <C-l> <Esc>:wincmd l<CR>

" trigger NERDTree, Tagbar $ Co.
map <leader>n <Esc>:NERDTreeToggle<CR>
map <leader>t <Esc>:TagbarToggle<CR>

nmap oi aI
vmap oi aI
