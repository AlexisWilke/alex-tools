" Vim syntax file
" Language:	SSWF
" Maintainer:	Alexis Wilke <alexis@m2osw.com>
" Last change:	2003 Nov 1
"
" Copyright (c) 2002-2006 Made to Order Software Corp.
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

" by default we ignore the case
syn case ignore

" minimum number of lines for synchronization
" /* ... */ comments can be long
syn sync minlines=150

" Keywords (mainly objects)
syn keyword	sswfObject		ACTION DO BUTTON STATE FONT TEXT SETUP GLYPH
syn keyword	sswfObject		BLOCK COLOR LIST TRANSFORM FILL STYLE LINE
syn keyword	sswfObject		REMOVE PLACE OBJECT EDGES GRADIENT IMAGE FOR
syn keyword	sswfObject		MATRIX RECT RECTANGLE ALL SEQUENCE SET POINTS
syn keyword	sswfObject		BACKGROUND DEFINE SHAPE SHOW FRAME SPRITE END
syn keyword	sswfObject		LABEL REPLACE FUNCTION WITH IF ELSE EDIT
syn keyword	sswfObject		IMPORT EXPORT SOUND INFO TAB INDEX SCRIPT
syn keyword	sswfObject		LIMITS TRY CATCH FINALLY METADATA

syn match	sswfObject		"ACTION_\=SCRIPT"
syn match	sswfObject		"DO_\=ACTION"
syn match	sswfObject		"FILL_\=STYLE"
syn match	sswfObject		"FRAME_\=LABEL"
syn match	sswfObject		"LINE_\=STYLE"
syn match	sswfObject		"SCRIPT_\=LIMITS"
syn match	sswfObject		"SET_\=BACKGROUND_\=COLOR"
syn match	sswfObject		"SET_\=TAB_\=INDEX"
syn match	sswfObject		"SHOW_\=FRAME"
syn match	sswfObject		"SOUND_\=INFO"
syn match	sswfObject		"TEXT_\=SETUP"

syn keyword	sswfUnit		BC CM DEG FC FPF FPS GRAD IN PT PX RAD RT TW

syn keyword	sswfSpecialReference	CLIPPING

" Constants
syn keyword	sswfConstant		true false
syn match	sswfConstant		"\<0x[0-9A-F]\+\>"
syn match	sswfConstant		"\<0[0-7]*\>"
syn match	sswfConstant		"\<[1-9][0-9]*\.\=[0-9]*\(E+[0-9]\+\)\=\>"
syn match	sswfConstant		"\<0\=\.[0-9]\+\(E+[0-9]\+\)\=\>"
syn region	sswfConstant		start=+"+ skip=+\\.+ end=+"+
syn region	sswfConstant		start=+'+ skip=+\\.+ end=+'+
syn region	sswfConstant		start=+`+ skip=+\\.+ end=+`+

" Labels
syn match	sswfLabel		"[A-Z_0-9]\+[ \t\r\n]*:[^=]\="

" prevent labels in `?:' expressions
syn region	sswfNothing		start="?" end=":" contains=sswfConstant,sswfCComment,sswfPComment

" Special Variables
syn match	sswfSpecialVariable	"FRAME_\=RATE"
syn match	sswfSpecialVariable	"MINIMUM_\=VERSION"
syn match	sswfSpecialVariable	"MAXIMUM_\=VERSION"
syn match	sswfSpecialVariable	"USE_\=NETWORK"
syn keyword	sswfSpecialVariable	PROTECT COMPRESS VERSION

" Comments
syn keyword	sswfTodo		contained TODO FIXME XXX
syn match	sswfTodo		contained "WATCH\(\s\=OUT\)\="
syn region	sswfCComment		start="/\*" end="\*/" contains=sswfTodo
syn region	sswfPComment		start="(\*" end="\*)" contains=sswfTodo
syn region	sswfCPPComment		start="//" end="$" contains=sswfTodo


let b:current_syntax = "sswf"

if !exists("did_sswf_syntax_inits")
  let did_sswf_syntax_inits = 1
  hi link sswfCComment		Comment
  hi link sswfPComment		Comment
  hi link sswfCPPComment	Comment
  hi link sswfLabel		Typedef
  hi link sswfTodo		Todo
  hi link sswfObject		Keyword
  hi link sswfUnit		Type
  hi link sswfOperator		Operator
  hi link sswfConstant		Constant
  hi link sswfBackslash		Backslash
  hi sswfSpecialVariable	guifg=#883333
  hi sswfSpecialReference	guifg=#FF0000 gui=italic
endif
