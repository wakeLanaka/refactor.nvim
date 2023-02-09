-- TODO: Add tests, store printer_nodes and then delete thos
local languages = require("refactor.languages")
local ts_utils = require("nvim-treesitter.ts_utils")
local query = vim.treesitter.query

local get_whole_line = function (node)
  local row, _ = node:start()
  local parent = node:parent()

  while (parent ~= nil and parent:start() == row) do
    node = parent
    parent = node:parent()
  end

  return node
end

local function is_identifier_node(node)
  local is_identifier = true
  if node == nil then
    print("No treesitter parser found!")
    is_identifier = false
  end
  local node_type = node:type()
  if node_type ~= "identifier" then
    print("Node is not an identifier!")
    is_identifier = false
  end
  return is_identifier
end

local function indent_text(text, line_col)
  local counter = 0

  while (counter < line_col) do
    text = " " .. text
    counter = counter + 1
  end

  return text
end

local M = {}


M.print_identifier = function ()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.bo.filetype
  local node = ts_utils.get_node_at_cursor()

  if not is_identifier_node(node) then
    return nil
  end

  local line_row, line_col = get_whole_line(node):start()

  -- local bufnr = vim.api.nvim_get_current_buf()
  local node_text = query.get_node_text(node, bufnr)
  local print_text = languages.print_keyword[filetype] .. "(\"" .. node_text .. ": \" + " .. node_text .. ") " .. languages.comment_keyword[filetype] .. " GENERATED PRINT"
  local indented_text = indent_text(print_text, line_col)
  local printer_row = line_row + 1
  vim.api.nvim_buf_set_lines(bufnr, printer_row, printer_row, true, {indented_text} )
end


M.delete_printers = function()
  local comment = languages.comment_keyword[vim.bo.filetype]
  comment = comment:gsub(".", function (c)
    if c == "/" then
      return "\\/"
    end
  end)
  local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command("%s/^.\\+".. comment .. " GENERATED PRINT\\n//")
  vim.api.nvim_win_set_cursor(0, cursor_position)
end

return M
