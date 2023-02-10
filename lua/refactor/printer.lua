-- TODO: Add tests, store printer_nodes and then delete thos
local languages = require("refactor.languages")
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_helpers = require("refactor.ts_helpers")
local string_utils = require("refactor.string_utils")
local query = vim.treesitter.query

local M = {}


M.print_identifier = function ()
  local node = ts_utils.get_node_at_cursor()
  if not ts_helpers.is_identifier_node(node) then
    return nil
  end
  local line_row, line_col = ts_helpers.get_whole_line(node):start()
  local bufnr = vim.api.nvim_get_current_buf()
  local identifier = query.get_node_text(node, bufnr)
  local filetype = vim.bo.filetype
  local print_text = languages.print_keyword[filetype] .. "(\"" .. identifier .. ": \" + " .. identifier .. ") "
      .. languages.comment_keyword[filetype] .. " GENERATED PRINT"
  local indented_text = string_utils.indent_line(print_text, line_col)
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
  -- local cursor_position = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_command("%s/^.*".. comment .. " GENERATED PRINT\\n//")
  -- vim.api.nvim_win_set_cursor(0, cursor_position)
end

return M
