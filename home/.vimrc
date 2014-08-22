" Disable vi-compatibility
set nocompatible

" ========================================================================
" Vundle stuff
" ========================================================================
filetype off

" Set up Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'bling/vim-airline'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'nanotech/jellybeans.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-surround'
Plugin 'davidoc/taskpaper.vim'
Plugin 'Tabmerge'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'wlangstroth/vim-racket'
Plugin 'tpope/vim-commentary'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'taglist.vim'
Plugin 'vim-pandoc/vim-markdownfootnotes'
Plugin 'tpope/vim-dispatch'
Plugin 'bjoernd/vim-weasel'

" Required for Vundle
call vundle#end()
filetype plugin indent on

" vim-airline options
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline_theme='jellybeans'

" vim-markdown options
let g:vim_markdown_folding_disabled=1

" Syntax highlighting on
syntax enable


" ========================================================================
" Keyboard
" ========================================================================
let mapleader=","

" Remember last tab and switch to it when <Leader>tl is used
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

map <Leader>rc :tabe ~/.vimrc<CR>
map <Leader>zshrc :tabe ~/.zshrc<CR>
map <Leader>m :Make!<CR>

" Bring up taglist window
nnoremap <silent> <Leader>t :TlistToggle<CR>

" Easy escape
imap jk <Esc>

" Use semicolon as colon as well
" nnoremap ; :

" Enter will insert a line
nmap <CR> o<Esc>

" Ctrl-S to save a file
nnoremap <silent> <C-s> :<C-u>w<CR>
inoremap <c-s> <c-o>:w<cr>
vnoremap <c-s> <c-c>:w<cr>

" New tab with Ctrl-t
map <C-t> <esc>:tabnew<CR>

" Make window navigation easier
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Time to get serious here... No more arrow keys
noremap <left> <nop>
noremap <up> <nop>
noremap <down> <nop>
noremap <right> <nop>

" Allows normal movements on wrapped lines
onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" Tab complete
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

" Fix typical typos
command! Q q            " Bind :Q to :q
command! Qall qall      " Bind :Qall to :qall
cnoremap q1 q!
cnoremap Wq wq
cnoremap WQ wq

" Shortcut for clearing search results
command C let @/=""


" ========================================================================
" Text
" ========================================================================
set autoindent
set encoding=utf-8 	" Necessary to show Unicode glyphs
set expandtab
set smartindent
set cinkeys-=#      " Allow use of >> with commented lines
set tabstop=4
set shiftwidth=4
set shiftround      " When at 3 spaces and I hit >>, go to 4, not 5.
set lbr				" Linebreak
"set tw=80			" Linebreak at 80 char
"set formatoptions+=aw
"set fo-=t
set hlsearch        " Turn on search highlighting
set nowrap
set backspace=2

" Search
set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       " ...unless uppercase letters used
set hlsearch        "Highlight all matches


" ========================================================================
" Display
" ========================================================================
colorscheme jellybeans
set equalalways       " Display split windows equally
set background=light
set t_Co=256          " Number of colors in terminal
set guioptions-=L     " Remove left scroll bar
set guioptions-=r     " Remove right scroll bar
set ruler             " Show line number
set number            " Line numbers
set laststatus=2      " Status bar
set showcmd           " Show commands
set splitbelow        " Split windows below current window
set colorcolumn=80
set scrolloff=10
set laststatus=2
set ttimeoutlen=50


" ========================================================================
" File Types
" ========================================================================

" Automatically add Shebang
augroup Shebang
     autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
     autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby\<nl># -*- coding: None -*-\<nl>\"|$
augroup END

" Text files
autocmd BufNewFile,BufRead *.txt,*.tex,*.md setlocal spell spelllang=en_us wrap

" Python
autocmd BufNewFile,BufReadPost *.py setl syntax=python shiftwidth=4 expandtab makeprg=python\ %

" Taskpaper
autocmd BufNewFile,BufRead *.taskpaper setlocal spell spelllang=en_us wrap

" Git commit messages
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell


" ========================================================================
" Functions
" ========================================================================

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction

" Trailing whitespace
function! <SID>StripTrailingWhitespaces()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" Do the business
	%s/\s\+$//e
	" Clean up: restore previous search history, and cursor position
	let @/=_s
	call cursor(l,c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.
"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction

