 
 

local v1 = {};

local function linear(p2, p3, p4, p5) -- Line: 5
    return p4 * p2 / p5 + p3;
end;

function v1.Linear(p6) -- Line: 9
    return 1 * p6 / 1 + 0;
end;

local function constant(p7, p8, p9, p10) -- Line: 13
    return p7 == p10 and 1 or 0;
end;

function v1.Constant(p11) -- Line: 17
    return p11 == 1 and 1 or 0;
end;

local function inSine(p12, p13, p14, p15) -- Line: 21
    return -p14 * math.cos(p12 / p15 * 1.5707963267948966) + p14 + p13;
end;

local function outSine(p16, p17, p18, p19) -- Line: 24
    return p18 * math.sin(p16 / p19 * 1.5707963267948966) + p17;
end;

local function inOutSine(p20, p21, p22, p23) -- Line: 27
    return -p22 / 2 * (math.cos(3.141592653589793 * p20 / p23) - 1) + p21;
end;

local function outInSine(p24, p25, p26, p27) -- Line: 30
    if p24 < p27 / 2 then
        return p26 / 2 * math.sin(p24 * 2 / p27 * 1.5707963267948966) + p25;
    end;

    local v28 = p26 / 2;

    return -v28 * math.cos((p24 * 2 - p27) / p27 * 1.5707963267948966) + v28 + (p25 + p26 / 2);
end;

function v1.SineIn(p29) -- Line: 38
    return -1 * math.cos(p29 / 1 * 1.5707963267948966) + 1 + 0;
end;

function v1.SineOut(p30) -- Line: 41
    return 1 * math.sin(p30 / 1 * 1.5707963267948966) + 0;
end;

function v1.SineInOut(p31) -- Line: 44
    return -0.5 * (math.cos(3.141592653589793 * p31 / 1) - 1) + 0;
end;

function v1.SineOutIn(p32) -- Line: 47
    if p32 < 0.5 then
        return 0.5 * math.sin(p32 * 2 / 1 * 1.5707963267948966) + 0;
    end;

    return -0.5 * math.cos((p32 * 2 - 1) / 1 * 1.5707963267948966) + 0.5 + 0.5;
end;

local function inQuad(p33, p34, p35, p36) -- Line: 51
    return p35 * math.pow(p33 / p36, 2) + p34;
end;

local function outQuad(p37, p38, p39, p40) -- Line: 55
    local v41 = p37 / p40;

    return -p39 * v41 * (v41 - 2) + p38;
end;

local function inOutQuad(p42, p43, p44, p45) -- Line: 59
    local v46 = p42 / p45 * 2;

    if v46 < 1 then
        return p44 / 2 * math.pow(v46, 2) + p43;
    end;

    return -p44 / 2 * ((v46 - 1) * (v46 - 3) - 1) + p43;
end;

local function outInQuad(p47, p48, p49, p50) -- Line: 67
    if p47 >= p50 / 2 then
        return p49 / 2 * math.pow((p47 * 2 - p50) / p50, 2) + (p48 + p49 / 2);
    end;

    local v51 = p47 * 2 / p50;

    return -(p49 / 2) * v51 * (v51 - 2) + p48;
end;

function v1.QuadIn(p52) -- Line: 75
    return 1 * math.pow(p52 / 1, 2) + 0;
end;

function v1.QuadOut(p53) -- Line: 78
    local v54 = p53 / 1;

    return -1 * v54 * (v54 - 2) + 0;
end;

function v1.QuadInOut(p55) -- Line: 81
    local v56 = p55 / 1 * 2;

    if v56 < 1 then
        return 0.5 * math.pow(v56, 2) + 0;
    end;

    return -0.5 * ((v56 - 1) * (v56 - 3) - 1) + 0;
end;

function v1.QuadOutIn(p57) -- Line: 84
    if p57 >= 0.5 then
        return 0.5 * math.pow((p57 * 2 - 1) / 1, 2) + 0.5;
    end;

    local v58 = p57 * 2 / 1;

    return -0.5 * v58 * (v58 - 2) + 0;
