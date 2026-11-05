  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.CollectionService;
local _ = PathShortcuts.ClientAssets;
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();

return function(p1) -- Line: 12
    -- upvalues: EffectsHandler (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    while p1.Parent and p1:GetAttribute("Slashing") do
        local spawn = task.spawn;
        local CallEffect = EffectsHandler.CallEffect;
        local v2 = {
            Time = 0.15,
            Size = Vector3.new(4.5, 20, 4.5),
            SurfaceDirection = "Bottom",
            Origin = HumanoidRootPart
        };
        local v3 = CFrame.new(0, 0, -1);
        local Angles = CFrame.Angles;
        local v4 = math.random(-25, 25);
        local v5 = math.rad(v4);
        local v6 = math.random(-25, 25);
        v2.Offset = v3 * Angles(v5, 1.5707963267948966, (math.rad(v6)));
        v2.EndCFrame = CFrame.Angles(0, -2.6179938779914944, 0);
        v2.Color = Color3.fromRGB(172, 172, 172);
        spawn(CallEffect, "Anubis_Slash", v2);
        task.wait(0.095);
    end;
end;