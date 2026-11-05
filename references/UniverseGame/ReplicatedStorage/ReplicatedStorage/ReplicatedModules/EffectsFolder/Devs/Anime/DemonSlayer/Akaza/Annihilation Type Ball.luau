  

 

game:GetService("TweenService");
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
local LocalPlayer = Players.LocalPlayer;

return function(p2) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), LocalPlayer (copy), EffectsHandler (copy), RunService (copy), u1 (copy)
    local Character = p2.Character;
    local _ = p2.Player;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Speed = p2.Speed;
    local v3 = p2.StartFrame or 24;
    local v4 = p2.Offset or CFrame.new(0, 2.5, -10);
    local u5 = HumanoidRootPart.CFrame * v4;
    local v6 = AssetHandler.GetAbilityData(Character);
    local u7 = AssetHandler.CloneAsset("Particles/Annihilation Type/BallFX", v6);
    u7.CFrame = u5;
    u7.Parent = workspace.Effects;

    local function EmitAndEnable(u8, p9) -- Line: 36
        -- upvalues: ParticleHandler (ref), u7 (copy), Speed (copy)
        ParticleHandler.Emit(u7[u8], ParticleHandler.GenerateEmitInfo(u7[u8]));

        if p9 then
            ParticleHandler.EnableAllParticles(u7[u8], true);
            task.delay(p9 / Speed, function() -- Line: 42
                -- upvalues: ParticleHandler (ref), u7 (ref), u8 (copy)
                ParticleHandler.EnableAllParticles(u7[u8], false);
            end);
        end;
    end;

    EmitAndEnable("1", 0.7);
    task.delay((41 - v3) / 60 / Speed, EmitAndEnable, "1.5", 0.2);
    task.delay((53 - v3) / 60 / Speed, EmitAndEnable, "2");
    task.delay((61 - v3) / 60 / Speed, EmitAndEnable, "3");
    local u10 = (69 - v3) / 60 / Speed;

    if (LocalPlayer.Character.HumanoidRootPart.Position - u5.Position).Magnitude <= 100 then
        local u11 = AssetHandler.CloneAsset("Models/Ball", v6);
        u11.Parent = workspace.Effects;
        u11:PivotTo(u5);
        task.spawn(function() -- Line: 62
            -- upvalues: u10 (copy), u11 (ref)
            local u12 = os.clock();
            task.delay(u10, u11.Destroy, u11);
            local RunService2 = game:GetService("RunService");
            local TweenService = game:GetService("TweenService");
            local Outter = u11.Outter;
            local v13 = u11.RootPart:GetChildren();
            local v14 = {};

            for _, v in ipairs(v13) do
                if v:IsA("Bone") then
                    table.insert(v14, v);
                end;
            end;

            local u15 = {};

            for _, v in ipairs(v14) do
                u15[v] = {
                    Speed = Vector3.new(54, 54, 54),
                    Amplitude = Vector3.new(1.5, 1.5, 1.5),
                    Original = v.Transform,
                    TimeOffset = math.random() * 3.141592653589793 * 2
                };
            end;

            local u16 = false;

            local function waveOffset(p17, p18, p19, p20) -- Line: 92
                return math.sin(p17 * p19 + p18) * p20;
            end;

            local function GetScale() -- Line: 96
                -- upvalues: Outter (copy)
                return math.clamp(Outter.Size.Magnitude / 20, 0.5, 2);
            end;

            local u21 = nil;
            u21 = RunService2.PreSimulation:Connect(function(p22) -- Line: 104
                -- upvalues: u16 (ref), u15 (copy), Outter (copy), u12 (copy), u10 (ref), u21 (ref), TweenService (copy), u11 (ref)
                if not u16 then
                    for i, v in pairs(u15) do
                        local v23 = tick();
                        local TimeOffset = v.TimeOffset;
                        local X = v.Speed.X;
                        local v24 = v.Amplitude.X * math.clamp(Outter.Size.Magnitude / 20, 0.5, 2);
                        local v25 = math.sin(v23 * X + TimeOffset) * v24;
                        local v26 = tick();
                        local v27 = v.TimeOffset + 1;
                        local Y = v.Speed.Y;
                        local v28 = v.Amplitude.Y * math.clamp(Outter.Size.Magnitude / 20, 0.5, 2);
                        local v29 = math.sin(v26 * Y + v27) * v28;
                        local v30 = tick();
                        local v31 = v.TimeOffset + 2;
                        local Z = v.Speed.Z;
                        local v32 = v.Amplitude.Z * math.clamp(Outter.Size.Magnitude / 20, 0.5, 2);
                        local v33 = math.sin(v30 * Z + v31) * v32;
                        local v34 = Vector3.new(v25, v29, v33);
                        i.Transform = v.Original * CFrame.new(v34);
                    end;
                end;

                if not u16 and os.clock() - u12 >= 0.92 * u10 then
                    if u16 then
                        return;
                    end;

                    u16 = true;

                    if u21 then
                        u21:Disconnect();
                        u21 = nil;
                    end;

                    local v35 = u10 * 0.02;
                    local v36 = tick();

                    while tick() - v36 < v35 do
                        local v37 = (tick() - v36) / v35;

                        for i, v in pairs(u15) do
                            local v38 = math.noise(tick(), 0, 0);
                            local v39 = math.noise(0, tick(), 0);
                            local v40 = Vector3.new(v38, v39, math.noise(0, 0, tick()));
                            i.Transform = v.Original * CFrame.new(v40.Unit * 6 * (1 - v37));
                        end;

                        task.wait();
                    end;

                    TweenService:Create(Outter, TweenInfo.new(0.08, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = Outter.Size * 3
                    }):Play();
                    TweenService:Create(u11.Inner, TweenInfo.new(0.08, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                        Size = u11.Inner.Size * 3
                    }):Play();
                end;
            end);
        end);
    end;

    task.spawn(EffectsHandler.CallEffect, "Radial Bezier", Character, {
        Path = "Particles/Misc/Trails",
        Rate = 0.04,
        Radius = 45,
        Goal = u5.Position,
        Duration = u10,
        Lifetime = NumberRange.new(0.16363636363636364, 0.3103448275862069)
    });
    task.delay(u10, function() -- Line: 164
        -- upvalues: EffectsHandler (ref), u5 (copy), ParticleHandler (ref), u7 (copy)
        EffectsHandler.CallEffect("Sharm Rock Crater", {
            MaxElevation = 50,
            MinRange = 2,
            MaxRange = 14,
            Rings = 2,
            Frequency = 10,
            FadeIn = 0.05,
            FadeOut = 1,
            Duration = 3,
            CollisionGroup = "NoCollision",
            Position = u5.Position,
            LookAtPosition = (u5 * CFrame.new(0, 20, 0)).Position
        });
        ParticleHandler.Emit(u7["4"], ParticleHandler.GenerateEmitInfo(u7["4"]));
    end);
    local u41 = os.clock();
    local u42 = os.clock();
    local u43 = true;
    local u44 = nil;
    u44 = RunService.RenderStepped:Connect(function() -- Line: 188
        -- upvalues: u41 (copy), u10 (copy), u44 (ref), u42 (ref), EffectsHandler (ref), u5 (copy), u1 (ref), u43 (ref)
        if u10 > os.clock() - u41 then
            if os.clock() - u42 >= 0.07 then
                u42 = os.clock();
                EffectsHandler.CallEffect("Mesh Emit", {
                    Effect = "Akaza Ult Ball",
                    Origin = u5
                });
                local v45 = u1:NextNumber(0.9, 1.05);
                local v46 = u1:NextNumber(0.08, 0.12);

                if u43 then
                    v45 = v45 * 2;
                    v46 = v46 * 2;
                end;

                u43 = false;
                EffectsHandler.CallEffect("Bubble Distortion", {
                    Origin = u5,
                    StartSize = Vector3.new(10, 10, 10) * v45,
                    EndSize = Vector3.new(30, 30, 30) * v45,
                    Transparency = u1:NextNumber(7, 10),
                    Time = v46
                });
            end;

            return;
        end;

        u44:Disconnect();
        u44 = nil;
    end);
end;