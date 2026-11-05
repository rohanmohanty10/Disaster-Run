  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 7
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    if p2 == nil then
        return;
    end;

    local v3 = {
        AbilityName = "Gryphon",
        SkinName = AssetHandler.GetAbilityData(p1).SkinName
    };
    local HumanoidRootPart = p2.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local v4 = AssetHandler.CloneAsset("Particles/EmpyreanClobber/Meshes", v3);
    v4.Parent = workspace.Effects;
    task.delay(0.65, v4.Destroy, v4);

    for _, child in ipairs(v4:GetChildren()) do
        child.CFrame = HumanoidRootPart.CFrame;
        local v5 = TweenInfo.new(0.25, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
        local v6 = {
            Transparency = 1
        };
        local Angles = CFrame.Angles;
        local v7 = math.random(120, 180);
        v6.CFrame = CFrame2 * Angles(0, math.rad(v7) * (math.random(1, 2) == 1 and -1 or 1), 0) * CFrame.new(0, child.Size.Y / 1.5, 0);
        v6.Size = child.Size * 1.65;
        TweenService:Create(child, v5, v6):Play();
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/EmpyreanClobber/Thrust",
        AutoSerialize = true,
        Origin = CFrame2 * CFrame.new(0, 5, 0) * CFrame.Angles(0, 0, -1.5707963267948966),
        AbilityName = v3.AbilityName,
        SkinName = v3.SkinName
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 1.5,
        Size = Vector3.new(2.1, 2.1, 2.1),
        Radius = 9,
        Amount = 15,
        Origin = CFrame2
    });
    local CallEffect = EffectsHandler.CallEffect;
    local v8 = {
        Size = Vector3.new(9, 9, 9),
        Amount = 6
    };
    local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local v9 = math.random(0, 360);
    v8.Origin = CFrame2 * fromEulerAnglesXYZ(0, math.rad(v9), 0);
    CallEffect("Anubis_Laceration", v8);
end;