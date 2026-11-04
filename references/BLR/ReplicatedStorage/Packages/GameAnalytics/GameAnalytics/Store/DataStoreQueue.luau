  

local u1 = {
    QR = true,
    Queue = {},
    Process = 0
};
local u2 = {};
task.spawn(function() -- Line: 7
    -- upvalues: u1 (copy), u2 (copy)
    while u1.QR do
        task.wait();

        if #u1.Queue > 0 then
            local u3 = u1.Queue[1];
            table.remove(u1.Queue, 1);

            if not u2[u3.Key] then
                u2[u3.Key] = 0;
            end;

            local v4 = u1;
            v4.Process = v4.Process + 1;
            local v5 = u3.Delay + u2[u3.Key] - DateTime.now().UnixTimestamp;
            task.delay(v5 <= 0 and 0 or v5, function() -- Line: 21
                -- upvalues: u2 (ref), u3 (copy), u1 (ref)
                local v6, v7, v8;

                while true do
                    u2[u3.Key] = DateTime.now().UnixTimestamp;
                    v6, v7, v8 = pcall(u3.Func);

                    if not v6 then
                        warn(v7);
                    end;

                    if v6 and v7 or not u3.Delay then
                        break;
                    end;

                    task.wait(u3.Delay);

                    if v6 and v7 then
                        break;
                    end;
                end;

                u3.Event:Fire(v6, v7, v8);
                local v9 = u1;
                v9.Process = v9.Process - 1;
                u2[u3.Key] = DateTime.now().UnixTimestamp;
            end);
        end;
    end;
end);

function u1.AddRequest(p10, p11, p12) -- Line: 40
    -- upvalues: u1 (copy)
    local BindableEvent = Instance.new("BindableEvent");
    table.insert(u1.Queue, {
        Key = p10,
        Delay = p12,
        Func = p11,
        Event = BindableEvent
    });
    local v13, v14, v15 = BindableEvent.Event:Wait();

    return v13, v14, v15;
end;

function u1.RemoveKey(p16) -- Line: 54
    -- upvalues: u2 (copy)
    u2[p16] = nil;
end;

return u1;