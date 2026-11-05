  

 

local Players = game:GetService("Players");
local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4, u5, p6) -- Line: 27
    -- upvalues: u1 (copy), Signal (copy)
    local u7 = setmetatable({}, u1);
    u7._re = Instance.new(p4 and "UnreliableRemoteEvent" or "RemoteEvent");
    u7._re.Name = p3;
    u7._re.Parent = p2;

    if p6 and #p6 > 0 then
        u7._hasOutbound = true;
        u7._outbound = p6;
    else
        u7._hasOutbound = false;
    end;

    if not u5 or #u5 <= 0 then
        u7._directConnect = true;

        return u7;
    end;

    u7._directConnect = false;
    u7._signal = Signal.new();
    u7._re.OnServerEvent:Connect(function(p8, ...) -- Line: 41
        -- upvalues: u5 (copy), u7 (copy)
        local v9 = table.pack(...);

        for _, v in ipairs(u5) do
            if not table.pack(v(p8, v9))[1] then
                return;
            end;

            v9.n = #v9;
        end;

        u7._signal:Fire(p8, table.unpack(v9, 1, v9.n));
    end);

    return u7;
end;

function u1.Connect(p10, p11) -- Line: 65
    if p10._directConnect then
        return p10._re.OnServerEvent:Connect(p11);
    end;

    return p10._signal:Connect(p11);
end;

function u1._processOutboundMiddleware(p12, p13, ...) -- Line: 73
    if not p12._hasOutbound then
        return ...;
    end;

    local v14 = table.pack(...);

    for _, v in ipairs(p12._outbound) do
        local v15 = table.pack(v(p13, v14));

        if not v15[1] then
            return table.unpack(v15, 2, v15.n);
        end;

        v14.n = #v14;
    end;

    return table.unpack(v14, 1, v14.n);
end;

function u1.Fire(p16, p17, ...) -- Line: 98
    p16._re:FireClient(p17, p16:_processOutboundMiddleware(p17, ...));
end;

function u1.FireAll(p18, ...) -- Line: 111
    p18._re:FireAllClients(p18:_processOutboundMiddleware(nil, ...));
end;

function u1.FireExcept(p19, u20, ...) -- Line: 126
    p19:FireFilter(function(p21) -- Line: 127
        -- upvalues: u20 (copy)
        return p21 ~= u20;
    end, ...);
end;

function u1.FireFilter(p22, p23, ...) -- Line: 156
    -- upvalues: Players (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if p23(v, ...) then
            p22._re:FireClient(v, p22:_processOutboundMiddleware(nil, ...));
        end;
    end;
end;

function u1.FireFor(p24, p25, ...) -- Line: 180
    for _, v in ipairs(p25) do
        p24._re:FireClient(v, p24:_processOutboundMiddleware(nil, ...));
    end;
end;

function u1.Destroy(p26) -- Line: 189
    p26._re:Destroy();

    if p26._signal then
        p26._signal:Destroy();
    end;
end;

return u1;