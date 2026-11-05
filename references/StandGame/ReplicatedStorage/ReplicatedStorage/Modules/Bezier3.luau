 

 

local function u2(p1) --[[ Line: 19 ]]
    -- upvalues: u2 (copy)
    return p1 == 0 and 1 or p1 * u2(p1 - 1);
end;
local u3 = {};
local u4 = {};
u4.__index = u4;
function u3.new(p5) --[[ Line: 74 ]]
    -- upvalues: u4 (copy)
    return setmetatable({
        Points = p5
    }, u4);
end;
function u3.fromParts(p6) --[[ Line: 89 ]]
    -- upvalues: u3 (copy)
    local v7 = p6:GetChildren();
    table.sort(v7, function(p8, p9) --[[ Line: 92 ]]
        return tonumber(p8.Name) < tonumber(p9.Name);
    end);
    local v10 = {};
    for _, v11 in v7 do
        table.insert(v10, v11.Position);
    end;
    return u3.new(v10);
end;
function u3.random(p12, p13, p14, p15) --[[ Line: 111 ]]
    -- upvalues: u3 (copy)
    local v16 = p15 or 0.9;
    if typeof(p12) == "Vector3" then
        p12 = CFrame.new(p12) * CFrame.fromEulerAnglesYXZ(math.random() * 3.141592653589793 * 2 - 3.141592653589793, math.random() * 3.141592653589793 * 2 - 3.141592653589793, math.random() * 3.141592653589793 * 2 - 3.141592653589793);
    end;
    local v17 = { p12.Position };
    for _ = 1, p13 - 1 do
        local v18 = math.random(p14.Min, p14.Max);
        local v19 = v18 * v16 / 2;
        local v20 = p12.LookVector * v18 + p12.Position;
        local v21 = CFrame.new(v20.X, v20.Y, v20.Z, select(4, p12:GetComponents())) * CFrame.new(math.random(-v19, v19), math.random(-v19, v19), 0);
        table.insert(v17, v21.Position);
        local v22 = CFrame.lookAt(p12.Position, v21.Position);
        p12 = CFrame.new(v21.X, v21.Y, v21.Z, select(4, v22:GetComponents()));
    end;
    return u3.new(v17);
end;
function u4.DeCasteljau(p23, p24) --[[ Line: 152 ]]
    local v25 = { unpack(p23.Points) };
    local v26 = #v25;
    for v27 = 1, v26 - 1 do
        for v28 = 1, v26 - v27 do
            v25[v28] = v25[v28] * (1 - p24) + v25[v28 + 1] * p24;
        end;
    end;
    return v25[1];
end;
function u4.GetPoint(p29, p30) --[[ Line: 169 ]]
    -- upvalues: u2 (copy)
    local l__Points__1 = p29.Points;
    local v31 = #l__Points__1 - 1;
    local v32 = Vector3.new(0, 0, 0);
    for v33 = 0, v31 do
        local v34 = v31 == 0 and 1 or v31 * u2(v31 - 1);
        local v35 = v33 == 0 and 1 or v33 * u2(v33 - 1);
        local v36 = v31 - v33;
        v32 = v32 + v34 / (v35 * (v36 == 0 and 1 or v36 * u2(v36 - 1))) * p30 ^ v33 * (1 - p30) ^ (v31 - v33) * l__Points__1[v33 + 1];
    end;
    return v32;
end;
function u4.Polynomial(p37) --[[ Line: 187 ]]
    -- upvalues: u2 (copy)
    local l__Points__2 = p37.Points;
    local u38 = #l__Points__2 - 1;
    local u39 = {};
    for v40 = 0, u38 do
        local v41 = Vector3.new(0, 0, 0);
        for v42 = 0, v40 do
            local v43 = (-1) ^ (v42 + v40) * l__Points__2[v42 + 1];
            local v44 = v42 == 0 and 1 or v42 * u2(v42 - 1);
            local v45 = v40 - v42;
            v41 = v41 + v43 / (v44 * (v45 == 0 and 1 or v45 * u2(v45 - 1)));
        end;
        local v46 = v41 * (u38 == 0 and 1 or u38 * u2(u38 - 1));
        local v47 = u38 - v40;
        u39[v40] = v46 / (v47 == 0 and 1 or v47 * u2(v47 - 1));
    end;
    return function(p48) --[[ Line: 199 ]]
        -- upvalues: u38 (copy), u39 (copy)
        local v49 = Vector3.new(0, 0, 0);
        for v50 = 0, u38 do
            v49 = v49 + p48 ^ v50 * u39[v50];
        end;
        return v49;
    end, u39;
