  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: EffectsHandler (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local CFrame = TargetCharacter.HumanoidRootPart.CFrame;
    TargetCharacter.Archivable = true;
    local v6 = TargetCharacter:Clone();
    v6.Parent = workspace.Effects;
    v6:PivotTo(CFrame);
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    EffectsHandler.CallEffect("Dio Death", v6);
    task.delay(15, v6.Destroy, v6);
end;