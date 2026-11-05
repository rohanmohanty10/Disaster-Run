  

 

local ClientConnection = require(script.Parent.ClientConnection);
local ClientIdentifiers = require(script.Parent.ClientIdentifiers);
local ClientProcess = require(script.Parent.ClientProcess);
local Constants = require(script.Parent.Parent.Constants);
local Output = require(script.Parent.Parent.Utilities.Output);
local TableKit = require(script.Parent.Parent.Parent.TableKit);
local RemotePacketSizeCounter = require(script.Parent.Parent.Parent.RemotePacketSizeCounter);
require(script.Parent.Parent.Types);
local NetworkUtils = require(script.Parent.Parent.Utilities.NetworkUtils);
local tostringData = require(script.Parent.Parent.Utilities.tostringData);
local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 22, Name: __tostring
        return "ClientBridge";
    end
};

function v1.RateLimit(p4) -- Line: 33
    -- upvalues: Output (copy)
    Output.warn("cannot call :RateLimit() from client");
end;

function v1.DisableRateLimit(p5) -- Line: 44
    -- upvalues: Output (copy)
    Output.warn("cannot call :DisableRateLimit() from client");
end;

function v1.InboundMiddleware(p6, p7) -- Line: 54
    -- upvalues: Output (copy), TableKit (copy)
    Output.fatalAssert(tostring(p6) == "ClientBridge", "InboundMiddleware called with . instead of :");
    Output.fatalAssert(typeof(p7) == "table", string.format("InboundMiddleware takes table, got %*", (typeof(p7))));
    Output.warnAssert(TableKit.IsArray(p7), "InboundMiddleware takes array, got dictionary.");
    p6._inboundMiddleware = p7;
end;

function v1.OutboundMiddleware(p8, p9) -- Line: 71
    -- upvalues: Output (copy), TableKit (copy)
    Output.fatalAssert(tostring(p8) == "ClientBridge", "OutboundMiddleware called with . instead of :");
    Output.fatalAssert(typeof(p9) == "table", string.format("OutboundMiddleware takes table, got %*", (typeof(p9))));
    Output.warnAssert(TableKit.IsArray(p9), "InboundMiddleware takes array, got dictionary.");
    p8._outboundMiddleware = p9;
end;

function v1.Fire(p10, p11) -- Line: 88
    -- upvalues: Output (copy), Constants (copy), tostringData (copy), RemotePacketSizeCounter (copy), ClientProcess (copy)
    Output.fatalAssert(tostring(p10) == "ClientBridge", "Fire called with . instead of :");

    if p10._outboundMiddleware == nil then
        if p10.Logging then
            Output.log((`{debug.info(2, "s")}:{debug.info(2, "l")}`));
            local v12 = string.format(Constants.CLIENT_FIRE_LOG, p10._name, tostringData(p11), RemotePacketSizeCounter.GetDataByteSize(p11));
            Output.log(v12);
        end;

        ClientProcess.addToQueue(p10._identifier, p11);

        return;
    end;

    for _, v in p10._outboundMiddleware do
        local v13 = v(p11);

        if typeof(v13) == "table" then
            p11 = v13;
        else
            Output.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", p10._name));
        end;
    end;

    if p10.Logging then
        Output.log((`{debug.info(2, "s")}:{debug.info(2, "l")}`));
        local v14 = string.format(Constants.CLIENT_FIRE_LOG, p10._name, tostringData(p11), RemotePacketSizeCounter.GetDataByteSize(p11));
        Output.log(v14);
    end;

    ClientProcess.addToQueue(p10._identifier, p11);
end;

