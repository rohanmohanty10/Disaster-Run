 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Timer
-- Stephen Leitnick
-- July 28, 2021

--[=[
	@within Timer
	@type CallbackFn () -> ()
	Callback function.
]=]
type CallbackFn = () -> nil

--[=[
	@within Timer
	@type TimeFn () -> number
	Time function.
]=]
type TimeFn = () -> number

local Signal = require(script.Parent.Signal)

local RunService = game:GetService("RunService")

--[=[
	@class Timer

	The Timer class allows for code to run periodically at specified intervals.

	```lua
	local timer = Timer.new(2)
	timer.Tick:Connect(function()
		print("Tock")
	end)
	timer:Start()
	```
]=]
local Timer = {}
Timer.__index = Timer

--[=[
	@within Timer
	@prop Interval number
	Interval at which the `Tick` event fires.
]=]
--[=[
	@within Timer
	@prop UpdateSignal RBXScriptSignal | Signal
	The signal which updates the timer internally.
]=]
--[=[
	@within Timer
	@prop TimeFunction TimeFn
	The function which gets the current time.
]=]
--[=[
	@within Timer
	@prop AllowDrift boolean
	Flag which indicates if the timer is allowed to drift. This
	is set to `true` by default. This flag must be set before
	calling `Start` or `StartNow`. This flag should only be set
	to `false` if it is necessary for drift to be eliminated.
]=]
--[=[
	@within Timer
	@prop Tick RBXScriptSignal | Signal
	The event which is fired every time the timer hits its interval.
]=]

--[=[
	@return Timer
	
	Creates a new timer.
]=]
function Timer.new(interval: number)
	assert(type(interval) == "number", "Argument #1 to Timer.new must be a number; got " .. type(interval))
	assert(interval >= 0, "Argument #1 to Timer.new must be greater or equal to 0; got " .. tostring(interval))
	local self = setmetatable({}, Timer)
	self._runHandle = nil
	self.Interval = interval
	self.UpdateSignal = RunService.Heartbeat
	self.TimeFunction = time
	self.AllowDrift = true
	self.Tick = Signal.new()
	return self
end

--[=[
	@return RBXScriptConnection

	Creates a simplified timer which just fires off a callback function at the given interval.

	```lua
	-- Basic:
	Timer.Simple(1, function()
		print("Tick")
	end)

	-- Using other arguments:
	Timer.Simple(1, function()
		print("Tick")
	end, true, RunService.Heartbeat, os.clock)
	```
]=]
function Timer.Simple(
	interval: number,
	callback: CallbackFn,
	startNow: boolean?,
	updateSignal: RBXScriptSignal?,
	timeFn: TimeFn?
)
	local update = updateSignal or RunService.Heartbeat
	local t = timeFn or time
	local nextTick = t() + interval
	if startNow then
		task.defer(callback)
	end
	return update:Connect(function()
		local now = t()
		if now >= nextTick then
			nextTick = now + interval
			task.defer(callback)
		end
	end)
end

--[=[
	Returns `true` if the given object is a Timer.
]=]
function Timer.Is(obj: any): boolean
	return type(obj) == "table" and getmetatable(obj) == Timer
end

function Timer:_startTimer()
	local t = self.TimeFunction
	local nextTick = t() + self.Interval
	self._runHandle = self.UpdateSignal:Connect(function()
		local now = t()
		if now >= nextTick then
			nextTick = now + self.Interval
			self.Tick:Fire()
		end
	end)
end

function Timer:_startTimerNoDrift()
	assert(self.Interval > 0, "Interval must be greater than 0 when AllowDrift is set to false")
	local t = self.TimeFunction
	local n = 1
	local start = t()
	local nextTick = start + self.Interval
	self._runHandle = self.UpdateSignal:Connect(function()
		local now = t()
		while now >= nextTick do
			n += 1
			nextTick = start + (self.Interval * n)
			self.Tick:Fire()
		end
	end)
end

--[=[
	Starts the timer. Will do nothing if the timer is already running.

	```lua
	timer:Start()
	```
]=]
function Timer:Start()
	if self._runHandle then
		return
	end
	if self.AllowDrift then
		self:_startTimer()
	else
		self:_startTimerNoDrift()
	end
end

--[=[
	Starts the timer and fires off the Tick event immediately. Will do
	nothing if the timer is already running.

	```lua
	timer:StartNow()
	```
]=]
function Timer:StartNow()
	if self._runHandle then
		return
	end
	self.Tick:Fire()
	self:Start()
