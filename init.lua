-- initialization with lua
home_dir = vim.loop.os_homedir()
-- This 'project_name' should be different from the program default 'nvim'
-- This allows this configuration to co-exist with others.
local config_lua_name = vim.loop.fs_realpath(
    debug.getinfo(1, 'S').source:match("^@?(.*)$") -- nvim -u ./some/path/config.lua
  )
local config_lua_dir = config_lua_name:match("^(.*)/[^/]*$")
local config_lua_parent = config_lua_dir:match("^.*/([^/]+)$")
if config_lua_parent == nil then
  -- This shouldn't be the case but just in case
  config_lua_parent = "nvme"
end
local project_name = vim.fn.exists(vim.env.PROJECT_NAME) and vim.env.PROJECT_NAME or config_lua_parent

-- Set up project specific directory names as global
xdg_config_home = vim.fn.exists(vim.env.XDG_CONFIG_HOME) and vim.env.XDG_CONFIG_HOME or home_dir .. '/.config'
xdg_data_home = vim.fn.exists(vim.env.XDG_DATA_HOME) and vim.env.XDG_DATA_HOME or home_dir .. '/.local/share'
project_config = xdg_config_home .. '/' .. project_name
project_data = xdg_data_home .. '/' .. project_name

--  print("I: HOME               = " .. home_dir )
--  print("I: PROJECT NAME       = " .. project_name )
--  print("I: XDG_CONFIG_HOME    = " .. xdg_config_home )
--  print("I: XDG_DATA_HOME      = " .. xdg_data_home )
--  print("I: PROJECT_NAME       = " .. project_name )
--  print("I: PROJECT_CONFIG     = " .. project_config )
--  print("I: PROJECT_DATA       = " .. project_data )

local opt = vim.opt
opt.rtp:remove(xdg_data_home .. "/nvim/site")
opt.rtp:remove(xdg_data_home .. "/nvim/site/after")
opt.rtp:prepend(project_data .. "/site")
opt.rtp:append(project_data .. "/site/after")

opt.rtp:remove(xdg_config_home .. "/nvim")
opt.rtp:remove(xdg_config_home .. "/nvim/after")
opt.rtp:prepend(project_config)
opt.rtp:append(project_config .. "/after")

vim.cmd [[let &packpath = &runtimepath]]

require'packages'
require'settings'
require'mappings'

-- vim: set sw=2 sts=2 et ft=lua :
