 
 

local RunService = game:GetService("RunService");

return function(u1, u2, p3) -- Line: 3
    -- upvalues: RunService (copy)
    local Time = u2[#u2].Time;
    local u4 = 1;
    local u5 = tick() + (p3 or 0);
    local u6 = nil;
    u6 = RunService.Stepped:Connect(function(p7) -- Line: 10
        -- upvalues: u5 (copy), u2 (copy), u4 (ref), u1 (copy), u6 (ref)
        local v8 = tick() - u5;
        local v9 = u2[u4];
        local v10 = u2[u4 + 1];

        if not (v9 and v10) then
            if v9 then
                u1.CFrame = v9.CFrame;
            end;

            u6:Disconnect();

            return;
        end;

        if v10.Time / 60 <= v8 then
            u4 = u4 + 1;

            return;
        end;

        u1.CFrame = v9.CFrame:Lerp(v10.CFrame, (v8 - v9.Time / 60) / (v10.Time / 60 - v9.Time / 60));
    end);
    task.delay(Time / 60 + 1 - (p3 or 0), function() -- Line: 34
        -- upvalues: u6 (ref)
        u6:Disconnect();
    end);
end;