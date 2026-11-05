  

 

local RunService = game:GetService("RunService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 10
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("TagService");
end);
local TableUtil = require(Knit.Util.TableUtil);
local Enums = require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local v2 = ReplicatedStorage["Client Assets"];
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Gadgets = require(script.Gadgets);
local CurrentCamera = workspace.CurrentCamera;
local v3 = {};
local u4 = Random.new();
local u5 = nil;
local u6 = nil;
local u7 = nil;
Knit.OnStart():andThen(function() -- Line: 36
    -- upvalues: u5 (ref), Knit (copy), u6 (ref), PathShortcuts (copy), u7 (ref)
    u5 = Knit.GetService("MoveInputService");
    u6 = Knit.GetService("EffectService");
    u7 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
local v8 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            Particle = v2.Gura.LightHit
        }
    }
};
local v9 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V2",
        "__Legacy",
        {
            AutoSerialize = true,
            Particle = v2.Gura.HeavyHit
        }
    }
};
v3["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 4,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 15, 19, "Attack" }, { 37, "End" } },
        HitRemotes = { v8 },
        HitSounds = {
            Hit = {
                SoundId = 17874176065,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 9, 16, "Attack" }, { 25, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 17874176899,
                Volume = 1
            }
        }
    },
    ["LMB-3"] = {
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB3" }, { 17, 21, "Attack" }, { 33, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 17874176433,
                Volume = 1
            }
        }
    },
    ["LMB-4"] = TableUtil.Reconcile({
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB4" }, { 23, 27, "Attack" }, { 60, "End" } },
        HitRemotes = { v9 },
        HitSounds = {
            Hit = {
                SoundId = 17874175765,
                Volume = 1
            }
        }
    }, BaseStatsModule.Rush_Attack_Finisher)
};
v3["Vault / Glide"] = {
    Active = true,
    ClientActionable = {
        Stunned = true,

        Check = function(p10) -- Line: 155, Name: Check
            if p10:GetAttribute("MoveActive") and not p10:GetAttribute("Grappling") then
                return false;
            end;

            local v11 = not p10:GetAttribute("Vaulting") and not p10:GetAttribute("Gliding");

            return v11;
        end
    },

    Invoke = function(p12) -- Line: 165, Name: Invoke
        -- upvalues: Knit (copy), PathShortcuts (copy), u5 (ref)
        Knit.GetController("MoveInputController");
        local InputTracker = require(PathShortcuts.ReplicatedStorage.ClientModules.InputTracker);
        local Character = game.Players.LocalPlayer.Character;
        local Input = p12.Input;
        local v13, v14 = unpack(p12.Arguments);

        if not v13 and Character:GetAttribute("Grappling") then
            return;
        end;

        local VaultHandler = require(script.VaultHandler);
        local GlideHandler = require(script.GlideHandler);
        local v15;

        if v13 == "ForceGlide" then
            v15 = false;
        else
            v15 = VaultHandler:DetectLedge(v13, v14) or false;
        end;

        if not v15 then
            local v16 = ((not GlideHandler:OnFloor(15) or v13 == "ForceGlide") and true or false) and GlideHandler:BeginGlide();

            if v16 then
                u5:FireInput(p12.RawInput, true, "Glide");

                while Character:IsDescendantOf(game) and (Character:GetAttribute("Gliding") and InputTracker:IsKeyDown(Input)) do
                    task.wait();
                end;

                local v17 = nil;

                if math.abs(Character.HumanoidRootPart.AssemblyLinearVelocity.Y) > 80 then
                    local v18 = GlideHandler:OnFloor(100);
                    v17 = v18 and {
                        Position = v18.Position,
                        Normal = v18.Normal
                    } or v17;
                end;

                v16:Destroy();
                u5:FireInput(p12.RawInput, false, "Glide", v17);
            end;

            return;
        end;

        u5:FireInput(p12.RawInput, true, "Vault");

        while Character:IsDescendantOf(game) and Character:GetAttribute("Vaulting") do
            task.wait();
        end;

        u5:FireInput(p12.RawInput, false, "Vault");
    end
};
v3.Grapple = {
    Active = true,
    ClientActionable = {
        Stunned = true,

        Check = function(p19) -- Line: 226, Name: Check
            local Grapple = workspace.Effects:FindFirstChild("Grapple");

            if not Grapple or p19:GetAttribute("MoveActive") and not p19:GetAttribute("Gliding") then
                return false;
            end;

            local v20 = Grapple.BillboardGui.Enabled and not p19:GetAttribute("Grappling");

            return v20;
        end
    },
    Cooldown = {
        Time = 1.5,
        CooldownReduction = false
    },

    Invoke = function(p21) -- Line: 242, Name: Invoke
        -- upvalues: Knit (copy), PathShortcuts (copy), RunService (copy), u5 (ref), CurrentCamera (copy), Trove (copy)
        Knit.GetController("CombatController");
        local u22 = Knit.GetController("MoveInputController");
        local TweenService = game:GetService("TweenService");
        local InputTracker = require(PathShortcuts.ReplicatedStorage.ClientModules.InputTracker);
        local Character = game.Players.LocalPlayer.Character;
        local _ = p21.Input;
        local Humanoid = Character:WaitForChild("Humanoid");
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local Grapple = workspace.Effects:FindFirstChild("Grapple");

        if not Grapple or Character:GetAttribute("Grappling") then
            return;
        end;

        Grapple:SetAttribute("GrappleUIFX", true);
        Character:SetAttribute("Grappling", true);
        local Position = Grapple.Position;
        local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;
        local u23 = 0.25 + Magnitude / 250;
        local v24 = os.clock() + u23;
        local u25 = Magnitude / 200;
        local u26 = true;
        Humanoid.AutoRotate = false;
        local v27 = TweenService:Create(Grapple.BillboardGui.ImageLabel, TweenInfo.new(u23 - 0.25), {
            Size = UDim2.new(0, 0, 0, 0)
        });
        v27.Completed:Connect(function() -- Line: 277
            -- upvalues: Grapple (copy), RunService (ref)
            Grapple:SetAttribute("GrappleUIFX", false);
            RunService.RenderStepped:Wait();
            Grapple.BillboardGui.ImageLabel.Size = UDim2.new(1, 0, 1, 0);
        end);
        v27:Play();
        u5:FireInput(p21.RawInput, Position, Magnitude, v24, u23, u25);
        local u28 = true;
        task.delay(u23 - 0.25, function() -- Line: 288
            -- upvalues: u26 (ref), Character (copy), TweenService (copy), CurrentCamera (ref), u23 (copy), u25 (copy), HumanoidRootPart (copy), Position (copy), Grapple (copy), u28 (ref)
            u26 = false;

            if Character:GetAttribute("Gliding") then
                require(script.GlideHandler):Destroy();
            end;

            TweenService:Create(CurrentCamera, TweenInfo.new((u23 + u25 - 0.25) / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, true), {
                FieldOfView = CurrentCamera.FieldOfView + 45
            }):Play();
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, Position);
            Grapple.Orientation = HumanoidRootPart.Orientation * Vector3.new(0, 1, 1);
            local v29 = -1.5;

            if Grapple.RayNormal.Value then
                local v30 = Grapple.RayNormal.Value:Dot(Vector3.new(0, 1, 0));

                if math.abs(v30) > 0.75 then
                    u28 = false;
                    v29 = 2.5;
                end;
            end;

            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.Size = Vector3.new(1, 1, 1);
            Part.CFrame = HumanoidRootPart.CFrame;
            Part.CanQuery = false;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.Transparency = 1;
            Part.Parent = workspace.Effects;
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = Part;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Parent = HumanoidRootPart;
            local AlignPosition = Instance.new("AlignPosition");
            AlignPosition.ApplyAtCenterOfMass = true;
            AlignPosition.Responsiveness = 200;
            AlignPosition.MaxForce = 1000000;
            AlignPosition.Attachment0 = Attachment2;
            AlignPosition.Attachment1 = Attachment;
            AlignPosition.Parent = Attachment2;
            local AlignOrientation = Instance.new("AlignOrientation");
            AlignOrientation.RigidityEnabled = true;
            AlignOrientation.MaxTorque = 1000000;
            AlignOrientation.Attachment0 = Attachment2;
            AlignOrientation.Attachment1 = Attachment;
            AlignOrientation.Parent = Attachment2;
            local v31 = TweenService:Create(Part, TweenInfo.new(u25, Enum.EasingStyle.Linear), {
                CFrame = Grapple.CFrame * CFrame.new(0, v29, 1)
            });
            v31:Play();
            v31.Completed:Connect(function() -- Line: 351
                -- upvalues: Part (copy), Attachment2 (copy)
                Part:Destroy();
                Attachment2:Destroy();
            end);
        end);
        local CFrame2 = Grapple.CFrame;

        while os.clock() < v24 + u25 - 0.25 or not Character:IsDescendantOf(game) do
            if u26 then
                HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + (CFrame2.Position - HumanoidRootPart.Position).Unit * Vector3.new(1, 0, 1));
            end;

            task.wait();
        end;

        if Character:IsDescendantOf(game) then
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
            Humanoid:ChangeState(Enum.HumanoidStateType.Freefall);
            Humanoid.AutoRotate = true;
            HumanoidRootPart.Anchored = false;
            local Keybind = u22:GetEquippedMoves()["Vault / Glide"].Keybind;
            local u33 = string.gsub(string.lower(Keybind), "^%l", function(p32) -- Line: 379
                return string.upper(p32);
            end);
            Character:FindFirstChild("Grapple Followup", true):Play();

            if InputTracker:IsKeyDown(u33) then
                if not u28 then
                    return;
                end;

                require(PathShortcuts.ReplicatedModules.AnimationHandler).Get(Humanoid.Animator):PlayAnimation("Glide Vault");
                HumanoidRootPart.CFrame = CFrame2 * CFrame.new(0, 3, 2);
                Humanoid.AutoRotate = false;
                local v34 = Trove.new();
                v34:AttachToInstance(Character);
                local u35 = v34:Construct(Instance, "BodyVelocity");
                u35.MaxForce = Vector3.new(1000000, 1000000, 1000000);
                u35.Parent = HumanoidRootPart;
                v34:Connect(RunService.RenderStepped, function(p36) -- Line: 412
                    -- upvalues: HumanoidRootPart (copy), CurrentCamera (ref), u35 (copy)
                    HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position, HumanoidRootPart.Position + CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1));
                    u35.Velocity = HumanoidRootPart.CFrame.LookVector * 125 + HumanoidRootPart.CFrame.UpVector * 80;
                end);
                v34:Add(function() -- Line: 417
                    -- upvalues: Character (copy), u22 (copy), u33 (copy)
                    if Character:IsDescendantOf(game) then
                        u22:FireInput(u33, "ForceGlide");
                    end;
                end);
                task.delay(0.35, v34.Destroy, v34);
            else
                u22:FireInput(u33, {
                    Position = Grapple.RayPosition.Value,
                    Normal = Grapple.RayNormal.Value,
                    Instance = Grapple.RayInstance.Value
                }, true);
            end;
        end;
    end
};
v3["Utility Belt"] = {
    Active = true,
    ClientActionable = {
        Active = true,
        Stunned = false
    },

    Invoke = function(p37) -- Line: 457, Name: Invoke
        -- upvalues: PathShortcuts (copy), Gadgets (copy), u4 (copy), CurrentCamera (copy)
        local TweenService = game:GetService("TweenService");
        local UserInputService = game:GetService("UserInputService");
        local InputTracker = require(PathShortcuts.ReplicatedStorage.ClientModules.InputTracker);
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local Input = p37.Input;
        local BlurEffect = Instance.new("BlurEffect");
        BlurEffect.Size = 0;
        BlurEffect.Parent = game.Lighting;
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Parent = game.Lighting;
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Brightness = -0.15,
            Contrast = 1,
            Saturation = -0.5,
            TintColor = Color3.fromRGB(122, 162, 179)
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.35), {
            Size = 14
        }):Play();
        local ClientUIOutput = PathShortcuts.RemotesPath:WaitForChild("ClientUIOutput");
        ClientUIOutput:Fire("PlaySound", "utility_belt_activate");
        ClientUIOutput:Fire("PlayDirectSound", "utility_belt_ambience");
        local v38 = Gadgets:GetUIElement("SelectScreen"):Clone();
        v38.Parent = LocalPlayer:WaitForChild("PlayerGui");
        local ImageTransparency = v38.Vignette.ImageTransparency;
        v38.Vignette.ImageTransparency = 1;
        TweenService:Create(v38.Vignette, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ImageTransparency = ImageTransparency
        }):Play();
        local Frame = v38.Frame;
        local v39 = {};

        for _, child in Frame:GetChildren() do
            if child:IsA("ImageLabel") and child.Name ~= "Hologram" then
                local Size = child.Size;
                local ImageTransparency2 = child.ImageTransparency;
                child.Size = UDim2.new(0, 0, 0, 0);
                child.ImageTransparency = 1;
                TweenService:Create(child, TweenInfo.new(u4:NextNumber(0.2, 0.3), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Size = Size,
                    ImageTransparency = ImageTransparency2
                }):Play();

                if child.Name ~= "Grid" and child.Name ~= "MouseSelect" then
                    v39[child] = {
                        Speed = u4:NextNumber(0.28, 0.57) * (math.random(1, 2) == 1 and -1 or 1),
                        OriginalSize = Size,
                        Noise = {
                            X1 = math.random() * 10000,
                            Y1 = math.random() * 10000,
                            X2 = math.random() * 10000,
                            Y2 = math.random() * 10000
                        }
                    };
                end;
            end;
        end;

        TweenService:Create(CurrentCamera, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = 80
        }):Play();
        local v40 = Frame.AbsoluteSize.Y * 0.57;
        local u41 = #Gadgets.Avaliable;
        local v42 = 360 / u41;

        for i = 1, u41 do
            local v43 = Gadgets.Avaliable[i];
            local v44 = Gadgets:GetUIElement("IconTemplate"):Clone();
            v44.Position = UDim2.fromScale(0.5, 0.5);
            v44.Image = v43.ImageId;
            v44:SetAttribute("Gadget", v43.Name);
            v44.Name = "Gadget" .. i;
            v44.ImageTransparency = 1;
            v44.Parent = Frame;
            local v45 = math.rad((i + 1) * v42);
            TweenService:Create(v44, TweenInfo.new(0.35), {
                ImageTransparency = 0.65,
                Position = v44.Position + UDim2.fromOffset(v40 * math.cos(v45), v40 * math.sin(v45))
            }):Play();
        end;

        local Position = Frame.Grid.Position;
        local v46 = math.random();
        local v47 = math.random();
        local v48 = math.random();
        local v49 = math.random();
        local _ = Frame.AbsoluteSize.Y / 2;
        local u50 = Frame.AbsolutePosition + Frame.AbsoluteSize / 2;

        local function GetTheta() -- Line: 571
            -- upvalues: UserInputService (copy), u50 (copy)
            local Unit = (UserInputService:GetMouseLocation() - Vector2.new(0, 36) - u50).Unit;
            local v51 = math.acos(Unit.X);
            local v52 = math.deg(v51);

            if math.sign(Unit.Y) == 1 then
                v52 = 360 - v52;
            end;

            return v52;
        end;

        local v53 = 0;

        local function PickIndex(p54) -- Line: 594
            -- upvalues: u41 (copy), Frame (copy), UserInputService (copy)
            if u41 <= 0 then
                return false;
            end;

            local v55 = 1000000;
            local v56 = nil;

            for i = 1, u41 do
                local Magnitude = (Frame["Gadget" .. i].AbsolutePosition - (UserInputService:GetMouseLocation() + Vector2.new(0, -36))).Magnitude;

                if Magnitude < v55 then
                    v56 = i;
                    v55 = Magnitude;
                end;
            end;

            return v56, v55;
        end;

        local v57 = nil;

        while Character and (Character:IsDescendantOf(game) and InputTracker:IsKeyDown(Input)) do
            local v58 = task.wait();
            v53 = v53 + v58 * 0.5;

            for i, v in v39 do
                local Speed = v.Speed;
                local Noise = v.Noise;
                local v59 = UDim2.fromScale(math.noise(Noise.X1, Noise.Y1, v53) * 0.075, math.noise(Noise.X2, Noise.Y2, v53) * 0.075);
                i.Size = v.OriginalSize + v59;
                i.Rotation = i.Rotation + Speed * v58 * 60;
            end;

            local v60 = UDim2.fromScale(math.noise(v46, v47, v53) * 0.085, math.noise(v48, v49, v53) * 0.085);
            Frame.Grid.Position = Position + v60;
            local Unit = (UserInputService:GetMouseLocation() - Vector2.new(0, 36) - u50).Unit;
            local v61 = math.acos(Unit.X);
            local v62 = math.deg(v61);

            if math.sign(Unit.Y) == 1 then
                v62 = 360 - v62;
            end;

            local v63;

            if v62 then
                v63 = PickIndex(v62);

                if not v63 then
                    return;
                end;

                local v64 = Frame["Gadget" .. v63];
                v64.ImageTransparency = 0;
                v64.Size = UDim2.fromScale(0.15, 0.15);

                if v57 ~= v63 then
                    ClientUIOutput:Fire("PlaySound", "utility_belt_select");

                    if v57 ~= nil then
                        local v65 = Frame["Gadget" .. v57];
                        v65.ImageTransparency = 0.65;
                        v65.Size = UDim2.fromScale(0.1, 0.1);
                    end;

                    local v66 = v64:GetAttribute("Gadget");
                    local v67 = Gadgets:GetGadgetData(v66);

                    if v67 then
                        Character:SetAttribute("SelectedGadget", v66);

                        for _, v in { "TitleShadow", "GadgetName", "GadgetDescription", "Hologram" } do
                            local v68 = Frame[v];
                            v68.Visible = true;
                            local v69 = {
                                TextTransparency = 0,
                                BackgroundTransparency = v == "TitleShadow" and 0 or 1,
                                TextStrokeTransparency = v == "GadgetDescription" and 0.5 or 0
                            };

                            if v == "Hologram" then
                                v68.ImageTransparency = 1;

                                for i, v4 in v67.Data.Hologram do
                                    v68[i] = v4;
                                end;

                                v69 = {
                                    ImageTransparency = 0
                                };
                            else
                                v68.BackgroundTransparency = 1;
                                v68.TextTransparency = 1;
                                v68.TextStrokeTransparency = 1;
                            end;

                            TweenService:Create(v68, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v69):Play();
                        end;

                        Frame.GadgetName.Text = v66;
                        Frame.GadgetDescription.Text = v67.Data.Description;
                    end;
                end;
            else
                v63 = v57;
            end;

            v57 = v63;
        end;

        ClientUIOutput:Fire("PlaySound", "utility_belt_deactivate");
        ClientUIOutput:Fire("StopDirectSound", "utility_belt_ambience");
        TweenService:Create(v38.Vignette, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        }):Play();
        TweenService:Create(CurrentCamera, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FieldOfView = LocalPlayer.Settings.FieldOfView.Value
        }):Play();
        local v70 = TweenService:Create(BlurEffect, TweenInfo.new(0.35), {
            Size = 0
        });
        v70.Completed:Connect(function() -- Line: 729
            -- upvalues: BlurEffect (copy)
            BlurEffect:Destroy();
        end);
        v70:Play();
        local v71 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            Brightness = 0,
            Contrast = 0,
            Saturation = 0,
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v71.Completed:Connect(function() -- Line: 740
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
        v71:Play();

        for _, child in Frame:GetChildren() do
            if child:IsA("ImageLabel") then
                local v72 = {
                    ImageTransparency = 1,
                    Size = UDim2.new(0, 0, 0, 0)
                };

                if child:GetAttribute("Gadget") then
                    v72.Position = UDim2.fromScale(0.5, 0.5);
                end;

                TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), v72):Play();
            elseif child:IsA("TextLabel") then
                TweenService:Create(child, TweenInfo.new(0.08, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
                    BackgroundTransparency = 1,
                    TextStrokeTransparency = 1,
                    TextTransparency = 1
                }):Play();
            end;
        end;

        task.delay(1, v38.Destroy, v38);
    end
};
v3["Gadget Usage"] = {
    Active = true,
    ClientActionable = {
        Active = true,

        Check = function(p73) -- Line: 772, Name: Check
            -- upvalues: PathShortcuts (copy)
            local v74 = game.Players:GetPlayerFromCharacter(p73);

            if not p73:GetAttribute("SelectedGadget") and v74 then
                PathShortcuts.RemotesPath:WaitForChild("ClientUIOutput"):Fire(
                    "CreateMiddleNotification",
                    {
                        NumericalContent = -1,
                        NumericalSuffix = "The Dark Knight",
                        Verb = "",
                        Subject = "You need to select a Gadget from your utility belt first"
                    }
                );
            end;

            return p73:GetAttribute("SelectedGadget") ~= nil;
        end
    },
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 1,
        AfterMove = true
    },

    Invoke = function(p75) -- Line: 800, Name: Invoke
        -- upvalues: Gadgets (copy), u5 (ref)
        local _ = p75.Input;
        local v76 = game.Players.LocalPlayer.Character:GetAttribute("SelectedGadget");
        local v77;

        if v76 then
            v77 = Gadgets:GetGadgetData(v76);
        else
            v77 = v76;
        end;

        if v77 then
            u5:FireInput(p75.RawInput, v76);
        end;
    end
};
v3.Block = {
    From = "Combat.Block"
};
v3.Quickstep = {
    From = "Combat.Quickstep"
};
v3.Pose = {
    From = "Combat.Pose"
};
v3.Grab = {
    From = "Combat.Grab",
    Grab = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
            } }
    },
    Throw = {
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
            } }
    }
};
v3.Batmobile = {
    Active = true,
    Actionable = {
        Active = true
    },
    Explode = {
        Damage = 35,
        Stun = {
            Time = 0.3
        },
        Hitbox = {
            Type = "Region3",
            Size = Vector3.new(20, 20, 20),
            Debug = true,
            Origin = CFrame.new(),
            Offset = CFrame.new(0, 0, 0)
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Target",
            Speed = 60,
            Time = 0.2,
            Override = true,
            Velocity = Vector3.new(0, 50, 0)
        }
    }
};
v3.Batwing = {
    Active = true,
    Actionable = {
        Active = true
    }
};
v3["Shock Gloves"] = {
    Active = true,
    Damage = 15,
    Priority = Enums.Intangible.Grab,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 6,
        AfterMove = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(8, 8, 8),
        HitboxType = "ClientHitbox",
        Debug = false,
        Offset = CFrame.new(0, 0, -4)
    },
    Stun = {
        Time = 1,
        Priority = Enums.Stun.Medium
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false
    },
    HitRemotes = { {
            Name = "Output",
            Arguments = { "FX", "HitEffect V3", {
                    Attacker = "__Attacker",
                    Target = "__Target",
                    Path = "Particles/Shock",
                    AutoSerialize = true,
                    LookAt = "Attacker"
                } }
        } },
    FinalPunch = {
        Damage = 35,
        Block = {
            Blockable = false,
            PerfectBlockable = false
        },
        Ragdoll = {
            Time = 1
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 60,
            Time = 0.1
        }
    }
};

