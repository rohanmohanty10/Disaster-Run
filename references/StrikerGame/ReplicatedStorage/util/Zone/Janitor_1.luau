 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Janitor
-- Original by Validark
-- Modifications by pobammer
-- roblox-ts support by OverHash and Validark
-- LinkToInstance fixed by Elttob.

local RunService = game:GetService("RunService")
local Heartbeat = RunService.Heartbeat

local IndicesReference = newproxy(true)
getmetatable(IndicesReference).__tostring = function()
	return "IndicesReference"
end

local LinkToInstanceIndex = newproxy(true)
getmetatable(LinkToInstanceIndex).__tostring = function()
	return "LinkToInstanceIndex"
end

local METHOD_NOT_FOUND_ERROR = "Object %s doesn't have method %s, are you sure you want to add it? Traceback: %s"
--local NOT_A_PROMISE = "Invalid argument #1 to 'Janitor:AddPromise' (Promise expected, got %s (%s))"

local Janitor = {
	ClassName = "Janitor";
	__index = {
		CurrentlyCleaning = true;
		[IndicesReference] = nil;
	};
}

local TypeDefaults = {
	["function"] = true;
	RBXScriptConnection = "Disconnect";
}

--[[**
	Instantiates a new Janitor object.
	@returns [t:Janitor]
**--]]
function Janitor.new()
	return setmetatable({
		CurrentlyCleaning = false;
		[IndicesReference] = nil;
	}, Janitor)
end

--[[**
	Determines if the passed object is a Janitor.
	@param [t:any] Object The object you are checking.
	@returns [t:boolean] Whether or not the object is a Janitor.
**--]]
function Janitor.Is(Object)
	return type(Object) == "table" and getmetatable(Object) == Janitor
end

Janitor.is = Janitor.Is

--[[**
	Adds an `Object` to Janitor for later cleanup, where `MethodName` is the key of the method within `Object` which should be called at cleanup time. If the `MethodName` is `true` the `Object` itself will be called instead. If passed an index it will occupy a namespace which can be `Remove()`d or overwritten. Returns the `Object`.
	@param [t:any] Object The object you want to clean up.
	@param [t:string|true?] MethodName The name of the method that will be used to clean up. If not passed, it will first check if the object's type exists in TypeDefaults, and if that doesn't exist, it assumes `Destroy`.
	@param [t:any?] Index The index that can be used to clean up the object manually.
	@returns [t:any] The object that was passed.
**--]]
function Janitor.__index:Add(Object, MethodName, Index)
	if Index == nil then
		Index = newproxy(false)
	end

	if Index then
		self:Remove(Index)

		local This = self[IndicesReference]
		if not This then
			This = {}
			self[IndicesReference] = This
		end

		This[Index] = Object
	end
	--[[
	if Promise.is(Object) then
		local Id = newproxy(false)
		if Object:getStatus() == Promise.Status.Started then
			local NewPromise = self:Add(Promise.resolve(Object), "cancel", Id)
			NewPromise:finallyCall(self.Remove, self, Id)
			return NewPromise, Id
		else
			return Object
		end
	end--]]

	MethodName = MethodName or TypeDefaults[typeof(Object)] or "Destroy"
	if type(Object) ~= "function" and not Object[MethodName] then
		warn(string.format(METHOD_NOT_FOUND_ERROR, tostring(Object), tostring(MethodName), debug.traceback(nil, 2)))
	end

	self[Object] = MethodName
	return Object, Index
end

Janitor.__index.Give = Janitor.__index.Add

-- My version of Promise has PascalCase, but I converted it to use lowerCamelCase for this release since obviously that's important to do.

--[[**
	Adds a promise to the janitor. If the janitor is cleaned up and the promise is not completed, the promise will be cancelled.
	@param [t:Promise] PromiseObject The promise you want to add to the janitor.
	@returns [t:Promise]
**--]]
--[[
function Janitor.__index:AddPromise(PromiseObject)
	if not Promise.is(PromiseObject) then
		error(string.format(NOT_A_PROMISE, typeof(PromiseObject), tostring(PromiseObject)))
	end

	if PromiseObject:getStatus() == Promise.Status.Started then
		local Id = newproxy(false)
		local NewPromise = self:Add(Promise.resolve(PromiseObject), "cancel", Id)
		NewPromise:finallyCall(self.Remove, self, Id)
		return NewPromise, Id
	else
		return PromiseObject
	end
end
--]]

