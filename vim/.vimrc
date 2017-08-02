set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'kien/ctrlp.vim'
"Plugin 'pangloss/vim-javascript'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'joshdick/onedark.vim'
Plugin 'w0rp/ale'
Plugin 'valloric/youcompleteme'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" --- Global Configuration ---

syntax enable
"set background=dark
"let g:solarized_termcolors=256
colorscheme onedark
set guifont=Menlo:h14
set guioptions=
set shiftwidth=2
set tabstop=2
set expandtab
set number
autocmd BufWritePre * %s/\s\+$//e
set splitbelow
set splitright

" --- Plugins Configuration ---

" -- NERDTree
" Toggle Shortcut
map <C-n> :NERDTreeToggle<CR>
map <C-b> :NERDTreeFind<CR>
" Open automatically when no files is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open automatically when a folder is specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" For mouse click in NERDTree
set mouse=a
let g:NERDTreeMouseMode=3

" -- Syntax Highlighting
let g:used_javascript_libs = 'angularjs,angularuirouter'

" -- Ale
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'scss': ['sasslint'],
\ 'html': ['htmlhint']
\}
" .htmlhintrc file not working
" let g:ale_html_htmlhint_options = '--config ~/.htmlhintrc --format=unix stdin'

" -- ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" -- NERDCommenter
nmap <C-_> <leader>c<Space>
vmap <C-_> <leader>c<Space>

" --- General Key Mappings ---
" Move between splits
nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move lines Up and Down
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Tab navigation
map <S-A-Right> :tabn<CR>
map <S-A-Left>  :tabp<CR>
