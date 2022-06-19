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
        if !exists('w:match_list') || empty(w:match_list)
            echo 'Rainbow mode enabled in current buffer'
            ColorHighlight
        else
            echo 'Rainbow mode disabled in current buffer'
            ColorClear
        endif
    endfunction
endif

function! Reveal_In_Files()
    if has('linux')
        let opencmd = '!xdg-open '
    elseif has('mac') || has('macunix')
        let opencmd = '!open '
    elseif has('win16') || has('win32')
        let opencmd = '!explorer.exe '
        " let opencmd = '!start explorer.exe /select,'
    endif

    silent execute opencmd . expand('%:p:h')
endfunction

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

if has_key(plugs, 'vim-gitgutter')
    " Select current hunk
    omap ic <Plug>(GitGutterTextObjectInnerPending)
    omap ac <Plug>(GitGutterTextObjectOuterPending)
    xmap ic <Plug>(GitGutterTextObjectInnerVisual)
    xmap ac <Plug>(GitGutterTextObjectOuterVisual)
endif

" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']       = { 'name' : '+workspace' }   | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map.['<Tab>']['.'] = 'Switch workspace'          | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']['0']  = 'Switch to final workspace' | endif
" if has_key(plugs, 'vim-which-key') | let g:which_key_map['<Tab>']['1']  = 'Switch to 1st workspace'   | endif

nnoremap <silent> <leader><Tab>. :tabs<cr>
nnoremap <silent> <leader><Tab>0 :$tabnext<cr>
nnoremap <silent> <leader><Tab>1 :1tabnext<cr>
nnoremap <silent> <leader><Tab>2 :2tabnext<cr>
nnoremap <silent> <leader><Tab>3 :3tabnext<cr>
nnoremap <silent> <leader><Tab>4 :4tabnext<cr>
nnoremap <silent> <leader><Tab>5 :5tabnext<cr>
nnoremap <silent> <leader><Tab>6 :6tabnext<cr>
nnoremap <silent> <leader><Tab>7 :7tabnext<cr>
nnoremap <silent> <leader><Tab>8 :8tabnext<cr>
nnoremap <silent> <leader><Tab>9 :9tabnext<cr>
nnoremap <silent> <leader><Tab>< :0tabmove<cr>
nnoremap <silent> <leader><Tab>> :$tabmove<cr>
nnoremap <silent> <leader><Tab>[ :tabprevious<cr>
nnoremap <silent> <leader><Tab>] :tabnext<cr>
nnoremap <silent> <leader><Tab>c :tabclose<cr>
nnoremap <silent> <leader><Tab>d :tabclose<cr>
nnoremap <leader><Tab>m :tabmove
nnoremap <leader><Tab>n :tabnew<cr>
nnoremap <leader><Tab>N :tabnew 
nnoremap <silent> <leader><Tab>O :tabonly<cr>
nnoremap <silent> <leader><Tab>{ :-tabmove<cr>
nnoremap <silent> <leader><Tab>} :+tabmove<cr>


" Toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <silent> <leader><Tab>` :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

if has_key(plugs, 'fzf')
    nnoremap <silent> <leader><Tab>. :Windows<cr>
endif

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

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.c = { 'name' : '+code' } | endif

    " Remap for format selected region
    xmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)
    let g:which_key_map.c['f'] = 'Format' 

    " Remap for do codeAction of current line
    nmap <leader>c<space> <Plug>(coc-codeaction)
    let g:which_key_map.c[' '] = 'Code action' 

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>cv <Plug>(coc-codeaction-selected)
    nmap <leader>cv <Plug>(coc-codeaction-selected)
    let g:which_key_map.c['v'] = 'Code action selected' 

    " Fix autofix problem of current line
    nmap <leader>ca  <Plug>(coc-fix-current)
    let g:which_key_map.c['a'] = 'Fix current' 

    " Show all diagnostics
    nnoremap <silent> <leader>cd  :<C-u>CocList diagnostics<cr>
    let g:which_key_map.c['d'] = 'Diagnostics' 

    " Manage extensions
    nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
    let g:which_key_map.c['e'] = 'Extensions' 

    " Show commands
    nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
    let g:which_key_map.c['c'] = 'Commands' 

    " Find symbol of current document
    nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
    let g:which_key_map.c['o'] = 'Outline' 

    " Search workspace symbols
    nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
    let g:which_key_map.c['s'] = 'Symbols' 

    nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
    let g:which_key_map.c['j'] = 'Default action for next item' 

    nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
    let g:which_key_map.c['k'] = 'Default action for previous item' 

    nnoremap <silent> <leader>cp  :<C-u>CocListResume<CR>
    let g:which_key_map.c['p'] = 'Resume latest coc list' 

