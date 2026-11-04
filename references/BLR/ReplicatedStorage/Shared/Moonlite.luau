  

local v1 = {};
require(script.Types);
local script_Specials = require(script.Specials);
local script_EaseFuncs = require(script.EaseFuncs);
local RunService = game:GetService("RunService");
game:GetService("HttpService");

if RunService:IsServer() and RunService:IsStudio() then
    warn("Moonlite should NOT be used on the server! Rig transforms will not be replicated.");
end;

local u2 = {};
u2.__index = u2;
local u3 = {
    Instance = true,
    boolean = true,
    string = true,
    ["nil"] = true
};
local u4 = {};

local function lerp(p5: any, p6: any, p7: number) -- Line: 98
    if type(p5) == "number" then
        return math.lerp(p5, p6, p7);
    end;

    return p5:Lerp(p6, p7);
end;

local function deepCopy(p8) -- Line: 106
    -- upvalues: deepCopy (copy)
    local v9 = {};

    for i, v in next, p8 do
        local v10;

        if type(i) == "table" then
            v10 = deepCopy(i);
        else
            v10 = i;
        end;

        local v11;

        if type(v) == "table" then
            v11 = deepCopy(v);
        else
            v11 = v;
        end;

        v9[v10] = v11;
    end;

    return v9;
end;

local function toPath(p12) -- Line: 115
    return table.concat(p12.InstanceNames, ".");
end;

local function resolveAnimPath(u13: any, p14: userdata?) -- Line: 144
    if not u13 then
        return nil;
    end;

    local u15 = #u13.InstanceNames;
    local u16 = p14 or game;
    local success, result = pcall(function() -- Line: 152
        -- upvalues: u15 (copy), u13 (copy), u16 (ref)
        for i = 2, u15 do
            local v17 = u13.InstanceNames[i];
            local v18 = u13.InstanceTypes[i];

            if v17 == "CoreGui" then
                u13.InstanceNames[i] = "ReplicatedStorage";
                u13.InstanceTypes[i] = "ReplicatedStorage";
                v17 = u13.InstanceNames[i];
                v18 = u13.InstanceTypes[i];
            end;

            local v19 = u16:FindFirstChild(v17);
            local v20 = typeof(v19) == "Instance";
            assert(v20);
            assert(v19.ClassName == v18);
            u16 = v19;
            local _ = i;
        end;
    end);

    if success then
        return u16;
    end;

    warn("!! PATH RESOLVE FAILED:", table.concat(u13.InstanceNames, "."), "\n", result);

    return nil;
end;

local function resolveJoints(p21: userdata) -- Line: 180
    local v22 = {};
    local v23 = {};

    for _, descendant in p21:GetDescendants() do
        if descendant:IsA("Motor6D") and descendant.Active then
            local Part1 = descendant.Part1;

            if Part1 then
                Part1 = Part1.Name;
            end;

            if Part1 then
                v22[Part1] = {
                    Name = Part1,
                    Joint = descendant,
                    Children = {}
                };
            end;
        elseif descendant:IsA("Bone") then
            local Name = descendant.Name;
            v22[Name] = {
                Name = Name,
                Joint = descendant,
                Children = {}
            };
        end;
    end;

    for i, v in v22 do
        local Joint = v.Joint;

        if Joint:IsA("Motor6D") then
            local Part0 = Joint.Part0;

            if Part0 then
                local v24 = v22[Part0.Name];

                if v24 then
                    v24.Children[i] = v;
                    v.Parent = v24;
                end;
            end;
        elseif Joint:IsA("Bone") then
            local Parent = Joint.Parent;

            if Parent then
                local v25 = v22[Parent.Name];

                if v25 then
                    v25.Children[i] = v;
                    v.Parent = v25;
                end;
            end;
        end;
    end;

    for _, v in v22 do
        local Name = v.Name;
        local Parent = v.Parent;

        while Parent do
            Name = `{Parent.Name}.{Name}`;
            Parent = Parent.Parent;
        end;

        v23[Name] = v;
    end;

    return v23;
end;

