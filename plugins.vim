command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" load minpac on demand
if !exists('g:loaded_minpac')
  finish
endif

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
call minpac#add('tpope/vim-obsession')
call minpac#add('sgur/vim-editorconfig')

call minpac#add('christoomey/vim-tmux-navigator')

call minpac#add('morhetz/gruvbox')

call minpac#add('prabirshrestha/vim-lsp')
call minpac#add('mattn/vim-lsp-settings')
call minpac#add('prabirshrestha/asyncomplete.vim')
call minpac#add('prabirshrestha/asyncomplete-lsp.vim')