function v1.Connect(u15, u16, u17) -- Line: 144
    -- upvalues: Output (copy), ClientConnection (copy), ClientIdentifiers (copy), Constants (copy), tostringData (copy), RemotePacketSizeCounter (copy)
    Output.fatalAssert(tostring(u15) == "ClientBridge", "connect called with . instead of :");
    Output.typecheck("function", "Connect", "callback", u16);
    local u18 = debug.info(2, "l");
    local u19 = debug.info(2, "s");

    return ClientConnection(u15._identifier, function(p20) -- Line: 151
        -- upvalues: ClientIdentifiers (ref), u15 (copy), Output (ref), Constants (ref), u17 (copy), tostringData (ref), RemotePacketSizeCounter (ref), u19 (copy), u18 (copy), u16 (copy)
        if typeof(p20) == "table" and p20[1] == ClientIdentifiers.ref("REQUEST", 3, false) then
            return;
        end;

        if u15._inboundMiddleware == nil then
            if u15.Logging then
                local v21 = string.format(Constants.CLIENT_CONNECT_LOG, u17 or u15._name, tostringData(p20), RemotePacketSizeCounter.GetDataByteSize(p20), u19, u18);
                Output.log(v21);
            end;

            if u17 then
                debug.profilebegin(u17);
            end;

            u16(p20);

            if u17 then
                debug.profileend();
            end;
        else
            for _, v in u15._inboundMiddleware do
                local v22 = v(p20);

                if typeof(v22) == "table" then
                    p20 = v22;
                else
                    Output.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", u15._name));
                end;
            end;

            if u15.Logging then
                local v23 = string.format(Constants.CLIENT_CONNECT_LOG, u17 or u15._name, tostringData(p20), RemotePacketSizeCounter.GetDataByteSize(p20), u19, u18);
                Output.log(v23);
            end;

            if u17 then
                debug.profilebegin(u17);
            end;

            u16(p20);

            if u17 then
                debug.profileend();
            end;
        end;
    end);
end;

function v1.Wait(p24) -- Line: 230
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p24) == "ClientBridge", "Wait called with . instead of :");
    local u25 = coroutine.running();
    p24:Once(function(p26) -- Line: 234
        -- upvalues: u25 (copy)
        task.spawn(u25, p26);
    end);

    return coroutine.yield();
end;

function v1.InvokeServerAsync(p27, p28) -- Line: 248
    -- upvalues: Output (copy), NetworkUtils (copy), ClientIdentifiers (copy), ClientProcess (copy)
    Output.fatalAssert(tostring(p27) == "ClientBridge", "InvokeServerAsync called with . instead of :");
    local u29 = NetworkUtils.FromHex(NetworkUtils.CreateUUID());
    p27:Fire({ ClientIdentifiers.ref("REQUEST", 3, false), u29, p28 });
    local u30 = coroutine.running();
    local u31 = nil;
    u31 = ClientProcess.connect(p27._identifier, function(p32) -- Line: 257
        -- upvalues: ClientIdentifiers (ref), u29 (copy), u31 (ref), u30 (copy)
        if typeof(p32) ~= "table" then
            return;
        end;

        if p32[1] == ClientIdentifiers.ref("REQUEST", 3, false) and p32[2] == u29 then
            u31();
            task.spawn(u30, p32[3]);
        end;
    end);

    return coroutine.yield();
end;

function v1.Once(p33, u34) -- Line: 276
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p33) == "ClientBridge", "Once called with . instead of :");
    local u35 = nil;
    u35 = p33:Connect(function(p36) -- Line: 280
        -- upvalues: u35 (ref), u34 (copy)
        u35:Disconnect();
        u34(p36);
    end);

    return u35;
end;

function v1.Destroy(p37) -- Line: 292
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p37) == "ClientBridge", "Destroy called with . instead of :");
    table.clear(p37);
    setmetatable(p37, nil);
end;

return function(p38) -- Line: 299
    -- upvalues: ClientIdentifiers (copy), u3 (copy), ClientProcess (copy)
    local v39 = {
        Logging = false,
        _identifier = ClientIdentifiers.ref(p38, 3, true),
        _name = p38,
        _inboundMiddleware = {},
        _outboundMiddleware = {}
    };
    local v40 = setmetatable(v39, u3);
    ClientProcess.registerBridge(v40._identifier);

    return v40;
end;