end;

local function inCubic(p59, p60, p61, p62) -- Line: 88
    return p61 * math.pow(p59 / p62, 3) + p60;
end;

local function outCubic(p63, p64, p65, p66) -- Line: 92
    return p65 * (math.pow(p63 / p66 - 1, 3) + 1) + p64;
end;

local function inOutCubic(p67, p68, p69, p70) -- Line: 96
    local v71 = p67 / p70 * 2;

    if v71 < 1 then
        return p69 / 2 * v71 * v71 * v71 + p68;
    end;

    local v72 = v71 - 2;

    return p69 / 2 * (v72 * v72 * v72 + 2) + p68;
end;

local function outInCubic(p73, p74, p75, p76) -- Line: 105
    if p73 < p76 / 2 then
        return p75 / 2 * (math.pow(p73 * 2 / p76 - 1, 3) + 1) + p74;
    end;

    return p75 / 2 * math.pow((p73 * 2 - p76) / p76, 3) + (p74 + p75 / 2);
end;

function v1.CubicIn(p77) -- Line: 113
    return 1 * math.pow(p77 / 1, 3) + 0;
end;

function v1.CubicOut(p78) -- Line: 116
    return 1 * (math.pow(p78 / 1 - 1, 3) + 1) + 0;
end;

function v1.CubicInOut(p79) -- Line: 119
    local v80 = p79 / 1 * 2;

    if v80 < 1 then
        return 0.5 * v80 * v80 * v80 + 0;
    end;

    local v81 = v80 - 2;

    return 0.5 * (v81 * v81 * v81 + 2) + 0;
end;

function v1.CubicOutIn(p82) -- Line: 122
    if p82 < 0.5 then
        return 0.5 * (math.pow(p82 * 2 / 1 - 1, 3) + 1) + 0;
    end;

    return 0.5 * math.pow((p82 * 2 - 1) / 1, 3) + 0.5;
end;

local function inQuart(p83, p84, p85, p86) -- Line: 126
    return p85 * math.pow(p83 / p86, 4) + p84;
end;

local function outQuart(p87, p88, p89, p90) -- Line: 130
    return -p89 * (math.pow(p87 / p90 - 1, 4) - 1) + p88;
end;

local function inOutQuart(p91, p92, p93, p94) -- Line: 134
    local v95 = p91 / p94 * 2;

    if v95 < 1 then
        return p93 / 2 * math.pow(v95, 4) + p92;
    end;

    return -p93 / 2 * (math.pow(v95 - 2, 4) - 2) + p92;
end;

local function outInQuart(p96, p97, p98, p99) -- Line: 143
    if p96 < p99 / 2 then
        return -(p98 / 2) * (math.pow(p96 * 2 / p99 - 1, 4) - 1) + p97;
    end;

    return p98 / 2 * math.pow((p96 * 2 - p99) / p99, 4) + (p97 + p98 / 2);
end;

function v1.QuartIn(p100) -- Line: 151
    return 1 * math.pow(p100 / 1, 4) + 0;
end;

function v1.QuartOut(p101) -- Line: 154
    return -1 * (math.pow(p101 / 1 - 1, 4) - 1) + 0;
end;

function v1.QuartInOut(p102) -- Line: 157
    local v103 = p102 / 1 * 2;

    if v103 < 1 then
        return 0.5 * math.pow(v103, 4) + 0;
    end;

    return -0.5 * (math.pow(v103 - 2, 4) - 2) + 0;
end;

function v1.QuartOutIn(p104) -- Line: 160
    if p104 < 0.5 then
        return -0.5 * (math.pow(p104 * 2 / 1 - 1, 4) - 1) + 0;
    end;

    return 0.5 * math.pow((p104 * 2 - 1) / 1, 4) + 0.5;
end;

local function inQuint(p105, p106, p107, p108) -- Line: 164
    return p107 * math.pow(p105 / p108, 5) + p106;
end;

local function outQuint(p109, p110, p111, p112) -- Line: 168
    return p111 * (math.pow(p109 / p112 - 1, 5) + 1) + p110;
