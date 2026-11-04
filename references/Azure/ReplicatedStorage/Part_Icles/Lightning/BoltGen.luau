 

 

local u8 = {
    layout = function(p1, p2, p3, p4) -- Line: 18, Name: layout
        local math_floor_ret = math.floor(p1 or 12);
        local math_clamp_ret = math.clamp(math_floor_ret, 2, p4);
        local math_floor_ret2 = math.floor(math_clamp_ret / 2);
        local math_max_ret = math.max(2, math_floor_ret2);
        local v5;

        if (p2 or 0) >= 0.5 and (p3 or 0) > 0 then
            local v6 = p4 - math_clamp_ret;

            if v6 >= 4 and math.floor(v6 / math_max_ret) < 2 then
                local math_floor_ret3 = math.floor(v6 / 2);
                local math_min_ret = math.min(math_max_ret, math_floor_ret3);
                math_max_ret = math.max(4, math_min_ret);
            end;

            local math_floor_ret3 = math.floor(v6 / math_max_ret);
            v5 = math.min(6, math_floor_ret3);

            if v5 < 0 then
                v5 = 0;
            end;
        else
            v5 = 0;
        end;

        return math_clamp_ret + v5 * math_max_ret, math_clamp_ret, math_max_ret, v5;
    end,

    basis = function(p7) -- Line: 39, Name: basis
        if p7.Magnitude < 0.0001 then
            return Vector3.new(1, 0, 0), Vector3.new(0, 0, 1);
        end;

        local Unit = p7.Unit;
        local Unit2 = Unit:Cross(math.abs(Unit.Y) < 0.99 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)).Unit;

        return Unit2, Unit:Cross(Unit2);
    end
};

local function displace(p9, p10, p11, p12, p13, p14, p15) -- Line: 50
    -- upvalues: displace (copy)
    if p11 - p10 <= 1 then
        return;
    end;

    local math_floor_ret = math.floor((p10 + p11) / 2);
    p9[math_floor_ret] = p9[p10]:Lerp(p9[p11], (math_floor_ret - p10) / (p11 - p10)) + p14 * ((math.random() * 2 - 1) * p12) + p15 * ((math.random() * 2 - 1) * p12);
    local v16 = p12 * p13;
    displace(p9, p10, math_floor_ret, v16, p13, p14, p15);
    displace(p9, math_floor_ret, p11, v16, p13, p14, p15);
end;

local function buildPolyline(p17, p18, p19, p20, p21, p22, p23, p24, p25, p26) -- Line: 66
    -- upvalues: u8 (copy), displace (copy)
    local v27 = p20 - p19;
    local Magnitude = v27.Magnitude;

    for i = 1, p18 + 1 do
        p17[i] = p19 + v27 * ((i - 1) / p18);
        local _ = i;
    end;

    if p24 and p21 ~= 0 then
        local v28, v29 = u8.basis(v27);
        displace(p17, 1, p18 + 1, p21, p22, v28, v29);
    end;

    if p23 ~= 0 and Magnitude > 0.0001 then
        local v30 = (p25 or Vector3.new(0, 1, 0)) * (p23 >= 0 and -1 or 1);
        local math_max_ret = math.max(p26 or 1, 0);
        local v31 = math.abs(p23) * Magnitude;

        if math_max_ret >= 1 then
            for i = 2, p18 do
                local v32 = (i - 1) / p18;
                local v33 = 4 * v32 * (1 - v32);

                if math_max_ret ~= 1 then
                    v33 = v33 ^ math_max_ret;
                end;

                p17[i] = p17[i] + v30 * (v31 * v33);
                local _ = i;
            end;

            return;
        end;

        local v34 = v27 * (1 / Magnitude);
        local v35 = v30 - v34 * v30:Dot(v34);

        if v35.Magnitude > 0.0001 then
            local Unit = v35.Unit;
            local v36 = (Magnitude * Magnitude * 0.25 + v31 * v31) / (2 * v31);
            local math_clamp_ret = math.clamp((v36 - v31) / v36, -1, 1);
            local math_acos_ret = math.acos(math_clamp_ret);
            local v37 = p19 + v27 * 0.5 + Unit * (v31 - v36);

            for i = 2, p18 do
                local v38 = (i - 1) / p18;
                local v39 = p19 + v27 * v38;
                local v40 = (2 * v38 - 1) * math_acos_ret;
                local v41 = v37 + (v34 * math.sin(v40) + Unit * math.cos(v40)) * v36;
                local v42;

                if math_max_ret >= 0.5 then
                    v42 = v41:Lerp(v39 + Unit * (v31 * 4 * v38 * (1 - v38)), (math_max_ret - 0.5) * 2);
                else
                    v42 = (v39 + Unit * v31):Lerp(v41, math_max_ret * 2);
                end;

                p17[i] = p17[i] + (v42 - v39);
                local _ = i;
            end;
        end;
    end;
