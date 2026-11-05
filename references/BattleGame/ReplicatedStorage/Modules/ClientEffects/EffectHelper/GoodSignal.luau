local freeThread
local function acquireRunnerThreadAndCallEventHandler(fn, ...)
	local acquiredThread = freeThread
	freeThread = nil
	fn(...)
	freeThread = acquiredThread
end

local function runEventHandlerInFreeThread()
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

-- Connection class
local Connection = {}
Connection.__index = Connection

local function newConnection(signal, fn)
	local self = {
		_connected = true;
		_signal = signal;
		_fn = fn;
		_next = false;
	}
	return setmetatable(self, Connection)
end

Connection.new = newConnection

function Connection:Disconnect()
	self._connected = false
	-- Fix: was checking uninitialised var4 == self, so head check was never reached
	if self._signal._handlerListHead == self then
		self._signal._handlerListHead = self._next
	else
		local prev = self._signal._handlerListHead
		while prev and prev._next ~= self do
			prev = prev._next
		end
		if prev then
			prev._next = self._next
		end
	end
end

Connection.Destroy = Connection.Disconnect

setmetatable(Connection, {
	__index = function(_, key)
		error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end;
	__newindex = function(_, key, _v)
		error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end;
})

-- Signal class
local Signal = {}
Signal.__index = Signal

function Signal.new()
	return setmetatable({
		_handlerListHead = false;
	}, Signal)
end

function Signal:Connect(fn)
	local connection = newConnection(self, fn)
	if self._handlerListHead then
		connection._next = self._handlerListHead
	end
	self._handlerListHead = connection
	return connection
end

function Signal:DisconnectAll()
	self._handlerListHead = false
end

Signal.Destroy = Signal.DisconnectAll

function Signal:Fire(...)
	local handler = self._handlerListHead
	while handler do
		if handler._connected then
			if not freeThread then
				freeThread = coroutine.create(runEventHandlerInFreeThread)
				coroutine.resume(freeThread)
			end
			task.spawn(freeThread, handler._fn, ...)
		end
		-- Fix: was missing this line, causing an infinite loop
		handler = handler._next
	end
end

function Signal:Wait()
	local connection
	local currentThread = coroutine.running()
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(currentThread, ...)
	end)
	return coroutine.yield()
end

function Signal:Once(fn)
	local connection
	connection = self:Connect(function(...)
		if connection._connected then
			connection:Disconnect()
		end
		fn(...)
	end)
	return connection
end

setmetatable(Signal, {
	__index = function(_, key)
		error(("Attempt to get Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end;
	__newindex = function(_, key, _v)
		error(("Attempt to set Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end;
})

return Signal