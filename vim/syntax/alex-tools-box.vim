" Vim syntax file
" Language:	Boxmaker Resources
" Maintainer:	Alexis Wilke <alexis@eden.com>
" URL:		http://www.eden.com/~alexis
" Last change:	2000 Jul 14

" Remove any old syntax stuff hanging around
syn clear

" This file makes use of the highlighting "Function", which is not defined
" in the normal syntax.vim file yet.

" pre-processor
syn region boxPreprocessor	start="^#\<\(if\|ifdef\|ifndef\|elif\|else\|endif\|include\)\>" end="$"
syn match boxPreprocessor	"^#\<\(else\|endif\)\>"


" keywords
syn keyword boxKeyword		box
syn keyword boxKeyword		col
syn keyword boxKeyword		def
syn keyword boxKeyword		error
syn keyword boxKeyword		include
syn keyword boxKeyword		slider
syn keyword boxKeyword		string
syn keyword boxKeyword		tag
syn keyword boxKeyword		text
syn keyword boxKeyword		window
syn match boxKeyword		"^Def[ \t]"

" special C keywords we often use in box files
syn keyword boxKeyword		offsetof
syn keyword boxKeyword		sizeof

" fields (box keywords)
syn case ignore
syn keyword boxField		COLOR
syn keyword boxField		ETAG
syn keyword boxOldField		ETEXT
syn keyword boxOldField		ESLIDER
syn keyword boxOldField		FLAG
syn keyword boxField		FLAGS
syn keyword boxField		FUNC
syn keyword boxUnusedField	LEVEL
syn keyword boxField		NAME
syn keyword boxUnusedField	PERM
syn keyword boxField		POS
syn keyword boxField		RANGE
syn keyword boxField		STR
syn keyword boxField		SIZE
syn keyword boxField		XP
syn keyword boxField		XS
syn keyword boxField		YP
syn keyword boxField		YS
syn case match

syn match boxStartC		"%{"
syn match boxIncludeC		"%#include"
syn match boxEndC		"%}"

syn match boxComment		";.*$"
syn region boxComment		start="/\*" end="\*/"
syn region boxString		start='"' skip='\\"\|\\\\' end='"'


syn match boxHeader contained	"//PTFile V[0-9]\+\.[0-9]\+"ms=s+2




if !exists("did_presenttrack_resources_syntax_inits")
  let did_presenttrack_resources_syntax_inits = 1
  hi link boxPreprocessor	PreCondit
  hi link boxKeyword		Statement
  hi link boxField		Identifier
  hi link boxString		String
  hi link boxComment		Comment
  hi link boxStartC		Constant
  hi link boxEndC		Constant
  hi link boxIncludeC		Type
  hi boxOldField		guifg=#CC6600
  hi boxUnusedField		guifg=#CC6600
endif

let b:current_syntax = "resource"

" vim: ts=8