end

--[=[
	Stops the timer. Will do nothing if the timer is already stopped.

	```lua
	timer:Stop()
	```
]=]
function Timer:Stop()
	if not self._runHandle then
		return
	end
	self._runHandle:Disconnect()
	self._runHandle = nil
end

--[=[
	Returns `true` if the timer is currently running.

	```lua
	if timer:IsRunning() then
		-- Do something
	end
	```
]=]
function Timer:IsRunning(): boolean
	return self._runHandle ~= nil
end

--[=[
	Destroys the timer. This will also stop the timer.
]=]
function Timer:Destroy()
	self.Tick:Destroy()
	self:Stop()
end

return Timer

]==]

 

local Signal = require(script.Parent.Signal);
local RunService = game:GetService("RunService");
local u1 = {};
u1.__index = u1;

function u1.new(p2: number) -- Line: 73
    -- upvalues: u1 (copy), RunService (copy), Signal (copy)
    local v3 = type(p2) == "number";
    local v4 = "Argument #1 to Timer.new must be a number; got " .. type(p2);
    assert(v3, v4);
    local v5 = "Argument #1 to Timer.new must be greater or equal to 0; got " .. tostring(p2);
    assert(p2 >= 0, v5);
    local v6 = setmetatable({}, u1);
    v6._runHandle = nil;
    v6.Interval = p2;
    v6.UpdateSignal = RunService.Heartbeat;
    v6.TimeFunction = time;
    v6.AllowDrift = true;
    v6.Tick = Signal.new();

    return v6;
end;

function u1.Simple(u7: number, u8: function, p9: boolean?, p10: userdata?, p11: function?) -- Line: 103
    -- upvalues: RunService (copy)
    local v12 = p10 or RunService.Heartbeat;
    local u13 = p11 or time;
    local u14 = u13() + u7;

    if p9 then
        task.defer(u8);
    end;

    return v12:Connect(function() -- Line: 116
        -- upvalues: u13 (copy), u14 (ref), u7 (copy), u8 (copy)
        local v15 = u13();

        if u14 <= v15 then
            u14 = v15 + u7;
            task.defer(u8);
        end;
    end);
end;

function u1.Is(p16) -- Line: 128
    -- upvalues: u1 (copy)
    local v17;

    if type(p16) == "table" then
        v17 = getmetatable(p16) == u1;
    else
        v17 = false;
    end;

    return v17;
end;

function u1._startTimer(u18) -- Line: 132
    local TimeFunction = u18.TimeFunction;
    local u19 = TimeFunction() + u18.Interval;
    u18._runHandle = u18.UpdateSignal:Connect(function() -- Line: 135
        -- upvalues: TimeFunction (copy), u19 (ref), u18 (copy)
        local v20 = TimeFunction();

        if u19 <= v20 then
            u19 = v20 + u18.Interval;
            u18.Tick:Fire();
        end;
    end);
end;

function u1._startTimerNoDrift(u21) -- Line: 144
    assert(u21.Interval > 0, "Interval must be greater than 0 when AllowDrift is set to false");
    local TimeFunction = u21.TimeFunction;
    local u22 = 1;
    local u23 = TimeFunction();
    local u24 = u23 + u21.Interval;
    u21._runHandle = u21.UpdateSignal:Connect(function() -- Line: 150
        -- upvalues: TimeFunction (copy), u24 (ref), u22 (ref), u23 (copy), u21 (copy)
        local v25 = TimeFunction();

        while u24 <= v25 do
            u22 = u22 + 1;
            u24 = u23 + u21.Interval * u22;
            u21.Tick:Fire();
        end;
    end);
end;

function u1.Start(p26) -- Line: 167
    if p26._runHandle then
        return;
    end;

    if p26.AllowDrift then
        p26:_startTimer();

        return;
    end;

    p26:_startTimerNoDrift();
end;

function u1.StartNow(p27) -- Line: 186
    if p27._runHandle then
        return;
    end;

    p27.Tick:Fire();
    p27:Start();
end;

function u1.Stop(p28) -- Line: 201
    if not p28._runHandle then
        return;
    end;

    p28._runHandle:Disconnect();
    p28._runHandle = nil;
end;

function u1.IsRunning(p29) -- Line: 218
    return p29._runHandle ~= nil;
end;

function u1.Destroy(p30) -- Line: 225
    p30.Tick:Destroy();
    p30:Stop();
end;

return u1;