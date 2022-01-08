" Vim syntax file
" Language:	Makefile
" Maintainer:	Alexis Wilke <alexis@m2osw.com>
" URL:		http://www.m2osw.com/amake
" Last change:	2002 Jan 25

" Remove any old syntax stuff hanging around
syn clear

" This file makes use of the highlighting "Function", which is not defined
" in the normal syntax.vim file yet.


" the new line preceeded by a \ is a line continuation
syn match makeNextLine	contained "\\$"


" identifiers
syn match makeIdentList contained	"\s[A-Za-z0-9_.+-]\+\>"
syn match makeIdent			"^\s*[A-Za-z0-9_.! \t+-]\+="me=e-1 contains=makeCpp
syn match makeIdent			"^\s*[A-Za-z0-9_.! \t+-]\+[:<+?!]="me=e-2 contains=makeCpp
syn match makeIdent			"^\s*[A-Za-z0-9_.! \t+-]\+:\s*sh\s*="me=e-1 contains=makeCpp
syn match makeIdent			"%"

" comments which are like processor
syn region makeComment			start="#" end=".*$" contains=makeCpp,makeNextLine


" this first one has been very well worked out for the [!.]export command; do not modify if you don't know what you're doing
" syn region makeCpp	matchgroup=makeCpp start="^\s*\(export\|override\|undef\|unexport\|vpath\)\>" matchgroup=makeIdent end="$" contains=makeIdentList,makeSString,makeDString,makeBString,makeMacro
syn match  makeCpp	"^[.!]\=\(export\|override\|undef\|unexport\|vpath\)\>"

syn region makeCpp	matchgroup=makeCpp start="^[.!]\=define\>" matchgroup=makeIdent end="$" contains=makeIdent,makeMacro,makeDString,makeSString,makeBString,makeNextLine
syn region makeCpp	matchgroup=makeCpp start="^[.!]\=\(ident\|noop\)\>" end="$"
syn region makeCpp	matchgroup=makeCpp start="^[.!]\=\(error\|echo\|message\|shell\|loaddll\|warn\)\>" matchgroup=makeMessage end="$" contains=makeExpr,makeDString,makeSString,makeBString,makeIdent,makeMacro,makeOperator,makeNextLine
syn region makeCpp	matchgroup=makePreCondit start="^[.!]\=\(else\|el\)\=ifn\=\(def\|eqi\=\|make\)\=\>" matchgroup=NONE end="$" contains=makeExpr,makeDString,makeSString,makeBString,makeIdent,makeMacro,makeOperator,makeNextLine
syn region makeCpp	matchgroup=makePreCondit start="^[.!]\=else\>" matchgroup=makeComment end="$"
syn region makeCpp	matchgroup=makePreCondit start="^[.!]\=end\(for\|if\)\=\>" matchgroup=makeComment end="$"
syn region makeCpp	matchgroup=makeCpp start="^[.!]\=[-s]\=include\>" matchgroup=makeIdent end="$" contains=makeDString,makeSString,makeBString,makeIString
syn region makeCpp	matchgroup=makeCpp start="^[.!]\=includedir\>" matchgroup=makeIdent end="$" contains=makeDString,makeSString,makeBString,makeIString
syn region makeCpp	matchgroup=makeCpp start="^[.!]\=for\>" matchgroup=NONE end="$" contains=makeIn,makeDString,makeSString,makeBString,makeMacro,makeNextLine