local function parseEase(p26: userdata) -- Line: 247
    local Type = p26:FindFirstChild("Type");
    local Params = p26:FindFirstChild("Params");
    local v27 = {};
    local v28;

    if Type and Type:IsA("StringValue") then
        v28 = Type.Value;
    else
        v28 = nil;
    end;

    v27.Type = assert(v28);
    v27.Params = {};

    if Params then
        for _, child in Params:GetChildren() do
            if child:IsA("ValueBase") then
                v27.Params[child.Name] = child.Value;
            end;
        end;
    end;

    return v27;
end;

local function parseEaseOld(p29: userdata) -- Line: 272
    local Style = p29:FindFirstChild("Style");
    local v30;

    if Style then
        v30 = Style:IsA("StringValue");
    else
        v30 = Style;
    end;

    assert(v30, "No style in legacy ease!");
    local Direction = p29:FindFirstChild("Direction");
    local v31;

    if Direction then
        v31 = Direction:IsA("StringValue");
    else
        v31 = Direction;
    end;

    assert(v31, "No direction in legacy ease!");

    return {
        Type = Style.Value,
        Params = {
            Direction = Direction.Value
        }
    };
end;

local function readValue(p32: userdata) -- Line: 288
    if not p32:IsA("ValueBase") then
        return p32:GetAttribute("Value");
    end;

    local v33;

    if tonumber(p32.Name) then
        v33 = assert(p32.Parent);
    else
        v33 = p32;
    end;

    local Value = p32.Value;
    local EnumType = v33:FindFirstChild("EnumType");

    if EnumType and EnumType:IsA("StringValue") then
        return Enum[EnumType.Value][Value];
    end;

    if v33:FindFirstChild("Vector2") then
        return Vector2.new(Value.X, Value.Y);
    end;

    if v33:FindFirstChild("ColorSequence") then
        return ColorSequence.new(Value);
    end;

    if v33:FindFirstChild("NumberSequence") then
        return NumberSequence.new(Value);
    end;

    if v33:FindFirstChild("NumberRange") then
        Value = NumberRange.new(Value);
    end;

    return Value;
end;

local function getPropValue(p34: any, u35: userdata?, u36: string) -- Line: 316
    -- upvalues: script_Specials (copy)
    local v37 = u35 and script_Specials.Get(p34._scratch, u35, u36);

    if not v37 then
        return pcall(function() -- Line: 331
            -- upvalues: u35 (copy), u36 (copy)
            return u35[u36];
        end);
    end;

    local Get = v37.Get;

    if Get then
        return pcall(Get, u35);
    end;

    return true, v37.Default;
end;

local function setPropValue(p38: any, u39: userdata?, u40: string, u41: any, p42: boolean?) -- Line: 336
    -- upvalues: script_Specials (copy)
    local v43 = u39 and script_Specials.Get(p38._scratch, u39, u40);

    if not v43 then
        return pcall(function() -- Line: 353
            -- upvalues: u39 (copy), u40 (copy), u41 (ref)
            u39[u40] = u41;
        end);
    end;

    if v43.Get == nil and (p42 and u41 == true) then
        u41 = false;
    end;

    return pcall(v43.Set, u41);
end;

local function parseKeyframePack(p44: userdata) -- Line: 358
    -- upvalues: readValue (copy), parseEase (copy), parseEaseOld (copy)
    local v45 = tonumber(p44.Name);
    assert(v45, "Bad frame number");
    local Values = p44:FindFirstChild("Values");
    assert(Values, "No value folder!");
    local v46 = Values:FindFirstChild("0");
    assert(v46, "No starting value!");
    local v47 = {};
    local v48 = 0;

    for _, child in Values:GetChildren() do
        local v49 = tonumber(child.Name);

        if v49 then
            local success, result = pcall(readValue, child);

            if success then
                v47[v49] = result;
                v48 = math.max(v49, v48);
            end;
        end;
    end;

    local Eases = p44:FindFirstChild("Eases");
    local Ease = p44:FindFirstChild("Ease");
    local v50 = {};

    if Eases then
        for _, child in Eases:GetChildren() do
            local v51 = tonumber(child.Name);
            local v52 = `Bad index on ease @{child:GetFullName()}`;
            assert(v51, v52);
            v50[v51] = parseEase(child);
        end;
    elseif Ease then
        v50[v48] = parseEaseOld(Ease);
    end;

    return {
        FrameIndex = v45,
        FrameCount = v48,
        Values = v47,
        Eases = v50
    };
