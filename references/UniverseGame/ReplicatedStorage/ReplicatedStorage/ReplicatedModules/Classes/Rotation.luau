  

 

local KnitPackage = game.ReplicatedStorage.ReplicatedModules.KnitPackage;
local Trove = require(KnitPackage.Trove);
local Timer = require(KnitPackage.Timer);
local RunService = game:GetService("RunService");
local u1 = RunService:IsServer() and RunService.Heartbeat or RunService.RenderStepped;
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 11
    -- upvalues: Trove (copy), u2 (copy)
    local v4 = {
        Parts = {},
        Anchored = {},
        Angle = p3,
        Trove = Trove.new()
    };
    setmetatable(v4, u2);

    return v4;
end;

function u2.AddPart(p5, p6) -- Line: 22
    if type(p6) == "userdata" and p6:IsA("BasePart") then
        if not p6.Anchored then
            table.insert(p5.Anchored, p6);
            p6.Anchored = true;
        end;

        table.insert(p5.Parts, p6);
    end;
end;

function u2.ChangeRotation(p7, p8) -- Line: 29
    p7.Angle = p8;
end;

function u2.ChangeInterval(p9, p10) -- Line: 33
    if p9.Timer and (type(p10) == "number" and p10 >= 0) then
        p9.Trove:Remove(p9.Timer);
        p9:Start(p10);
    end;
end;

function u2.Start(u11, p12) -- Line: 40
    -- upvalues: Timer (copy), u1 (copy)
    local v13 = (type(p12) ~= "number" or p12 < 0) and 0 or p12;
    u11.Timer = u11.Trove:Add(Timer.Simple(v13, function() -- Line: 42
        -- upvalues: u11 (copy)
        if u11._Stopped then
            return;
        end;

        for _, v in ipairs(u11.Parts) do
            v.CFrame = v.CFrame * u11.Angle;
        end;
    end, true, u1, os.clock));
end;

function u2.Stop(p14) -- Line: 50
    p14._Stopped = true;
end;

function u2.Resume(p15) -- Line: 54
    p15._Stopped = false;
end;

function u2.Destroy(p16) -- Line: 58
    p16.Trove:Destroy();

    for _, v in ipairs(p16.Anchored) do
        v.Anchored = false;
    end;

    table.clear(p16.Anchored);
    table.clear(p16.Parts);
    table.clear(p16);
end;

return u2;