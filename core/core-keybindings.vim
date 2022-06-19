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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'vertical h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

if has_key(plugs, 'vim-which-key')
    " let g:which_key_map['<Esc>'] = 'Reset/Cleanup'
    let g:which_key_map[',']     = 'Switch workspace buffer'
    let g:which_key_map['<']     = 'Switch buffer'
    let g:which_key_map['`']     = 'Switch to last buffer'
endif

" Can cause issues
nnoremap <silent> <Esc> :call ClearAll()<cr>

" nnoremap <silent> <leader><Esc> :call ClearAll()<cr>
nnoremap <leader>, :BufExplorerHorizontalSplit<cr>
nnoremap <leader>< :Buffers<cr>
nnoremap <leader>` :b#<cr>

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map[' '] = ['GFiles', 'Find file in project' ]
    endif

    nnoremap <leader><Space> :GFiles<cr>
endif

if has_key(plugs, 'vim-gitgutter')
    " Select current hunk
    omap ic <Plug>(GitGutterTextObjectInnerPending)
    omap ac <Plug>(GitGutterTextObjectOuterPending)
    xmap ic <Plug>(GitGutterTextObjectInnerVisual)
    xmap ac <Plug>(GitGutterTextObjectOuterVisual)
endif

if has_key(plugs, 'vim-which-key')
    " let g:which_key_map['<Tab>']       = { 'name' : '+workspace' }
    " let g:which_key_map.['<Tab>']['.'] = 'Switch workspace'
    " let g:which_key_map['<Tab>']['0']  = 'Switch to final workspace'
    " let g:which_key_map['<Tab>']['1']  = 'Switch to 1st workspace'
endif

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

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.b      = { 'name' : '+buffer' }
    let g:which_key_map.b['['] = 'Previous buffer'
    let g:which_key_map.b[']'] = 'Next buffer'
    let g:which_key_map.b['b'] = 'Switch workspace buffer'
    let g:which_key_map.b['B'] = 'Switch buffer'
    let g:which_key_map.b['d'] = 'Kill buffer'
    let g:which_key_map.b['i'] = 'ibuffer'
    let g:which_key_map.b['k'] = 'Kill buffer'
    let g:which_key_map.b['K'] = 'Kill all buffers'
    let g:which_key_map.b['l'] = 'Switch to last buffer'
    let g:which_key_map.b['L'] = 'List bookmarks'
    let g:which_key_map.b['n'] = 'Next buffer'
    let g:which_key_map.b['N'] = 'New empty buffer'
    let g:which_key_map.b['O'] = 'Kill other buffers'
    let g:which_key_map.b['p'] = 'Previous buffer'
    let g:which_key_map.b['r'] = 'Revert buffer'
    let g:which_key_map.b['s'] = 'Save buffer'
    let g:which_key_map.b['S'] = 'Save all buffers'
    let g:which_key_map.b['u'] = 'Save buffer as root'
endif

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

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.c = { 'name' : '+code' }
endif

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.c      = { 'name' : '+code' }
        let g:which_key_map.c['a'] = 'LSP Execute code action'
        let g:which_key_map.c['d'] = 'Jump to definition'
        let g:which_key_map.c['D'] = 'Jump to references'
        let g:which_key_map.c['f'] = 'Format buffer/region'
        let g:which_key_map.c['i'] = 'Find implementations'
        let g:which_key_map.c['j'] = 'Jump to symbol in current workspace'
        let g:which_key_map.c['j'] = 'Jump to symbol in any workspace'
        let g:which_key_map.c['k'] = 'Jump to documentation'
        let g:which_key_map.c['x'] = 'List errors'
        let g:which_key_map.c['t'] = 'Find type definition'
    endif

    " do codeAction of current line
    nmap <leader>ca <Plug>(coc-codeaction)
    nnoremap <silent> <leader>cd <Plug>(coc-definition)
    nnoremap <silent> <leader>cD <Plug>(coc-references)
    xmap <leader>cf <Plug>(coc-format-selected)
    nmap <leader>cf <Plug>(coc-format-selected)
    nnoremap <silent> <leader>ci <Plug>(coc-implementation)
    " Find symbol of current document
    nnoremap <silent> <leader>cj :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <leader>cJ :<C-u>CocList -I symbols<cr>
    nnoremap <silent> <leader>ck :call <SID>show_documentation()<CR>
    nnoremap <silent> <leader>cx :<C-u>CocList diagnostics<cr>
    nnoremap <silent> <leader>ct <Plug>(coc-type-definition)




    " do codeAction of selected region, ex: `<leader>aap` for current paragraph
    " xmap <leader>cv <Plug>(coc-codeaction-selected)
    " nmap <leader>cv <Plug>(coc-codeaction-selected)
    " let g:which_key_map.c['v'] = 'Code action selected'

    " Fix autofix problem of current line
    " nmap <leader>ca  <Plug>(coc-fix-current)
    " let g:which_key_map.c['a'] = 'Fix current'


    " Manage extensions
    " nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
    " let g:which_key_map.c['e'] = 'Extensions'

    " Show commands
    " nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
    " let g:which_key_map.c['c'] = 'Commands'

    " nnoremap <silent> <leader>cj  :<C-u>CocNext<CR>
    " let g:which_key_map.c['j'] = 'Default action for next item'

    " nnoremap <silent> <leader>ck  :<C-u>CocPrev<CR>
    " let g:which_key_map.c['k'] = 'Default action for previous item'

endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.f      = { 'name' : '+file' }          
    let g:which_key_map.f['c'] = 'CD to current directory'
    " let g:which_key_map.f['c'] = 'Open project editorconfig'
    " let g:which_key_map.f['C'] = 'Copy this file'
    " let g:which_key_map.f['d'] = 'Find directory'
    let g:which_key_map.f['D'] = 'Delete this file'
    let g:which_key_map.f['E'] = 'Browse vim.d'
    let g:which_key_map.f['P'] = 'Browse private config'
    " let g:which_key_map.f['R'] = 'Rename/move file'
    let g:which_key_map.f['s'] = 'Save file'
    let g:which_key_map.f['S'] = 'Save as...'
    " let g:which_key_map.f['u'] = 'Sudo find file'
    " let g:which_key_map.f['U'] = 'Sudo this file'
    let g:which_key_map.f['y'] = 'Yank file path'
    let g:which_key_map.f['Y'] = 'Yank file path from project'
    let g:which_key_map.f['v'] = 'Grep?'
endif

nnoremap <leader>fc :cd %:p:h<cr>:pwd<cr>
nnoremap <silent> <leader>fD :if confirm('Really delete "' . expand('%') . '"?', "&Yes\n&No", 1)==1 <Bar> exe ":call delete(@%)" <Bar> exe ":Bclose" <Bar> endif<cr>
nnoremap <leader>fE :Hexplore ~/.vim/core<cr>
nnoremap <leader>fP :Hexplore ~/.vim<cr>
nnoremap <leader>fs :write<cr>
nnoremap <leader>fS :write
nnoremap <leader>fy :let @" = expand('%:p')<cr>:let @+ = expand('%:p')<cr>:echo "Copied path to clipboard: " . expand('%:p')<cr>
nnoremap <leader>fY :let @" = expand('%')<cr>:let @+ = expand('%')<cr>:echo "Copied path to clipboard: " . expand('%')<cr>
nnoremap <leader>fv :vimgrep **/*

if has_key(plugs, 'fzf' )
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.f['e'] = 'Find file in vim.d'          
        " let g:which_key_map.f['f'] = 'Find file'
        let g:which_key_map.f['F'] = 'Find file from here'
        let g:which_key_map.f['l'] = 'Locate file'
        let g:which_key_map.f['p'] = 'Find file in private config'
        let g:which_key_map.f['r'] = 'Recent files'
    endif

    map <leader>fe :Files ~/.vim/core<CR>
    map <leader>fF :Files<CR>
    map <leader>fl :Locate
    map <leader>fp :Files ~/.vim<CR>
    map <leader>fr :History<CR>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.g = { 'name' : '+git' }
endif

if has_key(plugs, 'vim-gitgutter')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.g['['] = 'Jump to previous hunk'
        let g:which_key_map.g[']'] = 'Jump to next hunk'
        let g:which_key_map.g['p'] = 'Preview hunk'
        let g:which_key_map.g['s'] = 'Git stage hunk'
        let g:which_key_map.g['r'] = 'Revert hunk'
    endif

    nmap <leader>g[ <Plug>(GitGutterPrevHunk)
    nmap <leader>g] <Plug>(GitGutterNextHunk)
    nmap <leader>gp <Plug>(GitGutterPreviewHunk)
    nmap <leader>gs <Plug>(GitGutterStageHunk)
    nmap <leader>gr <Plug>(GitGutterUndoHunk)
endif

if has_key(plugs, 'vim-fugitive')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.g['d'] = 'Diff Split'
        let g:which_key_map.g['g'] = 'Status'
    endif
    
    nmap <silent> <leader>gd :Gvdiffsplit<cr>
    nmap <silent> <leader>gg :Git<cr>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.h           = { 'name' : '+help' }
    let g:which_key_map.h['<CR>']   = 'Info vim Manual'
    let g:which_key_map.h['?']      = 'Help for help'
    let g:which_key_map.h['e']      = 'View echo area messages'
    let g:which_key_map.h['i']      = 'Show version info'
    let g:which_key_map.h['q']      = 'Help quit'
    let g:which_key_map.h['v']      = 'Show version info'
    let g:which_key_map.h['<F1>']   = 'Help for help'
    let g:which_key_map.h['<Help>'] = 'Help for help'
endif

nnoremap <silent> <leader>h<CR> :help<cr>
nnoremap <silent> <leader>h? :help helphelp<cr>
nnoremap <silent> <leader>he :messages<cr>
nnoremap <silent> <leader>hi :version<cr>
nnoremap <silent> <leader>hq :helpclose<cr>
nnoremap <silent> <leader>hv :version<cr>
nnoremap <silent> <leader>h<F1> :help helphelp<cr>
nnoremap <silent> <leader>h<Help> :help helphelp<cr>

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.h['k'] = 'Describe key'
        let g:which_key_map.h['s'] = 'Help search headings'
        let g:which_key_map.h['t'] = 'Load theme'
    endif

    nnoremap <silent> <leader>hk :Maps<cr>
    nnoremap <silent> <leader>hs :Helptags<cr>
    nnoremap <silent> <leader>ht :Colors<cr>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.h.r      = { 'name' : '+reload' }
    let g:which_key_map.h.r['f'] = 'Reload this file'
    let g:which_key_map.h.r['p'] = 'Reload packages'
    let g:which_key_map.h.r['r'] = 'Reload'
    let g:which_key_map.h.r['t'] = 'Reload theme'
endif

nnoremap <silent> <leader>hrf :source % <Bar> echo "Current file successfully reloaded!"<cr>
nnoremap <silent> <leader>hrp :PlugInstall --sync<cr>
nnoremap <silent> <leader>hrr :source $MYVIMRC<cr>
nnoremap <silent> <leader>hrt :execute 'colorscheme ' . g:colors_name<cr>

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.i      = { 'name' : '+insert' }
    let g:which_key_map.i['f'] = 'Current file name'
    let g:which_key_map.i['F'] = 'Current file path'
    let g:which_key_map.i['p'] = 'Evil ex path'
    let g:which_key_map.i['t'] = 'Toilet pagga'
endif

" nnoremap <silent> <leader>if :normal "%p<cr>
nnoremap <silent> <leader>if a<C-r>=expand("%:t")<cr><esc>
nnoremap <silent> <leader>iF a<C-r>=expand("%:p")<cr><esc>
nnoremap <leader>ip :r !echo 
nnoremap <leader>it :r !toilet -f pagga

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.o      = { 'name' : '+open' }
    let g:which_key_map.o['-'] = 'Netrw'
    let g:which_key_map.o['b'] = 'Default browser'
    let g:which_key_map.o['o'] = 'Reveal in finder'
endif

nnoremap <leader>o- :Explore<cr>
nnoremap <leader>ob <Plug>NetrwBrowseX
nnoremap <leader>oo :call Reveal_In_Files()<cr>

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.o['p'] = 'Project sidebar'
        " let g:which_key_map.o['P'] = 'Find file in project sidebar'
    endif

    nnoremap <leader>op :CocCommand explorer<cr>
endif

if has_key(plugs, 'vim-floaterm')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.o['-'] = 'Vifm'
        let g:which_key_map.o['t'] = 'Toggle term popup'
    endif

    nnoremap <silent> <leader>ot :FloatermToggle<cr>
    nnoremap <silent> <leader>o- :FloatermNew vifm<cr>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.p = { 'name' : '+project' }
endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.p['f'] = 'Find file in project'
    endif

    nnoremap <leader>pf :GFiles<cr>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.q      = { 'name' : '+quit/session' }
    let g:which_key_map.q['l'] = 'Restore last session'
    let g:which_key_map.q['L'] = 'Restore session from file'
    let g:which_key_map.q['q'] = 'Quit Vim'
    let g:which_key_map.q['Q'] = 'Quit Vim without saving'
    let g:which_key_map.q['s'] = 'Quick save current session'
    let g:which_key_map.q['S'] = 'Save session to file'
endif

nnoremap <silent> <leader>ql :source $HOME/.vim/.local/etc/workspaces/quick-session.vim<cr>
nnoremap <silent> <leader>qL :source $HOME/.vim/.local/etc/workspaces/
nnoremap <silent> <leader>qq :qa<cr>
nnoremap <silent> <leader>qQ :qa!<cr>
nnoremap <silent> <leader>qs :mksession! $HOME/.vim/.local/etc/workspaces/quick-session.vim<cr>
nnoremap <silent> <leader>qS :mksession $HOME/.vim/.local/etc/workspaces/

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.s = { 'name' : '+search' }
endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.s['b'] = 'Search buffer'
        let g:which_key_map.s['B'] = 'Search all open buffers'
        let g:which_key_map.s['p'] = 'Search project'
        let g:which_key_map.s['r'] = 'Jump to mark'
        let g:which_key_map.s['t'] = 'Search Tags in buffer'
        let g:which_key_map.s['T'] = 'Search Tags in all buffers'
    endif
    
    nnoremap <leader>sb :BLines<CR>
    nnoremap <leader>sB :Lines<CR>
    nnoremap <leader>sp :Rg<CR>
    nnoremap <leader>sr :Marks<CR>
    nnoremap <leader>st :BTags<CR>
    nnoremap <leader>sT :Tags<CR>
    
    " let g:which_key_map.s['/'] = 'Search history'
    " let g:which_key_map.s[':'] = 'Commands history'
    " let g:which_key_map.s['c'] = 'Search all commands'

"     nnoremap <silent> <leader>s/ :History/<CR>
"     nnoremap <silent> <leader>s: :History:<CR>
"     nnoremap <silent> <leader>sc :Commands<CR>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.t      = { 'name' : '+toggle' }
    let g:which_key_map.t['l'] = 'Line numbers'
    let g:which_key_map.t['p'] = 'Paste mode'
    let g:which_key_map.t['w'] = 'Soft line wrapping'
    let g:which_key_map.t['r'] = 'Read-only mode'
    let g:which_key_map.t['s'] = 'Spell checker'
    let g:which_key_map.t['|'] = 'Fill column indicator'
endif

nnoremap <leader>tl :call Cycle_LineNumbers()<cr>
nnoremap <leader>tp :call Toggle_Mode('paste'   , 'Paste mode enabled in current buffer'      , 'Paste mode disabled in current buffer')<cr>
nnoremap <leader>tw :call Toggle_Mode('wrap'    , 'Visual-Line mode enabled in current buffer', 'Visual-Line mode disabled in current buffer')<cr>
nnoremap <leader>tr :call Toggle_Mode('readonly', 'Read-Only mode enabled in current buffer'  , 'Read-Only mode disabled in current buffer')<cr>
nnoremap <leader>ts :call Toggle_Mode('spell'   , 'Spell mode enabled in current buffer'      , 'Spell mode disabled in current buffer')<cr>
nnoremap <leader>t\| :call Toggle_FillColumn()<cr>

if has_key(plugs, 'vim-minimap')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.t['m']      = 'Minimap'
        let g:which_key_map.t['M']      = { 'name' : '+minimap...' }
        let g:which_key_map.t['M']['c'] = 'Close minimap'
        let g:which_key_map.t['M']['o'] = 'Open minimap'
        let g:which_key_map.t['M']['u'] = 'Update minimap'
    endif
    
    let g:minimap_show='<leader>tMo'
    let g:minimap_update='<leader>tMu'
    let g:minimap_close='<leader>tMc'
    let g:minimap_toggle='<leader>tm'
endif

if has_key(plugs, 'Colorizer')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.t['c'] = 'Colors'
    endif

    nnoremap <leader>tc :call Toggle_Rainbow()<cr>
endif

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.w      = { 'name' : '+window' }
    let g:which_key_map.w['+'] = 'Increase window height'
    let g:which_key_map.w['-'] = 'Decrease window height'
    let g:which_key_map.w['<'] = 'Decrease window width'
    let g:which_key_map.w['='] = 'Balance windows'
    let g:which_key_map.w['>'] = 'Increase window width'
    let g:which_key_map.w['_'] = 'Set window height'
    let g:which_key_map.w['`'] = 'Open a terminal in a split'
    let g:which_key_map.w['b'] = 'Bottom right window'
    let g:which_key_map.w['c'] = 'Close window'
    let g:which_key_map.w['d'] = 'Close window'
    let g:which_key_map.w['h'] = 'Left window'
    let g:which_key_map.w['H'] = 'Move window left'
    let g:which_key_map.w['j'] = 'Down window'
    let g:which_key_map.w['J'] = 'Move window down'
    let g:which_key_map.w['k'] = 'Up window'
    let g:which_key_map.w['K'] = 'Move window up'
    let g:which_key_map.w['l'] = 'Right window'
    let g:which_key_map.w['L'] = 'Move window right'
    let g:which_key_map.w['n'] = 'New window'
    let g:which_key_map.w['o'] = 'Enlargen window'
    let g:which_key_map.w['p'] = 'Last window'
    let g:which_key_map.w['q'] = 'Quit window'
    let g:which_key_map.w['r'] = 'Rotate windows downwards'
    let g:which_key_map.w['R'] = 'Rotate windows upwards'
    let g:which_key_map.w['s'] = 'Split window'
    let g:which_key_map.w['S'] = 'Split and follow window'
    let g:which_key_map.w['t'] = 'Top left window'
    let g:which_key_map.w['T'] = 'Tear off window'
    let g:which_key_map.w['v'] = 'VSplit window'
    let g:which_key_map.w['V'] = 'VSplit and follow window'
    let g:which_key_map.w['w'] = 'Next window'
    let g:which_key_map.w['W'] = 'Previous window'
    let g:which_key_map.w['|'] = 'Set window width'
