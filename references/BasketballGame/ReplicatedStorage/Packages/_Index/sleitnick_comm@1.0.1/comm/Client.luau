 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
local Util = require(script.Parent.Util)
local Types = require(script.Parent.Types)
local Promise = require(script.Parent.Parent.Promise)
local ClientRemoteSignal = require(script.ClientRemoteSignal)
local ClientRemoteProperty = require(script.ClientRemoteProperty)

local Client = {}

function Client.GetFunction(
	parent: Instance,
	name: string,
	usePromise: boolean,
	inboundMiddleware: Types.ClientMiddleware?,
	outboundMiddleware: Types.ClientMiddleware?
)
	assert(not Util.IsServer, "GetFunction must be called from the client")
	local folder = Util.GetCommSubFolder(parent, "RF"):Expect("Failed to get Comm RF folder")
	local rf = folder:WaitForChild(name, Util.WaitForChildTimeout)
	assert(rf ~= nil, "Failed to find RemoteFunction: " .. name)
	local hasInbound = type(inboundMiddleware) == "table" and #inboundMiddleware > 0
	local hasOutbound = type(outboundMiddleware) == "table" and #outboundMiddleware > 0
	local function ProcessOutbound(args)
		for _, middlewareFunc in ipairs(outboundMiddleware) do
			local middlewareResult = table.pack(middlewareFunc(args))
			if not middlewareResult[1] then
				return table.unpack(middlewareResult, 2, middlewareResult.n)
			end
			args.n = #args
		end
		return table.unpack(args, 1, args.n)
	end
	if hasInbound then
		if usePromise then
			return function(...)
				local args = table.pack(...)
				return Promise.new(function(resolve, reject)
					local success, res = pcall(function()
						if hasOutbound then
							return table.pack(rf:InvokeServer(ProcessOutbound(args)))
						else
							return table.pack(rf:InvokeServer(table.unpack(args, 1, args.n)))
						end
					end)
					if success then
						for _, middlewareFunc in ipairs(inboundMiddleware) do
							local middlewareResult = table.pack(middlewareFunc(res))
							if not middlewareResult[1] then
								return table.unpack(middlewareResult, 2, middlewareResult.n)
							end
							res.n = #res
						end
						resolve(table.unpack(res, 1, res.n))
					else
						reject(res)
					end
				end)
			end
		else
			return function(...)
				local res
				if hasOutbound then
					res = table.pack(rf:InvokeServer(ProcessOutbound(table.pack(...))))
				else
					res = table.pack(rf:InvokeServer(...))
				end
				for _, middlewareFunc in ipairs(inboundMiddleware) do
					local middlewareResult = table.pack(middlewareFunc(res))
					if not middlewareResult[1] then
						return table.unpack(middlewareResult, 2, middlewareResult.n)
					end
					res.n = #res
				end
				return table.unpack(res, 1, res.n)
			end
		end
	else
		if usePromise then
			return function(...)
				local args = table.pack(...)
				return Promise.new(function(resolve, reject)
					local success, res = pcall(function()
						if hasOutbound then
							return table.pack(rf:InvokeServer(ProcessOutbound(args)))
						else
							return table.pack(rf:InvokeServer(table.unpack(args, 1, args.n)))
						end
					end)
					if success then
						resolve(table.unpack(res, 1, res.n))
					else
						reject(res)
					end
				end)
			end
		else
			if hasOutbound then
				return function(...)
					return rf:InvokeServer(ProcessOutbound(table.pack(...)))
				end
			else
				return function(...)
					return rf:InvokeServer(...)
				end
			end
		end
	end
end

function Client.GetSignal(
	parent: Instance,
	name: string,
	inboundMiddleware: Types.ClientMiddleware?,
	outboundMiddleware: Types.ClientMiddleware?
)
	assert(not Util.IsServer, "GetSignal must be called from the client")
	local folder = Util.GetCommSubFolder(parent, "RE"):Expect("Failed to get Comm RE folder")
	local re = folder:WaitForChild(name, Util.WaitForChildTimeout)
	assert(re ~= nil, "Failed to find RemoteEvent: " .. name)
	return ClientRemoteSignal.new(re, inboundMiddleware, outboundMiddleware)
end

function Client.GetProperty(
	parent: Instance,
	name: string,
	inboundMiddleware: Types.ClientMiddleware?,
	outboundMiddleware: Types.ClientMiddleware?
)
	assert(not Util.IsServer, "GetProperty must be called from the client")
	local folder = Util.GetCommSubFolder(parent, "RP"):Expect("Failed to get Comm RP folder")
	local re = folder:WaitForChild(name, Util.WaitForChildTimeout)
	assert(re ~= nil, "Failed to find RemoteEvent for RemoteProperty: " .. name)
	return ClientRemoteProperty.new(re, inboundMiddleware, outboundMiddleware)
end

return Client

]]

 

local Util = require(script.Parent.Util);
require(script.Parent.Types);
local Promise = require(script.Parent.Parent.Promise);
local script_ClientRemoteSignal = require(script.ClientRemoteSignal);
local script_ClientRemoteProperty = require(script.ClientRemoteProperty);

