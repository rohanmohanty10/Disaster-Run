  

 

if game:GetService("RunService"):IsServer() then
    return function() -- Line: 2
    end;
end;

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Promise = require(Knit.Util.Promise);
require(Knit.Util.TableUtil);
require(PathShortcuts.GenericModule);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local Fusion = require(game.ReplicatedStorage.ClientLibrary.Fusion);
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.Computed;
local _ = Fusion.ForKeys;
local _ = Fusion.ForValues;
local _ = Fusion.ForPairs;
local _ = Fusion.New;
local _ = Fusion.Hydrate;
local _ = Fusion.Children;
local _ = Fusion.OnEvent;
local _ = Fusion.OnChange;
local _ = Fusion.Out;
local _ = Fusion.Ref;
local _ = Fusion.Cleanup;
local _ = Fusion.Tween;
local _ = Fusion.Spring;
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
EffectsHandler.GetEffect("Emit Particle V3");
local u1 = Random.new();

local function GetFrustumRectForRadius(p2, p3, p4, p5) -- Line: 33
    local v6 = p3.X / p3.Y;
    local v7 = math.rad(p4 * 0.5);
    local v8 = p5 / math.sin(v7);
    local v9 = math.tan(v7) * 2 * v8;
    local v10 = p2 * CFrame.new(0, 0, -v8);
    local ZVector = p2.ZVector;

    return {
        Width = v9 * v6,
        Height = v9,
        Normal = ZVector,
        Distance = -v10.Position:Dot(ZVector),
        Origin = CFrame.fromMatrix(v10.Position, -v10.XVector, v10.YVector, -ZVector)
    };
end;

local function GetFrustumRectAtDistance(p11, p12, p13, p14) -- Line: 54
    local v15 = p12.X / p12.Y;
    local v16 = math.rad(p13 * 0.5);
    local v17 = math.tan(v16) * 2 * p14;
    local v18 = p11 * CFrame.new(0, 0, -p14);
    local ZVector = p11.ZVector;

    return {
        Width = v17 * v15,
        Height = v17,
        Normal = ZVector,
        Distance = -v18.Position:Dot(ZVector),
        Origin = CFrame.fromMatrix(v18.Position, -v18.XVector, v18.YVector, -ZVector)
    };
end;

local CurrentCamera = workspace.CurrentCamera;

