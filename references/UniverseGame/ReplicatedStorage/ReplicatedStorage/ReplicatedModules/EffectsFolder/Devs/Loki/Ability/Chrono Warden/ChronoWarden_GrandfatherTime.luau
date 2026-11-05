  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Classes = ReplicatedModules:FindFirstChild("Classes");
local Sequence_V2 = require(Classes:FindFirstChild("Sequence_V2"));
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
local Tween = Petal("Util").Tween;
local _ = game:GetService("RunService").Heartbeat;
local LocalPlayer = game:GetService("Players").LocalPlayer;
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local Angles = CFrame.Angles;
local _ = Color3.fromRGB;
local u1 = Random.new();

local function Rng(p2, p3) -- Line: 26
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function Lerp(p4, p5, p6) -- Line: 30
    return p4 + (p5 - p4) * p6;
end;

local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

local function ShatterGlass(p7, u8) -- Line: 37
    -- upvalues: RunService (copy), Tween (copy), u1 (copy)
    local v9 = p7.GlassShattered.GlassBottom:GetChildren();
    local v10 = p7.GlassShattered.GlassTop:GetChildren();
    local GlassTop = p7.GlassNormal.GlassTop;
    local GlassBottom = p7.GlassNormal.GlassBottom;
    local v11 = RunService.Heartbeat:Wait() * 60;
    local u12 = math.clamp(v11, 0.9, 1.5);

    local function Shatter(u13, p14) -- Line: 46
        -- upvalues: u12 (copy), Tween (ref), u1 (ref), u8 (copy)
        u13.Transparency = 1;
        u13:ClearAllChildren();

        for i = 1, #p14 do
            local u15 = p14[i]:Clone();
            u15.Parent = workspace.Effects;
            p14[i]:Destroy();
            u15.Transparency = 0.6;
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = u15;
            local LinearVelocity = Instance.new("LinearVelocity");
            LinearVelocity.Attachment0 = Attachment;
            LinearVelocity.MaxForce = 1000000;
            LinearVelocity.Parent = u15;
            LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
            local AngularVelocity = Instance.new("AngularVelocity");
            AngularVelocity.Attachment0 = Attachment;
            AngularVelocity.MaxTorque = 1000000;
            AngularVelocity.Parent = u15;
            AngularVelocity.AngularVelocity = Vector3.new(0, 0, 0);
            local v16 = u13.CFrame.RightVector * math.random(5, 70);
            local v17 = math.random(-5, 5);
            local v18 = math.random(-5, 5);
            local u19 = Vector3.new(v17, v18, math.random(-5, 5));
            LinearVelocity.VectorVelocity = v16 * u12;
            AngularVelocity.AngularVelocity = u19 * u12;
            Tween(LinearVelocity, u1:NextNumber(0.7, 0.9), "Quart", "Out", {
                VectorVelocity = Vector3.new(0, 0, 0)
            });
            Tween(AngularVelocity, u1:NextNumber(0.7, 0.9) + 0.15, "Quart", "Out", {
                AngularVelocity = Vector3.new(0, 0, 0)
            });
            task.delay(u8, function() -- Line: 81
                -- upvalues: Tween (ref), LinearVelocity (copy), u1 (ref), u13 (copy), u12 (ref), AngularVelocity (copy), u19 (copy), u15 (copy)
                Tween(LinearVelocity, u1:NextNumber(0.5, 0.6), "Quart", "Out", {
                    MaxForce = 0,
                    VectorVelocity = u13.CFrame.RightVector * math.random(15, 35) * u12
                });
                Tween(AngularVelocity, u1:NextNumber(0.7, 0.9) + 0.15, "Quart", "Out", {
                    MaxTorque = 0,
                    AngularVelocity = u19 * u12
                });
                task.delay(1.5, function() -- Line: 85
                    -- upvalues: u15 (ref)
                    u15:Destroy();
                end);
            end);
        end;
    end;

    Shatter(GlassBottom, v9);
    Shatter(GlassTop, v10);
end;

