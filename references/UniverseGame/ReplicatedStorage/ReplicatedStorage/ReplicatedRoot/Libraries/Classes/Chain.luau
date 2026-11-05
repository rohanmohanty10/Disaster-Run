  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 42
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2.PositionCurve = Instance.new("Vector3Curve");
    v2.RotationCurve = Instance.new("RotationCurve");
    v2.SizeCurve = Instance.new("Vector3Curve");
    v2.Segments = {};
    v2.Timeline = {};
    v2.Start = nil;
    v2.Length = 0;

    return v2;
end;

function u1.GetSegments(p3) -- Line: 58
    return p3.Segments;
end;

function u1.GetFirstSegment(p4) -- Line: 62
    if p4.Start then
        return p4:GetSegmentAtTime(p4.Start);
    end;

    return nil;
end;

function u1.GetLastSegment(p5) -- Line: 69
    return p5:GetSegmentAtTime(p5.Length);
end;

function u1.GetSegmentAtTime(p6, p7) -- Line: 73
    return p6.Timeline[p7];
end;

function u1.GetSegmentsAtTime(p8, p9) -- Line: 77
    local v10 = nil;
    local v11 = nil;

    for _, v in pairs(p8.Segments) do
        if v.Time <= p9 and (not v10 or v ~= v10) then
            if v11 == nil or v.Time > v11.Time then
                v11 = v;
            end;
        end;

        if p9 <= v.Time and (not v11 or v ~= v11) and (v10 == nil or v.Time < v10.Time) then
            v10 = v;
        end;
    end;

    return { v11, v10 };
end;

function u1.GetSegment(p12, p13) -- Line: 98
    return p12.Segments[p13];
end;

function u1.AddSegment(p14, p15) -- Line: 102
    local v16 = {
        CFrame = p15.CFrame or CFrame.identity,
        Size = p15.Size or Vector3.new(0, 0, 0),
        Time = p15.Time or 0,
        Interpolation = p15.Interpolation or Enum.KeyInterpolationMode.Linear
    };
    local v17 = RotationCurveKey.new(v16.Time, v16.CFrame, v16.Interpolation);
    local v18 = FloatCurveKey.new(v16.Time, v16.CFrame.X, v16.Interpolation);
    local v19 = FloatCurveKey.new(v16.Time, v16.CFrame.Y, v16.Interpolation);
    local v20 = FloatCurveKey.new(v16.Time, v16.CFrame.Z, v16.Interpolation);
    local v21 = FloatCurveKey.new(v16.Time, v16.Size.X, v16.Interpolation);
    local v22 = FloatCurveKey.new(v16.Time, v16.Size.Y, v16.Interpolation);
    local v23 = FloatCurveKey.new(v16.Time, v16.Size.Z, v16.Interpolation);

    if v16.Interpolation == Enum.KeyInterpolationMode.Cubic then
        if p15.LeftRotationTangent then
            v17.LeftTangent = p15.LeftRotationTangent;
        end;

        if p15.RightRotationTangent then
            v17.RightTangent = p15.RightRotationTangent;
        end;

        if p15.LeftPositionTangent then
            if p15.LeftPositionTangent[1] then
                v18.LeftTangent = p15.LeftPositionTangent[1];
            end;

            if p15.LeftPositionTangent[2] then
                v19.LeftTangent = p15.LeftPositionTangent[2];
            end;

            if p15.LeftPositionTangent[3] then
                v20.LeftTangent = p15.LeftPositionTangent[3];
            end;
        end;

        if p15.RightPositionTangent then
            if p15.RightPositionTangent[1] then
                v18.RightTangent = p15.RightPositionTangent[1];
            end;

            if p15.RightPositionTangent[2] then
                v19.RightTangent = p15.RightPositionTangent[2];
            end;

            if p15.RightPositionTangent[3] then
                v20.RightTangent = p15.RightPositionTangent[3];
            end;
        end;

        if p15.LeftSizeTangent then
            if p15.LeftSizeTangent[1] then
                v21.LeftTangent = p15.LeftSizeTangent[1];
            end;

            if p15.LeftSizeTangent[2] then
                v22.LeftTangent = p15.LeftSizeTangent[2];
            end;

            if p15.LeftSizeTangent[3] then
                v23.LeftTangent = p15.LeftSizeTangent[3];
            end;
        end;

        if p15.RightSizeTangent then
            if p15.RightSizeTangent[1] then
                v21.RightTangent = p15.RightSizeTangent[1];
            end;

            if p15.RightSizeTangent[2] then
                v22.RightTangent = p15.RightSizeTangent[2];
            end;

            if p15.RightSizeTangent[3] then
                v23.RightTangent = p15.RightSizeTangent[3];
            end;
        end;
    end;

    p14.RotationCurve:InsertKey(RotationCurveKey.new(v16.Time, v16.CFrame, v16.Interpolation));
    p14.PositionCurve:X():InsertKey(v18);
    p14.PositionCurve:Y():InsertKey(v19);
    p14.PositionCurve:Z():InsertKey(v20);
    p14.SizeCurve:X():InsertKey(v21);
    p14.SizeCurve:Y():InsertKey(v22);
    p14.SizeCurve:Z():InsertKey(v23);

    if p14.Timeline[v16.Time] then
        p14:RemoveSegment(p14.Timeline[v16.Time]);
    end;

    p14.Timeline[v16.Time] = v16;

    if v16.Time > p14.Length then
        p14.Length = v16.Time;
    end;

    if not p14.Start or v16.Time < p14.Start then
        p14.Start = v16.Time;
    end;

    table.insert(p14.Segments, v16);

    return v16;
