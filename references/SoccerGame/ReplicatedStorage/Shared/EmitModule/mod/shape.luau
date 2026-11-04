  

local u1 = require("./utility");
local u7 = {
    getSurfaceCFrame = function(p2, p3: vector, p4: vector) -- Line: 7, Name: getSurfaceCFrame
        local v5 = p3:Dot(Vector3.new(0, 1, 0));
        local v6 = math.abs(v5) > 0.99 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0);
        local CFrame_lookAt_ret = CFrame.lookAt(Vector3.new(0, 0, 0), p3, v6);

        return p2 * CFrame.new(p4) * CFrame_lookAt_ret;
    end
};

function u7.getPointWithinBox(p8: number, p9, p10: vector, p11: any) -- Line: 13
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointWithinBox");
    local Random_new_ret = Random.new(p8);
    local v12 = Random_new_ret:NextNumber(-1, 1);
    local v13 = Random_new_ret:NextNumber(-1, 1);
    local v14 = Vector3.new(v12, v13, Random_new_ret:NextNumber(-1, 1)) * (p10 / 2);
    local SurfaceCFrame = u7.getSurfaceCFrame(p9, Vector3.FromNormalId(p11), v14);
    debug.profileend();

    return SurfaceCFrame;
end;

function u7.getPointOnBox(p15: number, p16, p17: vector, p18: any) -- Line: 34
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointOnBox");
    local Random_new_ret = Random.new(p15);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p18);
    local v19 = p17 / 2;
    local v20 = Vector3.new(1, 1, 1) - Vector3_FromNormalId_ret:Abs();
    local v21 = Random_new_ret:NextNumber(-1, 1);
    local v22 = Random_new_ret:NextNumber(-1, 1);
    local v23 = Vector3.new(v21, v22, Random_new_ret:NextNumber(-1, 1)) * v19 * v20;
    local SurfaceCFrame = u7.getSurfaceCFrame(p16, Vector3_FromNormalId_ret, v23 + Vector3_FromNormalId_ret * v19);
    debug.profileend();

    return SurfaceCFrame;
end;

function u7.getPointWithinCylinder(p24: number, p25: number, p26: number, p27, p28: vector, p29: any) -- Line: 58
    -- upvalues: u1 (copy)
    debug.profilebegin("getPointWithinCylinder");
    local Random_new_ret = Random.new(p24);
    local v30 = Random_new_ret:NextNumber(p25, 1);
    local math_sqrt_ret = math.sqrt(v30);
    local v31 = Random_new_ret:NextNumber(0, 6.283185307179586);

    if p29 == Enum.NormalId.Left or p29 == Enum.NormalId.Right then
        p27 = p27 * CFrame.fromOrientation(0, 1.5707963267948966 * (p29 == Enum.NormalId.Right and -1 or 1), 0);
        p28 = Vector3.new(p28.Z, p28.Y, p28.X);
    elseif p29 == Enum.NormalId.Front or p29 == Enum.NormalId.Back then
        p27 = p27 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    local v32 = 1 - Random_new_ret:NextNumber() ^ u1.lerp(0.5, 1, (math.sqrt(p26)));
    local v33 = u1.lerp(1, p26, v32);
    local v34 = math_sqrt_ret * math.sin(v31) * v33;
    local v35 = math_sqrt_ret * math.cos(v31) * v33;
    local v36 = Vector3.new(v32 * 2 - 1, v34, v35) * p28 / 2;
    local v37 = math.sin(v31) * v33;
    local v38 = math.cos(v31) * v33;
    local v39 = Vector3.new(0, v37, v38) * p28 / 2;
    local Unit = v39.Unit;
    local UpVector = p27.UpVector;

    if math.abs((Unit ~= Unit and Vector3.new(0, 0, 0) or Unit).Y) > 0.999 then
        if p29 == Enum.NormalId.Left or p29 == Enum.NormalId.Right then
            UpVector = p27.RightVector;
        else
            UpVector = p27.LookVector;
        end;
    end;

    local v40 = p27 * CFrame.new(v36) * CFrame.lookAt(Vector3.new(0, 0, 0), v39, UpVector);
    debug.profileend();

    return v40;
