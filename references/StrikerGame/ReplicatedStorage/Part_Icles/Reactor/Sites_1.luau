 
 

local Fissure = require(script.Parent.Fissure);
local u1 = {
    MAX = 240,
    LAYERS = 2
};
local u2 = { "X", "Y", "Z" };
local u3 = { 1, -1 };
u1.RUN_ON = 1.9;

function u1.sequence(p4) -- Line: 122
    local u5 = p4 % 2147483647;

    return function() -- Line: 124
        -- upvalues: u5 (ref)
        u5 = (u5 * 48271 + 11) % 2147483647;

        return u5 / 2147483647;
    end;
end;

function u1.seedAt(p6) -- Line: 130
    local v7 = math.abs(p6.X * 31.7 + p6.Y * 57.3 + p6.Z * 17.1) * 1000;

    return math.floor(v7) % 2147483646 + 1;
end;

function u1.count(p8, p9) -- Line: 134
    -- upvalues: u1 (copy)
    local math_min_ret = math.min(p9, u1.MAX);
    local math_floor_ret = math.floor(math_min_ret);
    local math_floor_ret2 = math.floor(p8.X * p8.Y * p8.Z / 0.125);
    local math_min_ret2 = math.min(math_floor_ret, math_floor_ret2);

    return math.max(math_min_ret2, 0);
end;

local function anywhere(p10, p11) -- Line: 140
    local v12 = (p11() - 0.5) * p10.X;
    local v13 = (p11() - 0.5) * p10.Y;
    local v14 = (p11() - 0.5) * p10.Z;

    return Vector3.new(v12, v13, v14) * 0.95;
end;

function u1.even(p15, p16, p17) -- Line: 144
    local table_create_ret = table.create(p16);

    for i = 1, p16 do
        local v18 = (p17() - 0.5) * p15.X;
        local v19 = (p17() - 0.5) * p15.Y;
        local v20 = (p17() - 0.5) * p15.Z;
        table_create_ret[i] = Vector3.new(v18, v19, v20) * 0.95;
        local _ = i;
    end;

    return table_create_ret;
end;

function u1.hitIn(p21, p22) -- Line: 152
    local v23 = p21 / 2;
    local math_clamp_ret = math.clamp(p22.X, -v23.X, v23.X);
    local math_clamp_ret2 = math.clamp(p22.Y, -v23.Y, v23.Y);
    local math_clamp_ret3 = math.clamp(p22.Z, -v23.Z, v23.Z);

    return Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3);
end;

function u1.aroundHit(p24, p25, p26, p27) -- Line: 157
    -- upvalues: u1 (copy)
    local table_create_ret = table.create(p25);
    local v28 = math.max(p24.X, p24.Y, p24.Z) * 0.4;
    local math_floor_ret = math.floor(p25 * 0.7);

    for i = 1, p25 do
        local v29;

        if math_floor_ret < i then
            local v30 = (p27() - 0.5) * p24.X;
            local v31 = (p27() - 0.5) * p24.Y;
            local v32 = (p27() - 0.5) * p24.Z;
            table_create_ret[i] = Vector3.new(v30, v31, v32) * 0.95;
            v29 = i;
        else
            local v33 = p27() - 0.5;
            local v34 = p27() - 0.5;
            local v35 = p27() - 0.5;
            local Vector3_new_ret = Vector3.new(v33, v34, v35);
            local v36 = p26 + (Vector3_new_ret.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret).Unit * (v28 * p27() ^ 0.6);
            table_create_ret[i] = u1.hitIn(p24, v36) * 0.95;
            v29 = i;
        end;
    end;

    return table_create_ret;
end;

local function faceDistance(p37, p38, p39, p40) -- Line: 177
    -- upvalues: u2 (copy)
    local v41 = (p38[p39] - p40 * p37[p39] / 2) ^ 2;

    for _, v in ipairs(u2) do
        if v ~= p39 then
            local v42 = math.abs(p38[v]) - p37[v] / 2;
            local math_max_ret = math.max(v42, 0);
            v41 = v41 + math_max_ret * math_max_ret;
        end;
    end;

    return math.sqrt(v41);
