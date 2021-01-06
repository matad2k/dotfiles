set encoding=utf-8

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-vinegar'
Plug 'ervandew/supertab'


call plug#end()

filetype on
filetype plugin on
filetype indent on
syntax enable

set nocompatible
set wildmenu
set ruler
set ignorecase
set hlsearch
set smartcase
set showmatch
set autoindent
set shiftwidth=4
set shiftround
set tabstop=4
set number
set t_Co=256
let g:javascript_plugin_flow = 1

set nobackup
set nowb
set noswapfile

colorscheme jellyx

let mapleader = ","

if has("autocmd")
	autocmd bufwritepost .vimrc source $MYVIMRC
endif

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'

nmap <leader>v :tabedit $MYVIMRC<CR>

nmap <leader>Q :qa! <CR>
nmap <leader>w :w <CR>
nmap <leader>q :q <CR>
nmap <leader>wq :wq <CR>

nmap <leader>b :CtrlPBuffer<CR>
map <F3> :Explore<CR>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.ts set filetype=javascript

let g:ycm_key_list_previous_completion=['<Up>']
let g:UltiSnipsExpandTrigger="<leader>c"
let g:UltiSnipsListSnippets="<c-s-tab>"

let g:netrw_banner = 0
