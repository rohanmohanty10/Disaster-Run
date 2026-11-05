  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local Debris = game:GetService("Debris");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = game:GetService("SoundService").StandSounds;

return function(p1) -- Line: 9
    -- upvalues: AssetHandler (copy), Debris (copy), EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v2 = AssetHandler.CloneAsset("Disconnect/Emit", {
        AbilityName = "KillEffects"
    });
    v2.Parent = workspace.Effects;
    v2.Position = HumanoidRootPart and (HumanoidRootPart.Position or Vector3.new(0, 0, 0)) or Vector3.new(0, 0, 0);
    Debris:AddItem(v2, 5);

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;

            if child == HumanoidRootPart then
                child.Anchored = true;
            end;
        elseif child:IsA("Model") then
            child:Destroy();
        end;
    end;

    v2.VFX:Emit(1);
    v2.Audio:Play();
    local v3 = TargetCharacter:GetScale();

    while true do
        TargetCharacter:ScaleTo(v3 * 0.8);
        EffectsHandler.Wait(0.01);

        if TargetCharacter then
            v3 = TargetCharacter:GetScale();
        else
            v3 = TargetCharacter;
        end;

        if not TargetCharacter or (not v3 or v3 <= 0.01) then
            if TargetCharacter then
                TargetCharacter:Destroy();
            end;

            return;
        end;
    end;
end;