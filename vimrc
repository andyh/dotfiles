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

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rvm'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-abolish'
Plugin 'godlygeek/tabular'
Plugin 'vim-ruby/vim-ruby'
Plugin 'pangloss/vim-javascript'
Plugin 'chriseppstein/vim-haml'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'mattn/webapi-vim'
Plugin 'mattn/gist-vim'
Plugin 'skalnik/vim-vroom'
Plugin 'Gundo'
Plugin 'kurkale6ka/vim-swap'
Plugin 't9md/vim-ruby-xmpfilter'
Plugin 'UltiSnips'
Plugin 'jgdavey/vim-blockle'
Plugin 'Townk/vim-autoclose'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'ervandew/supertab'
Plugin 'briancollins/vim-jst'
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'
Plugin 'myusuf3/numbers.vim'
Plugin 'bling/vim-airline'

call vundle#end() " required
filetype plugin indent on "required

runtime macros/matchit.vim

syntax enable

set number        " I like me some line numbers
" Use numbers plugin for switching between relative and absolute numbers
" if numbers show up where they shouldn't add them to this exclude list
" let g:numbers_exclude = ['unite', 'tagbar', 'startify', 'gundo', 'vimshell', 'w3m']$

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

" toggling for numbers.vim
nnoremap <F3> :NumbersToggle<CR>
nnoremap <F4> :NumbersOnOff<CR>

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

" map write
map <leader>w :w<cr>

"Dash Settings
let g:dash_map = {
    \ 'ruby': 'rails'
    \ }

" shortcut for looking up words in Dash
nmap <silent> <leader>d <Plug>DashSearch
nmap <silent> <leader>dg <Plug>DashGlobalSearch

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
      \ 'fallback': 'ag %s -l --nocolor -g ""'
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
endif
let g:airline_powerline_fonts = 1

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
" Ensure that seeing_is_believing gem is installed

let g:xmpfilter_cmd = "seeing_is_believing"

autocmd FileType ruby nmap <buffer> <leader>mr <Plug>(seeing_is_believing-mark)
autocmd FileType ruby xmap <buffer> <leader>mr <Plug>(seeing_is_believing-mark)
autocmd FileType ruby imap <buffer> <leader>mr <Plug>(seeing_is_believing-mark)

autocmd FileType ruby nmap <buffer> <leader>rc <Plug>(seeing_is_believing-clean)
autocmd FileType ruby xmap <buffer> <leader>rc <Plug>(seeing_is_believing-clean)
autocmd FileType ruby imap <buffer> <leader>rc <Plug>(seeing_is_believing-clean)

" xmpfilter compatible
autocmd FileType ruby nmap <buffer> <leader>rr <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby xmap <buffer> <leader>rr <Plug>(seeing_is_believing-run_-x)
autocmd FileType ruby imap <buffer> <leader>rr <Plug>(seeing_is_believing-run_-x)

" auto insert mark at appropriate spot.
autocmd FileType ruby nmap <buffer> <leader>ra <Plug>(seeing_is_believing-run)
autocmd FileType ruby xmap <buffer> <leader>ra <Plug>(seeing_is_believing-run)
autocmd FileType ruby imap <buffer> <leader>ra <Plug>(seeing_is_believing-run)

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

" Cleaning up crufty html using pandoc
" From http://vimcasts.org/episodes/using-external-filter-commands-to-reformat-html/
function! FormatprgLocal(filter)
  if !empty(v:char)
    return 1
  else
    let l:command = v:lnum.','.(v:lnum+v:count-1).'!'.a:filter
    echo l:command
    execute l:command
  endif
endfunction

if has("autocmd")
  let pandoc_pipeline  = "pandoc --from=html --to=markdown"
  let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
  autocmd FileType html setlocal formatexpr=FormatprgLocal(pandoc_pipeline)
endif
