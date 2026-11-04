 

 

local u3 = {
    finite = function(p1) -- Line: 3, Name: finite
        local v2;

        if type(p1) == "number" and p1 == p1 then
            v2 = math.abs(p1) < 10000000;
        else
            v2 = false;
        end;

        return v2;
    end
};

function u3.vector(p4) -- Line: 6
    -- upvalues: u3 (copy)
    local v5;

    if typeof(p4) == "Vector3" then
        v5 = u3.finite(p4.X) and u3.finite(p4.Y) and u3.finite(p4.Z);
    else
        v5 = false;
    end;

    return v5;
end;

function u3.valid(p6) -- Line: 9
    -- upvalues: u3 (copy)
    local v7;

    if type(p6) == "table" and typeof(p6.cf) == "CFrame" then
        v7 = u3.vector(p6.cf.Position) and (u3.vector(p6.min) and u3.vector(p6.max));

        if v7 then
            if p6.min.X < p6.max.X and p6.min.Y < p6.max.Y then
                v7 = p6.min.Z < p6.max.Z;
            else
                v7 = false;
            end;
        end;
    else
        v7 = false;
    end;

    return v7;
end;

function u3.clamp(p8, p9) -- Line: 19
    local v10 = p9.cf:PointToObjectSpace(p8);
    local cf = p9.cf;
    local math_clamp_ret = math.clamp(v10.X, p9.min.X, p9.max.X);
    local math_clamp_ret2 = math.clamp(v10.Y, p9.min.Y, p9.max.Y);
    local math_clamp_ret3 = math.clamp(v10.Z, p9.min.Z, p9.max.Z);

    return cf:PointToWorldSpace((Vector3.new(math_clamp_ret, math_clamp_ret2, math_clamp_ret3)));
end;

function u3.inside(p11, p12) -- Line: 29
    -- upvalues: u3 (copy)
    local v13 = u3.vector(p11) and (p11 - u3.clamp(p11, p12)).Magnitude < 0.01;

    return v13;
end;

function u3.bounds(p14, p15) -- Line: 32
    -- upvalues: u3 (copy)
    if p14 and p14:IsA("BasePart") then
        if not p14:IsA("UnionOperation") then
            local v16 = p14.Size * 0.5;
            local Y = v16.Y;
            local v17 = Y + p15.MaxHeight;

            for _, child in p14.Parent:GetChildren() do
                if child:IsA("BasePart") and child.Name:find("InvisWall") then
                    local v18 = p14.CFrame:ToObjectSpace(child.CFrame);
                    local v19 = child.Size * 0.5;
                    local v20 = math.abs(v18.RightVector.Y) * v19.X;
                    local v21 = math.abs(v18.UpVector.Y) * v19.Y;
                    local v22 = math.abs(v18.LookVector.Y) * v19.Z;
                    local Vector3_new_ret = Vector3.new(v20, v21, v22);
                    local v23 = Vector3_new_ret.X + Vector3_new_ret.Y + Vector3_new_ret.Z;

                    if v23 <= 4 and v18.Position.Y - v23 > Y + 10 then
                        v17 = math.min(v17, v18.Position.Y - v23 - p15.FieldInset);
                    end;
                end;
            end;

            local v24 = {
                cf = p14.CFrame,
                min = Vector3.new(-v16.X + p15.FieldInset, Y + p15.MinHeight, -v16.Z + p15.FieldInset),
                max = Vector3.new(v16.X - p15.FieldInset, v17, v16.Z - p15.FieldInset)
            };

            return u3.valid(v24) and v24 and v24 or nil;
        end;

        local v25 = p14.Size * 0.5;
        local CFrame2 = p14.CFrame;
        local v26 = math.abs(CFrame2.RightVector.X) * v25.X + math.abs(CFrame2.UpVector.X) * v25.Y + math.abs(CFrame2.LookVector.X) * v25.Z;
        local v27 = math.abs(CFrame2.RightVector.Y) * v25.X + math.abs(CFrame2.UpVector.Y) * v25.Y + math.abs(CFrame2.LookVector.Y) * v25.Z;
        local v28 = math.abs(CFrame2.RightVector.Z) * v25.X + math.abs(CFrame2.UpVector.Z) * v25.Y + math.abs(CFrame2.LookVector.Z) * v25.Z;
        local v29 = {
            cf = CFrame.new(p14.Position),
            min = Vector3.new(-v26 + p15.FieldInset, v27 + p15.MinHeight, -v28 + p15.FieldInset),
            max = Vector3.new(v26 - p15.FieldInset, v27 + p15.MaxHeight, v28 - p15.FieldInset)
        };

        return u3.valid(v29) and v29 and v29 or nil;
    end;
end;

function u3.creatorBounds(p30, p31, p32) -- Line: 82
    -- upvalues: u3 (copy)
    local v33 = u3.bounds(p30, p32);

    if v33 then
        local min = v33.min;
        local max = v33.max;

        if p31 then
            for _, descendant in p31:GetDescendants() do
                if descendant:IsA("BasePart") and (descendant.Transparency < 1 and not descendant:GetAttribute("WeaponVFX")) then
                    local v34 = descendant.Size * 0.5;
                    local v35 = descendant;

                    for i = -1, 1, 2 do
                        local v36 = i;

                        for i2 = -1, 1, 2 do
                            local v37 = i2;

                            for i3 = -1, 1, 2 do
                                local v38 = v33.cf:PointToObjectSpace(v35.CFrame:PointToWorldSpace(v34 * Vector3.new(v36, v37, i3)));
                                local math_min_ret = math.min(min.X, v38.X - 12);
                                local math_min_ret2 = math.min(min.Y, v38.Y + 2);
                                local math_min_ret3 = math.min(min.Z, v38.Z - 12);
                                min = Vector3.new(math_min_ret, math_min_ret2, math_min_ret3);
                                local math_max_ret = math.max(max.X, v38.X + 12);
                                local math_max_ret2 = math.max(max.Y, v38.Y + 30);
                                local math_max_ret3 = math.max(max.Z, v38.Z + 12);
                                max = Vector3.new(math_max_ret, math_max_ret2, math_max_ret3);
                                local _ = i3;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        v33.min = min;
        v33.max = max;

        return u3.valid(v33) and v33 and v33 or nil;
    end;
end;

function u3.alpha(p39, p40) -- Line: 117
    local v41 = -p39 * math.max(0, p40);

    return 1 - math.exp(v41);
end;

function u3.angles(p42) -- Line: 120
    local LookVector = p42.LookVector;
    local math_atan2_ret = math.atan2(-LookVector.X, -LookVector.Z);
    local math_clamp_ret = math.clamp(LookVector.Y, -1, 1);

    return math_atan2_ret, math.asin(math_clamp_ret);
end;

function u3.deadzone(p43) -- Line: 124
    local Magnitude = p43.Magnitude;

    if Magnitude < 0.16 then
        return Vector2.zero;
    end;

    return p43.Unit * math.clamp((Magnitude - 0.16) / 0.84, 0, 1);
end;

return table.freeze(u3);