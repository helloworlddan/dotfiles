set autoindent
set expandtab
set shiftround
set shiftwidth=2
set smarttab
set tabstop=2

set hlsearch
set incsearch
set smartcase

set encoding=utf-8
set linebreak
set scrolloff=5
set sidescrolloff=10

set noerrorbells
set background=dark

set ruler
set relativenumber
set nu

filetype indent on
syntax enable

set laststatus=2

set showtabline=2
map <C-t><C-t> :tabs<cr>
map <C-t><right> :tabnext<cr>
map <C-t><left> :tabprevious<cr>
map <C-t><up> :tabnew<cr>
map <C-t><down> :tabclose<cr>
:hi TabLineFill ctermfg=Black ctermbg=Black
:hi TabLine ctermfg=White ctermbg=Grey
:hi TabLineSel ctermfg=White ctermbg=DarkRed

