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

M.is_identifier_node = function (node)
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

return M
