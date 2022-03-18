
" Startup {{{
" https://github.com/rhysd/dogfiles/blob/master/vimrc
augroup MyVimrc
  autocmd!
augroup END

command! -nargs=* Autocmd autocmd MyVimrc <args>
command! -nargs=* AutocmdFT autocmd MyVimrc FileType <args>
function! s:hl_my_autocmd()
  highlight def link myVimAutocmd vimAutoCmd
  syntax match vimAutoCmd /\<\(Autocmd\|AutocmdFT\)\>/
  syntax keyword myVimAutocmd Autocmd skipwhite nextgroup=vimAutoEventList
endfunction
Autocmd BufWinEnter,ColorScheme *vimrc call s:hl_my_autocmd()

" source vimrc file after saving it
Autocmd BufWritePost *vimrc source $MYVIMRC

" echo startup time on start {{{
if has('vim_starting') && has('reltime')
  " Shell: vim --startuptime filename -q; vim filename
  " vim --cmd 'profile start profile.txt' --cmd 'profile file $HOME/.vimrc' +q && vim profile.txt
  let g:startuptime = reltime()
  Autocmd VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
  \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
endif
" }}}
" }}}

" Plugins {{{
" load minpac on demand and show error message if needed.
function! PackInit() abort
  packadd minpac
  if !exists('g:loaded_minpac')
    echoerr 'minpac installation has failed!'
    finish
  else
    call minpac#init({'verbose': 0, 'progress_open': 'none'})

    " minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
    " by doing so, minpac is loaded before .vimrc is sourced and
    " plugins installed under ~/.vim/pack/minpac/start/ are automatically added to the 'runtimepath'.
    call minpac#add('k-tanaka/minpac', {'type': 'opt'})

    call minpac#add('tpope/vim-unimpaired')
    call minpac#add('junegunn/fzf')
    call minpac#add('junegunn/fzf.vim')
    call minpac#add('tpope/vim-obsession')
    call minpac#add('tpope/vim-commentary')
    call minpac#add('tpope/vim-projectionist')
    call minpac#add('tpope/vim-dispatch')
    call minpac#add('w0rp/ale')
    call minpac#add('mhinz/vim-grepper')
    call minpac#add('janko-m/vim-test')
    call minpac#add('sgur/vim-editorconfig')
    call minpac#add('mhinz/vim-startify')
    call minpac#add('haya14busa/incsearch.vim')
    call minpac#add('easymotion/vim-easymotion')
    call minpac#add('tpope/vim-surround')
    call minpac#add('airblade/vim-gitgutter')
    call minpac#add('simeji/winresizer')
    call minpac#add('kana/vim-textobj-entire')
    call minpac#add('kana/vim-textobj-user')

    " python {{{
    " enable handle .ipynb file like .py file
    call minpac#add('goerz/jupytext.vim')
    " make vim talk to jupyter kernels
    call minpac#add('jupyter-vim/jupyter-vim')
    " }}}

    " tmux {{{
    call minpac#add('christoomey/vim-tmux-navigator')
    " }}}

    " color scheme {{{
    call minpac#add('morhetz/gruvbox')
    call minpac#add('kien/rainbow_parentheses.vim')
    call minpac#add('itchyny/lightline.vim')
    " }}}

    " lsp {{{
    call minpac#add('prabirshrestha/vim-lsp')
    call minpac#add('mattn/vim-lsp-settings')
    call minpac#add('prabirshrestha/asyncomplete.vim')
    call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
    " }}}

    " 42 {{{
    call minpac#add('pbondoer/vim-42header')
    " }}}

    silent! helptags ALL
  endif
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean  source $MYVIMRC | call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

" }}}

" Basic editing config {{{
syntax on " turn on syntax highlighting
filetype plugin indent on " detection:ON  plugin:ON  indent:ON
set autoindent " copy indent from current line when starting a new line
set backspace=indent,eol,start " allow backspacing over everything
set laststatus=2 " always a status line
set nu " number lines
set rnu " relative line numbering
set showmatch " show matching braces when text indicator is over them
set matchtime=1 " match 0.1 sec
set display=lastline " show long line text
set nofoldenable " disable folding
set noerrorbells visualbell t_vb= " disable audible bell
set history=10000 " more history
set hidden " allow auto-hiding of edited buffers
set nojoinspaces " inserting one spaces between sentences
set wildmenu " command-line autocompletion on
set wildmode=list:longest,full " show all the options
set keywordprg=:help " open vim internal help by K command
set updatetime=100 " update more frequently
set modeline " enable load mode
set wrap " Lines longer than the width of the window will wrap

