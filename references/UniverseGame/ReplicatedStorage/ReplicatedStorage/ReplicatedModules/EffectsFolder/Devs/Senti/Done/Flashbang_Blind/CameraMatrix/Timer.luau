  

 

local RunService = game:GetService("RunService");
local v1 = {};

function Time(u2, u3)
    -- upvalues: RunService (copy)
    local u4 = false;
    local v6 = RunService.Heartbeat:Connect(function() -- Line: 7
        -- upvalues: u3 (copy), u2 (copy), u4 (ref)
        local format = string.format;
        local v5 = u3 - os.clock();

        if u2 <= tonumber(format("%.2f", v5)).magnitude then
            u4 = true;
        end;
    end);

    repeat
        RunService.Heartbeat:Wait();
    until u4;

    v6:Disconnect();

    return true;
end;

function v1.CreateClock(p7, u8) -- Line: 17
    -- upvalues: RunService (copy)
    coroutine.wrap(function() -- Line: 18
        -- upvalues: u8 (copy), RunService (ref)
        local v9 = os.clock();
        local v10 = Time(u8, v9);

        repeat
            RunService.Heartbeat:Wait();
        until v10;

        return v10;
    end);
end;

return v1;