 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- ServerComm
-- Stephen Leitnick
-- December 20, 2021

local Comm = require(script.Parent)
local Types = require(script.Parent.Parent.Types)
local Util = require(script.Parent.Parent.Util)

--[=[
	@class ServerComm
	@server
]=]
local ServerComm = {}
ServerComm.__index = ServerComm

--[=[
	@within ServerComm
	@type ServerMiddlewareFn (player: Player, args: {any}) -> (shouldContinue: boolean, ...: any)
	The middleware function takes the client player and the arguments (as a table array), and should
	return `true|false` to indicate if the process should continue.

	If returning `false`, the optional varargs after the `false` are used as the new return values
	to whatever was calling the middleware.
]=]
--[=[
	@within ServerComm
	@type ServerMiddleware {ServerMiddlewareFn}
	Array of middleware functions.
]=]

--[=[
	@return ServerComm
	Constructs a ServerComm object. The `namespace` parameter is used
	in cases where more than one ServerComm object may be bound
	to the same object. Otherwise, a default namespace is used.

	```lua
	local serverComm = ServerComm.new(game:GetService("ReplicatedStorage"))

	-- If many might exist in the given parent, use a unique namespace:
	local serverComm = ServerComm.new(game:GetService("ReplicatedStorage"), "MyNamespace")
	```
]=]
function ServerComm.new(parent: Instance, namespace: string?)
	assert(Util.IsServer, "ServerComm must be constructed from the server")
	assert(typeof(parent) == "Instance", "Parent must be of type Instance")
	local ns = Util.DefaultCommFolderName
	if namespace then
		ns = namespace
	end
	assert(not parent:FindFirstChild(ns), "Parent already has another ServerComm bound to namespace " .. ns)
	local self = setmetatable({}, ServerComm)
	self._instancesFolder = Instance.new("Folder")
	self._instancesFolder.Name = ns
	self._instancesFolder.Parent = parent
	return self
end

--[=[
	@param name string
	@param fn (player: Player, ...: any) -> ...: any
	@param inboundMiddleware ServerMiddleware?
	@param outboundMiddleware ServerMiddleware?
	@return RemoteFunction
	Creates a RemoteFunction and binds the given function to it. Inbound
	and outbound middleware can be applied if desired.

	```lua
	local function GetSomething(player: Player)
		return "Something"
	end

	serverComm:BindFunction("GetSomething", GetSomething)
	```
]=]
function ServerComm:BindFunction(
	name: string,
	fn: Types.FnBind,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
): RemoteFunction
	return Comm.BindFunction(self._instancesFolder, name, fn, inboundMiddleware, outboundMiddleware)
end

--[=[
	@param tbl table
	@param name string
	@param inboundMiddleware ServerMiddleware?
	@param outboundMiddleware ServerMiddleware?
	@return RemoteFunction

	Binds a function to a table method. The name must match the
	name of the method in the table. The same name will be used
	on the client to access the given function.

	```lua
	local MyObject = {
		_Data = 10,
	}

	function MyObject:GetData(player: Player)
		return self._Data
	end

	serverComm:WrapMethod(MyObject, "GetData")
	```
]=]
function ServerComm:WrapMethod(
	tbl: {},
	name: string,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
): RemoteFunction
	return Comm.WrapMethod(self._instancesFolder, tbl, name, inboundMiddleware, outboundMiddleware)
end

--[=[
	@param name string
	@param unreliable boolean?
	@param inboundMiddleware ServerMiddleware?
	@param outboundMiddleware ServerMiddleware?
	@return RemoteSignal

	Creates a signal that can be used to fire data to the clients
	or receive data from the clients.

	By default, signals use RemoteEvents internally. However, if
	the `unreliable` argument is set to `true`, then an
	UnreliableRemoteEvent will be used instead.

	```lua
	local mySignal = serverComm:CreateSignal("MySignal")

	-- Examples of firing in different ways (see docs for RemoteSignal for further info):
	mySignal:Fire(somePlayer, "Hello world")
	mySignal:FireAll("Hi there")
	mySignal:FireExcept(somePlayer, "Hello everyone except " .. somePlayer.Name)
	mySignal:FireFilter(function(player) return player.Team == someCoolTeam end, "Hello cool team")

	-- Example of listening for clients to send data:
	mySignal:Connect(function(player, message)
		print("Got a message from " .. player.Name .. ":", message)
	end)
	```
]=]
function ServerComm:CreateSignal(
	name: string,
	unreliable: boolean?,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
)
	return Comm.CreateSignal(self._instancesFolder, name, unreliable, inboundMiddleware, outboundMiddleware)
