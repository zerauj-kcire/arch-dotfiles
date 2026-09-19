
--  ██   ██                         
-- ░██  ██           ██   ██        
-- ░██ ██    █████  ░░██ ██   ██████
-- ░████    ██░░░██  ░░███   ██░░░░ 
-- ░██░██  ░███████   ░██   ░░█████ 
-- ░██░░██ ░██░░░░    ██     ░░░░░██
-- ░██ ░░██░░██████  ██      ██████ 
-- ░░   ░░  ░░░░░░  ░░      ░░░░░░  

-- === FUNCTIONS === (((
-- aliases
local cmd = vim.cmd
local g = vim.g
local api = vim.api

-- single mappings
-- true: noremap
-- false: remap
local function map(mode,key,action,opts)
	local options = {noremap = true, silent = false}
	if opts then
		options = {noremap = opts, silent = true}
	end
  vim.api.nvim_set_keymap(mode, key, action, options)
end

-- function to autocommand for a mapping
local function au_m(event, group, pattern, mapping)
	api.nvim_create_autocmd(event,{
		group = group,
		pattern = pattern,
		callback = mapping,
	})
end

-- function to autocommand for a script
local function au_c(event, group, pattern, command)
	api.nvim_create_autocmd(event,{
		group = group,
		pattern = pattern,
		command = command,
	})
end
-- )))

-- === DIRECTIONS === (((
map('','j','h')
map('','k','j')
map('','l','k')
map('','ñ','l')
map('','J','0')
map('','K','G')
map('','L','gg')
map('','Ñ','$')
-- )))

-- === GENERAL === (((
	--
map('n','<M-d>',':au!<CR>',false)
map('n','<M-n>',':Lex<bar> vertical resize 30<CR>')

cmd([[command W w]])
map('','<Insert>','<nop>')
map('i','<Insert>','<nop>')
map('n','Q','@',false)
-- cmd([[unmap! <C-w>]])
cmd([[nnoremap <silent> <nowait> <C-w> :set indentexpr=<CR>:set wrap!<CR>:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>]])
-- map('n','<C-w>',':set indentexpr=<CR>:set wrap!<CR>:execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>')
map('n', '<C-q>', '<nop>')
-- map('i','e<Tab>','^ ')
-- )))

