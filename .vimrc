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
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
function! StatuslineGitBranch()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
function! GitDiff()
  return system("git diff --stat .vimrc | tr -d '\n'")
endfunction
function! StatuslineGitDiff()
  let l:diffstat = GitDiff()
  return strlen(l:diffstat) > 0?'  '.l:diffstat.' ':''
endfunction
set statusline=
set statusline+=%#StatusLineTermNC#
set statusline+=%{StatuslineGitBranch()}
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGitDiff()}
set statusline+=%#LineNr#
set statusline+=%m
set statusline+=%=
set statusline+=%#Todo#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

set showtabline=2
map <C-t><C-t> :tabs<cr>
map <C-t><right> :tabnext<cr>
map <C-t><left> :tabprevious<cr>
map <C-t><up> :tabnew<cr>
map <C-t><down> :tabclose<cr>
:hi TabLineFill ctermfg=Black ctermbg=Black
:hi TabLine ctermfg=White ctermbg=Grey
:hi TabLineSel ctermfg=White ctermbg=DarkRed

highlight VertSplit cterm=None