end;

local function inOutQuint(p113, p114, p115, p116) -- Line: 172
    local v117 = p113 / p116 * 2;

    if v117 < 1 then
        return p115 / 2 * math.pow(v117, 5) + p114;
    end;

    return p115 / 2 * (math.pow(v117 - 2, 5) + 2) + p114;
end;

local function outInQuint(p118, p119, p120, p121) -- Line: 181
    if p118 < p121 / 2 then
        return p120 / 2 * (math.pow(p118 * 2 / p121 - 1, 5) + 1) + p119;
    end;

    return p120 / 2 * math.pow((p118 * 2 - p121) / p121, 5) + (p119 + p120 / 2);
end;

function v1.QuintIn(p122) -- Line: 189
    return 1 * math.pow(p122 / 1, 5) + 0;
end;

function v1.QuintOut(p123) -- Line: 192
    return 1 * (math.pow(p123 / 1 - 1, 5) + 1) + 0;
end;

function v1.QuintInOut(p124) -- Line: 195
    local v125 = p124 / 1 * 2;

    if v125 < 1 then
        return 0.5 * math.pow(v125, 5) + 0;
    end;

    return 0.5 * (math.pow(v125 - 2, 5) + 2) + 0;
end;

function v1.QuintOutIn(p126) -- Line: 198
    if p126 < 0.5 then
        return 0.5 * (math.pow(p126 * 2 / 1 - 1, 5) + 1) + 0;
    end;

    return 0.5 * math.pow((p126 * 2 - 1) / 1, 5) + 0.5;
end;

local function inSextic(p127, p128, p129, p130) -- Line: 202
    return p129 * math.pow(p127 / p130, 6) + p128;
end;

local function outSextic(p131, p132, p133, p134) -- Line: 206
    return -p133 * (math.pow(p131 / p134 - 1, 6) - 1) + p132;
end;

local function inOutSextic(p135, p136, p137, p138) -- Line: 210
    local v139 = p135 / p138 * 2;

    if v139 < 1 then
        return p137 / 2 * math.pow(v139, 6) + p136;
    end;

    return -p137 / 2 * (math.pow(v139 - 2, 6) - 2) + p136;
end;

local function outInSextic(p140, p141, p142, p143) -- Line: 219
    if p140 < p143 / 2 then
        return -(p142 / 2) * (math.pow(p140 * 2 / p143 - 1, 6) - 1) + p141;
    end;

    return p142 / 2 * math.pow((p140 * 2 - p143) / p143, 6) + (p141 + p142 / 2);
end;

function v1.SexticIn(p144) -- Line: 227
    return 1 * math.pow(p144 / 1, 6) + 0;
end;

function v1.SexticOut(p145) -- Line: 230
    return -1 * (math.pow(p145 / 1 - 1, 6) - 1) + 0;
end;

function v1.SexticInOut(p146) -- Line: 233
    local v147 = p146 / 1 * 2;

    if v147 < 1 then
        return 0.5 * math.pow(v147, 6) + 0;
    end;

    return -0.5 * (math.pow(v147 - 2, 6) - 2) + 0;
end;

function v1.SexticOutIn(p148) -- Line: 236
    if p148 < 0.5 then
        return -0.5 * (math.pow(p148 * 2 / 1 - 1, 6) - 1) + 0;
    end;

    return 0.5 * math.pow((p148 * 2 - 1) / 1, 6) + 0.5;
end;

local function inExpo(p149, p150, p151, p152) -- Line: 240
    if p149 == 0 then
        return p150;
    end;

    return p151 * math.pow(2, 10 * (p149 / p152 - 1)) + p150 - p151 * 0.001;
end;

local function outExpo(p153, p154, p155, p156) -- Line: 247
    if p153 == p156 then
        return p154 + p155;
    end;

    return p155 * 1.001 * (-math.pow(2, -10 * p153 / p156) + 1) + p154;
end;