" preprocessor directives
"   common operators
syn match  makeOperator "="
syn match  makeOperator "+="
syn match  makeOperator "?="
syn match  makeOperator "!="
syn match  makeOperator ":="
syn match  makeOperator "<="
"   preprocessor only operators
syn match  makeOperator contained "\["
syn match  makeOperator contained "]"
syn match  makeOperator contained "\*\*"
syn match  makeOperator contained "\*"
syn match  makeOperator contained "/"
syn match  makeOperator contained "%"
syn match  makeOperator contained "+"
syn match  makeOperator contained "-"
syn match  makeOperator contained "<<"
syn match  makeOperator contained ">>"
syn match  makeOperator contained "(..*)" contains=makeExpr,makeOperator,makeIdent,makeMacro,makeSString,makeDString,makeBString
syn match  makeOperator contained "^"
syn match  makeOperator contained "|"
syn match  makeOperator contained "||"
syn match  makeOperator contained "&"
syn match  makeOperator contained "&&"
syn match  makeOperator contained "!"
syn match  makeOperator contained "\~"
syn match  makeOperator contained "=="
syn match  makeOperator contained "!="
syn match  makeOperator contained "<>"
syn match  makeOperator contained "<"
syn match  makeOperator contained ">"
syn match  makeOperator contained "<="
syn match  makeOperator contained ">="
" syn match  makeExpr contained "(..*)" contains=makeExpr,makeIdent
syn case ignore
syn match  makeExpr contained "\<[0-9]\+"
syn match  makeExpr contained "\<0x[0-9a-f]\+"
syn case match
syn keyword makeIn contained in
syn region makeExpr contained start="\(count\|$d\|debug\|defined\|empty\|exists\|islocked\|make\|sizeof\|system\|target\|version\)(" skip="([^)]*)" end=")" contains=makeExpr,makeIdent,makeDString,makeSString,makeBString
syn region makeCpp	matchgroup=makeCpp start="^#define\>" matchgroup=makeIdent end="$" contains=makeIdent,makeDString,makeSString,makeBString
syn region makeCpp	matchgroup=makeCpp start="^#\(export\|override\|undef\|unexport\|vpath\)\>" matchgroup=NONE end="$" contains=makeIdent,makeMacro,makeOperator,makeDString,makeSString,makeBString,makeNextLine
syn region makeCpp	matchgroup=makeCpp start="^#\(error\|echo\|ident\|noop\|message\|shell\|loaddll\|warn\)\>" matchgroup=makeMessage end="$" contains=makeExpr,makeDString,makeSString,makeBString,makeIdent,makeMacro,makeOperator,makeNextLine
syn region makeCpp	matchgroup=makePreCondit start="^#\(else\|el\)\=ifn\=\(def\|eqi\=\|make\)\=\>" matchgroup=NONE end="$" contains=makeExpr,makeDString,makeSString,makeBString,makeIdent,makeMacro,makeOperator,makeNextLine
syn region makeCpp	matchgroup=makePreCondit start="^#else\>" matchgroup=makeComment end="$"
syn region makeCpp	matchgroup=makePreCondit start="^#end\(for\|if\)\=\>" matchgroup=makeComment end="$"
syn region makeCpp	matchgroup=makeCpp start="^#[-s]\=include\>" matchgroup=makeIdent end="$" contains=makeDString,makeSString,makeBString,makeIString
syn region makeCpp	matchgroup=makeCpp start="^#includedir\>" matchgroup=makeIdent end="$" contains=makeDString,makeSString,makeBString,makeIString
syn region makeCpp	matchgroup=makeCpp start="^#for\>" matchgroup=NONE end="$" contains=makeIn,makeDString,makeSString,makeBString,makeIdent


