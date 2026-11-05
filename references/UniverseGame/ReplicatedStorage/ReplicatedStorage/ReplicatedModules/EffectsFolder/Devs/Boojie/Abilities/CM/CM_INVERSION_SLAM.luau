  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 14
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v5 = p4 or {};
    local v6 = RaycastParams.new();
    v6.FilterType = Enum.RaycastFilterType.Whitelist;
    v6.FilterDescendantsInstances = { game.Workspace.Map };
    local v7 = workspace:Raycast(p2, p3, v6);

    if not v7 then
        return;
    end;

    local u8 = AssetHandler.GetAsset("Particles/InversionSlam", v5):Clone();
    u8.CFrame = CFrame.lookAt(v7.Position, v7.Position - v7.Normal) * CFrame.Angles(0, 0, 1.5707963267948966);
    ParticleHandler.Unusualify(u8, {
        Character = v5.Character
    });
    u8.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u8,
        SkinName = v5.SkinName
    });
    task.delay(3, function() -- Line: 38
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;