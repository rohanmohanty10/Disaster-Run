  

 

local Constants = require(script.Parent.Parent.Constants);
local RemotePacketSizeCounter = require(script.Parent.Parent.Parent.RemotePacketSizeCounter);
local ServerProcess = require(script.Parent.ServerProcess);
local TableKit = require(script.Parent.Parent.Parent.TableKit);
require(script.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Utilities.Output);
local tostringData = require(script.Parent.Parent.Utilities.tostringData);
local PlayerContainers = require(script.Parent.PlayerContainers);
local ServerConnection = require(script.Parent.ServerConnection);
local ServerIdentifiers = require(script.Parent.ServerIdentifiers);
local v1 = {};
local u3 = {
    __index = v1,

    __tostring = function(p2) -- Line: 31, Name: __tostring
        return "ServerBridge";
    end
};

function v1.InboundMiddleware(p4, p5) -- Line: 41
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p4) == "ServerBridge", "InboundMiddleware called with . instead of :");
    p4._inboundMiddleware = p5;
end;

function v1.OutboundMiddleware(p6, p7) -- Line: 52
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p6) == "ServerBridge", "OutboundMiddleware called with . instead of :");
    p6._outboundMiddleware = p7;
end;

function v1.Connect(u8, u9, u10) -- Line: 66
    -- upvalues: Output (copy), ServerConnection (copy), ServerIdentifiers (copy), Constants (copy), tostringData (copy), RemotePacketSizeCounter (copy)
    Output.fatalAssert(tostring(u8) == "ServerBridge", "Connect called with . instead of :");
    Output.typecheck("function", "Connect", "callback", u9);
    local u11 = debug.info(2, "l");
    local u12 = debug.info(2, "s");

    return ServerConnection(u8._identifier, function(p13, p14) -- Line: 73
        -- upvalues: ServerIdentifiers (ref), u8 (copy), Output (ref), Constants (ref), u10 (copy), tostringData (ref), RemotePacketSizeCounter (ref), u12 (copy), u11 (copy), u9 (copy)
        if typeof(p14) == "table" and p14[1] == ServerIdentifiers.ref("REQUEST") then
            return;
        end;

        if u8.RateLimitActive then
            local v15 = os.clock() - os.clock() % 1;
            local v16 = math.round(v15);

            if u8._rateMap[p13] == nil then
                u8._rateMap[p13] = { v16, 1 };
            elseif (u8._rateMap[p13][1] or 0) == v16 then
                local v17 = u8._rateMap[p13];
                v17[2] = v17[2] + 1;
            else
                u8._rateMap[p13][2] = 0;
                u8._rateMap[p13][1] = v16;
            end;

            if u8._rateMap[p13][2] >= u8._maxRate and not u8._overflowFunction(p13) then
                return;
            end;
        end;

        if u8._inboundMiddleware == nil then
            if u8.Logging then
                local v18 = string.format(Constants.SERVER_CONNECT_LOG, u10 or u8._name, p13.Name, tostringData(p14), RemotePacketSizeCounter.GetDataByteSize(p14), u12, u11);
                Output.log(v18);
            end;

            if u10 then
                debug.profilebegin(u10);
            end;

            u9(p13, p14);

            if u10 then
                debug.profileend();
            end;
        else
            local v19 = p14;

            for _, v in u8._inboundMiddleware do
                local v20 = v(p13, p14);

                if typeof(v20) == "table" then
                    p14 = v20;
                else
                    Output.silent(string.format("Inbound middleware on bridge %* did not return a table; ignoring the return.", u8._name));
                end;
            end;

            if u8.Logging then
                local v21 = string.format(Constants.SERVER_CONNECT_LOG, u10 or u8._name, p13.Name, tostringData(v19), RemotePacketSizeCounter.GetDataByteSize(v19), u12, u11);
                Output.log(v21);
            end;

            if u10 then
                debug.profilebegin(u10);
            end;

            u9(p13, p14);

            if u10 then
                debug.profileend();
            end;
        end;
    end);
end;

function v1.RateLimit(p22, p23, p24) -- Line: 175
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p22) == "ServerBridge", "RateLimit called with . instead of :");
    p22.RateLimitActive = true;
    p22._overflowFunction = p24;
    p22._maxRate = p23;
end;

function v1.DisableRateLimit(p25) -- Line: 186
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p25) == "ServerBridge", "DisableRateLimit called with . instead of :");
    p25.RateLimitActive = false;
end;

