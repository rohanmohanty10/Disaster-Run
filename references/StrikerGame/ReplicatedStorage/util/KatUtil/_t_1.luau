 
 

local u8 = {
    type = function(u1) -- Line: 9, Name: type
        return function(p2) -- Line: 10
            -- upvalues: u1 (copy)
            local v3 = type(p2);

            if v3 == u1 then
                return true;
            end;

            return false, string.format("%s expected, got %s", u1, v3);
        end;
    end,

    typeof = function(u4) -- Line: 20, Name: typeof
        return function(p5) -- Line: 21
            -- upvalues: u4 (copy)
            local v6 = typeof(p5);

            if v6 == u4 then
                return true;
            end;

            return false, string.format("%s expected, got %s", u4, v6);
        end;
    end,

    any = function(p7) -- Line: 38, Name: any
        if p7 == nil then
            return false, "any expected, got nil";
        end;

        return true;
    end
};
u8.boolean = u8.typeof("boolean");
u8.buffer = u8.typeof("buffer");
u8.thread = u8.typeof("thread");
u8.callback = u8.typeof("function");
u8["function"] = u8.callback;
u8.none = u8.typeof("nil");
u8["nil"] = u8.none;
u8.string = u8.typeof("string");
u8.table = u8.typeof("table");
u8.userdata = u8.type("userdata");
u8.vector = u8.type("vector");

function u8.number(p9) -- Line: 138
    local v10 = typeof(p9);

    if v10 ~= "number" then
        return false, string.format("number expected, got %s", v10);
    end;

    if p9 == p9 then
        return true;
    end;

    return false, "unexpected NaN value";
end;

function u8.nan(p11) -- Line: 158
    local v12 = typeof(p11);

    if v12 ~= "number" then
        return false, string.format("number expected, got %s", v12);
    end;

    if p11 == p11 then
        return false, "unexpected non-NaN value";
    end;

    return true;
end;

u8.Axes = u8.typeof("Axes");
u8.BrickColor = u8.typeof("BrickColor");
u8.CatalogSearchParams = u8.typeof("CatalogSearchParams");
u8.CFrame = u8.typeof("CFrame");
u8.Color3 = u8.typeof("Color3");
u8.ColorSequence = u8.typeof("ColorSequence");
u8.ColorSequenceKeypoint = u8.typeof("ColorSequenceKeypoint");
u8.DateTime = u8.typeof("DateTime");
u8.DockWidgetPluginGuiInfo = u8.typeof("DockWidgetPluginGuiInfo");
u8.Enum = u8.typeof("Enum");
u8.EnumItem = u8.typeof("EnumItem");
u8.Enums = u8.typeof("Enums");
u8.Faces = u8.typeof("Faces");
u8.FloatCurveKey = u8.typeof("FloatCurveKey");
u8.Font = u8.typeof("Font");
u8.Instance = u8.typeof("Instance");
u8.NumberRange = u8.typeof("NumberRange");
u8.NumberSequence = u8.typeof("NumberSequence");
u8.NumberSequenceKeypoint = u8.typeof("NumberSequenceKeypoint");
u8.OverlapParams = u8.typeof("OverlapParams");
u8.PathWaypoint = u8.typeof("PathWaypoint");
u8.PhysicalProperties = u8.typeof("PhysicalProperties");
u8.Random = u8.typeof("Random");
u8.Ray = u8.typeof("Ray");
u8.RaycastParams = u8.typeof("RaycastParams");
u8.RaycastResult = u8.typeof("RaycastResult");
u8.RBXScriptConnection = u8.typeof("RBXScriptConnection");
u8.RBXScriptSignal = u8.typeof("RBXScriptSignal");
u8.Rect = u8.typeof("Rect");
u8.Region3 = u8.typeof("Region3");
u8.Region3int16 = u8.typeof("Region3int16");
u8.TweenInfo = u8.typeof("TweenInfo");
u8.UDim = u8.typeof("UDim");
u8.UDim2 = u8.typeof("UDim2");
u8.Vector2 = u8.typeof("Vector2");
u8.Vector2int16 = u8.typeof("Vector2int16");
u8.Vector3 = u8.typeof("Vector3");
u8.Vector3int16 = u8.typeof("Vector3int16");

