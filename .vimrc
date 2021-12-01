syntax on
filetype plugin indent on
set autoindent
set tabstop=4
set shiftwidth=4
set backspace=2
set laststatus=2
set showcmd
set nrformats=
let mapleader="\<space>"
set wildmenu wildmode=list:full
autocmd FileType json syntax match Comment +\/\/.\+$+
set autochdir

" Searching words.
set hlsearch
set incsearch
set ignorecase
""""""""""""""""""

" Folding.
set foldmethod=indent
autocmd BufRead * normal zR
""""""""""

" Show line numbers.
set number
set relativenumber
""""""""""""""""""""

" For plugins.
packloadall
silent! helptags ALL
""""""""""""""

" Use vim-plug.
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-commentary'

" Nerdtree """"""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
			\ b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Winresizer """"""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'simeji/winresizer'
let g:winresizer_vert_resize=2
let g:winresizer_horiz_resize=1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" coc.nvim """"""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <CR> pumvisible() ? "<C-y>" : "<CR>"
set completeopt=menuone,noinsert
inoremap <expr><C-n> pumvisible() ? "\<Down>" : "\<C-n>"
inoremap <expr><C-p> pumvisible() ? "\<Up>" : "\<C-p>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-fugitive """""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-tmux-navigator """""""""""""""""""""""""""""""""""""""""""
Plug 'christoomey/vim-tmux-navigator'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Syntastic """"""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-syntastic/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_checkers = ['avrgcc']
let g:syntastic_c_checkers = ['avrgcc']
let g:syntastic_python_checkers = ['pylint']
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" colorscheme """"""""""""""""""""""""""""""""""""""""""""""""""
Plug 'flazz/vim-colorschemes'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline """"""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_section_c = '%t'
let g:airline#extensions#default#layout = [
			\ ['a','b','c'],
			\ ['x']
			\]
let g:airline_theme = 'luna'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 42header """"""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'pbondoer/vim-42header'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


call plug#end()
"""""""""""""

" open new split panes to right and bottom
set splitbelow
set splitright

" Colors.
set background=dark
colorscheme PaperColor
"""""""""

" Windows movement.
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>
"""""""""""""""""""

" Cursor movement.
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <Up> gk
noremap <Down> gj
noremap <S-h> ^
noremap <S-l> $

" Enable undo for all files.
set undofile
if !isdirectory(expand("$HOME/.vim/undodir"))
	call mkdir(expand("$HOME/.vim/undodir"), "p")
endif
set undodir=$HOME/.vim/undodir
""""""""""""""""""""""""""""

" highlight double byte spaces
hi DoubleByteSpace term=underline ctermbg=blue guibg=darkgray
match DoubleByteSpace /　/

inoremap <c-]> <esc>A;

let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
	source $LOCALFILE
endif

