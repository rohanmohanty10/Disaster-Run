  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local TweenService = game:GetService("TweenService");
local Angles = CFrame.Angles;
local rad = math.rad;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function tweendeb(p2, p3) -- Line: 8
    p2:Play();
    p2.Completed:Wait();

    if p3 then
        p3:Destroy();
    end;

    return true;
end;

local function Lerp(p4, p5, p6) -- Line: 15
    return (p5 - p4) * p6 + p4;
end;

return function(p7, p8, p9) -- Line: 19
    -- upvalues: u1 (copy), Angles (copy), ParticleHandler (copy), rad (copy), TweenService (copy)
    local wait = task.wait;
    local Dawn = u1.Dawn;
    local v10 = typeof(p8) == "CFrame" and p8 and p8 or p8.CFrame;
    local u11 = Dawn.Shock:Clone();
    u11.Color = Color3.new(0, 1, 1);
    u11.Transparency = 0;
    u11.CFrame = v10 * CFrame.new(0, u11.Size.Y / 2, 0);
    local u12 = Dawn.Wind1:Clone();
    local u13 = Dawn.Wind2:Clone();
    u12.CFrame = v10;
    u13.CFrame = v10 * Angles(0, -1.4835298641951802, 0);
    u12.Transparency = 0;
    u13.Transparency = 0;
    local v14 = ParticleHandler.GetSkinInfo(p9);
    local v15 = type(v14) == "table" and ((v14.Slam or {}).HSVShift or (v14.Metadata or {}).HSVShift);

    if v15 then
        u11.Color = ParticleHandler.HSVShift(u11.Color, v15);
        u12.Color = ParticleHandler.HSVShift(u12.Color, v15);
        u13.Color = ParticleHandler.HSVShift(u13.Color, v15);
    end;

    u11.Parent = workspace.Effects;
    u12.Parent = workspace.Effects;
    u13.Parent = workspace.Effects;
    task.spawn(function() -- Line: 50
        -- upvalues: u11 (copy), Angles (ref), rad (ref), u12 (copy), u13 (copy), wait (copy)
        local v16 = 5;
        local v17 = 0;

        while u11.Parent do
            local v18 = Angles(0, rad(v16), 0);
            local v19 = u11;
            v19.CFrame = v19.CFrame * v18;
            local v20 = u12;
            v20.CFrame = v20.CFrame * v18;
            local v21 = u13;
            v21.CFrame = v21.CFrame * v18;
            v17 = v17 + wait() * 2;
            v16 = -5 * v17 + 5;
        end;
    end);
    local v22 = TweenInfo.new(0.5, Enum.EasingStyle.Sine);
    TweenService:Create(u12, v22, {
        Transparency = 1,
        Size = u12.Size * 1.5
    }):Play();
    TweenService:Create(u13, v22, {
        Transparency = 1,
        Size = u13.Size * 1.5
    }):Play();
    local v23 = TweenService:Create(u11, v22, {
        Transparency = 1,
        Size = u11.Size * 3
    });
    v23:Play();
    v23.Completed:Wait();

    if u11 then
        u11:Destroy();
    end;

    u12:Destroy();
    u13:Destroy();
end;