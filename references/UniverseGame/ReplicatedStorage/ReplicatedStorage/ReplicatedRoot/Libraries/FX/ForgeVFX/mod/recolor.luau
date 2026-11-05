  

 

local u1 = {
    Single = {
        Color3 = { "Decal", "Texture" },
        Color = { "Part", "Union", "MeshPart", "SpotLight", "PointLight", "SurfaceLight", "SurfaceAppearance" }
    },
    Sequence = {
        Color = { "Beam", "Trail", "ParticleEmitter" }
    }
};

local function warp(p2) -- Line: 30
    return (p2 % 1 + 1) % 1;
end;

local function multiplyHue(p3, p4) -- Line: 34
    return ((p3 + (p4 - 0.5) * 1) % 1 + 1) % 1;
end;

local function multiplyChannel(p5, p6) -- Line: 39
    local v7 = p6 * 2 - 1;

    if v7 >= 0 then
        return math.clamp(p5 + (1 - p5) * v7, 0, 1);
    end;

    local v8 = p5 - p5 * math.abs(v7);

    return math.clamp(v8, 0, 1);
end;

local function normalizeColor(p9) -- Line: 49
    local R = p9.R;
    local G = p9.G;
    local B = p9.B;
    local v10 = math.max(1, R, G, B);

    return v10, Color3.new(R / v10, G / v10, B / v10);
end;

local function multiplyRGB(p11, p12) -- Line: 55
    return Color3.new(p11.R * p12, p11.G * p12, p11.B * p12);
end;

local function recolorObj(p13, p14, p15, p16) -- Line: 59
    -- upvalues: u1 (copy), multiplyRGB (copy)
    if not p16 and p13:IsA("BasePart") then
        return;
    end;

    local v17, v18, v19 = p14:ToHSV();

    for _, v in u1 do
        for i, v2 in v do
            if table.find(v2, p13.ClassName) then
                local v20 = p13[i];

                if p15 == "multiply" then
                    if typeof(v20) == "Color3" then
                        local R = v20.R;
                        local G = v20.G;
                        local B = v20.B;
                        local v21 = math.max(1, R, G, B);
                        local v22, v23, v24 = Color3.new(R / v21, G / v21, B / v21):ToHSV();
                        local v25 = v18 * 2 - 1;
                        local v26;

                        if v25 >= 0 then
                            v26 = math.clamp(v23 + (1 - v23) * v25, 0, 1);
                        else
                            local v27 = v23 - v23 * math.abs(v25);
                            v26 = math.clamp(v27, 0, 1);
                        end;

                        local v28 = v19 * 2 - 1;
                        local v29;

                        if v28 >= 0 then
                            v29 = math.clamp(v24 + (1 - v24) * v28, 0, 1);
                        else
                            local v30 = v24 - v24 * math.abs(v28);
                            v29 = math.clamp(v30, 0, 1);
                        end;

                        local v31 = Color3.fromHSV(((v22 + (v17 - 0.5) * 1) % 1 + 1) % 1, v26, v29);
                        p13[i] = Color3.new(v31.R * v21, v31.G * v21, v31.B * v21);
                    elseif typeof(v20) == "ColorSequence" then
                        local v32 = {};

                        for _, v3 in v20.Keypoints do
                            local Value = v3.Value;
                            local R = Value.R;
                            local G = Value.G;
                            local B = Value.B;
                            local v33 = math.max(1, R, G, B);
                            local v34, v35, v36 = Color3.new(R / v33, G / v33, B / v33):ToHSV();
                            local v37 = v18 * 2 - 1;
                            local v38;

                            if v37 >= 0 then
                                v38 = math.clamp(v35 + (1 - v35) * v37, 0, 1);
                            else
                                local v39 = v35 - v35 * math.abs(v37);
                                v38 = math.clamp(v39, 0, 1);
                            end;

                            local v40 = v19 * 2 - 1;
                            local v41;

                            if v40 >= 0 then
                                v41 = math.clamp(v36 + (1 - v36) * v40, 0, 1);
                            else
                                local v42 = v36 - v36 * math.abs(v40);
                                v41 = math.clamp(v42, 0, 1);
                            end;

                            local new = ColorSequenceKeypoint.new;
                            local Time = v3.Time;
                            local v43 = Color3.fromHSV(((v34 + (v17 - 0.5) * 1) % 1 + 1) % 1, v38, v41);
                            table.insert(v32, new(Time, multiplyRGB(v43, v33)));
                        end;

                        p13[i] = ColorSequence.new(v32);
                    end;
                elseif typeof(v20) == "Color3" then
                    local R = v20.R;
                    local G = v20.G;
                    local B = v20.B;
                    local v44 = math.max(1, R, G, B);
                    Color3.new(R / v44, G / v44, B / v44);
                    p13[i] = Color3.new(p14.R * v44, p14.G * v44, p14.B * v44);
                elseif typeof(v20) == "ColorSequence" then
                    p13[i] = ColorSequence.new(p14);
                end;
            end;
        end;
    end;
end;

return function(p45, p46, ...) -- Line: 112, Name: recolor
    -- upvalues: recolorObj (copy)
    for _, v in { ... } do
        recolorObj(v, p45, p46, true);

        for _, descendant in v:GetDescendants() do
            recolorObj(descendant, p45, p46, false);
        end;
    end;
end;