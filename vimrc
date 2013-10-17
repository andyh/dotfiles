""
"" Thanks:
""   Gary Bernhardt  <destroyallsoftware.com>
""   Drew Neil  <vimcasts.org>
""   Tim Pope  <tbaggery.com>
""   Janus  <github.com/carlhuda/janus>
""   Mislav Marohnić <mislav.marohnic@gmail.com>

set nocompatible

set encoding=utf-8

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-rvm'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-abolish'
Bundle 'godlygeek/tabular'
Bundle 'vim-ruby/vim-ruby'
Bundle 'pangloss/vim-javascript'
Bundle 'chriseppstein/vim-haml'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'rking/ag.vim'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'skalnik/vim-vroom'
Bundle 'Gundo'
Bundle 'kurkale6ka/vim-swap'
Bundle 't9md/vim-ruby-xmpfilter'
Bundle 'UltiSnips'
Bundle 'jgdavey/vim-blockle'
Bundle 'Townk/vim-autoclose'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
Bundle 'ervandew/supertab'
Bundle 'briancollins/vim-jst'
" Bundle 'rodjek/vim-puppet'

filetype plugin indent on

runtime macros/matchit.vim

syntax enable

set number        " I like me some line numbers
if v:version >= 704
  set relativenumber  " also show relative line numbers,
                      " enabling the hybrid number mode
endif
set ruler         " show the cursor position all the time
set cursorline    " highlight the line of the cursor
set showcmd       " show partial commands below the status line
set shell=bash    " avoids munging PATH under zsh
let g:is_bash=1   " default shell syntax
set history=10000 " never forget!
set scrolloff=3   " have some context around the current line always on screen

" Allow backgrounding buffers without writing them, and remember marks/undo
" for backgrounded buffers
set hidden

" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the first column when wrap is
" off and the line continues beyond the left of the screen

"" Searching
set hlsearch                      " highlight matches
set incsearch                     " incremental searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

" Diffs
set diffopt=filler,vertical       " Prefer vertical splits by default

let mapleader=","

function! s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=80
endfunction

if has("autocmd")
  " In Makefiles, use real tabs, not tabs expanded to spaces
  au FileType make set noexpandtab

  " Make sure all markdown files have the correct filetype set and setup wrapping
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " mark Jekyll YAML frontmatter as comment
  au BufNewFile,BufRead *.{md,markdown,html,xml} sy match Comment /\%^---\_.\{-}---$/

  " Indent p tags
  " au FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif

  " Make sure haml files are set correctly
  au BufRead,BufNewFile *.haml set ft=haml
endif

" don't use Ex mode, use Q for formatting
map Q gq

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" paste lines from unnamed register and fix indentation
nmap <leader>p pV`]=
nmap <leader>P PV`]=

let g:ctrlp_map = '<leader>f'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 5
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_match_window_bottom = 1
let g:ctrlp_switch_buffer = 2
let g:ctrlp_working_path_mode = 2
let g:ctrlp_mruf_include = '\.py$\|\.rb$|\.coffee|\.haml'
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript']
let g:ctrlp_user_command = {
      \ 'types': {
      \ 1: ['.git/', 'cd %s && git ls-files'],
      \ 2: ['.hg/', 'hg --cwd %s locate -I .'],
      \ },
      \ 'fallback': 'find %s -type f'
      \ }
map <leader>ft :CtrlPTag<cr>
map <leader>fb :CtrlPBuffer<cr>

" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" ignore Rubinius, Sass cache files
set wildignore+=tmp/**,*.rbc,.rbx,*.scssc,*.sassc
set wildmenu
set wildmode=list:longest

" switch between alternate buffers
nnoremap <leader><leader> <c-^>

" find merge conflict markers
nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize pane mappings.
nnoremap <Home> :vertical resize +5<cr>
nnoremap <End> :vertical resize -5<cr>
nnoremap <PageUp> :resize +5<cr>
nnoremap <PageDown> :resize -5<cr>

" disable cursor keys in normal mode
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

set backupdir=~/.vim/_backup    " where to put backup files.
set directory=~/.vim/_temp      " where to put swap files.

if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " Start the status line
  set statusline=%f\ %m\ %r

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}', '|':'|' }
let g:AutoCloseProtectedRegions = ["Character"]

nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_gb

" vimcasts.org/e/26 && unimpaired plugin
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" vim-swap customisations
let g:swap_custom_ops = ['=>']
vmap <Leader>xx <plug>SwapSwapPivotOperands

nnoremap <F5> :GundoToggle<CR>

" Tabular plugin
if exists('g:tabular_loaded')
  AddTabularPattern! symbols         / :/l0
  AddTabularPattern! hash            /^[^>]*\zs=>/
  AddTabularPattern! chunks          / \S\+/l0
  AddTabularPattern! assignment      / = /l0
  AddTabularPattern! comma           /^[^,]*,/l1
  AddTabularPattern! colon           /:\zs /l0
  AddTabularPattern! options_hashes  /:\w\+ =>/
endif

if has("mac")
  let g:gist_clip_command = 'pbcopy'
elseif has("unix")
  let g:gist_clip_command = 'xclip -selection clipboard'
endif

" Gist settings
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_post_private = 1
let g:gist_show_privates = 1

" Insert a hash rocket with <c-l>
imap <c-l> <space>=><space>

" Rails stuff
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>ga :topleft :split app/models/ability.rb<cr>

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>

" Check ruby syntax
map <leader>cr :! ruby -c %<CR>

command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction

" =============== xmpfilter ========================
" Ensure rcodetools gem is installed
nmap <buffer> <leader>mr  <Plug>(xmpfilter-mark)
xmap <buffer> <leader>mr  <Plug>(xmpfilter-mark)
imap <buffer> <leader>mr  <Plug>(xmpfilter-mark)
nmap <buffer> <leader>rr  <Plug>(xmpfilter-run)
xmap <buffer> <leader>rr  <Plug>(xmpfilter-run)
imap <buffer> <leader>rr  <Plug>(xmpfilter-run)

" edit this file
map <silent> <leader>ev :e $MYVIMRC<cr>

" find all TODO comments and put in quickfix window
noremap <leader>t :noautocmd vimgrep /TODO/gj **/*.rb **/*.haml **/*.coffee **/*.js **/*.erb<CR>:cw<CR>

" turn off using bundle exec in vroom since it mucks up the color codes even
" with colors turned off
let g:vroom_use_bundle_exec = 0

function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>l :PromoteToLet<cr>

:map <leader>ct :Dispatch! ctags -R --languages=ruby --exclude=.git --exclude=log --extra=+f<cr>

