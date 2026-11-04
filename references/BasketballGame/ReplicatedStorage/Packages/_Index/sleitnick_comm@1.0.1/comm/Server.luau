 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
local RemoteProperty = require(script.RemoteProperty)
local RemoteSignal = require(script.RemoteSignal)
local Types = require(script.Parent.Types)
local Util = require(script.Parent.Util)

local Server = {}

--[=[
	@within Comm
	@prop ServerComm ServerComm
]=]
--[=[
	@within Comm
	@prop ClientComm ClientComm
]=]

--[=[
	@within Comm
	@private
	@interface Server
	.BindFunction (parent: Instance, name: string, fn: FnBind, inboundMiddleware: ServerMiddleware?, outboundMiddleware: ServerMiddleware?): RemoteFunction
	.WrapMethod (parent: Instance, tbl: table, name: string, inboundMiddleware: ServerMiddleware?, outboundMiddleware: ServerMiddleware?): RemoteFunction
	.CreateSignal (parent: Instance, name: string, inboundMiddleware: ServerMiddleware?, outboundMiddleware: ServerMiddleware?): RemoteSignal
	.CreateProperty (parent: Instance, name: string, value: any, inboundMiddleware: ServerMiddleware?, outboundMiddleware: ServerMiddleware?): RemoteProperty
	Server Comm
]=]
--[=[
	@within Comm
	@private
	@interface Client
	.GetFunction (parent: Instance, name: string, usePromise: boolean, inboundMiddleware: ClientMiddleware?, outboundMiddleware: ClientMiddleware?): (...: any) -> any
	.GetSignal (parent: Instance, name: string, inboundMiddleware: ClientMiddleware?, outboundMiddleware: ClientMiddleware?): ClientRemoteSignal
	.GetProperty (parent: Instance, name: string, inboundMiddleware: ClientMiddleware?, outboundMiddleware: ClientMiddleware?): ClientRemoteProperty
	Client Comm
]=]

function Server.BindFunction(
	parent: Instance,
	name: string,
	func: Types.FnBind,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
): RemoteFunction
	assert(Util.IsServer, "BindFunction must be called from the server")
	local folder = Util.GetCommSubFolder(parent, "RF"):Expect("Failed to get Comm RF folder")
	local rf = Instance.new("RemoteFunction")
	rf.Name = name
	local hasInbound = type(inboundMiddleware) == "table" and #inboundMiddleware > 0
	local hasOutbound = type(outboundMiddleware) == "table" and #outboundMiddleware > 0
	local function ProcessOutbound(player, ...)
		local args = table.pack(...)
		for _, middlewareFunc in ipairs(outboundMiddleware) do
			local middlewareResult = table.pack(middlewareFunc(player, args))
			if not middlewareResult[1] then
				return table.unpack(middlewareResult, 2, middlewareResult.n)
			end
			args.n = #args
		end
		return table.unpack(args, 1, args.n)
	end
	if hasInbound and hasOutbound then
		local function OnServerInvoke(player, ...)
			local args = table.pack(...)
			for _, middlewareFunc in ipairs(inboundMiddleware) do
				local middlewareResult = table.pack(middlewareFunc(player, args))
				if not middlewareResult[1] then
					return table.unpack(middlewareResult, 2, middlewareResult.n)
				end
				args.n = #args
			end
			return ProcessOutbound(player, func(player, table.unpack(args, 1, args.n)))
		end
		rf.OnServerInvoke = OnServerInvoke
	elseif hasInbound then
		local function OnServerInvoke(player, ...)
			local args = table.pack(...)
			for _, middlewareFunc in ipairs(inboundMiddleware) do
				local middlewareResult = table.pack(middlewareFunc(player, args))
				if not middlewareResult[1] then
					return table.unpack(middlewareResult, 2, middlewareResult.n)
				end
				args.n = #args
			end
			return func(player, table.unpack(args, 1, args.n))
		end
		rf.OnServerInvoke = OnServerInvoke
	elseif hasOutbound then
		local function OnServerInvoke(player, ...)
			return ProcessOutbound(player, func(player, ...))
		end
		rf.OnServerInvoke = OnServerInvoke
	else
		rf.OnServerInvoke = func
	end
	rf.Parent = folder
	return rf
end

function Server.WrapMethod(
	parent: Instance,
	tbl: {},
	name: string,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
): RemoteFunction
	assert(Util.IsServer, "WrapMethod must be called from the server")
	local fn = tbl[name]
	assert(type(fn) == "function", "Value at index " .. name .. " must be a function; got " .. type(fn))
	return Server.BindFunction(parent, name, function(...)
		return fn(tbl, ...)
	end, inboundMiddleware, outboundMiddleware)
end

