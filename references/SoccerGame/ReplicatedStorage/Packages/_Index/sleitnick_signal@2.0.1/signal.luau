 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- -----------------------------------------------------------------------------
--               Batched Yield-Safe Signal Implementation                     --
-- This is a Signal class which has effectively identical behavior to a       --
-- normal RBXScriptSignal, with the only difference being a couple extra      --
-- stack frames at the bottom of the stack trace when an error is thrown.     --
-- This implementation caches runner coroutines, so the ability to yield in   --
-- the signal handlers comes at minimal extra cost over a naive signal        --
-- implementation that either always or never spawns a thread.                --
--                                                                            --
-- License:                                                                   --
--   Licensed under the MIT license.                                          --
--                                                                            --
-- Authors:                                                                   --
--   stravant - July 31st, 2021 - Created the file.                           --
--   sleitnick - August 3rd, 2021 - Modified for Knit.                        --
-- -----------------------------------------------------------------------------

-- Signal types
export type Connection = {
	Disconnect: (self: Connection) -> (),
	Destroy: (self: Connection) -> (),
	Connected: boolean,
}

export type Signal<T...> = {
	Fire: (self: Signal<T...>, T...) -> (),
	FireDeferred: (self: Signal<T...>, T...) -> (),
	Connect: (self: Signal<T...>, fn: (T...) -> ()) -> Connection,
	Once: (self: Signal<T...>, fn: (T...) -> ()) -> Connection,
	DisconnectAll: (self: Signal<T...>) -> (),
	GetConnections: (self: Signal<T...>) -> { Connection },
	Destroy: (self: Signal<T...>) -> (),
	Wait: (self: Signal<T...>) -> T...,
}

-- The currently idle thread to run the next handler on
local freeRunnerThread = nil

-- Function which acquires the currently idle handler runner thread, runs the
-- function fn on it, and then releases the thread, returning it to being the
-- currently idle one.
-- If there was a currently idle runner thread already, that's okay, that old
-- one will just get thrown and eventually GCed.
local function acquireRunnerThreadAndCallEventHandler(fn, ...)
	local acquiredRunnerThread = freeRunnerThread
	freeRunnerThread = nil
	fn(...)
	-- The handler finished running, this runner thread is free again.
	freeRunnerThread = acquiredRunnerThread
end

-- Coroutine runner that we create coroutines of. The coroutine can be
-- repeatedly resumed with functions to run followed by the argument to run
-- them with.
local function runEventHandlerInFreeThread(...)
	acquireRunnerThreadAndCallEventHandler(...)
	while true do
		acquireRunnerThreadAndCallEventHandler(coroutine.yield())
	end
end

--[=[
	@within Signal
	@interface SignalConnection
	.Connected boolean
	.Disconnect (SignalConnection) -> ()

	Represents a connection to a signal.
	```lua
	local connection = signal:Connect(function() end)
	print(connection.Connected) --> true
	connection:Disconnect()
	print(connection.Connected) --> false
	```
]=]

-- Connection class
local Connection = {}
Connection.__index = Connection

function Connection:Disconnect()
	if not self.Connected then
		return
	end
	self.Connected = false

	-- Unhook the node, but DON'T clear it. That way any fire calls that are
	-- currently sitting on this node will be able to iterate forwards off of
	-- it, but any subsequent fire calls will not hit it, and it will be GCed
	-- when no more fire calls are sitting on it.
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

-- Make Connection strict
setmetatable(Connection, {
	__index = function(_tb, key)
		error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end,
	__newindex = function(_tb, key, _value)
		error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end,
})

--[=[
	@within Signal
	@type ConnectionFn (...any) -> ()

	A function connected to a signal.
]=]

--[=[
	@class Signal

	Signals allow events to be dispatched and handled.

	For example:
	```lua
	local signal = Signal.new()

	signal:Connect(function(msg)
		print("Got message:", msg)
	end)

	signal:Fire("Hello world!")
	```
]=]
local Signal = {}
Signal.__index = Signal

