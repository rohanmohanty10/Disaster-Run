 
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
-- API:                                                                       --
--   local Signal = require(THIS MODULE)                                      --
--   local sig = Signal.new()                                                 --
--   local connection = sig:Connect(function(arg1, arg2, ...) ... end)        --
--   sig:Fire(arg1, arg2, ...)                                                --
--   connection:Disconnect()                                                  --
--   sig:DisconnectAll()                                                      --
--   local arg1, arg2, ... = sig:Wait()                                       --
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

function Connection.new(signal, fn)
	return setmetatable({
		Connected = true,
		_signal = signal,
		_fn = fn,
		_next = false,
	}, Connection)
end

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
	local connection = Connection.new(self, fn)
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
		task.defer(item._fn, ...)
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
	local waitingCoroutine = coroutine.running()
	local connection
	local done = false
	connection = self:Connect(function(...)
		if done then
			return
		end
		done = true
		connection:Disconnect()
		task.spawn(waitingCoroutine, ...)
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

return {
	new = Signal.new,
	Wrap = Signal.Wrap,
	Is = Signal.Is,
}

]==]

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 53
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread(...) -- Line: 64
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    acquireRunnerThreadAndCallEventHandler(...);

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 90
    -- upvalues: u4 (copy)
    return setmetatable({
        Connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 99
    if not p7.Connected then
        return;
    end;

    p7.Connected = false;

    if p7._signal._handlerListHead == p7 then
        p7._signal._handlerListHead = p7._next;

        return;
    end;

    local _handlerListHead = p7._signal._handlerListHead;

    while _handlerListHead and _handlerListHead._next ~= p7 do
        _handlerListHead = _handlerListHead._next;
    end;

    if _handlerListHead then
        _handlerListHead._next = p7._next;
    end;
end;

u4.Destroy = u4.Disconnect;
setmetatable(u4, {
    __index = function(p8, p9) -- Line: 126, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end,

    __newindex = function(p10, p11, p12) -- Line: 129, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u13 = {};
u13.__index = u13;

function u13.new() -- Line: 165
    -- upvalues: u13 (copy)
    return setmetatable({
        _handlerListHead = false,
        _proxyHandler = nil
    }, u13);
end;

function u13.Wrap(p14: userdata) -- Line: 186
    -- upvalues: u13 (copy)
    local v15 = typeof(p14) == "RBXScriptSignal";
    local v16 = "Argument #1 to Signal.Wrap must be a RBXScriptSignal; got " .. typeof(p14);
    assert(v15, v16);
    local u17 = u13.new();
    u17._proxyHandler = p14:Connect(function(...) -- Line: 192
        -- upvalues: u17 (copy)
        u17:Fire(...);
    end);

    return u17;
end;

function u13.Is(p18) -- Line: 204
    -- upvalues: u13 (copy)
    local v19;

    if type(p18) == "table" then
        v19 = getmetatable(p18) == u13;
    else
        v19 = false;
    end;

    return v19;
end;

function u13.Connect(p20, p21) -- Line: 221
    -- upvalues: u4 (copy)
    local v22 = u4.new(p20, p21);

    if not p20._handlerListHead then
        p20._handlerListHead = v22;

        return v22;
    end;

    v22._next = p20._handlerListHead;
    p20._handlerListHead = v22;

    return v22;
end;

function u13.ConnectOnce(p23, p24) -- Line: 237
    return p23:Once(p24);
end;

function u13.Once(p25, u26) -- Line: 256
    local u27 = nil;
    local u28 = false;
    u27 = p25:Connect(function(...) -- Line: 259
        -- upvalues: u28 (ref), u27 (ref), u26 (copy)
        if u28 then
            return;
        end;

        u28 = true;
        u27:Disconnect();
        u26(...);
    end);

    return u27;
end;

function u13.GetConnections(p29) -- Line: 270
    local _handlerListHead = p29._handlerListHead;
    local v30 = {};

    while _handlerListHead do
        table.insert(v30, _handlerListHead);
        _handlerListHead = _handlerListHead._next;
    end;

    return v30;
end;

function u13.DisconnectAll(p31) -- Line: 288
    local _handlerListHead = p31._handlerListHead;

    while _handlerListHead do
        _handlerListHead.Connected = false;
        _handlerListHead = _handlerListHead._next;
    end;

    p31._handlerListHead = false;
end;

function u13.Fire(p32, ...) -- Line: 312
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p32._handlerListHead;

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

function u13.FireDeferred(p33, ...) -- Line: 333
    local _handlerListHead = p33._handlerListHead;

    while _handlerListHead do
        task.defer(_handlerListHead._fn, ...);
        _handlerListHead = _handlerListHead._next;
    end;
end;

function u13.Wait(p34) -- Line: 356
    local coroutine_running_ret = coroutine.running();
    local u35 = nil;
    local u36 = false;
    u35 = p34:Connect(function(...) -- Line: 360
        -- upvalues: u36 (ref), u35 (ref), coroutine_running_ret (copy)
        if u36 then
            return;
        end;

        u36 = true;
        u35:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

function u13.Destroy(p37) -- Line: 383
    p37:DisconnectAll();
    local v38 = rawget(p37, "_proxyHandler");

    if v38 then
        v38:Disconnect();
    end;
end;

setmetatable(u13, {
    __index = function(p39, p40) -- Line: 393, Name: __index
        error(("Attempt to get Signal::%s (not a valid member)"):format((tostring(p40))), 2);
    end,

    __newindex = function(p41, p42, p43) -- Line: 396, Name: __newindex
        error(("Attempt to set Signal::%s (not a valid member)"):format((tostring(p42))), 2);
    end
});

return {
    new = u13.new,
    Wrap = u13.Wrap,
    Is = u13.Is
};