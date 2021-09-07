# dot-neovim

This is a copy of my `~/.config/nvim` targeting for neovim 0.5 with lua.

It's rather new.

## Key features

* IDE like access to buffer and file selections
* Spellcheck and syntax doesn't interfere each other
* Sure NORMAL mode with `<Esc><Esc>` (terminal)
* Simple search and highlight function with `<SPACE><SPACE>`
  (`#` `and *`-like)
* Clean screen (Ale, GitGutter, FZF.VIM capable but hidden)
* Safe window selection moves without using risky CTRL-W
* Shell like CTRL-ASCII access to `<Left>`, `<Right>`, `<DEl>`.
* Minimal key binding overrides
* NEOVIM based

For inner details on why and how I chose to set up, see baseline was my
vim seting:

* [Re-learning Vim (1)](https://osamuaoki.github.io/en/2019/09/17/vim-learn-1/)
* [Re-learning Vim (2)](https://osamuaoki.github.io/en/2019/09/24/vim-learn-2/)
* [My older .vim for Vim 8.0](https://github.com/osamuaoki/dot-vim)

Currently, `vi` starts `nvim` and `vim` starts `vim`.

## Quick start

This will set up basic configuration for my vim (Others may need to use
their cloned tracking repo if they need to modify and keep by `push`).

```
 $ cd
 $ rm -rf ~/.vim # reset all
 $ git clone https://github.com/osamuaoki/dot-nvim ~/.config/nvim
 $ vi
```

## Adding usable plugin packages

See `packer.nvim`

## Further customization idea

Here are a few insightful recommendations for the best practices I
referenced for setting up Vim.

* VIM
    * [Seven habits of effective text editing](https://www.moolenaar.net/habits.html) by Bram Moolenaar
    * [#vim Recommendations](https://www.vi-improved.org/recommendations/)
    * [vim-galore](https://github.com/mhinz/vim-galore)
* NVIM
    * [Getting started using Lua in Neovim](https://github.com/nanotee/nvim-lua-guide)
    * [Everything you need to know to configure neovim using lua 2021-08-01](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)

<!-- vim: set sts=2 sw=2 expandtab ai si tw=72: -->
