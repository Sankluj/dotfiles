set nocompatible              " be iMproved, required
filetype off                  " required

set ignorecase
set smartcase

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" --- Plugins ---

" Navigation
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'

" Git integration
Plugin 'tpope/vim-fugitive'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'

" Default sane config
Plugin 'tpope/vim-sensible'

" Text manipulation helpers
Plugin 'tpope/vim-surround'
" Plugin 'luochen1990/rainbow'
Plugin 'jiangmiao/auto-pairs'
Plugin 'alvan/vim-closetag'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdcommenter'

" File Navigation
Plugin 'kien/ctrlp.vim'

" Editor Style
" Plugin 'joshdick/onedark.vim'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'

" Lint
Plugin 'dense-analysis/ale'

" Syntax highlighting
Plugin 'sheerun/vim-polyglot'

" Autocompletion
Plugin 'valloric/youcompleteme'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" --- Global Configuration ---

syntax enable
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set background=dark
colorscheme gruvbox
set guifont=Menlo:h14
set guioptions=
set shiftwidth=2
set tabstop=2
set expandtab
set number
autocmd BufWritePre * %s/\s\+$//e
set splitbelow
set splitright
set hidden

" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" --- Plugins Configuration ---

" -- Airline
let g:airline_powerline_fonts = 1
let g:airline_section_z = ' %{strftime("%-I:%M %p")}'
let g:airline_section_warning = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'

" -- NERDTree
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
let g:used_javascript_libs = 'react'

" -- Ale
let g:ale_fix_on_save = 1
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'html': ['htmlhint']
\}
let g:ale_javascript_eslint_executable='npx eslint'
let g:ale_javascript_eslint_options = '--cache'
let g:ale_fixers = {
\ 'javascriptreact': ['prettier', 'eslint'],
\ 'javascript': ['prettier', 'eslint'],
\ 'go': ['gofmt'],
\ '*': ['prettier']
\}
" .htmlhintrc file not working
" let g:ale_html_htmlhint_options = '--config ~/.htmlhintrc --format=unix stdin'

" -- ctrlp
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" -- closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" -- YouCompleteMe
" set completeopt-=preview
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1

" -- Rainbow
" let g:rainbow_active = 1

" --- General Key Mappings ---
let mapleader = ";"
noremap <leader>l :ALEFix<CR>
noremap <leader>w :w<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>f :NERDTreeFind<CR>
noremap <leader>p :CtrlP<CR>
noremap <leader>b :CtrlPBuffer<CR>
autocmd FileType javascript nnoremap <buffer> <leader>g :YcmCompleter GoTo<CR>
" Move between buffers
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>

" Move between splits
nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Move lines Up and Down
nnoremap <DOWN> :m .+1<CR>==
nnoremap <UP> :m .-2<CR>==
vnoremap <DOWN> :m '>+1<CR>gv=gv
vnoremap <UP> :m '<-2<CR>gv=gv

" Use tab for indenting in visual mode
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" File Manipulation
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
command -nargs=0 -bar Update if &modified
                           \|    if empty(bufname('%'))
                           \|        browse confirm write
                           \|    else
                           \|        confirm write
                           \|    endif
                           \|endif
nnoremap <silent> <C-S> :<C-u>Update<CR>
inoremap <c-s> <Esc>:Update<CR>
nnoremap <C-w> :bp<bar>sp<bar>bn<bar>bd<CR>
