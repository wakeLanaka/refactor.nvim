-- have to be in tests directory to be able to read files!!
-- add tests for other languages

local scandir = require("plenary.scandir")
local Path = require("plenary.path")
local refactor = require("refactor")
local languages = require("refactor.languages")
local cwd = vim.loop.cwd()

local function for_each_file(directory, func)
  local files = scandir.scan_dir(Path:new(cwd, "files", directory):absolute())
  for _, file in pairs(files) do
    func(file)
  end
end

local function open_test_file(file)
  vim.cmd(":e " .. file)
  return vim.api.nvim_get_current_buf()
end

describe("delete_printers", function()
  after_each(function ()
    vim.cmd(":bd!")
  end)
  it("deletes all printers lua", function()
      local bufnr = open_test_file("./files/delete_printers/lua/delete_printers.lua")
      local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      refactor.delete_printers()
      local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      assert.are.same(#before - 2, #after)
  end)
  it("deletes all printers scala", function()
      local bufnr = open_test_file("./files/delete_printers/scala/delete_printers.scala")
      local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      refactor.delete_printers()
      local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      assert.are.same(#before - 2, #after)
  end)
  it("deletes only generated printers lua", function()
      local bufnr = open_test_file("./files/delete_printers/lua/delete_printers.lua")
      local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      refactor.delete_printers()
      local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      assert.are.same(before[6], after[4])
  end)
  it("deletes only generated printers scala", function()
      local bufnr = open_test_file("./files/delete_printers/scala/delete_printers.scala")
      local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      refactor.delete_printers()
      local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      assert.are.same(before[6], after[4])
  end)
end)

describe("print_identifier", function()
  after_each(function ()
    vim.cmd(":bd!")
  end)
  it("prints the identifier for lua", function()
    for_each_file("print_identifier", function (file)
      local bufnr = open_test_file(file)
      local row_number = 2
      local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local row = before[row_number]
      local col_number, _ = string.find(row, "variable")
      local win = vim.api.nvim_get_current_win()
      vim.api.nvim_win_set_cursor(win, {row_number, col_number})
      local filetype = vim.bo.filetype
      refactor.print_identifier()
      local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      local start, _ = string.find(after[3], languages.print_keyword[filetype])
      assert.are.same(#before + 1, #after)
      assert.are.not_same(nil, start)
    end)
  end)
end)
