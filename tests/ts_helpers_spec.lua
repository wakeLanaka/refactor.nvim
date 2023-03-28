local test_helpers = require(".test_helpers")
local ts_helpers = require("refactor.ts_helpers")
local ts_utils = require("nvim-treesitter.ts_utils")

describe("get_whole_line", function()
  it("returns correct node on indentend line lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local expected_col = string.find(line, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local line_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(variable_line - 1, line_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on not indented line lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "test")
    local expected_col = string.find(line, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local line_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(variable_line - 1, line_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on indentend line scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local expected_col = string.find(line, "val")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local line_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(variable_line - 1, line_node)
    assert.are.same(expected_col - 1, col_node)
  end)
  it("returns correct node on not indented line scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "test")
    local expected_col = string.find(line, "def")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local line_node, col_node =  ts_helpers.get_whole_line(node):start()

    assert.are.same(variable_line - 1, line_node)
    assert.are.same(expected_col - 1, col_node)
  end)
end)

describe("is_node_kind", function()
  it("returns true if is identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("identifier", node)

    assert.are.same(true, is_identifier)
  end)

  it("returns true if is identifier scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 2
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("identifier", node)

    assert.are.same(true, is_identifier)
  end)
  it("returns false if is not identifier lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "local")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("identifier", node)

    assert.are.same(false, is_identifier)
  end)
  it("returns false if is not identifier scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "def")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("identifier", node)

    assert.are.same(false, is_identifier)
  end)
  it("returns true if it's function_declaration", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "function")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("function_declaration", node)

    assert.are.same(true, is_identifier)
  end)
  it("returns true if it's function_definition", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "def")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local is_identifier =  ts_helpers.is_node_kind("function_definition", node)

    assert.are.same(true, is_identifier)
  end)
end)

describe("get_function_node", function()
  it("return function node lua", function()
    local bufnr = test_helpers.open_test_file("./files/lua/test.lua")
    local variable_line = 2
    local function_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local node_line, _ =  ts_helpers.get_function_node(node):start()

    assert.are.same(function_line - 1, node_line)
  end)
  it("return function node scala", function()
    local bufnr = test_helpers.open_test_file("./files/scala/test.scala")
    local variable_line = 2
    local function_line = 1
    local before = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local line = before[variable_line]
    local col_number = string.find(line, "variable")
    local win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_cursor(win, {variable_line, col_number})
    local node = ts_utils.get_node_at_cursor()
    local node_line, _ =  ts_helpers.get_function_node(node):start()

    assert.are.same(function_line - 1, node_line)
  end)
end)
