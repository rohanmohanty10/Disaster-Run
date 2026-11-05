 

 

local u1 = {};
u1.__index = u1;
local u2 = {};
u2.__index = u2;
local u3 = setmetatable({}, {
    __mode = "kv"
});
function AddListItem(p4, p5)
    local v6 = {
        Signal = p4,
        Callback = p5,
        Last = p4.Last
    };
    if v6.Last then
        v6.Last.Next = v6;
    end;
    p4.Last = v6;
    return v6;
end;
function DisconnectListItem(p7)
    if p7.Signal.Last == p7 then
        p7.Signal.Last = p7.Last;
    end;
    if p7.Last then
        p7.Last.Next = p7.Next;
    end;
    if p7.Next then
        p7.Next.Last = p7.Last;
    end;
    p7.Callback = nil;
end;
function u1.new() --[[ Line: 29 ]]
    -- upvalues: u1 (copy)
    return setmetatable({
        Last = nil
    }, u1);
end;
function u1.Connect(p8, p9) --[[ Line: 33 ]]
    -- upvalues: u2 (copy), u3 (copy)
    if not p8.Killed then
        local v10 = setmetatable({
            Connected = true
        }, u2);
        u3[v10] = AddListItem(p8, p9);
        return v10;
    end;
end;
function u1.Wait(p11) --[[ Line: 42 ]]
    if p11.Killed then
        return coroutine.yield();
    end;
    AddListItem(p11, coroutine.running());
    return coroutine.yield();
end;
function u1.Fire(p12, ...) --[[ Line: 50 ]]
    if p12.Killed then
    else
        local l__Last__1 = p12.Last;
        while l__Last__1 do
            local l__Callback__2 = l__Last__1.Callback;
            local v13 = typeof(l__Callback__2);
            if v13 == "thread" then
                DisconnectListItem(l__Last__1);
                task.spawn(l__Callback__2, ...);
            elseif v13 == "function" then
                task.spawn(l__Callback__2, ...);
            end;
            l__Last__1 = l__Last__1.Last;
        end;
    end;
end;
function u1.FireDeferred(p14, ...) --[[ Line: 70 ]]
    task.defer(p14.Fire, p14, ...);
end;
function u1.Destroy(p15) --[[ Line: 74 ]]
    if p15.Killed then
    else
        p15.Killed = true;
        p15.Last = nil;
    end;
end;
u1.connect = u1.Connect;
u1.wait = u1.Wait;
function u2.GetOnDisconnectSignal(p16) --[[ Line: 86 ]]
    -- upvalues: u1 (copy)
    if not p16.DisconnectSignal then
        p16.DisconnectSignal = u1.new();
    end;
    return p16.DisconnectSignal;
end;
function u2.Disconnect(p17) --[[ Line: 94 ]]
    -- upvalues: u3 (copy)
    if p17.Connected then
        p17.Connected = false;
        local v18 = u3[p17];
        if v18 then
            u3[p17] = nil;
            DisconnectListItem(v18);
        end;
        if p17.DisconnectSignal then
            p17.DisconnectSignal:Fire();
            p17.DisconnectSignal:Destroy();
        end;
    end;
end;
u2.disconnect = u2.Disconnect;
u2.Destroy = u2.Disconnect;
return u1;