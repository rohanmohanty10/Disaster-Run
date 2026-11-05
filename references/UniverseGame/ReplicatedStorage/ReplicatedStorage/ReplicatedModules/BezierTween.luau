  

 

local u1 = {};
u1.__index = u1;
u1.Waypoints = require(script.Waypoints);
local Signal = require(script.Signal);
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");

local function factorial(p2) -- Line: 33
    -- upvalues: factorial (copy)
    return p2 == 0 and 1 or p2 * factorial(p2 - 1);
end;

local function binomial(p3, p4) -- Line: 38
    -- upvalues: factorial (copy)
    local v5 = p3 == 0 and 1 or p3 * factorial(p3 - 1);
    local v6 = p3 - p4;

    return v5 / ((v6 == 0 and 1 or v6 * factorial(v6 - 1)) * (p4 == 0 and 1 or p4 * factorial(p4 - 1)));
end;

local function graphPoint(p7, ...) -- Line: 47
    -- upvalues: factorial (copy)
    local v8;

    if p7 >= 0 then
        v8 = p7 <= 1;
    else
        v8 = false;
    end;

    assert(v8, p7 .. "t is not between 0 and 1.");
    local v9 = { ... };
    local v10 = #v9 - 1;
    local v11 = nil;

    for i = 0, v10 do
        local v12 = v10 == 0 and 1 or v10 * factorial(v10 - 1);
        local v13 = v10 - i;
        local v14 = v12 / ((v13 == 0 and 1 or v13 * factorial(v13 - 1)) * (i == 0 and 1 or i * factorial(i - 1))) * (1 - p7) ^ (v10 - i) * p7 ^ i * v9[i + 1];

        if v11 then
            v11 = v11 + v14 or v14;
        else
            v11 = v14;
        end;
    end;

    return v11;
end;

function u1.Create(p15, p16) -- Line: 61
    -- upvalues: u1 (copy), Signal (copy)
    local v17 = setmetatable({}, u1);
    assert(#p16.Waypoints > 1, "Bezier curve must have atleast 2 waypoints.");
    assert(p16.EasingStyle ~= Enum.EasingStyle.Elastic, "Elastic easing style not supported.");
    assert(p16.EasingStyle ~= Enum.EasingStyle.Back, "Back easing style not supported.");
    v17.Instance = p15;
    v17.PlaybackState = Enum.PlaybackState.Begin;
    v17.TweenInfo = p16;
    v17.Played = Signal.new();
    v17.Completed = Signal.new();
    v17.Cancelled = Signal.new();
    v17.Ended = Signal.new();
    v17.Paused = Signal.new();
    v17.Resumed = Signal.new();
    v17.Changed = Signal.new();
    v17._time = 0;
    v17._style = p16.EasingStyle or Enum.EasingStyle.Linear;
    v17._direction = p16.EasingDirection or Enum.EasingDirection.In;

    return v17;
end;

function u1.Play(u18) -- Line: 90
    -- upvalues: TweenService (copy), graphPoint (copy), RunService (copy)
    assert(u18.PlaybackState ~= Enum.PlaybackState.Playing, "Tween is already playing.");
    assert(u18.PlaybackState ~= Enum.PlaybackState.Cancelled, "Tween is cancelled.");
    u18.Played:Fire();
    u18.PlaybackState = Enum.PlaybackState.Playing;
    task.spawn(function() -- Line: 96
        -- upvalues: u18 (copy), TweenService (ref), graphPoint (ref), RunService (ref)
        local _ = u18.TweenInfo.Time;

        while u18._time < 1 do
            if u18.PlaybackState ~= Enum.PlaybackState.Playing then
                return;
            end;

            local v19 = graphPoint(TweenService:GetValue(u18._time, u18._style, u18._direction), unpack(u18.TweenInfo.Waypoints));
            local v20 = u18;
            v20._time = v20._time + 1 / (60 * u18.TweenInfo.Time);
            local v21 = graphPoint(TweenService:GetValue(u18._time, u18._style, u18._direction), unpack(u18.TweenInfo.Waypoints));
            u18.Instance.CFrame = CFrame.lookAt(v19, v21);
            u18.Changed:Fire({
                Tween = u18,
                CFrame = u18.Instance.CFrame,
                Position = u18.Instance.Position
            });
            RunService.Heartbeat:Wait();
        end;

        u18.PlaybackState = Enum.PlaybackState.Completed;
        u18.Changed:Fire({
            Completed = true,
            Tween = u18,
            CFrame = CFrame.new(u18.TweenInfo.Waypoints[#u18.TweenInfo.Waypoints]),
            Position = u18.TweenInfo.Waypoints[#u18.TweenInfo.Waypoints]
        });
        u18.Completed:Fire();
        u18.Ended:Fire();

        return "Completed";
    end);
end;

function u1.Pause(p22) -- Line: 132
    if p22.PlaybackState ~= Enum.PlaybackState.Paused then
        p22.PlaybackState = Enum.PlaybackState.Paused;
        p22.Paused:Fire();
    end;
end;

function u1.Resume(p23) -- Line: 139
    if p23.PlaybackState == Enum.PlaybackState.Paused then
        p23:Play();
        p23.Resumed:Fire();
    end;
end;

function u1.Cancel(p24) -- Line: 146
    if p24.PlaybackState ~= Enum.PlaybackState.Cancelled then
        p24.PlaybackState = Enum.PlaybackState.Cancelled;
        p24.Cancelled:Fire();
        p24.Ended:Fire();
        p24.Changed:Fire({
            Completed = true,
            Tween = p24,
            CFrame = p24.Instance.CFrame,
            Position = p24.Instance.Position
        });
    end;
end;

function u1.UpdatePoint(p25, p26, p27) -- Line: 161
    p25.TweenInfo.Waypoints[p26] = p27;
end;

function u1.UpdateEndpoint(p28, p29) -- Line: 164
    p28:UpdatePoint(#p28.TweenInfo.Waypoints, p29);
end;

function u1.UpdateWaypoints(p30, p31) -- Line: 167
    p30.TweenInfo.Waypoints = p31;
end;

return u1;