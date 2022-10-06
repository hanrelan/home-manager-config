"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

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
set clipboard^=unnamedplus
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

set background=dark
let ayucolor="dark"   " for dark version of theme
colorscheme ayu
let g:airline_theme="ayu_dark"
" colorscheme molokai
" let g:airline_theme='term'
" let g:airline_theme='gruvbox'
" let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox


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


