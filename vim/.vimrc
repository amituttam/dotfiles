" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" Source a global configuration file if available
" XXX Deprecated, please move your changes here in /etc/vim/vimrc
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

set tabstop=4
set shiftwidth=4
"set expandtab
set noswapfile
set autoindent
set nobackup
set nowritebackup
set viminfo=

if has('gui_running')
    colors leo
	"colors bluegreen
    "set guifont=DejaVu\ Sans\ Mono\ 11
    set guifont=Inconsolata\ 14
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=b
else
    set t_Co=256
	"colors inkpot
	"colors slate
	"colors default
	colors delek 
	"colorscheme wombat_term
endif

set guicursor=a:blinkon0

" For printing
"set printoptions=left:2pc,right:2pc
set printfont=courier:h12

" 80 column text width with highlighted color
" set textwidth=80
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.*/

" Tags
set tags=./tags;/
map <F4> :TlistToggle <CR>
map <F8> :!/usr/bin/ctags -R<CR>

" Highlight all search matches
set hlsearch

set autochdir

" Highlighting
map <F11> :match ErrorMsg '\%>80v.\+' <CR>
map <F12> :call clearmatches() <CR>

"flag problematic whitespace (trailing and spaces before tabs)
"Note you get the same by doing let c_space_errors=1 but
"this rule really applys to everything.
"highlight RedundantSpaces term=standout ctermbg=red guibg=red
"match RedundantSpaces /\s\+$\| \+\ze\t/ "\ze sets end of match so only spaces highlighted
"use :set list! to toggle visible whitespace on/off
set listchars=tab:>-,trail:.,extends:>
"let c_space_errors=1
"highlight WhitespaceEOL ctermbg=red guibg=red
map <F10> :set list!<CR>

set wm=2
set textwidth=72

" Grep word under cursor
map <F5> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR>
nnoremap <silent> <F6> :Rgrep<CR>
nnoremap <silent> <F7> :RgrepAdd -i<CR>

" DWM fix for extra width at the bottom of screen
set ghr=5

" Autoread changed documents
set autoread

" For GNU Screen (should fix Del key)
if $TERM == 'screen'
      set term=xterm
endif

set modeline

" For diff mode
if &diff
    set foldmethod=manual
endif

" To save file as root
cmap w!! %!sudo tee > /dev/null %

" Autocomplete
let g:neocomplcache_enable_at_startup=0

" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

" For CTRL+P
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_max_files=0
let g:ctrlp_regexp=1
"let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
let g:ctrlp_user_command=['.git', 'cd %s && git ls-files']
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
