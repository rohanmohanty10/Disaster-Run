  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local _ = HumanoidRootPart.CFrame;
    EffectsHandler.Wait(0.2);
    local v2 = { 15619422633, 15619422735, 15619422811 };
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. v2[math.random(1, #v2)];
    Sound.Volume = 1.5;
    Sound.Parent = HumanoidRootPart;
    Sound:Play();
    local v3 = AssetHandler.GetAsset("Vaporize/Death", {
        AbilityName = "KillEffects"
    });
    local v4 = { "HumanoidRootPart" };

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") and not table.find(v4, child.Name) then
            if child.Name == "Torso" then
                local v5 = v3.Attachment:Clone();
                v5.Parent = child;
                v5.Flare:Emit(v5.Flare:GetAttribute("EmitCount"));
            end;

            for _, child2 in v3:GetChildren() do
                if child2:IsA("ParticleEmitter") then
                    local v6 = child2:Clone();
                    v6.Parent = child;
                    v6:Emit(v6:GetAttribute("EmitCount"));
                end;
            end;
        end;
    end;

    for _, descendant in TargetCharacter:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
        end;
    end;
end;