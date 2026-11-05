  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
local Signal = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Signal);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
local u2 = Petal("Util");
Petal("New");
local v3 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local Rng = v3.Rng;
local u4 = {};
u4.__index = u4;
local LocalPlayer = Players.LocalPlayer;

local function GetInsets() -- Line: 72
    -- upvalues: LocalPlayer (copy)
    local ScreenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui);
    ScreenGui.Enabled = false;
    Instance.new("Frame", ScreenGui);
    local v5 = ScreenGui:Clone();
    ScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.FullscreenExtension;
    ScreenGui.ScreenInsets = Enum.ScreenInsets.None;
    local v6 = v5.AbsolutePosition - ScreenGui.AbsolutePosition;
    ScreenGui:Destroy();
    v5:Destroy();

    return Vector2.new(v6.X, v6.Y);
end;

local function Vignette(p7) -- Line: 90
    -- upvalues: EffectsHandler (copy)
    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
        LifeTime = 0.2,
        Transparency = 0.5,
        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 0.225, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
        Size = UDim2.fromScale(1.25, 1.25),
        Color = p7
    });
end;

local function CreateZoneHitEffect(p8) -- Line: 104
    -- upvalues: GetInsets (copy), LocalPlayer (copy), Rng (copy), u2 (copy), Vignette (copy)
    if p8 and p8.Parent then
        local v9 = Instance.fromExisting(p8);
        local AbsolutePosition = p8.AbsolutePosition;
        local AbsoluteSize = p8.AbsoluteSize;
        local v10 = GetInsets();
        v9.AnchorPoint = Vector2.new(0.5, 0.5);
        v9.Position = UDim2.new(0, AbsolutePosition.X + AbsoluteSize.X / 2, 0, AbsolutePosition.Y + v10.Y + AbsoluteSize.Y / 2);
        v9.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
        v9.Parent = LocalPlayer.PlayerGui.UI.Gameplay;
        v9.Name = "Zone_Visual_Clone";
        local v11 = Rng(0.55, 0.7);
        u2.Tween(v9, v11, "Quart", "Out", {
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(AbsoluteSize.X * 1.4, AbsoluteSize.Y * 1.4)
        });
        task.delay(v11, v9.Destroy, v9);
        Vignette(p8.BackgroundColor3);
    end;
end;

function u4.new(p12) -- Line: 127
    -- upvalues: Trove (copy), Signal (copy), u4 (copy)
    local v13 = {
        Destroyed = false,
        Active = false,
        Direction = 1,
        Speed = 0.6,
        Trove = Trove.new(),
        Zones = {}
    };
    local v14 = v13.Trove:Clone(script.MineMinigame);
    v13.Canvas = v14;
    v13.Bar = v14.Bar;
    v13.Slider = v14.Bar.Slider;
    v13.Hit = v13.Trove:Construct(Signal);

    return setmetatable(v13, u4);
end;

function u4.UpdateSlider(p15, p16) -- Line: 148
    local v17 = UDim2.fromScale(math.clamp(p15.Slider.Position.X.Scale + p16 * p15.Speed * p15.Direction, 0, 1), 0.5);
    p15.Slider.Position = v17;

    if v17.X.Scale >= 1 then
        p15.Direction = -1;

        return;
    end;

    if v17.X.Scale <= 0 then
        p15.Direction = 1;
    end;
end;

function u4.CreateZone(p18, p19) -- Line: 161
    local v20 = p18.Canvas.Assets.Zone:Clone();
    v20.BackgroundColor3 = p19.Color or Color3.fromRGB(255, 255, 255);
    v20.Size = UDim2.fromScale(p19.Size, 1);
    local v21;

    if p19.Position then
        v21 = UDim2.fromScale(math.clamp(p19.Position, 0, 1 - p19.Size), 0);
    else
        v21 = UDim2.fromScale(0.5, 0);
    end;

    v20.Position = v21;
    local v22;

    if p19.Position then
        v22 = Vector2.zero;
    else
        v22 = Vector2.new(0.5, 0);
    end;

    v20.AnchorPoint = v22;
    v20.Parent = p19.Parent or p18.Canvas.Bar;

    if p18.Zones[p19.Parent] then
        v20.ZIndex = p19.Parent.ZIndex + 1;
    end;

    v20.Visible = true;
    p18.Zones[v20] = {
        Value = p19.Value,
        Priority = p19.Priority or 1,
        Frame = v20
    };
    p18.Trove:Add(v20);

    return v20;