end;

local function unpackKeyframes(p53: userdata, p54: function?) -- Line: 409
    -- upvalues: parseKeyframePack (copy)
    local v55 = {};
    local v56 = {};
    local v57 = {};

    for _, child in p53:GetChildren() do
        local v58 = tonumber(child.Name);

        if v58 then
            v55[v58] = parseKeyframePack(child);
            table.insert(v56, v58);
        end;
    end;

    table.sort(v56);

    for i = 2, #v56 do
        local v59 = v55[v56[i - 1]];
        local v60 = v55[v56[i]];
        v59.Next = v60;
        v60.Prev = v59;
        local _ = i;
    end;

    local v61 = v55[v56[1]];

    while v61 do
        local FrameIndex = v61.FrameIndex;
        local v62 = nil;

        for i = 0, v61.FrameCount do
            local v63 = v61.Eases[i] or v62;
            local v64 = v61.Values[i];
            local v65;

            if v64 == nil then
                v65 = i;
            else
                if p54 then
                    v64 = p54(v64);
                end;

                table.insert(v57, {
                    Time = FrameIndex + i,
                    Value = v64,
                    Ease = v63
                });

                if v63 then
                    v62 = v63;
                    v65 = i;
                else
                    v65 = i;
                end;
            end;
        end;

        v61 = v61.Next;
    end;

    return v57;
end;

local function readValueBase(p66: userdata, p67: string) -- Line: 467
    local v68 = p66:FindFirstChild(p67);
    local v69;

    if v68 then
        v69 = v68:IsA("ValueBase");
    else
        v69 = v68;
    end;

    assert(v69);

    return v68.Value;
end;

local function compileItem(p70, p71, p72) -- Line: 473
    -- upvalues: resolveAnimPath (copy), resolveJoints (copy), readValue (copy), unpackKeyframes (copy), script_Specials (copy)
    assert(p70._data and p70._save, "This track is already compiled from source");
    local table_find_ret = table.find(p70._data.Items, p71);

    if not table_find_ret then
        return;
    end;

    local Path = p71.Path;
    local ItemType = Path.ItemType;
    local v73 = p71.Override or resolveAnimPath(Path, p70._root);
    local v74 = p70._save:FindFirstChild((tostring(table_find_ret)));

    if not (v73 and v74) then
        return;
    end;

    assert(v73);
    assert(v74);
    local Rig = v74:FindFirstChild("Rig");
    local MarkerTrack = v74:FindFirstChild("MarkerTrack");

    if Rig and ItemType == "Rig" then
        local v75 = resolveJoints(v73);

        for _, child in Rig:GetChildren() do
            if child.Name == "_joint" then
                local _hier = child:FindFirstChild("_hier");
                local default = child:FindFirstChild("default");
                local _keyframes = child:FindFirstChild("_keyframes");

                if default then
                    default = readValue(default);
                end;

                local v76 = _hier and _keyframes and v75[readValue(_hier)];

                if v76 then
                    local Joint = v76.Joint;
                    local v77 = {};
                    local v78 = {
                        Default = CFrame.identity
                    };
                    local v79;

                    if Joint:IsA("Motor6D") then
                        v79 = unpackKeyframes(_keyframes, function(p80) -- Line: 525
                            -- upvalues: default (ref)
                            return p80:Inverse() * default;
                        end);
                    else
                        v79 = unpackKeyframes(_keyframes, function(p81) -- Line: 528
                            return p81;
                        end);
                    end;

                    v78.Sequence = v79;
                    v77.Transform = v78;
                    p72[Joint] = {
                        Props = v77,
                        Target = Joint
                    };
                end;
            end;
        end;
    end;

    local v82 = {};

    for _, child in v74:GetChildren() do
        if child:IsA("Folder") and (child ~= MarkerTrack and child.Name ~= "Rig") then
            local default = child:FindFirstChild("default");
            local Name = child.Name;

            if default then
                default = readValue(default);
            end;

            local v83 = script_Specials.Static(v73, Name);
            local v84 = {
                Default = default
            };

            if v83 == false then
                v83 = nil;
            end;

            v84.Static = v83;
            v84.Sequence = unpackKeyframes(child);
            v82[Name] = v84;
        end;
    end;

    p72[v73] = {
        Props = v82,
        Target = v73
    };

    if MarkerTrack then
        local v85 = {};
        p70._markers[v73] = v85;

        for _, child in MarkerTrack:GetChildren() do
            if child:FindFirstChild("name") then
                local v86 = tonumber(child.Name);
                local v87 = assert(v86);
                local width = child:FindFirstChild("width");
                local v88;

                if width then
                    v88 = width:IsA("ValueBase");
                else
                    v88 = width;
                end;

                assert(v88);
                local Value = width.Value;
                local name = child:FindFirstChild("name");
                name = name;
                local v89;

                if name then
                    v89 = name:IsA("ValueBase");
                else
                    v89 = name;
                end;

                assert(v89);
                local Value2 = name.Value;
                local v90 = {};
                local KFMarkers = child:FindFirstChild("KFMarkers");

                if KFMarkers then
                    for _, child2 in KFMarkers:GetChildren() do
                        if child2:IsA("ValueBase") then
                            local Value3 = child2.Value;
                            local Val = child2:FindFirstChild("Val");
                            local v91;

                            if Val then
                                v91 = Val:IsA("ValueBase");
                            else
                                v91 = Val;
                            end;

                            assert(v91);
                            v90[Value3] = Val.Value;
                        end;
                    end;
                end;

                local v92 = v85[v87];

                if not v92 then
                    v92 = {
                        StartMarkers = {},
                        EndMarkers = {}
                    };
                    v85[v87] = v92;
                end;

                if Value > 0 then
                    local math_min_ret = math.min(v87 + Value, p70.Frames);
                    local v93 = v85[math_min_ret];

                    if not v93 then
                        v93 = {
                            StartMarkers = {},
                            EndMarkers = {}
                        };
                        v85[math_min_ret] = v93;
                    end;

                    v93.EndMarkers[Value2] = v90;
                end;

                v92.StartMarkers[Value2] = v90;
            end;
        end;
    end;
