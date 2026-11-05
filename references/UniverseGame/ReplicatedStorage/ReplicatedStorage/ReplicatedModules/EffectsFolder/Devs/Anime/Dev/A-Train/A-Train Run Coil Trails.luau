  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();

return function(p1) -- Line: 13
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local Attribute = v2.Attribute;
    local Trail = v2.Trail;

    if not (Character and Attribute) then
        return;
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = "A-Train FX";
    Folder.Parent = Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local _ = Character.Torso;
    local v3 = v2.Total or 4;
    local v4 = 0;
    local v5 = {};

    for i = 1, v3 do
        local v6 = v4 + i / v3 * 6.283185307179586;
        local v7 = (Trail or AssetHandler.GetAsset("Particles/General/CoilTrail", AssetHandler.GetAbilityData(Character))):Clone();
        v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.cos(v6) * 4.75, math.sin(v6) * 4.75, 0);
        ParticleHandler.Unusualify(v7, {
            Character = Character
        });
        v7.Parent = Folder;
        table.insert(v5, v7);
    end;

    while true do
        local v8 = task.wait();
        v4 = v4 + 9.42477796076938 * v8 % 6.283185307179586;

        for i, v in v5 do
            local v9 = v4 + i / #v5 * 6.283185307179586;
            TweenService:Create(v, TweenInfo.new(v8, Enum.EasingStyle.Linear), {
                CFrame = HumanoidRootPart.CFrame * CFrame.new(math.cos(v9) * 4.75, math.sin(v9) * 4.75, 0)
            }):Play();
        end;

        if not (Character:IsDescendantOf(game) and Character:GetAttribute(Attribute)) then
            ParticleHandler.DestroyEmit(Folder);
            ParticleHandler.EnableAllParticles(Folder, false);

            return;
        end;
    end;
end;