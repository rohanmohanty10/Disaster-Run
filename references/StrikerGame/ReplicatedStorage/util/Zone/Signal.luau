 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[[
--------------------------------------------------------------------------------
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
-- Licence:                                                                   --
--   Licenced under the MIT licence.                                          --
--                                                                            --
-- Authors:                                                                   --
--   stravant - July 31st, 2021 - Created the file.                           --
--------------------------------------------------------------------------------

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

-- Connection class
local Connection = {}
Connection.__index = Connection

function Connection.new(signal, fn)
	return setmetatable({
		_connected = true,
		_signal = signal,
		_fn = fn,
		_next = false,
	}, Connection)
end

function Connection:Disconnect()
	assert(self._connected, "Can't disconnect a connection twice.", 2)
	self._connected = false

	-- Unhook the node, but DON'T clear it. That way any fire calls that are
	-- currently sitting on this node will be able to iterate forwards off of
	-- it, but any subsequent fire calls will not hit it, and it will be GCed
	-- when no more fire calls are sitting on it.
    local signal = self._signal
	if signal._handlerListHead == self then
		signal._handlerListHead = self._next
	else
		local prev = signal._handlerListHead
		while prev and prev._next ~= self do
			prev = prev._next
		end
		if prev then
			prev._next = self._next
		end
	end

    if signal.connectionsChanged then
		signal.totalConnections -= 1
        signal.connectionsChanged:Fire(-1)
    end
end

-- Make Connection strict
setmetatable(Connection, {
	__index = function(tb, key)
		error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end,
	__newindex = function(tb, key, value)
		error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
	end
})

-- Signal class
local Signal = {}
Signal.__index = Signal

function Signal.new(createConnectionsChangedSignal)
	local self = setmetatable({
		_handlerListHead = false,	
	}, Signal)
    if createConnectionsChangedSignal then
        self.totalConnections = 0
		self.connectionsChanged = Signal.new()
	end
    return self
end

function Signal:Connect(fn)
	local connection = Connection.new(self, fn)
	if self._handlerListHead then
		connection._next = self._handlerListHead
		self._handlerListHead = connection
	else
		self._handlerListHead = connection
	end

	if self.connectionsChanged then
        self.totalConnections += 1
		self.connectionsChanged:Fire(1)
	end
	return connection
end

-- Disconnect all handlers. Since we use a linked list it suffices to clear the
-- reference to the head handler.
function Signal:DisconnectAll()
	self._handlerListHead = false

    if self.connectionsChanged then
		self.connectionsChanged:Fire(-self.totalConnections)
		self.connectionsChanged:Destroy()
		self.connectionsChanged = nil
		self.totalConnections = 0
	end
end
Signal.Destroy = Signal.DisconnectAll
Signal.destroy = Signal.DisconnectAll

-- Signal:Fire(...) implemented by running the handler functions on the
-- coRunnerThread, and any time the resulting thread yielded without returning
-- to us, that means that it yielded to the Roblox scheduler and has been taken
-- over by Roblox scheduling, meaning we have to make a new coroutine runner.
function Signal:Fire(...)
	local item = self._handlerListHead
	while item do
		if item._connected then
			if not freeRunnerThread then
				freeRunnerThread = coroutine.create(runEventHandlerInFreeThread)
			end
			task.spawn(freeRunnerThread, item._fn, ...)
		end
		item = item._next
	end
end

-- Implement Signal:Wait() in terms of a temporary connection using
-- a Signal:Connect() which disconnects itself.
function Signal:Wait()
	local waitingCoroutine = coroutine.running()
	local cn;
	cn = self:Connect(function(...)
		cn:Disconnect()
		task.spawn(waitingCoroutine, ...)
	end)
	return coroutine.yield()
end


return Signal
]]

 

local u1 = nil;

local function acquireRunnerThreadAndCallEventHandler(p2, ...) -- Line: 34
    -- upvalues: u1 (ref)
    local v3 = u1;
    u1 = nil;
    p2(...);
    u1 = v3;
