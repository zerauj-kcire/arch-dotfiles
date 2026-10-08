" File: quicktex.vim
" Author: Bennett Rennier <barennier AT gmail.com>
" Website: brennier.com
" Description: Maps keywords into other words, functions, keypresses, etc.
" while in insert mode. The main purpose is for writing LaTeX faster. Also
" includes different namespaces for inside and outside of math mode.
" Last Edit: Jan 16, 2018

" Call the assignment function after the filetype of the file has been
" determined.
autocmd FileType * call AssignExpander()

if !exists('g:quicktex_excludechar')
    let g:quicktex_excludechar = ['{', '(', '[']
endif

if get(g:, 'quicktex_always_latex', 1)
    let g:tex_flavor = 'latex'
endif

if !exists('g:quicktex_math_filetypes')
   let g:quicktex_math_filetypes = ['tex', 'pandoc', 'markdown']
endif

function! AssignExpander()
		let trigger = '<Tab>'

    " If a dictionary for the filetype exists, then map the ExpandWord
    " function to the trigger.
    if (exists('g:quicktex_math') && index(g:quicktex_math_filetypes, &ft)+1)
      \ || exists('g:quicktex_'.&ft)
        execute('inoremap <silent> <buffer> '.trigger.
                    \' <C-r>=quicktex#expand#ExpandWord("'.&ft.'")<CR>')
    endif
endfunction

function! quicktex#DoJump()
    " Find the next occurrence of <++>, delete it, and enter insert mode
    if search('<+++>', 'z')
        " Delete using the black hole register `_` instead of the default register
        normal! "_df>
        if col(".") == col("$") - 1
            startinsert!
        else
            startinsert
        endif
    endif
endfunction
