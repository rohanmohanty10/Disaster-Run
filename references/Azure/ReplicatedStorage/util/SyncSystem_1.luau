 
 

local RunService = game:GetService("RunService");
local u1 = require("./NetworkSystem");
local u2 = {
    frameRate = 60,
    frameTime = 0.016666666666666666,
    currentFrame = 0,
    started = false,
    _frameClock = 0,
    _stepClock = 0,
    onUpdate = require("./Signal").new(),

    _serverTime = function() -- Line: 23, Name: _serverTime
        return workspace:GetServerTimeNow();
    end,

    _localTime = function() -- Line: 27, Name: _localTime
        return os.clock();
    end
};

function u2.now() -- Line: 31
    -- upvalues: u2 (copy)
    return u2._frameClock / 60 + u2._localTime() - u2._stepClock;
end;

function u2.getPing(p3: number) -- Line: 35
    -- upvalues: u2 (copy)
    return (u2.currentFrame - p3) * u2.frameTime;
end;

function u2._advance() -- Line: 39
    -- upvalues: u2 (copy)
    local v4 = u2._localTime();
    local v5 = v4 - u2._stepClock;
    u2._stepClock = v4;
    local v6 = u2._serverTime() * 60;
    local v7 = u2._frameClock + v5 * 60;
    local v8 = v6 - v7;

    if math.abs(v8) <= 30 then
        v6 = v7 + v8 * math.min(v5 * 4, 1);
    end;

    u2._frameClock = v6;
    local math_floor_ret = math.floor(u2._frameClock);
    local v9 = math_floor_ret - u2.currentFrame;

    if v9 > 0 then
        u2.currentFrame = math_floor_ret;
        u2.onUpdate:Fire(v9 * u2.frameTime, math_floor_ret);
    end;
end;

function u2._onPostSimulation() -- Line: 57
    -- upvalues: u2 (copy), u1 (copy)
    u2._advance();
    u1.flush();
end;

function u2.start() -- Line: 62
    -- upvalues: u2 (copy), RunService (copy)
    if u2.started then
        return;
    end;

    u2.started = true;
    u2._stepClock = u2._localTime();
    u2._frameClock = u2._serverTime() * 60;
    u2.currentFrame = math.floor(u2._frameClock);
    RunService.PostSimulation:Connect(u2._onPostSimulation);
end;

return u2;