 

 

local u1 = {};
local u2 = {};
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");

local function v6(p3, p4, p5) -- Line: 151
    return p3:Lerp(p4, p5);
end;

local u7 = {
    number = math.lerp,
    ModelTransparency = math.lerp,
    ModelReflectance = math.lerp,
    Color3 = v6,
    CFrame = v6,
    Vector3 = v6
};
local u8 = {
    boolean = true,
    string = true,
    Emit = true
};
local u9 = {
    Emit = true
};
local u10 = {};

local function getContainerFromFrame(p11: userdata, p12: string) -- Line: 173
    if p11:FindFirstChild(p12) then
        return p11[p12]:FindFirstChild("0");
    end;
end;

local function getValueFromFrame(p13: userdata, p14: string) -- Line: 180
    local v15 = table.find({ "Style", "Direction" }, p14) and "Eases" or (p14 == "Value" and "Values" or nil);

    if not v15 then
        warn((`[MoonPropertyAnimator]: Unable to declare a category from {p13.Name} ({p13:GetFullName()}) when searching for {p14}`));

        return;
    end;

    local v16;

    if p13:FindFirstChild(v15) then
        v16 = p13[v15]:FindFirstChild("0");
    else
        v16 = nil;
    end;

    if v16 then
        if v15 == "Eases" then
            if p14 == "Style" and v16:FindFirstChild("Type") then
                return v16.Type.Value;
            end;

            if p14 == "Direction" and (v16:FindFirstChild("Params") and v16.Params:FindFirstChild("Direction")) then
                return v16.Params.Direction.Value;
            end;
        elseif v15 == "Values" then
            return v16.Value;
        end;

        return;
    end;

    if v15 ~= "Eases" then
        warn((`[MoonPropertyAnimator]: Unable to find container instance for frame {p13.Name} ({p13:GetFullName()}) when searching for {p14}, category declared: {tostring(v15)}`));
    end;
end;

local function saveToEnumLookup(p17, p18, p19) -- Line: 209
    -- upvalues: u10 (copy)
    if not u10[p17] then
        u10[p17] = {};
    end;

    u10[p17][p18] = p19;
end;

local function getEnum(p20, p21, p22) -- Line: 216
    -- upvalues: u10 (copy)
    local v23 = u10[p20] and u10[p20][p21];

    if v23 then
        return v23;
    end;

    for _, v in p20:GetEnumItems() do
        if v.Name == p21 then
            if not u10[p20] then
                u10[p20] = {};
            end;

            u10[p20][p21] = v;

            return v;
        end;
    end;

    local v24 = p20[p22];

    if not u10[p20] then
        u10[p20] = {};
    end;

    u10[p20][p21] = v24;

    return v24;
end;

local function findFrameIndex(p25, p26) -- Line: 232
    local v27 = #p25;
    local v28 = 1;

    while v28 <= v27 do
        local v29 = (v28 + v27) // 2;
        local v30 = p25[v29];

        if p26 < v30.KeyframeTime then
            v27 = v29 - 1;
        else
            if v30.KeyframeTime >= p26 then
                return v29;
            end;

            v28 = v29 + 1;
        end;
    end;

    return math.clamp(v27, 1, #p25);
end;

local function isValidForClass(p31, p32) -- Line: 248
    if p31 == nil and p32 ~= "Instance" then
        return false, "nil";
    end;

    local v33 = typeof(p31);

    if v33 == "number" and p32 == "NumberSequence" then
        return true, v33;
    end;

    if v33 == "Color3" and p32 == "ColorSequence" then
        return true, v33;
    end;

    if v33 == "Instance" and (p32 == "ModelTransparency" and p31:IsA("Model")) then
        return true, v33;
    end;

    if v33 == "number" and p32 == "Emit" then
        return true, v33;
    end;

    if v33 == "number" and p32 == "ModelTransparency" then
        return true, v33;
    end;

    if v33 == "number" and p32 == "ModelReflectance" then
        return true, v33;
    end;

    return v33 == p32, v33;
end;

function u7.NumberSequence(p34: number, p35: number, p36: number) -- Line: 270
    return NumberSequence.new((math.lerp(p34, p35, p36)));
end;

function u7.ColorSequence(p37, p38, p39: number) -- Line: 274
    return ColorSequence.new(p37:Lerp(p38, p39));
end;

local function serializeString(p40: string) -- Line: 280
    return string.format("%q", p40);
end;

local function serializeNumber(p41: number) -- Line: 284
    if p41 ~= p41 then
        return "(0/0)";
    end;

    if p41 == (1 / 0) then
        return "math.huge";
    end;

    if p41 == (-1 / 0) then
        return "-math.huge";
    end;

    if p41 == math.floor(p41) and math.abs(p41) < 1000000000000000 then
        return string.format("%d", p41);
    end;

    for i = 1, 17 do
        local string_format_ret = string.format("%." .. i .. "f", p41);

        if tonumber(string_format_ret) == p41 then
            return string_format_ret;
        end;

        local _ = i;
    end;

    for i = 1, 17 do
        local string_format_ret = string.format("%." .. i .. "g", p41);

        if tonumber(string_format_ret) == p41 then
            return string_format_ret;
        end;

        local _ = i;
    end;

    return string.format("%.17g", p41);
end;

local buffer_create_ret = buffer.create(4);

local function toFloat32(p42: number) -- Line: 312
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p42);

    return buffer.readf32(buffer_create_ret, 0);
