  

 

local u1 = {
    _type = "Quaternion",
    _TO_STRING_CHAR = nil
};

local function GetType(p2) -- Line: 289
    if p2 == nil then
        return "nil";
    end;

    local v3 = getmetatable(p2);

    if type(v3) == "table" and v3._type ~= nil then
        return tostring(v3._type);
    end;

    return typeof(p2);
end;

local function _safeUnit(p4, p5) -- Line: 299
    if p4.Magnitude > 5e-7 then
        return p4.Unit;
    end;

    return p5;
end;

local function new(p6, p7, p8, p9) -- Line: 315
    -- upvalues: u1 (copy)
    local v10 = setmetatable({
        X = p6 or 0,
        Y = p7 or 0,
        Z = p8 or 0,
        W = p9 or 1,
        _cached = {}
    }, u1);
    table.freeze(v10);

    return v10;
end;

u1.new = new;
u1.identity = new(0, 0, 0, 1);
u1.zero = new(0, 0, 0, 0);

local function _Orthonormalize(p11, p12, p13) -- Line: 335
    local v14 = p11.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or p11.Unit;
    local v15 = v14:Cross(p12.Magnitude <= 5e-7 and Vector3.new(0, 1, 0) or p12.Unit);
    local v16;

    if v15.Magnitude > 5e-7 then
        v16 = v15.Unit;
    else
        local v17 = v14:Cross(Vector3.new(0, 1, 0));
        v16 = v17.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v17.Unit;
    end;

    local Unit = v16:Cross(v14).Unit;

    if v16:Dot(p13) < 0 then
        v16 = -v16;
    end;

    return v14, Unit, v16;
end;

local function _fromOrthonormalizedMatrix(p18, p19, p20) -- Line: 359
    -- upvalues: new (copy)
    local X = p18.X;
    local Y = p18.Y;
    local Z = p18.Z;
    local X2 = p19.X;
    local Y2 = p19.Y;
    local Z2 = p19.Z;
    local X3 = p20.X;
    local Y3 = p20.Y;
    local Z3 = p20.Z;
    local v21 = X + Y2 + Z3;
    local v22, v23, v24, v25;

    if v21 > 0 then
        local v26 = math.sqrt(v21 + 1) * 2;
        v22 = (Z2 - Y3) / v26;
        v23 = (X3 - Z) / v26;
        v24 = (Y - X2) / v26;
        v25 = v26 * 0.25;
    elseif Y2 < X and Z3 < X then
        local v27 = math.sqrt(X + 1 - Y2 - Z3) * 2;
        v22 = v27 * 0.25;
        v23 = (X2 + Y) / v27;
        v24 = (X3 + Z) / v27;
        v25 = (Z2 - Y3) / v27;
    elseif Z3 < Y2 then
        local v28 = math.sqrt(Y2 + 1 - X - Z3) * 2;
        v22 = (X2 + Y) / v28;
        v23 = v28 * 0.25;
        v24 = (Y3 + Z2) / v28;
        v25 = (X3 - Z) / v28;
    else
        local v29 = math.sqrt(Z3 + 1 - X - Y2) * 2;
        v22 = (X3 + Z) / v29;
        v23 = (Y3 + Z2) / v29;
        v24 = v29 * 0.25;
        v25 = (Y - X2) / v29;
    end;

    return new(v22, v23, v24, v25);
end;

function u1.fromAxisAngle(p30, p31) -- Line: 406
    -- upvalues: new (copy)
    local v32 = p30.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or p30.Unit;
    local v33 = p31 / 2;
    local v34 = math.sin(v33);

    return new(v34 * v32.X, v34 * v32.Y, v34 * v32.Z, (math.cos(v33)));
end;

function u1.fromAxisAngleFast(p35, p36) -- Line: 429
    -- upvalues: new (copy)
    local v37 = p36 / 2;
    local v38 = p35 * math.sin(v37);

    return new(v38.X, v38.Y, v38.Z, (math.cos(v37)));
end;

function u1.fromEulerVector(p39) -- Line: 451
    -- upvalues: new (copy), u1 (copy)
    local Magnitude = p39.Magnitude;

    if Magnitude <= 0 then
        return u1.identity;
    end;

    local v40 = Magnitude / 2;
    local v41 = p39 / Magnitude * math.sin(v40);

    return new(v41.X, v41.Y, v41.Z, (math.cos(v40)));
end;

function u1.fromCFrame(p42) -- Line: 471
    -- upvalues: new (copy)
    local v43, v44 = p42:Orthonormalize():ToAxisAngle();
    local v45 = v43.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v43.Unit;
    local v46 = v44 / 2;
    local v47 = math.sin(v46);

    return new(v47 * v45.X, v47 * v45.Y, v47 * v45.Z, (math.cos(v46)));
end;

function u1.fromCFrameFast(p48) -- Line: 486
    -- upvalues: new (copy)
    local v49, v50 = p48:ToAxisAngle();
    local v51 = v50 / 2;
    local v52 = v49 * math.sin(v51);

    return new(v52.X, v52.Y, v52.Z, (math.cos(v51)));
end;

function u1.fromMatrix(p53, p54, p55) -- Line: 501
    -- upvalues: _fromOrthonormalizedMatrix (copy), _Orthonormalize (copy)
    return _fromOrthonormalizedMatrix(_Orthonormalize(p53, p54, p55 or p53:Cross(p54)));
end;

function u1.fromMatrixFast(p56, p57, p58) -- Line: 518
    -- upvalues: _fromOrthonormalizedMatrix (copy)
    return _fromOrthonormalizedMatrix(p56.Unit, p57.Unit, p58 or p56:Cross(p57).Unit);
end;

