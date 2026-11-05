  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();

return function(p1) -- Line: 14
    -- upvalues: EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Character = v2.Character;
    local Duration = v2.Duration;

    if not Character then
        return;
    end;

    local v3 = Character:Clone();
    v3.Parent = workspace.Effects;
    task.delay(Duration + 8, v3.Destroy, v3);

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BillboardGui") or (descendant:IsA("Script") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Motor6D") or (descendant:IsA("Weld") or descendant:IsA("Accessory")))))) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Anchored = true;
        end;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/BloodBurst",
        AbilityName = "UGrain",
        AutoSerialize = true,
        Origin = Character.HumanoidRootPart.CFrame
    });
    EffectsHandler.CallEffect("Blood Rays", {
        SpeedScale = 1.85,
        Part = Character.HumanoidRootPart,
        TrailRange = NumberRange.new(15, 20)
    });
    local v4 = AssetHandler.CloneAsset("Models/SkeletonHead", {
        AbilityName = "UGrain"
    });
    v4.Parent = Character;
    ParticleHandler.AttachTo(v4, {
        Part = Character.Head
    });
    local v5 = TweenInfo.new(Duration * 0.75, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, Duration * 0.25);

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") or descendant:IsA("Decal") then
            descendant.Transparency = 1;
            TweenService:Create(descendant, v5, {
                Transparency = 0
            }):Play();
        end;
    end;

    TweenService:Create(Character.Head, v5, {
        Transparency = 1
    }):Play();
    TweenService:Create(v4, TweenInfo.new(1), {
        CFrame = Character.Head.CFrame * CFrame.new(0, 50, -50)
    }):Play();
end;