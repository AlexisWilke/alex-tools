" Vim syntax file
" Language:	PresentTrack Resources
" Maintainer:	Alexis Wilke <alexis@eden.com>
" URL:		http://www.eden.com/~alexis
" Last change:	1999 Nov 17

" Remove any old syntax stuff hanging around
syn clear

" This file makes use of the highlighting "Function", which is not defined
" in the normal syntax.vim file yet.

" the resource specific keywords are not case sensitive
syn case ignore


" identifiers are checked before keywords
syn match rscIdentifier		"[a-z][a-z0-9_-]*"
syn match rscField		"^\s*[a-z][a-z0-9_-]*"


" keywords
syn match rscKeyword		"button"
syn match rscKeyword		"button-icon"
syn keyword rscKeyword		check
syn keyword rscKeyword		edit
syn match rscKeyword		"file-list"
syn match rscKeyword		"file-manager"
syn keyword rscKeyword		folder
syn keyword rscKeyword		frame
syn match rscKeyword		"icon"
syn match rscKeyword		"icon-file"
syn keyword rscKeyword		image
syn keyword rscKeyword		label
syn keyword rscKeyword		list
syn match rscKeyword		"menu.*{"me=s+4
syn match rscKeyword		"menubar"
syn match rscKeyword		"menubar-button"
syn match rscKeyword		"menu-button"
syn match rscKeyword		"menu-check"
syn match rscKeyword		"menu-dialog"
syn match rscKeyword		"menu-radio"
syn match rscKeyword		"menu-separator"
syn match rscKeyword		"scrolled-table"
syn keyword rscKeyword		shell
syn keyword rscKeyword		slider
syn keyword rscKeyword		submenu
syn match rscKeyword		"table"
syn keyword rscKeyword		text
syn match rscKeyword		"window.*{"me=s+6


syn match rscComment		"\/\/.*"	contains=rscHeader
syn match rscString		'"[^"]*"'

syn case match

syn match rscHeader contained	"//PTFile V[0-9]\+\.[0-9]\+"ms=s+2




if !exists("did_presenttrack_resources_syntax_inits")
  let did_presenttrack_resources_syntax_inits = 1
  hi link rscKeyword		Statement
  hi link rscHeader		Identifier
  hi link rscString		String
  hi link rscComment		Comment
  hi link rscIdentifier		Identifier
  hi rscField			guifg=#CC6600
endif

let b:current_syntax = "resource"

" vim: ts=8
