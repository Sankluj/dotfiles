set nocompatible              " be iMproved, required
filetype off                  " required

" --- Plugins ---
call plug#begin('~/.vim/plugged')

" Navigation
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'

" Default sane config
Plug 'tpope/vim-sensible'

" Text manipulation helpers
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'Yggdroot/indentLine'
Plug 'scrooloose/nerdcommenter'

" File Navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'           " Set up fzf and fzf.vim

" Editor Style
Plug 'morhetz/gruvbox'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Lint & Autocompletion
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" golang
Plug 'fatih/vim-go'

call plug#end()
filetype plugin indent on    " required

" --- Global Configuration ---
set ignorecase
set smartcase
syntax enable
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
set hlsearch
set mouse=a

" Trigger `autoread` when files changes on disk
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
let g:NERDTreeMouseMode=3

" -- Syntax Highlighting
let g:used_javascript_libs = 'react'

" -- closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.erb,*.jsx,*.js,*ts,*tsx"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js,*.erb,*ts,*tsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader>>'

" -- CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-go']

" Add CoC Prettier if prettier is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

" Add CoC ESLint if ESLint is installed
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

" -- Golang
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 0

" -- Doc display
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"autocmd CursorHold * silent call CocActionAsync('doHover')

" --- General Key Mappings ---
let mapleader = ";"
noremap <leader>w :w<CR>
noremap <leader>q :q<CR>
noremap <leader>n :NERDTreeToggle<CR>
noremap <leader>f :NERDTreeFind<CR>
noremap <leader>p :GFiles<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>g :Ag<CR>
noremap <silent><leader>d :call CocActionAsync('doHover')<CR>
" Move between buffers
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>
" Move between location list
nnoremap <leader>) :lnext<CR>
nnoremap <leader>( :lprev<CR>
" Open Vim configuration file for editing
nnoremap <silent><leader>2 :e ~/.vimrc<CR>
" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>
" Coc
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <leader>a <Plug>(coc-codeaction-selected)
nmap <silent> <leader>ac <Plug>(coc-codeaction)

" js/ts Key Mappings
autocmd FileType typescript,typescriptreact,javascript,javascriptreact noremap <leader>l :CocCommand prettier.formatFile<CR>
autocmd FileType typescript,typescriptreact,javascript,javascriptreact nmap <leader>rn <Plug>(coc-rename)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact nmap <silent> <leader>g <Plug>(coc-definition)
autocmd FileType typescript,typescriptreact,javascript,javascriptreact nmap gr <Plug>(coc-references)

" Golang Key Mappings
" [[ and ]] to navigate between functions
" if and af to select inner and outer function
autocmd FileType go nmap gb  <Plug>(go-build)
autocmd FileType go nmap gr  <Plug>(go-run)
autocmd FileType go nmap gt  <Plug>(go-test)
autocmd FileType go nmap gft  <Plug>(go-test-func)
autocmd FileType go nmap gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap ga :GoAlternate<CR>
autocmd FileType go nmap <leader>o :GoDeclsDir<CR>
autocmd FileType go nmap <buffer> <leader>g :GoDef<CR>
autocmd FileType go nmap <buffer> <leader>rn :GoRename<CR>

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
