" Vim syntax file
" Language:	C++ & definitions for presentrack
" Maintainer:	Alexis Wilke <alexis@eden.com>
" Last change:	1999 Dec 11

" Remove any old syntax stuff hanging around
syn clear

" Read the C++ syntax to start with
source $VIMRUNTIME/syntax/cpp.vim
source $VIMRUNTIME/syntax/doxygen.vim

" Presentrack definitions

syn keyword cType		nullptr
syn keyword cConstant		NAN
syn match ptField		"\<f_[A-Za-z0-9_]\+\>"
syn match ptField		"\<m_[A-Za-z0-9_]\+\>"
syn match ptGlobal              "\<g_[A-Za-z0-9_]\+\>"
syn match cppType		"\<PT[A-Z][A-Za-z0-9_]\+\>"
syn match cppType               "[A-Za-z_][A-Za-z0-9_]\+_t\>"
syn match cppType               "[A-Za-z_][A-Za-z0-9][A-Za-z0-9_]\+_type\>"
syn match cppType               "\<[A-Za-z_][A-Za-z0-9_:]\+_t\>"
syn match cppType               "\<[A-Za-z_][A-Za-z0-9][A-Za-z0-9_:]\+_type\>"
syn keyword cppType             FILE
syn match cppCast		"\<std::\(const\|static\|dynamic\|reinterpret\)_pointer_cast\s*<"me=e-1
syn match cppCast		"\<std::\(const\|static\|dynamic\|reinterpret\)_pointer_cast\s*$"

let b:current_syntax = "presentrack"

if !exists("did_presentrack_syntax_inits")
  let did_presentrack_syntax_inits = 1
  hi ptField  guifg=#883333
  hi ptGlobal guifg=#333388
  hi ptACS    guifg=#8800FF
  hi ColorColumn guibg=#f0fff0
endif

set formatoptions=cro
set comments=s1:/*,mb:*,ex:*/,b://

" vim: ts=8
