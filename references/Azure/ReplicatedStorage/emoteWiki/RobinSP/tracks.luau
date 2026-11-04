 

 

local function freeze_list(p1: table) -- Line: 5
    for _, v in p1 do
        table.freeze(v);
    end;

    return table.freeze(p1);
end;

local v2 = {};

local function join(...) -- Line: 16
    local v3 = {};

    for _, v in { ... } do
        for _, v4 in v do
            table.insert(v3, v4);
        end;
    end;

    return table.freeze(v3);
end;

local v4 = { "RobinBase/SpotLight4/BeamDecreasing", "RobinBase/SpotLight3/BeamDecreasing", "RobinBase/SpotLight1/BeamDecreasing", "RobinBase/SpotLight2/BeamDecreasing" };
local v5 = { "RobinBase/SpotLight1/Flare172New", "RobinBase/SpotLight2/Flare172New", "RobinBase/SpotLight3/Flare172New", "RobinBase/SpotLight4/Flare172New" };
local v6 = { "RobinBase/A1", "RobinBase/A2", "RobinBase/A3", "RobinBase/A4" };

for _, v in { "1", "2", "3", "4" } do
    local v7 = `RobinBase/SpotLight{v}`;

    for _, v3 in { "BurstBeam", "BurstBeamD", "HypeFlare", "BurstFlare", "5", "4", "3", "2", "Confetti" } do
        local v8 = `{v7}/{v3}`;
        table.insert(v2, v8);
    end;
end;

table.insert(v2, "RobinCoffeti");
local table_freeze = table.freeze;
local table_freeze2 = table.freeze;
local v9 = {
    { 0, CFrame.new(1, 7, 1) },
    { 416, CFrame.new(1, 7, 1) },
    {
        427,
        CFrame.new(1, 2.43315, 2, 1, 0, 0, 0, 0.965926, -0.258819, 0, 0.258819, 0.965926),
        "Cubic",
        "Out"
    },
    { 494, CFrame.new(1, 10, 0) },
    { 540, CFrame.new(1, 7, 1) }
};
local v10 = {};
local v11 = {
    fps = 60,
    length = 930
};

for _, v in v9 do
    table.freeze(v);
end;

v10["RobinBase/SpotLight4/B4"] = table.freeze(v9);
local v12 = {
    { 0, CFrame.new(-1, 7, 2) },
    { 416, CFrame.new(-1, 7, 2) },
    {
        427,
        CFrame.new(-1, 1.43315, 3.97055, 1, 0, 0, 0, 0.866025, -0.5, 0, 0.5, 0.866025),
        "Cubic",
        "Out"
    },
    { 494, CFrame.new(-1, 9, 0) },
    { 540, CFrame.new(-1, 7, 2) }
};

for _, v in v12 do
    table.freeze(v);
end;

v10["RobinBase/SpotLight3/B3"] = table.freeze(v12);
local v13 = {
    { 0, CFrame.new(0, 7, -2) },
    { 416, CFrame.new(0, 7, -2) },
    {
        427,
        CFrame.new(0, 2.43315, -3.73206, 1, 0, 0, 0, 0.866025, 0.5, 0, -0.5, 0.866025),
        "Cubic",
        "Out"
    },
    { 494, CFrame.new(0, 9, 0) },
    { 540, CFrame.new(0, 7, -2) }
};

for _, v in v13 do
    table.freeze(v);
end;

v10["RobinBase/SpotLight2/B2"] = table.freeze(v13);
local v14 = {
    { 0, CFrame.new(-2, 7, 0) },
    { 416, CFrame.new(-2, 7, 0) },
    {
        427,
        CFrame.new(-4, 1.43315, 0),
        "Cubic",
        "Out"
    },
    { 494, CFrame.new(0, 10, 0) },
    { 541, CFrame.new(-2, 7, 0) }
};

for _, v in v14 do
    table.freeze(v);
end;

v10["RobinBase/SpotLight1/B1"] = table.freeze(v14);
local v15 = {
    { 314, CFrame.new(1, 5, 1), "Constant" },
    { 363, CFrame.new(1, 7, 1) }
};

for _, v in v15 do
    table.freeze(v);
end;

