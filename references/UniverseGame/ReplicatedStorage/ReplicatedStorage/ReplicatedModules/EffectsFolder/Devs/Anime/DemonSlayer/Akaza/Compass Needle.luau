  

 

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
local _ = Players.LocalPlayer;

return function(p2) -- Line: 19
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), u1 (copy), TweenService (copy), RunService (copy)
    local Player = p2.Player;
    local Character = p2.Character;
    local v3 = p2.Origin or ParticleHandler.TranslateToCFrame(Character.HumanoidRootPart);
    local u4 = AssetHandler.GetAbilityData(Player);
    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Include;
    v5.FilterDescendantsInstances = { workspace.Map };
    local v6 = workspace:Raycast(v3.Position, Vector3.new(0, -10, 0), v5);

    if v6 then
        local v7 = ParticleHandler.GetUnusualHSVData({
            Player = Player
        });
        local u8 = v7 ~= nil and ParticleHandler.HSVShift(Color3.fromHSV(0.599639, 0.721569, 1), v7) or Color3.fromHSV(0.599639, 0.721569, 1);
        local u9 = v7 ~= nil and ParticleHandler.HSVShift(Color3.fromHSV(0.996472, 0.802258, 0.694118), v7) or Color3.fromHSV(0.996472, 0.802258, 0.694118);
        local Unit = v3.LookVector:Cross(v6.Normal).Unit;
        local u10 = CFrame.fromMatrix(v6.Position, Unit, v6.Normal, Unit:Cross(v6.Normal).Unit) * CFrame.new(0, 0.1, 0);
        EffectsHandler.CallEffect("Mesh Emit", {
            Effect = "Akaza Compass Red",
            Origin = u10,
            Offset = CFrame.new(0, -2.5, 0)
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/CompassNeedle/Slam",
            Player = Player,
            Origin = u10,
            Offset = CFrame.new(0, 2.5, 0)
        });
        local u11 = AssetHandler.CloneAsset("Particles/CompassNeedle/Enable", u4);
        ParticleHandler.Unusualify(u11, {
            Player = Player,
            Character = Character
        });
        u11.CFrame = u10;
        u11.Parent = workspace.Effects;
        task.delay(0.36666666666666664, function() -- Line: 62
            -- upvalues: u10 (copy), u1 (ref), AssetHandler (ref), u4 (copy), ParticleHandler (ref), Player (copy), Character (copy), EffectsHandler (ref)
            local u12 = u10 * CFrame.new(0, 0, -1.7);
            local u13 = Vector2.new(0.23, 0.3);
            local v14 = Vector2.new(5, 18);
            local v15 = Vector2.new(8, 25);
            local v16 = Vector2.new(-5, 5);
            local v17 = Vector2.new(0.01, 0.03);

            for _ = 1, 13 do
                local v18 = u1:NextNumber() * 3.141592653589793 * 2;
                local v19 = u1:NextNumber(v14.X, v14.Y);
                local Position = u12.Position;
                local v20 = math.cos(v18) * v19;
                local v21 = -3 + u1:NextNumber() * -1;
                local v22 = math.sin(v18) * v19;
                local u23 = Position + Vector3.new(v20, v21, v22);
                local v24 = (u23 + u12.Position) / 2;
                local v25 = u1:NextNumber(v16.X, v16.Y);
                local v26 = u1:NextNumber(v15.X, v15.Y);
                local u27 = v24 + Vector3.new(v25, v26, u1:NextNumber(v16.X, v16.Y));
                local u28 = AssetHandler.CloneAsset("Particles/CompassNeedle/Trail", u4);
                ParticleHandler.Unusualify(u28, {
                    Player = Player,
                    Character = Character
                });
                u28.Position = u23;
                u28.Parent = workspace.Effects;
                task.spawn(function() -- Line: 84
                    -- upvalues: u1 (ref), u13 (copy), u28 (copy), u23 (copy), u27 (copy), u12 (copy), ParticleHandler (ref)
                    local v29 = os.clock();
                    local v30 = u1:NextNumber(u13.X, u13.Y);

                    while os.clock() - v29 < v30 do
                        local v31 = (os.clock() - v29) / v30;
                        local v32 = math.clamp(v31, 0, 1);
                        local v33 = v32 < 0.5 and v32 * 2 * v32 or 1 - (v32 * -2 + 2) ^ 2 / 2;
                        u28.Position = (1 - v33) ^ 2 * u23 + 2 * (1 - v33) * v33 * u27 + v33 ^ 2 * u12.Position;

                        if v32 >= 1 then
                            break;
                        end;

                        game.RunService.Heartbeat:Wait();
                    end;

                    ParticleHandler.DestroyEmit(u28);
                    ParticleHandler.EnableAllParticles(u28, false);
                end);
                EffectsHandler.Wait(u1:NextNumber(v17.X, v17.Y));
            end;
        end);
        local u34 = AssetHandler.CloneAsset("Models/Compass", u4);
        local Size = u34.Size;
        local v35 = u34:GetDescendants();
        table.insert(v35, u34);

        for _, v in v35 do
            if v:IsA("BasePart") then
                v.Color = u9;
            end;
        end;

        u34.Size = u34.Size * Vector3.new(0.25, 1, 0.25);
        u34.CFrame = u10;
        u34.Parent = workspace.Effects;
        local v36 = TweenService:Create(u34, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = Size
        });
        v36:Play();
        v36.Completed:Wait();
        local u37 = u34.Hexagons:GetChildren();
        local u38 = #u37;
        task.spawn(function() -- Line: 133
            -- upvalues: u37 (copy), u1 (ref), u38 (copy), TweenService (ref), EffectsHandler (ref)
            for i = #u37, 2, -1 do
                local v39 = u1:NextInteger(1, i);
                local v40 = u37[i];
                u37[i] = u37[v39];
                u37[v39] = v40;
            end;

            for _, v in u37 do
                local v41 = 0.75 / u38;
                TweenService:Create(v, TweenInfo.new(v41 * 0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
                    Transparency = 0
                }):Play();
                EffectsHandler.Wait(v41 * 0.33);
            end;
        end);
        EffectsHandler.Wait(0.30000000000000004);
        EffectsHandler.CallEffect("Mesh Emit", {
            Effect = "Akaza Compass Blue",
            Origin = u10,
            Offset = CFrame.new(0, -5, 0)
        });
        task.delay(0.05, function() -- Line: 159
            -- upvalues: EffectsHandler (ref), Player (copy), u10 (copy), u11 (copy), TweenService (ref), u8 (copy)
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/CompassNeedle/Blue",
                EmitBeams = true,
                Player = Player,
                Origin = u10,
                Offset = CFrame.new(0, 2.5, 0)
            });
            local PointLight = u11:FindFirstChild("PointLight", true);

            if PointLight then
                TweenService:Create(PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Color = u8
                }):Play();
            end;
        end);
        local u42 = {};

        for _, descendant in u11:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                table.insert(u42, descendant);
            end;
        end;

        local u43 = os.clock();
        local u44 = nil;
        u44 = RunService.RenderStepped:Connect(function() -- Line: 186
            -- upvalues: TweenService (ref), u43 (copy), u44 (ref), u42 (copy), u9 (copy), u8 (copy)
            local v45 = TweenService:GetValue((os.clock() - u43) / 0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);

            if v45 < 1 then
                for _, v in u42 do
                    v.Color = ColorSequence.new(u9:Lerp(u8, v45));
                end;

                return;
            end;

            u44:Disconnect();
            u44 = nil;
        end);
        TweenService:Create(u34, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Color = u8
        }):Play();
        task.delay(1, function() -- Line: 204
            -- upvalues: EffectsHandler (ref), u11 (copy), ParticleHandler (ref), TweenService (ref), u34 (copy)
            EffectsHandler.CallEffect("FadeBeams", u11, {
                Time = 0.4
            });
            ParticleHandler.EnableVFX(u11, false, { "ParticleEmitter", "PointLight" });
            ParticleHandler.DestroyEmit(u11);
            local v46 = TweenService:Create(u34, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            });
            v46:Play();
            v46.Completed:Connect(function() -- Line: 216
                -- upvalues: u34 (ref)
                u34:Destroy();
            end);
        end);
        EffectsHandler.CallEffect("Kars_Coil", {
            Uniform = true,
            Amount = 2,
            Height = 0.35,
            Radius = 15,
            Duration = 0.75,
            Origin = u10,
            Degree = Vector2.new(3.5, 7.5),
            Offset = CFrame.new(0, -2.75, 0),
            Trail = AssetHandler.GetAsset("Particles/CompassNeedle/Trail", u4),
            HSVShift = v7
        });
    end;
end;