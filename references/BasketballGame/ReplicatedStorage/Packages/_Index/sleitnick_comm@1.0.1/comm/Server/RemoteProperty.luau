 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- RemoteProperty
-- Stephen Leitnick
-- December 20, 2021

local Players = game:GetService("Players")

local RemoteSignal = require(script.Parent.RemoteSignal)
local Types = require(script.Parent.Parent.Types)
local Util = require(script.Parent.Parent.Util)

local None = Util.None

--[=[
	@class RemoteProperty
	@server
	Created via `ServerComm:CreateProperty()`.

	Values set can be anything that can pass through a
	[RemoteEvent](https://developer.roblox.com/en-us/articles/Remote-Functions-and-Events#parameter-limitations).

	Here is a cheat-sheet for the below methods:
	- Setting data
		- `Set`: Set "top" value for all current and future players. Overrides any custom-set data per player.
		- `SetTop`: Set the "top" value for all players, but does _not_ override any custom-set data per player.
		- `SetFor`: Set custom data for the given player. Overrides the "top" value. (_Can be nil_)
		- `SetForList`: Same as `SetFor`, but accepts a list of players.
		- `SetFilter`: Accepts a predicate function which checks for which players to set.
	- Clearing data
		- `ClearFor`: Clears the custom data set for a given player. Player will start using the "top" level value instead.
		- `ClearForList`: Same as `ClearFor`, but accepts a list of players.
		- `ClearFilter`: Accepts a predicate function which checks for which players to clear.
	- Getting data
		- `Get`: Retrieves the "top" value
		- `GetFor`: Gets the current value for the given player. If cleared, returns the top value.

	:::caution Network
	Calling any of the data setter methods (e.g. `Set()`) will
	fire the underlying RemoteEvent to replicate data to the
	clients. Therefore, setting data should only occur when it
	is necessary to change the data that the clients receive.
	:::

	:::caution Tables
	Tables _can_ be used with RemoteProperties. However, the
	RemoteProperty object will _not_ watch for changes within
	the table. Therefore, anytime changes are made to the table,
	the data must be set again using one of the setter methods.
	:::
]=]
local RemoteProperty = {}
RemoteProperty.__index = RemoteProperty

function RemoteProperty.new(
	parent: Instance,
	name: string,
	initialValue: any,
	inboundMiddleware: Types.ServerMiddleware?,
	outboundMiddleware: Types.ServerMiddleware?
)
	local self = setmetatable({}, RemoteProperty)
	self._rs = RemoteSignal.new(parent, name, false, inboundMiddleware, outboundMiddleware)
	self._value = initialValue
	self._perPlayer = {}
	self._playerRemoving = Players.PlayerRemoving:Connect(function(player)
		self._perPlayer[player] = nil
	end)
	self._rs:Connect(function(player)
		local playerValue = self._perPlayer[player]
		local value = if playerValue == nil then self._value elseif playerValue == None then nil else playerValue
		self._rs:Fire(player, value)
	end)
	return self
end

--[=[
	Sets the top-level value of all clients to the same value.
	
	:::note Override Per-Player Data
	This will override any per-player data that was set using
	`SetFor` or `SetFilter`. To avoid overriding this data,
	`SetTop` can be used instead.
	:::

	```lua
	-- Examples
	remoteProperty:Set(10)
	remoteProperty:Set({SomeData = 32})
	remoteProperty:Set("HelloWorld")
	```
]=]
function RemoteProperty:Set(value: any)
	self._value = value
	table.clear(self._perPlayer)
	self._rs:FireAll(value)
end

--[=[
	Set the top-level value of the property, but does not override
	any per-player data (e.g. set with `SetFor` or `SetFilter`).
	Any player without custom-set data will receive this new data.

	This is useful if certain players have specific values that
	should not be changed, but all other players should receive
	the same new value.

	```lua
	-- Using just 'Set' overrides per-player data:
	remoteProperty:SetFor(somePlayer, "CustomData")
	remoteProperty:Set("Data")
	print(remoteProperty:GetFor(somePlayer)) --> "Data"

	-- Using 'SetTop' does not override:
	remoteProperty:SetFor(somePlayer, "CustomData")
	remoteProperty:SetTop("Data")
	print(remoteProperty:GetFor(somePlayer)) --> "CustomData"
	```
]=]
function RemoteProperty:SetTop(value: any)
	self._value = value
	for _, player in ipairs(Players:GetPlayers()) do
		if self._perPlayer[player] == nil then
			self._rs:Fire(player, value)
		end
	end
end

--[=[
	@param value any -- Value to set for the clients (and to the predicate)
	Sets the value for specific clients that pass the `predicate`
	function test. This can be used to finely set the values
	based on more control logic (e.g. setting certain values
	per team).

	```lua
	-- Set the value of "NewValue" to players with a name longer than 10 characters:
	remoteProperty:SetFilter(function(player)
		return #player.Name > 10
	end, "NewValue")
	```
]=]
function RemoteProperty:SetFilter(predicate: (Player, any) -> boolean, value: any)
	for _, player in ipairs(Players:GetPlayers()) do
		if predicate(player, value) then
			self:SetFor(player, value)
		end
	end
end

--[=[
	Set the value of the property for a specific player. This
	will override the value used by `Set` (and the initial value
	set for the property when created).

	This value _can_ be `nil`. In order to reset the value for a
	given player and let the player use the top-level value held
	by this property, either use `Set` to set all players' data,
	or use `ClearFor`.

	```lua
	remoteProperty:SetFor(somePlayer, "CustomData")
	```
]=]
function RemoteProperty:SetFor(player: Player, value: any)
	if player.Parent then
		self._perPlayer[player] = if value == nil then None else value
	end
	self._rs:Fire(player, value)
end

--[=[
	Set the value of the property for specific players. This just
	loops through the players given and calls `SetFor`.

	```lua
	local players = {player1, player2, player3}
	remoteProperty:SetForList(players, "CustomData")
	```
]=]
function RemoteProperty:SetForList(players: { Player }, value: any)
	for _, player in ipairs(players) do
		self:SetFor(player, value)
	end
end

--[=[
	Clears the custom property value for the given player. When
	this occurs, the player will reset to use the top-level
	value held by this property (either the value set when the
	property was created, or the last value set by `Set`).

	```lua
	remoteProperty:Set("DATA")

	remoteProperty:SetFor(somePlayer, "CUSTOM_DATA")
	print(remoteProperty:GetFor(somePlayer)) --> "CUSTOM_DATA"

	-- DOES NOT CLEAR, JUST SETS CUSTOM DATA TO NIL:
	remoteProperty:SetFor(somePlayer, nil)
	print(remoteProperty:GetFor(somePlayer)) --> nil

	-- CLEAR:
	remoteProperty:ClearFor(somePlayer)
	print(remoteProperty:GetFor(somePlayer)) --> "DATA"
	```
]=]
function RemoteProperty:ClearFor(player: Player)
	if self._perPlayer[player] == nil then
		return
	end
	self._perPlayer[player] = nil
	self._rs:Fire(player, self._value)
end

--[=[
	Clears the custom value for the given players. This
	just loops through the list of players and calls
	the `ClearFor` method for each player.
]=]
function RemoteProperty:ClearForList(players: { Player })
	for _, player in ipairs(players) do
		self:ClearFor(player)
	end
end

--[=[
	The same as `SetFiler`, except clears the custom value
	for any player that passes the predicate.
]=]
function RemoteProperty:ClearFilter(predicate: (Player) -> boolean)
	for _, player in ipairs(Players:GetPlayers()) do
		if predicate(player) then
			self:ClearFor(player)
		end
	end
end

--[=[
	Returns the top-level value held by the property. This will
	either be the initial value set, or the last value set
	with `Set()`.

	```lua
	remoteProperty:Set("Data")
	print(remoteProperty:Get()) --> "Data"
	```
]=]
function RemoteProperty:Get(): any
	return self._value
end

--[=[
	Returns the current value for the given player. This value
	will depend on if `SetFor` or `SetFilter` has affected the
	custom value for the player. If so, that custom value will
	be returned. Otherwise, the top-level value will be used
	(e.g. value from `Set`).

	```lua
	-- Set top level data:
	remoteProperty:Set("Data")
	print(remoteProperty:GetFor(somePlayer)) --> "Data"

	-- Set custom data:
	remoteProperty:SetFor(somePlayer, "CustomData")
	print(remoteProperty:GetFor(somePlayer)) --> "CustomData"

	-- Set top level again, overriding custom data:
	remoteProperty:Set("NewData")
	print(remoteProperty:GetFor(somePlayer)) --> "NewData"

	-- Set custom data again, and set top level without overriding:
	remoteProperty:SetFor(somePlayer, "CustomData")
	remoteProperty:SetTop("Data")
	print(remoteProperty:GetFor(somePlayer)) --> "CustomData"

	-- Clear custom data to use top level data:
	remoteProperty:ClearFor(somePlayer)
	print(remoteProperty:GetFor(somePlayer)) --> "Data"
	```
]=]
function RemoteProperty:GetFor(player: Player): any
	local playerValue = self._perPlayer[player]
	local value = if playerValue == nil then self._value elseif playerValue == None then nil else playerValue
	return value
end

--[=[
	Destroys the RemoteProperty object.
]=]
function RemoteProperty:Destroy()
	self._rs:Destroy()
	self._playerRemoving:Disconnect()
end

return RemoteProperty

]==]

 

