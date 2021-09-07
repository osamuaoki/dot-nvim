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

--  Text formatting (Tab, ...)
local override_width = 0      -- set this to 2, 4, 8 ... to enable
if override_width > 0 then
  o.tabstop = override_width
  o.shiftwidth = override_width
  o.textwidth = 160
  o.softtabstop = 0
  o.expandtab = true
end

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
