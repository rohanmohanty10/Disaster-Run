  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = game.Players.LocalPlayer:FindFirstChildWhichIsA("PlayerGui");

local function Wait(p2) -- Line: 7
    -- upvalues: RunService (copy)
    local v3 = 0;

    repeat
        v3 = v3 + RunService.Heartbeat:Wait();
    until (p2 or 0) <= v3;

    return v3;
end;

local function Delay(u4, u5, ...) -- Line: 18
    -- upvalues: RunService (copy)
    local u6 = ... and (typeof(...) == "table" and ... or ({ ... } or {})) or {};

    return task.spawn(function() -- Line: 20
        -- upvalues: u4 (copy), RunService (ref), u5 (copy), u6 (copy)
        local v7 = 0;

        repeat
            v7 = v7 + RunService.Heartbeat:Wait();
        until (u4 or 0) <= v7;

        u5(unpack(u6));
    end);
end;

return function(p8) -- Line: 26
    -- upvalues: u1 (copy), TweenService (copy), Delay (copy), RunService (copy)
    local Extra = u1.Extra;
    local ScreenImages = Extra.ScreenImages;
    local HeavyBlood = ScreenImages.Blood.HeavyBlood;
    local u9;

    if Extra.Enabled then
        u9 = false;
    else
        Extra.Enabled = true;
        u9 = true;
    end;

    HeavyBlood.ImageTransparency = 1;
    ScreenImages.Enabled = true;
    HeavyBlood.Visible = true;
    TweenService:Create(HeavyBlood, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        ImageTransparency = 0
    }):Play();
    Delay(p8 or 2.5, function() -- Line: 48
        -- upvalues: u9 (ref), Extra (copy), TweenService (ref), HeavyBlood (copy), RunService (ref), ScreenImages (copy)
        if not u9 then
            Extra.Enabled = false;
        end;

        TweenService:Create(HeavyBlood, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        local v10 = 0;

        repeat
            v10 = v10 + RunService.Heartbeat:Wait();
        until (1 or 0) <= v10;

        ScreenImages.Enabled = false;
        HeavyBlood.Visible = false;
        HeavyBlood.ImageTransparency = 0;
    end);
end;