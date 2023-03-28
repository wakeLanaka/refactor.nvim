local ts_utils = require("nvim-treesitter.ts_utils")
local M = {}

M.get_whole_line = function(node)
  local row, _ = node:start()
  local parent = node:parent()

  while (parent ~= nil and parent:start() == row) do
    node = parent
    parent = node:parent()
  end

  return node
end

M.get_function_node = function(node)
  local parent = node:parent()
  while (not (M.is_node_kind("function_declaration", parent) or M.is_node_kind("function_definition", parent))) do
    parent = parent:parent()
  end
  return parent
end

M.is_node_kind = function(node_name, node)
  if node == nil then
    return false
  end
  return node_name == node:type()
end

return M