local Players = game:GetService("Players");
local RemoteSignal = require(script.Parent.RemoteSignal);
require(script.Parent.Parent.Types);
local None = require(script.Parent.Parent.Util).None;
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: string, p4: any, p5: any, p6: any) -- Line: 53
    -- upvalues: u1 (copy), RemoteSignal (copy), Players (copy), None (copy)
    local u7 = setmetatable({}, u1);
    u7._rs = RemoteSignal.new(p2, p3, false, p5, p6);
    u7._value = p4;
    u7._perPlayer = {};
    u7._playerRemoving = Players.PlayerRemoving:Connect(function(p8) -- Line: 64
        -- upvalues: u7 (copy)
        u7._perPlayer[p8] = nil;
    end);
    u7._rs:Connect(function(p9) -- Line: 67
        -- upvalues: u7 (copy), None (ref)
        local v10 = u7._perPlayer[p9];

        if v10 == nil then
            v10 = u7._value;
        elseif v10 == None then
            v10 = nil;
        end;

        u7._rs:Fire(p9, v10);
    end);

    return u7;
end;

function u1.Set(p11, p12) -- Line: 91
    p11._value = p12;
    table.clear(p11._perPlayer);
    p11._rs:FireAll(p12);
end;

function u1.SetTop(p13, p14) -- Line: 118
    -- upvalues: Players (copy)
    p13._value = p14;

    for _, v in ipairs(Players:GetPlayers()) do
        if p13._perPlayer[v] == nil then
            p13._rs:Fire(v, p14);
        end;
    end;