end;
function u4.UpdateLUT(p51, p52, p53) --[[ Line: 212 ]]
    local v54 = p52 or 101;
    local _ = p51.Points;
    local v55 = {};
    local v56 = 0;
    local v57 = nil;
    for v58 = 0, v54 - 1 do
        local v59 = p51:DeCasteljau(v58 / (v54 - 1));
        if v58 ~= 0 then
            v56 = v56 + (v57 - v59).Magnitude;
        end;
        v55[v58] = v56;
        v57 = v59;
    end;
    p51.LUT = v55;
    p51.Length = v56;
    if p53 or p51.RMFLUT then
        local v60 = p51:GetDerivative(-0.001);
        local l__Unit__3 = (v60 + p51:GetSecondDerivative(-0.001)):Cross(v60).Unit;
        local v61 = {
            {
                p51:DeCasteljau(0),
                v60,
                l__Unit__3,
                l__Unit__3:Cross(v60)
            }
        };
        for v62 = 0, 99 do
            local v63 = v61[v62];
            local v64 = (v62 + 1) / 100;
            local v65 = { p51:DeCasteljau(v64), p51:GetDerivative(v64) };
            local v66 = v65[1] - v63[1];
            local v67 = v66:Dot(v66);
            local v68 = v63[3] - v66 * 2 / v67 * v66:Dot(v63[3]);
            local v69 = v63[2] - v66 * 2 / v67 * v66:Dot(v63[2]);
            local v70 = v65[2] - v69;
            v65[3] = v68 - v70 * 2 / v70:Dot(v70) * v70:Dot(v68);
            v65[4] = v65[3]:Cross(v65[2]);
            v61[v62 + 1] = v65;
        end;
        p51.RMFLUT = v61;
    end;
end;
function u4.ConvertT(p71, p72) --[[ Line: 284 ]]
    if not p71.Length then
        p71:UpdateLUT();
    end;
    local l__LUT__4 = p71.LUT;
    local v73 = p71.Length * p72;
    local v74 = 0;
    local v75 = 0;
    for v76, v77 in l__LUT__4 do
        if v77 <= v73 and v74 < v77 then
            v75 = v76;
            v74 = v77;
        end;
    end;
    if v74 == v73 then
        return v75 / #l__LUT__4;
    elseif l__LUT__4[v75 + 1] then
        return (v75 + (v73 - v74) / (l__LUT__4[v75 + 1] - v74)) / #l__LUT__4;
    else
        return (v75 + (v73 - v74) / (l__LUT__4[v75 - 1] - v74)) / #l__LUT__4;
    end;
end;
function u4.GetDerivative(p78, p79) --[[ Line: 336 ]]
    -- upvalues: u2 (copy)
    local l__Points__5 = p78.Points;
    local v80 = #l__Points__5 - 2;
    local v81 = Vector3.new(0, 0, 0);
    for v82 = 0, v80 do
        local v83 = v80 == 0 and 1 or v80 * u2(v80 - 1);
        local v84 = v82 == 0 and 1 or v82 * u2(v82 - 1);
        local v85 = v80 - v82;
        v81 = v81 + v83 / (v84 * (v85 == 0 and 1 or v85 * u2(v85 - 1))) * p79 ^ v82 * (1 - p79) ^ (v80 - v82) * (l__Points__5[v82 + 2] - l__Points__5[v82 + 1]);
    end;
    return v81 * (v80 + 1);
end;
function u4.GetSecondDerivative(p86, p87) --[[ Line: 352 ]]
    -- upvalues: u2 (copy)
    local l__Points__6 = p86.Points;
    local v88 = #l__Points__6 - 3;
    local v89 = Vector3.new(0, 0, 0);
    for v90 = 0, v88 do
        local v91 = v88 == 0 and 1 or v88 * u2(v88 - 1);
        local v92 = v90 == 0 and 1 or v90 * u2(v90 - 1);
        local v93 = v88 - v90;
        v89 = v89 + v91 / (v92 * (v93 == 0 and 1 or v93 * u2(v93 - 1))) * p87 ^ v90 * (1 - p87) ^ (v88 - v90) * ((v88 + 2) * (v88 + 1) * (l__Points__6[v90 + 3] - 2 * l__Points__6[v90 + 2] + l__Points__6[v90 + 1]));
    end;
    return v89;
