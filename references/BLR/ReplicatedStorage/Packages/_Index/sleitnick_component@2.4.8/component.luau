 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Component
-- Stephen Leitnick
-- November 26, 2021

type AncestorList = { Instance }

--[=[
	@type ExtensionFn (component) -> ()
	@within Component
]=]
type ExtensionFn = (any) -> ()

--[=[
	@type ExtensionShouldFn (component) -> boolean
	@within Component
]=]
type ExtensionShouldFn = (any) -> boolean

--[=[
	@interface Extension
	@within Component
	.ShouldExtend ExtensionShouldFn?
	.ShouldConstruct ExtensionShouldFn?
	.Constructing ExtensionFn?
	.Constructed ExtensionFn?
	.Starting ExtensionFn?
	.Started ExtensionFn?
	.Stopping ExtensionFn?
	.Stopped ExtensionFn?

	An extension allows the ability to extend the behavior of
	components. This is useful for adding injection systems or
	extending the behavior of components by wrapping around
	component lifecycle methods.

	The `ShouldConstruct` function can be used to indicate
	if the component should actually be created. This must
	return `true` or `false`. A component with multiple
	`ShouldConstruct` extension functions must have them _all_
	return `true` in order for the component to be constructed.
	The `ShouldConstruct` function runs _before_ all other
	extension functions and component lifecycle methods.

	The `ShouldExtend` function can be used to indicate if
	the extension itself should be used. This can be used in
	order to toggle an extension on/off depending on whatever
	logic is appropriate. If no `ShouldExtend` function is
	provided, the extension will always be used if provided
	as an extension to the component.

	As an example, an extension could be created to simply log
	when the various lifecycle stages run on the component:

	```lua
	local Logger = {}
	function Logger.Constructing(component) print("Constructing", component) end
	function Logger.Constructed(component) print("Constructed", component) end
	function Logger.Starting(component) print("Starting", component) end
	function Logger.Started(component) print("Started", component) end
	function Logger.Stopping(component) print("Stopping", component) end
	function Logger.Stopped(component) print("Stopped", component) end

	local MyComponent = Component.new({Tag = "MyComponent", Extensions = {Logger}})
	```

	Sometimes it is useful for an extension to control whether or
	not a component should be constructed. For instance, if a
	component on the client should only be instantiated for the
	local player, an extension might look like this, assuming the
	instance has an attribute linking it to the player's UserId:
	```lua
	local player = game:GetService("Players").LocalPlayer

	local OnlyLocalPlayer = {}
	function OnlyLocalPlayer.ShouldConstruct(component)
		local ownerId = component.Instance:GetAttribute("OwnerId")
		return ownerId == player.UserId
	end

	local MyComponent = Component.new({Tag = "MyComponent", Extensions = {OnlyLocalPlayer}})
	```

	It can also be useful for an extension itself to turn on/off
	depending on various contexts. For example, let's take the
	Logger from the first example, and only use that extension
	if the bound instance has a Log attribute set to `true`:
	```lua
	function Logger.ShouldExtend(component)
		return component.Instance:GetAttribute("Log") == true
	end
	```
]=]
type Extension = {
	ShouldExtend: ExtensionShouldFn?,
	ShouldConstruct: ExtensionShouldFn?,
	Constructing: ExtensionFn?,
	Constructed: ExtensionFn?,
	Starting: ExtensionFn?,
	Started: ExtensionFn?,
	Stopping: ExtensionFn?,
	Stopped: ExtensionFn?,
}

--[=[
	@interface ComponentConfig
	@within Component
	.Tag string -- CollectionService tag to use
	.Ancestors {Instance}? -- Optional array of ancestors in which components will be started
	.Extensions {Extension}? -- Optional array of extension objects

	Component configuration passed to `Component.new`.

	- If no Ancestors option is included, it defaults to `{workspace, game.Players}`.
	- If no Extensions option is included, it defaults to a blank table `{}`.
]=]
type ComponentConfig = {
	Tag: string,
	Ancestors: AncestorList?,
	Extensions: { Extension }?,
}

--[=[
	@within Component
	@prop Started Signal
	@tag Event
	@tag Component Class

	Fired when a new instance of a component is started.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})

	MyComponent.Started:Connect(function(component) end)
	```
]=]

--[=[
	@within Component
	@prop Stopped Signal
	@tag Event
	@tag Component Class

	Fired when an instance of a component is stopped.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})

	MyComponent.Stopped:Connect(function(component) end)
	```
]=]

