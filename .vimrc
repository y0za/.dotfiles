set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'cohama/lexima.vim'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'thinca/vim-themis'
Plug 'thinca/vim-qfreplace'
Plug 'posva/vim-vue'
Plug 'junegunn/vim-easy-align'
Plug 'w0ng/vim-hybrid'
Plug 'prettier/vim-prettier'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'ryanolsonx/vim-lsp-typescript'

call plug#end()

syntax on
filetype plugin indent on

set background=dark
set nonumber
set cursorline
set autoindent
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
set hidden
set ignorecase
set incsearch
set hlsearch
set nrformats=bin,hex
set virtualedit=block
set ambiwidth=double
set backspace=indent,eol,start
set lazyredraw
set wildmenu
set wildmode=longest:full,full
set laststatus=2
set statusline=%m%f%=%y
set expandtab
set tabstop=2
set shiftwidth=2
set grepprg=jvgrep
set splitbelow
set splitright

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

colorscheme hybrid

if !isdirectory(expand('~/.vim/backup'))
  call mkdir(expand('~/.vim/backup'), 'p')
endif
set backup
set backupdir=~/.vim/backup

if !isdirectory(expand('~/.vim/swap'))
  call mkdir(expand('~/.vim/swap'), 'p')
endif
set swapfile
set directory=~/.vim/swap//

if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), 'p')
endif
set undofile
set undodir=~/.vim/undo

let g:mapleader = ','
noremap \ ,

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-h> <BS>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>

vmap <Leader><CR> <Plug>(reading_vimrc-update_clipboard)

map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:javascript_plugin_flow = 1

let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss Prettier

let g:go_def_mapping_enabled = 0

if executable('bingo')
  augroup LspGo
    au!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'bingo',
          \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
    autocmd FileType go setlocal omnifunc=lsp#complete
    autocmd FileType go nmap gd <plug>(lsp-definition)
  augroup END
endif

if executable('flow-language-server')
  augroup LspFlow
    au!
    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'flow',
          \ 'cmd': {server_info->['flow-language-server', '--stdio']},
          \ 'whitelist': ['javascript'],
          \ })
    autocmd FileType javascript setlocal omnifunc=lsp#complete
  augroup END
endif

if executable('typescript-language-server')
  augroup LspTypescript
    au!
    autocmd FileType typescript setlocal omnifunc=lsp#complete
    autocmd FileType typescript nmap gd <plug>(lsp-definition)
  augroup END
endif
