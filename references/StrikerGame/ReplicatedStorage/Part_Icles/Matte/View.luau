 

 

local u1 = {
    MODES = {
        Tilted = "Tilted",
        SemiTilt = "Semi Tilt",
        Middle = "Middle",
        Front = "Front",
        OnTop = "On Top"
    },
    NEAREST = 0.5,
    THICKNESS = 0.05
};

local function stepOf(p2) -- Line: 126
    local v3 = math.max(p2, 32) / 32;
    local v4 = math.log(v3, 2) * 2 - 1e-9;
    local v5 = 2 ^ (math.ceil(v4) / 2) * 32 + 0.5;
    local math_floor_ret = math.floor(v5);

    return math.min(math_floor_ret, 2048);
end;

local function picture(p6, p7, p8, p9) -- Line: 133
    local v10 = math.max(p7, 32) / 32;
    local v11 = math.log(v10, 2) * 2 - 1e-9;
    local v12 = 2 ^ (math.ceil(v11) / 2) * 32 + 0.5;
    local math_floor_ret = math.floor(v12);
    local math_min_ret = math.min(math_floor_ret, 2048);
    local v13 = math.max(p8, 32) / 32;
    local v14 = math.log(v13, 2) * 2 - 1e-9;
    local v15 = 2 ^ (math.ceil(v14) / 2) * 32 + 0.5;
    local math_floor_ret2 = math.floor(v15);
    local math_min_ret2 = math.min(math_floor_ret2, 2048);
    local keptX = p6.keptX;
    local keptY = p6.keptY;

    if keptX and (keptX >= math_min_ret and keptY >= math_min_ret2) then
        if keptX * keptY > 2.2 * math_min_ret * math_min_ret2 then
            p6.roomy = (p6.roomy or 0) + 1;

            if p6.roomy > 45 then
                p6.roomy = 0;
            else
                math_min_ret2 = keptY;
                math_min_ret = keptX;
            end;
        else
            p6.roomy = 0;
            math_min_ret2 = keptY;
            math_min_ret = keptX;
        end;
    else
        math_min_ret = math.max(keptX or 0, math_min_ret);
        math_min_ret2 = math.max(keptY or 0, math_min_ret2);
        p6.roomy = 0;
    end;

    p6.keptX = math_min_ret;
    p6.keptY = math_min_ret2;

    if math_min_ret * math_min_ret2 <= p9 then
        return math_min_ret, math_min_ret2;
    end;

    local math_sqrt_ret = math.sqrt(p9 / (math_min_ret * math_min_ret2));
    local math_floor_ret3 = math.floor(math_min_ret * math_sqrt_ret);
    local math_max_ret = math.max(math_floor_ret3, 1);
    local math_floor_ret4 = math.floor(math_min_ret2 * math_sqrt_ret);

    return math_max_ret, math.max(math_floor_ret4, 1);
end;

function u1.shareOf(p16) -- Line: 162
    if p16 <= 3 then
        return 1;
    end;

    if p16 > 48 then
        local v17 = math.log(p16 / 48, 2) * 2 - 1e-9;
        local v18 = 2 ^ (-math.ceil(v17) / 2) * 0.125;

        return math.max(v18, 0.03125);
    end;

    local v19 = math.log(p16 / 3, 2) * 2 - 1e-9;
    local v20 = 2 ^ (-math.ceil(v19) / 2);

    return math.max(v20, 0.125);
end;

local function heightAt(p21, p22) -- Line: 174
    local math_rad_ret = math.rad(p21 / 2);

    return 2 * p22 * math.tan(math_rad_ret);
end;

local function across(p23, p24) -- Line: 179
    return p23 - 1e-6 <= p24 and 1 or math.ceil((p23 - p24) / (2 * p24) - 1e-6) * 2 + 1;
end;

local function whole(p25) -- Line: 187
    for i, v in ipairs(p25) do
        if v >= 1 then
            return i;
        end;
    end;

    return #p25;
end;

function u1.along(p26, p27) -- Line: 196
    return (p27 - p26.Position):Dot(p26.LookVector);
end;

function u1.farthest(p28, p29) -- Line: 200
    local math_rad_ret = math.rad(p28 / 2);

    return 2048 / (2 * math.tan(math_rad_ret) * math.max(p29, 1));
end;

function u1.depth(p30, p31, p32) -- Line: 204
    -- upvalues: u1 (copy)
    local NEAREST = u1.NEAREST;
    local v33 = u1.farthest(p31, p32);

    return math.clamp(p30, NEAREST, v33);
