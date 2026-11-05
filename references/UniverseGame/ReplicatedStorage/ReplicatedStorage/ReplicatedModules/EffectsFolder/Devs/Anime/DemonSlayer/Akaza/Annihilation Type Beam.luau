  

 

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
local _ = Players.LocalPlayer;

return function(p2) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), u1 (copy), RunService (copy)
    local Character = p2.Character;
    local _ = p2.Player;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Speed = p2.Speed;
    local v3 = p2.StartFrame or 75;
    local v4 = p2.Offset or CFrame.new(0, 0, -10);
    local u5 = HumanoidRootPart.CFrame * v4;
    local u6 = AssetHandler.GetAbilityData(Character);
    local u7 = AssetHandler.CloneAsset("Particles/Annihilation Type/BeamFX", u6);
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

    ParticleHandler.Emit(u7["1"], ParticleHandler.GenerateEmitInfo(u7["1"]));
    task.delay((77 - v3) / 60 / Speed, function() -- Line: 49
        -- upvalues: EmitAndEnable (copy), EffectsHandler (ref), u5 (copy), u1 (ref), AssetHandler (ref), u6 (copy), RunService (ref), ParticleHandler (ref)
        EmitAndEnable("2", 0.4);
        EffectsHandler.CallEffect("Mesh Emit", {
            Effect = "Akaza Ult Appear",
            Origin = u5,
            Offset = CFrame.new(0, 7, 0)
        });

        for _ = 1, 26 do
            local u10 = u1:NextNumber(0.28, 0.43);
            local v11 = u1:NextNumber(10, 22);
            local v12 = u1:NextNumber(6, 12);
            local v13 = u1:NextNumber(13, 22);
            local v14 = u1:NextNumber(22, 36);
            local v15 = u1:NextNumber(10, 18);
            local v16 = u1:NextNumber(6, 14);
            local u17 = u1:NextNumber(15, 50);
            local u18 = u1:NextNumber() < 0.5;
            local v19 = u1:NextNumber() * 3.141592653589793 * 2;
            local v20 = math.cos(v19);
            local v21 = math.sin(v19);
            local u22 = Vector3.new(v20, 0, v21);
            local v23 = Vector3.new(-u22.Z, 0, u22.X);
            local v24 = u1:NextInteger(0, 1) * 2 - 1;
            local Position = u5.Position;
            local v25 = Position + v23 * v24 * v11 + u22 * u1:NextNumber(-2, 2);
            local u26 = Vector2.new(v25.X, v25.Z);
            local u27 = u26 + Vector2.new(u22.X * v12 + v23.X * v24 * v15, u22.Z * v12 + v23.Z * v24 * v15);
            local v28 = Position + u22 * v13 + v23 * (v24 * u1:NextNumber(-v16, v16));
            local u29 = Vector2.new(v28.X, v28.Z);
            local v30 = Position + u22 * v14 + v23 * (v24 * u1:NextNumber(-6, 6));
            local u31 = Vector2.new(v30.X, v30.Z);
            local v32 = math.random(1, 2);
            local u33 = AssetHandler.CloneAsset("Particles/Annihilation Type/Trail" .. v32, u6);
            u33.CFrame = CFrame.new(u26.X, Position.Y, u26.Y);
            u33.Parent = workspace.Effects;

            for _, descendant in u33:GetDescendants() do
                if descendant:IsA("Trail") then
                    descendant.Enabled = true;
                    descendant.Lifetime = descendant.Lifetime * (u1:NextNumber(0.67, 0.95) * (v32 == 2 and 0.5 or 1));
                end;
            end;

            local u34 = 0;
            local u35 = nil;
            u35 = RunService.Stepped:Connect(function(p36, p37) -- Line: 100
                -- upvalues: u34 (ref), u10 (copy), u35 (ref), ParticleHandler (ref), u33 (copy), u26 (copy), u27 (copy), u29 (copy), u31 (copy), Position (copy), u17 (copy), u18 (copy), u22 (copy)
                u34 = math.min(u34 + p37 / u10, 1);

                if u34 >= 1 then
                    u35:Disconnect();
                    u35 = nil;
                    ParticleHandler.EnableAllParticles(u33, false);
                    task.delay(1, u33.Destroy, u33);

                    return;
                end;

                local v38 = u34 == 1 and 1 or 1 - 2 ^ (u34 * -10);
                local v39 = 1 - v38;
                local v40 = math.pow(v39, 3) * u26 + math.pow(v39, 2) * 3 * v38 * u27 + 3 * v39 * math.pow(v38, 2) * u29 + math.pow(v38, 3) * u31;
                local v41 = Position.Y + u17 * (u18 and v38 * v38 or 1 - (1 - v38) * (1 - v38));
                local v42 = math.min(v38 + 0.02, 1);
                local v43 = 1 - v42;
                local v44 = math.pow(v43, 3) * u26 + math.pow(v43, 2) * 3 * v42 * u27 + v43 * 3 * math.pow(v42, 2) * u29 + math.pow(v42, 3) * u31;
                local v45 = Vector3.new(v44.X - v40.X, Position.Y + u17 * (u18 and v42 * v42 or 1 - (1 - v42) * (1 - v42)) - v41, v44.Y - v40.Y);

                if v45.Magnitude < 0.0001 then
                    v45 = u22;
                end;

                u33.CFrame = CFrame.fromMatrix(Vector3.new(v40.X, v41, v40.Y), v45.Unit:Cross(Vector3.new(0, 1, 0)).Unit, Vector3.new(0, 1, 0));
            end);
            EffectsHandler.Wait(u1:NextNumber(0, 0.025));
        end;
    end);
    task.delay((100 - v3) / 60 / Speed, EmitAndEnable, "1");
    task.delay((106 - v3) / 60 / Speed, function() -- Line: 133
        -- upvalues: ParticleHandler (ref), u7 (copy), EffectsHandler (ref), u5 (copy)
        ParticleHandler.Emit(u7["3"], ParticleHandler.GenerateEmitInfo(u7["3"]));
        EffectsHandler.CallEffect("Mesh Emit", {
            Effect = "Akaza Ult Disappear",
            Origin = u5,
            Offset = CFrame.new(0, 7, 0)
        });
        EffectsHandler.CallEffect("Sharm Rock Crater", {
            MaxElevation = 50,
            MinRange = 16,
            MaxRange = 20,
            Rings = 1,
            Frequency = 10,
            FadeIn = 0.05,
            FadeOut = 1,
            Duration = 2.2,
            CollisionGroup = "NoCollision",
            Position = u5.Position,
            LookAtPosition = (u5 * CFrame.new(0, 20, 0)).Position
        });
    end);
end;