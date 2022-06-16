function! ClearAll()
    call feedkeys( ":nohlsearch\<CR>" )
    call feedkeys( "\<Plug>(ExchangeClear)" )
endfunction

function! Cycle_LineNumbers()
    if &number && &relativenumber
        setlocal norelativenumber
        echo 'Switched to normal line numbers'
    elseif &number && ! &relativenumber
        setlocal nonumber
        echo 'Switched to disabled line numbers'
    else
        setlocal number
        setlocal relativenumber
        echo 'Switched to relative line numbers'
    endif
endfunction

function! Toggle_Mode( mode, enable_message, disable_message )
    execute 'setlocal ' . a:mode . '!'
    execute 'echo (&' . a:mode' ? "' . a:enable_message . '" : "' . a:disable_message . '")'
endfunction

function! Toggle_FillColumn()
    execute 'set colorcolumn=' . (&colorcolumn == '' ? '-0' : '')
    execute 'echo ' . (&colorcolumn == '' ? '"Global Dispaly-Fill-Column-Indicator mode disabled"' : '"Global Dispaly-Fill-Column-Indicator mode enabled"')
endfunction

if has_key(plugs, 'Colorizer')
    function! Toggle_Rainbow()
        if !exists("w:match_list") || empty(w:match_list)
            echo 'Rainbow mode enabled in current buffer'
            ColorHighlight
        else
            echo 'Rainbow mode disabled in current buffer'
            ColorClear
        endif
    endfunction
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Esc>'] = 'Reset/Cleanup'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map[',']     = 'Switch workspace buffer' | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map['<']     = 'Switch buffer'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map['`']     = 'Switch to last buffer'   | endif

nnoremap <silent> <leader><Esc> :call ClearAll()<cr>
nnoremap <leader>, :BufExplorerHorizontalSplit<cr>
nnoremap <leader>< :Buffers<cr>
nnoremap <leader>` :b#<cr>

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map[' '] = ['GFiles', 'Find file in project' ] | endif

    nnoremap <leader><Space> :GFiles<cr>
endif

" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']      = { 'name' : '+workspace' }   | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']['0'] = 'Switch to final workspace' | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']['1'] = 'Switch to 1st workspace'   | endif

