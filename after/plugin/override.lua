local o = vim.o
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
-- Settings

--  Text formatting (Tab, ...)
local override_width = 0      -- set this to 2, 4, 8 ... to enable
if override_width > 0 then
  o.tabstop = override_width
  o.shiftwidth = override_width
  o.textwidth = 160
  o.softtabstop = 0
  o.expandtab = true
end

-- Package Settings overrides

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

g.gitgutter_enabled = 0 --  initially disable gitgutter


g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'
if g.airline_symbols then
  g.airline_symbols.colnr = '' -- U+E0A3 is missing in hack font
end

o.timeoutlen=800              -- mapping delay in ms, default 1000
o.ttimeoutlen=10              -- keycode delay in ms, default 50

if not g.loaded_better_whitespace_plugin then
  o.list = true -- display non-printable tabs and newlines
  if vim.fn.has('multi_byte') and o.encoding == 'utf-8' then
    o.listchars = [[eol:¶,tab:⇄ ,trail:␣,extends:↦,precedes:↤,nbsp:␣]]
    -- o.listchars=[[eol:↲,tab:⇔ ,trail:␣,extends:»,precedes:«,nbsp:␣]]
    -- o.listchars=[[eol:↲,tab:▶ ,trail:□,extends:▶,precedes:◀,nbsp:□]]
  end
end

-- This must be the last setting. (light enough to run every time now)
cmd [[silent! helptags ALL]]

--  filler to avoid the line above being recognized as a modeline

-- vim: set sw=2 sts=2 et ft=lua :
