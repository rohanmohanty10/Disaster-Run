 

 

local l__RunService__1 = game:GetService("RunService");
local u1 = {
    Time = 1
};
u1.mt = {
    __index = u1
};
function u1.new(u2, p3, p4) --[[ Line: 6 ]]
    -- upvalues: u1 (copy)
    local u5 = setmetatable({}, u1.mt);
    u5.Time = u2;
    u5.Func = p3;
    u5.Duration = p4;
    u5.TimeSpot = 0;
    u5.Cancelled = nil;
    u5.StoppedShort = nil;
    local u6 = nil;
    u6 = coroutine.create(function() --[[ Line: 18 ]]
        -- upvalues: u2 (copy), u5 (ref), u6 (ref)
        wait(u2 + 5);
        if u5 and not (u5.StoppedShort or u5.Cancelled) then
            u5.StoppedShort = true;
            u5.Cancelled = true;
            if not u5.LoopBegan then
                u5 = nil;
            end;
        end;
        if coroutine.running() then
            u6 = nil;
            coroutine.yield();
        else
            coroutine.close(u6);
        end;
    end);
    coroutine.resume(u6);
    return u5;
end;
function u1.Start(u7) --[[ Line: 43 ]]
    -- upvalues: l__RunService__1 (copy)
    if u7.Cancelled then
        setmetatable(u7, nil);
    else
        local u8 = tick();
        local u9 = nil;
        u9 = coroutine.create(function() --[[ Line: 54 ]]
            -- upvalues: u7 (ref), u8 (copy), l__RunService__1 (ref), u9 (ref)
            u7.TimeSpot = tick() - u8;
            u7.LoopBegan = true;
            while u7.TimeSpot < u7.Time and not (u7.StoppedShort or u7.StoppedShort) do
                u7.TimeSpot = tick() - u8;
                if u7.Duration then
                    u7.Duration();
                end;
                l__RunService__1.Stepped:Wait();
            end;
            if not u7.Cancelled then
                local v10, v11 = pcall(function() --[[ Line: 71 ]]
                    -- upvalues: u7 (ref)
                    u7.Func();
                end);
                if not v10 then
                    print(v11);
                end;
            end;
            setmetatable(u7, nil);
            u7 = nil;
            if coroutine.running() then
                u9 = nil;
                coroutine.yield();
            else
                coroutine.close(u9);
            end;
        end);
        coroutine.resume(u9);
    end;
end;
function u1.Cancel(p12) --[[ Line: 92 ]]
    p12.Cancelled = true;
    p12.StoppedShort = true;
end;
function u1.StopShort(p13) --[[ Line: 97 ]]
    p13.StoppedShort = true;
    p13.Cancelled = true;
    p13.Func();
end;
function u1.Prolong(p14, p15) --[[ Line: 104 ]]
    p14.Time = p14.Time + p15;
end;
return u1;