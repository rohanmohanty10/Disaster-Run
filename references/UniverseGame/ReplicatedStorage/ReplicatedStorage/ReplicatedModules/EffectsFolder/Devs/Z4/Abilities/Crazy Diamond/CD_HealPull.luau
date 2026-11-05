  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 7
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v3 = p2 or {
        AbilityName = "Crazy Diamond"
    };
    local v4;

    if p1:IsA("Player") then
        v4 = p1.Character or p1;
    else
        v4 = p1;
    end;

    local u5 = AssetHandler.CloneAsset("Particles/RecoilImpale/Pull", v3);
    u5.Parent = workspace.Effects;
    u5.CFrame = v4.HumanoidRootPart.CFrame * CFrame.new(0, -2, -1);
    local v6 = 0;

    if p1 and (p1:IsA("Player") and p1.Data.Skin:GetAttribute("UnusualHueId")) then
        v6 = v6 + p1.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v6 > 0 then
        ParticleHandler.HSVShiftParticles(u5, {
            HueShift = v6
        });
    end;

    ParticleHandler.EnableAllParticles(u5, true);
    local u7 = TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
    TweenService:Create(u5.Beams.BeamA, u7, {
        Width0 = 10,
        Width1 = 1
    }):Play();
    TweenService:Create(u5.Beams.BeamB, u7, {
        Width0 = 7,
        Width1 = 1
    }):Play();
    TweenService:Create(u5.BeamAt, TweenInfo.new(1.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        WorldCFrame = u5.Core.WorldCFrame
    }):Play();
    task.delay(0.8, function() -- Line: 47
        -- upvalues: TweenService (ref), u5 (copy), u7 (copy)
        TweenService:Create(u5.Beams.BeamA, u7, {
            Width0 = 0,
            Width1 = 0
        }):Play();
        TweenService:Create(u5.Beams.BeamB, u7, {
            Width0 = 0,
            Width1 = 0
        }):Play();
        task.wait(1);
        u5:Destroy();
    end);
end;