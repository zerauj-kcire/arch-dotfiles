
 -- ███████   ██                 ██                 
-- ░██░░░░██ ░██          █████ ░░                  
-- ░██   ░██ ░██ ██   ██ ██░░░██ ██ ███████   ██████
-- ░███████  ░██░██  ░██░██  ░██░██░░██░░░██ ██░░░░ 
-- ░██░░░░   ░██░██  ░██░░██████░██ ░██  ░██░░█████ 
-- ░██       ░██░██  ░██ ░░░░░██░██ ░██  ░██ ░░░░░██
-- ░██       ███░░██████  █████ ░██ ███  ░██ ██████ 
-- ░░       ░░░  ░░░░░░  ░░░░░  ░░ ░░░   ░░ ░░░░░░  

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
	Plug 'brennier/quicktex'
	Plug 'salsifis/vim-transpose'
	Plug 'ziontee113/color-picker.nvim'
	Plug 'sainnhe/sonokai'
	Plug 'xiyaowong/transparent.nvim' 
vim.call('plug#end')
