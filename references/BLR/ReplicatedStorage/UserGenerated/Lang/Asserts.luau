  

local function IsEqual(p1, p2) -- Line: 23
    return rawequal(p1, p2) and true or type(p1) == "number" and (type(p2) == "number" and (p1 ~= p1 and p2 ~= p2));
end;

local function IsASCII(p3: string) -- Line: 37
    for i = 1, string.len(p3) do
        local string_byte_ret = string.byte(p3, i);

        if string_byte_ret < 32 or string_byte_ret > 126 then
            return false;
        end;

        local _ = i;
    end;

    return true;
end;

local function IsFinite(p4: number) -- Line: 49
    local v5;

    if p4 == p4 and p4 ~= (1 / 0) then
        v5 = p4 ~= (-1 / 0);
    else
        v5 = false;
    end;

    return v5;
end;

local function IsInteger(p6: number) -- Line: 55
    local v7;

    if math.floor(p6) == p6 and p6 ~= (1 / 0) then
        v7 = p6 ~= (-1 / 0);
    else
        v7 = false;
    end;

    return v7;
end;

local function LuaString(p8: string) -- Line: 72
    local v9, _ = string.format("%q", p8):gsub("\n", "n");

    return v9;
end;

local function StringRep(p10) -- Line: 77
    if type(p10) == "string" then
        local v11, _ = string.format("%q", p10):gsub("\n", "n");

        return v11;
    end;

    if typeof(p10) == "Instance" then
        return p10:GetFullName();
    end;

    return tostring(p10);
end;

local function SafeKeyStringRep(p12) -- Line: 86
    if type(p12) == "number" or type(p12) == "boolean" then
        return `{p12}`;
    end;

    if type(p12) ~= "string" then
        if typeof(p12) == "Instance" then
            return p12:GetFullName();
        end;

        return `UnknownType({typeof(p12)})`;
    end;

    local utf8_len_ret = utf8.len(p12);

    if not utf8_len_ret then
        return "InvalidUTF8";
    end;

    local v13 = true;

    for i = 1, string.len(p12) do
        local string_byte_ret = string.byte(p12, i);

        if string_byte_ret < 32 or string_byte_ret > 126 then
            v13 = false;
            break;
        end;

        local _ = i;
    end;

    if not v13 then
        return "NonASCII";
    end;

    if utf8_len_ret <= 30 then
        local v14, _ = string.format("%q", p12):gsub("\n", "n");

        return v14;
    end;

    local string_sub_ret = string.sub(p12, 1, 30);
    local v15, _ = string.format("%q", string_sub_ret):gsub("\n", "n");

    return `{v15}...{utf8_len_ret - 30}`;
end;

local function StripErrorSource(p16) -- Line: 107
    local v17 = tostring(p16);
    local string_match_ret, v18 = string.match(v17, "^(.*:%d+): (.+)$");

    if string_match_ret then
        v17 = v18 or v17;
    end;

    return v17;
end;

local function ParseError(p19) -- Line: 118
    local v20 = tostring(p19);
    local string_match_ret, v21 = string.match(v20, "^(.*:%d+): (.+)$");

    if string_match_ret then
        v20 = v21 or v20;
    end;

    local string_match_ret2, v22 = string.match(v20, "^(.+) $(%[.+)$");

    if string_match_ret2 then
        if not v22 then
            string_match_ret2 = v20;
        end;
    else
        string_match_ret2 = v20;
    end;

    return string_match_ret2, v22;
end;

local function MakeError(p23: string, p24: string) -- Line: 130
    return `{p23} ${p24}`;
end;

local u45 = {
    IsCFrameFinite = function(p25) -- Line: 59, Name: IsCFrameFinite
        local Components, v26, v27, v28, v29, v30, v31, v32, v33, v34, v35, v36 = p25:GetComponents();
        local v37 = Components + v26 + v27 + v28 + v29 + v30 + v31 + v32 + v33 + v34 + v35 + v36;
        local v38;

        if v37 == v37 and v37 ~= (1 / 0) then
            v38 = v37 ~= (-1 / 0);
        else
            v38 = false;
        end;

        return v38;
    end,

    IsVector2Finite = function(p39) -- Line: 64, Name: IsVector2Finite
        local v40 = p39.X + p39.Y;
        local v41;

        if v40 == v40 and v40 ~= (1 / 0) then
            v41 = v40 ~= (-1 / 0);
        else
            v41 = false;
        end;

        return v41;
    end,

    IsVector3Finite = function(p42: vector) -- Line: 68, Name: IsVector3Finite
        local v43 = p42.X + p42.Y + p42.Z;
        local v44;

        if v43 == v43 and v43 ~= (1 / 0) then
            v44 = v43 ~= (-1 / 0);
        else
            v44 = false;
        end;

        return v44;
    end
};

