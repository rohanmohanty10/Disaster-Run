  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local u1 = Random.new();
local CurrentCamera = workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;
local u2 = nil;

local function GetFrustumRectAtDistance(p3, p4, p5, p6) -- Line: 22
    local v7 = p4.X / p4.Y;
    local v8 = math.rad(p5 * 0.5);
    local v9 = math.tan(v8) * 2 * p6;
    local v10 = p3 * CFrame.new(0, 0, -p6);

    return {
        Width = v9 * v7,
        Height = v9,
        Origin = CFrame.fromMatrix(v10.Position, -v10.XVector, v10.YVector, -p3.ZVector)
    };
end;

local u11 = { 132351606654937, 105445935069917, 132983760796552, 94407627004838, 97410308149017, 73297500331711 };
local u12 = {
    Startup = 85147454430964,
    Loop = 79500825059107,
    Release = 115235210465128,
    Idle = 111225218005107
};

local function ScreenSlash(p13, p14, p15) -- Line: 60
    -- upvalues: CurrentCamera (copy), GetFrustumRectAtDistance (copy), u1 (copy), TweenService (copy)
    local u16 = p14 or Color3.new(1, 1, 1);
    local v17 = p15 or 0;

    if p13 then
        p13 = p13:FindFirstChild("HumanoidRootPart");
    end;

    if not p13 then
        return;
    end;

    local v18 = CurrentCamera;
    local v19 = GetFrustumRectAtDistance(v18.CFrame, v18.ViewportSize, v18.FieldOfView, 1);
    local v20 = v18:WorldToViewportPoint(p13.Position);
    local v21 = v19.Width / v18.ViewportSize.X;
    local v22 = v19.Height / v18.ViewportSize.Y;
    local u23 = v17 >= 0 and 1 or -1;
    local v24 = v17 + u1:NextNumber(-4, 4);
    local v25 = math.rad(v24);
    local v26 = Vector3.new(v19.Width + v19.Width / 2 + v20.X * v21, 0.005, 0.01);
    local u27 = v19.Origin * CFrame.new(v19.Width / 2, v19.Height / 2, 0) * CFrame.new(-v20.X * v21, -v20.Y * v22, 0) * CFrame.Angles(0, 0, v25);
    local Model = Instance.new("Model");
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = u16;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
    Highlight.Parent = Model;
    Model.Parent = workspace.Effects;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.Size = Vector3.new(0.05, 0.125, 0.01);
    Part.CFrame = u27 * CFrame.new(v26.X / 2 * u23, 0, 0);
    Part.Color = u16;
    Part.Material = Enum.Material.Neon;
    local SpecialMesh = Instance.new("SpecialMesh");
    SpecialMesh.MeshType = Enum.MeshType.Sphere;
    SpecialMesh.Parent = Part;
    Part.Parent = Model;
    local CFrame2 = Part.CFrame;
    TweenService:Create(Part, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = v26,
        CFrame = u27
    }):Play();
    task.spawn(function() -- Line: 112
        -- upvalues: CFrame2 (copy), u27 (copy), Part (copy), u23 (copy), u1 (ref), u16 (ref), Model (copy), TweenService (ref)
        local v28 = os.clock();

        while os.clock() - v28 <= 0.15 do
            local v29 = (os.clock() - v28) / 0.15;
            local v30 = math.clamp(v29, 0, 1);
            local v31 = CFrame2:Lerp(u27 * CFrame.new(Part.Size.X / 2 * -u23, 0, 0), v30);

            for _ = 1, 8 do
                local v32 = u1:NextNumber(0.008, 0.016);
                local Part2 = Instance.new("Part");
                Part2.Anchored = true;
                Part2.CanCollide = false;
                Part2.Size = Vector3.new(v32, v32, 0.01);
                Part2.CFrame = v31 * CFrame.new(u1:NextNumber(-0.5, 0) * u23, 0, 0);
                Part2.Color = u16;
                Part2.Material = Enum.Material.Neon;
                local SpecialMesh2 = Instance.new("SpecialMesh");
                SpecialMesh2.MeshType = Enum.MeshType.Sphere;
                SpecialMesh2.Parent = Part2;
                Part2.Parent = Model;
                local v33 = u1:NextNumber(0.15, 0.4);
                TweenService:Create(Part2, TweenInfo.new(v33, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = Vector3.new(0.0001, 0.0001, 0.0001),
                    CFrame = Part2.CFrame * CFrame.new(0, u1:NextNumber(-0.3, 0.3), 0)
                }):Play();
                task.delay(v33 + 0.05, function() -- Line: 142
                    -- upvalues: Part2 (copy)
                    Part2:Destroy();
                end);
            end;

            task.wait();
        end;
    end);
    task.delay(0.08, function() -- Line: 150
        -- upvalues: TweenService (ref), Highlight (copy), SpecialMesh (copy)
        TweenService:Create(Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            FillTransparency = 1
        }):Play();
        TweenService:Create(SpecialMesh, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
            Scale = Vector3.new(1, 0, 1)
        }):Play();
    end);
    task.delay(0.28, function() -- Line: 160
        -- upvalues: TweenService (ref), SpecialMesh (copy), Part (copy), Model (copy)
        TweenService:Create(SpecialMesh, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
            Scale = Vector3.new(0.75, 48, 1)
        }):Play();
        TweenService:Create(Part, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {
            Transparency = 1
        }):Play();
        task.delay(0.12, function() -- Line: 169
            -- upvalues: Model (ref)
            Model:Destroy();
        end);
    end);
