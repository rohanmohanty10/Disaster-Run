 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=6245329519

-- ! Source from the asset above; the game may have edited it since.

--[=[
-- Custom enum implementation that provides an effective way to compare, send
-- and store values. Instead of returning a userdata value, enum items return
-- their corresponding itemValue (an integer) when indexed. Enum items can
-- also associate a 'property', specified as the third element, which can be
-- retrieved by doing ``enum.getProperty(ITEM_NAME_OR_VALUE)``
-- This ultimately means groups of data can be easily categorised, efficiently
-- transmitted over networks and saved without throwing errors.
-- Ben Horton (ForeverHD)



-- LOCAL
local Enum = {}
local enums = {}
Enum.enums = enums



-- METHODS
function Enum.createEnum(enumName, details)
	assert(typeof(enumName) == "string", "bad argument #1 - enums must be created using a string name!")
	assert(typeof(details) == "table", "bad argument #2 - enums must be created using a table!")
	assert(not enums[enumName], ("enum '%s' already exists!"):format(enumName))
	
	local enum = {}
	local usedNames = {}
	local usedValues = {}
	local usedProperties = {}
	local enumMetaFunctions = {
		getName = function(valueOrProperty)
			valueOrProperty = tostring(valueOrProperty)
			local index = usedValues[valueOrProperty]
			if not index then
				index = usedProperties[valueOrProperty]
			end
			if index then
				return details[index][1]
			end
		end,
		getValue = function(nameOrProperty)
			nameOrProperty = tostring(nameOrProperty)
			local index = usedNames[nameOrProperty]
			if not index then
				index = usedProperties[nameOrProperty]
			end
			if index then
				return details[index][2]
			end
		end,
		getProperty = function(nameOrValue)
			nameOrValue = tostring(nameOrValue)
			local index = usedNames[nameOrValue]
			if not index then
				index = usedValues[nameOrValue]
			end
			if index then
				return details[index][3]
			end
		end
	}
	for i, detail in pairs(details) do
		assert(typeof(detail) == "table", ("bad argument #2.%s - details must only be comprised of tables!"):format(i))
		local name = detail[1]
		assert(typeof(name) == "string", ("bad argument #2.%s.1 - detail name must be a string!"):format(i))
		assert(typeof(not usedNames[name]), ("bad argument #2.%s.1 - the detail name '%s' already exists!"):format(i, name))
		assert(typeof(not enumMetaFunctions[name]), ("bad argument #2.%s.1 - that name is reserved."):format(i, name))
		usedNames[tostring(name)] = i
		local value = detail[2]
		local valueString = tostring(value)
		--assert(typeof(value) == "number" and math.ceil(value)/value == 1, ("bad argument #2.%s.2 - detail value must be an integer!"):format(i))
		assert(typeof(not usedValues[valueString]), ("bad argument #2.%s.2 - the detail value '%s' already exists!"):format(i, valueString))
		usedValues[valueString] = i
		local property = detail[3]
		if property then
			assert(typeof(not usedProperties[property]), ("bad argument #2.%s.3 - the detail property '%s' already exists!"):format(i, tostring(property)))
			usedProperties[tostring(property)] = i
		end
		enum[name] = value
		setmetatable(enum, {
			__index = function(_, index)
				return(enumMetaFunctions[index])
			end
		})
	end
	
	enums[enumName] = enum
	return enum
end

function Enum.getEnums()
	return enums
end



-- SETUP ENUMS
local createEnum = Enum.createEnum
for _, childModule in pairs(script:GetChildren()) do
	if childModule:IsA("ModuleScript") then
		local enumDetail = require(childModule)
		createEnum(childModule.Name, enumDetail)
	end
end

--[[
-- Example enum
createEnum("Color", {
	{"White", 1, Color3.fromRGB(255, 255, 255)},
	{"Black", 2, Color3.fromRGB(0, 0, 0)},
})
--]]



return Enum

]=]

 

local v1 = {};
local u2 = {};
v1.enums = u2;

function v1.createEnum(p3, u4) -- Line: 20
    -- upvalues: u2 (copy)
    local v5 = typeof(p3) == "string";
    assert(v5, "bad argument #1 - enums must be created using a string name!");
    local v6 = typeof(u4) == "table";
    assert(v6, "bad argument #2 - enums must be created using a table!");
    assert(not u2[p3], ("enum \'%s\' already exists!"):format(p3));
    local u7 = {};
    local u8 = {};
    local u9 = {};
    local u19 = {
        getName = function(p10) -- Line: 30, Name: getName
            -- upvalues: u8 (copy), u9 (copy), u4 (copy)
            local v11 = tostring(p10);
            local v12 = u8[v11] or u9[v11];

            if v12 then
                return u4[v12][1];
            end;
        end,

        getValue = function(p13) -- Line: 40, Name: getValue
            -- upvalues: u7 (copy), u9 (copy), u4 (copy)
            local v14 = tostring(p13);
            local v15 = u7[v14] or u9[v14];

            if v15 then
                return u4[v15][2];
            end;
        end,

        getProperty = function(p16) -- Line: 50, Name: getProperty
            -- upvalues: u7 (copy), u8 (copy), u4 (copy)
            local v17 = tostring(p16);
            local v18 = u7[v17] or u8[v17];

            if v18 then
                return u4[v18][3];
            end;
        end
    };
    local v20 = {};

    for i, v in pairs(u4) do
        local v21 = typeof(v) == "table";
        assert(v21, ("bad argument #2.%s - details must only be comprised of tables!"):format(i));
        local v22 = v[1];
        local v23 = typeof(v22) == "string";
        assert(v23, ("bad argument #2.%s.1 - detail name must be a string!"):format(i));
        local v24 = typeof(not u7[v22]);
        assert(v24, ("bad argument #2.%s.1 - the detail name \'%s\' already exists!"):format(i, v22));
        local v25 = typeof(not u19[v22]);
        assert(v25, ("bad argument #2.%s.1 - that name is reserved."):format(i, v22));
        u7[tostring(v22)] = i;
        local v26 = v[2];
        local v27 = tostring(v26);
        local v28 = typeof(not u8[v27]);
        assert(v28, ("bad argument #2.%s.2 - the detail value \'%s\' already exists!"):format(i, v27));
        u8[v27] = i;
        local v29 = v[3];

        if v29 then
            local v30 = typeof(not u9[v29]);
            local v31 = tostring(v29);
            assert(v30, ("bad argument #2.%s.3 - the detail property \'%s\' already exists!"):format(i, v31));
            u9[tostring(v29)] = i;
        end;

        v20[v22] = v26;
        setmetatable(v20, {
            __index = function(p32, p33) -- Line: 80, Name: __index
                -- upvalues: u19 (copy)
                return u19[p33];
            end
        });
    end;

    u2[p3] = v20;

    return v20;
end;

function v1.getEnums() -- Line: 90
    -- upvalues: u2 (copy)
    return u2;
end;

local createEnum = v1.createEnum;

for _, child in pairs(script:GetChildren()) do
    if child:IsA("ModuleScript") then
        local v34 = require(child);
        createEnum(child.Name, v34);
    end;
end;

return v1;