function u45.Array(u46: function) -- Line: 140
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u46);

    return function(p47: table) -- Line: 142
        -- upvalues: SafeKeyStringRep (ref), u46 (copy)
        if type(p47) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p47) ~= nil then
            error("metatable", 2);
        end;

        local v48 = rawlen(p47);
        local v49 = 0;

        for i, v in pairs(p47) do
            v49 = v49 + 1;

            if i ~= v49 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v48 < v49 then
                error(`IndexOverflow ${`[{v49}]`}`, 2);
            end;

            local success, result = pcall(u46, v);

            if not success then
                local v50 = tostring(result);
                local string_match_ret, v51 = string.match(v50, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v50 = v51 or v50;
                end;

                local string_match_ret2, v52 = string.match(v50, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v52 then
                        string_match_ret2 = v50;
                    end;
                else
                    string_match_ret2 = v50;
                end;

                error(`{string_match_ret2} ${`[{v49}]{v52 or ""}`}`, 2);
            end;
        end;

        if v48 ~= v49 then
            error("LengthMismatch", 2);
        end;

        return p47;
    end;
end;

function u45.ArrayCoerce(u53: function) -- Line: 172
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u53);

    return function(p54: table) -- Line: 174
        -- upvalues: SafeKeyStringRep (ref), u53 (copy)
        if type(p54) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p54) ~= nil then
            error("metatable", 2);
        end;

        local v55 = rawlen(p54);
        local v56 = 0;
        local v57 = {};

        for i, v in pairs(p54) do
            v56 = v56 + 1;

            if i ~= v56 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v55 < v56 then
                error(`IndexOverflow ${`[{v56}]`}`, 2);
            end;

            local success, result = pcall(u53, v);

            if not success then
                local v58 = tostring(result);
                local string_match_ret, v59 = string.match(v58, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v58 = v59 or v58;
                end;

                local string_match_ret2, v60 = string.match(v58, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v60 then
                        string_match_ret2 = v58;
                    end;
                else
                    string_match_ret2 = v58;
                end;

                error(`{string_match_ret2} ${`[{v56}]{v60 or ""}`}`, 2);
            end;

            v57[i] = result;
        end;

        if v55 ~= v56 then
            error("LengthMismatch", 2);
        end;

        return v57;
    end;
end;

function u45.UniqueArray(u61: function) -- Line: 206
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u61);

    return function(p62: table) -- Line: 208
        -- upvalues: SafeKeyStringRep (ref), u61 (copy)
        if type(p62) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p62) ~= nil then
            error("metatable", 2);
        end;

        local v63 = rawlen(p62);
        local v64 = 0;
        local v65 = {};

        for i, v in pairs(p62) do
            v64 = v64 + 1;

            if i ~= v64 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v63 < v64 then
                error(`IndexOverflow ${`[{v64}]`}`, 2);
            end;

            if v65[v] then
                error(`UniqueArray ${`[{v64}]`}`, 2);
            end;

            v65[v] = true;

            if not v65[v] then
                error(`InvalidKey ${`[{v64}]`}`, 2);
            end;

            local success, result = pcall(u61, v);

            if not success then
                local v66 = tostring(result);
                local string_match_ret, v67 = string.match(v66, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v66 = v67 or v66;
                end;

                local string_match_ret2, v68 = string.match(v66, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v68 then
                        string_match_ret2 = v66;
                    end;
                else
                    string_match_ret2 = v66;
                end;

                error(`{string_match_ret2} ${`[{v64}]{v68 or ""}`}`, 2);
            end;
        end;

        if v63 ~= v64 then
            error("LengthMismatch", 2);
        end;

        return p62;
    end;
end;

function u45.UniqueArrayCoerce(u69: function) -- Line: 246
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u69);

    return function(p70: table) -- Line: 248
        -- upvalues: SafeKeyStringRep (ref), u69 (copy)
        if type(p70) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p70) ~= nil then
            error("metatable", 2);
        end;

        local v71 = rawlen(p70);
        local v72 = 0;
        local v73 = {};
        local v74 = {};

        for i, v in pairs(p70) do
            v72 = v72 + 1;

            if i ~= v72 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v71 < v72 then
                error(`IndexOverflow ${`[{v72}]`}`, 2);
            end;

            if v73[v] then
                error(`UniqueArray ${`[{v72}]`}`, 2);
            end;

            v73[v] = true;

            if not v73[v] then
                error(`InvalidKey ${`[{v72}]`}`, 2);
            end;

            local success, result = pcall(u69, v);

            if not success then
                local v75 = tostring(result);
                local string_match_ret, v76 = string.match(v75, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v75 = v76 or v75;
                end;

                local string_match_ret2, v77 = string.match(v75, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v77 then
                        string_match_ret2 = v75;
                    end;
                else
                    string_match_ret2 = v75;
                end;

                error(`{string_match_ret2} ${`[{v72}]{v77 or ""}`}`, 2);
            end;

            v74[i] = result;
        end;

        if v71 ~= v72 then
            error("LengthMismatch", 2);
        end;

        return v74;
    end;
end;

function u45.Map(u78: function, u79: function, p80: number?) -- Line: 289
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u78);
    u45.Function(u79);
    u45.Optional(u45.IntegerPositive)(p80);
    local u81 = p80 or (1 / 0);

    return function(p82) -- Line: 295
        -- upvalues: u81 (copy), u78 (copy), SafeKeyStringRep (ref), u79 (copy)
        if type(p82) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p82) ~= nil then
            error("metatable", 2);
        end;

        local v83 = 0;

        for i, v in pairs(p82) do
            v83 = v83 + 1;

            if u81 < v83 then
                error(`LengthLimit({u81})`, 2);
            end;

            local success, result = pcall(u78, i);

            if not success then
                local v84 = tostring(result);
                local string_match_ret, v85 = string.match(v84, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v84 = v85 or v84;
                end;

                local string_match_ret2, v86 = string.match(v84, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v86 then
                        string_match_ret2 = v84;
                    end;
                else
                    string_match_ret2 = v84;
                end;

                error(`{string_match_ret2} ${`<{SafeKeyStringRep(i)}>{v86 or ""}`}`, 2);
            end;

            local success2, result2 = pcall(u79, v);

            if not success2 then
                local v87 = tostring(result2);
                local string_match_ret, v88 = string.match(v87, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v87 = v88 or v87;
                end;

                local string_match_ret2, v89 = string.match(v87, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v89 then
                        string_match_ret2 = v87;
                    end;
                else
                    string_match_ret2 = v87;
                end;

                error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v89 or ""}`}`, 2);
            end;
        end;

        return p82;
    end;
end;

function u45.MapCoerce(u90: function, u91: function, p92: number?) -- Line: 324
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.Function(u90);
    u45.Function(u91);
    u45.Optional(u45.IntegerPositive)(p92);
    local u93 = p92 or (1 / 0);

    return function(p94) -- Line: 334
        -- upvalues: u93 (copy), u90 (copy), SafeKeyStringRep (ref), u91 (copy)
        if type(p94) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p94) ~= nil then
            error("metatable", 2);
        end;

        local v95 = 0;
        local v96 = {};

        for i, v in pairs(p94) do
            v95 = v95 + 1;

            if u93 < v95 then
                error(`LengthLimit({u93})`, 2);
            end;

            local success, result = pcall(u90, i);

            if not success then
                local v97 = tostring(result);
                local string_match_ret, v98 = string.match(v97, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v97 = v98 or v97;
                end;

                local string_match_ret2, v99 = string.match(v97, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v99 then
                        string_match_ret2 = v97;
                    end;
                else
                    string_match_ret2 = v97;
                end;

                error(`{string_match_ret2} ${`<{SafeKeyStringRep(i)}>{v99 or ""}`}`, 2);
            end;

            local success2, result2 = pcall(u91, v);

            if not success2 then
                local v100 = tostring(result2);
                local string_match_ret, v101 = string.match(v100, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v100 = v101 or v100;
                end;

                local string_match_ret2, v102 = string.match(v100, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v102 then
                        string_match_ret2 = v100;
                    end;
                else
                    string_match_ret2 = v100;
                end;

                error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v102 or ""}`}`, 2);
            end;

            v96[result] = result2;
        end;

        return v96;
    end;
end;

function u45.Table(p103: table) -- Line: 365
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.NoMetatable(p103);

    for _, v in pairs(p103) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p103);

    return function(p104) -- Line: 372
        -- upvalues: table_clone_ret (ref), SafeKeyStringRep (ref)
        if type(p104) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p104) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p104) then
            error("LengthMismatch", 2);
        end;

        for i, _ in pairs(p104) do
            if not table_clone_ret[i] then
                error(`UnknownKey ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p104[i]);

            if not success then
                local v105 = tostring(result);
                local string_match_ret, v106 = string.match(v105, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v105 = v106 or v105;
                end;

                local string_match_ret2, v107 = string.match(v105, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v107 then
                        string_match_ret2 = v105;
                    end;
                else
                    string_match_ret2 = v105;
                end;

                local l_error = error;
                local v108;

                if type(i) == "string" then
                    local v109;
                    v108, v109 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v108 = i:GetFullName();
                else
                    v108 = tostring(i);
                end;

                l_error(`{string_match_ret2} ${`[{v108}]{v107 or ""}`}`, 2);
            end;
        end;

        return p104;
    end;
end;

function u45.TablePermissive(p110: table) -- Line: 399
    -- upvalues: u45 (copy)
    u45.NoMetatable(p110);

    for _, v in pairs(p110) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p110);

    return function(p111) -- Line: 406
        -- upvalues: table_clone_ret (ref)
        if type(p111) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p111) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p111) then
            error("LengthMismatch", 2);
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p111[i]);

            if not success then
                local v112 = tostring(result);
                local string_match_ret, v113 = string.match(v112, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v112 = v113 or v112;
                end;

                local string_match_ret2, v114 = string.match(v112, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v114 then
                        string_match_ret2 = v112;
                    end;
                else
                    string_match_ret2 = v112;
                end;

                local l_error = error;
                local v115;

                if type(i) == "string" then
                    local v116;
                    v115, v116 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v115 = i:GetFullName();
                else
                    v115 = tostring(i);
                end;

                l_error(`{string_match_ret2} ${`[{v115}]{v114 or ""}`}`, 2);
            end;
        end;

        return p111;
    end;
end;

function u45.TableCoerce(p117: table) -- Line: 434
    -- upvalues: u45 (copy), SafeKeyStringRep (copy)
    u45.NoMetatable(p117);

    for _, v in pairs(p117) do
        u45.Function(v);
    end;

    local table_clone_ret = table.clone(p117);

    return function(p118) -- Line: 441
        -- upvalues: table_clone_ret (ref), SafeKeyStringRep (ref)
        if type(p118) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p118) ~= nil then
            error("metatable", 2);
        end;

        if rawlen(table_clone_ret) ~= rawlen(p118) then
            error("LengthMismatch", 2);
        end;

        local v119 = {};

        for i, _ in pairs(p118) do
            if not table_clone_ret[i] then
                error(`UnknownKey ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;
        end;

        for i, v in pairs(table_clone_ret) do
            local success, result = pcall(v, p118[i]);

            if not success then
                local v120 = tostring(result);
                local string_match_ret, v121 = string.match(v120, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v120 = v121 or v120;
                end;

                local string_match_ret2, v122 = string.match(v120, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v122 then
                        string_match_ret2 = v120;
                    end;
                else
                    string_match_ret2 = v120;
                end;

                local l_error = error;
                local v123;

                if type(i) == "string" then
                    local v124;
                    v123, v124 = string.format("%q", i):gsub("\n", "n");
                elseif typeof(i) == "Instance" then
                    v123 = i:GetFullName();
                else
                    v123 = tostring(i);
                end;

                l_error(`{string_match_ret2} ${`[{v123}]{v122 or ""}`}`, 2);
            end;

            v119[i] = result;
        end;

        return v119;
    end;
end;

function u45.IsASCII(p125: string) -- Line: 470
    local v126;

    if type(p125) == "string" then
        for i = 1, string.len(p125) do
            local string_byte_ret = string.byte(p125, i);

            if string_byte_ret < 32 or string_byte_ret > 126 then
                return false;
            end;

            local _ = i;
        end;

        v126 = true;
    else
        v126 = false;
    end;

    return v126;
end;

function u45.IsFinite(p127: number) -- Line: 473
    local v128;

    if type(p127) == "number" and (p127 == p127 and p127 ~= (1 / 0)) then
        v128 = p127 ~= (-1 / 0);
    else
        v128 = false;
    end;

    return v128;
end;

function u45.IsInteger(p129: number) -- Line: 476
    local v130;

    if type(p129) == "number" and (math.floor(p129) == p129 and p129 ~= (1 / 0)) then
        v130 = p129 ~= (-1 / 0);
    else
        v130 = false;
    end;

    return v130;
end;

function u45.IsCFrameFinite(p131) -- Line: 479
    local v132;

    if typeof(p131) == "CFrame" then
        local Components, v133, v134, v135, v136, v137, v138, v139, v140, v141, v142, v143 = p131:GetComponents();
        local v144 = Components + v133 + v134 + v135 + v136 + v137 + v138 + v139 + v140 + v141 + v142 + v143;

        if v144 == v144 and v144 ~= (1 / 0) then
            v132 = v144 ~= (-1 / 0);
        else
            v132 = false;
        end;
    else
        v132 = false;
    end;

    return v132;
end;

function u45.IsVector2Finite(p145) -- Line: 482
    local v146;

    if typeof(p145) == "Vector2" then
        local v147 = p145.X + p145.Y;

        if v147 == v147 and v147 ~= (1 / 0) then
            v146 = v147 ~= (-1 / 0);
        else
            v146 = false;
        end;
    else
        v146 = false;
    end;

    return v146;
end;

function u45.Optional(u148: function) -- Line: 486
    if type(u148) ~= "function" then
        error("function", 2);
    end;

    return function(p149) -- Line: 490
        -- upvalues: u148 (copy)
        if p149 == nil then
            return nil;
        end;

        local success, result = pcall(u148, p149);

        if not success then
            local l_error = error;
            local v150 = tostring(result);
            local string_match_ret, v151 = string.match(v150, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v150 = v151 or v150;
            end;

            l_error(v150, 2);
        end;

        return result;
    end;
end;

function u45.Default(u152: function, p153: any) -- Line: 502
    if type(u152) ~= "function" then
        error("function", 2);
    end;

    local u154 = u152(p153);

    return function(p155) -- Line: 507
        -- upvalues: u154 (copy), u152 (copy)
        if p155 == nil then
            return u154;
        end;

        local success, result = pcall(u152, p155);

        if not success then
            local l_error = error;
            local v156 = tostring(result);
            local string_match_ret, v157 = string.match(v156, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v156 = v157 or v156;
            end;

            l_error(v156, 2);
        end;

        return result;
    end;
end;

function u45.AnyOf(...) -- Line: 519
    local table_pack_ret = table.pack(...);

    for i = 1, table_pack_ret.n do
        local v158 = type(table_pack_ret[i]) == "function";
        assert(v158, "function");
        local _ = i;
    end;

    assert(table_pack_ret.n > 0);

    return function(p159) -- Line: 525
        -- upvalues: table_pack_ret (copy)
        for i = 1, table_pack_ret.n do
            local success, result = pcall(table_pack_ret[i], p159);

            if success then
                return result;
            end;

            local _ = i;
        end;

        error("AnyOf", 2);
    end;
end;

function u45.AllOf(...) -- Line: 536
    local table_pack_ret = table.pack(...);

    for i = 1, table_pack_ret.n do
        local v160 = type(table_pack_ret[i]) == "function";
        assert(v160, "function");
        local _ = i;
    end;

    assert(table_pack_ret.n > 0);

    return function(p161) -- Line: 542
        -- upvalues: table_pack_ret (copy)
        for i = 1, table_pack_ret.n do
            local success, result = pcall(table_pack_ret[i], p161);
            local v162;

            if success then
                v162 = i;
            else
                local l_error = error;
                local v163 = tostring(result);
                local string_match_ret, v164 = string.match(v163, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v163 = v164 or v163;
                end;

                l_error(v163, 2);
                v162 = i;
            end;
        end;

        return p161;
    end;
end;

function u45.AnyTable(p165) -- Line: 554
    if type(p165) ~= "table" then
        error("table", 2);
    end;

    return p165;
end;

function u45.Number(p166: number) -- Line: 560
    if type(p166) ~= "number" then
        error("number", 2);
    end;

    return p166;
end;

function u45.Boolean(p167: boolean) -- Line: 566
    if type(p167) ~= "boolean" then
        error("boolean", 2);
    end;

    return p167;
end;

function u45.Buffer(p168: buffer) -- Line: 572
    if type(p168) ~= "buffer" then
        error("buffer", 2);
    end;

    return p168;
end;

function u45.Function(p169: function) -- Line: 578
    if type(p169) ~= "function" then
        error("function", 2);
    end;

    return p169;
end;

function u45.Thread(p170: thread) -- Line: 584
    if type(p170) ~= "thread" then
        error("thread", 2);
    end;

    return p170;
end;

function u45.String(p171: string) -- Line: 591
    if type(p171) ~= "string" then
        error("string", 2);
    end;

    if not utf8.len(p171) then
        error("UTF8", 2);
    end;

    return p171;
end;

function u45.RawString(p172: string) -- Line: 601
    if type(p172) ~= "string" then
        error("string", 2);
    end;

    return p172;
end;

function u45.Any(p173) -- Line: 608
    return p173;
end;

function u45.Equals(u174) -- Line: 612
    return function(p175) -- Line: 613
        -- upvalues: u174 (copy)
        local v176 = u174;

        if not (rawequal(p175, v176) or type(p175) == "number" and (type(v176) == "number" and (p175 ~= p175 and v176 ~= v176))) then
            error("Equals", 2);
        end;

        return p175;
    end;
end;

function u45.Set(p177: table) -- Line: 621
    -- upvalues: u45 (copy)
    u45.Array(u45.Any);
    local u178 = {};

    for _, v in ipairs(p177) do
        if v ~= v then
            error("InvalidKeyNaN", 2);
        end;

        u178[v] = true;

        if not u178[v] then
            error("InvalidKey", 2);
        end;
    end;

    return function(p179) -- Line: 633
        -- upvalues: u178 (copy)
        if not u178[p179] then
            error("Set", 2);
        end;

        return p179;
    end;
end;

function u45.Pattern(u180: string) -- Line: 641
    -- upvalues: u45 (copy)
    u45.String(u180);

    return function(p181) -- Line: 643
        -- upvalues: u180 (copy)
        if type(p181) ~= "string" then
            error("string", 2);
        end;

        if not utf8.len(p181) then
            error("UTF8", 2);
        end;

        if not string.find(p181, u180) then
            error("Pattern", 2);
        end;

        return p181;
    end;
end;

function u45.NoMetatable(p182) -- Line: 657
    if type(p182) ~= "table" then
        error("table", 2);
    end;

    if getmetatable(p182) ~= nil then
        error("metatable", 2);
    end;

    return p182;
end;

function u45.Finite(p183: number) -- Line: 668
    if type(p183) ~= "number" then
        error("number", 2);
    end;

    local v184;

    if p183 == p183 and p183 ~= (1 / 0) then
        v184 = p183 ~= (-1 / 0);
    else
        v184 = false;
    end;

    if not v184 then
        error("Finite", 2);
    end;

    return p183;
end;

function u45.FinitePositive(p185: number) -- Line: 679
    if type(p185) ~= "number" then
        error("number", 2);
    end;

    local v186;

    if p185 == p185 and p185 ~= (1 / 0) then
        v186 = p185 ~= (-1 / 0);
    else
        v186 = false;
    end;

    if not v186 then
        error("Finite", 2);
    end;

    if p185 <= 0 then
        error("Positive", 2);
    end;

    return p185;
end;

function u45.FiniteNonNegative(p187: number) -- Line: 693
    if type(p187) ~= "number" then
        error("number", 2);
    end;

    local v188;

    if p187 == p187 and p187 ~= (1 / 0) then
        v188 = p187 ~= (-1 / 0);
    else
        v188 = false;
    end;

    if not v188 then
        error("Finite", 2);
    end;

    if p187 < 0 then
        error("NonNegative", 2);
    end;

    return p187;
end;

function u45.Positive(p189: number) -- Line: 707
    if type(p189) ~= "number" then
        error("number", 2);
    end;

    if p189 <= 0 then
        error("Positive", 2);
    end;

    return p189;
end;

function u45.NonNegative(p190: number) -- Line: 718
    if type(p190) ~= "number" then
        error("number", 2);
    end;

    if p190 < 0 then
        error("NonNegative", 2);
    end;

    return p190;
end;

function u45.Real(p191: number) -- Line: 729
    if type(p191) ~= "number" then
        error("number", 2);
    end;

    if p191 ~= p191 then
        error("Real", 2);
    end;

    return p191;
end;

function u45.Range(u192: number, u193: number) -- Line: 740
    -- upvalues: u45 (copy)
    u45.Real(u192);
    u45.Real(u193);

    if u192 > u193 then
        error("a<=b", 2);
    end;

    return function(p194) -- Line: 746
        -- upvalues: u192 (copy), u193 (copy)
        if type(p194) ~= "number" then
            error("number", 2);
        end;

        if u192 > p194 or p194 > u193 then
            error(`Range({u192},{u193})`, 2);
        end;

        return p194;
    end;
end;

function u45.Integer(p195: number) -- Line: 758
    if type(p195) ~= "number" then
        error("number", 2);
    end;

    local v196;

    if math.floor(p195) == p195 and p195 ~= (1 / 0) then
        v196 = p195 ~= (-1 / 0);
    else
        v196 = false;
    end;

    if not v196 then
        error("Integer", 2);
    end;

    return p195;
end;

function u45.Unsigned32(p197: number) -- Line: 769
    if bit32.bor(p197, 0) ~= p197 then
        error("Unsigned32", 2);
    end;

    return p197;
end;

function u45.IntegerPositive(p198: number) -- Line: 778
    if type(p198) ~= "number" then
        error("number", 2);
    end;

    local v199;

    if math.floor(p198) == p198 and p198 ~= (1 / 0) then
        v199 = p198 ~= (-1 / 0);
    else
        v199 = false;
    end;

    if not v199 then
        error("Integer", 2);
    end;

    if p198 < 1 then
        error("Positive", 2);
    end;

    return p198;
end;

function u45.Index(p200: number) -- Line: 792
    if type(p200) ~= "number" then
        error("number", 2);
    end;

    local v201;

    if math.floor(p200) == p200 and p200 ~= (1 / 0) then
        v201 = p200 ~= (-1 / 0);
    else
        v201 = false;
    end;

    if not v201 then
        error("Integer", 2);
    end;

    if p200 < 1 then
        error("Positive", 2);
    end;

    return p200;
end;

function u45.IntegerNonNegative(p202: number) -- Line: 806
    if type(p202) ~= "number" then
        error("number", 2);
    end;

    local v203;

    if math.floor(p202) == p202 and p202 ~= (1 / 0) then
        v203 = p202 ~= (-1 / 0);
    else
        v203 = false;
    end;

    if not v203 then
        error("Integer", 2);
    end;

    if p202 < 0 then
        error("NonNegative", 2);
    end;

    return p202;
end;

function u45.IntegerRange(u204: number, u205: number) -- Line: 820
    -- upvalues: u45 (copy)
    u45.Integer(u204);
    u45.Integer(u205);

    if u204 > u205 then
        error("a<=b", 2);
    end;

    return function(p206) -- Line: 826
        -- upvalues: u204 (copy), u205 (copy)
        if type(p206) ~= "number" then
            error("number", 2);
        end;

        local v207;

        if math.floor(p206) == p206 and p206 ~= (1 / 0) then
            v207 = p206 ~= (-1 / 0);
        else
            v207 = false;
        end;

        if not v207 then
            error("Integer", 2);
        end;

        if u204 > p206 or p206 > u205 then
            error(`Range({u204},{u205})`, 2);
        end;

        return p206;
    end;
end;

function u45.UInt32() -- Line: 840
    return function(p208) -- Line: 841
        if type(p208) ~= "number" then
            error("number", 2);
        end;

        if bit32.bor(p208, 0) ~= p208 then
            error("UInt32", 2);
        end;

        return p208;
    end;
end;

function u45.StringRange(u209: number, u210: number) -- Line: 853
    -- upvalues: u45 (copy)
    u45.Integer(u209);
    u45.Integer(u210);

    if u209 > u210 then
        error("a<=b", 2);
    end;

    return function(p211) -- Line: 859
        -- upvalues: u209 (copy), u210 (copy)
        if type(p211) ~= "string" then
            error("string", 2);
        end;

        local utf8_len_ret = utf8.len(p211);

        if not utf8_len_ret then
            error("UTF8", 2);
        end;

        if u209 > utf8_len_ret or utf8_len_ret > u210 then
            error(`StringRange({u209},{u210})`, 2);
        end;

        return p211;
    end;
end;

function u45.ASCII(p212: string) -- Line: 874
    if type(p212) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p212) do
        local string_byte_ret = string.byte(p212, i);
        local v213;

        if string_byte_ret < 32 or string_byte_ret > 126 then
            error("ASCII", 2);
            v213 = i;
        else
            v213 = i;
        end;
    end;

    return p212;
end;

function u45.ASCIIRange(u214: number, u215: number) -- Line: 888
    -- upvalues: u45 (copy)
    u45.Integer(u214);
    u45.Integer(u215);

    if u214 > u215 then
        error("a<=b", 2);
    end;

    return function(p216) -- Line: 894
        -- upvalues: u214 (copy), u215 (copy)
        if type(p216) ~= "string" then
            error("string", 2);
        end;

        local string_len_ret = string.len(p216);

        if u214 > string_len_ret or string_len_ret > u215 then
            error(`ASCIIRange({u214},{u215})`, 2);
        end;

        for i = 1, string_len_ret do
            local string_byte_ret = string.byte(p216, i);
            local v217;

            if string_byte_ret < 32 or string_byte_ret > 126 then
                error("ASCII", 2);
                v217 = i;
            else
                v217 = i;
            end;
        end;

        return p216;
    end;
end;

function u45.CFrame(p218) -- Line: 912
    if typeof(p218) ~= "CFrame" then
        error("CFrame", 2);
    end;

    return p218;
end;

function u45.CFrameFinite(p219) -- Line: 918
    if typeof(p219) ~= "CFrame" then
        error("CFrame", 2);
    end;

    local Components, v220, v221, v222, v223, v224, v225, v226, v227, v228, v229, v230 = p219:GetComponents();
    local v231 = Components + v220 + v221 + v222 + v223 + v224 + v225 + v226 + v227 + v228 + v229 + v230;
    local v232;

    if v231 == v231 and v231 ~= (1 / 0) then
        v232 = v231 ~= (-1 / 0);
    else
        v232 = false;
    end;

    if not v232 then
        error("CFrameFinite", 2);
    end;

    return p219;
end;

function u45.Vector2(p233) -- Line: 927
    if typeof(p233) ~= "Vector2" then
        error("Vector2", 2);
    end;

    return p233;
end;

function u45.Vector2Finite(p234) -- Line: 933
    if typeof(p234) ~= "Vector2" then
        error("Vector2", 2);
    end;

    local v235 = p234.X + p234.Y;
    local v236;

    if v235 == v235 and v235 ~= (1 / 0) then
        v236 = v235 ~= (-1 / 0);
    else
        v236 = false;
    end;

    if not v236 then
        error("Vector2Finite", 2);
    end;

    return p234;
end;

function u45.Vector2Unit(p237) -- Line: 942
    if typeof(p237) ~= "Vector2" then
        error("Vector2", 2);
    end;

    local v238 = p237.X + p237.Y;
    local v239;

    if v238 == v238 and v238 ~= (1 / 0) then
        v239 = v238 ~= (-1 / 0);
    else
        v239 = false;
    end;

    if not v239 then
        error("Vector2Finite", 2);
    end;

    if math.abs(p237.Magnitude - 1) > 1e-6 then
        error("Vector2Unit", 2);
    end;

    return p237;
end;

function u45.Vector3(p240: vector) -- Line: 954
    if typeof(p240) ~= "Vector3" then
        error("Vector3", 2);
    end;

    return p240;
end;

function u45.Vector3Finite(p241: vector) -- Line: 960
    if typeof(p241) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v242 = p241.X + p241.Y + p241.Z;
    local v243;

    if v242 == v242 and v242 ~= (1 / 0) then
        v243 = v242 ~= (-1 / 0);
    else
        v243 = false;
    end;

    if not v243 then
        error("Vector3Finite", 2);
    end;

    return p241;
end;

function u45.Vector3Unit(p244: vector) -- Line: 969
    if typeof(p244) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v245 = p244.X + p244.Y + p244.Z;
    local v246;

    if v245 == v245 and v245 ~= (1 / 0) then
        v246 = v245 ~= (-1 / 0);
    else
        v246 = false;
    end;

    if not v246 then
        error("Vector3Finite", 2);
    end;

    if math.abs(p244.Magnitude - 1) > 1e-6 then
        error("Vector3Unit", 2);
    end;

    return p244;
end;

function u45.Vector3Positive(p247: vector) -- Line: 981
    if typeof(p247) ~= "Vector3" then
        error("Vector3", 2);
    end;

    local v248 = p247.X + p247.Y + p247.Z;
    local v249;

    if v248 == v248 and v248 ~= (1 / 0) then
        v249 = v248 ~= (-1 / 0);
    else
        v249 = false;
    end;

    if not v249 then
        error("Vector3Finite", 2);
    end;

    if p247.X <= 0 or (p247.Y <= 0 or p247.Z <= 0) then
        error("Vector3Positive");
    end;

    return p247;
end;

function u45.Vector3int16(p250: userdata) -- Line: 993
    if typeof(p250) ~= "Vector3int16" then
        error("Vector3int16", 2);
    end;

    return p250;
end;

function u45.Vector2int16(p251: userdata) -- Line: 999
    if typeof(p251) ~= "Vector2int16" then
        error("Vector2int16", 2);
    end;

    return p251;
end;

function u45.Region3(p252: userdata) -- Line: 1005
    if typeof(p252) ~= "Region3" then
        error("Region3", 2);
    end;

    return p252;
end;

function u45.Region3int16(p253: userdata) -- Line: 1011
    if typeof(p253) ~= "Region3int16" then
        error("Region3int16", 2);
    end;

    return p253;
end;

function u45.UDim(p254) -- Line: 1017
    if typeof(p254) ~= "UDim" then
        error("UDim", 2);
    end;

    return p254;
end;

function u45.UDim2(p255) -- Line: 1023
    if typeof(p255) ~= "UDim2" then
        error("UDim2", 2);
    end;

    return p255;
end;

function u45.Rect(p256) -- Line: 1029
    if typeof(p256) ~= "Rect" then
        error("Rect", 2);
    end;

    return p256;
end;

function u45.PhysicalProperties(p257: userdata) -- Line: 1035
    if typeof(p257) ~= "PhysicalProperties" then
        error("PhysicalProperties", 2);
    end;

    return p257;
end;

function u45.Storable(p258: any, p259: table?) -- Line: 1044
    -- upvalues: SafeKeyStringRep (copy), u45 (copy)
    if type(p258) == "boolean" then
        return p258;
    end;

    if type(p258) == "number" then
        return p258;
    end;

    if type(p258) == "string" then
        if not utf8.len(p258) then
            error("UTF8", 2);

            return p258;
        end;
    else
        if type(p258) == "buffer" then
            return p258;
        end;

        if type(p258) == "table" then
            if type(p258) ~= "table" then
                error("table", 2);
            end;

            if getmetatable(p258) ~= nil then
                error("metatable", 2);
            end;

            local v260 = p259 or {};

            if v260[p258] then
                error("Loop", 2);
            end;

            v260[p258] = true;
            local v261 = rawlen(p258);

            if v261 <= 0 then
                for i, v in pairs(p258) do
                    if type(i) ~= "string" then
                        error(`KeyString ${`[{SafeKeyStringRep(i)}]`}`, 2);
                    end;

                    if not utf8.len(i) then
                        error(`KeyUTF8 ${`[{SafeKeyStringRep(i)}]`}`, 2);
                    end;

                    local success, result = pcall(u45.Storable, v, v260);

                    if not success then
                        local v262 = tostring(result);
                        local string_match_ret, v263 = string.match(v262, "^(.*:%d+): (.+)$");

                        if string_match_ret then
                            v262 = v263 or v262;
                        end;

                        local string_match_ret2, v264 = string.match(v262, "^(.+) $(%[.+)$");

                        if string_match_ret2 then
                            if not v264 then
                                string_match_ret2 = v262;
                            end;
                        else
                            string_match_ret2 = v262;
                        end;

                        error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v264 or ""}`}`, 2);
                    end;
                end;

                return p258;
            end;

            local v265 = 0;

            for i, v in pairs(p258) do
                v265 = v265 + 1;

                if i ~= v265 then
                    error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                if v261 < v265 then
                    error(`IndexOverflow ${`[{v265}]`}`, 2);
                end;

                local success, result = pcall(u45.Storable, v, v260);

                if not success then
                    local v266 = tostring(result);
                    local string_match_ret, v267 = string.match(v266, "^(.*:%d+): (.+)$");

                    if string_match_ret then
                        v266 = v267 or v266;
                    end;

                    local string_match_ret2, v268 = string.match(v266, "^(.+) $(%[.+)$");

                    if string_match_ret2 then
                        if not v268 then
                            string_match_ret2 = v266;
                        end;
                    else
                        string_match_ret2 = v266;
                    end;

                    error(`{string_match_ret2} ${`[{v265}]{v268 or ""}`}`, 2);
                end;
            end;

            if v261 ~= v265 then
                error("LengthMismatch", 2);

                return p258;
            end;
        else
            error("Storable", 2);
        end;
    end;

    return p258;
end;

local u269 = {
    boolean = true,
    number = true,
    string = true,
    buffer = true,
    Color3 = true,
    Instance = true,
    NumberRange = true,
    Rect = true,
    Region3 = true,
    Region3int16 = true,
    UDim = true,
    UDim2 = true,
    CFrame = true,
    Vector2 = true,
    Vector2int16 = true,
    Vector3 = true,
    Vector3int16 = true,
    EnumItem = true
};
table.freeze(u269);

function u45.Networkable(p270: any, p271: table?) -- Line: 1150
    -- upvalues: SafeKeyStringRep (copy), u45 (copy), u269 (copy)
    if type(p270) == "string" then
        if not utf8.len(p270) then
            error("UTF8", 2);

            return p270;
        end;
    elseif type(p270) == "table" then
        if type(p270) ~= "table" then
            error("table", 2);
        end;

        if getmetatable(p270) ~= nil then
            error("metatable", 2);
        end;

        local v272 = p271 or {};

        if v272[p270] then
            error("Loop", 2);
        end;

        v272[p270] = true;
        local v273 = rawlen(p270);

        if v273 <= 0 then
            for i, v in pairs(p270) do
                if type(i) ~= "string" then
                    error(`KeyString ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                if not utf8.len(i) then
                    error(`KeyUTF8 ${`[{SafeKeyStringRep(i)}]`}`, 2);
                end;

                local success, result = pcall(u45.Networkable, v, v272);

                if not success then
                    local v274 = tostring(result);
                    local string_match_ret, v275 = string.match(v274, "^(.*:%d+): (.+)$");

                    if string_match_ret then
                        v274 = v275 or v274;
                    end;

                    local string_match_ret2, v276 = string.match(v274, "^(.+) $(%[.+)$");

                    if string_match_ret2 then
                        if not v276 then
                            string_match_ret2 = v274;
                        end;
                    else
                        string_match_ret2 = v274;
                    end;

                    error(`{string_match_ret2} ${`[{SafeKeyStringRep(i)}]{v276 or ""}`}`, 2);
                end;
            end;

            return p270;
        end;

        local v277 = 0;

        for i, v in pairs(p270) do
            v277 = v277 + 1;

            if i ~= v277 then
                error(`IndexMismatch ${`[{SafeKeyStringRep(i)}]`}`, 2);
            end;

            if v273 < v277 then
                error(`IndexOverflow ${`[{v277}]`}`, 2);
            end;

            local success, result = pcall(u45.Networkable, v, v272);

            if not success then
                local v278 = tostring(result);
                local string_match_ret, v279 = string.match(v278, "^(.*:%d+): (.+)$");

                if string_match_ret then
                    v278 = v279 or v278;
                end;

                local string_match_ret2, v280 = string.match(v278, "^(.+) $(%[.+)$");

                if string_match_ret2 then
                    if not v280 then
                        string_match_ret2 = v278;
                    end;
                else
                    string_match_ret2 = v278;
                end;

                error(`{string_match_ret2} ${`[{v277}]{v280 or ""}`}`, 2);
            end;
        end;

        if v273 ~= v277 then
            error("LengthMismatch", 2);

            return p270;
        end;
    elseif not u269[typeof(p270)] then
        error("Networkable", 2);
    end;

    return p270;
end;

function u45.Enum(u281: userdata) -- Line: 1210
    if typeof(u281) ~= "Enum" then
        error("Enum", 2);
    end;

    return function(p282) -- Line: 1214
        -- upvalues: u281 (copy)
        if typeof(p282) ~= "EnumItem" then
            error("EnumItem", 2);
        end;

        if p282.EnumType ~= u281 then
            error(tostring(u281), 2);
        end;

        return p282;
    end;
end;

function u45.EnumValue(p283: userdata) -- Line: 1225
    if typeof(p283) ~= "Enum" then
        error("Enum", 2);
    end;

    local u284 = {};

    for _, v in ipairs(p283:GetEnumItems()) do
        u284[v.Value] = v;
    end;

    return function(p285) -- Line: 1233
        -- upvalues: u284 (copy)
        if typeof(p285) ~= "number" then
            error("number", 2);
        end;

        if not u284[p285] then
            error("EnumValue", 2);
        end;

        return p285;
    end;
end;

function u45.Player(p286: userdata) -- Line: 1244
    if typeof(p286) ~= "Instance" or not p286:IsA("Player") then
        error("Player", 2);
    end;

    return p286;
end;

function u45.BasePart(p287: userdata) -- Line: 1250
    if typeof(p287) ~= "Instance" or not p287:IsA("BasePart") then
        error("BasePart", 2);
    end;

    return p287;
end;

function u45.Part(p288: userdata) -- Line: 1256
    if typeof(p288) ~= "Instance" or not p288:IsA("Part") then
        error("Part", 2);
    end;

    return p288;
end;

function u45.MeshPart(p289: userdata) -- Line: 1262
    if typeof(p289) ~= "Instance" or not p289:IsA("MeshPart") then
        error("MeshPart", 2);
    end;

    return p289;
end;

function u45.Model(p290: userdata) -- Line: 1268
    if typeof(p290) ~= "Instance" or not p290:IsA("Model") then
        error("Model", 2);
    end;

    return p290;
end;

function u45.Animation(p291: userdata) -- Line: 1274
    if typeof(p291) ~= "Instance" or not p291:IsA("Animation") then
        error("Animation", 2);
    end;

    return p291;
end;

function u45.Humanoid(p292: userdata) -- Line: 1280
    if typeof(p292) ~= "Instance" or not p292:IsA("Humanoid") then
        error("Humanoid", 2);
    end;

    return p292;
end;

function u45.ParticleEmitter(p293: userdata) -- Line: 1286
    if typeof(p293) ~= "Instance" or not p293:IsA("ParticleEmitter") then
        error("ParticleEmitter", 2);
    end;

    return p293;
end;

function u45.Sound(p294: userdata) -- Line: 1292
    if typeof(p294) ~= "Instance" or not p294:IsA("Sound") then
        error("Sound", 2);
    end;

    return p294;
end;

function u45.Instance(p295: userdata) -- Line: 1298
    if typeof(p295) ~= "Instance" then
        error("Instance", 2);
    end;

    return p295;
end;

function u45.InstanceOf(u296: string) -- Line: 1306
    -- upvalues: u45 (copy)
    u45.String(u296);

    return function(p297) -- Line: 1308
        -- upvalues: u296 (copy)
        if typeof(p297) ~= "Instance" then
            error("Instance", 2);
        end;

        if not p297:IsA(u296) then
            error(u296, 2);
        end;

        return p297;
    end;
end;

function u45.InstanceClass(u298: string) -- Line: 1319
    -- upvalues: u45 (copy)
    u45.String(u298);

    return function(p299) -- Line: 1321
        -- upvalues: u298 (copy)
        if typeof(p299) ~= "Instance" then
            error("Instance", 2);
        end;

        if p299.ClassName ~= u298 then
            error(u298, 2);
        end;

        return p299;
    end;
end;

function u45.HexLower(p300: string) -- Line: 1332
    if type(p300) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p300) do
        local string_byte_ret = string.byte(p300, i);
        local v301;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 97 and string_byte_ret <= 102 then
            v301 = i;
        else
            error("HexLower", 2);
            v301 = i;
        end;
    end;

    return p300;
end;

function u45.HexUpper(p302: string) -- Line: 1346
    if type(p302) ~= "string" then
        error("string", 2);
    end;

    for i = 1, string.len(p302) do
        local string_byte_ret = string.byte(p302, i);
        local v303;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 65 and string_byte_ret <= 70 then
            v303 = i;
        else
            error("HexUpper", 2);
            v303 = i;
        end;
    end;

    return p302;
end;

function u45.UUIDStripped(p304: string) -- Line: 1360
    if type(p304) ~= "string" then
        error("string", 2);
    end;

    local string_len_ret = string.len(p304);

    if string_len_ret ~= 32 then
        error("Length32", 2);
    end;

    for i = 1, string_len_ret do
        local string_byte_ret = string.byte(p304, i);
        local v305;

        if string_byte_ret >= 48 and string_byte_ret <= 57 or string_byte_ret >= 97 and string_byte_ret <= 102 then
            v305 = i;
        else
            error("HexLower", 2);
            v305 = i;
        end;
    end;

    return p304;
end;

function u45.UUID(p306: string) -- Line: 1378
    if type(p306) ~= "string" then
        error("string", 2);
    end;

    if string.len(p306) ~= 36 then
        error("Length36", 2);
    end;

    if not p306:find("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
        error("UUID", 2);
    end;

    return p306;
end;

function u45.Base64(p307: string) -- Line: 1391
    if type(p307) ~= "string" then
        error("string", 2);
    end;

    if string.len(p307) % 4 ~= 0 then
        error("Base64Length", 2);
    end;

    if not string.match(p307, "^[A-Za-z0-9+/]*=?=?$") or string.match(p307, "[^=]=+[^=]") then
        error("Base64", 2);
    end;

    return p307;
end;

function u45.ToNumber(u308: function) -- Line: 1404
    return function(p309) -- Line: 1405
        -- upvalues: u308 (copy)
        local v310 = tonumber(p309);

        if not v310 then
            error("tonumber", 2);
        end;

        local success, result = pcall(u308, v310);

        if not success then
            local l_error = error;
            local v311 = tostring(result);
            local string_match_ret, v312 = string.match(v311, "^(.*:%d+): (.+)$");

            if string_match_ret then
                v311 = v312 or v311;
            end;

            l_error(v311, 2);
        end;

        return result;
    end;
end;

function u45.IsoDate(p313: string) -- Line: 1418
    if not DateTime.fromIsoDate(p313) then
        error("IsoDate", 2);
    end;

    return p313;
end;

return table.freeze(u45);