  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
game.ReplicatedStorage:WaitForChild("Client Assets");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local Trove = require(PathShortcuts.ReplicatedModules.KnitPackage.Trove);
local v1 = script:FindFirstAncestor("ReplicatedModules");
local EffectsHandler = require(v1.EffectsHandler);
local UserInputService = game:GetService("UserInputService");
local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u2 = {};

return function(p3) -- Line: 17
    -- upvalues: ParticleHandler (copy), Trove (copy), UserInputService (copy), TweenService (copy), u2 (copy), CollectionService (copy), RunService (copy), EffectsHandler (copy), PathShortcuts (copy)
    local Character = p3.Character;
    local Toggling = p3.Toggling;
    local PrimaryColor = p3.PrimaryColor;
    local SecondaryColor = p3.SecondaryColor;
    local BPM = p3.BPM;
    local CustomBallReference = p3.CustomBallReference;
    local CustomParticleName = p3.CustomParticleName;
    local VisualizerIntensity = p3.VisualizerIntensity;
    local v4 = Character:FindFirstChildOfClass("Humanoid");
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and v4) then
        return;
    end;

    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer and (LocalPlayer:FindFirstChild("Data") and (LocalPlayer.Data:FindFirstChild("Skin") and LocalPlayer.Data.Skin:GetAttribute("UnusualHueId"))) then
        local v5 = LocalPlayer.Data.Skin:GetAttribute("UnusualHueId") * 5;
        PrimaryColor = ParticleHandler.HSVShift(PrimaryColor, {
            HueShift = v5
        });
        SecondaryColor = ParticleHandler.HSVShift(SecondaryColor, {
            HueShift = v5
        });
    end;

    if Toggling and game.Players.LocalPlayer.Settings.ExtraProps.Value == true then
        local u6 = Trove.new();

        if not UserInputService.TouchEnabled then
            local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui");
            local UI = PlayerGui:WaitForChild("UI");
            UI.Enabled = false;
            local u7 = false;
            u6:Add(UI:WaitForChild("Menus").Changed:Connect(function(p8) -- Line: 59
                -- upvalues: u7 (ref), UI (copy)
                print(p8, u7);

                if p8 == "Visible" and (u7 and not UI.Menus.Visible) then
                    UI.Enabled = false;
                    u7 = false;
                end;
            end));
            u6:Add(UserInputService.InputBegan:Connect(function(p9, p10) -- Line: 69
                -- upvalues: u7 (ref), UI (copy)
                if p10 then
                    return;
                end;

                if p9.KeyCode.Name == "M" then
                    u7 = not u7;
                    UI.Enabled = not UI.Enabled;
                end;
            end));
            local CinematicBlackBars = PlayerGui:FindFirstChild("CinematicBlackBars");
            CinematicBlackBars.Enabled = true;
            CinematicBlackBars.Upper.Position = UDim2.fromScale(0.5, -1.1);
            CinematicBlackBars.Lower.Position = UDim2.fromScale(0.5, 1.1);
            TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut), {
                Position = UDim2.fromScale(0.5, -0.9)
            }):Play();
            TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, false, 0.25), {
                Position = UDim2.fromScale(0.5, 0.9)
            }):Play();
            u6:Add(function() -- Line: 88
                -- upvalues: TweenService (ref), CinematicBlackBars (copy)
                TweenService:Create(CinematicBlackBars.Upper, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, -1.1)
                }):Play();
                TweenService:Create(CinematicBlackBars.Lower, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Position = UDim2.fromScale(0.5, 1.1)
                }):Play();
                task.delay(0.5, function() -- Line: 92
                    -- upvalues: CinematicBlackBars (ref)
                    CinematicBlackBars.Enabled = false;
                end);
            end);
            u6:Add(function() -- Line: 97
                -- upvalues: UI (copy)
                UI.Enabled = true;
            end);
        end;

        local u11 = u6:Add(Instance.new("Model", workspace.Effects));
        u11.Name = "Pose";
        u2[Character] = u11;
        u6:Add(function() -- Line: 106
            -- upvalues: u2 (ref), Character (copy), u11 (copy)
            if u2[Character] == u11 then
                u2[Character] = nil;
            end;
        end);
        local u12 = {};
        local u13 = {};

        for i = 1, 360, 4 do
            local Part = Instance.new("Part");
            Part.Size = Vector3.new(0.1, 1, 0.1);
            Part.CFrame = HumanoidRootPart.CFrame;
            Part.Material = Enum.Material.Neon;
            Part.Color = PrimaryColor or Color3.fromRGB(11, 125, 248);
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CastShadow = false;
            local SpecialMesh = Instance.new("SpecialMesh");
            SpecialMesh.MeshType = Enum.MeshType.Brick;
            SpecialMesh.Scale = Vector3.new(1, 1, 1);
            SpecialMesh.Parent = Part;
            Part.Parent = u11;
            u12[i] = { Part, SpecialMesh };
        end;

        local u14 = nil;

        if not u14 then
            u14 = Character.Stand.StandHumanoidRootPart.PoseMusic;

            if Character.Stand.StandHumanoidRootPart:FindFirstChild("StandOffPoseMusic") and not CollectionService:HasTag(Character, "Summoned") then
                u14 = Character.Stand.StandHumanoidRootPart:FindFirstChild("StandOffPoseMusic");
            end;
        end;

        u6:Add((RunService.Heartbeat:Connect(function() -- Line: 144
            -- upvalues: u14 (ref), Character (copy)
            if u14 and not u14.IsPlaying then
                for _, child in pairs(Character.Stand.StandHumanoidRootPart:GetChildren()) do
                    if child:IsA("Sound") and (child ~= u14 and (string.find(child.Name, "PoseMusic") or string.find(child.Name, "StandOffPoseMusic"))) and child.IsPlaying then
                        u14 = child;

                        return;
                    end;
                end;
            end;
        end)));
        local u15 = 1;
        local u16 = nil;
        local u17 = u6:Add(Instance.new("Highlight"));
        u17.DepthMode = Enum.HighlightDepthMode.Occluded;
        u17.OutlineColor = PrimaryColor or Color3.new(0.435294, 0.878431, 1);
        u17.FillColor = PrimaryColor or Color3.new(0.435294, 0.878431, 1);
        u17.FillTransparency = 0.9;
        u17.OutlineTransparency = 0;
        u17.Parent = u11;
        u17.Adornee = Character;
        local u18;

        if CustomBallReference then
            u18 = CustomBallReference:Clone();
        else
            u18 = Instance.new("Part");
            u18.Shape = Enum.PartType.Ball;
        end;

        u18.Size = Vector3.new(0, 0, 0);
        u18.CFrame = HumanoidRootPart.CFrame;
        u18.Anchored = true;
        u18.CanCollide = false;
        u18.Material = Enum.Material.ForceField;
        u18.Color = PrimaryColor or Color3.new(0.435294, 0.878431, 1);
        u18.Parent = u11;
        u18.CastShadow = false;
        local u19 = u18:Clone();
        u19.Transparency = 0.5;
        u19.Color = SecondaryColor or (PrimaryColor or Color3.new(0.435294, 0.878431, 1));
        u19.Parent = u11;
        local Model = Instance.new("Model", u11);
        math.floor(60 / (BPM / 60));
        local u20 = 1 / (BPM / 60);
        task.spawn(function() -- Line: 200
            -- upvalues: u2 (ref), Character (copy), u11 (copy), u17 (copy), TweenService (ref), u20 (copy)
            while u2[Character] == u11 do
                u17.OutlineTransparency = 0;
                TweenService:Create(u17, TweenInfo.new(u20, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    OutlineTransparency = 1
                }):Play();
                task.wait(u20);
            end;
        end);
        u6:Add(RunService.RenderStepped:Connect(function(p21) -- Line: 208
            -- upvalues: Character (copy), u6 (copy), u2 (ref), u11 (copy), u14 (ref), HumanoidRootPart (copy), u15 (ref), VisualizerIntensity (copy), u16 (ref), u18 (ref), u19 (copy), u17 (copy), Model (copy), EffectsHandler (ref), CustomParticleName (copy), PathShortcuts (ref), PrimaryColor (ref), SecondaryColor (ref), TweenService (ref), u12 (copy), u13 (copy)
            if not (Character and Character:IsDescendantOf(workspace)) then
                u6:Destroy();

                return;
            end;

            if u2[Character] ~= u11 then
                u6:Destroy();

                return;
            end;

            if game.Players.LocalPlayer.Settings.ExtraProps.Value ~= true then
                u6:Destroy();

                return;
            end;

            if not (u14 and (u14:IsA("Sound") and u14.Parent)) then
                u6:Destroy();

                return;
            end;

            local v22 = u14.TimePosition / u14.TimeLength;
            u11:GetChildren();
            local v23 = u14.PlaybackLoudness / 2;
            local v24 = 25 / (workspace.CurrentCamera.CFrame.p - HumanoidRootPart.CFrame.p).Magnitude;
            u15 = u15 + (1 + v23 / 360 - u15) * math.clamp(p21 * 10, 0, 1);
            u15 = u15 * VisualizerIntensity;
            u16 = math.clamp(u15 - 1.5, 0, 1) * 8;
            workspace.CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value + u16 * 5 * v24;
            u18.CFrame = HumanoidRootPart.CFrame;
            u19.CFrame = HumanoidRootPart.CFrame;
            local v25 = u19.Size:Lerp(Vector3.new(0, 0, 0), p21 * 0.65);
            local v26 = Vector3.new(1, 1, 1) * u16 * 6 * v24;

            if v26.Magnitude > v25.Magnitude then
                v25 = v26;
            end;

            local OutlineTransparency = u17.OutlineTransparency;
            u19.Size = v25;
            u18.Size = v26;

            for _, child in pairs(Model:GetChildren()) do
                for _, child2 in pairs(child.Attachment:GetChildren()) do
                    child2.TimeScale = (u15 - 0.9) / 1.7 - 0.3 - 0.01 * OutlineTransparency ^ 4;
                    child2.Transparency = NumberSequence.new(OutlineTransparency);
                end;
            end;

            if u15 > 1.75 and not u11:FindFirstChild("FloorRippleGrid") then
                EffectsHandler.GetEffect("ChronoWarden_Ripple")(Character, {
                    GridSize = 26,
                    CellSize = 1.85,
                    EffectParent = u11,
                    Resonance = u15 ^ 2 / 5 + 20
                });
            end;

            if u15 > 1.7 then
                local u27 = (PathShortcuts.ClientAssets["P//S_R"]:FindFirstChild(CustomParticleName or "PoseParticle") or PathShortcuts.ClientAssets["P//S_R"]:FindFirstChild("PoseParticle")):Clone();
                u27.CFrame = HumanoidRootPart.CFrame;
                u27.Parent = Model;
                task.delay(2, function() -- Line: 271
                    -- upvalues: u27 (ref)
                    u27:Destroy();
                end);

                for _, child in pairs(u27.Attachment:GetChildren()) do
                    local v28 = math.random(0, 1) == 1 and PrimaryColor or SecondaryColor;
                    child.Color = ColorSequence.new(v28);
                    child:Emit(1);
                end;
            end;

            if u15 > 1.5 then
                local Part = Instance.new("Part");
                Part.Shape = Enum.PartType.Ball;
                Part.Material = Enum.Material.Neon;
                Part.Transparency = 0.6;
                Part.Color = PrimaryColor or Color3.new(0.678431, 0.160784, 1);

                if math.random(0, 1) == 1 then
                    Part.Color = SecondaryColor or Color3.new(1, 1, 1);
                end;

                Part.Size = Vector3.new(3, 3, 3) * (u15 / 1.7);
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanTouch = false;
                Part.CanQuery = false;
                Part.CastShadow = false;
                Part.CFrame = HumanoidRootPart.CFrame * CFrame.new(math.random(-10, 10), math.random(0, 5), math.random(-10, 10));
                Part.Parent = u11;
                TweenService:Create(Part, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                    Transparency = 1,
                    Size = Vector3.new(0, 0, 0)
                }):Play();
                game.Debris:AddItem(Part, 0.6);
            end;

            local CFrame2 = HumanoidRootPart.CFrame;
            local Position = (CFrame.Angles(0, math.rad(v23), 0) * CFrame.new(0, 0, u15 * -6)).Position;

            for i, v in pairs(u12) do
                local v29 = v[1];
                local v30 = v[2];

                if not u13[v29] then
                    u13[v29] = 0;
                end;

                local v31 = u13;
                v31[v29] = v31[v29] + (0 - u13[v29]) * math.clamp(p21 * 5, 0, 1);
                local v32 = CFrame.Angles(0, math.rad(i), 0) * CFrame.new(0, 0, u15 * -6);
                local v33 = u13;
                v33[v29] = v33[v29] + (10 / ((v32.Position - Position).Magnitude * 8 + 1) - u13[v29]) * math.clamp(p21 * 10, 0, 1);
                local v34 = Vector3.new(1, 1.5 * u13[v29], 1);
                v30.Scale = v34;
                v29.CFrame = CFrame2 * v32 * CFrame.new(0, v34.Y * 0.5, 0) * CFrame.new(0, OutlineTransparency * 0.8 * v22, 0);
                local v35 = math.abs(i - 180);
                v29.Color = (SecondaryColor or Color3.new(1, 1, 1)):Lerp(PrimaryColor or Color3.new(0.678431, 0.160784, 1), v35 / 180);
            end;
        end));
    else
        local v36 = u2[Character];

        if v36 then
            v36.Name = "Pose Off";
            v36:Destroy();
            u2[Character] = nil;
            workspace.CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value;
        end;
    end;
end;