end;

function u1.RemoveSegment(p24, p25) -- Line: 203
    local v26 = table.find(p24.Segments, p25);

    if v26 then
        table.remove(p24.Segments, v26);
        p24.Timeline[p25.Time] = nil;

        for i, v in pairs(p24.RotationCurve:GetKeys()) do
            if v.Time == p25.Time then
                p24.RotationCurve:RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.PositionCurve:X():GetKeys()) do
            if v.Time == p25.Time then
                p24.PositionCurve:X():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.PositionCurve:Y():GetKeys()) do
            if v.Time == p25.Time then
                p24.PositionCurve:Y():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.PositionCurve:Z():GetKeys()) do
            if v.Time == p25.Time then
                p24.PositionCurve:Z():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.SizeCurve:X():GetKeys()) do
            if v.Time == p25.Time then
                p24.SizeCurve:X():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.SizeCurve:Y():GetKeys()) do
            if v.Time == p25.Time then
                p24.SizeCurve:Y():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        for i, v in pairs(p24.SizeCurve:Z():GetKeys()) do
            if v.Time == p25.Time then
                p24.SizeCurve:Z():RemoveKeyAtIndex(i);
                break;
            end;
        end;

        local v27 = 0;
        local v28 = nil;

        for _, v in pairs(p24.Segments) do
            if v27 < v.Time then
                v27 = v.Time;
            end;

            if v28 == nil or v.Time < v28 then
                v28 = v.Time;
            end;
        end;

        p24.Start = v28;
        p24.Length = v27;
    end;
end;

function u1.EvaluateAtTime(p29, p30) -- Line: 270
    local v31 = p29.PositionCurve:GetValueAtTime(p30);
    local v32 = p29.RotationCurve:GetValueAtTime(p30);
    local v33 = p29.SizeCurve:GetValueAtTime(p30);

    return CFrame.new((Vector3.new(unpack(v31)))) * v32, Vector3.new(unpack(v33));
end;

function u1.Destroy(p34) -- Line: 277
    if table.isfrozen(p34) then
        return;
    end;

    p34.PositionCurve:Destroy();
    p34.RotationCurve:Destroy();
    p34.SizeCurve:Destroy();
    table.clear(p34);
    table.freeze(p34);
end;

return u1;