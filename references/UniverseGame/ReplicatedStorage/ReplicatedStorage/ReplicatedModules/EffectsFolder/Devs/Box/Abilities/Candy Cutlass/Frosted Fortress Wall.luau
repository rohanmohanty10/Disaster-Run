  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local Character = p1.Character;

    if Character == nil then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local u2 = {
        AbilityName = "Candy Cutlass",
        SkinName = AssetHandler.GetAbilityData(Character).SkinName
    };
    local u3 = AssetHandler.CloneAsset("Particles/FrostedFortress/IceWall", u2);
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 1.7, -12.5);
    u3.Parent = workspace.Effects;
    TweenService:Create(u3, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = Vector3.new(14.148, 9.385, 4.556)
    }):Play();
    local u4 = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, -12.5);
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Origin = u4,
        Particle = AssetHandler.GetAsset("Particles/FrostedFortress/WallSummon", u2)
    });
    u3.Transparency = 0;
    task.delay(1.22, function(p5) -- Line: 35
        -- upvalues: EffectsHandler (ref), u4 (copy), AssetHandler (ref), u2 (ref), TweenService (ref), u3 (copy)
        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            Origin = u4,
            Particle = AssetHandler.GetAsset("Particles/FrostedFortress/WallSummon", u2)
        });
        TweenService:Create(u3, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.In), {
            Size = Vector3.new()
        }):Play();
        task.delay(0.3, u3.Destroy, u3);
    end);
end;