" Vim syntax file
" Language: Slang
" Maintainer: Isaac Sloan <isaac@isaacsloan.com>
" Version:  1
" Last Change:  2016 April 17
" TODO: Feedback is welcomed.

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'slang'
endif

" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @slangRubyTop syntax/ruby.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @slangHaml syntax/haml.vim
unlet! b:current_syntax

syn match slangBegin  "^\s*\(&[^= ]\)\@!" nextgroup=slangTag,slangClassChar,slangIdChar,slangRuby

syn region  rubyCurlyBlock start="{" end="}" contains=@slangRubyTop contained
syn cluster slangRubyTop    add=rubyCurlyBlock

syn cluster slangComponent contains=slangClassChar,slangIdChar,slangWrappedAttrs,slangRuby,slangAttr,slangInlineTagChar

syn keyword slangDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   slangDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=slangDocType

syn keyword slangTodo        FIXME TODO NOTE OPTIMIZE XXX contained
syn keyword htmlTagName     contained script

syn match slangTag           "\w\+[><]*"         contained contains=htmlTagName nextgroup=@slangComponent
syn match slangIdChar        "#{\@!"        contained nextgroup=slangId
syn match slangId            "\%(\w\|-\)\+" contained nextgroup=@slangComponent
syn match slangClassChar     "\."           contained nextgroup=slangClass
syn match slangClass         "\%(\w\|-\)\+" contained nextgroup=@slangComponent
syn match slangInlineTagChar "\s*:\s*"      contained nextgroup=slangTag,slangClassChar,slangIdChar

syn region slangWrappedAttrs matchgroup=slangWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=slangAttr nextgroup=slangRuby
syn region slangWrappedAttrs matchgroup=slangWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=slangAttr nextgroup=slangRuby
syn region slangWrappedAttrs matchgroup=slangWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=slangAttr nextgroup=slangRuby

syn match slangAttr /\s*\%(\w\|-\)\+\s*=/me=e-1 contained contains=htmlArg nextgroup=slangAttrAssignment
syn match slangAttrAssignment "\s*=\s*" contained nextgroup=slangWrappedAttrValue,slangAttrString

syn region slangWrappedAttrValue start="[^"']" end="\s\|$" contained contains=slangAttrString,@slangRubyTop nextgroup=slangAttr,slangRuby,slangInlineTagChar
syn region slangWrappedAttrValue matchgroup=slangWrappedAttrValueDelimiter start="{" end="}" contained contains=slangAttrString,@slangRubyTop nextgroup=slangAttr,slangRuby,slangInlineTagChar
syn region slangWrappedAttrValue matchgroup=slangWrappedAttrValueDelimiter start="\[" end="\]" contained contains=slangAttrString,@slangRubyTop nextgroup=slangAttr,slangRuby,slangInlineTagChar
syn region slangWrappedAttrValue matchgroup=slangWrappedAttrValueDelimiter start="(" end=")" contained contains=slangAttrString,@slangRubyTop nextgroup=slangAttr,slangRuby,slangInlineTagChar

syn region slangAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slangInterpolation,slangInterpolationEscape nextgroup=slangAttr,slangRuby,slangInlineTagChar
syn region slangAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slangInterpolation,slangInterpolationEscape nextgroup=slangAttr,slangRuby,slangInlineTagChar

syn region slangInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=slangInterpolation,slangInterpolationEscape nextgroup=slangAttr
syn region slangInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=slangInterpolation,slangInterpolationEscape nextgroup=slangAttr

syn region slangInterpolation matchgroup=slangInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,slangWrappedAttrs
syn region slangInterpolation matchgroup=slangInterpolationDelimiter start="#{{" end="}}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,slangWrappedAttrs
syn match  slangInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region slangRuby matchgroup=slangRubyOutputChar start="\s*[=]\==[']\=" skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slangRubyTop keepend
syn region slangRuby matchgroup=slangRubyChar       start="\s*-"           skip="\%\(,\s*\|\\\)$" end="$" contained contains=@slangRubyTop keepend

syn match slangComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=slangTodo
syn match slangText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/ contains=slangInterpolation

syn match slangFilter /\s*\w\+:\s*/                            contained
syn match slangHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@slangHaml,slangFilter

syn match slangIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=slangComment

hi def link slangAttrString                String
hi def link slangBegin                     String
hi def link slangClass                     Type
hi def link slangAttr                      Type
hi def link slangClassChar                 Type
hi def link slangComment                   Comment
hi def link slangDocType                   Identifier
hi def link slangDocTypeKeyword            Keyword
hi def link slangFilter                    Keyword
hi def link slangIEConditional             SpecialComment
hi def link slangId                        Identifier
hi def link slangIdChar                    Identifier
hi def link slangInnerAttrString           String
hi def link slangInterpolationDelimiter    Delimiter
hi def link slangRubyChar                  Special
hi def link slangRubyOutputChar            Special
hi def link slangText                      String
hi def link slangTodo                      Todo
hi def link slangWrappedAttrValueDelimiter Delimiter
hi def link slangWrappedAttrsDelimiter     Delimiter
hi def link slangInlineTagChar             Delimiter

let b:current_syntax = "slang"
