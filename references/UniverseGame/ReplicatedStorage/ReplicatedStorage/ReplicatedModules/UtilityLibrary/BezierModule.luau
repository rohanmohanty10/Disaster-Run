  

 

local function _(p1) -- Line: 1
    if p1 then
        local v2;

        if typeof(p1) == "BasePart" then
            v2 = p1.CFrame.Position;
        else
            v2 = false;
        end;

        if typeof(p1) == "CFrame" then
            local _ = p1.Position;
        end;

        return v2;
    end;

    warn("MISSING POINT");
end;

return function(p3, p4, p5, p6) -- Line: 13
    if p6 then
        local v7;

        if p3 then
            if typeof(p3) == "BasePart" then
                v7 = p3.CFrame.Position;
            else
                v7 = false;
            end;

            if typeof(p3) == "CFrame" then
                local _ = p3.Position;
            end;
        else
            warn("MISSING POINT");
            v7 = nil;
        end;

        local v8;

        if p4 then
            if typeof(p4) == "BasePart" then
                v8 = p4.CFrame.Position;
            else
                v8 = false;
            end;

            if typeof(p4) == "CFrame" then
                local _ = p4.Position;
            end;
        else
            warn("MISSING POINT");
            v8 = nil;
        end;

        local v9;

        if p5 then
            if typeof(p5) == "BasePart" then
                v9 = p5.CFrame.Position;
            else
                v9 = false;
            end;

            if typeof(p5) == "CFrame" then
                local _ = p5.Position;
            end;
        else
            warn("MISSING POINT");
            v9 = nil;
        end;

        local v10 = {};

        for i = 0, 1, 1 / p6 do
            v10[#v10 + 1] = (1 - i) ^ 2 * v7 + (1 - i) * 2 * i * v8 + i ^ 2 * v9;
        end;

        return v10;
    end;

    warn("NO SEGMENTS GIVEN");
end;