endif

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
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['['] = 'Jump to previous hunk' | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g[']'] = 'Jump to next hunk'     | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['p'] = 'Preview hunk'          | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['s'] = 'Git stage hunk'        | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['r'] = 'Revert hunk'           | endif

    nmap <leader>g[ <Plug>(GitGutterPrevHunk)
    nmap <leader>g] <Plug>(GitGutterNextHunk)
    nmap <leader>gp <Plug>(GitGutterPreviewHunk)
    nmap <leader>gs <Plug>(GitGutterStageHunk)
    nmap <leader>gr <Plug>(GitGutterUndoHunk)
endif

if has_key(plugs, 'vim-fugitive')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['d'] = 'Diff Split'            | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.g['g'] = 'Status' | endif
    
    nmap <silent> <leader>gd :Gvdiffsplit<cr>
    nmap <silent> <leader>gg :Git<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.h = { 'name' : '+help' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['<CR>']   = 'info-vim-Manual'         | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['?']      = 'help-for-help'           | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['e']      = 'view-echo-area-messages' | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['i']      = 'show-version-info'       | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['k']      = 'describe-key'            | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['q']      = 'help-quit'               | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['s']      = 'help-search-headings'    | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['t']      = 'load-theme'              | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['v']      = 'show-version-info'       | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['<F1>']   = 'help-for-help'           | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.h['<Help>'] = 'help-for-help'           | endif

    nnoremap <silent> <leader>h<CR> :help<cr>
    nnoremap <silent> <leader>h? :help helphelp<cr>
    nnoremap <silent> <leader>he :messages<cr>
    nnoremap <silent> <leader>hi :version<cr>
    nnoremap <silent> <leader>hk :Maps<cr>
    nnoremap <silent> <leader>hq :helpclose<cr>
    nnoremap <silent> <leader>hs :Helptags<cr>
    nnoremap <silent> <leader>ht :Colors<cr>
    nnoremap <silent> <leader>hv :version<cr>
    nnoremap <silent> <leader>h<F1> :help helphelp<cr>
    nnoremap <silent> <leader>h<Help> :help helphelp<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r      = { 'name' : '+reload' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['f'] = 'reload-this-file'     | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['p'] = 'reload-packages'      | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['r'] = 'reload'               | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.h.r['t'] = 'reload-theme'         | endif

nnoremap <silent> <leader>hrf :source % <Bar> echo "Current file successfully reloaded!"<cr>
nnoremap <silent> <leader>hrp :PlugInstall --sync<cr>
nnoremap <silent> <leader>hrr :source $MYVIMRC<cr>
nnoremap <silent> <leader>hrt :execute 'colorscheme ' . g:colors_name<cr>

if has_key(plugs, 'vim-which-key') | let g:which_key_map.i      = { 'name' : '+insert' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.i['f'] = 'Current file name'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.i['F'] = 'Current file path'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.i['p'] = 'Evil ex path'         | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.i['t'] = 'Toilet pagga'         | endif

" nnoremap <silent> <leader>if :normal "%p<cr>
nnoremap <silent> <leader>if a<C-r>=expand("%:t")<cr><esc>
nnoremap <silent> <leader>iF a<C-r>=expand("%:p")<cr><esc>
nnoremap <leader>ip :r !echo 
nnoremap <leader>it :r !toilet -f pagga

if has_key(plugs, 'vim-which-key') | let g:which_key_map.o      = { 'name' : '+open' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['-'] = 'Netrw'              | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['b'] = 'Default browser'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['o'] = 'Reveal in finder'   | endif

nnoremap <leader>o- :Explore<cr>
nnoremap <leader>ob <Plug>NetrwBrowseX
nnoremap <leader>oo :call Reveal_In_Files()<cr>

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['p'] = 'Project sidebar'              | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['P'] = 'Find file in project sidebar' | endif

    nnoremap <leader>op :CocCommand explorer<cr>
endif

if has_key(plugs, 'vim-floaterm')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['-'] = 'Vifm'              | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.o['t'] = 'Toggle term popup' | endif

    nnoremap <silent> <leader>ot :FloatermToggle<cr>
    nnoremap <silent> <leader>o- :FloatermNew vifm<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.m = { 'name' : '+<localleader>' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.m['M'] = 'Switch major mode' | endif
    
    nnoremap <silent> <leader>mM :Filetypes<CR>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.p = { 'name' : '+popup' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.p['f'] = 'Find file in project' | endif

    nnoremap <leader>pf :GFiles<cr>
endif

if has_key(plugs, 'vim-which-key') | let g:which_key_map.q      = { 'name' : '+quit/session' } | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['l'] = 'Restore last session'       | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['L'] = 'Restore session from file'  | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['q'] = 'Quit Vim'                   | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['Q'] = 'Quit Vim without saving'    | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['s'] = 'Quick save current session' | endif
if has_key(plugs, 'vim-which-key') | let g:which_key_map.q['S'] = 'Save session to file'       | endif

nnoremap <silent> <leader>ql :source $HOME/.vim/.local/etc/workspaces/quick-session.vim<cr>
nnoremap <silent> <leader>qL :source $HOME/.vim/.local/etc/workspaces/
nnoremap <silent> <leader>qq :qa<cr>
nnoremap <silent> <leader>qQ :qa!<cr>
nnoremap <silent> <leader>qs :mksession! $HOME/.vim/.local/etc/workspaces/quick-session.vim<cr>
nnoremap <silent> <leader>qS :mksession $HOME/.vim/.local/etc/workspaces/

if has_key(plugs, 'vim-which-key') | let g:which_key_map.s = { 'name' : '+search' } | endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['b'] = 'Search buffer'              | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['B'] = 'Search all open buffers'    | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['p'] = 'Search project'             | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['r'] = 'Jump to mark'               | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['t'] = 'Search Tags in buffer'      | endif
    if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['T'] = 'Search Tags in all buffers' | endif
    
    nnoremap <leader>sb :BLines<CR>
    nnoremap <leader>sB :Lines<CR>
    nnoremap <leader>sp :Rg<CR>
    nnoremap <leader>sr :Marks<CR>
    nnoremap <leader>st :BTags<CR>
    nnoremap <leader>sT :Tags<CR>
    
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['/'] = 'Search history'      | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.s[':'] = 'Commands history'    | endif
    " if has_key(plugs, 'vim-which-key') | let g:which_key_map.s['c'] = 'Search all commands' | endif

"     nnoremap <silent> <leader>s/ :History/<CR>
"     nnoremap <silent> <leader>s: :History:<CR>
"     nnoremap <silent> <leader>sc :Commands<CR>
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

if has_key(plugs, 'vim-which-key') | let g:g_map['#']      = 'ex-search-unbounded-word-backward' | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['$']      = 'end-of-visual-line'                | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['&']      = 'ex-repeat-substitute'              | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['*']      = 'ex-search-unbounded-word-forward'  | endif
if has_key(plugs, 'vim-which-key') | let g:g_map[',']      = 'goto-last-change-reverse'          | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['-']      = 'number/dec-at-point'               | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['0']      = 'beginning-of-visual-line'          | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['8']      = 'what-cursor-position'              | endif
if has_key(plugs, 'vim-which-key') | let g:g_map[';']      = 'goto-last-change'                  | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['=']      = 'number/inc-at-point'               | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['?']      = 'rot13'                             | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['@']      = 'apply-macro'                       | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['^']      = 'first-non-blank-of-visual-line'    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['_']      = 'last-non-blank'                    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['a']      = 'what-cursor-position'              | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['c']      = 'comment-operator'                  | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['d']      = '+lookup definition'                | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['e']      = 'backward-word-end'                 | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['E']      = 'backward-WORD-end'                 | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['f']      = '+lookup file'                      | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['F']      = 'find-file-at-point-with-line'      | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['g']      = 'goto-first-line'                   | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['i']      = 'insert-resume'                     | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['j']      = 'next-visual-line'                  | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['J']      = 'join-whitespace'                   | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['k']      = 'previous-visual-line'              | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['l']      = 'lion-left'                         | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['L']      = 'lion-right'                        | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['m']      = 'middle-of-visual-line'             | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['M']      = 'percentage-of-line'                | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['n']      = 'next-match'                        | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['N']      = 'previous-match'                    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['o']      = 'goto-char'                         | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['p']      = 'reselect-paste'                    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['q']      = 'fill-and-move'                     | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['Q']      = '+format region'                    | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['r']      = '+eval region'                      | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['R']      = '+eval/buffer'                      | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['s']      = '+prefix'                           | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['t']      = '+workspace switch-next '           | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['T']      = '+workspace switch-previous'        | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['u']      = 'downcase'                          | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['U']      = 'upcase'                            | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['v']      = 'visual-restore'                    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['w']      = 'fill'                              | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['y']      = 'yank-unindented'                   | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['~']      = 'invert-case'                       | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['<C-]>']  = 'projectile-find-tag'               | endif
" if has_key(plugs, 'vim-which-key') | let g:g_map['<C-g>']  = 'count-words'                       | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['<Down>'] = 'next-visual-line'                  | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['<End>']  = 'end-of-visual-line'                | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['<Home>'] = 'first-non-blank-of-visual-line'    | endif
if has_key(plugs, 'vim-which-key') | let g:g_map['<Up>']   = 'previous-visual-line'              | endif

map g# g#
map g$ g$
map g& g&
map g* g*
map g, g,
map g- <C-x>
map g0 g0
map g8 g8
map g; g;
map g= <C-a>
map g? g?
map g^ g^
map g_ g_
map ga ga
map gc gc
map gd gd
map ge ge
map gE gE
map gf gf
map gF gF
map gg gg
map gi gi
map gj gj
map gJ gJ
map gk gk
map gl gl
map gL gL
map gm gm
map gM gM
map gn gn
map gN gN
map go go
map gq gq
map gt gt
map gT gT
map gu gu
map gU gU
map gv gv
map gw gw
map g~ g~
map g<Down> g<Down>
map g<End> g<End>
map g<Home> g<Home>
map g<Up> g<Up>

if has_key(plugs, 'vim-exchange')
    if has_key(plugs, 'vim-which-key') | let g:g_map["x"] = 'exchange' | endif

    nmap gx <Plug>(Exchange)
    nmap gxx <Plug>(ExchangeLine)
    nmap gxc <Plug>(ExchangeClear)
    xmap gx <Plug>(Exchange)
endif

if has_key(plugs, 'coc.nvim')
    " if has_key(plugs, 'vim-which-key') | let g:g_map['A'] = '+lookup assignments'     | endif
    if has_key(plugs, 'vim-which-key') | let g:g_map['d'] = '+lookup definition'      | endif
    if has_key(plugs, 'vim-which-key') | let g:g_map['D'] = '+lookup references'      | endif
    if has_key(plugs, 'vim-which-key') | let g:g_map['I'] = '+lookup implementations' | endif
    
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gD <Plug>(coc-references)
    nmap <silent> gI <Plug>(coc-implementation)
    " nmap <silent> gy <Plug>(coc-type-definition)
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

if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['"'] = 'which_key_ignore'                 | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map[' '] = ['[o', 'Insert newline above']     | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['#'] = 'Previous preproc directive'       | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map["'"] = 'Previous mark line'               | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['('] = 'Previous open paren'              | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['['] = 'Backward section end'             | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map[']'] = 'Backward section begin'           | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['`'] = 'Previous mark'                    | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['a'] = 'Backward arg'                     | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['b'] = 'Previous buffer'                  | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['c'] = 'Previous comment'                 | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['f'] = 'Previous file'                    | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['h'] = 'Outline previous visible heading' | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['m'] = 'Previous beginning of method'     | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['M'] = 'Previous end of method'           | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['o'] = 'Insert newline above'             | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['s'] = '+spell Previous error'            | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['t'] = 'Hl todo previous'                 | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['u'] = 'Url decode'                       | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['w'] = '+workspace Switch left'           | endif
" if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['y'] = 'C string decode'                  | endif
if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['{'] = 'Previous open brace'              | endif

if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['"'] = 'which_key_ignore'                 | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map[' '] = [']o', 'Insert newline below']     | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['#'] = 'Next preproc directive'           | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map["'"] = 'Next mark line'                   | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map[')'] = 'Next close paren'                 | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['['] = 'Forward section end'              | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map[']'] = 'Forward section begin'            | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['`'] = 'Next mark'                        | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['a'] = 'Forward arg'                      | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['b'] = 'Next buffer'                      | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['c'] = 'Next comment'                     | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['f'] = 'Next file'                        | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['h'] = 'Outline next visible heading'     | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['m'] = 'Next beginning of method'         | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['M'] = 'Next end of method'               | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['o'] = 'Insert newline below'             | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['s'] = '+spell Next error'                | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['t'] = 'Hl todo next'                     | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['u'] = 'Url encode'                       | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['w'] = '+workspace Switch right'          | endif
" if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['y'] = 'C string encode'                  | endif
if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['}'] = 'Next close brace'                 | endif

nmap <silent> [<Space> [o
nmap <silent> ]<Space> ]o
nmap <silent> [b :bprevious<cr>
nmap <silent> ]b :bnext<cr>
nmap ]c ]"
nmap [c ["
nmap <silent> [o :call append(line('.')-1, '')<cr>
nmap <silent> ]o :call append(line('.'), '')<cr>
nmap [s [s
nmap ]s ]s
nmap <silent> [w :tabprevious<cr>
nmap <silent> ]w :tabnext<cr>
nmap [{ [{
nmap ]} ]}

if has_key(plugs, 'vim-gitgutter')
    if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map.d = '+git Previous hunk' | endif
    if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map.d = '+git Next hunk'     | endif
    
    nmap [d <Plug>(GitGutterPrevHunk)
    nmap ]d <Plug>(GitGutterNextHunk)
endif

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key') | let g:l_sqr_bracket_map['e'] = 'Previous error' | endif
    if has_key(plugs, 'vim-which-key') | let g:r_sqr_bracket_map['e'] = 'Next error'     | endif
    
    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)
endif

nnoremap <Up> :blast<cr>
nnoremap <Down> :bfirst<cr>
nnoremap <Left> :bprevious<cr>
nnoremap <Right> :bnext<cr>

noremap <tab> :norm za<cr>
noremap <tab><tab> :norm zA<cr>
noremap <S-tab> :norm zR<cr>
noremap <S-tab><S-tab> :norm zM<cr>

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <A-x> :

nnoremap <A-k> :m-2<cr>==
nnoremap <A-j> :m+<cr>==
vnoremap <A-k> :m '<-2<cr>gv=gv
vnoremap <A-j> :m '>+1<cr>gv=gv

if has_key(plugs, 'coc.nvim')
    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
endif