function u1.lookAt(p59, p60, p61) -- Line: 535
    -- upvalues: _fromOrthonormalizedMatrix (copy)
    local v62 = p60 - p59;
    local v63 = v62.Magnitude <= 5e-7 and Vector3.new(0, 0, 1) or v62.Unit;
    local v64 = p61 or Vector3.new(0, 1, 0);
    local v65 = v63:Cross(v64.Magnitude <= 5e-7 and Vector3.new(0, 1, 0) or v64.Unit);

    if v65.Magnitude > 5e-7 then
        local Unit = v65.Unit;

        return _fromOrthonormalizedMatrix(Unit, Unit:Cross(v63).Unit, -v63);
    end;

    local v66 = v63:Cross(Vector3.new(1, 0, 0));

    if v66.Magnitude > 5e-7 then
        local Unit = v66.Unit;

        return _fromOrthonormalizedMatrix(Unit, Unit:Cross(v63).Unit, -v63);
    end;

    local v67 = (Vector3.new(0, 0, 1)):Cross(v63);
    local v68 = v67 * v67:Dot(Vector3.new(0, 1, 0));

    return _fromOrthonormalizedMatrix(v63:Cross(v68), v68, -v63);
end;

local function fromEulerAnglesXYZ(p69, p70, p71) -- Line: 569
    -- upvalues: new (copy)
    local v72 = math.cos(p69 / 2);
    local v73 = math.sin(p69 / 2);
    local v74 = math.cos(p70 / 2);
    local v75 = math.sin(p70 / 2);
    local v76 = math.cos(p71 / 2);
    local v77 = math.sin(p71 / 2);
    local v78 = v73 * v74;
    local v79 = v72 * v75;
    local v80 = v72 * v74;
    local v81 = v73 * v75;

    return new(v78 * v76 + v79 * v77, v79 * v76 - v78 * v77, v80 * v77 + v81 * v76, v80 * v76 - v81 * v77);
end;

u1.fromEulerAnglesXYZ = fromEulerAnglesXYZ;
u1.Angles = fromEulerAnglesXYZ;

local function fromEulerAnglesYXZ(p82, p83, p84) -- Line: 607
    -- upvalues: new (copy)
    local v85 = math.cos(p82 / 2);
    local v86 = math.sin(p82 / 2);
    local v87 = math.cos(p83 / 2);
    local v88 = math.sin(p83 / 2);
    local v89 = math.cos(p84 / 2);
    local v90 = math.sin(p84 / 2);
    local v91 = v86 * v87;
    local v92 = v85 * v88;
    local v93 = v85 * v87;
    local v94 = v86 * v88;

    return new(v91 * v89 + v92 * v90, v92 * v89 - v91 * v90, v93 * v90 - v94 * v89, v93 * v89 + v94 * v90);
end;

u1.fromEulerAnglesYXZ = fromEulerAnglesYXZ;
u1.fromOrientation = fromEulerAnglesYXZ;

function u1.fromEulerAngles(p95, p96, p97, p98) -- Line: 647
    -- upvalues: new (copy)
    local v99 = p98 or Enum.RotationOrder.XYZ;
    local v100 = math.cos(p95 / 2);
    local v101 = math.cos(p96 / 2);
    local v102 = math.cos(p97 / 2);
    local v103 = math.sin(p95 / 2);
    local v104 = math.sin(p96 / 2);
    local v105 = math.sin(p97 / 2);
    local v106 = v103 * v101;
    local v107 = v100 * v104;
    local v108 = v100 * v101;
    local v109 = v103 * v104;
    local v110 = nil;
    local v111 = nil;
    local v112 = nil;
    local v113 = nil;
    local Name = v99.Name;

    if Name == "XYZ" then
        v110 = v106 * v102 + v107 * v105;
        v111 = v107 * v102 - v106 * v105;
        v112 = v108 * v105 + v109 * v102;
        v113 = v108 * v102 - v109 * v105;
    elseif Name == "YXZ" then
        v110 = v106 * v102 + v107 * v105;
        v111 = v107 * v102 - v106 * v105;
        v112 = v108 * v105 - v109 * v102;
        v113 = v108 * v102 + v109 * v105;
    elseif Name == "ZXY" then
        v110 = v106 * v102 - v107 * v105;
        v111 = v107 * v102 + v106 * v105;
        v112 = v108 * v105 + v109 * v102;
        v113 = v108 * v102 - v109 * v105;
    elseif Name == "ZYX" then
        v110 = v106 * v102 - v107 * v105;
        v111 = v107 * v102 + v106 * v105;
        v112 = v108 * v105 - v109 * v102;
        v113 = v108 * v102 + v109 * v105;
    elseif Name == "YZX" then
        v110 = v106 * v102 + v107 * v105;
        v111 = v107 * v102 + v106 * v105;
        v112 = v108 * v105 - v109 * v102;
        v113 = v108 * v102 - v109 * v105;
    elseif Name == "XZY" then
        v110 = v106 * v102 - v107 * v105;
        v111 = v107 * v102 - v106 * v105;
        v112 = v108 * v105 + v109 * v102;
        v113 = v108 * v102 + v109 * v105;
    end;

    return new(v110, v111, v112, v113);
end;

function u1.fromVector(p114, p115) -- Line: 712
    -- upvalues: new (copy)
    return new(p114.X, p114.Y, p114.Z, p115 or 0);
end;

function u1.RandomQuaternion(p116) -- Line: 725
    -- upvalues: new (copy)
    local u117 = Random.new(p116 or 1);
    local sqrt = math.sqrt;
    local sin = math.sin;
    local cos = math.cos;

    return function() -- Line: 733
        -- upvalues: u117 (copy), sqrt (copy), sin (copy), cos (copy), new (ref)
        local v118 = u117:NextNumber(0, 1);
        local v119 = u117:NextNumber(0, 1);
        local v120 = u117:NextNumber(0, 1);
        local v121 = sqrt(v118);
        local v122 = sqrt(1 - v118);
        local v123 = 6.283185307179586 * v119;
        local v124 = 6.283185307179586 * v120;

        return new(v122 * sin(v123), v122 * cos(v123), v121 * sin(v124), v121 * cos(v124));
    end;
end;

local function Add(p125, p126) -- Line: 888
    -- upvalues: new (copy)
    return new(p125.X + p126.X, p125.Y + p126.Y, p125.Z + p126.Z, p125.W + p126.W);
end;

u1.__add = Add;
u1.Add = Add;

local function Sub(p127, p128) -- Line: 895
    -- upvalues: new (copy)
    return new(p127.X - p128.X, p127.Y - p128.Y, p127.Z - p128.Z, p127.W - p128.W);
end;

u1.__sub = Sub;
u1.Sub = Sub;

