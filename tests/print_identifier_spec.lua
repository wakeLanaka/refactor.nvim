local refactor = require("refactor")
local languages = require("refactor.languages")
local test_helpers = require(".test_helpers")

describe("print_identifier", function()
  after_each(function ()
    vim.cmd(":bd!")
  end)
  it("prints the identifier scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
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
  it("prints the identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
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
