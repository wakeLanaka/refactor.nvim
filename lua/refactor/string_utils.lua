local M = {}

M.indent_line = function (text, line_col)
  local indent = 0

  while (indent < line_col) do
    text = " " .. text
    indent = indent + 1
  end

  return text
end

return M
