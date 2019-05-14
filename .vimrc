let g:ale_completion_enabled = 1
execute pathogen#infect()

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
call plug#end()

filetype plugin indent on

set updatetime=1000
set number cursorline hlsearch incsearch linebreak
syntax on
set smartindent autoindent tabstop=4 softtabstop=4 shiftwidth=4
set ignorecase smartcase
set clipboard=unnamed
let mapleader="-"
set tabpagemax=100
set mouse=a
set guifont=xos4\ Terminus\ 12
set undodir=~/.vimundodir
set undofile
set scrolloff=5
set relativenumber

set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"

set completeopt+=preview
set completeopt+=menuone
set completeopt+=longest
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
" refresh the completion list
imap <C-space> <Plug>(asyncomplete_force_refresh)

cnoreabbrev rename Rename
cnoreabbrev vimposter !vimposter
cnoreabbrev tabber set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab

" Keybindings
nnoremap U :echo 'Turn off your CAPS LOCK, dummy!'<CR>
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
"" Buffer Navigation
nnoremap <M-Left> :bprev<CR>
nnoremap <M-h> :bprev<CR>
nnoremap <M-Right> :bnext<CR>
nnoremap <M-l> :bnext<CR>
nnoremap <M-Up> :bfirst<CR>
nnoremap <M-k> :bfirst<CR>
nnoremap <M-Down> :blast<CR>
nnoremap <M-j> :blast<CR>
"" Window Resizing
nnoremap <leader>] :vertical resize +10<CR>
nnoremap <leader>[ :vertical resize -10<CR>
nnoremap <leader>} :resize +5<CR>
nnoremap <leader>{ :resize -5<CR>
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
"" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
"" Toggle GitGutter
nnoremap <leader>g :GitGutterToggle
"" Show/hide whitespace characters
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:*
nnoremap <leader>l :set list<CR>
nnoremap <leader>L :set list!<CR>
"" Delete trailing whitespace
nnoremap <leader>dt :%s/\s\+$//e<CR>
vnoremap <leader>dt :s/\s\+$//e<CR>
inoremap <C-d> <C-o>:s/\s\+$//e<CR>

""Don't be a dummy
nnoremap U :echo "TURN CAPS LOCK OFF, DUMMY!"<CR>

" Enable crontab editing in place
au BufNewFile,BufRead crontab.* set nobackup | set nowritebackup

" Set syntax for specific extensions
autocmd BufNewFile,BufRead *.env,*.cbp,*.cbx,*.cblindata  set syntax=dosini
autocmd BufNewFile,BufRead *.mxf,*.pxf,*.cxf set syntax=xml
if (&ft=='mail')
    set spell
endif

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
