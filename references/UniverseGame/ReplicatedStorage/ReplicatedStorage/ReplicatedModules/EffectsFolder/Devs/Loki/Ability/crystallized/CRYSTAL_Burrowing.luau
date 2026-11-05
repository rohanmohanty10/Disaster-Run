  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
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

local Petal = _G.Petal;
local u4 = Petal("Util");
Petal("New");
local Rng = Petal("Extensions").Rng;

return function(p5, p6, p7, p8) -- Line: 38
    -- upvalues: AssetHandler (copy), Rng (copy), u4 (copy), ParticleHandler (copy)
    if not (p5 and (p6 and p7)) then
        return;
    end;

    local Unit = (p6 - p7).Unit;
    local v9 = math.ceil((p6 - p7).Magnitude) * (p8.SegmentsPerStud or 3);
    local v10 = p8.Duration * 0.8 / v9;
    local v11 = p8.MaxVariance or 3;
    local u12 = AssetHandler.CloneAsset("Particles/Burrowing Quake/BurrowTrail", AssetHandler.GetAbilityData(p5));
    u12.Anchored = true;
    u12.CanCollide = false;
    u12.Position = p6;
    u12.Parent = workspace.Effects;
    local v13 = 1;
    local v14 = 0;
    local v15 = 0;

    while v13 < v9 and (p5 and p5.Parent) do
        local v16 = task.wait();
        local v17;

        if v10 <= os.clock() - v14 then
            local v18 = math.floor(v15 / v10);
            v17 = math.min(v18, v9);
            local _ = v17 - v13;

            for i = v13 + 1, v17 do
                local v19 = p6:Lerp(p7, i / v9);
                local v20 = RaycastMap(v19, Vector3.new(0, 1, 0) * -(p8.MaxHeight or 25));

                if v20 then
                    local v21 = CFrame.lookAlong(v20.Position + v20.Normal, Unit) * CFrame.new((i == 1 or i == v9) and 0 or Rng(-v11, v11), 0, 0);
                    u4.Tween(u12, v10, "Linear", "InOut", {
                        Position = v21.Position
                    });
                end;
            end;

            v14 = os.clock();
        else
            v17 = v13;
        end;

        v15 = v15 + v16;
        v13 = v17;
    end;

    ParticleHandler.EnableAllParticles(u12, false);
    task.delay(3, function() -- Line: 87
        -- upvalues: u12 (ref)
        u12:Destroy();
        u12 = nil;
    end);
    print("Ended");
end;