end;

function u1.quad(p34, p35, p36, p37) -- Line: 208
    -- upvalues: u1 (copy)
    local math_rad_ret = math.rad(p35 / 2);
    local v38 = 2 * p37 * math.tan(math_rad_ret);

    return p34 * CFrame.new(0, 0, -p37), Vector3.new(v38 * p36, v38, u1.THICKNESS);
end;

function u1.shrinkFor(p39, p40, p41) -- Line: 219
    -- upvalues: u1 (copy)
    local v42 = p41 or 300;
    local v43 = u1.behind(p39);

    return v43 <= v42 and 1 or math.clamp(v42 / v43, p40 <= 1 and 1 or 1 / p40, 1);
end;

function u1.sceneReach(p44, p45) -- Line: 234
    local math_rad_ret = math.rad(p44 / 2);
    local v46 = 1843.2 / (4 * (2 * math.tan(math_rad_ret)) * math.max(p45, 1));

    return math.min(300, v46);
end;

function u1.behind(p47) -- Line: 239
    -- upvalues: u1 (copy)
    local math_max_ret = math.max(p47, u1.NEAREST);

    return math_max_ret + math.max(math_max_ret * 0.5, 40);
end;

function u1.fit(p48, p49, p50, p51, p52) -- Line: 244
    local math_rad_ret = math.rad(p48 / 2);
    local v53 = 2 * p50 * math.tan(math_rad_ret);
    local v54 = v53 * p49;
    local math_max_ret = math.max(v54, v53);
    local v55 = math.max(p51, 0.0001) * v53;
    local v56 = #p52;

    for i, v in ipairs(p52) do
        if math_max_ret <= v * v55 then
            v56 = i;
            break;
        end;
    end;

    local v57 = p52[v56] * v55;

    while v57 > 2048 and (v56 > 1 and p52[v56 - 1] >= 1) do
        v56 = v56 - 1;
        v57 = p52[v56] * v55;
    end;

    local math_min_ret = math.min(v57, 2048);

    if math_min_ret < math_max_ret and p52[v56] < 1 then
        for i, v in ipairs(p52) do
            if v >= 1 then
                v56 = i;
                break;
            end;
        end;

        v56 = #p52;
        math_min_ret = math.min(p52[v56] * v55, 2048);
    end;

    local v58 = v54 - 1e-6 <= math_min_ret and 1 or math.ceil((v54 - math_min_ret) / (2 * math_min_ret) - 1e-6) * 2 + 1;
    local v59 = v53 - 1e-6 <= math_min_ret and 1 or math.ceil((v53 - math_min_ret) / (2 * math_min_ret) - 1e-6) * 2 + 1;

    if v58 > 5 or v59 > 5 then
        math_min_ret = math_max_ret / 5;
        v58 = v54 - 1e-6 <= math_min_ret and 1 or math.ceil((v54 - math_min_ret) / (2 * math_min_ret) - 1e-6) * 2 + 1;

        if v53 - 1e-6 <= math_min_ret then
            v59 = 1;
        else
            v59 = math.ceil((v53 - math_min_ret) / (2 * math_min_ret) - 1e-6) * 2 + 1;
        end;
    end;

    return v56, math_min_ret, v58, v59;
end;

function u1.tile(p60, p61, p62, p63, p64, p65) -- Line: 282
    return CFrame.new((p62 - (p63 + 1) / 2) * p61, ((p65 + 1) / 2 - p64) * p61, -p60);
end;

local table_create_ret = table.create(12, 0);
local table_create_ret2 = table.create(12, 0);
local table_create_ret3 = table.create(12, 0);
local table_create_ret4 = table.create(12, 0);

local function cut(p66, p67, p68, p69) -- Line: 293
    -- upvalues: table_create_ret (ref), table_create_ret2 (ref), table_create_ret3 (ref), table_create_ret4 (ref)
    if p66 == 0 then
        return 0;
    end;

    local v70 = table_create_ret[p66];
    local v71 = table_create_ret2[p66];
    local v72 = p67 * v70 + p68 * v71 + p69;
    local v73 = 0;

    for i = 1, p66 do
        local v74 = table_create_ret[i];
        local v75 = table_create_ret2[i];
        local v76 = p67 * v74 + p68 * v75 + p69;

        if v76 >= 0 ~= (v72 >= 0) then
            local v77 = v72 / (v72 - v76);
            v73 = v73 + 1;
            table_create_ret3[v73] = v70 + (v74 - v70) * v77;
            table_create_ret4[v73] = v71 + (v75 - v71) * v77;
        end;

        if v76 >= 0 then
            v73 = v73 + 1;
            table_create_ret3[v73] = v74;
            table_create_ret4[v73] = v75;
        end;

        v71 = v75;
        v70 = v74;
        v72 = v76;
        local _ = i;
    end;

    local v78 = table_create_ret;
    table_create_ret = table_create_ret3;
    table_create_ret3 = v78;
    local v79 = table_create_ret2;
    table_create_ret2 = table_create_ret4;
    table_create_ret4 = v79;

    return v73;
