if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif
"auto reload when file changes
set autoread

set nocompatible
filetype plugin on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

filetype indent on
map <F5> I// <ESC>
map <F11> ^xx
set foldmethod=indent
set ts=4
set softtabstop=4
set ai

" cross
set cul
set cul

"php function auto complete
au FileType php call PHPFuncList()
function PHPFuncList()
        set dictionary-=/home/yang/.vim/plugin/php_funclist.txt
        set dictionary+=/home/yang/.vim/plugin/php_funclist.txt
        set complete-=k complete+=k
endfunction
set nocp
" fuzzy find
"set path+=**
"set wildmenu
set nofoldenable
set relativenumber
set autoindent
set smartindent
set showmatch
set expandtab
set nu!
set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
Bundle 'Raimondi/delimitMate'
Plugin 'wakatime/vim-wakatime'

let g:rainbow_active = 1
inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>

autocmd BufWritePost *.php call PHPSyntaxCheck()
if !exists('g:PHP_SYNTAX_CHECK_BIN')
        let g:PHP_SYNTAX_CHECK_BIN = 'php'
endif

function! PHPSyntaxCheck()
        let result = system(g:PHP_SYNTAX_CHECK_BIN.' -l -n '.expand('%'))
        if (stridx(result, 'No syntax errors detected') == -1)
                echohl WarningMsg | echo result | echohl None
        endif
endfunction
