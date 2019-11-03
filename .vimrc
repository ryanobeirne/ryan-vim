let g:ale_completion_enabled = 1
execute pathogen#infect()

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
call plug#end()

filetype plugin indent on

set updatetime=100
set number cursorline hlsearch incsearch linebreak
syntax on
set smartindent autoindent tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase
set clipboard=unnamed
let mapleader="-"
set tabpagemax=100
set mouse=a
set guifont=Source\ Code\ Pro\ Medium\ 12
set undodir=~/.vimundodir
set undofile
set scrolloff=5
"set relativenumber

set wildmenu
set wildmode=longest,list

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set completeopt+=preview
set completeopt+=menuone
set completeopt+=longest
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

autocmd BufNew,BufRead *.sh :inoremap <expr> <Tab> pumvisible() ? "\<C-x><C-f>" : "\<Tab>"
autocmd BufNew,BufRead *.sh :inoremap <expr> <S-Tab> pumvisible() ? "\<C-x><C-f>" : "\<S-Tab>"

" refresh the completion list
imap <C-space> <Plug>(asyncomplete_force_refresh)
nnoremap <leader><leader> :LspHover<CR>
nnoremap <F2> :LspRename<CR>

" Keybindings
"" Line navigation
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
nnoremap <C-a> 0
nnoremap <C-e> $
"" Tab navigation
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <C-k> :tabfirst<CR>
nnoremap <C-j> :tablast<CR>
"" Buffer navigation
nnoremap <M-h> :bprev<CR>
nnoremap <M-Left> :bprev<CR>
nnoremap <M-l> :bnext<CR>
nnoremap <M-Right> :bnext<CR>
nnoremap <M-k> :bfirst<CR>
nnoremap <M-Up> :bfirst<CR>
nnoremap <M-j> :blast<CR>
nnoremap <M-Down> :blast<CR>


"" Select All
nnoremap <leader>a ggVG
vnoremap <leader>a <ESC>ggVG
"" Paste from system register
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P
"" Copy to system register
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
vnoremap <leader>Y "+Y
"" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"" Toggle GitGutter
nnoremap <leader>g :GitGutterToggle
"" Show/hide whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:*
nnoremap <leader>l :set list<CR>
nnoremap <leader>L :set list!<CR>

""Don't be a dummy
nnoremap U :echo "TURN CAPS LOCK OFF, DUMMY!"<CR>

" Enable crontab editing in place
au BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

" Set syntax for specific extensions
autocmd BufNewFile,BufRead *.env  set syntax=dosini ft=dosini
autocmd BufNewFile,BufRead *.ovpn set syntax=conf ft=conf
"autocmd BufNewFile,BufRead *.conf  set syntax=conf ft=conf

" Rust
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
set hidden

"if executable('racer')
	"autocmd User asyncomplete_setup call asyncomplete#register_source(
		"\ asyncomplete#sources#racer#get_source_options())
"endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

"Register ccls C++ lanuage server.
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" Latex
let g:livepreview_previewer = 'okular'

" Last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set laststatus=2
let g:lightline = {
\'colorscheme': 'twodark',
\}
let g:onedark_color_overrides = {
\ "black": {"gui": "#051421", "cterm": "NONE", "cterm16": "NONE" },
\}
colorscheme onedark
highlight CursorLine ctermbg=0
highlight Visual ctermbg=0
highlight Search cterm=NONE ctermfg=NONE ctermbg=8

" Toggle highlight.
let hlstate=0
nnoremap <leader><ESC> :if (hlstate%2 == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=hlstate+1<CR>

" Sessions
let g:session_dir = '~/.vim/sessions'
exec 'nnoremap <Leader>ss :mks! ' . g:session_dir . '/*.vim<C-D><BS><BS><BS><BS><BS>'
exec 'nnoremap <Leader>sr :so ' . g:session_dir. '/*.vim<C-D><BS><BS><BS><BS><BS>'

" vimdiff highlighting
highlight DiffAdd    cterm=bold ctermfg=NONE ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=NONE ctermbg=52 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=NONE ctermbg=235  gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=NONE ctermbg=8  gui=none guifg=bg guibg=Red

packloadall
silent! helptags ALL
