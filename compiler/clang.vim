if exists("clang")
	finish
endif
let current_compiler = "clang"

let s:cpo_save = &cpo
set cpo-=C

setlocal errorformat=%f:%l:%c:\ %t%s:\ %m\ %E

let &cpo = s:cpo_save
unlet s:cpo_save
