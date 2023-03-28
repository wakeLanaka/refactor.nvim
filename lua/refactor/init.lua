local printer = require('refactor.printer')
local composing_methods = require('refactor.composing_methods')

local M = {}
  M.print_identifier = printer.print_identifier
  M.delete_printers = printer.delete_printers
  M.extract_method = composing_methods.extract_method
return M
