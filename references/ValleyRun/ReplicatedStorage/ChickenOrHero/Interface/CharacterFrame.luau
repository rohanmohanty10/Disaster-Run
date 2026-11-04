 

 

local v1 = {};

local function bodyBox(p2) -- Line: 6
    local v3 = nil;
    local v4 = nil;

    for _, child in p2:GetChildren() do
        if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
            local CFrame2 = child.CFrame;
            local v5 = child.Size / 2;
            local v6 = math.abs(CFrame2.RightVector.X) * v5.X + math.abs(CFrame2.UpVector.X) * v5.Y + math.abs(CFrame2.LookVector.X) * v5.Z;
            local v7 = math.abs(CFrame2.RightVector.Y) * v5.X + math.abs(CFrame2.UpVector.Y) * v5.Y + math.abs(CFrame2.LookVector.Y) * v5.Z;
            local v8 = math.abs(CFrame2.RightVector.Z) * v5.X + math.abs(CFrame2.UpVector.Z) * v5.Y + math.abs(CFrame2.LookVector.Z) * v5.Z;
            local Vector3_new_ret = Vector3.new(v6, v7, v8);
            local v9 = CFrame2.Position - Vector3_new_ret;
            local v10 = CFrame2.Position + Vector3_new_ret;

            if v3 then
                v3 = v3:Min(v9);
            else
                v3 = v9;
            end;

            if v4 then
                v4 = v4:Max(v10);
            else
                v4 = v10;
            end;
        end;
    end;

    return v3, v4;
end;

function v1.fit(p11, p12, p13, p14) -- Line: 25
    -- upvalues: bodyBox (copy)
    local v15, v16 = bodyBox(p12);

    if not v15 then
        local BoundingBox, v17 = p12:GetBoundingBox();
        v15 = BoundingBox.Position - v17 / 2;
        v16 = BoundingBox.Position + v17 / 2;
    end;

    local v18 = (v15 + v16) / 2;
    local v19 = v16 - v15;
    local AbsoluteSize = p13.AbsoluteSize;
    local v20 = (AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0) and 1 or AbsoluteSize.X / AbsoluteSize.Y;
    local math_rad_ret = math.rad(p11.FieldOfView / 2);
    local math_tan_ret = math.tan(math_rad_ret);
    local v21 = math.max(v19.Y / 2 / math_tan_ret, v19.X / 2 / (math_tan_ret * v20)) * p14 + v19.Z / 2;
    p11.CFrame = CFrame.lookAt(v18 - Vector3.new(0, 0, v21), v18);
end;

return v1;