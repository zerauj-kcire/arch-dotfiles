
--    ████████                                             ██
--   ██░░░░░░██                                           ░██
--  ██      ░░   █████  ███████   █████  ██████  ██████   ░██
-- ░██          ██░░░██░░██░░░██ ██░░░██░░██░░█ ░░░░░░██  ░██
-- ░██    █████░███████ ░██  ░██░███████ ░██ ░   ███████  ░██
-- ░░██  ░░░░██░██░░░░  ░██  ░██░██░░░░  ░██    ██░░░░██  ░██
--  ░░████████ ░░██████ ███  ░██░░██████░███   ░░████████ ███
--   ░░░░░░░░   ░░░░░░ ░░░   ░░  ░░░░░░ ░░░     ░░░░░░░░ ░░░ 

-- === VARIABLES === (((
local o   = vim.o -- global 
local cmd = vim.cmd
local g   = vim.g
local wo  = vim.wo
local bo  = vim.bo
local b = vim.b
local fn  = vim.fn
local opt = vim.opt
local api = vim.api
-- )))

-- === COLORS === (((
-- vim.cmd([[colorscheme moonfly]])
-- )))

-- === INPUT KEYBOARD === (((
opt.clipboard = 'unnamedplus'
opt.encoding  = 'utf-8'
-- )))

-- === INTERFAZ === (((
o.showcmd = false 
wo.number         = true
wo.relativenumber = true
wo.cursorline     = true
wo.cursorlineopt  = 'number'
-- wo.wrap           = true
wo.wrap           = false
wo.colorcolumn = '80'
b.textwidth = 80
o.lazyredraw      = true
o.laststatus      = 0
o.incsearch       = true
o.guicursor       = ''
o.termguicolors   = true
wo.foldmethod     = 'marker'
wo.foldmarker     = '(((,)))'
o.hlsearch        = false
o.inccommand      = 'nosplit'
vim.cmd([[
func! Stl_filename()
	return expand('%:t:r')
endfunc
set rulerformat=%60(%p%%\ \%=[%<\ \%{Stl_filename()}\ \]\ \%m\ \%=%Y%)
]])
vim.cmd([[hi FloatBorder guibg=NONE]])
-- o.shortmess = 'a'
o.cmdheight = 2
vim.cmd([[set shell=bash\ -i]])
-- )))

-- === CURSOR EN EL CENTRO === (((
vim.cmd([[
autocmd CursorMoved,CursorMovedI * call CentredCursor()
function! CentredCursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction
]])
    -- normal! zszH
-- )))

-- === TABULATIONS === (((
bo.shiftwidth  = 2
bo.tabstop     = 2
bo.autoindent  = false
bo.cindent     = false
bo.smartindent = false
bo.indentexpr  = ''
b.indentexpr = ""
b.did_indent = 1
bo.fo          = 'jql'
vim.api.nvim_command('filetype indent off')
o.splitright = true
o.splitbelow = true
-- )))

-- === AUX FILES === (((
bo.swapfile = false
-- )))

-- === FUNCTION TO COMMENT FILES === (((
vim.cmd([[
let s:comment_map = { 
    \   "ahk": ';',
		\   "beamer" : "%",
    \   "bash_profile": '#',
    \   "bashrc": '#',
    \   "bat": 'REM',
    \   "bib": "#",
    \   "c": '\/\/',
    \   "conf": '#',
    \   "cpp": '\/\/',
    \   "desktop": '#',
    \   "eml": '>',
    \   "fstab": '#',
    \   "go": '\/\/',
		\   "html": '<!--',
    \   "java": '\/\/',
    \   "javascript": '\/\/',
    \   "lua": '--',
    \   "mail": '>',
		\   "manim" : '#',
		\   "matlab" : "%",
    \   "php": '\/\/',
    \   "profile": '#',
    \   "python": '#',
    \   "r": '#',
    \   "ruby": '#',
    \   "rust": '\/\/',
    \   "scala": '\/\/',
    \   "sh": '#',
    \   "sty": '%',
		\   "swayconfig": '#',
    \   "tex": '%',
    \   "text": '#',
		\   "tmux": '#',
		\   "toml": '#',
    \   "vim": '"',
		\   "yaml": '#',
		\   "zathurarc": "#",
    \ }

" FUNCIÓN
function! ToggleComment()
	if has_key(s:comment_map, &filetype)
		let comment_leader = s:comment_map[&filetype]
		if getline('.') =~ "^\\s*" . comment_leader . " " 
			" Uncomment the line
			execute "silent s/^\\(\\s*\\)" . comment_leader . " /\\1/"
		else 
			if getline('.') =~ "^\\s*" . comment_leader
				" Uncomment the line
				execute "silent s/^\\(\\s*\\)" . comment_leader . "/\\1/"
			else
				" Comment the line
				execute "silent s/^\\(\\s*\\)/\\1" . comment_leader . " /"
			end
		end
else
			echo "No comment leader found for filetype"
	end
endfunction
]])
-- )))