return function(p20, p21) -- Line: 96
    -- upvalues: Trove (copy), LocalPlayer (copy), AssetHandler (copy), RunService (copy), Angles (copy), Sequence_V2 (copy), EffectsHandler (copy), Tween (copy), ParticleHandler (copy), ShatterGlass (copy), u1 (copy)
    local u22 = Trove.new();
    local TimestopDuration = p21.TimestopDuration;
    local ClockModel = p21.ClockModel;
    local Origin = p21.Origin;
    local Floor = p21.Floor;
    local u23 = p21.Player or LocalPlayer;
    local u24 = u23 and u23.Data.Skin:GetAttribute("UnusualHueId") and u23.Data.Skin:GetAttribute("UnusualHueId") * 5 or (p21.HueShift or 0);
    AssetHandler.GetAbilityData(p20);
    local u25 = 1;
    task.wait(0.2);
    local u26 = ClockModel:GetExtentsSize();
    task.spawn(function() -- Line: 112
        -- upvalues: ClockModel (copy), u22 (copy), RunService (ref), u25 (ref), Angles (ref)
        local u27 = 1;
        local HourHand = ClockModel.ClockMiddle.HourHand;
        local MinuteHand = ClockModel.ClockMiddle.MinuteHand;
        local Pendulum = ClockModel.Body.Pendulum;
        local C1 = Pendulum.C1;
        u22:Connect(RunService.Heartbeat, function() -- Line: 119
            -- upvalues: u27 (ref), u25 (ref), HourHand (copy), Angles (ref), MinuteHand (copy), Pendulum (copy), C1 (copy)
            local v28 = u27;
            u27 = v28 + (u25 - v28) * 0.03;
            HourHand.C1 = HourHand.C1 * Angles(math.rad(u27 * 2), 0, 0);
            MinuteHand.C1 = MinuteHand.C1 * Angles(math.rad(u27 * 8), 0, 0);
            local v29 = tick() * 5;
            local v30 = u27 * 3 * math.cos(v29);
            Pendulum.C1 = C1 * Angles(math.rad(v30), 0, 0);
        end);
    end);
    Sequence_V2.CreateFromOldSequence({
        Speed = 1,

        Validate = function(p31) -- Line: 130, Name: Validate
            -- upvalues: ClockModel (copy), u22 (copy)
            if not (ClockModel and ClockModel.Parent) then
                u22:Destroy();
            end;

            return ClockModel and ClockModel.Parent ~= nil;
        end,

        Frames = {
            { 0, function(p32) -- Line: 137
                    -- upvalues: ClockModel (copy), Origin (copy), EffectsHandler (ref), u23 (copy), Tween (ref), ParticleHandler (ref), u24 (copy)
                    ClockModel:PivotTo(Origin);
                    local v33 = p32:GetCache("Cache");
                    v33.Duration = 1.2171717171717171;
                    v33.Rot = 12.05;
                    v33.Delay = 0.1;
                    EffectsHandler.CallEffect("Emit Particle V3", {
                        Path = "Particles/GrandfatherTime/Summon",
                        AutoSerialize = true,
                        AttachTo = {
                            Part = ClockModel.Body
                        },
                        Player = u23
                    });

                    for _, descendant in pairs(ClockModel:GetDescendants()) do
                        if descendant:IsA("BasePart") and (descendant.Name ~= "Fragment" and descendant.Name ~= "Primary") then
                            if string.find(descendant.Name, "Glass") then
                                task.delay(1.2171717171717171, function() -- Line: 159
                                    -- upvalues: Tween (ref), descendant (copy)
                                    Tween(descendant, 0.25, "Quad", "InOut", {
                                        Transparency = descendant:GetAttribute("GoalTransparency") or 0
                                    });
                                end);
                            else
                                Tween(descendant, 0.9671717171717171, "Quad", "InOut", {
                                    Transparency = descendant:GetAttribute("GoalTransparency") or 0
                                });
                            end;

                            if descendant.Material == Enum.Material.Neon then
                                descendant.Color = ParticleHandler.HSVShift(descendant.Color, {
                                    HueShift = u24
                                });
                            end;
                        end;
                    end;
                end },
            { 1, 120, function(p34, p35) -- Line: 175
                    -- upvalues: ClockModel (copy)
                    local v36 = p34:GetCache("Cache");
                    local Rot = v36.Rot;
                    local Delay = v36.Delay;
                    ClockModel:PivotTo(ClockModel:GetPivot() * CFrame.Angles(0, 0, (math.rad(Rot - Delay * (p35 + 0.05)))));
                end },
            { 180, function(p37, p38) -- Line: 183
                    -- upvalues: Floor (copy), Tween (ref), ClockModel (copy), ShatterGlass (ref), TimestopDuration (copy), u25 (ref), EffectsHandler (ref), u26 (copy), u1 (ref)
                    if not Floor then
                        p37:Pause();
                        p37:MoveTo(180 + TimestopDuration * 60);
                        p37:Resume();

                        return;
                    end;

                    Tween(ClockModel.Primary, 0.2, "Quad", "InOut", {
                        CFrame = Floor
                    });
                    task.wait(0.19);
                    ShatterGlass(ClockModel, TimestopDuration);
                    u25 = 0;
                    EffectsHandler.CallEffect("Rock Debris", {
                        Size = Vector3.new(3.65, 3.65, 3.65),
                        Amount = 35,
                        Origin = Floor * CFrame.new(0, -(u26.Y / 2) + 5, 0),
                        Lifetime = TimestopDuration + 3,
                        Radius = u1:NextNumber(43, 47)
                    });
                    EffectsHandler.CallEffect("Rock Debris", {
                        Size = Vector3.new(4.15, 4.15, 4.15),
                        Radius = 9,
                        Amount = 8,
                        Origin = Floor * CFrame.new(0, -(u26.Y / 2) + 5, 0),
                        Lifetime = TimestopDuration + 5
                    });
                    EffectsHandler.CallEffect("Flying Debris", {
                        Force = Vector3.new(80, 80, 80),
                        Lifetime = 3,
                        Size = 3,
                        TweenDelay = 2,
                        Origin = Floor * CFrame.new(0, -(u26.Y / 2) + 5, 0),
                        Tween = {
                            Transparency = 1,
                            Size = Vector3.new(0, 0, 0)
                        }
                    });
                end },
            { 180 + TimestopDuration * 60, function(p39, p40) -- Line: 221
                    -- upvalues: u25 (ref)
                    u25 = 1;
                end },
            { 180 + TimestopDuration * 60 + 60, function(p41, p42) -- Line: 225
                    -- upvalues: u25 (ref), ClockModel (copy), Tween (ref), EffectsHandler (ref), u23 (copy)
                    u25 = 1;

                    for _, descendant in pairs(ClockModel:GetDescendants()) do
                        if descendant:IsA("BasePart") and descendant.Name ~= "Primary" then
                            if string.find(descendant.Name, "Glass") then
                                Tween(descendant, 0.15, "Quad", "InOut", {
                                    Transparency = 1
                                });
                            else
                                Tween(descendant, 3, "Quad", "InOut", {
                                    Transparency = 1
                                });
                            end;
                        end;
                    end;

                    task.delay(2.5, function() -- Line: 237
                        -- upvalues: EffectsHandler (ref), ClockModel (ref), u23 (ref)
                        EffectsHandler.CallEffect("Emit Particle V3", {
                            Path = "Particles/GrandfatherTime/Desummon",
                            AutoSerialize = true,
                            AttachTo = {
                                Part = ClockModel.Body
                            },
                            Player = u23
                        });
                        EffectsHandler.CallEffect("CameraShake", 7, 7, 0, 0.5, Vector3.new(0.35, 0.35, 0.35), Vector3.new(2, 2, 2), true, nil, ClockModel.Body.Position, 60);
                    end);
                    local v43 = p41:GetCache("Cache");
                    v43.RotMult = 0;
                    v43.SpinMult = 0;
                    v43.CF = ClockModel.Primary.CFrame;
                end },
            { 180 + TimestopDuration * 60 + 1 + 60, 360 + TimestopDuration * 60 + 60, function(p44, p45) -- Line: 254
                    -- upvalues: TimestopDuration (copy), ClockModel (copy)
                    local v46 = p44:GetCache("Cache");
                    local _ = v46.RotMult;
                    local SpinMult = v46.SpinMult;
                    local CF = v46.CF;
                    local v47 = p45 - (180 + TimestopDuration * 60 - 1 + 60);

                    if SpinMult <= 32 then
                        v46.SpinMult = v46.SpinMult + 1;
                    end;

                    local v48 = 1 + 1 * (v47 / 350);

                    if CF then
                        local v49 = CF * CFrame.new(0, v47 / 25, 0);
                        local Angles2 = CFrame.Angles;
                        local v50 = SpinMult * math.cos(v47 / 12 * v48);
                        ClockModel:PivotTo(v49 * Angles2(math.rad(v50), 0, (math.rad(-(v47 * v47 / 20) * v48))));
                    end;
                end },
            { 360 + TimestopDuration * 60 + 70, function(p51, p52) -- Line: 271
                    -- upvalues: u22 (copy)
                    u22:Destroy();
                end }
        }
    }):Play();
end;