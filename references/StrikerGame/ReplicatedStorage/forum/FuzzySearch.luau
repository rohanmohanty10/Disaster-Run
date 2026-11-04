 

-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=82220347085258

-- ! Source from the asset above; the game may have edited it since.

--[=[
--!strict
-- FuzzySearch.lua
-- Inspired by Fuse.js

--[[ EXAMPLE USAGE:

	//Example with strings//

local FuzzySearch = require(path.to.FuzzySearch)

local fruits = {"apple", "orange", "banana", "pineapple"}
local searcher = FuzzySearch.new(fruits, {threshold = 0.4})

local results = searcher:search("aple")
for _, result in ipairs(results) do
    print(result.item, result.score)
end

	/Output/

	apple      0.2
	pineapple  0.36

	
	//Example with objects//

local people = {
    {name = "John Doe", job = "Developer"},
    {name = "Jane Smith", job = "Designer"},
    {name = "Jake Johnson", job = "Doctor"}
}

local searcher2 = FuzzySearch.new(people, {
    threshold = 0.3,
    keys = {"name", "job"}
})

local results2 = searcher2:search("Desiner")
for _, result in ipairs(results2) do
    print(result.item.name, result.item.job, result.score)
end

	/Output/

	Jane Smith  Designer  0.18

]]

local FuzzySearch = {}
FuzzySearch.__index = FuzzySearch

export type Options = {
	threshold: number?, -- 0 = exact match only, 1 = match everything
	keys: {string}?, -- keys to search in objects
	caseSensitive: boolean?
}

type SearchResult = {
	item: any,
	score: number
}

-- Utility: Normalize case
local function normalize(str: string, caseSensitive: boolean?): string
	if not caseSensitive then
		return string.lower(str)
	end
	return str
end

-- Utility: Levenshtein distance
local function levenshtein(a: string, b: string): number
	local lenA, lenB = #a, #b
	local matrix = {}

	for i = 0, lenA do
		matrix[i] = {[0] = i}
	end
	for j = 0, lenB do
		matrix[0][j] = j
	end

	for i = 1, lenA do
		for j = 1, lenB do
			if a:sub(i, i) == b:sub(j, j) then
				matrix[i][j] = matrix[i - 1][j - 1]
			else
				local deletion = matrix[i - 1][j] + 1
				local insertion = matrix[i][j - 1] + 1
				local substitution = matrix[i - 1][j - 1] + 1
				matrix[i][j] = math.min(deletion, insertion, substitution)
			end
		end
	end

	return matrix[lenA][lenB]
end

-- Utility: Similarity score (0 = identical, 1 = completely different)
local function similarity(a: string, b: string): number
	if a == b then
		return 0
	end
	local dist = levenshtein(a, b)
	return dist / math.max(#a, #b)
end

-- Constructor
function FuzzySearch.new(list: {any}, options: Options?)
	local self = setmetatable({}, FuzzySearch)
	self.list = list or {}
	self.options = options or {}
	self.options.threshold = self.options.threshold or 0.4
	self.options.keys = self.options.keys or {}
	self.options.caseSensitive = self.options.caseSensitive or false
	return self
end

-- Utility: Get nested value by path
local function getNestedValue(tbl: any, path: string)
	local current = tbl
	for part in string.gmatch(path, "[^%.]+") do
		if type(current) ~= "table" then
			return nil
		end
		current = current[part]
		if current == nil then
			return nil
		end
	end
	return current
end

-- Utility: Collect all string values in a table (non-recursive or recursive)
local function collectAllStrings(tbl: any, results: {string}, recursive: boolean)
	if type(tbl) ~= "table" then return end
	for _, v in pairs(tbl) do
		if type(v) == "string" then
			table.insert(results, v)
		elseif recursive and type(v) == "table" then
			collectAllStrings(v, results, recursive)
		end
	end
end

-- Internal: Extract searchable text from an item
function FuzzySearch:_extractText(item: any): {string}
	if type(item) == "string" then
		return {item}
	elseif type(item) == "table" and #self.options.keys > 0 then
		local results = {}
		for _, key in ipairs(self.options.keys) do
			if key == ".*" then
				-- All string properties in the item (recursive)
				collectAllStrings(item, results, true)

			elseif string.sub(key, -2) == ".*" then
				-- Wildcard: all children of a nested table
				local basePath = string.sub(key, 1, -3)
				local tbl = basePath ~= "" and getNestedValue(item, basePath) or item
				if type(tbl) == "table" then
					collectAllStrings(tbl, results, true)
				end

			else
				-- Normal key/path
				local value
				if string.find(key, "%.") then
					value = getNestedValue(item, key)
				else
					value = item[key]
				end
				if type(value) == "string" then
					table.insert(results, value)
				end
			end
		end
		return results
	end
	return {}
end




-- Search
function FuzzySearch:search(pattern: string): {SearchResult}
	local results = {}
	local threshold = self.options.threshold or 0.4
	local caseSensitive = self.options.caseSensitive

	local normalizedPattern = normalize(pattern, caseSensitive)

	for _, item in ipairs(self.list) do
		for _, text in ipairs(self:_extractText(item)) do
			local normText = normalize(text, caseSensitive)
			local score = similarity(normalizedPattern, normText)

			if score <= threshold then
				table.insert(results, {item = item, score = score})
				break
			end
		end
	end

	table.sort(results, function(a, b)
		return a.score < b.score
	end)

	return results
end

return FuzzySearch

]=]

 

local u1 = {};
u1.__index = u1;

local function normalize(p2: string, p3: boolean?) -- Line: 63
    if p3 then
        return p2;
    end;

    return string.lower(p2);
end;

local function levenshtein(p4: string, p5: string) -- Line: 71
    local v6 = #p4;
    local v7 = #p5;
    local v8 = {};

    for i = 0, v6 do
        v8[i] = { i };
        local _ = i;
    end;

    for i = 0, v7 do
        v8[0][i] = i;
        local _ = i;
    end;

    for i = 1, v6 do
        local v9 = i;

        for i2 = 1, v7 do
            local v10;

            if p4:sub(v9, v9) == p5:sub(i2, i2) then
                v8[v9][i2] = v8[v9 - 1][i2 - 1];
                v10 = i2;
            else
                v8[v9][i2] = math.min(v8[v9 - 1][i2] + 1, v8[v9][i2 - 1] + 1, v8[v9 - 1][i2 - 1] + 1);
                v10 = i2;
            end;
        end;
    end;

    return v8[v6][v7];
end;

local function similarity(p11: string, p12: string) -- Line: 99
    -- upvalues: levenshtein (copy)
    return p11 == p12 and 0 or levenshtein(p11, p12) / math.max(#p11, #p12);
end;

function u1.new(p13: table, p14: table?) -- Line: 108
    -- upvalues: u1 (copy)
    local v15 = setmetatable({}, u1);
    v15.list = p13 or {};
    v15.options = p14 or {};
    v15.options.threshold = v15.options.threshold or 0.4;
    v15.options.keys = v15.options.keys or {};
    v15.options.caseSensitive = v15.options.caseSensitive or false;

    return v15;
end;

local function getNestedValue(p16: any, p17: string) -- Line: 119
    for i in string.gmatch(p17, "[^%.]+") do
        if type(p16) ~= "table" then
            return nil;
        end;

        p16 = p16[i];

        if p16 == nil then
            return nil;
        end;
    end;

    return p16;
end;

local function collectAllStrings(p18: any, p19: table, p20: boolean) -- Line: 134
    -- upvalues: collectAllStrings (copy)
    if type(p18) ~= "table" then
        return;
    end;

    for _, v in pairs(p18) do
        if type(v) == "string" then
            table.insert(p19, v);
        elseif p20 and type(v) == "table" then
            collectAllStrings(v, p19, p20);
        end;
    end;
end;

function u1._extractText(p21, p22) -- Line: 146
    -- upvalues: collectAllStrings (copy), getNestedValue (copy)
    if type(p22) == "string" then
        return { p22 };
    end;

    if type(p22) ~= "table" or #p21.options.keys <= 0 then
        return {};
    end;

    local v23 = {};

    for _, v in ipairs(p21.options.keys) do
        if v == ".*" then
            collectAllStrings(p22, v23, true);
        elseif string.sub(v, -2) == ".*" then
            local string_sub_ret = string.sub(v, 1, -3);
            local v24;

            if string_sub_ret == "" then
                v24 = p22;
            else
                v24 = getNestedValue(p22, string_sub_ret) or p22;
            end;

            if type(v24) == "table" then
                collectAllStrings(v24, v23, true);
            end;
        else
            local v25;

            if string.find(v, "%.") then
                v25 = getNestedValue(p22, v);
            else
                v25 = p22[v];
            end;

            if type(v25) == "string" then
                table.insert(v23, v25);
            end;
        end;
    end;

    return v23;
end;

function u1.search(p26: table, p27: string) -- Line: 186
    -- upvalues: levenshtein (copy)
    local v28 = {};
    local v29 = p26.options.threshold or 0.4;
    local caseSensitive = p26.options.caseSensitive;

    if not caseSensitive then
        p27 = string.lower(p27);
    end;

    for _, v in ipairs(p26.list) do
        local v30 = v;

        for _, v2 in ipairs(p26:_extractText(v)) do
            local v31;

            if caseSensitive then
                v31 = v2;
            else
                v31 = string.lower(v2);
            end;

            local v32 = p27 == v31 and 0 or levenshtein(p27, v31) / math.max(#p27, #v31);

            if v32 <= v29 then
                table.insert(v28, {
                    item = v30,
                    score = v32
                });
                break;
            end;
        end;
    end;

    table.sort(v28, function(p33, p34) -- Line: 205
        return p33.score < p34.score;
    end);

    return v28;
end;

return u1;