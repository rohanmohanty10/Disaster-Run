  

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
TweenInfo.new(0.375, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
local u2 = Random.new();

return function(p3) -- Line: 13
    -- upvalues: Players (copy), EffectsHandler (copy), u2 (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (copy)
    local v4 = p3 and p3.Target and p3.Target:FindFirstChild("HumanoidRootPart");

    if not v4 then
        return;
    end;

    local v5 = p3.Attacker and Players:GetPlayerFromCharacter(p3.Attacker);

    if p3.Attacker then
        p3.Attacker:GetAttribute("ChromaUnusual");
    end;

    task.spawn(EffectsHandler.CallEffect, "HitEffect V3", p3);
    local v6 = u2:NextNumber(-0.85, 2.5);
    local u7 = AssetHandler.CloneAsset("Models/HitSphere", {
        AbilityName = "Gold Experience Requiem"
    });
    local v8 = 0;
    local v9 = v5 and (v5:FindFirstChild("Data") and v5.Data:FindFirstChild("Skin")) and v5.Data.Skin:GetAttribute("UnusualHueId");

    if v9 then
        v8 = v8 + v9 * 5;
    end;

    u7.Color = v8 > 0 and ParticleHandler.HSVShift(p3.Color or u7.Color, {
        HueShift = v8
    }) or (p3.Color or u7.Color);
    u7.Material = p3.Material or u7.Material;
    u7.Parent = workspace.Effects;
    u7.Size = u7.Size * v6;
    local CFrame2 = v4.CFrame;
    local Angles = CFrame.Angles;
    local v10 = u2:NextNumber(-90, 90);
    local v11 = math.rad(v10);
    local v12 = u2:NextNumber(-90, 90);
    local v13 = math.rad(v12);
    local v14 = u2:NextNumber(-90, 90);
    u7.CFrame = CFrame2 * Angles(v11, v13, (math.rad(v14)));
    u7.Anchored = false;
    u7.WeldConstraint.Part1 = v4;
    local v15 = u2:NextNumber(7.5, 14);
    local v16 = Vector3.new(v15, u7.Size.Y, u7.Size.Z);
    local v17 = u2:NextNumber(0.8, 1.8);
    local u18 = TweenService:Create(u7, u1, {
        Transparency = 0.325,
        Size = v16
    });
    local u19 = TweenService:Create(u7, u1, {
        Transparency = 1,
        Size = Vector3.new(v16.X + 2, v16.Y / v17, v16.Z / v17)
    });
    u18:Play();
    u18.Completed:Once(function() -- Line: 56
        -- upvalues: u18 (copy), u19 (copy), u7 (copy)
        u18:Destroy();
        u19:Play();
        u19.Completed:Once(function() -- Line: 59
            -- upvalues: u19 (ref), u7 (ref)
            u19:Destroy();
            u7:Destroy();
        end);
    end);
end;