return function(p19) -- Line: 76
    -- upvalues: Trove (copy), BoatTween (copy), ParticleHandler (copy), Promise (copy), CurrentCamera (copy), GetFrustumRectAtDistance (copy), u1 (copy)
    local v20 = p19 or {};
    local Attacker = v20.Attacker;
    local u21 = v20.Targets or {};
    local u22 = Trove.new();

    local function TweenObject(p23, p24) -- Line: 83
        -- upvalues: u22 (copy), BoatTween (ref)
        u22:Add(BoatTween:Create(p23, p24)):Play();
    end;

    local u25 = Color3.new(1, 1, 1);

    if v20.HSVShift then
        u25 = ParticleHandler.HSVShiftColor(Color3.new(1, 0, 0), v20.HSVShift);
    end;

    Promise.try(function() -- Line: 94
        -- upvalues: u21 (copy), Attacker (copy), u22 (copy), u25 (ref), BoatTween (ref), CurrentCamera (ref), GetFrustumRectAtDistance (ref), u1 (ref)
        local v26 = table.clone(u21);
        table.insert(v26, Attacker);
        local v27 = u22:Construct(Instance, "ColorCorrectionEffect");
        local u28 = u22:Construct(Instance, "Model");
        local v29 = u22:Construct(Instance, "Highlight");
        v29.FillColor = u25;
        v29.OutlineTransparency = 1;
        v29.FillTransparency = 0;
        v29.Parent = u28;
        u28.Parent = workspace.Effects;
        u22:Add(BoatTween:Create(v27, {
            Time = 0.25,
            EasingStyle = "Linear",
            EasingDirection = "Out",
            StepType = "RenderStepped",
            Goal = {
                Contrast = -1,
                Brightness = -1
            }
        })):Play();
        v27.Parent = game.Lighting;
        local v30 = {};

        for _, v in pairs(v26) do
            local v31 = u22:Construct(Instance, "Highlight");
            v31.FillColor = Color3.new(1, 1, 1);
            v31.OutlineTransparency = 1;
            v31.FillTransparency = 1;
            v31.Parent = v;
            v30[v] = v31;
            u22:Add(BoatTween:Create(v31, {
                Time = 0.25,
                EasingStyle = "Cubic",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    FillTransparency = 0
                }
            })):Play();
        end;

        local CFrame2 = CurrentCamera.CFrame;
        local Custom = Enum.CameraType.Custom;
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u22:Connect(game:GetService("RunService").RenderStepped, function(p32) -- Line: 148
            -- upvalues: CurrentCamera (ref), CFrame2 (copy)
            CurrentCamera.CFrame = CFrame2;
        end);
        u22:Add(function() -- Line: 151
            -- upvalues: CurrentCamera (ref), Custom (copy)
            CurrentCamera.CameraType = Custom;
        end);
        u22:Add(BoatTween:Create(CurrentCamera, {
            Time = 0.75,
            EasingStyle = "Circ",
            EasingDirection = "Out",
            StepType = "RenderStepped",
            Goal = {
                FieldOfView = CurrentCamera.FieldOfView - 15
            }
        })):Play();
        u22:Add(function() -- Line: 165
            -- upvalues: CurrentCamera (ref)
            game:GetService("TweenService"):Create(CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value
            }):Play();
        end);
        local v33 = GetFrustumRectAtDistance(CurrentCamera.CFrame, CurrentCamera.ViewportSize, CurrentCamera.FieldOfView, 1);
        local u34 = {};

        for i, v in pairs(u21) do
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                local v35, _ = CurrentCamera:WorldToViewportPoint(HumanoidRootPart.Position);
                local v36 = v33.Width / CurrentCamera.ViewportSize.X;
                local v37 = v33.Height / CurrentCamera.ViewportSize.Y;
                local v38 = i % 2 == 1 and -1 or 1;
                local v39 = Vector3.new(v33.Width + v33.Width / 2 + v35.X * v36, 0.005, 0.01);
                local v40 = v33.Origin * CFrame.new(v33.Width / 2, v33.Height / 2, 0) * CFrame.new(-v35.X * v36, -v35.Y * v37, 0);
                local Angles = CFrame.Angles;
                local v41 = v38 * 10 + u1:NextNumber(-8, 8);
                local v42 = v40 * Angles(0, 0, (math.rad(v41)));
                local v43 = u22:Construct(Instance, "Part");
                v43.Anchored = true;
                v43.CanCollide = false;
                v43.Size = Vector3.new(0.05, 0.125, 0.01);
                v43.CFrame = v42 * CFrame.new(v39.X / 2 * v38, 0, 0);
                v43.Color = Color3.new(1, 1, 1);
                v43.Material = Enum.Material.Neon;
                v43.Parent = u28;
                v43:SetAttribute("TargetCFrame", v42);
                v43:SetAttribute("TargetSize", v39);
                v43:SetAttribute("Multiplier", v38);
                v43:SetAttribute("StartPoint", v43.CFrame);
                local SpecialMesh = Instance.new("SpecialMesh");
                SpecialMesh.MeshType = Enum.MeshType.Sphere;
                SpecialMesh.Parent = v43;
                u22:Add(BoatTween:Create(v43, {
                    Time = 0.5,
                    EasingStyle = "Cubic",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Size = v39,
                        CFrame = v42
                    }
                })):Play();
                table.insert(u34, v43);
            end;
        end;

        task.spawn(function() -- Line: 225
            -- upvalues: u34 (copy), u21 (ref), u1 (ref), u22 (ref), u28 (copy), BoatTween (ref)
            local v44 = os.clock();

            while os.clock() - v44 <= 0.5 do
                local v45 = (os.clock() - v44) / 0.5;
                local v46 = math.clamp(v45, 0, 1);

                for _, v in pairs(u34) do
                    local v47 = v:GetAttribute("Multiplier");
                    local v48 = v:GetAttribute("StartPoint"):Lerp(v:GetAttribute("TargetCFrame") * CFrame.new(v.Size.X / 2 * -v47, 0, 0), v46);
                    local v49 = math.clamp(#u21, 0, 8) / 2;

                    for _ = 1, 15 / math.round(v49) do
                        local v50 = u1:NextNumber(0.008, 0.016);
                        local u51 = u22:Construct(Instance, "Part");
                        u51.Anchored = true;
                        u51.CanCollide = false;
                        u51.Size = Vector3.new(v50, v50, 0.01);
                        u51.CFrame = v48 * CFrame.new(u1:NextNumber(-0.5, 0) * v47, 0, 0);
                        u51.Color = Color3.new(1, 1, 1);
                        u51.Material = Enum.Material.Neon;
                        local SpecialMesh = Instance.new("SpecialMesh");
                        SpecialMesh.MeshType = Enum.MeshType.Sphere;
                        SpecialMesh.Parent = u51;
                        u51.Parent = u28;
                        local v52 = u1:NextNumber(0.3, 1);
                        u22:Add(BoatTween:Create(u51, {
                            EasingStyle = "Quad",
                            EasingDirection = "Out",
                            StepType = "RenderStepped",
                            Time = v52,
                            Goal = {
                                Size = Vector3.new(0.0001, 0.0001, 0.0001),
                                CFrame = u51.CFrame * CFrame.new(0, u1:NextNumber(-0.3, 0.3), 0)
                            }
                        })):Play();
                        task.delay(v52 + 0.1, function() -- Line: 267
                            -- upvalues: u51 (copy)
                            u51:Destroy();
                        end);
                    end;
                end;

                task.wait();
            end;
        end);
        task.wait(0.25);
        u22:Add(BoatTween:Create(v29, {
            Time = 0.75,
            EasingStyle = "Linear",
            EasingDirection = "Out",
            StepType = "RenderStepped",
            Goal = {
                FillTransparency = 1
            }
        })):Play();

        for _, v in pairs(u34) do
            u22:Add(BoatTween:Create(v.Mesh, {
                Time = 0.75,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Scale = Vector3.new(1, 0, 1)
                }
            })):Play();
        end;

        task.wait(0.75);

        for _, v in pairs(u34) do
            u22:Add(BoatTween:Create(v.Mesh, {
                Time = 0.25,
                EasingStyle = "Circ",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    Scale = Vector3.new(0.75, 48, 1)
                }
            })):Play();
            v.Mesh.MeshType = Enum.MeshType.Sphere;
        end;

        for _ = 1, 2 do
            u22:Add(BoatTween:Create(v27, {
                Time = 0.05,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Brightness = 1
                }
            })):Play();
            u22:Add(BoatTween:Create(v29, {
                Time = 0.05,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    FillTransparency = 0,
                    FillColor = Color3.new(0, 0, 0)
                }
            })):Play();

            for _, v in pairs(v30) do
                u22:Add(BoatTween:Create(v, {
                    Time = 0.05,
                    EasingStyle = "Linear",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        FillTransparency = 0,
                        FillColor = Color3.new(255, 255, 255)
                    }
                })):Play();
            end;

            task.wait(0.05);
            u22:Add(BoatTween:Create(v27, {
                Time = 0.05,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Brightness = -1
                }
            })):Play();
            u22:Add(BoatTween:Create(v29, {
                Time = 0.05,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    FillTransparency = 0,
                    FillColor = u25
                }
            })):Play();

            for _, v in pairs(v30) do
                u22:Add(BoatTween:Create(v, {
                    Time = 0.05,
                    EasingStyle = "Linear",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        FillTransparency = 0,
                        FillColor = Color3.new(0, 0, 0)
                    }
                })):Play();
            end;

            task.wait(0.05);
        end;

        u22:Add(BoatTween:Create(v27, {
            Time = 0.1,
            EasingStyle = "Linear",
            EasingDirection = "Out",
            StepType = "RenderStepped",
            Goal = {
                Brightness = 0,
                Contrast = 0
            }
        })):Play();
        u22:Add(BoatTween:Create(v29, {
            Time = 0.1,
            EasingStyle = "Linear",
            EasingDirection = "Out",
            StepType = "RenderStepped",
            Goal = {
                FillTransparency = 1
            }
        })):Play();

        for _, v in pairs(u34) do
            u22:Add(BoatTween:Create(v, {
                Time = 0.05,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = 1
                }
            })):Play();
        end;

        for _, v in pairs(v30) do
            u22:Add(BoatTween:Create(v, {
                Time = 0.1,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    FillTransparency = 1
                }
            })):Play();
        end;

        task.wait(0.2);
    end):finallyCall(u22.Destroy, u22):catch(warn);
end;