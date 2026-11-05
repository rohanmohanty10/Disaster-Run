  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(u2) -- Line: 11
    -- upvalues: u1 (copy), ReplicatedStorage (copy), AssetHandler (copy), TweenService (copy)
    local TargetCharacter = u2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local CFrame2 = HumanoidRootPart.CFrame;
    local Position = CFrame2:ToWorldSpace(CFrame.new(-8, 0, 2)).Position;
    local Position2 = CFrame2:ToWorldSpace(CFrame.new(8, 0, 0)).Position;
    local u3 = u2.DelayTime or 0.25;
    local u4 = u2.Duration or 2;
    local v5 = workspace:Raycast(Position, Vector3.new(0, -10, 0), u1);

    if v5 then
        Position = v5.Position;
    end;

    local v6 = workspace:Raycast(Position2, Vector3.new(0, -10, 0), u1);

    if v6 then
        Position2 = v6.Position;
    end;

    local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
    local v7 = AssetHandler.CloneAsset("Legacy Reaper/DimensionRift", {
        AbilityName = "KillEffects"
    });
    v7.Parent = workspace.Effects;
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(string.match(script.Name, "KillEffect_(.+)") .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });

    for _, child in v7:GetChildren() do
        child.CFrame = CFrame.new(Position, Position2);
        local Magnitude = (Position - Position2).Magnitude;
        local u8 = CFrame.new((Position + Position2) / 2, Position2);
        local u9 = child.Name == "Portal" and 0.1 or 0.05;

        if child.Name ~= "Portal" then
            Magnitude = Magnitude * 1.05;
        end;

        child.Size = Vector3.new(1, 1, 1) * u9;
        task.spawn(function() -- Line: 53
            -- upvalues: TweenService (ref), child (copy), u3 (copy), u8 (copy), u9 (copy), Magnitude (ref), u4 (copy)
            TweenService:Create(child, TweenInfo.new(u3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                CFrame = u8,
                Size = Vector3.new(u9, u9, Magnitude)
            }):Play();
            task.wait(u3 + 0.25);
            TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                CFrame = u8,
                Size = Vector3.new(Magnitude, u9, Magnitude)
            }):Play();
            task.wait(u4);
            TweenService:Create(child, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                CFrame = u8,
                Size = Vector3.new(Magnitude / 4, u9, Magnitude / 4)
            }):Play();
            task.wait(0.15);
            TweenService:Create(child, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                CFrame = u8,
                Size = Vector3.new(Magnitude * 2, u9, u9)
            }):Play();
        end);
    end;

    task.delay(u3 + u4 + 0.5, v7.Destroy, v7);
    task.delay(u3 + 0.1, function() -- Line: 66
        -- upvalues: EffectsHandler (copy), u2 (copy), HumanoidRootPart (copy), u4 (copy), TargetCharacter (copy)
        EffectsHandler.CallEffect("HoldProp", u2.KillerPlayer, "SkeletonArm", HumanoidRootPart, u4);
        EffectsHandler.CallEffect("EmitParticles", "Smoke", TargetCharacter.Torso, 25);
    end);
end;