nnoremap <leader><Tab><Tab> :tabs<cr>
nnoremap <leader><Tab>0 :$tabnext<cr>
nnoremap <leader><Tab>1 :1tabnext<cr>
nnoremap <leader><Tab>2 :2tabnext<cr>
nnoremap <leader><Tab>3 :3tabnext<cr>
nnoremap <leader><Tab>4 :4tabnext<cr>
nnoremap <leader><Tab>5 :5tabnext<cr>
nnoremap <leader><Tab>6 :6tabnext<cr>
nnoremap <leader><Tab>7 :7tabnext<cr>
nnoremap <leader><Tab>8 :8tabnext<cr>
nnoremap <leader><Tab>9 :9tabnext<cr>
nnoremap <leader><Tab>< :0tabmove<cr>
nnoremap <leader><Tab>> :$tabmove<cr>
nnoremap <leader><Tab>[ :tabprevious<cr>
nnoremap <leader><Tab>] :tabnext<cr>
nnoremap <leader><Tab>` :tablast<cr>
nnoremap <leader><Tab>c :tabclose<cr>
nnoremap <leader><Tab>d :tabclose<cr>
nnoremap <leader><Tab>m :tabmove
nnoremap <leader><Tab>n :tabnew<cr>
nnoremap <leader><Tab>N :tabnew 
nnoremap <leader><Tab>O :tabonly<cr>
nnoremap <leader><Tab>{ :-tabmove<cr>
nnoremap <leader><Tab>} :+tabmove<cr>


" Toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader><Tab>l :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

if has_key(plugs, 'vim-which-key') | let g:which_key_map.b      = { 'name' : '+buffer' }    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['['] = 'Previous buffer'         | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b[']'] = 'Next buffer'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['b'] = 'Switch workspace buffer' | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['B'] = 'Switch buffer'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['d'] = 'Kill buffer'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['i'] = 'ibuffer'                 | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['k'] = 'Kill buffer'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['K'] = 'Kill all buffers'        | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['l'] = 'Switch to last buffer'   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['L'] = 'List bookmarks'          | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['n'] = 'Next buffer'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['N'] = 'New empty buffer'        | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['O'] = 'Kill other buffers'      | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['p'] = 'Previous buffer'         | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['r'] = 'Revert buffer'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['s'] = 'Save buffer'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['S'] = 'Save all buffers'        | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.b['u'] = 'Save buffer as root'     | endif

nnoremap <silent> <leader>b[ :bprevious<cr>
nnoremap <silent> <leader>b] :bnext<cr>
nnoremap <silent> <leader>bb :BufExplorerHorizontalSplit<cr>
nnoremap <silent> <leader>bB :Buffers<cr>
nnoremap <silent> <leader>bd :Bclose<cr>
nnoremap <silent> <leader>bi :BufExplorer<cr>
nnoremap <silent> <leader>bk :Bclose<cr>
nnoremap <silent> <leader>bK :bufdo bd<cr>
nnoremap <silent> <leader>bl :b#<cr>
nnoremap <silent> <leader>bL :marks<cr>
nnoremap <silent> <leader>bn :bnext<cr>
nnoremap <silent> <leader>bN :e *new*<cr>
nnoremap <leader>bO :%bd <Bar> e#<cr>
nnoremap <silent> <leader>bp :bprevious<cr>
nnoremap <silent> <leader>br :if confirm('Discard edits and reread from ' . expand('%:p') . '?', "&Yes\n&No", 1)==1 <Bar> exe ":edit!" <Bar> endif<cr>
nnoremap <leader>bs :write<cr>
nnoremap <leader>bS :wa<cr>
nnoremap <leader>bu :W<cr>

if has_key(plugs, 'vim-which-key') | let g:which_key_map.c = { 'name' : '+code' } | endif

if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f      = { 'name' : '+file' }          | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['c'] = 'CD to current directory'     | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['c'] = 'Open project editorconfig'   | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['C'] = 'Copy this file'              | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['d'] = 'Find directory'              | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['D'] = 'Delete this file'            | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['E'] = 'Browse vim.d'                | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['P'] = 'Browse private config'       | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['R'] = 'Rename/move file'            | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['s'] = 'Save file'                   | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['S'] = 'Save as...'                  | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['u'] = 'Sudo find file'              | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['U'] = 'Sudo this file'              | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['y'] = 'Yank file path'              | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['Y'] = 'Yank file path from project' | endif
if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['v'] = 'Grep?'                       | endif

nnoremap <leader>fc :cd %:p:h<cr>:pwd<cr>
nnoremap <silent> <leader>fD :if confirm('Really delete "' . expand('%') . '"?', "&Yes\n&No", 1)==1 <Bar> exe ":call delete(@%)" <Bar> exe ":Bclose" <Bar> endif<cr>
nnoremap <leader>fE :Hexplore ~/.vim/core<cr>
nnoremap <leader>fP :Hexplore ~/.vim<cr>
nnoremap <leader>fs :write<cr>
nnoremap <leader>fS :write 
nnoremap <leader>fy :let @" = expand('%:p')<cr>:let @+ = expand('%:p')<cr>:echo "Copied path to clipboard: " . expand('%:p')<cr>
nnoremap <leader>fY :let @" = expand('%')<cr>:let @+ = expand('%')<cr>:echo "Copied path to clipboard: " . expand('%')<cr>
nnoremap <leader>fv :vimgrep **/*

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['e'] = 'Find file in vim.d'          | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.f['f'] = 'Find file'                   | endif
    if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['F'] = 'Find file from here'         | endif
    if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['l'] = 'Locate file'                 | endif
    if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['p'] = 'Find file in private config' | endif
    if has_key(plugs, 'vim-which-key')   | let g:which_key_map.f['r'] = 'Recent files'                | endif

    map <leader>fe :Files ~/.vim/core<CR>
    map <leader>fF :Files<CR>
    map <leader>fl :Locate 
    map <leader>fp :Files ~/.vim<CR>
    map <leader>fr :History<CR>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.g      = { 'name' : '+git' } | endif

if has_key(plugs, 'vim-gitgutter')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['d'] = 'Diff Split'        | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['g'] = 'Status'            | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['p'] = 'Preview hunk'      | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['s'] = 'Stage hunk'        | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['u'] = 'Undo hunk'         | endif
    if has_key(plugs, 'vim-which-key') | let g:squre_bracket_map.c        = 'Git Hunk'          | endif

    nnoremap <silent> <leader>gd :vertical Gdiffsplit<cr>
    nnoremap <silent> <leader>gg :Git<cr>

    nnoremap <leader>gp <Plug>(GitGutterPreviewHunk)
    nnoremap <leader>gs <Plug>(GitGutterStageHunk)
    nnoremap <leader>gu <Plug>(GitGutterUndoHunk)
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.h = { 'name' : '+help' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['k'] = 'describe-key'         | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['s'] = 'help-search-headings' | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['t'] = 'load-theme'           | endif

    nnoremap <leader>hk :Maps<CR>
    nnoremap <leader>hs :Helptags<CR>
    nnoremap <leader>ht :Colors<CR>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r      = { 'name' : '+reload' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['e'] = 'reload-env'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['p'] = 'reload-packages'      | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['r'] = 'reload'               | endif

nnoremap <leader>hre :source $MYVIMRC<cr>
nnoremap <leader>hrr :source %<cr>

if has_key(plugs, 'vim-which-key') | let g:which_key_map.i      = { 'name' : '+insert' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.i['t'] = 'Toilet pagga'         | endif

nnoremap <leader>it :r !toilet -f pagga

if has_key(plugs, 'vim-which-key') | let g:which_key_map.o = { 'name' : '+open' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['-'] = 'File Explorer' | endif

nnoremap <leader>o- :Explore<cr>

if has_key(plugs, 'vim-floaterm')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['t'] = 'Toggle term popup' | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['p'] = 'Python'   | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['r'] = 'Ranger'   | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['v'] = 'Vifm'     | endif

    nnoremap <leader>ot :FloatermToggle<cr>
    nnoremap <leader>op :FloatermNew python<cr>
    nnoremap <leader>or :FloatermNew ranger<cr>
    nnoremap <leader>ov :FloatermNew vifm<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.m = { 'name' : '+<localleader>' } | endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.p = { 'name' : '+popup' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['f'] = 'Find file in project' | endif

    nnoremap <leader>pf :GFiles<cr>
    
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p["'"] = 'Search marks'        | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['/'] = 'Search history'      | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p[':'] = 'Commands history'    | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['c'] = 'Search all commands' | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['f'] = 'Switch filetype'     | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['w'] = 'Switch window'       | endif

"     nnoremap <leader>p' :Marks<CR>
"     nnoremap <leader>p/ :History/<CR>
"     nnoremap <leader>p: :History:<CR>
"     nnoremap <leader>pc :Commands<CR>
"     nnoremap <leader>pf :Filetypes<CR>
"     nnoremap <leader>pw :Windows<CR>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.q      = { 'name' : '+quit/session' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['l'] = 'Restore last session'       | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['L'] = 'Restore session from file'  | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['q'] = 'Quit Vim'                   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['Q'] = 'Quit Vim without saving'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['s'] = 'Quick save current session' | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['S'] = 'Save session to file'       | endif

nnoremap <leader>ql :source $HOME/.vim/sessions/quick-session.vim<cr>
nnoremap <leader>qL :source $HOME/.vim/sessions/
nnoremap <leader>qq :qa<cr>
nnoremap <leader>qQ :qa!<cr>
nnoremap <leader>qs :mksession! $HOME/.vim/sessions/quick-session.vim<cr>
nnoremap <leader>qS :mksession $HOME/.vim/sessions/

if has_key(plugs, 'vim-which-key') | let g:which_key_map.s = { 'name' : '+search' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['b'] = 'Search buffer'              | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['B'] = 'Search all open buffers'    | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['p'] = 'Search project'             | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['t'] = 'Search Tags in buffer'      | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['T'] = 'Search Tags in all buffers' | endif

    nnoremap <leader>sb :BLines<CR>
    nnoremap <leader>sB :Lines<CR>
    nnoremap <leader>sp :Rg<CR>
    nnoremap <leader>st :BTags<CR>
    nnoremap <leader>sT :Tags<CR>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.t      = { 'name' : '+toggle' }   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['l'] = 'Line numbers'           | endif 
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['p'] = 'Paste mode'             | endif 
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['w'] = 'Soft line wrapping'     | endif 
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['r'] = 'Read-only mode'         | endif 
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['s'] = 'Spell checker'          | endif 
if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['|'] = 'Fill column indicator'  | endif 

nnoremap <leader>tl :call Cycle_LineNumbers()<cr>
nnoremap <leader>tp :call Toggle_Mode('paste'   , 'Paste mode enabled in current buffer'      , 'Paste mode disabled in current buffer')<cr>
nnoremap <leader>tw :call Toggle_Mode('wrap'    , 'Visual-Line mode enabled in current buffer', 'Visual-Line mode disabled in current buffer')<cr>
nnoremap <leader>tr :call Toggle_Mode('readonly', 'Read-Only mode enabled in current buffer'  , 'Read-Only mode disabled in current buffer')<cr>
nnoremap <leader>ts :call Toggle_Mode('spell'   , 'Spell mode enabled in current buffer'      , 'Spell mode disabled in current buffer')<cr>
nnoremap <leader>t\| :call Toggle_FillColumn()<cr>

if has_key(plugs, 'vim-minimap')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['m']      = 'Minimap'                  | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['M']      = { 'name' : '+minimap...' } | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['M']['c'] = 'Close minimap'            | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['M']['o'] = 'Open minimap'             | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['M']['u'] = 'Update minimap'           | endif
    
    let g:minimap_show='<leader>tMo'
    let g:minimap_update='<leader>tMu'
    let g:minimap_close='<leader>tMc'
    let g:minimap_toggle='<leader>tm'
endif

if has_key(plugs, 'Colorizer')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.t['c'] = 'Colors' | endif

    nnoremap <leader>tc :call Toggle_Rainbow()<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.w      = { 'name' : '+window' }       | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['+'] = 'Increase window height'     | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['-'] = 'Decrease window height'     | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['<'] = 'Decrease window width'      | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['='] = 'Balance windows'            | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['>'] = 'Increase window width'      | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['_'] = 'Set window height'          | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['`'] = 'Open a terminal in a split' | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['b'] = 'Bottom-right window'        | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['c'] = 'Close window'               | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['d'] = 'Close window'               | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['h'] = 'Left window'                | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['H'] = 'Move window left'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['j'] = 'Down window'                | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['J'] = 'Move window down'           | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['k'] = 'Up window'                  | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['K'] = 'Move window up'             | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['l'] = 'Right window'               | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['L'] = 'Move window right'          | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['n'] = 'New window'                 | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['o'] = 'Enlargen window'            | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['p'] = 'Last window'                | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['q'] = 'Quit window'                | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['r'] = 'Rotate windows downwards'   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['R'] = 'Rotate windows upwards'     | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['s'] = 'Split window'               | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['S'] = 'Split and follow window'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['t'] = 'Top-left window'            | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['T'] = 'Tear off window'            | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['v'] = 'VSplit window'              | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['V'] = 'VSplit and follow window'   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['w'] = 'Next window'                | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['W'] = 'Previous window'            | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.w['|'] = 'Set window width'           | endif

