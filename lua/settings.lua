local opt = vim.opt
local go = vim.go
local g = vim.g
local fn = vim.fn
local cmd = vim.cmd
-- Settings
cmd [[
filetype plugin indent on
syntax enable
colorscheme murphy
]]
opt.tags:remove('./tags')
opt.tags:remove('./tags;')
opt.tags:prepend('./tags;')

opt.autoindent = true
opt.autoread = true
opt.backspace = {'indent','eol','start'}
opt.complete:remove('i')
opt.cursorline = true            -- Neovim cursor is thin
opt.display:append('lastline')
opt.errorbells = false           -- Disable audible bells (default=false)
opt.fileencodings = ''            -- force to read with fileencoding
opt.formatoptions:append('j') -- Delete comment character when joining commented lines
opt.hidden = true                -- open another file without saving (default=false)
opt.incsearch = true
opt.laststatus = 2
opt.mouse = 'nivh'
opt.nrformats:remove('octal')
opt.paste = false                -- Set-up buffer pasting (default=false)
opt.ruler = true
opt.scrolloff = 1
opt.scrolloff = 7
opt.sessionoptions:remove('options')
opt.shada = [[!,'20,<5000,s10,h,/100]] -- 500 lines, 100 KiB size, shared data
opt.sidescrolloff = 5
opt.smartcase = true             -- case insensitive except capitals (default=false)
opt.smartindent =  true          -- autoindent + drop and pop after '{', '}'
opt.smarttab = true
opt.spell = true                 -- Enable spell check
opt.spelllang = 'en_us'          -- Spell check language as en_us
opt.statusline = '%<%f%m%r%h%w%=%y[U+%04B]%2l/%2L=%P,%2c%V' -- w/o airline
opt.undofile = true, buffer
opt.viewoptions:remove('options')
opt.visualbell = false           -- Disable visual bells (default=false)
opt.wildignore = '*.o,*~,*.pyc'
opt.wildmenu = true
opt.wildmode = 'longest,full'
opt.wrap = false                 -- Don't wrap line (default=true)

--  Text formatting (Tab, ...)
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 0
opt.tabstop = 2
opt.textwidth = 160

--  Use faster 'rg' for :grep
if os.execute([[command -pV rg >/dev/null]]) then
  opt.grepprg = [[rg --no-heading --color=never --ignore-case --column]]
  opt.grepformat = [[%f:%l:%c:%m,%f:%l:%m]]
end

cmd [[
augroup vimcursor
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]]


-- Package Settings
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

if os.getenv('TERM') == 'linux' then
  g.airline_powerline_fonts = 0
  g.airline_symbols_ascii = 1
else
  g.airline_powerline_fonts = 1
end

g['airline#parts#ffenc#skip_expected_string'] = 'utf-8[unix]'

-- vim: set sw=2 sts=2 et ft=lua :
