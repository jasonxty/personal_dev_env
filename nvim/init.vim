call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'dhananjaylatkar/cscope_maps.nvim' " cscope keymaps
Plug 'folke/which-key.nvim' " optional [for whichkey hints]
Plug 'nvim-telescope/telescope.nvim' " roptional [for picker='telescope']
Plug 'ibhagwan/fzf-lua' " optional [for picker='fzf-lua']
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons' " optional [for devicons in telescope or fzf]
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-gutentags'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()
lua require("cscope_maps").setup()
lua require("nvim-tree").setup()

set nobackup
set nowritebackup
set hidden
set enc=utf8
set fencs=utf8,gbk
color desert
syntax on
"set nu
set sm
set ai
set ls=2
"set cino=g0l1
set ffs=unix,mac,dos
"Added by haichi for indentation
"we can use :h cinoptions-values to find the meaning of cino 
set cino=:0l1(0
"Reducing indentation problem in .diff files.Added by haichi for using spaces instead of tabs in .c
set tabstop=4 shiftwidth=4 expandtab
"Formatting comments. Added by haichi
set fo=croq

" REQUIRED. This makes vim invoke latex-suite when you open a tex file.
"filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
"set shellslash

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

set guifont=Bitstream\ Vera\ Sans\ Mono\ 8
set guioptions-=T
set guioptions-=m

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse latex-suite. Set your grep
" program to alway generate a file-name.
set shellslash
set grepprg=grep\ -nH\ $*
augroup Source
  au BufWritePost *.cxx set ft=cpp
  au BufWritePost *.c set ft=c
  au BufWritePost *.tex set ft=tex sw=2
  au BufWritePost *.cpp set ft=cpp
  au BufWritePost *.h set ft=cpp
  au BufWritePost *.mp set ft=mp
  au BufWritePost *.py set ft=python
"  au BufReadPost *.py call Python_fold()
"  au BufWritePost *.py call Python_fold()
augroup END

"augroup c_prog
"  fun! C_fold()
"  if (! exists("b:outline_mode"))
"    FOLD
"  elseif (b:outline_mode==0)
"    FOLD
"  endif
"  endfun
"  au FileType c call C_fold()
"  au FileType cpp call C_fold()
"  au FileType c call DoWordComplete()
"augroup END

set bs=indent,eol,start
" set backup
let Tlist_Ctags_Cmd="/users/fazhang/bin/ctags"
set is
set hls
set ruler
map <silent> <S-F12> :TlistUpdate<CR>

"--------------------------------------------------
" autocmd FileType c,cpp nnoremap <F12> mm:%!astyle --style=ansi --convert-tabs -O -p -L -T<CR> :update<CR>'m
" autocmd FileType c,cpp inoremap <F12> <Esc>mm:%!astyle --style=ansi -T<CR> :update<CR>'m
"-------------------------------------------------- 

"configuration for python_prog
augroup python_prog 
  au! 
  fun! Python_fold() 
    syntax keyword pythonStatement pass
    syntax clear pythonStatement 
    syntax keyword pythonStatement break continue del
    syntax keyword pythonStatement except exec finally
    syntax keyword pythonStatement pass print raise
    syntax keyword pythonStatement return try
    syntax keyword pythonStatement global assert
    syntax keyword pythonStatement lambda yield
    syntax match pythonStatement /\<def\>/ nextgroup=pythonFunction skipwhite
    syntax match pythonStatement /\<class\>/ nextgroup=pythonFunction skipwhite
    syntax region pythonFold start="^\z(\s*\)\%(.*:\s*\%(#.*$\)\?\)" end="^\%(\n*\z1\s\)\@!" transparent fold
    syntax sync minlines=2000 maxlines=4000
    set foldmethod=syntax 
    "set foldopen=all foldclose=all 
    set foldtext=substitute(getline(v:foldstart),'\\t','\ \ \ \ ','g').'\ \ ('.(v:foldend-v:foldstart+1).'\ lines)'
    set fillchars=vert:\|,fold:\ 
    set tabstop=4 shiftwidth=4 nowrap
  	set complete+=k~/.vim/pydiction iskeyword+=.
  endfun 
"    autocmd FileType python call Python_fold() 
augroup END

"map <C-J> <C-W>j<C-W>_
"map <C-K> <C-W>k<C-W>_
map <C-J> <C-W>j
map <C-K> <C-W>k
set wmh=0

" Setting the font in the GUI
if has("gui_running") 
  if has("gui_gtk2") 
    set guifont=Courier\ New\ 10
  elseif has("gui_photon")
    set guifont=Courier\ New:s11
  elseif has("gui_kde")
    set guifont=Courier\ New/11/-1/5/50/0/0/0/1/0
  elseif has("x11") 
    "set guifont=-*-courier-medium-r-normal-*-*-180-*-*-m-*-* 
  else 
    set guifont=Courier_New:h11:cDEFAULT 
  endif 
endif 

" This option gets rid of the menu.
" set guioptions-=m

" Toggle the taglist window
map <M-F8> :TlistToggle<CR>
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplForceSyntaxEnable=1
" Move to the next or previous tab
map <C-H> :bp<CR>
map <C-L> :bn<CR>

" Close the tab windows
map <M-F4> :bd<CR>

"map <BACKSPACE> X

"To activate, choose "Word Completion" from the Tools menu, or type
"  :call DoWordComplete()
"To make it stop, choose "Tools/Stop Completion," or type
"  :call EndWordComplete()

" To save, ctrl-s.
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>a

" switch between *.h and *.c
nnoremap <silent> <F12> :A<CR>

" Set at least some personal details for c.vim
let g:C_AuthorName      = 'Fan Zhang'
let g:C_AuthorRef       = 'fazhang'
let g:C_Email           = 'fazhang@cisco.com'
let g:C_Company         = 'Cisco Systems, Inc.'

" All folds open when open a file
"set foldmethod=indent
"set foldlevel=20

" Execute Macor by teype one key
nnoremap <silent> <F11> @a

" [cctree.vim]
let g:CCTreeCscopeDb = "cscope.out"
let g:CCTreeRecursiveDepth = 1
let g:CCTreeMinVisibleDepth = 3
let g:CCTreeOrientation = "leftabove"
map <F8> :CCTreeLoadXRefDBFromDisk cctree.out<CR> 

 let g:miniBufExplMapWindowNavVim = 1 
 let g:miniBufExplMapWindowNavArrows = 1 
 let g:miniBufExplMapCTabSwitchBufs = 1 
 let g:miniBufExplModSelTarget = 1
 
 set nocompatible
 set history=1000 
 set autoindent
 set smartindent
 "set number
 set tabstop=4
 set shiftwidth=4
 set showmatch
 set guioptions-=T
 set guioptions-=r
 
 set vb t_vb=
 set ruler
 set incsearch
 set hlsearch
 
 
 filetype on 
 syntax on 
 au FileType c,cpp set cindent
 au FileType c,cpp set tabstop=4
 au FileType tmc set tabstop=4
 au FileType c,cpp,tmc set shiftwidth=4 | set expandtab
 
 set tags=./tags,../tags,../../tags,../../../tags
 let Tlist_Show_One_File = 1
 let Tlist_Exit_OnlyWindow = 1
 let Tlist_Enable_Fold_Column = 0
 
 "let Tlist_Ctags_Cmd = '/usr/bin/ctags'
 
 if filereadable("cscope.out")
   cs add cscope.out  
 elseif filereadable("../cscope.out")
   cs add ../cscope.out ..
 elseif filereadable("../../cscope.out")
   cs add ../../cscope.out ../..
 elseif filereadable("../../../cscope.out")
   cs add ../../../cscope.out ../../..
 elseif $CSCOPE_DB != ""
   cs add $CSCOPE_DB
 endif
 
 
 
 nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>	
 nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>	
 nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>	
 nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>	
 nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>	
 nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	
 nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
 nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
 
 
 nnoremap <silent> <F12> :A<CR>
 nnoremap <silent> <F4> :Grep<CR>
 
 if has("gui_running")
   let psc_style='cool'
     set lines=50
   set columns=90
   colorscheme koehler
   let Tlist_Auto_Open=1
 else
   set background=dark
   let psc_style='cool'
 endif

set nopaste

filetype plugin on

let g:pydiction_location='~/.vim/complete-dict' 

nmap <silent> <F12> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_left = 1  
let g:tagbar_autofocus = 1  
set cul