local function inOutExpo(p157, p158, p159, p160) -- Line: 254
    if p157 == 0 then
        return p158;
    end;

    if p157 == p160 then
        return p158 + p159;
    end;

    local v161 = p157 / p160 * 2;

    if v161 < 1 then
        return p159 / 2 * math.pow(2, 10 * (v161 - 1)) + p158 - p159 * 0.0005;
    end;

    return p159 / 2 * 1.0005 * (-math.pow(2, -10 * (v161 - 1)) + 2) + p158;
end;

local function outInExpo(p162, p163, p164, p165) -- Line: 265
    if p162 < p165 / 2 then
        local v166 = p162 * 2;
        local v167 = p164 / 2;

        if v166 == p165 then
            return p163 + v167;
        end;

        return v167 * 1.001 * (-math.pow(2, -10 * v166 / p165) + 1) + p163;
    end;

    local v168 = p162 * 2 - p165;
    local v169 = p163 + p164 / 2;
    local v170 = p164 / 2;

    if v168 == 0 then
        return v169;
    end;

    return v170 * math.pow(2, 10 * (v168 / p165 - 1)) + v169 - v170 * 0.001;
end;

function v1.ExpoIn(p171) -- Line: 273
    return p171 == 0 and 0 or 1 * math.pow(2, 10 * (p171 / 1 - 1)) + 0 - 0.001;
end;

function v1.ExpoOut(p172) -- Line: 276
    return p172 == 1 and 1 or 1.001 * (-math.pow(2, -10 * p172 / 1) + 1) + 0;
end;

function v1.ExpoInOut(p173) -- Line: 279
    if p173 == 0 then
        return 0;
    end;

    if p173 == 1 then
        return 1;
    end;

    local v174 = p173 / 1 * 2;

    if v174 < 1 then
        return 0.5 * math.pow(2, 10 * (v174 - 1)) + 0 - 0.0005;
    end;

    return 0.50025 * (-math.pow(2, -10 * (v174 - 1)) + 2) + 0;
end;

function v1.ExpoOutIn(p175) -- Line: 282
    if p175 < 0.5 then
        local v176 = p175 * 2;

        return v176 == 1 and 0.5 or 0.5005 * (-math.pow(2, -10 * v176 / 1) + 1) + 0;
    end;

    local v177 = p175 * 2 - 1;

    return v177 == 0 and 0.5 or 0.5 * math.pow(2, 10 * (v177 / 1 - 1)) + 0.5 - 0.0005;
end;

local function inCirc(p178, p179, p180, p181) -- Line: 286
    local v182 = 1 - math.pow(p178 / p181, 2);

    return -p180 * (math.sqrt(v182) - 1) + p179;
end;

local function outCirc(p183, p184, p185, p186) -- Line: 290
    local v187 = 1 - math.pow(p183 / p186 - 1, 2);

    return p185 * math.sqrt(v187) + p184;
end;

local function inOutCirc(p188, p189, p190, p191) -- Line: 294
    local v192 = p188 / p191 * 2;

    if v192 < 1 then
        return -p190 / 2 * (math.sqrt(1 - v192 * v192) - 1) + p189;
    end;

    local v193 = v192 - 2;

    return p190 / 2 * (math.sqrt(1 - v193 * v193) + 1) + p189;
end;

local function outInCirc(p194, p195, p196, p197) -- Line: 303
    if p194 < p197 / 2 then
        local v198 = 1 - math.pow(p194 * 2 / p197 - 1, 2);

        return p196 / 2 * math.sqrt(v198) + p195;
    end;

    local v199 = 1 - math.pow((p194 * 2 - p197) / p197, 2);

    return -(p196 / 2) * (math.sqrt(v199) - 1) + (p195 + p196 / 2);
end;

function v1.CircIn(p200) -- Line: 311
    local v201 = 1 - math.pow(p200 / 1, 2);

    return -1 * (math.sqrt(v201) - 1) + 0;
end;

function v1.CircOut(p202) -- Line: 314
    local v203 = 1 - math.pow(p202 / 1 - 1, 2);

    return 1 * math.sqrt(v203) + 0;
end;