end;

function u4.ClearZones(p23) -- Line: 180
    for i, _ in p23.Zones do
        p23.Trove:Remove(i);
    end;
end;

function u4.RegisterHit(p24) -- Line: 186
    local X = p24.Slider.AbsolutePosition.X;

    local function Intercepts(p25) -- Line: 189
        -- upvalues: X (copy)
        return math.abs(p25.AbsolutePosition.X + p25.AbsoluteSize.X / 2 - X) <= p25.AbsoluteSize.X / 2;
    end;

    local v26 = {};

    for i, v in p24.Zones do
        if math.abs(i.AbsolutePosition.X + i.AbsoluteSize.X / 2 - X) <= i.AbsoluteSize.X / 2 then
            table.insert(v26, v);
        end;
    end;

    local v27 = 0;

    for i = 1, #v26 do
        if v27 < v26[i].Priority then
            v27 = i;
        end;
    end;

    return v26[v27];
end;

function u4.Run(u28) -- Line: 213
    -- upvalues: UserInputService (copy), CreateZoneHitEffect (copy)
    u28.Active = true;
    u28.Trove:Connect(UserInputService.InputBegan, function(p29, p30) -- Line: 216
        -- upvalues: u28 (copy), CreateZoneHitEffect (ref)
        if p30 or not u28.Active then
            return;
        end;

        if p29.UserInputType ~= Enum.UserInputType.MouseButton1 and p29.UserInputType ~= Enum.UserInputType.Touch then
            if p29.UserInputType == Enum.UserInputType.Gamepad1 and p29.KeyCode == Enum.KeyCode.ButtonX then
                local v31 = u28:RegisterHit();
                local v32;

                if v31 then
                    v32 = v31.Frame or nil;
                else
                    v32 = nil;
                end;

                task.spawn(CreateZoneHitEffect, v32);
                u28.Hit:Fire(v31);
            end;

            return;
        end;

        local v33 = u28:RegisterHit();
        local v34;

        if v33 then
            v34 = v33.Frame or nil;
        else
            v34 = nil;
        end;

        task.spawn(CreateZoneHitEffect, v34);
        u28.Hit:Fire(v33);
    end);

    while not u28.Destroyed do
        local v35 = task.wait();

        if u28.Active then
            u28:UpdateSlider(v35);
        end;
    end;
end;

function u4.Destroy(u36) -- Line: 243
    u36.Trove:Destroy();
    task.defer(function() -- Line: 246
        -- upvalues: u36 (copy)
        table.clear(u36);
        table.freeze(u36);
    end);
end;

