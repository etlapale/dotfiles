set nocompatible	" I hate VI
set noexrc		" No local version of .vimrc
set hlsearch            " Highlight search results
set ruler               " Show position always
set backspace=indent,eol,start  " Allow BS everywhere
syntax on		" Use some colors

set expandtab

" Neo Bundle
"if has('vim_starting')
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif

"call neobundle#begin(expand('~/.vim/bundle/'))
  "NeoBundleFetch 'Shougo/neobundle.vim'
  "NeoBundle 'bling/vim-airline'
  "NeoBundle 'gabrielelana/vim-markdown'
"call neobundle#end()

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'gabrielelana/vim-markdown'
Plug 'hynek/vim-python-pep8-indent'
call plug#end()

filetype plugin indent on

set wildignore+=*.o,*.pyc,*.hi

" Ignore case on searching
set ignorecase

" Syntax highlighting does not seem to work with ‘options’
set sessionoptions-=options

"set t_Co=256

" GUI options
if has('gui_running')
  set guioptions=-M
  " set guifont=Terminess\ Powerline\ 10
  " set guifont=Fira\ Mono\ 10
  set guifont=Fira\ Mono\ for\ Powerline\ 10
  set linespace=-2
  " set guifont=PragmataPro\ 10
  colorscheme pocolors
  set guiheadroom=0
  set mouse=a
else
  colorscheme pocolors
endif

" Airline
set laststatus=2
let g:airline_powerline_fonts=1

set shiftwidth=2
set tabstop=8
set cinoptions=Ls,:0,g0,t0,i4,(0,w4,)30,*80

" C indentation
function! PocoIndent()
  "setlocal cinoptions=Ls,:0,g0
  "setlocal shiftwidth=2
  "setlocal tabstop=8
  setlocal cindent
endfunction

" OpenCL and CUDA
au BufNewFile,BufRead *.cl set filetype=c
au BufNewFile,BufRead *.cu set filetype=c
au BufNewFile,BufRead *.cuh set filetype=c

" Vala
au BufNewFile,BufRead *.vala set filetype=vala cindent
au BufNewFile,BufRead *.vapi set filetype=vala cindent

" GNU indentation
au FileType c call PocoIndent() 

" Python indentation
function! PocoPythonIndent()
  setlocal sw=2
  setlocal expandtab
endfunction
au FileType python call PocoPythonIndent() 

" Qt coding style
function! QtIndent()
  setlocal cinoptions=:0,g0,N-s,t0,u2,W2s,i0
  setlocal shiftwidth=2
  setlocal cindent
endfunction
au BufNewFile,BufRead *.h call QtIndent()
au BufNewFile,BufRead *.cc call QtIndent()
au BufNewFile,BufRead *.qs set filetype=javascript
au BufNewFile,BufRead *.qml set filetype=qml shiftwidth=4

" Mardown
au BufNewFile,BufRead *.md set filetype=markdown

" Haskell
au BufNewFile,BufRead *.hs set filetype=haskell shiftwidth=2
au BufNewFile,BufRead *.hsc set filetype=haskell shiftwidth=2
"let g:haddock_browser = "iceweasel"

" LaTeX
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='latexmk -pdf -pdflatex=lualatex -pvc $*'
set iskeyword+=:
au BufNewFile,BufRead *.tex set textwidth=78

" Coq
au BufRead,BufNewFile *.v set filetype=coq

" waf’s wscript
au BufRead,BufNewFile wscript set filetype=python

" Mutt composition
au BufRead /tmp/mutt-* set tw=72

" reStructuredText
au BufRead,BufNewFile *.rst set tw=79

" zsh
au BufRead,BufNewFile */.zsh/* set filetype=zsh

" vim-airline ruler
" set laststatus=2

" Disable mouse at Airbus since vim has no clipboard support
" set mouse=""

cd
