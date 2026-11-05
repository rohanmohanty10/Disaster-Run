  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
ReplicatedStorage:FindFirstChild("Client Assets");
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
Random.new();

return function(p1) -- Line: 13
    -- upvalues: EffectsHandler (copy), TweenService (copy), AssetHandler (copy)
    local v2 = p1 or {};
    local Character = v2.Character;

    if not Character then
        return;
    end;

    local v3 = v2.Sound and v2.Sound:Clone();
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
    local v4 = Character:Clone();
    v4.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame;
    v4.Parent = workspace.Effects;
    v4.Humanoid.BreakJointsOnDeath = false;
    v4.Humanoid.EvaluateStateMachine = false;
    v4.Humanoid.RequiresNeck = false;
    v4.Humanoid.AutomaticScalingEnabled = false;

    if v3 then
        v3.Parent = v4.HumanoidRootPart;
        v3:Play();
    end;

    task.delay(8, v4.Destroy, v4);

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BillboardGui") or (descendant:IsA("Script") or (descendant:IsA("Decal") or (descendant:IsA("Texture") or (descendant:IsA("Motor6D") or (descendant:IsA("Weld") or descendant:IsA("Sound")))))) then
            descendant:Destroy();
        end;
    end;

    for _, child in v4:GetChildren() do
        if child:IsA("BasePart") then
            child.CFrame = child.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
            BodyVelocity.Velocity = child.CFrame.LookVector * math.random(20, 30);
            BodyVelocity.Parent = child;
            task.delay(math.random(25, 42) / 100, BodyVelocity.Destroy, BodyVelocity);
            child.CollisionGroup = "Ghosted";
            child.CanCollide = true;
            TweenService:Create(child, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 5), {
                Size = Vector3.new(0, 0, 0)
            }):Play();

            for _, child2 in AssetHandler.GetAsset("Particles/LimbBlood", {
                AbilityName = "UGrain"
            }):GetChildren() do
                child2:Clone().Parent = child;
            end;

            task.delay(5, function() -- Line: 79
                -- upvalues: child (copy)
                for _, descendant in child:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;
    end;

    for _, descendant in Character:GetDescendants() do
        if descendant:IsA("BillboardGui") or (descendant:IsA("Script") or descendant:IsA("Decal")) then
            descendant:Destroy();
        elseif descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        end;
    end;
end;