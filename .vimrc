" =============================================================================
" Basic UI and Usability
" =============================================================================

" Set the default encoding to UTF-8
set encoding=utf-8

" Enable syntax highlighting
syntax on

" Show line numbers
set number

" Show relative line numbers (great for movements like 10j or 5k)
" This shows the current line number as absolute, and all others relative to it.
"set relativenumber

" Always show the status line at the bottom
set laststatus=2

" Show the cursor's position in the status line
set ruler

" Don't wrap lines by default. Long lines will scroll horizontally.
set nowrap

" When a line does wrap, do it at word boundaries instead of mid-word
set linebreak

" Height of the command bar
set cmdheight=1

" A buffer can be hidden, but not abandoned. Useful for multi-file editing.
set hidden


" =============================================================================
" Searching
" =============================================================================

" Highlight search results
set hlsearch

" Incrementally highlight search matches as you type
set incsearch

" Ignore case when searching...
set ignorecase

" ...unless your search pattern contains an uppercase letter
set smartcase


" =============================================================================
" Indentation and Tabs
" =============================================================================
" Use 4 spaces for a tab. Set this to 2 if you prefer.
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Use spaces instead of actual tab characters
set expandtab

" Enable smart auto-indenting
set autoindent
set smartindent


" =============================================================================
" File, Swap, and Backup Handling
" =============================================================================
" Keep swap, backup, and undo files in a central location to avoid
" cluttering your project directories.
" First, create these directories in your terminal:
" mkdir -p ~/.vim/swap ~/.vim/backup ~/.vim/undo

set undofile          " Persist undo history between sessions
set backupdir=~/.vim/backup
set directory=~/.vim/swap
set undodir=~/.vim/undo

" Turn off creating backup files if you don't want them
set nobackup
set nowritebackup


" =============================================================================
" Quality of Life Mappings and Commands
" =============================================================================

" The "Leader" key is a customizable key for your own shortcuts.
" It's often mapped to space or comma. Let's use space.
let mapleader = " "

" Clear search highlighting by pressing <leader> and then space
nnoremap <leader><space> :nohlsearch<CR>

" --- The CORRECT way to handle pasting ---
" Toggle paste mode with a single key press (e.g., F2).
" When you want to paste, press F2, paste your code (with Ctrl+Shift+V or Cmd+V),
" and then press F2 again to turn paste mode off.
set pastetoggle=<F2>

" Faster window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" =============================================================================
" Plugin Section using vim-plug
" =============================================================================
call plug#begin('~/.vim/plugged')

" A nice colorscheme
Plug 'morhetz/gruvbox'

" A lightweight status line
Plug 'vim-airline/vim-airline'

" File explorer tree
Plug 'preservim/nerdtree'

" Fuzzy file finder (requires fzf to be installed: sudo apt install fzf)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" --- Plugin Configuration ---
" Set the colorscheme after the plugin section
colorscheme gruvbox
set background=dark