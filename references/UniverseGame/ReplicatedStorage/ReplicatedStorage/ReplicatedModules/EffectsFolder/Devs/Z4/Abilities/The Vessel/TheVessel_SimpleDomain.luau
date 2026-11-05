  

 

game:GetService("TweenService");
game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2, p3) -- Line: 9
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    if not (p1 or p1:GetAttribute("DomainImmunity")) then
        return;
    end;

    local v4 = p3 or {};
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local v5 = AssetHandler.CloneAsset("Particles/SimpleDomain", {
        AbilityName = "The Vessel",
        SkinName = p2
    });

    if v4.HSVShift then
        ParticleHandler.HSVShiftParticles(v5, v4.HSVShift);
    end;

    v5.Parent = Model;
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    Model:ScaleTo(0.05);
    ParticleHandler.EnableAllParticles(v5, true);
    local v6 = 0.0025;

    while Model:GetScale() < 1 do
        v6 = v6 + 0.0001;
        Model:ScaleTo(Model:GetScale() + 0.01);
        task.wait(v6);
    end;

    repeat
        task.wait(0.1);
    until not (p1.Parent and p1:GetAttribute("DomainImmunity"));

    while Model:GetScale() > 1e-7 do
        Model:ScaleTo(Model:GetScale() - 0.01);
        task.wait(0.01);
    end;

    Model:Destroy();
end;