end;
function u4.CreateDerivativeCurve(p94, p95) --[[ Line: 370 ]]
    -- upvalues: u2 (copy), u3 (copy)
    local v96 = p95 or 1;
    local l__Points__7 = p94.Points;
    local v97 = {};
    for v98 = 1, #l__Points__7 - v96 do
        local v99 = Vector3.new(0, 0, 0);
        for v100 = 0, v96 do
            local v101 = (-1) ^ (v96 - v100);
            local v102 = v96 == 0 and 1 or v96 * u2(v96 - 1);
            local v103 = v100 == 0 and 1 or v100 * u2(v100 - 1);
            local v104 = v96 - v100;
            v99 = v99 + v101 * (v102 / (v103 * (v104 == 0 and 1 or v104 * u2(v104 - 1)))) * l__Points__7[v98 + v100];
        end;
        table.insert(v97, v99);
    end;
    return u3.new(v97);
end;
function u4.GetCurvature(p105, p106) --[[ Line: 389 ]]
    local v107 = p105:GetDerivative(p106);
    return v107:Cross(p105:GetSecondDerivative(p106)).Magnitude / v107.Magnitude ^ 3;
end;
function u4.GetIterations(p108, p109, p110) --[[ Line: 402 ]]
    -- upvalues: u4 (copy)
    local v111 = p110 or u4.DeCasteljau;
    local v112 = {};
    for v113 = 0, p109 - 1 do
        table.insert(v112, v111(p108, v113 / (p109 - 1)));
    end;
    return v112;
end;
function u4.Subdivide(p114, p115) --[[ Line: 420 ]]
    -- upvalues: u3 (copy)
    local l__Points__8 = p114.Points;
    local v116 = #l__Points__8;
    local v117 = {};
    local v118 = p115 or 0.5;
    local v119 = {};
    for v120 = 1, v116 - 1 do
        for v121 = 1, v116 - v120 do
            if v121 == 1 then
                table.insert(v119, l__Points__8[1]);
            end;
            if v121 == v116 - v120 then
                table.insert(v117, l__Points__8[v121 + 1]);
            end;
            l__Points__8[v121] = l__Points__8[v121] * (1 - v118) + l__Points__8[v121 + 1] * v118;
        end;
    end;
    table.insert(v119, l__Points__8[1]);
    table.insert(v117, l__Points__8[1]);
    return u3.new(v119), u3.new(v117);
end;
function u4.ElevateDegree(p122, p123) --[[ Line: 451 ]]
    -- upvalues: u3 (copy)
    local v124 = nil;
    for _ = 1, p123 or 1 do
        local v125 = v124 or p122.Points;
        v124 = {};
        local v126 = #v125;
        v124[1] = v125[1];
        v124[v126 + 1] = v125[v126];
        for v127 = 2, v126 do
            v124[v127] = (v127 - 1) / v126 * v125[v127 - 1] + (v126 - v127 + 1) / v126 * v125[v127];
        end;
    end;
    return u3.new(v124);
end;
local u128;
if script:FindFirstChildWhichIsA("ModuleScript") then
    u128 = require(script:FindFirstChildWhichIsA("ModuleScript"));
else
    u128 = nil;
