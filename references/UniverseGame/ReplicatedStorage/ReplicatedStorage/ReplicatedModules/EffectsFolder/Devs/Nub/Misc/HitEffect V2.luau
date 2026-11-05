  

 

local ParticleInfo = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: ParticleInfo (copy), EffectsHandler (copy)
    if not (p1 and p1:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    local v5 = nil;
    local v6 = nil;

    if type(p4) == "table" then
        v5 = p4;
        p4 = p4.ParticleName;
    elseif type(p4) == "string" then
        v5 = {};
    else
        p4 = v6;
    end;

    local v7 = game.Players:GetPlayerFromCharacter(p2);
    local v8 = p2:FindFirstChild("Torso") or p2.PrimaryPart;

    if not v8 then
        return;
    end;

    local v9 = p1:FindFirstChild("Torso") or p1.PrimaryPart;

    if not v9 then
        return;
    end;

    ParticleInfo.GetParticleInfo(p4);
    local CFrame2 = v8.CFrame;
    local CFrame3 = v9.CFrame;

    if v5.LookAt == "Attacker" then
        CFrame3 = CFrame.new(CFrame3.Position, CFrame2.Position);
    elseif v5.LookAt == "Target" then
        CFrame3 = CFrame.new(CFrame2.Position, CFrame3.Position);
    end;

    if v5.Offset then
        CFrame3 = CFrame3 * v5.Offset;
    end;

    local v10 = EffectsHandler.GetEffect("Emit Particle V3");
    local v11 = {
        Origin = CFrame3,
        Particle = v5.Particle,
        ParticleName = p4
    };

    if v7 then
        v7 = v7.Data.Skin:GetAttribute("SkinName");
    end;

    v11.SkinName = v7;
    v11.HueShift = v5.HueShift;
    v10(v11);
end;