end;

local function GetAnimator(p34) -- Line: 175
    local v35 = p34:FindFirstChildOfClass("Humanoid");

    if v35 then
        return v35:FindFirstChildOfClass("Animator") or v35;
    end;

    return nil;
end;

local function PlayAnim(p36, p37, p38) -- Line: 181
    -- upvalues: u12 (copy), AnimationHandler (copy)
    local v39 = p36:FindFirstChildOfClass("Humanoid");
    local v40;

    if v39 then
        v40 = v39:FindFirstChildOfClass("Animator") or v39;
    else
        v40 = nil;
    end;

    if not v40 then
        return;
    end;

    local v41 = u12[p37];

    if v41 then
        local v42 = v40:LoadAnimation((AnimationHandler.CreateAnimationById("Thunderclap " .. p37, v41)));
        v42.Priority = Enum.AnimationPriority.Action4;
        v42:Play(p38);

        return v42;
    end;
end;

local function StopAnim(p43, p44) -- Line: 197
    local v45 = p43:FindFirstChildOfClass("Humanoid");
    local v46;

    if v45 then
        v46 = v45:FindFirstChildOfClass("Animator") or v45;
    else
        v46 = nil;
    end;

    if not v46 then
        return;
    end;

    for _, v in v46:GetPlayingAnimationTracks() do
        if v.Name == "Thunderclap " .. p44 then
            v:Stop(0);
        end;
    end;
end;

local function StopAllAnims(p47) -- Line: 208
    -- upvalues: u12 (copy), StopAnim (copy)
    for i in u12 do
        StopAnim(p47, i);
    end;
end;

local u48 = {};

local function SetCamera(p49, p50) -- Line: 217
    -- upvalues: CurrentCamera (copy), LocalPlayer (copy), AssetHandler (copy), u11 (copy), AnimationHandler (copy), u48 (ref), RunService (copy), SetCamera (copy)
    if not (p49 and p50) then
        CurrentCamera.CameraType = Enum.CameraType.Custom;
        CurrentCamera.FieldOfView = LocalPlayer.Settings.FieldOfView.Value;

        return;
    end;

    local CameraRig = p49:FindFirstChild("CameraRig");

    if not CameraRig then
        CameraRig = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/CameraRig");
        CameraRig.PrimaryPart.CFrame = p49.Attacker.CFrame;
        CameraRig.Parent = p49;
        CurrentCamera.FieldOfView = 55;
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local Animator = CameraRig.AnimationController.Animator;

        for i, v in u11 do
            local v51 = AnimationHandler.CreateAnimationById("Stage" .. i, v);
            v51.Parent = CameraRig;
            local v52 = Animator:LoadAnimation(v51);
            v52.Priority = Enum.AnimationPriority.Action4;
            u48[i] = v52;
        end;

        local u53 = nil;
        u53 = RunService.RenderStepped:Connect(function() -- Line: 244
            -- upvalues: CameraRig (ref), u53 (ref), u48 (ref), SetCamera (ref), CurrentCamera (ref)
            if CameraRig and CameraRig.Parent ~= nil then
                if CameraRig:GetAttribute("IsPlaying") then
                    CurrentCamera.CFrame = CameraRig.camera.CFrame;
                end;

                return;
            end;

            u53:Disconnect();
            u53 = nil;
            u48 = {};
            SetCamera();
        end);
    end;

    for _, v in u48 do
        if v.IsPlaying then
            v:Stop(0);
        end;
    end;

    local v54 = u48[p50];

    if v54 then
        v54:Play(0);

        repeat
            task.wait();
        until v54.IsPlaying;

        CameraRig:SetAttribute("IsPlaying", true);
        v54.Stopped:Once(function() -- Line: 273
            -- upvalues: CameraRig (ref)
            CameraRig:SetAttribute("IsPlaying", nil);
        end);
    end;
