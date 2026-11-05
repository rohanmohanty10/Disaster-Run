  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContentProvider = game:GetService("ContentProvider");

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: ReplicatedStorage (copy), ContentProvider (copy)
    local v5 = p3 or {};
    local v6 = (v5.InfoTable or {}).Effects or p4;

    if v6[1] then
        v6 = {};

        for _, v in ipairs(v6) do
            v6[v] = {};
        end;
    end;

    local v7 = {
        Blunt = { 7284685183, 7284685727, 7284691039, 7284691722, 7284692216, 7284692603 },
        ArcadeHitEffect = { 7290888208, 7290893243, 7290897295, 7290899998 },
        ArcadeBlood = { 7290890288, 7290891678, 7290898926, 7290901319 },
        HitEffect1 = { 7289938120, 7289939205, 7289940301, 7289940301, 7289942646, 7289943984, 7289945177, 7289945951 },
        BarragekurEffect = { 7306310331, 7306316403, 7306324682, 7306388582, 7306389506, 7306390366, 7306391232, 7306400362 },
        BloodSplatter = { 7301900582, 7301904440, 7301906200, 7301907651, 7301909777, 7301911494, 7301913007, 7301920448, 7301924634, 7301931403 },
        CutHit = { 7285009066, 7285010077, 7285010970, 7285203137, 7285012633, 7285013371, 7285014455, 7285014760, 7285015108, 7285015621, 7285015965, 7285016305, 7285016560, 7285016871 },
        Bleed = { 7265586448, 7265588879, 7265589954, 7265591299, 7265593105, 7265594749 }
    };

    for i, v in pairs(v6) do
        local v8 = ReplicatedStorage["Client Assets"]["Hit Effects"].Frames:Clone();
        local Particle = v8.Particle;
        local v9;

        if v5 and (v5.Source and v5.Source.CFrame) then
            v9 = v5.Source.CFrame;
        elseif p1 and p1:FindFirstChild("Torso") then
            v9 = p1.Torso.CFrame;
        else
            v9 = nil;
        end;

        if v9 ~= nil then
            v8.CFrame = v9;
        end;

        v8.Parent = workspace.Effects;
        game.Debris:AddItem(v8, 3);
        local u10 = v.Size or NumberSequence.new({ NumberSequenceKeypoint.new(0, 3.5), NumberSequenceKeypoint.new(1, 3.5) });
        local u11 = v.LightEmission or 0;
        local _ = v.TimeScale;
        local _ = v.Speed;
        local _ = v.RotSpeed;
        local _ = v.Rotation;
        local u12 = math.random(-180, 180);
        local u13 = {};

        for i2 = 1, #v7[i] do
            table.insert(u13, "rbxassetid://" .. v7[i][i2]);
        end;

        ContentProvider:PreloadAsync(u13, function() -- Line: 125, Name: spawnEffect
            -- upvalues: u13 (copy), Particle (copy), u10 (copy), u11 (copy), u12 (copy)
            coroutine.wrap(function() -- Line: 126
                -- upvalues: u13 (ref), Particle (ref), u10 (ref), u11 (ref), u12 (ref)
                for i2 = 1, #u13 do
                    Particle.Size = u10;
                    Particle.LightEmission = u11;
                    Particle.Texture = u13[i2];
                    Particle.Lifetime = NumberRange.new(i2 / 75 + 0.1);
                    Particle.Rotation = NumberRange.new(u12);
                    Particle:Emit(1);
                    task.wait(i2 / 250 + -0.1);
                end;
            end)();
        end);
    end;
end;