end;

local function writeSegments(p43, p44, p45, p46, p47) -- Line: 127
    local v48 = p47;

    for i = 1, p45 do
        local v49 = p44[i];
        local v50 = p44[i + 1];
        local Magnitude = (v50 - v49).Magnitude;
        local v51 = p46 + i;
        p43.revealDist[v51] = p47;

        if Magnitude > 0.0001 then
            p43.rollCFs[v51] = CFrame.lookAt((v49 + v50) * 0.5, v50);
        else
            p43.rollCFs[v51] = CFrame.new((v49 + v50) * 0.5);
        end;

        p43.segLen[v51] = math.max(Magnitude, 0.05);
        p47 = p47 + Magnitude;
        local _ = i;
    end;

    return p47 - v48;
end;

function u8.roll(p52, p53, p54, p55, p56) -- Line: 149
    -- upvalues: buildPolyline (copy), u8 (copy), writeSegments (copy)
    local math_clamp_ret = math.clamp(p53._segCount or p52.mainSegs, 2, p52.mainSegs);
    local Magnitude = (p55 - p54).Magnitude;
    local v57 = (p53._amplitude or 0) * Magnitude;
    local v58 = p53._shapeMode or "Jitter";
    buildPolyline(p52.ptBuf, math_clamp_ret, p54, p55, v57, p53._decay or 0.5, p53._sag or 0, v58 ~= "Scroll", p53._sagDirWorld, p53._sagShape);

    if v58 ~= "Jitter" then
        for i = 1, math_clamp_ret + 1 do
            p52.basePtBuf[i] = p52.ptBuf[i];
            local _ = i;
        end;

        local v59, v60 = u8.basis(p55 - p54);
        p52.scrollU = v59;
        p52.scrollV = v60;
        p52.scrollDist = Magnitude;
    end;

    p52.curSegs = math_clamp_ret;
    local v61 = writeSegments(p52, p52.ptBuf, math_clamp_ret, 0, 0);

    for i = math_clamp_ret + 1, p52.mainSegs do
        p52.rollCFs[i] = p56;
        p52.segLen[i] = 0.05;
        p52.revealDist[i] = (1 / 0);
        local _ = i;
    end;

    local v62 = 0;

    for i = 1, p52.forkSlots do
        local v63 = p52.mainSegs + (i - 1) * p52.forkSegs;
        local v64 = p52.slotDepth[i];
        local v65 = false;
        local v66;

        if (p53._forkChance or 0) > math.random() and v64 <= (p53._forkDepth or 0) then
            local v67 = nil;
            local v68 = nil;
            local v69 = nil;
            local v70 = 0;
            local v71 = 0;
            local v72 = 0;

            if v64 == 1 then
                v70 = math.random(2, math_clamp_ret);
                v67 = p52.ptBuf[v70];
                v68 = (p52.ptBuf[v70 + 1] or p55) - v67;
                v69 = p52.revealDist[v70] or 0;
            elseif v62 > 0 then
                local math_random_ret = math.random(1, v62);
                v67 = p52.forkAnchorPos[math_random_ret];
                v68 = p52.forkAnchorDir[math_random_ret];
                v69 = p52.forkAnchorReveal[math_random_ret];
                v71 = p52.forkAnchorSlot[math_random_ret];
                v72 = p52.forkAnchorPtIdx[math_random_ret];
            end;

            if v67 and (v68 and v68.Magnitude > 0.0001) then
                local v73 = (p53._forkLenScale or 0.4) ^ v64;
                local math_max_ret = math.max(1, Magnitude * v73);
                local v74, v75 = u8.basis(v68);
                local v76 = math.random() * 3.141592653589793 * 2;
                local v77 = v74 * math.cos(v76) + v75 * math.sin(v76);
                local v78 = 0.2617993877991494 + math.random() * 0.5235987755982989;
                local v79 = CFrame.fromAxisAngle(v77, v78):VectorToWorldSpace(v68.Unit);
                buildPolyline(p52.forkPtBuf, p52.forkSegs, v67, v67 + v79 * math_max_ret, v57 * v73, p53._decay or 0.5, 0, true);
                writeSegments(p52, p52.forkPtBuf, p52.forkSegs, v63, v69);
                local v80 = p52.forkLocalPts[i];
                v66 = i;

                for i2 = 1, p52.forkSegs + 1 do
                    v80[i2] = p52.forkPtBuf[i2] - v67;
                    local _ = i2;
                end;

                p52.forkOriginIdx[v66] = v70 or 0;
                p52.forkParentSlot[v66] = v71 or 0;
                p52.forkParentPtIdx[v66] = v72 or 0;
                p52.forkLen[v66] = math_max_ret;
                p52.forkStartReveal[v66] = v69;

                if v64 == 1 then
                    p52.forkStartFrac[v66] = v69 / math.max(v61, 0.0001);
                else
                    local v81 = p52.forkStartFrac[v71] or 0;
                    local v82 = (v69 - (p52.forkStartReveal[v71] or 0)) / math.max(p52.forkLen[v71] or 1, 0.0001);
                    p52.forkStartFrac[v66] = v81 + math.clamp(v82, 0, 1) * (1 - v81);
                end;

                local v83, v84 = u8.basis(v79);
                local forkV = p52.forkV;
                p52.forkU[v66] = v83;
                forkV[v66] = v84;
                p52.forkSeedU[v66] = math.random() * 100;
                p52.forkSeedV[v66] = 100 + math.random() * 100;

                if v64 == 1 then
                    v62 = v62 + 1;
                    local v85 = math.floor(p52.forkSegs / 2) + 1;
                    local math_max_ret2 = math.max(2, v85);
                    p52.forkAnchorPos[v62] = p52.forkPtBuf[math_max_ret2];
                    p52.forkAnchorDir[v62] = v79;
                    p52.forkAnchorReveal[v62] = v69;
                    p52.forkAnchorSlot[v62] = v66;
                    p52.forkAnchorPtIdx[v62] = math_max_ret2;
                end;

                v65 = true;
            else
                v66 = i;
            end;
        else
            v66 = i;
        end;

        if not v65 then
            p52.forkOriginIdx[v66] = 0;
            p52.forkParentSlot[v66] = 0;

            for i2 = 1, p52.forkSegs do
                local v86 = v63 + i2;
                p52.rollCFs[v86] = p56;
                p52.segLen[v86] = 0.05;
                p52.revealDist[v86] = (1 / 0);
                local _ = i2;
            end;
        end;
    end;

    local v87 = 0;

    for i = 1, p52.partCount do
        local v88 = p52.revealDist[i];
        local v89;

        if v88 == (1 / 0) or v87 >= v88 + p52.segLen[i] then
            v89 = i;
        else
            v87 = v88 + p52.segLen[i];
            v89 = i;
        end;
    end;

    p52.maxReveal = v87;
    u8.sortReveal(p52);

    return v61;
