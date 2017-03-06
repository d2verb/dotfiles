set encoding=utf-8
scriptencoding utf-8
" vim-plug ======================================================================
call plug#begin('~/.vim/plugged')

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tyru/caw.vim'
Plug 'morhetz/gruvbox'
Plug 'tyru/caw.vim'
Plug 'itchyny/lightline.vim'
Plug 'cohama/lexima.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'tpope/vim-surround'
Plug 'hynek/vim-python-pep8-indent'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()
" General =======================================================================
set backspace=indent,eol,start
set nocompatible
set noswapfile
set nowritebackup
set nobackup
set viminfo=
set mouse=a
set virtualedit=block
set modifiable
set clipboard=unnamed,autoselect
set hidden
set completeopt-=preview
set ignorecase
set smartcase
set wrapscan
set incsearch
set helplang=ja,en
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
set wildmenu wildmode=list:full
set smartindent
set ambiwidth=double
set laststatus=2
set number
syntax on
set t_Co=256
set cursorline
set tabstop=2
set softtabstop=2
set shiftwidth=2               
set expandtab
set showcmd
set cmdheight=1
set showmatch
set matchtime=2
set colorcolumn=82
colorscheme gruvbox
set background=dark
" neosnippet ====================================================================
imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

imap <expr><Tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "\<C-n>" : "\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)"
      \ : "\<Tab>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" caw.vim =======================================================================
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" ligthline =====================================================================
function! s:getGruvColor(group)
  let guiColor = synIDattr(hlID(a:group), "fg", "gui")
  let termColor = synIDattr(hlID(a:group), "fg", "cterm")
  return [ guiColor, termColor ]
endfunction

let s:bg0  = s:getGruvColor('GruvboxBg0')
let s:bg1  = s:getGruvColor('GruvboxBg1')
let s:bg2  = s:getGruvColor('GruvboxBg2')
let s:bg4  = s:getGruvColor('GruvboxBg4')
let s:fg1  = s:getGruvColor('GruvboxFg1')
let s:fg4  = s:getGruvColor('GruvboxFg4')

let s:yellow = s:getGruvColor('GruvboxYellow')
let s:blue   = s:getGruvColor('GruvboxBlue')
let s:aqua   = s:getGruvColor('GruvboxAqua')
let s:orange = s:getGruvColor('GruvboxOrange')

let s:p = {'normal':{}, 'inactive':{}, 'insert':{}, 'replace':{}, 'visual':{}, 'tabline':{}}
let s:p.normal.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
let s:p.normal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
let s:p.normal.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
let s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
let s:p.insert.left = [ [ s:bg0, s:blue ], [ s:fg1, s:bg2 ] ]
let s:p.insert.right = [ [ s:bg0, s:blue ], [ s:fg1, s:bg2 ] ]
let s:p.insert.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.replace.left = [ [ s:bg0, s:aqua ], [ s:fg1, s:bg2 ] ]
let s:p.replace.right = [ [ s:bg0, s:aqua ], [ s:fg1, s:bg2 ] ]
let s:p.replace.middle = [ [ s:fg4, s:bg2 ] ]
let s:p.visual.left = [ [ s:bg0, s:orange ], [ s:bg0, s:bg4 ] ]
let s:p.visual.right = [ [ s:bg0, s:orange ], [ s:bg0, s:bg4 ] ]
let s:p.visual.middle = [ [ s:fg4, s:bg1 ] ]
let s:p.tabline.left = [ [ s:fg4, s:bg2 ] ]
let s:p.tabline.tabsel = [ [ s:bg0, s:fg4 ] ]
let s:p.tabline.middle = [ [ s:bg0, s:bg0 ] ]
let s:p.tabline.right = [ [ s:bg0, s:orange ] ]
let s:p.normal.error = [ [ s:bg0, s:orange ] ]
let s:p.normal.warning = [ [ s:bg2, s:yellow ] ]

let g:lightline#colorscheme#gruvbox#palette = lightline#colorscheme#flatten(s:p)

let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }
" neocomplete ===================================================================
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_smart_case=1
let g:neocomplete#max_lis=20
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#auto_completion_start_length=2
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'
let g:neocomplete#sources#dictionary#dictionaries={
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
