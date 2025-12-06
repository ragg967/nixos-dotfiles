return {
	"neovim/nvim-lspconfig",
	config = function()
		local lsps = { "rust-analyzer", "lua_ls", "clangd", "pyright", "taplo", "nimls", "nil_ls", "bashls", "jdtls" }

		for _, lsp in ipairs(lsps) do
			vim.lsp.enable(lsp)
		end
	end
}