" spell check {{{
set spelllang=en,cjk " spell checking language
nnoremap <space>s :<C-u>setl spell! spell?<CR>

" underline the word which is not recognized by the spellchecker {{{
function! MyHighlights() abort
   highlight SpellBad ctermbg=RED ctermfg=BLACK
endfunction

Autocmd ColorScheme * call MyHighlights()
" }}}

" }}}

" <Tab> size is equal to 4 spaces {{{
set tabstop=4
set softtabstop=4
set shiftwidth=4
" }}}

" show invisibles {{{
set list
set listchars=tab:\¦\    " set list to see tabs

" shortcut to rapidly toggle `set list`
nnoremap <silent> <space>l :<C-u>set list! list?<CR>
" }}}

" window split {{{
set splitbelow " open new split panes to bottom
set splitright " and right, which feels more natural
" }}}

" search config {{{
set ignorecase " case of normal letters is ignored
set smartcase  " unless the search pattern contains upper cases
set incsearch  " incremental search (as string is being typed so far)
set hlsearch   " highlight search
" }}}

" highlight current line, but only in active window {{{
Autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
Autocmd WinLeave * setlocal nocursorline
" }}}

" keep state vim function {{{
function! s:preserve(command)
  let l:_s=@/
  let l:pos = winsaveview()
  silent! execute a:command
  let @/=l:_s
  call winrestview(l:pos)
endfunction
" }}}

" highlight or remove eol whitespaces {{{
" highlight {{{
function! s:hl_trailing_spaces()
  highlight! link TrailingSpaces Error
  syntax match TrailingSpaces containedin=ALL /\s\+$/
endfunction

Autocmd BufWinEnter,InsertLeave * call s:hl_trailing_spaces()
" }}}

" remove
nmap <space>$ :<c-u>call <SID>preserve("%s/\\s\\+$//ge")<cr>
" }}}

" format entire buffer {{{
nmap <space>= :<c-u>call <SID>preserve("normal gg=G")<cr>
" }}}

" change current directory {{{
" https://vim-jp.org/vim-users-jp/2009/09/08/Hack-69.html
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
  if a:directory == ''
    lcd %:p:h
  else
    execute 'lcd' . a:directory
  endif

  if a:bang == ''
    pwd
  endif
endfunction

nnoremap <silent> <Space>cd :<C-u>CD<CR>
"}}}

" restore last cursor position when open a file {{{
Autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" }}}

" }}}

" tab configuration {{{

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

" tabline pop up only when there are more than one tab
set showtabline=1

" key binds related to tab {{{
" prefix
nnoremap    [Tag]   <Nop>
nmap    t [Tag]

" jump to n-th tab by t(1..9) {{{
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" }}}

map <silent> [Tag]n :tablast <bar> tabnew<CR> " create a new tab on the far right
map <silent> [Tag]x :tabclose<CR> " close tab

" create new tab with a current open buffer (tm command in normal mode) {{{
nnoremap <silent> tm :<C-u>call <SID>MoveToNewTab()<CR>
function! s:MoveToNewTab()
  tab split
  tabprevious

  if winnr('$') > 1
    close
  elseif bufnr('$') > 1
    buffer #
  endif

  tabnext
endfunction
" }}}
" }}}
" }}}

" Misc configuration {{{

" Windows movement. {{{
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>
" }}}

" movement between terminal and vim {{{
tnoremap <c-j> <c-w><c-j>
tnoremap <c-k> <c-w><c-k>
tnoremap <c-l> <c-w><c-l>
tnoremap <c-h> <c-w><c-h>
" }}}

" Cursor movement. {{{
noremap <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <expr> k (v:count == 0 ? 'gk' : 'k')
noremap <Up> gk
noremap <Down> gj
" }}}

" increment setting {{{
nnoremap + <C-a>
nnoremap - <C-x>
" }}}