end;

local function looks(p80, p81, p82, p83, p84) -- Line: 327
    local v85 = math.abs(p80) - p81;

    if v85 <= 0 then
        return nil;
    end;

    local math_sqrt_ret = math.sqrt(v85 * v85 + p82 * p82 + p83 * p83);

    if v85 < math_sqrt_ret * 0.002 then
        return nil;
    end;

    return p84 * v85 / (math_sqrt_ret * math_sqrt_ret * math_sqrt_ret);
end;

local function largestFace(p86, p87, p88) -- Line: 341
    local v89 = 0;
    local v90 = 0;
    local v91 = p87.X / 2;
    local Y = p86.Y;
    local Z = p86.Z;
    local v92 = p87.Y * p87.Z;
    local v93 = math.abs(p86.X) - v91;
    local v94;

    if v93 <= 0 then
        v94 = nil;
    else
        local math_sqrt_ret = math.sqrt(v93 * v93 + Y * Y + Z * Z);

        if v93 < math_sqrt_ret * 0.002 then
            v94 = nil;
        else
            v94 = v92 * v93 / (math_sqrt_ret * math_sqrt_ret * math_sqrt_ret);
        end;
    end;

    local v95 = p87.Y / 2;
    local Z2 = p86.Z;
    local X = p86.X;
    local v96 = p87.Z * p87.X;
    local v97 = math.abs(p86.Y) - v95;
    local v98;

    if v97 <= 0 then
        v98 = nil;
    else
        local math_sqrt_ret = math.sqrt(v97 * v97 + Z2 * Z2 + X * X);

        if v97 < math_sqrt_ret * 0.002 then
            v98 = nil;
        else
            v98 = v96 * v97 / (math_sqrt_ret * math_sqrt_ret * math_sqrt_ret);
        end;
    end;

    local v99 = p87.Z / 2;
    local X2 = p86.X;
    local Y2 = p86.Y;
    local v100 = p87.X * p87.Y;
    local v101 = math.abs(p86.Z) - v99;
    local v102;

    if v101 <= 0 then
        v102 = nil;
    else
        local math_sqrt_ret = math.sqrt(v101 * v101 + X2 * X2 + Y2 * Y2);

        if v101 < math_sqrt_ret * 0.002 then
            v102 = nil;
        else
            v102 = v100 * v101 / (math_sqrt_ret * math_sqrt_ret * math_sqrt_ret);
        end;
    end;

    if v94 then
        v89 = p86.X > 0 and 1 or -1;

        if v89 == p88 then
            v94 = v94 * 1.2 or v94;
        end;
    else
        v94 = v90;
    end;

    local v103;

    if v98 then
        v103 = p86.Y > 0 and 2 or -2;

        if v103 == p88 then
            v98 = v98 * 1.2 or v98;
        end;

        if v94 >= v98 then
            v98 = v94;
            v103 = v89;
        end;
    else
        v98 = v94;
        v103 = v89;
    end;

    local v104;

    if v102 then
        v104 = p86.Z > 0 and 3 or -3;

        if v104 == p88 then
            v102 = v102 * 1.2 or v102;
        end;

        if v98 >= v102 then
            v104 = v103;
        end;
    else
        v104 = v103;
    end;

    return v104;
end;

local function groupReset(p105, p106, p107, p108, p109) -- Line: 369
    p105.origin = p106;
    p105.axisX = p107;
    p105.axisY = p108;
    p105.axisZ = p109;
    p105.lowX = (1 / 0);
    p105.lowY = (1 / 0);
    p105.lowZ = (1 / 0);
    p105.highX = (-1 / 0);
    p105.highY = (-1 / 0);
    p105.highZ = (-1 / 0);
end;

