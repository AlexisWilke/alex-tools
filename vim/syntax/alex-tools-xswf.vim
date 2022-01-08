" Vim syntax file
" Language:	SSWF
" Maintainer:	Alexis Wilke <alexis@m2osw.com>
" Last change:	2003 Nov 1
"
" Copyright (c) 2002-2005 Made to Order Software, Ltd.
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

" V5: Remove any other syntax
" V6: Keep what is already defined
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif


" Read the SSWF syntax to start with
if version < 600
  so <sfile>:p:h/sswf.vim
else
  runtime! syntax/sswf.vim
  unlet b:current_syntax
endif

" XSWF tags
syn match	xswfTag			"<variable>"
syn match	xswfTag			"</variable>"
syn match	xswfTag			"<sample>"
syn match	xswfTag			"</sample>"

let b:current_syntax = "xswf"

if !exists("did_xswf_syntax_inits")
  let did_xswf_syntax_inits = 1
  hi xswfTag			guifg=#338833
endif
