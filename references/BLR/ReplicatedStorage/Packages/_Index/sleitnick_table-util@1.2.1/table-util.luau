 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
--!strict

-- TableUtil
-- Stephen Leitnick
-- September 13, 2017

--[=[
	@class TableUtil

	A collection of helpful table utility functions. Many of these functions are carried over from JavaScript or
	Python that are not present in Lua.

	Tables that only work specifically with arrays or dictionaries are marked as such in the documentation.

	:::info Immutability
	All functions (_except_ `SwapRemove`, `SwapRemoveFirstValue`, and `Lock`) treat tables as immutable and will return
	copies of the given table(s) with the operations performed on the copies.
]=]
local TableUtil = {}

local HttpService = game:GetService("HttpService")
local rng = Random.new()

--[=[
	@within TableUtil
	@function Copy
	@param tbl table -- Table to copy
	@param deep boolean? -- Whether or not to perform a deep copy
	@return table

	Creates a copy of the given table. By default, a shallow copy is
	performed. For deep copies, a second boolean argument must be
	passed to the function.

	:::caution No cyclical references
	Deep copies are _not_ protected against cyclical references. Passing
	a table with cyclical references _and_ the `deep` parameter set to
	`true` will result in a stack-overflow.
]=]
local function Copy<T>(t: T, deep: boolean?): T
	if not deep then
		return (table.clone(t :: any) :: any) :: T
	end
	local function DeepCopy(tbl: { any })
		local tCopy = table.clone(tbl)
		for k, v in tCopy do
			if type(v) == "table" then
				tCopy[k] = DeepCopy(v)
			end
		end
		return tCopy
	end
	return DeepCopy(t :: any) :: T
end

--[=[
	@within TableUtil
	@function Sync
	@param srcTbl table -- Source table
	@param templateTbl table -- Template table
	@return table

	Synchronizes the `srcTbl` based on the `templateTbl`. This will make
	sure that `srcTbl` has all of the same keys as `templateTbl`, including
	removing keys in `srcTbl` that are not present in `templateTbl`. This
	is a _deep_ operation, so any nested tables will be synchronized as
	well.

	```lua
	local template = {kills = 0, deaths = 0, xp = 0}
	local data = {kills = 10, experience = 12}
	data = TableUtil.Sync(data, template)
	print(data) --> {kills = 10, deaths = 0, xp = 0}
	```

	:::caution Data Loss Warning
	This is a two-way sync, so the source table will have data
	_removed_ that isn't found in the template table. This can
	be problematic if used for player data, where there might
	be dynamic data added that isn't in the template.

	For player data, use `TableUtil.Reconcile` instead.
]=]
local function Sync<S, T>(srcTbl: S, templateTbl: T): T
	assert(type(srcTbl) == "table", "First argument must be a table")
	assert(type(templateTbl) == "table", "Second argument must be a table")

	local tbl = table.clone(srcTbl)

	-- If 'tbl' has something 'templateTbl' doesn't, then remove it from 'tbl'
	-- If 'tbl' has something of a different type than 'templateTbl', copy from 'templateTbl'
	-- If 'templateTbl' has something 'tbl' doesn't, then add it to 'tbl'
	for k, v in pairs(tbl) do
		local vTemplate = templateTbl[k]

		-- Remove keys not within template:
		if vTemplate == nil then
			tbl[k] = nil

			-- Synchronize data types:
		elseif type(v) ~= type(vTemplate) then
			if type(vTemplate) == "table" then
				tbl[k] = Copy(vTemplate, true)
			else
				tbl[k] = vTemplate
			end

			-- Synchronize sub-tables:
		elseif type(v) == "table" then
			tbl[k] = Sync(v, vTemplate)
		end
	end

	-- Add any missing keys:
	for k, vTemplate in pairs(templateTbl) do
		local v = tbl[k]

		if v == nil then
			if type(vTemplate) == "table" then
				tbl[k] = Copy(vTemplate, true)
			else
				tbl[k] = vTemplate
			end
		end
	end

	return (tbl :: any) :: T
end

--[=[
	@within TableUtil
	@function Reconcile
	@param source table
	@param template table
	@return table

	Performs a one-way sync on the `source` table against the
	`template` table. Any keys found in `template` that are
	not found in `source` will be added to `source`. This is
	useful for syncing player data against data template tables
	to ensure players have all the necessary keys, while
	maintaining existing keys that may no longer be in the
	template.

	This is a deep operation, so nested tables will also be
	properly reconciled.

	```lua
	local template = {kills = 0, deaths = 0, xp = 0}
	local data = {kills = 10, abc = 20}
	local correctedData = TableUtil.Reconcile(data, template)
	
	print(correctedData) --> {kills = 10, deaths = 0, xp = 0, abc = 20}
	```
]=]
local function Reconcile<S, T>(src: S, template: T): S & T
	assert(type(src) == "table", "First argument must be a table")
	assert(type(template) == "table", "Second argument must be a table")

	local tbl = table.clone(src)

	for k, v in template do
		local sv = src[k]
		if sv == nil then
			if type(v) == "table" then
				tbl[k] = Copy(v, true)
			else
				tbl[k] = v
			end
		elseif type(sv) == "table" then
			if type(v) == "table" then
				tbl[k] = Reconcile(sv, v)
			else
				tbl[k] = Copy(sv, true)
			end
		end
	end

	return (tbl :: any) :: S & T
