  

 

local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return {
    OnBeat = function(p3, p4, p5) -- Line: 25
        -- upvalues: EffectsHandler (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = p3.Character,
            Particle = script.Shock
        });
        task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
            LifeTime = 0.2,
            Transparency = 0.5,
            TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
            TweenOut = { 0.225, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
            Size = UDim2.fromScale(1.25, 1.25),
            Color = math.random(1, 2) == 1 and Color3.fromRGB(47, 137, 255) or Color3.fromRGB(255, 231, 112)
        });
        local v6 = { Color3.fromRGB(255, 230, 80), Color3.fromRGB(80, 160, 255) };
        p3.BeatColorFlip = not p3.BeatColorFlip;
        local v7 = v6[p3.BeatColorFlip and 1 or 2];
        EffectsHandler.CallEffect("HighlightObject", p3.Character, {
            FillTransparency = 0.35,
            Tween = true,
            FillColor = v7,
            OutlineColor = v7,
            DepthMode = Enum.HighlightDepthMode.Occluded,
            Lifetime = 0.3 + p5 * 0.2
        });
    end,

    OnPeak = function(u8, p9) -- Line: 59
        -- upvalues: EffectsHandler (copy), LocalPlayer (copy), ParticleHandler (copy), RunService (copy), u1 (copy), u2 (copy), TweenService (copy)
        u8.CamShake = 1;
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Player = LocalPlayer,
            Origin = u8.Character,
            Offset = CFrame.new(0, -2.4, 0),
            Particle = script.Activation
        });
        EffectsHandler.CallEffect("Rock Debris", {
            Lifetime = 1.6,
            Size = Vector3.new(1.8, 1.8, 1.8),
            Radius = 6.5,
            Amount = 8,
            Origin = u8.Character.HumanoidRootPart.CFrame
        });
        local u10 = script.Aura:Clone();
        u10.Parent = u8.Character.HumanoidRootPart;
        ParticleHandler.AttachTo(u10, {
            Part = u8.Character.HumanoidRootPart
        });
        u8.Trove:Add(function() -- Line: 87
            -- upvalues: ParticleHandler (ref), u10 (copy)
            ParticleHandler.DestroyEmit(u10);
            ParticleHandler.EnableAllParticles(u10, false);
        end);
        local u11 = 0;
        local u12 = 0;
        u8.Trove:Connect(RunService.RenderStepped, function(p13) -- Line: 95
            -- upvalues: u8 (copy), u11 (ref), u1 (ref), u2 (ref), EffectsHandler (ref), u12 (ref), TweenService (ref)
            local Position = u8.Character.HumanoidRootPart.Position;

            if os.clock() - u11 >= 0.2 then
                u11 = os.clock();
                local v14 = u1:NextNumber(0.35, 0.65);
                local v15 = u1:NextNumber(5, 20);
                local v16 = u1:NextNumber(-6, 6);
                local v17 = u1:NextNumber(-v16, v16);
                local v18 = Position + Vector3.new(v17, 0, u1:NextNumber(-v16, v16));
                local v19 = workspace:Raycast(v18 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

                if v19 then
                    local _ = v19.Instance;
                    local Attachment = Instance.new("Attachment");
                    Attachment.Parent = workspace.Terrain;
                    Attachment.WorldPosition = v19.Position;
                    local Attachment2 = Instance.new("Attachment");
                    Attachment2.Parent = workspace.Terrain;
                    Attachment2.WorldPosition = v19.Position + Vector3.new(0, v15, 0);
                    u1:NextNumber(5, 7.5);
                    local v20 = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
                    local v21 = u1:NextNumber(7, 9);
                    local v22 = u1:NextNumber(0.5, 1);
                    local v23 = u1:NextNumber(0, 1);
                    local v24 = u1:NextInteger(8, 12);
                    local v25 = { 1.25, 1.5 };
                    local v26 = { Color3.fromRGB(244, 225, 119), Color3.fromRGB(100, 125, 219) };
                    local v27 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                        Color = v26[math.random(1, #v26)],
                        Curves = v20,
                        Speed = v21,
                        Length = v22,
                        A1 = Attachment,
                        A2 = Attachment2,
                        Size = v14,
                        PartCount = v24
                    });
                    v27.MinThicknessMultiplier = 0.5;
                    v27.AnimationSpeed = v23;
                    v27.MinRadius = v25[1];
                    v27.MaxRadius = v25[2];
                    task.delay(0.25 / v21, function() -- Line: 145
                        -- upvalues: Attachment (copy), Attachment2 (copy)
                        Attachment:Destroy();
                        Attachment2:Destroy();
                    end);
                end;
            end;

            if os.clock() - u12 >= 0.16 then
                u12 = os.clock();
                local v28 = u1:NextNumber(-7, 7);
                local v29 = Position + Vector3.new(v28, 0, u1:NextNumber(-7, 7));
                local v30 = workspace:Raycast(v29 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

                if v30 then
                    local Instance2 = v30.Instance;
                    local v31 = math.random(0, 360);
                    local v32 = math.rad(v31);
                    local Part = Instance.new("Part");
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanTouch = false;
                    Part.Material = v30.Material;
                    Part.Color = Instance2.Color;
                    Part.CFrame = CFrame.new(v30.Position) * CFrame.Angles(v32, v32, v32);
                    Part.Size = Vector3.new(1, 1, 1) * u1:NextNumber(1, 1.65);
                    Part.BottomSurface = Enum.SurfaceType.Smooth;
                    Part.TopSurface = Enum.SurfaceType.Smooth;
                    Part.Parent = workspace.Effects;

                    for _, child in pairs(Instance2:GetChildren()) do
                        if child:IsA("Decal") or child:IsA("Texture") then
                            child:Clone().Parent = Part;
                        end;
                    end;

                    local v33 = math.random(0, 360);
                    math.rad(v33);
                    local v34 = {
                        Size = Vector3.new(0, 0, 0)
                    };
                    local Position2 = Part.Position;
                    local v35 = u1:NextNumber(9, 12.4);
                    v34.Position = Position2 + Vector3.new(0, v35, 0);
                    local v36 = math.random(0, 120);
                    local v37 = math.random(0, 120);
                    v34.Orientation = Vector3.new(v36, v37, math.random(0, 120));
                    local v38 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1.95, 2.65), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v34);
                    v38:Play();
                    v38.Completed:Connect(function() -- Line: 189
                        -- upvalues: Part (copy)
                        Part:Destroy();
                    end);
                end;
            end;
        end);
    end
};