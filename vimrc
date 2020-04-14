" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ================ General Config ====================
"
"
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set history=1000                "Store lots of :cmdline history
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set gcr=a:blinkon0              "Disable cursor blink
set autoread                    "Reload files changed outside vim

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

"turn on syntax highlighting
syntax on

" The mapleader has to be set before vundle starts loading all
" the plugins.
let mapleader = "\<Space>"

" ================ Turn Off Swap Files ==============

set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>

" Better search
set hlsearch
set incsearch

" grep word under cursor
nnoremap <Leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" Misc
nnoremap H ^
nnoremap L $
nnoremap J gT
nnoremap K gt
if !has('gui_running')
  set t_Co=256
endif
nnoremap ; :
nnoremap <Leader>b :buffers<CR>:buffer<Space>

" VIM PLUG
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'pbogut/fzf-mru.vim'
call plug#end()

" NerdTree
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" fzf-mru
map <leader>p :FZFMru<cr>
