return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Configure rust-analyzer explicitly before enabling
		-- Force using the Nix version, not Mason's
		local rust_analyzer_path = vim.fn.trim(vim.fn.system("which rust-analyzer"))
		vim.lsp.config("rust-analyzer", {
			filetypes = { "rust" },
			cmd = { rust_analyzer_path },
			root_markers = { "Cargo.toml", "rust-project.json" },
			settings = {
				["rust-analyzer"] = {
					diagnostics = {
						disabled = { "unlinked-file" },
					},
					cargo = {
						allFeatures = true,
					},
					check = {
						command = "clippy",
					},
				},
			},
		})

		-- Configure jdtls to be quiet
		vim.lsp.config("jdtls", {
			handlers = {
				["language/status"] = function() end,
				["$/progress"] = function() end,
			},
		})

		-- Enable all LSPs
		local lsps = { "rust-analyzer", "lua_ls", "clangd", "pyright", "taplo", "nimls", "nil_ls", "bashls", "jdtls" }

		for _, lsp in ipairs(lsps) do
			vim.lsp.enable(lsp)
		end
	end,
}
