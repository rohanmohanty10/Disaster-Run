  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(Knit.Util.Signal);
local u1 = {};
u1.__index = u1;
local RunService = game:GetService("RunService");

function u1.new(p2, p3) -- Line: 10
    -- upvalues: u1 (copy), Signal (copy)
    local v4 = setmetatable({}, u1);
    v4.Duration = p2;
    v4.Clean = (p3 == nil or not p3) and true or p3;
    v4._Stopped = false;
    v4._Time = 0;
    v4.Ended = Signal.new();
    v4.Stopped = Signal.new();
    v4.Tick = Signal.new();

    return v4;
end;

function u1.Start(u5) -- Line: 22
    -- upvalues: RunService (copy)
    if u5._Stopped then
        u5._Stopped = false;

        return;
    end;

    u5.Connection = RunService.Heartbeat:Connect(function(p6) -- Line: 28
        -- upvalues: u5 (copy)
        if u5._Stopped then
            return;
        end;

        local v7 = u5;
        v7._Time = v7._Time + p6;
        u5.Tick:Fire(u5._Time);

        if u5._Time >= u5.Duration then
            u5:Cancel();
        end;
    end);
end;

function u1.GetTime(p8) -- Line: 42
    return p8._Time;
end;

function u1.IsRunning(p9) -- Line: 46
    return not p9._Stopped;
end;

function u1._Disconnect(p10) -- Line: 50
    if p10.Connection then
        p10.Connection:Disconnect();
        p10.Connection = nil;
    end;
end;

function u1.Cancel(p11) -- Line: 57
    p11:_Disconnect();
    p11._Stopped = true;
    p11.Ended:Fire(p11._Time);

    if p11.Clean then
        p11:Destroy();
    end;
end;

function u1.Restart(p12) -- Line: 67
    p12._Time = 0;
end;

function u1.Stop(p13) -- Line: 71
    p13._Stopped = true;
    p13.Stopped:Fire(p13._Time);
end;

function u1.Destroy(p14) -- Line: 76
    p14.Tick:Destroy();
    p14.Stopped:Destroy();
    p14.Ended:Destroy();
    table.clear(p14);
    setmetatable(p14, nil);
end;

return u1;