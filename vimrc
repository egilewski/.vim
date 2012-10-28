"set cin!
"set et!
"set ts=2
"set noet
"set ai
"set si
"set cin
syntax on
" Commented out for Vundle.
"filetype on
"filetype plugin on
colorscheme delek
set showcmd
set statusline=%t%m%r%h%w\ [%{&ff}]\ %y\ [\%03.3b/0x\%02.2B]%=[%l(%L\),\ %v]\ [%p%%]
set laststatus=2
set cc=81
autocmd FileType python set cc=80
autocmd FileType html set cc=0
autocmd FileType htmldjango set cc=0
set highlight=sb
set scrolloff=100
set undofile
set relativenumber
set numberwidth=1
set backspace=indent,eol,start
set incsearch
set nohlsearch
"set ignorecase
set smartcase
set autoindent

set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
autocmd FileType python set tabstop=4
autocmd FileType python set shiftwidth=4
autocmd FileType python set softtabstop=4
autocmd FileType php set tabstop=2
autocmd FileType php set shiftwidth=2
autocmd FileType php set softtabstop=2

let mapleader = ","

"set encoding=utf-8
"set termencoding=utf-8
set fileencodings=utf-8,cp1251,cp866,koi8-u

" Whitespace highlighting
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" Moving aroud windows.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

"""""""""""""""
" Python-mode "
"""""""""""""""
" Python-mode code checking
let g:pymode_lint_checker = "pep8,pyflakes,pylint,mccabe"
let g:pymode_lint_cwindow = 0
let g:pymode_lint_onfly = 1
" Python rope
let g:pymode_rope_goto_def_newwin = "new"
let g:pymode_rope_guess_project = 0
let g:pymode_rope_vim_completion=1
:map <Leader>g :call RopeGotoDefinition()<cr>
"""""""""""""""""""
" End Python-mode "
"""""""""""""""""""

""""""""""
" Vundle "
""""""""""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
"Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdcommenter'
Bundle 'klen/python-mode'
" vim-scripts repos
" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
"
filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" CLI: vim +BundleInstall +qall
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
""""""""""""""
" End Vundle "
""""""""""""""

"""""""""""""""""""""""""""
" Restore cursor position "
"""""""""""""""""""""""""""
" Tell vim to remember certain things when we exit
"  '100 :  marks will be remembered for up to 100 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='100,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
"""""""""""""""""""""""""""""""
" End Restore cursor position "
"""""""""""""""""""""""""""""""

" Run python on this program when pressing F9
nmap <silent> <F9> :w<CR>:!%:p<CR>
vmap <silent> <F9> <esc>:w<CR>:!%:p<CR>
imap <silent> <F9> <esc>:w<CR>:!%:p<CR>

" <F7> File fileformat (dos - <CR> <NL>, unix - <NL>, mac - <CR>)
map <F7>	:execute RotateFileFormat()<CR>
vmap <F7>	<C-C><F7>
imap <F7>	<C-O><F7>
let b:fformatindex=0
function! RotateFileFormat()
  let y = -1
  while y == -1
    let encstring = "#unix#dos#mac#"
    let x = match(encstring,"#",b:fformatindex)
    let y = match(encstring,"#",x+1)
    let b:fformatindex = x+1
    if y == -1
      let b:fformatindex = 0
    else
      let str = strpart(encstring,x+1,y-x-1)
      return ":set fileformat=".str
    endif
  endwhile
endfunction

" <F8> File encoding for open
" ucs-2le - MS Windows unicode encoding
map <F8>	:execute RotateEnc()<CR>
vmap <F8>	<C-C><F8>
imap <F8>	<C-O><F8>
let b:encindex=0
function! RotateEnc()
  let y = -1
  while y == -1
    let encstring = "#koi8-u#cp1251#8bit-cp866#utf-8#ucs-2le#"
    let x = match(encstring,"#",b:encindex)
    let y = match(encstring,"#",x+1)
    let b:encindex = x+1
    if y == -1
      let b:encindex = 0
    else
      let str = strpart(encstring,x+1,y-x-1)
      return ":e ++enc=".str
    endif
  endwhile
endfunction

" <Shift+F8> Force file encoding for open (encoding = fileencoding)
map <S-F8>	:execute ForceRotateEnc()<CR>
vmap <S-F8>	<C-C><S-F8>
imap <S-F8>	<C-O><S-F8>
let b:encindex=0
function! ForceRotateEnc()
  let y = -1
  while y == -1
    let encstring = "#koi8-u#cp1251#8bit-cp866#utf-8#ucs-2le#"
    let x = match(encstring,"#",b:encindex)
    let y = match(encstring,"#",x+1)
    let b:encindex = x+1
    if y == -1
      let b:encindex = 0
    else
      let str = strpart(encstring,x+1,y-x-1)
      :execute "set encoding=".str
      return ":e ++enc=".str
    endif
  endwhile
endfunction

" <Ctrl+F8> File encoding for save (convert)
map <C-F8>	:execute RotateFEnc()<CR>
vmap <C-F8>	<C-C><C-F8>
imap <C-F8>	<C-O><C-F8>
let b:fencindex=0
function! RotateFEnc()
  let y = -1
  while y == -1
    let encstring = "#koi8-u#cp1251#8bit-cp866#utf-8#ucs-2le#"
    let x = match(encstring,"#",b:fencindex)
    let y = match(encstring,"#",x+1)
    let b:fencindex = x+1
    if y == -1
      let b:fencindex = 0
    else
      let str = strpart(encstring,x+1,y-x-1)
      return ":set fenc=".str
    endif
  endwhile
endfunction

" Use for debugging.
"augroup vimrc
"au!
    "" Auto reload vim settins
    "autocmd BufWritePost * source ~/.vimrc
"augroup END
