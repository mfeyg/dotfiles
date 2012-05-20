filetype plugin indent on
set grepprg=grep\ -nH\ $*
if &t_Co > 1
 syntax enable
endif
set incsearch
au BufEnter *.hs compiler ghc
let g:haddock_browser="/usr/bin/firefox"
set mouse=a

set nocompatible
set showcmd

set autoindent
set expandtab
set smarttab
set shiftwidth=3
set softtabstop=3

let g:clipbrdDefaultReg = '+'

au FileType tex setl tw=80 | set nu
let g:tex_flavor = "latex"
let g:Tex_DefaultTargetFormat = "pdf"
let g:Tex_ViewRule_pdf = "zathura"
