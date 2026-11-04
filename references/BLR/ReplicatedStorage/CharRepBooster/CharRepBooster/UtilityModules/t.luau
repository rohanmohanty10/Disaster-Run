  

local u8 = {
    type = function(u1) -- Line: 5, Name: type
        return function(p2) -- Line: 6
            -- upvalues: u1 (copy)
            local v3 = type(p2);

            if v3 == u1 then
                return true;
            end;

            return false, string.format("%s expected, got %s", u1, v3);
        end;
    end,

    typeof = function(u4) -- Line: 16, Name: typeof
        return function(p5) -- Line: 17
            -- upvalues: u4 (copy)
            local v6 = typeof(p5);

            if v6 == u4 then
                return true;
            end;

            return false, string.format("%s expected, got %s", u4, v6);
        end;
    end,

    any = function(p7) -- Line: 34, Name: any
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

function u8.number(p9) -- Line: 134
    local v10 = typeof(p9);

    if v10 ~= "number" then
        return false, string.format("number expected, got %s", v10);
    end;

    if p9 == p9 then
        return true;
    end;

    return false, "unexpected NaN value";
end;

function u8.nan(p11) -- Line: 154
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
u8.Content = u8.typeof("Content");
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

function u8.literalList(u13) -- Line: 527
    local u14 = {};

    for _, v in ipairs(u13) do
        u14[v] = true;
    end;

    return function(p15) -- Line: 533
        -- upvalues: u14 (copy), u13 (copy)
        if u14[p15] then
            return true;
        end;

        for _, v in ipairs(u13) do
            if v == p15 then
                return true;
            end;
        end;

        return false, "bad type for literal list";
    end;
end;

function u8.literal(...) -- Line: 554
    -- upvalues: u8 (copy)
    local v16 = select("#", ...);

    if v16 == 1 then
        local u17 = ...;

        return function(p18) -- Line: 558
            -- upvalues: u17 (copy)
            if p18 == u17 then
                return true;
            end;

            return false, string.format("expected %s, got %s", tostring(u17), (tostring(p18)));
        end;
    end;

    local v19 = {};

    for i = 1, v16 do
        local v20 = select(i, ...);
        v19[i] = u8.literal(v20);
        local _ = i;
    end;

    return u8.unionList(v19);
end;

u8.exactly = u8.literal;

function u8.keyOf(p21) -- Line: 589
    -- upvalues: u8 (copy)
    local v22 = 0;
    local v23 = {};

    for i in pairs(p21) do
        v22 = v22 + 1;
        v23[v22] = i;
    end;

    return u8.literal(table.unpack(v23, 1, v22));
end;

function u8.valueOf(p24) -- Line: 607
    -- upvalues: u8 (copy)
    local v25 = 0;
    local v26 = {};

    for _, v in pairs(p24) do
        v25 = v25 + 1;
        v26[v25] = v;
    end;

    return u8.literal(table.unpack(v26, 1, v25));
end;

function u8.integer(p27) -- Line: 625
    -- upvalues: u8 (copy)
    local v28, v29 = u8.number(p27);

    if not v28 then
        return false, v29 or "";
    end;

    if p27 % 1 == 0 then
        return true;
    end;

    return false, string.format("integer expected, got %s", p27);
end;

function u8.numberMin(u30) -- Line: 645
    -- upvalues: u8 (copy)
    return function(p31) -- Line: 646
        -- upvalues: u8 (ref), u30 (copy)
        local v32, v33 = u8.number(p31);

        if not v32 then
            return false, v33 or "";
        end;

        if u30 <= p31 then
            return true;
        end;

        return false, string.format("number >= %s expected, got %s", u30, p31);
    end;
end;

function u8.numberMax(u34) -- Line: 667
    -- upvalues: u8 (copy)
    return function(p35) -- Line: 668
        -- upvalues: u8 (ref), u34 (copy)
        local v36, v37 = u8.number(p35);

        if not v36 then
            return false, v37;
        end;

        if p35 <= u34 then
            return true;
        end;

        return false, string.format("number <= %s expected, got %s", u34, p35);
    end;
end;

function u8.numberMinExclusive(u38) -- Line: 689
    -- upvalues: u8 (copy)
    return function(p39) -- Line: 690
        -- upvalues: u8 (ref), u38 (copy)
        local v40, v41 = u8.number(p39);

        if not v40 then
            return false, v41 or "";
        end;

        if u38 < p39 then
            return true;
        end;

        return false, string.format("number > %s expected, got %s", u38, p39);
    end;
end;

function u8.numberMaxExclusive(u42) -- Line: 711
    -- upvalues: u8 (copy)
    return function(p43) -- Line: 712
        -- upvalues: u8 (ref), u42 (copy)
        local v44, v45 = u8.number(p43);

        if not v44 then
            return false, v45 or "";
        end;

        if p43 < u42 then
            return true;
        end;

        return false, string.format("number < %s expected, got %s", u42, p43);
    end;
end;

u8.numberPositive = u8.numberMinExclusive(0);
u8.numberNegative = u8.numberMaxExclusive(0);

function u8.numberConstrained(p46, p47) -- Line: 748
    -- upvalues: u8 (copy)
    assert(u8.number(p46));
    assert(u8.number(p47));
    local u48 = u8.numberMin(p46);
    local u49 = u8.numberMax(p47);

    return function(p50) -- Line: 754
        -- upvalues: u48 (copy), u49 (copy)
        local v51, v52 = u48(p50);

        if not v51 then
            return false, v52 or "";
        end;

        local v53, v54 = u49(p50);

        if v53 then
            return true;
        end;

        return false, v54 or "";
    end;
end;

function u8.numberConstrainedExclusive(p55, p56) -- Line: 777
    -- upvalues: u8 (copy)
    assert(u8.number(p55));
    assert(u8.number(p56));
    local u57 = u8.numberMinExclusive(p55);
    local u58 = u8.numberMaxExclusive(p56);

    return function(p59) -- Line: 783
        -- upvalues: u57 (copy), u58 (copy)
        local v60, v61 = u57(p59);

        if not v60 then
            return false, v61 or "";
        end;

        local v62, v63 = u58(p59);

        if v62 then
            return true;
        end;

        return false, v63 or "";
    end;
end;

function u8.match(u64) -- Line: 805
    -- upvalues: u8 (copy)
    assert(u8.string(u64));

    return function(p65) -- Line: 807
        -- upvalues: u8 (ref), u64 (copy)
        local v66, v67 = u8.string(p65);

        if not v66 then
            return false, v67;
        end;

        if string.match(p65, u64) == nil then
            return false, string.format("%q failed to match pattern %q", p65, u64);
        end;

        return true;
    end;
end;

function u8.optional(u68) -- Line: 828
    -- upvalues: u8 (copy)
    assert(u8.callback(u68));

    return function(p69) -- Line: 830
        -- upvalues: u68 (copy)
        if p69 == nil then
            return true;
        end;

        local v70, v71 = u68(p69);

        if v70 then
            return true;
        end;

        return false, string.format("(optional) %s", v71 or "");
    end;
end;

function u8.tuple(...) -- Line: 851
    local u72 = { ... };

    return function(...) -- Line: 853
        -- upvalues: u72 (copy)
        local v73 = { ... };

        for i, v in ipairs(u72) do
            local v74, v75 = v(v73[i]);

            if v74 == false then
                return false, string.format("Bad tuple index #%s:\n\t%s", i, v75 or "");
            end;
        end;

        return true;
    end;
end;

function u8.keys(u76) -- Line: 873
    -- upvalues: u8 (copy)
    assert(u8.callback(u76));

    return function(p77) -- Line: 875
        -- upvalues: u8 (ref), u76 (copy)
        local v78, v79 = u8.table(p77);

        if v78 == false then
            return false, v79 or "";
        end;

        for i in pairs(p77) do
            local v80, v81 = u76(i);

            if v80 == false then
                return false, string.format("bad key %s:\n\t%s", tostring(i), v81 or "");
            end;
        end;

        return true;
    end;
end;

function u8.values(u82) -- Line: 899
    -- upvalues: u8 (copy)
    assert(u8.callback(u82));

    return function(p83) -- Line: 901
        -- upvalues: u8 (ref), u82 (copy)
        local v84, v85 = u8.table(p83);

        if v84 == false then
            return false, v85 or "";
        end;

        for i, v in pairs(p83) do
            local v86, v87 = u82(v);

            if v86 == false then
                return false, string.format("bad value for key %s:\n\t%s", tostring(i), v87 or "");
            end;
        end;

        return true;
    end;
end;

function u8.map(p88, p89) -- Line: 926
    -- upvalues: u8 (copy)
    assert(u8.callback(p88));
    assert(u8.callback(p89));
    local u90 = u8.keys(p88);
    local u91 = u8.values(p89);

    return function(p92) -- Line: 932
        -- upvalues: u90 (copy), u91 (copy)
        local v93, v94 = u90(p92);

        if not v93 then
            return false, v94 or "";
        end;

        local v95, v96 = u91(p92);

        if v95 then
            return true;
        end;

        return false, v96 or "";
    end;
end;

function u8.set(p97) -- Line: 954
    -- upvalues: u8 (copy)
    return u8.map(p97, u8.literal(true));
end;

local u98 = u8.keys(u8.integer);

function u8.array(p99) -- Line: 967
    -- upvalues: u8 (copy), u98 (copy)
    assert(u8.callback(p99));
    local u100 = u8.values(p99);

    return function(p101) -- Line: 971
        -- upvalues: u98 (ref), u100 (copy)
        local v102, v103 = u98(p101);

        if v102 == false then
            return false, string.format("[array] %s", v103 or "");
        end;

        local v104 = 0;

        for _ in ipairs(p101) do
            v104 = v104 + 1;
        end;

        for i in pairs(p101) do
            if i < 1 or v104 < i then
                return false, string.format("[array] key %s must be sequential", (tostring(i)));
            end;
        end;

        local v105, v106 = u100(p101);

        if v105 then
            return true;
        end;

        return false, string.format("[array] %s", v106 or "");
    end;
end;

function u8.strictArray(...) -- Line: 1007
    -- upvalues: u8 (copy), u98 (copy)
    local u107 = { ... };
    local v108 = u8.array(u8.callback);
    assert(v108(u107));

    return function(p109) -- Line: 1011
        -- upvalues: u98 (ref), u107 (copy)
        local v110, v111 = u98(p109);

        if v110 == false then
            return false, string.format("[strictArray] %s", v111 or "");
        end;

        if #u107 < #p109 then
            return false, string.format("[strictArray] Array size exceeds limit of %d", #u107);
        end;

        for i, v in pairs(u107) do
            local v112, v113 = v(p109[i]);

            if not v112 then
                return false, string.format("[strictArray] Array index #%d - %s", i, v113);
            end;
        end;

        return true;
    end;
end;

local u114 = u8.array(u8.callback);

function u8.unionList(u115) -- Line: 1043
    -- upvalues: u114 (copy)
    assert(u114(u115));

    return function(p116) -- Line: 1046
        -- upvalues: u115 (copy)
        for _, v in ipairs(u115) do
            if v(p116) then
                return true;
            end;
        end;

        return false, "bad type for union";
    end;
end;

function u8.union(...) -- Line: 1064
    -- upvalues: u8 (copy)
    return u8.unionList({ ... });
end;

u8.some = u8.union;

function u8.intersectionList(u117) -- Line: 1080
    -- upvalues: u114 (copy)
    assert(u114(u117));

    return function(p118) -- Line: 1083
        -- upvalues: u117 (copy)
        for _, v in ipairs(u117) do
            local v119, v120 = v(p118);

            if not v119 then
                return false, v120 or "";
            end;
        end;

        return true;
    end;
end;

function u8.intersection(...) -- Line: 1102
    -- upvalues: u8 (copy)
    return u8.intersectionList({ ... });
end;

u8.every = u8.intersection;
local u121 = u8.map(u8.any, u8.callback);

function u8.interface(u122) -- Line: 1121
    -- upvalues: u121 (copy), u8 (copy)
    assert(u121(u122));

    return function(p123) -- Line: 1123
        -- upvalues: u8 (ref), u122 (copy)
        local v124, v125 = u8.table(p123);

        if v124 == false then
            return false, v125 or "";
        end;

        for i, v in pairs(u122) do
            local v126, v127 = v(p123[i]);

            if v126 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(i), v127 or "");
            end;
        end;

        return true;
    end;
end;

function u8.strictInterface(u128) -- Line: 1147
    -- upvalues: u121 (copy), u8 (copy)
    assert(u121(u128));

    return function(p129) -- Line: 1149
        -- upvalues: u8 (ref), u128 (copy)
        local v130, v131 = u8.table(p129);

        if v130 == false then
            return false, v131 or "";
        end;

        for i, v in pairs(u128) do
            local v132, v133 = v(p129[i]);

            if v132 == false then
                return false, string.format("[interface] bad value for %s:\n\t%s", tostring(i), v133 or "");
            end;
        end;

        for i in pairs(p129) do
            if not u128[i] then
                return false, string.format("[interface] unexpected field %q", (tostring(i)));
            end;
        end;

        return true;
    end;
end;

function u8.instanceOf(u134, p135) -- Line: 1180
    -- upvalues: u8 (copy)
    assert(u8.string(u134));
    local u136;

    if p135 == nil then
        u136 = nil;
    else
        u136 = u8.children(p135);
    end;

    return function(p137) -- Line: 1188
        -- upvalues: u8 (ref), u134 (copy), u136 (ref)
        local v138, v139 = u8.Instance(p137);

        if not v138 then
            return false, v139 or "";
        end;

        if p137.ClassName ~= u134 then
            return false, string.format("%s expected, got %s", u134, p137.ClassName);
        end;

        if u136 then
            local v140, v141 = u136(p137);

            if not v140 then
                return false, v141;
            end;
        end;

        return true;
    end;
end;

u8.instance = u8.instanceOf;

function u8.instanceIsA(u142, p143) -- Line: 1218
    -- upvalues: u8 (copy)
    assert(u8.string(u142));
    local u144;

    if p143 == nil then
        u144 = nil;
    else
        u144 = u8.children(p143);
    end;

    return function(p145) -- Line: 1226
        -- upvalues: u8 (ref), u142 (copy), u144 (ref)
        local v146, v147 = u8.Instance(p145);

        if not v146 then
            return false, v147 or "";
        end;

        if not p145:IsA(u142) then
            return false, string.format("%s expected, got %s", u142, p145.ClassName);
        end;

        if u144 then
            local v148, v149 = u144(p145);

            if not v148 then
                return false, v149;
            end;
        end;

        return true;
    end;
end;

function u8.enum(u150) -- Line: 1254
    -- upvalues: u8 (copy)
    assert(u8.Enum(u150));

    return function(p151) -- Line: 1256
        -- upvalues: u8 (ref), u150 (copy)
        local v152, v153 = u8.EnumItem(p151);

        if not v152 then
            return false, v153;
        end;

        if p151.EnumType == u150 then
            return true;
        end;

        return false, string.format("enum of %s expected, got enum of %s", tostring(u150), (tostring(p151.EnumType)));
    end;
end;

local u154 = u8.tuple(u8.callback, u8.callback);

function u8.wrap(u155, u156) -- Line: 1281
    -- upvalues: u154 (copy)
    assert(u154(u155, u156));

    return function(...) -- Line: 1283
        -- upvalues: u156 (copy), u155 (copy)
        assert(u156(...));

        return u155(...);
    end;
end;

function u8.strict(u157) -- Line: 1297
    return function(...) -- Line: 1298
        -- upvalues: u157 (copy)
        assert(u157(...));
    end;
end;

local u158 = u8.map(u8.string, u8.callback);

function u8.children(u159) -- Line: 1317
    -- upvalues: u158 (copy), u8 (copy)
    assert(u158(u159));

    return function(p160) -- Line: 1320
        -- upvalues: u8 (ref), u159 (copy)
        local v161, v162 = u8.Instance(p160);

        if not v161 then
            return false, v162 or "";
        end;

        local v163 = {};

        for _, child in ipairs(p160:GetChildren()) do
            local Name = child.Name;

            if u159[Name] then
                if v163[Name] then
                    return false, string.format("Cannot process multiple children with the same name %q", Name);
                end;

                v163[Name] = child;
            end;
        end;

        for i, v in pairs(u159) do
            local v164, v165 = v(v163[i]);

            if not v164 then
                return false, string.format("[%s.%s] %s", p160:GetFullName(), i, v165 or "");
            end;
        end;

        return true;
    end;
end;

return u8;