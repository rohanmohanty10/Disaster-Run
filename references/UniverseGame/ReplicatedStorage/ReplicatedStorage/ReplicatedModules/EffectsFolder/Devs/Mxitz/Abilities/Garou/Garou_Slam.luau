  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 22
    -- upvalues: u2 (copy), AssetHandler (copy), ParticleHandler (copy), u1 (ref)
    local v4 = p3 or {};
    local v5 = v4.Origin or error("No Origin");
    local v6 = v4.AbilityData or {
        AbilityName = "Garou"
    };
    v6.AbilityName = "Garou";
    local v7 = workspace:Raycast(v5.Position, Vector3.new(0, -20, 0), u2);

    if v7 and v7.Position then
        v5 = CFrame.new(v7.Position + Vector3.new(0, 3, 0)) * v5.Rotation;
    end;

    local v8 = AssetHandler.CloneAsset("Particles/SlamMove/Slam/Emit", v6);
    v8.WorldCFrame = v5 * v8.CFrame;
    v8.Parent = workspace.Terrain;
    local v9 = ParticleHandler.GetUnusualHSVData({
        Character = v4.Character
    });

    if v9 ~= nil then
        ParticleHandler.Unusualify(v8, {
            HSVData = v9
        });
    end;

    ParticleHandler.Emit(v8, ParticleHandler.GenerateEmitInfo(v8));
    task.delay(ParticleHandler.GetMaxLifetime(v8), v8.Destroy, v8);

    for _, descendant in AssetHandler.GetAsset("Particles/SlamMove/Slam/Meshes", v6):GetDescendants() do
        if descendant.Name == "Start" then
            local v10 = descendant.Parent:Clone();
            v10.Start.CFrame = v5 * v10:GetAttribute("Spawn_Offset");
            v10.Parent = workspace.Effects;
            u1.CallEffect("Arc_MeshEmit", v10.Start, true);
            task.delay(v10:GetAttribute("Duration") or 1, v10.Destroy, v10);
        end;
    end;
end;