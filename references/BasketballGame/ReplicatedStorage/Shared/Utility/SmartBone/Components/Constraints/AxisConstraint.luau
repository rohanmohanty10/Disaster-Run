 
 

local function SafeUnit(p1) -- Line: 1
    return p1.Magnitude == 0 and Vector3.new(0, 0, 0) or p1.Unit;
end;

return function(p2, p3, p4, p5) -- Line: 9
    debug.profilebegin("Axis Constraint");
    local v6 = p5:Inverse() * p3;
    local X = v6.X;
    local Y = v6.Y;
    local Z = v6.Z;
    local XAxisLimits = p2.XAxisLimits;
    local YAxisLimits = p2.YAxisLimits;
    local ZAxisLimits = p2.ZAxisLimits;
    local v7 = XAxisLimits.Min + p2.Radius;
    local v8;

    if v7 <= XAxisLimits.Max - p2.Radius then
        v8 = XAxisLimits.Max - p2.Radius or v7;
    else
        v8 = v7;
    end;

    local v9 = YAxisLimits.Min + p2.Radius;
    local v10;

    if v9 <= YAxisLimits.Max - p2.Radius then
        v10 = YAxisLimits.Max - p2.Radius or v9;
    else
        v10 = v9;
    end;

    local v11 = ZAxisLimits.Min + p2.Radius;
    local v12;

    if v11 <= ZAxisLimits.Max - p2.Radius then
        v12 = ZAxisLimits.Max - p2.Radius or v11;
    else
        v12 = v11;
    end;

    if X < v7 and v7 then
        X = v7;
    elseif v8 < X then
        X = v8 or X;
    end;

    if Y < v9 and v9 then
        Y = v9;
    elseif v10 < Y then
        Y = v10 or Y;
    end;

    if Z < v11 and v11 then
        Z = v11;
    elseif v12 < Z then
        Z = v12 or Z;
    end;

    local v13 = X * (p2.AxisLocked[1] and 0 or 1);
    local v14 = Y * (p2.AxisLocked[2] and 0 or 1);
    local v15 = Z * (p2.AxisLocked[3] and 0 or 1);
    local v16 = p5 * Vector3.new(v13, v14, v15);
    local RightVector = p5.RightVector;
    local UpVector = p5.UpVector;
    local LookVector = p5.LookVector;
    local v17 = v16 - p4;
    local v18 = v17.Magnitude == 0 and Vector3.new(0, 0, 0) or v17.Unit;

    if v13 ~= v6.X then
        if RightVector:Dot(v18) < 0 then
            RightVector = -RightVector or RightVector;
        end;

        p2:ClipVelocity(v16, RightVector);
    end;

    if v14 ~= v6.Y then
        if UpVector:Dot(v18) < 0 then
            UpVector = -UpVector or UpVector;
        end;

        p2:ClipVelocity(v16, UpVector);
    end;

    if v15 ~= v6.Z then
        if LookVector:Dot(v18) > 0 then
            LookVector = -LookVector or LookVector;
        end;

        p2:ClipVelocity(v16, LookVector);
    end;

    debug.profileend();

    return v16;
end;