" key binding {{{
nnoremap Y y$ " consistent with D for dd, C cc
nnoremap gV `[v`] " visually select the text that was last edited
" }}}

" unbind key {{{
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>
" }}}

" set undodir and undo file {{{
set undofile
if !has('nvim')
  if !isdirectory(expand("$HOME/.vim/undodir"))
    call mkdir(expand("$HOME/.vim/undodir"), "p")
  endif
endif
set undodir=$HOME/.vim/undodir
" }}}
" }}}

" File type configuration {{{
" spell check in git commit
AutocmdFT gitcommit setlocal spell nofoldenable
AutocmdFT help      nnoremap <buffer> q ZZ
"}}}

" Plugin configuration {{{
let g:mapleader=","

" netrw {{{
let g:netrw_banner = 0 " disable show banner
let g:netrw_liststyle = 3 " show directory in tree style
let g:netrw_winsize = 30 " size 30%
" }}}

if !empty(system('ls ~/.vim/pack/minpac/start/'))
  " For JavaScript files, use `eslint` (and only eslint)
  let g:ale_linters = {
        \   'javascript': ['eslint'],
        \ }

  " Mappings in the style of unimpaired-next
  nmap <silent> [W <Plug>(ale_first)
  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> ]W <Plug>(ale_last)

  " ALE run linters only when invoked it by hand. {{{
  " nnoremap <Leader>l :ALELint<CR>
  " let g:ale_lint_on_text_changed = 'never'
  " let g:ale_lint_on_insert_leave = 0
  " let g:ale_lint_on_save = 0
  " let g:ale_lint_on_enter = 0
  " let g:ale_lint_on_filetype_changed = 0
  " }}}

  " ALE run automatically {{{
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_filetype_changed = 1
  " }}}

  " configure Grepper {{{
  let g:grepper       = {}
  let g:grepper.tools = ['rg', 'grep']

  " Search for the current word
  nnoremap <Leader>* :Grepper -cword -noprompt<CR>

  " Search for the current selection
  nmap gs <plug>(GrepperOperator)
  xmap gs <plug>(GrepperOperator)
  " }}}

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

  " tpope/vim-unimpaired {{{
  nmap <C-Up> [e
  nmap <C-Down> ]e
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  " }}}

  " prabirshrestha/vim-lsp {{{
  inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
  inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
  let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
  " }}}

  " morhetz/gruvbox {{{
  Autocmd vimenter * nested colorscheme gruvbox
  set bg=dark
  " }}}

  " kien/rainbow_parentheses.vim {{{
  Autocmd VimEnter * RainbowParenthesesToggle
  Autocmd Syntax * RainbowParenthesesLoadRound
  Autocmd Syntax * RainbowParenthesesLoadSquare
  Autocmd Syntax * RainbowParenthesesLoadBraces
  " }}}

  " junegunn/fzf.vim {{{
  nnoremap <C-p> :<C-u>FZF<CR>
  nnoremap <silent> <leader>f :Files<CR>
  nnoremap <silent> <leader>h :History<CR>
  nnoremap <silent> <leader>b :Buffers<CR>
  " }}}

  " haya14busa/incsearch.vim {{{
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)
  let g:incsearch#auto_nohlsearch = 1
  map n  <Plug>(incsearch-nohl-n)
  map N  <Plug>(incsearch-nohl-N)
  map *  <Plug>(incsearch-nohl-*)
  map #  <Plug>(incsearch-nohl-#)
  map g* <Plug>(incsearch-nohl-g*)
  map g# <Plug>(incsearch-nohl-g#)
  " }}}

  " itchyny/lightline.vim {{{
  let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ }
  " }}}

  " simeji/winresizer {{{
  let g:winresizer_vert_resize=2
  let g:winresizer_horiz_resize=1
  " }}}

  " goerz/jupytext.vim {{{
  " convert to python file
  let g:jupytext_fmt = 'py:percent'
  let g:jupytext_filetype_map = {'py': 'python'}
  " }}}
endif

" }}}

" if there is local config, then load it {{{
let $LOCALFILE=expand("~/.vimrc_local")
if filereadable($LOCALFILE)
  source $LOCALFILE
endif
" }}}

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
