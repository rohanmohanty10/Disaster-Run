  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy), ParticleHandler (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    local u6 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local u7 = HumanoidRootPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(0.45, function() -- Line: 33
        -- upvalues: EffectsHandler (ref), u7 (copy), AssetHandler (ref), TweenService (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Angelo Entrap/Transform",
            AbilityName = "KillEffects",
            Origin = u7
        });
        local u8 = AssetHandler.CloneAsset("Angelo Entrap/Angelo", {
            AbilityName = "KillEffects"
        });
        u8.CFrame = u7;
        u8.Parent = workspace.Effects;
        task.delay(8, function() -- Line: 44
            -- upvalues: TweenService (ref), u8 (copy)
            local v9 = TweenService:Create(u8, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1
            });
            v9:Play();
            v9.Completed:Connect(function() -- Line: 49
                -- upvalues: u8 (ref)
                u8:Destroy();
            end);
        end);
    end);

    for _ = 1, 13 do
        local u10 = u7 * CFrame.new(u6:NextNumber(-1, 1), u6:NextNumber(-2.5, 2), u6:NextNumber(-1, 1));
        local v11 = u7 * CFrame.new(u6:NextNumber(-20, 20), u6:NextNumber(-20, 20), u6:NextNumber(-20, 20));
        local Angles = CFrame.Angles;
        local v12 = math.random(-360, 360);
        local v13 = math.rad(v12);
        local v14 = math.random(-360, 360);
        local v15 = math.rad(v14);
        local v16 = math.random(-360, 360);
        local u17 = v11 * Angles(v13, v15, (math.rad(v16)));
        local u18 = u7 * CFrame.new(u6:NextNumber(-7, 7), u6:NextNumber(-7, 7), u6:NextNumber(-7, 7));
        local u19 = u7 * CFrame.new(u6:NextNumber(-5, 5), u6:NextNumber(-5, 5), u6:NextNumber(-5, 5));
        task.spawn(function() -- Line: 62
            -- upvalues: AssetHandler (ref), u6 (copy), u17 (copy), TweenService (ref), u18 (copy), u19 (copy), u10 (copy), EffectsHandler (ref), ParticleHandler (ref)
            local v20 = AssetHandler.CloneAsset("Angelo Entrap/Rock", {
                AbilityName = "KillEffects"
            });
            AssetHandler.ScaleAsset(v20, {
                Scale = u6:NextNumber(0.55, 1.25)
            });
            v20.CFrame = u17;
            v20.Parent = workspace.Effects;
            local v21 = TweenInfo.new(0.45, Enum.EasingStyle.Linear);
            local v22 = {};
            local v23 = math.random(-40, 40);
            local v24 = math.random(-40, 40);
            v22.Orientation = Vector3.new(v23, v24, math.random(-40, 40));
            TweenService:Create(v20, v21, v22):Play();

            for i = 1, 27 do
                if not v20:IsDescendantOf(game) then
                    break;
                end;

                local v25 = i / 27;
                v20.Position = (1 - v25) ^ 3 * u17.Position + 3 * (1 - v25) ^ 2 * v25 * u18.Position + 3 * (1 - v25) * v25 ^ 2 * u19.Position + v25 ^ 3 * u10.Position;
                EffectsHandler.Wait();
            end;

            if not v20:IsDescendantOf(game) then
                return;
            end;

            ParticleHandler.EnableAllParticles(v20, false);
            ParticleHandler.DestroyEmit(v20);
            v20.Transparency = 1;
        end);
    end;
end;