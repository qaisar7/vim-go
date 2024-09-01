set nocompatible              " required
set encoding=utf-8
set backspace=indent,eol,start
set nu
set mouse=a

"filetype off                  " required
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
call plug#end()

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:netrw_altv = 1  " Open files in vertical split to the right
let g:netrw_liststyle = 3  " Tree-style file explorer

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
Plugin 'vim-scripts/indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" Python related shinanigans
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

let mapleader = ","

let python_highlight_all=1
syntax on

let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"nnoremap <leader>t :w !go test >> /tmp/vim_log.pipe<CR>
"make the pipe using command: mkfifo /tmp/vim_log.pipe
"watch --color -n 0.3 'cat /tmp/vim_log.pipe'


" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

let g:go_fmt_command = "goimports"
let g:go_def_mode = "gopls"
let g:go_info_mode = "gopls"
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.go NERDTree
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>d <Plug>(go-decls)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
autocmd Filetype go command! -bang DV call go#decls(<bang>0, 'vsplit')

" This section is not really related to vim, but as we are talking about Go,
" its best to list it here.
" :GoTestFunc - to test the function under the cursor.
" :GoCoverage - to test the coverage.
" :GoCoverageClear - to clear the highlights.
" :GoAlternate - quickly switch btw file and its test file & vice-versa. 
" gd to navigate to the defination of something.
" ctrl-t to navigate back to where we called the definition lookup
" :GoDecls - to list all the functions in the file.
" :GoDeclsDir - to list all the functions in the directory of all the files
" but not the sub-directories.
" :GoFiles to list all the files in the package.
" :GoReferrers to list all the references of identifiers.
" :GoCallers - callers of a function.
" :GoCalleers - callees of a function.

set autowrite "Save the file when calling build.

map <C-n> :cnext<CR>
map <C-p> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" Map left and right arrow keys to open and close directories in NERDTree, only when NERDTree is focused
let g:NERDTreeMapCloseDir="<Left>"
let g:NERDTreeMapActivateNode="<Right>"
let NERDTreeCustomOpenArgs = {'file': {'reuse': 'all', 'where': 'p', 'keepopen':1, 'stay':1}, 'dir':{}}

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

