 

 

local u1 = {};
u1.__index = u1;
function u1.new(...) --[[ Line: 127 ]]
    -- upvalues: u1 (copy)
    local u2 = { ... };
    assert(#u2 >= 3, "Must have at least 3 points");
    local v3 = #u2 == 3;
    local v4 = #u2 == 4;
    local v5 = {};
    local l__new__1 = Vector3.new;
    local l__lerp__2 = l__new__1().lerp;
    local u6 = nil;
    local v7 = {};
    local function v13(p8) --[[ Line: 152 ]]
        -- upvalues: l__new__1 (copy), l__lerp__2 (copy)
        return {
            p8.X,
            p8.Y,
            p8.Z,
            ToVector3 = function(p9) --[[ Name: ToVector3, Line 155 ]]
                -- upvalues: l__new__1 (ref)
                return l__new__1(p9[1], p9[2], p9[3]);
            end,
            lerp = function(p10, p11, p12) --[[ Name: lerp, Line 158 ]]
                -- upvalues: l__lerp__2 (ref)
                return l__lerp__2(p10:ToVector3(), p11:ToVector3(), p12);
            end
        };
    end;
    local u14, u15, u16;
    if v3 or v4 then
        u14 = v7;
        u15 = 0;
        u16 = nil;
    else
        for v17 = 1, #u2 - 1 do
            local v18 = v13(u2[v17]);
            local v19 = { v18, v13(u2[v17 + 1]), (v13(v18)) };
            v7[#v7 + 1] = v19;
        end;
        u14 = v7;
        for v20 = #v7, 2, -1 do
            local v21 = {};
            for v22 = 1, v20 - 1 do
                local v23 = v7[v22];
                local v24 = { v23[3], v7[v22 + 1][3], (v13(v23[3])) };
                v21[v22] = v24;
                u14[#u14 + 1] = v24;
            end;
            v7 = v21;
        end;
        u16 = v7[1];
        u15 = #u14;
    end;
    if v3 then
        local u25 = u2[1];
        local u26 = u2[2];
        local u27 = u2[3];
        function v5.Get(_, p28, p29) --[[ Line: 203 ]]
            -- upvalues: u25 (copy), u26 (copy), u27 (copy)
            if p29 then
                p28 = p28 < 0 and 0 or (p28 > 1 and 1 or p28);
            end;
            return (1 - p28) * (1 - p28) * u25 + 2 * (1 - p28) * p28 * u26 + p28 * p28 * u27;
        end;
    elseif v4 then
        local u30 = u2[1];
        local u31 = u2[2];
        local u32 = u2[3];
        local u33 = u2[4];
        function v5.Get(_, p34, p35) --[[ Line: 215 ]]
            -- upvalues: u30 (copy), u31 (copy), u32 (copy), u33 (copy)
            if p35 then
                p34 = p34 < 0 and 0 or (p34 > 1 and 1 or p34);
            end;
            return (1 - p34) * (1 - p34) * (1 - p34) * u30 + 3 * (1 - p34) * (1 - p34) * p34 * u31 + 3 * (1 - p34) * p34 * p34 * u32 + p34 * p34 * p34 * u33;
        end;
    else
        function v5.Get(_, p36, p37) --[[ Line: 224 ]]
            -- upvalues: u15 (ref), u14 (copy), u16 (ref)
            if p37 then
                p36 = p36 < 0 and 0 or (p36 > 1 and 1 or p36);
            end;
            for v38 = 1, u15 do
                local v39 = u14[v38];
                local v40 = v39[1]:lerp(v39[2], p36);
                local v41 = v39[3];
                local l__X__3 = v40.X;
                local l__Y__4 = v40.Y;
                local l__Z__5 = v40.Z;
                v41[1] = l__X__3;
                v41[2] = l__Y__4;
                v41[3] = l__Z__5;
            end;
            return u16[3]:ToVector3();
        end;
    end;
    function v5.GetLength(p42, p43) --[[ Line: 242 ]]
        -- upvalues: u6 (ref)
        if not u6 then
            local v44 = p42:GetPath(p43 or 0.1);
            local v45 = 0;
            for v46 = 2, #v44 do
                v45 = v45 + (v44[v46 - 1] - v44[v46]).Magnitude;
            end;
            u6 = v45;
        end;
        return u6;
    end;
    function v5.GetPath(p47, p48) --[[ Line: 258 ]]
        local v49 = type(p48) == "number";
        assert(v49, "Must provide a step increment");
        local v50;
        if p48 > 0 then
            v50 = p48 < 1;
        else
            v50 = false;
        end;
        assert(v50, "Step out of domain; should be between 0 and 1 (exclusive)");
        local v51 = {};
        local v52 = 0;
        for v53 = 0, 1, p48 do
            v51[#v51 + 1] = p47:Get(v53);
            v52 = v53;
        end;
        if v52 < 1 then
            v51[#v51 + (1 - v52 < p48 * 0.5 and 0 or 1)] = p47:Get(1);
        end;
        return v51;
    end;
    function v5.GetPathByNumberSegments(p54, p55) --[[ Line: 277 ]]
        local v56 = type(p55) == "number";
        assert(v56, "Must provide number of segments");
        assert(p55 > 0, "Number of segments must be greater than 0");
        return p54:GetPath(1 / p55);
    end;
    function v5.GetPathBySegmentLength(p57, p58) --[[ Line: 284 ]]
        local v59 = type(p58) == "number";
        assert(v59, "Must provide a segment length");
        assert(p58 > 0, "Segment length must be greater than 0");
        local v60 = p57:GetLength() / p58 + 0.5;
        return p57:GetPathByNumberSegments((math.floor(v60)));
    end;
    function v5.GetPoints(_) --[[ Line: 294 ]]
        -- upvalues: u2 (copy)
        return u2;
    end;
    return setmetatable(v5, u1);
end;
return u1;