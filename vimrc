" =============================================================================
" __   _(_)_ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
" 
" =============================================================================
"
" Clément Geiger - 2011
" forked from Paul ADENOT -- 2011
"
call pathogen#infect()

""" Standard ViM options
set mouse=a
set ttyfast
" who cares about vi
set nocompatible "eq. to nocp
" , is a nice leader key
let mapleader = ","
" highlight words and numbers inside a comment
let c_comment_strings=1
" Enable syntax highlighting
syntax on
" Color scheme.
colo desert
set background=dark
set hlsearch
" Show the line numbers.
set number
" Automatic indentation for C-like languages.
set smartindent
" Write (=save) the file whenever it is compiled or when
" the user changes files in a buffer.
set autowrite
" Automatic comments
set formatoptions=tco
" Show a line at 80 chars and disable text width checking
set colorcolumn=80
set textwidth=0
" Incremental search : search befor return is typed
set incsearch
" Set the EOL format
set fileformats=unix,dos
" Tilda is set as an operator
set tildeop
" Search wrap around the entire file.
set wrapscan
" Wrap words, and break then between words only.
set linebreak
" Match pairs of symbols
set matchpairs+=<:>":"`:`
" Size of tabulatons, which are in fact spaces
set expandtab
set tabstop=2
set shiftwidth=2
" hitting backspace delete spaces two by two
set softtabstop=2
" Case sensitive seach if a capital is used in the search pattern
set ignorecase
set smartcase
" Font in GUI mode : https://github.com/andreberg/Meslo-Font
set guifont=Meslo\ LG\ S\ DZ\ 9 
" remove the useless buttons from gvim
set guioptions=nomenu
" Remove menubar
set guioptions-=m
" Add vim icon and use console instead of popups
set guioptions+=ic
" Remove bottom scrolling bar.
set guioptions-=b
" Copy visual area to paste buffer
set go+=a
" Allow backspace in insert mode like in any other text editor
set backspace=indent,eol,start
" Set the dictionnary to french
set dictionary+="/usr/share/dict/french"
" Set the Doxygen style comments, to ease the writing of documentation
set comments=s1:/**,mb:*,ex:*/
" We will almost never open .o in vim, so remove them from matching
set wildignore+=*.o,*.obj,.git,*.swp,*.svn,*.pyc
" Add · for trailing spaces.
set list listchars=tab:\ \ ,trail:·
" nice menu for auto completion
set wildmenu
set lazyredraw
" Don't go to the start of line when using C-D and such
set nostartofline
set modeline
set scroll=5
set scrolloff=5
set sidescrolloff=5
set sidescroll=1
set viminfo='10,:20,\"100,%,n~/.viminfo
set history=1000
" Persistent undo
set undofile
set undodir=~/.vim/undodir
" show partially typed commands
set showcmd

" Use TAB in normal mode to fold/unfold
set foldmethod=indent
map <Tab> za
au BufWinEnter * normal zR

" SCons support
set makeprg=scons\ -u\ \.
" Ack is "better than grep"
set grepprg=ack-grep

" Set the GUI Size to one screen
au GUIEnter * set lines=48 columns=84

""" File type specific
filetype indent on
filetype plugin on
" Enable spelling check on .tex and .latex files, as well as rst files
augroup filetypedetect
  " set syntax for qml files
  au BufNewFile,BufRead *.qml set syntax=qml
  au BufNewFile,BufRead {*.tex,*.md,*.mdwn,*.markdown} setlocal spell spelllang=en nocindent
  au BufWritePost *.tex :silent !make
  au BufNewFile,BufRead *.rst set syntax=rest
  autocmd FileType c,cpp,python,javascript,html IndentGuidesEnable
  let g:indent_guides_auto_colors = 1
  let g:indent_guides_guide_size = 4
  " After opening a file, put the cursor when it was last time this file was edited.
  autocmd BufReadPost * normal `"
  " SConscript & SConstruct are python
  au BufRead,BufNewFile {SConscript,SConstruct}  set ft=python
  " .rl (ragel parsing file) should be highlighted as C
  au BufRead,BufNewFile {*.rl} set ft=c
  " .ipdl (inte-process-definition-language) should be highlighted as C++
  au BufRead,BufNewFile {*.ipdl} set ft=cpp
  " highlight .sjs (server side js) as javacript
  au BufRead,BufNewFile {*.sjs} set ft=javascript
  " Respect PEP8 while editing python
  au FileType python  set tabstop=4 textwidth=0
  " When using make, we shouldn't expand tabs.
  au FileType make set noexpandtab
augroup END


"""" Omnicpp
set tags+=./tags;$HOME
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/qttags
set tags+=~/.vimtags
" F12 builds tags for the current project.
map <F12> :!ctags -R --sort=yes --c++-kinds=+lp --fields=+iaS --extra=+q .<CR>

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

"" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


" Mapping for tabularize plugin
if exists(":Tabularize")
    noremap <Leader>a= :Tabularize /=<CR>
    noremap <Leader>a= :Tabularize /=<CR>
    noremap <Leader>z| :Tabularize /|<CR>
    noremap <Leader>z| :Tabularize /|<CR>
endif

" F5 toogles to Gundo panel
nnoremap <F5> :GundoToggle<CR>

" Tag list toggle
noremap <F6> :TagbarToggle<CR>
  
" Control tab switches between cpp an .h file, as in Eclipse
map <C-Tab> :FSHere<CR><Esc>

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

map <C-S-]> gt
map <C-S-[> gT
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt
map <M-0> :tablast<CR>

augroup mycppfiles
  au!
  au BufRead *.cpp let b:fswitchlocs = '.,../public/'
  au BufRead *.cpp let b:fswitchdst = "h"
  au BufRead *.h let b:fswitchdst  = 'cpp,cc,C'
  au BufRead *.h let b:fswitchlocs = '.,../src/'
augroup END


" Type :w!! when forgot sudo and editing a file.
cmap w!! w !sudo tee % >/dev/null

" Disable arrows in normal mode
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
" control+j & control+k switch tabs
noremap <C-J> :silent :tabprev<CR><Esc>
noremap <C-K> :silent :tabnext<CR><Esc>
" leader a : ack the word under cursor
nnoremap <leader>a :grep <cword><CR>

" Textmate command-t (fuzzy find file).
map <Leader>t :silent :FufCoverageFile <CR><Esc>

let delimitMate_matchpairs = "(:),[:],{:}"
au FileType html let b:delimitMate_matchpairs = "(:),[:],{:},<:>"

" Press F4 to clear highlighting.
map <F2> :noh<CR>
" Allow to paste formatted code nicely
set pastetoggle=<F3>

" Activate syntastic. Prevent its activation for c++ because it screws up in
" Mozilla codebase. TODO: Make this work.
  let g:syntastic_enable_signs=1
  let g:syntastic_auto_jump=1
  let g:syntastic_auto_loc_list=1
  let g:syntastic_disabled_filetypes = ['cpp', "h"]

" Nice statusbar (found here : http://paulrouget.com/e/mqpatch_vim/)
set laststatus=2
let g:mqStatusPath = substitute(system("hg root --cwd " .  getcwd()), "\n", "", "g") . "/.hg/patches/status"

function! GetCurrentMqPatch()
    if filereadable(g:mqStatusPath)
      let patchesList = readfile(g:mqStatusPath)
      if len(patchesList) > 0
        return split(patchesList[-1], ':')[1]
      endif
    endif
    return ""
endfunction

set statusline=%{GetCurrentMqPatch()}\ %F%m%r%h%w

function! MyStatusLine(mode)
    let statusline=""

    if filereadable(g:mqStatusPath)
      let statusline .= "%#PatchColor#" . GetCurrentMqPatch() . "%*"
    endif

    if a:mode == 'Enter'
        let statusline.="%#StatColor#"
    endif
    let statusline.="\(%n\)\ %f\ "
    if a:mode == 'Enter'
        let statusline.="%*"
    endif
    let statusline.="%#Modified#%m"
    if a:mode == 'Leave'
        let statusline.="%*%r"
    elseif a:mode == 'Enter'
        let statusline.="%r%*"
    endif
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=#002b36 guifg=#999999 ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#cb4b16 ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#dc322f ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#999999 guifg=#002b36 ctermbg=lightgreen ctermfg=black

" In CSS, F8 and F9 change colors by one shade
if filereadable("~/.vim/cssScript/hex.php")
  function! HexUpdate(operator, shade)
      let hex = expand("<cword>")
      let newHex = system("php ~/.vim/cssScript/hex.php ". hex ." ". a:operator . a:shade)
      execute "normal ciw". newHex
endfunction

  nnoremap <F8> :call HexUpdate("-",1)<CR>
  nnoremap <F9> :call HexUpdate("+",1)<CR>
endif

" vim-javascript options
let g:javascript_plugin_jsdoc = 1
