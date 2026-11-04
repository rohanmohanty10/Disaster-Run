  

local script_Base64 = require(script.Base64);
local l_ipairs = ipairs;
local bit32_band = bit32.band;
local bit32_bor = bit32.bor;
local bit32_bxor = bit32.bxor;
local bit32_lshift = bit32.lshift;
local bit32_rshift = bit32.rshift;
local bit32_lrotate = bit32.lrotate;
local bit32_rrotate = bit32.rrotate;
local u1 = {};
local u2 = {};
local v3 = {};
local v4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = { 0, 0, 0, 0, 0, 0, 0, 0, 28, 25, 26, 27, 0, 0, 10, 9, 11, 12, 0, 15, 16, 17, 18, 0, 20, 22, 23, 21 };
local u9 = {};
local v10 = v4;
local v11 = v3;
local v12 = 4;
local v13 = { 4, 1, 2, -2, 2 };
local u14 = { 1732584193, 4023233417, 2562383102, 271733878, 3285377520 };

local function md5_feed_64(p15, p16, p17, p18) -- Line: 278
    -- upvalues: u9 (copy), u7 (copy), u8 (copy), bit32_band (copy), bit32_rrotate (copy), bit32_bxor (copy), bit32_bor (copy)
    local v19 = u9;
    local v20 = u7;
    local v21 = u8;
    local v22 = p15[1];
    local v23 = p15[2];
    local v24 = p15[3];
    local v25 = p15[4];

    for i = p17, p17 + p18 - 1, 64 do
        local v26 = i;
        local v27 = v26;
        local v28 = v26;
        v26 = v27;
        v28 = v27;

        for i2 = 1, 16 do
            v27 = v27 + 4;
            local string_byte_ret, v29, v30, v31 = string.byte(p16, v27 - 3, v27);
            v19[i2] = ((v31 * 256 + v30) * 256 + v29) * 256 + string_byte_ret;
            local _ = i2;
        end;

        local v32 = v22;
        local v33 = v25;
        local v34 = v24;
        local v35 = v23;
        local v36 = 25;

        for i2 = 1, 16 do
            local v37 = bit32_rrotate(bit32_band(v23, v24) + bit32_band(-1 - v23, v25) + v22 + v20[i2] + v19[i2], v36) + v23;
            v36 = v21[v36];
            v22 = v25;
            v25 = v24;
            v24 = v23;
            v23 = v37;
            local _ = i2;
        end;

        local v38 = 27;

        for i2 = 17, 32 do
            local v39 = bit32_rrotate(bit32_band(v25, v23) + bit32_band(-1 - v25, v24) + v22 + v20[i2] + v19[(i2 * 5 - 4) % 16 + 1], v38) + v23;
            v38 = v21[v38];
            v22 = v25;
            v25 = v24;
            v24 = v23;
            v23 = v39;
            local _ = i2;
        end;

        local v40 = 28;

        for i2 = 33, 48 do
            local v41 = bit32_rrotate(bit32_bxor(bit32_bxor(v23, v24), v25) + v22 + v20[i2] + v19[(i2 * 3 + 2) % 16 + 1], v40) + v23;
            v40 = v21[v40];
            v22 = v25;
            v25 = v24;
            v24 = v23;
            v23 = v41;
            local _ = i2;
        end;

        local v42 = 26;

        for i2 = 49, 64 do
            local v43 = bit32_rrotate(bit32_bxor(v24, (bit32_bor(v23, -1 - v25))) + v22 + v20[i2] + v19[(i2 * 7 - 7) % 16 + 1], v42) + v23;
            v42 = v21[v42];
            v22 = v25;
            v25 = v24;
            v24 = v23;
            v23 = v43;
            local _ = i2;
        end;

        v22 = (v22 + v32) % 4294967296;
        v23 = (v23 + v35) % 4294967296;
        v24 = (v24 + v34) % 4294967296;
        v25 = (v25 + v33) % 4294967296;
    end;

    p15[1] = v22;
    p15[2] = v23;
    p15[3] = v24;
    p15[4] = v25;
end;

local u44 = {
    [384] = {},
    [512] = v4
};
local u45 = {
    [384] = {},
    [512] = v3
};
local u46 = {
    [224] = {},
    [256] = v4
};

local function sha256_feed_64(p47, p48, p49, p50) -- Line: 151
    -- upvalues: u9 (copy), u2 (copy), bit32_rrotate (copy), bit32_lrotate (copy), bit32_rshift (copy), bit32_bxor (copy), bit32_band (copy)
    local v51 = u9;
    local v52 = u2;
    local v53 = p47[1];
    local v54 = p47[2];
    local v55 = p47[3];
    local v56 = p47[4];
    local v57 = p47[5];
    local v58 = p47[6];
    local v59 = p47[7];
    local v60 = p47[8];

    for i = p49, p49 + p50 - 1, 64 do
        local v61 = i;
        local v62 = v61;
        local v63 = v61;
        v61 = v62;
        v63 = v62;

        for i2 = 1, 16 do
            v62 = v62 + 4;
            local string_byte_ret, v64, v65, v66 = string.byte(p48, v62 - 3, v62);
            v51[i2] = ((string_byte_ret * 256 + v64) * 256 + v65) * 256 + v66;
            local _ = i2;
        end;

        for i2 = 17, 64 do
            local v67 = v51[i2 - 15];
            local v68 = v51[i2 - 2];
            v51[i2] = bit32_bxor(bit32_rrotate(v67, 7), bit32_lrotate(v67, 14), (bit32_rshift(v67, 3))) + bit32_bxor(bit32_lrotate(v68, 15), bit32_lrotate(v68, 13), (bit32_rshift(v68, 10))) + v51[i2 - 7] + v51[i2 - 16];
            local _ = i2;
        end;

        local v69 = v53;
        local v70 = v59;
        local v71 = v58;
        local v72 = v57;
        local v73 = v60;
        local v74 = v56;
        local v75 = v54;
        local v76 = v55;

        for i2 = 1, 64 do
            local v77 = bit32_bxor(bit32_rrotate(v57, 6), bit32_rrotate(v57, 11), (bit32_lrotate(v57, 7))) + bit32_band(v57, v58) + bit32_band(-1 - v57, v59) + v60 + v52[i2] + v51[i2];
            local v78 = v77 + bit32_band(v55, v54) + bit32_band(v53, (bit32_bxor(v55, v54))) + bit32_bxor(bit32_rrotate(v53, 2), bit32_rrotate(v53, 13), (bit32_lrotate(v53, 10)));
            v60 = v59;
            v59 = v58;
            v58 = v57;
            v57 = v77 + v56;
            v56 = v55;
            v55 = v54;
            v54 = v53;
            v53 = v78;
            local _ = i2;
        end;

        v53 = (v53 + v69) % 4294967296;
        v54 = (v54 + v75) % 4294967296;
        v55 = (v55 + v76) % 4294967296;
        v56 = (v56 + v74) % 4294967296;
        v57 = (v57 + v72) % 4294967296;
        v58 = (v58 + v71) % 4294967296;
        v59 = (v59 + v70) % 4294967296;
        v60 = (v60 + v73) % 4294967296;
    end;

    p47[1] = v53;
    p47[2] = v54;
    p47[3] = v55;
    p47[4] = v56;
    p47[5] = v57;
    p47[6] = v58;
    p47[7] = v59;
    p47[8] = v60;
end;

