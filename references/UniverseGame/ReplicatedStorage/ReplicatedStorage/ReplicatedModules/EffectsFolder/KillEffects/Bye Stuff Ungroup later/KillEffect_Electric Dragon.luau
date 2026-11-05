  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    local u3 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    local function GetRand(p4, p5) -- Line: 30
        -- upvalues: u3 (copy)
        return u3:NextNumber(p4, p5) * (math.random(1, 2) == 1 and -1 or 1);
    end;

    local function Bezier(p6, p7, p8, p9, p10) -- Line: 34
        return (1 - p6) ^ 3 * p7 + 3 * (1 - p6) ^ 2 * p6 * p8 + 3 * (1 - p6) * p6 ^ 2 * p9 + p6 ^ 3 * p10;
    end;

    local v11 = CFrame2 * CFrame.new(u3:NextNumber(15, 20) * (math.random(1, 2) == 1 and -1 or 1), u3:NextNumber(8, 15), u3:NextNumber(15, 20) * (math.random(1, 2) == 1 and -1 or 1));
    local v12 = u3:NextNumber(15, 30) * (math.random(1, 2) == 1 and -1 or 1);
    local v13 = u3:NextNumber(0, 30);
    local v14 = u3:NextNumber(15, 30);
    local v15 = math.random(1, 2) == 1 and -1 or 1;
    local u16 = Vector3.new(v12, v13, v14 * v15);

    if not u16 then
        local v17 = u3:NextNumber(-15, 15);
        local v18 = u3:NextNumber(-5, 10);
        u16 = Vector3.new(v17, v18, u3:NextNumber(-15, 15));
    end;

    local u19 = v11 * CFrame.new(u3:NextNumber(3, 6) * (math.random(1, 2) == 1 and -1 or 1), u3:NextNumber(3, 6) * (math.random(1, 2) == 1 and -1 or 1), u3:NextNumber(3, 6) * (math.random(1, 2) == 1 and -1 or 1));
    task.spawn(function() -- Line: 45
        -- upvalues: u19 (ref), CFrame2 (copy), u16 (copy), AssetHandler (ref), ParticleHandler (ref), TweenService (ref), EffectsHandler (ref), TargetCharacter (copy)
        local v20 = u19.Position:Lerp(CFrame2.Position, 0.4) + u16;
        local v21 = u19.Position:Lerp(CFrame2.Position, 0.65) + u16;
        local v22 = 1 * u19.Position + 0 * v20 + 0 * v21 + 0 * CFrame2.Position;
        local v23 = 0.970299 * u19.Position + 0.029403 * v20 + 0.000297 * v21 + 1.0000000000000002e-6 * CFrame2.Position;
        local u24 = AssetHandler.CloneAsset("Electric Dragon/DragonHead", {
            AbilityName = "KillEffects"
        });
        u24.CFrame = CFrame.new(v22, v23);
        u24.Parent = workspace.Effects;
        task.spawn(function() -- Line: 56
            -- upvalues: u24 (copy), AssetHandler (ref), ParticleHandler (ref), TweenService (ref)
            local Position = u24.Position;

            while u24:IsDescendantOf(game) and not u24:GetAttribute("Inactive") do
                if (u24.Position - Position).Magnitude > 2.5 then
                    local v25 = Position:Lerp(u24.Position, 0.5);
                    local v26 = CFrame.new(v25, v25 + (u24.Position - Position).Unit);
                    local u27 = AssetHandler.CloneAsset("Electric Dragon/Segment", {
                        AbilityName = "KillEffects"
                    });
                    u27.CFrame = v26;
                    u27.Parent = workspace.Effects;

                    for _, descendant in ipairs(u27:GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") then
                            descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                        end;
                    end;

                    ParticleHandler.EnableAllParticles(u27, false);
                    local v28 = TweenService:Create(u27, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
                        Size = u27.Size * Vector3.new(0, 0, 1)
                    });
                    v28:Play();
                    v28.Completed:Connect(function() -- Line: 89
                        -- upvalues: u27 (copy)
                        u27:Destroy();
                    end);
                    Position = u24.Position;
                end;

                task.wait();
            end;
        end);
        local u29 = os.clock();
        local u30 = nil;
        u30 = game["Run Service"].RenderStepped:Connect(function(p31) -- Line: 103
            -- upvalues: u29 (copy), u19 (ref), CFrame2 (ref), u16 (ref), u30 (ref), u24 (copy), TweenService (ref), EffectsHandler (ref), TargetCharacter (ref)
            local v32 = (os.clock() - u29) / 0.43;
            local v33 = u19.Position:Lerp(CFrame2.Position, 0.4) + u16;
            local v34 = u19.Position:Lerp(CFrame2.Position, 0.65) + u16;
            local v35 = (1 - v32) ^ 3 * u19.Position + 3 * (1 - v32) ^ 2 * v32 * v33 + 3 * (1 - v32) * v32 ^ 2 * v34 + v32 ^ 3 * CFrame2.Position;
            local v36 = v32 + 0.01;
            local v37 = (1 - v36) ^ 3 * u19.Position + 3 * (1 - v36) ^ 2 * v36 * v33 + 3 * (1 - v36) * v36 ^ 2 * v34 + v36 ^ 3 * CFrame2.Position;

            if v32 < 1 then
                u24.CFrame = CFrame.new(v35, v37);

                return;
            end;

            u30:Disconnect();
            u30 = nil;

            if not u24:IsDescendantOf(game) then
                return;
            end;

            u24:SetAttribute("Inactive", true);
            TweenService:Create(u24, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.4), {
                Size = Vector3.new(0, 0, 0)
            }):Play();
            task.delay(0.4, u24.Destroy, u24);

            for _, descendant in ipairs(u24:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;

                if descendant:IsA("BasePart") then
                    TweenService:Create(descendant, TweenInfo.new(0.4, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.4), {
                        Size = Vector3.new(0, 0, 0)
                    }):Play();
                end;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Electric Dragon/Explosion",
                AbilityName = "KillEffects",
                Origin = CFrame2
            });
            EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
        end);
    end);
end;