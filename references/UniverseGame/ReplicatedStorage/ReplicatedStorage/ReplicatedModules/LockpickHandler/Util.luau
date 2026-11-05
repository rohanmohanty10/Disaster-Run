  

 

local u4 = {
    Assert = function(p1, p2) -- Line: 3, Name: Assert
        if not p1 then
            error(p2);
        end;
    end,

    GetDirection = function(p3) -- Line: 9, Name: GetDirection
        if p3.Y == 0 then
            return Vector3.new(0, 0, 0);
        end;

        if p3.Y > 0 then
            p3 = -p3 or p3;
        end;

        return p3;
    end
};

function u4.GetLowestPoint(p5) -- Line: 13
    -- upvalues: u4 (copy)
    local CFrame = p5.CFrame;
    local v6 = p5.Size / 2;
    local v7 = u4.GetDirection(CFrame.RightVector) * v6.X;
    local v8 = u4.GetDirection(CFrame.UpVector) * v6.Y;
    local v9 = u4.GetDirection(CFrame.LookVector) * v6.Z;

    return (CFrame + v7 + v8 + v9).Position;
end;

function u4.GetHighestPoint(p10) -- Line: 24
    -- upvalues: u4 (copy)
    local CFrame = p10.CFrame;
    local v11 = p10.Size / 2;
    local v12 = u4.GetDirection(CFrame.RightVector) * -v11.X;
    local v13 = u4.GetDirection(CFrame.UpVector) * -v11.Y;
    local v14 = u4.GetDirection(CFrame.LookVector) * -v11.Z;

    return (CFrame + v12 + v13 + v14).Position;
end;

return u4;