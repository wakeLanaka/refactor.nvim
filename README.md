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

### Delete printers

Keymap to delete all generated printers in this buffer:
```lua
vim.keymap.set("n", "<leader>rd", "<cmd>lua require('refactor').delete_printers()<cr>")
```

## exctract method

Keymap to extract the selected code to a new method above the current method. This does only work if the code snippet is
marked in visual mode.
```lua
vim.keymap.set("v", "<leader>rx", "<cmd>lua require('refactor').extract_method()<cr>")
```
