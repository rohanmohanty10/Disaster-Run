 

 

local RunService = game:GetService("RunService");
local u1 = {};
local u2 = {};
local u3 = nil;

function u1.running() -- Line: 31
    -- upvalues: u2 (copy)
    return #u2;
end;

function u1.step(p4) -- Line: 35
    -- upvalues: u2 (copy), u3 (ref)
    local v5 = #u2;

    while v5 >= 1 do
        local v6 = u2[v5];
        local v7 = not v6.stillCurrent();

        if not v7 then
            v6.elapsed = v6.elapsed + p4;
            v7 = v6.elapsed >= v6.duration - 1e-6;
        end;

        if v7 then
            u2[v5] = u2[#u2];
            u2[#u2] = nil;
        else
            local emitter = v6.emitter;
            v6.owed = v6.owed + p4 * emitter.Rate * math.clamp(emitter.TimeScale, 0, 1);
            local math_floor_ret = math.floor(v6.owed);

            if math_floor_ret > 0 then
                v6.owed = v6.owed - math_floor_ret;
                emitter:Emit(v6.count * math_floor_ret);
            end;
        end;

        v5 = v5 - 1;
    end;

    if #u2 == 0 and u3 then
        u3:Disconnect();
        u3 = nil;
    end;
end;

function u1.start(p8, p9, p10, p11) -- Line: 64
    -- upvalues: u2 (copy), u3 (ref), RunService (copy), u1 (copy)
    if p9 <= 0 then
        return;
    end;

    p8:Emit(p9);

    if p10 <= 0 then
        return;
    end;

    table.insert(u2, {
        elapsed = 0,
        owed = 0,
        emitter = p8,
        count = p9,
        duration = p10,
        stillCurrent = p11
    });

    if not u3 then
        u3 = RunService.Heartbeat:Connect(u1.step);
    end;
end;

return u1;