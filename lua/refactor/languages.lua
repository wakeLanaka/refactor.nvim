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
return M
