return {
	"neovim/nvim-lspconfig",
	config = function()
		local lsps = { "lua_ls", "clangd", "pyright", "taplo", "zls", "ts_ls" }

		for _, lsp in ipairs(lsps) do
			vim.lsp.enable(lsp)
		end
	end
}
