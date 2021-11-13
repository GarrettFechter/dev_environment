filetype plugin indent on

set hidden

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-obsession'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'github/copilot.vim'

Plug 'christoomey/vim-tmux-navigator'
Plug 'alexghergh/nvim-tmux-navigation'
call plug#end()

" lsp server
nnoremap <C-p> :LspPeekDefinition<CR>
nnoremap <C-]> :LspDefinition<CR>

function! GoToDefinition()
    redir => found
    silent execute 'LspDefinition'
    silent execute 'sleep 400m'
    redir END

    if stridx(found, "No definition") > -1
        call feedkeys(":tag ")
        call feedkeys("\<C-R>")
        call feedkeys("\<C-W>")
        call feedkeys("\<CR>")
    endif
endfunction
"nnoremap <C-]> :call GoToDefinition()<CR>

" autosave
" autocmd TextChanged,TextChangedI <buffer> silent write

" asyncomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always '
            \ . <q-args>, 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
cnoreabbrev rg Rg

command! -bang -nargs=* Lrg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --with-filename '
            \ . <q-args> . ' ' . expand('%'), 1,
            \   <bang>0 ? fzf#vim#with_preview('up:60%')
            \           : fzf#vim#with_preview('right:50%:hidden', '?'),
            \   <bang>0)
cnoreabbrev lrg Lrg

set nocompatible
set history=10000 " remember 10000 commands
set tabstop=4 " num of spaces for each <Tab>
set softtabstop=4 " use # of spaces for <Tab> insertion
set shiftwidth=4
set autoindent
set laststatus=2 " always display status bar
set showmatch " briefly match closing brace
set incsearch " incremental search highlight
nnoremap <Space> :set hlsearch!<enter>
set hlsearch

set autoread
set number
set ruler
set backspace=eol,start,indent " backspace over everything in insert
set whichwrap+=<,>,h,l
set smartcase
set cursorline " highlight cursor line
" dont clobber scrollback after opening and closing vim  http://www.shallowsky.com/linux/noaltscreen.html
" set t_ti= t_te=
set scrolloff=5 " context to keep when going up/down

" settings from python dev
set clipboard=unnamed " use system clipboard (PRIMARY) by default
set cc=80

syntax on
syntax enable
set list
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set listchars=tab:->,trail:~,extends:>,precedes:<
colorscheme lucius
set background=dark
set tags=./tags;/

" multipurpose TAB from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col
        return "\<tab>"
    endif

    let char = getline('.')[col - 1]
    if char =~ '\k'
        " There's an identifier before
        " the cursor, so complete the
        " identifier.
        return "\<c-p>"
    else
        return "\<tab>"
    endif
endfunction
"noremap <expr> <tab> InsertTabWrapper()
"inoremap <s-tab> <c-n>

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal g`\"" |
            \ endif

set foldmethod=syntax
au BufRead * normal zR

hi StatusLine ctermfg=255 ctermbg=0

"augroup remember_folds
"   autocmd!
" autocmd BufWinLeave ?* mkview | filetype detect
" autocmd BufWinEnter ?* silent loadview | filetype detect
"augroup END