endif

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

if has_key(plugs, 'vim-which-key')
    let g:g_map['#']      = 'ex-search-unbounded-word-backward'
    let g:g_map['$']      = 'end-of-visual-line'
    let g:g_map['&']      = 'ex-repeat-substitute'
    let g:g_map['*']      = 'ex-search-unbounded-word-forward'
    let g:g_map[',']      = 'goto-last-change-reverse'
    let g:g_map['-']      = 'number/dec-at-point'
    let g:g_map['0']      = 'beginning-of-visual-line'
    let g:g_map['8']      = 'what-cursor-position'
    let g:g_map[';']      = 'goto-last-change'
    let g:g_map['=']      = 'number/inc-at-point'
    let g:g_map['?']      = 'rot13'
    " let g:g_map['@']      = 'apply-macro'
    let g:g_map['^']      = 'first-non-blank-of-visual-line'
    let g:g_map['_']      = 'last-non-blank'
    let g:g_map['a']      = 'what-cursor-position'
    let g:g_map['c']      = 'comment-operator'
    let g:g_map['d']      = '+lookup definition'
    let g:g_map['e']      = 'backward-word-end'
    let g:g_map['E']      = 'backward-WORD-end'
    let g:g_map['f']      = '+lookup file'
    let g:g_map['F']      = 'find-file-at-point-with-line'
    let g:g_map['g']      = 'goto-first-line'
    let g:g_map['i']      = 'insert-resume'
    let g:g_map['j']      = 'next-visual-line'
    let g:g_map['J']      = 'join-whitespace'
    let g:g_map['k']      = 'previous-visual-line'
    let g:g_map['l']      = 'lion-left'
    let g:g_map['L']      = 'lion-right'
    let g:g_map['m']      = 'middle-of-visual-line'
    let g:g_map['M']      = 'percentage-of-line'
    let g:g_map['n']      = 'next-match'
    let g:g_map['N']      = 'previous-match'
    let g:g_map['o']      = 'goto-char'
    " let g:g_map['p']      = 'reselect-paste'
    let g:g_map['q']      = 'fill-and-move'
    " let g:g_map['Q']      = '+format region'
    " let g:g_map['r']      = '+eval region'
    " let g:g_map['R']      = '+eval/buffer'
    let g:g_map['t']      = '+workspace switch-next '
    let g:g_map['T']      = '+workspace switch-previous'
    let g:g_map['u']      = 'downcase'
    let g:g_map['U']      = 'upcase'
    let g:g_map['v']      = 'visual-restore'
    let g:g_map['w']      = 'fill'
    " let g:g_map['y']      = 'yank-unindented'
    let g:g_map['~']      = 'invert-case'
    " let g:g_map['<C-]>']  = 'projectile-find-tag'
    " let g:g_map['<C-g>']  = 'count-words'
    let g:g_map['<Down>'] = 'next-visual-line'
    let g:g_map['<End>']  = 'end-of-visual-line'
    let g:g_map['<Home>'] = 'first-non-blank-of-visual-line'
    let g:g_map['<Up>']   = 'previous-visual-line'
