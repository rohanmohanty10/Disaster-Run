  

return {
    ShallowCopy = function(p1) -- Line: 3, Name: ShallowCopy
        local v2 = {};

        for i, v in pairs(p1) do
            v2[i] = v;
        end;

        return v2;
    end,

    Lerp = function(p3, p4, p5) -- Line: 11, Name: Lerp
        return p3 + (p4 - p3) * p5;
    end,

    GetRotationBetween = function(p6: vector, p7: vector, p8: vector) -- Line: 15, Name: GetRotationBetween
        local v9 = p6:Dot(p7);
        local v10 = p6:Cross(p7);

        if v9 < -0.99999 then
            return CFrame.fromAxisAngle(p8, 3.141592653589793);
        end;

        return CFrame.new(0, 0, 0, v10.X, v10.Y, v10.Z, 1 + v9);
    end,

    GetHierarchyLength = function(p11: userdata, p12: userdata) -- Line: 23, Name: GetHierarchyLength
        if p11 == p12 then
            warn("Child and Root are the same Instance!");

            return;
        end;

        if p11 ~= nil then
            local v13 = 0;

            repeat
                v13 = v13 + 1;
                p11 = p11.Parent;
            until p11 == p12;

            return v13;
        end;

        warn("Child is nil!");
    end,

    WaitForChildOfClass = function(p14: userdata, p15: string, p16: number) -- Line: 40, Name: WaitForChildOfClass
        local os_clock_ret = os.clock();

        repeat
            task.wait();
        until p14:FindFirstChildOfClass(p15) or (p16 or 10) < os.clock() - os_clock_ret;

        return p14:FindFirstChildOfClass(p15);
    end
};