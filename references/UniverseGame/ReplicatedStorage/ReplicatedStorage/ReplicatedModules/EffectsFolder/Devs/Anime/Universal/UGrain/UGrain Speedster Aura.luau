  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local u1 = {
    Default = Color3.fromRGB(105, 141, 192),
    ["Reverse Flash"] = Color3.fromRGB(172, 12, 12),
    ["CW Flash"] = Color3.fromRGB(221, 147, 81),
    ["Injustice Flash"] = Color3.fromRGB(234, 201, 15)
};

return function(p2) -- Line: 25
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), u1 (copy), TweenService (copy), EffectsHandler (copy)
    local u3 = p2 or {};
    local Character = u3.Character;
    local u4 = u3.Attribute or "Awakened";
    local u5 = Trove.new();
    u5:AttachToInstance(Character);
    u5:Connect(Character:GetAttributeChangedSignal(u4), function() -- Line: 34
        -- upvalues: Character (copy), u4 (copy), u5 (copy)
        if not Character:GetAttribute(u4) then
            u5:Destroy();
        end;
    end);
    local v6 = u3.PathData or AssetHandler.GetAbilityData(Character);
    local v7 = u3.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = u3.Player,
        Character = Character
    });
    local u8 = AssetHandler.CloneAsset("Particles/Awaken/Aura", v6);
    ParticleHandler.Unusualify(u8, {
        HSVData = v7
    });
    u8.Parent = Character;
    ParticleHandler.AttachTo(u8, {
        Part = Character.Torso
    });
    u5:Add(function() -- Line: 51
        -- upvalues: ParticleHandler (ref), u8 (copy)
        ParticleHandler.EnableAllParticles(u8, false);
        ParticleHandler.DestroyEmit(u8);
    end);
    local u9 = {};

    for _, child in Character:GetChildren() do
        if child:IsA("BasePart") then
            for _, child2 in AssetHandler.GetAsset("Particles/Awaken/Blur", v6):GetChildren() do
                local v10 = u5:Clone(child2);
                v10.Parent = child;
                table.insert(u9, v10);
            end;
        end;
    end;

    local u11 = u1[u3.SkinName] or u1.Default;
    local u12 = u5:Construct(Instance, "Highlight");
    u12.FillTransparency = 0.25;
    u12.OutlineTransparency = 1;
    u12.OutlineColor = ParticleHandler.TryHSVShift(u11, v7);
    u12.FillColor = ParticleHandler.TryHSVShift(u11, v7);
    u12.DepthMode = Enum.HighlightDepthMode.Occluded;
    u12.Adornee = Character;
    u12.Parent = workspace.Effects;
    u12.Name = "ATrainHighlight";
    local v13 = TweenService:Create(u12, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
        FillTransparency = 1
    });
    v13.Completed:Connect(function() -- Line: 83
        -- upvalues: TweenService (ref), u12 (copy)
        TweenService:Create(u12, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, (1 / 0), true), {
            OutlineTransparency = 0.5
        }):Play();
    end);
    v13:Play();
    u5:Connect(Character:GetAttributeChangedSignal("Vanished"), function() -- Line: 90
        -- upvalues: Character (copy), ParticleHandler (ref), u8 (copy), EffectsHandler (ref), u11 (copy), u3 (ref), u9 (copy)
        local v14 = not Character:GetAttribute("Vanished");
        ParticleHandler.EnableAllParticles(u8, v14);

        for _, v in { "Lightning Beam Aura", "UGrain Lightning", "A-Train Afterimages" } do
            task.spawn(EffectsHandler.CallEffect, v, Character, v14, {
                Color = u11,
                SkinName = u3.SkinName
            });
        end;

        for _, v in u9 do
            v.Enabled = v14;
        end;
    end);
    local v15 = { "Lightning Beam Aura", "UGrain Lightning" };

    if not u3.NoAfterimages then
        table.insert(v15, "A-Train Afterimages");
    end;

    for _, v in v15 do
        task.spawn(EffectsHandler.CallEffect, v, Character, true, {
            Color = u11,
            SkinName = u3.SkinName
        });
        u5:Add(function() -- Line: 119
            -- upvalues: EffectsHandler (ref), v (copy), Character (copy)
            EffectsHandler.CallEffect(v, Character, false);
        end);
    end;
end;