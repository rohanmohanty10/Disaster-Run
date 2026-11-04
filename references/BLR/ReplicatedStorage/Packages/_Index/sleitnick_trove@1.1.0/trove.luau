 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- Trove
-- Stephen Leitnick
-- October 16, 2021

local FN_MARKER = newproxy()
local THREAD_MARKER = newproxy()
local GENERIC_OBJECT_CLEANUP_METHODS = { "Destroy", "Disconnect", "destroy", "disconnect" }

local RunService = game:GetService("RunService")

local function GetObjectCleanupFunction(object, cleanupMethod)
	local t = typeof(object)
	if t == "function" then
		return FN_MARKER
	elseif t == "thread" then
		return THREAD_MARKER
	end
	if cleanupMethod then
		return cleanupMethod
	end
	if t == "Instance" then
		return "Destroy"
	elseif t == "RBXScriptConnection" then
		return "Disconnect"
	elseif t == "table" then
		for _, genericCleanupMethod in GENERIC_OBJECT_CLEANUP_METHODS do
			if typeof(object[genericCleanupMethod]) == "function" then
				return genericCleanupMethod
			end
		end
	end
	error("Failed to get cleanup function for object " .. t .. ": " .. tostring(object), 3)
end

local function AssertPromiseLike(object)
	if
		typeof(object) ~= "table"
		or typeof(object.getStatus) ~= "function"
		or typeof(object.finally) ~= "function"
		or typeof(object.cancel) ~= "function"
	then
		error("Did not receive a Promise as an argument", 3)
	end
end

--[=[
	@class Trove
	A Trove is helpful for tracking any sort of object during
	runtime that needs to get cleaned up at some point.
]=]
local Trove = {}
Trove.__index = Trove

--[=[
	@return Trove
	Constructs a Trove object.
]=]
function Trove.new()
	local self = setmetatable({}, Trove)
	self._objects = {}
	self._cleaning = false
	return self
end

--[=[
	@return Trove
	Creates and adds another trove to itself. This is just shorthand
	for `trove:Construct(Trove)`. This is useful for contexts where
	the trove object is present, but the class itself isn't.

	:::note
	This does _not_ clone the trove. In other words, the objects in the
	trove are not given to the new constructed trove. This is simply to
	construct a new Trove and add it as an object to track.
	:::

	```lua
	local trove = Trove.new()
	local subTrove = trove:Extend()

	trove:Clean() -- Cleans up the subTrove too
	```
]=]
function Trove:Extend()
	if self._cleaning then
		error("Cannot call trove:Extend() while cleaning", 2)
	end
	return self:Construct(Trove)
end

--[=[
	Clones the given instance and adds it to the trove. Shorthand for
	`trove:Add(instance:Clone())`.
]=]
function Trove:Clone(instance: Instance): Instance
	if self._cleaning then
		error("Cannot call trove:Clone() while cleaning", 2)
	end
	return self:Add(instance:Clone())
end

--[=[
	@param class table | (...any) -> any
	@param ... any
	@return any
	Constructs a new object from either the
	table or function given.

	If a table is given, the table's `new`
	function will be called with the given
	arguments.

	If a function is given, the function will
	be called with the given arguments.
	
	The result from either of the two options
	will be added to the trove.

	This is shorthand for `trove:Add(SomeClass.new(...))`
	and `trove:Add(SomeFunction(...))`.

	```lua
	local Signal = require(somewhere.Signal)

	-- All of these are identical:
	local s = trove:Construct(Signal)
	local s = trove:Construct(Signal.new)
	local s = trove:Construct(function() return Signal.new() end)
	local s = trove:Add(Signal.new())

	-- Even Roblox instances can be created:
	local part = trove:Construct(Instance, "Part")
	```
]=]
function Trove:Construct(class, ...)
	if self._cleaning then
		error("Cannot call trove:Construct() while cleaning", 2)
	end
	local object = nil
	local t = type(class)
	if t == "table" then
		object = class.new(...)
	elseif t == "function" then
		object = class(...)
	end
	return self:Add(object)
end

