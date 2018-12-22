" Enable true colour
if (empty($TMUX))
 if (has("nvim"))
   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
 endif
 if (has("termguicolors"))
   set termguicolors
 endif
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'Kien/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'w0rp/ale'
Plug 'mhinz/vim-signify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'farmergreg/vim-lastplace'
Plug 'sjl/vitality.vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'rakr/vim-one'
Plug 'mileszs/ack.vim'
call plug#end()

"""""""""""""""
""" Base config
"""""""""""""""
set backup
set backupdir=/private/tmp
set dir=/private/tmp
set backspace=indent,eol,start
set ruler
set tabstop=2
set expandtab
set mouse=n
set shiftwidth=2
set smarttab
set linebreak
set smartindent
set cindent
set autoindent
set ignorecase
set smartcase
set number
set relativenumber
set splitright
set splitbelow
set cursorline
set cursorcolumn
set hidden
set clipboard=unnamed

"""""""""""
""" Theming
"""""""""""
syntax on
set background=dark
let g:one_allow_italics = 1
colorscheme one

""""""""""""""""""
""" Plugins config
""""""""""""""""""
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:ctrlp_custom_ignore = '\v[\/](node_modules|vendor|coverage)|(\.(swp|ico|git|DS_Store))$'
let g:ctrlp_working_path_mode = 'w'
let g:SuperTabCrMapping = 1
let NERDSpaceDelims = 1

highlight SignifySignChange guibg='#61afef' guifg='#61afef' 
highlight SignifySignAdd guibg='#98c379' guifg='#98c379'
highlight SignifySignDelete guibg='#d19a66' guifg='#d19a66'

" Airline
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '::'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1

" ALE
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = { 'javascript': ['prettier'], 'css': ['prettier'] }
let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
highlight ALEErrorSign guibg='#f74b3c' guifg='#f74b3c'
highlight ALEWarningSign guibg='#be5046' guifg='#be5046'

""""""""""""""""
""" Key mappings
""""""""""""""""
map <C-n> :NERDTreeToggle<CR>
nnoremap <Space> i_<Esc>r
nnoremap <esc> :noh<return><esc>
map <C-s> :e ~/Desktop/scratchpad.md<return>
map <C-d> :%bd\|e#\|bd#<CR>
nnoremap <Leader>a :Ack!<Space>

"""""""""""""""""
""" Bug fixes etc
"""""""""""""""""

""" fix airline slowness leaving insert mode "
if ! has('gui_running')
  set ttimeoutlen=10
  augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
  augroup END
endif