--[=[
	@tag Component Instance
	@within Component
	@prop Instance Instance
	
	A reference back to the _Roblox_ instance from within a _component_ instance. When
	a component instance is created, it is bound to a specific Roblox instance, which
	will always be present through the `Instance` property.

	```lua
	MyComponent.Started:Connect(function(component)
		local robloxInstance: Instance = component.Instance
		print("Component is bound to " .. robloxInstance:GetFullName())
	end)
	```
]=]

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

local Promise = require(script.Parent.Promise)
local Signal = require(script.Parent.Signal)
local Symbol = require(script.Parent.Symbol)
local Trove = require(script.Parent.Trove)

local IS_SERVER = RunService:IsServer()
local DEFAULT_ANCESTORS = { workspace, game:GetService("Players") }
local DEFAULT_TIMEOUT = 60

-- Symbol keys:
local KEY_ANCESTORS = Symbol("Ancestors")
local KEY_INST_TO_COMPONENTS = Symbol("InstancesToComponents")
local KEY_LOCK_CONSTRUCT = Symbol("LockConstruct")
local KEY_COMPONENTS = Symbol("Components")
local KEY_TROVE = Symbol("Trove")
local KEY_EXTENSIONS = Symbol("Extensions")
local KEY_ACTIVE_EXTENSIONS = Symbol("ActiveExtensions")
local KEY_STARTING = Symbol("Starting")
local KEY_STARTED = Symbol("Started")

local renderId = 0
local function NextRenderName(): string
	renderId += 1
	return "ComponentRender" .. tostring(renderId)
end

local function InvokeExtensionFn(component, fnName: string)
	for _, extension in ipairs(component[KEY_ACTIVE_EXTENSIONS]) do
		local fn = extension[fnName]
		if type(fn) == "function" then
			fn(component)
		end
	end
end

local function ShouldConstruct(component): boolean
	for _, extension in ipairs(component[KEY_ACTIVE_EXTENSIONS]) do
		local fn = extension.ShouldConstruct
		if type(fn) == "function" then
			local shouldConstruct = fn(component)
			if not shouldConstruct then
				return false
			end
		end
	end
	return true
end

