  

 

local MockConnection = require(script.Parent.MockConnection);
local Constants = require(script.Parent.Parent.Constants);
local Output = require(script.Parent.Parent.Utilities.Output);
local TableKit = require(script.Parent.Parent.Parent.TableKit);
local RemotePacketSizeCounter = require(script.Parent.Parent.Parent.RemotePacketSizeCounter);
require(script.Parent.Parent.Types);
local tostringData = require(script.Parent.Parent.Utilities.tostringData);
local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 14, Name: __tostring
        return "ClientBridge";
    end
};

function v1.RateLimit(p4) -- Line: 18
    -- upvalues: Output (copy)
    Output.warn("cannot call :RateLimit() from client");
end;

function v1.DisableRateLimit(p5) -- Line: 22
    -- upvalues: Output (copy)
    Output.warn("cannot call :DisableRateLimit() from client");
end;

function v1.InboundMiddleware(p6, p7) -- Line: 26
    -- upvalues: Output (copy), TableKit (copy)
    Output.fatalAssert(tostring(p6) == "ClientBridge", "InboundMiddleware called with . instead of :");
    Output.fatalAssert(typeof(p7) == "table", string.format("InboundMiddleware takes table, got %*", (typeof(p7))));
    Output.warnAssert(TableKit.IsArray(p7), "InboundMiddleware takes array, got dictionary.");
    p6._inboundMiddleware = p7;
end;

function v1.OutboundMiddleware(p8, p9) -- Line: 37
    -- upvalues: Output (copy), TableKit (copy)
    Output.fatalAssert(tostring(p8) == "ClientBridge", "OutboundMiddleware called with . instead of :");
    Output.fatalAssert(typeof(p9) == "table", string.format("OutboundMiddleware takes table, got %*", (typeof(p9))));
    Output.warnAssert(TableKit.IsArray(p9), "InboundMiddleware takes array, got dictionary.");
    p8._outboundMiddleware = p9;
end;

function v1.Fire(p10, p11) -- Line: 48
    -- upvalues: Output (copy), Constants (copy), tostringData (copy), RemotePacketSizeCounter (copy)
    Output.fatalAssert(tostring(p10) == "ClientBridge", "Fire called with . instead of :");

    if p10.Logging then
        local v12 = string.format(Constants.CLIENT_FIRE_LOG, p10._name, tostringData(p11), RemotePacketSizeCounter.GetDataByteSize(p11));
        Output.log(v12);
    end;
end;

function v1.Connect(p13, p14) -- Line: 62
    -- upvalues: Output (copy), MockConnection (copy)
    Output.fatalAssert(tostring(p13) == "ClientBridge", "connect called with . instead of :");
    Output.typecheck("function", "Connect", "callback", p14);

    return MockConnection();
end;

function v1.Wait(p15) -- Line: 69
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p15) == "ClientBridge", "Wait called with . instead of :");
    local u16 = coroutine.running();
    p15:Once(function(p17) -- Line: 73
        -- upvalues: u16 (copy)
        task.spawn(u16, p17);
    end);

    return coroutine.yield();
end;

function v1.InvokeServerAsync(p18, p19) -- Line: 79
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p18) == "ClientBridge", "InvokeServerAsync called with . instead of :");

    return coroutine.yield();
end;

function v1.Once(p20, p21) -- Line: 85
    -- upvalues: Output (copy), MockConnection (copy)
    Output.fatalAssert(tostring(p20) == "ClientBridge", "Once called with . instead of :");

    return MockConnection();
end;

function v1.Destroy(p22) -- Line: 91
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p22) == "ClientBridge", "Destroy called with . instead of :");
    table.clear(p22);
    setmetatable(p22, nil);
end;

return function(p23) -- Line: 98
    -- upvalues: u3 (copy)
    return setmetatable({
        Logging = false,
        _identifier = p23,
        _name = p23,
        _inboundMiddleware = {},
        _outboundMiddleware = {}
    }, u3);
end;