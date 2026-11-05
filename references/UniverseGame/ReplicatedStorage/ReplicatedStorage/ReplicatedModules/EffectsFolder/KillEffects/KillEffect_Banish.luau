  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 7
    -- upvalues: EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local KillerPlayer = p1.KillerPlayer;
    local v2 = KillerPlayer.Character:FindFirstChildOfClass("BodyColors");
    local v3 = v2 and v2.TorsoColor3 or KillerPlayer.Character.Torso.Color;
    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;

            if child == HumanoidRootPart then
                child.Anchored = true;
            end;
        end;
    end;

    EffectsHandler.CallEffect("Banish", TargetCharacter, v3);
end;