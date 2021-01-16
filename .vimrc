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
:hi CursorLineNr ctermfg=White

filetype indent on
syntax enable

set laststatus=2
augroup gitstatusline
    au!
    let b:git_branch = "- "
    let b:git_diff = "- "
    autocmd TabEnter,BufEnter,FocusGained,BufWritePost *
        \ let b:git_branch = substitute(system("git rev-parse --abbrev-ref HEAD 2>/dev/null"), "\n", " ", "g")
    autocmd TabEnter,BufEnter,FocusGained,BufWritePost *
        \ if !empty(expand('%')) | let b:git_diff = substitute(system("git diff --stat " . expand('%') . " 2>/dev/null"), "\n", " ", "g") | endif
augroup end

function! GitBranch()
  return get(b:, "git_branch", "")
endfunction

function! GitDiff()
  return get(b:, "git_diff", "")
endfunction

:hi PmenuSel ctermfg=White
set statusline=
set statusline+=%#StatusLineTermNC#
set statusline+=\ %{GitBranch()}
set statusline+=%#PmenuSel#
set statusline+=\ %{GitDiff()}
set statusline+=%m
set statusline+=%=
set statusline+=%#LineNr#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ %{&fileformat}
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

set showtabline=2
map <C-t><C-t> :tabs<cr>
map <C-t><right> :tabnext<cr>
map <C-t><left> :tabprevious<cr>
map <C-t><up> :tabnew<cr>
map <C-t><down> :tabclose<cr>
:hi TabLineFill ctermfg=Black ctermbg=Black
:hi TabLine ctermfg=Black ctermbg=Grey 
:hi TabLineSel ctermfg=White ctermbg=DarkRed

highlight VertSplit cterm=None