function v1.Wait(p26) -- Line: 198
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p26) == "ServerBridge", "Wait called with . instead of :");
    local u27 = coroutine.running();
    p26:Connect(function(p28, p29) -- Line: 201
        -- upvalues: u27 (copy)
        task.spawn(u27, p28, p29);
    end);

    return coroutine.yield();
end;

function v1.Once(p30, u31) -- Line: 214
    -- upvalues: Output (copy)
    Output.fatalAssert(tostring(p30) == "ServerBridge", "Once called with . instead of :");
    Output.typecheck("function", "Once", "callback", u31);
    local u32 = nil;
    u32 = p30:Connect(function(p33, p34) -- Line: 219
        -- upvalues: u32 (ref), u31 (copy)
        u32:Disconnect();
        u31(p33, p34);
    end);

    return u32;
end;

function v1.Fire(p35, p36, p37) -- Line: 233
    -- upvalues: Output (copy), PlayerContainers (copy), Constants (copy), TableKit (copy), tostringData (copy), RemotePacketSizeCounter (copy), ServerProcess (copy)
    Output.fatalAssert(tostring(p35) == "ServerBridge", "Fire called with . instead of :");
    local v38 = nil;

    if typeof(p36) == "Instance" then
        if p36:IsA("Player") then
            v38 = PlayerContainers.Single(p36);
        else
            Output.fatal("non-player instance passed into :Fire()");
        end;
    else
        if typeof(p36) == "nil" then
            Output.fatal("target parameter passed into ServerBridge:Fire() is nil");
        end;

        Output.typecheck("table", "Fire", "target", p36);
        v38 = p36;
    end;

    if p35._outboundMiddleware == nil then
        if p35.Logging then
            Output.log((`{debug.info(2, "s")}:{debug.info(2, "l")}`));
            local format = string.format;
            local SERVER_FIRE_LOG = Constants.SERVER_FIRE_LOG;
            local _name = p35._name;
            local v39;

            if v38.kind == "all" then
                v39 = "{all}";
            elseif v38.kind == "single" then
                v39 = v38.value.Name;
            else
                v39 = TableKit.ToArrayString(v38.value);
            end;

            local v40 = format(SERVER_FIRE_LOG, _name, v39, tostringData(p37), RemotePacketSizeCounter.GetDataByteSize(p37));
            Output.log(v40);
        end;

        ServerProcess.addToQueue(v38, p35._identifier, p37);

        return;
    end;

    for _, v in p35._outboundMiddleware do
        local v41 = v(p37);

        if typeof(v41) == "table" then
            p37 = v41;
        else
            Output.silent(string.format("Outbound middleware on bridge %* did not return a table; ignoring the return.", p35._name));
        end;
    end;

    if p35.Logging then
        Output.log((`{debug.info(2, "s")}:{debug.info(2, "l")}`));
        local format = string.format;
        local SERVER_FIRE_LOG = Constants.SERVER_FIRE_LOG;
        local _name = p35._name;
        local v42;

        if v38.kind == "all" then
            v42 = "{all}";
        elseif v38.kind == "single" then
            v42 = v38.value.Name;
        else
            v42 = TableKit.ToArrayString(v38.value);
        end;

        local v43 = format(SERVER_FIRE_LOG, _name, v42, tostringData(p37), RemotePacketSizeCounter.GetDataByteSize(p37));
        Output.log(v43);
    end;

    ServerProcess.addToQueue(v38, p35._identifier, p37);
end;

return function(p44) -- Line: 306
    -- upvalues: ServerIdentifiers (copy), u3 (copy), ServerProcess (copy)
    local v45 = {
        _outboundMiddleware = nil,
        _inboundMiddleware = nil,
        Logging = false,
        RateLimitActive = false,
        _maxRate = 500,
        _identifier = ServerIdentifiers.ref(p44),
        _name = p44,

        OnServerInvoke = function() -- Line: 318
        end,

        _rateMap = {},

        _overflowFunction = function() -- Line: 324, Name: _overflowFunction
            return false;
        end
    };
    local u46 = setmetatable(v45, u3);
    ServerProcess.registerBridge(u46._identifier);
    ServerProcess.connect(u46._identifier, function(p47, p48) -- Line: 331
        -- upvalues: u46 (copy), ServerIdentifiers (ref)
        if typeof(p48) ~= "table" then
            return;
        end;

        if u46.OnServerInvoke ~= nil and p48[1] == ServerIdentifiers.ref("REQUEST") then
            local v49 = u46.OnServerInvoke(p47, p48[3]);
            u46:Fire(p47, { ServerIdentifiers.ref("REQUEST"), p48[2], v49 });
        end;
    end);

    return u46;
end;