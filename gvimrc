set guifont=Inconsolata:h18
set linespace=2
set antialias

set visualbell

set guioptions-=T " no toolbar
set guioptions-=r " no scrollbars

if has("gui_macvim")
  set fuoptions=maxhorz,maxvert
  set macmeta " so meta/alt mappings work in macvim
endif

if has("gui_running")
  set background=dark
else
  set background=light
endif

let g:solarized_termcolors=256
colorscheme solarized
