local ft = vim.ft
local cmd = vim.cmd

-- vim and vim-scripts in opt are not packer managed
cmd[[
packadd! secure-modelines
packadd! matchit
packadd! winmanager
packadd! bufexplorer
packadd! xmledit
packadd! po
packadd! gnupg
]]

-- make sure to do ':PackerSync' once in a while

require'packer'.startup({function(use)
  use{'wbthomason/packer.nvim'}
  -- Also run code after load (see the "config" key)
  use {'airblade/vim-gitgutter'}
  use {'dense-analysis/ale'}
  use {'bfredl/nvim-luadev'}
  use {'junegunn/fzf'}
  use {'junegunn/fzf.vim'}
  -- use {'glepnir/indent-guides.nvim'}
  -- use {'lukas-reineke/indent-blankline.nvim'}
  use {'ntpeters/vim-better-whitespace'}
  use {'osamuaoki/vim-python-matchit'}
  use {'osamuaoki/vim-spell-under'}
  use {'romainl/vim-qlist'}
  use {'tpope/vim-repeat'}
  use {'nvim-treesitter/nvim-treesitter'}
  use {'vim-airline/vim-airline'}
  use {'vim-airline/vim-airline-themes'}
end,
config = {
  display = {
    open_fn = require('packer.util').float,
  }
}})

-- vim: set sw=2 sts=2 et ft=lua :