local function sha512_feed_128(p79, p80, p81, p82, p83) -- Line: 187
    -- upvalues: u9 (copy), u1 (copy), u2 (copy), bit32_rshift (copy), bit32_lshift (copy), bit32_bxor (copy), bit32_band (copy)
    local v84 = u9;
    local v85 = u1;
    local v86 = u2;
    local v87 = p79[1];
    local v88 = p79[2];
    local v89 = p79[3];
    local v90 = p79[4];
    local v91 = p79[5];
    local v92 = p79[6];
    local v93 = p79[7];
    local v94 = p79[8];
    local v95 = p80[1];
    local v96 = p80[2];
    local v97 = p80[3];
    local v98 = p80[4];
    local v99 = p80[5];
    local v100 = p80[6];
    local v101 = p80[7];
    local v102 = p80[8];

    for i = p82, p82 + p83 - 1, 128 do
        local v103 = i;
        local v104 = v103;
        local v105 = v103;
        v103 = v104;
        v105 = v104;

        for i2 = 1, 32 do
            v104 = v104 + 4;
            local string_byte_ret, v106, v107, v108 = string.byte(p81, v104 - 3, v104);
            v84[i2] = ((string_byte_ret * 256 + v106) * 256 + v107) * 256 + v108;
            local _ = i2;
        end;

        for i2 = 34, 160, 2 do
            local v109 = v84[i2 - 30];
            local v110 = v84[i2 - 31];
            local v111 = v84[i2 - 4];
            local v112 = v84[i2 - 5];
            local v113 = bit32_bxor(bit32_rshift(v109, 1) + bit32_lshift(v110, 31), bit32_rshift(v109, 8) + bit32_lshift(v110, 24), bit32_rshift(v109, 7) + bit32_lshift(v110, 25)) % 4294967296 + bit32_bxor(bit32_rshift(v111, 19) + bit32_lshift(v112, 13), bit32_lshift(v111, 3) + bit32_rshift(v112, 29), bit32_rshift(v111, 6) + bit32_lshift(v112, 26)) % 4294967296 + v84[i2 - 14] + v84[i2 - 32];
            local v114 = v113 % 4294967296;
            v84[i2 - 1] = bit32_bxor(bit32_rshift(v110, 1) + bit32_lshift(v109, 31), bit32_rshift(v110, 8) + bit32_lshift(v109, 24), (bit32_rshift(v110, 7))) + bit32_bxor(bit32_rshift(v112, 19) + bit32_lshift(v111, 13), bit32_lshift(v112, 3) + bit32_rshift(v111, 29), (bit32_rshift(v112, 6))) + v84[i2 - 15] + v84[i2 - 33] + (v113 - v114) / 4294967296;
            v84[i2] = v114;
            local _ = i2;
        end;

        local v115 = v88;
        local v116 = v90;
        local v117 = v102;
        local v118 = v93;
        local v119 = v92;
        local v120 = v99;
        local v121 = v98;
        local v122 = v96;
        local v123 = v95;
        local v124 = v87;
        local v125 = v89;
        local v126 = v101;
        local v127 = v100;
        local v128 = v91;
        local v129 = v94;
        local v130 = v97;

        for i2 = 1, 80 do
            local v131 = i2 * 2;
            local v132 = bit32_bxor(bit32_rshift(v91, 14) + bit32_lshift(v99, 18), bit32_rshift(v91, 18) + bit32_lshift(v99, 14), bit32_lshift(v91, 23) + bit32_rshift(v99, 9)) % 4294967296 + (bit32_band(v91, v92) + bit32_band(-1 - v91, v93)) % 4294967296 + v94 + v85[i2] + v84[v131];
            local v133 = v132 % 4294967296;
            local v134 = bit32_bxor(bit32_rshift(v99, 14) + bit32_lshift(v91, 18), bit32_rshift(v99, 18) + bit32_lshift(v91, 14), bit32_lshift(v99, 23) + bit32_rshift(v91, 9)) + bit32_band(v99, v100) + bit32_band(-1 - v99, v101) + v102 + v86[i2] + v84[v131 - 1] + (v132 - v133) / 4294967296;
            local v135 = v133 + v90;
            local v136 = v135 % 4294967296;
            local v137 = v134 + v98 + (v135 - v136) / 4294967296;
            local v138 = v133 + (bit32_band(v89, v88) + bit32_band(v87, (bit32_bxor(v89, v88)))) % 4294967296 + bit32_bxor(bit32_rshift(v87, 28) + bit32_lshift(v95, 4), bit32_lshift(v87, 30) + bit32_rshift(v95, 2), bit32_lshift(v87, 25) + bit32_rshift(v95, 7)) % 4294967296;
            local v139 = v138 % 4294967296;
            local v140 = v134 + (bit32_band(v97, v96) + bit32_band(v95, (bit32_bxor(v97, v96)))) + bit32_bxor(bit32_rshift(v95, 28) + bit32_lshift(v87, 4), bit32_lshift(v95, 30) + bit32_rshift(v87, 2), bit32_lshift(v95, 25) + bit32_rshift(v87, 7)) + (v138 - v139) / 4294967296;
            v94 = v93;
            v93 = v92;
            v92 = v91;
            v91 = v136;
            v98 = v97;
            v97 = v96;
            v96 = v95;
            v95 = v140;
            v90 = v89;
            v89 = v88;
            v88 = v87;
            v87 = v139;
            v102 = v101;
            v101 = v100;
            v100 = v99;
            v99 = v137;
            local _ = i2;
        end;

        local v141 = v124 + v87;
        v87 = v141 % 4294967296;
        v95 = (v123 + v95 + (v141 - v87) / 4294967296) % 4294967296;
        local v142 = v115 + v88;
        v88 = v142 % 4294967296;
        v96 = (v122 + v96 + (v142 - v88) / 4294967296) % 4294967296;
        local v143 = v125 + v89;
        v89 = v143 % 4294967296;
        v97 = (v130 + v97 + (v143 - v89) / 4294967296) % 4294967296;
        local v144 = v116 + v90;
        v90 = v144 % 4294967296;
        v98 = (v121 + v98 + (v144 - v90) / 4294967296) % 4294967296;
        local v145 = v128 + v91;
        v91 = v145 % 4294967296;
        v99 = (v120 + v99 + (v145 - v91) / 4294967296) % 4294967296;
        local v146 = v119 + v92;
        v92 = v146 % 4294967296;
        v100 = (v127 + v100 + (v146 - v92) / 4294967296) % 4294967296;
        local v147 = v118 + v93;
        v93 = v147 % 4294967296;
        v101 = (v126 + v101 + (v147 - v93) / 4294967296) % 4294967296;
        local v148 = v129 + v94;
        v94 = v148 % 4294967296;
        v102 = (v117 + v102 + (v148 - v94) / 4294967296) % 4294967296;
    end;

    p79[1] = v87;
    p79[2] = v88;
    p79[3] = v89;
    p79[4] = v90;
    p79[5] = v91;
    p79[6] = v92;
    p79[7] = v93;
    p79[8] = v94;
    p80[1] = v95;
    p80[2] = v96;
    p80[3] = v97;
    p80[4] = v98;
    p80[5] = v99;
    p80[6] = v100;
    p80[7] = v101;
    p80[8] = v102;
end;