end

--[=[
	@within TableUtil
	@function SwapRemove
	@param tbl table -- Array
	@param i number -- Index

	Removes index `i` in the table by swapping the value at `i` with
	the last value in the array, and then trimming off the last
	value from the array.

	This allows removal of the value at `i` in `O(1)` time, but does
	not preserve array ordering. If a value needs to be removed from
	an array, but ordering of the array does not matter, using
	`SwapRemove` is always preferred over `table.remove`.

	In the following example, we remove "B" at index 2. SwapRemove does
	this by moving the last value "E" over top of "B", and then trimming
	off "E" at the end of the array:
	```lua
	local t = {"A", "B", "C", "D", "E"}
	TableUtil.SwapRemove(t, 2) -- Remove "B"
	print(t) --> {"A", "E", "C", "D"}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function SwapRemove<T>(t: { T }, i: number)
	local n = #t
	t[i] = t[n]
	t[n] = nil
end

--[=[
	@within TableUtil
	@function SwapRemoveFirstValue
	@param tbl table -- Array
	@param v any -- Value to find
	@return number?

	Performs `table.find(tbl, v)` to find the index of the given
	value, and then performs `TableUtil.SwapRemove` on that index.

	```lua
	local t = {"A", "B", "C", "D", "E"}
	TableUtil.SwapRemoveFirstValue(t, "C")
	print(t) --> {"A", "B", "E", "D"}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function SwapRemoveFirstValue<T>(t: { T }, v: T): number?
	local index: number? = table.find(t, v)
	if index then
		SwapRemove(t, index)
	end
	return index
end

--[=[
	@within TableUtil
	@function Map
	@param tbl table
	@param predicate (value: any, key: any, tbl: table) -> newValue: any
	@return table

	Performs a map operation against the given table, which can be used to
	map new values based on the old values at given keys/indices.

	For example:

	```lua
	local t = {A = 10, B = 20, C = 30}
	local t2 = TableUtil.Map(t, function(value)
		return value * 2
	end)
	print(t2) --> {A = 20, B = 40, C = 60}
	```
]=]
local function Map<T, M>(t: { T }, f: (T, number, { T }) -> M): { M }
	assert(type(t) == "table", "First argument must be a table")
	assert(type(f) == "function", "Second argument must be a function")
	local newT = table.create(#t)
	for k, v in t do
		newT[k] = f(v, k, t)
	end
	return newT
end

--[=[
	@within TableUtil
	@function Filter
	@param tbl table
	@param predicate (value: any, key: any, tbl: table) -> keep: boolean
	@return table

	Performs a filter operation against the given table, which can be used to
	filter out unwanted values from the table.

	For example:

	```lua
	local t = {A = 10, B = 20, C = 30}
	local t2 = TableUtil.Filter(t, function(value, key)
		return value > 15
	end)
	print(t2) --> {B = 40, C = 60}
	```
]=]
local function Filter<T>(t: { T }, predicate: (T, any, { T }) -> boolean): { T }
	assert(type(t) == "table", "First argument must be a table")
	assert(type(predicate) == "function", "Second argument must be a function")
	local newT = table.create(#t)
	if #t > 0 then
		local n = 0
		for i, v in t do
			if predicate(v, i, t) then
				n += 1
				newT[n] = v
			end
		end
	else
		for k, v in t do
			if predicate(v, k, t) then
				newT[k] = v
			end
		end
	end
	return newT
end

--[=[
	@within TableUtil
	@function Reduce
	@param tbl table
	@param predicate (accumulator: any, value: any, index: any, tbl: table) -> result: any
	@return table

	Performs a reduce operation against the given table, which can be used to
	reduce the table into a single value. This could be used to sum up a table
	or transform all the values into a compound value of any kind.

	For example:

	```lua
	local t = {10, 20, 30, 40}
	local result = TableUtil.Reduce(t, function(accum, value)
		return accum + value
	end)
	print(result) --> 100
	```
]=]
local function Reduce<T, R>(t: { T }, predicate: (R, T, any, { T }) -> R, init: R): R
	assert(type(t) == "table", "First argument must be a table")
	assert(type(predicate) == "function", "Second argument must be a function")
	local result = init :: R
	if #t > 0 then
		local start = 1
		if init == nil then
			result = (t[1] :: any) :: R
			start = 2
		end
		for i = start, #t do
			result = predicate(result, t[i], i, t)
		end
	else
		local start = nil
		if init == nil then
			result = (next(t) :: any) :: R
			start = result
		end
		for k, v in next, t, start :: any? do
			result = predicate(result, v, k, t)
		end
	end
	return result
end

--[=[
	@within TableUtil
	@function Assign
	@param target table
	@param ... table
	@return table

	Copies all values of the given tables into the `target` table.

	```lua
	local t = {A = 10}
	local t2 = {B = 20}
	local t3 = {C = 30, D = 40}
	local newT = TableUtil.Assign(t, t2, t3)
	print(newT) --> {A = 10, B = 20, C = 30, D = 40}
	```
]=]
local function Assign<T>(target: { T }, ...: { any }): { T } & { any }
	local tbl = table.clone(target)
	for _, src in { ... } do
		for k, v in src do
			tbl[k] = v
		end
	end
	return tbl
end

--[=[
	@within TableUtil
	@function Extend
	@param target table
	@param extension table
	@return table

	Extends the target array with the extension array.

	```lua
	local t = {10, 20, 30}
	local t2 = {30, 40, 50}
	local tNew = TableUtil.Extend(t, t2)
	print(tNew) --> {10, 20, 30, 30, 40, 50}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function Extend<T, E>(target: { T }, extension: { E }): { T } & { E }
	local tbl = table.clone(target) :: { any }
	for _, v in extension do
		table.insert(tbl, v)
	end
	return tbl
end

--[=[
	@within TableUtil
	@function Reverse
	@param tbl table
	@return table

	Reverses the array.

	```lua
	local t = {1, 5, 10}
	local tReverse = TableUtil.Reverse(t)
	print(tReverse) --> {10, 5, 1}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function Reverse<T>(tbl: { T }): { T }
	local n = #tbl
	local tblRev = table.create(n)
	for i = 1, n do
		tblRev[i] = tbl[n - i + 1]
	end
	return tblRev
end

--[=[
	@within TableUtil
	@function Shuffle
	@param tbl table
	@param rngOverride Random?
	@return table

	Shuffles the table.

	```lua
	local t = {1, 2, 3, 4, 5, 6, 7, 8, 9}
	local shuffled = TableUtil.Shuffle(t)
	print(shuffled) --> e.g. {9, 4, 6, 7, 3, 1, 5, 8, 2}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function Shuffle<T>(tbl: { T }, rngOverride: Random?): { T }
	assert(type(tbl) == "table", "First argument must be a table")
	local shuffled = table.clone(tbl)
	local random = if typeof(rngOverride) == "Random" then rngOverride else rng
	for i = #tbl, 2, -1 do
		local j = random:NextInteger(1, i)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end
	return shuffled
end

--[=[
	@within TableUtil
	@function Sample
	@param tbl table
	@param sampleSize number
	@param rngOverride Random?
	@return table

	Returns a random sample of the table.

	```lua
	local t = {1, 2, 3, 4, 5, 6, 7, 8, 9}
	local sample = TableUtil.Sample(t, 3)
	print(sample) --> e.g. {6, 2, 5}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function Sample<T>(tbl: { T }, size: number, rngOverride: Random?): { T }
	assert(type(tbl) == "table", "First argument must be a table")
	assert(type(size) == "number", "Second argument must be a number")

	-- If given table is empty, just return a new empty table:
	local len = #tbl
	if len == 0 then
		return {}
	end

	local shuffled = table.clone(tbl)
	local sample = table.create(size)
	local random = if typeof(rngOverride) == "Random" then rngOverride else rng

	-- Clamp sample size to be no larger than the given table size:
	size = math.clamp(size, 1, len)

	for i = 1, size do
		local j = random:NextInteger(i, len)
		shuffled[i], shuffled[j] = shuffled[j], shuffled[i]
	end

	table.move(shuffled, 1, size, 1, sample)

	return sample
end

--[=[
	@within TableUtil
	@function Flat
	@param tbl table
	@param depth number?
	@return table

	Returns a new table where all sub-arrays have been
	bubbled up to the top. The depth at which the scan
	is performed is dictated by the `depth` parameter,
	which is set to `1` by default.

	```lua
	local t = {{10, 20}, {90, 100}, {30, 15}}
	local flat = TableUtil.Flat(t)
	print(flat) --> {10, 20, 90, 100, 30, 15}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function Flat<T>(tbl: { T }, depth: number?): { T }
	local maxDepth: number = if type(depth) == "number" then depth else 1
	local flatTbl = table.create(#tbl)
	local function Scan(t: { any }, d: number)
		for _, v in t do
			if type(v) == "table" and d < maxDepth then
				Scan(v, d + 1)
			else
				table.insert(flatTbl, v)
			end
		end
	end
	Scan(tbl, 0)
	return flatTbl
end

--[=[
	@within TableUtil
	@function FlatMap
	@param tbl table
	@param predicate (key: any, value: any, tbl: table) -> newValue: any
	@return table

	Calls `TableUtil.Map` on the given table and predicate, and then
	calls `TableUtil.Flat` on the result from the map operation.

	```lua
	local t = {10, 20, 30}
	local result = TableUtil.FlatMap(t, function(value)
		return {value, value * 2}
	end)
	print(result) --> {10, 20, 20, 40, 30, 60}
	```

	:::note Arrays only
	This function works on arrays, but not dictionaries.
]=]
local function FlatMap<T, M>(tbl: { T }, callback: (T, number, { T }) -> M): { M }
	return Flat(Map(tbl, callback))
end

--[=[
	@within TableUtil
	@function Keys
	@param tbl table
	@return table

	Returns an array with all the keys in the table.

	```lua
	local t = {A = 10, B = 20, C = 30}
	local keys = TableUtil.Keys(t)
	print(keys) --> {"A", "B", "C"}
	```

	:::caution Ordering
	The ordering of the keys is never guaranteed. If order is imperative, call
	`table.sort` on the resulting `keys` array.
	```lua
	local keys = TableUtil.Keys(t)
	table.sort(keys)
	```
]=]
local function Keys<K, V>(tbl: { [K]: V }): { K }
	local keys = table.create(#tbl)
	for k in tbl do
		table.insert(keys, k)
	end
	return keys
end

--[=[
	@within TableUtil
	@function Values
	@param tbl table
	@return table

	Returns an array with all the values in the table.

	```lua
	local t = {A = 10, B = 20, C = 30}
	local values = TableUtil.Values(t)
	print(values) --> {10, 20, 30}
	```

	:::caution Ordering
	The ordering of the values is never guaranteed. If order is imperative, call
	`table.sort` on the resulting `values` array.
	```lua
	local values = TableUtil.Values(t)
	table.sort(values)
	```
]=]
local function Values<K, V>(tbl: { [K]: V }): { V }
	local values = table.create(#tbl)
	for _, v in tbl do
		table.insert(values, v)
	end
	return values
end

--[=[
	@within TableUtil
	@function Find
	@param tbl table
	@param callback (value: any, index: any, tbl: table) -> boolean
	@return (value: any?, key: any?)

	Performs a linear scan across the table and calls `callback` on
	each item in the array. Returns the value and key of the first
	pair in which the callback returns `true`.

	```lua
	local t = {
		{Name = "Bob", Age = 20};
		{Name = "Jill", Age = 30};
		{Name = "Ann", Age = 25};
	}

	-- Find first person who has a name starting with J:
	local firstPersonWithJ = TableUtil.Find(t, function(person)
		return person.Name:sub(1, 1):lower() == "j"
	end)

	print(firstPersonWithJ) --> {Name = "Jill", Age = 30}
	```

	:::caution Dictionary Ordering
	While `Find` can also be used with dictionaries, dictionary ordering is never
	guaranteed, and thus the result could be different if there are more
	than one possible matches given the data and callback function.
]=]
local function Find<K, V>(tbl: { [K]: V }, callback: (V, K, { [K]: V }) -> boolean): (V?, K?)
	for k, v in tbl do
		if callback(v, k, tbl) then
			return v, k
		end
	end
	return nil, nil
end

--[=[
	@within TableUtil
	@function Every
	@param tbl table
	@param callback (value: any, index: any, tbl: table) -> boolean
	@return boolean

	Returns `true` if the `callback` also returns `true` for _every_
	item in the table.

	```lua
	local t = {10, 20, 40, 50, 60}

	local allAboveZero = TableUtil.Every(t, function(value)
		return value > 0
	end)

	print("All above zero:", allAboveZero) --> All above zero: true
	```
]=]
local function Every<K, V>(tbl: { [K]: V }, callback: (V, K, { [K]: V }) -> boolean): boolean
	for k, v in tbl do
		if not callback(v, k, tbl) then
			return false
		end
	end
	return true
end

--[=[
	@within TableUtil
	@function Some
	@param tbl table
	@param callback (value: any, index: any, tbl: table) -> boolean
	@return boolean

	Returns `true` if the `callback` also returns `true` for _at least
	one_ of the items in the table.

	```lua
	local t = {10, 20, 40, 50, 60}

	local someBelowTwenty = TableUtil.Some(t, function(value)
		return value < 20
	end)

	print("Some below twenty:", someBelowTwenty) --> Some below twenty: true
	```
]=]
local function Some<K, V>(tbl: { [K]: V }, callback: (V, K, { [K]: V }) -> boolean): boolean
	for k, v in tbl do
		if callback(v, k, tbl) then
			return true
		end
	end
	return false
end

--[=[
	@within TableUtil
	@function Truncate
	@param tbl table
	@param length number
	@return table

	Returns a new table truncated to the length of `length`. Any length
	equal or greater than the current length will simply return a
	shallow copy of the table.

	```lua
	local t = {10, 20, 30, 40, 50, 60, 70, 80}
	local tTruncated = TableUtil.Truncate(t, 3)
	print(tTruncated) --> {10, 20, 30}
	```
]=]
local function Truncate<T>(tbl: { T }, len: number): { T }
	local n = #tbl
	len = math.clamp(len, 1, n)
	return if len == n then table.clone(tbl) else table.move(tbl, 1, len, 1, table.create(len))
end

--[=[
	@within TableUtil
	@function Zip
	@param ... table
	@return (iter: (t: table, k: any) -> (key: any?, values: table?), tbl: table, startIndex: any?)

	Returns an iterator that can scan through multiple tables at the same time side-by-side, matching
	against shared keys/indices.

	```lua
	local t1 = {10, 20, 30, 40, 50}
	local t2 = {60, 70, 80, 90, 100}

	for key,values in TableUtil.Zip(t1, t2) do
		print(key, values)
	end

	--[[
		Outputs:
		1 {10, 60}
		2 {20, 70}
		3 {30, 80}
		4 {40, 90}
		5 {50, 100}
	--]]
	```
]=]
local function Zip(...: { [any]: any }): ((t: { any }, k: any) -> (any, any), { any }, any)
	assert(select("#", ...) > 0, "Must supply at least 1 table")
	local function ZipIteratorArray(all: { any }, k: number): (number?, { any }?)
		k += 1
		local values = {}
		for i, t in all do
			local v = t[k]
			if v ~= nil then
				values[i] = v
			else
				return nil, nil
			end
		end
		return k, values
	end
	local function ZipIteratorMap(all: { [any]: any }, k: any): (number?, { any }?)
		local values = {}
		for i, t in all do
			local v = next(t, k)
			if v ~= nil then
				values[i] = v
			else
				return nil, nil
			end
		end
		return k, values
	end
	local all = { ... }
	if #all[1] > 0 then
		return ZipIteratorArray, all, 0
	else
		return ZipIteratorMap, all, nil
	end
end

--[=[
	@within TableUtil
	@function Lock
	@param tbl table
	@return table

	Locks the table using `table.freeze`, as well as any
	nested tables within the given table. This will lock
	the whole deep structure of the table, disallowing any
	further modifications.

	```lua
	local tbl = {xyz = {abc = 32}}
	tbl.xyz.abc = 28 -- Works fine
	TableUtil.Lock(tbl)
	tbl.xyz.abc = 64 -- Will throw an error (cannot modify readonly table)
	```
]=]
local function Lock<T>(tbl: T): T
	local function Freeze(t: { [any]: any })
		for k, v in pairs(t) do
			if type(v) == "table" then
				t[k] = Freeze(v)
			end
		end
		return table.freeze(t)
	end
	return Freeze(tbl :: any)
end

--[=[
	@within TableUtil
	@function IsEmpty
	@param tbl table
	@return boolean

	Returns `true` if the given table is empty. This is
	simply performed by checking if `next(tbl)` is `nil`
	and works for both arrays and dictionaries. This is
	useful when needing to check if a table is empty but
	not knowing if it is an array or dictionary.

	```lua
	TableUtil.IsEmpty({}) -- true
	TableUtil.IsEmpty({"abc"}) -- false
	TableUtil.IsEmpty({abc = 32}) -- false
	```
]=]
local function IsEmpty(tbl: { any }): boolean
	return next(tbl) == nil
end

--[=[
	@within TableUtil
	@function EncodeJSON
	@param value any
	@return string

	Proxy for [`HttpService:JSONEncode`](https://developer.roblox.com/en-us/api-reference/function/HttpService/JSONEncode).
]=]
local function EncodeJSON(value: any): string
	return HttpService:JSONEncode(value)
end

--[=[
	@within TableUtil
	@function DecodeJSON
	@param value any
	@return string

	Proxy for [`HttpService:JSONDecode`](https://developer.roblox.com/en-us/api-reference/function/HttpService/JSONDecode).
]=]
local function DecodeJSON(str: string): any
	return HttpService:JSONDecode(str)
end

TableUtil.Copy = Copy
TableUtil.Sync = Sync
TableUtil.Reconcile = Reconcile
TableUtil.SwapRemove = SwapRemove
TableUtil.SwapRemoveFirstValue = SwapRemoveFirstValue
TableUtil.Map = Map
TableUtil.Filter = Filter
TableUtil.Reduce = Reduce
TableUtil.Assign = Assign
TableUtil.Extend = Extend
TableUtil.Reverse = Reverse
TableUtil.Shuffle = Shuffle
TableUtil.Sample = Sample
TableUtil.Flat = Flat
TableUtil.FlatMap = FlatMap
TableUtil.Keys = Keys
TableUtil.Values = Values
TableUtil.Find = Find
TableUtil.Every = Every
TableUtil.Some = Some
TableUtil.Truncate = Truncate
TableUtil.Zip = Zip
TableUtil.Lock = Lock
TableUtil.IsEmpty = IsEmpty
TableUtil.EncodeJSON = EncodeJSON
TableUtil.DecodeJSON = DecodeJSON

return TableUtil

]==]

 

local v1 = {};
game:GetService("HttpService");
local Random_new_ret = Random.new();

local function CopyTableShallow(p2: table) -- Line: 58
    local table_create_ret = table.create(#p2);

    if #p2 > 0 then
        table.move(p2, 1, #p2, 1, table_create_ret);

        return table_create_ret;
    end;

    for i, v in pairs(p2) do
        table_create_ret[i] = v;
    end;

    return table_create_ret;
end;

local function Sync(p3: table, p4: table) -- Line: 68
    -- upvalues: CopyTableShallow (copy), Sync (copy)
    local v5 = type(p3) == "table";
    assert(v5, "First argument must be a table");
    local v6 = type(p4) == "table";
    assert(v6, "Second argument must be a table");
    local v7 = CopyTableShallow(p3);

    for i, v in pairs(v7) do
        local v8 = p4[i];

        if v8 == nil then
            v7[i] = nil;
        elseif type(v) == type(v8) then
            if type(v) == "table" then
                v7[i] = Sync(v, v8);
            end;
        elseif type(v8) == "table" then
            local v9 = type(v8) == "table";
            assert(v9, "First argument must be a table");

            local function Copy(p10) -- Line: 44
                -- upvalues: Copy (copy)
                local table_create_ret = table.create(#p10);

                for i2, v2 in pairs(p10) do
                    if type(v2) == "table" then
                        table_create_ret[i2] = Copy(v2);
                    else
                        table_create_ret[i2] = v2;
                    end;
                end;

                return table_create_ret;
            end;

            v7[i] = Copy(v8);
        else
            v7[i] = v8;
        end;
    end;

    for i, v in pairs(p4) do
        if v7[i] == nil then
            if type(v) == "table" then
                local v11 = type(v) == "table";
                assert(v11, "First argument must be a table");

                local function u13(p12) -- Line: 44
                    -- upvalues: u13 (copy)
                    local table_create_ret = table.create(#p12);

                    for i2, v2 in pairs(p12) do
                        if type(v2) == "table" then
                            table_create_ret[i2] = u13(v2);
                        else
                            table_create_ret[i2] = v2;
                        end;
                    end;

                    return table_create_ret;
                end;

                v7[i] = u13(v);
            else
                v7[i] = v;
            end;
        end;
    end;

    return v7;
end;

local HttpService = game:GetService("HttpService");

local function GenerateUUID() -- Line: 117
    -- upvalues: HttpService (copy)
    return HttpService:GenerateGUID(false);
end;

local function Map(p14: table, p15: function) -- Line: 130
    local v16 = type(p14) == "table";
    assert(v16, "First argument must be a table");
    local v17 = type(p15) == "function";
    assert(v17, "Second argument must be a function");
    local table_create_ret = table.create(#p14);

    for i, v in pairs(p14) do
        table_create_ret[i] = p15(v, i, p14);
    end;

    return table_create_ret;
end;

function IsArrayOrDictionary(p18: table)
    if type(p18) ~= "table" then
        return "None";
    end;

    local v19 = 0;
    local v20 = true;

    for i, _ in pairs(p18) do
        if type(i) ~= "number" or i ~= v19 + 1 then
            v20 = false;
            break;
        end;

        v19 = i;
    end;

    return v20 and "Array" or "Dictionary";
end;

local function Compare(p21, p22, p23) -- Line: 355
    -- upvalues: Compare (copy)
    if type(p21) ~= type(p22) then
        return false;
    end;

    if type(p21) ~= "table" then
        return p21 == p22;
    end;

    local v24 = getmetatable(p21);

    if not p23 and (v24 and v24.__eq) then
        return p21 == p22;
    end;

    for i, v in pairs(p21) do
        if not Compare(v, p22[i]) then
            return false;
        end;
    end;

    for i, v in pairs(p22) do
        if not Compare(v, p21[i]) then
            return false;
        end;
    end;

    return true;
end;

local function StringPathToArray(p25) -- Line: 406
    local v26 = {};

    if p25 ~= "" then
        for i in string.gmatch(p25, "[^%.]+") do
            table.insert(v26, i);
        end;
    end;

    return v26;
end;

function v1.Insert(p27, p28) -- Line: 288
    if IsArrayOrDictionary(p27) == "Array" then
        local v29 = #p27 + 1;
        p27[v29] = p28;

        return p27[v29], v29;
    end;
end;

function v1.Copy(p30: table) -- Line: 42
    local v31 = type(p30) == "table";
    assert(v31, "First argument must be a table");

    local function u33(p32) -- Line: 44
        -- upvalues: u33 (copy)
        local table_create_ret = table.create(#p32);

        for i, v in pairs(p32) do
            if type(v) == "table" then
                table_create_ret[i] = u33(v);
            else
                table_create_ret[i] = v;
            end;
        end;

        return table_create_ret;
    end;

    return u33(p30);
end;

function v1.Merge(...) -- Line: 374
    local v34 = {};

    for i = 1, select("#", ...) do
        local _ = i;

        for i2, v in pairs(select(i, ...)) do
            if type(v) == "number" and type(v34[i2]) == "number" then
                v34[i2] = v34[i2] + v;
            else
                v34[i2] = v;
            end;
        end;
    end;

    return v34;
end;

function v1.Combine(...) -- Line: 388
    local v35 = {};

    for _, v in pairs({ ... }) do
        if typeof(v) == "table" then
            for i, v2 in pairs(v) do
                if v35[i] and typeof(i) == "number" then
                    table.insert(v35, v2);
                else
                    v35[i] = v2;
                end;
            end;
        else
            table.insert(v35, v);
        end;
    end;

    return v35;
end;

v1.Compare = Compare;
v1.CopyShallow = CopyTableShallow;
v1.Sync = Sync;

function v1.FastRemove(p36, p37) -- Line: 104
    local v38 = p36[p37];
    local v39 = #p36;
    p36[p37] = p36[v39];
    p36[v39] = nil;

    return v38;
end;

function v1.FastRemoveFirstValue(p40: table, p41: any) -- Line: 121
    local table_find_ret = table.find(p40, p41);

    if not table_find_ret then
        return false, nil;
    end;

    local _ = p40[table_find_ret];
    local v42 = #p40;
    p40[table_find_ret] = p40[v42];
    p40[v42] = nil;

    return true, table_find_ret;
end;

v1.Map = Map;

function v1.Filter(p43: table, p44: function) -- Line: 140
    local v45 = type(p43) == "table";
    assert(v45, "First argument must be a table");
    local v46 = type(p44) == "function";
    assert(v46, "Second argument must be a function");
    local table_create_ret = table.create(#p43);

    if #p43 <= 0 then
        for i, v in pairs(p43) do
            if p44(v, i, p43) then
                table_create_ret[i] = v;
            end;
        end;

        return table_create_ret;
    end;

    local v47 = 0;

    for i, v in ipairs(p43) do
        if p44(v, i, p43) then
            v47 = v47 + 1;
            table_create_ret[v47] = v;
        end;
    end;

    return table_create_ret;
end;

function v1.Reduce(p48: table, p49: function, p50: number?) -- Line: 162
    local v51 = type(p48) == "table";
    assert(v51, "First argument must be a table");
    local v52 = type(p49) == "function";
    assert(v52, "Second argument must be a function");
    local v53 = p50 == nil and true or type(p50) == "number";
    assert(v53, "Third argument must be a number or nil");
    local v54 = p50 or 0;

    for i, v in pairs(p48) do
        v54 = p49(v54, v, i, p48);
    end;

    return v54;
end;

function v1.Assign(p55: table, ...) -- Line: 173
    -- upvalues: CopyTableShallow (copy)
    local v56 = CopyTableShallow(p55);

    for _, v in ipairs({ ... }) do
        for i, v2 in pairs(v) do
            v56[i] = v2;
        end;
    end;

    return v56;
end;

function v1.Extend(p57: table, p58: table) -- Line: 183
    -- upvalues: CopyTableShallow (copy)
    local v59 = CopyTableShallow(p57);

    for _, v in ipairs(p58) do
        table.insert(v59, v);
    end;

    return v59;
end;

function v1.Reverse(p60: table) -- Line: 191
    local v61 = #p60;
    local table_create_ret = table.create(v61);

    for i = 1, v61 do
        table_create_ret[i] = p60[v61 - i + 1];
        local _ = i;
    end;

    return table_create_ret;
end;

function v1.Shuffle(p62: table, p63: userdata?) -- Line: 200
    -- upvalues: CopyTableShallow (copy), Random_new_ret (copy)
    local v64 = type(p62) == "table";
    assert(v64, "First argument must be a table");
    local v65 = CopyTableShallow(p62);
    local v66 = p63 or Random_new_ret;

    for i = #p62, 2, -1 do
        local v67 = v66:NextInteger(1, i);
        local v68 = v65[i];
        v65[i] = v65[v67];
        v65[v67] = v68;
        local _ = i;
    end;

    return v65;
end;

function v1.Flat(p69: table, p70: number?) -- Line: 211
    local u71 = p70 or 1;
    local table_create_ret = table.create(#p69);

    local function Scan(p72: table, p73: number) -- Line: 214
        -- upvalues: u71 (copy), Scan (copy), table_create_ret (copy)
        for _, v in ipairs(p72) do
            if type(v) == "table" and p73 < u71 then
                Scan(v, p73 + 1);
            else
                table.insert(table_create_ret, v);
            end;
        end;
    end;

    Scan(p69, 0);

    return table_create_ret;
end;

function v1.FlatMap(p74: table, p75: function) -- Line: 227
    -- upvalues: Map (copy)
    local v76 = Map(p74, p75);
    local table_create_ret = table.create(#v76);
    local u77 = 1;

    local function u80(p78: table, p79: number) -- Line: 214
        -- upvalues: u77 (copy), u80 (copy), table_create_ret (copy)
        for _, v in ipairs(p78) do
            if type(v) == "table" and p79 < u77 then
                u80(v, p79 + 1);
            else
                table.insert(table_create_ret, v);
            end;
        end;
    end;

    u80(v76, 0);

    return table_create_ret;
end;

function v1.Keys(p81: table) -- Line: 232
    local table_create_ret = table.create(#p81);

    for i in pairs(p81) do
        table.insert(table_create_ret, i);
    end;

    return table_create_ret;
end;

function v1.Find(p82: table, p83: function) -- Line: 240
    for i, v in pairs(p82) do
        if p83(v, i, p82) then
            return v, i;
        end;
    end;

    return nil, nil;
end;

function v1.FindPathOnArray(p84, p85) -- Line: 416
    -- upvalues: StringPathToArray (copy)
    if type(p85) == "string" then
        p85 = StringPathToArray(p85) or p85;
    end;

    for i = 1, #p85 do
        p84 = p84[p85[i]];
        local _ = i;
    end;

    return p84;
end;

v1.StringPathToArray = StringPathToArray;

function v1.SearchArray(p86, p87, p88) -- Line: 298
    if next(p86) == nil then
        return false;
    end;

    for i, v in ipairs(p86) do
        if p88 then
            if tostring(v) == tostring(p87) then
                return v, i;
            end;
        elseif v == p87 then
            return v, i;
        end;
    end;
end;

function v1.Every(p89: table, p90: function) -- Line: 249
    for i, v in pairs(p89) do
        if not p90(v, i, p89) then
            return false;
        end;
    end;

    return true;
end;

function v1.Some(p91: table, p92: function) -- Line: 258
    for i, v in pairs(p91) do
        if p92(v, i, p91) then
            return true;
        end;
    end;

    return false;
end;

function v1.IsEmpty(p93) -- Line: 267
    return next(p93) == nil;
end;

function v1.EncodeJSON(p94) -- Line: 316
    -- upvalues: HttpService (copy)
    return HttpService:JSONEncode(p94);
end;

function v1.DecodeJSON(p95: string) -- Line: 320
    -- upvalues: HttpService (copy)
    return HttpService:JSONDecode(p95);
end;

function v1.GetDictionaryLength(p96) -- Line: 324
    local v97 = 0;

    for _, _ in pairs(p96) do
        v97 = v97 + 1;
    end;

    return v97;
end;

function v1.RandomPair(p98) -- Line: 332
    local Random_new_ret2 = Random.new();
    local v99 = 0;

    for _, _ in pairs(p98) do
        v99 = v99 + 1;
    end;

    local v100 = Random_new_ret2:NextInteger(1, v99);
    local v101 = 0;

    for _, v in pairs(p98) do
        v101 = v101 + 1;

        if v101 == v100 then
            return v;
        end;
    end;
end;

function v1.RandomArray(p102) -- Line: 344
    return p102[Random.new():NextInteger(1, #p102)];
end;

function v1.FastClone(p103) -- Line: 113
    return table.clone(p103);
end;

function v1.TableToString(p104) -- Line: 425
    local u105 = {};
    local u106 = "";

    local function constructor(p107, p108) -- Line: 428
        -- upvalues: u105 (copy), u106 (ref), constructor (copy)
        if u105[tostring(p107)] then
            u106 = u106 .. (p108 .. "*" .. tostring(p107)) .. "\n";

            return;
        end;

        u105[tostring(p107)] = true;

        if type(p107) == "table" then
            for i, v in pairs(p107) do
                if type(v) == "table" then
                    u106 = u106 .. (p108 .. "[" .. i .. "] => " .. tostring(p107) .. " {") .. "\n";
                    constructor(v, p108 .. string.rep(" ", string.len(i) + 8));
                    u106 = u106 .. (p108 .. string.rep(" ", string.len(i) + 6) .. "}") .. u106;
                elseif type(v) == "string" then
                    u106 = u106 .. (p108 .. "[" .. i .. "] => \"" .. v .. "\"") .. "\n";
                else
                    u106 = u106 .. (p108 .. "[" .. i .. "] => " .. tostring(v)) .. "\n";
                end;
            end;

            return;
        end;

        u106 = u106 .. (p108 .. tostring(p107)) .. "\n";
    end;

    if type(p104) == "table" then
        u106 = u106 .. (tostring(p104) .. " {") .. "\n";
        constructor(p104, "  ");
        u106 = u106 .. "}\n";
    else
        constructor(p104, "  ");
    end;

    u106 = u106 .. "\n";

    return u106;
end;

function v1.RemoveRandom(p109) -- Line: 349
    local v110 = Random.new():NextInteger(1, #p109);

    return table.remove(p109, v110);
end;

return v1;