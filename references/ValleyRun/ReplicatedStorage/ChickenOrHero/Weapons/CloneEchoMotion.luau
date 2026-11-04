 

 

local u1 = {};
local v2 = {};

for i = 0, 20 do
    local v3 = i / 20 * 0.7 + 0.3;
    u1[i] = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.12, v3),
        NumberSequenceKeypoint.new(0.8, (math.min(1, v3 + 0.08))),
        NumberSequenceKeypoint.new(1, 1)
    });
    local _ = i;
end;

function v2.build(p4) -- Line: 14
    if p4:GetAttribute("CloneEchoVersion") ~= 2 then
        return nil;
    end;

    local v5 = {
        part = p4,
        orbits = {},
        echoes = {},
        phase = (p4.Position.X * 0.37 + p4.Position.Z * 0.21) % 6.283185307179586
    };

    for i = 1, 2 do
        local v6 = p4:FindFirstChild("SurgeOrbit" .. i .. "Start");
        local v7 = p4:FindFirstChild("SurgeOrbit" .. i .. "End");
        local v8 = p4:FindFirstChild("SurgeOrbit" .. i .. "Core");
        local v9 = p4:FindFirstChild("SurgeOrbit" .. i .. "Glow");

        if not (v6 and (v7 and (v8 and v9))) then
            return nil;
        end;

        table.insert(v5.orbits, {
            a = v6,
            b = v7,
            core = v8,
            glow = v9,
            radius = i == 1 and 0.97 or 0.88,
            tilt = i == 1 and 0.35 or -0.55,
            direction = i == 1 and 1 or -1
        });
        local v10 = {
            points = {},
            beams = {},
            side = i == 1 and -1 or 1
        };
        local v11 = i;

        for i2 = 1, 5 do
            local v12 = p4:FindFirstChild("BladeEcho" .. v11 .. "Point" .. i2);

            if not v12 then
                return nil;
            end;

            local points = v10.points;
            local v13 = {
                attachment = v12,
                rest = v12:GetAttribute("EchoRestPosition")
            };
            table.insert(points, v13);
            local _ = i2;
        end;

        for i2 = 1, 4 do
            local v14 = p4:FindFirstChild("BladeEcho" .. v11 .. "Edge" .. i2);

            if not v14 then
                return nil;
            end;

            table.insert(v10.beams, v14);
            local _ = i2;
        end;

        table.insert(v5.echoes, v10);
    end;

    return v5;
end;

function v2.step(p15, p16, p17, p18) -- Line: 39
    -- upvalues: u1 (copy)
    local part = p15.part;

    if not (p17 and (part.Parent and p15.orbits[1].core.Enabled)) then
        return;
    end;

    if (p17.CFrame.Position - part.Position).Magnitude > (p18 < 1 and 38 or 58) then
        return;
    end;

    local v19, v20 = p17:WorldToViewportPoint(part.Position);

    if not v20 or v19.Z <= 0 then
        return;
    end;

    local v21 = part.Size.X / 0.12;
    local v22 = p16 + p15.phase;

    for i, v in p15.orbits do
        local v23 = v22 * 1.9 * v.direction + (i - 1) * 3.141592653589793;
        local u24 = v.radius * v21;
        local u25 = CFrame.new(0, 0.12 * v21, 0.03 * v21) * CFrame.Angles(v.tilt + math.sin(v22 * 0.8 + i) * 0.18, 0, 0);

        local function pose(p26, p27) -- Line: 53
            -- upvalues: u24 (copy), u25 (copy)
            local v28 = math.cos(p27) * u24;
            local v29 = math.sin(p27) * u24;
            local Vector3_new_ret = Vector3.new(v28, v29, 0);
            local v30 = -math.sin(p27);
            local math_cos_ret = math.cos(p27);
            local Vector3_new_ret2 = Vector3.new(v30, math_cos_ret, 0);
            p26.CFrame = u25 * CFrame.fromMatrix(Vector3_new_ret, Vector3_new_ret2, Vector3.new(0, 0, 1), Vector3_new_ret2:Cross(Vector3.new(0, 0, 1)));
        end;

        pose(v.a, v23);
        pose(v.b, v23 + 2.4085543677521746);

        if p15.scale ~= v21 then
            local v31 = 0.9163746114688174 * u24;
            v.core.CurveSize0 = v31;
            v.core.CurveSize1 = v31;
            v.glow.CurveSize0 = v31;
            v.glow.CurveSize1 = v31;
        end;
    end;

    p15.scale = v21;

    for i, v in p15.echoes do
        local v32 = (v22 * 0.62 + (i - 1) * 0.5) % 1;
        local math_sin_ret = math.sin(v32 * 3.141592653589793);
        local v33 = CFrame.new(v.side * (0.15 + v32 * 0.5) * v21, v32 * 0.15 * v21, 0.07 * v21) * CFrame.Angles(0, 0, v.side * v32 * 0.08);
        local v34 = v;

        for _, v3 in v.points do
            v3.attachment.CFrame = v33 * CFrame.new(v3.rest * v21);
        end;

        local math_floor_ret = math.floor((1 - math_sin_ret) * 20 + 0.5);
        local math_clamp_ret = math.clamp(math_floor_ret, 0, 20);

        if v34.fade ~= math_clamp_ret then
            v34.fade = math_clamp_ret;

            for _, v3 in v34.beams do
                v3.Transparency = u1[math_clamp_ret];
            end;
        end;
    end;
end;

return table.freeze(v2);