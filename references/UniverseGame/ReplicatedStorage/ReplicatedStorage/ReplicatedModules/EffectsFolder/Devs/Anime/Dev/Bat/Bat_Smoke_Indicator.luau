  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local u1 = LocalPlayer:GetMouse();
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 23
    -- upvalues: LocalPlayer (copy), AssetHandler (copy), u1 (copy), u2 (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v4 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local HumanoidRootPart = v4.HumanoidRootPart;
    local SmokePellet = v4:WaitForChild("SmokePellet", 5);
    local v5 = AssetHandler.CloneAsset("Particles/SmokePelletIndicator", {
        AbilityName = "The Dark Knight"
    });
    v5.Parent = workspace.Effects;
    v5.Beam.Attachment1 = SmokePellet.Attachment;
    v5:SetAttribute("Active", true);
    local v6 = {
        Hue = 1,
        Saturation = 0.75,
        Value = 0.95
    };
    local v7 = {
        Hue = 0.375,
        Saturation = 0.64,
        Value = 0.94
    };

    while v5:IsDescendantOf(game) and (SmokePellet:IsDescendantOf(game) and SmokePellet:GetAttribute("Active")) do
        local Unit = (u1.Hit.Position - HumanoidRootPart.Position).Unit;
        local v8 = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + Unit) * CFrame.new(0, 0, -p3);
        local v9 = workspace:Raycast(HumanoidRootPart.Position, Unit * p3 * 2, u2);

        if v9 then
            v8 = CFrame.new(v9.Position, v9.Position + v9.Normal) * CFrame.new(0, 0, -0.25) * CFrame.Angles(-4.71238898038469, 0, 0);
        end;

        local Magnitude = (v8.Position - HumanoidRootPart.Position).Magnitude;
        v5.CFrame = v8;
        local v10;

        if Magnitude <= p3 and (v9 ~= nil and v7) then
            v10 = v7;
        else
            v10 = v6;
        end;

        ParticleHandler.EnableParticles(v5, v9 ~= nil);
        ParticleHandler.HSVShiftParticles(v5, v10);
        v5.Sphere.Color = Color3.fromHSV(v10.Hue, v10.Saturation, v10.Value);
        task.wait();
    end;

    ParticleHandler.EnableParticles(v5, false);
    EffectsHandler.CallEffect("FadeBeams", v5, {
        Time = 0.75
    });
    TweenService:Create(v5.Sphere, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1
    }):Play();
    task.delay(3, v5.Destroy, v5);
end;