end

--[=[
	@param name string
	@param initialValue any
	@param inboundMiddleware ServerMiddleware?
	@param outboundMiddleware ServerMiddleware?
	@return RemoteProperty

	Create a property object which will replicate its property value to
	the clients. Optionally, specific clients can be targeted with
	different property values.

	```lua
	local comm = Comm.ServerComm.new(game:GetService("ReplicatedStorage"))

	local mapInfo = comm:CreateProperty("MapInfo", {
		MapName = "TheAwesomeMap",
		MapDuration = 60,
	})

	-- Change the data:
	mapInfo:Set({
		MapName = "AnotherMap",
		MapDuration = 30,
	})

	-- Change the data for one player:
	mapInfo:SetFor(somePlayer, {
		MapName = "ASpecialMapForYou",
		MapDuration = 90,
	})

	-- Change data based on a predicate function:
	mapInfo:SetFilter(function(player)
		return player.Team == game.Teams.SomeSpecialTeam
	end, {
		MapName = "TeamMap",
		MapDuration = 20,
	})
	```
]=]
function ServerComm:CreateProperty(
	name: string,
	initialValue: any,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
)
	return Comm.CreateProperty(self._instancesFolder, name, initialValue, inboundMiddleware, outboundMiddleware)
end

--[=[
	Destroy the ServerComm object.
]=]
function ServerComm:Destroy()
	self._instancesFolder:Destroy()
end

return ServerComm

]==]

 

local script_Parent = require(script.Parent);
require(script.Parent.Parent.Types);
local Util = require(script.Parent.Parent.Util);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: string?) -- Line: 44
    -- upvalues: Util (copy), u1 (copy)
    assert(Util.IsServer, "ServerComm must be constructed from the server");
    local v4 = typeof(p2) == "Instance";
    assert(v4, "Parent must be of type Instance");
    local v5 = p3 or Util.DefaultCommFolderName;
    local v6 = not p2:FindFirstChild(v5);
    assert(v6, "Parent already has another ServerComm bound to namespace " .. v5);
    local v7 = setmetatable({}, u1);
    v7._instancesFolder = Instance.new("Folder");
    v7._instancesFolder.Name = v5;
    v7._instancesFolder.Parent = p2;

    return v7;
end;

function u1.BindFunction(p8: table, p9: string, p10: any, p11: any, p12: any) -- Line: 76
    -- upvalues: script_Parent (copy)
    return script_Parent.BindFunction(p8._instancesFolder, p9, p10, p11, p12);
end;

function u1.WrapMethod(p13: table, p14: table, p15: string, p16: any, p17: any) -- Line: 108
    -- upvalues: script_Parent (copy)
    return script_Parent.WrapMethod(p13._instancesFolder, p14, p15, p16, p17);
end;

function u1.CreateSignal(p18: table, p19: string, p20: boolean?, p21: any, p22: any) -- Line: 146
    -- upvalues: script_Parent (copy)
    return script_Parent.CreateSignal(p18._instancesFolder, p19, p20, p21, p22);
end;

function u1.CreateProperty(p23: table, p24: string, p25: any, p26: any, p27: any) -- Line: 195
    -- upvalues: script_Parent (copy)
    return script_Parent.CreateProperty(p23._instancesFolder, p24, p25, p26, p27);
end;

function u1.Destroy(p28) -- Line: 207
    p28._instancesFolder:Destroy();
end;

return u1;