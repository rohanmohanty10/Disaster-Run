  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("CollectionService");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);

return function(p2) -- Line: 16
    -- upvalues: AssetHandler (copy)
    local v3 = p2 or {};
    local v4 = v3.Animation or error("no animation");
    local u5 = AssetHandler.CloneAsset("Models/Hollogram", v3.AbilityData or {
        AbilityName = "Garou"
    });
    u5.Join.Part0 = v3.RootPart;
    u5.Parent = workspace.Effects;
    local v6 = u5.AnimationController.Animator:LoadAnimation(v4);
    v6.Stopped:Once(function() -- Line: 30
        -- upvalues: u5 (copy)
        if u5 then
            u5:Destroy();
        end;
    end);
    task.delay(v6.Length or 1, function() -- Line: 36
        -- upvalues: u5 (copy)
        if u5 then
            u5:Destroy();
        end;
    end);
    v6:Play();
    v6.TimePosition = os.clock() - (v3.Started or os.clock());
end;