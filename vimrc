execute pathogen#infect()

filetype plugin indent on
syntax on
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

syntax enable
syntax on
set list
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set listchars=tab:->,trail:~,extends:>,precedes:<
colorscheme shades_of_purple
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
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
