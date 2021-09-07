local cmd = vim.cmd
local map_key = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  -- noremap as default
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end
-- Remap keys (non-<LEADER>

-- Following vim manual
map('n', 'Y', 'y$') -- reasonable nocompatible system
map('i', '<C-U>', '<C-G>u<C-U>') -- for better undo
map('i', '<C-W>', '<C-G>u<C-W>') -- for better undo

--  Shell/EMACS style cursor moves
map({'c', 't', 'i'}, '<C-F>', '<Right>')
map({'c', 't', 'i'}, '<C-B>', '<Left>')
map({'c', 't', 'i'}, '<C-D>', '<Del>')
map({'c', 't'}, '<C-A>', '<Home>')
map({'c', 't'}, '<C-E>', '<End>')
map({'c', 't'}, '<C-P>', '<Up>')
map({'c', 't'}, '<C-N>', '<Down>')

--  NORMAL MODE
map('n', '[I', [[<Plug>QlistIncludefromtop]], {silent = true})
map('n', ']I', [[<Plug>QlistIncludefromhere]], {silent = true})
map('n', '[D', [[<Plug>QlistDefinefromtop]], {silent = true})
map('n', ']D', [[<Plug>QlistDefinefromhere]], {silent = true})
--  VISUAL MODE
map('x', '[I', [[<Plug>QlistIncludefromtopvisual]], {silent = true})
map('x', '[I', [[<Plug>QlistIncludefromherevisual]], {silent = true})
map('x', '[I', [[<Plug>QlistDefinefromtopvisual]], {silent = true})
map('x', '[I', [[<Plug>QlistDefinefromtopvisual]], {silent = true})

-- LEADER (1 char)

--  Window moves (avoid typing dangerous CTRL-W)
map({'n', 'v'}, '<leader>h', '<C-W>h')
map({'n', 'v'}, '<leader>j', '<C-W>j')
map({'n', 'v'}, '<leader>k', '<C-W>k')
map({'n', 'v'}, '<leader>l', '<C-W>l')

--  Key Board MACRO with @q/@1/@2 and Q/<F2>/<F3>
map('n', 'Q', '@q')
map('v', 'Q', ';norm @q<cr>')
map('n', '<F2>', '@2')
map('v', '<F2>', ':norm @2<cr>')
map('n', '<F3>', '@3')
map('v', '<F3>', ':norm @3<cr>')
map('n', '<leader>=', 'gg=G') --  ReFormatAll
map('n', '<leader>z', 'zO') --  I can't remember all z-things, just a temporary relief
--  Select highlighted section and set search/replace/highlight (NORMAL, VISUAL)
map('n', '<leader><leader>', [[yiw:let @/ = '\<' . '<C-R>"' . '\>' <CR>:set hlsearch<CR>]], {silent = true})
map('v', '<leader><leader>', [[y:let @/ = '\V' . escape('<C-R>"', '\')<CR>:set hlsearch<CR>]], {silent = true})
map('n', '<leader>r', [[%s%<C-r>/%<C-r>"%gc<Left><Left><Left>]])
--  Turn-off highlight and refresh screen as usual with <C-L> --> vim-sensible.vim takes care
map('n', '<leader><CR>', [[:term<CR>i]]) --  NORMAL -> TERM: open terminal on current window (and on prompt)
--  This avoids crashing fzf menu running in terminal with escape
--    https://github.com/junegunn/fzf.vim/issues/544
--    https://vi.stackexchange.com/questions/2614/why-does-this-esc-normal-mode-mapping-affect-startup
--    https://vi.stackexchange.com/questions/24925/usage-of-timeoutlen-and-ttimeoutlen
cmd [[
fun! RemapTerminalEsc()
  if &ft =~ 'fzf'
    silent! tunmap <buffer> <Esc><Esc>
  else
    " If <Esc> is typed slowly, it can skip this.  (compromise)
    silent! tnoremap <buffer> <Esc><Esc> <c-\><c-n>
  endif
endfun
augroup vimrc
  autocmd!
  autocmd BufEnter * silent! call RemapTerminalEsc()
augroup END
]]

map('n', '<leader>w', [[:WMToggle<CR>]]) --  WinManager: toggle _winmanager activity
map('n', '<leader>b', [[:ToggleBufExplorer<CR>]]) --  BufExplorer:  toggle
map('n', '<leader>e', [[:StripWhitespace<cr>]]) --  StripSpaces at EOL
-- Vim TABs
map('n', '<leader>1', '1gt<CR>')
map('n', '<leader>2', '2gt<CR>')
map('n', '<leader>3', '3gt<CR>')
map('n', '<leader>4', '4gt<CR>')
map('n', '<leader>5', '5gt<CR>')
map('n', '<leader>6', '6gt<CR>')
map('n', '<leader>7', '7gt<CR>')
map('n', '<leader>8', '8gt<CR>')
map('n', '<leader>9', '9gt<CR>')
map('n', '<leader>1', '1gt<CR>')

--  Rotate spell/syntax mode (default)
map('n', '<leader>s',  [[<Plug>RotateSpellSyntax]], {noremap = false})
--  ALE: toggle _ALE activity
map('n', '<leader>a',[[:ALEToggle<CR>]])

--- LEADER: 2 chars

--  GitGutter:
map('n', '<leader>gg',[[:GitGutterToggle<CR>]])
map('n', '<leader>gp',[[:GitGutterPreviewHunk<CR>]])
-- move to the preview window, e.g. :wincmd P / <C-W> P
map('n', '<leader>gs',[[:GitGutterStageHunk<CR>]])
map('n', '<leader>gu',[[:GitGutterUndoHunk<CR>]])

--  Fzf: CTRL-T:openTAB, CTRL-X:split-H, CTRL-V:split-V
map('n', '<leader>fb', ':Buffers<CR>')
map('n', '<leader>fc', ':Colors<CR>')
map('n', '<leader>ff', ':Files<CR>')
map('n', '<leader>gl', ':GFiles<CR>')
map('n', '<leader>gs', ':GFiles?<CR>')
map('n', '<leader>fm', ':Maps<CR>')
map('n', '<leader>fr', ':Rg<CR>')
map('n', '<leader>ft', ':Tags<CR>')
map('n', '<leader>fT', ':Filetypes<CR>')
map('n', '<leader>fv', ':History<CR>')
map('n', '<leader>fx', ':Commands<CR>')
map('n', '<leader>f/', ':History/<CR>')
map('n', '<leader>f:', ':History:<CR>')
map('n', '<leader>fh', ':Helptags<CR>')
map('n', '<leader>fM', ':Marks<CR>')
map('n', '<leader>fw', ':Windows<CR>')
--map('n', '<leader>fB', ':Btags<CR>')

-- vim: set sw=2 sts=2 et ft=lua :