endif

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
" map gc gc
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
    if has_key(plugs, 'vim-which-key')
        let g:g_map['x'] = 'exchange'
    endif

    nmap gx <Plug>(Exchange)
    nmap gxx <Plug>(ExchangeLine)
    nmap gxc <Plug>(ExchangeClear)
    xmap gx <Plug>(Exchange)
endif

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key')
        " let g:g_map['A'] = '+lookup assignments'
        let g:g_map['d'] = '+lookup definition'
        let g:g_map['D'] = '+lookup references'
        let g:g_map['I'] = '+lookup implementations'
    endif

    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gD <Plug>(coc-references)
    nmap <silent> gI <Plug>(coc-implementation)
endif

" if has_key(plugs, 'vim-which-key')
"     let g:g_map['s'] = '+prefix' 
" endif

if has_key(plugs, 'vim-which-key')
    let g:z_map['+']    = 'scroll-bottom-line-to-top'
    let g:z_map['-']    = 'scroll-line-to-bottom'
    let g:z_map['.']    = 'scroll-line-to-center'
    let g:z_map['=']    = 'ispell-word'
    let g:z_map['^']    = 'scroll-top-line-to-bottom'
    let g:z_map['b']    = 'scroll-line-to-bottom'
    let g:z_map['g']    = 'add-word'
    let g:z_map['t']    = 'scroll-line-to-top'
    let g:z_map['z']    = 'scroll-line-to-center'
    let g:z_map['<CR>'] = 'scroll-line-to-top'
