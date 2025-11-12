return {
	"nvim-mini/mini.nvim",
	version = false, -- use main branch
	config = function()
		-- mini.nvim setup here
		require("mini.icons").setup()
		require("mini.ai").setup()
		require("mini.completion").setup({
			lsp_completion = {
				source_func = "omnifunc",
				auto_setup = true,
			},
		})
		require("mini.basics").setup()
		local miniclue = require("mini.clue")
		miniclue.setup({
			triggers = {
				-- Leader triggers
				{ mode = "n", keys = "<Leader>" },
				{ mode = "x", keys = "<Leader>" },

				-- Built-in completion
				{ mode = "i", keys = "<C-x>" },

				-- `g` key
				{ mode = "n", keys = "g" },
				{ mode = "x", keys = "g" },

				-- Marks
				{ mode = "n", keys = "'" },
				{ mode = "n", keys = "`" },
				{ mode = "x", keys = "'" },
				{ mode = "x", keys = "`" },

				-- Registers
				{ mode = "n", keys = '"' },
				{ mode = "x", keys = '"' },
				{ mode = "i", keys = "<C-r>" },
				{ mode = "c", keys = "<C-r>" },

				-- Window commands
				{ mode = "n", keys = "<C-w>" },

				-- `z` key
				{ mode = "n", keys = "z" },
				{ mode = "x", keys = "z" },
			},

			clues = {
				-- Enhance this by adding descriptions for <Leader> mapping groups
				miniclue.gen_clues.builtin_completion(),
				miniclue.gen_clues.g(),
				miniclue.gen_clues.marks(),
				miniclue.gen_clues.registers(),
				miniclue.gen_clues.windows(),
				miniclue.gen_clues.z(),
			},
		})
		require("mini.comment").setup()
		require("mini.cursorword").setup()
		require("mini.files").setup()
		require("mini.pick").setup()
		require("mini.indentscope").setup()
		require("mini.keymap").setup()
		require("mini.move").setup()
		require("mini.notify").setup()
		require("mini.pairs").setup()
		require("mini.snippets").setup()
		require("mini.diff").setup({
			view = {
				style = "sign", -- or 'number'
			},
		})
		require("mini.statusline").setup({
			use_icons = true,
		})

		-- Start screen (replaces alpha-nvim)
		local starter = require("mini.starter")
		starter.setup({
			items = {
				{ name = "Find files",    action = "Pick files",      section = "Pick" },
				{ name = "Recent files",  action = "Pick oldfiles",   section = "Pick" },
				{ name = "Grep",          action = "Pick grep_live",  section = "Pick" },
				{ name = "Help",          action = "Pick help",       section = "Pick" },
				starter.sections.recent_files(5, false),
				starter.sections.recent_files(5, true),
				starter.sections.builtin_actions(),
			},
			content_hooks = {
				starter.gen_hook.adding_bullet(),
				starter.gen_hook.aligning("center", "center"),
			},
			header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
]],
		})
		require("mini.statusline").setup()
		require("mini.surround").setup()
		require('mini.tabline').setup()
		require('mini.trailspace').setup()
		require("mini.extra").setup()
	end,
}
