 

 

local u1 = ipairs;
local u2 = Color3.new();
local function v6(u3, u4) --[[ Line: 5 ]]
    return function(p5) --[[ Line: 6 ]]
        -- upvalues: u3 (copy), u4 (copy)
        return u3:Lerp(u4, p5);
    end;
end;
local function u9(p7, p8) --[[ Line: 15 ]]
    return p7.Time < p8.Time;
end;
local function u42(p10, p11) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    local l__R__1 = p10.R;
    local l__G__2 = p10.G;
    local l__B__3 = p10.B;
    local v12 = l__R__1 < 0.0404482362771076 and l__R__1 / 12.92 or 0.87941546140213 * (l__R__1 + 0.055) ^ 2.4;
    local v13 = l__G__2 < 0.0404482362771076 and l__G__2 / 12.92 or 0.87941546140213 * (l__G__2 + 0.055) ^ 2.4;
    local v14 = l__B__3 < 0.0404482362771076 and l__B__3 / 12.92 or 0.87941546140213 * (l__B__3 + 0.055) ^ 2.4;
    local v15 = 0.2125862307855956 * v12 + 0.7151703037034108 * v13 + 0.0722004986433362 * v14;
    local v16 = 3.6590806972265884 * v12 + 11.442689580057424 * v13 + 4.114991502426484 * v14;
    local u17 = v15 > 0.008856451679035631 and 116 * v15 ^ 0.3333333333333333 - 16 or 903.296296296296 * v15;
    local u18, u19;
    if v16 > 1e-15 then
        u18 = u17 * (0.9257063972951867 * v12 - 0.8333736323779866 * v13 - 0.09209820666085898 * v14) / v16;
        u19 = u17 * (9 * v15 / v16 - 0.46832);
    else
        u18 = -0.19783 * u17;
        u19 = -0.46832 * u17;
    end;
    local l__R__4 = p11.R;
    local l__G__5 = p11.G;
    local l__B__6 = p11.B;
    local v20 = l__R__4 < 0.0404482362771076 and l__R__4 / 12.92 or 0.87941546140213 * (l__R__4 + 0.055) ^ 2.4;
    local v21 = l__G__5 < 0.0404482362771076 and l__G__5 / 12.92 or 0.87941546140213 * (l__G__5 + 0.055) ^ 2.4;
    local v22 = l__B__6 < 0.0404482362771076 and l__B__6 / 12.92 or 0.87941546140213 * (l__B__6 + 0.055) ^ 2.4;
    local v23 = 0.2125862307855956 * v20 + 0.7151703037034108 * v21 + 0.0722004986433362 * v22;
    local v24 = 3.6590806972265884 * v20 + 11.442689580057424 * v21 + 4.114991502426484 * v22;
    local u25 = v23 > 0.008856451679035631 and 116 * v23 ^ 0.3333333333333333 - 16 or 903.296296296296 * v23;
    local u26, u27;
    if v24 > 1e-15 then
        u26 = u25 * (0.9257063972951867 * v20 - 0.8333736323779866 * v21 - 0.09209820666085898 * v22) / v24;
        u27 = u25 * (9 * v23 / v24 - 0.46832);
    else
        u26 = -0.19783 * u25;
        u27 = -0.46832 * u25;
    end;
    return function(p28) --[[ Line: 54 ]]
        -- upvalues: u17 (ref), u25 (ref), u2 (ref), u18 (ref), u26 (ref), u19 (ref), u27 (ref)
        local v29 = (1 - p28) * u17 + p28 * u25;
        if v29 < 0.0197955 then
            return u2;
        end;
        local v30 = ((1 - p28) * u18 + p28 * u26) / v29 + 0.19783;
        local v31 = ((1 - p28) * u19 + p28 * u27) / v29 + 0.46832;
        local v32 = (v29 + 16) / 116;
        local v33 = v32 > 0.20689655172413793 and v32 * v32 * v32 or 0.12841854934601665 * v32 - 0.01771290335807126;
        local v34 = v33 * v30 / v31;
        local v35 = v33 * ((3 - 0.75 * v30) / v31 - 5);
        local v36 = 7.2914074 * v34 - 1.537208 * v33 - 0.4986286 * v35;
        local v37 = -2.180094 * v34 + 1.8757561 * v33 + 0.0415175 * v35;
        local v38 = 0.1253477 * v34 - 0.2040211 * v33 + 1.0569959 * v35;
        if v36 < 0 and (v36 < v37 and v36 < v38) then
            v37 = v37 - v36;
            v38 = v38 - v36;
            v36 = 0;
        elseif v37 < 0 and v37 < v38 then
            v36 = v36 - v37;
            v38 = v38 - v37;
            v37 = 0;
        elseif v38 < 0 then
            v36 = v36 - v38;
            v37 = v37 - v38;
            v38 = 0;
        end;
        local v39 = v36 < 0.0031306684425 and 12.92 * v36 or 1.055 * v36 ^ 0.4166666666666667 - 0.055;
        local v40 = v37 < 0.0031306684425 and 12.92 * v37 or 1.055 * v37 ^ 0.4166666666666667 - 0.055;
        local v41 = v38 < 0.0031306684425 and 12.92 * v38 or 1.055 * v38 ^ 0.4166666666666667 - 0.055;
        return Color3.new(v39 > 1 and 1 or (v39 < 0 and 0 or v39), v40 > 1 and 1 or (v40 < 0 and 0 or v40), v41 > 1 and 1 or (v41 < 0 and 0 or v41));
    end;
