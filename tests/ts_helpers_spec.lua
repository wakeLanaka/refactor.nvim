local test_helpers = require(".test_helpers")
local ts_helpers = require("refactor.ts_helpers")
local ts_utils = require("nvim-treesitter.ts_utils")

describe("get_whole_line", function()
  it("returns correct node on indentend line lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local row_number = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "variable")
    local expected_col = string.find(row, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local row_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(row_number - 1, row_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on not indented line lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local row_number = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "test")
    local expected_col = string.find(row, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local row_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(row_number - 1, row_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on indentend line scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local row_number = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "variable")
    local expected_col = string.find(row, "val")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local row_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(row_number - 1, row_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on not indented line scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local row_number = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "test")
    local expected_col = string.find(row, "def")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local row_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(row_number - 1, row_node)
    assert.are.same(expected_col - 1, col_node)
  end)
end)

describe("is_identifier", function()
  it("returns true if is identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local row_number = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_identifier_node(node)

    assert.are.same(true, is_identifier)
  end)

  it("returns true if is identifier scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local row_number = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_identifier_node(node)

    assert.are.same(true, is_identifier)
  end)
  it("returns false if is not identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local row_number = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_identifier_node(node)

    assert.are.same(false, is_identifier)
  end)
  it("returns false if is not identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local row_number = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local row = before[row_number]
    local col_number = string.find(row, "def")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {row_number, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_identifier_node(node)

    assert.are.same(false, is_identifier)
  end)
end)
