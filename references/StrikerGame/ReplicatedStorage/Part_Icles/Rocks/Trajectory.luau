 

 

local v1 = {};

local function support(p2, p3, p4, p5) -- Line: 45
    local v6 = p2.XVector:Dot(p4);
    local v7 = math.abs(v6) * p3.X;
    local v8 = p2.YVector:Dot(p4);
    local v9 = v7 + math.abs(v8) * p3.Y;
    local v10 = p2.ZVector:Dot(p4);

    return (v9 + math.abs(v10) * p3.Z) * p5;
end;

local function spinCF(p11, p12, p13) -- Line: 51
    local Magnitude = p12.Magnitude;

    if Magnitude * p13 < 0.0001 then
        return p11;
    end;

    return CFrame.fromAxisAngle(p12 * (1 / Magnitude), Magnitude * p13) * p11;
end;

local function planeCrossTime(p14, p15, p16, p17, p18, p19, p20) -- Line: 63
    local v21 = 0.5 * p16:Dot(p17);
    local v22 = p15:Dot(p17);
    local v23 = p14:Dot(p17) - p18;

    if math.abs(v21) < 1e-6 then
        if math.abs(v22) < 1e-9 then
            return nil;
        end;

        if p20 and v22 > 0 then
            return nil;
        end;

        local v24 = -v23 / v22;

        if v24 >= 0 and v24 <= p19 then
            return v24;
        end;

        return nil;
    end;

    local v25 = v22 * v22 - 4 * v21 * v23;

    if v25 < 0 then
        return nil;
    end;

    local math_sqrt_ret = math.sqrt(v25);

    if p20 then
        local v26 = (-v22 - math_sqrt_ret) / (2 * v21);

        if v26 >= 0 and v26 <= p19 then
            return v26;
        end;

        return nil;
    end;

    local v27 = (-v22 - math_sqrt_ret) / (2 * v21);
    local v28 = (-v22 + math_sqrt_ret) / (2 * v21);

    if v28 >= v27 then
        local v29 = v27;
        v27 = v28;
        v28 = v29;
    end;

    if v28 >= 0 and v28 <= p19 then
        return v28;
    end;

    if v27 >= 0 and v27 <= p19 then
        return v27;
    end;

    return nil;
end;

local function restPose(p30, p31, p32) -- Line: 97
    local v33 = p30.XVector:Dot(p32);
    local v34 = p30.YVector:Dot(p32);
    local v35 = p30.ZVector:Dot(p32);
    local v36 = math.abs(v33) / math.max(p31.X, 0.05);
    local v37 = math.abs(v34) / math.max(p31.Y, 0.05);
    local v38 = math.abs(v35) / math.max(p31.Z, 0.05);
    local v39, v40;

    if v37 <= v36 and v38 <= v36 then
        v39 = p30.XVector * (v33 >= 0 and 1 or -1);
        v40 = p31.X;
    elseif v38 <= v37 then
        v39 = p30.YVector * (v34 >= 0 and 1 or -1);
        v40 = p31.Y;
    else
        v39 = p30.ZVector * (v35 >= 0 and 1 or -1);
        v40 = p31.Z;
    end;

    local v41 = v39:Dot(p32);
    local math_clamp_ret = math.clamp(v41, -1, 1);
    local v42 = v39:Cross(p32);

    if v42.Magnitude > 0.00001 and math_clamp_ret < 0.9999 then
        return CFrame.fromAxisAngle(v42.Unit, (math.acos(math_clamp_ret))) * p30, v40;
    end;

    return p30, v40;
end;

local function edgeOf(u43, u44, u45, u46) -- Line: 124
    local function carried(p47) -- Line: 125
        -- upvalues: u43 (copy), u44 (copy), u45 (copy), u46 (copy)
        local v48 = u43.p0:Lerp(u43.p1, p47);

        return u46(v48, u44 * -(v48:Dot(u44) - u45 + 0.5)) ~= nil;
    end;

    local v49 = u43.p0:Lerp(u43.p1, 1);

    if u46(v49, u44 * -(v49:Dot(u44) - u45 + 0.5)) ~= nil then
        return nil;
    end;

    local Magnitude = (u43.p1 - u43.p0).Magnitude;
    local v50 = 1;
    local v51 = 0;

    for i = 1, 8 do
        if (v50 - v51) * Magnitude < 0.1 then
            break;
        end;

        local v52 = (v51 + v50) / 2;
        local v53 = u43.p0:Lerp(u43.p1, v52);
        local v54;

        if u46(v53, u44 * -(v53:Dot(u44) - u45 + 0.5)) ~= nil then
            v51 = v52;
            v54 = i;
        else
            v50 = v52;
            v54 = i;
        end;
    end;

    return v50;
