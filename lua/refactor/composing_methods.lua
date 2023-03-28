-- TODO add method name at extracted position

local ts_utils = require("nvim-treesitter.ts_utils")
local ts_helpers = require("refactor.ts_helpers")
local languages = require("refactor.languages")
local string_utils = require("refactor.string_utils")
local query = vim.treesitter.query

local function sort_visual_selection_range(line1, line2)
  if (line1 > line2) then
    return {line2, line1}
  end
  return {line1, line2}
end

local function create_function_signature(function_name, filetype)
  return languages.function_keyword[filetype] .. " " .. function_name .. languages.function_signature_ending[filetype]
end

local function generate_new_method(function_name, body, indentation)
  local filetype = vim.bo.filetype
  local function_declaration = {}
  local function_signature = create_function_signature(function_name, filetype)
  function_signature = string_utils.indent_line(function_signature, indentation)
  table.insert(function_declaration, function_signature)
  for _, line in pairs(body) do
    table.insert(function_declaration, line)
  end
  table.insert(function_declaration, string_utils.indent_line(languages.function_ending[filetype], indentation))
  table.insert(function_declaration, "")
  return function_declaration
end

local function get_root(bufnr)
  local parser = vim.treesitter.get_parser(bufnr, vim.bo.filetype, {})
  local tree = parser:parse()[1]
  return tree:root()
end

local function get_identifiers(bufnr, root)
  local declarations = {}
  local test = vim.treesitter.parse_query("scala", [[(identifier) @id]])
  for _, node in test:iter_captures(root, vim.bo.filetype, 0, -1) do
    local variable_name = query.get_node_text(node, bufnr)
    declarations[variable_name] = node:start()
  end
  return declarations
end

local M = {}

M.extract_method = function ()
  local mode = vim.api.nvim_get_mode()
  if mode.mode ~= "V" then
    print("Needs to be in visual mode!")
    return
  end
  local function_name = vim.fn.input("Function name: ")
  if function_name == nil or function_name == "" then
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local root = get_root(bufnr)
  local declarations = get_identifiers(bufnr, root)
  local visual_start_line = vim.fn.getpos('v')[2]
  local cursor_line = vim.fn.getcurpos()[2]
  local selection = sort_visual_selection_range(visual_start_line, cursor_line)
  for id, row in pairs(declarations) do
    if (row < selection[1] or row > selection[2]) then
      declarations[id] = nil
    end
  end


  local node = ts_utils.get_node_at_cursor()
  local function_line, function_col = ts_helpers.get_function_node(node):start()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), 'V', false)
  local selected_lines = vim.api.nvim_buf_get_lines(bufnr, selection[1] - 1, selection[2], false)
  vim.api.nvim_buf_set_lines(bufnr, selection[1] - 1, selection[2], false, {})

  local extracted_method = generate_new_method(function_name, selected_lines, function_col)
  vim.api.nvim_buf_set_lines(bufnr, function_line, function_line, false, extracted_method)

  local extracted_method_usage_line = selection[1] + #extracted_method - 1
  local function_invocation_string = function_name .. "()"
  local indentation = vim.bo.tabstop + function_col
  function_invocation_string = string_utils.indent_line(function_invocation_string, indentation)

  vim.api.nvim_buf_set_lines(bufnr, extracted_method_usage_line, extracted_method_usage_line, false, {function_invocation_string})

  vim.api.nvim_win_set_cursor(0, {extracted_method_usage_line + 1, indentation})
end

return M