local function GetActiveExtensions(component, extensionList)
	local activeExtensions = table.create(#extensionList)
	local allActive = true
	for _, extension in ipairs(extensionList) do
		local fn = extension.ShouldExtend
		local shouldExtend = type(fn) ~= "function" or not not fn(component)
		if shouldExtend then
			table.insert(activeExtensions, extension)
		else
			allActive = false
		end
	end
	return if allActive then extensionList else activeExtensions
end

--[=[
	@class Component

	Bind components to Roblox instances using the Component class and CollectionService tags.

	To avoid confusion of terms:
	- `Component` refers to this module.
	- `Component Class` (e.g. `MyComponent` through this documentation) refers to a class created via `Component.new`
	- `Component Instance` refers to an instance of a component class.
	- `Roblox Instance` refers to the Roblox instance to which the component instance is bound.

	Methods and properties are tagged with the above terms to help clarify the level at which they are used.
]=]
local Component = {}
Component.__index = Component

--[=[
	@tag Component
	@param config ComponentConfig
	@return ComponentClass

	Create a new custom Component class.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})
	```

	A full example might look like this:

	```lua
	local MyComponent = Component.new({
		Tag = "MyComponent",
		Ancestors = {workspace},
		Extensions = {Logger}, -- See Logger example within the example for the Extension type
	})

	local AnotherComponent = require(somewhere.AnotherComponent)

	-- Optional if UpdateRenderStepped should use BindToRenderStep:
	MyComponent.RenderPriority = Enum.RenderPriority.Camera.Value

	function MyComponent:Construct()
		self.MyData = "Hello"
	end

	function MyComponent:Start()
		local another = self:GetComponent(AnotherComponent)
		another:DoSomething()
	end

	function MyComponent:Stop()
		self.MyData = "Goodbye"
	end

	function MyComponent:HeartbeatUpdate(dt)
	end

	function MyComponent:SteppedUpdate(dt)
	end
	
	function MyComponent:RenderSteppedUpdate(dt)
	end
	```
]=]
function Component.new(config: ComponentConfig)
	local customComponent = {}
	customComponent.__index = customComponent
	customComponent.__tostring = function()
		return "Component<" .. config.Tag .. ">"
	end
	customComponent[KEY_ANCESTORS] = config.Ancestors or DEFAULT_ANCESTORS
	customComponent[KEY_INST_TO_COMPONENTS] = {}
	customComponent[KEY_COMPONENTS] = {}
	customComponent[KEY_LOCK_CONSTRUCT] = {}
	customComponent[KEY_TROVE] = Trove.new()
	customComponent[KEY_EXTENSIONS] = config.Extensions or {}
	customComponent[KEY_STARTED] = false
	customComponent.Tag = config.Tag
	customComponent.Started = customComponent[KEY_TROVE]:Construct(Signal)
	customComponent.Stopped = customComponent[KEY_TROVE]:Construct(Signal)
	setmetatable(customComponent, Component)
	customComponent:_setup()
	return customComponent
end

function Component:_instantiate(instance: Instance)
	local component = setmetatable({}, self)
	component.Instance = instance
	component[KEY_ACTIVE_EXTENSIONS] = GetActiveExtensions(component, self[KEY_EXTENSIONS])
	if not ShouldConstruct(component) then
		return nil
	end
	InvokeExtensionFn(component, "Constructing")
	if type(component.Construct) == "function" then
		component:Construct()
	end
	InvokeExtensionFn(component, "Constructed")
	return component
end

function Component:_setup()
	local watchingInstances = {}

	local function StartComponent(component)
		component[KEY_STARTING] = coroutine.running()

		InvokeExtensionFn(component, "Starting")

		component:Start()
		if component[KEY_STARTING] == nil then
			-- Component's Start method stopped the component
			return
		end

		InvokeExtensionFn(component, "Started")

		local hasHeartbeatUpdate = typeof(component.HeartbeatUpdate) == "function"
		local hasSteppedUpdate = typeof(component.SteppedUpdate) == "function"
		local hasRenderSteppedUpdate = typeof(component.RenderSteppedUpdate) == "function"

		if hasHeartbeatUpdate then
			component._heartbeatUpdate = RunService.Heartbeat:Connect(function(dt)
				component:HeartbeatUpdate(dt)
			end)
		end

		if hasSteppedUpdate then
			component._steppedUpdate = RunService.Stepped:Connect(function(_, dt)
				component:SteppedUpdate(dt)
			end)
		end

		if hasRenderSteppedUpdate and not IS_SERVER then
			if component.RenderPriority then
				component._renderName = NextRenderName()
				RunService:BindToRenderStep(component._renderName, component.RenderPriority, function(dt)
					component:RenderSteppedUpdate(dt)
				end)
			else
				component._renderSteppedUpdate = RunService.RenderStepped:Connect(function(dt)
					component:RenderSteppedUpdate(dt)
				end)
			end
		end

		component[KEY_STARTED] = true
		component[KEY_STARTING] = nil

		self.Started:Fire(component)
	end

	local function StopComponent(component)
		if component[KEY_STARTING] then
			-- Stop the component during its start method invocation:
			local startThread = component[KEY_STARTING]
			if coroutine.status(startThread) ~= "normal" then
				pcall(function()
					task.cancel(startThread)
				end)
			else
				task.defer(function()
					pcall(function()
						task.cancel(startThread)
					end)
				end)
			end
			component[KEY_STARTING] = nil
		end

		if component._heartbeatUpdate then
			component._heartbeatUpdate:Disconnect()
		end

		if component._steppedUpdate then
			component._steppedUpdate:Disconnect()
		end

		if component._renderSteppedUpdate then
			component._renderSteppedUpdate:Disconnect()
		elseif component._renderName then
			RunService:UnbindFromRenderStep(component._renderName)
		end

		InvokeExtensionFn(component, "Stopping")
		component:Stop()
		InvokeExtensionFn(component, "Stopped")
		self.Stopped:Fire(component)
	end

	local function SafeConstruct(instance, id)
		if self[KEY_LOCK_CONSTRUCT][instance] ~= id then
			return nil
		end
		local component = self:_instantiate(instance)
		if self[KEY_LOCK_CONSTRUCT][instance] ~= id then
			return nil
		end
		return component
	end

	local function TryConstructComponent(instance)
		if self[KEY_INST_TO_COMPONENTS][instance] then
			return
		end
		local id = self[KEY_LOCK_CONSTRUCT][instance] or 0
		id += 1
		self[KEY_LOCK_CONSTRUCT][instance] = id
		task.defer(function()
			local component = SafeConstruct(instance, id)
			if not component then
				return
			end
			self[KEY_INST_TO_COMPONENTS][instance] = component
			table.insert(self[KEY_COMPONENTS], component)
			task.defer(function()
				if self[KEY_INST_TO_COMPONENTS][instance] == component then
					StartComponent(component)
				end
			end)
		end)
	end

	local function TryDeconstructComponent(instance)
		local component = self[KEY_INST_TO_COMPONENTS][instance]
		if not component then
			return
		end
		self[KEY_INST_TO_COMPONENTS][instance] = nil
		self[KEY_LOCK_CONSTRUCT][instance] = nil
		local components = self[KEY_COMPONENTS]
		local index = table.find(components, component)
		if index then
			local n = #components
			components[index] = components[n]
			components[n] = nil
		end
		if component[KEY_STARTED] or component[KEY_STARTING] then
			task.spawn(StopComponent, component)
		end
	end

	local function StartWatchingInstance(instance)
		if watchingInstances[instance] then
			return
		end
		local function IsInAncestorList(): boolean
			for _, parent in ipairs(self[KEY_ANCESTORS]) do
				if instance:IsDescendantOf(parent) then
					return true
				end
			end
			return false
		end
		local ancestryChangedHandle = self[KEY_TROVE]:Connect(instance.AncestryChanged, function(_, parent)
			if parent and IsInAncestorList() then
				TryConstructComponent(instance)
			else
				TryDeconstructComponent(instance)
			end
		end)
		watchingInstances[instance] = ancestryChangedHandle
		if IsInAncestorList() then
			TryConstructComponent(instance)
		end
	end

	local function InstanceTagged(instance: Instance)
		StartWatchingInstance(instance)
	end

	local function InstanceUntagged(instance: Instance)
		local watchHandle = watchingInstances[instance]
		if watchHandle then
			watchingInstances[instance] = nil
			self[KEY_TROVE]:Remove(watchHandle)
		end
		TryDeconstructComponent(instance)
	end

	self[KEY_TROVE]:Connect(CollectionService:GetInstanceAddedSignal(self.Tag), InstanceTagged)
	self[KEY_TROVE]:Connect(CollectionService:GetInstanceRemovedSignal(self.Tag), InstanceUntagged)

	local tagged = CollectionService:GetTagged(self.Tag)
	for _, instance in ipairs(tagged) do
		task.defer(InstanceTagged, instance)
	end
end

--[=[
	@tag Component Class
	@return {Component}
	Gets a table array of all existing component objects. For example,
	if there was a component class linked to the "MyComponent" tag,
	and three Roblox instances in your game had that same tag, then
	calling `GetAll` would return the three component instances.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})

	-- ...

	local components = MyComponent:GetAll()
	for _,component in ipairs(components) do
		component:DoSomethingHere()
	end
	```
]=]
function Component:GetAll()
	return self[KEY_COMPONENTS]
