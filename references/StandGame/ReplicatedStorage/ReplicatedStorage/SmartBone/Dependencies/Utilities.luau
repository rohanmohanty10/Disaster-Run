 

 

return {
    ShallowCopy = function(p1) --[[ Name: ShallowCopy, Line 3 ]]
        local v2 = {};
        for v3, v4 in pairs(p1) do
            v2[v3] = v4;
        end;
        return v2;
    end,
    Lerp = function(p5, p6, p7) --[[ Name: Lerp, Line 11 ]]
        return p5 + (p6 - p5) * p7;
    end,
    GetRotationBetween = function(p8, p9, p10) --[[ Name: GetRotationBetween, Line 15 ]]
        local v11 = p8:Dot(p9);
        local v12 = p8:Cross(p9);
        if v11 < -0.99999 then
            return CFrame.fromAxisAngle(p10, 3.141592653589793);
        else
            return CFrame.new(0, 0, 0, v12.X, v12.Y, v12.Z, 1 + v11);
        end;
    end,
    GetHierarchyLength = function(p13, p14) --[[ Name: GetHierarchyLength, Line 23 ]]
        if p13 == p14 then
            warn("Child and Root are the same Instance!");
        else
            if p13 ~= nil then
                local v15 = 0;
                repeat
                    v15 = v15 + 1;
                    p13 = p13.Parent;
                until p13 == p14;
                return v15;
            end;
            warn("Child is nil!");
        end;
    end,
    WaitForChildOfClass = function(p16, p17, p18) --[[ Name: WaitForChildOfClass, Line 40 ]]
        local v19 = os.clock();
        local v20 = p18 or 10;
        repeat
            task.wait();
        until p16:FindFirstChildOfClass(p17) or v20 < os.clock - v19;
        return p16:FindFirstChildOfClass(p17);
    end
};