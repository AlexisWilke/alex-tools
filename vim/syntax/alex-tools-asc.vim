" Vim syntax file
" Language:	ASC
" Maintainer:	Alexis Wilke <alexis@m2osw.com>
" Last change:	2005 Jul 5
"
" Copyright (c) 2005 Made to Order Software, Ltd.
"
" Permission is hereby granted, free of charge, to any
" person obtaining a copy of this software and
" associated documentation files (the "Software"), to
" deal in the Software without restriction, including
" without limitation the rights to use, copy, modify,
" merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom
" the Software is furnished to do so, subject to the
" following conditions:
"
" The above copyright notice and this permission notice
" shall be included in all copies or substantial
" portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
" ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
" LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
" FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO
" EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
" WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
" ARISING FROM, OUT OF OR IN CONNECTION WITH THE
" SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
" SOFTWARE.
"


" Remove any other syntax
syn clear

set formatoptions-=tc
set formatoptions+=or

" minimum number of lines for synchronization
" /* ... */ comments can be long
syn sync minlines=150


" Operators
syn match	ascOperator		"+"
syn match	ascOperator		"&"
syn match	ascOperator		"\~"
syn match	ascOperator		"|"
syn match	ascOperator		"\^"
syn match	ascOperator		","
syn match	ascOperator		"/"
syn match	ascOperator		">"
syn match	ascOperator		"<"
syn match	ascOperator		"!"
syn match	ascOperator		"%"
syn match	ascOperator		"\*"
syn match	ascOperator		"\."
syn match	ascOperator		";"
syn match	ascOperator		"-"
syn match	ascOperator		"="
syn match	ascOperator		"+="
syn match	ascOperator		"&="
syn match	ascOperator		"|="
syn match	ascOperator		"\^="
syn match	ascOperator		"/="
syn match	ascOperator		"&&="
syn match	ascOperator		"||="
syn match	ascOperator		"\^\^="
syn match	ascOperator		"%="
syn match	ascOperator		"\*="
syn match	ascOperator		"\*\*="
syn match	ascOperator		"<<="
syn match	ascOperator		">>="
syn match	ascOperator		">>>="
syn match	ascOperator		"!<="
syn match	ascOperator		"!>="
syn match	ascOperator		"-="
syn match	ascOperator		"--"
syn match	ascOperator		"=="
syn match	ascOperator		">="
syn match	ascOperator		"++"
syn match	ascOperator		"<="
syn match	ascOperator		"&&"
syn match	ascOperator		"||"
syn match	ascOperator		"\^\^"
syn match	ascOperator		"\~="
syn match	ascOperator		"?>"
syn match	ascOperator		"?<"
syn match	ascOperator		"!="
syn match	ascOperator		"\*\*"
syn match	ascOperator		"\.\."
syn match	ascOperator		"\.\.\."
syn match	ascOperator		"!<"
syn match	ascOperator		"!>"
syn match	ascOperator		"::"
syn match	ascOperator		"<<"
syn match	ascOperator		">>"
syn match	ascOperator		">>>"
syn match	ascOperator		"==="
syn match	ascOperator		"!==="


" Complex keywords
syn match	ascKeyword		"\<function\>\([ \t\n\r]\+\<[sg]et\>\)\="
syn match	ascKeyword		"\<for\>\([ \t\n\r]\+\<each\>\)\="

" Keywords
syn keyword	ascKeyword		as break case catch class const
syn keyword	ascKeyword		continue default delete do else
syn keyword	ascKeyword		enum extends finally friend
syn keyword	ascKeyword		goto if implements import in
syn keyword	ascKeyword		inline instanceof interface
syn keyword	ascKeyword		intrinsic is namespace new package
syn keyword	ascKeyword		private public return super switch
syn keyword	ascKeyword		this throw try typeof use var
syn keyword	ascKeyword		virtual with while

" Known Types (internal)
syn keyword	ascType			Array Boolean Date Double Function Global
syn keyword	ascType			Integer Math Native Number Object
syn keyword	ascType			RegularExpression String System Void

" Constants
syn keyword	ascConstant		true false null undefined Infinity NaN
syn match	ascConstant		"\<0x[0-9A-F]\+\>"
syn match	ascConstant		"\<0[0-7]*\>"
syn match	ascConstant		"\<[1-9][0-9]*\.\=[0-9]*\([eE][+-]\=[0-9]\+\)\=\>"
syn match	ascConstant		"\<0\=\.[0-9]\+\([eE][+-]\=[0-9]\+\)\=\>"
syn region	ascConstant		start=+"+ skip=+\\.+ end=+"+
syn region	ascConstant		start=+'+ skip=+\\.+ end=+'+
syn region	ascRegularExpression	start=+`+ skip=+\\.+ end=+`+


" Labels
syn match	ascLabel		"^[a-zA-Z_$][a-zA-Z_$0-9]*[ \t\r\n]*:[^=:]\="

" prevent labels in `?:' expressions
syn region	ascNothing		start="?" end=":" contains=ascConstant,ascLComment,ascMComment
syn match	ascOperator		"?"
syn match	ascOperator		":"


" Comments
syn keyword	ascTodo			contained TODO FIXME XXX
syn match	ascTodo			contained "WATCH\(\s\=OUT\)\="
syn region	ascMComment		start="/\*" end="\*/" contains=ascTodo
syn region	ascLComment		start="//" end="$" contains=ascTodo


let b:current_syntax = "asc"

if !exists("did_asc_syntax_inits")
  let did_asc_syntax_inits = 1
  hi link ascKeyword		Keyword
  hi link ascMComment		Comment
  hi link ascLComment		Comment
  hi link ascLabel		Typedef
  hi link ascTodo		Todo
  hi link ascType		Type
  hi link ascOperator		Operator
  hi link ascConstant		Constant
  hi link ascRegularExpression	Constant
endif