function u8.keys(u13: function) -- Line: 522
    -- upvalues: u8 (copy)
    assert(u8.callback(u13));

    return function(p14) -- Line: 524
        -- upvalues: u8 (ref), u13 (copy)
        local v15, v16 = u8.table(p14);

        if v15 == false then
            return false, v16 or "";
        end;

        for i in pairs(p14) do
            local v17, v18 = u13(i);

            if v17 == false then
                return false, string.format("bad key %s:\n\t%s", tostring(i), v18 or "");
            end;
        end;

        return true;
    end;
end;

function u8.values(u19: function) -- Line: 548
    -- upvalues: u8 (copy)
    assert(u8.callback(u19));

    return function(p20) -- Line: 550
        -- upvalues: u8 (ref), u19 (copy)
        local v21, v22 = u8.table(p20);

        if v21 == false then
            return false, v22 or "";
        end;

        for i, v in pairs(p20) do
            local v23, v24 = u19(v);

            if v23 == false then
                return false, string.format("bad value for key %s:\n\t%s", tostring(i), v24 or "");
            end;
        end;

        return true;
    end;
end;

function u8.integer(p25) -- Line: 574
    -- upvalues: u8 (copy)
    local v26, v27 = u8.number(p25);

    if not v26 then
        return false, v27 or "";
    end;

    if p25 % 1 == 0 then
        return true;
    end;

    return false, string.format("integer expected, got %s", p25);
end;

local u28 = u8.keys(u8.integer);

function u8.array(p29: function) -- Line: 596
    -- upvalues: u8 (copy), u28 (copy)
    assert(u8.callback(p29));
    local u30 = u8.values(p29);

    return function(p31) -- Line: 600
        -- upvalues: u28 (ref), u30 (copy)
        local v32, v33 = u28(p31);

        if v32 == false then
            return false, string.format("[array] %s", v33 or "");
        end;

        local v34 = 0;

        for _ in ipairs(p31) do
            v34 = v34 + 1;
        end;

        for i in pairs(p31) do
            if i < 1 or v34 < i then
                return false, string.format("[array] key %s must be sequential", (tostring(i)));
            end;
        end;

        local v35, v36 = u30(p31);

        if v35 then
            return true;
        end;

        return false, string.format("[array] %s", v36 or "");
    end;
end;

