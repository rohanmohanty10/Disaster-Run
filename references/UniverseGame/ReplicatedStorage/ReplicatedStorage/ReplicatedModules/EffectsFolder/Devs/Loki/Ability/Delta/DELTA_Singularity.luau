  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local Sequence_V3 = require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.Types);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local Rng = v2.Rng;
local LocalPlayer = Players.LocalPlayer;
local Highlight = script:WaitForChild("Inversion"):WaitForChild("Highlight");

if game:GetService("RunService"):IsClient() then
    Highlight.Parent = nil;
end;

return function(u3, p4) -- Line: 41
    -- upvalues: Players (copy), Trove (copy), AssetHandler (copy), BoatTween (copy), Sequence_V3 (copy), EffectsHandler (copy), ParticleHandler (copy), Highlight (copy), RunService (copy), u1 (copy), LocalPlayer (copy), Rng (copy)
    if not u3.Parent then
        return;
    end;

    local u5 = Players:GetPlayerFromCharacter(u3);
    local u6 = Trove.new();
    u6:AttachToInstance(u3);
    local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");
    AssetHandler.GetAbilityData(u3);

    local function Tween(p7, p8) -- Line: 52
        -- upvalues: u6 (copy), BoatTween (ref)
        u6:Add(BoatTween:Create(p7, p8)):Play();
    end;

    local v38 = Sequence_V3.new({
        Validate = function() -- Line: 58, Name: Validate
            -- upvalues: u3 (copy)
            local v9 = u3 and u3:IsDescendantOf(workspace);

            return v9;
        end,

        Speed = p4.Speed,
        Frames = {
            { 0, function(p10, u11) -- Line: 63
                    -- upvalues: EffectsHandler (ref), HumanoidRootPart (copy), u3 (copy), ParticleHandler (ref), Highlight (ref), u6 (copy), BoatTween (ref), RunService (ref), u1 (ref)
                    local u12 = p10:GetCache();
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/Singularity/PreCharge",
                        AutoSerialize = true,
                        Scale = 1.5,
                        AttachTo = {
                            Part = HumanoidRootPart,
                            Offset = CFrame.new(0, -2, 0)
                        },
                        Character = u3
                    });
                    local v13 = EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/Singularity/Startup",
                        AutoSerialize = true,
                        Scale = 1,
                        Destroy = false,
                        AttachTo = {
                            Part = HumanoidRootPart,
                            Offset = CFrame.new(0, -2, 0)
                        },
                        Character = u3
                    });
                    local v14 = ParticleHandler.GetUnusualHSVData({
                        Character = u3
                    });
                    local Particle = v13.Particle;
                    local u15 = script.Inversion:Clone();
                    local v16 = Highlight:Clone();
                    v16.Parent = u15;
                    v16.Adornee = u15;
                    u15.Highlight.FillTransparency = -0.5;
                    u15.Size = Vector3.new(0, 0, 0);
                    u15.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 2, 0);
                    u15.Parent = workspace.Effects;
                    ParticleHandler.AttachTo(u15, {
                        Part = HumanoidRootPart
                    });
                    u15.Highlight.FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(89, 131, 88), v14);
                    u6:Add(BoatTween:Create(u15, {
                        EasingStyle = "Quad",
                        EasingDirection = "InOut",
                        StepType = "Heartbeat",
                        Time = (130 - u11) / 60 / p10:GetSpeed(),
                        Goal = {
                            Size = Vector3.new(60, 60, 60)
                        }
                    })):Play();
                    u6:Add(BoatTween:Create(u15.Highlight, {
                        EasingStyle = "Quad",
                        EasingDirection = "InOut",
                        StepType = "Heartbeat",
                        Time = (110 - u11) / 60 / p10:GetSpeed(),
                        Goal = {
                            FillTransparency = -3
                        }
                    })):Play();
                    local Folder = Instance.new("Folder");
                    Folder.Parent = u3;
                    u6:Add(Folder);
                    task.spawn(function() -- Line: 122
                        -- upvalues: EffectsHandler (ref), u3 (ref), Folder (copy), u11 (copy), HumanoidRootPart (ref), u15 (copy), u12 (copy), u6 (ref)
                        task.spawn(EffectsHandler.CallEffect, "Radial Bezier", u3, {
                            Path = "Particles/Common/EnergyTrail",
                            Rate = 0.06,
                            Radius = 55,
                            Lifetime = NumberRange.new(0.45, 0.75),
                            Goal = u3:FindFirstChild("Torso"),
                            Duration = Folder,
                            LifetimeElapsedProportion = {
                                Min = 0.2,
                                Denominator = (130 - u11) / 60
                            }
                        });
                        local u17 = EffectsHandler.CallEffect("Spiral Debris", u3, {
                            PullSpeed = nil,
                            RequiresGround = true,
                            Rate = 0.0085,
                            Center = HumanoidRootPart,
                            AxisSpeed = NumberRange.new(3, 4),
                            Scale = NumberRange.new(1, 1.3),
                            Radius = u15.Size.X
                        });
                        u12.SpiralDebris = u17;
                        local _ = u15.Size.X * 1.25;
                        u6:Add(u17);
                        u6:Connect(u15:GetPropertyChangedSignal("Size"), function() -- Line: 153
                            -- upvalues: u17 (copy), u15 (ref)
                            if table.isfrozen(u17) then
                                return;
                            end;

                            u17.Radius = 30 + u15.Size.X / 2;
                            u17.PullSpeed = NumberRange.new(70, 100);
                        end);
                    end);
                    u6:Add(u15);
                    local CurrentCamera = workspace.CurrentCamera;
                    u6:Connect(RunService.Heartbeat, function() -- Line: 162
                        -- upvalues: u15 (copy), CurrentCamera (copy), u1 (ref)
                        local Position = u15.Position;
                        local _, v18 = CurrentCamera:WorldToScreenPoint(Position);
                        local v19 = workspace:Raycast(CurrentCamera.CFrame.Position, (Position - CurrentCamera.CFrame.Position).Unit * (Position - CurrentCamera.CFrame.Position).Magnitude, u1);

                        if v19 and (v19.Position - CurrentCamera.CFrame.Position).Magnitude < (Position - CurrentCamera.CFrame.Position).Magnitude and true or not v18 then
                            u15.Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;

                            return;
                        end;

                        u15.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                    end);
                    u12.Inversion = u15;
                    u12.Particles = { Particle };
                    u12.Ref = Folder;
                end },
            { 1, function(p20, p21) -- Line: 192
                    -- upvalues: AssetHandler (ref), u6 (copy)
                    local v22 = p20:GetCache();

                    if not v22.Particles then
                        return;
                    end;

                    for _, v in v22.Particles do
                        AssetHandler.ScaleAsset(v, {
                            Scale = 2.3,
                            TweenInfo = { (130 - p21) / 60 / p20:GetSpeed(), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut }
                        });
                        u6:Add(function() -- Line: 200
                            -- upvalues: v (copy)
                            task.delay(3, function() -- Line: 201
                                -- upvalues: v (ref)
                                v:Destroy();
                            end);
                        end);
                    end;
                end },
            { 110, function(p23, p24) -- Line: 208
                    local v25 = p23:GetCache();

                    if v25.SpiralDebris then
                        v25.SpiralDebris:Destroy();
                    end;
                end },
            { 130, function(p26, p27) -- Line: 215
                    -- upvalues: EffectsHandler (ref), HumanoidRootPart (copy), u3 (copy), u6 (copy), BoatTween (ref)
                    local v28 = p26:GetCache();
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/Singularity/Pull",
                        AutoSerialize = true,
                        Scale = 2.5,
                        AttachTo = {
                            Part = HumanoidRootPart,
                            Offset = CFrame.new(0, -2, 0)
                        },
                        Character = u3
                    });

                    if v28.Inversion then
                        u6:Add(BoatTween:Create(v28.Inversion, {
                            EasingStyle = "Circ",
                            EasingDirection = "In",
                            StepType = "Heartbeat",
                            Time = (137 - p27) / 60 / p26:GetSpeed(),
                            Goal = {
                                Size = Vector3.new(0, 0, 0)
                            }
                        })):Play();
                    end;

                    if v28.Ref then
                        v28.Ref:Destroy();
                    end;
                end },
            { 137, function(p29, p30) -- Line: 243
                    -- upvalues: u3 (copy), ParticleHandler (ref), EffectsHandler (ref), HumanoidRootPart (copy), LocalPlayer (ref), u5 (copy), Rng (ref)
                    local Stand = u3:FindFirstChild("Stand");

                    if Stand then
                        ParticleHandler.EnableAllParticles(Stand, false);

                        for _, descendant in Stand:GetDescendants() do
                            if descendant:IsA("BasePart") then
                                descendant.Transparency = 1;
                            end;
                        end;
                    end;

                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/Singularity/Blast",
                        LockToPart = false,
                        AutoSerialize = true,
                        Scale = 1,
                        AttachTo = {
                            Part = HumanoidRootPart,
                            Offset = CFrame.new(0, -2, 0)
                        },
                        Character = u3
                    });

                    if LocalPlayer == u5 then
                        EffectsHandler.CallEffects({
                            {
                                Name = "TedBlur",
                                Data = { 20, 0.2 }
                            },
                            {
                                Name = "InvertedLighting",
                                Data = { 0.2, 0.5 }
                            },
                            {
                                Effect = "Dawn Lighting",
                                Arguments = {}
                            },
                            {
                                Name = "Impact Frame",
                                Data = {
                                    {
                                        Time = 0.1,
                                        Models = { u3 }
                                    }
                                }
                            }
                        });
                    end;

                    local CallEffects = EffectsHandler.CallEffects;
                    local v31 = {};
                    local v32 = {
                        Name = "Flying Debris"
                    };
                    local v33 = {};
                    local v34 = {
                        Lifetime = 2,
                        Collision = true,
                        Size = 4,
                        Amount = 13,
                        TweenDelay = 0.9,
                        Inconsistent = true,
                        Origin = HumanoidRootPart.CFrame
                    };
                    local v35 = Rng(0.9, 1.4);
                    v34.Force = Vector3.new(1, v35, 1) * 45;
                    v34.Tween = {
                        Transparency = 1,
                        Size = Vector3.new(0, 0, 0)
                    };
                    v33[1] = v34;
                    v32.Data = v33;
                    v31[1], v31[2] = v32, {
    Name = "Q_RADIAL",
    Data = {
        {
            Distance = 30,
            Origin = HumanoidRootPart.CFrame,
            Effect = { {
                    Effect = "Camera Shake",
                    Arguments = { { 9, 14, 0, 0.6, Vector3.new(0.4, 0.4, 0.4), Vector3.new(4, 1, 1), true } }
                } }
        }
    }
};
                    CallEffects(v31);
                end },
            { 170, function(p36, p37) -- Line: 322
                end }
        }
    });
    u6:Add(v38);
    v38:Play();

    if p4.StartFrame then
        v38:MoveTo(p4.StartFrame, true);
    end;

    while v38:IsPlaying() do
        task.wait(0.1);
    end;

    u6:Destroy();
end;