--Janitor.__index.GivePromise = Janitor.__index.AddPromise

-- This will assume whether or not the object is a Promise or a regular object.
function Janitor.__index:AddObject(Object)
	local Id = newproxy(false)
	--[[
	if Promise.is(Object) then
		if Object:getStatus() == Promise.Status.Started then
			local NewPromise = self:Add(Promise.resolve(Object), "cancel", Id)
			NewPromise:finallyCall(self.Remove, self, Id)
			return NewPromise, Id
		else
			return Object
		end
	else
		return self:Add(Object, false, Id), Id
	end---]]
	return self:Add(Object, false, Id), Id
end

Janitor.__index.GiveObject = Janitor.__index.AddObject

--[[**
	Cleans up whatever `Object` was set to this namespace by the 3rd parameter of `:Add()`.
	@param [t:any] Index The index you want to remove.
	@returns [t:Janitor] The same janitor, for chaining reasons.
**--]]
function Janitor.__index:Remove(Index)
	local This = self[IndicesReference]

	if This then
		local Object = This[Index]

		if Object then
			local MethodName = self[Object]

			if MethodName then
				if MethodName == true then
					Object()
				else
					local ObjectMethod = Object[MethodName]
					if ObjectMethod then
						ObjectMethod(Object)
					end
				end

				self[Object] = nil
			end

			This[Index] = nil
		end
	end

	return self
end

--[[**
	Gets whatever object is stored with the given index, if it exists. This was added since Maid allows getting the job using `__index`.
	@param [t:any] Index The index that the object is stored under.
	@returns [t:any?] This will return the object if it is found, but it won't return anything if it doesn't exist.
**--]]
function Janitor.__index:Get(Index)
	local This = self[IndicesReference]
	if This then
		return This[Index]
	end
end

--[[**
	Calls each Object's `MethodName` (or calls the Object if `MethodName == true`) and removes them from the Janitor. Also clears the namespace. This function is also called when you call a Janitor Object (so it can be used as a destructor callback).
	@returns [t:void]
**--]]
function Janitor.__index:Cleanup()
	if not self.CurrentlyCleaning then
		self.CurrentlyCleaning = nil
		for Object, MethodName in next, self do
			if Object == IndicesReference then
				continue
			end

			-- Weird decision to rawset directly to the janitor in Agent. This should protect against it though.
			local TypeOf = type(Object)
			if TypeOf == "string" or TypeOf == "number" then
				self[Object] = nil
				continue
			end

			if MethodName == true then
				Object()
			else
				local ObjectMethod = Object[MethodName]
				if ObjectMethod then
					ObjectMethod(Object)
				end
			end

			self[Object] = nil
		end

		local This = self[IndicesReference]
		if This then
			for Index in next, This do
				This[Index] = nil
			end

			self[IndicesReference] = {}
		end

		self.CurrentlyCleaning = false
	end
end

Janitor.__index.Clean = Janitor.__index.Cleanup

--[[**
	Calls `:Cleanup()` and renders the Janitor unusable.
	@returns [t:void]
**--]]
function Janitor.__index:Destroy()
	self:Cleanup()
	--table.clear(self)
	--setmetatable(self, nil)
end

Janitor.__call = Janitor.__index.Cleanup

--- Makes the Janitor clean up when the instance is destroyed
-- @param Instance Instance The Instance the Janitor will wait for to be Destroyed
-- @returns Disconnectable table to stop Janitor from being cleaned up upon Instance Destroy (automatically cleaned up by Janitor, btw)
-- @author Corecii
local Disconnect = {Connected = true}
Disconnect.__index = Disconnect
function Disconnect:Disconnect()
	if self.Connected then
		self.Connected = false
		self.Connection:Disconnect()
	end
end

function Disconnect:__tostring()
	return "Disconnect<" .. tostring(self.Connected) .. ">"
end

