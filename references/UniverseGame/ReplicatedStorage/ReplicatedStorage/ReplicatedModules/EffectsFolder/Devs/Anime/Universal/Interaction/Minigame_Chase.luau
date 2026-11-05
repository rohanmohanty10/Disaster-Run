  

 

local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ClientAssets = PathShortcuts.ClientAssets;
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u1 = Random.new();
local u2 = CFrame.new(0, 12, 16);
local u3 = NumberRange.new(140, 160);
local u4 = { { 13, 20, { "Person" } }, { 25, 29, { "Person" } }, { 39.5, 50, { "Laser" } } };
local u5 = { 110231579, 4217348366, 696133166, 186015418, 1628637263, 2224298089, 137157364 };
local u6 = { 7063945703, 10181005270, 10384315127, 136450544611316 };
local u7 = {
    [Enum.UserInputType.MouseMovement] = 0.1,
    [Enum.UserInputType.Touch] = 0.18
};

return function(p8) -- Line: 62
    -- upvalues: LocalPlayer (copy), Trove (copy), Lighting (copy), EffectsHandler (copy), TweenService (copy), AnimationHandler (copy), CurrentCamera (copy), UserInputService (copy), u4 (copy), u1 (copy), u6 (copy), Players (copy), u5 (copy), u3 (copy), ClientAssets (copy), u7 (copy), RunService (copy), u2 (copy)
    local v9 = p8 or {};
    local u10 = v9.Character or LocalPlayer.Character;
    local HumanoidRootPart = u10.HumanoidRootPart;
    local Remote = v9.Remote;
    local CurvedPath = workspace:WaitForChild("CurvedPath");
    local u11 = workspace:WaitForChild("UGrain Chase");
    local Obstacles = script:WaitForChild("Obstacles");
    u11.Nodes.ModelStreamingMode = Enum.ModelStreamingMode.Persistent;
    local u12 = Trove.new();
    u12:AttachToInstance(u10);
    CurvedPath:ScaleTo(1);
    u12:Add(function() -- Line: 79
        -- upvalues: CurvedPath (copy)
        CurvedPath:ScaleTo(0.001);
    end);
    local u13 = false;
    local u14 = true;
    local u15 = false;
    local u16 = false;
    local v17 = u12:Add(Instance.new("ScreenGui"));
    v17.ResetOnSpawn = false;
    v17.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v17.Parent = LocalPlayer.PlayerGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Parent = v17;
    local u18 = u12:Add(Instance.new("ColorCorrectionEffect"));
    u18.Enabled = false;
    u18.Parent = Lighting;

    local function TypeText(p19, p20) -- Line: 130
        -- upvalues: EffectsHandler (ref)
        p19.MaxVisibleGraphemes = 0;
        p19.TextTransparency = 0;
        local v21 = utf8.len(p19.Text);

        for i = 1, v21 do
            if not p19.Parent then
                break;
            end;

            p19.MaxVisibleGraphemes = i;
            EffectsHandler.Wait(p20 / v21);
        end;
    end;

    local function FadeLabel(p22, p23, p24, p25) -- Line: 141
        -- upvalues: TypeText (copy), EffectsHandler (ref), TweenService (ref)
        TypeText(p22, p23);
        EffectsHandler.Wait(p24);
        TweenService:Create(p22, TweenInfo.new(p25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1
        }):Play();
        EffectsHandler.Wait(p25);
    end;

    local function EndChase(p26) -- Line: 148
        -- upvalues: u16 (ref), LocalPlayer (ref), TweenService (ref), EffectsHandler (ref), u12 (copy)
        if u16 then
            return;
        end;

        u16 = true;
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.Name = "ChaseFade";
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.DisplayOrder = 100;
        ScreenGui.ResetOnSpawn = false;
        ScreenGui.Parent = LocalPlayer.PlayerGui;
        local Frame2 = Instance.new("Frame");
        Frame2.Size = UDim2.fromScale(1, 1);
        Frame2.BackgroundColor3 = Color3.new(0, 0, 0);
        Frame2.BackgroundTransparency = 1;
        Frame2.BorderSizePixel = 0;
        Frame2.ZIndex = 1;
        Frame2.Parent = ScreenGui;
        TweenService:Create(Frame2, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 0
        }):Play();
        EffectsHandler.Wait(0.4);
        local v27;

        if p26 then
            v27 = Instance.new("TextLabel");
            v27.Size = UDim2.fromScale(0.85, 0.18);
            v27.Position = UDim2.fromScale(0.5, 0.5);
            v27.AnchorPoint = Vector2.new(0.5, 0.5);
            v27.BackgroundTransparency = 1;
            v27.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
            v27.TextSize = 72;
            v27.TextColor3 = Color3.fromRGB(230, 230, 230);
            v27.TextStrokeTransparency = 0.4;
            v27.TextTransparency = 1;
            v27.Text = p26;
            v27.TextWrapped = true;
            v27.ZIndex = 2;
            v27.Parent = ScreenGui;
            TweenService:Create(v27, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 0
            }):Play();
        else
            v27 = nil;
        end;

        EffectsHandler.Wait(1.5);

        if v27 then
            TweenService:Create(v27, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
                TextTransparency = 1
            }):Play();
            EffectsHandler.Wait(0.3);
        end;

        u12:Destroy();
        EffectsHandler.Wait(0.15);
        TweenService:Create(Frame2, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        }):Play();
        task.delay(0.5, ScreenGui.Destroy, ScreenGui);
    end;

    local v28 = u12:Add(Instance.new("DistortionSoundEffect"));
    v28.Level = 0.8;
    v28.Parent = script.Music;
    local v29 = u12:Add(Instance.new("EqualizerSoundEffect"));
    v29.LowGain = 6;
    v29.MidGain = -8;
    v29.HighGain = -12;
    v29.Parent = script.Music;
    local PlaybackSpeed = script.Music.PlaybackSpeed;
    script.Music.PlaybackSpeed = 0.05;
    script.Music:Play();
    u12:Add(function() -- Line: 217
        -- upvalues: PlaybackSpeed (copy)
        script.Music:Stop();
        script.Music.TimePosition = 0;
        script.Music.PlaybackSpeed = PlaybackSpeed;
    end);
    local v30 = TweenInfo.new(2.375, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
    u12:Add(TweenService:Create(script.Music, v30, {
        PlaybackSpeed = PlaybackSpeed
    }), "Cancel"):Play();
    TweenService:Create(v28, v30, {
        Level = 0
    }):Play();
    TweenService:Create(v29, v30, {
        LowGain = 0,
        MidGain = 0,
        HighGain = 0
    }):Play();
    local u31 = AnimationHandler.PlayAnimId(u10, 11765603339, true);
    u31.Priority = Enum.AnimationPriority.Action4;
    u31:Play(0);
    HumanoidRootPart.Anchored = true;
    u10:SetAttribute("SpeedsterAura", true);
    EffectsHandler.CallEffect("UGrain Speedster Aura", {
        Attribute = "SpeedsterAura",
        NoAfterimages = true,
        Character = u10,
        PathData = {
            AbilityName = "UGrain"
        }
    });
    CurrentCamera:SetAttribute("CamDisabled", true);
    u12:Add(function() -- Line: 244
        -- upvalues: CurrentCamera (ref), u10 (copy), u14 (ref), u31 (copy), UserInputService (ref), HumanoidRootPart (copy), Remote (copy), u15 (ref)
        CurrentCamera:SetAttribute("CamDisabled", nil);
        u10:SetAttribute("SpeedsterAura", nil);
        u14 = false;
        script.Music:Stop();
        u31:Stop();
        CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value or 70;
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
        HumanoidRootPart.Anchored = false;

        if Remote then
            if Remote:IsA("RemoteEvent") then
                Remote:FireServer({
                    Success = u15
                });

                return;
            end;

            if Remote:IsA("BindableEvent") then
                Remote:Fire({
                    Success = u15
                });
            end;
        end;
    end);
    local Nodes = u11.Nodes;
    local u32 = 0;
    local u33 = {};
    local u34 = 0;
    local u35 = false;
    local u36 = false;
    local u37 = 1;
    local u38 = 0;

    local function MakeLabel(p39) -- Line: 107
        -- upvalues: Frame (copy)
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.fromScale(0.8, 0.15);
        TextLabel.Position = UDim2.fromScale(0.5, 0.42);
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = 56;
        TextLabel.TextColor3 = Color3.new(1, 1, 1);
        TextLabel.TextTransparency = 1;
        TextLabel.Text = p39;
        TextLabel.TextWrapped = true;
        TextLabel.ZIndex = 3;
        TextLabel.Parent = Frame;
        local UIGradient = Instance.new("UIGradient");
        UIGradient.Color = ColorSequence.new(Color3.new(1, 1, 1), Color3.fromHex("#afc8ff"));
        UIGradient.Rotation = 90;
        UIGradient.Parent = TextLabel;

        return TextLabel;
    end;

    local u40 = 1;

    for i = 0, #Nodes:GetChildren() - 1 do
        local v41 = Nodes:FindFirstChild((tostring(i)));
        local v42 = Nodes:FindFirstChild((tostring(i + 1)));

        if not v41 then
            return;
        end;

        local v43 = v42 and CFrame.lookAt(v41.Position, v42.Position, v41.CFrame.UpVector) or v41.CFrame;
        local v44 = v42 and ((v42.Position - v41.Position).Magnitude or 0) or 0;
        u33[i] = {
            Index = i,
            Node = v41,
            Next = v42,
            Origin = v43,
            Distance = v44,
            CumulativeStart = u32
        };
        u32 = u32 + v44;
        u34 = i + 1;
    end;

    local u45 = u32 / 53;
    local v46 = u33[u34 - 2];
    local u47;

    if v46 then
        u47 = v46.CumulativeStart;
    else
        u47 = u32;
    end;

    local function GetPositionAtDistance(p48, p49) -- Line: 304
        -- upvalues: u34 (ref), u33 (copy)
        local v50 = p49 or 0;

        while v50 < u34 - 2 do
            local v51 = u33[v50];

            if not v51 or p48 <= v51.CumulativeStart + v51.Distance then
                break;
            end;

            v50 = v50 + 1;
        end;

        local v52 = u33[v50];

        if v52 then
            local v53 = v52.Distance > 0 and (math.clamp((p48 - v52.CumulativeStart) / v52.Distance, 0, 1) or 0) or 0;

            return v52.Node.Position:Lerp(v52.Next and v52.Next.Position or v52.Node.Position, v53), v52.Origin.LookVector, v52.Origin.RightVector, v52.Origin.UpVector, v50;
        end;

        local v54 = u33[math.max(0, u34 - 1)];

        if v54 then
            return v54.Node.Position, v54.Origin.LookVector, v54.Origin.RightVector, v54.Origin.UpVector, v50;
        end;

        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 1), Vector3.new(1, 0, 0), Vector3.new(0, 1, 0), v50;
    end;

    local u55 = u32;
    local u56 = {};

    for _, v in u4 do
        local v57 = v[3];
        local v58 = v[1] * u45;

        while v58 < v[2] * u45 do
            local v59 = nil;

            for i = 0, u34 - 2 do
                local v60 = u33[i];

                if v60 and (v60.CumulativeStart <= v58 and v58 <= v60.CumulativeStart + v60.Distance) then
                    v59 = v60;
                    break;
                end;
            end;

            if v59 then
                local v61 = (v58 - v59.CumulativeStart) / v59.Distance;
                local v62 = (u1:NextNumber() - 0.5) * 18;
                local v63 = v59.Node.Position:Lerp(v59.Next.Position, v61) + v59.Origin.RightVector * v62;
                local v64 = v57[u1:NextInteger(1, #v57)];
                local v65 = Obstacles:FindFirstChild(v64);

                if v65 then
                    local u66 = u12:Clone(v65);
                    u66.Anchored = true;
                    u66.CanCollide = false;
                    u66.CanTouch = true;
                    u66.CFrame = CFrame.lookAt(v63, v63 + v59.Origin.LookVector, v59.Origin.UpVector) * CFrame.new(0, -2.5 + u66.Size.Y / 2, 0);
                    u66.Parent = u11.Obstacles;

                    if v64 == "Person" then
                        local Humanoid = u66:WaitForChild("CharacterVisual").Humanoid;
                        AnimationHandler.PlayAnimId(u66.CharacterVisual, u6[u1:NextInteger(1, #u6)]);
                        task.spawn(function() -- Line: 359
                            -- upvalues: Humanoid (copy), Players (ref), u5 (ref), u1 (ref), u66 (copy)
                            Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(u5[u1:NextInteger(1, #u5)]));
                            local v67 = u66;
                            v67.CFrame = v67.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
                        end);
                    end;

                    table.insert(u56, {
                        Name = v64,
                        Obstacle = u66,
                        GlobalDistance = v58,
                        Type = v64 == "Laser" and "Homelander" or "Regular",
                        WorldPosition = v63
                    });
                end;
            end;

            v58 = v58 + u1:NextNumber(u3.Min, u3.Max);
        end;
    end;

    table.sort(u56, function(p68, p69) -- Line: 379
        return p68.GlobalDistance < p69.GlobalDistance;
    end);
    local u70 = 0;
    local u71 = 0;
    local u72 = u45;
    local u73 = 0;
    local u74 = 0;
    local u75 = 0;
    local v76, v77 = GetPositionAtDistance(0);
    HumanoidRootPart.CFrame = CFrame.lookAt(v76, v76 + v77);
    local CFrame2 = HumanoidRootPart.CFrame;
    local u78 = u12:Clone(ClientAssets.KurUGrain);
    u78.Parent = u11;
    local u79 = AnimationHandler.PlayAnimId(u78, 11765603339);
    local u80 = u33[1] and u33[1].CumulativeStart or 0;
    local u81 = 1;
    local v82, v83, _, v84 = GetPositionAtDistance(u80);
    local u85 = CFrame.lookAt(v82, v82 + v83, v84);
    u78.PrimaryPart.CFrame = u85;
    u12:Connect(UserInputService.TouchStarted, function(p86) -- Line: 403
        -- upvalues: u75 (ref)
        u75 = p86.Position.X;
    end);
    CurrentCamera.CameraType = Enum.CameraType.Scriptable;
    u12:Connect(UserInputService.InputChanged, function(p87) -- Line: 409
        -- upvalues: u14 (ref), u35 (ref), u36 (ref), u73 (ref), CurrentCamera (ref), u75 (ref), u7 (ref)
        if not u14 or (u35 or u36) then
            return;
        end;

        if p87.UserInputType == Enum.UserInputType.MouseMovement then
            u73 = math.clamp((p87.Position.X - CurrentCamera.ViewportSize.X / 2) / (CurrentCamera.ViewportSize.X / 2) * 9, -9, 9);

            return;
        end;

        if p87.UserInputType ~= Enum.UserInputType.Touch then
            if p87.UserInputType == Enum.UserInputType.Gamepad1 and (p87.KeyCode == Enum.KeyCode.Thumbstick1 and math.abs(p87.Position.X) > 0.15) then
                u73 = math.clamp(u73 + p87.Position.X * 9 * 0.016666666666666666, -9, 9);
            end;

            return;
        end;

        u73 = math.clamp(u73 + (p87.Position.X - u75) * u7[p87.UserInputType], -9, 9);
        u75 = p87.Position.X;
    end);
    local u88 = CFrame.new(0, 14, 5);
    local u89 = 0;
    local u90 = 0;
    local u91 = 0;
    local u92 = os.clock();
    local u93 = 5;
    local u94 = {};
    local u95 = nil;
    local u96 = nil;
    local u97 = nil;

    local function EnableAllParticles(p98, p99, p100) -- Line: 431
        if not p98 then
            return;
        end;

        for _, descendant in p98:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                descendant.Enabled = p99;

                if descendant:IsA("ParticleEmitter") and p100 then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                end;
            end;
        end;
    end;

    local function ShootLaser(p101) -- Line: 443
        -- upvalues: u97 (ref), u96 (ref), u95 (ref), u12 (copy), u11 (copy), EnableAllParticles (copy)
        if not (u97 and u97.Parent) then
            return;
        end;

        if u96 then
            task.cancel(u96);
            u96 = nil;
        end;

        local LaserVFX = u97.Head:FindFirstChild("LaserVFX");

        if not LaserVFX then
            LaserVFX = script.Assets.LaserVFX:Clone();
            LaserVFX.Parent = u97.Head;
            local Weld = Instance.new("Weld");
            Weld.Part0 = LaserVFX;
            Weld.Part1 = u97.Head;
            Weld.Parent = LaserVFX;
        end;

        if not u95 then
            u95 = u12:Clone(script.Assets.LaserHit);
            u95.Parent = u11;

            for _, descendant in LaserVFX:GetDescendants() do
                if descendant:IsA("Beam") then
                    descendant.Attachment1 = u95["1Position"];
                end;
            end;
        end;

        u95.CFrame = p101;
        EnableAllParticles(LaserVFX, true);
        EnableAllParticles(u95, true, true);
        u96 = task.delay(0.3, function() -- Line: 477
            -- upvalues: EnableAllParticles (ref), LaserVFX (ref), u95 (ref)
            EnableAllParticles(LaserVFX, false);
            EnableAllParticles(u95, false);
        end);
    end;

    u12:Connect(RunService.RenderStepped, function(p102) -- Line: 483
        -- upvalues: u14 (ref), u12 (copy), u70 (ref), u37 (ref), u40 (ref), u38 (ref), u72 (ref), u45 (copy), u71 (ref), u47 (ref), u74 (ref), u35 (ref), u36 (ref), u73 (ref), GetPositionAtDistance (copy), u13 (ref), CFrame2 (ref), HumanoidRootPart (copy), u78 (copy), CurrentCamera (ref), u2 (ref), u80 (ref), u32 (copy), u81 (ref), u85 (ref), u31 (copy), u79 (copy), u97 (ref), u92 (ref), u93 (ref), u1 (ref), u90 (ref), u91 (ref), u89 (ref), u88 (ref), u56 (copy), u94 (copy), ShootLaser (copy), u11 (copy), u16 (ref), EndChase (copy)
        if not u14 then
            u12:Destroy();

            return;
        end;

        u70 = u70 + p102;
        u37 = u37 + (u40 - u37) * 0.06;

        if u38 > 0 then
            u38 = math.max(0, u38 - p102);
        end;

        u72 = (u38 > 0 and math.lerp(u45 * 0.35, u45, 1 - u38 / 2) or u45) * u37;
        u71 = math.min(u71 + u72 * p102, u47);
        u74 = u74 + (((u35 or u36) and 0 or u73) - u74) * 0.2;
        local v103, v104, v105, v106 = GetPositionAtDistance(u71, 0);
        local v107 = v103 + v105 * u74;

        if not u13 then
            CFrame2 = CFrame2:Lerp(CFrame.lookAt(v107, v107 + v104, v106), 0.2);
            HumanoidRootPart.CFrame = CFrame2;
        end;

        if u36 and u78.Parent then
            local v108 = CFrame.lookAt((u78.PrimaryPart.Position + HumanoidRootPart.Position) / 2 + v104 * 36 + v106 * 2 + v105 * 8, HumanoidRootPart.Position + v106 * 1.5);
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(v108, 0.1);
        elseif u35 and u78.Parent then
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.lookAt(v103 + v105 * 5 + v106 - v104 * 12, u78.PrimaryPart.Position + v106), 0.06);
        else
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CFrame.lookAt(v103, v103 + v104, v106) * u2, 0.08);
        end;

        if u78.Parent then
            u80 = math.min(u80 + u45 * u37 * p102, u32);
            local v109, v110, _, v111, v112 = GetPositionAtDistance(u80, u81);
            u81 = v112;
            u85 = u85:Lerp(CFrame.lookAt(v109, v109 + v110, v111), 0.2);
            u78.PrimaryPart.CFrame = u85;
        end;

        u31:AdjustSpeed(u72 / u45);

        if u79 then
            u79:AdjustSpeed(u37);
        end;

        if u97 and u97.Parent then
            if u93 < os.clock() - u92 then
                u92 = os.clock();
                u93 = u1:NextNumber(1.8, 2.75);
                u90 = u1:NextNumber(-9, 9);
            end;

            u91 = u89;
            u89 = u89 + (u90 - u89) * 0.015;
            local v113 = math.clamp((u89 - u91) * 200, -20, 20);
            u97.PrimaryPart.CFrame = u97.PrimaryPart.CFrame:Lerp(CFrame.lookAt(v103, v103 + v104, v106) * u88 * CFrame.new(u89, 0, 0) * CFrame.Angles(0, 0, (math.rad(-v113))), 0.2);

            for _, v in u56 do
                if v.Type == "Homelander" and (not u94[v] and (v.Obstacle and (v.Obstacle.Parent and (u97.PrimaryPart.Position - v.WorldPosition).Magnitude <= 85))) then
                    u94[v] = true;
                    ShootLaser(CFrame.new(v.WorldPosition));
                    v.Obstacle.Transparency = u1:NextNumber(0.2, 0.8);
                end;
            end;
        end;

        local v114 = OverlapParams.new();
        v114.FilterType = Enum.RaycastFilterType.Include;
        v114.FilterDescendantsInstances = { u11.Obstacles };

        for _, v in workspace:GetPartBoundsInBox(HumanoidRootPart.CFrame, Vector3.new(2, 4, 1), v114) do
            if v.Parent == u11.Obstacles then
                if v.Name == "Person" then
                    local v115 = script.Assets.KillFX:Clone();
                    v115.CFrame = CFrame.new(v.Position);
                    v115.Parent = workspace;

                    for _, descendant in v115:GetDescendants() do
                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                        end;
                    end;

                    task.delay(5, v115.Destroy, v115);
                end;

                v:Destroy();
                u38 = 2.5;
                break;
            end;
        end;

        if u70 >= 65 and not u16 then
            task.spawn(EndChase, "Kur got away");
        end;
    end);
    task.spawn(function() -- Line: 586
        -- upvalues: EffectsHandler (ref), u14 (ref), u16 (ref), MakeLabel (copy), FadeLabel (copy), UserInputService (ref)
        EffectsHandler.Wait(1);

        if not u14 or u16 then
            return;
        end;

        local v116 = MakeLabel("Don\'t let Kur get away!");
        FadeLabel(v116, 0.6, 0.8, 0.3);
        v116:Destroy();
        EffectsHandler.Wait(0.2);

        if not u14 or u16 then
            return;
        end;

        local v117 = UserInputService:GetLastInputType();
        local v118 = MakeLabel(v117 == Enum.UserInputType.Touch and "Swipe left and right to dodge!" or ((v117 == Enum.UserInputType.Gamepad1 or v117 == Enum.UserInputType.Gamepad2) and "Use the left stick to dodge!" or "Move your mouse to dodge!"));
        FadeLabel(v118, 0.5, 4, 0.4);
        v118:Destroy();
        EffectsHandler.Wait(0.3);

        if not u14 or u16 then
            return;
        end;

        local v119 = MakeLabel("Dodge the bodies in your way!");
        FadeLabel(v119, 0.5, 2.5, 0.4);
        v119:Destroy();
    end);
    task.delay(20, function() -- Line: 614
        -- upvalues: u14 (ref), u16 (ref), u35 (ref), u40 (ref), u12 (copy), TweenService (ref), PlaybackSpeed (copy), CurrentCamera (ref), u18 (copy), EffectsHandler (ref), MakeLabel (copy), TypeText (copy), u78 (copy), u11 (copy), RunService (ref), GetPositionAtDistance (copy), u71 (ref), u72 (ref), u55 (ref), u74 (ref), EndChase (copy), Frame (copy)
        if not u14 or u16 then
            return;
        end;

        u35 = true;
        u40 = 0.3;
        local v120 = TweenInfo.new(0.6, Enum.EasingStyle.Sine);
        u12:Add(TweenService:Create(script.Music, v120, {
            PlaybackSpeed = PlaybackSpeed * 0.3
        }), "Cancel"):Play();
        TweenService:Create(CurrentCamera, v120, {
            FieldOfView = 38
        }):Play();
        u18.Enabled = true;
        TweenService:Create(u18, TweenInfo.new(0.5), {
            TintColor = Color3.fromRGB(88, 124, 191)
        }):Play();
        EffectsHandler.Wait(1);

        if not u14 or u16 then
            return;
        end;

        local v121 = MakeLabel("Watch out for Kur\'s poop!");
        v121.TextSize = 48;
        task.spawn(TypeText, v121, 0.3);
        local u122 = MakeLabel("PHASE");
        u122.Position = UDim2.fromScale(0.5, 0.62);
        u122.TextSize = 88;
        u122.TextTransparency = 0;
        local v123 = u122:FindFirstChildWhichIsA("UIGradient");

        if v123 then
            v123.Color = ColorSequence.new(Color3.fromHex("#ffffff"), Color3.fromHex("#5b9bff"));
        end;

        if u78.Parent then
            local u124 = u12:Clone(script.Poop);
            u124.Anchored = true;
            u124.CFrame = u78.PrimaryPart.CFrame;
            u124.Parent = u11;
            local Highlight = Instance.new("Highlight");
            Highlight.OutlineColor = Color3.fromRGB(255, 30, 30);
            Highlight.FillTransparency = 1;
            Highlight.OutlineTransparency = 0;
            Highlight.Parent = u124;
            local u125 = 0;
            local u126 = 0;
            local u127 = false;
            local u128 = nil;
            local u129 = nil;
            local u130 = nil;
            u130 = u12:Connect(RunService.Heartbeat, function(p131) -- Line: 661
                -- upvalues: u124 (copy), u130 (ref), u125 (ref), u127 (ref), GetPositionAtDistance (ref), u71 (ref), u72 (ref), u55 (ref), u74 (ref), u128 (ref), u129 (ref), u126 (ref), TweenService (ref)
                if not u124.Parent then
                    u130:Disconnect();

                    return;
                end;

                u125 = u125 + p131;
                local v132 = CFrame.Angles(u125 * 2.5, u125 * 1.8, u125 * 1.2);

                if u127 then
                    u126 = u126 + p131;
                    local v133 = math.clamp(u126 / 0.25, 0, 1);
                    u124.CFrame = CFrame.new(u128:Lerp(u129, v133)) * v132;

                    if v133 >= 1 then
                        u130:Disconnect();
                        TweenService:Create(u124, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                            Transparency = 1
                        }):Play();
                        task.delay(0.2, u124.Destroy, u124);
                    end;
                else
                    local v134 = math.max(0.001, 2 - u125);
                    local v135, _, v136 = GetPositionAtDistance(math.min(u71 + u72 * v134, u55), 0);
                    local v137 = v135 + v136 * u74 - u124.Position;

                    if v137.Magnitude > 0.001 then
                        u124.CFrame = CFrame.new(u124.Position + v137.Unit * (v137.Magnitude / v134) * p131) * v132;
                    end;

                    if u125 >= 2 then
                        local v138, v139, v140 = GetPositionAtDistance(u71, 0);
                        local v141 = v138 + v140 * u74;
                        u128 = v141;
                        u129 = v141 - v139 * 5;
                        u124.CFrame = CFrame.new(u128) * v132;
                        u127 = true;
                    end;
                end;
            end);
        end;

        local v142 = u12:Add(Instance.new("BindableEvent"));
        v142.Parent = script;
        local u143 = false;
        local u144 = false;
        u12:Connect(v142.Event, function(p145) -- Line: 707
            -- upvalues: u143 (ref), u144 (ref)
            u143 = true;
            u144 = p145 and p145.GoalMet or false;
        end);
        task.spawn(EffectsHandler.CallEffect, "QTE", v142, {
            Amount = 1,
            Goal = 1,
            HitWindow = 0.2,
            ShrinkTime = 1.5,
            RandomPosition = false,
            Keys = { Enum.KeyCode.Space }
        });
        EffectsHandler.Wait(1.6);

        if not u14 or u16 then
            return;
        end;

        local v146 = os.clock() + 0.25;

        while not u143 and os.clock() < v146 do
            RunService.Heartbeat:Wait();
        end;

        v121:Destroy();

        if not u144 then
            EffectsHandler.Wait(0.2);
            EndChase("You suffered a heart attack");

            return;
        end;

        local u147 = {};

        for i = 1, 3 do
            local v148 = u122:Clone();
            v148.Parent = Frame;
            v148.ZIndex = u122.ZIndex + i;
            table.insert(u147, v148);
        end;

        local u149 = os.clock();
        local v154 = u12:Connect(RunService.RenderStepped, function() -- Line: 746
            -- upvalues: u149 (copy), u147 (copy), u122 (copy)
            local v150 = os.clock() - u149;

            for i, v in u147 do
                v.Position = UDim2.fromScale(math.sin(v150 * 14 + i * 2.1) * 0.012 + 0.5, math.cos(v150 * 11 + i * 1.7) * 0.008 + 0.62);
                local v151 = math.sin(v150 * 22 + i * 1.5) * 0.45 + 0.15;
                v.TextTransparency = math.clamp(v151, 0, 0.9);
                v.TextColor3 = Color3.fromHSV(math.sin(v150 * 6 + i) * 0.04 + 0.6, math.sin(v150 * 9) * 0.2 + 0.7, 1);
            end;

            local v152 = math.sin(v150 * 16);
            local v153 = math.abs(v152) * 0.4;
            u122.TextTransparency = math.clamp(v153, 0, 0.5);
        end);
        EffectsHandler.Wait(0.2);
        v154:Disconnect();

        for _, v in u147 do
            v:Destroy();
        end;

        if not u14 or u16 then
            return;
        end;

        TweenService:Create(u122, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            TextTransparency = 1
        }):Play();
        u12:Add(TweenService:Create(script.Music, TweenInfo.new(1, Enum.EasingStyle.Sine), {
            PlaybackSpeed = PlaybackSpeed
        }), "Cancel"):Play();
        TweenService:Create(u18, TweenInfo.new(0.7), {
            Saturation = 0,
            Brightness = 0,
            TintColor = Color3.new(1, 1, 1)
        }):Play();
        TweenService:Create(CurrentCamera, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            FieldOfView = 70
        }):Play();
        EffectsHandler.Wait(0.7);
        u18.Enabled = false;
        EffectsHandler.Wait(0.1);
        u122:Destroy();
        u40 = 1;
        u35 = false;
    end);
    task.delay(38, function() -- Line: 776
        -- upvalues: u14 (ref), u16 (ref), u88 (ref), u97 (ref), u12 (copy), HumanoidRootPart (copy), u11 (copy), TweenService (ref), EffectsHandler (ref)
        if not u14 or u16 then
            return;
        end;

        local v155 = u88;
        local v156 = v155 * CFrame.new(17.5, 3, 25);
        u88 = v156;
        u97 = u12:Clone(script.Assets.Homelander);
        u97.AnimationController.Animator:LoadAnimation(u97.Flying):Play(0);
        u97.PrimaryPart.CFrame = HumanoidRootPart.CFrame * u88;
        u97.Parent = u11;

        for i = 1, 100 do
            u88 = v156:Lerp(v155, TweenService:GetValue(i / 100, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
            EffectsHandler.Wait(0.04);
        end;
    end);
    task.spawn(function() -- Line: 794
        -- upvalues: u14 (ref), u16 (ref), u71 (ref), u47 (ref), u80 (ref), u32 (copy), RunService (ref), u36 (ref), u40 (ref), u79 (copy), u31 (copy), AnimationHandler (ref), u78 (copy), u12 (copy), u10 (copy), TweenService (ref), CurrentCamera (ref), MakeLabel (copy), TypeText (copy), EffectsHandler (ref), EndChase (copy), u15 (ref), u13 (ref), HumanoidRootPart (copy)
        while u14 and (not u16 and (u71 < u47 or u80 < u32)) do
            RunService.Heartbeat:Wait();
        end;

        if not u14 or u16 then
            return;
        end;

        u36 = true;
        u40 = 0.02;

        if u79 then
            u79:Stop(0.3);
        end;

        u31:Stop(0.3);
        local u157 = AnimationHandler.PlayAnimId(u78, 7473308966, true);
        u157:Play(0.3);
        u12:Add(function() -- Line: 813
            -- upvalues: u157 (copy)
            u157:Stop(0.3);
        end);
        local u158 = AnimationHandler.PlayAnimId(u10, 14324703321, true);
        u158.Priority = Enum.AnimationPriority.Action4;
        u158:Play(0.2, 1, 0.02);
        u12:Add(function() -- Line: 821
            -- upvalues: u158 (copy)
            u158:Stop(0.3);
        end);
        TweenService:Create(CurrentCamera, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            FieldOfView = 32
        }):Play();
        local v159 = MakeLabel("Kur has no where left to go. Run through him!");
        v159.TextSize = 48;
        task.spawn(TypeText, v159, 0.5);
        local v160 = u12:Add(Instance.new("BindableEvent"));
        v160.Parent = script;
        local u161 = false;
        local u162 = false;
        u12:Connect(v160.Event, function(p163) -- Line: 838
            -- upvalues: u161 (ref), u162 (ref)
            u161 = true;
            u162 = p163 and p163.GoalMet or false;
        end);
        task.spawn(EffectsHandler.CallEffect, "QTE", v160, {
            Amount = 1,
            Goal = 1,
            HitWindow = 2,
            ShrinkTime = 2,
            RandomPosition = false,
            Keys = { Enum.KeyCode.E }
        });
        local v164 = os.clock() + 2 + 0.5;

        while not u161 and os.clock() < v164 do
            RunService.Heartbeat:Wait();
        end;

        if not u14 or u16 then
            return;
        end;

        TweenService:Create(v159, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            TextTransparency = 1
        }):Play();
        task.delay(0.3, v159.Destroy, v159);

        if not u162 then
            EndChase("You suffered a heart attack");

            return;
        end;

        u15 = true;
        u158:AdjustSpeed(1);
        task.delay(math.max(0, 0.3 - u158.TimePosition), function() -- Line: 872
            -- upvalues: EffectsHandler (ref), u78 (ref), u10 (ref), u13 (ref), TweenService (ref), HumanoidRootPart (ref)
            EffectsHandler.CallEffect("Emit Particle V3", {
                AbilityName = "UGrain",
                Path = "Particles/General/Burst",
                Origin = u78
            });
            EffectsHandler.CallEffect("SK_VANISH", {
                Transparency = 1,
                AffectStands = true,
                Character = u78,
                TweenInfo = { 0 }
            });
            task.spawn(EffectsHandler.CallEffect, "A-Train Afterimages", u10, true);
            local _ = (u10.HumanoidRootPart.Position - u78.HumanoidRootPart.Position).Magnitude;
            local CFrame3 = u78.HumanoidRootPart.CFrame;
            u13 = true;
            TweenService:Create(HumanoidRootPart, TweenInfo.new(0.125), {
                CFrame = CFrame3
            }):Play();
            EffectsHandler.CallEffect("UGrain Dash", {
                PathData = {
                    AbilityName = "UGrain"
                },
                Character = u10,
                Start = u10.HumanoidRootPart.CFrame,
                End = CFrame3
            });
        end);
        EffectsHandler.Wait(1.5);
        EffectsHandler.CallEffect("A-Train Afterimages", u10, false);
        EndChase();
    end);
end;