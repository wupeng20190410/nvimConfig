---Basic comfiguration
local set = vim.opt
set.number = true
--set.relativenumber = true
set.clipboard = "unnamedplus"
set.mouse = "a"
--vim.cmd([[
--  autocmd BufRead,BufNewFile *.s set filetype=asm
--]])
--Tab
set.tabstop = 4 -- number of visual spaces per TAB
set.softtabstop = 4 -- number of spacesin tab when editing
set.shiftwidth = 4 -- insert 4 spaces on a tab
set.expandtab = true -- tabs are spaces, mainly because of python

--Highlight after copy
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			timeout = 300,
		})
	end,
})

--Keybinding
local KeyMap = vim.keymap.set
KeyMap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
KeyMap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
KeyMap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
KeyMap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })

-- Fast enter file on explore
vim.api.nvim_create_augroup("netrw_mapping", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "l", "<CR>", { noremap = false, silent = true })
		vim.api.nvim_buf_set_keymap(0, "n", "h", "-<Esc>", { noremap = false, silent = true })
	end,
})

--Open explore
KeyMap("n", "-", ":Ex<CR>", { noremap = true, silent = true })

--split windows
KeyMap("n", "<Leader>-", ":sp<CR>", { desc = "Split horizontal", noremap = true, silent = true }) --horizontal
KeyMap("n", "<Leader>|", ":vsp<CR>", { desc = "Split vertical", noremap = true, silent = true }) --Vertical

-- Clean search
KeyMap("n", "<Leader><Esc>", ":noh<CR>", { desc = "Clear search highlight", noremap = true, silent = true })

--telescope key
local telescope = require("telescope")
local builtin = require("telescope.builtin")

-- 基本配置
telescope.setup({
	defaults = {
		prompt_prefix = "> ",
		selection_caret = "> ",
		path_display = { "smart" },
	},
})

-- 快捷键映射
KeyMap("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
KeyMap("n", "<leader>sw", function()
	--Catch word on cursor
	local word = vim.fn.expand("<cword>")
	builtin.live_grep({ default_text = word })
end, { desc = "Search word" })

--Lsp
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "diagnostic open", noremap = true, silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "diagnostic goto_prev", noremap = true, silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "diagnostic goto_next", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<space>q",
	vim.diagnostic.setloclist,
	{ desc = "diagnostic seloclist", noremap = true, silent = true }
)

--Fold code

-- Hints:
--   A uppercase letter followed `z` means recursive
--   zo: open one fold under the cursor
--   zc: close one fold under the cursor
--   za: toggle the folding
--   zv: open just enough folds to make the line in which the cursor is located not folded
--   zM: close all foldings
--   zR: open all foldings
-- source: https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation

local ts_fold_group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {})
vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = ts_fold_group,
	pattern = { "*.c", "*.lua" },
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = false
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = ts_fold_group,
	pattern = { "*.s" },
	callback = function()
		vim.opt.foldmethod = "indent"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldenable = false
	end,
})

--Bufferline
vim.keymap.set("n", "H", ":BufferLineCyclePrev<CR>", { desc = "Left windows", noremap = true, silent = true })
vim.keymap.set("n", "L", ":BufferLineCycleNext<CR>", { desc = "Right windows", noremap = true, silent = true })
vim.keymap.set(
	"n",
	"<space>bd",
	":bd<CR>",
	{ desc = "Close current windows", noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<space>bo",
	":BufferLineCloseOther<CR>",
	{ desc = "Close ohthers windows", noremap = true, silent = true }
)


--align

-- 定义在正常模式和可视模式下使用 `ga` 启动对齐
vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {})
vim.api.nvim_set_keymap("x", "ga", "<Plug>(EasyAlign)", {})

--formatter

vim.keymap.set("n","<leader>f",":Format<CR>")

--projects
--projects

vim.keymap.set("n","<leader>p",":Telescope projects<CR>")
