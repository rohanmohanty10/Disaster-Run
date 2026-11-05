  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

local function CreateAfterimage(p3) -- Line: 20
    local Character = p3.Character;
    local v4 = p3.Transparency or 0;
    Character.Archivable = true;
    local v5 = Character:Clone();
    v5.Name = Character.Name .. "_Visual";
    local v6 = { "LocalScript", "Script", "Sound", "Folder", "BillboardGui", "SurfaceGui", "ScreenGui", "BallSocketConstraint", "NoCollisionConstraint" };

    for _, descendant in v5:GetDescendants() do
        if table.find(v6, descendant.ClassName) then
            descendant:Destroy();
        end;
    end;

    local HumanoidRootPart = v5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        for _, descendant in v5:GetDescendants() do
            if descendant:IsA("BasePart") then
                HumanoidRootPart = descendant;
                break;
            end;
        end;
    end;

    local v7 = v5:FindFirstChildOfClass("Humanoid");

    if v7 then
        v7.DisplayDistanceType = "None";
        v7.HealthDisplayType = "AlwaysOff";
        v7.BreakJointsOnDeath = false;
        v7.EvaluateStateMachine = false;
        v7.RequiresNeck = false;
        v7.AutomaticScalingEnabled = false;
    end;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Anchored = descendant == HumanoidRootPart;
            descendant.CollisionGroup = "Ghosted";
            descendant.CanCollide = false;
            descendant.CanTouch = false;
            descendant.CanQuery = false;
            descendant.Massless = true;
            descendant.CastShadow = false;
        end;

        if descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")) then
            descendant.Transparency = math.clamp(descendant.Transparency + (1 - descendant.Transparency) * v4, 0, 1);
        end;
    end;

    v5.PrimaryPart = HumanoidRootPart;
    v5.Parent = workspace.Effects;
    v5:PivotTo(Character:GetPivot());

    return v5;
end;

