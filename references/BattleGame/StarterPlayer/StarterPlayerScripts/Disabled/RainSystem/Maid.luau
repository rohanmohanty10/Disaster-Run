--!strict
-- Maid.luau — minimal cleanup helper.
-- Hand it connections, instances, threads, tweens or plain functions; call
-- clean() once and everything is released. This is how every subsystem stays
-- leak-free when the rain stops or the script is destroyed.

local Maid = {}
Maid.__index = Maid

export type Cleanable =
	RBXScriptConnection
| Instance
| thread
| () -> ()
| { Destroy: (any) -> () }

export type Maid = typeof(setmetatable({} :: { _tasks: { Cleanable } }, Maid))

function Maid.new(): Maid
	return setmetatable({ _tasks = {} }, Maid)
end

-- Track something for later cleanup; returns it for convenient inlining.
function Maid.give<T>(self: Maid, item: T & Cleanable): T
	table.insert(self._tasks, item)
	return item
end

function Maid.clean(self: Maid)
	-- Swap the list out first so anything that re-enters during cleanup is safe.
	local tasks = self._tasks
	self._tasks = {}
	for _, item in tasks do
		local kind = typeof(item)
		if kind == "RBXScriptConnection" then
			(item :: RBXScriptConnection):Disconnect()
		elseif kind == "Instance" then
			(item :: Instance):Destroy()
		elseif kind == "function" then
			(item :: () -> ())()
		elseif kind == "thread" then
			pcall(task.cancel, item :: thread)
		elseif kind == "table" and (item :: any).Destroy then
			(item :: any):Destroy()
		end
	end
end

return Maid