nnoremap <leader>w+ :resize +5<cr>
nnoremap <leader>w- :resize -5<cr>
nnoremap <leader>w< :vertical resize -5<cr>
nnoremap <leader>w= <C-w>=
nnoremap <leader>w> :vertical resize +5<cr>
nnoremap <leader>w_ :resize<cr>
nnoremap <leader>w` :term<cr>
nnoremap <leader>wb <C-w>b
nnoremap <leader>wc :close<cr>
nnoremap <leader>wd :close<cr>
nnoremap <leader>wh <C-w>h
nnoremap <leader>wH <C-w>H
nnoremap <leader>wj <C-w>j
nnoremap <leader>wJ <C-w>J
nnoremap <leader>wk <C-w>k
nnoremap <leader>wK <C-w>K
nnoremap <leader>wl <C-w>l
nnoremap <leader>wL <C-w>L
nnoremap <leader>wn :new<cr>
nnoremap <leader>wo :only<cr>
nnoremap <leader>wp <C-w>p
nnoremap <leader>wq :quit<cr>
nnoremap <leader>wr <C-w>r
nnoremap <leader>wR <C-w>R
nnoremap <leader>ws :split<cr><C-w>p
nnoremap <leader>wS :split<cr>
nnoremap <leader>wt <C-w>t
nnoremap <leader>wT <C-w>T
nnoremap <leader>wv :vsplit<cr><C-w>p
nnoremap <leader>wV :vsplit<cr>
nnoremap <leader>ww <C-w>w
nnoremap <leader>wW <C-w>W
nnoremap <leader>w\| :vertical resize<cr>

if has_key(plugs, 'vim-which-key') | let g:g_map['$'] = 'end-of-visual-line'       | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['-'] = 'number/dec-at-point'      | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['0'] = 'beginning-of-visual-line' | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['8'] = 'what-cursor-position'     | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['='] = 'number/inc-at-point'      | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['m'] = 'middle-of-visual-line'    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['M'] = 'percentage-of-line'       | endif

map g$ g$
noremap g- <C-x>
map g0 g0
map g8 g8
noremap g= <C-a>
map gm gm
map gM gM

if has_key(plugs, 'vim-exchange')
    if has_key(plugs, 'vim-which-key') | let g:g_map["x"] = 'vim-exchange'        | endif

    nmap gx <Plug>(Exchange)
    nmap gxx <Plug>(ExchangeLine)
    nmap gxc <Plug>(ExchangeClear)
    xmap gx <Plug>(Exchange)
endif

if has_key(plugs, 'vim-which-key') | let g:z_map['+']    = 'scroll-bottom-line-to-top' | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['-']    = 'scroll-line-to-bottom'     | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['.']    = 'scroll-line-to-center'     | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['=']    = 'ispell-word'               | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['^']    = 'scroll-top-line-to-bottom' | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['b']    = 'scroll-line-to-bottom'     | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['g']    = 'add-word'                  | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['t']    = 'scroll-line-to-top'        | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['z']    = 'scroll-line-to-center'     | endif
if has_key(plugs, 'vim-which-key') | let g:z_map['<CR>'] = 'scroll-line-to-top'        | endif

map z= z=
map zg zg

if has_key(plugs, 'vim-which-key') | let g:Z_map['Q'] = 'vim-quit'                | endif
if has_key(plugs, 'vim-which-key') | let g:Z_map['Z'] = 'save-modified-and-close' | endif

map ZQ ZQ
map ZZ ZZ

nnoremap <Up> :blast<cr>
nnoremap <Down> :bfirst<cr>
nnoremap <Left> :bprevious<cr>
nnoremap <Right> :bnext<cr>

if has_key(plugs, 'vim-which-key') | let g:squre_bracket_map['['] = 'Move around functions' | endif
if has_key(plugs, 'vim-which-key') | let g:squre_bracket_map[']'] = 'Move around functions' | endif
if has_key(plugs, 'vim-which-key') | let g:squre_bracket_map['"'] = 'Move around comments'  | endif

noremap <tab> :norm za<cr>
noremap <tab><tab> :norm zA<cr>
noremap <S-tab> :norm zR<cr>
noremap <S-tab><S-tab> :norm zM<cr>

map <A-x> :

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

nnoremap <A-k> :m-2<cr>==
nnoremap <A-j> :m+<cr>==
vnoremap <A-k> :m '<-2<cr>gv=gv
vnoremap <A-j> :m '>+1<cr>gv=gv
