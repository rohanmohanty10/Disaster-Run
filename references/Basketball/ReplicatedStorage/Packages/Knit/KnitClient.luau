 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
--[=[
	@interface Middleware
	.Inbound ClientMiddleware?
	.Outbound ClientMiddleware?
	@within KnitClient
]=]
type Middleware = {
	Inbound: ClientMiddleware?,
	Outbound: ClientMiddleware?,
}

--[=[
	@type ClientMiddlewareFn (args: {any}) -> (shouldContinue: boolean, ...: any)
	@within KnitClient

	For more info, see [ClientComm](https://sleitnick.github.io/RbxUtil/api/ClientComm/) documentation.
]=]
type ClientMiddlewareFn = (args: { any }) -> (boolean, ...any)

--[=[
	@type ClientMiddleware {ClientMiddlewareFn}
	@within KnitClient
	An array of client middleware functions.
]=]
type ClientMiddleware = { ClientMiddlewareFn }

--[=[
	@type PerServiceMiddleware {[string]: Middleware}
	@within KnitClient
]=]
type PerServiceMiddleware = { [string]: Middleware }

--[=[
	@interface ControllerDef
	.Name string
	.[any] any
	@within KnitClient
	Used to define a controller when creating it in `CreateController`.
]=]
type ControllerDef = {
	Name: string,
	[any]: any,
}

--[=[
	@interface Controller
	.Name string
	.[any] any
	@within KnitClient
]=]
type Controller = {
	Name: string,
	[any]: any,
}

--[=[
	@interface Service
	.[any] any
	@within KnitClient
]=]
type Service = {
	[any]: any,
}

--[=[
	@interface KnitOptions
	.ServicePromises boolean?
	.Middleware Middleware?
	.PerServiceMiddleware PerServiceMiddleware?
	@within KnitClient

	- `ServicePromises` defaults to `true` and indicates if service methods use promises.
	- Each service will go through the defined middleware, unless the service
	has middleware defined in `PerServiceMiddleware`.
]=]
type KnitOptions = {
	ServicePromises: boolean,
	Middleware: Middleware?,
	PerServiceMiddleware: PerServiceMiddleware?,
}

local defaultOptions: KnitOptions = {
	ServicePromises = true,
	Middleware = nil,
	PerServiceMiddleware = {},
}

local selectedOptions = nil

--[=[
	@class KnitClient
	@client
]=]
local KnitClient = {}

--[=[
	@prop Player Player
	@within KnitClient
	@readonly
	Reference to the LocalPlayer.
]=]
KnitClient.Player = game:GetService("Players").LocalPlayer

--[=[
	@prop Util Folder
	@within KnitClient
	@readonly
	References the Util folder. Should only be accessed when using Knit as
	a standalone module. If using Knit from Wally, modules should just be
	pulled in via Wally instead of relying on Knit's Util folder, as this
	folder only contains what is necessary for Knit to run in Wally mode.
]=]
KnitClient.Util = (script.Parent :: Instance).Parent

local Promise = require(KnitClient.Util.Promise)
local Comm = require(KnitClient.Util.Comm)
local ClientComm = Comm.ClientComm

local controllers: { [string]: Controller } = {}
local services: { [string]: Service } = {}
local servicesFolder = nil

local started = false
local startedComplete = false
local onStartedComplete = Instance.new("BindableEvent")

local function DoesControllerExist(controllerName: string): boolean
	local controller: Controller? = controllers[controllerName]

	return controller ~= nil
end

local function GetServicesFolder()
	if not servicesFolder then
		servicesFolder = (script.Parent :: Instance):WaitForChild("Services")
	end

	return servicesFolder
end

local function GetMiddlewareForService(serviceName: string)
	local knitMiddleware = if selectedOptions.Middleware ~= nil then selectedOptions.Middleware else {}
	local serviceMiddleware = selectedOptions.PerServiceMiddleware[serviceName]

	return if serviceMiddleware ~= nil then serviceMiddleware else knitMiddleware
end

local function BuildService(serviceName: string)
	local folder = GetServicesFolder()
	local middleware = GetMiddlewareForService(serviceName)
	local clientComm = ClientComm.new(folder, selectedOptions.ServicePromises, serviceName)
	local service = clientComm:BuildObject(middleware.Inbound, middleware.Outbound)

	services[serviceName] = service

	return service
end

--[=[
	Creates a new controller.

	:::caution
	Controllers must be created _before_ calling `Knit.Start()`.
	:::
	```lua
	-- Create a controller
	local MyController = Knit.CreateController {
		Name = "MyController",
	}

	function MyController:KnitStart()
		print("MyController started")
	end

	function MyController:KnitInit()
		print("MyController initialized")
	end
	```
]=]
function KnitClient.CreateController(controllerDef: ControllerDef): Controller
	assert(type(controllerDef) == "table", `Controller must be a table; got {type(controllerDef)}`)
	assert(type(controllerDef.Name) == "string", `Controller.Name must be a string; got {type(controllerDef.Name)}`)
	assert(#controllerDef.Name > 0, "Controller.Name must be a non-empty string")
	assert(not DoesControllerExist(controllerDef.Name), `Controller {controllerDef.Name} already exists`)
	assert(not started, `Controllers cannot be created after calling "Knit.Start()"`)

	local controller = controllerDef :: Controller
	controllers[controller.Name] = controller

	return controller
end

--[=[
	Requires all the modules that are children of the given parent. This is an easy
	way to quickly load all controllers that might be in a folder.
	```lua
	Knit.AddControllers(somewhere.Controllers)
	```
]=]
function KnitClient.AddControllers(parent: Instance): { Controller }
	assert(not started, `Controllers cannot be added after calling "Knit.Start()"`)

	local addedControllers = {}
	for _, v in parent:GetChildren() do
		if not v:IsA("ModuleScript") then
			continue
		end

		table.insert(addedControllers, require(v))
	end

	return addedControllers
end

--[=[
	Requires all the modules that are descendants of the given parent.
]=]
function KnitClient.AddControllersDeep(parent: Instance): { Controller }
	assert(not started, `Controllers cannot be added after calling "Knit.Start()"`)

	local addedControllers = {}
	for _, v in parent:GetDescendants() do
		if not v:IsA("ModuleScript") then
			continue
		end

		table.insert(addedControllers, require(v))
	end

	return addedControllers
end

--[=[
	Returns a Service object which is a reflection of the remote objects
	within the Client table of the given service. Throws an error if the
	service is not found.

	If a service's Client table contains RemoteSignals and/or RemoteProperties,
	these values are reflected as
	[ClientRemoteSignals](https://sleitnick.github.io/RbxUtil/api/ClientRemoteSignal) and
	[ClientRemoteProperties](https://sleitnick.github.io/RbxUtil/api/ClientRemoteProperty).

	```lua
	-- Server-side service creation:
	local MyService = Knit.CreateService {
		Name = "MyService",
		Client = {
			MySignal = Knit.CreateSignal(),
			MyProperty = Knit.CreateProperty("Hello"),
		},
	}
	function MyService:AddOne(player, number)
		return number + 1
	end

	-------------------------------------------------

	-- Client-side service reflection:
	local MyService = Knit.GetService("MyService")

	-- Call a method:
	local num = MyService:AddOne(5) --> 6

	-- Fire a signal to the server:
	MyService.MySignal:Fire("Hello")

	-- Listen for signals from the server:
	MyService.MySignal:Connect(function(message)
		print(message)
	end)

	-- Observe the initial value and changes to properties:
	MyService.MyProperty:Observe(function(value)
		print(value)
	end)
	```

	:::caution
	Services are only exposed to the client if the service has remote-based
	content in the Client table. If not, the service will not be visible
	to the client. `KnitClient.GetService` will only work on services that
	expose remote-based content on their Client tables.
	:::
]=]
function KnitClient.GetService(serviceName: string): Service
	local service = services[serviceName]
	if service then
		return service
	end

	assert(started, "Cannot call GetService until Knit has been started")
	assert(type(serviceName) == "string", `ServiceName must be a string; got {type(serviceName)}`)

	return BuildService(serviceName)
end

--[=[
	Gets the controller by name. Throws an error if the controller
	is not found.
]=]
function KnitClient.GetController(controllerName: string): Controller
	local controller = controllers[controllerName]
	if controller then
		return controller
	end

	assert(started, "Cannot call GetController until Knit has been started")
	assert(type(controllerName) == "string", `ControllerName must be a string; got {type(controllerName)}`)
	error(`Could not find controller "{controllerName}". Check to verify a controller with this name exists.`, 2)
end

--[=[
	Gets a table of all controllers.
]=]
function KnitClient.GetControllers(): { [string]: Controller }
	assert(started, "Cannot call GetControllers until Knit has been started")

	return controllers
end

--[=[
	@return Promise
	Starts Knit. Should only be called once per client.
	```lua
	Knit.Start():andThen(function()
		print("Knit started!")
	end):catch(warn)
	```

	By default, service methods exposed to the client will return promises.
	To change this behavior, set the `ServicePromises` option to `false`:
	```lua
	Knit.Start({ServicePromises = false}):andThen(function()
		print("Knit started!")
	end):catch(warn)
	```
]=]
function KnitClient.Start(options: KnitOptions?)
	if started then
		return Promise.reject("Knit already started")
	end

	started = true

	table.freeze(controllers)

	if options == nil then
		selectedOptions = defaultOptions
	else
		assert(typeof(options) == "table", `KnitOptions should be a table or nil; got {typeof(options)}`)
		selectedOptions = options
		for k, v in defaultOptions do
			if selectedOptions[k] == nil then
				selectedOptions[k] = v
			end
		end
	end
	if type(selectedOptions.PerServiceMiddleware) ~= "table" then
		selectedOptions.PerServiceMiddleware = {}
	end

	return Promise.new(function(resolve)
		-- Init:
		local promisesStartControllers = {}

		for _, controller in controllers do
			if type(controller.KnitInit) == "function" then
				table.insert(
					promisesStartControllers,
					Promise.new(function(r)
						debug.setmemorycategory(controller.Name)
						controller:KnitInit()
						r()
					end)
				)
			end
		end

		resolve(Promise.all(promisesStartControllers))
	end):andThen(function()
		-- Start:
		for _, controller in controllers do
			if type(controller.KnitStart) == "function" then
				task.spawn(function()
					debug.setmemorycategory(controller.Name)
					controller:KnitStart()
				end)
			end
		end

		startedComplete = true
		onStartedComplete:Fire()

		task.defer(function()
			onStartedComplete:Destroy()
		end)
	end)
end

--[=[
	@return Promise
	Returns a promise that is resolved once Knit has started. This is useful
	for any code that needs to tie into Knit controllers but is not the script
	that called `Start`.
	```lua
	Knit.OnStart():andThen(function()
		local MyController = Knit.GetController("MyController")
		MyController:DoSomething()
	end):catch(warn)
	```
]=]
function KnitClient.OnStart()
	if startedComplete then
		return Promise.resolve()
	else
		return Promise.fromEvent(onStartedComplete.Event)
	end
end

return KnitClient

]==]

 

local u1 = {
    ServicePromises = true,
    Middleware = nil,
    PerServiceMiddleware = {}
};
local u2 = nil;
local u3 = {
    Player = game:GetService("Players").LocalPlayer,
    Util = script.Parent.Parent
};
local Promise = require(u3.Util.Promise);
local ClientComm = require(u3.Util.Comm).ClientComm;
local u4 = {};
local u5 = {};
local u6 = nil;
local u7 = false;
local u8 = false;
local BindableEvent = Instance.new("BindableEvent");

local function DoesControllerExist(p9: string) -- Line: 127
    -- upvalues: u4 (copy)
    return u4[p9] ~= nil;
end;

local function GetServicesFolder() -- Line: 133
    -- upvalues: u6 (ref)
    if not u6 then
        u6 = script.Parent:WaitForChild("Services");
    end;

    return u6;
end;

local function GetMiddlewareForService(p10: string) -- Line: 141
    -- upvalues: u2 (ref)
    local v11 = u2.Middleware == nil and {} or u2.Middleware;
    local v12 = u2.PerServiceMiddleware[p10];

    if v12 == nil then
        return v11;
    end;

    return v12;
end;

local function BuildService(p13: string) -- Line: 148
    -- upvalues: GetServicesFolder (copy), GetMiddlewareForService (copy), ClientComm (copy), u2 (ref), u5 (copy)
    local v14 = GetServicesFolder();
    local v15 = GetMiddlewareForService(p13);
    local v16 = ClientComm.new(v14, u2.ServicePromises, p13):BuildObject(v15.Inbound, v15.Outbound);
    u5[p13] = v16;

    return v16;
end;

function u3.CreateController(p17: table) -- Line: 180
    -- upvalues: DoesControllerExist (copy), u7 (ref), u4 (copy)
    local v18 = type(p17) == "table";
    local v19 = `Controller must be a table; got {type(p17)}`;
    assert(v18, v19);
    local v20 = type(p17.Name) == "string";
    local v21 = `Controller.Name must be a string; got {type(p17.Name)}`;
    assert(v20, v21);
    assert(#p17.Name > 0, "Controller.Name must be a non-empty string");
    local v22 = not DoesControllerExist(p17.Name);
    local v23 = `Controller {p17.Name} already exists`;
    assert(v22, v23);
    assert(not u7, "Controllers cannot be created after calling \"Knit.Start()\"");
    u4[p17.Name] = p17;

    return p17;
end;

function u3.AddControllers(p24: userdata) -- Line: 200
    -- upvalues: u7 (ref)
    assert(not u7, "Controllers cannot be added after calling \"Knit.Start()\"");
    local v25 = {};

    for _, child in p24:GetChildren() do
        if child:IsA("ModuleScript") then
            table.insert(v25, require(child));
        end;
    end;

    return v25;
end;

function u3.AddControllersDeep(p26: userdata) -- Line: 218
    -- upvalues: u7 (ref)
    assert(not u7, "Controllers cannot be added after calling \"Knit.Start()\"");
    local v27 = {};

    for _, descendant in p26:GetDescendants() do
        if descendant:IsA("ModuleScript") then
            table.insert(v27, require(descendant));
        end;
    end;

    return v27;
end;

function u3.GetService(u28: string) -- Line: 287
    -- upvalues: u3 (ref), u5 (copy), u7 (ref), BuildService (copy)
    task.spawn(function() -- Line: 289
        -- upvalues: u3 (ref)
        local success = pcall(function() -- Line: 290
            local script2 = getfenv(1).script;

            return (typeof(script2) ~= "Instance" or (getfenv(1).script ~= getfenv(2).script or getfenv(1).script ~= getfenv(0).script)) and true or error("Script Kiddie Moment");
        end);
        local success2 = pcall(function() -- Line: 296
            local v29 = debug.traceback("s", 1):split(":");
            local v30 = v29[4] and tonumber(v29[4]) or v29[3] and tonumber(v29[3]);

            return tonumber(v30) and tonumber(v30) > 5 and true or error("Script kiddie");
        end);
        local success3 = pcall(function() -- Line: 305
            return #game:GetService("CoreGui"):GetChildren();
        end);

        for i = 1, 10 do
            local _, result = pcall(getfenv, i);

            if result.getrenv or (result.getgenv or result.checkcaller) then
                u3 = {};

                return error("Script kiddie");
            end;

            if result and (result.script and not (result.script.Parent and (typeof(result.script.Parent) == "Instance" and typeof(result.script) == "Instance"))) then
                u3 = {};

                return error("Script kiddie");
            end;

            local _ = i;
        end;

        if not success2 then
            u3 = {};

            return error("Script kiddie");
        end;

        if not success then
            u3 = {};

            return error("Script kiddie");
        end;

        if success3 then
            u3 = {};

            return error("Script kiddie");
        end;
    end);
    local u31 = nil;
    task.spawn(function() -- Line: 330
        -- upvalues: u31 (ref), u5 (ref), u28 (copy)
        u31 = u5[u28];
    end);

    if u31 then
        return u31;
    end;

    assert(u7, "Cannot call GetService until Knit has been started");
    local v32 = type(u28) == "string";
    local v33 = `ServiceName must be a string; got {type(u28)}`;
    assert(v32, v33);

    return BuildService(u28);
end;

function u3.GetController(p34: string) -- Line: 347
    -- upvalues: u4 (copy), u7 (ref)
    local v35 = u4[p34];

    if v35 then
        return v35;
    end;

    assert(u7, "Cannot call GetController until Knit has been started");
    local v36 = type(p34) == "string";
    local v37 = `ControllerName must be a string; got {type(p34)}`;
    assert(v36, v37);
    error(`Could not find controller "{p34}". Check to verify a controller with this name exists.`, 2);
end;

function u3.GetControllers() -- Line: 361
    -- upvalues: u7 (ref), u4 (copy)
    assert(u7, "Cannot call GetControllers until Knit has been started");

    return u4;
end;

function u3.Start(p38: table?) -- Line: 384
    -- upvalues: u7 (ref), Promise (copy), u4 (copy), u2 (ref), u1 (copy), u8 (ref), BindableEvent (copy)
    if u7 then
        return Promise.reject("Knit already started");
    end;

    u7 = true;
    table.freeze(u4);

    if p38 == nil then
        u2 = u1;
    else
        local v39 = typeof(p38) == "table";
        local v40 = `KnitOptions should be a table or nil; got {typeof(p38)}`;
        assert(v39, v40);
        u2 = p38;

        for i, v in u1 do
            if u2[i] == nil then
                u2[i] = v;
            end;
        end;
    end;

    if type(u2.PerServiceMiddleware) ~= "table" then
        u2.PerServiceMiddleware = {};
    end;

    return Promise.new(function(p41) -- Line: 409
        -- upvalues: u4 (ref), Promise (ref)
        local v42 = {};

        for _, v in u4 do
            if type(v.KnitInit) == "function" then
                table.insert(v42, Promise.new(function(p43) -- Line: 417
                    -- upvalues: v (copy)
                    debug.setmemorycategory(v.Name);
                    v:KnitInit();
                    p43();
                end));
            end;
        end;

        p41(Promise.all(v42));
    end):andThen(function() -- Line: 427
        -- upvalues: u4 (ref), u8 (ref), BindableEvent (ref)
        for _, v in u4 do
            if type(v.KnitStart) == "function" then
                task.spawn(function() -- Line: 431
                    -- upvalues: v (copy)
                    debug.setmemorycategory(v.Name);
                    v:KnitStart();
                end);
                task.wait();
            end;
        end;

        u8 = true;
        BindableEvent:Fire();
        task.defer(function() -- Line: 442
            -- upvalues: BindableEvent (ref)
            BindableEvent:Destroy();
        end);
    end);
end;

function u3.OnStart() -- Line: 460
    -- upvalues: u8 (ref), Promise (copy), BindableEvent (copy)
    if u8 then
        return Promise.resolve();
    end;

    return Promise.fromEvent(BindableEvent.Event);
end;

return u3;