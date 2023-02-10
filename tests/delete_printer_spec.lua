-- have to be in tests directory to be able to read files!!

local refactor = require("refactor")
local languages = require("refactor.languages")
local test_helpers = require(".test_helpers")


describe("delete_printers", function()
  before_each(function ()
    vim.cmd(":bd!")
  end)
  it("deletes all printers lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    refactor.delete_printers()
    local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    assert.are.same(#before - 2, #after)
  end)
  it("deletes all printers scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    refactor.delete_printers()
    local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    assert.are.same(#before - 2, #after)
  end)
  it("deletes only generated printers lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    refactor.delete_printers()
    local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    assert.are.same(before[6], after[4])
  end)
  it("deletes only generated printers scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    refactor.delete_printers()
    local after = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    assert.are.same(before[6], after[4])
  end)
end)