end;

local function serializeFloat32(p43: number) -- Line: 317
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p43);
    local buffer_readf32_ret = buffer.readf32(buffer_create_ret, 0);

    if buffer_readf32_ret ~= buffer_readf32_ret then
        return "(0/0)";
    end;

    if buffer_readf32_ret == (1 / 0) then
        return "math.huge";
    end;

    if buffer_readf32_ret == (-1 / 0) then
        return "-math.huge";
    end;

    if buffer_readf32_ret == math.floor(buffer_readf32_ret) and math.abs(buffer_readf32_ret) < 1000000000000000 then
        return string.format("%d", buffer_readf32_ret);
    end;

    for i = 1, 9 do
        local string_format_ret = string.format("%." .. i .. "f", buffer_readf32_ret);
        local v44 = tonumber(string_format_ret);
        buffer.writef32(buffer_create_ret, 0, v44);

        if buffer.readf32(buffer_create_ret, 0) == buffer_readf32_ret then
            return string_format_ret;
        end;

        local _ = i;
    end;

    for i = 1, 9 do
        local string_format_ret = string.format("%." .. i .. "g", buffer_readf32_ret);
        local v45 = tonumber(string_format_ret);
        buffer.writef32(buffer_create_ret, 0, v45);

        if buffer.readf32(buffer_create_ret, 0) == buffer_readf32_ret then
            return string_format_ret;
        end;

        local _ = i;
    end;

    return string.format("%.9g", buffer_readf32_ret);
end;

local function serializeColorComponent(p46: number) -- Line: 344
    local v47 = math.round(p46 * 255) / 255;

    return string.format("%.4g", v47);
end;

local function serializeValue(p48) -- Line: 349
    -- upvalues: serializeNumber (copy), serializeString (copy), serializeFloat32 (copy)
    local v49 = typeof(p48);

    if v49 == "number" then
        return serializeNumber(p48);
    end;

    if v49 == "boolean" then
        return tostring(p48);
    end;

    if v49 == "string" then
        return serializeString(p48);
    end;

    if v49 == "Color3" then
        return string.format("Color3.new(%s, %s, %s)", serializeFloat32(p48.R), serializeFloat32(p48.G), serializeFloat32(p48.B));
    end;

    if v49 == "Vector3" then
        return string.format("Vector3.new(%s, %s, %s)", serializeFloat32(p48.X), serializeFloat32(p48.Y), serializeFloat32(p48.Z));
    end;

    if v49 == "CFrame" then
        local Components, v50, v51, v52, v53, v54, v55, v56, v57, v58, v59, v60 = p48:GetComponents();

        return string.format("CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", serializeFloat32(Components), serializeFloat32(v50), serializeFloat32(v51), serializeFloat32(v52), serializeFloat32(v53), serializeFloat32(v54), serializeFloat32(v55), serializeFloat32(v56), serializeFloat32(v57), serializeFloat32(v58), serializeFloat32(v59), serializeFloat32(v60));
    end;

    if v49 == "nil" then
        return "nil";
    end;

    warn((`[MoonPropertyAnimator]: Unable to serialize a value of type {v49}, defaulting to nil`));

    return "nil";
end;

local function serializeFrameEntry(p61: table) -- Line: 377
    -- upvalues: serializeValue (copy)
    local v62 = { "Value = " .. serializeValue(p61.Value) };

    if p61.Style then
        local v63 = "Style = " .. string.format("%q", p61.Style);
        table.insert(v62, v63);
    end;

    if p61.Direction then
        local v64 = "Direction = " .. string.format("%q", p61.Direction);
        table.insert(v62, v64);
    end;

    return "{" .. table.concat(v62, ", ") .. "}";
end;

local function serializeFrameKey(p65: string) -- Line: 388
    local v66 = tonumber(p65);

    if v66 then
        return "[" .. string.format("%d", v66) .. "]";
    end;

    return "[" .. string.format("%q", p65) .. "]";
end;

local function serializePropertyData(p67: string, p68: table, p69: string) -- Line: 396
    -- upvalues: serializeFrameEntry (copy)
    local v70 = {};

    for i, v in pairs(p68) do
        local v71 = tonumber(i);
        local v72;

        if v71 then
            v72 = "[" .. string.format("%d", v71) .. "]";
        else
            v72 = "[" .. string.format("%q", i) .. "]";
        end;

        local v73 = p69 .. "\t" .. v72 .. " = " .. serializeFrameEntry(v);
        table.insert(v70, v73);
    end;

    return table.concat({ p69 .. "[" .. string.format("%q", p67) .. "] = {", table.concat(v70, ",\n"), p69 .. "}" }, "\n");
end;

