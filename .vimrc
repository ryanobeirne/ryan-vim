execute pathogen#infect()

filetype plugin indent on

set updatetime=100
set number cursorline
syntax on
set smartindent autoindent tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set ignorecase smartcase
let mapleader="-"
set hls
set tabpagemax=100
set mouse=a
set backspace=indent,eol,start
set showtabline=2 " Always show tabline
set undodir=~/.vimundodir
set undofile
set scrolloff=5
set relativenumber

" Rust racer
set hidden
let g:racer_cmd = "/Users/Spoonflower/.cargo/bin/racer"
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Aliases
cnoreabbrev git !git
cnoreabbrev mkdir !mkdir
cnoreabbrev cargo !cargo
cnoreabbrev rename Rename
cnoreabbrev vimposter !vimposter

" Keybindings
"" Line navigation
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
nnoremap <C-a> 0
nnoremap <C-e> $
"" Omnicompletion
inoremap <C-<leader>> <C-x><C-o>
"" Tab navigation
nnoremap <C-l> :tabnext<CR>
nnoremap <leader><C-l> :+tabmove<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <leader><C-h> :-tabmove<CR>
nnoremap <C-k> :tabfirst<CR>
nnoremap <leader><C-k> :0tabmove<CR>
nnoremap <C-j> :tablast<CR>
nnoremap <leader><C-j> :$tabmove<CR>
"" Show/Hide NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"" Toggle GitGutter
nnoremap <leader>g :GitGutterToggle<CR>
"" Upcase/Downcase
nnoremap <leader>U viwU
nnoremap <leader>u viwu
"" Select All
nnoremap <leader>a ggVG
vnoremap <leader>a <ESC>ggVG
"" Paste from system register
nnoremap <leader>p "*p
nnoremap <leader>P "*P
vnoremap <leader>p "*p
vnoremap <leader>P "*P
"" Copy to system register
nnoremap <leader>y "*y
nnoremap <leader>Y "*Y
vnoremap <leader>y "*y
vnoremap <leader>Y "*Y
"" Show/hide whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:*
nnoremap <leader>l :set list<CR>
nnoremap <leader>L :set list!<CR>

" Enable crontab editing in place
autocmd BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

" Set syntax for specific extensions
autocmd BufNewFile,BufRead *.env  set syntax=dosini
if (&ft=='mail')
    set spell
endif

" Last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Color scheme
set laststatus=2
let g:lightline = {
\'colorscheme': 'twodark',
\}
let g:onedark_color_overrides = {
\ "black": {"gui": "NONE", "cterm": "NONE", "cterm16": "NONE" },
\}
colorscheme onedark
highlight Search cterm=NONE ctermfg=NONE ctermbg=8
highlight CursorLine ctermbg=0

" Toggle highlight.
let hlstate=0
nnoremap <leader><ESC> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<cr>

highlight DiffAdd    cterm=bold ctermfg=NONE ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=NONE ctermbg=52 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=NONE ctermbg=235  gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=NONE ctermbg=8  gui=none guifg=bg guibg=Red
