  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local _ = PathShortcuts.ClientAssets;
game:GetService("TweenService");
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy)
    local Character = p1.Character;

    if Character == nil then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart == nil then
        return;
    end;

    local v2 = {
        AbilityName = "Candy Cutlass",
        SkinName = AssetHandler.GetAbilityData(Character).SkinName
    };
    local v3 = AssetHandler.CloneAsset("Particles/FrostedFortress/TrailProjectile", v2);
    v3.CFrame = HumanoidRootPart.CFrame;
    v3.Parent = workspace.Effects;
    local Position = (HumanoidRootPart.CFrame * CFrame.new(0, 0, -12.5)).Position;
    local v4 = Position or (HumanoidRootPart:IsA("Attachment") and HumanoidRootPart.WorldPosition or HumanoidRootPart.Position);
    local Position2 = Character["Left Arm"].Position;
    local v5 = math.random(-7, 7);
    local v6 = math.random(2, 7);
    local v7 = v4 + Vector3.new(v5, v6, math.random(-7, 7)) * 1;
    local v8 = math.random(-5, 5);
    local v9 = math.random(-5, 5);
    local v10 = v4 + Vector3.new(v8, v9, math.random(-5, 5)) * 1;

    for i = 1, 48 do
        if not v3:IsDescendantOf(game) or HumanoidRootPart and not HumanoidRootPart:IsDescendantOf(game) then
            break;
        end;

        local v11 = i / 48;
        local v12 = Position or (HumanoidRootPart:IsA("Attachment") and HumanoidRootPart.WorldPosition or HumanoidRootPart.Position);
        v3.Position = (1 - v11) ^ 3 * Position2 + 3 * (1 - v11) ^ 2 * v11 * v7 + 3 * (1 - v11) * v11 ^ 2 * v10 + v11 ^ 3 * v12;
        task.wait();
    end;

    for _, descendant in ipairs(v3:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant.Enabled = false;
        end;
    end;

    v3.Transparency = 1;
    task.delay(2.5, v3.Destroy, v3);
end;