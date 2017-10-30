syntax on
filetype on
"set textwidth=72
set wrap
"set colorcolumn=80 
set softtabstop=4
set tabstop=8
set shiftwidth=4
set expandtab
colorscheme ron
map <F8> :set hls!<BAR>set hls?<CR>
map <F7> :set nu!<BAR>set nu?<CR>
map <F5> :!cscope -Rbqk<CR>:cs reset<CR><CR>
map <F2> :Tlist<CR>
set incsearch
set hls
set laststatus=2
set statusline=%4*%<\ %1*[%F]%4*\ %5*%y%4*%=%6*%m%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%P%4*\ \>
set colorcolumn=81
set paste
highlight ColorColumn ctermbg=1

" ---------- Vundle ----------
set nocompatible              " be iMproved, required
filetype off    
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'https://github.com/scrooloose/nerdtree.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

