local packer_package_root = project_data .. '/site/pack'
local packer_install_path = packer_package_root .. 'packer/start/packer.nvim'
local packer_compile_path = project_config .. 'plugin/packer_compiled.lua'

local cmd = vim.cmd
local fn = vim.fn
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

-- Bootstrap packer.lua to /pack/*/start/
local install_path =  packer_install_path
if fn.empty(fn.glob(install_path)) then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end
cmd [[ packadd! packer.nvim ]]

local packer = require "packer"
local util = require "packer.util"
packer.init {
  package_root = packer_package_root,
  compile_path = packer_compile_path,
  git = { clone_timeout = 300 },
  display = {
    open_fn = function()
      return util.float { border = "rounded" }
    end,
  },
}

-- make sure to do ':PackerSync' once in a while

packer.startup({function(use)
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
})

-- vim: set sw=2 sts=2 et ft=lua :