--[=[
	Constructs a new Signal

	@return Signal
]=]
function Signal.new<T...>(): Signal<T...>
	local self = setmetatable({
		_handlerListHead = false,
		_proxyHandler = nil,
		_yieldedThreads = nil,
	}, Signal)

	return self
end

--[=[
	Constructs a new Signal that wraps around an RBXScriptSignal.

	@param rbxScriptSignal RBXScriptSignal -- Existing RBXScriptSignal to wrap
	@return Signal

	For example:
	```lua
	local signal = Signal.Wrap(workspace.ChildAdded)
	signal:Connect(function(part) print(part.Name .. " added") end)
	Instance.new("Part").Parent = workspace
	```
]=]
function Signal.Wrap<T...>(rbxScriptSignal: RBXScriptSignal): Signal<T...>
	assert(
		typeof(rbxScriptSignal) == "RBXScriptSignal",
		"Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(rbxScriptSignal)
	)

	local signal = Signal.new()
	signal._proxyHandler = rbxScriptSignal:Connect(function(...)
		signal:Fire(...)
	end)

	return signal
end

--[=[
	Checks if the given object is a Signal.

	@param obj any -- Object to check
	@return boolean -- `true` if the object is a Signal.
]=]
function Signal.Is(obj: any): boolean
	return type(obj) == "table" and getmetatable(obj) == Signal
end

--[=[
	@param fn ConnectionFn
	@return SignalConnection

	Connects a function to the signal, which will be called anytime the signal is fired.
	```lua
	signal:Connect(function(msg, num)
		print(msg, num)
	end)

	signal:Fire("Hello", 25)
	```
]=]
function Signal:Connect(fn)
	local connection = setmetatable({
		Connected = true,
		_signal = self,
		_fn = fn,
		_next = false,
	}, Connection)

	if self._handlerListHead then
		connection._next = self._handlerListHead
		self._handlerListHead = connection
	else
		self._handlerListHead = connection
	end

	return connection
end

--[=[
	@deprecated v1.3.0 -- Use `Signal:Once` instead.
	@param fn ConnectionFn
	@return SignalConnection
]=]
function Signal:ConnectOnce(fn)
	return self:Once(fn)
end

--[=[
	@param fn ConnectionFn
	@return SignalConnection

	Connects a function to the signal, which will be called the next time the signal fires. Once
	the connection is triggered, it will disconnect itself.
	```lua
	signal:Once(function(msg, num)
		print(msg, num)
	end)

	signal:Fire("Hello", 25)
	signal:Fire("This message will not go through", 10)
	```
]=]
function Signal:Once(fn)
	local connection
	local done = false

	connection = self:Connect(function(...)
		if done then
			return
		end

		done = true
		connection:Disconnect()
		fn(...)
	end)

	return connection
end

function Signal:GetConnections()
	local items = {}

	local item = self._handlerListHead
	while item do
		table.insert(items, item)
		item = item._next
	end

	return items
end

-- Disconnect all handlers. Since we use a linked list it suffices to clear the
-- reference to the head handler.
--[=[
	Disconnects all connections from the signal.
	```lua
	signal:DisconnectAll()
	```
]=]
function Signal:DisconnectAll()
	local item = self._handlerListHead
	while item do
		item.Connected = false
		item = item._next
	end
	self._handlerListHead = false

	local yieldedThreads = rawget(self, "_yieldedThreads")
	if yieldedThreads then
		for thread in yieldedThreads do
			if coroutine.status(thread) == "suspended" then
				warn(debug.traceback(thread, "signal disconnected; yielded thread cancelled", 2))
				task.cancel(thread)
			end
		end
		table.clear(self._yieldedThreads)
	end
end