function Server.CreateSignal(
	parent: Instance,
	name: string,
	reliable: boolean?,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
)
	assert(Util.IsServer, "CreateSignal must be called from the server")
	local folder = Util.GetCommSubFolder(parent, "RE"):Expect("Failed to get Comm RE folder")
	local rs = RemoteSignal.new(folder, name, reliable, inboundMiddleware, outboundMiddleware)
	return rs
end

function Server.CreateProperty(
	parent: Instance,
	name: string,
	initialValue: any,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
)
	assert(Util.IsServer, "CreateProperty must be called from the server")
	local folder = Util.GetCommSubFolder(parent, "RP"):Expect("Failed to get Comm RP folder")
	local rp = RemoteProperty.new(folder, name, initialValue, inboundMiddleware, outboundMiddleware)
	return rp
end

return Server

]==]

 

local script_RemoteProperty = require(script.RemoteProperty);
local script_RemoteSignal = require(script.RemoteSignal);
require(script.Parent.Types);
local Util = require(script.Parent.Util);
local u13 = {
    BindFunction = function(p1: userdata, p2: string, u3: any, u4: any, u5: any) -- Line: 37, Name: BindFunction
        -- upvalues: Util (copy)
        assert(Util.IsServer, "BindFunction must be called from the server");
        local v6 = Util.GetCommSubFolder(p1, "RF"):Expect("Failed to get Comm RF folder");
        local RemoteFunction = Instance.new("RemoteFunction");
        RemoteFunction.Name = p2;
        local v7;

        if type(u4) == "table" then
            v7 = #u4 > 0;
        else
            v7 = false;
        end;

        local v8;

        if type(u5) == "table" then
            v8 = #u5 > 0;
        else
            v8 = false;
        end;

        local function ProcessOutbound(p9, ...) -- Line: 50
            -- upvalues: u5 (copy)
            local table_pack_ret = table.pack(...);

            for _, v in ipairs(u5) do
                local table_pack_ret2 = table.pack(v(p9, table_pack_ret));

                if not table_pack_ret2[1] then
                    return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                end;

                table_pack_ret.n = #table_pack_ret;
            end;

            return table.unpack(table_pack_ret, 1, table_pack_ret.n);
        end;

        if v7 and v8 then
            function RemoteFunction.OnServerInvoke(p10, ...) -- Line: 62
                -- upvalues: u4 (copy), ProcessOutbound (copy), u3 (copy)
                local table_pack_ret = table.pack(...);

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(p10, table_pack_ret));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    table_pack_ret.n = #table_pack_ret;
                end;

                return ProcessOutbound(p10, u3(p10, table.unpack(table_pack_ret, 1, table_pack_ret.n)));
            end;
        elseif v7 then
            function RemoteFunction.OnServerInvoke(p11, ...) -- Line: 75
                -- upvalues: u4 (copy), u3 (copy)
                local table_pack_ret = table.pack(...);

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(p11, table_pack_ret));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    table_pack_ret.n = #table_pack_ret;
                end;

                return u3(p11, table.unpack(table_pack_ret, 1, table_pack_ret.n));
            end;
        elseif v8 then
            function RemoteFunction.OnServerInvoke(p12, ...) -- Line: 88
                -- upvalues: ProcessOutbound (copy), u3 (copy)
                return ProcessOutbound(p12, u3(p12, ...));
            end;
        else
            RemoteFunction.OnServerInvoke = u3;
        end;

        RemoteFunction.Parent = v6;

        return RemoteFunction;
    end
};

function u13.WrapMethod(p14: userdata, u15: table, p16: string, p17: any, p18: any) -- Line: 99
    -- upvalues: Util (copy), u13 (copy)
    assert(Util.IsServer, "WrapMethod must be called from the server");
    local u19 = u15[p16];
    local v20 = type(u19) == "function";
    local v21 = "Value at index " .. p16 .. " must be a function; got " .. type(u19);
    assert(v20, v21);

    return u13.BindFunction(p14, p16, function(...) -- Line: 109
        -- upvalues: u19 (copy), u15 (copy)
        return u19(u15, ...);
    end, p17, p18);
end;

function u13.CreateSignal(p22: userdata, p23: string, p24: boolean?, p25: any, p26: any) -- Line: 114
    -- upvalues: Util (copy), script_RemoteSignal (copy)
    assert(Util.IsServer, "CreateSignal must be called from the server");
    local v27 = Util.GetCommSubFolder(p22, "RE"):Expect("Failed to get Comm RE folder");

    return script_RemoteSignal.new(v27, p23, p24, p25, p26);
end;

function u13.CreateProperty(p28: userdata, p29: string, p30: any, p31: any, p32: any) -- Line: 127
    -- upvalues: Util (copy), script_RemoteProperty (copy)
    assert(Util.IsServer, "CreateProperty must be called from the server");
    local v33 = Util.GetCommSubFolder(p28, "RP"):Expect("Failed to get Comm RP folder");

    return script_RemoteProperty.new(v33, p29, p30, p31, p32);
end;

return u13;