local function serializeStringArray(p74: table) -- Line: 408
    -- upvalues: serializeString (copy)
    local v75 = {};

    for _, v in ipairs(p74) do
        table.insert(v75, serializeString(v));
    end;

    return "{" .. table.concat(v75, ", ") .. "}";
end;

local function serializeItem(p76: any, p77: string) -- Line: 416
    -- upvalues: serializeStringArray (copy)
    return p77 .. "{Path = {InstanceNames = " .. serializeStringArray(p76.Path.InstanceNames) .. "}}";
end;

local function buildFramesList(p78: string, p79: string, p80: table, p81: number) -- Line: 420
    -- upvalues: isValidForClass (copy)
    local v82 = {};
    local v83 = nil;

    for i, v in pairs(p80) do
        if i == "default" then
            if v83 == nil then
                v83 = v.Value;
            end;
        else
            local v84 = tonumber(i);

            if v84 then
                local v85, v86 = isValidForClass(v.Value, p79);

                if v85 then
                    if v84 == 0 then
                        v83 = v.Value;
                    end;

                    table.insert(v82, {
                        Num = v84,
                        KeyframeTime = v84 / p81,
                        EasingStyle = v.Style or "Linear",
                        EasingDirection = v.Direction or "Out",
                        Value = v.Value
                    });
                else
                    warn((`[MoonPropertyAnimator]: Unable to use frame {i} of {p78} because it's {v86} despite class being {p79}`));
                end;
            end;
        end;
    end;

    if v83 ~= nil then
        local v87 = false;

        for _, v in ipairs(v82) do
            if v.Num == 0 then
                v87 = true;
                break;
            end;
        end;

        if not v87 then
            table.insert(v82, {
                Num = 0,
                KeyframeTime = 0,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                Value = v83
            });
        end;
    end;

    table.sort(v82, function(p88, p89) -- Line: 468
        return p88.Num < p89.Num;
    end);

    return v82, v83;
end;

function u1.LerpSolution(p90: string, u91: any, u92: any, u93: number, u94: string, u95: string, p96: string?) -- Line: 476
    -- upvalues: u7 (copy), TweenService (copy), getEnum (copy)
    local u97 = u7[p90];

    if not u97 or u94 == "Constant" then
        if u93 >= 1 then
            u91 = u92 or u91;
        end;

        return u91;
    end;

    local success, result = pcall(function() -- Line: 490
        -- upvalues: TweenService (ref), u93 (copy), getEnum (ref), u94 (copy), u95 (copy), u97 (copy), u91 (copy), u92 (copy)
        return u97(u91, u92, (TweenService:GetValue(math.clamp(u93, 0, 1), getEnum(Enum.EasingStyle, u94, "Linear"), (getEnum(Enum.EasingDirection, u95, "Out")))));
    end);

    if success then
        return result;
    end;

    warn((`Error with solution for {p90} using values {tostring(u91)} ({typeof(u91)}) and {tostring(u92)} ({typeof(u92)}): {result}`));

    return u91;
end;

function u1.ConvertSave(p98: userdata, p99: table) -- Line: 507
    -- upvalues: HttpService (copy)
    local v100;

    if p98:IsA("ModuleScript") then
        local success, result = pcall(require, p98);

        if not success then
            warn((`[MoonPropertyAnimator]: Unable to require compiled save {p98:GetFullName()}: {result}`));

            return {};
        end;

        v100 = result.Items;
    else
        v100 = HttpService:JSONDecode(p98.Value).Items;
    end;

    local v101 = {};

    for i, v in ipairs(v100) do
        local InstanceNames = v.Path.InstanceNames;
        local v102 = i;

        for i2 = #InstanceNames, 1, -1 do
            local v103 = p99[InstanceNames[i2]];
            local v104;

            if v103 then
                v104 = i2;

                for i3 = i2 + 1, #InstanceNames do
                    v103 = v103:FindFirstChild(InstanceNames[i3]);

                    if not v103 then
                        break;
                    end;

                    local _ = i3;
                end;

                if v103 then
                    v101[v102] = v103;
                    break;
                end;
            else
                v104 = i2;
            end;
        end;
    end;

    return v101;
end;

function u1.GetFPS(u105: userdata) -- Line: 547
    -- upvalues: HttpService (copy)
    local success, result = pcall(function() -- Line: 548
        -- upvalues: HttpService (ref), u105 (copy)
        return HttpService:JSONDecode(u105.Value);
    end);

    return not (success and (result.Information and typeof(result.Information.FPS) == "number")) and 60 or result.Information.FPS;
end;

