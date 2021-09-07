local o = vim.o
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
local map_key = vim.api.nvim_set_keymap
local function map(modes, lhs, rhs, opts)
  opts = opts or {}
  -- noremap as default
  opts.noremap = opts.noremap == nil and true or opts.noremap
  if type(modes) == 'string' then modes = {modes} end
  for _, mode in ipairs(modes) do map_key(mode, lhs, rhs, opts) end
end
-- Settings
o.spelllang = 'en_us'          -- Spell check language as en_us
o.spell = true                 -- Enable spell check
o.smartindent =  true          -- autoindent + drop and pop after '{', '}'
o.statusline = '%<%f%m%r%h%w%=%y[U+%04B]%2l/%2L=%P,%2c%V' -- w/o airline
o.hidden = true                -- open another file without saving (default=false)
o.errorbells = false           -- Disable audible bells (default=false)
o.visualbell = false           -- Disable visual bells (default=false)
o.wrap = false                 -- Don't wrap line (default=true)
o.paste = false                -- Set-up buffer pasting (default=false)
o.shada = [['20,<5000,s10,h,/100]] -- 500 lines, 100 KiB size
o.scrolloff = 7
o.wildignore = '*.o,*~,*.pyc'
o.wildmode = 'longest,full'
o.cursorline = true            -- Neovim cursor is thin
o.undofile = true, buffer
o.mouse = 'nivh'
o.smartcase = true             -- case insensitive except capitals (default=false)
--      neovim encoding is always utf-8
o.fileencodings = ''            -- force to read with fileencoding
--      neovim use shada instead of viminfo

--  Text formatting (Tab, ...)
o.textwidth = 160
o.tabstop = 2
o.softtabstop = 0
o.expandtab = true
o.shiftwidth = 2

--    PASTE MODE toggle
--      Use ' p' in NORMAL MODE for paste mode toggle
o.pastetoggle = [[<leader>p]]
--   Offer original <C-F> function to start COMMAND NORMAL HISTORY MODE
--   from unused CTRL-O (mc like)
o.cedit = [[<C-O>]]
--  mini scripts (use vim's native feature)
--  Use faster 'rg' for :grep
if os.execute([[command -pV rg >/dev/null]]) then
  o.grepprg = [[rg --no-heading --color=never --ignore-case --column]]
  o.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]
end

cmd [[
augroup vimcursor
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]]

--  Leader/local leader
g.mapleader = [[ ]]                   -- Use <SPACE>
g.maplocalleader = [[,]]
g.spell_under = 'murphy'              -- set color
g.better_whitespace_enabled=1         -- nicer than `:set list`
g.better_whitespace_filetypes_blacklist={'diff'}    -- practically no blacklist
g.strip_max_file_size=0               --  Disable
g.strip_whitespace_on_save=0          --  Don't auto strip whitespace
g.show_spaces_that_precede_tabs=1     --  highlight stray spaces
g.strip_whitelines_at_eof=1           --  Enable stripping white lines at EOF
g.indent_guides_enable_on_vim_startup = 1

g.ale_enabled = false -- initially disable ALE.
g.ale_lint_on_text_changed = 'never' -- No linters upon change
g.ale_lint_on_enter = 1 -- No linters upon opening a file
g.ale_lint_on_insert_leave = 1 -- No linters upon leaving INSERT
--g.ale_linters = {python = {1 = 'flake8'}}
cmd [[ let g:ale_linters = {'python': ['flake8']}  ]] -- RED only, Use this, faster
--  cmd [[let g:ale_linters = {'python': ['flake8', 'pylint']}]]
--  cmd [[let g:ale_linters = {'python': ['pylint']}]] -- YELLOW (MANY)
--  cmd [[let g:ale_linters = {'python': ['mypy']}]]

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

g.gitgutter_enabled = 0 --  initially disable gitgutter

if os.getenv('TERM') == 'linux' then
  g.airline_powerline_fonts = 0
  g.airline_symbols_ascii = 1
else
  g.airline_powerline_fonts = 1
end

g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'

-- Remap keys (non-<LEADER>

map('n', 'Y', 'y$') -- reasonable nocompatible system


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
--  See FZF above how TERM -> NORMAL is done safely with <Esc>
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
