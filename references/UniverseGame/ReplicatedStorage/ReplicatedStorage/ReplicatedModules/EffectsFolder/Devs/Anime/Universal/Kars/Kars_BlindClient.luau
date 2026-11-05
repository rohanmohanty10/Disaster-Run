  

 

local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 10
    -- upvalues: TweenService (copy)
    local BloomEffect = Instance.new("BloomEffect");
    BloomEffect.Name = "Kars Blind Bloom";
    BloomEffect.Parent = game.Lighting;
    task.delay(p1, BloomEffect.Destroy, BloomEffect);
    local u2 = p1 * 0.25;
    TweenService:Create(BloomEffect, TweenInfo.new(u2), {
        Intensity = 1000,
        Threshold = -1
    }):Play();
    task.delay(p1 * 0.5, function() -- Line: 24
        -- upvalues: TweenService (ref), BloomEffect (copy), u2 (copy)
        TweenService:Create(BloomEffect, TweenInfo.new(u2), {
            Intensity = 0,
            Size = 0,
            Threshold = 2
        }):Play();
    end);
end;