end;

function u8.diffLive(p90) -- Line: 280
    local v91 = 0;

    for i = 1, p90.partCount do
        local v92 = p90.revealDist[i] ~= (1 / 0);

        if v92 and not p90.prevLive[i] then
            v91 = v91 + 1;
            p90.newlyLiveIdx[v91] = i;
            p90.lastWrittenLen[i] = -1;
        end;

        p90.prevLive[i] = v92;
        local _ = i;
    end;

    return v91;
end;

function u8.planSizes(p93, p94, p95) -- Line: 300
    local v96 = p95 or p94 ~= p93.lastThick;
    local v97 = 0;

    for i = 1, p93.partCount do
        local v98;

        if p93.revealDist[i] == (1 / 0) then
            v98 = i;
        else
            local v99 = p93.segLen[i];

            if v96 or v99 ~= p93.lastWrittenLen[i] then
                v97 = v97 + 1;
                p93.sizeWriteIdx[v97] = i;
                p93.lastWrittenLen[i] = v99;
                v98 = i;
            else
                v98 = i;
            end;
        end;
    end;

    p93.lastThick = p94;

    return v97;
end;

function u8.applyScroll(p100, p101, p102) -- Line: 321
    local curSegs = p100.curSegs;
    local scrollU = p100.scrollU;
    local scrollV = p100.scrollV;

    if not (curSegs and (curSegs >= 2 and scrollU)) then
        return;
    end;

    local v103 = (p101._amplitude or 0) * (p100.scrollDist or 0);
    local v104 = p101._waves or 3;
    local v105 = p101._decay or 0.5;
    local v106 = p101._noiseSeedA or 0;
    local v107 = p101._noiseSeedB or 500;
    local ptBuf = p100.ptBuf;
    local basePtBuf = p100.basePtBuf;

    for i = 1, curSegs + 1 do
        local v108 = (i - 1) / curSegs;
        local v109 = 4 * v108 * (1 - v108);
        local v110 = v109 * v109;
        local v111 = v108 * v104 - p102;
        local v112 = v108 * v104 * 2.7 - p102 * 1.6;
        local v113 = (math.noise(v111, v106) + math.noise(v112, v106 + 37.1) * v105) * v103 * v110;
        local v114 = (math.noise(v111, v107) + math.noise(v112, v107 + 37.1) * v105) * v103 * v110;
        ptBuf[i] = basePtBuf[i] + scrollU * v113 + scrollV * v114;
        local _ = i;
    end;

    for i = 1, curSegs do
        local v115 = ptBuf[i];
        local v116 = ptBuf[i + 1];
        local Magnitude = (v116 - v115).Magnitude;

        if Magnitude > 0.0001 then
            p100.rollCFs[i] = CFrame.lookAt((v115 + v116) * 0.5, v116);
        else
            p100.rollCFs[i] = CFrame.new((v115 + v116) * 0.5);
        end;

        p100.segLen[i] = math.max(Magnitude, 0.05);
        local _ = i;
    end;
