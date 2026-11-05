  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = RaycastParams.new();
u1.IgnoreWater = true;
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
u1.CollisionGroup = "Map";

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

return function(p4, p5) -- Line: 29
    -- upvalues: AssetHandler (copy), EffectsHandler (copy)
    if not (p5 and p5.Targets) then
        return;
    end;

    AssetHandler.GetAbilityData(p4);

    for _, v in p5.Targets do
        local v6 = v:FindFirstChild("Torso") or v:FindFirstChild("HumanoidRootPart");
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/NowWeFly/DownwardForce",
            AutoSerialize = true,
            Scale = 1.6,
            ScaleLifetime = 1,
            BypassRenderCap = true,
            Origin = CFrame.new(v6.Position) * CFrame.Angles(-1.5707963267948966, 0, 0),
            Character = p4
        });
    end;
end;