return {
    Stats = v3,
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Grapple = {
                DefaultKeybind = "E",
                Equipped = true
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            ["Vault / Glide"] = {
                DefaultKeybind = "Space",
                Equipped = true,
                IndicatorInfo = {
                    Input = "^"
                }
            },
            ["Shock Gloves"] = {
                DefaultKeybind = "R",
                Equipped = true
            },
            ["Utility Belt"] = {
                DefaultKeybind = "Y",
                Equipped = true
            },
            ["Gadget Usage"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Batmobile = {
                DefaultKeybind = "G",
                Equipped = true
            },
            Batwing = {
                DefaultKeybind = "H",
                Equipped = true
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 13390676738,
            ["LMB-2"] = 13390679117,
            ["LMB-3"] = 13390682925,
            ["LMB-4"] = 13390686490,
            ["Grapple Loop"] = 80354423248108,
            ["Grapple Start"] = 111197048021419,
            ["Glide Vault"] = 114861216716827,
            GadgetWindup = 11904779163,
            GadgetHold = 11904781751,
            GadgetThrow = 11904783238,
            BatrangStartup = 102623391449561,
            BatrangHold = 93486873379080,
            ["Shock Gloves Startup"] = 71983339271167,
            ["Shock Gloves Attacker"] = 73644219587369,
            ["Shock Gloves Victim"] = 73885386643046
        },
        Movement = {
            Walk = 103113696939057,
            Run = 10914799131,
            Fall = 81883014978692,
            Jump = 88124332911725
        },
        Idle = {
            Idle = 138890437451116
        }
    },
    Sounds = {
        ["Grapple Air Boost"] = {
            SoundId = 137116671056536,
            Volume = 1
        },
        ["Grapple Fire"] = {
            SoundId = 114454718674226,
            Volume = 1
        },
        ["Grapple Followup"] = {
            SoundId = 112688186312733,
            Volume = 1
        },
        ["Grapple Wall Contact"] = {
            SoundId = 78013152299246,
            Volume = 1
        },
        ["Grapple Loop"] = {
            SoundId = 94106315256308,
            Volume = 1,
            Looped = true
        },
        ["Utility Belt Activation"] = {
            SoundId = 131973380325550,
            Volume = 1
        },
        ["Utility Belt Deactivation"] = {
            SoundId = 106882545603016,
            Volume = 1
        },
        ["Utility Belt Hover"] = {
            SoundId = 98606053438984,
            Volume = 1
        },
        ["Utility Belt Ambience"] = {
            SoundId = 96776405474327,
            Volume = 1,
            Looped = true
        },
        ["Freeze Blast Held 1"] = {
            SoundId = 72204641901719,
            Volume = 1,
            Looped = true
        },
        ["Freeze Blast Held 2"] = {
            SoundId = 80056681144648,
            Volume = 1,
            Looped = true
        },
        ["Freeze Blast Throw"] = {
            SoundId = 111636275971868,
            Volume = 1
        },
        ["Freeze Blast Startup"] = {
            SoundId = 109425576115907,
            Volume = 1
        },
        ["Freeze Blast Explosion"] = {
            SoundId = 121306180662745,
            Volume = 1
        },
        ["Glide Ambience"] = {
            SoundId = 94502514471566,
            Volume = 0.5,
            Looped = true
        },
        ["Dive Ambience"] = {
            SoundId = 94985921856196,
            Volume = 2,
            Looped = true
        },
        ["Glide Cape Trigger"] = {
            SoundId = 76473184972502,
            Volume = 1
        },
        ["Glide Startup"] = {
            SoundId = 102612282221765,
            Volume = 1
        }
    }
};