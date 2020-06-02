set hidden
set nobackup
set nowritebackup
syntax enable

let mapleader="\<space>"

" ================ termguicolors ======================
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
set t_Co=256

set termguicolors

" ================ Keymaps ======================
nnoremap <leader>, :noh<cr>
nnoremap H ^
nnoremap L $
nnoremap <leader>ev :vs $MYVIMRC<cr><c-w>L
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <c-l> A;<esc>
inoremap <c-l> <esc>A;

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ Case ======================
set ignorecase
set smartcase

" ================ Number Col ======================
set number
set relativenumber
highlight LineNr ctermfg=grey ctermbg=black
highlight CursorLineNr gui=bold guifg=DarkRed guibg=#c0d0e0

" ================ Window Movement ======================
noremap <C-w><C-h> <C-w>H
noremap <C-w><C-j> <C-w>J
noremap <C-w><C-k> <C-w>K
noremap <C-w><C-l> <C-w>L

" ================ Search words ======================
vnoremap // y/\V<c-r>=escape(@", '/\')<cr><cr>N
nnoremap * *N

" ================ color ======================
hi Whitespace ctermfg=238 guifg=#424450 guibg=NONE ctermbg=NONE
hi VertSplit  ctermfg=Black  guifg=Black guibg=NONE ctermbg=NONE
hi LineNr ctermbg=NONE guibg=NONE
hi SignColumn ctermfg=187 ctermbg=NONE guifg=#ebdbb2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