function u1.groupStart(p110, p111) -- Line: 382
    local XVector = p111.XVector;
    local YVector = p111.YVector;
    local ZVector = p111.ZVector;
    p110.origin = p111.Position;
    p110.axisX = XVector;
    p110.axisY = YVector;
    p110.axisZ = ZVector;
    p110.lowX = (1 / 0);
    p110.lowY = (1 / 0);
    p110.lowZ = (1 / 0);
    p110.highX = (-1 / 0);
    p110.highY = (-1 / 0);
    p110.highZ = (-1 / 0);
end;

function u1.groupWorld(p112) -- Line: 386
    p112.origin = Vector3.new(0, 0, 0);
    p112.axisX = Vector3.new(1, 0, 0);
    p112.axisY = Vector3.new(0, 1, 0);
    p112.axisZ = Vector3.new(0, 0, 1);
    p112.lowX = (1 / 0);
    p112.lowY = (1 / 0);
    p112.lowZ = (1 / 0);
    p112.highX = (-1 / 0);
    p112.highY = (-1 / 0);
    p112.highZ = (-1 / 0);
end;

function u1.groupAlong(p113, p114, p115) -- Line: 390
    -- upvalues: u1 (copy)
    local v116 = p115 - p114;
    local Magnitude = v116.Magnitude;

    if Magnitude < 0.05 then
        u1.groupWorld(p113);

        return;
    end;

    local v117 = v116 / Magnitude;
    local Unit = (math.abs(v117.Y) < 0.9 and Vector3.new(0, 1, 0) or Vector3.new(1, 0, 0)):Cross(v117).Unit;
    local v118 = v117:Cross(Unit);
    p113.origin = p114;
    p113.axisX = Unit;
    p113.axisY = v118;
    p113.axisZ = v117;
    p113.lowX = (1 / 0);
    p113.lowY = (1 / 0);
    p113.lowZ = (1 / 0);
    p113.highX = (-1 / 0);
    p113.highY = (-1 / 0);
    p113.highZ = (-1 / 0);
end;

local function halfAlong(p119, p120, p121) -- Line: 405
    local v122 = p119:Dot(p120.XVector);
    local v123 = math.abs(v122) * p121.X;
    local v124 = p119:Dot(p120.YVector);
    local v125 = v123 + math.abs(v124) * p121.Y;
    local v126 = p119:Dot(p120.ZVector);

    return (v125 + math.abs(v126) * p121.Z) / 2;
end;

function u1.groupAdd(p127, p128, p129) -- Line: 409
    -- upvalues: halfAlong (copy)
    local v130 = p128.Position - p127.origin;
    local v131 = v130:Dot(p127.axisX);
    local v132 = halfAlong(p127.axisX, p128, p129);
    p127.lowX = math.min(p127.lowX, v131 - v132);
    p127.highX = math.max(p127.highX, v131 + v132);
    local v133 = v130:Dot(p127.axisY);
    local v134 = halfAlong(p127.axisY, p128, p129);
    p127.lowY = math.min(p127.lowY, v133 - v134);
    p127.highY = math.max(p127.highY, v133 + v134);
    local v135 = v130:Dot(p127.axisZ);
    local v136 = halfAlong(p127.axisZ, p128, p129);
    p127.lowZ = math.min(p127.lowZ, v135 - v136);
    p127.highZ = math.max(p127.highZ, v135 + v136);
end;

function u1.groupBox(p137) -- Line: 425
    return CFrame.fromMatrix(p137.origin + p137.axisX * ((p137.lowX + p137.highX) / 2) + p137.axisY * ((p137.lowY + p137.highY) / 2) + p137.axisZ * ((p137.lowZ + p137.highZ) / 2), p137.axisX, p137.axisY, p137.axisZ), Vector3.new(p137.highX - p137.lowX, p137.highY - p137.lowY, p137.highZ - p137.lowZ);
end;

function u1.glow(p138, p139) -- Line: 436
    local math_min_ret = math.min(p139, 8);
    local math_max_ret = math.max(math_min_ret, 1);

    return p138 * math_max_ret, (1 / math_max_ret) ^ 0.5555555555555556, (math_min_ret / math_max_ret) ^ 0.5555555555555556;
end;

function u1.sharedDepth(p140, p141, p142) -- Line: 442
    -- upvalues: u1 (copy)
    if p140 == u1.MODES.OnTop then
        return 1;
    end;

    if p140 == u1.MODES.Front then
        return p141;
    end;

    return p142;
end;