--[=[
	@param signal RBXScriptSignal
	@param fn (...: any) -> ()
	@return RBXScriptConnection
	Connects the function to the signal, adds the connection
	to the trove, and then returns the connection.

	This is shorthand for `trove:Add(signal:Connect(fn))`.

	```lua
	trove:Connect(workspace.ChildAdded, function(instance)
		print(instance.Name .. " added to workspace")
	end)
	```
]=]
function Trove:Connect(signal, fn)
	if self._cleaning then
		error("Cannot call trove:Connect() while cleaning", 2)
	end
	return self:Add(signal:Connect(fn))
end

--[=[
	@param name string
	@param priority number
	@param fn (dt: number) -> ()
	Calls `RunService:BindToRenderStep` and registers a function in the
	trove that will call `RunService:UnbindFromRenderStep` on cleanup.

	```lua
	trove:BindToRenderStep("Test", Enum.RenderPriority.Last.Value, function(dt)
		-- Do something
	end)
	```
]=]
function Trove:BindToRenderStep(name: string, priority: number, fn: (dt: number) -> ())
	if self._cleaning then
		error("Cannot call trove:BindToRenderStep() while cleaning", 2)
	end
	RunService:BindToRenderStep(name, priority, fn)
	self:Add(function()
		RunService:UnbindFromRenderStep(name)
	end)
end

--[=[
	@param promise Promise
	@return Promise
	Gives the promise to the trove, which will cancel the promise if the trove is cleaned up or if the promise
	is removed. The exact promise is returned, thus allowing chaining.

	```lua
	trove:AddPromise(doSomethingThatReturnsAPromise())
		:andThen(function()
			print("Done")
		end)
	-- Will cancel the above promise (assuming it didn't resolve immediately)
	trove:Clean()

	local p = trove:AddPromise(doSomethingThatReturnsAPromise())
	-- Will also cancel the promise
	trove:Remove(p)
	```

	:::caution Promise v4 Only
	This is only compatible with the [roblox-lua-promise](https://eryn.io/roblox-lua-promise/) library, version 4.
	:::
]=]
function Trove:AddPromise(promise)
	if self._cleaning then
		error("Cannot call trove:AddPromise() while cleaning", 2)
	end
	AssertPromiseLike(promise)
	if promise:getStatus() == "Started" then
		promise:finally(function()
			if self._cleaning then
				return
			end
			self:_findAndRemoveFromObjects(promise, false)
		end)
		self:Add(promise, "cancel")
	end
	return promise
end

--[=[
	@param object any -- Object to track
	@param cleanupMethod string? -- Optional cleanup name override
	@return object: any
	Adds an object to the trove. Once the trove is cleaned or
	destroyed, the object will also be cleaned up.

	The following types are accepted (e.g. `typeof(object)`):

	| Type | Cleanup |
	| ---- | ------- |
	| `Instance` | `object:Destroy()` |
	| `RBXScriptConnection` | `object:Disconnect()` |
	| `function` | `object()` |
	| `thread` | `task.cancel(object)` |
	| `table` | `object:Destroy()` _or_ `object:Disconnect()` _or_ `object:destroy()` _or_ `object:disconnect()` |
	| `table` with `cleanupMethod` | `object:<cleanupMethod>()` |

	Returns the object added.

	```lua
	-- Add a part to the trove, then destroy the trove,
	-- which will also destroy the part:
	local part = Instance.new("Part")
	trove:Add(part)
	trove:Destroy()

	-- Add a function to the trove:
	trove:Add(function()
		print("Cleanup!")
	end)
	trove:Destroy()

	-- Standard cleanup from table:
	local tbl = {}
	function tbl:Destroy()
		print("Cleanup")
	end
	trove:Add(tbl)

	-- Custom cleanup from table:
	local tbl = {}
	function tbl:DoSomething()
		print("Do something on cleanup")
	end
	trove:Add(tbl, "DoSomething")
	```
]=]
function Trove:Add(object: any, cleanupMethod: string?): any
	if self._cleaning then
		error("Cannot call trove:Add() while cleaning", 2)
	end
	local cleanup = GetObjectCleanupFunction(object, cleanupMethod)
	table.insert(self._objects, { object, cleanup })
	return object
end

--[=[
	@param object any -- Object to remove
	Removes the object from the Trove and cleans it up.

	```lua
	local part = Instance.new("Part")
	trove:Add(part)
	trove:Remove(part)
	```
]=]
function Trove:Remove(object: any): boolean
	if self._cleaning then
		error("Cannot call trove:Remove() while cleaning", 2)
	end
	return self:_findAndRemoveFromObjects(object, true)
end

--[=[
	Cleans up all objects in the trove. This is
	similar to calling `Remove` on each object
	within the trove. The ordering of the objects
	removed is _not_ guaranteed.
]=]
function Trove:Clean()
	if self._cleaning then
		return
	end
	self._cleaning = true
	for _, obj in self._objects do
		self:_cleanupObject(obj[1], obj[2])
	end
	table.clear(self._objects)
	self._cleaning = false
end

function Trove:_findAndRemoveFromObjects(object: any, cleanup: boolean): boolean
	local objects = self._objects
	for i, obj in ipairs(objects) do
		if obj[1] == object then
			local n = #objects
			objects[i] = objects[n]
			objects[n] = nil
			if cleanup then
				self:_cleanupObject(obj[1], obj[2])
			end
			return true
		end
	end
	return false
end

function Trove:_cleanupObject(object, cleanupMethod)
	if cleanupMethod == FN_MARKER then
		object()
	elseif cleanupMethod == THREAD_MARKER then
		pcall(task.cancel, object)
	else
		object[cleanupMethod](object)
	end
end

--[=[
	@param instance Instance
	@return RBXScriptConnection
	Attaches the trove to a Roblox instance. Once this
	instance is removed from the game (parent or ancestor's
	parent set to `nil`), the trove will automatically
	clean up.

	:::caution
	Will throw an error if `instance` is not a descendant
	of the game hierarchy.
	:::
]=]
function Trove:AttachToInstance(instance: Instance)
	if self._cleaning then
		error("Cannot call trove:AttachToInstance() while cleaning", 2)
	elseif not instance:IsDescendantOf(game) then
		error("Instance is not a descendant of the game hierarchy", 2)
	end
	return self:Connect(instance.Destroying, function()
		self:Destroy()
	end)
end

--[=[
	Alias for `trove:Clean()`.
]=]
function Trove:Destroy()
	self:Clean()
end

return Trove

]==]

 