return function(p8) -- Line: 91
    -- upvalues: Players (copy), AssetHandler (copy), CreateAfterimage (copy), TweenService (copy), EffectsHandler (copy), ParticleHandler (copy), RunService (copy), u1 (copy), u2 (copy)
    local v9 = p8 or {};
    local Player = v9.Player;
    local Character = v9.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil or HumanoidRootPart:IsA("BasePart") ~= true then
        return;
    end;

    local v10 = v9.Attribute or "CapriceStart";
    local v11 = Player == Players.LocalPlayer;
    local CFrame2 = HumanoidRootPart.CFrame;
    local u12 = CFrame2 * CFrame.new(0, 25, 0);
    local u13 = v9.Speed or 1;
    local Animation = v9.Animation;
    local Sounds = v9.Sounds;
    local u14 = AssetHandler.GetAbilityData(Character);
    local u15 = CreateAfterimage(v9);
    local HumanoidRootPart2 = u15:FindFirstChild("HumanoidRootPart");
    HumanoidRootPart2:PivotTo(CFrame2);
    local v16 = Sounds.UserLoop:Clone();
    v16.Parent = HumanoidRootPart2;
    v16:Play();
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = u15;
    u15.Humanoid:LoadAnimation(Animation2):Play(0);
    local u17 = 0.3 / u13;
    task.spawn(function() -- Line: 130
        -- upvalues: u17 (copy), TweenService (ref), HumanoidRootPart (copy), CFrame2 (copy), u12 (copy), HumanoidRootPart2 (copy)
        local v18 = os.clock();

        while os.clock() - v18 < u17 do
            local v19 = TweenService:GetValue((os.clock() - v18) / u17, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
            local Unit = (HumanoidRootPart.Position - CFrame2.Position).Unit;
            local v20 = CFrame.lookAlong(CFrame2.Position, Unit);
            local v21 = CFrame.lookAlong(u12.Position, Unit);

            if v20 ~= v20 then
                v20 = CFrame.new(v20.Position);
            end;

            if v21 ~= v21 then
                v21 = CFrame.new(v21.Position);
            end;

            HumanoidRootPart2:PivotTo(v20:Lerp(v21, v19));
            task.wait();
        end;
    end);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Caprice/Launch",
        Player = Player,
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("Kars_Debris", {
        Radius = 6.25,
        RockCount = 8,
        Lifetime = 0.75,
        SizeMultiplier = 0.85,
        ExpandTime = 0.05,
        TweenTime = 0.3,
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("Anubis_Laceration", {
        Size = Vector3.new(13, 15, 13),
        Amount = 5,
        VelocityMultiplier = 0.85,
        Origin = CFrame2
    });
    local u22 = nil;
    task.delay(u17, function() -- Line: 180
        -- upvalues: u22 (ref), AssetHandler (ref), u14 (copy), ParticleHandler (ref), u15 (copy), EffectsHandler (ref), Player (copy), u12 (copy)
        u22 = AssetHandler.CloneAsset("Particles/Caprice/Aura", u14);
        u22.Parent = workspace.Effects;
        ParticleHandler.AttachTo(u22, {
            Part = u15.PrimaryPart
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Caprice/Emit",
            Player = Player,
            Origin = u12
        });
    end);
    task.spawn(function() -- Line: 195
        -- upvalues: CFrame2 (copy), AssetHandler (ref), u14 (copy), RunService (ref), u17 (copy), ParticleHandler (ref), TweenService (ref)
        local u23 = os.clock();

        for i = 1, 2 do
            local u24 = (i - 1) * 3.141592653589793;
            local u25 = 0;
            local u26 = 10;

            local function GetCFrame() -- Line: 210
                -- upvalues: CFrame2 (ref), u24 (ref), u26 (ref), u25 (ref)
                return CFrame2 * CFrame.new(math.cos(u24) * u26, u25, -math.sin(u24) * u26);
            end;

            local u27 = AssetHandler.CloneAsset("Particles/Caprice/Trail", u14);
            u27.CFrame = CFrame2 * CFrame.new(math.cos(u24) * u26, u25, -math.sin(u24) * u26);
            u27.Parent = workspace.Effects;
            local u28 = nil;
            u28 = RunService.RenderStepped:Connect(function(p29) -- Line: 219
                -- upvalues: u23 (copy), u17 (ref), u28 (ref), ParticleHandler (ref), u27 (copy), u24 (ref), u25 (ref), TweenService (ref), u26 (ref), CFrame2 (ref)
                if u17 <= os.clock() - u23 then
                    u28:Disconnect();
                    u28 = nil;
                    ParticleHandler.EnableAllParticles(u27, false);
                    ParticleHandler.DestroyEmit(u27);

                    return;
                end;

                local v30 = (os.clock() - u23) / u17;
                u24 = u24 + 28.274333882308138 * p29;
                u25 = math.lerp(0, 25, TweenService:GetValue(v30, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out));
                u26 = math.lerp(10, 0, TweenService:GetValue(v30, Enum.EasingStyle.Quint, Enum.EasingDirection.In));
                u27.CFrame = CFrame2 * CFrame.new(math.cos(u24) * u26, u25, -math.sin(u24) * u26);
            end);
        end;
    end);
    EffectsHandler.CallEffect("SK_VANISH", {
        Transparency = 1,
        AffectStands = true,
        Character = Character,
        TweenInfo = { 0 }
    });
    local v31, v32;

    if v11 then
        v31 = AssetHandler.CloneAsset("Particles/Caprice/Indicator", u14);
        v31.CFrame = HumanoidRootPart.CFrame;
        v31.Parent = workspace.Effects;
        v32 = Sounds.IndicatorLoop:Clone();
        v32.Parent = v31;
        v32:Play();
        local Transparency = v31.Transparency;
        v31.Transparency = 1;
        TweenService:Create(v31, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = Transparency
        }):Play();
    else
        v32 = nil;
        v31 = nil;
    end;

    local v33 = os.clock();

    while true do
        local v34 = task.wait();

        if u15 and Character then
            local v35 = HumanoidRootPart2:GetPivot();
            local v36 = (HumanoidRootPart.Position - v35.Position) * Vector3.new(1, 0, 1);
            HumanoidRootPart2:PivotTo(v35:Lerp(CFrame.lookAlong(v35.Position, v36.Magnitude <= 0 and Vector3.new(-0, -0, -1) or v36), (math.min(v34 * 6, 1))));

            if os.clock() - v33 >= 0.06 then
                v33 = os.clock();
                EffectsHandler.CallEffect("Bezier Trails", {
                    Path = "Particles/Caprice/Trail",
                    Amount = 1,
                    Player = Player,
                    RelativePart = u15.Stand.SwordHandle.Handle.Blade.Shine,
                    Lifetime = u1:NextNumber(0.12, 0.15),
                    Amplitude = u1:NextNumber(1.8, 2.2)
                });
            end;
        end;

        if v31 then
            local v37 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            local v38 = workspace:Raycast(HumanoidRootPart.Position + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), u2);

            if v38 then
                local Unit = HumanoidRootPart.CFrame.LookVector:Cross(v38.Normal).Unit;
                v37 = CFrame.fromMatrix(v38.Position, Unit, v38.Normal, Unit:Cross(v38.Normal).Unit) * CFrame.new(0, 0.1, 0);
            end;

            v31.CFrame = v31.CFrame:Lerp(v37, v34 * 8.5);
        end;

        if not Character or (Character.Parent == nil or not Character:GetAttribute(v10)) then
            if v31 then
                TweenService:Create(v31, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                TweenService:Create(v32, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Volume = 0
                }):Play();
                ParticleHandler.DestroyEmit(v31);
                ParticleHandler.EnableAllParticles(v31, false);
            end;

            if u22 then
                ParticleHandler.DestroyEmit(u22);
                ParticleHandler.EnableAllParticles(u22, false);
            end;

            ParticleHandler.Emit(u15.Stand, ParticleHandler.GenerateEmitInfo(u15.Stand));
            local v39 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            local v40 = workspace:Raycast(HumanoidRootPart.Position + Vector3.new(0, 10, 0), Vector3.new(0, -100, 0), u2);

            if v40 then
                local Unit = HumanoidRootPart.CFrame.LookVector:Cross(v40.Normal).Unit;
                v39 = CFrame.fromMatrix(v40.Position, Unit, v40.Normal, Unit:Cross(v40.Normal).Unit) * CFrame.new(0, 0.1, 0);
            end;

            local CFrame3 = u15.PrimaryPart.CFrame;
            local u41 = v39 * CFrame.new(0, 2.5, 0);
            local Unit = (u41.Position - CFrame3.Position).Unit;
            task.spawn(function() -- Line: 344
                -- upvalues: CFrame3 (copy), u41 (copy), Unit (copy), EffectsHandler (ref), Character (copy), u13 (copy)
                for i = 1, 3 do
                    local v42 = CFrame3:Lerp(u41, i / 4);
                    local v43 = CFrame.new(v42.Position, v42.Position + Unit);
                    EffectsHandler.CallEffect("Byee_Afterimage", {
                        Lifetime = 0.8,
                        IsHighlight = true,
                        FillTransparency = 0.35,
                        OutlineTransparency = 0.27,
                        Origin = v43,
                        Character = Character,
                        FillColor = Color3.fromRGB(145, 67, 255),
                        OutlineColor = Color3.fromRGB(99, 14, 168),
                        DepthMode = Enum.HighlightDepthMode.Occluded
                    });
                    EffectsHandler.Wait(0.1 / u13);
                end;
            end);
            local u44 = AssetHandler.CloneAsset("Particles/Caprice/BodyTrail", u14);
            u44.CFrame = CFrame.new(CFrame3.Position, CFrame3.Position + Unit);
            u44.Parent = workspace.Effects;
            local v45 = 0.25 / u13;
            local v46 = TweenService:Create(u44, TweenInfo.new(v45, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new(u41.Position, u41.Position + Unit)
            });
            v46:Play();
            v46.Completed:Connect(function() -- Line: 377
                -- upvalues: ParticleHandler (ref), u44 (copy)
                ParticleHandler.DestroyEmit(u44);
                ParticleHandler.EnableAllParticles(u44, false);
            end);
            local v47 = Sounds.Launch:Clone();
            v47.Parent = u15.PrimaryPart;
            v47:Play();
            TweenService:Create(v16, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Volume = 0
            }):Play();
            local v48 = TweenService:Create(u15.PrimaryPart, TweenInfo.new(v45, Enum.EasingStyle.Linear), {
                CFrame = u41
            });
            v48:Play();
            v48.Completed:Wait();
            task.defer(u15.Destroy, u15);

            if not Character:IsDescendantOf(game) then
                return;
            end;

            EffectsHandler.CallEffect("SK_VANISH", {
                Transparency = 0,
                AffectStands = true,
                Character = Character
            });

            return;
        end;
    end;
end;