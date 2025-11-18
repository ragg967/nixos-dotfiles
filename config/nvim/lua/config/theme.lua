-- Custom Theme Configuration
-- lua/config/theme.lua

local colors = {
  bg = "#6367a4",
  fg = "#fec35d",
  black = "#3d3334",
	red = "#f26655",
  green = "#aeda76",
  yellow = "#fef5ca",
  blue = "#a8cee3",
  magenta = "#d88ee5",
  cyan = "#0cb7d6",
  bright_black = "#2a2f4a",
}

-- Reset highlights
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.o.termguicolors = true
vim.g.colors_name = "custom"

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor highlights
hl("Normal", { fg = colors.fg, bg = colors.bg })
hl("NormalFloat", { fg = colors.fg, bg = colors.bright_black })
hl("CursorLine", { bg = colors.bright_black })
hl("CursorLineNr", { fg = colors.yellow, bold = true })
hl("LineNr", { fg = colors.black })
hl("SignColumn", { bg = colors.bg })
hl("VertSplit", { fg = colors.bright_black })
hl("StatusLine", { fg = colors.fg, bg = colors.bright_black })
hl("StatusLineNC", { fg = colors.black, bg = colors.bright_black })
hl("Pmenu", { fg = colors.fg, bg = colors.bright_black })
hl("PmenuSel", { fg = colors.bg, bg = colors.yellow })
hl("PmenuSbar", { bg = colors.bright_black })
hl("PmenuThumb", { bg = colors.cyan })
hl("Visual", { bg = colors.bright_black })
hl("Search", { fg = colors.bg, bg = colors.yellow })
hl("IncSearch", { fg = colors.bg, bg = colors.cyan })
hl("MatchParen", { fg = colors.magenta, bold = true })

-- Syntax highlighting
hl("Comment", { fg = colors.black, italic = true })
hl("Constant", { fg = colors.magenta })
hl("String", { fg = colors.green })
hl("Character", { fg = colors.green })
hl("Number", { fg = colors.magenta })
hl("Boolean", { fg = colors.magenta })
hl("Float", { fg = colors.magenta })
hl("Identifier", { fg = colors.blue })
hl("Function", { fg = colors.yellow })
hl("Statement", { fg = colors.red })
hl("Conditional", { fg = colors.red })
hl("Repeat", { fg = colors.red })
hl("Label", { fg = colors.red })
hl("Operator", { fg = colors.cyan })
hl("Keyword", { fg = colors.red })
hl("Exception", { fg = colors.red })
hl("PreProc", { fg = colors.cyan })
hl("Include", { fg = colors.cyan })
hl("Define", { fg = colors.cyan })
hl("Macro", { fg = colors.cyan })
hl("PreCondit", { fg = colors.cyan })
hl("Type", { fg = colors.yellow })
hl("StorageClass", { fg = colors.yellow })
hl("Structure", { fg = colors.yellow })
hl("Typedef", { fg = colors.yellow })
hl("Special", { fg = colors.magenta })
hl("SpecialChar", { fg = colors.magenta })
hl("Tag", { fg = colors.yellow })
hl("Delimiter", { fg = colors.fg })
hl("SpecialComment", { fg = colors.cyan, italic = true })
hl("Debug", { fg = colors.red })
hl("Underlined", { underline = true })
hl("Error", { fg = colors.red, bold = true })
hl("Todo", { fg = colors.yellow, bg = colors.bright_black, bold = true })

-- Treesitter highlights
hl("@variable", { fg = colors.fg })
hl("@variable.builtin", { fg = colors.magenta })
hl("@function", { fg = colors.yellow })
hl("@function.builtin", { fg = colors.cyan })
hl("@keyword", { fg = colors.red })
hl("@keyword.function", { fg = colors.red })
hl("@string", { fg = colors.green })
hl("@constant", { fg = colors.magenta })
hl("@type", { fg = colors.yellow })
hl("@parameter", { fg = colors.blue })
hl("@property", { fg = colors.blue })
hl("@operator", { fg = colors.cyan })
hl("@punctuation.bracket", { fg = colors.fg })
hl("@punctuation.delimiter", { fg = colors.fg })
hl("@comment", { fg = colors.black, italic = true })

-- Git highlights
hl("DiffAdd", { fg = colors.green, bg = colors.bright_black })
hl("DiffChange", { fg = colors.yellow, bg = colors.bright_black })
hl("DiffDelete", { fg = colors.red, bg = colors.bright_black })
hl("DiffText", { fg = colors.blue, bg = colors.bright_black })

-- Diagnostic highlights
hl("DiagnosticError", { fg = colors.red })
hl("DiagnosticWarn", { fg = colors.yellow })
hl("DiagnosticInfo", { fg = colors.cyan })
hl("DiagnosticHint", { fg = colors.blue })