end;
local function u172(p129) --[[ Line: 480 ]]
    -- upvalues: u128 (ref)
    local v130 = 0;
    local v131 = 0;
    local v132 = {};
    for _ in p129 do
        v130 = v130 + 1;
    end;
    for v133 = v131, v130 - 1 - 1 do
        v132[v133] = 0;
    end;
    local v134 = 0;
    for _ in p129 do
        v134 = v134 + 1;
    end;
    local v135 = v134 - 1;
    local v136 = u128.cmplx(0, 1);
    local v137 = math.abs(p129[0] / p129[v135]);
    local v138 = math.pow(v137, 1 / v135);
    local v139 = 6.283185307179586 / v135;
    local v140 = v139 / (v135 + 1);
    for v141 = 0, v135 - 1 do
        v132[v141] = u128.cmplx(v138, 0) * u128.exp(v136 * u128.cmplx(v139 * v141 + v140, 0));
    end;
    local v142 = {};
    for v143 = 0, v135 do
        v142[v143] = 0;
    end;
    local v144 = u128.cmplx(1e-14, 0);
    local v145 = 0;
    local v146 = 0;
    local v147 = 0;
    local v148 = 0;
    for _ in v142 do
        v145 = v145 + 1;
    end;
    for v149 = v146, v145 - 1 - 1 do
        v147 = v147 + u128.pow(u128.abs(v142[v149] - v132[v149]), 2);
    end;
    local v150 = u128.sqrt(v147);
    while v144 < v150 and v148 < 10000 do
        v148 = v148 + 1;
        for v151, v152 in v132 do
            v142[v151] = u128.cmplx(v152.Re, v152.Im);
        end;
        local v153 = 0;
        local v154 = 0;
        for _ in v132 do
            v153 = v153 + 1;
        end;
        for v155 = v154, v153 - 1 do
            local v156 = 0;
            for _ in p129 do
                v156 = v156 + 1;
            end;
            local v157 = v156 - 1 + 1;
            local v158 = u128.cmplx(0, 0);
            local v159 = u128.cmplx(p129[v157 - 1], 0);
            for v160 = v157 - 2, 0, -1 do
                v158 = v158 * v142[v155] + v159;
                v159 = u128.cmplx(p129[v160], 0) + v142[v155] * v159;
            end;
            local v161 = v159 / v158;
            local v162 = u128.cmplx(0, 0);
            local v163 = 0;
            local v164 = 0;
            for _ in v142 do
                v163 = v163 + 1;
            end;
            for v165 = v164, v163 - 1 - 1 do
                if v165 ~= v155 then
                    v162 = v162 + 1 / (v142[v155] - v142[v165]);
                end;
            end;
            v132[v155] = v132[v155] - v161 / (1 - v161 * v162);
        end;
        local v166 = 0;
        local v167 = 0;
        local v168 = 0;
        for _ in v142 do
            v166 = v166 + 1;
        end;
        for v169 = v167, v166 - 1 - 1 do
            v168 = v168 + u128.pow(u128.abs(v142[v169] - v132[v169]), 2);
        end;
        v150 = u128.sqrt(v168);
    end;
    for v170, v171 in v132 do
        v132[v170] = v171.Re;
    end;
    return v132;
end;
function u4.GetExtrema(p173) --[[ Line: 558 ]]
    -- upvalues: u128 (ref), u172 (copy)
    if not u128 then
        error("GetExtrema requires the installation of another module, please check the Bézier module or docs for more information.");
    end;
    local _, v174 = p173:CreateDerivativeCurve():Polynomial();
    local v175 = {};
    for _, v176 in { "X", "Y", "Z" } do
        local v177 = 0;
        local v178 = 1;
        local v179 = p173:DeCasteljau(v177)[v176];
        local v180 = p173:DeCasteljau(v178)[v176];
        local v181 = {};
        for v182, v183 in v174 do
            v181[v182] = v183[v176];
        end;
        for _, v184 in u172(v181) do
            if v184 > 0.01 and v184 < 0.99 then
                local v185 = p173:DeCasteljau(v184)[v176];
                if v180 < v179 then
                    if v185 < v180 then
                        v178 = v184;
                        v180 = v185;
                    end;
                    if v179 < v185 then
                        v177 = v184;
                        v179 = v185;
                    end;
                else
                    if v185 < v179 then
                        v177 = v184;
                        v179 = v185;
                    end;
                    if v180 < v185 then
                        v178 = v184;
                        v180 = v185;
                    end;
                end;
            end;
        end;
        v175[v176] = { v177, v178 };
    end;
    return v175;
