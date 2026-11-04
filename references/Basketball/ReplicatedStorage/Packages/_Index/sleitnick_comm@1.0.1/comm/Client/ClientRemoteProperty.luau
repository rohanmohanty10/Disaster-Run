 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- ClientRemoteProperty
-- Stephen Leitnick
-- December 20, 2021

local Promise = require(script.Parent.Parent.Parent.Promise)
local Signal = require(script.Parent.Parent.Parent.Signal)
local ClientRemoteSignal = require(script.Parent.ClientRemoteSignal)
local Types = require(script.Parent.Parent.Types)

--[=[
	@within ClientRemoteProperty
	@prop Changed Signal<any>

	Fires when the property receives an updated value
	from the server.

	```lua
	clientRemoteProperty.Changed:Connect(function(value)
		print("New value", value)
	end)
	```
]=]

--[=[
	@class ClientRemoteProperty
	@client
	Created via `ClientComm:GetProperty()`.
]=]
local ClientRemoteProperty = {}
ClientRemoteProperty.__index = ClientRemoteProperty

function ClientRemoteProperty.new(
	re: RemoteEvent,
	inboundMiddleware: Types.ClientMiddleware?,
	outboudMiddleware: Types.ClientMiddleware?
)
	local self = setmetatable({}, ClientRemoteProperty)
	self._rs = ClientRemoteSignal.new(re, inboundMiddleware, outboudMiddleware)
	self._ready = false
	self._value = nil
	self.Changed = Signal.new()
	self._rs:Fire()

	local resolveOnReadyPromise
	self._readyPromise = Promise.new(function(resolve)
		resolveOnReadyPromise = resolve
	end)
	self._changed = self._rs:Connect(function(value)
		local changed = value ~= self._value
		self._value = value
		if not self._ready then
			self._ready = true
			resolveOnReadyPromise(value)
		end
		if changed then
			self.Changed:Fire(value)
		end
	end)

	return self
end

--[=[
	Gets the value of the property object.

	:::caution
	This value might not be ready right away. Use `OnReady()` or `IsReady()`
	before calling `Get()`. If not ready, this value will return `nil`.
	:::
]=]
function ClientRemoteProperty:Get(): any
	return self._value
end

--[=[
	@return Promise<any>
	Returns a Promise which resolves once the property object is
	ready to be used. The resolved promise will also contain the
	value of the property.

	```lua
	-- Use andThen clause:
	clientRemoteProperty:OnReady():andThen(function(initialValue)
		print(initialValue)
	end)

	-- Use await:
	local success, initialValue = clientRemoteProperty:OnReady():await()
	if success then
		print(initialValue)
	end
	```
]=]
function ClientRemoteProperty:OnReady()
	return self._readyPromise
end

--[=[
	Returns `true` if the property object is ready to be
	used. In other words, it has successfully gained
	connection to the server-side version and has synced
	in the initial value.

	```lua
	if clientRemoteProperty:IsReady() then
		local value = clientRemoteProperty:Get()
	end
	```
]=]
function ClientRemoteProperty:IsReady(): boolean
	return self._ready
end

--[=[
	@param observer (any) -> nil
	@return Connection
	Observes the value of the property. The observer will
	be called right when the value is first ready, and
	every time the value changes. This is safe to call
	immediately (i.e. no need to use `IsReady` or `OnReady`
	before using this method).

	Observing is essentially listening to `Changed`, but
	also sends the initial value right away (or at least
	once `OnReady` is completed).

	```lua
	local function ObserveValue(value)
		print(value)
	end

	clientRemoteProperty:Observe(ObserveValue)
	```
]=]
function ClientRemoteProperty:Observe(observer: (any) -> ())
	if self._ready then
		task.defer(observer, self._value)
	end
	return self.Changed:Connect(observer)
end

--[=[
	Destroys the ClientRemoteProperty object.
]=]
function ClientRemoteProperty:Destroy()
	self._rs:Destroy()
	if self._readyPromise then
		self._readyPromise:cancel()
	end
	if self._changed then
		self._changed:Disconnect()
	end
	self.Changed:Destroy()
end

return ClientRemoteProperty

]==]

 

local Promise = require(script.Parent.Parent.Parent.Promise);
local Signal = require(script.Parent.Parent.Parent.Signal);
local ClientRemoteSignal = require(script.Parent.ClientRemoteSignal);
require(script.Parent.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2: userdata, p3: any, p4: any) -- Line: 32
    -- upvalues: u1 (copy), ClientRemoteSignal (copy), Signal (copy), Promise (copy)
    local u5 = setmetatable({}, u1);
    u5._rs = ClientRemoteSignal.new(p2, p3, p4);
    u5._ready = false;
    u5._value = nil;
    u5.Changed = Signal.new();
    u5._rs:Fire();
    local u6 = nil;
    u5._readyPromise = Promise.new(function(p7) -- Line: 45
        -- upvalues: u6 (ref)
        u6 = p7;
    end);
    u5._changed = u5._rs:Connect(function(p8) -- Line: 48
        -- upvalues: u5 (copy), u6 (ref)
        local v9 = p8 ~= u5._value;
        u5._value = p8;

        if not u5._ready then
            u5._ready = true;
            u6(p8);
        end;

        if v9 then
            u5.Changed:Fire(p8);
        end;
    end);

    return u5;
end;

function u1.Get(p10) -- Line: 71
    return p10._value;
end;

function u1.OnReady(p11) -- Line: 94
    return p11._readyPromise;
end;

function u1.IsReady(p12) -- Line: 110
    return p12._ready;
end;

function u1.Observe(p13: table, p14: function) -- Line: 135
    if p13._ready then
        task.defer(p14, p13._value);
    end;

    return p13.Changed:Connect(p14);
end;

function u1.Destroy(p15) -- Line: 145
    p15._rs:Destroy();

    if p15._readyPromise then
        p15._readyPromise:cancel();
    end;

    if p15._changed then
        p15._changed:Disconnect();
    end;

    p15.Changed:Destroy();
end;

return u1;