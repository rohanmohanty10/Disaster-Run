 

 

local v1 = {
    CHOICES = { "Auto", "Off", "X", "Y", "Z" }
};
local u2 = {
    X = CFrame.new(0, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, 1),
    Y = CFrame.new(0, 0, 0, 1, 0, 0, 0, -1, 0, 0, 0, 1),
    Z = CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, -1)
};

function v1.axis(p3, p4) -- Line: 37
    -- upvalues: u2 (copy)
    if u2[p3] then
        return p3;
    end;

    if p3 ~= "Auto" then
        return nil;
    end;

    local math_max_ret = math.max(p4.X, p4.Y, p4.Z);
    local X = p4.X;
    local v5;

    if p4.Y < X then
        X = p4.Y;
        v5 = "Y";
    else
        v5 = "X";
    end;

    if p4.Z < X then
        X = p4.Z;
        v5 = "Z";
    end;

    return X > math_max_ret * 0.1 and "X" or v5;
end;

function v1.wanted(p6) -- Line: 58
    local v7 = p6:IsA("MeshPart") and p6.DoubleSided;

    return v7;
end;

function v1.twin(p8, p9) -- Line: 62
    -- upvalues: u2 (copy)
    local v10 = u2[p9];
    local Instance_fromExisting_ret = Instance.fromExisting(p8);
    Instance_fromExisting_ret.Name = "OtherSide";
    Instance_fromExisting_ret.Archivable = false;
    Instance_fromExisting_ret.DoubleSided = false;
    Instance_fromExisting_ret.CFrame = p8.CFrame * v10;

    return Instance_fromExisting_ret, v10;
end;

return v1;