--!strict
-- A counter-based on/off state (from the SorceryGame reference's NumberStack).
-- Every Add() pushes one level, optionally popping itself after a duration; the state is
-- "on" while any level remains. So overlapping effects never cut each other short:
-- a 0.3s stun landing during a 3s stun leaves the player stunned for the full 3s.

local Signal = require(script.Parent.Signal)

local NumberStack = {}
NumberStack.__index = NumberStack

export type NumberStack = typeof(setmetatable(
	{} :: {
		Value: number,
		Threads: { [thread]: boolean },
		Changed: Signal.Signal, -- (isOn) when it turns on or off
	},
	NumberStack
))

function NumberStack.new(): NumberStack
	return setmetatable({
		Value = 0,
		Threads = {},
		Changed = Signal.new(),
	}, NumberStack)
end

function NumberStack.IsOn(self: NumberStack): boolean
	return self.Value > 0
end

-- Pushes one level. With a duration, that level pops itself when the time is up.
function NumberStack.Add(self: NumberStack, duration: number?)
	local wasOff = self.Value == 0
	self.Value += 1
	if wasOff then
		self.Changed:Fire(true)
	end
	if duration then
		local thread: thread
		thread = task.delay(duration, function()
			self.Threads[thread] = nil
			self:Remove()
		end)
		self.Threads[thread] = true
	end
end

-- Pops one level.
function NumberStack.Remove(self: NumberStack)
	if self.Value == 0 then
		return
	end
	self.Value -= 1
	if self.Value == 0 then
		self.Changed:Fire(false)
	end
end

-- Clears every level and pending timer.
function NumberStack.Reset(self: NumberStack)
	for thread in self.Threads do
		if coroutine.status(thread) == "suspended" then
			task.cancel(thread)
		end
	end
	table.clear(self.Threads)
	if self.Value > 0 then
		self.Value = 0
		self.Changed:Fire(false)
	end
end

return NumberStack