function u8.strictArray(...) -- Line: 636
    -- upvalues: u8 (copy), u28 (copy)
    local u37 = { ... };
    local v38 = u8.array(u8.callback);
    assert(v38(u37));

    return function(p39) -- Line: 640
        -- upvalues: u28 (ref), u37 (copy)
        local v40, v41 = u28(p39);

        if v40 == false then
            return false, string.format("[strictArray] %s", v41 or "");
        end;

        if #u37 < #p39 then
            return false, string.format("[strictArray] Array size exceeds limit of %d", #u37);
        end;

        for i, v in pairs(u37) do
            local v42, v43 = v(p39[i]);

            if not v42 then
                return false, string.format("[strictArray] Array index #%d - %s", i, v43);
            end;
        end;

        return true;
    end;
end;

local u44 = u8.array(u8.callback);

function u8.union(...) -- Line: 672
    -- upvalues: u44 (copy)
    local u45 = { ... };
    assert(u44(u45));

    return function(p46) -- Line: 676
        -- upvalues: u45 (copy)
        for _, v in ipairs(u45) do
            if v(p46) then
                return true;
            end;
        end;

        return false, "bad type for union";
    end;
end;

u8.some = u8.union;

function u8.intersection(...) -- Line: 699
    -- upvalues: u44 (copy)
    local u47 = { ... };
    assert(u44(u47));

    return function(p48) -- Line: 703
        -- upvalues: u47 (copy)
        for _, v in ipairs(u47) do
            local v49, v50 = v(p48);

            if not v49 then
                return false, v50 or "";
            end;
        end;

        return true;
    end;
end;

u8.every = u8.intersection;

function u8.literal(...) -- Line: 728
    -- upvalues: u8 (copy)
    local v51 = select("#", ...);

    if v51 == 1 then
        local u52 = ...;

        return function(p53) -- Line: 732
            -- upvalues: u52 (copy)
            if p53 == u52 then
                return true;
            end;

            return false, string.format("expected %s, got %s", tostring(u52), (tostring(p53)));
        end;
    end;

    local v54 = {};

    for i = 1, v51 do
        local v55 = select(i, ...);
        v54[i] = u8.literal(v55);
        local _ = i;
    end;

    return u8.union(table.unpack(v54, 1, v51));
end;

u8.exactly = u8.literal;

function u8.keyOf(p56: table) -- Line: 763
    -- upvalues: u8 (copy)
    local v57 = 0;
    local v58 = {};

    for i in pairs(p56) do
        v57 = v57 + 1;
        v58[v57] = i;
    end;

    return u8.literal(table.unpack(v58, 1, v57));
end;

function u8.valueOf(p59: table) -- Line: 781
    -- upvalues: u8 (copy)
    local v60 = 0;
    local v61 = {};

    for _, v in pairs(p59) do
        v60 = v60 + 1;
        v61[v60] = v;
    end;

    return u8.literal(table.unpack(v61, 1, v60));
end;

function u8.integerMin(u62) -- Line: 799
    -- upvalues: u8 (copy)
    return function(p63) -- Line: 800
        -- upvalues: u8 (ref), u62 (copy)
        local v64, v65 = u8.integer(p63);

        if not v64 then
            return false, v65 or "";
        end;

        if u62 <= p63 then
            return true;
        end;

        return false, string.format("integer >= %s expected, got %s", u62, p63);
    end;
end;

function u8.integerMax(u66) -- Line: 821
    -- upvalues: u8 (copy)
    return function(p67) -- Line: 822
        -- upvalues: u8 (ref), u66 (copy)
        local v68, v69 = u8.integer(p67);

        if not v68 then
            return false, v69;
        end;

        if p67 <= u66 then
            return true;
        end;

        return false, string.format("integer <= %s expected, got %s", u66, p67);
    end;
end;

function u8.integerMinExclusive(u70) -- Line: 843
    -- upvalues: u8 (copy)
    return function(p71) -- Line: 844
        -- upvalues: u8 (ref), u70 (copy)
        local v72, v73 = u8.integer(p71);

        if not v72 then
            return false, v73 or "";
        end;

        if u70 < p71 then
            return true;
        end;

        return false, string.format("integer > %s expected, got %s", u70, p71);
    end;
end;

function u8.integerMaxExclusive(u74) -- Line: 865
    -- upvalues: u8 (copy)
    return function(p75) -- Line: 866
        -- upvalues: u8 (ref), u74 (copy)
        local v76, v77 = u8.integer(p75);

        if not v76 then
            return false, v77 or "";
        end;

        if p75 < u74 then
            return true;
        end;

        return false, string.format("integer < %s expected, got %s", u74, p75);
    end;
end;

function u8.integerConstrained(p78, p79) -- Line: 888
    -- upvalues: u8 (copy)
    assert(u8.integer(p78));
    assert(u8.integer(p79));
    local u80 = u8.integerMin(p78);
    local u81 = u8.integerMax(p79);

    return function(p82) -- Line: 894
        -- upvalues: u80 (copy), u81 (copy)
        local v83, v84 = u80(p82);

        if not v83 then
            return false, v84 or "";
        end;

        local v85, v86 = u81(p82);

        if v85 then
            return true;
        end;

        return false, v86 or "";
    end;
end;

function u8.integerConstrainedExclusive(p87, p88) -- Line: 917
    -- upvalues: u8 (copy)
    assert(u8.number(p87));
    assert(u8.number(p88));
    local u89 = u8.integerMinExclusive(p87);
    local u90 = u8.integerMaxExclusive(p88);

    return function(p91) -- Line: 923
        -- upvalues: u89 (copy), u90 (copy)
        local v92, v93 = u89(p91);

        if not v92 then
            return false, v93 or "";
        end;

        local v94, v95 = u90(p91);

        if v94 then
            return true;
        end;

        return false, v95 or "";
    end;
end;

u8.integerPositive = u8.integerMinExclusive(0);
u8.integerNegative = u8.integerMaxExclusive(0);

function u8.numberMin(u96) -- Line: 959
    -- upvalues: u8 (copy)
    return function(p97) -- Line: 960
        -- upvalues: u8 (ref), u96 (copy)
        local v98, v99 = u8.number(p97);

        if not v98 then
            return false, v99 or "";
        end;

        if u96 <= p97 then
            return true;
        end;

        return false, string.format("number >= %s expected, got %s", u96, p97);
    end;
end;

function u8.numberMax(u100) -- Line: 981
    -- upvalues: u8 (copy)
    return function(p101) -- Line: 982
        -- upvalues: u8 (ref), u100 (copy)
        local v102, v103 = u8.number(p101);

        if not v102 then
            return false, v103;
        end;

        if p101 <= u100 then
            return true;
        end;

        return false, string.format("number <= %s expected, got %s", u100, p101);
    end;
end;

function u8.numberMinExclusive(u104) -- Line: 1003
    -- upvalues: u8 (copy)
    return function(p105) -- Line: 1004
        -- upvalues: u8 (ref), u104 (copy)
        local v106, v107 = u8.number(p105);

        if not v106 then
            return false, v107 or "";
        end;

        if u104 < p105 then
            return true;
        end;

        return false, string.format("number > %s expected, got %s", u104, p105);
    end;
end;

function u8.numberMaxExclusive(u108) -- Line: 1025
    -- upvalues: u8 (copy)
    return function(p109) -- Line: 1026
        -- upvalues: u8 (ref), u108 (copy)
        local v110, v111 = u8.number(p109);

        if not v110 then
            return false, v111 or "";
        end;

        if p109 < u108 then
            return true;
        end;

        return false, string.format("number < %s expected, got %s", u108, p109);
    end;
end;

u8.numberPositive = u8.numberMinExclusive(0);
u8.numberNegative = u8.numberMaxExclusive(0);

function u8.numberConstrained(p112, p113) -- Line: 1062
    -- upvalues: u8 (copy)
    assert(u8.number(p112));
    assert(u8.number(p113));
    local u114 = u8.numberMin(p112);
    local u115 = u8.numberMax(p113);

    return function(p116) -- Line: 1068
        -- upvalues: u114 (copy), u115 (copy)
        local v117, v118 = u114(p116);

        if not v117 then
            return false, v118 or "";
        end;

        local v119, v120 = u115(p116);

        if v119 then
            return true;
        end;

        return false, v120 or "";
    end;
end;

function u8.numberConstrainedExclusive(p121, p122) -- Line: 1091
    -- upvalues: u8 (copy)
    assert(u8.number(p121));
    assert(u8.number(p122));
    local u123 = u8.numberMinExclusive(p121);
    local u124 = u8.numberMaxExclusive(p122);

    return function(p125) -- Line: 1097
        -- upvalues: u123 (copy), u124 (copy)
        local v126, v127 = u123(p125);

        if not v126 then
            return false, v127 or "";
        end;

        local v128, v129 = u124(p125);

        if v128 then
            return true;
        end;

        return false, v129 or "";
    end;
end;

function u8.match(u130) -- Line: 1119
    -- upvalues: u8 (copy)
    assert(u8.string(u130));

    return function(p131) -- Line: 1121
        -- upvalues: u8 (ref), u130 (copy)
        local v132, v133 = u8.string(p131);

        if not v132 then
            return false, v133;
        end;

        if string.match(p131, u130) == nil then
            return false, string.format("%q failed to match pattern %q", p131, u130);
        end;

        return true;
    end;
end;

function u8.optional(u134: function) -- Line: 1142
    -- upvalues: u8 (copy)
    assert(u8.callback(u134));

    return function(p135) -- Line: 1144
        -- upvalues: u134 (copy)
        if p135 == nil then
            return true;
        end;

        local v136, v137 = u134(p135);

        if v136 then
            return true;
        end;

        return false, string.format("(optional) %s", v137 or "");
    end;
end;

function u8.tuple(...) -- Line: 1165
    local u138 = { ... };

    return function(...) -- Line: 1167
        -- upvalues: u138 (copy)
        local v139 = { ... };

        for i, v in ipairs(u138) do
            local v140, v141 = v(v139[i]);

            if v140 == false then
                return false, string.format("Bad tuple index #%s:\n\t%s", tostring(i), v141 or "");
            end;
        end;

        return true;
    end;
end;

function u8.map(p142: function, p143: function) -- Line: 1188
    -- upvalues: u8 (copy)
    assert(u8.callback(p142));
    assert(u8.callback(p143));
    local u144 = u8.keys(p142);
    local u145 = u8.values(p143);

    return function(p146) -- Line: 1194
        -- upvalues: u144 (copy), u145 (copy)
        local v147, v148 = u144(p146);

        if not v147 then
            return false, v148 or "";
        end;

        local v149, v150 = u145(p146);

        if v149 then
            return true;
        end;

        return false, v150 or "";
    end;
end;

function u8.set(p151: function) -- Line: 1216
    -- upvalues: u8 (copy)
    return u8.map(p151, u8.literal(true));
end;

local u152 = u8.map(u8.any, u8.callback);

function u8.interface(u153: table) -- Line: 1229
    -- upvalues: u152 (copy), u8 (copy)
    assert(u152(u153));

    return function(p154) -- Line: 1231
        -- upvalues: u8 (ref), u153 (copy)
        local v155, v156 = u8.table(p154);

        if v155 == false then
            return false, v156 or "";
        end;

        for i, v in pairs(u153) do
            local v157, v158 = v(p154[i]);

            if v157 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(i), v158 or "");
            end;
        end;

        return true;
    end;
