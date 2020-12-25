set encoding=utf-8
scriptencoding utf-8

call plug#begin('~/.vim/plugged')

Plug 'HerringtonDarkholme/yats.vim'
Plug 'jparise/vim-graphql'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'thinca/vim-themis'
Plug 'thinca/vim-qfreplace'
Plug 'posva/vim-vue'
Plug 'junegunn/vim-easy-align'
Plug 'w0ng/vim-hybrid'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'previm/previm'

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
set shortmess-=S
set nostartofline
set signcolumn=number

command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

colorscheme hybrid

if !isdirectory(expand('~/.vim/backup'))
  call mkdir(expand('~/.vim/backup'), 'p')
endif
set backup
set backupdir=~/.vim/backup
set backupcopy=yes

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

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:javascript_plugin_flow = 1

let g:previm_open_cmd = 'open -a Google\ Chrome'

" coc.nvim

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList actions<cr>
" Show all diagnostics
nnoremap <silent> <space>d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