-- Signal:Fire(...) implemented by running the handler functions on the
-- coRunnerThread, and any time the resulting thread yielded without returning
-- to us, that means that it yielded to the Roblox scheduler and has been taken
-- over by Roblox scheduling, meaning we have to make a new coroutine runner.
--[=[
	@param ... any

	Fire the signal, which will call all of the connected functions with the given arguments.
	```lua
	signal:Fire("Hello")

	-- Any number of arguments can be fired:
	signal:Fire("Hello", 32, {Test = "Test"}, true)
	```
]=]
function Signal:Fire(...)
	local item = self._handlerListHead
	while item do
		if item.Connected then
			if not freeRunnerThread then
				freeRunnerThread = coroutine.create(runEventHandlerInFreeThread)
			end
			task.spawn(freeRunnerThread, item._fn, ...)
		end
		item = item._next
	end
end

--[=[
	@param ... any

	Same as `Fire`, but uses `task.defer` internally & doesn't take advantage of thread reuse.
	```lua
	signal:FireDeferred("Hello")
	```
]=]
function Signal:FireDeferred(...)
	local item = self._handlerListHead
	while item do
		local conn = item
		task.defer(function(...)
			if conn.Connected then
				conn._fn(...)
			end
		end, ...)
		item = item._next
	end
end

--[=[
	@return ... any
	@yields

	Yields the current thread until the signal is fired, and returns the arguments fired from the signal.
	Yielding the current thread is not always desirable. If the desire is to only capture the next event
	fired, using `Once` might be a better solution.
	```lua
	task.spawn(function()
		local msg, num = signal:Wait()
		print(msg, num) --> "Hello", 32
	end)
	signal:Fire("Hello", 32)
	```
]=]
function Signal:Wait()
	local yieldedThreads = rawget(self, "_yieldedThreads")
	if not yieldedThreads then
		yieldedThreads = {}
		rawset(self, "_yieldedThreads", yieldedThreads)
	end

	local thread = coroutine.running()
	yieldedThreads[thread] = true

	self:Once(function(...)
		yieldedThreads[thread] = nil
		task.spawn(thread, ...)
	end)

	return coroutine.yield()
end

--[=[
	Cleans up the signal.

	Technically, this is only necessary if the signal is created using
	`Signal.Wrap`. Connections should be properly GC'd once the signal
	is no longer referenced anywhere. However, it is still good practice
	to include ways to strictly clean up resources. Calling `Destroy`
	on a signal will also disconnect all connections immediately.
	```lua
	signal:Destroy()
	```
]=]
function Signal:Destroy()
	self:DisconnectAll()

	local proxyHandler = rawget(self, "_proxyHandler")
	if proxyHandler then
		proxyHandler:Disconnect()
	end
end

-- Make signal strict
setmetatable(Signal, {
	__index = function(_tb, key)
		error(("Attempt to get Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end,
	__newindex = function(_tb, key, _value)
		error(("Attempt to set Signal::%s (not a valid member)"):format(tostring(key)), 2)
	end,
})

return table.freeze({
	new = Signal.new,
	Wrap = Signal.Wrap,
	Is = Signal.Is,
})

]==]

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 44
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread(...) -- Line: 55
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    acquireRunnerThreadAndCallEventHandler(...);

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.Disconnect(p5) -- Line: 81
    if not p5.Connected then
        return;
    end;

    p5.Connected = false;

    if p5._signal._handlerListHead == p5 then
        p5._signal._handlerListHead = p5._next;

        return;
    end;

    local _handlerListHead = p5._signal._handlerListHead;

    while _handlerListHead and _handlerListHead._next ~= p5 do
        _handlerListHead = _handlerListHead._next;
    end;

    if _handlerListHead then
        _handlerListHead._next = p5._next;
    end;
end;

u4.Destroy = u4.Disconnect;
setmetatable(u4, {
    __index = function(p6, p7) -- Line: 108, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p7))), 2);
    end,

    __newindex = function(p8, p9, p10) -- Line: 111, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end
});
local u11 = {};
u11.__index = u11;

function u11.new() -- Line: 147
    -- upvalues: u11 (copy)
    return setmetatable({
        _handlerListHead = false,
        _proxyHandler = nil,
        _yieldedThreads = nil
    }, u11);
end;