end;
function u4.GetBoundingBox(p186, p187, p188) --[[ Line: 632 ]]
    -- upvalues: u3 (copy)
    if not p187 then
        local v189 = (1 / 0);
        local v190 = (-1 / 0);
        local v191 = v189;
        local v192 = v190;
        local v193 = v191;
        local v194 = v192;
        local v195 = v191;
        v191 = v193;
        v195 = v192;
        v192 = v194;
        v195 = v193;
        v193 = v191;
        v195 = v194;
        for _, v196 in p186.Points do
            if v196.X < v189 then
                v189 = v196.X;
            end;
            if v194 < v196.X then
                v194 = v196.X;
            end;
            if v196.Y < v193 then
                v193 = v196.Y;
            end;
            if v192 < v196.Y then
                v192 = v196.Y;
            end;
            if v196.Z < v191 then
                v191 = v196.Z;
            end;
            if v190 < v196.Z then
                v190 = v196.Z;
            end;
        end;
        return Vector3.new(v189, v193, v191), Vector3.new(v194, v192, v190);
    end;
    if not p188 then
        local v197 = p186:GetExtrema();
        local l__X__9 = p186:DeCasteljau(v197.X[1]).X;
        local l__Y__10 = p186:DeCasteljau(v197.Y[1]).Y;
        local l__Z__11 = p186:DeCasteljau(v197.Z[1]).Z;
        local v198 = Vector3.new(l__X__9, l__Y__10, l__Z__11);
        local l__X__12 = p186:DeCasteljau(v197.X[2]).X;
        local l__Y__13 = p186:DeCasteljau(v197.Y[2]).Y;
        local l__Z__14 = p186:DeCasteljau(v197.Z[2]).Z;
        return v198, Vector3.new(l__X__12, l__Y__13, l__Z__14);
    end;
    local v199 = p186.Points[1];
    local v200 = {};
    for _, v201 in p186.Points do
        table.insert(v200, v201 - v199);
    end;
    local v202 = #v200;
    local v203 = math.atan2(v200[v202].Z, v200[v202].X);
    for v204, v205 in v200 do
        local v206 = v205.X * math.cos(-v203) - v205.Z * math.sin(-v203);
        local l__Y__15 = v205.Y;
        local v207 = v205.X * math.sin(-v203) + v205.Z * math.cos(-v203);
        v200[v204] = Vector3.new(v206, l__Y__15, v207);
    end;
    local v208 = u3.new(v200);
    local v209 = v208:GetExtrema();
    local l__X__16 = v208:DeCasteljau(v209.X[1]).X;
    local l__X__17 = v208:DeCasteljau(v209.X[2]).X;
    local l__Y__18 = v208:DeCasteljau(v209.Y[1]).Y;
    local l__Y__19 = v208:DeCasteljau(v209.Y[2]).Y;
    local l__Z__20 = v208:DeCasteljau(v209.Z[1]).Z;
    local l__Z__21 = v208:DeCasteljau(v209.Z[2]).Z;
    local v210 = math.abs(l__X__17 - l__X__16);
    local v211 = math.abs(l__Y__19 - l__Y__18);
    local v212 = math.abs(l__Z__21 - l__Z__20);
    local v213 = Vector3.new(v210, v211, v212);
    local v214 = Vector3.new((l__X__16 + l__X__17) / 2, (l__Y__18 + l__Y__19) / 2, (l__Z__20 + l__Z__21) / 2);
    local v215 = (Vector3.new(0, 0, -v213.Z) + v214 * 2) / 2;
    local v216 = v199.X + v214.X * math.cos(v203) - v214.Z * math.sin(v203);
    local v217 = v199.Y + v214.Y;
    local v218 = v199.Z + v214.X * math.sin(v203) + v214.Z * math.cos(v203);
    local v219 = Vector3.new(v216, v217, v218);
    local v220 = v199.X + v215.X * math.cos(v203) - v215.Z * math.sin(v203);
    local v221 = v199.Y + v215.Y;
    local v222 = v199.Z + v215.X * math.sin(v203) + v215.Z * math.cos(v203);
    local v223 = Vector3.new(v220, v221, v222);
    return CFrame.lookAt(v219, v223), v213, Vector3.new(l__X__16, l__Y__18, l__Z__20), Vector3.new(l__X__17, l__Y__19, l__Z__21);
end;
function u4.GetNormal(p224, p225) --[[ Line: 733 ]]
    if not p224.RMFLUT then
        p224:UpdateLUT(nil, true);
    end;
    local l__RMFLUT__22 = p224.RMFLUT;
    local v226 = 0;
    for _ in l__RMFLUT__22 do
        v226 = v226 + 1;
    end;
    local v227 = v226 - 1;
    local v228 = p225 * v227;
    local v229 = math.floor(v228);
    if v228 == v229 then
        return {
            o = l__RMFLUT__22[v229][1],
            dt = l__RMFLUT__22[v229][2],
            r = l__RMFLUT__22[v229][3],
            n = l__RMFLUT__22[v229][4]
        };
    end;
    local v230 = v229 + 1;
    local v231 = v229 / v227;
    local v232 = (p225 - v231) / (v230 / v227 - v231);
    local v233 = {};
    for v234, v235 in {
        "o",
        "dt",
        "r",
        "n"
    } do
        v233[v235] = l__RMFLUT__22[v229][v234]:Lerp(l__RMFLUT__22[v230][v234], v232);
    end;
    return v233;
end;
local function u241(p236) --[[ Line: 777 ]]
    -- upvalues: u241 (copy)
    local v237 = {};
    for v238, v240 in p236 do
        if type(v240) == "table" then
            local v240 = u241(v240);
        end;
        v237[v238] = v240;
    end;
    return v237;
end;
function u4.Clone(p242) --[[ Line: 793 ]]
    -- upvalues: u241 (copy), u4 (copy)
    local v243 = u241(p242);
    return setmetatable(v243, u4);
end;
function u4.Destroy(p244) --[[ Line: 800 ]]
    table.clear(p244);
    setmetatable(p244, nil);
end;
return u3;