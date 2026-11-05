  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 19
    -- upvalues: Trove (copy), ParticleHandler (copy), TweenService (copy), EffectsHandler (copy), AssetHandler (copy), LocalPlayer (copy)
    local v2 = p1 or {};
    local u3 = v2.Character or error("No character data");
    local HSVData = v2.HSVData;
    local u4 = Trove.new();
    u4:AttachToInstance(u3);
    u4:Connect(u3:GetAttributeChangedSignal("Awakened"), function() -- Line: 28
        -- upvalues: u3 (copy), u4 (copy)
        if not u3:GetAttribute("Awakened") then
            u4:Destroy();
        end;
    end);
    local u5 = u4:Construct(Instance, "Highlight");
    u5.FillTransparency = 0.25;
    u5.OutlineTransparency = 1;
    u5.OutlineColor = ParticleHandler.TryHSVShift(Color3.fromRGB(46, 206, 255), HSVData);
    u5.FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(74, 155, 255), HSVData);
    u5.DepthMode = Enum.HighlightDepthMode.Occluded;
    u5.Adornee = u3;
    u5.Parent = workspace.Effects;
    local v6 = TweenService:Create(u5, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
        FillTransparency = 1
    });
    v6.Completed:Connect(function() -- Line: 47
        -- upvalues: TweenService (ref), u5 (copy)
        TweenService:Create(u5, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            OutlineTransparency = 0.5
        }):Play();
    end);
    v6:Play();
    local v7 = u4:Construct(Instance, "PointLight");
    v7.Range = 0;
    v7.Brightness = 8;
    v7.Color = ParticleHandler.TryHSVShift(Color3.fromRGB(46, 206, 255), HSVData);
    v7.Parent = u3.HumanoidRootPart;
    TweenService:Create(v7, TweenInfo.new(0.85, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {
        Range = 6
    }):Play();
    local Folder = Instance.new("Folder");
    Folder.Name = "Aura";
    Folder.Parent = workspace.Effects;
    u4:Add(function() -- Line: 68
        -- upvalues: EffectsHandler (ref), u3 (copy), ParticleHandler (ref), Folder (copy)
        EffectsHandler.CallEffect("A-Train Afterimages", u3, false);
        EffectsHandler.CallEffect("A-Train Lightning", u3, false);
        ParticleHandler.EnableAllParticles(Folder, false);
        ParticleHandler.DestroyEmit(Folder);
    end);
    u4:Connect(u3:GetAttributeChangedSignal("Flashtime"), function() -- Line: 82
        -- upvalues: ParticleHandler (ref), Folder (copy), u3 (copy)
        ParticleHandler.EnableParticleTrails(Folder, u3:GetAttribute("Flashtime") ~= true);
    end);

    for _, child in AssetHandler.GetAsset("Particles/Blessing/Aura", v2):GetChildren() do
        local v8 = u3[child.Name];
        local u9 = child:Clone();
        ParticleHandler.Unusualify(u9, v2);
        u9.Parent = Folder;
        ParticleHandler.AttachTo(u9, {
            Part = v8
        });

        if v8.Name == "Left Arm" or v8.Name == "Right Arm" then
            u4:Connect(u3.Humanoid.Running, function(p10) -- Line: 97
                -- upvalues: u3 (copy), ParticleHandler (ref), u9 (copy)
                if u3:GetAttribute("Flashtime") then
                    return;
                end;

                ParticleHandler.EnableParticleTrails(u9, p10 ~= 0);
            end);
        end;

        for _, child2 in AssetHandler.GetAsset("Particles/Blessing/Blur", v2):GetChildren() do
            u4:Clone(child2).Parent = v8;
        end;
    end;

    if LocalPlayer == v2.Player then
        EffectsHandler.CallEffect("Vignette Gui", {
            TweenTime = 0.2,
            Blur = 15,
            StartingColor = ParticleHandler.TryHSVShift(Color3.new(0.137255, 0.415686, 0.862745), HSVData),
            EndingColor = ParticleHandler.TryHSVShift(Color3.new(0.0784314, 0.419608, 0.862745), HSVData)
        });
        EffectsHandler.CallEffect("BoxCameraShake", "ViolentSlam");
    end;

    EffectsHandler.CallEffect("A-Train Afterimages", u3, true);
    EffectsHandler.CallEffect("A-Train Lightning", u3, true, {
        HSVData = HSVData
    });
end;