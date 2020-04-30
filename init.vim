set hidden
set termguicolors
set nobackup
set nowritebackup
syntax enable

let mapleader="\<space>"

" ================ Keymaps ======================
nnoremap <leader>, :noh<cr>
nnoremap H ^
nnoremap L $
nnoremap <leader>ev :vs $MYVIMRC<cr><c-w>L
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <c-l> A;<esc>
inoremap <c-l> <esc>A;

" ================ Clipboard ======================
let g:clipboard = {
          \   'name': 'tmuxClipboard',
          \   'copy': {
          \      '+': 'tmux load-buffer -',
          \      '*': 'tmux load-buffer -',
          \    },
          \   'paste': {
          \      '+': 'tmux save-buffer -',
          \      '*': 'tmux save-buffer -',
          \   },
          \   'cache_enabled': 1,
          \ }
set clipboard+=unnamedplus

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" ================ Number Col ======================
set number
highlight LineNr ctermfg=grey ctermbg=black
highlight CursorLineNr gui=bold guifg=DarkRed guibg=#c0d0e0

noremap <C-w><C-h> <C-w>H
noremap <C-w><C-j> <C-w>J
noremap <C-w><C-k> <C-w>K
noremap <C-w><C-l> <C-w>L

" ================ Search words ======================
vnoremap // y/\V<c-r>=escape(@", '/\')<cr><cr>N
nnoremap * *N

" ================ VIM Plug ======================
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'joshdick/onedark.vim'
call plug#end()

" ================ colorscheme ======================
colorscheme onedark

" ================ NerdTree ======================
nnoremap <silent> <leader>n :NERDTreeToggle<CR>
nnoremap <silent> <leader>m :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" ================ coc-nvim ======================
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes:1

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ================ coc-extensions ======================
let g:coc_global_extensions = [
  \'coc-css',
  \'coc-eslint',
  \'coc-git',
  \'coc-html',
  \'coc-json',
  \'coc-lists',
  \'coc-markdownlint',
  \'coc-python',
  \'coc-rust-analyzer',
  \'coc-tsserver',
  \'coc-yaml',
  \'coc-yank',
\ ]
nnoremap <silent> <leader>y  :<c-u>CocList -A --normal yank<cr>
" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <leader>a  :<c-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>e  :<c-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>c  :<c-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>o  :<c-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>s  :<c-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>j  :<c-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent> <leader>k  :<c-u>CocPrev<cr>
" Resume latest coc list.
nnoremap <silent> <leader>p  :<c-u>CocListResume<cr>
" Show MRU list
nnoremap <silent> <leader>r  :<c-u>CocList mru<cr>
" Show Files list
nnoremap <silent> <leader>f  :<c-u>CocList files<cr>
" Grep using ag
vnoremap <leader>g :<c-u>call <SID>GrepFromSelected(visualmode())<cr>
nnoremap <leader>g :<c-u>set operatorfunc=<SID>GrepFromSelected<cr>g@

function! s:GrepFromSelected(type)
  let saved_unnamed_register = @@
  if a:type ==# 'v'
    normal! `<v`>y
  elseif a:type ==# 'char'
    normal! `[v`]y
  else
    return
  endif
  let word = substitute(@@, '\n$', '', 'g')
  let word = escape(word, '| ')
  let @@ = saved_unnamed_register
  execute 'CocList grep '.word
endfunction


" ================ lightline ======================
let g:lightline = {
  \ 'colorscheme': 'Tomorrow_Night',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'git', 'modified', 'coc_error', 'coc_warning', 'coc_hint', 'coc_info' ] ],
  \   'right': [ [ 'lineinfo',  ],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype'] ]
  \ },
  \ 'component_expand': {
  \   'coc_error'        : 'LightlineCocErrors',
  \   'coc_warning'      : 'LightlineCocWarnings',
  \   'coc_info'         : 'LightlineCocInfos',
  \   'coc_hint'         : 'LightlineCocHints',
  \   'coc_fix'          : 'LightlineCocFixes',
  \ },
\ }

let g:lightline.component_type = {
\   'coc_error'        : 'error',
\   'coc_warning'      : 'warning',
\   'coc_info'         : 'tabsel',
\   'coc_hint'         : 'middle',
\   'coc_fix'          : 'middle',
\ }

function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  try
    let s = g:coc_user_config['diagnostic'][a:sign . 'Sign']
  catch
    let s = ''
  endtry
  return printf('%s %d', s, info[a:kind])
endfunction

function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', 'error')
endfunction

function! LightlineCocWarnings() abort
  return s:lightline_coc_diagnostic('warning', 'warning')
endfunction

function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', 'info')
endfunction

function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', 'hint')
endfunction
\ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" ================ color ======================
" hi Whitespace ctermfg=238 guifg=#424450 guibg=NONE ctermbg=NONE
" hi VertSplit  ctermfg=Black  guifg=Black guibg=NONE ctermbg=NONE
" hi LineNr ctermbg=NONE guibg=NONE
" hi SignColumn ctermfg=187 ctermbg=NONE guifg=#ebdbb2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
" hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
" hi default CocHighlightText  guibg=#725972 ctermbg=96
" hi CocWarningSign  ctermfg=32 ctermbg=NONE guifg=#0087d7 guibg=NONE