" make targets
syn match makeSpecTarget	"\.AFTER"
syn match makeSpecTarget	"\.AUTODEPEND"
syn match makeSpecTarget	"\.BEFORE"
syn match makeSpecTarget	"\.BEGIN"
syn match makeSpecTarget	"\.BLOCK"
syn match makeSpecTarget	"\.CHECK"
syn match makeSpecTarget	"\.CONTINUE"
syn match makeSpecTarget	"\.DEFAULT"
syn match makeSpecTarget	"\.DELETE_ON_ERROR"
syn match makeSpecTarget	"\.DONE"
syn match makeSpecTarget	"\.DONTCARE"
syn match makeSpecTarget	"\.END"
syn match makeSpecTarget	"\.ERASE"
syn match makeSpecTarget	"\.ERROR"
syn match makeSpecTarget	"\.EXCLUSIVE"
syn match makeSpecTarget	"\.EXEC"
syn match makeSpecTarget	"\.EXPORT"
syn match makeSpecTarget	"\.EXPORTSAME"
syn match makeSpecTarget	"\.EXPORT_ALL_VARIABLE"
syn match makeSpecTarget	"\.EXPORT_ALL_VARIABLES"
syn match makeSpecTarget	"\.FAILED"
syn match makeSpecTarget	"\.FIRST"
syn match makeSpecTarget	"\.HOLD"
syn match makeSpecTarget	"\.IGNORE"
syn match makeSpecTarget	"\.IMAKE"
syn match makeSpecTarget	"\.INCLUDES"
syn match makeSpecTarget	"\.INIT"
syn match makeSpecTarget	"\.INTERMEDIATE"
syn match makeSpecTarget	"\.INTERRUPT"
syn match makeSpecTarget	"\.INVISIBLE"
syn match makeSpecTarget	"\.JOIN"
syn match makeSpecTarget	"\.KEEP_STATE"
syn match makeSpecTarget	"\.KEEP_ON_ERROR"
syn match makeSpecTarget	"\.LAST"
syn match makeSpecTarget	"\.LIBS"
syn match makeSpecTarget	"\.LOCK"
syn match makeSpecTarget	"\.MAIN"
syn match makeSpecTarget	"\.MAKE"
syn match makeSpecTarget	"\.MAKEFLAGS"
syn match makeSpecTarget	"\.MAKEOPTS"
syn match makeSpecTarget	"\.MAKE_VERSION"
syn match makeSpecTarget	"\.NETWORK"
syn match makeSpecTarget	"\.NOCHECK"
syn match makeSpecTarget	"\.NODATE"
syn match makeSpecTarget	"\.NOEXPORT"
syn match makeSpecTarget	"\.NOTMAIN"
syn match makeSpecTarget	"\.NOTPARALLEL"
syn match makeSpecTarget	"\.NO_OPERATION"
syn match makeSpecTarget	"\.NO_PARALLEL"
syn match makeSpecTarget	"\.NULL"
syn match makeSpecTarget	"\.OPTIMIZE"
syn match makeSpecTarget	"\.OPTIONAL"
syn match makeSpecTarget	"\.ORDER"
syn match makeSpecTarget	"\.PARALLEL"
syn match makeSpecTarget	"\.PATH"
syn match makeSpecTarget	"\.PHONY"
syn match makeSpecTarget	"\.POSIX"
syn match makeSpecTarget	"\.PRECIOUS"
syn match makeSpecTarget	"\.RECURSIVE"
syn match makeSpecTarget	"\.REDO"
syn match makeSpecTarget	"\.SECONDARY"
syn match makeSpecTarget	"\.SHELL"
syn match makeSpecTarget	"\.SILENT"
syn match makeSpecTarget	"\.SINGLESHELL"
syn match makeSpecTarget	"\.SUFFIXES"
syn match makeSpecTarget	"\.TERMINAL"
syn match makeSpecTarget	"\.USE"
syn match makeSpecTarget	"\.WAIT"

syn case ignore

syn match makeImplicit		"^\(\.[A-Z0-9_+-]*\~\=\)\{1,2}\s*[:!][^=]"me=e-2
syn match makeImplicit		"^\(\.[A-Z0-9_+-]*\~\=\)\{1,2}\s*[:!]$"me=e-1

syn match makePattern		"^\([A-Z0-9_.,-/]*%[A-Z0-9_.,-/]*\s*\)\+[:!][^=]"me=e-2
syn match makePattern		"^\([A-Z0-9_.,-/]*%[A-Z0-9_.,-/]*\s*\)\+[:!]$"me=e-1

syn match makeTarget		"^[A-Z0-9_.-][A-Z0-9_./\t +-]*[:!][^=]"me=e-2
syn match makeTarget		"^[A-Z0-9_.-][A-Z0-9_./\t +-]*[:!]$"me=e-1

syn case match