local function sha1_feed_64(p149, p150, p151, p152) -- Line: 339
    -- upvalues: u9 (copy), bit32_bxor (copy), bit32_lrotate (copy), bit32_band (copy), bit32_rrotate (copy)
    local v153 = u9;
    local v154 = p149[1];
    local v155 = p149[2];
    local v156 = p149[3];
    local v157 = p149[4];
    local v158 = p149[5];

    for i = p151, p151 + p152 - 1, 64 do
        local v159 = i;
        local v160 = v159;
        local v161 = v159;
        v159 = v160;
        v161 = v160;

        for i2 = 1, 16 do
            v160 = v160 + 4;
            local string_byte_ret, v162, v163, v164 = string.byte(p150, v160 - 3, v160);
            v153[i2] = ((string_byte_ret * 256 + v162) * 256 + v163) * 256 + v164;
            local _ = i2;
        end;

        for i2 = 17, 80 do
            v153[i2] = bit32_lrotate(bit32_bxor(v153[i2 - 3], v153[i2 - 8], v153[i2 - 14], v153[i2 - 16]), 1);
            local _ = i2;
        end;

        local v165 = v157;
        local v166 = v156;
        local v167 = v155;
        local v168 = v154;
        local v169 = v158;

        for i2 = 1, 20 do
            local v170 = bit32_lrotate(v154, 5) + bit32_band(v155, v156) + bit32_band(-1 - v155, v157) + 1518500249 + v153[i2] + v158;
            local v171 = bit32_rrotate(v155, 2);
            v155 = v154;
            v154 = v170;
            v158 = v157;
            v157 = v156;
            v156 = v171;
            local _ = i2;
        end;

        for i2 = 21, 40 do
            local v172 = bit32_lrotate(v154, 5) + bit32_bxor(v155, v156, v157) + 1859775393 + v153[i2] + v158;
            local v173 = bit32_rrotate(v155, 2);
            v155 = v154;
            v154 = v172;
            v158 = v157;
            v157 = v156;
            v156 = v173;
            local _ = i2;
        end;

        for i2 = 41, 60 do
            local v174 = bit32_lrotate(v154, 5) + bit32_band(v157, v156) + bit32_band(v155, (bit32_bxor(v157, v156))) + 2400959708 + v153[i2] + v158;
            local v175 = bit32_rrotate(v155, 2);
            v155 = v154;
            v154 = v174;
            v158 = v157;
            v157 = v156;
            v156 = v175;
            local _ = i2;
        end;

        for i2 = 61, 80 do
            local v176 = bit32_lrotate(v154, 5) + bit32_bxor(v155, v156, v157) + 3395469782 + v153[i2] + v158;
            local v177 = bit32_rrotate(v155, 2);
            v155 = v154;
            v154 = v176;
            v158 = v157;
            v157 = v156;
            v156 = v177;
            local _ = i2;
        end;

        v154 = (v154 + v168) % 4294967296;
        v155 = (v155 + v167) % 4294967296;
        v156 = (v156 + v166) % 4294967296;
        v157 = (v157 + v165) % 4294967296;
        v158 = (v158 + v169) % 4294967296;
    end;

    p149[1] = v154;
    p149[2] = v155;
    p149[3] = v156;
    p149[4] = v157;
    p149[5] = v158;
end;

