  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
Random.new();

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local v3 = p2 or {};
    local Origin = v3.Origin;
    local v4 = v3.Scale or 1;

    if not (Origin and v4) then
        return;
    end;

    for _, child in AssetHandler.GetAsset("Models/SlamMeshes", {
        AbilityName = "Rokushiki"
    }):GetChildren() do
        local v5 = child:Clone();
        v5.Parent = workspace.Effects;
        v5:ScaleTo(v4);
        v5:PivotTo(Origin);
        local Start = v5.Start;
        local End = v5.End;
        local v6 = v5:GetAttribute("Duration");
        Start.Decal.Transparency = 0;
        local v7 = TweenInfo.new(v6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out);
        TweenService:Create(Start, v7, {
            CFrame = End.CFrame
        }):Play();
        TweenService:Create(Start.Mesh, v7, {
            Scale = End.Mesh.Scale
        }):Play();
        TweenService:Create(Start.Decal, v7, {
            Transparency = 1
        }):Play();
        task.delay(v6, v5.Destroy, v5);
    end;
end;