function v1.CircInOut(p204) -- Line: 317
    local v205 = p204 / 1 * 2;

    if v205 < 1 then
        return -0.5 * (math.sqrt(1 - v205 * v205) - 1) + 0;
    end;

    local v206 = v205 - 2;

    return 0.5 * (math.sqrt(1 - v206 * v206) + 1) + 0;
end;

function v1.CircOutIn(p207) -- Line: 320
    if p207 < 0.5 then
        local v208 = 1 - math.pow(p207 * 2 / 1 - 1, 2);

        return 0.5 * math.sqrt(v208) + 0;
    end;

    local v209 = 1 - math.pow((p207 * 2 - 1) / 1, 2);

    return -0.5 * (math.sqrt(v209) - 1) + 0.5;
end;

local function inBack(p210, p211, p212, p213, p214) -- Line: 324
    local v215 = p214 or 1.70158;
    local v216 = p210 / p213;

    return p212 * v216 * v216 * ((v215 + 1) * v216 - v215) + p211;
end;

local function outBack(p217, p218, p219, p220, p221) -- Line: 329
    local v222 = p221 or 1.70158;
    local v223 = p217 / p220 - 1;

    return p219 * (v223 * v223 * ((v222 + 1) * v223 + v222) + 1) + p218;
end;

local function inOutBack(p224, p225, p226, p227, p228) -- Line: 334
    local v229 = (p228 or 1.70158) * 1.525;
    local v230 = p224 / p227 * 2;

    if v230 < 1 then
        return p226 / 2 * (v230 * v230 * ((v229 + 1) * v230 - v229)) + p225;
    end;

    local v231 = v230 - 2;

    return p226 / 2 * (v231 * v231 * ((v229 + 1) * v231 + v229) + 2) + p225;
end;

local function outInBack(p232, p233, p234, p235, p236) -- Line: 345
    if p232 < p235 / 2 then
        local v237 = p236 or 1.70158;
        local v238 = p232 * 2 / p235 - 1;

        return p234 / 2 * (v238 * v238 * ((v237 + 1) * v238 + v237) + 1) + p233;
    end;

    local v239 = p236 or 1.70158;
    local v240 = (p232 * 2 - p235) / p235;

    return p234 / 2 * v240 * v240 * ((v239 + 1) * v240 - v239) + (p233 + p234 / 2);
end;

function v1.BackIn(p241, p242) -- Line: 353
    local v243 = p242 or 1.70158;
    local v244 = p241 / 1;

    return 1 * v244 * v244 * ((v243 + 1) * v244 - v243) + 0;
end;

function v1.BackOut(p245, p246) -- Line: 356
    local v247 = p246 or 1.70158;
    local v248 = p245 / 1 - 1;

    return 1 * (v248 * v248 * ((v247 + 1) * v248 + v247) + 1) + 0;
end;

function v1.BackInOut(p249, p250) -- Line: 359
    local v251 = (p250 or 1.70158) * 1.525;
    local v252 = p249 / 1 * 2;

    if v252 < 1 then
        return 0.5 * (v252 * v252 * ((v251 + 1) * v252 - v251)) + 0;
    end;

    local v253 = v252 - 2;

    return 0.5 * (v253 * v253 * ((v251 + 1) * v253 + v251) + 2) + 0;
end;

function v1.BackOutIn(p254, p255) -- Line: 362
    if p254 < 0.5 then
        local v256 = 1.702 or 1.70158;
        local v257 = p254 * 2 / 1 - 1;

        return 0.5 * (v257 * v257 * ((v256 + 1) * v257 + v256) + 1) + 0;
    end;

    local v258 = 1.702 or 1.70158;
    local v259 = (p254 * 2 - 1) / 1;

    return 0.5 * v259 * v259 * ((v258 + 1) * v259 - v258) + 0.5;
end;

