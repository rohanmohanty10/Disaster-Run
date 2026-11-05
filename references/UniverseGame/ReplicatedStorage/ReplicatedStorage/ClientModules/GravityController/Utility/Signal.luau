  

 

local u1 = {};
u1.__index = u1;
u1.ClassName = "Signal";

function u1.new() -- Line: 21
    -- upvalues: u1 (copy)
    local v2 = setmetatable({}, u1);
    v2._bindableEvent = Instance.new("BindableEvent");
    v2._argData = nil;
    v2._argCount = nil;
    v2._source = "";

    return v2;
end;

function u1.Fire(p3, ...) -- Line: 37
    if not p3._bindableEvent then
        warn(("Signal is already destroyed. %s"):format(p3._source));

        return;
    end;

    p3._argData = { ... };
    p3._argCount = select("#", ...);
    p3._bindableEvent:Fire();
end;

function u1.Connect(u4, u5) -- Line: 53
    if type(u5) ~= "function" then
        error(("connect(%s)"):format((typeof(u5))), 2);
    end;

    return u4._bindableEvent.Event:Connect(function() -- Line: 58
        -- upvalues: u5 (copy), u4 (copy)
        u5(unpack(u4._argData, 1, u4._argCount));
    end);
end;

function u1.Wait(p6) -- Line: 65
    p6._bindableEvent.Event:Wait();
    assert(p6._argData, "Missing arg data, likely due to :TweenSize/Position corrupting threadrefs.");

    return unpack(p6._argData, 1, p6._argCount);
end;

function u1.Destroy(p7) -- Line: 73
    if p7._bindableEvent then
        p7._bindableEvent:Destroy();
        p7._bindableEvent = nil;
    end;

    p7._argData = nil;
    p7._argCount = nil;
    setmetatable(p7, nil);
end;

return u1;