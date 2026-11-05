  

 

local u1 = require("./utility");
local u8 = {
    getSurfaceCFrame = function(p2, p3, p4) -- Line: 7, Name: getSurfaceCFrame
        local v5 = p3:Dot(Vector3.new(0, 1, 0));
        local v6 = math.abs(v5) > 0.99 and Vector3.new(0, 0, 1) or Vector3.new(0, 1, 0);
        local v7 = CFrame.lookAt(Vector3.new(0, 0, 0), p3, v6);

        return p2 * CFrame.new(p4) * v7;
    end
};

function u8.getPointWithinBox(p9, p10, p11, p12) -- Line: 13
    -- upvalues: u8 (copy)
    debug.profilebegin("getPointWithinBox");
    local v13 = Random.new(p9);
    local v14 = v13:NextNumber(-1, 1);
    local v15 = v13:NextNumber(-1, 1);
    local v16 = Vector3.new(v14, v15, v13:NextNumber(-1, 1)) * (p11 / 2);
    local v17 = u8.getSurfaceCFrame(p10, Vector3.FromNormalId(p12), v16);
    debug.profileend();

    return v17;
end;

function u8.getPointOnBox(p18, p19, p20, p21) -- Line: 34
    -- upvalues: u8 (copy)
    debug.profilebegin("getPointOnBox");
    local v22 = Random.new(p18);
    local v23 = Vector3.FromNormalId(p21);
    local v24 = p20 / 2;
    local v25 = Vector3.new(1, 1, 1) - v23:Abs();
    local v26 = v22:NextNumber(-1, 1);
    local v27 = v22:NextNumber(-1, 1);
    local v28 = Vector3.new(v26, v27, v22:NextNumber(-1, 1)) * v24 * v25;
    local v29 = u8.getSurfaceCFrame(p19, v23, v28 + v23 * v24);
    debug.profileend();

    return v29;
end;

function u8.getPointWithinCylinder(p30, p31, p32, p33, p34, p35) -- Line: 58
    -- upvalues: u1 (copy)
    debug.profilebegin("getPointWithinCylinder");
    local v36 = Random.new(p30);
    local v37 = v36:NextNumber(p31, 1);
    local v38 = math.sqrt(v37);
    local v39 = v36:NextNumber(0, 6.283185307179586);

    if p35 == Enum.NormalId.Left or p35 == Enum.NormalId.Right then
        p33 = p33 * CFrame.fromOrientation(0, 1.5707963267948966 * (p35 == Enum.NormalId.Right and -1 or 1), 0);
        p34 = Vector3.new(p34.Z, p34.Y, p34.X);
    elseif p35 == Enum.NormalId.Front or p35 == Enum.NormalId.Back then
        p33 = p33 * CFrame.fromOrientation(0, 3.141592653589793, 0);
    end;

    local v40 = 1 - v36:NextNumber() ^ u1.lerp(0.5, 1, (math.sqrt(p32)));
    local v41 = u1.lerp(1, p32, v40);
    local v42 = v38 * math.sin(v39) * v41;
    local v43 = v38 * math.cos(v39) * v41;
    local v44 = Vector3.new(v40 * 2 - 1, v42, v43) * p34 / 2;
    local v45 = math.sin(v39) * v41;
    local v46 = math.cos(v39) * v41;
    local v47 = Vector3.new(0, v45, v46) * p34 / 2;
    local v48 = math.cos(v39) * v41;
    local v49 = -math.sin(v39) * v41;
    local v50 = Vector3.new(0, v48, v49) * p34 / 2;
    local v51 = v50.Magnitude > 0.001 and v50.Unit or p33.UpVector;
    local v52 = p33 * CFrame.new(v44) * CFrame.lookAt(Vector3.new(0, 0, 0), v47, v51);
    debug.profileend();

    return v52;
end;

function u8.getPointWithinSphere(p53, p54, p55, p56, p57, p58) -- Line: 108
    -- upvalues: u8 (copy)
    debug.profilebegin("getPointWithinSphere");
    local v59 = Random.new(p53);
    local v60 = v59:NextNumber();
    local v61 = v59:NextNumber();
    local v62 = v60 * 2 * 3.141592653589793;
    local v63 = math.acos(2 * v61 - 1) * p55;
    local v64 = v59:NextNumber(p54, 1) ^ 0.3333333333333333;
    local v65 = math.sin(v62);
    local v66 = math.cos(v62);
    local v67 = math.sin(v63);
    local v68 = math.cos(v63);
    local v69 = Vector3.FromNormalId(p58);

    if p58 == Enum.NormalId.Left or p58 == Enum.NormalId.Right then
        p57 = Vector3.new(p57.Z, p57.Y, p57.X);
    elseif p58 == Enum.NormalId.Top or p58 == Enum.NormalId.Bottom then
        p57 = Vector3.new(p57.X, p57.Z, p57.Y);
    end;

    local v70 = p57 / 2;
    local v71 = u8.getSurfaceCFrame(p56, v69, Vector3.new(0, 0, 0));
    local v72 = Vector3.new(v64 * v67 * v66, v64 * v67 * v65, v64 * v68) * v70;
    local v73 = Vector3.new(-v67 * v65, v67 * v66, 0) * v70;
    local v74 = v73.Magnitude <= 0.001 and Vector3.new(1, 0, 0) or v73.Unit;
    local v75 = v71 * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(v72) * CFrame.lookAt(Vector3.new(0, 0, 0), v72, v74);
    debug.profileend();

    return v75;
end;

function u8.getPointWithinDisc(p76, p77, p78, p79, p80, p81) -- Line: 160
    -- upvalues: u1 (copy), u8 (copy)
    debug.profilebegin("getPointWithinDisc");
    local v82 = Random.new(p76);
    local v83 = Vector3.FromNormalId(p81);
    local v84 = Vector3.new(1, 1, 1) - v83:Abs() * p77;
    local v85 = p80 / 2;
    local v86 = v82:NextNumber(p77, 1);
    local v87 = u1.lerp(1, 0.5, p78 ^ 4);
    local v88 = v82:NextNumber(1 - p78, 1) ^ v87;
    local v89 = v82:NextNumber(0, 6.283185307179586);
    local v90 = v88 * math.sin(v89);
    local v91 = v88 * math.cos(v89);
    local v92 = Vector3.new(v86 * 2 - 1, v90, v91);

    if p81 == Enum.NormalId.Bottom or p81 == Enum.NormalId.Top then
        v92 = Vector3.new(v92.Z, v92.X, v92.Y);
    elseif p81 == Enum.NormalId.Front or p81 == Enum.NormalId.Back then
        v92 = Vector3.new(v92.Y, v92.Z, v92.X);
    end;

    local v93 = u8.getSurfaceCFrame(p79, v83, v92 * (v85 * v84) + v83 * p77 * v85);
    debug.profileend();

    return v93;
end;

return u8;