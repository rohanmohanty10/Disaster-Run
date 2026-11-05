  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 8
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local TargetCharacter = v2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local _ = { v2.KillerPlayer, game.Players:GetPlayerFromCharacter(TargetCharacter) };
    Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    for i = 0, 24 do
        local v3 = math.acos(1 - i / 24 * 2);
        local v4 = 9.79559267269995 * i;
        local v5 = {
            X = math.sin(v3) * math.cos(v4) * 7.5,
            Y = math.sin(v3) * math.sin(v4) * 7.5,
            Z = math.cos(v3) * 7.5
        };
        local v6 = Vector3.new(v5.X, v5.Y, v5.Z);
        local v7 = HumanoidRootPart.Position + v6;
        local u8 = AssetHandler.CloneAsset("Knife Checkmate/Knife", {
            AbilityName = "KillEffects"
        });
        u8.CFrame = CFrame.new(v7, HumanoidRootPart.Position);
        u8.Parent = workspace.Effects;
        task.delay(0.2, function() -- Line: 53
            -- upvalues: TweenService (ref), u8 (copy), HumanoidRootPart (copy)
            local v9 = TweenService:Create(u8, TweenInfo.new(0.12, Enum.EasingStyle.Linear), {
                CFrame = u8.CFrame * CFrame.new(0, 0, -(u8.Position - HumanoidRootPart.Position).Magnitude)
            });
            v9:Play();
            v9.Completed:Connect(function() -- Line: 59
                -- upvalues: u8 (ref)
                for _, descendant in u8:GetDescendants() do
                    if descendant:IsA("BasePart") then
                        descendant.Transparency = 1;
                    end;

                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;

                u8.Transparency = 1;
                task.delay(0.75, u8.Destroy, u8);
            end);
        end);
    end;

    task.delay(0.32, function() -- Line: 78
        -- upvalues: EffectsHandler (ref), CFrame2 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Knife Checkmate/Blood",
            AbilityName = "KillEffects",
            Origin = CFrame2
        });
    end);
end;