function u1.facing(p143, p144, p145, p146, p147, p148, p149) -- Line: 452
    -- upvalues: u1 (copy)
    local v150, v151 = u1.quad(p144, p145, p146, u1.depth(p148, p145, p146));
    local math_sqrt_ret = math.sqrt(p149 or 1);
    p143.face = 0;
    p143.quadFrame = v150;
    p143.quadSize = v151;
    p143.eyeFrame = p144;
    p143.eyeFov = p145;
    local math_floor_ret = math.floor(p147 * p146 * math_sqrt_ret);
    p143.canvasX = math.max(math_floor_ret, 1);
    local math_floor_ret2 = math.floor(p147 * math_sqrt_ret);
    p143.canvasY = math.max(math_floor_ret2, 1);

    return p143;
end;

local function leaves(p152, p153, p154) -- Line: 466
    local v155 = (1 / 0);

    if math.abs(p153.X) > 1e-6 then
        local v156 = (math.sign(p153.X) * p154.X / 2 - p152.X) / p153.X;
        v155 = math.min(v155, v156);
    end;

    if math.abs(p153.Y) > 1e-6 then
        local v157 = (math.sign(p153.Y) * p154.Y / 2 - p152.Y) / p153.Y;
        v155 = math.min(v155, v157);
    end;

    if math.abs(p153.Z) > 1e-6 then
        local v158 = (math.sign(p153.Z) * p154.Z / 2 - p152.Z) / p153.Z;
        v155 = math.min(v155, v158);
    end;

    return v155;
end;

