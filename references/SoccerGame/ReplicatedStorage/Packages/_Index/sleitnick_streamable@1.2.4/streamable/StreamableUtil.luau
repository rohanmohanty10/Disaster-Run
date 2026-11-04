 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
--!strict

-- StreamableUtil
-- Stephen Leitnick
-- March 03, 2021

local Trove = require(script.Parent.Parent.Trove)
local _Streamable = require(script.Parent.Streamable)

type Streamables = { _Streamable.Streamable }
type CompoundHandler = (Streamables, any) -> nil

--[=[
	@class StreamableUtil
	@client
	A utility library for the Streamable class.

	```lua
	local StreamableUtil = require(packages.Streamable).StreamableUtil
	```
]=]
local StreamableUtil = {}

--[=[
	@param streamables {Streamable}
	@param handler ({[child: string]: Instance}, trove: Trove) -> nil
	@return Trove

	Creates a compound streamable around all the given streamables. The compound
	streamable's observer handler will be fired once _all_ the given streamables
	are in existence, and will be cleaned up when _any_ of the streamables
	disappear.

	```lua
	local s1 = Streamable.new(workspace, "Part1")
	local s2 = Streamable.new(workspace, "Part2")

	local compoundTrove = StreamableUtil.Compound({S1 = s1, S2 = s2}, function(streamables, trove)
		local part1 = streamables.S1.Instance
		local part2 = streamables.S2.Instance
		trove:Add(function()
			print("Cleanup")
		end)
	end)
	```
]=]
function StreamableUtil.Compound(streamables: Streamables, handler: CompoundHandler)
	local compoundTrove = Trove.new()
	local observeAllTrove = Trove.new()
	local allAvailable = false
	local function Check()
		if allAvailable then
			return
		end
		for _, streamable in pairs(streamables) do
			if not streamable.Instance then
				return
			end
		end
		allAvailable = true
		handler(streamables, observeAllTrove)
	end
	local function Cleanup()
		if not allAvailable then
			return
		end
		allAvailable = false
		observeAllTrove:Clean()
	end
	for _, streamable in pairs(streamables) do
		compoundTrove:Add(streamable:Observe(function(_child, trove)
			Check()
			trove:Add(Cleanup)
		end))
	end
	compoundTrove:Add(Cleanup)
	return compoundTrove
end

return StreamableUtil

]==]

 

local Trove = require(script.Parent.Parent.Trove);
require(script.Parent.Streamable);

return {
    Compound = function(u1: table, u2: function) -- Line: 47, Name: Compound
        -- upvalues: Trove (copy)
        local v3 = Trove.new();
        local u4 = Trove.new();
        local u5 = false;

        local function Check() -- Line: 51
            -- upvalues: u5 (ref), u1 (copy), u2 (copy), u4 (copy)
            if u5 then
                return;
            end;

            for _, v in pairs(u1) do
                if not v.Instance then
                    return;
                end;
            end;

            u5 = true;
            u2(u1, u4);
        end;

        local function Cleanup() -- Line: 63
            -- upvalues: u5 (ref), u4 (copy)
            if not u5 then
                return;
            end;

            u5 = false;
            u4:Clean();
        end;

        for _, v in pairs(u1) do
            v3:Add(v:Observe(function(p6, p7) -- Line: 71
                -- upvalues: u5 (ref), u1 (copy), u2 (copy), u4 (copy), Cleanup (copy)
                if not u5 then
                    for _, v2 in pairs(u1) do
                        if not v2.Instance then
                            break;
                        end;
                    end;
                end;

                p7:Add(Cleanup);
            end));
        end;

        v3:Add(Cleanup);

        return v3;
    end
};