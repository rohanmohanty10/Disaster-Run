  

local u4 = {
    isAirBall = function(p1) -- Line: 5, Name: isAirBall
        local v2;

        if p1 == nil then
            v2 = false;
        else
            v2 = p1.Position.Y >= 14;
        end;

        return v2;
    end,

    ownBox = function(p3) -- Line: 9, Name: ownBox
        local Team = p3.Team;
        local PenaltyArea = workspace:FindFirstChild("PenaltyArea");

        if Team and (Team.Name == "Home" or Team.Name == "Away") and PenaltyArea then
            return PenaltyArea:FindFirstChild(Team.Name);
        end;

        return nil;
    end
};

function u4.inOwnBox(p5) -- Line: 16
    -- upvalues: u4 (copy)
    local v6 = u4.ownBox(p5);
    local v7 = p5.Character and p5.Character:FindFirstChild("HumanoidRootPart");

    if not (v6 and v7) then
        return false;
    end;

    local v8 = v6.CFrame:PointToObjectSpace(v7.Position);
    local v9 = v6.Size * 0.5;
    local v10;

    if math.abs(v8.X) <= v9.X and math.abs(v8.Y) <= v9.Y then
        v10 = math.abs(v8.Z) <= v9.Z;
    else
        v10 = false;
    end;

    return v10;
end;

function u4.clearanceDirection(p11) -- Line: 25
    local v12 = workspace.PenaltyArea:FindFirstChild(p11.Name == "Home" and "Away" or "Home");
    local v13 = v12 and v12.Position - p11.Position or -p11.CFrame.LookVector;
    local Vector3_new_ret = Vector3.new(v13.X, 0, v13.Z);

    return Vector3_new_ret.Magnitude > 0.001 and Vector3_new_ret.Unit or Vector3.new(1, 0, 0);
end;

function u4.isIncoming(p14, p15, p16) -- Line: 33
    -- upvalues: u4 (copy)
    local Vector3_new_ret = Vector3.new(p16.X, 0, p16.Z);

    if Vector3_new_ret.Magnitude < 1 or Vector3_new_ret:Dot(u4.clearanceDirection(p14)) >= 0 then
        return false;
    end;

    local v17 = p14.CFrame:PointToObjectSpace(p15);
    local v18 = p14.CFrame:VectorToObjectSpace(Vector3_new_ret);
    local v19 = p14.Size * 0.5;
    local v20 = 0;
    local v21 = (1 / 0);

    for _, v in { "X", "Z" } do
        if math.abs(v18[v]) < 0.0001 then
            if math.abs(v17[v]) > v19[v] then
                return false;
            end;
        else
            local v22 = (-v19[v] - v17[v]) / v18[v];
            local v23 = (v19[v] - v17[v]) / v18[v];
            local math_min_ret = math.min(v22, v23);
            v20 = math.max(v20, math_min_ret);
            local math_max_ret = math.max(v22, v23);
            v21 = math.min(v21, math_max_ret);

            if v21 < v20 then
                return false;
            end;
        end;
    end;

    return v20 <= v21;
end;

return u4;