end;

function u1.SetFilter(p15: table, p16: function, p17: any) -- Line: 141
    -- upvalues: Players (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if p16(v, p17) then
            p15:SetFor(v, p17);
        end;
    end;
end;

function u1.SetFor(p18: table, p19: userdata, p20: any) -- Line: 163
    -- upvalues: None (copy)
    if p19.Parent then
        local v21;

        if p20 == nil then
            v21 = None;
        else
            v21 = p20;
        end;

        p18._perPlayer[p19] = v21;
    end;

    p18._rs:Fire(p19, p20);
end;

function u1.SetForList(p22: table, p23: table, p24: any) -- Line: 179
    for _, v in ipairs(p23) do
        p22:SetFor(v, p24);
    end;
end;

function u1.ClearFor(p25: table, p26: userdata) -- Line: 206
    if p25._perPlayer[p26] == nil then
        return;
    end;

    p25._perPlayer[p26] = nil;
    p25._rs:Fire(p26, p25._value);
end;

function u1.ClearForList(p27: table, p28: table) -- Line: 219
    for _, v in ipairs(p28) do
        p27:ClearFor(v);
    end;
end;

function u1.ClearFilter(p29: table, p30: function) -- Line: 229
    -- upvalues: Players (copy)
    for _, v in ipairs(Players:GetPlayers()) do
        if p30(v) then
            p29:ClearFor(v);
        end;
    end;
end;

function u1.Get(p31) -- Line: 247
    return p31._value;
end;

function u1.GetFor(p32: table, p33: userdata) -- Line: 281
    -- upvalues: None (copy)
    local v34 = p32._perPlayer[p33];

    if v34 == nil then
        return p32._value;
    end;

    if v34 == None then
        return nil;
    end;

    return v34;
end;

function u1.Destroy(p35) -- Line: 290
    p35._rs:Destroy();
    p35._playerRemoving:Disconnect();
end;

return u1;