end;

function u7.getPointWithinSphere(p41: number, p42: number, p43: number, p44, p45: vector, p46: any) -- Line: 121
    -- upvalues: u7 (copy)
    debug.profilebegin("getPointWithinSphere");
    local Random_new_ret = Random.new(p41);
    local v47 = Random_new_ret:NextNumber();
    local v48 = Random_new_ret:NextNumber();
    local v49 = v47 * 2 * 3.141592653589793;
    local v50 = math.acos(2 * v48 - 1) * p43;
    local v51 = Random_new_ret:NextNumber(p42, 1) ^ 0.3333333333333333;
    local math_sin_ret = math.sin(v49);
    local math_cos_ret = math.cos(v49);
    local math_sin_ret2 = math.sin(v50);
    local math_cos_ret2 = math.cos(v50);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p46);

    if p46 == Enum.NormalId.Left or p46 == Enum.NormalId.Right then
        p45 = Vector3.new(p45.Z, p45.Y, p45.X);
    elseif p46 == Enum.NormalId.Top or p46 == Enum.NormalId.Bottom then
        p45 = Vector3.new(p45.X, p45.Z, p45.Y);
    end;

    local SurfaceCFrame = u7.getSurfaceCFrame(p44, Vector3_FromNormalId_ret, Vector3.new(0, 0, 0));
    local v52 = Vector3.new(v51 * math_sin_ret2 * math_cos_ret, v51 * math_sin_ret2 * math_sin_ret, v51 * math_cos_ret2) * (p45 / 2);
    local Unit = v52.Unit;
    local UpVector = p44.UpVector;

    if math.abs((Unit ~= Unit and Vector3.new(0, 0, 0) or Unit).Y) > 0.999 then
        if p46 == Enum.NormalId.Left or p46 == Enum.NormalId.Right then
            UpVector = p44.RightVector;
        else
            UpVector = p44.LookVector;
        end;
    end;

    local v53 = SurfaceCFrame * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(v52) * CFrame.lookAt(Vector3.new(0, 0, 0), v52, UpVector);
    debug.profileend();

    return v53;
end;

function u7.getPointWithinDisc(p54: number, p55: number, p56: number, p57, p58: vector, p59: any) -- Line: 189
    -- upvalues: u1 (copy), u7 (copy)
    debug.profilebegin("getPointWithinDisc");
    local Random_new_ret = Random.new(p54);
    local Vector3_FromNormalId_ret = Vector3.FromNormalId(p59);
    local v60 = Vector3.new(1, 1, 1) - Vector3_FromNormalId_ret:Abs() * p55;
    local v61 = p58 / 2;
    local v62 = Random_new_ret:NextNumber(p55, 1);
    local v63 = u1.lerp(1, 0.5, p56 ^ 4);
    local v64 = Random_new_ret:NextNumber(1 - p56, 1) ^ v63;
    local v65 = Random_new_ret:NextNumber(0, 6.283185307179586);
    local v66 = v64 * math.sin(v65);
    local v67 = v64 * math.cos(v65);
    local Vector3_new_ret = Vector3.new(v62 * 2 - 1, v66, v67);

    if p59 == Enum.NormalId.Bottom or p59 == Enum.NormalId.Top then
        Vector3_new_ret = Vector3.new(Vector3_new_ret.Z, Vector3_new_ret.X, Vector3_new_ret.Y);
    elseif p59 == Enum.NormalId.Front or p59 == Enum.NormalId.Back then
        Vector3_new_ret = Vector3.new(Vector3_new_ret.Y, Vector3_new_ret.Z, Vector3_new_ret.X);
    end;

    local SurfaceCFrame = u7.getSurfaceCFrame(p57, Vector3_FromNormalId_ret, Vector3_new_ret * (v61 * v60) + Vector3_FromNormalId_ret * p55 * v61);
    debug.profileend();

    return SurfaceCFrame;
end;

return u7;