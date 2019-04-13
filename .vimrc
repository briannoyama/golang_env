call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'jodosha/vim-godebug'
Plug 'fatih/molokai'
Plug 'ctrlpvim/ctrlp.vim'
" Creates a source code navigation bar.
" Plug 'majutsushi/tagbar' Not sure if I actually want this...
" Status line at bottom of vim.
Plug 'vim-airline/vim-airline'

" For showing lines with errors
" Plug 'w0rp/ale' Electing against this for now doesn't seem worth it.

" Autocomplete
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}

" For a file tree
Plug 'scrooloose/nerdtree'

call plug#end()

set autowrite
set showcmd

" runs :GoBuild or :GoTestCompile based on file name ending with "_test.go" or ".go"
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

let g:go_fmt_command = "goimports"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_build_constraints = 1
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2

let g:rehash256 = 1
let g:molokai_original = 1
colorscheme molokai

let g:go_metalinter_autosave = 1

autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

autocmd FileType go nmap <Leader>i <Plug>(go-info)

let g:go_auto_sameids = 1

" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'

" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

autocmd FileType go nmap <leader>gt :GoDeclsDir<cr>

let g:go_auto_type_info = 1

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = '/root/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" Use this if you need for c completion with c go.
" g:deoplete#sources#go#cgo

let g:airline#extensions#tabline#enabled = 1

" Auto open and close if nerd tree is the only open pane
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Copy and paste from same clipboard as OS
set clipboard=unnamed
"Turn on mouse
set mouse=a
"Make backspace normal
set bs=2

"Move through split screens easier.
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"Move through tabs easier.
map <c-,> :tabprevious<CR>
map <c-.> :tabnext<CR>

"Indent more easily
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

"Highlight extra spaces as red.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/

"Line numbers, width of document
set number
set tw=79
set nowrap
set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=233

"numbers for help
autocmd FileType help setlocal number

"More history
set history=512
set undolevels=512

"Search options
set hlsearch
set incsearch
