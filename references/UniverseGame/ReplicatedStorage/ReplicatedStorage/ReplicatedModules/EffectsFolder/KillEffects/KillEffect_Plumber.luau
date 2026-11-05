  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local StandSounds = game:GetService("SoundService").StandSounds;

return function(p1) -- Line: 8
    -- upvalues: Players (copy), AssetHandler (copy), StandSounds (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v2 = TargetCharacter:FindFirstChildOfClass("Humanoid");

    if v2 then
        v2 = v2:FindFirstChildOfClass("Animator") or v2;
    end;

    local v3 = Players:GetPlayerFromCharacter(TargetCharacter);
    local v4 = AssetHandler.CloneAsset("Plumber/Audio", {
        AbilityName = "KillEffects"
    });
    v4.Parent = HumanoidRootPart;
    v4.SoundGroup = StandSounds;

    if v3 and v3 == Players.LocalPlayer then
        local v5 = AssetHandler.CloneAsset("Plumber/DeathUI", {
            AbilityName = "KillEffects"
        });
        v5.Parent = v3.PlayerGui;
        v5.Handler.Enabled = true;
    end;

    if v2 then
        for _, v in v2:GetPlayingAnimationTracks() do
            v:Stop(0);
        end;

        local v6 = v2:LoadAnimation(AssetHandler.GetAsset("Plumber/Animation", {
            AbilityName = "KillEffects"
        }));
        v6.Priority = Enum.AnimationPriority.Action4;
        v6:Play(0, 1, 0.89);
    end;

    v4:Play();

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;

            if child == HumanoidRootPart then
                child.Anchored = true;
            end;
        end;
    end;
end;