function u1.CompileFolder(p106: userdata) -- Line: 557
    -- upvalues: RunService (copy), getValueFromFrame (copy)
    local v107 = RunService:IsStudio();
    assert(v107, "[MoonPropertyAnimator]: CompileFolder can only be used in Studio");
    local v108 = {};

    for _, child in ipairs(p106:GetChildren()) do
        local Name = child.Name;

        if not table.find({ "MarkerTrack", "Rig", "_PropertyContainer_collapsed" }, Name) then
            local v109 = child;
            local v110 = {};
            local v111 = 0;

            for _, child2 in ipairs(child:GetChildren()) do
                local Name2 = child2.Name;
                local v112 = nil;
                local v113 = nil;
                local v114, v115;

                if tonumber(Name2) then
                    v114 = getValueFromFrame(child2, "Value");
                    v112 = getValueFromFrame(child2, "Style");
                    v113 = getValueFromFrame(child2, "Direction");

                    if v114 ~= nil then
                        v115 = {
                            Value = v114
                        };

                        if v112 then
                            v115.Style = v112;
                        end;

                        if v113 then
                            v115.Direction = v113;
                        end;

                        v110[Name2] = v115;

                        if tonumber(Name2) then
                            v111 = v111 + 1;
                        end;
                    end;
                elseif Name2 == "default" then
                    v114 = child2.Value;

                    if v114 ~= nil then
                        v115 = {
                            Value = v114
                        };

                        if v112 then
                            v115.Style = v112;
                        end;

                        if v113 then
                            v115.Direction = v113;
                        end;

                        v110[Name2] = v115;

                        if tonumber(Name2) then
                            v111 = v111 + 1;
                        end;
                    end;
                end;
            end;

            if v111 == 1 and (v109:FindFirstChild("0") and v109["0"]:FindFirstChild("Values")) then
                for _, child2 in ipairs(v109["0"].Values:GetChildren()) do
                    if child2:IsA("ValueBase") and tonumber(child2.Name) then
                        v110[child2.Name] = {
                            Style = "Constant",
                            Value = child2.Value
                        };
                    end;
                end;
            end;

            if next(v110) then
                v108[Name] = v110;
            end;
        end;
    end;

    return v108;
end;

function u1.SaveCompiledModule(u116: userdata, p117: userdata?, u118: userdata?, u119: string?) -- Line: 604
    -- upvalues: RunService (copy), u1 (copy), serializePropertyData (copy), serializeNumber (copy)
    if not RunService:IsStudio() or RunService:IsRunning() then
        warn("[MoonPropertyAnimator]: SaveCompiledModule can only be used in Studio");

        return;
    end;

    local v120 = p117 and u1.GetFPS(p117) or 60;
    local v121 = u1.CompileFolder(u116);
    local v122 = {};

    for i, v in pairs(v121) do
        table.insert(v122, serializePropertyData(i, v, "\t\t"));
    end;

    local table_concat_ret = table.concat({
        "-- Auto-generated by MoonPropertyAnimator.SaveCompiledModule",
        "-- Compiled from: " .. u116:GetFullName(),
        "return {",
        "\tInformation = {FPS = " .. serializeNumber(v120) .. "},",
        "\tData = {",
        table.concat(v122, ",\n"),
        "\t}",
        "}"
    }, "\n");
    local success, result = pcall(function() -- Line: 626
        -- upvalues: u119 (copy), u116 (copy), table_concat_ret (copy), u118 (copy)
        local ModuleScript = Instance.new("ModuleScript");
        ModuleScript.Name = u119 or u116.Name .. "_Compiled";
        ModuleScript.Source = table_concat_ret;
        ModuleScript.Parent = u118 or u116.Parent;

        return ModuleScript;
    end);

    if success then
        return result;
    end;

    warn((`[MoonPropertyAnimator]: Unable to save compiled module (must be run from the command bar or a plugin): {result}`));
end;

function u1.SaveCompiledSave(u123: userdata, u124: userdata?, u125: string?) -- Line: 640
    -- upvalues: RunService (copy), HttpService (copy), u1 (copy), serializeStringArray (copy), serializePropertyData (copy), serializeNumber (copy)
    if not RunService:IsStudio() or RunService:IsRunning() then
        warn("[MoonPropertyAnimator]: SaveCompiledSave can only be used in Studio");

        return;
    end;

    local success, result = pcall(function() -- Line: 645
        -- upvalues: HttpService (ref), u123 (copy)
        return HttpService:JSONDecode(u123.Value);
    end);

    if not success then
        warn((`[MoonPropertyAnimator]: Unable to decode save {u123:GetFullName()}: {result}`));

        return;
    end;

    local FPS = u1.GetFPS(u123);
    local v126 = {};
    local v127 = {};

    for i, v in ipairs(result.Items) do
        local v128 = "\t\t" .. "{Path = {InstanceNames = " .. serializeStringArray(v.Path.InstanceNames) .. "}}";
        table.insert(v126, v128);
        local v129 = u123:FindFirstChild((tostring(i)));

        if v129 then
            local v130 = u1.CompileFolder(v129);
            local v131 = {};

            for i2, v2 in pairs(v130) do
                table.insert(v131, serializePropertyData(i2, v2, "\t\t\t"));
            end;

            local table_concat = table.concat;
            local v132 = { "\t\t[" .. i .. "] = {", table.concat(v131, ",\n"), "\t\t}" };
            table.insert(v127, table_concat(v132, "\n"));
        end;
    end;

    local table_concat_ret = table.concat({
        "-- Auto-generated by MoonPropertyAnimator.SaveCompiledSave",
        "-- Compiled from: " .. u123:GetFullName(),
        "return {",
        "\tInformation = {FPS = " .. serializeNumber(FPS) .. "},",
        "\tItems = {",
        table.concat(v126, ",\n"),
        "\t},",
        "\tData = {",
        table.concat(v127, ",\n"),
        "\t}",
        "}"
    }, "\n");
    local success2, result2 = pcall(function() -- Line: 687
        -- upvalues: u125 (copy), u123 (copy), table_concat_ret (copy), u124 (copy)
        local ModuleScript = Instance.new("ModuleScript");
        ModuleScript.Name = u125 or u123.Name .. "_Compiled";
        ModuleScript.Source = table_concat_ret;
        ModuleScript.Parent = u124 or u123.Parent;

        return ModuleScript;
    end);

    if success2 then
        return result2;
    end;

    warn((`[MoonPropertyAnimator]: Unable to save compiled save (must be run from the command bar or a plugin): {result2}`));
