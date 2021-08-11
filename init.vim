"""""""""""""""""""
" Install Plugins "
"""""""""""""""""""

call plug#begin('~/.local/share/nvim/plugged')
" syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'kentaroi/cocoa.vim'
Plug 'keith/swift.vim'

" language support
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" GIT
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" UI
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'farmergreg/vim-lastplace'
Plug 'sjl/vitality.vim'
Plug 'scrooloose/nerdtree'

" Utilities
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'scrooloose/nerdcommenter'
Plug 'unblevable/quick-scope'
Plug 'bkad/CamelCaseMotion'
Plug 'tpope/vim-surround'
Plug 'kevinhui/vim-docker-tools'
Plug 'editorconfig/editorconfig-vim'
call plug#end()

""""""""""""""""""""""""""""""""""
" Base settings and key mappings "
""""""""""""""""""""""""""""""""""

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

nnoremap , i_<Esc>r
nnoremap <esc> :noh<return><esc>
map <C-d> :%bd\|e#\|bd#<CR>
nnoremap <Leader>r :e ~/dotfiles/init.vim<return>
map <Leader>s :e ~/Desktop/scratchpad.md<return>

"""""""""""
" Theming "
"""""""""""

if (has("termguicolors"))
  set termguicolors
endif

syntax on
set background=dark
let g:one_allow_italics = 1
let g:java_highlight_functions = 1
colorscheme onedark

highlight SignifySignChange guibg='#61afef' guifg='#61afef'
highlight SignifySignAdd guibg='#98c379' guifg='#98c379'
highlight SignifySignDelete guibg='#d19a66' guifg='#d19a66'

highlight ALEErrorSign guibg='#f74b3c' guifg='#f74b3c'
highlight ALEWarningSign guibg='#be5046' guifg='#be5046'

""""""""""""""""""""""""""""""""""""
" Plugin settings and key mappings "
""""""""""""""""""""""""""""""""""""

let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1

let g:NERDSpaceDelims = 1
map <C-s> ysiw
autocmd FileType brs setlocal commentstring='%s

let g:NERDTreeHijackNetrw = 0
let g:NERDTreeQuitOnOpen = 1
map <C-n> :NERDTreeToggle<CR>

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:fzf_history_dir = '~/.local/share/fzf-history'
map <C-p> :FZF<return>
map <Leader>g :Rg<return>
map ; :Buffers \| :NERDTreeClose<return>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

let g:markdown_enable_spell_checking = 0

let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 0
let g:jsdoc_access_descriptions = 0

let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '::'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#ale#enabled = 1

map <silent> e <Plug>CamelCaseMotion_e
sunmap e

""""""""""""""""""""""""""
" Language Server config "
""""""""""""""""""""""""""
" The following needs some work, consider going to COC completely or native nvim lsp

" ALE "

call ale#linter#Define('brs', {
  \'name': 'eslint',
  \'output_stream': 'both',
  \'executable': function('ale#handlers#eslint#GetExecutable'),
  \'command': function('ale#handlers#eslint#GetCommand'),
  \'callback': 'ale#handlers#eslint#HandleJSON',
\})

let g:ale_linters = {
  \'javascript': ['eslint'],
  \'typescript': ['eslint'],
  \'brs': ['eslint'],
  \'objc': ['ccls', 'clang', 'clangd'],
  \'cpp': ['clangd']
\}

let g:ale_fixers = {
  \'javascript': ['eslint'],
  \'typescript': ['eslint'],
  \'*': ['trim_whitespace']
\}

set completeopt+=noinsert " https://github.com/w0rp/ale/issues/1700#issuecomment-402797948

let g:ale_javascript_eslint_executable = 'eslint' " TODO shouldn't this be local to project?
let g:ale_fix_on_save = 0
let g:ale_disable_lsp = 1
let g:ale_completion_enabled = 1

" noremap K :ALEHover<CR>
noremap <Leader>d :ALEGoToDefinition<CR>
noremap <Leader>gr :ALEFindReferences<CR>

" COC "

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped already
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
