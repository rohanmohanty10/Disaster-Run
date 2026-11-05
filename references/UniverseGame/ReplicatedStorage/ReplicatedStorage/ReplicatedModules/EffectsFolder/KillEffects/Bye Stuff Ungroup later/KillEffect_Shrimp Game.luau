  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy), u1 (copy)
    local TargetCharacter = p2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local CFrame2 = HumanoidRootPart.CFrame;
    task.delay(2.5, EffectsHandler.CallEffect, "FadeCharacter", TargetCharacter, 0.5);

    for i = 1, 7 do
        local v3 = math.lerp(0.7853981633974483, -0.7853981633974483, i / 7);
        local v4 = CFrame2 * CFrame.Angles(0, 1.4612058853906016, 0) * CFrame.new(math.cos(v3) * 20, 0, math.sin(v3) * 20);
        local v5 = i == 4;
        local u6 = AssetHandler.CloneAsset("Shrimp Game/" .. (v5 and "Frontman" or "Officer"), {
            AbilityName = "KillEffects"
        }):Clone();
        u6:PivotTo(CFrame.new(v4.Position, HumanoidRootPart.Position));
        u6.Parent = workspace.Effects;

        for _, descendant in u6:GetDescendants() do
            if descendant:isA("BasePart") then
                local Transparency = descendant.Transparency;
                descendant.Transparency = 1;
                TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = Transparency
                }):Play();
            end;
        end;

        if not v5 then
            task.spawn(function() -- Line: 50
                -- upvalues: u1 (ref), TargetCharacter (copy), AssetHandler (ref), u6 (copy), TweenService (ref), EffectsHandler (ref)
                local v7 = os.clock();
                local v8 = 1.5833333333333333 + u1:NextNumber(-0.2, 0.05);

                while os.clock() - v7 <= v8 do
                    local v9 = TargetCharacter.Torso.CFrame * CFrame.new(u1:NextNumber(-1, 1), u1:NextNumber(-2, 2), 0);
                    local u10 = AssetHandler.CloneAsset("Shrimp Game/Bullet", {
                        AbilityName = "KillEffects"
                    });
                    u10.CFrame = CFrame.new(u6.Gun.Tip.Position, v9.Position) * CFrame.Angles(3.141592653589793, 0, 0);
                    u10.Parent = workspace.Effects;
                    local v11 = TweenService:Create(u10, TweenInfo.new(u1:NextNumber(0.05, 0.11), Enum.EasingStyle.Linear), {
                        Position = v9.Position
                    });
                    v11.Completed:Connect(function() -- Line: 64
                        -- upvalues: u10 (copy)
                        for _, descendant in u10:GetDescendants() do
                            if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
                                descendant.Enabled = false;
                            end;
                        end;

                        u10.Transparency = 1;
                        task.delay(1.5, u10.Destroy, u10);
                    end);
                    v11:Play();

                    if math.random(1, 11) == 1 then
                        EffectsHandler.CallEffect("Blood Rays", {
                            Origin = CFrame.new(v9.Position),
                            TrailRange = NumberRange.new(4, 7)
                        });
                    end;

                    EffectsHandler.Wait(u1:NextNumber(0.04, 0.09));
                end;

                for _, descendant in u6:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;

        task.delay(2.083333333333333, function() -- Line: 96
            -- upvalues: u6 (copy), TweenService (ref)
            for _, descendant in u6:GetDescendants() do
                if descendant:IsA("BasePart") or (descendant:IsA("Texture") or descendant:IsA("Decal")) then
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Transparency = 1
                    }):Play();
                end;
            end;

            task.delay(1, u6.Destroy, u6);
        end);
    end;
end;