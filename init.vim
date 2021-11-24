set hidden
" set termguicolors
set nobackup
set nowritebackup
set encoding=utf-8
set cursorcolumn
set cursorline
syntax enable

let mapleader=","

" ================ Keymaps ======================
nnoremap <leader>, :noh<cr>
nnoremap H ^
nnoremap L $
nnoremap <leader>ev :vs $MYVIMRC<cr><c-w>L
nnoremap <leader>sv :so $MYVIMRC<cr>
nnoremap <c-l> A;<esc>
inoremap <c-l> <esc>A;
imap jk <Esc>
nnoremap <space> za

" ================ Window Movement ======================
noremap <C-w><C-h> <C-w>H
noremap <C-w><C-j> <C-w>J
noremap <C-w><C-k> <C-w>K
noremap <C-w><C-l> <C-w>L

" ================ misc. ================================
" Give more space for displaying messages.
set cmdheight=2
set nofoldenable

" ================ Case ======================
set ignorecase
set smartcase

" ================ Search words ======================
vnoremap // y/\V<c-r>=escape(@", '/\')<cr><cr>N
nnoremap * *N

if exists('g:vscode')
  nnoremap <leader>n <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
  nnoremap <leader>m <Cmd>call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')<CR>
  nnoremap <leader>r <Cmd>call VSCodeNotify('workbench.action.showAllEditorsByMostRecentlyUsed')<CR>
  nnoremap <leader>s <Cmd>call VSCodeNotify('workbench.action.gotoSymbol')<CR>
  nnoremap <leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
  nnoremap <leader>g <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  nnoremap gy <Cmd>call VSCodeNotify('editor.action.peekTypeDefinition')<CR>
  nnoremap gi <Cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>
  nnoremap gr <Cmd>call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>
  nnoremap <C-w><C-w> <Cmd>call VSCodeNotify('workbench.action.focusNextGroup')<CR>
  nnoremap <silent> u :<C-u>call VSCodeNotify('undo')<CR>
  nnoremap <silent> <C-r> :<C-u>call VSCodeNotify('redo')<CR>
else

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
  set relativenumber
  highlight LineNr ctermfg=grey ctermbg=black
  highlight CursorLineNr gui=bold guifg=DarkRed guibg=#c0d0e0

  " ================ VIM Plug ======================
  call plug#begin('~/.config/nvim/plugged')
  Plug 'preservim/nerdtree'
  Plug 'itchyny/lightline.vim'
  Plug 'mhinz/vim-startify'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'joshdick/onedark.vim'
  Plug 'cespare/vim-toml'
  Plug 'liuchengxu/vista.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'antoinemadec/coc-fzf'
  Plug 'josa42/vim-lightline-coc'
  Plug 'pedrohdz/vim-yaml-folds'
  call plug#end()

  " ================ colorscheme ======================
  :silent! colorscheme onedark

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
	if has("nvim-0.5.0") || has("patch-8.1.1564")
		" Recently vim can merge signcolumn and number column into one
		set signcolumn=number
	else
		set signcolumn=yes
	endif

  
  " Put coc-references into floating windows
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

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

  " Use <g-c> to trigger completion.
  inoremap <silent><expr> gc coc#refresh()

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  " nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)

  " Formatting the whole buffer
  nnoremap <leader>fm :call CocAction('format')<cr>

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
    \'coc-prettier',
    \'coc-pyright',
    \'coc-rust-analyzer',
    \'coc-tsserver',
    \'coc-yaml',
    \'coc-yank',
    \'coc-pairs',
    \'coc-go',
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

    " grep word under cursor
  command! -nargs=+ -complete=custom,s:GrepArgs Rg exe 'CocList grep '.<q-args>

  function! s:GrepArgs(...)
    let list = ['-S', '-smartcase', '-i', '-ignorecase', '-w', '-word',
          \ '-e', '-regex', '-u', '-skip-vcs-ignores', '-t', '-extension']
    return join(list, "\n")
  endfunction

  " Keymapping for grep word under cursor with interactive mode
  nnoremap <silent> <leader>cf :exe 'CocList -I --input='.expand('<cword>').' grep'<CR>

  " ================ Vista ======================
  let g:vista#renderer#enable_icon = 0
  let g:vista_default_executive = 'coc'

  function! NearestMethodOrFunction() abort
    return get(b:, 'vista_nearest_method_or_function', '')
  endfunction

  " set statusline+=%{NearestMethodOrFunction()}

  " By default vista.vim never run if you don't call it explicitly.
  "
  " If you want to show the nearest function in your statusline automatically,
  " you can add the following line to your vimrc 
  autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

  " Toggle vista sidebar
  nnoremap <silent> <leader>v  :<C-u>Vista!!<cr>
  " Toggle vista symbol list
  nnoremap <silent> <leader>l  :<C-u>Vista finder coc<cr>


  " ================ lightline ======================
  let g:lightline = {
  \   'active': {
  \     'left': [ [ 'mode', 'paste' ],
  \               [ 'readonly', 'filename', 'method' ],
  \               [ 'git', 'modified' ],
  \               [ 'coc_error', 'coc_warning', 'coc_hint', 'coc_info', 'coc_status' ] ],
  \     'right': [ [ 'lineinfo' ],
  \                [ 'percent' ],
  \                [ 'blame', 'git_status', 'git_changed_lines'] ]
  \   },
  \   'component_function': {
  \     'blame': 'LightlineGitBlame',
  \     'git_status': 'LightlineGitStatus',
  \   }
  \ }

  " register compoments:
  call lightline#coc#register()

  function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > 120 ? blame : ''
  endfunction

  function! LightlineGitStatus() abort
    let status = get(g:, 'coc_git_status', '')
    " return blame
    return winwidth(0) > 70 ? status : ''
  endfunction

  " Use auocmd to force lightline update.
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

  " ================ color ======================
  hi Whitespace ctermfg=238 guifg=#424450 guibg=NONE ctermbg=NONE
  hi VertSplit  ctermfg=Black  guifg=Black guibg=NONE ctermbg=NONE
  hi LineNr ctermbg=NONE guibg=NONE
  hi SignColumn ctermfg=187 ctermbg=NONE guifg=#ebdbb2 guibg=NONE guisp=NONE cterm=NONE gui=NONE
  hi CocCursorRange guibg=#b16286 guifg=#ebdbb2
  hi default CocHighlightText  guibg=#725972 ctermbg=96
  hi CocWarningSign  ctermfg=32 ctermbg=NONE guifg=#0087d7 guibg=NONE


  " ================ cursor ======================
  autocmd InsertEnter * set cul
  autocmd InsertLeave * set nocul
endif
