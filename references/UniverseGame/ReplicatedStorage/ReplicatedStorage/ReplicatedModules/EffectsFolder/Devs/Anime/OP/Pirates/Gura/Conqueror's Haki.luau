  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local LightningBolt = require(ReplicatedStorage.ClientModules.LightningBolt);
require(ReplicatedStorage.ClientModules.LightningBolt.LightningSparks);
local u2 = Random.new();

return function(p3) -- Line: 18
    -- upvalues: LocalPlayer (copy), u2 (copy), LightningBolt (copy), TweenService (copy), u1 (copy), ParticleHandler (copy)
    local Character = LocalPlayer.Character;
    local Character2 = p3.Character;
    local u4 = p3.Size or 1.75;
    local AdminCommand = p3.AdminCommand;
    local Model = Instance.new("Model");
    Model.Name = "ConquerorsHaki";
    Model.Parent = workspace.CurrentCamera;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.new(0, 0, 0);
    Highlight.Parent = Model;
    task.delay(5, Model.Destroy, Model);
    task.spawn(function() -- Line: 38
        -- upvalues: u2 (ref), u4 (copy), Character2 (copy), LightningBolt (ref), Model (copy), AdminCommand (copy)
        u2:NextNumber(0, 6.283185307179586);

        for _ = 1, 112 do
            local v5 = u2:NextNumber(0, 6.283185307179586);
            local v6 = u2:NextNumber(30, 60) * u4;
            local v7 = u2:NextNumber(-v6, v6);
            local v8 = {
                WorldAxis = Vector3.new(0, 0, 0),
                WorldPosition = Character2.Head.Position
            };
            local v9 = math.sin(v5);
            local v10 = math.cos(v5);
            v8.WorldAxis = Vector3.new(v9, 0, v10);
            local v11 = CFrame.lookAt(Vector3.new(0, 0, 0), Vector3.new(-0, -1, -0));
            local v12 = CFrame.Angles(0, 0, u2:NextNumber(0, 6.283185307179586));
            local Angles = CFrame.Angles;
            local v13 = u2:NextNumber(0.3420201433256688, -0.3420201433256687);
            local v14 = Angles(math.acos(v13), 0, 0);
            local v15 = {
                WorldAxis = Vector3.new(0, 0, 0),
                WorldPosition = Character2.Head.Position + v8.WorldAxis * v6 + Vector3.new(0, v7, 0),
                WorldAxis = (v11 * v12 * v14).LookVector
            };
            local v16 = LightningBolt.new(v8, v15, 14, Model);
            v16.AnimationSpeed = u2:NextNumber(6.3, 8.7);
            v16.Thickness = u2:NextNumber(1.25, 1.85) / (AdminCommand and 2.35 or 1);
            v16.Color = Color3.fromRGB(223, 0, 0);
            v16.PulseLength = u2:NextNumber(0.67, 0.9);
            v16.Frequency = 1.4;
            v16.MinRadius = 0;
            v16.MaxRadius = 4 * u4;
            v16.FadeLength = 0.25;
            v16.PulseSpeed = u2:NextNumber(4.75, 5.5);
            v16.MinThicknessMultiplier = 0.7;
            v16.MaxThicknessMultiplier = 1;
            v16.Velocity = (v15.WorldPosition - v8.WorldPosition).Unit * 0.1 * u4;
            task.wait(u2:NextNumber(0.01, 0.015));
        end;
    end);
    task.wait(0.15);

    if (Character.HumanoidRootPart.Position - Character2.Head.Position).Magnitude < 150 then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Brightness = -0.25;
        ColorCorrectionEffect.Parent = game.Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.4), {
            TintColor = Color3.fromRGB(255, 12, 16)
        }):Play();
        task.delay(2.5, ColorCorrectionEffect.Destroy, ColorCorrectionEffect);
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 0;
        BlurEffect.Parent = game.Lighting;
        TweenService:Create(BlurEffect, TweenInfo.new(0.4), {
            Size = 11
        }):Play();
        task.delay(3.25, BlurEffect.Destroy, BlurEffect);
        task.delay(2.25, function() -- Line: 97
            -- upvalues: TweenService (ref), BlurEffect (copy), ColorCorrectionEffect (copy)
            TweenService:Create(BlurEffect, TweenInfo.new(0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.25), {
                Size = 0
            }):Play();
            TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.65, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Brightness = 0,
                TintColor = Color3.fromRGB(255, 255, 255)
            }):Play();
        end);
    end;

    if not p3.DisableParticles then
        local v17 = u1.Gura.HakiReleaseHead:Clone();
        v17.Parent = Character2;
        ParticleHandler.AttachTo(v17, {
            Part = Character2.Head,
            Offset = CFrame.identity
        });
        local v18 = u1.Gura.Haki:Clone();
        v18.Position = Character2.Head.Position;
        v18.Parent = workspace.Effects;
        task.delay(ParticleHandler.EnableParticles(v17, false), v17.Destroy, v17);
        task.delay(ParticleHandler.EnableParticles(v18, false), v18.Destroy, v18);
    end;

    for _ = 1, math.random(15, 20) do
        task.wait(u2:NextNumber(0.075, 0.14));
        local Part = Instance.new("Part");
        Part.Transparency = 0.35;
        Part.Shape = "Ball";
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3.new(0, 0, 0);
        Part.Size = Vector3.new(0, 0, 0);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Position = Character2.Head.Position;
        Part.Parent = workspace.Effects;
        task.delay(0.4, Part.Destroy, Part);
        TweenService:Create(Part, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Transparency = 1,
            Size = Vector3.new(1, 1, 1) * (u4 * u2:NextNumber(135, 155))
        }):Play();
    end;
end;