local function CreateGame(u37, u38) -- Line: 252
    -- upvalues: Trove (copy), u4 (copy), Fusion (copy), LocalPlayer (copy), u2 (copy), Vignette (copy), EffectsHandler (copy), AssetHandler (copy), AnimationHandler (copy), ParticleHandler (copy)
    local u39 = Trove.new();
    u39:AttachToInstance(u37);
    local u40 = u4.new(u38);
    local u41 = 1;
    local u42 = 0;
    local u43 = buffer.create(u38.Iterations);
    local u44 = u38.Time or 6;
    local u45 = 0;
    local MaxMisses = u38.MaxMisses;
    local v46 = Fusion.Value(true);
    Fusion.Hydrate(u40.Canvas)({
        Name = "MiningMinigame",
        Visible = v46,
        Parent = LocalPlayer.PlayerGui.UI.Gameplay
    });
    u39:Add(function() -- Line: 274
        -- upvalues: u40 (copy)
        u40:Destroy();
    end);

    local function MakeZones() -- Line: 278
        -- upvalues: u40 (copy), u42 (ref), u38 (copy), u41 (ref)
        u40:CreateZone({
            Size = 0.275,
            Priority = 2,
            Value = 5,
            Parent = u40:CreateZone({
                Value = 3,
                Size = 0.3 / (u42 / u38.Iterations + 1),
                Position = Random.new():NextNumber(0, 0.65),
                Color = u38.Zone1Color or Color3.fromRGB(224, 175, 255)
            }),
            Color = u38.Zone2Color or Color3.fromRGB(255, 227, 114)
        });

        if u38.SpecialZone and u38.SpecialZone == u41 then
            u40:CreateZone({
                Size = 0.035,
                Value = 6,
                Priority = 3,
                Position = Random.new():NextNumber(0, 0.9),
                Color = Color3.fromRGB(255, 140, 64)
            });
        end;
    end;

    local u47 = nil;
    local Time = u40.Canvas:FindFirstChild("Bar"):FindFirstChild("Time");
    local u48 = nil;

    local function StartTimer() -- Line: 310
        -- upvalues: Time (copy), u48 (ref), u2 (ref), u44 (copy), u39 (copy), u37 (copy), u43 (copy)
        Time:FindFirstChild("Bar").Size = UDim2.fromScale(1, 1);

        if u48 then
            u48:Pause();
            u48:Destroy();
        end;

        u48 = u2.Tween(Time:FindFirstChild("Bar"), u44, "Linear", "Out", {
            Size = UDim2.fromScale(0, 1)
        });
        u48.Completed:Connect(function() -- Line: 319
            -- upvalues: u39 (ref), u37 (ref), u43 (ref)
            u39:Destroy();
            u37:FireServer(u43);
        end);
    end;

    local function Advance() -- Line: 325
        -- upvalues: u41 (ref), u38 (copy), u39 (copy), u37 (copy), u43 (copy), u40 (copy), MakeZones (copy), StartTimer (copy)
        u41 = u41 + 1;

        if u41 > u38.Iterations then
            u39:Destroy();
            u37:FireServer(u43);

            return;
        end;

        u40:ClearZones();
        task.delay(0.1, function() -- Line: 332
            -- upvalues: MakeZones (ref), StartTimer (ref)
            MakeZones();
            StartTimer();
        end);
    end;

    u40.Hit:Connect(function(p49) -- Line: 339
        -- upvalues: u45 (ref), u43 (copy), u41 (ref), Vignette (ref), MaxMisses (copy), u39 (copy), u37 (copy), u42 (ref), u38 (copy), EffectsHandler (ref), AssetHandler (ref), u40 (copy), u47 (ref), Advance (copy)
        if p49 then
            buffer.writeu8(u43, u41 - 1, p49.Value);
            u42 = u42 + 1;

            if u38.Object then
                local v50 = u38.HitEffect or "MineDamageRock";

                if v50 ~= "MineDamageRock" or not u38.HideMineEffects then
                    EffectsHandler.CallEffect(v50, u38.Object, {
                        Variant = (p49.Value == 5 or p49.Value == 6) and 2 or 1
                    });
                end;
            end;
        else
            u45 = u45 + 1;
            buffer.writeu8(u43, u41 - 1, 0);
            print("Missed");
            Vignette(Color3.fromRGB(255, 52, 52));

            if MaxMisses and MaxMisses <= u45 then
                u39:Destroy();
                u37:FireServer(u43);

                return;
            end;
        end;

        EffectsHandler.CallEffects({
            {
                Name = "Play Sound At",
                Data = {
                    {
                        Volume = 2.5,
                        Object = AssetHandler.GetAsset(u38.SoundsPath or "Universal/Interaction/Camellia/Mining/Sounds" .. (p49 and ((p49.Value == 5 or p49.Value == 6) and "/Hit_Perfect" or "/Hit") or "/Hit_Miss")),
                        Origin = u38.Object.CFrame
                    }
                }
            }
        });

        if not u38.NoCameraShake then
            task.spawn(EffectsHandler.CallEffect, "Camera Shake", { 4, 5, 0, 0.25, Vector3.new(0.3, 0.3, 0.3), Vector3.new(3, 1, 1), true });
        end;

        u40.Active = false;
        task.delay(0.1, function() -- Line: 383
            -- upvalues: u40 (ref), u42 (ref), u38 (ref)
            if table.isfrozen(u40) then
                return;
            end;

            u40.Speed = (u42 / u38.Iterations + 1) * 0.5;
            u40.Active = true;
        end);

        if u47 then
            u47:Play(0.1, 1, 1);
        end;

        Advance();
    end);
    task.spawn(u40.Run, u40);
    MakeZones();
    StartTimer();

    if LocalPlayer.Character and LocalPlayer.Character.Parent == workspace.Living then
        local v51 = not u38.NoAnimations and LocalPlayer.Character:FindFirstChildWhichIsA("Animator", true);

        if v51 then
            local v52 = AnimationHandler.CreateAnimationById("Loop", u38.LoopAnimation or 102808401189211);
            local v53 = AnimationHandler.CreateAnimationById("Pulse", u38.PulseAnimation or 131915646864495);
            local u54 = v51:LoadAnimation(v52);
            u47 = v51:LoadAnimation(v53);
            u54.Priority = Enum.AnimationPriority.Action;
            u47.Priority = Enum.AnimationPriority.Action2;
            u54:Play(0.15, 1, 1);
            u39:Add(v52);
            u39:Add(v53);
            u39:Add(function() -- Line: 420
                -- upvalues: u54 (ref), u47 (ref)
                u54:Stop(0);
                task.delay(0.3, function() -- Line: 422
                    -- upvalues: u54 (ref), u47 (ref)
                    u54:Destroy();
                    u47:Destroy();
                end);
            end);
        end;

        if not u38.HideMineEffects then
            task.spawn(function() -- Line: 431
                -- upvalues: LocalPlayer (ref), u38 (copy), EffectsHandler (ref), AssetHandler (ref), u39 (copy), ParticleHandler (ref), u40 (copy)
                local Laser = LocalPlayer.Character:WaitForChild("Laser", 2);
                local Object = u38.Object;

                if not (Laser and Object) then
                    return;
                end;

                EffectsHandler.CallEffects({
                    {
                        Name = "Play Sound At",
                        Data = {
                            {
                                Volume = 1.25,
                                Object = AssetHandler.GetAsset((u38.SoundsPath or "Universal/Interaction/Camellia/Mining/Sounds") .. "/Start"),
                                Origin = LocalPlayer.Character:GetPivot()
                            }
                        }
                    }
                });
                local u55 = AssetHandler.CloneAsset("Universal/Interaction/Lab/MiningLaser/Start");
                local v56 = AssetHandler.CloneAsset("Universal/Interaction/Lab/MiningLaser/End");
                u39:Add(u55);
                u39:Add(v56);
                v56.CFrame = Object.CFrame * CFrame.new(0, -1.5, 0);
                u55.CFrame = LocalPlayer.Character:GetPivot();
                u55.Parent = workspace.Effects;
                v56.Parent = workspace.Effects;
                ParticleHandler.SetBeamAttachments(u55, Laser:WaitForChild("Handle", 1):FindFirstChild("Muzzle"), v56.BeamEnd);
                ParticleHandler.EnableAllParticles(u55, true);
                ParticleHandler.EnableAllParticles(v56, true);

                if Laser:FindFirstChild("Handle") then
                    EffectsHandler.CallEffects({
                        {
                            Name = "Play Sound At",
                            Data = {
                                {
                                    Volume = 0.3,
                                    Object = AssetHandler.GetAsset("Universal/Interaction/Camellia/Mining/Sounds/Loop"),
                                    AttachTo = Laser:FindFirstChild("Handle"),
                                    Reference = u55
                                }
                            }
                        }
                    });
                end;

                u39:Connect(u40.Hit, function() -- Line: 482
                    -- upvalues: AssetHandler (ref), u55 (copy)
                    AssetHandler.ScaleAsset(u55, {
                        Scale = 2,
                        TweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, true)
                    });
                end);
            end);
        end;
    end;

    return u40;
end;

return function(p57, p58) -- Line: 496
    -- upvalues: CreateGame (copy)
    CreateGame(p57, p58);
end;