end;

local function overEdge(p55, p56, p57, p58) -- Line: 152
    local v59 = 1 - math.sqrt(1 - p56);
    local v60 = (p55.p1 - p55.p0) * ((1 - v59) * 2 / p55.dur);
    local v61 = p57:Cross(v60);
    local v62 = v61.Magnitude <= 0.0001 and Vector3.new(0, 0, 0) or v61.Unit * (v60.Magnitude / math.max(p58, 0.1));

    return p55.t0 + p55.dur * v59, p55.p0:Lerp(p55.p1, p56), v60, p55.rot0:Lerp(p55.rotF, p56), v62;
end;

local function seekGround(p63, p64, p65, p66, p67, p68, p69, p70, p71, p72) -- Line: 166
    -- upvalues: support (copy), planeCrossTime (copy)
    local v73 = p63 + p64 * p71 + p65 * (0.5 * p71 * p71);

    while p71 < p72 do
        local math_min_ret = math.min(p71 + 0.5, p72);
        local v74 = p63 + p64 * math_min_ret + p65 * (math_min_ret * 0.5 * math_min_ret);
        local v75 = v74 - v73;

        if v75.Magnitude > 0.0001 then
            local Unit = v75.Unit;
            local v76 = support(p66, p68, Unit, p69);
            local v77 = p70(v73, v75 + Unit * v76);

            if v77 then
                local math_clamp_ret = math.clamp((v77.Position - v73).Magnitude / (v75.Magnitude + v76), 0, 1);
                local v78 = p71 + (math_min_ret - p71) * math_clamp_ret;
                local Magnitude = p67.Magnitude;

                if Magnitude * v78 >= 0.0001 then
                    p66 = CFrame.fromAxisAngle(p67 * (1 / Magnitude), Magnitude * v78) * p66;
                end;

                local v79 = support(p66, p68, v77.Normal, p69);
                local v80 = v77.Position:Dot(v77.Normal) + v79;

                return v77, planeCrossTime(p63, p64, p65, v77.Normal, v80, p72, true) or v78;
            end;

            v73 = v74;
            p71 = math_min_ret;
        else
            v73 = v74;
            p71 = math_min_ret;
        end;
    end;

    return nil, nil;
end;

function v1.ballistic(p81, p82, p83, p84) -- Line: 193
    return {
        impactT = nil,
        hit = nil,
        restT = (1 / 0),
        segs = {
            {
                kind = 1,
                t0 = 0,
                p0 = p81,
                v0 = p82,
                rot0 = p83,
                w = p84
            }
        }
    };
end;

function v1.slide(p85, p86, p87, p88, p89, p90, p91) -- Line: 201
    return {
        kind = 4,
        t0 = 0,
        p0 = p85,
        v0 = p86,
        rot0 = p87,
        accel = p88,
        dur = p89,
        settle = p90,
        settleTime = p91
    };
end;

function v1.led(p92, p93) -- Line: 208
    local v94 = { p92 };

    for _, v in ipairs(p93.segs) do
        v.t0 = v.t0 + p92.dur;
        table.insert(v94, v);
    end;

    p93.segs = v94;

    if p93.impactT then
        p93.impactT = p93.impactT + p92.dur;
    end;

    p93.restT = p93.restT + p92.dur;
    p93.lead = p92;

    return p93;
end;

function v1.lying(p95, p96) -- Line: 225
    return {
        impactT = nil,
        hit = nil,
        restT = 0,
        segs = {
            {
                kind = 3,
                t0 = 0,
                cf = p95
            }
        },
        restNormal = p96
    };
end;

function v1.settled(p97, p98) -- Line: 230
    local v99 = p97.p0 + p97.v0 * p97.dur + p97.accel * (0.5 * p97.dur * p97.dur);

    if p97.settle then
        v99 = v99 + p97.settle;
    end;

    return {
        impactT = nil,
        hit = nil,
        segs = {
            p97,
            {
                kind = 3,
                t0 = p97.dur,
                cf = p97.rot0 + v99
            }
        },
        restT = p97.dur,
        restNormal = p98,
        lead = p97
    };
end;

