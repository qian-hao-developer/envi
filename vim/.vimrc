set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'morhetz/gruvbox'                    " for gruvbox scheme
Plugin 'vim-airline/vim-airline'            " for airline status bar
Plugin 'vim-airline/vim-airline-themes'     " for airline status
Plugin 'tpope/vim-fugitive'                 " for git status
Plugin 'Valloric/YouCompleteMe'             " for completion    attention:this need to run install.py at .vim/bundle/ycmd
Plugin 'Shougo/vimproc.vim'                 " background runner, for vimshell, quick-run, etc
Plugin 'taglist.vim'                        " for taglist                                                                                               # use Tlist
Plugin 'scrooloose/nerdcommenter'           " commenter                                                                                                 # use <Leader>c<space>/<Leader>ci
Plugin 'w0rp/ale'                           " asynchronous lint engine
Plugin 'godlygeek/tabular'                  " table format
Plugin 'mileszs/ack.vim'                    " search engine - need to install ack lib on OS
Plugin 'scrooloose/nerdtree'                " directory tree display                                                                                    # use NERDTree,NERDTreeToggle
Plugin 'airblade/vim-gitgutter'             " show git diff status
Plugin 'thinca/vim-quickrun'                " preview code-running
Plugin 'dag/vim-fish'                       " for fish file highlight
Plugin 'kergoth/vim-bitbake'                " for bitbake or yocto
Plugin 'junegunn/fzf'                       " like peco
Plugin 'vim-scripts/gtags.vim'              " gtags
Plugin 'rking/ag.vim'                       " silver search, more speedy than ack
Plugin 'tpope/vim-surround'                 " automatically insert ',{,etc                                                                              # use ysiw(  yang surround inside word {
Plugin 'tpope/vim-repeat'                   " extension for repeat cmd . (support vim-surround)
Plugin 'honza/vim-snippets'                 " auto complete or insert code format (snippet engine)
Plugin 'sirver/ultisnips'                   " snippet
Plugin 'terryma/vim-multiple-cursors'       " multi cursor
Plugin 'plasticboy/vim-markdown'            " markdown highlight
Plugin 'janko-m/vim-test'                   " in file test (need file coded use test framework)                                                         # use TestFile
Plugin 'ctrlpvim/ctrlp.vim'                 " file search
Plugin 'zxqfl/tabnine-vim'                  " tabnine auto completion
Plugin 'git@github.com:qian-hao-developer/vim-highlight.git'
Plugin 'git@github.com:qian-hao-developer/vim-customize.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" vim own
syntax on   " highlight
set number  " line number
set list    " show invisible character
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%  " define invisible character display
set clipboard=unnamed,autoselect   " copy to clipboard
set autoindent
set smarttab
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set wildmode=list:longest   " tab completion as bash
set ignorecase  " caps ignore
set incsearch   " preview search when typing
set nowrapscan  " search will stop at bottom

" gruvbox
colorscheme gruvbox
set background=dark    " Setting dark mode
let g:gruvbox_contrast_dark='soft'
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?

" airline
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1    " enable tab
" nmap <C-p> <Plug>AirlineSelectPrevTab
" nmap <C-n> <Plug>AirlineSelectNextTab
nmap <Leader>p <Plug>AirlineSelectPrevTab
nmap <Leader>n <Plug>AirlineSelectNextTab
let g:airline#extensions#tabline#buffer_idx_mode = 1    " show number for tab
set ttimeoutlen=50  " less duration time when mode changing
let g:airline_powerline_fonts = 1   " enable powerline fonts
let g:airline_gruvbox_bg='dark'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
set laststatus=2
set showtabline=2

" Powerline
"set rtp+=/usr/local/lib/python3.6/site-packages/powerline/bindings/vim/
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
"set laststatus=2
"set showtabline=2
"set noshowmode
"set ttimeoutlen=50  " less duration time when mode changing

" ale grammer check
" Display Setting
let g:ale_sign_error = '✖︎'
let g:ale_sign_warning = '⚡︎'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:ale_set_highlights = 0

" NERDTree
" nnoremap <C-o> :NERDTreeToggle<CR>
" nnoremap <C-t> :NERDTree<CR>
nmap <Leader>o :NERDTreeToggle<CR>
nmap <Leader>t :NERDTree<CR>

" ultisnpis
" because tab used by YCM, don't use tab key-bind
let g:UltiSnipsExpandTrigger="<Leader><tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
