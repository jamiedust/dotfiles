call plug#begin('~/.local/share/nvim/plugged')
" syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'chooh/brightscript.vim'
Plug 'gabrielelana/vim-markdown'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'kentaroi/cocoa.vim'
Plug 'bfrg/vim-cpp-modern'

" Colours
Plug 'rakr/vim-one'

" language support
Plug 'w0rp/ale'
Plug 'pechorin/any-jump.vim'

" GIT
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'farmergreg/vim-lastplace'
Plug 'sjl/vitality.vim'
Plug 'scrooloose/nerdtree'
Plug 'editorconfig/editorconfig-vim'
" Plug 'Yggdroot/indentLine'

" Utilities
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'scrooloose/nerdcommenter'
Plug 'unblevable/quick-scope'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'kevinhui/vim-docker-tools'
Plug 'editorconfig/editorconfig-vim'
Plug 'heavenshell/vim-jsdoc'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

set backup
set backupdir=/private/tmp
set dir=/private/tmp
set backspace=indent,eol,start
set ruler
set tabstop=2
set expandtab
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
" set cursorcolumn
set hidden
set clipboard=unnamed
set wcm=<tab>
set shortmess=a

syntax on
set background=dark
let g:one_allow_italics = 1
let g:java_highlight_functions = 1
colorscheme one

""""""""""""""""""
""" Plugins config
""""""""""""""""""
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:SuperTabCrMapping = 1
let NERDSpaceDelims = 1
let NERDTreeHijackNetrw = 0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:markdown_enable_spell_checking = 0
let g:NERDTreeQuitOnOpen = 1
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 0
let g:jsdoc_access_descriptions = 0

autocmd FileType brs setlocal commentstring='%s

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
let g:ale_linters = { 'javascript': ['eslint', 'tsserver'], 'objc': ['ccls', 'clang', 'clangd'] }
let g:ale_fixers = { 'javascript': ['eslint'], '*': ['trim_whitespace'] }
let g:ale_javascript_eslint_executable = 'eslint'
let g:ale_typescript_tsserver_use_global = 1
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
set completeopt+=noinsert " https://github.com/w0rp/ale/issues/1700#issuecomment-402797948
highlight ALEErrorSign guibg='#f74b3c' guifg='#f74b3c'
highlight ALEWarningSign guibg='#be5046' guifg='#be5046'
noremap K :ALEHover<CR>
noremap <Leader>d :ALEGoToDefinition<CR>
noremap <Leader>gr :ALEFindReferences<CR>

""" KEY MAPPINGS "
map <C-n> :NERDTreeToggle<CR>
nnoremap , i_<Esc>r
nnoremap <esc> :noh<return><esc>
map <C-d> :%bd\|e#\|bd#<CR>
nnoremap <Leader>r :e ~/dotfiles/init.vim<return>
map <Leader>s :e ~/Desktop/scratchpad.md<return>

map <C-p> :FZF<return>
map <Leader>g :Rg<return>
map ; :Buffers \| :NERDTreeClose<return>

map <silent> e <Plug>CamelCaseMotion_e
sunmap e

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
