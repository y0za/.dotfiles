set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'cohama/lexima.vim'
Plug 'fatih/vim-go'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'NLKNguyen/papercolor-theme'

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

colorscheme PaperColor
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