local function Mul(p129, p130) -- Line: 902
    -- upvalues: new (copy)
    local X = p129.X;
    local Y = p129.Y;
    local Z = p129.Z;
    local W = p129.W;
    local X2 = p130.X;
    local Y2 = p130.Y;
    local Z2 = p130.Z;
    local W2 = p130.W;

    return new(W * X2 + X * W2 + Y * Z2 - Z * Y2, W * Y2 - X * Z2 + Y * W2 + Z * X2, W * Z2 + X * Y2 - Y * X2 + Z * W2, W * W2 - X * X2 - Y * Y2 - Z * Z2);
end;

u1.__mul = Mul;
u1.Mul = Mul;

function u1.Scale(p131, p132) -- Line: 923
    -- upvalues: new (copy)
    return new(p131.X * p132, p131.Y * p132, p131.Z * p132, p131.W * p132);
end;

function u1.MulCFrameR(p133, p134) -- Line: 935
    return p133:ToCFrame() * p134;
end;

function u1.MulCFrameL(p135, p136) -- Line: 947
    return p136 * p135:ToCFrame();
end;

function u1.RotateVector(p137, p138) -- Line: 959
    -- upvalues: Mul (copy), new (copy)
    return Mul(p137 * new(p138.X, p138.Y, p138.Z, 0), p137:Conjugate()):Vector();
end;

function u1.CombineImaginary(p139, p140) -- Line: 972
    -- upvalues: Mul (copy), new (copy)
    return Mul(new(p140.X, p140.Y, p140.Z, 0), p139);
end;

local function Div(p141, p142) -- Line: 979
    -- upvalues: Mul (copy)
    return Mul(p141, p142:Inverse());
end;

u1.__div = Div;
u1.Div = Div;

function u1.ScaleInv(p143, p144) -- Line: 993
    -- upvalues: new (copy)
    return new(p143.X / p144, p143.Y / p144, p143.Z / p144, p143.W / p144);
end;

local function unm(p145) -- Line: 1000
    -- upvalues: new (copy)
    return new(-p145.X, -p145.Y, -p145.Z, -p145.W);
end;

u1.__unm = unm;
u1.Unm = unm;
u1.Negate = unm;

local function Pow(p146, p147) -- Line: 1008
    -- upvalues: u1 (copy)
    if p147 == -1 then
        return p146:Inverse();
    end;

    local W = p146.W;
    local X = p146.X;
    local Y = p146.Y;
    local Z = p146.Z;
    local v148 = X * X + Y * Y + Z * Z;
    local v149 = math.sqrt(W * W + v148);
    local v150 = math.sqrt(v148);
    local v151 = v149 ^ p147;

    if v150 <= v149 * 5e-7 then
        return u1.new(0, 0, 0, v151);
    end;

    local v152 = p147 * math.atan2(v150, W);
    local v153 = math.cos(v152);
    local v154 = v151 * math.sin(v152);

    return u1.new(v154 * (X / v150), v154 * (Y / v150), v154 * (Z / v150), v151 * v153);
end;

u1.__pow = Pow;
u1.Pow = Pow;

local function eq(p155, p156) -- Line: 1042
    local v157;

    if p155 == nil then
        v157 = "nil";
    else
        local v158 = getmetatable(p155);

        if type(v158) == "table" and v158._type ~= nil then
            v157 = tostring(v158._type);
        else
            v157 = typeof(p155);
        end;
    end;

    local v159;

    if p156 == nil then
        v159 = "nil";
    else
        local v160 = getmetatable(p156);

        if type(v160) == "table" and v160._type ~= nil then
            v159 = tostring(v160._type);
        else
            v159 = typeof(p156);
        end;
    end;

    if v157 ~= "Quaternion" or v159 ~= v157 then
        return false;
    end;

    local v161;

    if p155.X == p156.X and (p155.Y == p156.Y and p155.Z == p156.Z) then
        v161 = p155.W == p156.W;
    else
        v161 = false;
    end;

    return v161;
end;

u1.__eq = eq;
u1.Eq = eq;

local function lt(p162, p163) -- Line: 1056
    return p162:Length() < p163:Length();
end;

u1.__lt = lt;
u1.Lt = lt;

local function le(p164, p165) -- Line: 1066
    return p164:Length() <= p165:Length();
end;

u1.__le = le;
u1.Le = le;

local function Exp(p166) -- Line: 1082
    -- upvalues: new (copy)
    local X = p166.X;
    local Y = p166.Y;
    local Z = p166.Z;
    local v167 = math.exp(p166.W);
    local v168 = X * X + Y * Y + Z * Z;

    if v168 <= 0 then
        return new(0, 0, 0, v167);
    end;

    local v169 = v168 ^ 0.5;
    local v170 = v167 * math.sin(v169) / v169;

    return new(X * v170, Y * v170, Z * v170, v167 * math.cos(v169));
end;

u1.Exp = Exp;

function u1.ExpMap(p171, p172) -- Line: 1105
    -- upvalues: Mul (copy), Exp (copy)
    return Mul(p171, (Exp(p172)));
end;

function u1.ExpMapSym(p173, p174) -- Line: 1118
    -- upvalues: Pow (copy), Mul (copy), Exp (copy)
    local v175 = Pow(p173, 0.5);

    return Mul(Mul(v175, (Exp(p174))), v175);
end;

local function Log(p176) -- Line: 1131
    -- upvalues: new (copy)
    local X = p176.X;
    local Y = p176.Y;
    local Z = p176.Z;
    local W = p176.W;
    local v177 = X * X + Y * Y + Z * Z;
    local v178 = W * W + v177;

    if v178 <= 0 then
        return new(0, 0, 0, (-1 / 0));
    end;

    if v177 <= 0 then
        return new(0, 0, 0, math.log(v178) / 2);
    end;

    local v179 = v178 ^ 0.5;
    local v180 = math.acos(W / v179) / v177 ^ 0.5;

    return new(X * v180, Y * v180, Z * v180, (math.log(v179)));
end;

u1.Log = Log;

function u1.LogMap(p181, p182) -- Line: 1157
    -- upvalues: Log (copy), Mul (copy)
    return Log((Mul(p181:Inverse(), p182)));
end;

function u1.LogMapSym(p183, p184) -- Line: 1170
    -- upvalues: Pow (copy), Log (copy), Mul (copy)
    local v185 = Pow(p183, -0.5);

    return Log((Mul(Mul(v185, p184), v185)));
