  

 

local u1 = { Vector3.new(1, 0, 0), Vector3.new(0.5, 0.8660254, 0), Vector3.new(-0.5, 0.8660254, 0), Vector3.new(-1, 0.00000000000000012246469, 0), Vector3.new(-0.5, -0.8660254, 0), Vector3.new(0.5, -0.8660254, 0) };
Color3.fromRGB(0, 255, 255);
local HexPanelPrototype = script.HexPanelPrototype;
local TweenService = game:GetService("TweenService");

local function GetCorners(p2, p3) -- Line: 28
    -- upvalues: u1 (copy)
    local v4 = vector.dot(p3, Vector3.new(0, 1, 0));
    local v5 = math.abs(v4) > 0.99 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0);
    local v6 = vector.cross(p3, v5);
    local v7 = vector.normalize(v6);
    local v8 = vector.cross(v7, p3);
    local v9 = vector.normalize(v8);
    local v10 = {};

    for i = 1, 6 do
        local v11 = u1[i];
        table.insert(v10, i, p2 + (v7 * v11.X + v9 * v11.Y) * 2);
    end;

    return v10;
end;

local function Generate(p12, p13) -- Line: 44
    -- upvalues: GetCorners (copy), HexPanelPrototype (copy)
    local Model = Instance.new("Model");
    Model.Name = "HexSphereCage";
    Model.Parent = workspace;
    local v14 = {};

    for i = 0, 12 do
        local v15 = 3.141592653589793 * (i / 12);
        local v16 = math.cos(v15);
        local v17 = math.sin(v15);
        local v18 = math.floor(v17 * 12 * 2);
        local v19 = math.max(3, v18);

        for i2 = 0, v19 - 1 do
            local v20 = i2 / v19 * 3.141592653589793 * 2;
            local v21 = v17 * math.cos(v20);
            local v22 = v17 * math.sin(v20);
            local v23 = vector.create(v21, v16, v22);
            local v24 = GetCorners(p12 + v23 * p13, v23);
            local v25 = HexPanelPrototype:Clone();
            v25.Parent = Model;
            local v26 = 1;
            local v27 = {};

            for _, child in v25:GetChildren() do
                if child:IsA("BasePart") then
                    local v28 = v24[v26];
                    local v29 = v24[v26 % 6 + 1];
                    local v30 = v29 - v28;
                    local v31 = (v28 + v29) * 0.5;
                    local v32 = vector.magnitude(v30);
                    child.Size = vector.create(0.1, 0.1, v32);
                    child.CFrame = CFrame.new(v31, v31 + vector.normalize(v30));
                    v27[v26] = child;
                    v26 = v26 + 1;
                end;
            end;

            table.insert(v14, {
                Parts = v27,
                Direction = v23
            });
        end;
    end;

    return Model, v14;
end;

local function ScaleCage(p33, p34, p35, p36) -- Line: 100
    -- upvalues: GetCorners (copy), TweenService (copy)
    for _, v in p34 do
        local Direction = v.Direction;
        local v37 = GetCorners(p33 + Direction * p35, Direction);

        for i = 1, 6 do
            local v38 = v37[i];
            local v39 = v37[i % 6 + 1];
            local v40 = v39 - v38;
            local v41 = (v38 + v39) * 0.5;
            local v42 = v.Parts[i];
            local v43 = {};
            local v44 = vector.magnitude(v40);
            v43.Size = vector.create(0.1, 0.1, v44);
            v43.CFrame = CFrame.new(v41, v41 + vector.normalize(v40));
            TweenService:Create(v42, p36, v43):Play();
        end;
    end;
end;

return function(p45) -- Line: 121
    -- upvalues: Generate (copy), ScaleCage (copy), TweenService (copy)
    local v46, v47 = Generate(p45, 7);
    ScaleCage(p45, v47, 20, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut));
    task.wait(0.75);
    ScaleCage(p45, v47, 3, TweenInfo.new(0.45, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out));
    task.wait(0.45);

    for _, descendant in v46:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.delay(0.4, v46.Destroy, v46);
end;