end

--[=[
	@tag Component Class
	@return Component?

	Gets an instance of a component class from the given Roblox
	instance. Returns `nil` if not found.

	```lua
	local MyComponent = require(somewhere.MyComponent)

	local myComponentInstance = MyComponent:FromInstance(workspace.SomeInstance)
	```
]=]
function Component:FromInstance(instance: Instance)
	return self[KEY_INST_TO_COMPONENTS][instance]
end

--[=[
	@tag Component Class
	@return Promise<ComponentInstance>

	Resolves a promise once the component instance is present on a given
	Roblox instance.

	An optional `timeout` can be provided to reject the promise if it
	takes more than `timeout` seconds to resolve. If no timeout is
	supplied, `timeout` defaults to 60 seconds.

	```lua
	local MyComponent = require(somewhere.MyComponent)

	MyComponent:WaitForInstance(workspace.SomeInstance):andThen(function(myComponentInstance)
		-- Do something with the component class
	end)
	```
]=]
function Component:WaitForInstance(instance: Instance, timeout: number?)
	local componentInstance = self:FromInstance(instance)
	if componentInstance and componentInstance[KEY_STARTED] then
		return Promise.resolve(componentInstance)
	end
	return Promise.fromEvent(self.Started, function(c)
		local match = c.Instance == instance
		if match then
			componentInstance = c
		end
		return match
	end)
		:andThen(function()
			return componentInstance
		end)
		:timeout(if type(timeout) == "number" then timeout else DEFAULT_TIMEOUT)
end

--[=[
	@tag Component Class
	`Construct` is called before the component is started, and should be used
	to construct the component instance.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})

	function MyComponent:Construct()
		self.SomeData = 32
		self.OtherStuff = "HelloWorld"
	end
	```
]=]
function Component:Construct() end

--[=[
	@tag Component Class
	`Start` is called when the component is started. At this point in time, it
	is safe to grab other components also bound to the same instance.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})
	local AnotherComponent = require(somewhere.AnotherComponent)

	function MyComponent:Start()
		-- e.g., grab another component:
		local another = self:GetComponent(AnotherComponent)
	end
	```
]=]
function Component:Start() end

