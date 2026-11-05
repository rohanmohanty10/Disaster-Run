  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

local function lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 12
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v5 = p4 or {};
    local TargetCharacter = v5.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v5.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    local u6 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    local u7 = AssetHandler.CloneAsset("Amputate Scramble/Room", {
        AbilityName = "KillEffects"
    });
    u7.CFrame = CFrame2;
    u7.Parent = workspace.Effects;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    AssetHandler.ScaleAsset(u7, {
        Scale = 23,
        TweenInfo = { 0.5 }
    });
    task.wait(0.3);
    local u8 = AssetHandler.CloneAsset("Amputate Scramble/Spin", {
        AbilityName = "KillEffects"
    });
    u8.CFrame = CFrame2;
    u8.Parent = workspace.Effects;
    task.delay(3.5999999999999996, function() -- Line: 48
        -- upvalues: ParticleHandler (ref), u8 (copy), AssetHandler (ref), u7 (copy)
        ParticleHandler.DestroyEmit(u8);
        ParticleHandler.EnableAllParticles(u8, false);
        AssetHandler.ScaleAsset(u7, {
            Scale = 0,
            TweenInfo = { 0.5 }
        });
        task.delay(0.5, u7.Destroy, u7);
    end);

    for _, descendant in TargetCharacter:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            task.delay(2.7, function() -- Line: 62
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Cubic), {
                    Transparency = 1
                }):Play();
            end);
        end;

        if descendant:IsA("BasePart") then
            task.spawn(function() -- Line: 71
                -- upvalues: descendant (copy), u6 (copy), CFrame2 (copy), TweenService (ref), EffectsHandler (ref)
                descendant.Anchored = true;
                local v9 = os.clock();
                local v10 = 0;
                local v11 = u6:NextNumber(5, 10);
                local v12 = math.random(0, 360);
                local v13 = descendant.Position.Y - CFrame2.Position.Y;
                u6:NextNumber(-0.5, 0.5);
                local v14 = u6:NextNumber(4, 8);
                local v15 = TweenInfo.new(3, Enum.EasingStyle.Cubic);
                local v16 = {};
                local v17 = math.random(-480, 480);
                local v18 = math.random(-480, 480);
                v16.Orientation = Vector3.new(v17, v18, math.random(-480, 480));
                TweenService:Create(descendant, v15, v16):Play();
                local v19 = v10;

                while descendant:IsDescendantOf(game) and os.clock() - v9 <= 3 do
                    local new = CFrame.new;
                    local v20 = math.rad(v12);
                    local v21 = math.cos(v20) * v10;
                    local v22 = math.rad(v12);
                    descendant.Position = (CFrame2 * new(v21, v13, -math.sin(v22) * v10)).Position;
                    v12 = v12 + v14;

                    if os.clock() - v9 > 2 then
                        local v23 = (os.clock() - v9 - 2) / 1;
                        v10 = v11 + (v19 - v11) * v23;
                        v14 = v14 - 1 / v14;
                    else
                        local v24 = (os.clock() - v9) / 2;
                        v10 = v19 + (v11 - v19) * v24;
                        v14 = v14 + 1 / v14;
                    end;

                    EffectsHandler.Wait();
                end;
            end);
        end;
    end;
end;