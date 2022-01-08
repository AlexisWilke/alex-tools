" Vim syntax file
" Language:	C++ & definitions for presentrack
" Maintainer:	Alexis Wilke <alexis@eden.com>
" Last change:	1999 Dec 11

" Remove any old syntax stuff hanging around
syn clear

" Disassembler definitions

syn keyword admControl		end
syn keyword admControl		goto
syn keyword admControl		gosub
syn keyword admControl		if
syn keyword admControl		igoto
syn keyword admControl		return
syn keyword admControl		then

syn keyword admKeyword		print
syn keyword admKeyword		set

syn keyword admData		data



syn match admLabel		"^[A-Za-z_0-9@$]\+:"
syn match admSet			"[A-Za-z_0-9@$]\+[ \t]\+=[ \t]\+"
syn match admSet			"[A-Za-z_0-9@$]\+[ \t]\+:=[ \t]\+"
syn match admSet			"[A-Za-z_0-9@$]\+[ \t]\+<-[ \t]\+"


syn match admTODO		contained "TODO:\+"
syn match admTODO		contained "(TODO:\+.*)"

syn region admComment	start="^[ \t]*#" end=".*$" contains=admTODO


let b:current_syntax = "disassembler"

if !exists("did_disassembler_syntax_inits")
  let did_disassembler_syntax_inits = 1
  hi admControl  guifg=#FF0000
  hi admLabel    guifg=#008800
  hi admComment  guifg=#0000FF
  hi admSet      guifg=#FF00FF
  hi admKeyword  guifg=#995500
  hi admData     guifg=#000088
  hi admTODO     guifg=#0000FF guibg=#FFFF00
endif

" vim: ts=8

