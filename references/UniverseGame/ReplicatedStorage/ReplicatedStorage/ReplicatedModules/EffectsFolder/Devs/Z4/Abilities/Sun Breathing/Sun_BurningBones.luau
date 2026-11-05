  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 8
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    if not p1 then
        return;
    end;

    local HumanoidRootPart = p1.HumanoidRootPart;
    local v3 = game.Players:GetPlayerFromCharacter(p1);
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local v4 = AssetHandler.CloneAsset("Particles/BurningBones", {
        AbilityName = "Sun Breathing",
        SkinName = p2
    });
    local v5 = 0;

    if v3 and v3.Data.Skin:GetAttribute("UnusualHueId") then
        v5 = v5 + v3.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v5 > 0 then
        ParticleHandler.HSVShiftParticles(v4, {
            HueShift = v5
        });
    end;

    v4.CFrame = HumanoidRootPart.CFrame;
    v4.Parent = Model;

    repeat
        Model:ScaleTo(Model:GetScale() + 0.0075);
        task.wait();
    until Model:GetScale() >= 1.75;

    ParticleHandler.EnableAllParticles(Model, false);
    ParticleHandler.DestroyEmit(Model);
end;