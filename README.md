# refactor.nvim

Refactoring for neovim inspired by [refactoring.guru](https://refactoring.guru/). I created this plugin to learn how
to develop plugins for neovim, as well as learn more about refactoring techniques.

## Documentation

See `:help refactor.nvim`

A plugin to help refactoring your code.

## Usage

### Printers

The printers functionality was inspired by [Primeagen's refactoring.nvim](https://github.com/ThePrimeagen/refactoring.nvim)

#### Print identifier
Keymap to print variable:
```lua
vim.keymap.set("n", "<leader>rp", "<cmd>lua require('refactor').print_identifier()<cr>")
```
Keymap to delete all generated printers in this buffer:
```lua
vim.keymap.set("n", "<leader>rd", "<cmd>lua require('refactor').delete_printers()<cr>")
```
