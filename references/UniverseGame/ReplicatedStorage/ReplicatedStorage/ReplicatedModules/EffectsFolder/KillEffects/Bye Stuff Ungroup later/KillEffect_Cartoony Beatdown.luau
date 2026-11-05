  

 

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

    local v2 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local _ = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    for i = 1, 6 do
        local v3 = v2:NextNumber(0, 3.141592653589793);
        local Position = HumanoidRootPart.Position;
        local v4 = math.cos(v3) * 16 * (math.random(1, 2) == 1 and -1 or 1);
        local v5 = math.sin(v3) * 16;
        local v6 = math.random(1, 2) == 1 and -1 or 1;
        local v7 = Position + Vector3.new(v4, 0, v5 * v6);

        if i == 6 then
            v7 = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 2 + Vector3.new(0, -13, 0);
        end;

        local u8 = AssetHandler.CloneAsset("Cartoony Beatdown/Fist", {
            AbilityName = "KillEffects"
        });
        u8.CFrame = CFrame.new(v7, HumanoidRootPart.Position);
        u8.Parent = workspace.Effects;
        local u9 = HumanoidRootPart.Position + u8.CFrame.LookVector * 2.4 + Vector3.new(0, 3, 0);

        if i == 6 then
            u9 = HumanoidRootPart.Position + Vector3.new(0, 1000, 0);
        end;

        task.delay(i == 6 and 0.65 or 0.07, function() -- Line: 43
            -- upvalues: TweenService (ref), HumanoidRootPart (copy), i (copy), u9 (ref), EffectsHandler (ref)
            TweenService:Create(HumanoidRootPart, TweenInfo.new(i == 6 and 5 or 0.2), {
                CFrame = CFrame.new(u9, u9 + HumanoidRootPart.CFrame.LookVector)
            }):Play();
            EffectsHandler.CallEffect("Emit Particle V3", {
                AbilityName = "KillEffects",
                Path = `Cartoony Beatdown/{i == 6 and "Boom" or "Punch"}`,
                Origin = HumanoidRootPart.CFrame
            });
        end);

        if i == 6 then
            TweenService:Create(u8, TweenInfo.new(0.65), {
                Size = u8.Size * 2
            }):Play();
            u8.Boxes.Enabled = true;
            local CFrame2 = u8.CFrame;
            local v10 = os.clock();
            local v11 = os.clock() - 0.15;

            repeat
                u8.CFrame = CFrame2 * CFrame.new(v2:NextNumber(-0.05, 0.05), v2:NextNumber(-0.05, 0.05), v2:NextNumber(-0.05, 0.05));

                if os.clock() - v11 >= 0.15 then
                    v11 = os.clock();
                    local v12 = u8:Clone();
                    v12.Size = v12.Size * 2;
                    v12.Material = Enum.Material.ForceField;
                    v12.CFrame = u8.CFrame;
                    v12.Parent = workspace.Effects;
                    v12:ClearAllChildren();
                    TweenService:Create(v12, TweenInfo.new(0.15), {
                        Size = u8.Size
                    }):Play();
                    task.delay(0.15, v12.Destroy, v12);
                end;

                EffectsHandler.Wait();
            until os.clock() - v10 > 0.65;
        end;

        if i == 6 then
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Cartoony Beatdown/Charged Punch",
                AbilityName = "KillEffects",
                Origin = u8.CFrame
            });
        end;

        local v13 = TweenService:Create(u8, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
            CFrame = u8.CFrame * CFrame.new(0, 0, -22)
        });
        v13:Play();
        v13.Completed:Connect(function() -- Line: 102
            -- upvalues: TweenService (ref), u8 (copy), ParticleHandler (ref)
            TweenService:Create(u8, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {
                Transparency = 1
            }):Play();
            task.delay(0.3, u8.Destroy, u8);
            ParticleHandler.EnableAllParticles(u8, false);
        end);
        EffectsHandler.Wait(0.25);
    end;
end;