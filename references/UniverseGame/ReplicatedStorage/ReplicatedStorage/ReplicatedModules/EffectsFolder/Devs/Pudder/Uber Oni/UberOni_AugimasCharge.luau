  

 

game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local _ = PathShortcuts.ClientAssets;
local v1 = game.ReplicatedStorage["Client Assets"];
local _ = v1.Assets.Abilities["Uber Oni"].Particles["Limb Trail"];
local _ = v1.Assets.Abilities["Uber Oni"].Particles.Augimas;
local _ = workspace.CurrentCamera;
Random.new();

return function(p2) -- Line: 17
    -- upvalues: ParticleHandler (copy), TweenService (copy)
    local Object = p2.Object;
    local v3 = TweenInfo.new(p2.Time);
    local Y = Object.Size.Y;
    Object.Size = Vector3.new(0.1, 0.1, 0.1);
    local v4 = Y / 0.1;
    ParticleHandler.ScaleParticle(Object, 0.1 / Y);
    TweenService:Create(Object, v3, {
        Size = Vector3.new(2, 2, 2)
    }):Play();

    for _, descendant in Object:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            ParticleHandler.TweenScale(descendant, v4, v3);
        end;
    end;
end;