return {
    GetFunction = function(p1: userdata, p2: string, p3: boolean, u4: any, u5: any) -- Line: 9, Name: GetFunction
        -- upvalues: Util (copy), Promise (copy)
        assert(not Util.IsServer, "GetFunction must be called from the client");
        local u6 = Util.GetCommSubFolder(p1, "RF"):Expect("Failed to get Comm RF folder"):WaitForChild(p2, Util.WaitForChildTimeout);
        assert(u6 ~= nil, "Failed to find RemoteFunction: " .. p2);
        local v7;

        if type(u4) == "table" then
            v7 = #u4 > 0;
        else
            v7 = false;
        end;

        local u8;

        if type(u5) == "table" then
            u8 = #u5 > 0;
        else
            u8 = false;
        end;

        local function ProcessOutbound(p9) -- Line: 22
            -- upvalues: u5 (copy)
            for _, v in ipairs(u5) do
                local table_pack_ret = table.pack(v(p9));

                if not table_pack_ret[1] then
                    return table.unpack(table_pack_ret, 2, table_pack_ret.n);
                end;

                p9.n = #p9;
            end;

            return table.unpack(p9, 1, p9.n);
        end;

        return v7 and (p3 and function(...) -- Line: 34
            -- upvalues: Promise (ref), u8 (copy), u6 (copy), ProcessOutbound (copy), u4 (copy)
            local table_pack_ret = table.pack(...);

            return Promise.new(function(p10, p11) -- Line: 36
                -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (copy), u4 (ref)
                local success, result = pcall(function() -- Line: 37
                    -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (ref)
                    if u8 then
                        return table.pack(u6:InvokeServer(ProcessOutbound(table_pack_ret)));
                    end;

                    return table.pack(u6:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n)));
                end);

                if not success then
                    p11(result);

                    return;
                end;

                for _, v in ipairs(u4) do
                    local table_pack_ret2 = table.pack(v(result));

                    if not table_pack_ret2[1] then
                        return table.unpack(table_pack_ret2, 2, table_pack_ret2.n);
                    end;

                    result.n = #result;
                end;

                p10(table.unpack(result, 1, result.n));
            end);
        end or function(...) -- Line: 59
            -- upvalues: u8 (copy), u6 (copy), ProcessOutbound (copy), u4 (copy)
            local v12;

            if u8 then
                v12 = table.pack(u6:InvokeServer(ProcessOutbound(table.pack(...))));
            else
                v12 = table.pack(u6:InvokeServer(...));
            end;

            for _, v in ipairs(u4) do
                local table_pack_ret = table.pack(v(v12));

                if not table_pack_ret[1] then
                    return table.unpack(table_pack_ret, 2, table_pack_ret.n);
                end;

                v12.n = #v12;
            end;

            return table.unpack(v12, 1, v12.n);
        end) or (p3 and function(...) -- Line: 78
            -- upvalues: Promise (ref), u8 (copy), u6 (copy), ProcessOutbound (copy)
            local table_pack_ret = table.pack(...);

            return Promise.new(function(p13, p14) -- Line: 80
                -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (copy)
                local success, result = pcall(function() -- Line: 81
                    -- upvalues: u8 (ref), u6 (ref), ProcessOutbound (ref), table_pack_ret (ref)
                    if u8 then
                        return table.pack(u6:InvokeServer(ProcessOutbound(table_pack_ret)));
                    end;

                    return table.pack(u6:InvokeServer(table.unpack(table_pack_ret, 1, table_pack_ret.n)));
                end);

                if success then
                    p13(table.unpack(result, 1, result.n));

                    return;
                end;

                p14(result);
            end);
        end or (u8 and function(...) -- Line: 97
            -- upvalues: u6 (copy), ProcessOutbound (copy)
            return u6:InvokeServer(ProcessOutbound(table.pack(...)));
        end or function(...) -- Line: 101
            -- upvalues: u6 (copy)
            return u6:InvokeServer(...);
        end));
    end,

    GetSignal = function(p15: userdata, p16: string, p17: any, p18: any) -- Line: 109, Name: GetSignal
        -- upvalues: Util (copy), script_ClientRemoteSignal (copy)
        assert(not Util.IsServer, "GetSignal must be called from the client");
        local v19 = Util.GetCommSubFolder(p15, "RE"):Expect("Failed to get Comm RE folder"):WaitForChild(p16, Util.WaitForChildTimeout);
        assert(v19 ~= nil, "Failed to find RemoteEvent: " .. p16);
        p15.Name = "Sigma-Sigma-On The Wall, Who\'s The Sigma-est of them all?";

        return script_ClientRemoteSignal.new(v19, p17, p18);
    end,

    GetProperty = function(p20: userdata, p21: string, p22: any, p23: any) -- Line: 124, Name: GetProperty
        -- upvalues: Util (copy), script_ClientRemoteProperty (copy)
        assert(not Util.IsServer, "GetProperty must be called from the client");
        local v24 = Util.GetCommSubFolder(p20, "RP"):Expect("Failed to get Comm RP folder"):WaitForChild(p21, Util.WaitForChildTimeout);
        assert(v24 ~= nil, "Failed to find RemoteEvent for RemoteProperty: " .. p21);
        p20.Name = "Sigma-Sigma-On The Wall, Who\'s The Sigma-est of them all?";

        return script_ClientRemoteProperty.new(v24, p22, p23);
    end
};