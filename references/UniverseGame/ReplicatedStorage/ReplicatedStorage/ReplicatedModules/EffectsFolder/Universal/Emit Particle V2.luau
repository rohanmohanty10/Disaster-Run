  

 

local v1 = script:FindFirstAncestor("ReplicatedModules");
local EffectsHandler = require(v1.EffectsHandler);

return function(p2) -- Line: 4
    -- upvalues: EffectsHandler (copy)
    if not (p2.CFrame or p2.Part) then
        return;
    end;

    local v3 = p2.CFrame or p2.Part.CFrame;
    local v4 = p2.Character or p2.Player.Character;
    local CFrame2 = (v4.Torso or v4.PrimaryPart).CFrame;

    if p2.LookAt == "Attacker" then
        v3 = CFrame.new(v3.Position, CFrame2.Position);
    elseif p2.LookAt == "Target" then
        v3 = CFrame.new(CFrame2.Position, v3.Position);
    end;

    if p2.Offset then
        v3 = v3 * p2.Offset;
    end;

    local v5 = EffectsHandler.GetEffect("Emit Particle V3");
    local v6 = {
        Origin = v3,
        Particle = p2.Particle,
        ParticleName = p2.ParticleName
    };
    local v7 = p2.SkinName or p2.Player and p2.Player.Data.Skin:GetAttribute("SkinName");
    v6.SkinName = v7;
    v6.HueShift = p2.HueShift;
    v5(v6);
end;