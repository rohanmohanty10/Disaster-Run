  

 

local Promise = require(script.Parent.Parent.Parent.Promise);
local Signal = require(script.Parent.Parent.Parent.Signal);
local ClientRemoteSignal = require(script.Parent.ClientRemoteSignal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 33
    -- upvalues: u1 (copy), ClientRemoteSignal (copy), Signal (copy)
    local u5 = setmetatable({}, u1);
    u5._rs = ClientRemoteSignal.new(p2, p3, p4);
    u5._ready = false;
    u5._value = nil;
    u5.Changed = Signal.new();
    u5._readyPromise = u5:OnReady():andThen(function() -- Line: 39
        -- upvalues: u5 (copy)
        u5._readyPromise = nil;
        u5.Changed:Fire(u5._value);
        u5._changed = u5._rs:Connect(function(p6) -- Line: 42
            -- upvalues: u5 (ref)
            if p6 == u5._value then
                return;
            end;

            u5._value = p6;
            u5.Changed:Fire(p6);
        end);
    end);
    u5._rs:Fire();

    return u5;
end;

function u1.Get(p7) -- Line: 60
    return p7._value;
end;

function u1.OnReady(u8) -- Line: 83
    -- upvalues: Promise (copy)
    if u8._ready then
        return Promise.resolve(u8._value);
    end;

    return Promise.fromEvent(u8._rs, function(p9) -- Line: 87
        -- upvalues: u8 (copy)
        u8._value = p9;
        u8._ready = true;

        return true;
    end):andThen(function() -- Line: 91
        -- upvalues: u8 (copy)
        return u8._value;
    end);
end;

function u1.IsReady(p10) -- Line: 108
    return p10._ready;
end;

function u1.Observe(p11, p12) -- Line: 133
    if p11._ready then
        task.defer(p12, p11._value);
    end;

    return p11.Changed:Connect(p12);
end;

function u1.Destroy(p13) -- Line: 143
    p13._rs:Destroy();

    if p13._readyPromise then
        p13._readyPromise:cancel();
    end;

    if p13._changed then
        p13._changed:Disconnect();
    end;

    p13.Changed:Destroy();
end;

return u1;