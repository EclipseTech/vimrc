"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle (vim set-up to work without vundle installed)
set nocompatible "required by vundle
if executable('git') && !isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/Vundle.vim
    let s:setupvundle=1
endif
if isdirectory(expand("~/.vim/bundle/Vundle.vim"))
    set rtp+=~/.vim/bundle/Vundle.vim/
    filetype off "off reqiured by Vundle
    call vundle#begin()
    Plugin 'gmarik/vundle'
    " Plugins
    Plugin 'bartman/git-wip'          " commit to git on save (git log wip/<branch>)
    Plugin 'bling/vim-airline'        " status line
    Plugin 'davidhalter/jedi-vim'     " Python autocompletion
    Plugin 'ervandew/supertab'        " Tab completion
    Plugin 'kien/ctrlp.vim'           " ctrl+p to easy open files from current directory
    Plugin 'nvie/vim-flake8'          " flake8 vim integration
    Plugin 'Raimondi/YAIFA'           " Yet Another Indent Finder, Almost
    Plugin 'rosenfeld/conque-term'    " Vim command line integration (ConqueTerm bash)
    Plugin 'scrooloose/nerdcommenter' " Easy commenting
    Plugin 'scrooloose/nerdtree'      " Filesystem browser
    Plugin 'scrooloose/syntastic'     " Syntax checking
    Plugin 'tpope/vim-fugitive'       " Vim git wrapper
    Plugin 'tpope/vim-repeat'         " Use . to repeat in plugin context (needed for vim-surround)
    Plugin 'tpope/vim-surround'       " Surround sections in parens, brackets, quotes, XML tags, and more
    "Plugin 'Valloric/YouCompleteMe'  " Auto-completion
    " Colors
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'desert256.vim'
    Plugin 'Lokaltog/vim-distinguished'
    Plugin 'nanotech/jellybeans.vim'
    Plugin 'tpope/vim-vividchalk'
    call vundle#end()
    filetype plugin on
    filetype plugin indent on
    " This automatically installs plugins on first time vim setup
    " to install plugins manually run $vim +PluginInstall +qa
    if exists('s:setupvundle') && s:setupvundle
        unlet s:setupvundle
        PluginInstall
        quitall " Close the bundle install window.
    endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " plugin mappings
    nmap <F4> :SyntasticToggleMode<LF>
    nmap <F5> :NERDTreeToggle<LF>

    " git-wip plugin
    so ~/.vim/bundle/git-wip/vim/plugin/git-wip.vim

    " Jedi
    let g:jedi#use_splits_not_buffers = "right"

    " SuperTab
    let g:SuperTabDefaultCompletionType = "<c-n>"

    " airline plugin
    set laststatus=2
    set ttimeoutlen=50
    set timeoutlen=5000
    set noshowmode
    let g:bufferline_echo = 0
    let g:airline_powerline_fonts = 1
    let g:Powerline_symbols = "fancy"
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif
    let g:airline_symbols.space = "\ua0"
    "set guifont=MyFont\ for\ Powerline

    " syntastic
    let g:syntastic_python_checkers=['pylint', 'pyflakes', 'python', 'flake8']
    let g:syntastic_mode_map = { 'mode': 'passive',
                               \ 'active_filetypes': [],
                               \ 'passive_filetypes': [] }
    let g:syntastic_warning_symbol="⚠"
    let g:syntastic_error_symbol="✗"
    let g:syntastic_enable_signs=1

    " vim-flake8
    "let g:flake8_ignore=""
    "let g:flake8_max_line_length=80
    "autocmd BufWritePost *.py call Flake8() " run flake8 on python file on write
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=1000000

" tell it to use an undo file
set undofile
" set a directory to store the undo history
if !isdirectory(expand("~/.vim/undo/"))
    silent !mkdir -p ~/.vim/undo/ >/dev/null 2>&1
endif
set undodir=~/.vim/undo/

" don't try to be compatible with vi
set nocompatible

" don't backup with ~ files
set nobackup
" don't use swapfiles .swp
set noswapfile

" :shell will bring up bash shell
set shell=bash

" set defualt file encoding
set encoding=utf-8

" Set to auto read when a file is changed from the outside
set autoread

" For regular expressions turn magic on
set magic

" map leader from \ to ,
let mapleader=','
let maplocalleader='\'

" Yanks go on clipboard if clipboard is enabled
set clipboard+=unnamed
set clipboard+=unnamedplus

" Open new split below or vsplit right
set splitbelow
set splitright

" set paste mode to F2
set pastetoggle=<F2>

" Tab completion for command-line mode
set wildmode=longest,list,full
set wildmenu

" Enable mouse support in normal mode
set mouse=n

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab shebash #!/bin/bash
iab [bash] #!/usr/bin/env bash
iab shepython #!/usr/local/bin/python
iab [python] #!/usr/bin/env python
iab #t <C-V><C-I>
iab teh the

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Navigation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allows moving beyond eol
set virtualedit=all

" buffer navigation alt+1 previous alt+2 next
nmap <esc>1 :N<CR>
nmap <esc>2 :n<CR>
"nnoremap <M-1> <Esc>:N<CR>
"nnoremap <M-2> <Esc>:n<CR>

" tab navigation like firefox
nnoremap <C-S-tab> :tabprevious<LF>
nnoremap <C-tab>   :tabnext<LF>
nnoremap <C-t>     :tabnew<LF>
inoremap <C-S-tab> <Esc>:tabprevious<LF>
inoremap <C-tab>   <Esc>:tabnext<LF>
inoremap <C-t>     <Esc>:tabnew<LF>

" Source the vimrc file after saving it
"autocmd BufWritePost .vimrc source $MYVIMRC
" Fast edit the .vimrc file using ',x'
nnoremap <Leader>x :tabedit $MYVIMRC<LF>

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 256 color mode
set t_Co=256
" Enable syntax highlighting
highlight Pmenu ctermfg=2 gui=bold
highlight Pmenu ctermbg=238 gui=bold
highlight MatchParen cterm=underline ctermbg=white ctermfg=magenta
syntax enable
syntax on
highlight SpellBad cterm=underline ctermfg=darkred ctermbg=None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Better indentation
set autoindent
set smartindent
" Wrap lines
set wrap
set backspace=indent,eol,start

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set default format options
autocmd FileType * setlocal formatoptions=tcqlnj
" Formatting turn off automatic comment on o, O and enter
autocmd FileType * setlocal formatoptions-=ro

" Delete trailing whitespace on save
func! FixWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
  set ff=unix
  retab
endfunc
" Fix whitespace on these extensions
autocmd BufWrite *.py :call FixWS()
autocmd BufWrite *.xml :call FixWS()
autocmd BufWrite *.java :call FixWS()
autocmd BufWrite *.js :call FixWS()
autocmd BufWrite *.coffee :call FixWS()
" ,fs to fix whitespace on other extensions
nnoremap <Leader>fs :call FixWS()<LF>
"autocmd BufWrite *.* :call FixWS()

" xmllint formatting options for xml filetypes
autocmd FileType xml exe "let &l:equalprg='xmllint --format -'"

" Show eol whitespace in red
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

" Show tabs and trailing whitespace
set listchars=tab:▸-,trail:·,
set list

" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Highlight search results
set hlsearch
" Highlight search results while typing
"set incsearch

" Always show current position
set ruler

" Show matching brackets when text indicator is over them
set showmatch

" show line numbers
set number

