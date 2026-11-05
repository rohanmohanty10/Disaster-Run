  

 

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
    local v3 = Random.new();
    local HumanoidRootPart = TargetCharacter.HumanoidRootPart;
    local CFrame2 = HumanoidRootPart.CFrame;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            for _ = 1, math.random(2, 3) do
                local v4 = AssetHandler.GetAsset("Web Shred/Webs", {
                    AbilityName = "KillEffects"
                });
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = workspace.Terrain;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = workspace.Terrain;
                local Position = child.Position;
                local v5 = v3:NextNumber(-8, 8);
                local v6 = v3:NextNumber(0.5, 8);
                Attachment2.WorldPosition = Position + Vector3.new(v5, v6, v3:NextNumber(-8, 8));
                local Position2 = child.Position;
                local v7 = v3:NextNumber(-child.Size.X / 2, child.Size.X / 2);
                local v8 = v3:NextNumber(-child.Size.Y / 2, child.Size.Y / 2);
                local v9 = Position2 + Vector3.new(v7, v8, v3:NextNumber(-child.Size.Z / 2, child.Size.Z / 2));
                Attachment.WorldPosition = Attachment2.WorldPosition;
                local v10 = v3:NextNumber(0.09, 0.27);
                TweenService:Create(Attachment, TweenInfo.new(v10 * 0.5, Enum.EasingStyle.Linear), {
                    WorldPosition = v9
                }):Play();
                local v11 = v3:NextNumber(4, 6.5) * (math.random(1, 2) == 1 and 1 or -1);
                local v12 = v3:NextNumber(4, 6.5) * (math.random(1, 2) == 1 and 1 or -1);

                for _, child2 in v4:GetChildren() do
                    local v13 = child2:Clone();
                    v13.Attachment0 = Attachment;
                    v13.Attachment1 = Attachment2;
                    v13.Parent = Attachment;
                    v13.CurveSize0 = v11;
                    v13.CurveSize1 = v12;
                    TweenService:Create(v13, TweenInfo.new(v10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        CurveSize0 = 0,
                        CurveSize1 = 0
                    }):Play();
                end;

                task.delay(1, function() -- Line: 69
                    -- upvalues: TweenService (ref), Attachment (copy), Attachment2 (copy)
                    TweenService:Create(Attachment, TweenInfo.new(0.15), {
                        WorldPosition = Attachment2.WorldPosition
                    }):Play();
                    task.delay(1, Attachment.Destroy, Attachment);
                    task.delay(1, Attachment2.Destroy, Attachment2);
                end);
            end;
        end;
    end;

    EffectsHandler.Wait(1);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Web Shred/Shred",
        AbilityName = "KillEffects",
        Origin = CFrame2
    });
    EffectsHandler.CallEffect("FadeCharacter", TargetCharacter);
end;