end;

function u1.new() -- Line: 703
    -- upvalues: u1 (copy)
    return setmetatable({
        FrameRate = 60,
        _tracks = {}
    }, {
        __index = u1
    });
end;

function u1.SetFPS(p133: any, p134: number) -- Line: 711
    for _, v in ipairs(p133._tracks) do
        local v135 = #v.Frames;
        local v136 = 0;

        for i, v2 in ipairs(v.Frames) do
            v2.KeyframeTime = v2.KeyframeTime * p133.FrameRate / p134;

            if v135 == i then
                v136 = v2.KeyframeTime;
            end;
        end;

        v.Length = v136;
    end;

    p133.FrameRate = p134;
end;

function u1.LoadAnimations(p137: any, p138: userdata, p139: userdata) -- Line: 726
    -- upvalues: u2 (copy)
    local v140 = {};

    for _, child in ipairs(p139:GetChildren()) do
        local v141 = u2.new(p137, p138, child);
        table.insert(p137._tracks, v141);
        table.insert(v140, v141);
    end;

    return v140;
end;

function u1.LoadSave(p142: any, p143: userdata, p144: table) -- Line: 736
    -- upvalues: u1 (copy)
    if p143:IsA("ModuleScript") then
        return p142:LoadCompiledSave(p143, p144);
    end;

    p142.FrameRate = u1.GetFPS(p143);
    local v145 = {};

    for i, v in p144 do
        local v146 = p143:FindFirstChild((tostring(i)));

        if v146 then
            v145[i] = p142:LoadAnimations(v, v146);
        end;
    end;

    return v145;
end;

function u1.LoadCompiledSave(p147: any, p148: userdata, p149: table) -- Line: 752
    -- upvalues: u2 (copy)
    local success, result = pcall(require, p148);

    if not success then
        warn((`[MoonPropertyAnimator]: Unable to require compiled save {p148:GetFullName()}: {result}`));

        return {};
    end;

    p147.FrameRate = result.Information and (result.Information.FPS or 60) or 60;
    local v150 = {};

    for i, v in p149 do
        local v151 = result.Data[i];

        if v151 then
            local v152 = v;
            local v153 = {};

            for i2, v2 in pairs(v151) do
                local v154 = u2.fromMoonData(p147, v152, i2, v2);

                if v154 then
                    table.insert(p147._tracks, v154);
                    table.insert(v153, v154);
                end;
            end;

            v150[i] = v153;
        end;
    end;

    return v150;
end;

function u1.LoadAndConvertSave(p155: any, p156: userdata, p157: table) -- Line: 777
    -- upvalues: u1 (copy)
    return p155:LoadSave(p156, u1.ConvertSave(p156, p157));
end;

function u1.LoadCompiledAnimations(p158: any, p159: userdata, p160: userdata) -- Line: 781
    -- upvalues: u2 (copy)
    local success, result = pcall(require, p160);

    if not success then
        warn((`[MoonPropertyAnimator]: Unable to require compiled module {p160:GetFullName()}: {result}`));

        return {};
    end;

    p158.FrameRate = result.Information and (result.Information.FPS or 60) or 60;
    local v161 = {};

    for i, v in pairs(result.Data) do
        local v162 = u2.fromMoonData(p158, p159, i, v);

        if v162 then
            table.insert(p158._tracks, v162);
            table.insert(v161, v162);
        end;
    end;

    return v161;
end;

function u1.PlayAll(p163) -- Line: 799
    for _, v in p163._tracks do
        v:Play();
    end;
end;

function u1.FixRoots(p164) -- Line: 805
    if typeof(p164.OriginalRoot) ~= "CFrame" then
        return;
    end;

    for _, v in ipairs(p164._tracks) do
        v:FixRoot();
    end;
end;

function u1.SetRoot(p165: any, p166: userdata) -- Line: 812
    p165.Root = p166;
    p165:FixRoots();
end;

function u1.SetOriginalRoot(p167: any, p168) -- Line: 817
    p167.OriginalRoot = p168;
    p167:FixRoots();
end;

