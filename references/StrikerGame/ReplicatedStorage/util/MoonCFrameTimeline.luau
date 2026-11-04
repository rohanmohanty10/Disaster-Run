 

 

local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local u1 = require(ReplicatedStorage.util.Ray).new({
    FilterType = Enum.RaycastFilterType.Exclude,
    Ignore = { workspace.characters, workspace.gks, workspace.CF }
});
local u2 = {};

for _, v in Enum.EasingStyle:GetEnumItems() do
    u2[v.Name] = v;
end;

local u3 = {};

local function resolveEasingStyle(p4: string) -- Line: 25
    -- upvalues: u3 (copy), u2 (copy)
    local v5 = u3[p4];

    if v5 then
        return v5;
    end;

    local v6 = u2[p4];

    if not v6 then
        for i, v in u2 do
            if i:match(p4) then
                v6 = v;
                break;
            end;
        end;
    end;

    local v7 = v6 or Enum.EasingStyle.Linear;
    u3[p4] = v7;

    return v7;
end;

local function getFPS(p8: userdata) -- Line: 47
    -- upvalues: HttpService (copy)
    local v9 = typeof(p8) == "Instance";
    assert(v9, "Requires a valid Moon Animator 2 file (StringValue or converted ModuleScript)");
    local v10 = nil;

    if p8:IsA("StringValue") then
        v10 = HttpService:JSONDecode(p8.Value);
    elseif p8:IsA("ModuleScript") then
        v10 = require(p8);
    else
        error("Invalid Moon Animator 2 file (expected StringValue or a converted ModuleScript)");
    end;

    return not (v10.Information and v10.Information.FPS) and 60 or v10.Information.FPS;
end;

local function getData(p11: userdata) -- Line: 61
    -- upvalues: resolveEasingStyle (copy)
    local v12 = {};

    for _, child in p11:GetChildren() do
        local v13 = tonumber(child.Name);

        if child:IsA("Folder") and (child:FindFirstChild("Values") and (child.Values:FindFirstChild("0") and v13)) then
            local v14 = child.Values["0"];
            local Linear = Enum.EasingStyle.Linear;
            local Out = Enum.EasingDirection.Out;

            if child:FindFirstChild("Eases") and child.Eases:FindFirstChild("0") then
                local v15 = child.Eases:FindFirstChild("0");

                if v15 then
                    if v15:FindFirstChild("Type") then
                        Linear = resolveEasingStyle(v15.Type.Value);
                    end;

                    if v15:FindFirstChild("Params") and v15.Params:FindFirstChild("Direction") then
                        Out = Enum.EasingDirection[v15.Params.Direction.Value];
                    end;
                end;
            end;

            table.insert(v12, {
                v13,
                v14.Value,
                Linear,
                Out
            });
        end;
    end;

    table.sort(v12, function(p16, p17) -- Line: 84
        return p16[1] < p17[1];
    end);

    return v12;
end;

local function compileData(p18: userdata) -- Line: 91
    local v19 = {};

    for _, child in p18:GetChildren() do
        local v20 = tonumber(child.Name);

        if child:IsA("Folder") and (child:FindFirstChild("Values") and (child.Values:FindFirstChild("0") and v20)) then
            local v21 = child.Values["0"];
            local v22 = "Linear";
            local v23 = "Out";

            if child:FindFirstChild("Eases") and child.Eases:FindFirstChild("0") then
                local v24 = child.Eases:FindFirstChild("0");

                if v24 then
                    if v24:FindFirstChild("Type") then
                        v22 = v24.Type.Value;
                    end;

                    if v24:FindFirstChild("Params") and v24.Params:FindFirstChild("Direction") then
                        v23 = v24.Params.Direction.Value;
                    end;
                end;
            end;

            table.insert(v19, {
                v20,
                v21.Value,
                v22,
                v23
            });
        end;
    end;

    table.sort(v19, function(p25, p26) -- Line: 114
        return p25[1] < p26[1];
    end);

    return v19;
end;

local function serializeNumber(p27: number) -- Line: 121
    if p27 == math.floor(p27) and math.abs(p27) < 1000000000000000 then
        return string.format("%d", p27);
    end;

    for i = 1, 17 do
        local string_format_ret = string.format("%." .. i .. "f", p27);

        if tonumber(string_format_ret) == p27 then
            return string_format_ret;
        end;

        local _ = i;
    end;

    return string.format("%.17g", p27);
end;

local buffer_create_ret = buffer.create(4);

local function toFloat32(p28: number) -- Line: 136
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p28);

    return buffer.readf32(buffer_create_ret, 0);
end;

local function serializeFloat32(p29: number) -- Line: 141
    -- upvalues: buffer_create_ret (copy)
    buffer.writef32(buffer_create_ret, 0, p29);
    local buffer_readf32_ret = buffer.readf32(buffer_create_ret, 0);

    if buffer_readf32_ret == math.floor(buffer_readf32_ret) and math.abs(buffer_readf32_ret) < 1000000000000000 then
        return string.format("%d", buffer_readf32_ret);
    end;

    for i = 1, 9 do
        local string_format_ret = string.format("%." .. i .. "f", buffer_readf32_ret);
        local v30 = tonumber(string_format_ret);
        buffer.writef32(buffer_create_ret, 0, v30);

        if buffer.readf32(buffer_create_ret, 0) == buffer_readf32_ret then
            return string_format_ret;
        end;

        local _ = i;
    end;

    return string.format("%.9g", buffer_readf32_ret);