end;

function u8.strictInterface(u159: table) -- Line: 1255
    -- upvalues: u152 (copy), u8 (copy)
    assert(u152(u159));

    return function(p160) -- Line: 1257
        -- upvalues: u8 (ref), u159 (copy)
        local v161, v162 = u8.table(p160);

        if v161 == false then
            return false, v162 or "";
        end;

        for i, v in pairs(u159) do
            local v163, v164 = v(p160[i]);

            if v163 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(i), v164 or "");
            end;
        end;

        for i in pairs(p160) do
            if not u159[i] then
                return false, string.format("[interface] unexpected field %q", (tostring(i)));
            end;
        end;

        return true;
    end;
end;

local u165 = u8.map(u8.string, u8.callback);

function u8.children(u166: table) -- Line: 1295
    -- upvalues: u165 (copy), u8 (copy)
    assert(u165(u166));

    return function(p167) -- Line: 1298
        -- upvalues: u8 (ref), u166 (copy)
        local v168, v169 = u8.Instance(p167);

        if not v168 then
            return false, v169 or "";
        end;

        local v170 = {};

        for _, child in ipairs(p167:GetChildren()) do
            local Name = child.Name;

            if u166[Name] then
                if v170[Name] then
                    return false, string.format("Cannot process multiple children with the same name %q", Name);
                end;

                v170[Name] = child;
            end;
        end;

        for i, v in pairs(u166) do
            local v171, v172 = v(v170[i]);

            if not v171 then
                return false, string.format("[%s.%s] %s", p167:GetFullName(), i, v172 or "");
            end;
        end;

        return true;
    end;
