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

        -- Java
        none_ls.builtins.formatting.google_java_format,
        none_ls.builtins.diagnostics.checkstyle.with({
          extra_args = { "-c", "/google_checks.xml" }, -- or "/sun_checks.xml" or path to self written rules
        }),

        -- Nix
        none_ls.builtins.formatting.nixpkgs_fmt,

        -- Python
        require("none-ls.diagnostics.ruff"),
        require("none-ls.formatting.ruff"),

        -- Sh
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        none_ls.builtins.formatting.shfmt,

        -- Rust
        none_ls.builtins.formatting.rustfmt,
        none_ls.builtins.diagnostics.clippy,
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format file" })
  end,
}