function v1.build(p100, p101, p102, p103, p104, p105, p106, p107, p108, p109, p110) -- Line: 251
    -- upvalues: support (copy), planeCrossTime (copy), seekGround (copy), restPose (copy), edgeOf (copy), overEdge (copy)
    local v111;

    if p110 == nil then
        v111 = false;
    else
        v111 = p110.offWalls == true;
    end;

    local v112;

    if p110 == nil then
        v112 = false;
    else
        v112 = p110.offEdges == true;
    end;

    local v113;

    if p110 == nil then
        v113 = false;
    else
        v113 = p110.fromRest == true;
    end;

    local v114;

    if p110 == nil then
        v114 = nil;
    else
        v114 = p110.airTime or nil;
    end;

    local v115 = {};
    local Vector3_new_ret = Vector3.new(0, -p106, 0);
    local v116 = 0;
    local v117 = 0;
    local v118 = 0;
    local v119 = 0;
    local v120 = {
        impactT = nil,
        hit = nil,
        restT = (1 / 0),
        segs = v115
    };

    while true do
        if v116 > 3 then
            return v120;
        end;

        local v121 = v116 == 0 and 6 or 4;
        local v122 = math.max(p101.Y, 0) / math.max(p106, 1) * 2 + 1.5;
        local math_min_ret = math.min(v122, 6);
        local v123 = math_min_ret / v121;
        local v124 = p100;
        local v125 = nil;
        local v126 = nil;

        for i = 1, v121 do
            local v127 = i * v123;
            local v128 = p100 + p101 * v127 + Vector3_new_ret * (0.5 * v127 * v127);
            local v129 = v128 - v124;

            if v129.Magnitude > 0.0001 then
                local Unit = v129.Unit;
                local v130 = support(p102, p104, Unit, p105);
                local v131 = p109(v124, v129 + Unit * v130);

                if v131 then
                    local math_clamp_ret = math.clamp((v131.Position - v124).Magnitude / (v129.Magnitude + v130), 0, 1);
                    local v132 = (i - 1) * v123 + v123 * math_clamp_ret;
                    local Magnitude = p103.Magnitude;
                    local v133;

                    if Magnitude * v132 < 0.0001 then
                        v133 = p102;
                    else
                        v133 = CFrame.fromAxisAngle(p103 * (1 / Magnitude), Magnitude * v132) * p102;
                    end;

                    local v134 = support(v133, p104, v131.Normal, p105);
                    local v135 = v131.Position:Dot(v131.Normal) + v134;
                    v126 = planeCrossTime(p100, p101, Vector3_new_ret, v131.Normal, v135, math_min_ret, v113) or v132;
                    v125 = v131;
                    break;
                end;
            end;

            v124 = v128;
            local _ = i;
        end;

        if not (v125 or (not v114 or math_min_ret >= v114 - v117)) then
            v125, v126 = seekGround(p100, p101, Vector3_new_ret, p102, p103, p104, p105, p109, math_min_ret, v114 - v117);
        end;

        if not v125 then
            v115[#v115 + 1] = {
                kind = 1,
                t0 = v117,
                p0 = p100,
                v0 = p101,
                rot0 = p102,
                w = p103
            };

            return v120;
        end;

        local Normal = v125.Normal;
        local v136 = p101 + Vector3_new_ret * v126;
        local Magnitude = p103.Magnitude;
        local v137;

        if Magnitude * v126 < 0.0001 then
            v137 = p102;
        else
            v137 = CFrame.fromAxisAngle(p103 * (1 / Magnitude), Magnitude * v126) * p102;
        end;

        local v138 = support(v137, p104, Normal, p105);
        local v139 = p100 + p101 * v126 + Vector3_new_ret * (0.5 * v126 * v126);
        v115[#v115 + 1] = {
            kind = 1,
            t0 = v117,
            p0 = p100,
            v0 = p101,
            rot0 = p102,
            w = p103
        };
        v117 = v117 + v126;

        if not v120.impactT then
            v120.impactT = v117;
            v120.hit = v125;
        end;

        local v140 = v136:Dot(Normal);
        local v141 = v136 - Normal * v140;

        if v111 and (Normal.Y <= 0.3 and v118 < 4) then
            v118 = v118 + 1;
            p101 = v141 * (1 - p108) + Normal * math.max(-v140 * p107, 4);
            p102 = v137;
            p100 = v139;
        elseif -v140 * p107 > 6 and (Normal.Y > 0.3 and v116 < 3) then
            v116 = v116 + 1;
            p101 = v141 * (1 - p108) + Normal * (-v140 * p107);
            local v142 = Normal:Cross(v141);

            if v142.Magnitude > 0.0001 and v141.Magnitude > 0.5 then
                p103 = v142.Unit * (v141.Magnitude / math.max(v138, 0.1));
            end;

            p102 = v137;
            p100 = v139;
        else
            local Magnitude2 = v141.Magnitude;
            local math_max_ret = math.max(p108 * p106 * 0.5, 10);
            local math_min_ret2 = math.min(Magnitude2 / math_max_ret, 2);
            local v143 = Magnitude2 > 0.001 and v141.Unit or Vector3.new(1, 0, 0);
            local v144, v145 = restPose(v137, p104, Normal);
            local u146 = v125.Position:Dot(Normal);

            local function planeSeat(p147, p148) -- Line: 351
                -- upvalues: Normal (copy), u146 (copy)
                return p147 + Normal * (u146 + p148 - p147:Dot(Normal));
            end;

            local v149 = v139 + Normal * (u146 + v138 - v139:Dot(Normal));
            local v150 = v149 + v143 * (Magnitude2 * math_min_ret2 - math_max_ret * 0.5 * math_min_ret2 * math_min_ret2);
            local v151 = v150 + Normal * (u146 + v145 * p105 - v150:Dot(Normal));
            local v152 = {
                kind = 2,
                t0 = v117,
                dur = math.max(math_min_ret2, 0.15),
                p0 = v149,
                p1 = v151,
                rot0 = v137,
                rotF = v144
            };
            v115[#v115 + 1] = v152;
            local v153;

            if v112 then
                if v119 < 2 then
                    v153 = edgeOf(v152, Normal, u146, p109);
                else
                    v153 = false;
                end;
            else
                v153 = v112;
            end;

            if not v153 then
                local v154 = v117 + v152.dur;
                v115[#v115 + 1] = {
                    kind = 3,
                    t0 = v154,
                    cf = v144 + v151
                };
                v120.restT = v154;
                v120.restNormal = Normal;

                return v120;
            end;

            v119 = v119 + 1;
            v117, p100, p101, p102, p103 = overEdge(v152, v153, Normal, v138);
        end;
    end;
end;

function v1.evaluate(p155, p156, p157) -- Line: 374
    local segs = p155.segs;
    local v158 = segs[1];

    for i = 2, #segs do
        if segs[i].t0 > p156 then
            break;
        end;

        v158 = segs[i];
        local _ = i;
    end;

    if v158.kind ~= 1 then
        if v158.kind == 2 then
            local math_clamp_ret = math.clamp((p156 - v158.t0) / v158.dur, 0, 1);
            local v159 = 1 - (1 - math_clamp_ret) * (1 - math_clamp_ret);

            return v158.rot0:Lerp(v158.rotF, v159) + v158.p0:Lerp(v158.p1, v159);
        end;

        if v158.kind ~= 4 then
            return v158.cf;
        end;

        local math_clamp_ret = math.clamp(p156 - v158.t0, 0, v158.dur);
        local v160 = v158.p0 + v158.v0 * math_clamp_ret + v158.accel * (math_clamp_ret * 0.5 * math_clamp_ret);

        if v158.settle then
            local math_min_ret = math.min(math_clamp_ret / v158.settleTime, 1);
            v160 = v160 + v158.settle * (math_min_ret * math_min_ret);
        end;

        return v158.rot0 + v160;
    end;

    local math_max_ret = math.max(p156 - v158.t0, 0);
    local v161 = v158.p0 + v158.v0 * math_max_ret + Vector3.new(0, -0.5 * p157 * math_max_ret * math_max_ret, 0);
    local rot0 = v158.rot0;
    local w = v158.w;
    local Magnitude = w.Magnitude;

    if Magnitude * math_max_ret >= 0.0001 then
        rot0 = CFrame.fromAxisAngle(w * (1 / Magnitude), Magnitude * math_max_ret) * rot0;
    end;

    return rot0 + v161;
end;

function v1.velocity(p162, p163, p164) -- Line: 403
    local segs = p162.segs;
    local v165 = segs[1];

    for i = 2, #segs do
        if segs[i].t0 > p163 then
            break;
        end;

        v165 = segs[i];
        local _ = i;
    end;

    if v165.kind == 1 then
        local math_max_ret = math.max(p163 - v165.t0, 0);

        return v165.v0 + Vector3.new(0, -p164 * math_max_ret, 0), v165.w;
    end;

    if v165.kind == 2 then
        local math_clamp_ret = math.clamp((p163 - v165.t0) / v165.dur, 0, 1);

        return (v165.p1 - v165.p0) * ((1 - math_clamp_ret) * 2 / v165.dur), Vector3.new(0, 0, 0);
    end;

    if v165.kind ~= 4 then
        return Vector3.new(0, 0, 0), Vector3.new(0, 0, 0);
    end;

    local math_clamp_ret = math.clamp(p163 - v165.t0, 0, v165.dur);

    return v165.v0 + v165.accel * math_clamp_ret, Vector3.new(0, 0, 0);
end;

return v1;