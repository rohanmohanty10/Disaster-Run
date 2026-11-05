 
  
local function msg(...) --[[ msg | Line: 1 ]]
	return ("[Forge Emit API]: %*"):format((table.concat({ ... }, " ")))
end
return {
	error = function(...) --[[ error | Line: 7 | Upvalues: msg (copy) ]]
		error(msg(..., "\n"))
	end,
	warn = function(...) --[[ warn | Line: 11 | Upvalues: msg (copy) ]]
		warn(msg(...))
		warn(msg(debug.traceback("stack trace:")))
	end,
	info = function(...) --[[ info | Line: 16 | Upvalues: msg (copy) ]]
		print(msg(...))
	end
}