end;

local function serializeCFrame(p31) -- Line: 155
    -- upvalues: serializeFloat32 (copy)
    local Components, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42 = p31:GetComponents();

    return string.format("CFrame.new(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", serializeFloat32(Components), serializeFloat32(v32), serializeFloat32(v33), serializeFloat32(v34), serializeFloat32(v35), serializeFloat32(v36), serializeFloat32(v37), serializeFloat32(v38), serializeFloat32(v39), serializeFloat32(v40), serializeFloat32(v41), serializeFloat32(v42));
end;

local function serializeString(p43: string) -- Line: 166
    return string.format("%q", p43);
end;

local u44 = {};
local u45 = {};
local u46 = {};
u46.__index = u46;

function u46.new(p47: any, p48: userdata) -- Line: 184
    -- upvalues: resolveEasingStyle (copy), u46 (copy), getData (copy), getFPS (copy)
    local v49 = nil;

    if typeof(p47) == "table" then
        v49 = p47;
    elseif p47:IsA("ModuleScript") then
        local v50;
        v50, v49 = pcall(require, p47);

        if not v50 then
            warn((`[MoonCFrameTimeline]: Unable to require compiled save {p47:GetFullName()}: {v49}`));
            v49 = {
                Information = {
                    FPS = 60
                },
                Origin = CFrame.identity,
                Frames = {}
            };
        end;
    end;

    if not v49 then
        local v51 = getData(p47);
        local v52 = getFPS(p48);

        for _, v in v51 do
            v[1] = v[1] / v52;
        end;

        local v53 = {
            _youngest = 0,
            _lastindex = 1,
            frames = v51,
            fps = v52,
            origin = p47.default.Value,
            runtime = {}
        };
        setmetatable(v53, u46);

        return v53;
    end;

    local v54 = v49.Information and (v49.Information.FPS or 60) or 60;
    local v55 = {};

    for _, v in ipairs(v49.Frames) do
        local v56 = v[1];
        local v57 = v[2];
        local v58 = v[4];
        local v59 = resolveEasingStyle(v[3]);
        table.insert(v55, {
            v56 / v54,
            v57,
            v59,
            Enum.EasingDirection[v58] or Enum.EasingDirection.Out
        });
    end;

    table.sort(v55, function(p60, p61) -- Line: 209
        return p60[1] < p61[1];
    end);
    local v62 = {
        _youngest = 0,
        _lastindex = 1,
        frames = v55,
        fps = v54,
        origin = v49.Origin,
        runtime = {}
    };
    setmetatable(v62, u46);

    return v62;
end;

function u46.CompileFolder(p63: userdata, p64: userdata) -- Line: 250
    -- upvalues: getFPS (copy), compileData (copy)
    return {
        Information = {
            FPS = getFPS(p64)
        },
        Origin = p63.default.Value,
        Frames = compileData(p63)
    };
end;

function u46.SaveCompiledModule(u65: userdata, p66: userdata, u67: userdata?, u68: string?) -- Line: 258
    -- upvalues: RunService (copy), u46 (copy), serializeNumber (copy), serializeCFrame (copy), serializeString (copy)
    if not RunService:IsStudio() or RunService:IsRunning() then
        warn("[MoonCFrameTimeline]: SaveCompiledModule can only be used in Studio");

        return;
    end;

    local v69 = u46.CompileFolder(u65, p66);
    local v70 = {};

    for _, v in ipairs(v69.Frames) do
        local string_format = string.format;
        local v71 = serializeNumber(v[1]);
        local v72 = serializeCFrame(v[2]);
        local string_format_ret = string.format("%q", v[3]);
        table.insert(v70, string_format("\t\t{%s, %s, %s, %s}", v71, v72, string_format_ret, serializeString(v[4])));
    end;

    local table_concat_ret = table.concat({
        "-- Auto-generated by MoonCFrameTimeline.SaveCompiledModule",
        "-- Compiled from: " .. u65:GetFullName(),
        "return {",
        "\tInformation = {FPS = " .. serializeNumber(v69.Information.FPS) .. "},",
        "\tOrigin = " .. serializeCFrame(v69.Origin) .. ",",
        "\tFrames = {",
        table.concat(v70, ",\n"),
        "\t}",
        "}"
    }, "\n");
    local success, result = pcall(function() -- Line: 289
        -- upvalues: u68 (copy), u65 (copy), table_concat_ret (copy), u67 (copy)
        local ModuleScript = Instance.new("ModuleScript");
        ModuleScript.Name = u68 or u65.Name .. "_Compiled";
        ModuleScript.Source = table_concat_ret;
        ModuleScript.Parent = u67 or u65.Parent;

        return ModuleScript;
    end);

    if success then
        return result;
    end;

    warn((`[MoonCFrameTimeline]: Unable to save compiled module (must be run from the command bar or a plugin): {result}`));
