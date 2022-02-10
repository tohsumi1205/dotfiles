nnoremap <C-p> :<C-u>FZF<CR>
let g:mapleader=","

source ~/dotfiles/plugins.vim

"---------------------
" Basic editing config
"---------------------
syntax on					" turn on syntax highlighting
filetype plugin indent on	" detection:ON  plugin:ON  indent:ON
set autoindent				" copy indent from current line when starting a new line
set tabstop=4				" <Tab> size is equal to 4 spaces
set shiftwidth=4
set backspace=indent,eol,start " allow backspacing over everything
set laststatus=2
set shortmess+=I		" avoid the intro message on startup
set nu					" number lines
set rnu					" relative line numbering
set incsearch			" incremental search (as string is being typed so far)
set hls					" highlight search
set showmatch			" show matching braces when text indicator is over them
set ignorecase			" case of normal letters is ignored
set matchtime=1			" match 0.1 sec
set splitbelow			" open new split panes to bottom
set splitright			" and right, which feels more natural
set display=lastline	" show long line text
set nofoldenable		" disable folding
set noerrorbells visualbell t_vb= " disable audible bell
set history=10000		" more history
set hidden				" allow auto-hiding of edited buffers 
set nojoinspaces		" inserting one spaces between sentences
set list lcs=tab:\¦\    " set list to see tabs


""" tab config {{{

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'

" tabline pop up only when there are more than one tab {{{
function! s:tabstatus()
	if tabpagenr('$') > 1
		set showtabline=2
	else
		set showtabline=1
	endif
endfunction

augroup tab_status
	autocmd!
	autocmd TabLeave,TabEnter,TabClosed * call s:tabstatus()
augroup END
" }}}

" key binds related to tab {{{
" prefix
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" jump to n-th tab by t(1..9)
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]c :tablast <bar> tabnew<CR> " create a new tab on the far right
map <silent> [Tag]x :tabclose<CR> " close tab
" }}}

""" }}}

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END



" Windows movement.
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" increment setting
nnoremap + <C-a>
nnoremap - <C-x>

" Cursor movement.
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <Up> gk
noremap <Down> gj

" key binding
nnoremap Y y$ " consistent with D for dd, C cc

" unbind key
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

"--------------
" Plugin config
"--------------

" For JavaScript files, use `eslint` (and only eslint)
let g:ale_linters = {
\   'javascript': ['eslint'],
\ }

" Mappings in the style of unimpaired-next
nmap <silent> [W <Plug>(ale_first)
nmap <silent> [w <Plug>(ale_previous)
nmap <silent> ]w <Plug>(ale_next)
nmap <silent> ]W <Plug>(ale_last)

" ALE run linters only when invoked it by hand.
nnoremap <Leader>l :ALELint<CR>
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0


" configure Grepper
let g:grepper       = {}
let g:grepper.tools = ['rg', 'grep']

" Search for the current word
nnoremap <Leader>* :Grepper -cword -noprompt<CR>

" Search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)


" set undodir and undo file
set undofile
if !has('nvim')
	if !isdirectory(expand("$HOME/.vim/undodir"))
		call mkdir(expand("$HOME/.vim/undodir"), "p")
	endif
endif
set undodir=$HOME/.vim/undodir

augroup configure_projects
  autocmd!
  autocmd User ProjectionistActivate call s:linters()
augroup END

function! s:linters() abort
  let l:linters = projectionist#query('linters')
  if len(l:linters) > 0
    let b:ale_linters = {&filetype: l:linters[0][1]}
  endif
endfunction

" vim-lsp
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:lsp_diagnostics_enabled = 0         " disable diagnostics support

" gruvbox
augroup color_scheme
	autocmd!
	autocmd vimenter * ++nested colorscheme gruvbox
augroup END
set bg=dark

" kien/rainbow_parentheses.vim
augroup parenthes
	autocmd VimEnter * RainbowParenthesesToggle
	autocmd Syntax * RainbowParenthesesLoadRound
	autocmd Syntax * RainbowParenthesesLoadSquare
	autocmd Syntax * RainbowParenthesesLoadBraces
augroup END

" fzf.vim
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>b :Buffers<CR>


let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
	source $LOCALFILE
endif
