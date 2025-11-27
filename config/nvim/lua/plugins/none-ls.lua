return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
    "gbprod/none-ls-shellcheck.nvim",
  },
  config = function()
    local none_ls = require("null-ls")

    none_ls.setup({
      sources = {
        -- Lua
        none_ls.builtins.formatting.stylua,

        -- JS/TS/JSON/CSS/HTML/etc
        none_ls.builtins.formatting.prettier,

        -- Nix
        none_ls.builtins.formatting.nixpkgs_fmt,

        -- Python
        require("none-ls.diagnostics.ruff"),
        require("none-ls.formatting.ruff"),

        -- Sh
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        none_ls.builtins.formatting.shfmt,

        -- Nim - custom nph formatter (not a builtin)
        none_ls.register({
          name = "nph",
          method = none_ls.methods.FORMATTING,
          filetypes = { "nim", "nimscript", "nims" },
          generator = none_ls.formatter({
            command = "nph",
            args = { "$FILENAME" },
            to_stdin = false,
            to_temp_file = true,
          }),
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
