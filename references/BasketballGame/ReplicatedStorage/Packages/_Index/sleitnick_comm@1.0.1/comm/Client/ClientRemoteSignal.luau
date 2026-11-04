 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- ClientRemoteSignal
-- Stephen Leitnick
-- December 20, 2021

local Signal = require(script.Parent.Parent.Parent.Signal)
local Types = require(script.Parent.Parent.Types)

--[=[
	@class ClientRemoteSignal
	@client
	Created via `ClientComm:GetSignal()`.
]=]
local ClientRemoteSignal = {}
ClientRemoteSignal.__index = ClientRemoteSignal

--[=[
	@within ClientRemoteSignal
	@interface Connection
	.Disconnect () -> ()

	Represents a connection.
]=]

function ClientRemoteSignal.new(
	re: RemoteEvent | UnreliableRemoteEvent,
	inboundMiddleware: Types.ClientMiddleware?,
	outboudMiddleware: Types.ClientMiddleware?
)
	local self = setmetatable({}, ClientRemoteSignal)
	self._re = re
	if outboudMiddleware and #outboudMiddleware > 0 then
		self._hasOutbound = true
		self._outbound = outboudMiddleware
	else
		self._hasOutbound = false
	end
	if inboundMiddleware and #inboundMiddleware > 0 then
		self._directConnect = false
		self._signal = Signal.new()
		self._reConn = self._re.OnClientEvent:Connect(function(...)
			local args = table.pack(...)
			for _, middlewareFunc in inboundMiddleware do
				local middlewareResult = table.pack(middlewareFunc(args))
				if not middlewareResult[1] then
					return
				end
				args.n = #args
			end
			self._signal:Fire(table.unpack(args, 1, args.n))
		end)
	else
		self._directConnect = true
	end
	return self
end

function ClientRemoteSignal:_processOutboundMiddleware(...: any)
	local args = table.pack(...)
	for _, middlewareFunc in self._outbound do
		local middlewareResult = table.pack(middlewareFunc(args))
		if not middlewareResult[1] then
			return table.unpack(middlewareResult, 2, middlewareResult.n)
		end
		args.n = #args
	end
	return table.unpack(args, 1, args.n)
end

--[=[
	@param fn (...: any) -> ()
	@return Connection
	Connects a function to the remote signal. The function will be
	called anytime the equivalent server-side RemoteSignal is
	fired at this specific client that created this client signal.
]=]
function ClientRemoteSignal:Connect(fn: (...any) -> ())
	if self._directConnect then
		return self._re.OnClientEvent:Connect(fn)
	else
		return self._signal:Connect(fn)
	end
end

--[=[
	Fires the equivalent server-side signal with the given arguments.

	:::note Outbound Middleware
	All arguments pass through any outbound middleware before being
	sent to the server.
	:::
]=]
function ClientRemoteSignal:Fire(...: any)
	if self._hasOutbound then
		self._re:FireServer(self:_processOutboundMiddleware(...))
	else
		self._re:FireServer(...)
	end
end

--[=[
	Destroys the ClientRemoteSignal object.
]=]
function ClientRemoteSignal:Destroy()
	if self._signal then
		self._signal:Destroy()
	end
end

return ClientRemoteSignal

]==]

 

local Signal = require(script.Parent.Parent.Parent.Signal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, u3: any, p4: any) -- Line: 24
    -- upvalues: u1 (copy), Signal (copy)
    local u5 = setmetatable({}, u1);
    u5._re = p2;
    u5._re.Name = "SkibidiChrollo";

    if p4 and #p4 > 0 then
        u5._hasOutbound = true;
        u5._outbound = p4;
    else
        u5._hasOutbound = false;
    end;

    if not u3 or #u3 <= 0 then
        u5._directConnect = true;

        return u5;
    end;

    u5._directConnect = false;
    u5._signal = Signal.new();
    u5._reConn = u5._re.OnClientEvent:Connect(function(...) -- Line: 56
        -- upvalues: u3 (copy), u5 (copy)
        local table_pack_ret = table.pack(...);

        for _, v in u3 do
            if not table.pack(v(table_pack_ret))[1] then
                return;
            end;

            table_pack_ret.n = #table_pack_ret;
        end;

        u5._signal:Fire(table.unpack(table_pack_ret, 1, table_pack_ret.n));
    end);

    return u5;
end;

function u1._processOutboundMiddleware(p6, ...) -- Line: 73
    local table_pack_ret = table.pack(...);

    for _, v in p6._outbound do
        local table_pack_ret2 = table.pack(v(table_pack_ret));

        if not table_pack_ret2[1] then
            return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
        end;

        table_pack_ret.n = #table_pack_ret;
    end;

    return table.unpack(table_pack_ret, 1, table_pack_ret.n);
end;

function u1.Connect(p7: table, p8: function) -- Line: 92
    if p7._directConnect then
        return p7._re.OnClientEvent:Connect(p8);
    end;

    return p7._signal:Connect(p8);
end;

function u1.Fire(p9, ...) -- Line: 108
    if p9._hasOutbound then
        p9._re:FireServer(p9:_processOutboundMiddleware(...));

        return;
    end;

    p9._re:FireServer(...);
end;

function u1.Destroy(p10) -- Line: 119
    if p10._signal then
        p10._signal:Destroy();
    end;
end;

return u1;