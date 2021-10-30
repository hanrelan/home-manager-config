syntax on
set nocompatible
set hidden
set nowrap
set ruler
set mouse=a
set smarttab
set nobackup
set nowritebackup
set smartindent
set showmatch
set shiftwidth=2
set tabstop=2
set noexpandtab
set ignorecase
set smartcase
set incsearch
set backspace=eol,start,indent
set whichwrap=h,l,~,[,]
if system("uname") == "Darwin\n"
  set clipboard=unnamed
endif

set ttyfast
set shell=zsh
set visualbell
set nohlsearch
set number
set t_vb=
map <C-n> :bn<CR>
map <C-m> :bp<CR>
map <C-p> <C-^>
map <C-y> :redo<CR>
map <C-b> :buffers<CR>
cmap W w
cmap Q qa

colorscheme molokai
let g:airline_theme='term'
" colorscheme gruvbox
" let g:airline_theme='gruvbox'


let g:explVertical=1
let g:explStartRight=1
let g:explWinSize=50

" File completion in command line after :e
set wildmenu
set wildmode=full

" Show tabs on top
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_section_c = ''
let g:airline_section_y = ''