end;

function u8.applyScrollForks(p117, p118, p119) -- Line: 362
    local forkSegs = p117.forkSegs;
    local v120 = p118._waves or 3;

    for i = 1, p117.forkSlots do
        local v121 = p117.forkOriginIdx[i] or 0;
        local v122 = p117.forkParentSlot[i] or 0;
        local v123;

        if v121 == 0 and v122 == 0 then
            v123 = i;
        else
            local v124;

            if v122 == 0 then
                v124 = p117.ptBuf[v121];
            else
                v124 = p117.forkWorldPts[v122];

                if v124 then
                    v124 = v124[p117.forkParentPtIdx[i]];
                end;
            end;

            if v124 then
                local v125 = p117.forkLocalPts[i];
                local v126 = p117.forkWorldPts[i];
                local v127 = p117.forkU[i];
                local v128 = p117.forkV[i];
                local v129 = (p118._amplitude or 0) * (p117.forkLen[i] or 1);
                local v130 = p117.forkSeedU[i] or 0;
                local v131 = p117.forkSeedV[i] or 50;
                v123 = i;

                for i2 = 1, forkSegs + 1 do
                    local v132 = (i2 - 1) / forkSegs;
                    local v133 = v132 * v120 - p119 * 1.35;
                    v126[i2] = v124 + v125[i2] + v127 * (math.noise(v133, v130) * v129 * v132) + v128 * (math.noise(v133, v131) * v129 * v132);
                    local _ = i2;
                end;

                local v134 = p117.mainSegs + (v123 - 1) * forkSegs;

                for i2 = 1, forkSegs do
                    local v135 = v126[i2];
                    local v136 = v126[i2 + 1];
                    local Magnitude = (v136 - v135).Magnitude;
                    local v137 = v134 + i2;

                    if Magnitude > 0.0001 then
                        p117.rollCFs[v137] = CFrame.lookAt((v135 + v136) * 0.5, v136);
                    else
                        p117.rollCFs[v137] = CFrame.new((v135 + v136) * 0.5);
                    end;

                    p117.segLen[v137] = math.max(Magnitude, 0.05);
                    local _ = i2;
                end;
            else
                v123 = i;
            end;
        end;
    end;
end;

function u8.sortReveal(p138) -- Line: 409
    local revealOrder = p138.revealOrder;
    local revealDist = p138.revealDist;

    for i = 2, p138.partCount do
        local v139 = revealOrder[i];
        local v140 = i - 1;
        local _ = i;

        while v140 >= 1 and revealDist[v139] < revealDist[revealOrder[v140]] do
            revealOrder[v140 + 1] = revealOrder[v140];
            v140 = v140 - 1;
        end;

        revealOrder[v140 + 1] = v139;
    end;
end;

return u8;