function u1.Animate(u169) -- Line: 822
    -- upvalues: RunService (copy), u1 (copy), findFrameIndex (copy)
    if not (u169._animator and u169._animator.Connected) then
        u169._animator = RunService[RunService:IsServer() and "Heartbeat" or "RenderStepped"]:Connect(function(p170) -- Line: 824
            -- upvalues: u169 (copy), u1 (ref), findFrameIndex (ref)
            if #u169._tracks == 0 then
                u169._animator:Disconnect();

                return;
            end;

            local _tracks = u169._tracks;

            for i = #_tracks, 1, -1 do
                local u171 = _tracks[i];
                local v172;

                if u171.IsDestroying then
                    table.remove(_tracks, i);
                    table.clear(u171);
                    v172 = i;
                elseif u171.IsPlaying then
                    u171.TimePosition = u171.TimePosition + p170;
                    local Length = u171.Length;
                    local TimePosition = u171.TimePosition;
                    local v173 = Length <= TimePosition;
                    local Frames = u171.Frames;
                    local v174 = `{u171.Object.Name}.{u171.Class}`;

                    if v173 then
                        u171.IsDestroying = true;
                        local v175 = Frames[#Frames];

                        if v175 then
                            local v176 = u171:ResolveValue(v175.Value);

                            if u171.Mode == "Continuous" then
                                u171:Update((u1.LerpSolution(u171.Class, v176, v176, 1, "Constant", "Out", (`{v174}-{v175.Num}`))));
                                v172 = i;
                            elseif u171.Mode == "Step" then
                                u171:Update(v176);
                                v172 = i;
                            else
                                v172 = i;
                            end;
                        else
                            v172 = i;
                        end;
                    elseif v173 or Length <= 0 then
                        v172 = i;
                    else
                        local v177 = findFrameIndex(Frames, TimePosition);
                        local v178 = Frames[v177];
                        local v179 = Frames[v177 + 1] or v178;
                        local v180 = TimePosition - v178.KeyframeTime;
                        local v181 = v179.KeyframeTime - v178.KeyframeTime;
                        local v182 = u171:ResolveValue(v178.Value);
                        local v183 = u171:ResolveValue(v179.Value);

                        if u171.Mode == "Step" then
                            if u171._lastStepNum == v178.Num or v178.KeyframeTime > TimePosition then
                                v172 = i;
                            else
                                u171._lastStepNum = v178.Num;
                                u171:Update((u171:ResolveValue(v178.Value)));
                                v172 = i;
                            end;
                        else
                            local v184 = v181 == 0 and 1 or math.clamp(v180 / v181, 0, 1);
                            local u185 = u1.LerpSolution(u171.Class, v182, v183, v184, v178.EasingStyle, v178.EasingDirection, (`{v174}-{v178.Num}`));
                            local success, _ = pcall(function() -- Line: 877
                                -- upvalues: u171 (copy), u185 (copy)
                                u171:Update(u185);
                            end);

                            if success then
                                v172 = i;
                            else
                                warn((`Unable to assign property "{u171.Property}" because it is a "{u171.Class}" while v0 ({tostring(v178.Value)}) is a {typeof(v178.Value)} and v1 ({tostring(v179.Value)}) is a {typeof(v179.Value)}`));
                                v172 = i;
                            end;
                        end;
                    end;
                else
                    v172 = i;
                end;
            end;
        end);
    end;
end;

function u1.Destroy(p186) -- Line: 889
    if p186._animator then
        p186._animator:Disconnect();
    end;

    table.clear(p186);
end;

function u2.new(p187: any, u188: userdata, p189: userdata) -- Line: 898
    -- upvalues: u8 (copy), u7 (copy), u2 (copy), getValueFromFrame (copy), isValidForClass (copy), u9 (copy)
    local Name = p189.Name;

    if table.find({ "MarkerTrack", "Rig", "_PropertyContainer_collapsed" }, Name) then
        return;
    end;

    local v190, v191;

    if u188:IsA("Model") and table.find({ "Transparency", "Reflectance" }, Name) then
        v190 = `Model{Name}`;
        v191 = true;
    else
        v191 = false;
        v190 = nil;
    end;

    if Name == "Emit" then
        v191 = true;
        v190 = "Emit";
    end;

    local success, result = pcall(function() -- Line: 916
        -- upvalues: u188 (copy), Name (copy)
        return u188[Name];
    end);
    local v192 = nil;

    if not success then
        if Name == "CFrame" and (typeof(u188) == "Instance" and (u188:IsA("Model") and u188.PrimaryPart)) then
            result = u188:GetPivot();
            v192 = "PivotModel";
        else
            if not v191 then
                warn((`[MoonPropertyAnimator]: {Name} is not a valid member of {tostring(u188)}`));

                return;
            end;

            result = 0;
        end;
    end;

    local v193 = typeof(result);
    local v194 = v193 == "nil" and "Instance" or v193;

    if v191 then
        if not v190 then
            warn((`[MoonPropertyAnimator]: isSpecial is true, but no specialClass was assigned for {tostring(u188)}`));

            return;
        end;

        v194 = v190;
    end;

    local v195 = v194 == "EnumItem" and "string" or v194;
    local v196 = v195 == "EnumItem" and "string" or v195;
    local v197 = u8[v196];

    if not (u7[v196] or (v190 or v197)) then
        print(u188, v196);
        warn((`[MoonPropertyAnimator]: Support for animating {v196} doesn't exist`));

        return;
    end;

    local v198 = {
        TimePosition = 0,
        Length = 0,
        IsPlaying = false,
        IsDestroying = false,
        Object = u188,
        Property = Name,
        Class = v196,
        Frames = {},
        Animator = p187
    };
    local v199;

    if typeof(result) == "EnumItem" then
        v199 = result.EnumType or nil;
    else
        v199 = nil;
    end;

    v198.EnumType = v199;
    v198.Mode = v197 and "Step" or "Continuous";

    if v198.Mode == "Step" then
        v198._lastStepNum = nil;
    end;

    if v192 then
        v198[v192] = true;
    end;

    if v196 == "ModelTransparency" then
        v198._descendants = u188:QueryDescendants("BasePart, Decal, Texture");
        local Handle = u188:FindFirstChild("Handle");
        local v200 = Handle and table.find(v198._descendants, Handle);

        if v200 then
            table.remove(v198._descendants, v200);
        end;
    elseif v196 == "ModelReflectance" then
        v198._descendants = u188:QueryDescendants("BasePart");
    end;

    local v201 = setmetatable(v198, {
        __index = u2
    });
    local Frames = v198.Frames;
    local v202 = nil;

    for _, child in ipairs(p189:GetChildren()) do
        local v203 = tonumber(child.Name);

        if v203 then
            local v204, v205 = getValueFromFrame(child, "Value");

            if isValidForClass(v204, v196) then
                if v203 == 0 then
                    v202 = v204;
                end;

                local v206 = getValueFromFrame(child, "Style") or "Linear";
                local v207 = getValueFromFrame(child, "Direction") or "Out";
                table.insert(Frames, {
                    Num = v203,
                    KeyframeTime = v203 / p187.FrameRate,
                    EasingStyle = v206,
                    EasingDirection = v207,
                    Value = v204
                });
            else
                warn((`[MoonPropertyAnimator]: Unable to load frame {child.Name} of {Name} from "{u188.Name}" ("{p189.Parent.Name}") because it's {v205} despite class being {v196}`));
            end;
        elseif child.Name == "default" and not v202 then
            v202 = child.Value;
        end;
    end;

    if v202 then
        local v208 = false;

        for _, v in Frames do
            if v.Num == 0 then
                v208 = true;
                break;
            end;
        end;

        if not v208 then
            table.insert(Frames, {
                Num = 0,
                KeyframeTime = 0,
                EasingStyle = "Linear",
                EasingDirection = "Out",
                Value = v202
            });
        end;
    end;

    if #Frames == 1 and (p189:FindFirstChild("0") and p189["0"]:FindFirstChild("Values")) then
        for _, child in ipairs(p189["0"].Values:GetChildren()) do
            if child:IsA("ValueBase") then
                local v209 = tonumber(child.Name);

                if v209 then
                    if v209 == 0 then
                        v202 = child.Value;
                    end;

                    table.insert(Frames, {
                        EasingStyle = "Constant",
                        EasingDirection = "Out",
                        Num = v209,
                        KeyframeTime = v209 / p187.FrameRate,
                        Value = child.Value
                    });
                elseif child.Name == "default" and not v202 then
                    v202 = child.Value;
                end;
            end;
        end;
    end;

    if v202 and not u9[v198.Class] then
        v201:Update((p187.LerpSolution(v198.Class, v202, v202, 1, "Constant", "Out")));
    end;

    if #Frames > 0 then
        table.sort(Frames, function(p210, p211) -- Line: 1062
            return p210.Num < p211.Num;
        end);
        v198.Length = Frames[#Frames].KeyframeTime;
        v201:FixRoot();

        return v201;
    end;
end;

function u2.fromMoonData(p212: any, u213: userdata, u214: string, p215: table) -- Line: 1071
    -- upvalues: u8 (copy), u7 (copy), u2 (copy), buildFramesList (copy), u9 (copy)
    if table.find({ "MarkerTrack", "Rig", "_PropertyContainer_collapsed" }, u214) then
        return;
    end;

    local v216, v217;

    if u213:IsA("Model") and table.find({ "Transparency", "Reflectance" }, u214) then
        v216 = `Model{u214}`;
        v217 = true;
    else
        v217 = false;
        v216 = nil;
    end;

    if u214 == "Emit" then
        v217 = true;
        v216 = "Emit";
    end;

    local success, result = pcall(function() -- Line: 1088
        -- upvalues: u213 (copy), u214 (copy)
        return u213[u214];
    end);
    local v218 = nil;

    if not success then
        if u214 == "CFrame" and (u213:IsA("Model") and u213.PrimaryPart) then
            result = u213:GetPivot();
            v218 = "PivotModel";
        else
            if not v217 then
                warn((`[MoonPropertyAnimator]: {u214} is not a valid member of {tostring(u213)}`));

                return;
            end;

            result = 0;
        end;
    end;

    local v219 = typeof(result);
    local v220 = v219 == "nil" and "Instance" or v219;

    if v217 then
        if not v216 then
            warn((`[MoonPropertyAnimator]: isSpecial is true, but no specialClass was assigned for {tostring(u213)}`));

            return;
        end;

        v220 = v216;
    end;

    local v221 = v220 == "EnumItem" and "string" or v220;
    local v222 = v221 == "EnumItem" and "string" or v221;
    local v223 = u8[v222];

    if not (u7[v222] or (v216 or v223)) then
        warn((`[MoonPropertyAnimator]: Support for animating {v222} doesn't exist`));

        return;
    end;

    local v224 = {
        TimePosition = 0,
        Length = 0,
        IsPlaying = false,
        IsDestroying = false,
        Object = u213,
        Property = u214,
        Class = v222,
        Frames = {},
        Animator = p212
    };
    local v225;

    if typeof(result) == "EnumItem" then
        v225 = result.EnumType or nil;
    else
        v225 = nil;
    end;

    v224.EnumType = v225;
    v224.Mode = v223 and "Step" or "Continuous";

    if v224.Mode == "Step" then
        v224._lastStepNum = nil;
    end;

    if v218 then
        v224[v218] = true;
    end;

    if v222 == "ModelTransparency" then
        v224._descendants = u213:QueryDescendants("BasePart, Decal, Texture");
        local Handle = u213:FindFirstChild("Handle");
        local v226 = Handle and table.find(v224._descendants, Handle);

        if v226 then
            table.remove(v224._descendants, v226);
        end;
    elseif v222 == "ModelReflectance" then
        v224._descendants = u213:QueryDescendants("BasePart");
    end;

    local v227 = setmetatable(v224, {
        __index = u2
    });
    local v228, v229 = buildFramesList(u214, v222, p215, p212.FrameRate);
    v224.Frames = v228;

    if v229 ~= nil and not u9[v224.Class] then
        v227:Update((p212.LerpSolution(v224.Class, v229, v229, 1, "Constant", "Out")));
    end;

    if #v228 > 0 then
        v224.Length = v228[#v228].KeyframeTime;
        v227:FixRoot();

        return v227;
    end;
end;

function u2.Update(p230, p231) -- Line: 1175
    -- upvalues: getEnum (copy)
    if p230.PivotModel then
        p230.Object:PivotTo(p231);

        return;
    end;

    if p230.Object:IsA("BasePart") and typeof(p231) == "CFrame" then
        p230.Object:PivotTo(p231 * p230.Object.PivotOffset);

        return;
    end;

    if p230.Class == "ModelTransparency" then
        for _, v in ipairs(p230._descendants) do
            v.Transparency = p231;
        end;

        return;
    end;

    if p230.Class == "ModelReflectance" then
        for _, v in ipairs(p230._descendants) do
            v.Reflectance = p231;
        end;

        return;
    end;

    if p230.Class == "Emit" then
        p230.Object:Emit(p231);

        return;
    end;

    local v232 = p230.Object[p230.Property];
    local Attribute = p230.Object:GetAttribute("MoonTextScale");

    if p230.Property == "TextSize" and (typeof(p231) == "number" and typeof(Attribute) == "number") then
        local math_round_ret = math.round(p231 * Attribute);
        p231 = math.max(1, math_round_ret);
    end;

    if p230.EnumType and typeof(p231) == "string" then
        p231 = getEnum(p230.EnumType, p231, v232.Name);
    end;

    if typeof(v232) == "NumberSequence" and typeof(p231) == "number" then
        p231 = NumberSequence.new(p231);
    end;

    if typeof(v232) == "ColorSequence" and typeof(p231) == "Color3" then
        p231 = ColorSequence.new(p231);
    end;

    p230.Object[p230.Property] = p231;
end;

function u2.ResolveValue(p233, p234) -- Line: 1226
    local Animator = p233.Animator;

    if p233.Referenced and Animator.Root then
        p234 = Animator.Root.CFrame:ToWorldSpace(p234);
    end;

    return p234;
end;

function u2.FixRoot(p235) -- Line: 1234
    local OriginalRoot = p235.Animator.OriginalRoot;

    if typeof(OriginalRoot) ~= "CFrame" then
        return;
    end;

    if p235.Property == "CFrame" and not (p235.Referenced or p235.Object:IsA("Attachment")) then
        p235.Referenced = true;

        for _, v in p235.Frames do
            if typeof(v.Value) == "CFrame" then
                v.Value = OriginalRoot:ToObjectSpace(v.Value);
            end;
        end;
    end;
end;

function u2.Play(p236) -- Line: 1247
    p236.IsPlaying = true;
    p236.IsDestroying = false;
    p236.Animator:Animate();
end;

function u2.Stop(p237) -- Line: 1253
    p237.IsPlaying = false;
end;

function u2.Pause(p238) -- Line: 1257
    p238.IsPlaying = false;
end;

function u2.Destroy(p239) -- Line: 1261
    p239.IsDestroying = true;
    p239.Animator:Animate();
end;

return u1;