end;
return setmetatable({
    boolean = function(u43, u44) --[[ Name: boolean, Line 93 ]]
        return function(p45) --[[ Line: 94 ]]
            -- upvalues: u43 (copy), u44 (copy)
            if p45 < 0.5 then
                return u43;
            else
                return u44;
            end;
        end;
    end,
    number = function(u46, p47) --[[ Name: number, Line 103 ]]
        local u48 = p47 - u46;
        return function(p49) --[[ Line: 105 ]]
            -- upvalues: u46 (copy), u48 (copy)
            return u46 + u48 * p49;
        end;
    end,
    string = function(p50, u51) --[[ Name: string, Line 110 ]]
        local v52 = false;
        local v53, v54, v55, v56 = string.match(p50, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local v57, v58, v59, v60 = string.match(u51, "^([+-]?)(%d*):[+-]?(%d*):[+-]?(%d*)$");
        local u61, u62;
        if v53 and v57 then
            u61 = 3600 * (tonumber(v54) or 0) + 60 * (tonumber(v55) or 0) + (tonumber(v56) or 0);
            local v63 = 3600 * (tonumber(v58) or 0) + 60 * (tonumber(v59) or 0) + (tonumber(v60) or 0);
            if v53 == "-" then
                u61 = -u61;
            end;
            local v64 = 43200;
            if v57 == "-" or not v63 then
                v63 = -v63;
            end;
            u62 = (v64 + v63 - u61) % 86400 - 43200;
        else
            v52 = true;
            u61 = nil;
            u62 = nil;
        end;
        if not v52 then
            return function(p65) --[[ Line: 136 ]]
                -- upvalues: u61 (ref), u62 (ref)
                local v66 = (u61 + u62 * p65) % 86400;
                local v67 = math.abs(v66);
                return string.format(v66 < 0 and "-%.2u:%.2u:%.2u" or "%.2u:%.2u:%.2u", (v67 - v67 % 3600) / 3600, (v67 % 3600 - v67 % 60) / 60, v67 % 60);
            end;
        end;
        local u68 = #u51;
        return function(p69) --[[ Line: 131 ]]
            -- upvalues: u68 (copy), u51 (copy)
            local v70 = 1 + u68 * p69;
            return string.sub(u51, 1, v70 < u68 and v70 and v70 or u68);
        end;
    end,
    CFrame = v6,
    Color3 = u42,
    NumberRange = function(p71, p72) --[[ Name: NumberRange, Line 151 ]]
        local l__Min__7 = p71.Min;
        local l__Max__8 = p71.Max;
        local u73 = p72.Min - l__Min__7;
        local u74 = p72.Max - l__Max__8;
        return function(p75) --[[ Line: 155 ]]
            -- upvalues: l__Min__7 (copy), u73 (copy), l__Max__8 (copy), u74 (copy)
            return NumberRange.new(l__Min__7 + p75 * u73, l__Max__8 + p75 * u74);
        end;
    end,
    NumberSequenceKeypoint = function(p76, p77) --[[ Name: NumberSequenceKeypoint, Line 160 ]]
        local l__Time__9 = p76.Time;
        local l__Value__10 = p76.Value;
        local l__Envelope__11 = p76.Envelope;
        local u78 = p77.Time - l__Time__9;
        local u79 = p77.Value - l__Value__10;
        local u80 = p77.Envelope - l__Envelope__11;
        return function(p81) --[[ Line: 164 ]]
            -- upvalues: l__Time__9 (copy), u78 (copy), l__Value__10 (copy), u79 (copy), l__Envelope__11 (copy), u80 (copy)
            return NumberSequenceKeypoint.new(l__Time__9 + p81 * u78, l__Value__10 + p81 * u79, l__Envelope__11 + p81 * u80);
        end;
    end,
    PhysicalProperties = function(p82, p83) --[[ Name: PhysicalProperties, Line 169 ]]
        local l__Density__12 = p82.Density;
        local l__Elasticity__13 = p82.Elasticity;
        local l__ElasticityWeight__14 = p82.ElasticityWeight;
        local l__Friction__15 = p82.Friction;
        local l__FrictionWeight__16 = p82.FrictionWeight;
        local u84 = p83.Density - l__Density__12;
        local u85 = p83.Elasticity - l__Elasticity__13;
        local u86 = p83.ElasticityWeight - l__ElasticityWeight__14;
        local u87 = p83.Friction - l__Friction__15;
        local u88 = p83.FrictionWeight - l__FrictionWeight__16;
        return function(p89) --[[ Line: 180 ]]
            -- upvalues: l__Density__12 (copy), u84 (copy), l__Elasticity__13 (copy), u85 (copy), l__ElasticityWeight__14 (copy), u86 (copy), l__Friction__15 (copy), u87 (copy), l__FrictionWeight__16 (copy), u88 (copy)
            return PhysicalProperties.new(l__Density__12 + p89 * u84, l__Elasticity__13 + p89 * u85, l__ElasticityWeight__14 + p89 * u86, l__Friction__15 + p89 * u87, l__FrictionWeight__16 + p89 * u88);
        end;
    end,
    Ray = function(p90, p91) --[[ Name: Ray, Line 189 ]]
        local l__Origin__17 = p90.Origin;
        local l__Direction__18 = p90.Direction;
        local l__Origin__19 = p91.Origin;
        local l__Direction__20 = p91.Direction;
        local l__X__21 = l__Origin__17.X;
        local l__Y__22 = l__Origin__17.Y;
        local l__Z__23 = l__Origin__17.Z;
        local l__X__24 = l__Direction__18.X;
        local l__Y__25 = l__Direction__18.Y;
        local l__Z__26 = l__Direction__18.Z;
        local u92 = l__Origin__19.X - l__X__21;
        local u93 = l__Origin__19.Y - l__Y__22;
        local u94 = l__Origin__19.Z - l__Z__23;
        local u95 = l__Direction__20.X - l__X__24;
        local u96 = l__Direction__20.Y - l__Y__25;
        local u97 = l__Direction__20.Z - l__Z__26;
        return function(p98) --[[ Line: 194 ]]
            -- upvalues: l__X__21 (copy), u92 (copy), l__Y__22 (copy), u93 (copy), l__Z__23 (copy), u94 (copy), l__X__24 (copy), u95 (copy), l__Y__25 (copy), u96 (copy), l__Z__26 (copy), u97 (copy)
            return Ray.new(Vector3.new(l__X__21 + p98 * u92, l__Y__22 + p98 * u93, l__Z__23 + p98 * u94), (Vector3.new(l__X__24 + p98 * u95, l__Y__25 + p98 * u96, l__Z__26 + p98 * u97)));
        end;
    end,
    UDim = function(p99, p100) --[[ Name: UDim, Line 202 ]]
        local l__Scale__27 = p99.Scale;
        local l__Offset__28 = p99.Offset;
        local u101 = p100.Scale - l__Scale__27;
        local u102 = p100.Offset - l__Offset__28;
        return function(p103) --[[ Line: 206 ]]
            -- upvalues: l__Scale__27 (copy), u101 (copy), l__Offset__28 (copy), u102 (copy)
            return UDim.new(l__Scale__27 + p103 * u101, l__Offset__28 + p103 * u102);
        end;
    end,
    UDim2 = v6,
    Vector2 = v6,
    Vector3 = v6,
    Rect = function(u104, u105) --[[ Name: Rect, Line 214 ]]
        return function(p106) --[[ Line: 215 ]]
            -- upvalues: u104 (copy), u105 (copy)
            return Rect.new(u104.Min.X + p106 * (u105.Min.X - u104.Min.X), u104.Min.Y + p106 * (u105.Min.Y - u104.Min.Y), u104.Max.X + p106 * (u105.Max.X - u104.Max.X), u104.Max.Y + p106 * (u105.Max.Y - u104.Max.Y));
        end;
    end,
    Region3 = function(u107, u108) --[[ Name: Region3, Line 223 ]]
        return function(p109) --[[ Line: 224 ]]
            -- upvalues: u107 (copy), u108 (copy)
            local v110 = u107.CFrame * (-u107.Size / 2);
            local v111 = v110 + p109 * (u108.CFrame * (-u108.Size / 2) - v110);
            local v112 = u107.CFrame * (u107.Size / 2);
            local v113 = v112 + p109 * (u108.CFrame * (u108.Size / 2) - v112);
            local l__X__29 = v111.X;
            local l__X__30 = v113.X;
            local l__Y__31 = v111.Y;
            local l__Y__32 = v113.Y;
            local l__Z__33 = v111.Z;
            local l__Z__34 = v113.Z;
            local l__new__35 = Region3.new;
            local v114 = Vector3.new(l__X__29 < l__X__30 and l__X__29 and l__X__29 or l__X__30, l__Y__31 < l__Y__32 and l__Y__31 and l__Y__31 or l__Y__32, l__Z__33 < l__Z__34 and l__Z__33 and l__Z__33 or l__Z__34);
            if l__X__30 < l__X__29 then
                l__X__30 = l__X__29 or l__X__30;
            end;
            if l__Y__32 < l__Y__31 then
                l__Y__32 = l__Y__31 or l__Y__32;
            end;
            if l__Z__34 < l__Z__33 then
                l__Z__34 = l__Z__33 or l__Z__34;
            end;
            return l__new__35(v114, (Vector3.new(l__X__30, l__Y__32, l__Z__34)));
        end;
    end,
    NumberSequence = function(u115, u116) --[[ Name: NumberSequence, Line 242 ]]
        -- upvalues: u1 (copy), u9 (copy)
        return function(p117) --[[ Line: 243 ]]
            -- upvalues: u1 (ref), u115 (copy), u116 (copy), u9 (ref)
            local v118 = {};
            local v119 = 0;
            local v120 = {};
            for _, v121 in u1(u115.Keypoints) do
                local v122 = nil;
                local v123 = nil;
                for _, v124 in u1(u116.Keypoints) do
                    if v124.Time == v121.Time then
                        v122 = v124;
                        v123 = v122;
                        local v125 = v122;
                        v122 = v123;
                        v125 = v123;
                        break;
                    end;
                    if v124.Time < v121.Time and (v122 == nil or v124.Time > v122.Time) then
                        v122 = v124;
                    elseif v124.Time > v121.Time and (v123 == nil or v124.Time < v123.Time) then
                        v123 = v124;
                    end;
                end;
                local v126, v127;
                if v123 == v122 then
                    v126 = v123.Value;
                    v127 = v123.Envelope;
                else
                    local v128 = (v121.Time - v122.Time) / (v123.Time - v122.Time);
                    v126 = (v123.Value - v122.Value) * v128 + v122.Value;
                    v127 = (v123.Envelope - v122.Envelope) * v128 + v122.Envelope;
                end;
                v119 = v119 + 1;
                v120[v119] = NumberSequenceKeypoint.new(v121.Time, (v126 - v121.Value) * p117 + v121.Value, (v127 - v121.Envelope) * p117 + v121.Envelope);
                v118[v121.Time] = true;
            end;
            for _, v129 in u1(u116.Keypoints) do
                if not v118[v129.Time] then
                    local v130 = nil;
                    local v131 = nil;
                    for _, v132 in u1(u115.Keypoints) do
                        if v132.Time == v129.Time then
                            v130 = v132;
                            v131 = v130;
                            local v133 = v130;
                            v130 = v131;
                            v133 = v131;
                            break;
                        end;
                        if v132.Time < v129.Time and (v130 == nil or v132.Time > v130.Time) then
                            v130 = v132;
                        elseif v132.Time > v129.Time and (v131 == nil or v132.Time < v131.Time) then
                            v131 = v132;
                        end;
                    end;
                    local v134, v135;
                    if v131 == v130 then
                        v134 = v131.Value;
                        v135 = v131.Envelope;
                    else
                        local v136 = (v129.Time - v130.Time) / (v131.Time - v130.Time);
                        v134 = (v131.Value - v130.Value) * v136 + v130.Value;
                        v135 = (v131.Envelope - v130.Envelope) * v136 + v130.Envelope;
                    end;
                    v119 = v119 + 1;
                    v120[v119] = NumberSequenceKeypoint.new(v129.Time, (v129.Value - v134) * p117 + v134, (v129.Envelope - v135) * p117 + v135);
                end;
            end;
            table.sort(v120, u9);
            return NumberSequence.new(v120);
        end;
    end,
    ColorSequence = function(u137, u138) --[[ Name: ColorSequence, Line 310 ]]
        -- upvalues: u1 (copy), u42 (copy), u9 (copy)
        return function(p139) --[[ Line: 311 ]]
            -- upvalues: u1 (ref), u137 (copy), u138 (copy), u42 (ref), u9 (ref)
            local v140 = {};
            local v141 = 0;
            local v142 = {};
            for _, v143 in u1(u137.Keypoints) do
                local v144 = nil;
                local v145 = nil;
                for _, v146 in u1(u138.Keypoints) do
                    if v146.Time == v143.Time then
                        v144 = v146;
                        v145 = v144;
                        local v147 = v144;
                        v144 = v145;
                        v147 = v145;
                        break;
                    end;
                    if v146.Time < v143.Time and (v144 == nil or v146.Time > v144.Time) then
                        v144 = v146;
                    elseif v146.Time > v143.Time and (v145 == nil or v146.Time < v145.Time) then
                        v145 = v146;
                    end;
                end;
                local v148;
                if v145 == v144 then
                    v148 = v145.Value;
                else
                    v148 = u42(v144.Value, v145.Value)((v143.Time - v144.Time) / (v145.Time - v144.Time));
                end;
                v141 = v141 + 1;
                v142[v141] = ColorSequenceKeypoint.new(v143.Time, u42(v143.Value, v148)(p139));
                v140[v143.Time] = true;
            end;
            for _, v149 in u1(u138.Keypoints) do
                if not v140[v149.Time] then
                    local v150 = nil;
                    local v151 = nil;
                    for _, v152 in u1(u137.Keypoints) do
                        if v152.Time == v149.Time then
                            v150 = v152;
                            v151 = v150;
                            local v153 = v150;
                            v150 = v151;
                            v153 = v151;
                            break;
                        end;
                        if v152.Time < v149.Time and (v150 == nil or v152.Time > v150.Time) then
                            v150 = v152;
                        elseif v152.Time > v149.Time and (v151 == nil or v152.Time < v151.Time) then
                            v151 = v152;
                        end;
                    end;
                    local v154;
                    if v151 == v150 then
                        v154 = v151.Value;
                    else
                        v154 = u42(v150.Value, v151.Value)((v149.Time - v150.Time) / (v151.Time - v150.Time));
                    end;
                    v141 = v141 + 1;
                    v142[v141] = ColorSequenceKeypoint.new(v149.Time, u42(v149.Value, v154)(p139));
                end;
            end;
            table.sort(v142, u9);
            return ColorSequence.new(v142);
        end;
    end
}, {
    __index = function(_, p155) --[[ Name: __index, Line 374 ]]
        error("No lerp function is defined for type " .. tostring(p155) .. ".", 4);
    end,
    __newindex = function(_, p156) --[[ Name: __newindex, Line 378 ]]
        error("No lerp function is defined for type " .. tostring(p156) .. ".", 4);
    end
});