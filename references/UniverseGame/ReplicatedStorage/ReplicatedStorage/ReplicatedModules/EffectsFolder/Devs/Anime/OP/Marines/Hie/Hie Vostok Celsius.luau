  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local Attribute = v2.Attribute;
    local v3 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local v4 = AssetHandler.GetAbilityData(Character);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Vostok/Activate",
        AutoSerialize = true,
        Origin = Character.HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0),
        HSVShift = v3,
        AbilityName = v4.AbilityName,
        SkinName = v4.SkinName
    });
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 1;
    Highlight.FillColor = Color3.fromRGB(255, 255, 255);
    Highlight.Parent = Character;
    local v5 = TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        FillTransparency = 0
    });
    v5:Play();
    v5.Completed:Wait();
    EffectsHandler.CallEffect("Materialize Character", {
        Weld = true,
        Scale = 1.03,
        StartingTransparency = 0.5,
        Reflectance = 800,
        Attribute = "Awakened",
        Character = Character,
        Material = Enum.Material.Glass
    });
    TweenService:Create(Highlight, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        FillTransparency = 1
    }):Play();
    local u6 = {};

    for _, child in Character:GetChildren() do
        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
            for _, child2 in AssetHandler.GetAsset("Particles/Vostok/Aura", v4):GetChildren() do
                local v7 = child2:Clone();
                v7.Parent = child;
                table.insert(u6, v7);
            end;
        end;
    end;

    local u8 = nil;
    u8 = Character:GetAttributeChangedSignal(Attribute):Connect(function() -- Line: 76
        -- upvalues: Character (copy), Attribute (copy), u8 (ref), TweenService (ref), Highlight (copy), u6 (copy)
        if not Character:GetAttribute(Attribute) then
            u8:Disconnect();
            u8 = nil;
            local v9 = TweenService:Create(Highlight, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                FillTransparency = 0
            });
            v9:Play();
            v9.Completed:Connect(function() -- Line: 86
                -- upvalues: TweenService (ref), Highlight (ref)
                local v10 = TweenService:Create(Highlight, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    FillTransparency = 1
                });
                v10:Play();
                v10.Completed:Connect(function() -- Line: 92
                    -- upvalues: Highlight (ref)
                    Highlight:Destroy();
                end);
            end);

            for _, v in u6 do
                v.Enabled = false;
                task.delay(2, v.Destroy, v);
            end;

            table.clear(u6);
        end;
    end);
end;