--[=[
	@tag Component Class
	`Stop` is called when the component is stopped. This occurs either when the
	bound instance is removed from one of the whitelisted ancestors _or_ when
	the matching tag is removed from the instance. This also means that the
	instance _might_ be destroyed, and thus it is not safe to continue using
	the bound instance (e.g. `self.Instance`) any longer.

	This should be used to clean up the component.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})

	function MyComponent:Stop()
		self.SomeStuff:Destroy()
	end
	```
]=]
function Component:Stop() end

--[=[
	@tag Component Instance
	@param componentClass ComponentClass
	@return Component?

	Retrieves another component instance bound to the same
	Roblox instance.

	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})
	local AnotherComponent = require(somewhere.AnotherComponent)

	function MyComponent:Start()
		local another = self:GetComponent(AnotherComponent)
	end
	```
]=]
function Component:GetComponent(componentClass)
	return componentClass[KEY_INST_TO_COMPONENTS][self.Instance]
end

--[=[
	@tag Component Class
	@function HeartbeatUpdate
	@param dt number
	@within Component

	If this method is present on a component, then it will be
	automatically connected to `RunService.Heartbeat`.

	:::note Method
	This is a method, not a function. This is a limitation
	of the documentation tool which should be fixed soon.
	:::
	
	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})
	
	function MyComponent:HeartbeatUpdate(dt)
	end
	```
]=]
--[=[
	@tag Component Class
	@function SteppedUpdate
	@param dt number
	@within Component

	If this method is present on a component, then it will be
	automatically connected to `RunService.Stepped`.

	:::note Method
	This is a method, not a function. This is a limitation
	of the documentation tool which should be fixed soon.
	:::
	
	```lua
	local MyComponent = Component.new({Tag = "MyComponent"})
	
	function MyComponent:SteppedUpdate(dt)
	end
	```
]=]
--[=[
	@tag Component Class
	@function RenderSteppedUpdate
	@param dt number
	@within Component
	@client

	If this method is present on a component, then it will be
	automatically connected to `RunService.RenderStepped`. If
	the `[Component].RenderPriority` field is found, then the
	component will instead use `RunService:BindToRenderStep()`
	to bind the function.

	:::note Method
	This is a method, not a function. This is a limitation
	of the documentation tool which should be fixed soon.
	:::
	
	```lua
	-- Example that uses `RunService.RenderStepped` automatically:

	local MyComponent = Component.new({Tag = "MyComponent"})
	
	function MyComponent:RenderSteppedUpdate(dt)
	end
	```
	```lua
	-- Example that uses `RunService:BindToRenderStep` automatically:
	
	local MyComponent = Component.new({Tag = "MyComponent"})

	-- Defining a RenderPriority will force the component to use BindToRenderStep instead
	MyComponent.RenderPriority = Enum.RenderPriority.Camera.Value
	
	function MyComponent:RenderSteppedUpdate(dt)
	end
	```
]=]

function Component:Destroy()
	self[KEY_TROVE]:Destroy()
end

return Component

]==]

 

local CollectionService = game:GetService("CollectionService");
local RunService = game:GetService("RunService");
local Promise = require(script.Parent.Promise);
local Signal = require(script.Parent.Signal);
local Symbol = require(script.Parent.Symbol);
local Trove = require(script.Parent.Trove);
local u1 = RunService:IsServer();
local u2 = { workspace, game:GetService("Players") };
local u3 = Symbol("Ancestors");
local u4 = Symbol("InstancesToComponents");
local u5 = Symbol("LockConstruct");
local u6 = Symbol("Components");
local u7 = Symbol("Trove");
local u8 = Symbol("Extensions");
local u9 = Symbol("ActiveExtensions");
local u10 = Symbol("Starting");
local u11 = Symbol("Started");
local u12 = 0;

local function NextRenderName() -- Line: 193
    -- upvalues: u12 (ref)
    u12 = u12 + 1;

    return "ComponentRender" .. tostring(u12);
end;

local function InvokeExtensionFn(p13: any, p14: string) -- Line: 198
    -- upvalues: u9 (copy)
    for _, v in ipairs(p13[u9]) do
        local v15 = v[p14];

        if type(v15) == "function" then
            v15(p13);
        end;
    end;
end;

local function ShouldConstruct(p16) -- Line: 207
    -- upvalues: u9 (copy)
    for _, v in ipairs(p16[u9]) do
        local ShouldConstruct = v.ShouldConstruct;

        if type(ShouldConstruct) == "function" and not ShouldConstruct(p16) then
            return false;
        end;
    end;

    return true;
end;

local function GetActiveExtensions(p17, p18) -- Line: 220
    local table_create_ret = table.create(#p18);
    local v19 = true;

    for _, v in ipairs(p18) do
        local ShouldExtend = v.ShouldExtend;

        if type(ShouldExtend) ~= "function" and true or (ShouldExtend(p17) and true or false) then
            table.insert(table_create_ret, v);
        else
            v19 = false;
        end;
    end;

    if v19 then
        return p18;
    end;

    return table_create_ret;
end;

local u20 = {};
u20.__index = u20;

function u20.new(u21: table) -- Line: 299
    -- upvalues: u3 (copy), u2 (copy), u4 (copy), u6 (copy), u5 (copy), u7 (copy), Trove (copy), u8 (copy), u11 (copy), Signal (copy), u20 (copy)
    local v22 = {};
    v22.__index = v22;

    function v22.__tostring() -- Line: 302
        -- upvalues: u21 (copy)
        return "Component<" .. u21.Tag .. ">";
    end;

    v22[u3] = u21.Ancestors or u2;
    v22[u4] = {};
    v22[u6] = {};
    v22[u5] = {};
    v22[u7] = Trove.new();
    v22[u8] = u21.Extensions or {};
    v22[u11] = false;
    v22.Tag = u21.Tag;
    v22.Started = v22[u7]:Construct(Signal);
    v22.Stopped = v22[u7]:Construct(Signal);
    setmetatable(v22, u20);
    v22:_setup();

    return v22;
end;

function u20._instantiate(p23: table, p24: userdata) -- Line: 320
    -- upvalues: u9 (copy), GetActiveExtensions (copy), u8 (copy), ShouldConstruct (copy), InvokeExtensionFn (copy)
    local v25 = setmetatable({}, p23);
    v25.Instance = p24;
    v25[u9] = GetActiveExtensions(v25, p23[u8]);

    if not ShouldConstruct(v25) then
        return nil;
    end;

    InvokeExtensionFn(v25, "Constructing");

    if type(v25.Construct) == "function" then
        v25:Construct();
    end;

    InvokeExtensionFn(v25, "Constructed");

    return v25;
end;

function u20._setup(u26) -- Line: 335
    -- upvalues: u10 (copy), InvokeExtensionFn (copy), RunService (copy), u1 (copy), u12 (ref), u11 (copy), u5 (copy), u4 (copy), u6 (copy), u3 (copy), u7 (copy), CollectionService (copy)
    local u27 = {};

    local function StartComponent(u28) -- Line: 338
        -- upvalues: u10 (ref), InvokeExtensionFn (ref), RunService (ref), u1 (ref), u12 (ref), u11 (ref), u26 (copy)
        u28[u10] = coroutine.running();
        InvokeExtensionFn(u28, "Starting");
        u28:Start();

        if u28[u10] == nil then
            return;
        end;

        InvokeExtensionFn(u28, "Started");
        local v29 = typeof(u28.HeartbeatUpdate) == "function";
        local v30 = typeof(u28.SteppedUpdate) == "function";
        local v31 = typeof(u28.RenderSteppedUpdate) == "function";

        if v29 then
            u28._heartbeatUpdate = RunService.Heartbeat:Connect(function(p32) -- Line: 356
                -- upvalues: u28 (copy)
                u28:HeartbeatUpdate(p32);
            end);
        end;

        if v30 then
            u28._steppedUpdate = RunService.Stepped:Connect(function(p33, p34) -- Line: 362
                -- upvalues: u28 (copy)
                u28:SteppedUpdate(p34);
            end);
        end;

        if v31 and not u1 then
            if u28.RenderPriority then
                u12 = u12 + 1;
                u28._renderName = "ComponentRender" .. tostring(u12);
                RunService:BindToRenderStep(u28._renderName, u28.RenderPriority, function(p35) -- Line: 370
                    -- upvalues: u28 (copy)
                    u28:RenderSteppedUpdate(p35);
                end);
            else
                u28._renderSteppedUpdate = RunService.RenderStepped:Connect(function(p36) -- Line: 374
                    -- upvalues: u28 (copy)
                    u28:RenderSteppedUpdate(p36);
                end);
            end;
        end;

        u28[u11] = true;
        u28[u10] = nil;
        u26.Started:Fire(u28);
    end;

    local function StopComponent(p37) -- Line: 386
        -- upvalues: u10 (ref), RunService (ref), InvokeExtensionFn (ref), u26 (copy)
        if p37[u10] then
            local u38 = p37[u10];

            if coroutine.status(u38) == "normal" then
                task.defer(function() -- Line: 395
                    -- upvalues: u38 (copy)
                    pcall(function() -- Line: 396
                        -- upvalues: u38 (ref)
                        task.cancel(u38);
                    end);
                end);
            else
                pcall(function() -- Line: 391
                    -- upvalues: u38 (copy)
                    task.cancel(u38);
                end);
            end;

            p37[u10] = nil;
        end;

        if p37._heartbeatUpdate then
            p37._heartbeatUpdate:Disconnect();
        end;

        if p37._steppedUpdate then
            p37._steppedUpdate:Disconnect();
        end;

        if p37._renderSteppedUpdate then
            p37._renderSteppedUpdate:Disconnect();
        elseif p37._renderName then
            RunService:UnbindFromRenderStep(p37._renderName);
        end;

        InvokeExtensionFn(p37, "Stopping");
        p37:Stop();
        InvokeExtensionFn(p37, "Stopped");
        u26.Stopped:Fire(p37);
    end;

    local function SafeConstruct(p39, p40) -- Line: 424
        -- upvalues: u26 (copy), u5 (ref)
        if u26[u5][p39] ~= p40 then
            return nil;
        end;

        local v41 = u26:_instantiate(p39);

        if u26[u5][p39] == p40 then
            return v41;
        end;

        return nil;
    end;

    local function TryConstructComponent(u42) -- Line: 435
        -- upvalues: u26 (copy), u4 (ref), u5 (ref), u6 (ref), StartComponent (copy)
        if u26[u4][u42] then
            return;
        end;

        local u43 = (u26[u5][u42] or 0) + 1;
        u26[u5][u42] = u43;
        task.defer(function() -- Line: 442
            -- upvalues: u42 (copy), u43 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
            local v44 = u42;
            local v45 = u43;
            local u46;

            if u26[u5][v44] == v45 then
                u46 = u26:_instantiate(v44);

                if u26[u5][v44] ~= v45 then
                    u46 = nil;
                end;
            else
                u46 = nil;
            end;

            if not u46 then
                return;
            end;

            u26[u4][u42] = u46;
            table.insert(u26[u6], u46);
            task.defer(function() -- Line: 449
                -- upvalues: u26 (ref), u4 (ref), u42 (ref), u46 (copy), StartComponent (ref)
                if u26[u4][u42] == u46 then
                    StartComponent(u46);
                end;
            end);
        end);
    end;

    local function TryDeconstructComponent(p47) -- Line: 457
        -- upvalues: u26 (copy), u4 (ref), u5 (ref), u6 (ref), u11 (ref), u10 (ref), StopComponent (copy)
        local v48 = u26[u4][p47];

        if not v48 then
            return;
        end;

        u26[u4][p47] = nil;
        u26[u5][p47] = nil;
        local v49 = u26[u6];
        local table_find_ret = table.find(v49, v48);

        if table_find_ret then
            local v50 = #v49;
            v49[table_find_ret] = v49[v50];
            v49[v50] = nil;
        end;

        if v48[u11] or v48[u10] then
            task.spawn(StopComponent, v48);
        end;
    end;

    local function StartWatchingInstance(u51) -- Line: 476
        -- upvalues: u27 (copy), u26 (copy), u3 (ref), u7 (ref), u4 (ref), u5 (ref), u6 (ref), StartComponent (copy), TryDeconstructComponent (copy)
        if u27[u51] then
            return;
        end;

        local function IsInAncestorList() -- Line: 480
            -- upvalues: u26 (ref), u3 (ref), u51 (copy)
            for _, v in ipairs(u26[u3]) do
                if u51:IsDescendantOf(v) then
                    return true;
                end;
            end;

            return false;
        end;

        u27[u51] = u26[u7]:Connect(u51.AncestryChanged, function(p52, p53) -- Line: 488
            -- upvalues: u26 (ref), u3 (ref), u51 (copy), u4 (ref), u5 (ref), u6 (ref), StartComponent (ref), TryDeconstructComponent (ref)
            if p53 then
                local v54 = false;

                for _, v in ipairs(u26[u3]) do
                    if u51:IsDescendantOf(v) then
                        v54 = true;
                        break;
                    end;
                end;

                if v54 then
                    local u55 = u51;

                    if u26[u4][u55] then
                        return;
                    end;

                    local u56 = (u26[u5][u55] or 0) + 1;
                    u26[u5][u55] = u56;
                    task.defer(function() -- Line: 442
                        -- upvalues: u55 (copy), u56 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
                        local v57 = u55;
                        local v58 = u56;
                        local u59;

                        if u26[u5][v57] == v58 then
                            u59 = u26:_instantiate(v57);

                            if u26[u5][v57] ~= v58 then
                                u59 = nil;
                            end;
                        else
                            u59 = nil;
                        end;

                        if not u59 then
                            return;
                        end;

                        u26[u4][u55] = u59;
                        table.insert(u26[u6], u59);
                        task.defer(function() -- Line: 449
                            -- upvalues: u26 (ref), u4 (ref), u55 (ref), u59 (copy), StartComponent (ref)
                            if u26[u4][u55] == u59 then
                                StartComponent(u59);
                            end;
                        end);
                    end);

                    return;
                end;
            end;

            TryDeconstructComponent(u51);
        end);
        local v60 = false;

        for _, v in ipairs(u26[u3]) do
            if u51:IsDescendantOf(v) then
                v60 = true;
                break;
            end;
        end;

        if v60 then
            if u26[u4][u51] then
                return;
            end;

            local u61 = (u26[u5][u51] or 0) + 1;
            u26[u5][u51] = u61;
            task.defer(function() -- Line: 442
                -- upvalues: u51 (copy), u61 (ref), u26 (ref), u5 (ref), u4 (ref), u6 (ref), StartComponent (ref)
                local v62 = u51;
                local v63 = u61;
                local u64;

                if u26[u5][v62] == v63 then
                    u64 = u26:_instantiate(v62);

                    if u26[u5][v62] ~= v63 then
                        u64 = nil;
                    end;
                else
                    u64 = nil;
                end;

                if not u64 then
                    return;
                end;

                u26[u4][u51] = u64;
                table.insert(u26[u6], u64);
                task.defer(function() -- Line: 449
                    -- upvalues: u26 (ref), u4 (ref), u51 (ref), u64 (copy), StartComponent (ref)
                    if u26[u4][u51] == u64 then
                        StartComponent(u64);
                    end;
                end);
            end);
        end;
    end;

    local function InstanceTagged(p65: userdata) -- Line: 501
        -- upvalues: StartWatchingInstance (copy)
        StartWatchingInstance(p65);
    end;

    local function InstanceUntagged(p66: userdata) -- Line: 505
        -- upvalues: u27 (copy), u26 (copy), u7 (ref), TryDeconstructComponent (copy)
        local v67 = u27[p66];

        if v67 then
            u27[p66] = nil;
            u26[u7]:Remove(v67);
        end;

        TryDeconstructComponent(p66);
    end;

    u26[u7]:Connect(CollectionService:GetInstanceAddedSignal(u26.Tag), InstanceTagged);
    u26[u7]:Connect(CollectionService:GetInstanceRemovedSignal(u26.Tag), InstanceUntagged);
    local Tagged = CollectionService:GetTagged(u26.Tag);

    for _, v in ipairs(Tagged) do
        task.defer(InstanceTagged, v);
    end;
end;

function u20.GetAll(p68) -- Line: 542
    -- upvalues: u6 (copy)
    return p68[u6];
end;

function u20.FromInstance(p69: table, p70: userdata) -- Line: 559
    -- upvalues: u4 (copy)
    return p69[u4][p70];
end;

function u20.WaitForInstance(p71: table, u72: userdata, p73: number?) -- Line: 582
    -- upvalues: u11 (copy), Promise (copy)
    local u74 = p71:FromInstance(u72);

    if u74 and u74[u11] then
        return Promise.resolve(u74);
    end;

    return Promise.fromEvent(p71.Started, function(p75) -- Line: 587
        -- upvalues: u72 (copy), u74 (ref)
        local v76 = p75.Instance == u72;

        if v76 then
            u74 = p75;
        end;

        return v76;
    end):andThen(function() -- Line: 594
        -- upvalues: u74 (ref)
        return u74;
    end):timeout(type(p73) ~= "number" and 60 or p73);
end;

function u20.Construct(p77) -- Line: 614
end;

function u20.Start(p78) -- Line: 631
end;

function u20.Stop(p79) -- Line: 651
end;

function u20.GetComponent(p80, p81) -- Line: 670
    -- upvalues: u4 (copy)
    return p81[u4][p80.Instance];
end;

function u20.Destroy(p82) -- Line: 755
    -- upvalues: u7 (copy)
    p82[u7]:Destroy();
end;

return u20;