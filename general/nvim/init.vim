set nocompatible " be iMproved, required
filetype off     " required

" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
filetype plugin indent on

"splitline
set fillchars=vert:│

" Override color scheme to make split the same color as tmux's default
autocmd ColorScheme *
  \ highlight VertSplit cterm=NONE ctermfg=Green ctermbg=NONE |
  \ highlight SignColumn ctermbg=0 |
  \ highlight SignifyLineAdd ctermfg=10 ctermbg=0 |
  \ highlight SignifySignAdd ctermfg=10 ctermbg=0 |
  \ highlight SignifyLineChange ctermfg=11 ctermbg=0 |
  \ highlight SignifyLineChangeDelete ctermfg=11 ctermbg=0 |
  \ highlight SignifySignChange ctermfg=11 ctermbg=0 |
  \ highlight SignifySignChangeDelete ctermfg=11 ctermbg=0 |
  \ highlight SignifyLineDelete ctermfg=9 ctermbg=0 |
  \ highlight SignifyLineDeleteFirstLine ctermfg=9 ctermbg=0 |
  \ highlight SignifySignDelete ctermfg=9 ctermbg=0 |
  \ highlight SignifySignDeleteFirstLine ctermfg=9 ctermbg=0


set backspace=indent,eol,start

set encoding=utf8
set showcmd
set incsearch
set expandtab
set tabstop=2
set shiftwidth=2
set hlsearch
set ic
set autoindent
set cmdheight=1
set laststatus=2
set nowrap
set virtualedit=onemore
set updatetime=250
set signcolumn=auto:1
set t_Co=256

" Relative numbers
set number relativenumber

syntax enable

set nobackup
set noswapfile
set showmatch

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plug')
" Language specifics
" Plug 'yuezk/vim-js'
" Plug 'maxmellon/vim-jsx-pretty'
" Plug 'peitalin/vim-jsx-typescript'
" Plug 'leafgarland/typescript-vim' " TypeScript syntax
"

" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" Buffer managment
Plug 'moll/vim-bbye', {'branch': 'master'}

" NerdTREE (Files)
Plug 'preservim/nerdtree' " NerdTREE
" Tree dev icons
Plug 'ryanoasis/vim-devicons'
Plug 'vwxyutarooo/nerdtree-devicons-syntax'

" Comment plugin
Plug 'preservim/nerdcommenter' "NerdCommenter

" Find in files
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Autocomplete
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim'

" Git
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
Plug 'tpope/vim-fugitive'
call plug#end()

" =======================
"   ESLint plugin
" =======================
" Set ESLint as your plugging manager
let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }

" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️'
" Add the config to fix the file your are working on on save
let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" =======================
"        Airline
" =======================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'kolor'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" ====================
"     Air line
" ====================
"unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" " airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" =======================
"        NERDTree
" =======================
" autocmd vimenter * NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" =======================
"        Theme
" =======================
colorscheme monokai

" ======================
"    General Settings
" ======================

" Clipboard
set undofile
set undodir=$HOME/.config/nvim/undo

set undolevels=10000
set undoreload=10000
set hidden

" ======================
"     Keybindings
" ======================
let mapleader = "\<Space>"

" Buffers
" Mappings to access buffers (don't use "\p" because a
" delay before pressing "p" would accidentally paste).
" \l       : list buffers
" \b \f \g : go back/forward/last-used
" \1 \2 \3 : go to buffer 1/2/3 etc
nnoremap <Leader>g :e#<CR>

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

nnoremap <Leader>p :Files<CR>
nnoremap <Leader>f :Rg<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>d :Bdelete<CR>

" Split buffer vertically
nnoremap <Leader>v :vsp <bar> :bn<CR>
nnoremap <Leader>h :sp <bar> :bn<CR>

nmap <Leader>b :NERDTreeToggle<CR>

" Buffer next and prev
nnoremap <C-S-tab> :bp<CR>
nnoremap <C-tab>   :bn<CR>
nmap <C-x> :bd<CR>

" Split buffer navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