end;

function u1.face(p43, p44) -- Line: 188
    -- upvalues: u2 (copy), u3 (copy), faceDistance (copy)
    local v45 = (1 / 0);
    local v46 = 0;
    local v47 = "Y";
    local v48 = 1;

    for _, v in ipairs(u2) do
        local v49 = p43.X * p43.Y * p43.Z / p43[v];
        local v50 = v;

        for _, v2 in ipairs(u3) do
            local v51 = faceDistance(p43, p44, v50, v2);
            local v52;

            if v51 <= v45 * 1.25 then
                v52 = v46 < v49;
            else
                v52 = false;
            end;

            if v51 < v45 * 0.75 or v52 then
                v48 = v2;
                v47 = v50;
                v46 = v49;
                v45 = v51;
            end;
        end;
    end;

    return v47, v48;
end;

local function nextIn(p53, p54) -- Line: 228
    local v55 = p53[p54 % #p53 + 1];

    if v55 <= p53[p54] then
        v55 = v55 + 6.283185307179586;
    end;

    return v55;
end;

local function rings(p56, p57, p58, u59, p60, u61) -- Line: 237
    local u62 = {};

    local function add(p63, p64) -- Line: 239
        -- upvalues: u61 (copy), u62 (copy)
        if u61(p63, p64) then
            table.insert(u62, { p63, p64 });
        end;
    end;

    local math_floor_ret = math.floor(p56 * 0.1);

    for i = 1, math_floor_ret do
        local v65 = p60() * 2 * 3.141592653589793;
        local v66 = p60();
        local v67 = u59 * 0.12 * math.sqrt(v66);
        local v68 = p57 + math.cos(v65) * v67;
        local v69 = p58 + math.sin(v65) * v67;
        local v70;

        if u61(v68, v69) then
            table.insert(u62, { v68, v69 });
            v70 = i;
        else
            v70 = i;
        end;
    end;

    local v71 = math.sqrt(p56) * 0.9;
    local math_round_ret = math.round(v71);
    local math_clamp_ret = math.clamp(math_round_ret, 6, 16);
    local v72 = p60() * 3;
    local u73 = math_clamp_ret + math.floor(v72);
    local v74 = p60() * 2 * 3.141592653589793;
    local v75 = {};

    for i = 1, u73 do
        v75[i] = v74 + (i - 1 + (p60() - 0.5) * 2 * 0.3) / u73 * 2 * 3.141592653589793;
        local _ = i;
    end;

    local function edges(p76, p77) -- Line: 261
        -- upvalues: u59 (copy)
        return u59 * (0.12 + 0.88 * ((p76 - 1) / p77) ^ 1.3), u59 * (0.12 + 0.88 * (p76 / p77) ^ 1.3);
    end;

    local v78 = 1;

    local function cost(p79) -- Line: 267
        -- upvalues: u73 (copy), u59 (copy)
        local v80 = u73;
        local v81 = 0;

        for i = 1, p79 do
            local v82 = u59 * (0.12 + 0.88 * ((i - 1) / p79) ^ 1.3);
            local v83 = u59 * (0.12 + 0.88 * (i / p79) ^ 1.3);

            if 3.141592653589793 * (v82 + v83) / v80 > 2.4 * (v83 - v82) then
                v80 = v80 * 2;
            end;

            v81 = v81 + v80;
            local _ = i;
        end;

        return v81 + v80;
    end;

    while v78 < 14 and cost(v78 + 1) <= p56 - math_floor_ret do
        v78 = v78 + 1;
    end;

    for i = 1, v78 + 1 do
        local math_min_ret = math.min(i, v78);
        local v84 = u59 * (0.12 + 0.88 * ((math_min_ret - 1) / v78) ^ 1.3);
        local v85 = u59 * (0.12 + 0.88 * (math_min_ret / v78) ^ 1.3);

        if v78 < i then
            v85 = u59 * 1.9;
            v84 = u59;
        end;

        local v86 = v85 - v84;
        local v87, v88;

        if i <= v78 and 3.141592653589793 * (v84 + v85) / #v75 > 2.4 * v86 then
            v87 = i;
            v88 = {};

            for i2, v in ipairs(v75) do
                table.insert(v88, v);
                local v89 = v75[i2 % #v75 + 1];

                if v89 <= v75[i2] then
                    v89 = v89 + 6.283185307179586;
                end;

                local v90 = v + (v89 - v) * (0.5 + (p60() - 0.5) * 0.3);
                table.insert(v88, v90);
            end;
        else
            v87 = i;
            v88 = v75;
        end;

        for i2, v in ipairs(v88) do
            local v91 = v88[i2 % #v88 + 1];

            if v91 <= v88[i2] then
                v91 = v91 + 6.283185307179586;
            end;

            local v92 = (v + v91) / 2;
            local v93 = (v84 + v85) / 2 + (p60() - 0.5) * 2 * 0.3 * v86;
            local v94 = p57 + math.cos(v92) * v93;
            local v95 = p58 + math.sin(v92) * v93;

            if u61(v94, v95) then
                table.insert(u62, { v94, v95 });
            end;
        end;

        v75 = v88;
    end;

    return u62;
end;

local function spread(p96, p97, p98, p99) -- Line: 313
    local math_sqrt_ret = math.sqrt(p96 * p97 / p98);
    local math_round_ret = math.round(math_sqrt_ret);
    local math_clamp_ret = math.clamp(math_round_ret, 1, p96);
    local math_round_ret2 = math.round(p96 / math_clamp_ret);
    local math_max_ret = math.max(math_round_ret2, 1);
    local v100 = {};

    for i = 1, math_max_ret do
        local v101 = i;

        for i2 = 1, math_clamp_ret do
            local v102 = { (2 * (i2 - 0.5 + (p99() - 0.5) * 2 * 0.25) / math_clamp_ret - 1) * p97 * 0.95, (2 * (v101 - 0.5 + (p99() - 0.5) * 2 * 0.25) / math_max_ret - 1) * p98 * 0.95 };
            table.insert(v100, v102);
            local _ = i2;
        end;
    end;

    return v100;
end;

local function layered(p103, p104, p105, p106, p107, p108) -- Line: 329
    local v109 = {};

    if p104 < 1 then
        for _, v in ipairs(p103) do
            table.insert(v109, p108(v[1], v[2], p104 / 2));
        end;

        return v109;
    end;

    local v110 = p105 * 0.95;
    local v111 = p106 * 0.95;

    for i, v in ipairs(p103) do
        local v112 = math.max(p105, p106) * 2;
        local v113 = v;
        local v114 = i;

        for i2, v2 in ipairs(p103) do
            if i2 ~= v114 then
                local math_sqrt_ret = math.sqrt((v2[1] - v113[1]) ^ 2 + (v2[2] - v113[2]) ^ 2);
                v112 = math.min(v112, math_sqrt_ret);
            end;
        end;

        local v115 = p107() * 2 * 3.141592653589793;
        local v116 = math.cos(v115) * v112 * 0.3;
        local v117 = math.sin(v115) * v112 * 0.3;
        local math_clamp_ret = math.clamp(v113[1] + v116, -v110, v110);
        local math_clamp_ret2 = math.clamp(v113[2] + v117, -v111, v111);
        table.insert(v109, p108(math_clamp_ret, math_clamp_ret2, p104 * 0.28));
        local math_clamp_ret3 = math.clamp(v113[1] - v116, -v110, v110);
        local math_clamp_ret4 = math.clamp(v113[2] - v117, -v111, v111);
        table.insert(v109, p108(math_clamp_ret3, math_clamp_ret4, p104 * 0.72));
    end;

    return v109;
end;

function u1.faceAxes(p118) -- Line: 207
    if p118 == "X" then
        return "Y", "Z";
    end;

    if p118 == "Y" then
        return "X", "Z";
    end;

    return "X", "Y";
end;

function u1.underFace(p119, p120, p121, p122, p123, p124) -- Line: 217
    local v125 = p121 * (p119[p120] / 2 - p124);

    if p120 == "X" then
        return Vector3.new(v125, p122, p123);
    end;

    if p120 == "Y" then
        return Vector3.new(p122, v125, p123);
    end;

    return Vector3.new(p122, p123, v125);
end;

function u1.alongFace(p126, p127, p128, p129) -- Line: 357
    if p126 == "X" then
        return Vector3.new(p129, p127, p128);
    end;

    if p126 == "Y" then
        return Vector3.new(p127, p129, p128);
    end;

    return Vector3.new(p127, p128, p129);
end;

function u1.probes(p130, p131, p132, p133, p134, p135) -- Line: 369
    local v136 = {};
    local v137 = p132 * (p130[p131] / 2 - 0.5);
    local v138;

    if p131 == "X" then
        v138 = Vector3.new(v137, p133, p134);
    elseif p131 == "Y" then
        v138 = Vector3.new(p133, v137, p134);
    else
        v138 = Vector3.new(p133, p134, v137);
    end;

    v136[1] = v138;

    for i = 1, 3 do
        local v139 = p135 * i * 0.3;
        local _ = i;

        for i2 = 1, 8 do
            local v140 = i2 / 8 * 2 * 3.141592653589793;
            local v141 = p133 + math.cos(v140) * v139;
            local v142 = p134 + math.sin(v140) * v139;
            local v143 = p132 * (p130[p131] / 2 - 0.5);
            local v144;

            if p131 == "X" then
                v144 = Vector3.new(v143, v141, v142);
            elseif p131 == "Y" then
                v144 = Vector3.new(v141, v143, v142);
            else
                v144 = Vector3.new(v141, v142, v143);
            end;

            table.insert(v136, v144);
            local _ = i2;
        end;
    end;

    return v136;
end;

function u1.cracks(u145, p146, p147, p148, p149, p150) -- Line: 381
    -- upvalues: u1 (copy), Fissure (copy), rings (copy), spread (copy), layered (copy)
    local v151;

    if p150 then
        v151 = p150.face;
    else
        v151 = p150;
    end;

    local v152;

    if p150 then
        v152 = p150.fill;
    else
        v152 = p150;
    end;

    local v153;

    if p150 then
        v153 = p150.line;
    else
        v153 = p150;
    end;

    local u154, u155 = u1.face(u145, p147);

    if v151 then
        u154 = v151.axis;
        u155 = v151.side;
    end;

    local u156, u157;

    if u154 == "X" then
        u156 = "Y";
        u157 = "Z";
    elseif u154 == "Y" then
        u156 = "X";
        u157 = "Z";
    else
        u156 = "X";
        u157 = "Y";
    end;

    local u158 = u145[u156] / 2;
    local u159 = u145[u157] / 2;
    local v160 = p147[u156];
    local v161 = p147[u157];

    local function inside(p162, p163) -- Line: 392
        -- upvalues: u158 (copy), u159 (copy)
        local v164;

        if math.abs(p162) < u158 * 0.95 then
            v164 = math.abs(p163) < u159 * 0.95;
        else
            v164 = false;
        end;

        return v164;
    end;

    local v165, v166;

    if v153 then
        v165 = v153.reach;
        v166 = v153.path.length;
        local v167 = Fissure.at(v153.path, 0.5);
        v160 = v167[u156];
        v161 = v167[u157];
    else
        local v168 = (math.abs(v160) + u158) ^ 2 + (math.abs(v161) + u159) ^ 2;
        local v169 = math.sqrt(v168) / 1.2;
        v166 = math.min(p148, v169);
        v165 = v166;
    end;

    local v170 = u145[u154];
    local math_max_ret = math.max(v166 * 0.075, 0.5);
    local math_min_ret = math.min(math_max_ret, v170 * 0.45);

    if p150 and p150.crust then
        math_min_ret = p150.crust;
    end;

    local v171;

    if math_min_ret >= 0.5 then
        local v172 = math.min(math_min_ret, v170 - math_min_ret) / 2;
        local math_clamp_ret = math.clamp(v160, -u158 * 0.95, u158 * 0.95);
        local math_clamp_ret2 = math.clamp(v161, -u159 * 0.95, u159 * 0.95);
        v171 = {};
        local v173 = u155 * (u145[u154] / 2 - (math_min_ret - v172));
        local v174;

        if u154 == "X" then
            v174 = Vector3.new(v173, math_clamp_ret, math_clamp_ret2);
        elseif u154 == "Y" then
            v174 = Vector3.new(math_clamp_ret, v173, math_clamp_ret2);
        else
            v174 = Vector3.new(math_clamp_ret, math_clamp_ret2, v173);
        end;

        v171.inCrust = v174;
        local v175 = u155 * (u145[u154] / 2 - (math_min_ret + v172));
        local v176;

        if u154 == "X" then
            v176 = Vector3.new(v175, math_clamp_ret, math_clamp_ret2);
        elseif u154 == "Y" then
            v176 = Vector3.new(math_clamp_ret, v175, math_clamp_ret2);
        else
            v176 = Vector3.new(math_clamp_ret, math_clamp_ret2, v175);
        end;

        v171.inBase = v176;
    else
        math_min_ret = v170;
        v171 = nil;
    end;

    if math_min_ret >= 1 then
        p146 = math.min(p146, u1.MAX // u1.LAYERS);
    end;

    local v177 = p149() * 2147483645;
    local v178 = math.floor(v177) + 1;
    local v179 = {};

    if v153 then
        local v183 = Fissure.places(p146, v153.path, v165, 1.9, u1.sequence(v153.seed or v178), function(p180) -- Line: 436
            -- upvalues: u156 (copy), u157 (copy), u158 (copy), u159 (copy)
            local v181 = p180[u157];
            local v182;

            if math.abs(p180[u156]) < u158 * 0.95 then
                v182 = math.abs(v181) < u159 * 0.95;
            else
                v182 = false;
            end;

            return v182;
        end);

        for i, v in ipairs(v183) do
            v179[i] = { v[u156], v[u157] };
        end;

        p146 = 2;
    else
        v179 = rings(p146, v160, v161, v165, u1.sequence(v178), inside);
        local v184 = p146;
        local v185 = v184;
        local v186 = v184;
        v184 = v185;
        v186 = v185;

        for i = 1, 16 do
            if #v179 >= v184 * 0.95 then
                break;
            end;

            v185 = math.ceil(v185 * 1.12);
            local v187 = rings(v185, v160, v161, v165, u1.sequence(v178), inside);

            if v184 < #v187 then
                break;
            end;

            local _ = i;
            v179 = v187;
        end;
    end;

    if v152 and #v179 < 2 then
        v179 = spread(math.max(p146, 2), u158, u159, u1.sequence(v178));
    end;

    local v193 = layered(v179, math_min_ret, u158, u159, u1.sequence(v178 + 7), function(p188, p189, p190) -- Line: 463
        -- upvalues: u145 (copy), u154 (ref), u155 (ref)
        local v191 = u154;
        local v192 = u155 * (u145[v191] / 2 - p190);

        if v191 == "X" then
            return Vector3.new(v192, p188, p189);
        end;

        if v191 == "Y" then
            return Vector3.new(p188, v192, p189);
        end;

        return Vector3.new(p188, p189, v192);
    end);
    local v194 = {};
    local v195 = u154;
    local v196 = u155 * (u145[v195] / 2 - 0);
    local v197;

    if v195 == "X" then
        v197 = Vector3.new(v196, v160, v161);
    elseif v195 == "Y" then
        v197 = Vector3.new(v160, v196, v161);
    else
        v197 = Vector3.new(v160, v161, v196);
    end;

    v194.origin = v197;
    local v198 = u154;
    local v199 = u155 * ((Vector3.new(2, 2, 2))[v198] / 2 - 0);
    local v200;

    if v198 == "X" then
        v200 = Vector3.new(v199, 0, 0);
    elseif v198 == "Y" then
        v200 = Vector3.new(0, v199, 0);
    else
        v200 = Vector3.new(0, 0, v199);
    end;

    v194.normal = v200;
    v194.reach = v165;
    v194.crust = math_min_ret;

    if v153 then
        v194.path = v153.path;
    end;

    return v193, v194, v171;
end;

return u1;