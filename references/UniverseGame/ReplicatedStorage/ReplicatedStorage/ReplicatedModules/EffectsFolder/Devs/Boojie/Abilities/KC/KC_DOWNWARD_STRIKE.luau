  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
Random.new();

return function(p2, p3, p4) -- Line: 12
    -- upvalues: AssetHandler (copy), u1 (copy)
    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Whitelist;
    v5.FilterDescendantsInstances = { game.Workspace.Map };
    local v6 = workspace:Raycast(p2, p3, v5);

    if not v6 then
        return;
    end;

    local u7 = AssetHandler.GetAsset("Particles/DownwardStrike", p4):Clone();
    u7.CFrame = CFrame.lookAt(v6.Position, v6.Position - v6.Normal) * CFrame.Angles(0, 0, 1.5707963267948966);
    u7.Parent = workspace.Effects;
    u1({
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u7,
        SkinName = p4.SkinName,
        Origin = CFrame.lookAt(v6.Position, v6.Position - v6.Normal) * CFrame.Angles(0, 0, 1.5707963267948966)
    });
    task.delay(3, function() -- Line: 59
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;