local function outBounce(p260, p261, p262, p263) -- Line: 366
    local v264 = p260 / p263;

    if v264 < 0.36363636363636365 then
        return p262 * (7.5625 * v264 * v264) + p261;
    end;

    if v264 < 0.7272727272727273 then
        local v265 = v264 - 0.5454545454545454;

        return p262 * (7.5625 * v265 * v265 + 0.75) + p261;
    end;

    if v264 < 0.9090909090909091 then
        local v266 = v264 - 0.8181818181818182;

        return p262 * (7.5625 * v266 * v266 + 0.9375) + p261;
    end;

    local v267 = v264 - 0.9545454545454546;

    return p262 * (7.5625 * v267 * v267 + 0.984375) + p261;
end;

local function inBounce(p268, p269, p270, p271) -- Line: 381
    -- upvalues: outBounce (copy)
    return p270 - outBounce(p271 - p268, 0, p270, p271) + p269;
end;

local function inOutBounce(p272, p273, p274, p275) -- Line: 384
    -- upvalues: outBounce (copy)
    if p272 < p275 / 2 then
        return (p274 - outBounce(p275 - p272 * 2, 0, p274, p275) + 0) * 0.5 + p273;
    end;

    return outBounce(p272 * 2 - p275, 0, p274, p275) * 0.5 + p274 * 0.5 + p273;
end;

local function outInBounce(p276, p277, p278, p279) -- Line: 391
    -- upvalues: outBounce (copy)
    if p276 < p279 / 2 then
        return outBounce(p276 * 2, p277, p278 / 2, p279);
    end;

    local v280 = p278 / 2;

    return v280 - outBounce(p279 - (p276 * 2 - p279), 0, v280, p279) + (p277 + p278 / 2);
end;

function v1.BounceIn(p281) -- Line: 399
    -- upvalues: outBounce (copy)
    return 1 - outBounce(1 - p281, 0, 1, 1) + 0;
end;

function v1.BounceOut(p282) -- Line: 402
    -- upvalues: outBounce (copy)
    return outBounce(p282, 0, 1, 1);
end;

function v1.BounceInOut(p283) -- Line: 405
    -- upvalues: outBounce (copy)
    if p283 < 0.5 then
        return (1 - outBounce(1 - p283 * 2, 0, 1, 1) + 0) * 0.5 + 0;
    end;

    return outBounce(p283 * 2 - 1, 0, 1, 1) * 0.5 + 0.5 + 0;
end;

function v1.BounceOutIn(p284) -- Line: 408
    -- upvalues: outBounce (copy)
    if p284 < 0.5 then
        return outBounce(p284 * 2, 0, 0.5, 1);
    end;

    return 0.5 - outBounce(1 - (p284 * 2 - 1), 0, 0.5, 1) + 0.5;
end;

local function elastic_blend(p285, p286, p287, p288, p289, p290) -- Line: 412
    if p286 ~= 0 then
        local math_abs_ret = math.abs(p289);
        p290 = p288 == 0 and 0 or p290 * (p288 / math.abs(p286));

        if math.abs(p285 * p287) < math_abs_ret then
            local v291 = math.abs(p285 * p287) / math_abs_ret;
            p290 = p290 * v291 + (1 - v291);
        end;
    end;

    return p290;
end;

local function inElastic(p292, p293, p294, p295, p296, p297) -- Line: 427
    local v298 = 1;

    if p292 == 0 then
        return p293;
    end;

    local v299 = p292 / p295;

    if v299 == 1 then
        return p293 + p294;
    end;

    local v300 = v299 - 1;

    if not p297 or p297 == 0 then
        p297 = p295 * 0.3;
    end;

    local v301;

    if p296 and p296 >= math.abs(p294) then
        v301 = p297 / 6.283185307179586 * math.asin(p294 / p296);
        p294 = p296;
    else
        v301 = p297 / 4;

        if p294 ~= 0 then
            local math_abs_ret = math.abs(v301);
            v298 = p296 == 0 and 0 or v298 * (p296 / math.abs(p294));

            if math.abs(v300 * p295) < math_abs_ret then
                local v302 = math.abs(v300 * p295) / math_abs_ret;
                v298 = v298 * v302 + (1 - v302);
            end;
        end;
    end;

    return -v298 * (p294 * math.pow(2, 10 * v300) * math.sin((v300 * p295 - v301) * 6.283185307179586 / p297)) + p293;
