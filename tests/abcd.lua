local scandir = require("plenary.scandir")
local Path = require("plenary.path")
local cwd = vim.loop.cwd()
P(scandir.scan_dir(Path:new(cwd, "files"):absolute()))
