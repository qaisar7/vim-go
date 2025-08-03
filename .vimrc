call plug#begin('~/.vim/plugged')

" plugin to automatically indent files in html
Plug 'jasonwoodland/vim-html-indent'

" colorscheme for python
Plug 'morhetz/gruvbox'

" Install colorscheme vim-gitgo for Go
Plug 'bitfield/vim-gitgo'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" For autocompletion
Plug 'ycm-core/YouCompleteMe'

" For ctags generation
Plug 'ludovicchabant/vim-gutentags'

" For displaying tags in a sidebar
Plug 'preservim/tagbar'
" Above is for Go files. Use ':Tagbar' to display the functions.

" Syntax highlighting
Plug 'vim-python/python-syntax'

" Autocompletion with Jedi
Plug 'davidhalter/jedi-vim'

" Asynchronous linting and fixing
Plug 'dense-analysis/ale'

" Fern file explorer
Plug 'lambdalisue/fern.vim'

" Git status indicator for fern
Plug 'lambdalisue/fern-git-status.vim'

" Nerd Font icons for better visuals
Plug 'lambdalisue/nerdfont.vim'

call plug#end()

" ALE settings for Python
let g:ale_linters = {'python': ['flake8', 'mypy']}
let g:ale_fixers = {'python': ['autopep8', 'isort', 'remove_trailing_lines', 'trim_whitespace']}
let g:ale_fix_on_save = 1

" Use Jedi for autocompletion
let g:jedi#completions_enabled = 1

autocmd BufEnter * silent! lcd %:p:h

let mapleader = " "
nnoremap <Leader>f :Fern . -drawer -width=30 -toggle<CR>
autocmd FileType fern nnoremap <buffer> - :Fern ..<CR>

nnoremap <leader>n :set number!<CR>
nnoremap <leader>[ :tabprevious<CR>
nnoremap <leader>] :tabnext<CR>
autocmd FileType go nnoremap <buffer>t :TagbarToggle <CR>
augroup go_build_map
  autocmd!
  autocmd FileType go nnoremap <buffer> <C-_>b :GoBuild<CR>
augroup END

let g:ale_virtualtext_enabled = 1  " Enable inline messages by default
nnoremap <leader>e :let g:ale_virtualtext_enabled = !g:ale_virtualtext_enabled<CR>


set mouse=a
" colorscheme gruvbox
set background=dark

" Use vim-gitgo colorscheme for Go files
autocmd FileType go colorscheme gitgo

" Use gruvbox for Python files
autocmd FileType python colorscheme gruvbox

" Optional: revert to gruvbox when opening other files
" autocmd BufEnter * if &filetype !=# 'go' && &filetype !=# 'python' | colorscheme gruvbox | endif

" Run Go files in another window
" autocmd FileType go nnoremap <buffer> <leader>r :w<CR>:split | terminal go run %<CR>
nnoremap <leader>r :w<CR>:split \| terminal go run %<CR>

" Enable indentation for html files
filetype plugin indent on

" Set indentation width to 2 spaces
set tabstop=2       " Number of spaces that a <Tab> counts for
set shiftwidth=2    " Number of spaces used for each indent level
set expandtab       " Convert tabs to spaces, so indent uses spaces only

