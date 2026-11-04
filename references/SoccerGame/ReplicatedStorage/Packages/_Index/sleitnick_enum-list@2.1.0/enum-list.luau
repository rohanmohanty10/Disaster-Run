 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
-- EnumList
-- Stephen Leitnick
-- January 08, 2021

type EnumNames = { string }

--[=[
	@interface EnumItem
	.Name string
	.Value number
	.EnumType EnumList
	@within EnumList
]=]
export type EnumItem = {
	Name: string,
	Value: number,
	EnumType: any,
}

local LIST_KEY = newproxy()
local NAME_KEY = newproxy()

local function CreateEnumItem(name: string, value: number, enum: any): EnumItem
	local enumItem = {
		Name = name,
		Value = value,
		EnumType = enum,
	}
	table.freeze(enumItem)
	return enumItem
end

--[=[
	@class EnumList
	Defines a new Enum.
]=]
local EnumList = {}
EnumList.__index = EnumList

--[=[
	@param name string
	@param enums {string}
	@return EnumList
	Constructs a new EnumList.

	```lua
	local directions = EnumList.new("Directions", {
		"Up",
		"Down",
		"Left",
		"Right",
	})

	local direction = directions.Up
	```
]=]
function EnumList.new(name: string, enums: EnumNames)
	assert(type(name) == "string", "Name string required")
	assert(type(enums) == "table", "Enums table required")
	local self = {}
	self[LIST_KEY] = {}
	self[NAME_KEY] = name
	for i, enumName in ipairs(enums) do
		assert(type(enumName) == "string", "Enum name must be a string")
		local enumItem = CreateEnumItem(enumName, i, self)
		self[enumName] = enumItem
		table.insert(self[LIST_KEY], enumItem)
	end
	return table.freeze(setmetatable(self, EnumList))
end

--[=[
	@param obj any
	@return boolean
	Returns `true` if `obj` belongs to the EnumList.
]=]
function EnumList:BelongsTo(obj: any): boolean
	return type(obj) == "table" and obj.EnumType == self
end

--[=[
	Returns an array of all enum items.
	@return {EnumItem}
	@since v2.0.0
]=]
function EnumList:GetEnumItems()
	return self[LIST_KEY]
end

--[=[
	Get the name of the enum.
	@return string
	@since v2.0.0
]=]
function EnumList:GetName()
	return self[NAME_KEY]
end

export type EnumList = typeof(EnumList.new(...))

return EnumList

]==]

 

local u1 = newproxy();
local u2 = newproxy();

local function CreateEnumItem(p3: string, p4: number, p5: any) -- Line: 23
    local v6 = {
        Name = p3,
        Value = p4,
        EnumType = p5
    };
    table.freeze(v6);

    return v6;
end;

local u7 = {};
u7.__index = u7;

function u7.new(p8: string, p9: table) -- Line: 57
    -- upvalues: u1 (copy), u2 (copy), u7 (copy)
    local v10 = type(p8) == "string";
    assert(v10, "Name string required");
    local v11 = type(p9) == "table";
    assert(v11, "Enums table required");
    local v12 = {
        [u1] = {},
        [u2] = p8
    };

    for i, v in ipairs(p9) do
        local v13 = type(v) == "string";
        assert(v13, "Enum name must be a string");
        local v14 = {
            Name = v,
            Value = i,
            EnumType = v12
        };
        table.freeze(v14);
        v12[v] = v14;
        table.insert(v12[u1], v14);
    end;

    return table.freeze((setmetatable(v12, u7)));
end;

function u7.BelongsTo(p15, p16) -- Line: 77
    local v17;

    if type(p16) == "table" then
        v17 = p16.EnumType == p15;
    else
        v17 = false;
    end;

    return v17;
end;

function u7.GetEnumItems(p18) -- Line: 86
    -- upvalues: u1 (copy)
    return p18[u1];
end;

function u7.GetName(p19) -- Line: 95
    -- upvalues: u2 (copy)
    return p19[u2];
end;

return u7;