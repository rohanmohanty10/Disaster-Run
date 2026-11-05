  

 

game:GetService("RunService");
game:GetService("TweenService");
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Petal = _G.Petal;
Petal("New");
local Tween = Petal("Util").Tween;

return function(p1) -- Line: 12
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), Tween (copy)
    local TargetCharacter = p1.TargetCharacter;
    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");

    if not (HumanoidRootPart and TargetCharacter) then
        return;
    end;

    local v2 = TargetCharacter:FindFirstChild("Right Leg");

    if not v2 then
        return;
    end;

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;

            if child == HumanoidRootPart then
                child.Anchored = true;
            end;

            if child.Name == "Left Leg" then
                child.Anchored = true;
                child.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.5, -2, 0);
            elseif child.Name == "Right Leg" then
                child.Anchored = true;
                child.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.5, -2, 0);
            end;
        end;
    end;

    local v3 = v2.CFrame * CFrame.new(-0.5, 2, 0);
    local v4 = TargetCharacter:GetScale() or 1;
    local u5 = AssetHandler.CloneAsset("Sussy/Bone", {
        AbilityName = "KillEffects"
    });
    u5.Parent = TargetCharacter;
    u5.Size = u5.Size * v4;
    u5.CFrame = v3 * CFrame.new(0, -1.5 * v4, 0) * CFrame.Angles(1.5707963267948966, 0, 1.5707963267948966);
    local u6 = AssetHandler.CloneAsset("Sussy/Kill", {
        AbilityName = "KillEffects"
    });
    u6.Parent = HumanoidRootPart;
    u6:Play();

    for _, descendant in TargetCharacter:GetDescendants() do
        if descendant:IsA("Decal") or (descendant:IsA("Texture") or descendant:IsA("BasePart")) then
            if descendant.Name ~= "Left Leg" and (descendant.Name ~= "Right Leg" and descendant ~= u5) then
                descendant.Transparency = 1;
                ParticleHandler.EnableAllParticles(descendant, false);
            end;
        elseif descendant:IsA("JointInstance") and descendant.Name == "Left Hip" or descendant.Name == "Right Hip" then
            descendant.Transform = CFrame.identity;
        elseif descendant:IsA("Animator") then
            descendant:Destroy();
        end;
    end;

    EffectsHandler.CallEffect("Blood Rays", {
        SpeedScale = 2.25,
        Origin = v3,
        TrailRange = NumberRange.new(10, 14)
    });
    task.delay(1.5, function() -- Line: 68
        -- upvalues: u5 (ref), TargetCharacter (copy), Tween (ref), u6 (ref)
        if u5 and (u5.Parent and TargetCharacter.Parent) then
            Tween(u5, 1, "Linear", "InOut", {
                Transparency = 1
            });
            task.wait(1);
            u5:Destroy();
            u6:Destroy();
        end;

        u6 = nil;
        u5 = nil;
    end);
end;