end;

local function getInterpolator(p94) -- Line: 626
    -- upvalues: u3 (copy), lerp (copy)
    return typeof(p94) == "ColorSequence" and function(p95: userdata, p96: userdata, p97: number) -- Line: 628
        local Value = p95.Keypoints[1].Value;
        local Value2 = p96.Keypoints[1].Value;
        local v98;

        if type(Value) == "number" then
            v98 = math.lerp(Value, Value2, p97);
        else
            v98 = Value:Lerp(Value2, p97);
        end;

        return ColorSequence.new(v98);
    end or (typeof(p94) == "NumberSequence" and function(p99: userdata, p100: userdata, p101: number) -- Line: 633
        local Value = p99.Keypoints[1].Value;
        local Value2 = p100.Keypoints[1].Value;
        local v102;

        if type(Value) == "number" then
            v102 = math.lerp(Value, Value2, p101);
        else
            v102 = Value:Lerp(Value2, p101);
        end;

        return NumberSequence.new(v102);
    end or (typeof(p94) == "NumberRange" and function(p103, p104, p105: number) -- Line: 638
        local Min = p103.Min;
        local Min2 = p104.Min;
        local v106;

        if type(Min) == "number" then
            v106 = math.lerp(Min, Min2, p105);
        else
            v106 = Min:Lerp(Min2, p105);
        end;

        return NumberRange.new(v106);
    end or (u3[typeof(p94)] and function(p107: any, p108: any, p109: number) -- Line: 643
        if p109 >= 1 then
            return p108;
        end;

        return p107;
    end or lerp)));
end;

