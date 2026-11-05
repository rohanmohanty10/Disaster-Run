  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy), ParticleHandler (copy)
    local TargetCharacter = (p1 or {}).TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local u2 = TargetCharacter.HumanoidRootPart.CFrame * CFrame.new(0, 6, 0);
    local u3 = Random.new();
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(u2.Position)
    });
    local u4 = AssetHandler.CloneAsset("Glitch Overdrive/Orb", {
        AbilityName = "KillEffects"
    });
    u4.CFrame = u2;
    u4.Parent = workspace.Effects;
    local u5 = u4.Size * 3;
    local u6 = u4.Outline.Size * 3;
    TweenService:Create(u4, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = u5
    }):Play();
    TweenService:Create(u4.Outline, TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = u6
    }):Play();

    local function GetRand(p7, p8) -- Line: 34
        -- upvalues: u3 (copy)
        return u3:NextNumber(p7, p8) * (math.random(1, 2) == 1 and -1 or 1);
    end;

    local u9 = os.clock();
    local u10 = AssetHandler.GetAsset("Glitch Overdrive/Trails", {
        AbilityName = "KillEffects"
    }):GetChildren();

    local function lerp(p11, p12, p13) -- Line: 41
        return p11 + (p12 - p11) * p13;
    end;

    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
    local u14 = true;

    while os.clock() - u9 < 4 do
        if (os.clock() - u9) / 4 < 0.9 then
            task.spawn(function() -- Line: 51
                -- upvalues: u10 (copy), u3 (copy), u4 (copy), u2 (copy), EffectsHandler (ref), u9 (copy), u14 (ref), u5 (copy), u6 (copy), ParticleHandler (ref)
                local v15 = u10[math.random(1, #u10)]:Clone();
                v15.Parent = workspace.Effects;
                local v16 = os.clock();
                local v17 = 4 * u3:NextNumber(0.06, 0.1);
                local v18 = u4.Size.X * 2.25 + u3:NextNumber(5, 10);
                local v19 = math.random(0, 360);
                local v20 = u3:NextNumber(-10, 22);
                u3:NextNumber(-0.5, 0.5);
                local v21 = u3:NextNumber(10, 20);
                local v22 = v20;
                local v23 = v18;

                while v15:IsDescendantOf(game) and os.clock() - v16 <= v17 do
                    local new = CFrame.new;
                    local v24 = math.rad(v19);
                    local v25 = math.cos(v24) * v23;
                    local v26 = math.rad(v19);
                    v15.CFrame = u2 * new(v25, v22, -math.sin(v26) * v23);
                    v19 = v19 + v21;
                    local v27 = (os.clock() - v16) / v17;
                    v22 = v20 + (0 - v20) * v27;
                    v23 = v18 + (0 - v18) * v27;
                    EffectsHandler.Wait();
                end;

                if os.clock() - u9 > 0.24 and u14 then
                    local v28 = u3:NextNumber(0.95, 1.06);
                    u4.Size = u5 * v28;
                    u4.Outline.Size = u6 * v28;
                end;

                if not v15:IsDescendantOf(game) then
                    return;
                end;

                ParticleHandler.EnableAllParticles(v15, false);
                task.delay(2, v15.Destroy, v15);
            end);
            local v29 = math.random(1, 3);
            local v30 = u3:NextNumber(1, 4);
            local v31 = u3:NextNumber(1, 4);
            local v32 = Vector3.new(v30, v31, u3:NextNumber(1, 4));
            local u33 = AssetHandler.CloneAsset("Glitch Overdrive/Tech", {
                AbilityName = "KillEffects"
            });
            u33.Size = v32 * (v29 == 1 and Vector3.new(1, 1, 0) or (v29 == 2 and Vector3.new(1, 0, 1) or (v29 == 3 and Vector3.new(0, 0, 1) or Vector3.new(0, 0, 0))));
            u33.CFrame = u2 * CFrame.new(u3:NextNumber(-20, 20), u3:NextNumber(5, 10) * (math.random(1, 2) == 1 and -1 or 1), u3:NextNumber(-20, 20));
            u33.Parent = workspace.Effects;
            local v34 = TweenService:Create(u33, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut, 0, true), {
                Size = v32
            });
            v34:Play();
            v34.Completed:Connect(function() -- Line: 120
                -- upvalues: u33 (copy)
                u33:Destroy();
            end);
        end;

        EffectsHandler.Wait(0.04);
    end;

    local v35 = AssetHandler.CloneAsset("Glitch Overdrive/Distortion", {
        AbilityName = "KillEffects"
    });
    v35.Transparency = 10;
    v35.Size = Vector3.new(50, 50, 50);
    v35.Position = u2.Position;
    v35.Parent = workspace.Effects;
    task.delay(0.15, v35.Destroy, v35);
    task.delay(0.15, u4.Destroy, u4);
    local v36 = TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    TweenService:Create(v35, v36, {
        Transparency = 1,
        Size = Vector3.new(0, 0, 0)
    }):Play();
    TweenService:Create(u4, v36, {
        Size = Vector3.new(0, 0, 0)
    }):Play();
    TweenService:Create(u4.Outline, v36, {
        Size = Vector3.new(0, 0, 0)
    }):Play();

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.15,
                EasingStyle = "ExitExpressive",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    Size = NumberSequence.new(0)
                }
            });
        end;
    end;
end;