" Statements / Functions (GNU make)
syn match makeStatement contained "(addprefix"ms=s+1
syn match makeStatement contained "(addsuffix"ms=s+1
syn match makeStatement contained "(basename"ms=s+1
syn match makeStatement contained "(call"ms=s+1
syn match makeStatement contained "(concat"ms=s+1
syn match makeStatement contained "(dir"ms=s+1
syn match makeStatement contained "(echo"ms=s+1
syn match makeStatement contained "(error"ms=s+1
syn match makeStatement contained "(filter"ms=s+1
syn match makeStatement contained "(filter-out"ms=s+1
syn match makeStatement contained "(findstring"ms=s+1
syn match makeStatement contained "(firstword"ms=s+1
syn match makeStatement contained "(foreach"ms=s+1
syn match makeStatement contained "(join"ms=s+1
syn match makeStatement contained "(lastword"ms=s+1
syn match makeStatement contained "(lowercase"ms=s+1
syn match makeStatement contained "(message"ms=s+1
syn match makeStatement contained "(notdir"ms=s+1
syn match makeStatement contained "(origin"ms=s+1
syn match makeStatement contained "(patsubst"ms=s+1
syn match makeStatement contained "(shell"ms=s+1
syn match makeStatement contained "(sort"ms=s+1
syn match makeStatement contained "(strip"ms=s+1
syn match makeStatement contained "(subst"ms=s+1
syn match makeStatement contained "(suffix"ms=s+1
syn match makeStatement contained "(uppercase"ms=s+1
syn match makeStatement contained "(warning"ms=s+1
syn match makeStatement contained "(wildcard"ms=s+1
syn match makeStatement contained "(word"ms=s+1
syn match makeStatement contained "(wordlist"ms=s+1
syn match makeStatement contained "(words"ms=s+1

" some special characters
syn match makeSpecial			"^\s*[@-][@-]*"

" macros (use of identifiers)
" the following was slightly simplied to not have to create two makeModifiers (one with ) and one with })
syn match  makeModCmd contained		":[-:]\=[EHIPRTU]\>"
syn match  makeModCmd contained		":[-:]\=[MNS]"
syn match  makeModCmd contained		":[-:]\=sh\>"
syn match  makeUserModCmd contained	":[-:]\=[A-DFGJ-LOQV-Za-z0-9]\>"
syn match  makeModifiers contained	":[-:]\=[^:})]\+" contains=makeMacro,makeModCmd,makeUserModCmd
syn region makeMacro			start="\$(" end=")" contains=makeMacro,makeModifiers,makeStatement
syn region makeMacro			start="\${" end="}" contains=makeMacro,makeModifiers,makeStatement
syn match  makeMacro			"\$\$\=[^({]"


" Comments
syn match  makeComment			"XCOMM\s.*$"

" match escaped quotes, $ and any other escaped character
" The escaped char is not highlightet currently
syn match makeEscapedChar 	"\\."

syn region  makeDString			start=+"+  skip=+\\"+  end=+"+  contains=makeIdent,makeNextLine
syn region  makeSString			start=+'+  skip=+\\'+  end=+'+  contains=makeIdent,makeNextLine
syn region  makeBString			start=+`+  skip=+\\`+  end=+`+  contains=makeIdent,makeSString,makeDString,makeNextLine
syn match   makeIString contained	"<..*>"

if !exists("did_amakefile_syntax_inits")
  let did_amakefile_syntax_inits = 1
  hi link makeNextLine		makeSpecial
  hi link makeSpecTarget	Statement
  hi link makeImplicit		Function
  hi link makeTarget		Function
  hi link makeInclude		Include
  hi link makeCpp		PreProc
  hi link makeIn		makeCpp
  hi link makePreCondit		PreCondit
  hi link makeStatement		Statement
  hi link makeIdent		Identifier
  hi link makeSpecial		Special
  hi link makeComment		Comment
  hi link makeDString		String
  hi link makeSString		String
  hi link makeBString		Function
  hi link makeIString		String
  hi link makeMessage		String
  hi link makeExpr		Number
  hi link makeOperator		Operator
  hi link makeMacro		makeIdent
  hi link makeModCmd		Statement
  hi link makeUserModCmd	Character
  hi link makePattern		makeImplicit
endif

let b:current_syntax = "make"

" vim: ts=8