local function compileFrames(p110, p111) -- Line: 655
    -- upvalues: getInterpolator (copy), script_EaseFuncs (copy)
    local _buffer = p110._buffer;
    local _elements = p110._elements;

    for i, v in p111 do
        local v112 = {};
        _buffer[i] = v112;
        table.insert(_elements, i);

        for i2, v2 in v.Props do
            if v2.Sequence[1] then
                local Default = v2.Default;
                local v113 = getInterpolator(v2.Sequence[1].Value);
                local v114 = v2;
                local v115 = i2;
                local v116 = nil;
                local v117 = 0;

                for _, v3 in v2.Sequence do
                    if not v112[v3.Time] then
                        v112[v3.Time] = {};
                    end;

                    local v118 = v3.Time - v117;
                    v112[v3.Time][v115] = v3.Value;

                    if v118 <= 1 then
                        Default = v3.Value;
                        v116 = v3.Ease;
                        v117 = v3.Time;
                    else
                        local v119;

                        if v114.Static then
                            v119 = v3;
                        else
                            local v120 = script_EaseFuncs.Get(v116);
                            v119 = v3;

                            for i3 = 0, v118 do
                                local v121 = v120(i3 / v118);
                                local v122 = v117 + i3;

                                if not v112[v122] then
                                    v112[v122] = {};
                                end;

                                v112[v122][v115] = v113(Default, v119.Value, v121);
                                local _ = i3;
                            end;
                        end;

                        v116 = v119.Ease;
                        Default = v119.Value;
                        v117 = v119.Time;
                    end;
                end;

                if not v114.Static and v117 < p110.Frames then
                    local v123 = v112[v117][v115];

                    for i3 = v117, p110.Frames do
                        if not v112[i3] then
                            v112[i3] = {};
                        end;

                        v112[i3][v115] = v123;
                        local _ = i3;
                    end;
                end;
            end;
        end;
    end;
end;

local function compileRouting(p124) -- Line: 724
    -- upvalues: compileItem (copy), compileFrames (copy)
    assert(p124._data and p124._save, "This track is already compiled from source");
    table.clear(p124._buffer);
    table.clear(p124._elements);
    table.clear(p124._markers);
    local v125 = {};

    for _, v in p124._data.Items do
        compileItem(p124, v, v125);
    end;

    compileFrames(p124, v125);
    p124._compiled = true;
end;

local function restoreTrack(p126) -- Line: 741
    -- upvalues: u4 (copy), setPropValue (copy)
    local v127 = u4[p126];

    if not v127 then
        return;
    end;

    if p126.RestoreDefaults then
        for i, v in v127 do
            local v128 = i;

            for i2, v2 in v do
                setPropValue(p126, v128, i2, v2);
            end;
        end;

        setPropValue(p126, workspace.CurrentCamera, "AttachToPart", nil);
        setPropValue(p126, workspace.CurrentCamera, "LookAtPart", nil);
    end;

    u4[p126] = nil;
end;

local function stepTrack(p129: any, p130: number) -- Line: 763
    -- upvalues: setPropValue (copy)
    local math_floor_ret = math.floor(p129.TimePosition * p129.FrameRate);

    if p129.Frames < math_floor_ret then
        if not p129.Looped then
            p129._completed:Fire(Enum.PlaybackState.Completed);

            return true;
        end;

        p129.TimePosition = 0;
        p129.CurrentFrame = 0;
        p129._onLoop:Fire();
        math_floor_ret = 0;
    end;

    for i = p129.CurrentFrame, math_floor_ret do
        local v131 = i;

        for i2, v in p129._buffer do
            if p129._locks[i2] == nil then
                local v132 = v[v131];

                if v132 then
                    local v133 = i2;

                    for i3, v2 in v132 do
                        setPropValue(p129, v133, i3, v2);
                    end;
                end;
            end;
        end;

        for i2, v in p129._markers do
            local v134 = v[v131];

            if v134 then
                local v135 = i2;

                for i3, v2 in v134.StartMarkers do
                    if p129._markerSignals[i3] then
                        p129._markerSignals[i3]:Fire(v135, v2);
                    end;
                end;

                for i3, v2 in v134.EndMarkers do
                    if p129._endMarkerSignals[i3] then
                        p129._endMarkerSignals[i3]:Fire(v135, v2);
                    end;
                end;
            end;
        end;
    end;

    p129.CurrentFrame = math_floor_ret;
    p129.TimePosition = p129.TimePosition + p130;

    return false;
end;

