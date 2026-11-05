  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
Petal("Extensions");

return function(u2) -- Line: 12
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), u1 (copy)
    local TargetCharacter = u2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local u3 = HumanoidRootPart.Size.Y / 2;
    local u4 = AssetHandler.CloneAsset(u2.Name .. "/Snowman", {
        AbilityName = "KillEffects"
    });
    u4.PrimaryPart.CFrame = HumanoidRootPart.CFrame;
    u4:ScaleTo(u4:GetScale() * u3);
    u4.Parent = workspace.Effects;
    EffectsHandler.CallEffect("SK_VANISH", {
        AffectStands = true,
        Transparency = 1,
        Character = TargetCharacter,
        TweenInfo = { 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In }
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        AbilityName = "KillEffects",
        Origin = HumanoidRootPart,
        Offset = CFrame.new(0, 0, 0),
        Path = u2.Name .. "/Freeze",
        Scale = u3
    });

    for _, child in u4:GetChildren() do
        if child:IsA("MeshPart") then
            u1.Tween(child, 0.25, "Quad", "In", {
                Transparency = 0
            });
        end;
    end;

    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(u2.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
    task.delay(2, function() -- Line: 50
        -- upvalues: EffectsHandler (ref), HumanoidRootPart (copy), u2 (copy), u3 (copy), u4 (copy), u1 (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            AbilityName = "KillEffects",
            Origin = HumanoidRootPart,
            Offset = CFrame.new(0, 0, 0),
            Path = u2.Name .. "/Explosion",
            Scale = u3
        });

        for _, child in u4:GetChildren() do
            if child:IsA("MeshPart") then
                u1.Tween(child, 0.325, "Quad", "Out", {
                    Transparency = 1,
                    Size = child.Size * 0.5
                });
            end;
        end;

        task.delay(0.25, function() -- Line: 65
            -- upvalues: u4 (ref)
            u4:Destroy();
        end);
    end);
end;