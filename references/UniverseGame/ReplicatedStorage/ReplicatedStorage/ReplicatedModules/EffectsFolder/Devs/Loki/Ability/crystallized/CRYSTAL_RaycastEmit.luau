  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
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

return function(p4, p5) -- Line: 32
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy)
    if not p5 then
        return;
    end;

    if typeof(p4.Origin) == "Instance" then
        p4.Origin = ParticleHandler.TranslateToCFrame(p4.Origin);
    end;

    local v6 = RaycastMap;
    local v7;

    if typeof(p4.Origin) == "CFrame" then
        v7 = p4.Origin.Position;
    else
        v7 = p4.Origin;
    end;

    local v8 = v6(v7, p4.Direction);
    local Origin = p4.Origin;

    if v8 then
        local v9 = 0;

        if p5.Path then
            local GetAsset = AssetHandler.GetAsset;
            local Path = p5.Path;
            local v10;

            if p5.RawPath then
                v10 = nil;
            else
                v10 = AssetHandler.GetAbilityData(p5.Player or p5.Character);
            end;

            local v11 = GetAsset(Path, v10);

            if v11 then
                v9 = v11.Size.Y / 2;
            end;

            if p4.YOffset then
                v9 = v9 + p4.YOffset;
            end;
        end;

        p5.Origin = CFrame.new(v8.Position + Vector3.new(0, 1, 0) * (v9 + 0.05));

        if p4.KeepRotation then
            p5.Origin = p5.Origin * CFrame.fromOrientation(Origin:ToOrientation());
        end;

        EffectsHandler.CallEffect("Emit Particle V3", p5);
    end;
end;