function v1.CreatePlayer(p136: table, p137: userdata?) -- Line: 818
    -- upvalues: deepCopy (copy), u2 (copy)
    local BindableEvent = Instance.new("BindableEvent");
    local BindableEvent2 = Instance.new("BindableEvent");
    local v138 = deepCopy(p136);

    return setmetatable({
        RestoreDefaults = true,
        TimePosition = 0,
        CurrentFrame = 0,
        _compiled = false,
        Completed = BindableEvent.Event,
        OnLoop = BindableEvent2.Event,
        Looped = v138.Information.Looped,
        Frames = v138.Information.Length,
        FrameRate = v138.Information.FPS or 60,
        _moduleInfo = v138,
        _completed = BindableEvent,
        _onLoop = BindableEvent2,
        _markers = {},
        _markerSignals = {},
        _endMarkerSignals = {},
        _locks = {},
        _elements = {},
        _buffer = {},
        _scratch = {},
        _root = p137
    }, u2);
end;

function u2.Compile(p139) -- Line: 855
    -- upvalues: compileRouting (copy), resolveAnimPath (copy), compileFrames (copy)
    if p139._save then
        compileRouting(p139);

        return p139;
    end;

    if p139._moduleInfo then
        local v140 = {};

        for i, v in p139._moduleInfo.Compiled do
            local v141 = v.Override or resolveAnimPath(v.Path or i, p139._root);

            if v141 then
                for _, v2 in v.Props do
                    local Default = v2.Default;

                    if type(Default) == "table" and type(Default.ItemType) == "string" then
                        Default = Default.Override or resolveAnimPath(Default, p139._root);
                    end;

                    v2.Default = Default;

                    for _, v3 in v2.Sequence do
                        local Value = v3.Value;

                        if type(Value) == "table" and type(Value.ItemType) == "string" then
                            Value = Value.Override or resolveAnimPath(Value, p139._root);
                        end;

                        v3.Value = Value;
                    end;
                end;

                v140[v141] = v;
            end;
        end;

        compileFrames(p139, v140);
        p139._compiled = true;
    end;

    return p139;
end;

function u2.Destroy(p142) -- Line: 893
    for _, v in p142._markerSignals do
        v:Destroy();
    end;

    for _, v in p142._endMarkerSignals do
        v:Destroy();
    end;

    p142._completed:Destroy();
    table.clear(p142._markerSignals);
    table.clear(p142._endMarkerSignals);
end;

function u2.IsPlaying(p143) -- Line: 907
    -- upvalues: u4 (copy)
    return u4[p143] ~= nil;
end;

function u2.GetTimeLength(p144) -- Line: 911
    return p144.Frames / p144.FrameRate;
end;

function u2.GetMarkerReachedSignal(p145: any, p146: string) -- Line: 915
    if not p145._markerSignals[p146] then
        p145._markerSignals[p146] = Instance.new("BindableEvent");
    end;

    return p145._markerSignals[p146].Event;
end;

function u2.GetMarkerEndedSignal(p147: any, p148: string) -- Line: 923
    if not p147._endMarkerSignals[p148] then
        p147._endMarkerSignals[p148] = Instance.new("BindableEvent");
    end;

    return p147._endMarkerSignals[p148].Event;
end;

function u2.GetSetting(p149: any, p150: string) -- Line: 931
    return p149._scratch[p150];
end;

function u2.SetSetting(p151: any, p152: string, p153: any) -- Line: 935
    p151._scratch[p152] = p153;
end;

function u2.GetElements(p154) -- Line: 939
    return table.clone(p154._elements);
end;

function u2.LockElement(p155: any, p156: userdata, p157: any) -- Line: 943
    if not p155._locks[p156] then
        p155._locks[p156] = {};
    end;

    if p157 then
        p155._locks[p156][p157 or "Default"] = true;
    end;

    return true;
end;

function u2.UnlockElement(p158: any, p159: userdata, p160: any) -- Line: 955
    local v161 = p158._locks[p159];

    if v161 then
        v161[p160 or "Default"] = nil;

        if not next(v161) then
            p158._locks[p159] = nil;
        end;
    end;

    return true;
end;

function u2.IsElementLocked(p162: any, p163: userdata) -- Line: 969
    return p162._locks[p163] ~= nil;
end;

