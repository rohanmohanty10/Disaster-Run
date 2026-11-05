  

 

local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
require(ReplicatedModules.PathShortcuts);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Template = require(script:WaitForChild("Template"));
local u1 = {};

local function Lerp(p2, p3, p4) -- Line: 12
    if typeof(p2) == "Color3" then
        return p2:Lerp(p3, p4);
    end;

    return p2 + (p3 - p2) * p4;
end;

local function DeepCopy(p5) -- Line: 20
    -- upvalues: DeepCopy (copy)
    local v6 = {};

    for i, v in pairs(p5) do
        if type(v) == "table" then
            v6[i] = DeepCopy(v);
        else
            v6[i] = v;
        end;
    end;

    return v6;
end;

local function Write(p7, p8) -- Line: 32
    -- upvalues: u1 (copy)
    local v9 = p8 or p7.ClassName;
    local v10 = {};

    for i, v in pairs(p7) do
        if i ~= "ClassName" and i ~= "Name" then
            v10[i] = typeof(v);
        end;
    end;

    u1[v9] = v10;
end;

Write(Template.Lighting, "Lighting");
local u11 = {};

for _, v in pairs(Template.Objects) do
    Write(v);
end;

function u11.Save(p12) -- Line: 50
    -- upvalues: u1 (copy)
    local v13 = {
        Lighting = {},
        Objects = {}
    };

    for i, _ in pairs(u1.Lighting) do
        v13.Lighting[i] = game.Lighting[i];
    end;

    for _, child in ipairs(game.Lighting:GetChildren()) do
        if u1[child.ClassName] then
            local v14 = {
                Name = child.Name,
                ClassName = child.ClassName
            };

            for i, _ in pairs(u1[child.ClassName]) do
                v14[i] = child[i];
            end;

            table.insert(v13.Objects, v14);
        end;
    end;

    return v13;
end;

function u11.ToJSON(p15, p16) -- Line: 73
    -- upvalues: DeepCopy (copy)
    local v17 = DeepCopy(p16);

    local function SerializeColor3(p18) -- Line: 76
        -- upvalues: SerializeColor3 (copy)
        for i, v in pairs(p18) do
            if typeof(v) == "Color3" then
                p18[i] = "c3:" .. string.format("%.3f,%.3f,%.3f", v.R, v.G, v.B);
            elseif typeof(v) == "table" then
                SerializeColor3(v);
            end;
        end;
    end;

    SerializeColor3(v17);

    return game:GetService("HttpService"):JSONEncode(v17);
end;

function u11.FromJSON(p19, p20, p21) -- Line: 90
    local v22 = game:GetService("HttpService"):JSONDecode(p20);

    local function DeserializeColor3(p23) -- Line: 93
        -- upvalues: DeserializeColor3 (copy)
        for i, v in pairs(p23) do
            if typeof(v) == "string" then
                local v24 = v:split(":");

                if v24 and #v24 == 2 then
                    local v25 = v24[2];

                    if v24[1] == "c3" then
                        local v26 = v25:split(",");
                        p23[i] = Color3.new(v26[1], v26[2], v26[3]);
                    end;
                end;
            elseif typeof(v) == "table" then
                DeserializeColor3(v);
            end;
        end;
    end;

    DeserializeColor3(v22);

    return v22;
end;

local function DeepHSVShiftData(p27, p28) -- Line: 114
    -- upvalues: ParticleHandler (copy), DeepHSVShiftData (copy)
    for i, v in p27 do
        if typeof(v) == "Color3" then
            p27[i] = ParticleHandler.HSVShift(v, p28);
        elseif type(v) == "table" then
            DeepHSVShiftData(v, p28);
        end;
    end;
end;

