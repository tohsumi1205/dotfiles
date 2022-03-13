command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" load minpac on demand {{{
if !exists('g:loaded_minpac')
  finish
endif
" }}}

packadd minpac
call minpac#init({'verbose': 0})

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

" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