function u2.ReplaceElementByPath(p164: any, p165: string, p166: userdata) -- Line: 973
    -- upvalues: toPath (copy)
    local string_lower_ret = string.lower(p165);

    if p164._data then
        for _, v in p164._data.Items do
            local Path = v.Path;

            if string.lower(toPath(Path)) == string_lower_ret and (Path.ItemType == "Rig" or p166:IsA(Path.ItemType)) then
                v.Override = p166;

                return true;
            end;
        end;
    elseif p164._moduleInfo then
        local v167 = false;

        for i, v in p164._moduleInfo.Compiled do
            local ItemType = i.ItemType;

            if string.lower(toPath(i)) == string_lower_ret and (ItemType == "Rig" or p166:IsA(i.ItemType)) then
                v.Override = p166;
                v167 = true;
            end;

            local v168 = v;

            for _, v2 in v.Props do
                local Default = v2.Default;

                if type(Default) == "table" and (type(Default.ItemType) == "string" and (string_lower_ret == string.lower(toPath(Default)) and (Default.ItemType == "Rig" or p166:IsA(Default.ItemType)))) then
                    v168.Override = p166;
                    v167 = true;
                end;

                for _, v3 in v2.Sequence do
                    local Value = v3.Value;

                    if type(Value) == "table" and (type(Value.ItemType) == "string" and (string_lower_ret == string.lower(toPath(Value)) and (Value.ItemType == "Rig" or p166:IsA(Value.ItemType)))) then
                        v168.Override = p166;
                        v167 = true;
                    end;
                end;
            end;
        end;

        return v167;
    end;

    return false;
end;

function u2.FindElement(p169: any, p170: string) -- Line: 1029
    for _, v in p169._elements do
        if v and v.Name == p170 then
            return v;
        end;
    end;

    return nil;
end;

function u2.FindElementOfType(p171: any, p172: string) -- Line: 1039
    for _, v in p171._elements do
        if v and v:IsA(p172) then
            return v;
        end;
    end;

    return nil;
end;

function u2.Stop(p173) -- Line: 1049
    -- upvalues: restoreTrack (copy)
    p173.TimePosition = 0;
    p173.CurrentFrame = 0;
    task.spawn(restoreTrack, p173);
    p173._completed:Fire(Enum.PlaybackState.Cancelled);
end;

function u2.Reset(p174) -- Line: 1056
    -- upvalues: stepTrack (copy)
    p174.TimePosition = 0;
    p174.CurrentFrame = 0;
    stepTrack(p174, 0);

    return true;
end;

function u2.Play(p175) -- Line: 1064
    -- upvalues: u4 (copy), getPropValue (copy)
    assert(p175._compiled, "Track is not compiled.");

    if u4[p175] then
        return;
    end;

    if p175.TimePosition >= p175:GetTimeLength() then
        p175.TimePosition = 0;
        p175.CurrentFrame = 0;
    end;

    local v176 = {};

    for i, v in p175._buffer do
        if v[0] then
            local v177 = {};
            v176[i] = v177;
            local v178 = i;

            for i2 in v[0] do
                local v179, v180 = getPropValue(p175, v178, i2);

                if v179 then
                    v177[i2] = v180;
                end;
            end;
        end;
    end;

    u4[p175] = v176;
    p175._completed:Fire(Enum.PlaybackState.Playing);
end;

RunService.PreSimulation:Connect(function(p181: number) -- Line: 1097
    -- upvalues: u4 (copy), stepTrack (copy), restoreTrack (copy)
    for i in u4 do
        if stepTrack(i, p181) then
            restoreTrack(i);
        end;
    end;
end);

function v1.instanceToMoonAnimPath(p182: userdata) -- Line: 119
    local v183, v184, v185;

    if p182:IsDescendantOf(game) then
        v183 = p182;
        v184 = {};
        v185 = {};
    else
        error("Instance is not descendant of game");
        v183 = p182;
        v184 = {};
        v185 = {};
    end;

    while p182 ~= game do
        table.insert(v184, 1, p182.Name);
        table.insert(v185, 1, p182.ClassName);
        p182 = p182.Parent;
    end;

    table.insert(v184, 1, "game");
    table.insert(v185, 1, "DataModel");

    return {
        InstanceTypes = v185,
        ItemType = v183.ClassName,
        InstanceNames = v184
    };
end;

v1.resolveAnimPath = resolveAnimPath;
v1.toPathString = toPath;

return v1;