function u11.Wrap(p12: userdata) -- Line: 170
    -- upvalues: u11 (copy)
    local v13 = typeof(p12) == "RBXScriptSignal";
    local v14 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p12);
    assert(v13, v14);
    local u15 = u11.new();
    u15._proxyHandler = p12:Connect(function(...) -- Line: 177
        -- upvalues: u15 (copy)
        u15:Fire(...);
    end);

    return u15;
end;

function u11.Is(p16) -- Line: 190
    -- upvalues: u11 (copy)
    local v17;

    if type(p16) == "table" then
        v17 = getmetatable(p16) == u11;
    else
        v17 = false;
    end;

    return v17;
end;

function u11.Connect(p18, p19) -- Line: 207
    -- upvalues: u4 (copy)
    local v20 = setmetatable({
        Connected = true,
        _next = false,
        _signal = p18,
        _fn = p19
    }, u4);

    if not p18._handlerListHead then
        p18._handlerListHead = v20;

        return v20;
    end;

    v20._next = p18._handlerListHead;
    p18._handlerListHead = v20;

    return v20;
end;

function u11.ConnectOnce(p21, p22) -- Line: 230
    return p21:Once(p22);
end;

function u11.Once(p23, u24) -- Line: 249
    local u25 = nil;
    local u26 = false;
    u25 = p23:Connect(function(...) -- Line: 253
        -- upvalues: u26 (ref), u25 (ref), u24 (copy)
        if u26 then
            return;
        end;

        u26 = true;
        u25:Disconnect();
        u24(...);
    end);

    return u25;
end;

function u11.GetConnections(p27) -- Line: 266
    local _handlerListHead = p27._handlerListHead;
    local v28 = {};

    while _handlerListHead do
        table.insert(v28, _handlerListHead);
        _handlerListHead = _handlerListHead._next;
    end;

    return v28;
end;

function u11.DisconnectAll(p29) -- Line: 286
    local _handlerListHead = p29._handlerListHead;

    while _handlerListHead do
        _handlerListHead.Connected = false;
        _handlerListHead = _handlerListHead._next;
    end;

    p29._handlerListHead = false;
    local v30 = rawget(p29, "_yieldedThreads");

    if v30 then
        for i in v30 do
            if coroutine.status(i) == "suspended" then
                warn(debug.traceback(i, "signal disconnected; yielded thread cancelled", 2));
                task.cancel(i);
            end;
        end;

        table.clear(p29._yieldedThreads);
    end;
end;

function u11.Fire(p31, ...) -- Line: 321
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p31._handlerListHead;

    while _handlerListHead do
        if _handlerListHead.Connected then
            if not u1 then
                u1 = coroutine.create(runEventHandlerInFreeThread);
            end;

            task.spawn(u1, _handlerListHead._fn, ...);
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

function u11.FireDeferred(p32, ...) -- Line: 342
    local _handlerListHead = p32._handlerListHead;

    while _handlerListHead do
        task.defer(function(...) -- Line: 346
            -- upvalues: _handlerListHead (copy)
            if _handlerListHead.Connected then
                _handlerListHead._fn(...);
            end;
        end, ...);
        _handlerListHead = _handlerListHead._next;
    end;
end;

function u11.Wait(p33) -- Line: 370
    local u34 = rawget(p33, "_yieldedThreads");

    if not u34 then
        u34 = {};
        rawset(p33, "_yieldedThreads", u34);
    end;

    local coroutine_running_ret = coroutine.running();
    u34[coroutine_running_ret] = true;
    p33:Once(function(...) -- Line: 380
        -- upvalues: u34 (ref), coroutine_running_ret (copy)
        u34[coroutine_running_ret] = nil;
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u11.Destroy(p35) -- Line: 400
    p35:DisconnectAll();
    local v36 = rawget(p35, "_proxyHandler");

    if v36 then
        v36:Disconnect();
    end;
end;

setmetatable(u11, {
    __index = function(p37, p38) -- Line: 411, Name: __index
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p38))), 2);
    end,

    __newindex = function(p39, p40, p41) -- Line: 414, Name: __newindex
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p40))), 2);
    end
});

return table.freeze({
    new = u11.new,
    Wrap = u11.Wrap,
    Is = u11.Is
});