function u1.sheet(p159, p160, p161, p162, p163, p164, p165, p166) -- Line: 480
    -- upvalues: largestFace (copy), u1 (copy), leaves (copy), table_create_ret (ref), table_create_ret2 (ref), cut (copy), picture (copy)
    local Position = p160.Position;
    local v167 = p164:PointToObjectSpace(Position);
    local v168 = largestFace(v167, p165, p159.face);

    if v168 == 0 then
        local v169;

        if math.abs(v167.X) <= p165.X / 2 and math.abs(v167.Y) <= p165.Y / 2 then
            v169 = math.abs(v167.Z) <= p165.Z / 2;
        else
            v169 = false;
        end;

        local v170 = u1.along(p160, p164.Position);

        if v169 then
            v170 = leaves(v167, p164:VectorToObjectSpace(p160.LookVector), p165);
        elseif v170 < u1.NEAREST then
            return nil;
        end;

        return u1.facing(p159, p160, p161, p162, p163, v170, p166);
    end;

    local XVector = p164.XVector;
    local YVector = p164.YVector;
    local ZVector = p164.ZVector;
    local v171, v172, v173, v174, v175, v176;

    if v168 == 1 or v168 == -1 then
        v171 = p165.Y / 2;
        v172 = p165.Z / 2;
        v173 = p165.X;
        v174 = v167.Y;
        v175 = v167.Z;
        v176 = math.abs(v167.X) - p165.X / 2;
    elseif v168 == 2 or v168 == -2 then
        v171 = p165.Z / 2;
        v172 = p165.X / 2;
        v173 = p165.Y;
        v174 = v167.Z;
        v175 = v167.X;
        v176 = math.abs(v167.Y) - p165.Y / 2;
        local v177 = YVector;
        YVector = ZVector;
        ZVector = XVector;
        XVector = v177;
    else
        v171 = p165.X / 2;
        v172 = p165.Y / 2;
        v173 = p165.Z;
        v174 = v167.X;
        v175 = v167.Y;
        v176 = math.abs(v167.Z) - p165.Z / 2;
        local v178 = YVector;
        YVector = XVector;
        XVector = ZVector;
        ZVector = v178;
    end;

    if v168 < 0 then
        XVector = -XVector;
    else
        local v179 = YVector;
        YVector = ZVector;
        ZVector = v179;
        v179 = v174;
        v174 = v175;
        v175 = v179;
        v179 = v171;
        v171 = v172;
        v172 = v179;
    end;

    local v180 = p164.Position + XVector * (v173 / 2);
    local v181 = v176 / (v176 + v173);
    local math_min_ret = math.min(-v172, v175 + (-v172 - v175) * v181);
    local math_max_ret = math.max(v172, v175 + (v172 - v175) * v181);
    local math_min_ret2 = math.min(-v171, v174 + (-v171 - v174) * v181);
    local math_max_ret2 = math.max(v171, v174 + (v171 - v174) * v181);
    local v182 = (math_max_ret - math_min_ret) * 0.010000000000000009;
    local v183 = (math_max_ret2 - math_min_ret2) * 0.010000000000000009;
    table_create_ret[1] = math_min_ret - v182;
    table_create_ret2[1] = math_min_ret2 - v183;
    table_create_ret[2] = math_max_ret + v182;
    table_create_ret2[2] = math_min_ret2 - v183;
    table_create_ret[3] = math_max_ret + v182;
    table_create_ret2[3] = math_max_ret2 + v183;
    table_create_ret[4] = math_min_ret - v182;
    table_create_ret2[4] = math_max_ret2 + v183;
    local LookVector = p160.LookVector;
    local math_rad_ret = math.rad(p161 / 2);
    local v184 = math.tan(math_rad_ret) * 1.02;
    local v185 = v184 * p162;
    local v186 = 4;

    for i = 1, 4 do
        local v187;

        if i == 1 then
            v187 = LookVector * v185 - p160.RightVector;
        elseif i == 2 then
            v187 = LookVector * v185 + p160.RightVector;
        elseif i == 3 then
            v187 = LookVector * v184 - p160.UpVector;
        else
            v187 = LookVector * v184 + p160.UpVector;
        end;

        local v188 = v187:Dot(ZVector);
        local v189 = v187:Dot(YVector);
        v186 = cut(v186, v188, v189, -v188 * v175 - v189 * v174 - v176 * v187:Dot(XVector));
        local _ = i;
    end;

    if v186 < 3 then
        return nil;
    end;

    local v190 = (1 / 0);
    local v191 = (-1 / 0);
    local v192 = (1 / 0);
    local v193 = (-1 / 0);

    for i = 1, v186 do
        v190 = math.min(v190, table_create_ret[i]);
        v191 = math.max(v191, table_create_ret[i]);
        v192 = math.min(v192, table_create_ret2[i]);
        v193 = math.max(v193, table_create_ret2[i]);
        local _ = i;
    end;

    local v194 = v191 - v190;
    local v195 = v193 - v192;

    if v194 < 0.001 or v195 < 0.001 then
        return nil;
    end;

    local math_max_ret3 = math.max(v190 - v175, v175 - v191, 0);
    local math_max_ret4 = math.max(v192 - v174, v174 - v193, 0);
    local math_sqrt_ret = math.sqrt(v176 * v176 + math_max_ret3 * math_max_ret3 + math_max_ret4 * math_max_ret4);
    local v196 = p163 * p163 * p162 * (p166 or 1);
    local math_rad_ret2 = math.rad(p161 / 2);
    local v197 = p163 / (2 * math_sqrt_ret * math.tan(math_rad_ret2));
    local math_sqrt_ret2 = math.sqrt(v196 / (v194 * v195));
    local math_min_ret3 = math.min(v197, 2048 / v194, 2048 / v195, math_sqrt_ret2);
    local v198, v199 = picture(p159, v194 * math_min_ret3, v195 * math_min_ret3, v196);
    local math_min_ret4 = math.min(v198 / v194, v199 / v195);
    local v200 = v199 / math_min_ret4;
    local v201 = (v190 + v191) / 2;
    local v202 = (v192 + v193) / 2;
    local v203 = v175 - v201;
    local v204 = v174 - v202;
    local math_sqrt_ret3 = math.sqrt(v176 * v176 + v203 * v203 + v204 * v204);
    local math_clamp_ret = math.clamp(math_sqrt_ret3, v200 / 3.4641016151377535, v200 / 0.01745373558151758);
    local v205 = ZVector - XVector * (v203 / v176);
    local v206 = YVector - XVector * (v204 / v176);
    local v207 = XVector * (math_clamp_ret / v176);
    local math_max_ret5 = math.max(v205.Magnitude, v206.Magnitude, v207.Magnitude);
    p159.face = v168;
    p159.eyeFrame = CFrame.fromMatrix(Position, v205 / math_max_ret5, v206 / math_max_ret5, v207 / math_max_ret5);
    local math_atan_ret = math.atan(v200 / (math_clamp_ret * 2));
    p159.eyeFov = math.deg(math_atan_ret) * 2;
    p159.quadFrame = CFrame.fromMatrix(v180 + ZVector * v201 + YVector * v202 - XVector * (u1.THICKNESS / 2), ZVector, YVector, XVector);
    p159.quadSize = Vector3.new(v198 / math_min_ret4, v200, u1.THICKNESS);
    p159.canvasX = v198;
    p159.canvasY = v199;

    return p159;
end;

return u1;