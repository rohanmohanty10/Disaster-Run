  

 

local u1 = {};
local HttpService = game:GetService("HttpService");
local u2 = Random.new();

function u1.removeDuplicates(p3) -- Line: 27
    local v4 = table.create(#p3);
    local v5 = {};

    for _, v in ipairs(p3) do
        if not v5[v] then
            table.insert(v4, v);
            v5[v] = true;
        end;
    end;

    return v4;
end;

local u6 = {
    k = {
        __mode = "k"
    },
    v = {
        __mode = "v"
    },
    kv = {
        __mode = "kv"
    }
};

function u1.weakCache(p7) -- Line: 48
    -- upvalues: u6 (copy)
    return setmetatable({}, u6[p7]);
end;

local function Sync(p8, p9) -- Line: 122
    -- upvalues: Sync (copy)
    local v10 = type(p8) == "table";
    assert(v10, "First argument must be a table");
    local v11 = type(p9) == "table";
    assert(v11, "Second argument must be a table");
    local v12 = table.clone(p8);

    for i, v in pairs(v12) do
        local v13 = p9[i];

        if v13 == nil then
            v12[i] = nil;
        elseif type(v) == type(v13) then
            if type(v) == "table" then
                v12[i] = Sync(v, v13);
            end;
        elseif type(v13) == "table" then
            local function deepCopy(p14) -- Line: 73
                -- upvalues: deepCopy (copy)
                local v15 = typeof(p14) == "table";
                assert(v15, "Expected table for deepCopy!");
                local v16 = getmetatable(p14);
                local v17 = setmetatable({}, v16);

                for i2, v2 in p14 do
                    if typeof(v2) == "table" then
                        v17[i2] = deepCopy(v2);
                    else
                        v17[i2] = v2;
                    end;
                end;

                return v17;
            end;

            v12[i] = deepCopy(v13);
        else
            v12[i] = v13;
        end;
    end;

    for i, v in pairs(p9) do
        if v12[i] == nil then
            if type(v) == "table" then
                local function u22(p18) -- Line: 73
                    -- upvalues: u22 (copy)
                    local v19 = typeof(p18) == "table";
                    assert(v19, "Expected table for deepCopy!");
                    local v20 = getmetatable(p18);
                    local v21 = setmetatable({}, v20);

                    for i2, v2 in p18 do
                        if typeof(v2) == "table" then
                            v21[i2] = u22(v2);
                        else
                            v21[i2] = v2;
                        end;
                    end;

                    return v21;
                end;

                v12[i] = u22(v);
            else
                v12[i] = v;
            end;
        end;
    end;

    return v12;
end;

local function Reconcile(p23, p24) -- Line: 194
    -- upvalues: Reconcile (copy)
    local v25 = type(p23) == "table";
    assert(v25, "First argument must be a table");
    local v26 = type(p24) == "table";
    assert(v26, "Second argument must be a table");
    local v27 = table.clone(p23);

    for i, v in p24 do
        local v28 = p23[i];

        if v28 == nil then
            if type(v) == "table" then
                local function u33(p29) -- Line: 73
                    -- upvalues: u33 (copy)
                    local v30 = typeof(p29) == "table";
                    assert(v30, "Expected table for deepCopy!");
                    local v31 = getmetatable(p29);
                    local v32 = setmetatable({}, v31);

                    for i2, v2 in p29 do
                        if typeof(v2) == "table" then
                            v32[i2] = u33(v2);
                        else
                            v32[i2] = v2;
                        end;
                    end;

                    return v32;
                end;

                v27[i] = u33(v);
            else
                v27[i] = v;
            end;
        elseif type(v28) == "table" then
            if type(v) == "table" then
                v27[i] = Reconcile(v28, v);
            else
                local function u38(p34) -- Line: 73
                    -- upvalues: u38 (copy)
                    local v35 = typeof(p34) == "table";
                    assert(v35, "Expected table for deepCopy!");
                    local v36 = getmetatable(p34);
                    local v37 = setmetatable({}, v36);

                    for i2, v2 in p34 do
                        if typeof(v2) == "table" then
                            v37[i2] = u38(v2);
                        else
                            v37[i2] = v2;
                        end;
                    end;

                    return v37;
                end;

                v27[i] = u38(v28);
            end;
        end;
    end;

    return v27;
end;

local function Map(p39, p40) -- Line: 300
    local v41 = type(p39) == "table";
    assert(v41, "First argument must be a table");
    local v42 = type(p40) == "function";
    assert(v42, "Second argument must be a function");
    local v43 = table.create(#p39);

    for i, v in p39 do
        v43[i] = p40(v, i, p39);
    end;

    return v43;
end;

function u1.checkTableEquality(p44, p45) -- Line: 936
    if rawequal(p44, p45) then
        return true;
    end;

    for i, v in pairs(p44) do
        if p45[i] ~= v then
            return false;
        end;
    end;

    for i, v in pairs(p45) do
        if p44[i] ~= v then
            return false;
        end;
    end;

    return true;
end;

function u1.getValueFromKeyRecursive(p46, p47) -- Line: 956
    -- upvalues: u1 (copy)
    if rawget(p47, p46) then
        return rawget(p47, p46);
    end;

    for _, v in pairs(p47) do
        if typeof(v) == "table" then
            local v48 = u1.getValueFromKeyRecursive(p46, v);

            if v48 then
                return v48;
            end;
        end;
    end;

    return nil;
end;

function u1.getValueFromStringPatternRecursive(p49, p50) -- Line: 975
    -- upvalues: u1 (copy)
    local v51 = string.lower(p49);

    for i, v in pairs(p50) do
        local v52 = string.find(string.lower(i), v51);

        if v52 or typeof(v) ~= "table" then
            if v52 then
                return v;
            end;
        else
            local v53 = u1.getValueFromStringPatternRecursive(v51, v);

            if v53 then
                return v53;
            end;
        end;
    end;

    return nil;
end;

function u1.mergeArrays(p54, p55) -- Line: 994
    local v56 = #p55;
    local v57 = table.clone(p55);

    for i, v in ipairs(p54) do
        v57[v56 + i] = v;
    end;

    return v57;
end;

function u1.mergeDict(...) -- Line: 1005
    local v58 = {};

    for _, v in ipairs({ ... }) do
        local v59 = typeof(v) == "table";
        assert(v59, "invalid table given");

        for i, v2 in pairs(v) do
            if v58[i] == nil then
                v58[i] = v2;
            end;
        end;
    end;

    return v58;
end;

function u1.match(p60, p61) -- Line: 1022
    assert(p60, "list is invalid or nil");
    assert(p61, "partial is invalid or nil");
    local v62 = {};

    for _, v in pairs(p60) do
        if string.lower(v):sub(1, #p61) == string.lower(p61) then
            table.insert(v62, v);
        end;
    end;

    return v62;
end;

function u1.toArray(p63) -- Line: 1038
    assert(p63, "Dictionary is invalid or nil");
    local v64 = {};
    local v65 = {};

    for i, v in p63 do
        table.insert(v64, i);
        table.insert(v65, v);
    end;

    return v65, v64;
end;

local u66 = u1.weakCache("k");

function u1.toArrayCached(p67) -- Line: 1053
    -- upvalues: u66 (copy), u1 (copy)
    assert(p67, "Dictionary is invalid or nil");
    local v68 = u66[p67];

    if v68 then
        return table.clone(v68.Values), table.clone(v68.Keys);
    end;

    local v69, v70 = u1.toArray(p67);
    local v71 = {
        Values = v69,
        Keys = v70
    };
    u66[p67] = v71;

    return table.clone(v71.Values), table.clone(v71.Keys);
end;

function u1.toDict(p72) -- Line: 1070
    assert(p72, "list is invalid or nil");
    local v73 = {};

    for i, v in pairs(p72) do
        v73[v] = i;
    end;

    return v73;
end;

local u74 = u1.weakCache("k");

function u1.toDictCached(p75) -- Line: 1085
    -- upvalues: u74 (copy), u1 (copy)
    assert(p75, "list is invalid or nil");
    local v76 = u74[p75];

    if v76 then
        return table.clone(v76);
    end;

    local v77 = u1.toDict(p75);
    u74[p75] = v77;

    return table.clone(v77);
end;

function u1.getIndexes(p78) -- Line: 1100
    assert(p78, "listOrDict is invalid or nil");
    local v79 = {};

    for i, _ in pairs(p78) do
        table.insert(v79, i);
    end;

    return v79;
end;

function u1.getValues(p80) -- Line: 1111
    assert(p80, "listOrDict is invalid or nil");
    local v81 = {};

    for _, v in pairs(p80) do
        table.insert(v81, v);
    end;

    return v81;
end;

function u1.length(p82) -- Line: 1122
    local v83 = 0;

    for _, _ in p82 do
        v83 = v83 + 1;
    end;

    return v83;
end;

function u1.chunkArray(p84, p85) -- Line: 1131
    local v86 = {};

    for i = 1, #p84, p85 do
        local v87 = {};
        local v88 = math.min(i + p85 - 1, #p84);
        v87[1] = table.unpack(p84, i, v88);
        table.insert(v86, v87);
    end;

    return v86;
end;

function u1.traverse(p89, p90, p91, p92) -- Line: 1141
    -- upvalues: u1 (copy)
    local v93 = p92 or {};

    for i, v in pairs(p89) do
        local v94 = { unpack(v93) };
        table.insert(v94, i);

        if typeof(v) == "table" and p90(i, v, v94, p89) then
            u1.traverse(v, p90, p91, v94);
        else
            p91(i, v, v94, p89);
        end;
    end;
end;

function u1.simpleTraverse(p95, u96, u97) -- Line: 1165
    local u98 = {};

    local function recurse(p99, p100) -- Line: 1172
        -- upvalues: u98 (copy), u97 (copy), recurse (copy), u96 (copy)
        if u98[p99] then
            return;
        end;

        u98[p99] = true;

        for i, v in pairs(p99) do
            p100[#p100 + 1] = i;

            if typeof(v) == "table" then
                if not u97 or u97(i, v, p100, p99) then
                    recurse(v, p100);
                end;
            elseif not u97 or u97(i, v, p100, p99) then
                u96(i, v, p100, p99);
            end;

            p100[#p100] = nil;
        end;
    end;

    recurse(p95, {});
end;

function u1.containsDuplicates(p101, p102) -- Line: 1198
    if p102 == nil then
        local v103 = {};

        for _, v in pairs(p101) do
            if v103[v] then
                return true;
            end;

            v103[v] = true;
        end;

        return false;
    end;

    local v104 = 0;

    for _, v in pairs(p101) do
        if v == v then
            v104 = v104 + 1;

            if v104 >= 2 then
                return true;
            end;
        end;
    end;

    return false;
end;

local function createLookupSet(p105) -- Line: 1225
    local v106 = {};

    for _, v in p105 do
        v106[v] = true;
    end;

    return v106;
end;

function u1.containsAny(p107, p108) -- Line: 1236
    local v109 = {};

    for _, v in p107 do
        v109[v] = true;
    end;

    for _, v in p108 do
        if v109[v] then
            return true;
        end;
    end;

    return false;
end;

function u1.random(p110, p111) -- Line: 1250
    -- upvalues: u2 (copy)
    local v112 = type(p110) == "table";
    assert(v112, "First argument must be a table");

    if typeof(p111) ~= "Random" then
        p111 = u2;
    end;

    local v113 = #p110;

    if v113 > 0 then
        return p111:NextInteger(1, v113);
    end;

    local v114 = table.create(#p110);

    for i in p110 do
        table.insert(v114, i);
    end;

    if #v114 == 0 then
        return nil;
    end;

    return v114[p111:NextInteger(1, #v114)];
end;

local u115 = u1.weakCache("k");

function u1.sortCached(p116, p117) -- Line: 1276
    -- upvalues: u115 (copy), u1 (copy)
    local v118 = typeof(p116) == "table";
    assert(v118, "Expected a table");
    local v119 = typeof(p117) == "function";
    assert(v119, "Expected a comparator function");
    local v120 = u115[p116];

    if v120 then
        local v121 = v120[p117];

        if v121 then
            return v121;
        end;
    else
        v120 = u1.weakCache("k");
        u115[p116] = v120;
    end;

    local v122 = table.clone(p116);
    table.sort(v122, p117);
    v120[p117] = v122;

    return v122;
end;

function u1.copy(p123, p124) -- Line: 69
    if not p124 then
        return table.clone(p123);
    end;

    local function u129(p125) -- Line: 73
        -- upvalues: u129 (copy)
        local v126 = typeof(p125) == "table";
        assert(v126, "Expected table for deepCopy!");
        local v127 = getmetatable(p125);
        local v128 = setmetatable({}, v127);

        for i, v in p125 do
            if typeof(v) == "table" then
                v128[i] = u129(v);
            else
                v128[i] = v;
            end;
        end;

        return v128;
    end;

    return u129(p123);
end;

u1.sync = Sync;
u1.reconcile = Reconcile;

function u1.swapRemove(p130, p131) -- Line: 247
    local v132 = #p130;
    p130[p131] = p130[v132];
    p130[v132] = nil;
end;

function u1.swapRemoveFirstValue(p133, p134) -- Line: 272
    local v135 = table.find(p133, p134);

    if v135 then
        local v136 = #p133;
        p133[v135] = p133[v136];
        p133[v136] = nil;
    end;

    return v135;
end;

u1.map = Map;

function u1.filter(p137, p138) -- Line: 330
    local v139 = type(p137) == "table";
    assert(v139, "First argument must be a table");
    local v140 = type(p138) == "function";
    assert(v140, "Second argument must be a function");
    local v141 = table.create(#p137);

    if #p137 <= 0 then
        for i, v in p137 do
            if p138(v, i, p137) then
                v141[i] = v;
            end;
        end;

        return v141;
    end;

    local v142 = 0;

    for i, v in p137 do
        if p138(v, i, p137) then
            v142 = v142 + 1;
            v141[v142] = v;
        end;
    end;

    return v141;
end;

function u1.reduce(p143, p144, p145) -- Line: 373
    local v146 = type(p143) == "table";
    assert(v146, "First argument must be a table");
    local v147 = type(p144) == "function";
    assert(v147, "Second argument must be a function");

    if #p143 > 0 then
        local v148;

        if p145 == nil then
            p145 = p143[1];
            v148 = 2;
        else
            v148 = 1;
        end;

        for i = v148, #p143 do
            p145 = p144(p145, p143[i], i, p143);
        end;

        return p145;
    end;

    local v149;

    if p145 == nil then
        v149 = next(p143);
        p145 = v149;
    else
        v149 = nil;
    end;

    for i, v in next, p143, v149 do
        p145 = p144(p145, v, i, p143);
    end;

    return p145;
end;

function u1.assign(p150, ...) -- Line: 416
    local v151 = table.clone(p150);

    for _, v in { ... } do
        for i, v2 in v do
            v151[i] = v2;
        end;
    end;

    return v151;
end;

function u1.extend(p152, p153) -- Line: 445
    local v154 = table.clone(p152);

    for _, v in p153 do
        table.insert(v154, v);
    end;

    return v154;
end;

function u1.reverse(p155) -- Line: 470
    local v156 = #p155;
    local v157 = table.create(v156);

    for i = 1, v156 do
        v157[i] = p155[v156 - i + 1];
    end;

    return v157;
end;

function u1.shuffle(p158, p159) -- Line: 497
    -- upvalues: u2 (copy)
    local v160 = type(p158) == "table";
    assert(v160, "First argument must be a table");
    local v161 = table.clone(p158);

    if typeof(p159) ~= "Random" then
        p159 = u2;
    end;

    for i = #p158, 2, -1 do
        local v162 = p159:NextInteger(1, i);
        local v163 = v161[i];
        v161[i] = v161[v162];
        v161[v162] = v163;
    end;

    return v161;
end;

function u1.sample(p164, p165, p166) -- Line: 527
    -- upvalues: u2 (copy)
    local v167 = type(p164) == "table";
    assert(v167, "First argument must be a table");
    local v168 = type(p165) == "number";
    assert(v168, "Second argument must be a number");
    local v169 = #p164;

    if v169 == 0 then
        return {};
    end;

    local v170 = table.clone(p164);
    local v171 = table.create(p165);

    if typeof(p166) ~= "Random" then
        p166 = u2;
    end;

    local v172 = math.clamp(p165, 1, v169);

    for i = 1, v172 do
        local v173 = p166:NextInteger(i, v169);
        local v174 = v170[i];
        v170[i] = v170[v173];
        v170[v173] = v174;
    end;

    table.move(v170, 1, v172, 1, v171);

    return v171;
end;

function u1.flat(p175, p176) -- Line: 575
    local u177 = type(p176) ~= "number" and 1 or p176;
    local u178 = table.create(#p175);

    local function Scan(p179, p180) -- Line: 578
        -- upvalues: u177 (copy), Scan (copy), u178 (copy)
        for _, v in p179 do
            if type(v) == "table" and p180 < u177 then
                Scan(v, p180 + 1);
            else
                table.insert(u178, v);
            end;
        end;
    end;

    Scan(p175, 0);

    return u178;
end;

function u1.flatMap(p181, p182) -- Line: 612
    -- upvalues: Map (copy)
    local v183 = Map(p181, p182);
    local u184 = table.create(#v183);
    local u185 = 1;

    local function u188(p186, p187) -- Line: 578
        -- upvalues: u185 (copy), u188 (copy), u184 (copy)
        for _, v in p186 do
            if type(v) == "table" and p187 < u185 then
                u188(v, p187 + 1);
            else
                table.insert(u184, v);
            end;
        end;
    end;

    u188(v183, 0);

    return u184;
end;

function u1.keys(p189) -- Line: 638
    local v190 = table.create(#p189);

    for i in p189 do
        table.insert(v190, i);
    end;

    return v190;
end;

function u1.values(p191) -- Line: 668
    local v192 = table.create(#p191);

    for _, v in p191 do
        table.insert(v192, v);
    end;

    return v192;
end;

function u1.find(p193, p194) -- Line: 707
    for i, v in p193 do
        if p194(v, i, p193) then
            return v, i;
        end;
    end;

    return nil, nil;
end;

function u1.every(p195, p196) -- Line: 736
    for i, v in p195 do
        if not p196(v, i, p195) then
            return false;
        end;
    end;

    return true;
end;

function u1.some(p197, p198) -- Line: 765
    for i, v in p197 do
        if p198(v, i, p197) then
            return true;
        end;
    end;

    return false;
end;

function u1.truncate(p199, p200) -- Line: 791
    local v201 = #p199;
    local v202 = math.clamp(p200, 1, v201);

    if v202 == v201 then
        return table.clone(p199);
    end;

    return table.move(p199, 1, v202, 1, table.create(v202));
end;

function u1.zip(...) -- Line: 824
    local v203 = select("#", ...) > 0;
    assert(v203, "Must supply at least 1 table");

    local function ZipIteratorArray(p204, p205) -- Line: 826
        local v206 = p205 + 1;
        local v207 = {};

        for i, v in p204 do
            local v208 = v[v206];

            if v208 == nil then
                return nil, nil;
            end;

            v207[i] = v208;
        end;

        return v206, v207;
    end;

    local function ZipIteratorMap(p209, p210) -- Line: 839
        local v211 = {};

        for i, v in p209 do
            local v212 = next(v, p210);

            if v212 == nil then
                return nil, nil;
            end;

            v211[i] = v212;
        end;

        return p210, v211;
    end;

    local v213 = { ... };

    if #v213[1] > 0 then
        return ZipIteratorArray, v213, 0;
    end;

    return ZipIteratorMap, v213, nil;
end;

function u1.lock(p214) -- Line: 877
    local function Freeze(p215) -- Line: 878
        -- upvalues: Freeze (copy)
        for i, v in pairs(p215) do
            if type(v) == "table" then
                p215[i] = Freeze(v);
            end;
        end;

        return table.freeze(p215);
    end;

    return Freeze(p214);
end;

function u1.isEmpty(p216) -- Line: 907
    return next(p216) == nil;
end;

function u1.encodeJSON(p217) -- Line: 919
    -- upvalues: HttpService (copy)
    return HttpService:JSONEncode(p217);
end;

function u1.decodeJSON(p218) -- Line: 931
    -- upvalues: HttpService (copy)
    return HttpService:JSONDecode(p218);
end;

return u1;