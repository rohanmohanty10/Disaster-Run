  

 

local _ = game.Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 9
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    local Character = p1.Character;

    if not (Character and Character:GetAttribute("Roaring")) then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v2 = AssetHandler.GetAsset("Particles/Roar/Roar", {
        AbilityName = "Dragon Knight",
        SkinName = p1.SkinName
    }):Clone();
    v2.Parent = workspace.Effects;
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.75, 0);
    local v3 = 0;

    if p1.Player and (p1.Player:IsA("Player") and p1.Player.Data.Skin:GetAttribute("UnusualHueId")) then
        v3 = v3 + p1.Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v3 > 0 then
        ParticleHandler.HSVShiftParticles(v2, {
            HueShift = v3
        });
    end;

    ParticleHandler.EnableAllParticles(v2, true);

    repeat
        task.wait();
    until not (Character:GetAttribute("Roaring") and Character.Parent);

    local v4 = next;
    local v5, v6 = v2:GetChildren();

    for _, v in v4, v5, v6 do
        if v:IsA("BasePart") then
            v.Anchored = true;
        end;
    end;

    local v7 = ParticleHandler.EnableAllParticles(v2, false);
    task.wait(v7);
    v2:Destroy();
end;