endif

map z= z=
map zg zg

if has_key(plugs, 'vim-which-key')
    let g:Z_map['Q'] = 'vim-quit'
    let g:Z_map['Z'] = 'save-modified-and-close'
endif

map ZQ ZQ
map ZZ ZZ

if has_key(plugs, 'vim-which-key')
    let g:l_sqr_bracket_map['"'] = 'which_key_ignore'
    let g:l_sqr_bracket_map[' '] = ['[o', 'Insert newline above']
    " let g:l_sqr_bracket_map['#'] = 'Previous preproc directive'
    " let g:l_sqr_bracket_map["'"] = 'Previous mark line'
    let g:l_sqr_bracket_map['('] = 'Previous open paren'
    let g:l_sqr_bracket_map['['] = 'Backward section end'
    let g:l_sqr_bracket_map[']'] = 'Backward section begin'
    " let g:l_sqr_bracket_map['`'] = 'Previous mark'
    " let g:l_sqr_bracket_map['a'] = 'Backward arg'
    let g:l_sqr_bracket_map['b'] = 'Previous buffer'
    let g:l_sqr_bracket_map['c'] = 'Previous comment'
    " let g:l_sqr_bracket_map['f'] = 'Previous file'
    " let g:l_sqr_bracket_map['h'] = 'Outline previous visible heading'
    " let g:l_sqr_bracket_map['m'] = 'Previous beginning of method'
    " let g:l_sqr_bracket_map['M'] = 'Previous end of method'
    let g:l_sqr_bracket_map['o'] = 'Insert newline above'
    let g:l_sqr_bracket_map['s'] = '+spell Previous error'
    " let g:l_sqr_bracket_map['t'] = 'Hl todo previous'
    " let g:l_sqr_bracket_map['u'] = 'Url decode'
    let g:l_sqr_bracket_map['w'] = '+workspace Switch left'
    " let g:l_sqr_bracket_map['y'] = 'C string decode'
    let g:l_sqr_bracket_map['{'] = 'Previous open brace'
endif

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
    if has_key(plugs, 'vim-which-key')
        let g:l_sqr_bracket_map.d = '+git Previous hunk'
        let g:r_sqr_bracket_map.d = '+git Next hunk'
    endif
    
    nmap [d <Plug>(GitGutterPrevHunk)
    nmap ]d <Plug>(GitGutterNextHunk)
endif

if has_key(plugs, 'coc.nvim')
    if has_key(plugs, 'vim-which-key')
        let g:l_sqr_bracket_map['e'] = 'Previous error'
        let g:r_sqr_bracket_map['e'] = 'Next error'
    endif
    
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

if has_key(plugs, 'vim-which-key')
    let g:which_key_map.m = { 'name' : '+<localleader>' }
endif

if has_key(plugs, 'fzf')
    if has_key(plugs, 'vim-which-key')
        let g:which_key_map.m['M'] = 'Switch major mode'
    endif

    nnoremap <silent> <leader>mM :Filetypes<CR>
endif

autocmd FileType help nmap <silent> q :helpclose<cr>
                   \| nmap <silent> <Esc> :helpclose<cr>

autocmd FileType fugitive nmap <silent> q gq
                       \| nmap <silent> <Esc> gq