end;

local function runEventHandlerInFreeThread(...) -- Line: 45
    -- upvalues: acquireRunnerThreadAndCallEventHandler (copy)
    acquireRunnerThreadAndCallEventHandler(...);

    while true do
        acquireRunnerThreadAndCallEventHandler(coroutine.yield());
    end;
end;

local u4 = {};
u4.__index = u4;

function u4.new(p5, p6) -- Line: 56
    -- upvalues: u4 (copy)
    return setmetatable({
        _connected = true,
        _next = false,
        _signal = p5,
        _fn = p6
    }, u4);
end;

function u4.Disconnect(p7) -- Line: 65
    assert(p7._connected, "Can\'t disconnect a connection twice.", 2);
    p7._connected = false;
    local _signal = p7._signal;

    if _signal._handlerListHead == p7 then
        _signal._handlerListHead = p7._next;
    else
        local _handlerListHead = _signal._handlerListHead;

        while _handlerListHead and _handlerListHead._next ~= p7 do
            _handlerListHead = _handlerListHead._next;
        end;

        if _handlerListHead then
            _handlerListHead._next = p7._next;
        end;
    end;

    if _signal.connectionsChanged then
        _signal.totalConnections = _signal.totalConnections - 1;
        _signal.connectionsChanged:Fire(-1);
    end;
end;

setmetatable(u4, {
    __index = function(p8, p9) -- Line: 94, Name: __index
        error(("Attempt to get Connection::%s (not a valid member)"):format((tostring(p9))), 2);
    end,

    __newindex = function(p10, p11, p12) -- Line: 97, Name: __newindex
        error(("Attempt to set Connection::%s (not a valid member)"):format((tostring(p11))), 2);
    end
});
local u13 = {};
u13.__index = u13;

function u13.new(p14) -- Line: 106
    -- upvalues: u13 (copy)
    local v15 = setmetatable({
        _handlerListHead = false
    }, u13);

    if p14 then
        v15.totalConnections = 0;
        v15.connectionsChanged = u13.new();
    end;

    return v15;
end;

function u13.Connect(p16, p17) -- Line: 117
    -- upvalues: u4 (copy)
    local v18 = u4.new(p16, p17);

    if p16._handlerListHead then
        v18._next = p16._handlerListHead;
        p16._handlerListHead = v18;
    else
        p16._handlerListHead = v18;
    end;

    if p16.connectionsChanged then
        p16.totalConnections = p16.totalConnections + 1;
        p16.connectionsChanged:Fire(1);
    end;

    return v18;
end;

function u13.DisconnectAll(p19) -- Line: 135
    p19._handlerListHead = false;

    if p19.connectionsChanged then
        p19.connectionsChanged:Fire(-p19.totalConnections);
        p19.connectionsChanged:Destroy();
        p19.connectionsChanged = nil;
        p19.totalConnections = 0;
    end;
end;

u13.Destroy = u13.DisconnectAll;
u13.destroy = u13.DisconnectAll;

function u13.Fire(p20, ...) -- Line: 152
    -- upvalues: u1 (ref), runEventHandlerInFreeThread (copy)
    local _handlerListHead = p20._handlerListHead;

    while _handlerListHead do
        if _handlerListHead._connected then
            if not u1 then
                u1 = coroutine.create(runEventHandlerInFreeThread);
            end;

            task.spawn(u1, _handlerListHead._fn, ...);
        end;

        _handlerListHead = _handlerListHead._next;
    end;
end;

function u13.Wait(p21) -- Line: 167
    local coroutine_running_ret = coroutine.running();
    local u22 = nil;
    u22 = p21:Connect(function(...) -- Line: 170
        -- upvalues: u22 (ref), coroutine_running_ret (copy)
        u22:Disconnect();
        task.spawn(coroutine_running_ret, ...);
    end);

    return coroutine.yield();
end;

return u13;