--[[**
	"Links" this Janitor to an Instance, such that the Janitor will `Cleanup` when the Instance is `Destroyed()` and garbage collected. A Janitor may only be linked to one instance at a time, unless `AllowMultiple` is true. When called with a truthy `AllowMultiple` parameter, the Janitor will "link" the Instance without overwriting any previous links, and will also not be overwritable. When called with a falsy `AllowMultiple` parameter, the Janitor will overwrite the previous link which was also called with a falsy `AllowMultiple` parameter, if applicable.
	@param [t:Instance] Object The instance you want to link the Janitor to.
	@param [t:boolean?] AllowMultiple Whether or not to allow multiple links on the same Janitor.
	@returns [t:RbxScriptConnection] A pseudo RBXScriptConnection that can be disconnected.
**--]]
function Janitor.__index:LinkToInstance(Object, AllowMultiple)
	local Connection
	local IndexToUse = AllowMultiple and newproxy(false) or LinkToInstanceIndex
	local IsNilParented = Object.Parent == nil
	local ManualDisconnect = setmetatable({}, Disconnect)

	local function ChangedFunction(_DoNotUse, NewParent)
		if ManualDisconnect.Connected then
			_DoNotUse = nil
			IsNilParented = NewParent == nil

			if IsNilParented then
				coroutine.wrap(function()
					Heartbeat:Wait()
					if not ManualDisconnect.Connected then
						return
					elseif not Connection.Connected then
						self:Cleanup()
					else
						while IsNilParented and Connection.Connected and ManualDisconnect.Connected do
							Heartbeat:Wait()
						end

						if ManualDisconnect.Connected and IsNilParented then
							self:Cleanup()
						end
					end
				end)()
			end
		end
	end

	Connection = Object.AncestryChanged:Connect(ChangedFunction)
	ManualDisconnect.Connection = Connection

	if IsNilParented then
		ChangedFunction(nil, Object.Parent)
	end

	Object = nil
	return self:Add(ManualDisconnect, "Disconnect", IndexToUse)
end

--[[**
	Links several instances to a janitor, which is then returned.
	@param [t:...Instance] ... All the instances you want linked.
	@returns [t:Janitor] A janitor that can be used to manually disconnect all LinkToInstances.
**--]]
function Janitor.__index:LinkToInstances(...)
	local ManualCleanup = Janitor.new()
	for _, Object in ipairs({...}) do
		ManualCleanup:Add(self:LinkToInstance(Object, true), "Disconnect")
	end

	return ManualCleanup
end

for FunctionName, Function in next, Janitor.__index do
	local NewFunctionName = string.sub(string.lower(FunctionName), 1, 1) .. string.sub(FunctionName, 2)
	Janitor.__index[NewFunctionName] = Function
end

return Janitor
]=]

 

local Heartbeat = game:GetService("RunService").Heartbeat;
local u1 = newproxy(true);

getmetatable(u1).__tostring = function() -- Line: 11
    return "IndicesReference";
end;

local u2 = newproxy(true);

getmetatable(u2).__tostring = function() -- Line: 16
    return "LinkToInstanceIndex";
end;

local u3 = {
    ClassName = "Janitor",
    __index = {
        CurrentlyCleaning = true,
        [u1] = nil
    }
};
local u4 = {
    ["function"] = true,
    RBXScriptConnection = "Disconnect"
};

function u3.new() -- Line: 40
    -- upvalues: u1 (copy), u3 (copy)
    return setmetatable({
        CurrentlyCleaning = false,
        [u1] = nil
    }, u3);
end;

function u3.Is(p5) -- Line: 52
    -- upvalues: u3 (copy)
    local v6;

    if type(p5) == "table" then
        v6 = getmetatable(p5) == u3;
    else
        v6 = false;
    end;

    return v6;
end;

u3.is = u3.Is;

function u3.__index.Add(p7, p8, p9, p10) -- Line: 65
    -- upvalues: u1 (copy), u4 (copy)
    if p10 == nil then
        p10 = newproxy(false);
    end;

    if p10 then
        p7:Remove(p10);
        local v11 = p7[u1];

        if not v11 then
            v11 = {};
            p7[u1] = v11;
        end;

        v11[p10] = p8;
    end;

    local v12 = p9 or (u4[typeof(p8)] or "Destroy");

    if type(p8) ~= "function" and not p8[v12] then
        warn(string.format("Object %s doesn\'t have method %s, are you sure you want to add it? Traceback: %s", tostring(p8), tostring(v12), debug.traceback(nil, 2)));
    end;

    p7[p8] = v12;

    return p8, p10;
end;

u3.__index.Give = u3.__index.Add;

function u3.__index.AddObject(p13, p14) -- Line: 131
    local v15 = newproxy(false);

    return p13:Add(p14, false, v15), v15;
end;

u3.__index.GiveObject = u3.__index.AddObject;