local u1 = newproxy();
local u2 = newproxy();
local u3 = { "Destroy", "Disconnect", "destroy", "disconnect" };
local RunService = game:GetService("RunService");

local function GetObjectCleanupFunction(p4, p5) -- Line: 11
    -- upvalues: u1 (copy), u2 (copy), u3 (copy)
    local v6 = typeof(p4);

    if v6 == "function" then
        return u1;
    end;

    if v6 == "thread" then
        return u2;
    end;

    if p5 then
        return p5;
    end;

    if v6 == "Instance" then
        return "Destroy";
    end;

    if v6 == "RBXScriptConnection" then
        return "Disconnect";
    end;

    if v6 == "table" then
        for _, v in u3 do
            if typeof(p4[v]) == "function" then
                return v;
            end;
        end;
    end;

    error("Failed to get cleanup function for object " .. v6 .. ": " .. tostring(p4), 3);
end;

local function AssertPromiseLike(p7) -- Line: 35
    if typeof(p7) ~= "table" or (typeof(p7.getStatus) ~= "function" or (typeof(p7.finally) ~= "function" or typeof(p7.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;
end;

local u8 = {};
u8.__index = u8;

function u8.new() -- Line: 58
    -- upvalues: u8 (copy)
    local v9 = setmetatable({}, u8);
    v9._objects = {};
    v9._cleaning = false;

    return v9;
end;

function u8.Extend(p10) -- Line: 84
    -- upvalues: u8 (copy)
    if p10._cleaning then
        error("Cannot call trove:Extend() while cleaning", 2);
    end;

    return p10:Construct(u8);
end;

function u8.Clone(p11: table, p12: userdata) -- Line: 95
    if p11._cleaning then
        error("Cannot call trove:Clone() while cleaning", 2);
    end;

    return p11:Add(p12:Clone());
end;

function u8.Construct(p13, p14, ...) -- Line: 135
    if p13._cleaning then
        error("Cannot call trove:Construct() while cleaning", 2);
    end;

    local v15 = nil;
    local v16 = type(p14);

    if v16 == "table" then
        v15 = p14.new(...);
    elseif v16 == "function" then
        v15 = p14(...);
    end;

    return p13:Add(v15);
end;

function u8.Connect(p17, p18, p19) -- Line: 164
    if p17._cleaning then
        error("Cannot call trove:Connect() while cleaning", 2);
    end;

    return p17:Add(p18:Connect(p19));
end;

function u8.BindToRenderStep(p20: table, u21: string, p22: number, p23: function) -- Line: 184
    -- upvalues: RunService (copy)
    if p20._cleaning then
        error("Cannot call trove:BindToRenderStep() while cleaning", 2);
    end;

    RunService:BindToRenderStep(u21, p22, p23);
    p20:Add(function() -- Line: 189
        -- upvalues: RunService (ref), u21 (copy)
        RunService:UnbindFromRenderStep(u21);
    end);
end;

function u8.AddPromise(u24, u25) -- Line: 217
    if u24._cleaning then
        error("Cannot call trove:AddPromise() while cleaning", 2);
    end;

    if typeof(u25) ~= "table" or (typeof(u25.getStatus) ~= "function" or (typeof(u25.finally) ~= "function" or typeof(u25.cancel) ~= "function")) then
        error("Did not receive a Promise as an argument", 3);
    end;

    if u25:getStatus() == "Started" then
        u25:finally(function() -- Line: 223
            -- upvalues: u24 (copy), u25 (copy)
            if u24._cleaning then
                return;
            end;

            u24:_findAndRemoveFromObjects(u25, false);
        end);
        u24:Add(u25, "cancel");
    end;

    return u25;
end;

function u8.Add(p26: table, p27: any, p28: string?) -- Line: 282
    -- upvalues: GetObjectCleanupFunction (copy)
    if p26._cleaning then
        error("Cannot call trove:Add() while cleaning", 2);
    end;

    local v29 = { p27, (GetObjectCleanupFunction(p27, p28)) };
    table.insert(p26._objects, v29);

    return p27;
end;

function u8.Remove(p30, p31) -- Line: 301
    if p30._cleaning then
        error("Cannot call trove:Remove() while cleaning", 2);
    end;

    return p30:_findAndRemoveFromObjects(p31, true);
end;

function u8.Clean(p32) -- Line: 314
    if p32._cleaning then
        return;
    end;

    p32._cleaning = true;

    for _, v in p32._objects do
        p32:_cleanupObject(v[1], v[2]);
    end;

    table.clear(p32._objects);
    p32._cleaning = false;
end;

function u8._findAndRemoveFromObjects(p33: table, p34: any, p35: boolean) -- Line: 326
    local _objects = p33._objects;

    for i, v in ipairs(_objects) do
        if v[1] == p34 then
            local v36 = #_objects;
            _objects[i] = _objects[v36];
            _objects[v36] = nil;

            if p35 then
                p33:_cleanupObject(v[1], v[2]);
            end;

            return true;
        end;
    end;

    return false;
end;

function u8._cleanupObject(p37, p38, p39) -- Line: 342
    -- upvalues: u1 (copy), u2 (copy)
    if p39 == u1 then
        p38();

        return;
    end;

    if p39 == u2 then
        pcall(task.cancel, p38);

        return;
    end;

    p38[p39](p38);
end;

function u8.AttachToInstance(u40: table, p41: userdata) -- Line: 365
    if u40._cleaning then
        error("Cannot call trove:AttachToInstance() while cleaning", 2);
    elseif not p41:IsDescendantOf(game) then
        error("Instance is not a descendant of the game hierarchy", 2);
    end;

    return u40:Connect(p41.Destroying, function() -- Line: 371
        -- upvalues: u40 (copy)
        u40:Destroy();
    end);
end;

function u8.Destroy(p42) -- Line: 379
    p42:Clean();
end;

return u8;