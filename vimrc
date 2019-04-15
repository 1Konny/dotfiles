" =============== plugins ============= "
" enable pathogen
execute pathogen#infect()
filetype plugin indent on


" =============== general ============= "
if filereadable('/bin/zsh')
  set shell=/bin/zsh
endif

syntax on					" syntax highligting
set nocompatible
set cursorline              " highlight current cursorline
set ruler		            " show row/col info
set number				    " show line numbers

" indentation
set backspace=eol,start,indent
set autoindent
set smartindent

" tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" search
set ignorecase              " case-insensitive by default
set smartcase               " case-sensitive if keyword contains both uppercase and lowercase
set incsearch	            " incremental search
set hlsearch				" highlight search keyword

" color settings
set t_Co=256
set t_ut=
set background=dark
colorscheme xoria256

" copy-paste
set pastetoggle=<F8>		                " this will disable auto indent when pasting
autocmd InsertLeave * silent! set nopaste   " unset paste when leaving insert mode

" misc
set visualbell
set history=1000
set undolevels=1000
set noswapfile
set nobackup
set nowrap                  " no line wrapping
set textwidth=0             " no line wrapping
set splitbelow              " split bottom window if needed
set lazyredraw              " don't update screen during macro and script execution
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " no auto comment when inserting newline 


" =============== functional ============= "
let mapleader=","           " comma is the <Leader> key.
let maplocalleader=","      " comma : <LocalLeader>

nnoremap <leader>R :so $MYVIMRC<CR> " reload vimrc in current vim
nnoremap <F2> :noh<CR>              " turn off search highlight until the next search
nnoremap <F9> :set invnumber<CR>    " toggle line number (for the sake of copying text without line numbers)
nnoremap <leader>s :w<CR>           " write/save

nnoremap [b  :bprevious<CR> " go to the previous buffer 
nnoremap ]b  :bnext<CR>     " go to the next buffer
set hidden                  " enable switching across buffers without saving.

" https://superuser.com/questions/310417/how-to-keep-in-visual-mode-after-identing-by-shift-in-vim
:vnoremap < <gv             " keep in visual mode while indenting
:vnoremap > >gv             " (")

" ipdb
:nnoremap <Leader>b Oimport ipdb; ipdb.set_trace(context=15)<Esc>
:nnoremap <Leader>v oimport ipdb; ipdb.set_trace(context=15)<Esc>


" =============== plugins ============= "
" nerdtree
"" browse file tree
"map <Leader>N :NERDTreeToggle<CR>
map " :NERDTreeToggle<CR>
set encoding=utf-8 " fix the issue of being unable to open files outside current directory

" youcompleteme
""let g:ycm_add_preview_to_completeopt = 1
""let g:ycm_autoclose_preview_window_after_completion = 1
""let g:ycm_autoclose_preview_window_after_insertion = 1

" jedi-vim
" https://github.com/davidhalter/jedi-vim/blob/master/doc/jedi-vim.txt
let g:jedi#goto_command="<leader>d"
let g:jedi#goto_assignments_command="<leader>g"
let g:jedi#completions_enabled=0
let g:jedi#show_call_signatures=1 " argument hints 
let g:jedi#show_call_signatures_delay=50
let g:jedi#use_tabs_not_buffers=0
let g:jedi#smart_auto_mappings=0

" airline
" https://github.com/vim-airline/vim-airline#smarter-tab-line
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#formatter='unique_tail' " 
let g:airline_theme='bubblegum'
let g:airline_section_b = '%{strftime("%a %H:%M:%S %Y-%m-%d")}'
set laststatus=2                " turn on bottom bar