-- === TEXT === (((
-- Edit Text
-- cmd([[
-- function! Col(separator)
-- execute ':!column -n -t -s "' . a:separator . '"'
-- endfunction
-- vnoremap <M-a> :'<'>call Col('')<left><left>
-- ]])
-- . '" -o "' . a:separator . '"'
-- map("", "<M-a>",":let sep='' | execute '!column -t -s &sep -o &sep'<Home><right><right><right><right><right><right><right><right><right><right><right><right><right><right>")
--
map('','<M-a>',":!column -t -s ''<left>")

map('','s',':s///g<left><left><left>')
map('','<C-s>','"cyE:s///g<left><left><left><C-r>c<right>')
map('n','S',':%s///g<left><left><left>', false)
map('i','<C-BS>','<Esc>BcW')

-- Cancel all g mappings
cmd([[
function! SuppressAllStartingWith(c1)
	let c2 = nr2char(getchar())
	if maparg(a:c1.c2, 'n') != ''
		return a:c1.c2
	else
		return '\<Nop>'
	endif
endfunction
noremap <nowait> <silent> g SuppressAllStartingWith('g')
]])
map('','g','<Nop>',false)
map('','gv','<Nop>')

-- Capitalization
map('n','<M-v>','gv')

map('n','<C-g>','vgu')
map('v','<C-g>','gu',false)
map('n','G','vgU')
map('v','G','gU',false)
-- map('x','h','~',false)
map('n','h','~',false)
map('v','h','~',false)

-- Separate lines
map("n","z",":s/\\s\\+/\\r/g<CR>",false)
map("v","z",":s/\\s\\+/\\r/g<CR>",false)
-- Join lines
map('n','<C-z>','J') -- adding space
map('v','<C-z>','J')

map('n','<M-z>','gJ') -- no space
map('v','<M-z>','gJ')

-- Add at begin and the end of line
-- map('n','<C-a>',":norm A")
-- map('n','<C-i>',":norm I")
map('v','<C-a>',":norm A")
map('v','<C-i>',":norm I")
-- map('v','i','I')
-- map('v','a','A')
-- Arabic numbering
cmd([[vmap <C-1> :<c-u>let i=1 \| '<,'>g/^/ s//\=i . ' '/ \| let i+=1<CR>]])
map("n","<C-1>", ":r !printf '\\%s\\n' {1..}<left>")
map("i","<C-1>", "<Esc>:r !printf '\\%s\\n' {1..}<left>")
-- Alphabetical numbering
-- cmd([[vmap <C-2> :<c-u>let i=0 \| '<,'>g/^/ s//\=nr2char(char2nr('a')+i) . ' '/ \| let i+=1<CR>]])
-- map("n","<C-2>", ":r !printf '\\%s\\n' {a..}<left>")
-- map("i","<C-2>", "<Esc>:r !printf '\\%s\\n' {a..}<left>")
-- Replace 0 with arabic numbering
cmd([[vmap <C-0> :<c-u>let i=1 \| '<,'>g/0/ s//\=i /g \| let i+=1<CR>]])
cmd([[vmap <C-1> :<c-u>let i=1 \| '<,'>g/0/ s//\=i / \| let i+=1<CR>]])

-- Replace 0 with alphabetical numbering
cmd([[vmap <M-0> :<c-u>let i=0 \| '<,'>g/0/ s//\=nr2char(char2nr('a')+i) /g \| let i+=1<CR>]])
cmd([[vmap <M-1> :<c-u>let i=0 \| '<,'>g/0/ s//\=nr2char(char2nr('a')+i) / \| let i+=1<CR>]])
-- )))

-- === TERMINAL === (((
map('t','<Esc>','<C-\\><C-n>',false)
map('n','<C-t>',':vs<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>A')
cmd([[autocmd TermClose * execute 'bdelete! ' . expand('<abuf>')]])
-- )))

-- === DISABLE MOUSE === (((
map('n','<up>','<nop>')
map('n','<down>','<nop>')
map('n','<left>','<nop>')
map('n','<right>','<nop>')
map('i','<up>','<nop>')
map('i','<down>','<nop>')
map('i','<left>','<nop>')
map('i','<right>','<nop>')
map('v','<up>','<nop>')
map('v','<down>','<nop>')
map('v','<left>','<nop>')
map('v','<right>','<nop>')
-- )))

-- === SPELL CHECK === (((
	--
map('n','<M-w>',':setlocal spell! spelllang=es<CR><CR>')
map('n','<M-W>',':setlocal spell! spelllang=en<CR><CR>')

-- map('n','<C-S-ñ>',']s')
-- map('n','<C-S-j>','[s')
--
map('n','<M-c>','z=')

-- )))

-- === SEARCH === (((
map('','m',';')
map('','M',',')
-- )))

-- === COPY AND DRAG === (((
map('n','<C-e>','ggyG',false)
map('v','<C-l>',":move '<-2<CR>gv-gv")
map('v','<C-k>',":move '>+1<CR>gv-gv")
map('v','<C-ñ>','>gv')
map('v','<C-j>','<gv')
map('i','<C-ñ>','<Esc>V>gv<Esc>A')
map('i','<C-j>','<Esc>V<gv<Esc>A')
map('','<','<Nop>',false)
map('','>','<Nop>',false)

map('n','<C-ñ>','V>gv')
map('n','<C-j>','V<gv,')
map('n','<C-l>',"V:move '<-2<CR>gv-gv")
map('n','<C-k>',"V:move '>+1<CR>gv-gv")
-- map('n','<C-y>','\"ayw')
-- )))

-- === IDENTATIONS === (((
map('n','<C-S-L>','zM')
map('n','<C-S-K>','zR')
map('n','<space>','za',false)

map('n','<M-s>','/=== ',false)

-- )))

-- === COMMENT === (((
map('v','<C-c>',":call ToggleComment()<CR>")
map('n','<C-c>',':call ToggleComment()<CR>')
map('i','<C-c>','<ESC>:call ToggleComment()<CR>A')
-- )))

-- === AUTOCOMPLETE === (((
-- Double
map('i','"','"" <++><Esc>6ha')
map('i',"'","'' <++><Esc>6ha")
map('i','(','() <++><Esc>6ha')
map('i','[','[] <++><Esc>6ha')
map('i','{','{} <++><Esc>6ha')
map('i','¿','¿? <++><Esc>6ha')
map('i','¡','¡! <++><Esc>6ha')
map('i','<','<> <++><Esc>6ha')
map('i', '|','|| <++><Esc>6ha')
-- Single
map('i','<C-2>','"')
map('i',"<C-'>","'")
map('i','<C-8>','(')
map('i','<C-¿>','¿')
map('i','<C-lt>','<')
-- map('i','','[] <++><Esc>6ha')
-- map('i','{','{} <++><Esc>6ha')
-- Disable double
map('n', '<C-i>', ":iu \"<CR>:iu '<CR>:iu (<CR>:iu [<CR>:iu {<CR>:iu ¿<CR>:iu <<CR>")
-- cmd([[nmap <S-Tab> :exec printf("imap \" \"\" <++>\<Esc>6ha<CR> imap ' '' <++>\<Esc>6ha<CR> imap ( () <++>\<Esc>6ha<CR> imap [ [] <++>\<Esc>6ha<CR> imap { {} <++>\<Esc>6ha<CR> imap ¿¿? <++>\<Esc>6ha<CR> imap < <> <++>\<Esc>6ha<CR>")]])
-- )))

-- === SPLITS === (((
-- Move on splits
map('n','<M-j>','<C-w>h')
map('n','<M-k>','<C-w>j')
map('n','<M-l>','<C-w>k')
map('n','<M-ñ>','<C-w>l')
-- Move in insert mode.
--
map('i','<M-j>','<Esc><C-w>hi')
map('i','<M-k>','<Esc><C-w>ji')
map('i','<M-l>','<Esc><C-w>ki')
map('i','<M-ñ>','<Esc><C-w>li')

-- Move in insert mode.
--
map('t','<M-j>','<Esc><C-w>h')
map('t','<M-k>','<Esc><C-w>j')
map('t','<M-l>','<Esc><C-w>k')
map('t','<M-ñ>','<Esc><C-w>l')

-- Resize Splits
--
map('n','<M-J>',':vertical resize -5<CR>')
map('n','<M-S-ñ>',':vertical resize +5<CR>')
map('n','<M-K>',':resize -3<CR>')
map('n','<M-L>',':resize +3<CR>')

-- Split
-- map('n','<C-s>', ':vs<CR>',false) -- vertically
-- map('n','<C-h>', ':sp<CR>',false) -- horizontally
g.sendtowindow_use_defaults = 1
-- )))

-- === LaTeX === (((
local TeX = api.nvim_create_augroup("TeXgroup", { clear = true })
au_m("FileType", TeX, "tex", function()	map('n' , '<C-a>', ':!zathura<space>%:r.pdf<space>&<Enter><CR>', false) end)
au_c("BufWritePost", TeX, "*.tex" , 'silent ! mycomp %')
-- au_c("BufRead", TeX, "*.tex", "set indentexpr=<CR>")

-- map('n', '<M-p>', ":silent ! pdflatex %<CR>")
-- map('n', '<M-x>', ":silent ! xelatex %<CR>")
-- au_c("FileType", TeX , "*.tex", cmd([[command p silent ! pdflatex %]]))
-- au_m("FileType", TeX,  "tex", function() map('n', '<M-p>', ':au BufWritePost *.tex silent ! pdflatex %<CR>') end)
-- local TeXN = api.nvim_create_augroup("TeXgroupNew", { clear = true })
-- au_m("FileType", TeXN, "tex", function() map('n', '<M-x>', ':au BufWritePost *.tex silent ! xelatex %<CR>') end)
-- map('n', '<M-p>', function() au_c("FileType", TeX, "*.tex", ":! pdflatex %") end, true)
--map('n', '<M-x>', function() au_c("FileType", TeX, "*.tex", ":! xelatex %") end, true)

au_m("FileType", TeX, "tex", function() map('n', '<M-b>', ':!bibtex %:r<CR>' , false) end)

au_c("BufReadPre", TeX, "*.log", "set filetype=log")
-- au_c("FileType", TeX, "DEF", "set syntax=tex")
-- au_c("FileType", TeX, "CFG", "set syntax=tex")
au_m("FileType", TeX, "tex", function() map('n', '<C-o>', ':11sp %:r.log<CR>/^l\\.\\d<CR>ll"bye<C-w>k:<C-r>b<CR>', false) end)

au_m("FileType", TeX, "tex", function() map('n', '<M-O>', ':sp %:r.log<CR>/^l\\.\\d<CR>', false) end)
au_m("FileType", TeX, "tex", function() map('n', '<M-o>', ':vs %:r.log<CR>/^l\\.\\d<CR>ll"bye<C-w>h:<C-r>b<CR>', false) end)

-- https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_1)
-- https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
-- https://superuser.com/questions/234317/how-can-i-yank-multiple-lines-into-a-register
-- https://vi.stackexchange.com/questions/11791/how-to-store-all-occurrences-of-a-multiline-search-in-a-register
au_m("FileType", TeX, "tex", function() map('n', '<C-P>', ':vs preamble.tex<CR>' , false) end)

au_m("FileType", TeX, "tex", function() map('n', '<M-p>', ':sp preamble.tex<CR>' , false) end)

au_m("FileType", TeX, "tex", function() map('n', '<C-H>', ':sp preamble.tex<CR>' , false) end)
au_m("FileType", TeX, "tex", function() map('n', '<C-b>', ':vs Referencias.bib<CR>', false) end)
au_c("FileType", Bib, "bib", "set foldmethod=syntax")
-- au_m("FileType", TeX, "tex", function() map('n', '<M-o>', ':%s/% \\\\pause/\\\\pause/g<CR>:vs preamble.tex<CR>:set nofoldenable<CR>/overlay<CR>:call ToggleComment()<CR>') end)
-- au_m("FileType", TeX, "tex", function() map('n', '<M-p>', ':%s/\\\\pause/% \\\\pause/g<CR>:vs preamble.tex<CR>:set nofoldenable<CR>/overlay<CR>:call ToggleComment()<CR>') end)
g.tex_flavor = 'latex'
-- )))

-- === Rscript === (((
local Rg = api.nvim_create_augroup("Rgroup", {clear = true})
au_m("FileType", Rg, "r", function() map('n', '<C-a>', ':!zathura<space>Rplots.pdf<space>&<Enter><Enter>',false) end)

au_m("FileType", Rg, "r", function() map('n', '<M-t>', ':vs<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>AR<space>--no-save<CR>',false) end)
au_m("FileType", Rg, "r", function() map('n', '<M-c>', ':sp<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>AR<space>--no-save<CR>',false) end)
au_m("FileType", Rg, "r", function() map('n', '<M-r>', ':au BufWritePost *.r ! Rscript % > output.txt<CR><CR>',false) end)

au_m("FileType", Rg, "r", function() map('n', '<C-o>', ':vs output.txt<CR>',false) end)

au_m("FileType", Rg, "r", function() map('n', '<M-o>', ':sp output.txt<CR>',false) end)

au_m("FileType", Rg, "r", function() map('n', '<C-p>', ':vs functions.r<CR>',false) end)
-- au_m("FileType", Rg, "r", function() map('n', '<C-d>', ':vs datos.txt<CR>',false) end)
au_m("FileType", Rg, "r", function() map('t', '<C-q>', '<Esc>iq()<CR>exit<CR>') end)
au_m("FileType", Rg, "text", function() map('n', '<C-f>', "ggVG:s/\t/<space>/g<CR>gv:'<,'>'<'>!column -t -s ' '<CR>") end)
au_m("FileType", Rg, "text", function() map('n', '<C-b>', "ggVG:'<,'>'<'>!column -t -s ' '<CR>") end)
-- )))

-- === Python === (((
local Py = api.nvim_create_augroup("Pythongroup", {clear = true})

au_m("FileType", Py, "python", function() map('n', '<M-p>', ':au BufWritePost *.py silent !python3 % > output.txt<CR>',false) end)
au_m("FileType", Py, "python", function() map('n', '<M-t>', ':vs<CR>:term<CR>Apython3<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-j>',false) end)
au_m("FileType", Py, "python", function() map('n', '<M-c>', ':sp<CR>:term<CR>Apython3<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-l>',false) end)
au_m("FileType", Py, "python", function() map('n', '<M-e>', ':au BufWritePost *.py !python3 % > output.txt<CR>',false) end)

au_m("FileType", Py, "python", function() map('n', '<C-o>', ':vs output.txt<CR>',false) end)

au_m("FileType", Py, "python", function() map('n', '<M-o>', ':sp output.txt<CR>',false) end)

au_m("FileType", Py, "python", function() map('n', '<C-p>', ':topleft vs functions.py<CR>',false) end)
au_m("FileType", Py, "python", function() map('t', '<C-q>', '<Esc>iexit()<CR>exit<CR>',false) end)
-- )))

-- === C and CPP === (((
local Cg = api.nvim_create_augroup("Cgroup", {clear = true})
au_m("FileType", Cg, {"c", "cpp"}, function() map('n', '<C-p>', ':topleft vs functions.h<CR>',false) end)

au_m("FileType", Cg, {"cpp"},  function() map('n', '<M-t>', ':vs<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>ig++ -Wall *.cpp -o compilacion && ./compilacion<CR>', false) end)
au_m("FileType", Cg, {"cpp"},  function() map('n', '<M-c>', ':sp<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>ig++ -Wall *.cpp -o compilacion && ./compilacion<CR>', false) end)
au_m("FileType", Cg, {"cpp"},  function() map('n', '<M-CR>', ':w<CR>iclear<CR>g++ -Wall *.cpp -o compilacion && ./compilacion<CR>', false) end)

au_m("FileType", Cg, {"c"},  function() map('n', '<M-t>', ':vs<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>igcc -Wall -Wextra *.c -o comp.out && ./comp.out<CR><C-\\><C-N>gg<C-w>p', false) end)
au_m("FileType", Cg, {"c"},  function() map('n', '<M-c>', ':sp<CR>:term<CR><Esc>:set wrap<CR>:set nornu nonu<CR>igcc -Wall -Wextra *.c -o comp.out && ./comp.out<CR><C-\\><C-N>gg<C-w>p', false) end)
au_m("FileType", Cg, {"c"},  function() map('n', '<M-CR>', ':w<CR><C-W>piclear<CR>gcc -Wall -Wextra *.c -o comp.out && ./comp.out<CR><C-\\><C-N>gg<C-w>p', false) end)

au_m("FileType", Cg, {"c", "cpp"},  function() map('t', '<C-q>', '<Esc>iexit<CR>') end)
-- )))

-- === OCTAVE === (((
local Og = api.nvim_create_augroup("Octavegroup", {clear = true})

au_m("FileType", Og, "matlab",  function() map('n', '<M-p>', ':au BufWritePost *.py silent !octave % > output.txt<CR>', false) end)
au_m("FileType", Og, "matlab",  function() map('n', '<C-p>', ':topleft vs functions.m<CR>', false) end)
au_m("FileType", Og, "matlab",  function() map('n', '<M-t>', ':vs<CR>:term<CR>Aoctave<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-j>', false) end)
au_m("FileType", Og, "matlab",  function() map('n', '<M-c>', ':sp<CR>:term<CR>Aoctave<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-l>', false) end)

au_m("FileType", Og, "matlab",  function() map('t', '<C-q>', '<Esc>iexit<CR>exit<CR>') end)
-- )))

-- === RUBY === (((
local Rug = api.nvim_create_augroup("Rubygroup", {clear = true})

au_m("FileType", Rug, "ruby",  function() map('n', '<M-e>', ':au BufWritePost *.rb !ruby % > output.txt<CR>', false) end)
au_m("FileType", Rug, "ruby",  function() map('n', '<M-p>', ':au BufWritePost *.rb silent !ruby % > output.txt<CR>', false) end)
au_m("FileType", Rug, "ruby",  function() map('n', '<M-t>', ':vs<CR><M-ñ>:term<CR>Airb<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-j>', false) end)
au_m("FileType", Rug, "ruby",  function() map('n', '<M-c>', ':sp<CR><M-k>:term<CR>Airb<CR><Esc>:set wrap<CR>:set nornu nonu<CR><M-l>', false) end)

au_m("FileType", Rug, "ruby",  function() map('n', '<C-p>', ':topleft vs<CR>:e functions.m<CR>', false) end)
au_m("FileType", Rug, "ruby",  function() map('t', '<C-q>', '<Esc>iexit<CR>exit<CR>', false) end)
-- )))

-- === CSV === (((
local CSVg = api.nvim_create_augroup("CSVgroup", {clear = true})
au_c('BufReadPre', CSVg, "*.csv", "set filetype=csv")
au_m("FileType", CSVg, "csv",  function() map('n', '<C-f>', "ggVG:s/\t/<space>/g<CR>gv:'<,'>'<'>!column -t -s ' '<CR>", false) end)
au_m("FileType", CSVg, "csv",  function() map('n', '<C-b>', "ggVG:'<,'>'<'>!column -t -s ' '<CR>", false) end)
-- )))

-- === INFO === (((
local INFO = api.nvim_create_augroup("Infogroup", {clear = true})
au_c('BufReadPre', INFO, '*.info', "set filetype=info")
au_m("FileType", INFO, 'info', function () map('n', '<C-s>', "vip:'<,'>norm I [/Page <CR>vip:'<,'>norm A /OUT pdfmark<CR>") end)
-- au_m("FileType", INFO, 'info', function () map('n', '<C-S>', "I[/Cout ") end)
-- -- )))

-- === TXT === (((
local TXT = api.nvim_create_augroup("Txtgroup", {clear = true})
au_c('BufReadPost', TXT, '*.txt', "set ft=python")
-- cmd([[au Syntax txt runtime! syntax/python.vim]])
-- cmd([[au BufNewFile,BufRead *.txt set syntax=python]])
-- -- )))

-- === COLOR PICKER === (((
	--
map('i', '<M-P>', '<cmd>PickColorInsert<CR>', false)
map('n', '<M-P>', '<cmd>PickColor<CR>', false)
map('n', '<M-C>', '<cmd>ConvertHEXandRGB<CR>', false)

-- map('n', '<M-C>', '<cmd>ConvertHEXandHSL<CR>', false)
-- )))
