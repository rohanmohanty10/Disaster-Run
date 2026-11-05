  

 

require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleInfo);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 3
    -- upvalues: EffectsHandler (copy)
    local Target = p1.Target;
    local Attacker = p1.Attacker;

    if not (Target and Target:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    local v2 = p1.PartName or "Torso";
    local v3 = game.Players:GetPlayerFromCharacter(Attacker);
    local v4 = Attacker:FindFirstChild(v2) or Attacker.PrimaryPart;
    local v5 = Target:FindFirstChild(v2) or Target.PrimaryPart;

    if not (v4 and v5) then
        return;
    end;

    local CFrame2 = v4.CFrame;
    local CFrame3 = v5.CFrame;

    if p1.LookAt == "Attacker" then
        CFrame3 = CFrame.new(CFrame3.Position, CFrame2.Position);
    elseif p1.LookAt == "Target" then
        CFrame3 = CFrame.new(CFrame2.Position, CFrame3.Position);
    end;

    if p1.Offset then
        CFrame3 = CFrame3 * p1.Offset;
    end;

    if p1.Color then
        p1.Particle = p1.Particle:Clone();
        p1.Clone = false;
        local v6 = typeof(p1.Color) == "ColorSequence" and p1.Color or ColorSequence.new(p1.Color);

        for _, descendant in ipairs(p1.Particle:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                descendant.Color = v6;
            end;
        end;
    end;

    EffectsHandler.GetEffect("Emit Particle V3")({
        Origin = CFrame3,
        Particle = p1.Particle,
        ParticleName = p1.ParticleName,
        Character = Attacker,
        Player = v3,
        RawPath = p1.RawPath,
        PathFolder = p1.PathFolder,
        HueShift = p1.HueShift,
        Clone = p1.Clone,
        Path = p1.Path,
        AbilityName = p1.AbilityName,
        IgnoreUnusuals = p1.IgnoreUnusuals,
        Scale = p1.Scale
    });
end;