end;

function u8.instanceOf(u173: string, p174: table?) -- Line: 1335
    -- upvalues: u8 (copy)
    assert(u8.string(u173));
    local u175;

    if p174 == nil then
        u175 = nil;
    else
        u175 = u8.children(p174);
    end;

    return function(p176) -- Line: 1343
        -- upvalues: u8 (ref), u173 (copy), u175 (ref)
        local v177, v178 = u8.Instance(p176);

        if not v177 then
            return false, v178 or "";
        end;

        if p176.ClassName ~= u173 then
            return false, string.format("%s expected, got %s", u173, p176.ClassName);
        end;

        if u175 then
            local v179, v180 = u175(p176);

            if not v179 then
                return false, v180;
            end;
        end;

        return true;
    end;
end;

u8.instance = u8.instanceOf;

function u8.instanceIsA(u181: string, p182: table?) -- Line: 1373
    -- upvalues: u8 (copy)
    assert(u8.string(u181));
    local u183;

    if p182 == nil then
        u183 = nil;
    else
        u183 = u8.children(p182);
    end;

    return function(p184) -- Line: 1381
        -- upvalues: u8 (ref), u181 (copy), u183 (ref)
        local v185, v186 = u8.Instance(p184);

        if not v185 then
            return false, v186 or "";
        end;

        if not p184:IsA(u181) then
            return false, string.format("%s expected, got %s", u181, p184.ClassName);
        end;

        if u183 then
            local v187, v188 = u183(p184);

            if not v187 then
                return false, v188;
            end;
        end;

        return true;
    end;
end;

function u8.enum(u189) -- Line: 1409
    -- upvalues: u8 (copy)
    assert(u8.Enum(u189));

    return function(p190) -- Line: 1411
        -- upvalues: u8 (ref), u189 (copy)
        local v191, v192 = u8.EnumItem(p190);

        if not v191 then
            return false, v192;
        end;

        if p190.EnumType == u189 then
            return true;
        end;

        return false, string.format("enum of %s expected, got enum of %s", tostring(u189), (tostring(p190.EnumType)));
    end;
end;

local u193 = u8.tuple(u8.callback, u8.callback);

function u8.wrap(u194: any, u195: function) -- Line: 1436
    -- upvalues: u193 (copy)
    assert(u193(u194, u195));

    return function(...) -- Line: 1438
        -- upvalues: u195 (copy), u194 (copy)
        assert(u195(...));

        return u194(...);
    end;
end;

function u8.strict(u196: function) -- Line: 1452
    return function(...) -- Line: 1453
        -- upvalues: u196 (copy)
        assert(u196(...));
    end;
end;

return u8;