  

 

local Debris = game:GetService("Debris");

return function(p1, p2) -- Line: 2
    -- upvalues: Debris (copy)
    local v3 = p1.CFrame * CFrame.new(0, 5.5, 0);
    local v4 = CFrame.new(v3.Position, v3.Position + p2);
    local Part = Instance.new("Part");
    Part.CFrame = v4;
    Part.Anchored = true;
    require(game.StarterPlayer.StarterPlayerScripts.Output.EffectsTable)["Emit Particle V2"]({
        ParticleName = "SCRicochetSurface",
        Part = Part,
        Offset = CFrame.new(0, 0, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
    });
    Debris:AddItem(Part, 3);
end;