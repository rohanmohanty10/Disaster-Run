  

 

local v1 = script:FindFirstAncestor("ReplicatedModules");
local EffectsHandler = require(v1.EffectsHandler);

return function(p2, p3, p4) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local v5 = game.ReplicatedStorage["Client Assets"].Universal.Universal_HitVFX:Clone();
    local v6 = EffectsHandler.GetEffect("Emit Particle V3");
    local CFrame2 = p2.Torso.CFrame;
    local HitData = p4.HitData;

    if HitData and HitData.Color then
        local v7 = typeof(HitData.Color) == "ColorSequence" and HitData.Color or ColorSequence.new(HitData.Color);

        for _, descendant in ipairs(v5:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = v7;
            end;
        end;
    end;

    v6({
        Clone = false,
        AutoSerialize = true,
        Origin = CFrame.lookAt(CFrame2.Position, p3.Torso.CFrame.Position),
        Particle = v5
    });
end;