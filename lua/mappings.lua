local cmd = vim.cmd
local g = vim.g
local opt = vim.opt
local map_key = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  -- noremap as default
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end
--  Remap keys -- Check with ':h index.txt' for original mapping
--  Leader/local leader
g.mapleader = [[ ]]                   -- Use <SPACE>
g.maplocalleader = [[,]]

--  mini scripts (use vim's native feature)
--  Following vim manual
map('n', 'Y', 'y$') -- reasonable in line with D == d$
map('n', 'n', 'nzz') -- jump and POV centered
map('n', 'N', 'Nzz') -- jump and POV centered
map('i', '<C-H>', '<C-G>u<C-H>') -- for better undo
map('i', '<C-W>', '<C-G>u<C-W>') -- for better undo
map('i', '<C-U>', '<C-G>u<C-U>') -- for better undo
map('i', '<CR>', '<C-]><C-G>u<CR>') -- for better undo

--  Shell (EMACS) style cursor moves
map({'c', 't', 'i'}, '<C-F>', '<Right>')
opt.cedit = [[<C-O>]] -- for COMMAND MODE
map({'c', 't', 'i'}, '<C-B>', '<Left>')
map('c', '<C-@>', '<C-D>') -- original-<C-D> indent access
map({'c', 't', 'i'}, '<C-D>', '<Del>')
map('c', '<C-_>', '<C-A>') -- insert all access
map({'c', 't'}, '<C-A>', '<Home>')
-- map({'c', 't'}, '<C-E>', '<End>') -- already so
-- INSERT MODE idiosyncrasies -- at least, move with 2-keys within line
--     <C-F> or <C-B> were unbound (use them)
--     <C-D> were bound to adjust indent (useless, autoindent+NORMAL)
--     HOME can be <Esc>I, END can be <Esc>A
-- COMMAND MODE idiosyncrasies -- more like shell
--     <C-F> was bound to <cedit> (now by <C-O>)
--     <C-B> was bound to begin of command-line (now by <C-A>)
--     <C-D> was bound to list completions (useless, use <space>)
--     <C-A> was bound to list completions (insert all) (use <C-_>)
--     <C-E> was bound to cursor to end of command-line (no change)
--  TERMINAL MODE
--     <C-N> is used as a part of  <C-\><C-N> and get remapped somehow
--     <C-P> is skipped for mapping to match unmapped <C-N>

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

--  Window moves by meta keys (avoid typing dangerous CTRL-W)
map({'n', 'v'}, [[<M-h>]], [[<C-W>h]])
map({'n', 'v'}, [[<M-j>]], [[<C-W>j]])
map({'n', 'v'}, [[<M-k>]], [[<C-W>k]])
map({'n', 'v'}, [[<M-l>]], [[<C-W>l]])
map({'n', 'v'}, [[<M-=>]], [[<C-W>+]]) -- lower case + on US
map({'n', 'v'}, [[<M-->]], [[<C-W>-]]) --            -
map({'n', 'v'}, [[<M-,>]], [[<C-W>>]]) -- lower case <
map({'n', 'v'}, [[<M-.>]], [[<C-W><]]) -- lower case >
map({'n', 'v'}, [[<M-f>]], [[<C-W>r]])
map({'n', 'v'}, [[<M-b>]], [[<C-W>R]])
map({'n', 'v'}, [[<M-/>]], [[<C-W>=]]) -- since = is used use /

--  Key Board MACRO with @q/@1/@2 and Q/<F2>/<F3>
map('n', 'Q', '@q')
map('v', 'Q', ':norm @q<cr>')
map('n', '<F2>', '@2')
map('v', '<F2>', ':norm @2<cr>')
map('n', '<F3>', '@3')
map('v', '<F3>', ':norm @3<cr>')
map('n', '<leader>=', 'gg=G') --  Reformat
map('n', '<leader>z', 'zO') --  I can't remember all z-things, just a temporary relief
-- map('n', '<leader>id', [[:unlet $TZ<CR>a<C-r>=strftime('%Y-%m-%d')<CR>]]) --   2021-09-08
-- map('n', '<leader>is', [[:unlet $TZ<CR>a<C-r>=strftime('%Y-%m-%dT%H:%M:%S')<CR>]]) --  2021-09-08T12:08:40
map('n', '<leader>iu', [[:let $TZ=0<CR>a<C-r>=strftime('%Y-%m-%dT%H:%M:%S+00:00')<CR><ESC>:unlet $TZ<CR>]], {silent = true}) --  2021-09-08T03:08:27+00:00

--  Select highlighted section and set search/replace/highlight (NORMAL, VISUAL)
--    More flexible than # *
map('n', '<leader><leader>', [[yiw:let @/ = '\<' . '<C-R>"' . '\>' <CR>:set hlsearch<CR>]], {silent = true})
map('v', '<leader><leader>', [[y:let @/ = '\V' . escape('<C-R>"', '\')<CR>:set hlsearch<CR>]], {silent = true})
map('n', '<leader>r', [[:<C-u>%s%<C-r>/%<C-r>"%gc<Left><Left><Left>]])
map('v', '<leader>r', [[:s%<C-r>/%<C-r>"%gc<Left><Left><Left>]])
map({'n', 'v'}, '<C-L>', [[:nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>]], {silent = true}) --  no highlight and refresh screen

map({'n', 'v'}, '<leader><CR>', [[:term<CR>i]]) --  NORMAL -> TERM: open terminal on current window (and on prompt)
--  This <Esc><Esc> is easier to type than <C-\><C-N>
--       ... wait for more than a second between <Esc>s to send <Esc>s
map('t', [[<Esc><Esc>]], [[<C-\><C-N>]])
--  This <Esc><Esc> avoids crashing fzf menu running in TERMINAL MODE (:q if you do)
--    https://github.com/junegunn/fzf.vim/issues/544
--    https://vi.stackexchange.com/questions/2614/why-does-this-esc-normal-mode-mapping-affect-startup
--    https://vi.stackexchange.com/questions/24925/usage-of-timeoutlen-and-ttimeoutlen

opt.pastetoggle = [[<leader>p]] --    PASTE MODE toggle
map('n', '<leader>w', [[:WMToggle<CR>]]) --  WinManager: toggle
map('n', '<leader>b', [[:ToggleBufExplorer<CR>]]) --  BufExplorer:  toggle
map('n', '<leader>e', [[:StripWhitespace<CR>]]) --  StripSpaces at EOL
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
