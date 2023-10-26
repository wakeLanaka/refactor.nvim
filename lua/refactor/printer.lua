-- TODO: Add tests, store printer_nodes and then delete thos
local languages = require("refactor.languages")
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_helpers = require("refactor.ts_helpers")
local string_utils = require("refactor.string_utils")

local comment_identifier = " GENERATED PRINT"

local M = {}

M.print_identifier = function ()
  local node = ts_utils.get_node_at_cursor()
  if not ts_helpers.is_node_kind("identifier", node) then
    return nil
  end
  local line_row, line_col = ts_helpers.get_whole_line(node):start()
  local bufnr = vim.api.nvim_get_current_buf()
  local identifier = vim.treesitter.get_node_text(node, bufnr)
  local filetype = vim.bo.filetype
  local print_text = languages.print_keyword[filetype] .. "(\"" .. identifier .. ": \" + " .. identifier .. ") "
      .. languages.comment_keyword[filetype] .. comment_identifier
  local indented_text = string_utils.indent_line(print_text, line_col)
  local printer_row = line_row + 1
  vim.api.nvim_buf_set_lines(bufnr, printer_row, printer_row, false, {indented_text} )
end


M.delete_printers = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i = #lines, 1, -1 do
    local line_to_delete = string.find(lines[i], comment_identifier)
    if line_to_delete then
      vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, {})
    end
  end
end

return M
