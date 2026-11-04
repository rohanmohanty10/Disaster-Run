 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local v1 = {};

local function generatePath(p2, p3, p4, p5) -- Line: 6
    local v6 = { p2, p3 };

    for i = 1, p4 do
        local _ = i;
        local v7 = {};

        for i2 = 1, #v6 - 1 do
            local v8 = v6[i2];
            local v9 = (v8 + v6[i2 + 1]) / 2;
            local v10 = math.random() - 0.5;
            local v11 = math.random() - 0.5;
            local v12 = math.random() - 0.5;
            local v13 = Vector3.new(v10, v11, v12).Unit * p5;
            table.insert(v7, v8);
            table.insert(v7, v9 + v13);
            local _ = i2;
        end;

        table.insert(v7, v6[#v6]);
        v6 = v7;
    end;

    return v6;
end;

local function makePart(p14, p15, p16, p17, p18) -- Line: 28
    local Magnitude = (p15 - p14).Magnitude;

    if Magnitude < 0.01 then
        return nil;
    end;

    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.CastShadow = false;
    Part.Material = Enum.Material.Neon;
    Part.Color = p17;
    Part.Size = Vector3.new(p16, p16, Magnitude);
    Part.CFrame = CFrame.lookAt((p14 + p15) / 2, p15);
    Part.Parent = p18;

    return Part;
end;

local function buildBolt(p19, p20, p21, p22, p23, p24, p25, p26) -- Line: 45
    -- upvalues: generatePath (copy), makePart (copy)
    local v27 = generatePath(p19, p20, p21, p22);

    for i = 1, #v27 - 1 do
        local v28 = makePart(v27[i], v27[i + 1], p23, p24, p25);
        local v29;

        if v28 then
            table.insert(p26, v28);
            v29 = i;
        else
            v29 = i;
        end;
    end;

    return v27;
end;

local function spawnLightning(p30) -- Line: 54
    -- upvalues: buildBolt (copy), TweenService (copy), Debris (copy)
    local startPos = p30.startPos;
    local endPos = p30.endPos;
    local v31 = p30.iters or 5;
    local v32 = p30.offs or 4;
    local u33 = p30.lif or 0.15;
    local v34 = p30.col or Color3.fromRGB(255, 30, 30);
    local v35 = p30.wid or 0.2;
    local v36 = p30.parent or workspace;
    local v37 = p30.branchChance or 0.5;
    local v38 = p30.branchLength or 0.5;
    local u39 = p30.retract or false;
    local u40 = {};
    local v41 = buildBolt(startPos, endPos, v31, v32, v35, v34, v36, u40);

    for i = 2, #v41 - 1 do
        local v42;

        if math.random() < v37 then
            local v43 = (math.random() - 0.5) * 2;
            local v44 = (math.random() - 0.5) * 2;
            local v45 = (math.random() - 0.5) * 2;
            local Unit = Vector3.new(v43, v44, v45).Unit;
            local v46 = v32 * v38 * (2 + math.random() * 3);
            local v47 = v41[i] + Unit * v46;
            buildBolt(v41[i], v47, math.max(2, v31 - 2), v32 * 0.6, v35 * 0.5, v34, v36, u40);

            if math.random() < 0.4 then
                local v48 = (math.random() - 0.5) * 2;
                local v49 = (math.random() - 0.5) * 2;
                local v50 = (math.random() - 0.5) * 2;
                buildBolt(v47, v47 + Vector3.new(v48, v49, v50).Unit * v46 * 0.5, math.max(1, v31 - 3), v32 * 0.4, v35 * 0.3, v34, v36, u40);
                v42 = i;
            else
                v42 = i;
            end;
        else
            v42 = i;
        end;
    end;

    task.delay(u33 * 0.5, function() -- Line: 96
        -- upvalues: u39 (copy), u33 (copy), u40 (copy), TweenService (ref), Debris (ref)
        if not u39 then
            for _, v in ipairs(u40) do
                if v and v.Parent then
                    TweenService:Create(v, TweenInfo.new(u33 * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = Vector3.new(0.001, 0.001, v.Size.Z)
                    }):Play();
                    Debris:AddItem(v, u33 * 0.5);
                end;
            end;

            return;
        end;

        local v51 = u33 / math.max(1, #u40);

        for i = #u40, 1, -1 do
            local u52 = u40[i];
            task.delay((#u40 - i) * v51 * 0.5, function() -- Line: 101
                -- upvalues: u52 (copy), TweenService (ref), u33 (ref), Debris (ref)
                if u52 and u52.Parent then
                    TweenService:Create(u52, TweenInfo.new(u33 * 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                        Size = Vector3.new(0.001, 0.001, u52.Size.Z)
                    }):Play();
                    Debris:AddItem(u52, u33 * 0.5);
                end;
            end);
            local _ = i;
        end;
    end);

    return u40;
end;

function v1.Emit(p53) -- Line: 125
    -- upvalues: spawnLightning (copy)
    return spawnLightning(p53);
end;

function v1.EmitRetract(p54) -- Line: 129
    -- upvalues: spawnLightning (copy)
    p54.retract = true;

    return spawnLightning(p54);
end;

return v1;