end;

return function(p55) -- Line: 281
    -- upvalues: Players (copy), AssetHandler (copy), u2 (ref), ReplicatedStorage (copy), PlayAnim (copy), SetCamera (copy), CurrentCamera (copy), u12 (copy), StopAnim (copy), ParticleHandler (copy), AnimationHandler (copy), EffectsHandler (copy), u1 (copy), RunService (copy), TweenService (copy), GetFrustumRectAtDistance (copy)
    local v56 = p55 or {};
    local Character = v56.Character;
    local v57 = Players:GetPlayerFromCharacter(Character);
    local Stage = v56.Stage;
    local v58;

    if Character then
        v58 = Character:FindFirstChild("HumanoidRootPart");
    else
        v58 = Character;
    end;

    if Stage ~= "Init" then
        if Stage == "Cleanup" then
            if u2 then
                Character:SetAttribute("BreatheActive", nil);
                CurrentCamera.CameraType = Enum.CameraType.Custom;
                CurrentCamera.FieldOfView = v57.Settings.FieldOfView.Value;
                v58.CFrame = u2.OriginalCFrame;
                v58.Anchored = false;

                for i in u12 do
                    StopAnim(Character, i);
                end;

                for i, v in u2.OriginalLightingSettings do
                    game.Lighting[i] = v;
                end;

                game.Lighting:ClearAllChildren();

                for _, v in u2.LightingInstances do
                    v.Parent = game.Lighting;
                end;

                u2.Area:Destroy();
                u2 = nil;
            end;

            return;
        end;

        if not (u2 and u2.Area) then
            return;
        end;

        local Area = u2.Area;
        SetCamera(Area, Stage);
        local v120 = {
            function() -- Line: 375
                -- upvalues: AssetHandler (ref), Character (copy), ParticleHandler (ref), Area (copy), AnimationHandler (ref)
                local v59 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/HeadCharge");
                v59.Parent = Character;
                ParticleHandler.AttachTo(v59, {
                    Part = Character.Head
                });

                for _, descendant in v59:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") and descendant.Parent.Name == "Emit" then
                        descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                    end;
                end;

                task.delay(15, v59.Destroy, v59);
                local v60 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialDemon");
                v60.HumanoidRootPart.Anchored = true;
                v60.HumanoidRootPart.CFrame = Area.Enemy.CFrame;
                v60.Parent = Area;
                local Animator = v60.Humanoid.Animator;
                local v61 = AnimationHandler.CreateAnimationById("Idle", 86698787426100);
                v61.Parent = v60;
                local v62 = Animator:LoadAnimation(v61);
                v62.Priority = Enum.AnimationPriority.Action4;
                v62:Play(0);
                local Highlight = Instance.new("Highlight");
                Highlight.OutlineTransparency = 0;
                Highlight.FillColor = Color3.fromRGB(239, 26, 26);
                Highlight.FillTransparency = 1;
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.Parent = v60;
            end,

            function() -- Line: 420
                -- upvalues: Character (copy), ParticleHandler (ref), StopAnim (ref), PlayAnim (ref), AssetHandler (ref)
                local HeadCharge = Character:FindFirstChild("HeadCharge");

                if HeadCharge then
                    ParticleHandler.DestroyEmit(HeadCharge);
                    ParticleHandler.EnableAllParticles(HeadCharge, false);
                end;

                StopAnim(Character, "Idle");
                local v63 = PlayAnim(Character, "Startup");

                if v63 then
                    v63.Stopped:Once(function() -- Line: 430
                        -- upvalues: PlayAnim (ref), Character (ref)
                        PlayAnim(Character, "Loop");
                    end);
                end;

                local u64 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/LegFX");
                u64.Parent = Character;
                ParticleHandler.AttachTo(u64, {
                    Part = Character["Left Leg"]
                });
                task.delay(1.8, function() -- Line: 442
                    -- upvalues: ParticleHandler (ref), u64 (copy)
                    ParticleHandler.DestroyEmit(u64);
                    ParticleHandler.EnableAllParticles(u64, false);
                end);
            end,

            function() -- Line: 448
                -- upvalues: Character (copy), AssetHandler (ref), ParticleHandler (ref)
                task.spawn(function() -- Line: 449
                    -- upvalues: Character (ref), AssetHandler (ref), ParticleHandler (ref)
                    Character:SetAttribute("BreatheActive", true);
                    local v65 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Breathe");
                    v65.Parent = Character;
                    ParticleHandler.AttachTo(v65, {
                        Part = Character.Head
                    });
                end);
            end,

            function() -- Line: 468
                -- upvalues: EffectsHandler (ref), Area (copy), AssetHandler (ref), ParticleHandler (ref), Character (copy), u1 (ref), CurrentCamera (ref), RunService (ref)
                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Activation",
                    RawPath = true,
                    Origin = Area.Attacker.CFrame * CFrame.new(0, -2.5, 0)
                });
                task.spawn(function() -- Line: 475
                    -- upvalues: AssetHandler (ref), Area (ref), ParticleHandler (ref), EffectsHandler (ref), Character (ref), u1 (ref), CurrentCamera (ref), RunService (ref)
                    local v66 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Charge");
                    v66.CFrame = Area.Attacker.CFrame * CFrame.new(0, -2.65, 0);
                    v66.Parent = Area;
                    ParticleHandler.EnableAllParticles(v66, true);
                    EffectsHandler.CallEffect("HighlightObject", Character, {
                        FillTransparency = 0.35,
                        Tween = true,
                        FillColor = Color3.fromRGB(255, 248, 51),
                        OutlineColor = Color3.fromRGB(25, 174, 255),
                        DepthMode = Enum.HighlightDepthMode.Occluded,
                        Lifetime = u1:NextNumber(0.45, 0.6)
                    });
                    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                        LifeTime = 0.2,
                        Transparency = 0.5,
                        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                        TweenOut = { 0.225, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                        Size = UDim2.fromScale(1.25, 1.25),
                        Color = Color3.fromRGB(47, 137, 255)
                    });
                    task.delay(0.15, function() -- Line: 509
                        -- upvalues: CurrentCamera (ref), RunService (ref), Character (ref), u1 (ref)
                        local u67 = 0.26;
                        local u68 = os.clock();
                        local CFrame2 = CurrentCamera.CFrame;
                        local u69 = nil;
                        u69 = RunService.RenderStepped:Connect(function() -- Line: 517
                            -- upvalues: Character (ref), u68 (copy), CurrentCamera (ref), CFrame2 (copy), u69 (ref), u67 (ref), u1 (ref)
                            if not Character or (Character.Parent == nil or os.clock() - u68 >= 1.3) then
                                CurrentCamera.CFrame = CFrame2;
                                u69:Disconnect();
                                u69 = nil;

                                return;
                            end;

                            local v70 = (os.clock() - u68) / 1.3;
                            u67 = (1 - math.min(v70, 1)) * 0.2;
                            local v71 = u1:NextNumber(-u67, u67);
                            local v72 = u1:NextNumber(-u67, u67);
                            CurrentCamera.CFrame = CFrame2 * CFrame.new(v71, v72, 0);
                        end);
                    end);
                    local u73 = 0;

                    while Character and Character:GetAttribute("BreatheActive") do
                        task.spawn(function() -- Line: 557
                            -- upvalues: Character (ref), u73 (ref), u1 (ref), EffectsHandler (ref)
                            local Position = Character.HumanoidRootPart.Position;

                            if os.clock() - u73 >= 0.15 then
                                u73 = os.clock();
                                local v74 = u1:NextNumber(0.35, 0.65);
                                local v75 = u1:NextNumber(5, 13);
                                local v76 = u1:NextNumber(-4, 4);
                                local v77 = u1:NextNumber(-v76, v76);
                                local v78 = Position + Vector3.new(v77, -3, u1:NextNumber(-v76, v76));
                                local Attachment = Instance.new("Attachment");
                                Attachment.Parent = workspace.Terrain;
                                Attachment.WorldPosition = v78;
                                local Attachment2 = Instance.new("Attachment");
                                Attachment2.Parent = workspace.Terrain;
                                Attachment2.WorldPosition = v78 + Vector3.new(0, v75, 0);
                                local v79 = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
                                local v80 = u1:NextNumber(7, 9);
                                local v81 = u1:NextNumber(0.5, 1);
                                local v82 = u1:NextNumber(0, 1);
                                local v83 = u1:NextInteger(8, 12);
                                local v84 = { Color3.fromRGB(244, 225, 119), Color3.fromRGB(100, 125, 219) };
                                local v85 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                                    Color = v84[math.random(1, #v84)],
                                    Curves = v79,
                                    Speed = v80,
                                    Length = v81,
                                    A1 = Attachment,
                                    A2 = Attachment2,
                                    Size = v74,
                                    PartCount = v83
                                });
                                v85.MinThicknessMultiplier = 0.5;
                                v85.AnimationSpeed = v82;
                                v85.MinRadius = 1.25;
                                v85.MaxRadius = 1.5;
                                task.delay(0.25 / v80, function() -- Line: 601
                                    -- upvalues: Attachment (copy), Attachment2 (copy)
                                    Attachment:Destroy();
                                    Attachment2:Destroy();
                                end);
                            end;
                        end);
                        task.wait(0.1);
                    end;

                    ParticleHandler.DestroyEmit(v66);
                    ParticleHandler.EnableAllParticles(v66, false);
                end);
            end,

            function() -- Line: 616
                -- upvalues: Area (copy), TweenService (ref)
                local Indicator = Area:FindFirstChild("Indicator");

                if Indicator then
                    TweenService:Create(Indicator, TweenInfo.new(0.85, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 1.2333333333333334), {
                        Width0 = 3,
                        Width1 = 14
                    }):Play();
                    local TrialDemon = Area:FindFirstChild("TrialDemon");

                    if TrialDemon then
                        TweenService:Create(TrialDemon.Highlight, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, (1 / 0), true), {
                            FillTransparency = 0.2
                        }):Play();
                    end;
                end;
            end,

            function() -- Line: 633
                -- upvalues: Area (copy), AnimationHandler (ref), StopAnim (ref), Character (copy), PlayAnim (ref), EffectsHandler (ref), AssetHandler (ref), TweenService (ref), ParticleHandler (ref), u1 (ref), CurrentCamera (ref), GetFrustumRectAtDistance (ref)
                local TrialDemon = Area:FindFirstChild("TrialDemon");

                if TrialDemon then
                    local Animator = TrialDemon.Humanoid.Animator;

                    for _, v in Animator:GetPlayingAnimationTracks() do
                        v:Stop(0.2);
                    end;

                    local v86 = AnimationHandler.CreateAnimationById("Killed", 136793905683299);
                    v86.Parent = TrialDemon;
                    local v87 = Animator:LoadAnimation(v86);
                    v87.Priority = Enum.AnimationPriority.Action4;
                    v87:Play(0);
                end;

                StopAnim(Character, "Loop");
                local v88 = PlayAnim(Character, "Release");

                if v88 then
                    v88.Stopped:Once(function() -- Line: 652
                        -- upvalues: PlayAnim (ref), Character (ref)
                        PlayAnim(Character, "Idle");
                    end);
                end;

                EffectsHandler.CallEffect("Emit Particle V3", {
                    Path = "Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Wind",
                    RawPath = true,
                    Origin = Area.Attacker.CFrame,
                    EmitBeams = {
                        Lifetime = 1.8
                    }
                });
                local u89 = CFrame.new(Area.Attacker.Position, Area.Enemy.Position);
                local v90 = TrialDemon and TrialDemon:FindFirstChildOfClass("Highlight");

                if v90 then
                    v90:Destroy();
                end;

                local Stand = Character:FindFirstChild("Stand");

                if Stand then
                    Stand = Stand:FindFirstChild("Handle");
                end;

                if Stand then
                    local _ = Stand.Blade;
                    local SwordHandle = Stand.SwordHandle;

                    for _, child in AssetHandler.GetAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/SwordHighlight"):GetChildren() do
                        local v91 = Stand:FindFirstChild(child.Name);

                        if v91 then
                            for _, child2 in child:GetChildren() do
                                local u92 = child2:Clone();
                                u92.Parent = v91;
                                local v93 = TweenService:Create(u92, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, child.Name == "SwordHandle" and 0.2 or 0), {
                                    OffsetStudsU = u92.OffsetStudsU - u92.StudsPerTileU * (u92.OffsetStudsU >= 0 and 1 or -1)
                                });
                                v93:Play();
                                v93.Completed:Connect(function() -- Line: 693
                                    -- upvalues: u92 (ref)
                                    u92:Destroy();
                                end);
                            end;
                        end;
                    end;

                    task.delay(1.5666666666666667, function() -- Line: 727
                        -- upvalues: EffectsHandler (ref), SwordHandle (copy)
                        EffectsHandler.CallEffect("Emit Particle V3", {
                            Path = "Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Glint",
                            RawPath = true,
                            AttachTo = {
                                Part = SwordHandle
                            }
                        });
                    end);
                end;

                task.delay(1.8, function() -- Line: 736
                    -- upvalues: Character (ref), Area (ref), TweenService (ref), EffectsHandler (ref), ParticleHandler (ref)
                    Character:SetAttribute("BreatheActive", nil);
                    local Indicator = Area:FindFirstChild("Indicator");

                    if Indicator then
                        TweenService:Create(Indicator, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            Width0 = 0,
                            Width1 = 0
                        }):Play();
                    end;

                    if Character:FindFirstChild("Breathe") then
                        EffectsHandler.CallEffect("FadeBeams", Character.Breathe, {
                            Time = 0.5
                        });
                        ParticleHandler.EnableVFX(Character.Breathe, false, { "ParticleEmitter" });
                        ParticleHandler.DestroyEmit(Character.Breathe);
                    end;

                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Vanish",
                        RawPath = true,
                        Origin = Area.Attacker.CFrame
                    });
                end);
                task.delay(2.1333333333333333, function() -- Line: 763
                    -- upvalues: Area (ref), AssetHandler (ref), ParticleHandler (ref)
                    local CameraRig = Area:FindFirstChild("CameraRig");

                    if CameraRig then
                        local u94 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/CameraLines");
                        u94.Parent = workspace.CurrentCamera;
                        ParticleHandler.AttachTo(u94, {
                            Part = CameraRig.camera,
                            Offset = CFrame.new(0, 0, 0.2)
                        });
                        task.delay(0.43333333333333335, function() -- Line: 774
                            -- upvalues: ParticleHandler (ref), u94 (copy)
                            ParticleHandler.DestroyEmit(u94);
                            ParticleHandler.EnableAllParticles(u94, false);
                        end);
                    end;
                end);
                task.delay(2.3, function() -- Line: 781
                    -- upvalues: Area (ref), TrialDemon (copy), u1 (ref), CurrentCamera (ref), GetFrustumRectAtDistance (ref), TweenService (ref)
                    local CameraRig = Area:FindFirstChild("CameraRig");

                    if CameraRig then
                        CameraRig = CameraRig:FindFirstChild("camera");
                    end;

                    local v95 = TrialDemon and TrialDemon:FindFirstChild("HumanoidRootPart");

                    if not (v95 and CameraRig) then
                        return;
                    end;

                    local u96 = Color3.fromRGB(46, 189, 255);
                    local v97 = u1:NextNumber(-4, 4);
                    local v98 = math.rad(v97);
                    local v99 = CurrentCamera;
                    local v100 = v99:WorldToViewportPoint(v95.Position);
                    local v101 = GetFrustumRectAtDistance(v99.CFrame, v99.ViewportSize, v99.FieldOfView, 1);
                    local v102 = v101.Width / v99.ViewportSize.X;
                    local v103 = v101.Height / v99.ViewportSize.Y;
                    local u104 = Vector3.new(v101.Width + v101.Width / 2 + v100.X * v102, 0.005, 0.01);
                    local v105 = v101.Origin * CFrame.new(v101.Width / 2, v101.Height / 2, 0) * CFrame.new(-v100.X * v102, -v100.Y * v103, 0) * CFrame.Angles(0, 0, v98);
                    local v106 = v105 * CFrame.new(u104.X / 2 * 1, 0, 0);
                    local u107 = CameraRig.CFrame:ToObjectSpace(v105);
                    local u108 = CameraRig.CFrame:ToObjectSpace(v106);
                    local Model = Instance.new("Model");
                    local Highlight = Instance.new("Highlight");
                    Highlight.FillColor = u96;
                    Highlight.OutlineTransparency = 1;
                    Highlight.FillTransparency = 0;
                    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                    Highlight.Parent = Model;
                    Model.Parent = workspace.Effects;
                    local Part = Instance.new("Part");
                    Part.Anchored = false;
                    Part.CanCollide = false;
                    Part.CanQuery = false;
                    Part.Massless = true;
                    Part.CastShadow = false;
                    Part.Size = Vector3.new(0.05, 0.125, 0.01);
                    Part.Color = u96;
                    Part.Material = Enum.Material.Neon;
                    local SpecialMesh = Instance.new("SpecialMesh");
                    SpecialMesh.MeshType = Enum.MeshType.Sphere;
                    SpecialMesh.Parent = Part;
                    Part.Parent = Model;
                    local Weld = Instance.new("Weld");
                    Weld.Part0 = Part;
                    Weld.Part1 = CameraRig;
                    Weld.C0 = CFrame.new();
                    Weld.C1 = u108;
                    Weld.Parent = Part;
                    TweenService:Create(Weld, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        C1 = u107
                    }):Play();
                    TweenService:Create(Part, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Size = u104
                    }):Play();
                    task.spawn(function() -- Line: 846
                        -- upvalues: u107 (copy), u104 (copy), u108 (copy), u1 (ref), u96 (copy), Model (copy), CameraRig (copy), TweenService (ref)
                        local v109 = os.clock();
                        local v110 = u107 * CFrame.new(u104.X / 2 * -1, 0, 0);

                        while os.clock() - v109 <= 0.15 do
                            local v111 = (os.clock() - v109) / 0.15;
                            local v112 = u108:Lerp(v110, (math.clamp(v111, 0, 1)));

                            for _ = 1, 8 do
                                local v113 = u1:NextNumber(0.008, 0.016);
                                local Part2 = Instance.new("Part");
                                Part2.Anchored = false;
                                Part2.CanCollide = false;
                                Part2.CanQuery = false;
                                Part2.Massless = true;
                                Part2.CastShadow = false;
                                Part2.Size = Vector3.new(v113, v113, 0.01);
                                Part2.Color = u96;
                                Part2.Material = Enum.Material.Neon;
                                local SpecialMesh2 = Instance.new("SpecialMesh");
                                SpecialMesh2.MeshType = Enum.MeshType.Sphere;
                                SpecialMesh2.Parent = Part2;
                                Part2.Parent = Model;
                                local v114 = v112 * CFrame.new(u1:NextNumber(-0.5, 0) * 1, 0, 0);
                                local Weld2 = Instance.new("Weld");
                                Weld2.Part0 = Part2;
                                Weld2.Part1 = CameraRig;
                                Weld2.C0 = CFrame.new();
                                Weld2.C1 = v114;
                                Weld2.Parent = Part2;
                                local v115 = v114 * CFrame.new(0, u1:NextNumber(-0.3, 0.3), 0);
                                local v116 = u1:NextNumber(0.15, 0.4);
                                TweenService:Create(Part2, TweenInfo.new(v116, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    Size = Vector3.new(0.0001, 0.0001, 0.0001)
                                }):Play();
                                TweenService:Create(Weld2, TweenInfo.new(v116, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                    C1 = v115
                                }):Play();
                                task.delay(v116 + 0.05, Part2.Destroy, Part2);
                            end;

                            task.wait();
                        end;
                    end);
                    task.delay(0.08, function() -- Line: 897
                        -- upvalues: TweenService (ref), Highlight (copy), SpecialMesh (copy)
                        TweenService:Create(Highlight, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                            FillTransparency = 1
                        }):Play();
                        TweenService:Create(SpecialMesh, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {
                            Scale = Vector3.new(1, 0, 1)
                        }):Play();
                    end);
                    task.delay(0.28, function() -- Line: 907
                        -- upvalues: TweenService (ref), SpecialMesh (copy), Part (copy), Model (copy)
                        TweenService:Create(SpecialMesh, TweenInfo.new(0.1, Enum.EasingStyle.Circular, Enum.EasingDirection.In), {
                            Scale = Vector3.new(0.75, 48, 1)
                        }):Play();
                        TweenService:Create(Part, TweenInfo.new(0.08, Enum.EasingStyle.Linear), {
                            Transparency = 1
                        }):Play();
                        task.delay(0.12, function() -- Line: 916
                            -- upvalues: Model (ref)
                            Model:Destroy();
                        end);
                    end);
                end);
                task.delay(2.433333333333333, function() -- Line: 922
                    -- upvalues: EffectsHandler (ref), TrialDemon (copy)
                    EffectsHandler.CallEffect("Impact Frame", {
                        Time = 0.05,
                        Models = { TrialDemon }
                    });
                end);
                task.delay(2.5, function() -- Line: 929
                    -- upvalues: AssetHandler (ref), u89 (copy), Area (ref), ParticleHandler (ref), TweenService (ref), TrialDemon (copy), EffectsHandler (ref)
                    local v117 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Thunderclap");
                    v117.CFrame = u89;
                    v117.Parent = Area;
                    ParticleHandler.Emit(v117, ParticleHandler.GenerateEmitInfo(v117));
                    ParticleHandler.EnableVFX(v117, true, { "Beam" });
                    local v118 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Hit");
                    v118.CFrame = Area.Enemy.CFrame;
                    v118.Parent = Area;
                    ParticleHandler.Emit(v118, ParticleHandler.GenerateEmitInfo(v118));

                    for _, v in { v117, v118 } do
                        for _, descendant in v:GetDescendants() do
                            if descendant:IsA("ParticleEmitter") then
                                TweenService:Create(descendant, TweenInfo.new(0.35, Enum.EasingStyle.Circular, Enum.EasingDirection.Out), {
                                    TimeScale = 0.05
                                }):Play();
                            end;
                        end;
                    end;

                    local v119 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialVFX/Bleeding");
                    v119.Parent = TrialDemon;
                    ParticleHandler.AttachTo(v119, {
                        Part = TrialDemon.Torso
                    });
                    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
                        LifeTime = 0.2,
                        Transparency = 0.5,
                        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                        TweenOut = { 0.225, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
                        Size = UDim2.fromScale(1.25, 1.25),
                        Color = Color3.fromRGB(47, 137, 255)
                    });
                end);
            end
        };

        if v120[Stage] then
            v120[Stage]();
        end;

        return;
    end;

    local CFrame2 = v58.CFrame;
    local v121 = AssetHandler.CloneAsset("Universal/QuestAssets/Demon Slayer/Thunder Breathing/TrialArea");
    v121.Name = v57.Name .. " TrialArea";
    v121:PivotTo(CFrame.new(v58.Position + Vector3.new(0, 200, 0)));
    v121.Parent = workspace.Map;
    v58.Anchored = true;
    v58.CFrame = v121.Attacker.CFrame;
    u2 = {
        Area = v121,
        OriginalCFrame = CFrame2,
        OriginalLightingSettings = {},
        LightingInstances = {}
    };

    for i, v in {
        Brightness = 2,
        EnvironmentDiffuseScale = 0.6,
        EnvironmentSpecularScale = 0,
        ClockTime = 14.5,
        GeographicLatitude = 0,
        ExposureCompensation = 0,
        Ambient = Color3.fromRGB(168, 132, 88),
        ColorShift_Bottom = Color3.fromRGB(0, 0, 0),
        ColorShift_Top = Color3.fromRGB(171, 138, 80),
        OutdoorAmbient = Color3.fromRGB(70, 70, 70)
    } do
        u2.OriginalLightingSettings[i] = game.Lighting[i];
        game.Lighting[i] = v;
    end;

    for _, child in game.Lighting:GetChildren() do
        child.Parent = ReplicatedStorage;
        table.insert(u2.LightingInstances, child);
    end;

    for _, child in v121.Lighting:GetChildren() do
        child.Parent = game.Lighting;
    end;

    PlayAnim(Character, "Idle");
    SetCamera(v121, 1);
end;