local function mul(p178, p179, p180, p181) -- Line: 628
    local table_create_ret = table.create(p181);
    local v182 = 0;
    local v183 = 1;
    local v184 = 0;

    for i = 1, p181 do
        local v185 = i;

        for i2 = math.max(1, i + 1 - #p179), math.min(i, #p178) do
            v182 = v182 + p180 * p178[i2] * p179[v185 + 1 - i2];
            local _ = i2;
        end;

        local v186 = v182 % 16777216;
        table_create_ret[v185] = math.floor(v186);
        v182 = (v182 - v186) / 16777216;
        v184 = v184 + v186 * v183;
        v183 = v183 * 16777216;
    end;

    return table_create_ret, v184;
end;

local v187 = { 1 };
local v188 = 0;

local function keccak_feed(p189, p190, p191, p192, p193, p194) -- Line: 401
    -- upvalues: u5 (copy), u6 (copy), bit32_bxor (copy), bit32_band (copy)
    local v195 = u5;
    local v196 = u6;
    local v197 = p194 / 8;

    for i = p192, p192 + p193 - 1, p194 do
        local v198 = i;
        local v199 = v198;
        local v200 = v198;
        v198 = v199;
        v200 = v199;

        for i2 = 1, v197 do
            local string_byte_ret, v201, v202, v203 = string.byte(p191, v199 + 1, v199 + 4);
            p189[i2] = bit32_bxor(p189[i2], ((v203 * 256 + v202) * 256 + v201) * 256 + string_byte_ret);
            v199 = v199 + 8;
            local string_byte_ret2, v204, v205, v206 = string.byte(p191, v199 - 3, v199);
            p190[i2] = bit32_bxor(p190[i2], ((v206 * 256 + v205) * 256 + v204) * 256 + string_byte_ret2);
            local _ = i2;
        end;

        local v207 = p189[1];
        local v208 = p190[1];
        local v209 = p189[2];
        local v210 = p190[2];
        local v211 = p189[3];
        local v212 = p190[3];
        local v213 = p189[4];
        local v214 = p190[4];
        local v215 = p189[5];
        local v216 = p190[5];
        local v217 = p189[6];
        local v218 = p190[6];
        local v219 = p189[7];
        local v220 = p190[7];
        local v221 = p189[8];
        local v222 = p190[8];
        local v223 = p189[9];
        local v224 = p190[9];
        local v225 = p189[10];
        local v226 = p190[10];
        local v227 = p189[11];
        local v228 = p190[11];
        local v229 = p189[12];
        local v230 = p190[12];
        local v231 = p189[13];
        local v232 = p190[13];
        local v233 = p189[14];
        local v234 = p190[14];
        local v235 = p189[15];
        local v236 = p190[15];
        local v237 = p189[16];
        local v238 = p190[16];
        local v239 = p189[17];
        local v240 = p190[17];
        local v241 = p189[18];
        local v242 = p190[18];
        local v243 = p189[19];
        local v244 = p190[19];
        local v245 = p189[20];
        local v246 = p190[20];
        local v247 = p189[21];
        local v248 = p190[21];
        local v249 = p189[22];
        local v250 = p190[22];
        local v251 = p189[23];
        local v252 = p190[23];
        local v253 = p189[24];
        local v254 = p190[24];
        local v255 = p189[25];
        local v256 = p190[25];

        for i2 = 1, 24 do
            local v257 = bit32_bxor(v207, v217, v227, v237, v247);
            local v258 = bit32_bxor(v208, v218, v228, v238, v248);
            local v259 = bit32_bxor(v209, v219, v229, v239, v249);
            local v260 = bit32_bxor(v210, v220, v230, v240, v250);
            local v261 = bit32_bxor(v211, v221, v231, v241, v251);
            local v262 = bit32_bxor(v212, v222, v232, v242, v252);
            local v263 = bit32_bxor(v213, v223, v233, v243, v253);
            local v264 = bit32_bxor(v214, v224, v234, v244, v254);
            local v265 = bit32_bxor(v215, v225, v235, v245, v255);
            local v266 = bit32_bxor(v216, v226, v236, v246, v256);
            local v267 = bit32_bxor(v257, v261 * 2 + (v262 % 4294967296 - v262 % 2147483648) / 2147483648);
            local v268 = bit32_bxor(v258, v262 * 2 + (v261 % 4294967296 - v261 % 2147483648) / 2147483648);
            local v269 = bit32_bxor(v267, v209);
            local v270 = bit32_bxor(v268, v210);
            local v271 = bit32_bxor(v267, v219);
            local v272 = bit32_bxor(v268, v220);
            local v273 = bit32_bxor(v267, v229);
            local v274 = bit32_bxor(v268, v230);
            local v275 = bit32_bxor(v267, v239);
            local v276 = bit32_bxor(v268, v240);
            local v277 = bit32_bxor(v267, v249);
            local v278 = bit32_bxor(v268, v250);
            local v279 = (v271 % 4294967296 - v271 % 1048576) / 1048576 + v272 * 4096;
            local v280 = (v272 % 4294967296 - v272 % 1048576) / 1048576 + v271 * 4096;
            local v281 = (v275 % 4294967296 - v275 % 524288) / 524288 + v276 * 8192;
            local v282 = (v276 % 4294967296 - v276 % 524288) / 524288 + v275 * 8192;
            local v283 = v269 * 2 + (v270 % 4294967296 - v270 % 2147483648) / 2147483648;
            local v284 = v270 * 2 + (v269 % 4294967296 - v269 % 2147483648) / 2147483648;
            local v285 = v273 * 1024 + (v274 % 4294967296 - v274 % 4194304) / 4194304;
            local v286 = v274 * 1024 + (v273 % 4294967296 - v273 % 4194304) / 4194304;
            local v287 = v277 * 4 + (v278 % 4294967296 - v278 % 1073741824) / 1073741824;
            local v288 = v278 * 4 + (v277 % 4294967296 - v277 % 1073741824) / 1073741824;
            local v289 = bit32_bxor(v259, v263 * 2 + (v264 % 4294967296 - v264 % 2147483648) / 2147483648);
            local v290 = bit32_bxor(v260, v264 * 2 + (v263 % 4294967296 - v263 % 2147483648) / 2147483648);
            local v291 = bit32_bxor(v289, v211);
            local v292 = bit32_bxor(v290, v212);
            local v293 = bit32_bxor(v289, v221);
            local v294 = bit32_bxor(v290, v222);
            local v295 = bit32_bxor(v289, v231);
            local v296 = bit32_bxor(v290, v232);
            local v297 = bit32_bxor(v289, v241);
            local v298 = bit32_bxor(v290, v242);
            local v299 = bit32_bxor(v289, v251);
            local v300 = bit32_bxor(v290, v252);
            local v301 = (v295 % 4294967296 - v295 % 2097152) / 2097152 + v296 * 2048;
            local v302 = (v296 % 4294967296 - v296 % 2097152) / 2097152 + v295 * 2048;
            local v303 = (v299 % 4294967296 - v299 % 8) / 8 + v300 * 536870912 % 4294967296;
            local v304 = (v300 % 4294967296 - v300 % 8) / 8 + v299 * 536870912 % 4294967296;
            local v305 = v293 * 64 + (v294 % 4294967296 - v294 % 67108864) / 67108864;
            local v306 = v294 * 64 + (v293 % 4294967296 - v293 % 67108864) / 67108864;
            local v307 = v297 * 32768 + (v298 % 4294967296 - v298 % 131072) / 131072;
            local v308 = v298 * 32768 + (v297 % 4294967296 - v297 % 131072) / 131072;
            local v309 = (v291 % 4294967296 - v291 % 4) / 4 + v292 * 1073741824 % 4294967296;
            local v310 = (v292 % 4294967296 - v292 % 4) / 4 + v291 * 1073741824 % 4294967296;
            local v311 = bit32_bxor(v261, v265 * 2 + (v266 % 4294967296 - v266 % 2147483648) / 2147483648);
            local v312 = bit32_bxor(v262, v266 * 2 + (v265 % 4294967296 - v265 % 2147483648) / 2147483648);
            local v313 = bit32_bxor(v311, v213);
            local v314 = bit32_bxor(v312, v214);
            local v315 = bit32_bxor(v311, v223);
            local v316 = bit32_bxor(v312, v224);
            local v317 = bit32_bxor(v311, v233);
            local v318 = bit32_bxor(v312, v234);
            local v319 = bit32_bxor(v311, v243);
            local v320 = bit32_bxor(v312, v244);
            local v321 = bit32_bxor(v311, v253);
            local v322 = bit32_bxor(v312, v254);
            local v323 = v319 * 2097152 % 4294967296 + (v320 % 4294967296 - v320 % 2048) / 2048;
            local v324 = v320 * 2097152 % 4294967296 + (v319 % 4294967296 - v319 % 2048) / 2048;
            local v325 = v313 * 268435456 % 4294967296 + (v314 % 4294967296 - v314 % 16) / 16;
            local v326 = v314 * 268435456 % 4294967296 + (v313 % 4294967296 - v313 % 16) / 16;
            local v327 = v317 * 33554432 % 4294967296 + (v318 % 4294967296 - v318 % 128) / 128;
            local v328 = v318 * 33554432 % 4294967296 + (v317 % 4294967296 - v317 % 128) / 128;
            local v329 = (v321 % 4294967296 - v321 % 256) / 256 + v322 * 16777216 % 4294967296;
            local v330 = (v322 % 4294967296 - v322 % 256) / 256 + v321 * 16777216 % 4294967296;
            local v331 = (v315 % 4294967296 - v315 % 512) / 512 + v316 * 8388608 % 4294967296;
            local v332 = (v316 % 4294967296 - v316 % 512) / 512 + v315 * 8388608 % 4294967296;
            local v333 = bit32_bxor(v263, v257 * 2 + (v258 % 4294967296 - v258 % 2147483648) / 2147483648);
            local v334 = bit32_bxor(v264, v258 * 2 + (v257 % 4294967296 - v257 % 2147483648) / 2147483648);
            local v335 = bit32_bxor(v333, v215);
            local v336 = bit32_bxor(v334, v216);
            local v337 = bit32_bxor(v333, v225);
            local v338 = bit32_bxor(v334, v226);
            local v339 = bit32_bxor(v333, v235);
            local v340 = bit32_bxor(v334, v236);
            local v341 = bit32_bxor(v333, v245);
            local v342 = bit32_bxor(v334, v246);
            local v343 = bit32_bxor(v333, v255);
            local v344 = bit32_bxor(v334, v256);
            local v345 = v343 * 16384 + (v344 % 4294967296 - v344 % 262144) / 262144;
            local v346 = v344 * 16384 + (v343 % 4294967296 - v343 % 262144) / 262144;
            local v347 = v337 * 1048576 % 4294967296 + (v338 % 4294967296 - v338 % 4096) / 4096;
            local v348 = v338 * 1048576 % 4294967296 + (v337 % 4294967296 - v337 % 4096) / 4096;
            local v349 = v341 * 256 + (v342 % 4294967296 - v342 % 16777216) / 16777216;
            local v350 = v342 * 256 + (v341 % 4294967296 - v341 % 16777216) / 16777216;
            local v351 = v335 * 134217728 % 4294967296 + (v336 % 4294967296 - v336 % 32) / 32;
            local v352 = v336 * 134217728 % 4294967296 + (v335 % 4294967296 - v335 % 32) / 32;
            local v353 = (v339 % 4294967296 - v339 % 33554432) / 33554432 + v340 * 128;
            local v354 = (v340 % 4294967296 - v340 % 33554432) / 33554432 + v339 * 128;
            local v355 = bit32_bxor(v265, v259 * 2 + (v260 % 4294967296 - v260 % 2147483648) / 2147483648);
            local v356 = bit32_bxor(v266, v260 * 2 + (v259 % 4294967296 - v259 % 2147483648) / 2147483648);
            local v357 = bit32_bxor(v355, v217);
            local v358 = bit32_bxor(v356, v218);
            local v359 = bit32_bxor(v355, v227);
            local v360 = bit32_bxor(v356, v228);
            local v361 = bit32_bxor(v355, v237);
            local v362 = bit32_bxor(v356, v238);
            local v363 = bit32_bxor(v355, v247);
            local v364 = bit32_bxor(v356, v248);
            local v365 = v359 * 8 + (v360 % 4294967296 - v360 % 536870912) / 536870912;
            local v366 = v360 * 8 + (v359 % 4294967296 - v359 % 536870912) / 536870912;
            local v367 = v363 * 262144 + (v364 % 4294967296 - v364 % 16384) / 16384;
            local v368 = v364 * 262144 + (v363 % 4294967296 - v363 % 16384) / 16384;
            local v369 = (v357 % 4294967296 - v357 % 268435456) / 268435456 + v358 * 16;
            local v370 = (v358 % 4294967296 - v358 % 268435456) / 268435456 + v357 * 16;
            local v371 = (v361 % 4294967296 - v361 % 8388608) / 8388608 + v362 * 512;
            local v372 = (v362 % 4294967296 - v362 % 8388608) / 8388608 + v361 * 512;
            local v373 = bit32_bxor(v355, v207);
            local v374 = bit32_bxor(v356, v208);
            local v375 = bit32_bxor(v373, (bit32_band(-1 - v279, v301)));
            v209 = bit32_bxor(v279, (bit32_band(-1 - v301, v323)));
            v211 = bit32_bxor(v301, (bit32_band(-1 - v323, v345)));
            v213 = bit32_bxor(v323, (bit32_band(-1 - v345, v373)));
            v215 = bit32_bxor(v345, (bit32_band(-1 - v373, v279)));
            local v376 = bit32_bxor(v374, (bit32_band(-1 - v280, v302)));
            v210 = bit32_bxor(v280, (bit32_band(-1 - v302, v324)));
            v212 = bit32_bxor(v302, (bit32_band(-1 - v324, v346)));
            v214 = bit32_bxor(v324, (bit32_band(-1 - v346, v374)));
            v216 = bit32_bxor(v346, (bit32_band(-1 - v374, v280)));
            v217 = bit32_bxor(v325, (bit32_band(-1 - v347, v365)));
            v219 = bit32_bxor(v347, (bit32_band(-1 - v365, v281)));
            v221 = bit32_bxor(v365, (bit32_band(-1 - v281, v303)));
            v223 = bit32_bxor(v281, (bit32_band(-1 - v303, v325)));
            v225 = bit32_bxor(v303, (bit32_band(-1 - v325, v347)));
            v218 = bit32_bxor(v326, (bit32_band(-1 - v348, v366)));
            v220 = bit32_bxor(v348, (bit32_band(-1 - v366, v282)));
            v222 = bit32_bxor(v366, (bit32_band(-1 - v282, v304)));
            v224 = bit32_bxor(v282, (bit32_band(-1 - v304, v326)));
            v226 = bit32_bxor(v304, (bit32_band(-1 - v326, v348)));
            v227 = bit32_bxor(v283, (bit32_band(-1 - v305, v327)));
            v229 = bit32_bxor(v305, (bit32_band(-1 - v327, v349)));
            v231 = bit32_bxor(v327, (bit32_band(-1 - v349, v367)));
            v233 = bit32_bxor(v349, (bit32_band(-1 - v367, v283)));
            v235 = bit32_bxor(v367, (bit32_band(-1 - v283, v305)));
            v228 = bit32_bxor(v284, (bit32_band(-1 - v306, v328)));
            v230 = bit32_bxor(v306, (bit32_band(-1 - v328, v350)));
            v232 = bit32_bxor(v328, (bit32_band(-1 - v350, v368)));
            v234 = bit32_bxor(v350, (bit32_band(-1 - v368, v284)));
            v236 = bit32_bxor(v368, (bit32_band(-1 - v284, v306)));
            v237 = bit32_bxor(v351, (bit32_band(-1 - v369, v285)));
            v239 = bit32_bxor(v369, (bit32_band(-1 - v285, v307)));
            v241 = bit32_bxor(v285, (bit32_band(-1 - v307, v329)));
            v243 = bit32_bxor(v307, (bit32_band(-1 - v329, v351)));
            v245 = bit32_bxor(v329, (bit32_band(-1 - v351, v369)));
            v238 = bit32_bxor(v352, (bit32_band(-1 - v370, v286)));
            v240 = bit32_bxor(v370, (bit32_band(-1 - v286, v308)));
            v242 = bit32_bxor(v286, (bit32_band(-1 - v308, v330)));
            v244 = bit32_bxor(v308, (bit32_band(-1 - v330, v352)));
            v246 = bit32_bxor(v330, (bit32_band(-1 - v352, v370)));
            v247 = bit32_bxor(v309, (bit32_band(-1 - v331, v353)));
            v249 = bit32_bxor(v331, (bit32_band(-1 - v353, v371)));
            v251 = bit32_bxor(v353, (bit32_band(-1 - v371, v287)));
            v253 = bit32_bxor(v371, (bit32_band(-1 - v287, v309)));
            v255 = bit32_bxor(v287, (bit32_band(-1 - v309, v331)));
            v248 = bit32_bxor(v310, (bit32_band(-1 - v332, v354)));
            v250 = bit32_bxor(v332, (bit32_band(-1 - v354, v372)));
            v252 = bit32_bxor(v354, (bit32_band(-1 - v372, v288)));
            v254 = bit32_bxor(v372, (bit32_band(-1 - v288, v310)));
            v256 = bit32_bxor(v288, (bit32_band(-1 - v310, v332)));
            v207 = bit32_bxor(v375, v195[i2]);
            v208 = v376 + v196[i2];
            local _ = i2;
        end;

        p189[1] = v207;
        p190[1] = v208;
        p189[2] = v209;
        p190[2] = v210;
        p189[3] = v211;
        p190[3] = v212;
        p189[4] = v213;
        p190[4] = v214;
        p189[5] = v215;
        p190[5] = v216;
        p189[6] = v217;
        p190[6] = v218;
        p189[7] = v219;
        p190[7] = v220;
        p189[8] = v221;
        p190[8] = v222;
        p189[9] = v223;
        p190[9] = v224;
        p189[10] = v225;
        p190[10] = v226;
        p189[11] = v227;
        p190[11] = v228;
        p189[12] = v229;
        p190[12] = v230;
        p189[13] = v231;
        p190[13] = v232;
        p189[14] = v233;
        p190[14] = v234;
        p189[15] = v235;
        p190[15] = v236;
        p189[16] = v237;
        p190[16] = v238;
        p189[17] = v239;
        p190[17] = v240;
        p189[18] = v241;
        p190[18] = v242;
        p189[19] = v243;
        p190[19] = v244;
        p189[20] = v245;
        p190[20] = v246;
        p189[21] = v247;
        p190[21] = v248;
        p189[22] = v249;
        p190[22] = v250;
        p189[23] = v251;
        p190[23] = v252;
        p189[24] = v253;
        p190[24] = v254;
        p189[25] = v255;
        p190[25] = v256;
    end;
end;

while true do
    v12 = v12 + v13[v12 % 6];
    local v377 = 1;
    v377 = v377 + v13[v377 % 6];

    if v12 < v377 * v377 then
        local v378 = v12 ^ 0.3333333333333333;
        local v379 = mul(table.create(1, (math.floor(v378 * 1099511627776))), v187, 1, 2);
        local _, v380 = mul(v379, mul(v379, v379, 1, 4), -1, 4);
        local v381 = v379[2] % 65536 * 65536 + math.floor(v379[1] / 256);
        local v382 = v379[1] % 256 * 16777216 + math.floor(v380 * 4.625929269271485e-18 * v378 / v12);

        if v188 < 16 then
            local math_sqrt_ret = math.sqrt(v12);
            local v383 = mul(table.create(1, (math.floor(math_sqrt_ret * 1099511627776))), v187, 1, 2);
            local _, v384 = mul(v383, v383, -1, 2);
            local v385 = v383[2] % 65536 * 65536 + math.floor(v383[1] / 256);
            local v386 = v383[1] % 256 * 16777216 + math.floor(v384 * 7.62939453125e-6 / math_sqrt_ret);
            local v387 = v188 % 8 + 1;
            u46[224][v387] = v386;
            v10[v387] = v385;
            v11[v387] = v386 + v385 * 0;

            if v387 > 7 then
                v10 = u44[384];
                v11 = u45[384];
            end;
        end;

        v188 = v188 + 1;
        u2[v188] = v381;
        u1[v188] = v382 % 4294967296 + v381 * 0;
    elseif v12 % v377 == 0 then
    else
        continue;
    end;

    if v188 > 79 then
        for i = 224, 256, 32 do
            local v388 = i;
            local v389 = {};
            local v390 = {};

            for i2 = 1, 8 do
                v389[i2] = bit32_bxor(v3[i2], 2779096485) % 4294967296;
                v390[i2] = bit32_bxor(v4[i2], 2779096485) % 4294967296;
                local _ = i2;
            end;

            sha512_feed_128(v389, v390, "SHA-512/" .. tostring(v388) .. "\128" .. string.rep("\0", 115) .. "X", 0, 128);
            u45[v388] = v389;
            u44[v388] = v390;
        end;

        for i = 1, 64 do
            local math_sin_ret = math.sin(i);
            local v391 = math.abs(math_sin_ret) * 65536;
            local math_modf_ret, v392 = math.modf(v391);
            u7[i] = math_modf_ret * 65536 + math.floor(v392 * 65536);
            local _ = i;
        end;

        local u393 = 29;

        local function next_bit() -- Line: 720
            -- upvalues: u393 (ref), bit32_bxor (copy)
            local v394 = u393 % 2;
            u393 = bit32_bxor((u393 - v394) / 2, v394 * 142);

            return v394;
        end;

        for i = 1, 24 do
            local v395 = i;
            local v396 = nil;
            local v397 = 0;

            for i2 = 1, 6 do
                v396 = v396 and v396 * v396 * 2 or 1;
                local v398 = u393 % 2;
                u393 = bit32_bxor((u393 - v398) / 2, v398 * 142);
                v397 = v397 + v398 * v396;
                local _ = i2;
            end;

            local v399 = u393 % 2;
            u393 = bit32_bxor((u393 - v399) / 2, v399 * 142);
            local v400 = v399 * v396;
            u6[v395] = v400;
            u5[v395] = v397 + v400 * 0;
        end;

        local function HexToBinFunction(p401) -- Line: 1153
            local v402 = tonumber(p401, 16);

            return string.char(v402);
        end;

        local u403 = {
            ["+"] = 62,
            ["-"] = 62,
            [62] = "+",
            ["/"] = 63,
            _ = 63,
            [63] = "/",
            ["="] = -1,
            ["."] = -1,
            [-1] = "="
        };
        local v404 = 0;

        local function keccak(u405, u406, u407, p408) -- Line: 1010
            -- upvalues: keccak_feed (copy)
            if type(u406) ~= "number" then
                error("Argument \'digest_size_in_bytes\' must be a number", 2);
            end;

            local u409 = "";
            local table_create_ret = table.create(25, 0);
            local table_create_ret2 = table.create(25, 0);
            local u410 = nil;

            local function partial(p411) -- Line: 1036
                -- upvalues: u409 (ref), u405 (copy), keccak_feed (ref), table_create_ret (copy), table_create_ret2 (copy), partial (copy), u407 (copy), u406 (copy), u410 (ref)
                if not p411 then
                    if u409 then
                        local v412 = u407 and 31 or 6;
                        u409 = u409 .. (#u409 + 1 == u405 and string.char(v412 + 128) or string.char(v412) .. string.rep("\0", (-2 - #u409) % u405) .. "\128");
                        keccak_feed(table_create_ret, table_create_ret2, u409, 0, #u409, u405);
                        u409 = nil;
                        local u413 = 0;
                        local math_floor_ret = math.floor(u405 / 8);
                        local u414 = {};

                        local function get_next_qwords_of_digest(p415) -- Line: 1067
                            -- upvalues: u413 (ref), math_floor_ret (copy), keccak_feed (ref), table_create_ret (ref), table_create_ret2 (ref), u414 (copy)
                            if math_floor_ret <= u413 then
                                keccak_feed(table_create_ret, table_create_ret2, "\0\0\0\0\0\0\0\0", 0, 8, 8);
                                u413 = 0;
                            end;

                            local math_min_ret = math.min(p415, math_floor_ret - u413);
                            local math_floor_ret2 = math.floor(math_min_ret);

                            for i = 1, math_floor_ret2 do
                                u414[i] = string.format("%08x", table_create_ret2[u413 + i] % 4294967296) .. string.format("%08x", table_create_ret[u413 + i] % 4294967296);
                                local _ = i;
                            end;

                            u413 = u413 + math_floor_ret2;

                            return string.gsub(table.concat(u414, "", 1, math_floor_ret2), "(..)(..)(..)(..)(..)(..)(..)(..)", "%8%7%6%5%4%3%2%1"), math_floor_ret2 * 8;
                        end;

                        local u416 = {};
                        local u417 = "";
                        local u418 = 0;

                        local function get_next_part_of_digest(p419) -- Line: 1094
                            -- upvalues: u418 (ref), u417 (ref), u416 (copy), get_next_qwords_of_digest (copy), get_next_part_of_digest (copy)
                            local v420 = p419 or 1;

                            if v420 > u418 then
                                local v421;

                                if u418 > 0 then
                                    v421 = 1;
                                    u416[v421] = u417;
                                    v420 = v420 - u418;
                                else
                                    v421 = 0;
                                end;

                                while v420 >= 8 do
                                    local v422, v423 = get_next_qwords_of_digest(v420 / 8);
                                    v421 = v421 + 1;
                                    u416[v421] = v422;
                                    v420 = v420 - v423;
                                end;

                                if v420 > 0 then
                                    local v424, v425 = get_next_qwords_of_digest(1);
                                    u417 = v424;
                                    u418 = v425;
                                    v421 = v421 + 1;
                                    u416[v421] = get_next_part_of_digest(v420);
                                else
                                    u417 = "";
                                    u418 = 0;
                                end;

                                return table.concat(u416, "", 1, v421);
                            end;

                            u418 = u418 - v420;
                            local v426 = v420 * 2;
                            local string_sub_ret = string.sub(u417, 1, v426);
                            u417 = string.sub(u417, v426 + 1);

                            return string_sub_ret;
                        end;

                        if u406 < 0 then
                            u410 = get_next_part_of_digest;
                        else
                            u410 = get_next_part_of_digest(u406);
                        end;
                    end;

                    return u410;
                end;

                local v427 = #p411;

                if u409 then
                    local v428;

                    if u409 == "" or u405 > #u409 + v427 then
                        v428 = 0;
                    else
                        v428 = u405 - #u409;
                        keccak_feed(table_create_ret, table_create_ret2, u409 .. string.sub(p411, 1, v428), 0, u405, u405);
                        u409 = "";
                    end;

                    local v429 = v427 - v428;
                    local v430 = v429 % u405;
                    keccak_feed(table_create_ret, table_create_ret2, p411, v428, v429 - v430, u405);
                    u409 = u409 .. string.sub(p411, v427 + 1 - v430);

                    return partial;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p408 then
                return partial(p408)();
            end;

            return partial;
        end;

        local function hex2bin(p431) -- Line: 1157
            -- upvalues: HexToBinFunction (copy)
            return string.gsub(p431, "%x%x", HexToBinFunction);
        end;

        local function md5(p432) -- Line: 883
            -- upvalues: u14 (copy), md5_feed_64 (copy)
            local table_create_ret = table.create(4);
            local u433 = 0;
            local u434 = "";
            local v435 = u14[2];
            local v436 = u14[3];
            local v437 = u14[4];
            table_create_ret[1] = u14[1];
            table_create_ret[2] = v435;
            table_create_ret[3] = v436;
            table_create_ret[4] = v437;

            local function u444(p438) -- Line: 889
                -- upvalues: u434 (ref), u433 (ref), md5_feed_64 (ref), table_create_ret (ref), u444 (copy)
                if not p438 then
                    if u434 then
                        local table_create_ret2 = table.create(11);
                        table_create_ret2[1] = u434;
                        table_create_ret2[2] = "\128";
                        table_create_ret2[3] = string.rep("\0", (-9 - u433) % 64);
                        u434 = nil;
                        u433 = u433 * 8;

                        for i = 4, 11 do
                            local v439 = u433 % 256;
                            table_create_ret2[i] = string.char(v439);
                            u433 = (u433 - v439) / 256;
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret2);
                        md5_feed_64(table_create_ret, table_concat_ret, 0, #table_concat_ret);

                        for i = 1, 4 do
                            table_create_ret[i] = string.format("%08x", table_create_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_create_ret = string.gsub(table.concat(table_create_ret), "(..)(..)(..)(..)", "%4%3%2%1");
                    end;

                    return table_create_ret;
                end;

                local v440 = #p438;

                if u434 then
                    u433 = u433 + v440;
                    local v441;

                    if u434 == "" or #u434 + v440 < 64 then
                        v441 = 0;
                    else
                        v441 = 64 - #u434;
                        md5_feed_64(table_create_ret, u434 .. string.sub(p438, 1, v441), 0, 64);
                        u434 = "";
                    end;

                    local v442 = v440 - v441;
                    local v443 = v442 % 64;
                    md5_feed_64(table_create_ret, p438, v441, v442 - v443);
                    u434 = u434 .. string.sub(p438, v440 + 1 - v443);

                    return u444;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p432 then
                return u444(p432)();
            end;

            return u444;
        end;

        local function sha1(p445) -- Line: 947
            -- upvalues: u14 (copy), sha1_feed_64 (copy)
            local table_pack_ret = table.pack(table.unpack(u14));
            local u446 = 0;
            local u447 = "";

            local function u453(p448) -- Line: 951
                -- upvalues: u447 (ref), u446 (ref), sha1_feed_64 (ref), table_pack_ret (ref), u453 (copy)
                if not p448 then
                    if u447 then
                        local table_create_ret = table.create(10);
                        table_create_ret[1] = u447;
                        table_create_ret[2] = "\128";
                        table_create_ret[3] = string.rep("\0", (-9 - u446) % 64 + 1);
                        u447 = nil;
                        u446 = u446 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u446 = u446 % 1 * 256;
                            local math_floor_ret = math.floor(u446);
                            table_create_ret[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret);
                        sha1_feed_64(table_pack_ret, table_concat_ret, 0, #table_concat_ret);

                        for i = 1, 5 do
                            table_pack_ret[i] = string.format("%08x", table_pack_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_pack_ret = table.concat(table_pack_ret);
                    end;

                    return table_pack_ret;
                end;

                local v449 = #p448;

                if u447 then
                    u446 = u446 + v449;
                    local v450;

                    if u447 == "" or #u447 + v449 < 64 then
                        v450 = 0;
                    else
                        v450 = 64 - #u447;
                        sha1_feed_64(table_pack_ret, u447 .. string.sub(p448, 1, v450), 0, 64);
                        u447 = "";
                    end;

                    local v451 = v449 - v450;
                    local v452 = v451 % 64;
                    sha1_feed_64(table_pack_ret, p448, v450, v451 - v452);
                    u447 = u447 .. string.sub(p448, v449 + 1 - v452);

                    return u453;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p445 then
                return u453(p445)();
            end;

            return u453;
        end;

        local function sha256ext(u454, p455) -- Line: 741
            -- upvalues: u46 (copy), sha256_feed_64 (copy)
            local v456 = u46[u454];
            local u457 = 0;
            local u458 = "";
            local table_create_ret = table.create(8);
            local v459 = v456[2];
            local v460 = v456[3];
            local v461 = v456[4];
            local v462 = v456[5];
            local v463 = v456[6];
            local v464 = v456[7];
            local v465 = v456[8];
            table_create_ret[1] = v456[1];
            table_create_ret[2] = v459;
            table_create_ret[3] = v460;
            table_create_ret[4] = v461;
            table_create_ret[5] = v462;
            table_create_ret[6] = v463;
            table_create_ret[7] = v464;
            table_create_ret[8] = v465;

            local function u472(p466) -- Line: 748
                -- upvalues: u458 (ref), u457 (ref), sha256_feed_64 (ref), table_create_ret (ref), u472 (copy), u454 (copy)
                if not p466 then
                    if u458 then
                        local table_create_ret2 = table.create(10);
                        table_create_ret2[1] = u458;
                        table_create_ret2[2] = "\128";
                        table_create_ret2[3] = string.rep("\0", (-9 - u457) % 64 + 1);
                        u458 = nil;
                        u457 = u457 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u457 = u457 % 1 * 256;
                            local math_floor_ret = math.floor(u457);
                            table_create_ret2[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret2);
                        sha256_feed_64(table_create_ret, table_concat_ret, 0, #table_concat_ret);
                        local v467 = u454 / 32;

                        for i = 1, v467 do
                            table_create_ret[i] = string.format("%08x", table_create_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_create_ret = table.concat(table_create_ret, "", 1, v467);
                    end;

                    return table_create_ret;
                end;

                local v468 = #p466;

                if u458 then
                    u457 = u457 + v468;
                    local v469;

                    if u458 == "" or #u458 + v468 < 64 then
                        v469 = 0;
                    else
                        v469 = 64 - #u458;
                        sha256_feed_64(table_create_ret, u458 .. string.sub(p466, 1, v469), 0, 64);
                        u458 = "";
                    end;

                    local v470 = v468 - v469;
                    local v471 = v470 % 64;
                    sha256_feed_64(table_create_ret, p466, v469, v470 - v471);
                    u458 = u458 .. string.sub(p466, v468 + 1 - v471);

                    return u472;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p455 then
                return u472(p455)();
            end;

            return u472;
        end;

        local function sha512ext(u473, p474) -- Line: 809
            -- upvalues: u45 (copy), u44 (copy), sha512_feed_128 (copy)
            local u475 = 0;
            local u476 = "";
            local table_pack_ret = table.pack(table.unpack(u45[u473]));
            local table_pack_ret2 = table.pack(table.unpack(u44[u473]));

            local function u482(p477) -- Line: 814
                -- upvalues: u476 (ref), u475 (ref), sha512_feed_128 (ref), table_pack_ret (ref), table_pack_ret2 (ref), u482 (copy), u473 (copy)
                if not p477 then
                    if u476 then
                        local table_create_ret = table.create(10);
                        table_create_ret[1] = u476;
                        table_create_ret[2] = "\128";
                        table_create_ret[3] = string.rep("\0", (-17 - u475) % 128 + 9);
                        u476 = nil;
                        u475 = u475 * 1.1102230246251565e-16;

                        for i = 4, 10 do
                            u475 = u475 % 1 * 256;
                            local math_floor_ret = math.floor(u475);
                            table_create_ret[i] = string.char(math_floor_ret);
                            local _ = i;
                        end;

                        local table_concat_ret = table.concat(table_create_ret);
                        sha512_feed_128(table_pack_ret, table_pack_ret2, table_concat_ret, 0, #table_concat_ret);
                        local math_ceil_ret = math.ceil(u473 / 64);

                        for i = 1, math_ceil_ret do
                            table_pack_ret[i] = string.format("%08x", table_pack_ret2[i] % 4294967296) .. string.format("%08x", table_pack_ret[i] % 4294967296);
                            local _ = i;
                        end;

                        table_pack_ret2 = nil;
                        local table_concat_ret2 = table.concat(table_pack_ret, "", 1, math_ceil_ret);
                        table_pack_ret = string.sub(table_concat_ret2, 1, u473 / 4);
                    end;

                    return table_pack_ret;
                end;

                local v478 = #p477;

                if u476 then
                    u475 = u475 + v478;
                    local v479;

                    if u476 == "" or #u476 + v478 < 128 then
                        v479 = 0;
                    else
                        v479 = 128 - #u476;
                        sha512_feed_128(table_pack_ret, table_pack_ret2, u476 .. string.sub(p477, 1, v479), 0, 128);
                        u476 = "";
                    end;

                    local v480 = v478 - v479;
                    local v481 = v480 % 128;
                    sha512_feed_128(table_pack_ret, table_pack_ret2, p477, v479, v480 - v481);
                    u476 = u476 .. string.sub(p477, v478 + 1 - v481);

                    return u482;
                end;

                error("Adding more chunks is not allowed after receiving the result", 2);
            end;

            if p474 then
                return u482(p474)();
            end;

            return u482;
        end;

        for _, v in l_ipairs({ "AZ", "az", "09" }) do
            for i = string.byte(v), string.byte(v, 2) do
                local string_char_ret = string.char(i);
                u403[string_char_ret] = v404;
                u403[v404] = string_char_ret;
                v404 = v404 + 1;
                local _ = i;
            end;
        end;

        local function pad_and_xor(p483, p484, u485) -- Line: 1218
            -- upvalues: bit32_bxor (copy)
            return string.gsub(p483, ".", function(p486) -- Line: 1219
                -- upvalues: u485 (copy), bit32_bxor (ref)
                local v487 = bit32_bxor(string.byte(p486), u485);

                return string.char(v487);
            end) .. string.rep(string.char(u485), p484 - #p483);
        end;

        local u488 = {};

        local function base642bin(p489) -- Line: 1194
            -- upvalues: u403 (copy)
            local v490 = 3;
            local v491 = {};

            for i, v in string.gmatch(string.gsub(p489, "%s+", ""), "()(.)") do
                local v492 = u403[v];

                if v492 < 0 then
                    v490 = v490 - 1;
                    v492 = 0;
                end;

                local v493 = i % 4;

                if v493 > 0 then
                    v491[-v493] = v492;
                else
                    local v494 = v491[-1] * 4 + math.floor(v491[-2] / 16);
                    local v495 = v491[-2] % 16 * 16 + math.floor(v491[-3] / 4);
                    local string_char_ret = string.char(v494, v495, v491[-3] % 4 * 64 + v492);
                    v491[#v491 + 1] = string.sub(string_char_ret, 1, v490);
                end;
            end;

            return table.concat(v491);
        end;

        local function bin2base64(p496) -- Line: 1177
            -- upvalues: u403 (copy)
            local table_create_ret = table.create((math.ceil(#p496 / 3)));
            local v497 = 0;

            for i = 1, #p496, 3 do
                local v498 = string.sub(p496, i, i + 2) .. "\0";
                local string_byte_ret, v499, v500, v501 = string.byte(v498, 1, -1);
                v497 = v497 + 1;
                table_create_ret[v497] = u403[math.floor(string_byte_ret / 4)] .. u403[string_byte_ret % 4 * 16 + math.floor(v499 / 16)] .. u403[v500 and (v499 % 16 * 4 + math.floor(v500 / 64) or -1) or -1] .. u403[v501 and v500 % 64 or -1];
                local _ = i;
            end;

            return table.concat(table_create_ret);
        end;

        local u502 = nil;

        for i = 0, 255 do
            u488[string.format("%02x", i)] = string.char(i);
            local _ = i;
        end;

        local v536 = {
            md5 = md5,
            sha1 = sha1,

            sha224 = function(p503) -- Line: 1273, Name: sha224
                -- upvalues: sha256ext (copy)
                return sha256ext(224, p503);
            end,

            sha256 = function(p504) -- Line: 1277, Name: sha256
                -- upvalues: sha256ext (copy)
                return sha256ext(256, p504);
            end,

            sha512_224 = function(p505) -- Line: 1281, Name: sha512_224
                -- upvalues: sha512ext (copy)
                return sha512ext(224, p505);
            end,

            sha512_256 = function(p506) -- Line: 1285, Name: sha512_256
                -- upvalues: sha512ext (copy)
                return sha512ext(256, p506);
            end,

            sha384 = function(p507) -- Line: 1289, Name: sha384
                -- upvalues: sha512ext (copy)
                return sha512ext(384, p507);
            end,

            sha512 = function(p508) -- Line: 1293, Name: sha512
                -- upvalues: sha512ext (copy)
                return sha512ext(512, p508);
            end,

            sha3_224 = function(p509) -- Line: 1298, Name: sha3_224
                -- upvalues: keccak (copy)
                return keccak(144, 28, false, p509);
            end,

            sha3_256 = function(p510) -- Line: 1302, Name: sha3_256
                -- upvalues: keccak (copy)
                return keccak(136, 32, false, p510);
            end,

            sha3_384 = function(p511) -- Line: 1306, Name: sha3_384
                -- upvalues: keccak (copy)
                return keccak(104, 48, false, p511);
            end,

            sha3_512 = function(p512) -- Line: 1310, Name: sha3_512
                -- upvalues: keccak (copy)
                return keccak(72, 64, false, p512);
            end,

            shake128 = function(p513, p514) -- Line: 1314, Name: shake128
                -- upvalues: keccak (copy)
                return keccak(168, p514, true, p513);
            end,

            shake256 = function(p515, p516) -- Line: 1318, Name: shake256
                -- upvalues: keccak (copy)
                return keccak(136, p516, true, p515);
            end,

            hmac = function(u517, u518, p519, p520) -- Line: 1231, Name: hmac
                -- upvalues: u502 (ref), HexToBinFunction (copy), bit32_bxor (copy), u488 (copy)
                local u521 = u502[u517];

                if not u521 then
                    error("Unknown hash function", 2);
                end;

                if u521 < #u518 then
                    u518 = string.gsub(u517(u518), "%x%x", HexToBinFunction);
                end;

                local v522 = u518;
                local u523 = 54;
                local u526 = u517()(string.gsub(v522, ".", function(p524) -- Line: 1219
                    -- upvalues: u523 (copy), bit32_bxor (ref)
                    local v525 = bit32_bxor(string.byte(p524), u523);

                    return string.char(v525);
                end) .. string.rep("6", u521 - #v522));
                local u527 = nil;

                local function u534(p528) -- Line: 1246
                    -- upvalues: u527 (ref), u517 (copy), u518 (ref), u521 (copy), bit32_bxor (ref), u526 (copy), HexToBinFunction (ref), u534 (copy)
                    if not p528 then
                        local v529 = u527;

                        if not v529 then
                            local v530 = u518;
                            local u531 = 92;
                            v529 = u517((string.gsub(v530, ".", function(p532) -- Line: 1219
                                -- upvalues: u531 (copy), bit32_bxor (ref)
                                local v533 = bit32_bxor(string.byte(p532), u531);

                                return string.char(v533);
                            end) .. string.rep("\\", u521 - #v530)) .. string.gsub(u526(), "%x%x", HexToBinFunction));
                        end;

                        u527 = v529;

                        return u527;
                    end;

                    if not u527 then
                        u526(p528);

                        return u534;
                    end;

                    error("Adding more chunks is not allowed after receiving the result", 2);
                end;

                if not p519 then
                    return u534;
                end;

                local v535 = u534(p519)();

                if p520 then
                    v535 = string.gsub(v535, "%x%x", u488) or v535;
                end;

                return v535;
            end,

            hex_to_bin = hex2bin,
            base64_to_bin = base642bin,
            bin_to_base64 = bin2base64,
            base64_encode = script_Base64.Encode,
            base64_decode = script_Base64.Decode
        };
        u502 = {
            [v536.md5] = 64,
            [v536.sha1] = 64,
            [v536.sha224] = 64,
            [v536.sha256] = 64,
            [v536.sha512_224] = 128,
            [v536.sha512_256] = 128,
            [v536.sha384] = 128,
            [v536.sha512] = 128,
            [v536.sha3_224] = 144,
            [v536.sha3_256] = 136,
            [v536.sha3_384] = 104,
            [v536.sha3_512] = 72
        };

        return v536;
    end;
end;