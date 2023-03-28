local M = {}
M.print_keyword = {
  lua = "print",
  javascript = "console.log",
  scala = "println"
}
M.comment_keyword = {
  lua = "--",
  javascript = "//",
  scala = "//"
}

M.function_keyword = {
  lua = "local function",
  javascript = "function",
  scala = "def"
}

M.function_signature_ending = {
  lua = "()",
  javascript = "(){",
  scala = "() = {"
}

M.function_ending = {
  lua = "end",
  javascript = "}",
  scala = "}"
}

return M
