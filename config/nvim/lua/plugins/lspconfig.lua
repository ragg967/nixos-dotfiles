return {
	"neovim/nvim-lspconfig",
	config = function()
		local lsps = { "lua_ls", "clangd", "pyright", "taplo", "nimls", "nil_ls", "bash-language-server" }

		for _, lsp in ipairs(lsps) do
			vim.lsp.enable(lsp)
		end
	end
}
