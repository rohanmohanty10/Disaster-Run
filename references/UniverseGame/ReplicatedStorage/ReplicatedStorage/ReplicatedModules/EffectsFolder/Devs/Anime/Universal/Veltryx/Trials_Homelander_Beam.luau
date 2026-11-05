  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 19
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy), EffectsHandler (copy)
    local v3 = p2 or {};
    local Model = v3.Model;
    local Duration = v3.Duration;
    local Origin = v3.Origin;

    if not Model then
        return;
    end;

    local v4 = {
        AbilityName = "UGrain"
    };
    local v5 = AssetHandler.CloneAsset("Particles/ScorchedEarth/HeadLaser", v4);
    v5.Parent = Model;
    ParticleHandler.AttachTo(v5, {
        Part = Model:WaitForChild("Head")
    });
    ParticleHandler.Unusualify(v5, v4);
    ParticleHandler.EnableAllParticles(v5.HeadFX, true);
    local v6 = AssetHandler.CloneAsset("Particles/ScorchedEarth/Impact", v4);
    v6.CFrame = CFrame.new(Origin);
    v6.BodyPosition.Position = Origin;
    ParticleHandler.Unusualify(v6, v4);
    v6.Parent = workspace.Effects;
    v6:SetAttribute("Active", true);

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Attachment1 = v6.Hit;
        end;
    end;

    local Position = v6.Hit.Position;
    v6.Hit.WorldPosition = Model.Head.Position;
    task.wait(0.05);
    ParticleHandler.EnableAllParticles(v5.Laser, true);
    ParticleHandler.EnableAllParticles(v6, true);
    TweenService:Create(v6.Hit, TweenInfo.new(0.08333333333333333, Enum.EasingStyle.Linear), {
        Position = Position
    }):Play();
    local v7 = os.clock();

    while Model:IsDescendantOf(game) and (v6:IsDescendantOf(game) and os.clock() - v7 <= Duration) do
        EffectsHandler.Wait(0.04);
    end;

    v6:SetAttribute("Active", false);
    ParticleHandler.EnableAllParticles(v5.Laser, false);

    if v6:FindFirstChild("BodyPosition") then
        v6.BodyPosition:Destroy();
    end;

    v6.Anchored = true;
    TweenService:Create(v6.Hit, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Linear), {
        WorldPosition = Model.Head.Position
    }):Play();
    task.wait(0.13333333333333333);
    ParticleHandler.EnableAllParticles(v6, false);
    ParticleHandler.DestroyEmit(v6);
    ParticleHandler.DestroyEmit(v5);
    ParticleHandler.EnableVFX(v5, false, { "ParticleEmitter", "Trail" });
end;