end;

local function Length(p186) -- Line: 1183
    local X = p186.X;
    local Y = p186.Y;
    local Z = p186.Z;
    local W = p186.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
end;

u1.Length = Length;
u1.__len = Length;

function u1.LengthSquared(p187) -- Line: 1197
    local X = p187.X;
    local Y = p187.Y;
    local Z = p187.Z;
    local W = p187.W;

    return X * X + Y * Y + Z * Z + W * W;
end;

function u1.Hypot(p188) -- Line: 1210
    -- upvalues: new (copy)
    local v189 = math.max(p188.X, p188.Y, p188.Z, p188.W);

    if v189 <= 0 then
        return 0;
    end;

    local v190 = new(p188.X / v189, p188.Y / v189, p188.Z / v189, p188.W / v189);
    local X = v190.X;
    local Y = v190.Y;
    local Z = v190.Z;
    local W = v190.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5 * v189;
end;

function u1.Normalize(p191) -- Line: 1231
    -- upvalues: new (copy), u1 (copy)
    local X = p191.X;
    local Y = p191.Y;
    local Z = p191.Z;
    local W = p191.W;
    local v192 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;

    if v192 > 0 then
        return new(p191.X / v192, p191.Y / v192, p191.Z / v192, p191.W / v192);
    end;

    return u1.identity;
end;

function u1.IsUnit(p193, p194) -- Line: 1249
    local X = p193.X;
    local Y = p193.Y;
    local Z = p193.Z;
    local W = p193.W;

    return (p194 or 5e-7) > math.abs(1 - (X * X + Y * Y + Z * Z + W * W) ^ 0.5);
end;

function u1.ToCFrame(p195, p196) -- Line: 1264
    -- upvalues: new (copy), u1 (copy)
    local X = p195.X;
    local Y = p195.Y;
    local Z = p195.Z;
    local W = p195.W;
    local v197 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v198;

    if v197 > 0 then
        v198 = new(p195.X / v197, p195.Y / v197, p195.Z / v197, p195.W / v197);
    else
        v198 = u1.identity;
    end;

    local v199 = p196 or Vector3.new();

    return CFrame.new(v199.X, v199.Y, v199.Z, v198.X, v198.Y, v198.Z, v198.W);
end;

function u1.Dot(p200, p201) -- Line: 1282
    return p200.X * p201.X + p200.Y * p201.Y + p200.Z * p201.Z + p200.W * p201.W;
end;

function u1.Conjugate(p202) -- Line: 1295
    -- upvalues: new (copy)
    return new(-p202.X, -p202.Y, -p202.Z, p202.W);
end;

function u1.Inverse(p203) -- Line: 1308
    -- upvalues: new (copy)
    local X = p203.X;
    local Y = p203.Y;
    local Z = p203.Z;
    local W = p203.W;
    local v204 = X * X + Y * Y + Z * Z + W * W;

    return new(-p203.X / v204, -p203.Y / v204, -p203.Z / v204, p203.W / v204);
end;

local function Negate(p205) -- Line: 1323
    -- upvalues: new (copy)
    return new(-p205.X, -p205.Y, -p205.Z, -p205.W);
end;

u1.Negate = Negate;
u1.__unm = Negate;

function u1.Difference(p206, p207) -- Line: 1341
    -- upvalues: new (copy), Mul (copy)
    if p206.X * p207.X + p206.Y * p207.Y + p206.Z * p207.Z + p206.W * p207.W < 0 then
        p206 = new(-p206.X, -p206.Y, -p206.Z, -p206.W);
    end;

    local X = p206.X;
    local Y = p206.Y;
    local Z = p206.Z;
    local W = p206.W;
    local v208 = X * X + Y * Y + Z * Z + W * W;

    return Mul(new(-p206.X / v208, -p206.Y / v208, -p206.Z / v208, p206.W / v208), p207);
end;

function u1.Distance(p209, p210) -- Line: 1357
    -- upvalues: Log (copy), Mul (copy)
    local v211 = Log((Mul(p209:Inverse(), p210)));
    local X = v211.X;
    local Y = v211.Y;
    local Z = v211.Z;
    local W = v211.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5 * 2;
end;

