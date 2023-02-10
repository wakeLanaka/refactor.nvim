local scandir = require("plenary.scandir")
local Path = require("plenary.path")
local cwd = vim.loop.cwd()

local M = {}

  M.for_each_file = function(func)
    local files = scandir.scan_dir(Path:new(cwd, "files"):absolute())
    for _, file in pairs(files) do
      func(file)
    end
  end

  M.open_test_file = function(file)
    vim.cmd(":e " .. file)
    return vim.api.nvim_get_current_buf()
  end

return M
