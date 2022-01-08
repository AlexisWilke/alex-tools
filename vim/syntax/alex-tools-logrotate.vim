" Vim syntax file
" Language:	logrotate: logrotate main configuration file (1.5.5a)
" Maintainer: webmaster@askapache.com
" Last change:	2013 Jan 10
" URL:		--

" Remove any old syntax stuff hanging around
" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case ignore

syn keyword lrStatement	compress compresscmd compressext compressoptions copy copytruncate create daily dateext dateformat delaycompress olddir rotate count sharedscripts shred shredcycles size start count strftime tabooext uncompresscmd weekly yearly extension firstaction gunzip gzip ifempty include lastaction lr mail mailfirst maillast maxage minsize missingok monthly nextgroup=lrStatement,lrScript,lrNo,lrUser,lrDefault,lrComment skipwhite
syn keyword lrScript  postrotate prerotate endscript
syn keyword lrNo  nocompress nocopy nocopytruncate nocreate nodateext nodelaycompress nomail nomissingok noolddir nosharedscripts noshred notifempty


syn keyword lrTodo    contained TODO FIXME XXX NOTE
syn region  lrComment display oneline start='^\s*#' end='$' contains=lrTodo,@Spell


syn match   lrBegin   display '^' nextgroup=lrUser,lrDefault,lrComment skipwhite
syn match   lrUser    contained '[^ \t#*]\+' nextgroup=lrLimit,lrDeLimit skipwhite
syn match   lrDefault contained '*' nextgroup=lrLimit,lrDeLimit skipwhite
syn match   lrLimit   contained '[ACDFMNRSTUKLP]' nextgroup=lrNumber
syn match   lrDeLimit contained '-'
syn match   lrNumber  contained '\d\+\>' nextgroup=lrLimit skipwhite

"syn match  lrOptionF	/^\s*[^ \t#<=]*/ contains=lrStatement
syn region lrBlock start="{" end="}" fold transparent contains=lrStatement,lrScript,lrNo




if !exists("did_lr_syntax_inits")
    let did_lr_syntax_inits = 1

	hi def link lrStatement	Statement
    hi def link lrScript Operator
    hi def link lrNo     Function

	hi def link lrTodo    Todo
	hi def link lrComment Comment
	hi def link lrUser    Keyword
	hi def link lrDefault Macro
	hi def link lrLimit   Identifier
	hi def link lrDeLimit Special
	hi def link lrNumber  Number

endif


let b:current_syntax = "logrotate"
