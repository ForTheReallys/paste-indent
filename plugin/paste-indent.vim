" paste-indent.vim - Indent lines after every paste
" Maintainer:   Alex Maese (memaese@hotmail.com)

if exists("g:loaded_paste_indent")
    finish
endif
let g:loaded_paste_indent = 1

command PasteIndentOn call s:CreateMappings()
command PasteIndentOff call s:DestroyMappings()

function! s:DestroyMappings()
    execute "nunmap " . s:after_char
    execute "nunmap " . s:before_char
endfunction

function! s:CreateMappings()
    let s:after_char  = "p"
    let s:before_char = "P"

    if exists("g:paste_indent_after_char")
        let s:after_char = g:paste_indent_after_char
    endif

    if exists("g:paste_indent_before_char")
        let s:before_char = g:paste_indent_before_char
    endif

    map <script> <silent> <Plug>PasteIndentBefore :<C-u>call <SID>PasteBefore()<CR>
    map <script> <silent> <Plug>PasteIndentAfter :<C-u>call <SID>PasteAfter()<CR>

    execute "nmap " . s:before_char . " <Plug>PasteIndentBefore"
    execute "nmap " . s:after_char  . " <Plug>PasteIndentAfter"
endfunction

if !exists("g:paste_indent_off") || g:paste_indent_off == 0
    call s:CreateMappings()
endif

"pastes content and indents contents
function s:PasteIndent(key)
    "use the right register
    let l:buffer = getreg(v:register)

    "TODO make this work for all platforms
    let l:eol = "\n"
    let l:newlines = count(l:buffer, l:eol)

    let l:total_lines = l:newlines * v:count1

    let l:indent = 0

    "linewise
    if l:total_lines
        let l:indent = l:total_lines
    "characterwise and an empty line
    elseif getline(".") =~ '^\s*$' && !l:newlines
        let l:indent = 1
    endif

    execute 'normal! "'.v:register.v:count1.a:key

    "always indent unless characterwise paste AND not an empty line
    if l:indent
        execute "normal! ".l:total_lines."=="
    endif
endfunction

function s:PasteBefore()
    call s:PasteIndent('P')
endfunction

function s:PasteAfter()
    call s:PasteIndent('p')
endfunction

