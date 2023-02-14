"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin list
" (used with Vim-plug - https://github.com/junegunn/vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/AppData/Local/nvim/plugged')

" Theme
  Plug 'joshdick/onedark.vim'																" Dark Theme

" Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

" File browser
  Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" File Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Terminal
  Plug 'voldikss/vim-floaterm'																" Float terminal

" Code intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
  Plug 'liuchengxu/vista.vim' 

" Code syntax highlight
  Plug 'jackguo380/vim-lsp-cxx-highlight'													" C/C++

" Debugging
  Plug 'puremourning/vimspector'															" Vimspector

" Source code version control 
  Plug 'tpope/vim-fugitive'																	" Git infomation 
  Plug 'tpope/vim-rhubarb' 
  Plug 'airblade/vim-gitgutter'																" Git show changes 
  Plug 'samoshkin/vim-mergetool'															" Git merge

call plug#end()
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set mouse=a 
set tabstop=4 
set shiftwidth=4
set listchars=tab:\|\        																" Tab charactor 
set list
set foldmethod=indent   
set foldlevelstart=99   
set number																					" Show line number
set encoding=UTF-8
syntax on
set ignorecase 

" Enable copying from vim to clipboard
if has('win32')
  set clipboard=unnamed  
else
  set clipboard=unnamedplus
endif

" Auto reload content changed outside
au CursorHold,CursorHoldI * checktime
au FocusGained,BufEnter * :checktime
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == ''
      \ | checktime 
    \ | endif
autocmd FileChangedShellPost *
    \ echohl WarningMsg 
    \ | echo "File changed on disk. Buffer reloaded."
    \ | echohl None

" Disable automatic comment in newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set theme 
colorscheme onedark

" Overwrite some color highlight 
if (has("autocmd"))
  augroup colorextend
    autocmd ColorScheme 
      \ * call onedark#extend_highlight("Comment",{"fg": {"gui": "#728083"}})
    autocmd ColorScheme 
      \ * call onedark#extend_highlight("LineNr", {"fg": {"gui": "#728083"}})
  augroup END
endif

"Fonts
let g:airline_powerline_fonts = 1   
if has('win32')
	set guitablabel=\[%N\]\ %t\ %M
	set guifont=FiraCode\ NFM:h11
endif

"Status bar
let g:airline_theme='onedark'                           " Theme OneDark
let g:airline#extensions#tabline#enabled = 1            " Enable Tab bar
let g:airline#extensions#tabline#left_sep = ' '         " Enable Tab seperator 
let g:airline#extensions#tabline#left_alt_sep = '|'     " Enable Tab seperator
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#fnamemod = ':t'        " Set Tab name as file name

let g:airline#extensions#whitespace#enabled = 0         " Remove warning whitespace"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
"Resize pane
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Search a hightlighted text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
nmap /\ :noh<CR>

let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1

"Extended settings
let nvim_settings_dir = '~\AppData\Local\nvim\settings\'
execute 'source '.nvim_settings_dir.'coc.vim'
execute 'source '.nvim_settings_dir.'floaterm.vim'
execute 'source '.nvim_settings_dir.'nerdtree.vim'
execute 'source '.nvim_settings_dir.'fzf.vim'
execute 'source '.nvim_settings_dir.'vista.vim'
execute 'source '.nvim_settings_dir.'git.vim'
