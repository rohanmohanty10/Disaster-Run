  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules.EffectsHandler);
end);
Random.new();

return function(p2) -- Line: 17
    -- upvalues: AssetHandler (copy), u1 (ref), ParticleHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Player = v3.Player;
    local Duration = v3.Duration;

    if not Character then
        return;
    end;

    local v4 = AssetHandler.GetAbilityData(Player);
    v4.AbilityName = "Rokushiki";
    local HumanoidRootPart = Character.HumanoidRootPart;
    u1.CallEffect("Materialize Character", {
        StartingTransparency = 0.7,
        Weld = false,
        Duration = 1.1,
        Character = Character,
        Color = Color3.new(0, 0, 0),
        Material = Enum.Material.Neon
    });
    u1.CallEffect("Emit Particle V3", {
        AbilityName = "Rokushiki",
        Path = "Particles/Soru/Appear",
        AutoSerialize = true,
        Player = Player,
        Origin = HumanoidRootPart
    });

    for _, child in Character:GetChildren() do
        if child:IsA("BasePart") then
            local v5 = AssetHandler.CloneAsset("Particles/Soru/Emit", v4);
            v5.Parent = child;
            v5:Emit(5);
            task.delay(1.5, v5.Destroy, v5);
        end;
    end;

    local v6 = {};

    if Player == game.Players.LocalPlayer then
        local u7 = AssetHandler.CloneAsset("Particles/Soru/Trail", v4);
        u7.Parent = Character;
        ParticleHandler.AttachTo(u7, {
            Part = HumanoidRootPart
        });
        local Highlight = Instance.new("Highlight");
        Highlight.FillTransparency = 0.5;
        Highlight.OutlineTransparency = 0.5;
        Highlight.OutlineColor = Color3.new(1, 1, 1);
        Highlight.FillColor = Color3.new(0, 0, 0);
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.Parent = Character;
        task.delay(Duration, function() -- Line: 86
            -- upvalues: Highlight (copy), ParticleHandler (ref), u7 (copy)
            Highlight:Destroy();
            task.delay(ParticleHandler.EnableAllParticles(u7, false), u7.Destroy, u7);
        end);
    else
        for _, descendant in Character:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                v6[descendant] = descendant.Enabled;
                descendant.Enabled = false;
            elseif descendant:IsA("BasePart") or descendant:IsA("Decal") then
                v6[descendant] = descendant.Transparency;
                descendant.Transparency = 1;
            end;
        end;
    end;

    u1.Wait(Duration);

    for i, _ in v6 do
        if i:IsA("ParticleEmitter") or (i:IsA("Trail") or i:IsA("Beam")) then
            i.Enabled = v6[i];
        elseif (i:IsA("BasePart") or i:IsA("Decal")) and i.Name ~= "HumanoidRootPart" then
            i.Transparency = 0;
        end;
    end;

    u1.CallEffect("Emit Particle V3", {
        Path = "Particles/Soru/Appear",
        AutoSerialize = true,
        AbilityName = "Rokushiki",
        Player = Player,
        Origin = HumanoidRootPart
    });
end;