function u11.Set(p29, p30, p31, p32) -- Line: 124
    -- upvalues: u11 (copy), DeepHSVShiftData (copy)
    if typeof(p30) == "string" then
        p30 = u11:FromJSON(p30);
        local v33 = p32.SourceHSVShift or p32.TargetHSVShift;

        if v33 then
            DeepHSVShiftData(p30, v33);
        end;
    end;

    for i, v in pairs(p30.Lighting) do
        game.Lighting[i] = v;
    end;

    if p31 then
        for _, child in pairs(game.Lighting:GetChildren()) do
            if child:IsA("Sky") or child:IsA("PostEffect") then
                child:Destroy();
            end;
        end;
    end;

    for _, v in pairs(game:GetService("CollectionService"):GetTagged("_LIGHTINGOBJECT")) do
        v:Destroy();
    end;

    for _, v in pairs(p30.Objects) do
        if v.Archivable ~= false then
            if v.ClassName == "Atmosphere" or v.ClassName == "Sky" then
                local v34 = game.Lighting:FindFirstChildWhichIsA(v.ClassName);

                if v34 then
                    for i, v2 in pairs(v) do
                        if i ~= "ClassName" then
                            v34[i] = v2;
                        end;
                    end;
                end;
            else
                local v35 = Instance.new(v.ClassName);

                for i, v2 in pairs(v) do
                    if i ~= "ClassName" and i ~= "ClockTime" then
                        v35[i] = v2;
                    end;
                end;

                v35.Parent = game.Lighting;
                game:GetService("CollectionService"):AddTag(v35, "_LIGHTINGOBJECT");
            end;
        end;
    end;
end;

function u11.Transition(p36, p37, p38, p39, p40) -- Line: 173
    -- upvalues: u11 (copy), DeepHSVShiftData (copy)
    if typeof(p37) == "string" then
        p37 = u11:FromJSON(p37);
    end;

    if typeof(p38) == "string" then
        p38 = u11:FromJSON(p38);

        if p40.TargetHSVShift then
            DeepHSVShiftData(p38, p40.TargetHSVShift);
        end;
    end;

    for i, v in pairs(p38.Lighting) do
        if typeof(v) == "Color3" or typeof(v) == "number" then
            local v41 = p37.Lighting[i];

            if typeof(v41) == typeof(v) then
                local Lighting = game.Lighting;
                local v42;

                if typeof(v41) == "Color3" then
                    v42 = v41:Lerp(v, p39);
                else
                    v42 = v41 + (v - v41) * p39;
                end;

                Lighting[i] = v42;
            end;
        end;
    end;

    for _, v in pairs(p38.Objects) do
        local u43 = nil;

        for _, v2 in pairs(p37.Objects) do
            if v2.ClassName == v.ClassName and v2.Name == v.Name then
                u43 = v2;
                break;
            end;
        end;

        if u43 then
            local v45 = (function() -- Line: 203
                -- upvalues: v (copy), u43 (ref)
                if v.Archivable ~= false then
                    if v.ClassName == "Atmosphere" or v.ClassName == "Sky" then
                        return game.Lighting:FindFirstChildWhichIsA(v.ClassName);
                    end;

                    for _, v2 in pairs(game:GetService("CollectionService"):GetTagged("_LIGHTINGOBJECT")) do
                        if v2.ClassName == v.ClassName and v2.Name == v.Name then
                            return v2;
                        end;
                    end;

                    local v44 = Instance.new(v.ClassName);

                    for i, v2 in pairs(u43) do
                        if i ~= "ClassName" and i ~= "ClockTime" then
                            v44[i] = v2;
                        end;
                    end;

                    v44.Parent = game.Lighting;
                    game:GetService("CollectionService"):AddTag(v44, "_LIGHTINGOBJECT");

                    return v44;
                end;
            end)();

            for i, v2 in pairs(v) do
                if v.Archivable == false then
                    return;
                end;

                if (typeof(v2) == "Color3" or typeof(v2) == "number") and (u43[i] and v45) then
                    local v46 = u43[i];
                    local v47;

                    if typeof(v46) == "Color3" then
                        v47 = v46:Lerp(v2, p39);
                    else
                        v47 = v46 + (v2 - v46) * p39;
                    end;

                    v45[i] = v47;
                end;
            end;
        end;
    end;
end;

u11.OriginalLighting = u11:Save();

for _, v in pairs(u11.OriginalLighting.Objects) do
    if v.ClassName ~= "Sky" and v.ClassName ~= "Atmosphere" then
        v.Archivable = false;
    end;
end;

local Objects = u11.OriginalLighting.Objects;
local v48 = {
    Name = "ColorCorrection",
    ClassName = "ColorCorrectionEffect",
    Brightness = 0,
    Contrast = 0,
    Saturation = 0,
    Enabled = true,
    TintColor = Color3.fromRGB(255, 255, 255)
};
table.insert(Objects, v48);
table.insert(u11.OriginalLighting.Objects, {
    Name = "Bloom",
    ClassName = "BloomEffect",
    Intensity = 0,
    Size = 0,
    Threshold = 0,
    Enabled = false
});

return u11;