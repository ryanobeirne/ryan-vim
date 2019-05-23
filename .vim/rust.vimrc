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

nmap gd <Plug>(rust-def)
nmap gs <Plug>(rust-def-split)
nmap gx <Plug>(rust-def-vertical)
nmap <leader>gd <Plug>(rust-doc)
