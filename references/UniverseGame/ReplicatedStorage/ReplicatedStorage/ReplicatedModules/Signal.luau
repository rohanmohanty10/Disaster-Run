  

 

local u1 = {};
u1.__index = u1;
u1.ClassName = "Signal";

function u1.new() -- Line: 7
    -- upvalues: u1 (copy)
    local v2 = {
        _args = nil,
        _argCount = nil,
        _bindable = Instance.new("BindableEvent")
    };

    return setmetatable(v2, u1);
end;

function u1.Fire(p3, ...) -- Line: 17
    p3._args = { ... };
    p3._argCount = select("#", ...);
    p3._bindable:Fire();
end;

function u1.fire(p4, ...) -- Line: 25
    return p4:Fire(...);
end;

function u1.Connect(u5, u6) -- Line: 29
    if type(u6) ~= "function" then
        error(("connect(%s)"):format((typeof(u6))), 2);
    end;

    return u5._bindable.Event:Connect(function() -- Line: 34
        -- upvalues: u6 (copy), u5 (copy)
        u6(unpack(u5._args, 1, u5._argCount));
    end);
end;

function u1.connect(p7, ...) -- Line: 39
    return p7:Connect(...);
end;

function u1.Wait(p8) -- Line: 43
    p8._bindableEvent.Event:Wait();
    assert(p8._argData, "Missing argument data, likely due to :TweenSize/Position corrupting.");

    return unpack(p8._args, 1, p8._argCount);
end;

function u1.wait(p9) -- Line: 49
    return p9:Wait();
end;

function u1.Destroy(p10) -- Line: 53
    if p10._bindable then
        p10._bindable:Destroy();
        p10._bindable = nil;
    end;

    p10._args = nil;
    p10._argCount = nil;
    setmetatable(p10, nil);
end;

function u1.destroy(p11) -- Line: 65
    return p11:Destroy();
end;

return u1;