v10["RobinBase/A4/B4"] = table.freeze(v15);
local v16 = {
    { 314, CFrame.new(-1, 5, 2), "Constant" },
    { 363, CFrame.new(-1, 7, 2) }
};

for _, v in v16 do
    table.freeze(v);
end;

v10["RobinBase/A3/B3"] = table.freeze(v16);
local v17 = {
    { 314, CFrame.new(0, 5, -2), "Constant" },
    { 363, CFrame.new(0, 7, -2) }
};

for _, v in v17 do
    table.freeze(v);
end;

v10["RobinBase/A2/B2"] = table.freeze(v17);
local v18 = {
    { 314, CFrame.new(-2, 5, 0), "Constant" },
    { 363, CFrame.new(-2, 7, 0) }
};

for _, v in v18 do
    table.freeze(v);
end;

v10["RobinBase/A1/B1"] = table.freeze(v18);
v11.attachments = table_freeze2(v10);
local v19 = { { 0, 22, "Cubic", "Out" }, { 53, 3 }, { 251, 3 }, { 257, 9 }, { 272, 3 }, { 867, 3, "Sextic", "In" }, { 930, 20 } };

for _, v in v19 do
    table.freeze(v);
end;

v11.blur_size = table.freeze(v19);
local v20 = { { 37, 0 }, { 39, 0.3 }, { 47, 0 }, { 423, 0 }, { 425, 0.7 }, { 431, 0 }, { 504, 0 }, { 506, 0.3 }, { 514, 0 } };

for _, v in v20 do
    table.freeze(v);
end;

v11.impact_contrast = table.freeze(v20);
local v21 = {
    { 37, Color3.new(1, 1, 1) },
    { 38, Color3.new(0.918772, 0.827451, 1) },
    { 62, Color3.new(1, 1, 1) },
    { 423, Color3.new(1, 1, 1) },
    { 425, Color3.new(1, 0.97587, 0.815686) },
    { 435, Color3.new(1, 1, 1) },
    { 504, Color3.new(1, 1, 1) },
    { 505, Color3.new(0.918772, 0.827451, 1) },
    { 529, Color3.new(1, 1, 1) }
};

for _, v in v21 do
    table.freeze(v);
end;

v11.impact_tint = table.freeze(v21);
local v22 = { { 0, 0.2, "Quad", "Out" }, { 11, 0 }, { 37, 0 }, { 38, 0.15 }, { 41, 0.25 }, { 62, 0 }, { 420, 0 }, { 425, 0.3 }, { 436, 0 }, { 504, 0 }, { 505, 0.15 }, { 508, 0.25 }, { 529, 0 }, { 867, 0, "Sextic", "In" }, { 930, 0.2 } };

for _, v in v22 do
    table.freeze(v);
end;

v11.impact_brightness = table.freeze(v22);
v11.color_correction = table.freeze({
    saturation = 0.1,
    contrast = 0.1,
    brightness = 0.02
});
v11.vignette = table.freeze({
    transparency = 0.2,
    color = Color3.new(0.754296, 0.67451, 1)
});
local v23 = {
    { 0, join(v4, v5) },
    { 63, table.freeze({ "Pop/Pop1", "RobinBase/LEnflare2", "RobinBase/LEnflare" }) },
    { 104, table.freeze({ "Pop/Pop2", "RobinBase/LEnflare2", "RobinBase/LEnflare" }) },
    { 129, v4 },
    { 151, v4 },
    { 256, table.freeze({ "RobinBase/Beat" }) },
    { 282, join(v4, v5) },
    { 310, table.freeze({ "RobinBase/Beat" }) },
    { 316, v6 },
    { 370, join({ "RobinBase/Beat" }, v6) },
    { 425, join({ "RobinBase/Beat" }, v2) },
    { 545, join(v4, v5) },
    { 546, table.freeze({ "Pop/Pop3" }) },
    { 566, table.freeze({ "Pop/Pop4" }) },
    { 597, table.freeze({ "Pop/Pop5" }) },
    { 617, table.freeze({ "Pop/Pop6" }) },
    { 662, join(v4, v5) },
    { 772, join(v4, v5) }
};

for _, v in v23 do
    table.freeze(v);
end;

v11.markers = table.freeze(v23);

return table_freeze(v11);