end;

local function outElastic(p303, p304, p305, p306, p307, p308) -- Line: 446
    local v309 = 1;

    if p303 == 0 then
        return p304;
    end;

    local v310 = p303 / p306;

    if v310 == 1 then
        return p304 + p305;
    end;

    local v311 = -v310;

    if not p308 or p308 == 0 then
        p308 = p306 * 0.3;
    end;

    local v312;

    if p307 and p307 >= math.abs(p305) then
        v312 = p308 / 6.283185307179586 * math.asin(p305 / p307);
    else
        v312 = p308 / 4;

        if p305 ~= 0 then
            local math_abs_ret = math.abs(v312);
            v309 = p307 == 0 and 0 or v309 * (p307 / math.abs(p305));

            if math.abs(v311 * p306) < math_abs_ret then
                local v313 = math.abs(v311 * p306) / math_abs_ret;
                v309 = v309 * v313 + (1 - v313);
            end;
        end;

        p307 = p305;
    end;

    return v309 * (p307 * math.pow(2, 10 * v311) * math.sin((v311 * p306 - v312) * 6.283185307179586 / p308)) + p305 + p304;
end;

local function inOutElastic(p314, p315, p316, p317, p318, p319) -- Line: 464
    local v320 = 1;

    if p314 == 0 then
        return p315;
    end;

    local v321 = p314 / (p317 / 2);

    if v321 == 2 then
        return p315 + p316;
    end;

    local v322 = v321 - 1;

    if not p319 or p319 == 0 then
        p319 = p317 * 0.44999999999999996;
    end;

    local v323;

    if p318 and p318 >= math.abs(p316) then
        v323 = p319 / 6.283185307179586 * math.asin(p316 / p318);
    else
        v323 = p319 / 4;

        if p316 ~= 0 then
            local math_abs_ret = math.abs(v323);
            v320 = p318 == 0 and 0 or v320 * (p318 / math.abs(p316));

            if math.abs(v322 * p317) < math_abs_ret then
                local v324 = math.abs(v322 * p317) / math_abs_ret;
                v320 = v320 * v324 + (1 - v324);
            end;
        end;

        p318 = p316;
    end;

    if v322 < 0 then
        return v320 * -0.5 * (p318 * math.pow(2, 10 * v322) * math.sin((v322 * p317 - v323) * 6.283185307179586 / p319)) + p315;
    end;

    local v325 = -v322;

    return v320 * 0.5 * (p318 * math.pow(2, 10 * v325) * math.sin((v325 * p317 - v323) * 6.283185307179586 / p319)) + p316 + p315;
end;

local function outInElastic(p326, p327, p328, p329, p330, p331) -- Line: 489
    -- upvalues: outElastic (copy), inElastic (copy)
    if p326 < p329 / 2 then
        return outElastic(p326 * 2, p327, p328 / 2, p329, p330, p331);
    end;

    return inElastic(p326 * 2 - p329, p327 + p328 / 2, p328 / 2, p329, p330, p331);
end;

function v1.ElasticIn(p332, p333, p334) -- Line: 497
    -- upvalues: inElastic (copy)
    return inElastic(p332, 0, 1, 1, p333, p334);
end;

function v1.ElasticOut(p335, p336, p337) -- Line: 500
    -- upvalues: outElastic (copy)
    return outElastic(p335, 0, 1, 1, p336, p337);
end;

function v1.ElasticInOut(p338, p339, p340) -- Line: 503
    -- upvalues: inOutElastic (copy)
    return inOutElastic(p338, 0, 1, 1, p339, p340);
end;

function v1.ElasticOutIn(p341, p342, p343) -- Line: 506
    -- upvalues: outElastic (copy), inElastic (copy)
    if p341 < 0.5 then
        return outElastic(p341 * 2, 0, 0.5, 1, p342, p343);
    end;

    return inElastic(p341 * 2 - 1, 0.5, 0.5, 1, p342, p343);
end;

return v1;