function u3.__index.Remove(p16, p17) -- Line: 155
    -- upvalues: u1 (copy)
    local v18 = p16[u1];
    local v19 = v18 and v18[p17];

    if v19 then
        local v20 = p16[v19];

        if v20 then
            if v20 == true then
                v19();
            else
                local v21 = v19[v20];

                if v21 then
                    v21(v19);
                end;
            end;

            p16[v19] = nil;
        end;

        v18[p17] = nil;
    end;

    return p16;
end;

function u3.__index.Get(p22, p23) -- Line: 189
    -- upvalues: u1 (copy)
    local v24 = p22[u1];

    if v24 then
        return v24[p23];
    end;
end;

function u3.__index.Cleanup(p25) -- Line: 200
    -- upvalues: u1 (copy)
    if not p25.CurrentlyCleaning then
        p25.CurrentlyCleaning = nil;

        for i, v in next, p25 do
            if i ~= u1 then
                local v26 = type(i);

                if v26 == "string" or v26 == "number" then
                    p25[i] = nil;
                else
                    if v == true then
                        i();
                    else
                        local v27 = i[v];

                        if v27 then
                            v27(i);
                        end;
                    end;

                    p25[i] = nil;
                end;
            end;
        end;

        local v28 = p25[u1];

        if v28 then
            for i in next, v28 do
                v28[i] = nil;
            end;

            p25[u1] = {};
        end;

        p25.CurrentlyCleaning = false;
    end;
end;

u3.__index.Clean = u3.__index.Cleanup;

function u3.__index.Destroy(p29) -- Line: 246
    p29:Cleanup();
end;

u3.__call = u3.__index.Cleanup;
local u30 = {
    Connected = true
};
u30.__index = u30;

function u30.Disconnect(p31) -- Line: 260
    if p31.Connected then
        p31.Connected = false;
        p31.Connection:Disconnect();
    end;
end;

function u30.__tostring(p32) -- Line: 267
    return "Disconnect<" .. tostring(p32.Connected) .. ">";
end;

function u3.__index.LinkToInstance(u33, p34, p35) -- Line: 277
    -- upvalues: u2 (copy), u30 (copy), Heartbeat (copy)
    local u36 = nil;
    local v37 = p35 and newproxy(false) or u2;
    local u38 = p34.Parent == nil;
    local u39 = setmetatable({}, u30);
    u36 = p34.AncestryChanged:Connect(function(p40, p41) -- Line: 283, Name: ChangedFunction
        -- upvalues: u39 (copy), u38 (ref), Heartbeat (ref), u36 (ref), u33 (copy)
        u38 = u39.Connected and p41 == nil;

        if u38 then
            coroutine.wrap(function() -- Line: 289
                -- upvalues: Heartbeat (ref), u39 (ref), u36 (ref), u33 (ref), u38 (ref)
                Heartbeat:Wait();

                if not u39.Connected then
                    return;
                end;

                if not u36.Connected then
                    u33:Cleanup();

                    return;
                end;

                while u38 and (u36.Connected and u39.Connected) do
                    Heartbeat:Wait();
                end;

                if u39.Connected and u38 then
                    u33:Cleanup();
                end;
            end)();
        end;
    end);
    u39.Connection = u36;

    if u38 then
        local Parent = p34.Parent;

        if u39.Connected then
            if Parent == nil then
                u38 = true;
            else
                u38 = false;
            end;

            if u38 then
                coroutine.wrap(function() -- Line: 289
                    -- upvalues: Heartbeat (ref), u39 (copy), u36 (ref), u33 (copy), u38 (ref)
                    Heartbeat:Wait();

                    if not u39.Connected then
                        return;
                    end;

                    if not u36.Connected then
                        u33:Cleanup();

                        return;
                    end;

                    while u38 and (u36.Connected and u39.Connected) do
                        Heartbeat:Wait();
                    end;

                    if u39.Connected and u38 then
                        u33:Cleanup();
                    end;
                end)();
            end;
        end;
    end;

    return u33:Add(u39, "Disconnect", v37);
end;

function u3.__index.LinkToInstances(p42, ...) -- Line: 325
    -- upvalues: u3 (copy)
    local v43 = u3.new();

    for _, v in ipairs({ ... }) do
        v43:Add(p42:LinkToInstance(v, true), "Disconnect");
    end;

    return v43;
end;

for i, v in next, u3.__index do
    local string_lower_ret = string.lower(i);
    local v44 = string.sub(string_lower_ret, 1, 1) .. string.sub(i, 2);
    u3.__index[v44] = v;
end;

return u3;