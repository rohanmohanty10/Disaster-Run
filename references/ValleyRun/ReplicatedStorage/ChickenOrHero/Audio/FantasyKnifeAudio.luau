 

 

local u1 = {
    EmberCommon = { 105793298027133, 134671877618939, 9119747138, "FantasyCommon" },
    EmberRare = { 9119742466, 125914564702009, 9119747163, "FantasyRare" },
    EmberEpic = { 9114446802, 9114446852, 110870147282698, "MoltenFang" },
    EmberLegendary = { 104896783166331, 9125646252, 140491618332570, "VoidSovereign" },
    CelestialCommon = { 9119744718, 138283030240531, 138293953015099, "FantasyCommon" },
    CelestialRare = { 9125647212, 9125648149, 107001835875685, "FantasyRare" },
    CelestialEpic = { 9116394545, 9125647528, 93592528031453, "StormTalon" },
    CelestialLegendary = { 9116395089, 9125646242, 104220464553864, "CelestialDragon" }
};
local u2 = {
    FantasyCommon = { 9116190478, 9113824230, 5789211405, 9116194425, 9125619589, 9116194421, 9116194421, 0, 1, 0 },
    FantasyRare = { 9119742466, 9119748082, 9119749145, 9126014020, 9113449585, 9119747260, 9126013811, 0, 1.1, 0 },
    MoltenFang = { 7518441422, 9117878426, 101467914599270, 9126014020, 88644431848133, 9116194421, 9126013811, 100970228713833, 0.82, 0.13 },
    SpectralReaper = { 9125647212, 9125647922, 9125648149, 9125646252, 9125646917, 9125646918, 9125648137, 110631293617327, 0.86, 0.12 },
    SolarPhoenix = { 110631293617327, 9117878426, 137373404763792, 81857580097150, 9113449585, 9119747260, 9126013811, 9126073001, 1.16, 0.16 },
    VoidSovereign = { 1216343787, 9125647922, 129561737395908, 75787837073401, 101387462540484, 9125646918, 9125648137, 9120709480, 0.72, 0.15 },
    Voidspine = { 1216343787, 9125647922, 129561737395908, 75787837073401, 101387462540484, 9125646918, 9125648137, 9120709480, 0.72, 0.15 },
    StormTalon = { 9119744718, 132839917432435, 122312400582724, 136080815136211, 98609496290942, 9125616884, 9113133597, 88644431848133, 1.28, 0.11 },
    Moonfang = { 9125994570, 9119748082, 9126013477, 9126013644, 9125362690, 9125994543, 9126013811, 5621616510, 0.94, 0.13 },
    GlacialCrown = { 9119742466, 9114861389, 9119749145, 9126014020, 116374735080767, 9114860944, 9113041458, 93748663519982, 1.35, 0.15 },
    CelestialDragon = { 5614963261, 9117878426, 132839917432435, 9120972444, 88644431848133, 9119747260, 9113133597, 1216343787, 0.91, 0.17 }
};
local u3 = { "Equip", "Windup", "Swing", "Dive", "Hit", "Sheath", "Cancel" };
local v4 = {};

for i, v in u1 do
    local table_clone_ret = table.clone(u2[v[4]]);
    local v5 = v[2];
    local v6 = v[3];
    table_clone_ret[1] = v[1];
    table_clone_ret[3] = v5;
    table_clone_ret[5] = v6;
    table_clone_ret[8] = 0;
    table_clone_ret[9] = 1;
    table_clone_ret[10] = 0;
    u2[i] = table_clone_ret;
end;

local u7 = {
    Equip = 0.24,
    Windup = 0.1,
    Swing = 0.24,
    Dive = 0.28,
    Hit = 0.34,
    Sheath = 0.14,
    Cancel = 0.1
};
local u8 = {
    Equip = 1,
    Windup = 0.94,
    Swing = 1.1,
    Dive = 0.98,
    Hit = 1,
    Sheath = 1.08,
    Cancel = 0.9
};

local function sound(p9, p10, p11, p12, p13) -- Line: 137
    local v14 = p9:FindFirstChild(p10);

    if not v14 then
        v14 = Instance.new("Sound");
        v14.Name = p10;
        v14.Parent = p9;
    end;

    v14.SoundId = "rbxassetid://" .. p11;
    v14.Volume = p12;
    v14.PlaybackSpeed = p13;
    v14.Looped = false;
    v14.PlayOnRemove = false;
    v14.RollOffMaxDistance = 100;
    v14.RollOffMinDistance = 7;
    v14:SetAttribute("Enabled", true);
    v14:SetAttribute("PitchVariation", 0.018);
    v14:SetAttribute("KnifeMaxSeconds", (p10 == "Equip" or (p10 == "Hit" or string.find(p10, "Signature"))) and 3 or 2);

    return v14;
end;

function v4.install(p15) -- Line: 157
    -- upvalues: u2 (copy), u3 (copy), sound (copy), u1 (copy), u7 (copy), u8 (copy)
    local v16 = p15.library:FindFirstChild("08_Knives");

    if not v16 then
        v16 = Instance.new("Folder");
        v16.Name = "08_Knives";
        v16.Parent = p15.library;
    end;

    for _, v in { "BaseDagger", "SpoonDagger" } do
        local v17 = v16:FindFirstChild(v);
        local v18;

        if v17 then
            v18 = v17:FindFirstChild("Sheath");
        else
            v18 = v17;
        end;

        if v17 and (v18 and not v17:FindFirstChild("Cancel")) then
            local v19 = v18:Clone();
            v19.Name = "Cancel";
            v19.Volume = v19.Volume * 0.7;
            v19.Parent = v17;
        end;
    end;

    for i, v in u2 do
        local v20 = v16:FindFirstChild(i);

        if not v20 then
            v20 = Instance.new("Folder");
            v20.Name = i;
            v20.Parent = v16;
        end;

        local v21 = i;
        local v22 = v;

        for i2, v2 in u3 do
            sound(v20, v2, v22[i2], u1[v21] and (v2 == "Equip" or (v2 == "Swing" or v2 == "Hit")) and 0.35 or u7[v2], u8[v2] * v22[9]);
            local v23 = "Knife_" .. v21 .. "_" .. v2;
            p15.catalog[v23] = {
                Path = "08_Knives/" .. v21 .. "/" .. v2,
                MinInterval = v2 == "Windup" and 0.9 or 0.09
            };

            if v22[8] ~= 0 and (v2 == "Equip" or (v2 == "Dive" or v2 == "Hit")) then
                local v24 = v2 .. "Signature";
                sound(v20, v24, v22[8], v22[10] * (v2 == "Hit" and 1 or 0.65), v22[9] * (v2 == "Hit" and 0.92 or 1.12));
                p15.catalog[v23 .. "Signature"] = {
                    MinInterval = 0.12,
                    Path = "08_Knives/" .. v21 .. "/" .. v24
                };
            end;
        end;
    end;
end;

function v4.layer(p25, p26, p27, p28) -- Line: 202
    if p25.catalog[p26 .. "Signature"] then
        p25:one(p26 .. "Signature", p27, p28);
    end;
end;

return v4;