function u1.DistanceSym(p212, p213) -- Line: 1370
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p212.X * p213.X + p212.Y * p213.Y + p212.Z * p213.Z + p212.W * p213.W < 0 then
        p212 = new(-p212.X, -p212.Y, -p212.Z, -p212.W);
    end;

    local X = p212.X;
    local Y = p212.Y;
    local Z = p212.Z;
    local W = p212.W;
    local v214 = X * X + Y * Y + Z * Z + W * W;
    local v215 = Log((Mul(new(-p212.X / v214, -p212.Y / v214, -p212.Z / v214, p212.W / v214), p213)));
    local X2 = v215.X;
    local Y2 = v215.Y;
    local Z2 = v215.Z;
    local W2 = v215.W;

    return (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2;
end;

function u1.DistanceChord(p216, p217) -- Line: 1383
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p216.X * p217.X + p216.Y * p217.Y + p216.Z * p217.Z + p216.W * p217.W < 0 then
        p216 = new(-p216.X, -p216.Y, -p216.Z, -p216.W);
    end;

    local X = p216.X;
    local Y = p216.Y;
    local Z = p216.Z;
    local W = p216.W;
    local v218 = X * X + Y * Y + Z * Z + W * W;
    local v219 = Log((Mul(new(-p216.X / v218, -p216.Y / v218, -p216.Z / v218, p216.W / v218), p217)));
    local X2 = v219.X;
    local Y2 = v219.Y;
    local Z2 = v219.Z;
    local W2 = v219.W;

    return math.sin((X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2 / 2) * 2;
end;

function u1.DistanceAbs(p220, p221) -- Line: 1396
    -- upvalues: new (copy)
    local v222 = new(p220.X - p221.X, p220.Y - p221.Y, p220.Z - p221.Z, p220.W - p221.W);
    local v223 = new(p220.X + p221.X, p220.Y + p221.Y, p220.Z + p221.Z, p220.W + p221.W);
    local X = v222.X;
    local Y = v222.Y;
    local Z = v222.Z;
    local W = v222.W;
    local v224 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local X2 = v223.X;
    local Y2 = v223.Y;
    local Z2 = v223.Z;
    local W2 = v223.W;
    local v225 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;

    if v224 < v225 then
        return v224;
    end;

    return v225;
end;

function u1.Slerp(p226, p227, p228) -- Line: 1418
    -- upvalues: new (copy), u1 (copy)
    local X = p226.X;
    local Y = p226.Y;
    local Z = p226.Z;
    local W = p226.W;
    local v229 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v230;

    if v229 > 0 then
        v230 = new(p226.X / v229, p226.Y / v229, p226.Z / v229, p226.W / v229);
    else
        v230 = u1.identity;
    end;

    local X2 = p227.X;
    local Y2 = p227.Y;
    local Z2 = p227.Z;
    local W2 = p227.W;
    local v231 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;
    local v232;

    if v231 > 0 then
        v232 = new(p227.X / v231, p227.Y / v231, p227.Z / v231, p227.W / v231);
    else
        v232 = u1.identity;
    end;

    local v233 = v230.X * v232.X + v230.Y * v232.Y + v230.Z * v232.Z + v230.W * v232.W;

    if v233 < 0 then
        v230 = new(-v230.X, -v230.Y, -v230.Z, -v230.W);
        v233 = -v233;
    end;

    if v233 >= 1 then
        local v234 = new(v232.X - v230.X, v232.Y - v230.Y, v232.Z - v230.Z, v232.W - v230.W);
        local v235 = new(v234.X * p228, v234.Y * p228, v234.Z * p228, v234.W * p228);
        local v236 = new(v230.X + v235.X, v230.Y + v235.Y, v230.Z + v235.Z, v230.W + v235.W);
        local X3 = v236.X;
        local Y3 = v236.Y;
        local Z3 = v236.Z;
        local W3 = v236.W;
        local v237 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

        if v237 > 0 then
            return new(v236.X / v237, v236.Y / v237, v236.Z / v237, v236.W / v237);
        end;

        return u1.identity;
    end;

    local v238 = math.acos(v233);
    local v239 = math.sin(v238);
    local v240 = v238 * p228;
    local v241 = math.sin(v240);
    local v242 = math.cos(v240) - v233 * v241 / v239;
    local v243 = v241 / v239;
    local v244 = new(v230.X * v242, v230.Y * v242, v230.Z * v242, v230.W * v242);
    local v245 = new(v232.X * v243, v232.Y * v243, v232.Z * v243, v232.W * v243);
    local v246 = new(v244.X + v245.X, v244.Y + v245.Y, v244.Z + v245.Z, v244.W + v245.W);
    local X3 = v246.X;
    local Y3 = v246.Y;
    local Z3 = v246.Z;
    local W3 = v246.W;
    local v247 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

    if v247 > 0 then
        return new(v246.X / v247, v246.Y / v247, v246.Z / v247, v246.W / v247);
    end;

    return u1.identity;
end;

function u1.IdentitySlerp(p248, p249) -- Line: 1456
    -- upvalues: Pow (copy)
    if p248.W < 0 then
        return -Pow(-p248, p249);
    end;

    return Pow(p248, p249);
end;

local function SlerpFunction(p250, p251) -- Line: 1474
    -- upvalues: new (copy), u1 (copy)
    local v252 = p250;
    local X = v252.X;
    local Y = v252.Y;
    local Z = v252.Z;
    local W = v252.W;
    local v253 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local u254;

    if v253 > 0 then
        u254 = new(v252.X / v253, v252.Y / v253, v252.Z / v253, v252.W / v253);
    else
        u254 = u1.identity;
    end;

    local v255 = p251;
    local X2 = v255.X;
    local Y2 = v255.Y;
    local Z2 = v255.Z;
    local W2 = v255.W;
    local v256 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;
    local u257;

    if v256 > 0 then
        u257 = new(v255.X / v256, v255.Y / v256, v255.Z / v256, v255.W / v256);
    else
        u257 = u1.identity;
    end;

    local v258 = u257;
    local u259 = u254.X * v258.X + u254.Y * v258.Y + u254.Z * v258.Z + u254.W * v258.W;

    if u259 < 0 then
        u254 = new(-u254.X, -u254.Y, -u254.Z, -u254.W);
        u259 = -u259;
    end;

    if u259 < 1 then
        local u260 = math.acos(u259);
        local u261 = math.sin(u260);

        return function(p262) -- Line: 1496
            -- upvalues: u260 (copy), u259 (ref), u261 (copy), u254 (ref), new (ref), u257 (ref), u1 (ref)
            local v263 = u260 * p262;
            local v264 = math.sin(v263);
            local v265 = math.cos(v263) - u259 * v264 / u261;
            local v266 = v264 / u261;
            local v267 = u254;
            local v268 = new(v267.X * v265, v267.Y * v265, v267.Z * v265, v267.W * v265);
            local v269 = u257;
            local v270 = new(v269.X * v266, v269.Y * v266, v269.Z * v266, v269.W * v266);
            local v271 = new(v268.X + v270.X, v268.Y + v270.Y, v268.Z + v270.Z, v268.W + v270.W);
            local X3 = v271.X;
            local Y3 = v271.Y;
            local Z3 = v271.Z;
            local W3 = v271.W;
            local v272 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

            if v272 > 0 then
                return new(v271.X / v272, v271.Y / v272, v271.Z / v272, v271.W / v272);
            end;

            return u1.identity;
        end;
    end;

    local v273 = u257;
    local v274 = u254;
    local u275 = new(v273.X - v274.X, v273.Y - v274.Y, v273.Z - v274.Z, v273.W - v274.W);

    return function(p276) -- Line: 1488
        -- upvalues: u254 (ref), u275 (copy), new (ref), u1 (ref)
        local v277 = u254;
        local v278 = u275;
        local v279 = new(v278.X * p276, v278.Y * p276, v278.Z * p276, v278.W * p276);
        local v280 = new(v277.X + v279.X, v277.Y + v279.Y, v277.Z + v279.Z, v277.W + v279.W);
        local X3 = v280.X;
        local Y3 = v280.Y;
        local Z3 = v280.Z;
        local W3 = v280.W;
        local v281 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

        if v281 > 0 then
            return new(v280.X / v281, v280.Y / v281, v280.Z / v281, v280.W / v281);
        end;

        return u1.identity;
    end;
end;

u1.SlerpFunction = SlerpFunction;

function u1.Intermediates(p282, p283, p284, p285) -- Line: 1516
    -- upvalues: SlerpFunction (copy)
    local v286 = p285 or false;
    local v287 = 1 / (p284 + 1);
    local v288 = SlerpFunction(p282, p283);
    local v289 = v286 and { p282 } or {};

    for i = 1, p284 do
        local v290 = v288(v287 * i);
        table.insert(v289, v290);
    end;

    if v286 then
        table.insert(v289, p283);
    end;

    return v289;
end;

function u1.Derivative(p291, p292) -- Line: 1548
    -- upvalues: Mul (copy), new (copy)
    return Mul(new(p291.X * 0.5, p291.Y * 0.5, p291.Z * 0.5, p291.W * 0.5), (new(p292.X, p292.Y, p292.Z, 0)));
end;

function u1.Integrate(p293, p294, p295) -- Line: 1563
    -- upvalues: new (copy), u1 (copy), Mul (copy)
    local X = p293.X;
    local Y = p293.Y;
    local Z = p293.Z;
    local W = p293.W;
    local v296 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v297;

    if v296 > 0 then
        v297 = new(p293.X / v296, p293.Y / v296, p293.Z / v296, p293.W / v296);
    else
        v297 = u1.identity;
    end;

    local v298 = p294 * p295;
    local Magnitude = v298.Magnitude;

    if Magnitude <= 0 then
        return v297;
    end;

    local v299 = v298 / Magnitude;
    local v300 = v299.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v299.Unit;
    local v301 = Magnitude / 2;
    local v302 = math.sin(v301);
    local v303 = Mul(v297, (new(v302 * v300.X, v302 * v300.Y, v302 * v300.Z, (math.cos(v301)))));
    local X2 = v303.X;
    local Y2 = v303.Y;
    local Z2 = v303.Z;
    local W2 = v303.W;
    local v304 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;

    if v304 > 0 then
        return new(v303.X / v304, v303.Y / v304, v303.Z / v304, v303.W / v304);
    end;

    return u1.identity;
end;

function u1.AngularVelocity(p305, p306, p307) -- Line: 1588
    if p307 > 0 then
        return p305:Difference(p306):ToEulerVector() / p307;
    end;

    return Vector3.new();
end;

function u1.MinimalRotation(p308, p309) -- Line: 1607
    -- upvalues: new (copy)
    local _, v310, _ = p308:ToMatrixVectors();
    local _, v311, _ = p309:ToMatrixVectors();
    local v312 = v310:Cross(v311);
    local Magnitude = v312.Magnitude;
    local v313 = v310:Dot(v311);
    local v314 = math.atan2(Magnitude, v313);
    local v315 = v312.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v312.Unit;
    local v316 = v314 / 2;
    local v317 = math.sin(v316);

    return new(v317 * v315.X, v317 * v315.Y, v317 * v315.Z, (math.cos(v316)));
end;

function u1.ApproxEq(p318, p319, p320) -- Line: 1624
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p318.X * p319.X + p318.Y * p319.Y + p318.Z * p319.Z + p318.W * p319.W < 0 then
        p318 = new(-p318.X, -p318.Y, -p318.Z, -p318.W);
    end;

    local X = p318.X;
    local Y = p318.Y;
    local Z = p318.Z;
    local W = p318.W;
    local v321 = X * X + Y * Y + Z * Z + W * W;
    local v322 = Log((Mul(new(-p318.X / v321, -p318.Y / v321, -p318.Z / v321, p318.W / v321), p319)));
    local X2 = v322.X;
    local Y2 = v322.Y;
    local Z2 = v322.Z;
    local W2 = v322.W;

    return (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2 < (p320 or 5e-7);
end;

function u1.IsNaN(p323) -- Line: 1637
    local X = p323.X;
    local Y = p323.Y;
    local Z = p323.Z;
    local W = p323.W;

    return (X ~= X or (Y ~= Y or Z ~= Z)) and true or W ~= W;
end;

local function _toRotationMatrix(p324) -- Line: 1644
    -- upvalues: new (copy), u1 (copy)
    local X = p324.X;
    local Y = p324.Y;
    local Z = p324.Z;
    local W = p324.W;
    local v325 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v326;

    if v325 > 0 then
        v326 = new(p324.X / v325, p324.Y / v325, p324.Z / v325, p324.W / v325);
    else
        v326 = u1.identity;
    end;

    local X2 = v326.X;
    local Y2 = v326.Y;
    local Z2 = v326.Z;
    local W2 = v326.W;
    local v327 = X2 * X2;
    local v328 = Y2 * Y2;
    local v329 = Z2 * Z2;
    local v330 = W2 * W2;
    local v331 = X2 * Y2;
    local v332 = Z2 * W2;
    local v333 = X2 * Z2;
    local v334 = Y2 * W2;
    local v335 = Y2 * Z2;
    local v336 = X2 * W2;

    return v327 - v328 - v329 + v330, 2 * (v331 - v332), 2 * (v333 + v334), 2 * (v331 + v332), -v327 + v328 - v329 + v330, 2 * (v335 - v336), 2 * (v333 - v334), 2 * (v335 + v336), -v327 - v328 + v329 + v330;
end;

function u1.ToAxisAngle(p337) -- Line: 1682
    -- upvalues: new (copy), u1 (copy)
    local X = p337.X;
    local Y = p337.Y;
    local Z = p337.Z;
    local W = p337.W;
    local v338 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v339;

    if v338 > 0 then
        v339 = new(p337.X / v338, p337.Y / v338, p337.Z / v338, p337.W / v338);
    else
        v339 = u1.identity;
    end;

    local X2 = v339.X;
    local Y2 = v339.Y;
    local Z2 = v339.Z;
    local W2 = v339.W;
    local v340 = math.acos(W2) * 2;
    local v341 = math.sqrt(1 - W2 * W2);

    if v341 < 5e-7 then
        return Vector3.new(X2, Y2, Z2), v340;
    end;

    return Vector3.new(X2 / v341, Y2 / v341, Z2 / v341), v340;
end;

function u1.ToEulerVector(p342) -- Line: 1705
    -- upvalues: new (copy), u1 (copy)
    local X = p342.X;
    local Y = p342.Y;
    local Z = p342.Z;
    local W = p342.W;
    local v343 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v344;

    if v343 > 0 then
        v344 = new(p342.X / v343, p342.Y / v343, p342.Z / v343, p342.W / v343);
    else
        v344 = u1.identity;
    end;

    local X2 = v344.X;
    local Y2 = v344.Y;
    local Z2 = v344.Z;
    local W2 = v344.W;
    local v345 = math.acos(W2) * 2;
    local v346 = math.sqrt(1 - W2 * W2);

    if v346 < 5e-7 then
        return Vector3.new(X2, Y2, Z2) * v345;
    end;

    return Vector3.new(X2 / v346, Y2 / v346, Z2 / v346) * v345;
end;

function u1.ToMatrix(p347) -- Line: 1729
    -- upvalues: _toRotationMatrix (copy)
    return _toRotationMatrix(p347);
end;

function u1.ToMatrixVectors(p348) -- Line: 1744
    -- upvalues: _toRotationMatrix (copy)
    local v349, v350, v351, v352, v353, v354, v355, v356, v357 = _toRotationMatrix(p348);

    return Vector3.new(v349, v352, v355), Vector3.new(v350, v353, v356), Vector3.new(v351, v354, v357);
end;

function u1.Vector(p358) -- Line: 1759
    return Vector3.new(p358.X, p358.Y, p358.Z);
end;

function u1.Real(p359) -- Line: 1772
    -- upvalues: new (copy)
    return new(0, 0, 0, p359.W);
end;

function u1.Imaginary(p360) -- Line: 1785
    -- upvalues: new (copy)
    return new(p360.X, p360.Y, p360.Z, 0);
end;

local function ToEulerAnglesXYZ(p361) -- Line: 1798
    -- upvalues: new (copy), u1 (copy)
    local X = p361.X;
    local Y = p361.Y;
    local Z = p361.Z;
    local W = p361.W;
    local v362 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v363;

    if v362 > 0 then
        v363 = new(p361.X / v362, p361.Y / v362, p361.Z / v362, p361.W / v362);
    else
        v363 = u1.identity;
    end;

    local X2 = v363.X;
    local Y2 = v363.Y;
    local Z2 = v363.Z;
    local W2 = v363.W;
    local v364 = Y2 * W2 + X2 * Z2;

    if math.abs(v364) > 0.4999995 then
        local v365 = v364 > 0 and 1 or -1;

        return v365 * 2 * math.atan2(Z2, W2), v365 * 3.141592653589793 / 2, 0;
    end;

    local v366 = Y2 * Y2;

    return math.atan2(2 * (X2 * W2 - Y2 * Z2), 1 - 2 * (X2 * X2 + v366)), math.asin(2 * v364), math.atan2(2 * (Z2 * W2 - X2 * Y2), 1 - 2 * (Z2 * Z2 + v366));
end;

local function ToEulerAnglesYXZ(p367) -- Line: 1849
    -- upvalues: new (copy), u1 (copy)
    local X = p367.X;
    local Y = p367.Y;
    local Z = p367.Z;
    local W = p367.W;
    local v368 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v369;

    if v368 > 0 then
        v369 = new(p367.X / v368, p367.Y / v368, p367.Z / v368, p367.W / v368);
    else
        v369 = u1.identity;
    end;

    local X2 = v369.X;
    local Y2 = v369.Y;
    local Z2 = v369.Z;
    local W2 = v369.W;
    local v370 = X2 * W2 - Y2 * Z2;

    if math.abs(v370) > 0.4999995 then
        local v371 = v370 >= 0 and 1 or -1;

        return v371 * 3.141592653589793 / 2, v371 * 2 * -math.atan2(Z2, W2), 0;
    end;

    local v372 = X2 * X2;

    return math.asin(2 * v370), math.atan2(2 * (X2 * Z2 + Y2 * W2), 1 - 2 * (Y2 * Y2 + v372)), math.atan2(2 * (X2 * Y2 + Z2 * W2), 1 - 2 * (Z2 * Z2 + v372));
end;

local u397 = {
    XYZ = ToEulerAnglesXYZ,

    XZY = function(p373) -- Line: 1820, Name: ToEulerAnglesXZY
        -- upvalues: new (copy), u1 (copy)
        local X = p373.X;
        local Y = p373.Y;
        local Z = p373.Z;
        local W = p373.W;
        local v374 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v375;

        if v374 > 0 then
            v375 = new(p373.X / v374, p373.Y / v374, p373.Z / v374, p373.W / v374);
        else
            v375 = u1.identity;
        end;

        local X2 = v375.X;
        local Y2 = v375.Y;
        local Z2 = v375.Z;
        local W2 = v375.W;
        local v376 = Z2 * W2 - X2 * Y2;

        if math.abs(v376) > 0.4999995 then
            local v377 = v376 >= 0 and 1 or -1;

            return v377 * 2 * -math.atan2(Y2, W2), 0, v377 * 3.141592653589793 / 2;
        end;

        local v378 = Z2 * Z2;

        return math.atan2(2 * (X2 * W2 + Y2 * Z2), 1 - 2 * (X2 * X2 + v378)), math.atan2(2 * (X2 * Z2 + Y2 * W2), 1 - 2 * (Y2 * Y2 + v378)), math.asin(2 * v376);
    end,

    YZX = function(p379) -- Line: 1871, Name: ToEulerAnglesYZX
        -- upvalues: new (copy), u1 (copy)
        local X = p379.X;
        local Y = p379.Y;
        local Z = p379.Z;
        local W = p379.W;
        local v380 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v381;

        if v380 > 0 then
            v381 = new(p379.X / v380, p379.Y / v380, p379.Z / v380, p379.W / v380);
        else
            v381 = u1.identity;
        end;

        local X2 = v381.X;
        local Y2 = v381.Y;
        local Z2 = v381.Z;
        local W2 = v381.W;
        local v382 = Z2 * W2 + X2 * Y2;

        if math.abs(v382) > 0.4999995 then
            local v383 = v382 >= 0 and 1 or -1;

            return 0, v383 * 2 * math.atan2(X2, W2), v383 * 3.141592653589793 / 2;
        end;

        local v384 = Z2 * Z2;

        return math.atan2(2 * (X2 * W2 - Y2 * Z2), 1 - 2 * (X2 * X2 + v384)), math.atan2(2 * (Y2 * W2 - X2 * Z2), 1 - 2 * (Y2 * Y2 + v384)), math.asin(2 * v382);
    end,

    YXZ = ToEulerAnglesYXZ,

    ZXY = function(p385) -- Line: 1893, Name: ToEulerAnglesZXY
        -- upvalues: new (copy), u1 (copy)
        local X = p385.X;
        local Y = p385.Y;
        local Z = p385.Z;
        local W = p385.W;
        local v386 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v387;

        if v386 > 0 then
            v387 = new(p385.X / v386, p385.Y / v386, p385.Z / v386, p385.W / v386);
        else
            v387 = u1.identity;
        end;

        local X2 = v387.X;
        local Y2 = v387.Y;
        local Z2 = v387.Z;
        local W2 = v387.W;
        local v388 = X2 * W2 + Y2 * Z2;

        if math.abs(v388) > 0.4999995 then
            local v389 = v388 >= 0 and 1 or -1;

            return v389 * 3.141592653589793 / 2, 0, v389 * 2 * math.atan2(Y2, W2);
        end;

        local v390 = X2 * X2;

        return math.asin(2 * v388), math.atan2(2 * (Y2 * W2 - X2 * Z2), 1 - 2 * (Y2 * Y2 + v390)), math.atan2(2 * (Z2 * W2 - X2 * Y2), 1 - 2 * (Z2 * Z2 + v390));
    end,

    ZYX = function(p391) -- Line: 1915, Name: ToEulerAnglesZYX
        -- upvalues: new (copy), u1 (copy)
        local X = p391.X;
        local Y = p391.Y;
        local Z = p391.Z;
        local W = p391.W;
        local v392 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v393;

        if v392 > 0 then
            v393 = new(p391.X / v392, p391.Y / v392, p391.Z / v392, p391.W / v392);
        else
            v393 = u1.identity;
        end;

        local X2 = v393.X;
        local Y2 = v393.Y;
        local Z2 = v393.Z;
        local W2 = v393.W;
        local v394 = Y2 * W2 - X2 * Z2;

        if math.abs(v394) > 0.4999995 then
            local v395 = v394 >= 0 and 1 or -1;

            return 0, v395 * 3.141592653589793 / 2, v395 * 2 * -math.atan2(X2, W2);
        end;

        local v396 = Y2 * Y2;

        return math.atan2(2 * (X2 * W2 + Y2 * Z2), 1 - 2 * (X2 * X2 + v396)), math.asin(2 * v394), math.atan2(2 * (X2 * Y2 + Z2 * W2), 1 - 2 * (Z2 * Z2 + v396));
    end
};

function u1.ToEulerAngles(p398, p399) -- Line: 1954
    -- upvalues: u397 (copy)
    return u397[(p399 or Enum.RotationOrder.XYZ).Name](p398);
end;

u1.ToEulerAnglesXYZ = ToEulerAnglesXYZ;
u1.ToEulerAnglesYXZ = ToEulerAnglesYXZ;
u1.ToOrientation = ToEulerAnglesYXZ;

local function GetComponents(p400) -- Line: 1977
    return p400.X, p400.Y, p400.Z, p400.W;
end;

u1.GetComponents = GetComponents;
u1.components = GetComponents;

local function round(p401, p402) -- Line: 1990
    if not p402 then
        return tostring(p401);
    end;

    local v403 = math.max(0, p402);
    local v404 = string.format("%%.%df", v403);

    return string.format(v404, p401);
end;

local function ToString(p405, p406) -- Line: 2008
    -- upvalues: u1 (copy)
    if u1._TO_STRING_CHAR then
        p406 = u1._TO_STRING_CHAR;
    end;

    local X = p405.X;
    local v407;

    if p406 then
        local v408 = math.max(0, p406);
        local v409 = string.format("%%.%df", v408);
        v407 = string.format(v409, X);
    else
        v407 = tostring(X);
    end;

    local Y = p405.Y;
    local v410;

    if p406 then
        local v411 = math.max(0, p406);
        local v412 = string.format("%%.%df", v411);
        v410 = string.format(v412, Y);
    else
        v410 = tostring(Y);
    end;

    local Z = p405.Z;
    local v413;

    if p406 then
        local v414 = math.max(0, p406);
        local v415 = string.format("%%.%df", v414);
        v413 = string.format(v415, Z);
    else
        v413 = tostring(Z);
    end;

    local W = p405.W;
    local v416;

    if p406 then
        local v417 = math.max(0, p406);
        local v418 = string.format("%%.%df", v417);
        v416 = string.format(v418, W);
    else
        v416 = tostring(W);
    end;

    return v407 .. ", " .. v410 .. ", " .. v413 .. ", " .. v416;
end;

u1.__tostring = ToString;
u1.ToString = ToString;

function u1.__index(p419, p420) -- Line: 2023
    -- upvalues: u1 (copy), new (copy)
    local v421 = u1[p420];

    if v421 then
        return v421;
    end;

    local v422 = string.lower(p420);
    local v423 = rawget(p419, "_cached");

    if v422 == "unit" then
        if v423.unit then
            return v423.unit;
        end;

        local X = p419.X;
        local Y = p419.Y;
        local Z = p419.Z;
        local W = p419.W;
        local v424 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v425;

        if v424 > 0 then
            v425 = new(p419.X / v424, p419.Y / v424, p419.Z / v424, p419.W / v424);
        else
            v425 = u1.identity;
        end;

        v423.unit = v425;

        return v425;
    end;

    if v422 ~= "magnitude" then
        return nil;
    end;

    if v423.magnitude then
        return v423.magnitude;
    end;

    local X = p419.X;
    local Y = p419.Y;
    local Z = p419.Z;
    local W = p419.W;
    local v426 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    v423.magnitude = v426;

    return v426;
end;

function u1.__newindex(p427, p428) -- Line: 2048
    error(tostring(p428) .. " cannot be assigned to");
end;

table.freeze(u1);

return u1;