end;

function u46.Get(p73: any, p74: number) -- Line: 305
    -- upvalues: TweenService (copy)
    if p74 < p73._youngest then
        p73._lastindex = 1;
        p73._youngest = 0;
    end;

    local frames = p73.frames;

    if #frames == 0 then
        return CFrame.identity;
    end;

    for i = p73._lastindex, #frames do
        local v75 = frames[i];
        local v76 = frames[i + 1];

        if v76 and v76[1] > p74 then
            if p74 <= v75[1] then
                p73._lastindex = i;
                p73._youngest = v75[1];

                return v75[2];
            end;

            p73._lastindex = i;
            p73._youngest = v75[1];
            local Value = TweenService:GetValue((p74 - v75[1]) / (v76[1] - v75[1]), v75[3], v75[4]);

            return v75[2]:Lerp(v76[2], Value);
        end;

        p73._lastindex = i;
        p73._youngest = v75[1];
        local _ = i;
    end;

    return frames[#frames][2];
end;

local u77 = {
    A = true,
    B = true
};

function u46.Cast(u78: any, u79: userdata, u80: vector?, u81: function?, u82: function?) -- Line: 342
    -- upvalues: Players (copy), u77 (copy), RunService (copy), u1 (copy), u44 (copy), u45 (copy)
    local frames = u78.frames;
    local origin = u78.origin;
    local runtime = u78.runtime;
    local u83 = 0;
    local u84 = 0;
    local u85 = frames[#frames][1];

    if runtime[u79] then
        runtime[u79]:Disconnect();
    end;

    local u86 = u79:FindFirstAncestorWhichIsA("Model");
    local u87;

    if u86 then
        u87 = Players:GetPlayerFromCharacter(u86);
    else
        u87 = nil;
    end;

    local u88 = {};

    if u87 then
        local Name = u87.Team.Name;

        if u77[Name] then
            u88[`{Name}barriar`] = true;
        else
            for i in ipairs(u77) do
                u88[`{i}barriar`] = true;
            end;
        end;
    else
        for i in ipairs(u77) do
            local v89 = `{i}barriar`;
            table.insert(u88, v89);
        end;
    end;

    local v97 = RunService.RenderStepped:Connect(function(p90) -- Line: 378
        -- upvalues: u82 (copy), u83 (ref), u85 (copy), runtime (copy), u79 (copy), u84 (ref), u78 (copy), origin (ref), u80 (copy), u81 (copy), u1 (ref), u87 (copy), u86 (copy), u88 (copy)
        if u82 then
            p90 = u82(p90, u83);
        end;

        u83 = math.min(u83 + p90, u85);

        if u85 <= u83 then
            runtime[u79]:Disconnect();
            runtime[u79] = nil;
        end;

        if u84 == u83 then
            return;
        end;

        u84 = u83;
        local v91 = u78:Get(u83);
        local v92 = origin;

        if p90 > 0.03333333333333333 or u79.Anchored then
            v92 = v91;
        end;

        local v93 = v92:ToObjectSpace(v91);

        if u80 then
            v93 = CFrame.fromMatrix(v93.Position * u80, v93.XVector, v93.YVector, v93.ZVector);
        end;

        if u81 then
            v93 = u81(v93, u83);
        end;

        local CFrame2 = u79.CFrame;
        local v94 = CFrame2 * v93;
        local v95 = u1:fire(CFrame2.Position, v94.Position - CFrame2.Position);

        if u87 and v95 then
            local v96 = u86;

            if not (v96 and v96:GetAttribute("IgnorePenaltyBarriar")) then
                local _ = u87.Team.Name or "B";

                if v95 and (v95.Instance and not u88[v95.Instance.Name]) then
                    v94 = CFrame.new(v95.Position) * v94.Rotation;
                end;
            end;
        end;

        u79.CFrame = v94;
        origin = v91;
    end);
    runtime[u79] = v97;

    if u44[u79] and u44[u79].Connected then
        u44[u79]:Destroy();
    end;

    u44[u79] = u78;

    if not u45[u79] then
        u45[u79] = u79.AncestryChanged:Once(function() -- Line: 437
            -- upvalues: u45 (ref), u79 (copy), u44 (ref)
            u45[u79]:Disconnect();
            u45[u79] = nil;
            local v98 = u44[u79];

            if v98 then
                v98:Destroy();
                u44[u79] = nil;
            end;
        end);
    end;

    return v97;
end;

function u46.Destroy(p99) -- Line: 452
    -- upvalues: u44 (copy)
    local runtime = p99.runtime;

    for i, v in runtime do
        v:Disconnect();
        runtime[i] = nil;

        if u44[i] == p99 then
            u44[i] = nil;
        end;
    end;
end;

return {
    new = u46.new,
    CompileFolder = u46.CompileFolder,
    SaveCompiledModule = u46.SaveCompiledModule,
    ActiveParts = u44
};