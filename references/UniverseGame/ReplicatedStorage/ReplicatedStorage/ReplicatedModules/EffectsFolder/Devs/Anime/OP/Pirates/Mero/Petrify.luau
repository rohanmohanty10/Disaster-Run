  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();

return function(p1, p2, p3) -- Line: 13
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v4 = {
        AbilityName = "Mero",
        SkinName = (p2 and (AssetHandler.GetAbilityData(p2) or {}) or {}).SkinName
    };
    local Petrify = p2:FindFirstChild("Petrify", true);

    if Petrify then
        EffectsHandler.CallEffect("Q_PLAY_SOUND", Petrify, p1.HumanoidRootPart.Position);
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Misc/Petrify",
        AutoSerialize = true,
        Origin = p1.HumanoidRootPart.CFrame,
        Player = game.Players:GetPlayerFromCharacter(p2),
        AbilityName = v4.AbilityName,
        SkinName = v4.SkinName,
        PlaySounds = Petrify == nil
    });
    local v5 = AssetHandler.CloneAsset("Models/Petrification", v4);
    v5.Parent = p1;
    v5:ScaleTo(p1:GetScale() * v5:GetScale());

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            if p1:FindFirstChild(descendant.Name) then
                local Weld = Instance.new("Weld");
                Weld.Part0 = descendant;
                Weld.Part1 = p1[descendant.Name];
                Weld.Parent = v5;
            else
                descendant.Transparency = 1;
                TweenService:Create(descendant, TweenInfo.new(0.45, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 0.1
                }):Play();
            end;
        end;
    end;

    local v6 = os.clock();

    repeat
        task.wait(0.1);
    until typeof(p3) == "Instance" and not p3:IsDescendantOf(game) or typeof(p3) == "number" and p3 <= os.clock() - v6;

    if not v5:IsDescendantOf(game) then
        return;
    end;

    v5.Parent = workspace.Effects;
    local Unpetrify = p2:FindFirstChild("Unpetrify", true);

    if Unpetrify then
        EffectsHandler.CallEffect("Q_PLAY_SOUND", Unpetrify, p1.HumanoidRootPart.Position);
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Misc/PetrifiedExplosion",
        Origin = p1.HumanoidRootPart.CFrame,
        PlaySounds = Unpetrify == nil,
        AbilityName = v4.AbilityName,
        SkinName = v4.SkinName
    });

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("Weld") or (descendant:IsA("WeldConstraint") or descendant:IsA("ManualWeld")) then
            descendant:Destroy();
        end;
    end;

    for i, descendant in v5:GetDescendants() do
        if descendant:IsA("BasePart") then
            if i % 3 == 0 then
                descendant:Destroy();
            else
                descendant.CFrame = descendant.CFrame * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360));
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.MaxForce = Vector3.new(10000000, 1000, 100000);
                BodyVelocity.Velocity = descendant.CFrame.LookVector * math.random(20, 30);
                BodyVelocity.Parent = descendant;
                task.delay(0.15, BodyVelocity.Destroy, BodyVelocity);
                descendant.CollisionGroup = "Ghosted";
                descendant.CanCollide = true;
                TweenService:Create(descendant, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 2.5), {
                    Size = Vector3.new(0, 0, 0)
                }):Play();
            end;
        end;
    end;

    task.wait(3);
    v5:Destroy();
end;