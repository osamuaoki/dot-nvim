local fn = vim.fn

-- Bootstrap packer.lua to /pack/*/start/
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- vim: set sw=2 sts=2 et ft=lua :
