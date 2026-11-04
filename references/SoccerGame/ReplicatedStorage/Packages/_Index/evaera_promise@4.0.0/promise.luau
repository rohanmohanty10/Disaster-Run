 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[==[
--[[
	An implementation of Promises similar to Promise/A+.
]]

local ERROR_NON_PROMISE_IN_LIST = "Non-promise value passed into %s at index %s"
local ERROR_NON_LIST = "Please pass a list of promises to %s"
local ERROR_NON_FUNCTION = "Please pass a handler function to %s!"
local MODE_KEY_METATABLE = { __mode = "k" }

local function isCallable(value)
	if type(value) == "function" then
		return true
	end

	if type(value) == "table" then
		local metatable = getmetatable(value)
		if metatable and type(rawget(metatable, "__call")) == "function" then
			return true
		end
	end

	return false
end

--[[
	Creates an enum dictionary with some metamethods to prevent common mistakes.
]]
local function makeEnum(enumName, members)
	local enum = {}

	for _, memberName in ipairs(members) do
		enum[memberName] = memberName
	end

	return setmetatable(enum, {
		__index = function(_, k)
			error(string.format("%s is not in %s!", k, enumName), 2)
		end,
		__newindex = function()
			error(string.format("Creating new members in %s is not allowed!", enumName), 2)
		end,
	})
end

--[=[
	An object to represent runtime errors that occur during execution.
	Promises that experience an error like this will be rejected with
	an instance of this object.

	@class Error
]=]
local Error
do
	Error = {
		Kind = makeEnum("Promise.Error.Kind", {
			"ExecutionError",
			"AlreadyCancelled",
			"NotResolvedInTime",
			"TimedOut",
		}),
	}
	Error.__index = Error

	function Error.new(options, parent)
		options = options or {}
		return setmetatable({
			error = tostring(options.error) or "[This error has no error text.]",
			trace = options.trace,
			context = options.context,
			kind = options.kind,
			parent = parent,
			createdTick = os.clock(),
			createdTrace = debug.traceback(),
		}, Error)
	end

	function Error.is(anything)
		if type(anything) == "table" then
			local metatable = getmetatable(anything)

			if type(metatable) == "table" then
				return rawget(anything, "error") ~= nil and type(rawget(metatable, "extend")) == "function"
			end
		end

		return false
	end

	function Error.isKind(anything, kind)
		assert(kind ~= nil, "Argument #2 to Promise.Error.isKind must not be nil")

		return Error.is(anything) and anything.kind == kind
	end

	function Error:extend(options)
		options = options or {}

		options.kind = options.kind or self.kind

		return Error.new(options, self)
	end

	function Error:getErrorChain()
		local runtimeErrors = { self }

		while runtimeErrors[#runtimeErrors].parent do
			table.insert(runtimeErrors, runtimeErrors[#runtimeErrors].parent)
		end

		return runtimeErrors
	end

	function Error:__tostring()
		local errorStrings = {
			string.format("-- Promise.Error(%s) --", self.kind or "?"),
		}

		for _, runtimeError in ipairs(self:getErrorChain()) do
			table.insert(
				errorStrings,
				table.concat({
					runtimeError.trace or runtimeError.error,
					runtimeError.context,
				}, "\n")
			)
		end

		return table.concat(errorStrings, "\n")
	end
end

--[[
	Packs a number of arguments into a table and returns its length.

	Used to cajole varargs without dropping sparse values.
]]
local function pack(...)
	return select("#", ...), { ... }
end

--[[
	Returns first value (success), and packs all following values.
]]
local function packResult(success, ...)
	return success, select("#", ...), { ... }
end

local function makeErrorHandler(traceback)
	assert(traceback ~= nil, "traceback is nil")

	return function(err)
		-- If the error object is already a table, forward it directly.
		-- Should we extend the error here and add our own trace?

		if type(err) == "table" then
			return err
		end

		return Error.new({
			error = err,
			kind = Error.Kind.ExecutionError,
			trace = debug.traceback(tostring(err), 2),
			context = "Promise created at:\n\n" .. traceback,
		})
	end
end

--[[
	Calls a Promise executor with error handling.
]]
local function runExecutor(traceback, callback, ...)
	return packResult(xpcall(callback, makeErrorHandler(traceback), ...))
end

--[[
	Creates a function that invokes a callback with correct error handling and
	resolution mechanisms.
]]
local function createAdvancer(traceback, callback, resolve, reject)
	return function(...)
		local ok, resultLength, result = runExecutor(traceback, callback, ...)

		if ok then
			resolve(unpack(result, 1, resultLength))
		else
			reject(result[1])
		end
	end
end

local function isEmpty(t)
	return next(t) == nil
end

--[=[
	An enum value used to represent the Promise's status.
	@interface Status
	@tag enum
	@within Promise
	.Started "Started" -- The Promise is executing, and not settled yet.
	.Resolved "Resolved" -- The Promise finished successfully.
	.Rejected "Rejected" -- The Promise was rejected.
	.Cancelled "Cancelled" -- The Promise was cancelled before it finished.
]=]
--[=[
	@prop Status Status
	@within Promise
	@readonly
	@tag enums
	A table containing all members of the `Status` enum, e.g., `Promise.Status.Resolved`.
]=]
--[=[
	A Promise is an object that represents a value that will exist in the future, but doesn't right now.
	Promises allow you to then attach callbacks that can run once the value becomes available (known as *resolving*),
	or if an error has occurred (known as *rejecting*).

	@class Promise
	@__index prototype
]=]
local Promise = {
	Error = Error,
	Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
	_getTime = os.clock,
	_timeEvent = game:GetService("RunService").Heartbeat,
	_unhandledRejectionCallbacks = {},
}
Promise.prototype = {}
Promise.__index = Promise.prototype

function Promise._new(traceback, callback, parent)
	if parent ~= nil and not Promise.is(parent) then
		error("Argument #2 to Promise.new must be a promise or nil", 2)
	end

	local self = {
		-- The executor thread.
		_thread = nil,

		-- Used to locate where a promise was created
		_source = traceback,

		_status = Promise.Status.Started,

		-- A table containing a list of all results, whether success or failure.
		-- Only valid if _status is set to something besides Started
		_values = nil,

		-- Lua doesn't like sparse arrays very much, so we explicitly store the
		-- length of _values to handle middle nils.
		_valuesLength = -1,

		-- Tracks if this Promise has no error observers..
		_unhandledRejection = true,

		-- Queues representing functions we should invoke when we update!
		_queuedResolve = {},
		_queuedReject = {},
		_queuedFinally = {},

		-- The function to run when/if this promise is cancelled.
		_cancellationHook = nil,

		-- The "parent" of this promise in a promise chain. Required for
		-- cancellation propagation upstream.
		_parent = parent,

		-- Consumers are Promises that have chained onto this one.
		-- We track them for cancellation propagation downstream.
		_consumers = setmetatable({}, MODE_KEY_METATABLE),
	}

	if parent and parent._status == Promise.Status.Started then
		parent._consumers[self] = true
	end

	setmetatable(self, Promise)

	local function resolve(...)
		self:_resolve(...)
	end

	local function reject(...)
		self:_reject(...)
	end

	local function onCancel(cancellationHook)
		if cancellationHook then
			if self._status == Promise.Status.Cancelled then
				cancellationHook()
			else
				self._cancellationHook = cancellationHook
			end
		end

		return self._status == Promise.Status.Cancelled
	end

	self._thread = coroutine.create(function()
		local ok, _, result = runExecutor(self._source, callback, resolve, reject, onCancel)

		if not ok then
			reject(result[1])
		end
	end)

	task.spawn(self._thread)

	return self
end

--[=[
	Construct a new Promise that will be resolved or rejected with the given callbacks.

	If you `resolve` with a Promise, it will be chained onto.

	You can safely yield within the executor function and it will not block the creating thread.

	```lua
	local myFunction()
		return Promise.new(function(resolve, reject, onCancel)
			wait(1)
			resolve("Hello world!")
		end)
	end

	myFunction():andThen(print)
	```

	You do not need to use `pcall` within a Promise. Errors that occur during execution will be caught and turned into a rejection automatically. If `error()` is called with a table, that table will be the rejection value. Otherwise, string errors will be converted into `Promise.Error(Promise.Error.Kind.ExecutionError)` objects for tracking debug information.

	You may register an optional cancellation hook by using the `onCancel` argument:

	* This should be used to abort any ongoing operations leading up to the promise being settled.
	* Call the `onCancel` function with a function callback as its only argument to set a hook which will in turn be called when/if the promise is cancelled.
	* `onCancel` returns `true` if the Promise was already cancelled when you called `onCancel`.
	* Calling `onCancel` with no argument will not override a previously set cancellation hook, but it will still return `true` if the Promise is currently cancelled.
	* You can set the cancellation hook at any time before resolving.
	* When a promise is cancelled, calls to `resolve` or `reject` will be ignored, regardless of if you set a cancellation hook or not.

	:::caution
	If the Promise is cancelled, the `executor` thread is closed with `coroutine.close` after the cancellation hook is called.

	You must perform any cleanup code in the cancellation hook: any time your executor yields, it **may never resume**.
	:::

	@param executor (resolve: (...: any) -> (), reject: (...: any) -> (), onCancel: (abortHandler?: () -> ()) -> boolean) -> ()
	@return Promise
]=]
function Promise.new(executor)
	return Promise._new(debug.traceback(nil, 2), executor)
end

function Promise:__tostring()
	return string.format("Promise(%s)", self._status)
end

--[=[
	The same as [Promise.new](/api/Promise#new), except execution begins after the next `Heartbeat` event.

	This is a spiritual replacement for `spawn`, but it does not suffer from the same [issues](https://eryn.io/gist/3db84579866c099cdd5bb2ff37947cec) as `spawn`.

	```lua
	local function waitForChild(instance, childName, timeout)
	  return Promise.defer(function(resolve, reject)
		local child = instance:WaitForChild(childName, timeout)

		;(child and resolve or reject)(child)
	  end)
	end
	```

	@param executor (resolve: (...: any) -> (), reject: (...: any) -> (), onCancel: (abortHandler?: () -> ()) -> boolean) -> ()
	@return Promise
]=]
function Promise.defer(executor)
	local traceback = debug.traceback(nil, 2)
	local promise
	promise = Promise._new(traceback, function(resolve, reject, onCancel)
		local connection
		connection = Promise._timeEvent:Connect(function()
			connection:Disconnect()
			local ok, _, result = runExecutor(traceback, executor, resolve, reject, onCancel)

			if not ok then
				reject(result[1])
			end
		end)
	end)

	return promise
end

-- Backwards compatibility
Promise.async = Promise.defer

--[=[
	Creates an immediately resolved Promise with the given value.

	```lua
	-- Example using Promise.resolve to deliver cached values:
	function getSomething(name)
		if cache[name] then
			return Promise.resolve(cache[name])
		else
			return Promise.new(function(resolve, reject)
				local thing = getTheThing()
				cache[name] = thing

				resolve(thing)
			end)
		end
	end
	```

	@param ... any
	@return Promise<...any>
]=]
function Promise.resolve(...)
	local length, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(resolve)
		resolve(unpack(values, 1, length))
	end)
end

--[=[
	Creates an immediately rejected Promise with the given value.

	:::caution
	Something needs to consume this rejection (i.e. `:catch()` it), otherwise it will emit an unhandled Promise rejection warning on the next frame. Thus, you should not create and store rejected Promises for later use. Only create them on-demand as needed.
	:::

	@param ... any
	@return Promise<...any>
]=]
function Promise.reject(...)
	local length, values = pack(...)
	return Promise._new(debug.traceback(nil, 2), function(_, reject)
		reject(unpack(values, 1, length))
	end)
end

--[[
	Runs a non-promise-returning function as a Promise with the
  given arguments.
]]
function Promise._try(traceback, callback, ...)
	local valuesLength, values = pack(...)

	return Promise._new(traceback, function(resolve)
		resolve(callback(unpack(values, 1, valuesLength)))
	end)
end

--[=[
	Begins a Promise chain, calling a function and returning a Promise resolving with its return value. If the function errors, the returned Promise will be rejected with the error. You can safely yield within the Promise.try callback.

	:::info
	`Promise.try` is similar to [Promise.promisify](#promisify), except the callback is invoked immediately instead of returning a new function.
	:::

	```lua
	Promise.try(function()
		return math.random(1, 2) == 1 and "ok" or error("Oh an error!")
	end)
		:andThen(function(text)
			print(text)
		end)
		:catch(function(err)
			warn("Something went wrong")
		end)
	```

	@param callback (...: T...) -> ...any
	@param ... T... -- Additional arguments passed to `callback`
	@return Promise
]=]
function Promise.try(callback, ...)
	return Promise._try(debug.traceback(nil, 2), callback, ...)
end

--[[
	Returns a new promise that:
		* is resolved when all input promises resolve
		* is rejected if ANY input promises reject
]]
function Promise._all(traceback, promises, amount)
	if type(promises) ~= "table" then
		error(string.format(ERROR_NON_LIST, "Promise.all"), 3)
	end

	-- We need to check that each value is a promise here so that we can produce
	-- a proper error rather than a rejected promise with our error.
	for i, promise in pairs(promises) do
		if not Promise.is(promise) then
			error(string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.all", tostring(i)), 3)
		end
	end

	-- If there are no values then return an already resolved promise.
	if #promises == 0 or amount == 0 then
		return Promise.resolve({})
	end

	return Promise._new(traceback, function(resolve, reject, onCancel)
		-- An array to contain our resolved values from the given promises.
		local resolvedValues = {}
		local newPromises = {}

		-- Keep a count of resolved promises because just checking the resolved
		-- values length wouldn't account for promises that resolve with nil.
		local resolvedCount = 0
		local rejectedCount = 0
		local done = false

		local function cancel()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end

		-- Called when a single value is resolved and resolves if all are done.
		local function resolveOne(i, ...)
			if done then
				return
			end

			resolvedCount = resolvedCount + 1

			if amount == nil then
				resolvedValues[i] = ...
			else
				resolvedValues[resolvedCount] = ...
			end

			if resolvedCount >= (amount or #promises) then
				done = true
				resolve(resolvedValues)
				cancel()
			end
		end

		onCancel(cancel)

		-- We can assume the values inside `promises` are all promises since we
		-- checked above.
		for i, promise in ipairs(promises) do
			newPromises[i] = promise:andThen(function(...)
				resolveOne(i, ...)
			end, function(...)
				rejectedCount = rejectedCount + 1

				if amount == nil or #promises - rejectedCount < amount then
					cancel()
					done = true

					reject(...)
				end
			end)
		end

		if done then
			cancel()
		end
	end)
end

--[=[
	Accepts an array of Promises and returns a new promise that:
	* is resolved after all input promises resolve.
	* is rejected if *any* input promises reject.

	:::info
	Only the first return value from each promise will be present in the resulting array.
	:::

	After any input Promise rejects, all other input Promises that are still pending will be cancelled if they have no other consumers.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.all(promises)
	```

	@param promises {Promise<T>}
	@return Promise<{T}>
]=]
function Promise.all(promises)
	return Promise._all(debug.traceback(nil, 2), promises)
end

--[=[
	Folds an array of values or promises into a single value. The array is traversed sequentially.

	The reducer function can return a promise or value directly. Each iteration receives the resolved value from the previous, and the first receives your defined initial value.

	The folding will stop at the first rejection encountered.
	```lua
	local basket = {"blueberry", "melon", "pear", "melon"}
	Promise.fold(basket, function(cost, fruit)
		if fruit == "blueberry" then
			return cost -- blueberries are free!
		else
			-- call a function that returns a promise with the fruit price
			return fetchPrice(fruit):andThen(function(fruitCost)
				return cost + fruitCost
			end)
		end
	end, 0)
	```

	@since v3.1.0
	@param list {T | Promise<T>}
	@param reducer (accumulator: U, value: T, index: number) -> U | Promise<U>
	@param initialValue U
]=]
function Promise.fold(list, reducer, initialValue)
	assert(type(list) == "table", "Bad argument #1 to Promise.fold: must be a table")
	assert(isCallable(reducer), "Bad argument #2 to Promise.fold: must be a function")

	local accumulator = Promise.resolve(initialValue)
	return Promise.each(list, function(resolvedElement, i)
		accumulator = accumulator:andThen(function(previousValueResolved)
			return reducer(previousValueResolved, resolvedElement, i)
		end)
	end):andThen(function()
		return accumulator
	end)
end

--[=[
	Accepts an array of Promises and returns a Promise that is resolved as soon as `count` Promises are resolved from the input array. The resolved array values are in the order that the Promises resolved in. When this Promise resolves, all other pending Promises are cancelled if they have no other consumers.

	`count` 0 results in an empty array. The resultant array will never have more than `count` elements.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.some(promises, 2) -- Only resolves with first 2 promises to resolve
	```

	@param promises {Promise<T>}
	@param count number
	@return Promise<{T}>
]=]
function Promise.some(promises, count)
	assert(type(count) == "number", "Bad argument #2 to Promise.some: must be a number")

	return Promise._all(debug.traceback(nil, 2), promises, count)
end

--[=[
	Accepts an array of Promises and returns a Promise that is resolved as soon as *any* of the input Promises resolves. It will reject only if *all* input Promises reject. As soon as one Promises resolves, all other pending Promises are cancelled if they have no other consumers.

	Resolves directly with the value of the first resolved Promise. This is essentially [[Promise.some]] with `1` count, except the Promise resolves with the value directly instead of an array with one element.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.any(promises) -- Resolves with first value to resolve (only rejects if all 3 rejected)
	```

	@param promises {Promise<T>}
	@return Promise<T>
]=]
function Promise.any(promises)
	return Promise._all(debug.traceback(nil, 2), promises, 1):andThen(function(values)
		return values[1]
	end)
end

--[=[
	Accepts an array of Promises and returns a new Promise that resolves with an array of in-place Statuses when all input Promises have settled. This is equivalent to mapping `promise:finally` over the array of Promises.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.allSettled(promises)
	```

	@param promises {Promise<T>}
	@return Promise<{Status}>
]=]
function Promise.allSettled(promises)
	if type(promises) ~= "table" then
		error(string.format(ERROR_NON_LIST, "Promise.allSettled"), 2)
	end

	-- We need to check that each value is a promise here so that we can produce
	-- a proper error rather than a rejected promise with our error.
	for i, promise in pairs(promises) do
		if not Promise.is(promise) then
			error(string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.allSettled", tostring(i)), 2)
		end
	end

	-- If there are no values then return an already resolved promise.
	if #promises == 0 then
		return Promise.resolve({})
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
		-- An array to contain our resolved values from the given promises.
		local fates = {}
		local newPromises = {}

		-- Keep a count of resolved promises because just checking the resolved
		-- values length wouldn't account for promises that resolve with nil.
		local finishedCount = 0

		-- Called when a single value is resolved and resolves if all are done.
		local function resolveOne(i, ...)
			finishedCount = finishedCount + 1

			fates[i] = ...

			if finishedCount >= #promises then
				resolve(fates)
			end
		end

		onCancel(function()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end)

		-- We can assume the values inside `promises` are all promises since we
		-- checked above.
		for i, promise in ipairs(promises) do
			newPromises[i] = promise:finally(function(...)
				resolveOne(i, ...)
			end)
		end
	end)
end

--[=[
	Accepts an array of Promises and returns a new promise that is resolved or rejected as soon as any Promise in the array resolves or rejects.

	:::warning
	If the first Promise to settle from the array settles with a rejection, the resulting Promise from `race` will reject.

	If you instead want to tolerate rejections, and only care about at least one Promise resolving, you should use [Promise.any](#any) or [Promise.some](#some) instead.
	:::

	All other Promises that don't win the race will be cancelled if they have no other consumers.

	```lua
	local promises = {
		returnsAPromise("example 1"),
		returnsAPromise("example 2"),
		returnsAPromise("example 3"),
	}

	return Promise.race(promises) -- Only returns 1st value to resolve or reject
	```

	@param promises {Promise<T>}
	@return Promise<T>
]=]
function Promise.race(promises)
	assert(type(promises) == "table", string.format(ERROR_NON_LIST, "Promise.race"))

	for i, promise in pairs(promises) do
		assert(Promise.is(promise), string.format(ERROR_NON_PROMISE_IN_LIST, "Promise.race", tostring(i)))
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local newPromises = {}
		local finished = false

		local function cancel()
			for _, promise in ipairs(newPromises) do
				promise:cancel()
			end
		end

		local function finalize(callback)
			return function(...)
				cancel()
				finished = true
				return callback(...)
			end
		end

		if onCancel(finalize(reject)) then
			return
		end

		for i, promise in ipairs(promises) do
			newPromises[i] = promise:andThen(finalize(resolve), finalize(reject))
		end

		if finished then
			cancel()
		end
	end)
end

--[=[
	Iterates serially over the given an array of values, calling the predicate callback on each value before continuing.

	If the predicate returns a Promise, we wait for that Promise to resolve before moving on to the next item
	in the array.

	:::info
	`Promise.each` is similar to `Promise.all`, except the Promises are ran in order instead of all at once.

	But because Promises are eager, by the time they are created, they're already running. Thus, we need a way to defer creation of each Promise until a later time.

	The predicate function exists as a way for us to operate on our data instead of creating a new closure for each Promise. If you would prefer, you can pass in an array of functions, and in the predicate, call the function and return its return value.
	:::

	```lua
	Promise.each({
		"foo",
		"bar",
		"baz",
		"qux"
	}, function(value, index)
		return Promise.delay(1):andThen(function()
		print(("%d) Got %s!"):format(index, value))
		end)
	end)

	--[[
		(1 second passes)
		> 1) Got foo!
		(1 second passes)
		> 2) Got bar!
		(1 second passes)
		> 3) Got baz!
		(1 second passes)
		> 4) Got qux!
	]]
	```

	If the Promise a predicate returns rejects, the Promise from `Promise.each` is also rejected with the same value.

	If the array of values contains a Promise, when we get to that point in the list, we wait for the Promise to resolve before calling the predicate with the value.

	If a Promise in the array of values is already Rejected when `Promise.each` is called, `Promise.each` rejects with that value immediately (the predicate callback will never be called even once). If a Promise in the list is already Cancelled when `Promise.each` is called, `Promise.each` rejects with `Promise.Error(Promise.Error.Kind.AlreadyCancelled`). If a Promise in the array of values is Started at first, but later rejects, `Promise.each` will reject with that value and iteration will not continue once iteration encounters that value.

	Returns a Promise containing an array of the returned/resolved values from the predicate for each item in the array of values.

	If this Promise returned from `Promise.each` rejects or is cancelled for any reason, the following are true:
	- Iteration will not continue.
	- Any Promises within the array of values will now be cancelled if they have no other consumers.
	- The Promise returned from the currently active predicate will be cancelled if it hasn't resolved yet.

	@since 3.0.0
	@param list {T | Promise<T>}
	@param predicate (value: T, index: number) -> U | Promise<U>
	@return Promise<{U}>
]=]
function Promise.each(list, predicate)
	assert(type(list) == "table", string.format(ERROR_NON_LIST, "Promise.each"))
	assert(isCallable(predicate), string.format(ERROR_NON_FUNCTION, "Promise.each"))

	return Promise._new(debug.traceback(nil, 2), function(resolve, reject, onCancel)
		local results = {}
		local promisesToCancel = {}

		local cancelled = false

		local function cancel()
			for _, promiseToCancel in ipairs(promisesToCancel) do
				promiseToCancel:cancel()
			end
		end

		onCancel(function()
			cancelled = true

			cancel()
		end)

		-- We need to preprocess the list of values and look for Promises.
		-- If we find some, we must register our andThen calls now, so that those Promises have a consumer
		-- from us registered. If we don't do this, those Promises might get cancelled by something else
		-- before we get to them in the series because it's not possible to tell that we plan to use it
		-- unless we indicate it here.

		local preprocessedList = {}

		for index, value in ipairs(list) do
			if Promise.is(value) then
				if value:getStatus() == Promise.Status.Cancelled then
					cancel()
					return reject(Error.new({
						error = "Promise is cancelled",
						kind = Error.Kind.AlreadyCancelled,
						context = string.format(
							"The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s",
							index,
							value._source
						),
					}))
				elseif value:getStatus() == Promise.Status.Rejected then
					cancel()
					return reject(select(2, value:await()))
				end

				-- Chain a new Promise from this one so we only cancel ours
				local ourPromise = value:andThen(function(...)
					return ...
				end)

				table.insert(promisesToCancel, ourPromise)
				preprocessedList[index] = ourPromise
			else
				preprocessedList[index] = value
			end
		end

		for index, value in ipairs(preprocessedList) do
			if Promise.is(value) then
				local success
				success, value = value:await()

				if not success then
					cancel()
					return reject(value)
				end
			end

			if cancelled then
				return
			end

			local predicatePromise = Promise.resolve(predicate(value, index))

			table.insert(promisesToCancel, predicatePromise)

			local success, result = predicatePromise:await()

			if not success then
				cancel()
				return reject(result)
			end

			results[index] = result
		end

		resolve(results)
	end)
end

--[=[
	Checks whether the given object is a Promise via duck typing. This only checks if the object is a table and has an `andThen` method.

	@param object any
	@return boolean -- `true` if the given `object` is a Promise.
]=]
function Promise.is(object)
	if type(object) ~= "table" then
		return false
	end

	local objectMetatable = getmetatable(object)

	if objectMetatable == Promise then
		-- The Promise came from this library.
		return true
	elseif objectMetatable == nil then
		-- No metatable, but we should still chain onto tables with andThen methods
		return isCallable(object.andThen)
	elseif
		type(objectMetatable) == "table"
		and type(rawget(objectMetatable, "__index")) == "table"
		and isCallable(rawget(rawget(objectMetatable, "__index"), "andThen"))
	then
		-- Maybe this came from a different or older Promise library.
		return true
	end

	return false
end

--[=[
	Wraps a function that yields into one that returns a Promise.

	Any errors that occur while executing the function will be turned into rejections.

	:::info
	`Promise.promisify` is similar to [Promise.try](#try), except the callback is returned as a callable function instead of being invoked immediately.
	:::

	```lua
	local sleep = Promise.promisify(wait)

	sleep(1):andThen(print)
	```

	```lua
	local isPlayerInGroup = Promise.promisify(function(player, groupId)
		return player:IsInGroup(groupId)
	end)
	```

	@param callback (...: any) -> ...any
	@return (...: any) -> Promise
]=]
function Promise.promisify(callback)
	return function(...)
		return Promise._try(debug.traceback(nil, 2), callback, ...)
	end
end

--[=[
	Returns a Promise that resolves after `seconds` seconds have passed. The Promise resolves with the actual amount of time that was waited.

	This function is **not** a wrapper around `wait`. `Promise.delay` uses a custom scheduler which provides more accurate timing. As an optimization, cancelling this Promise instantly removes the task from the scheduler.

	:::warning
	Passing `NaN`, infinity, or a number less than 1/60 is equivalent to passing 1/60.
	:::

	```lua
		Promise.delay(5):andThenCall(print, "This prints after 5 seconds")
	```

	@function delay
	@within Promise
	@param seconds number
	@return Promise<number>
]=]
do
	-- uses a sorted doubly linked list (queue) to achieve O(1) remove operations and O(n) for insert

	-- the initial node in the linked list
	local first
	local connection

	function Promise.delay(seconds)
		assert(type(seconds) == "number", "Bad argument #1 to Promise.delay, must be a number.")
		-- If seconds is -INF, INF, NaN, or less than 1 / 60, assume seconds is 1 / 60.
		-- This mirrors the behavior of wait()
		if not (seconds >= 1 / 60) or seconds == math.huge then
			seconds = 1 / 60
		end

		return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
			local startTime = Promise._getTime()
			local endTime = startTime + seconds

			local node = {
				resolve = resolve,
				startTime = startTime,
				endTime = endTime,
			}

			if connection == nil then -- first is nil when connection is nil
				first = node
				connection = Promise._timeEvent:Connect(function()
					local threadStart = Promise._getTime()

					while first ~= nil and first.endTime < threadStart do
						local current = first
						first = current.next

						if first == nil then
							connection:Disconnect()
							connection = nil
						else
							first.previous = nil
						end

						current.resolve(Promise._getTime() - current.startTime)
					end
				end)
			else -- first is non-nil
				if first.endTime < endTime then -- if `node` should be placed after `first`
					-- we will insert `node` between `current` and `next`
					-- (i.e. after `current` if `next` is nil)
					local current = first
					local next = current.next

					while next ~= nil and next.endTime < endTime do
						current = next
						next = current.next
					end

					-- `current` must be non-nil, but `next` could be `nil` (i.e. last item in list)
					current.next = node
					node.previous = current

					if next ~= nil then
						node.next = next
						next.previous = node
					end
				else
					-- set `node` to `first`
					node.next = first
					first.previous = node
					first = node
				end
			end

			onCancel(function()
				-- remove node from queue
				local next = node.next

				if first == node then
					if next == nil then -- if `node` is the first and last
						connection:Disconnect()
						connection = nil
					else -- if `node` is `first` and not the last
						next.previous = nil
					end
					first = next
				else
					local previous = node.previous
					-- since `node` is not `first`, then we know `previous` is non-nil
					previous.next = next

					if next ~= nil then
						next.previous = previous
					end
				end
			end)
		end)
	end
end

--[=[
	Returns a new Promise that resolves if the chained Promise resolves within `seconds` seconds, or rejects if execution time exceeds `seconds`. The chained Promise will be cancelled if the timeout is reached.

	Rejects with `rejectionValue` if it is non-nil. If a `rejectionValue` is not given, it will reject with a `Promise.Error(Promise.Error.Kind.TimedOut)`. This can be checked with [[Error.isKind]].

	```lua
	getSomething():timeout(5):andThen(function(something)
		-- got something and it only took at max 5 seconds
	end):catch(function(e)
		-- Either getting something failed or the time was exceeded.

		if Promise.Error.isKind(e, Promise.Error.Kind.TimedOut) then
			warn("Operation timed out!")
		else
			warn("Operation encountered an error!")
		end
	end)
	```

	Sugar for:

	```lua
	Promise.race({
		Promise.delay(seconds):andThen(function()
			return Promise.reject(
				rejectionValue == nil
				and Promise.Error.new({ kind = Promise.Error.Kind.TimedOut })
				or rejectionValue
			)
		end),
		promise
	})
	```

	@param seconds number
	@param rejectionValue? any -- The value to reject with if the timeout is reached
	@return Promise
]=]
function Promise.prototype:timeout(seconds, rejectionValue)
	local traceback = debug.traceback(nil, 2)

	return Promise.race({
		Promise.delay(seconds):andThen(function()
			return Promise.reject(rejectionValue == nil and Error.new({
				kind = Error.Kind.TimedOut,
				error = "Timed out",
				context = string.format(
					"Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s",
					seconds,
					traceback
				),
			}) or rejectionValue)
		end),
		self,
	})
end

--[=[
	Returns the current Promise status.

	@return Status
]=]
function Promise.prototype:getStatus()
	return self._status
end

--[[
	Creates a new promise that receives the result of this promise.

	The given callbacks are invoked depending on that result.
]]
function Promise.prototype:_andThen(traceback, successHandler, failureHandler)
	self._unhandledRejection = false

	-- If we are already cancelled, we return a cancelled Promise
	if self._status == Promise.Status.Cancelled then
		local promise = Promise.new(function() end)
		promise:cancel()

		return promise
	end

	-- Create a new promise to follow this part of the chain
	return Promise._new(traceback, function(resolve, reject, onCancel)
		-- Our default callbacks just pass values onto the next promise.
		-- This lets success and failure cascade correctly!

		local successCallback = resolve
		if successHandler then
			successCallback = createAdvancer(traceback, successHandler, resolve, reject)
		end

		local failureCallback = reject
		if failureHandler then
			failureCallback = createAdvancer(traceback, failureHandler, resolve, reject)
		end

		if self._status == Promise.Status.Started then
			-- If we haven't resolved yet, put ourselves into the queue
			table.insert(self._queuedResolve, successCallback)
			table.insert(self._queuedReject, failureCallback)

			onCancel(function()
				-- These are guaranteed to exist because the cancellation handler is guaranteed to only
				-- be called at most once
				if self._status == Promise.Status.Started then
					table.remove(self._queuedResolve, table.find(self._queuedResolve, successCallback))
					table.remove(self._queuedReject, table.find(self._queuedReject, failureCallback))
				end
			end)
		elseif self._status == Promise.Status.Resolved then
			-- This promise has already resolved! Trigger success immediately.
			successCallback(unpack(self._values, 1, self._valuesLength))
		elseif self._status == Promise.Status.Rejected then
			-- This promise died a terrible death! Trigger failure immediately.
			failureCallback(unpack(self._values, 1, self._valuesLength))
		end
	end, self)
end

--[=[
	Chains onto an existing Promise and returns a new Promise.

	:::warning
	Within the failure handler, you should never assume that the rejection value is a string. Some rejections within the Promise library are represented by [[Error]] objects. If you want to treat it as a string for debugging, you should call `tostring` on it first.
	:::

	You can return a Promise from the success or failure handler and it will be chained onto.

	Calling `andThen` on a cancelled Promise returns a cancelled Promise.

	:::tip
	If the Promise returned by `andThen` is cancelled, `successHandler` and `failureHandler` will not run.

	To run code no matter what, use [Promise:finally].
	:::

	@param successHandler (...: any) -> ...any
	@param failureHandler? (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:andThen(successHandler, failureHandler)
	assert(successHandler == nil or isCallable(successHandler), string.format(ERROR_NON_FUNCTION, "Promise:andThen"))
	assert(failureHandler == nil or isCallable(failureHandler), string.format(ERROR_NON_FUNCTION, "Promise:andThen"))

	return self:_andThen(debug.traceback(nil, 2), successHandler, failureHandler)
end

--[=[
	Shorthand for `Promise:andThen(nil, failureHandler)`.

	Returns a Promise that resolves if the `failureHandler` worked without encountering an additional error.

	:::warning
	Within the failure handler, you should never assume that the rejection value is a string. Some rejections within the Promise library are represented by [[Error]] objects. If you want to treat it as a string for debugging, you should call `tostring` on it first.
	:::

	Calling `catch` on a cancelled Promise returns a cancelled Promise.

	:::tip
	If the Promise returned by `catch` is cancelled,  `failureHandler` will not run.

	To run code no matter what, use [Promise:finally].
	:::

	@param failureHandler (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:catch(failureHandler)
	assert(failureHandler == nil or isCallable(failureHandler), string.format(ERROR_NON_FUNCTION, "Promise:catch"))
	return self:_andThen(debug.traceback(nil, 2), nil, failureHandler)
end

--[=[
	Similar to [Promise.andThen](#andThen), except the return value is the same as the value passed to the handler. In other words, you can insert a `:tap` into a Promise chain without affecting the value that downstream Promises receive.

	```lua
		getTheValue()
		:tap(print)
		:andThen(function(theValue)
			print("Got", theValue, "even though print returns nil!")
		end)
	```

	If you return a Promise from the tap handler callback, its value will be discarded but `tap` will still wait until it resolves before passing the original value through.

	@param tapHandler (...: any) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:tap(tapHandler)
	assert(isCallable(tapHandler), string.format(ERROR_NON_FUNCTION, "Promise:tap"))
	return self:_andThen(debug.traceback(nil, 2), function(...)
		local callbackReturn = tapHandler(...)

		if Promise.is(callbackReturn) then
			local length, values = pack(...)
			return callbackReturn:andThen(function()
				return unpack(values, 1, length)
			end)
		end

		return ...
	end)
end

--[=[
	Attaches an `andThen` handler to this Promise that calls the given callback with the predefined arguments. The resolved value is discarded.

	```lua
		promise:andThenCall(someFunction, "some", "arguments")
	```

	This is sugar for

	```lua
		promise:andThen(function()
		return someFunction("some", "arguments")
		end)
	```

	@param callback (...: any) -> any
	@param ...? any -- Additional arguments which will be passed to `callback`
	@return Promise
]=]
function Promise.prototype:andThenCall(callback, ...)
	assert(isCallable(callback), string.format(ERROR_NON_FUNCTION, "Promise:andThenCall"))
	local length, values = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return callback(unpack(values, 1, length))
	end)
end

--[=[
	Attaches an `andThen` handler to this Promise that discards the resolved value and returns the given value from it.

	```lua
		promise:andThenReturn("some", "values")
	```

	This is sugar for

	```lua
		promise:andThen(function()
			return "some", "values"
		end)
	```

	:::caution
	Promises are eager, so if you pass a Promise to `andThenReturn`, it will begin executing before `andThenReturn` is reached in the chain. Likewise, if you pass a Promise created from [[Promise.reject]] into `andThenReturn`, it's possible that this will trigger the unhandled rejection warning. If you need to return a Promise, it's usually best practice to use [[Promise.andThen]].
	:::

	@param ... any -- Values to return from the function
	@return Promise
]=]
function Promise.prototype:andThenReturn(...)
	local length, values = pack(...)
	return self:_andThen(debug.traceback(nil, 2), function()
		return unpack(values, 1, length)
	end)
end

--[=[
	Cancels this promise, preventing the promise from resolving or rejecting. Does not do anything if the promise is already settled.

	Cancellations will propagate upwards and downwards through chained promises.

	Promises will only be cancelled if all of their consumers are also cancelled. This is to say that if you call `andThen` twice on the same promise, and you cancel only one of the child promises, it will not cancel the parent promise until the other child promise is also cancelled.

	```lua
		promise:cancel()
	```
]=]
function Promise.prototype:cancel()
	if self._status ~= Promise.Status.Started then
		return
	end

	self._status = Promise.Status.Cancelled

	if self._cancellationHook then
		self._cancellationHook()
	end

	coroutine.close(self._thread)

	if self._parent then
		self._parent:_consumerCancelled(self)
	end

	for child in pairs(self._consumers) do
		child:cancel()
	end

	self:_finalize()
end

--[[
	Used to decrease the number of consumers by 1, and if there are no more,
	cancel this promise.
]]
function Promise.prototype:_consumerCancelled(consumer)
	if self._status ~= Promise.Status.Started then
		return
	end

	self._consumers[consumer] = nil

	if next(self._consumers) == nil then
		self:cancel()
	end
end

--[[
	Used to set a handler for when the promise resolves, rejects, or is
	cancelled.
]]
function Promise.prototype:_finally(traceback, finallyHandler)
	self._unhandledRejection = false

	local promise = Promise._new(traceback, function(resolve, reject, onCancel)
		local handlerPromise

		onCancel(function()
			-- The finally Promise is not a proper consumer of self. We don't care about the resolved value.
			-- All we care about is running at the end. Therefore, if self has no other consumers, it's safe to
			-- cancel. We don't need to hold out cancelling just because there's a finally handler.
			self:_consumerCancelled(self)

			if handlerPromise then
				handlerPromise:cancel()
			end
		end)

		local finallyCallback = resolve
		if finallyHandler then
			finallyCallback = function(...)
				local callbackReturn = finallyHandler(...)

				if Promise.is(callbackReturn) then
					handlerPromise = callbackReturn

					callbackReturn
						:finally(function(status)
							if status ~= Promise.Status.Rejected then
								resolve(self)
							end
						end)
						:catch(function(...)
							reject(...)
						end)
				else
					resolve(self)
				end
			end
		end

		if self._status == Promise.Status.Started then
			-- The promise is not settled, so queue this.
			table.insert(self._queuedFinally, finallyCallback)
		else
			-- The promise already settled or was cancelled, run the callback now.
			finallyCallback(self._status)
		end
	end)

	return promise
end

--[=[
	Set a handler that will be called regardless of the promise's fate. The handler is called when the promise is
	resolved, rejected, *or* cancelled.

	Returns a new Promise that:
	- resolves with the same values that this Promise resolves with.
	- rejects with the same values that this Promise rejects with.
	- is cancelled if this Promise is cancelled.

	If the value you return from the handler is a Promise:
	- We wait for the Promise to resolve, but we ultimately discard the resolved value.
	- If the returned Promise rejects, the Promise returned from `finally` will reject with the rejected value from the
	*returned* promise.
	- If the `finally` Promise is cancelled, and you returned a Promise from the handler, we cancel that Promise too.

	Otherwise, the return value from the `finally` handler is entirely discarded.

	:::note Cancellation
	As of Promise v4, `Promise:finally` does not count as a consumer of the parent Promise for cancellation purposes.
	This means that if all of a Promise's consumers are cancelled and the only remaining callbacks are finally handlers,
	the Promise is cancelled and the finally callbacks run then and there.

	Cancellation still propagates through the `finally` Promise though: if you cancel the `finally` Promise, it can cancel
	its parent Promise if it had no other consumers. Likewise, if the parent Promise is cancelled, the `finally` Promise
	will also be cancelled.
	:::

	```lua
	local thing = createSomething()

	doSomethingWith(thing)
		:andThen(function()
			print("It worked!")
			-- do something..
		end)
		:catch(function()
			warn("Oh no it failed!")
		end)
		:finally(function()
			-- either way, destroy thing

			thing:Destroy()
		end)

	```

	@param finallyHandler (status: Status) -> ...any
	@return Promise<...any>
]=]
function Promise.prototype:finally(finallyHandler)
	assert(finallyHandler == nil or isCallable(finallyHandler), string.format(ERROR_NON_FUNCTION, "Promise:finally"))
	return self:_finally(debug.traceback(nil, 2), finallyHandler)
end

--[=[
	Same as `andThenCall`, except for `finally`.

	Attaches a `finally` handler to this Promise that calls the given callback with the predefined arguments.

	@param callback (...: any) -> any
	@param ...? any -- Additional arguments which will be passed to `callback`
	@return Promise
]=]
function Promise.prototype:finallyCall(callback, ...)
	assert(isCallable(callback), string.format(ERROR_NON_FUNCTION, "Promise:finallyCall"))
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return callback(unpack(values, 1, length))
	end)
end

--[=[
	Attaches a `finally` handler to this Promise that discards the resolved value and returns the given value from it.

	```lua
		promise:finallyReturn("some", "values")
	```

	This is sugar for

	```lua
		promise:finally(function()
			return "some", "values"
		end)
	```

	@param ... any -- Values to return from the function
	@return Promise
]=]
function Promise.prototype:finallyReturn(...)
	local length, values = pack(...)
	return self:_finally(debug.traceback(nil, 2), function()
		return unpack(values, 1, length)
	end)
end

--[=[
	Yields the current thread until the given Promise completes. Returns the Promise's status, followed by the values that the promise resolved or rejected with.

	@yields
	@return Status -- The Status representing the fate of the Promise
	@return ...any -- The values the Promise resolved or rejected with.
]=]
function Promise.prototype:awaitStatus()
	self._unhandledRejection = false

	if self._status == Promise.Status.Started then
		local thread = coroutine.running()

		self
			:finally(function()
				task.spawn(thread)
			end)
			-- The finally promise can propagate rejections, so we attach a catch handler to prevent the unhandled
			-- rejection warning from appearing
			:catch(
				function() end
			)

		coroutine.yield()
	end

	if self._status == Promise.Status.Resolved then
		return self._status, unpack(self._values, 1, self._valuesLength)
	elseif self._status == Promise.Status.Rejected then
		return self._status, unpack(self._values, 1, self._valuesLength)
	end

	return self._status
end

local function awaitHelper(status, ...)
	return status == Promise.Status.Resolved, ...
end

--[=[
	Yields the current thread until the given Promise completes. Returns true if the Promise resolved, followed by the values that the promise resolved or rejected with.

	:::caution
	If the Promise gets cancelled, this function will return `false`, which is indistinguishable from a rejection. If you need to differentiate, you should use [[Promise.awaitStatus]] instead.
	:::

	```lua
		local worked, value = getTheValue():await()

	if worked then
		print("got", value)
	else
		warn("it failed")
	end
	```

	@yields
	@return boolean -- `true` if the Promise successfully resolved
	@return ...any -- The values the Promise resolved or rejected with.
]=]
function Promise.prototype:await()
	return awaitHelper(self:awaitStatus())
end

local function expectHelper(status, ...)
	if status ~= Promise.Status.Resolved then
		error((...) == nil and "Expected Promise rejected with no value." or (...), 3)
	end

	return ...
end

--[=[
	Yields the current thread until the given Promise completes. Returns the values that the promise resolved with.

	```lua
	local worked = pcall(function()
		print("got", getTheValue():expect())
	end)

	if not worked then
		warn("it failed")
	end
	```

	This is essentially sugar for:

	```lua
	select(2, assert(promise:await()))
	```

	**Errors** if the Promise rejects or gets cancelled.

	@error any -- Errors with the rejection value if this Promise rejects or gets cancelled.
	@yields
	@return ...any -- The values the Promise resolved with.
]=]
function Promise.prototype:expect()
	return expectHelper(self:awaitStatus())
end

-- Backwards compatibility
Promise.prototype.awaitValue = Promise.prototype.expect

--[[
	Intended for use in tests.

	Similar to await(), but instead of yielding if the promise is unresolved,
	_unwrap will throw. This indicates an assumption that a promise has
	resolved.
]]
function Promise.prototype:_unwrap()
	if self._status == Promise.Status.Started then
		error("Promise has not resolved or rejected.", 2)
	end

	local success = self._status == Promise.Status.Resolved

	return success, unpack(self._values, 1, self._valuesLength)
end

function Promise.prototype:_resolve(...)
	if self._status ~= Promise.Status.Started then
		if Promise.is((...)) then
			(...):_consumerCancelled(self)
		end
		return
	end

	-- If the resolved value was a Promise, we chain onto it!
	if Promise.is((...)) then
		-- Without this warning, arguments sometimes mysteriously disappear
		if select("#", ...) > 1 then
			local message = string.format(
				"When returning a Promise from andThen, extra arguments are " .. "discarded! See:\n\n%s",
				self._source
			)
			warn(message)
		end

		local chainedPromise = ...

		local promise = chainedPromise:andThen(function(...)
			self:_resolve(...)
		end, function(...)
			local maybeRuntimeError = chainedPromise._values[1]

			-- Backwards compatibility < v2
			if chainedPromise._error then
				maybeRuntimeError = Error.new({
					error = chainedPromise._error,
					kind = Error.Kind.ExecutionError,
					context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
				})
			end

			if Error.isKind(maybeRuntimeError, Error.Kind.ExecutionError) then
				return self:_reject(maybeRuntimeError:extend({
					error = "This Promise was chained to a Promise that errored.",
					trace = "",
					context = string.format(
						"The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n",
						self._source
					),
				}))
			end

			self:_reject(...)
		end)

		if promise._status == Promise.Status.Cancelled then
			self:cancel()
		elseif promise._status == Promise.Status.Started then
			-- Adopt ourselves into promise for cancellation propagation.
			self._parent = promise
			promise._consumers[self] = true
		end

		return
	end

	self._status = Promise.Status.Resolved
	self._valuesLength, self._values = pack(...)

	-- We assume that these callbacks will not throw errors.
	for _, callback in ipairs(self._queuedResolve) do
		coroutine.wrap(callback)(...)
	end

	self:_finalize()
end

function Promise.prototype:_reject(...)
	if self._status ~= Promise.Status.Started then
		return
	end

	self._status = Promise.Status.Rejected
	self._valuesLength, self._values = pack(...)

	-- If there are any rejection handlers, call those!
	if not isEmpty(self._queuedReject) then
		-- We assume that these callbacks will not throw errors.
		for _, callback in ipairs(self._queuedReject) do
			coroutine.wrap(callback)(...)
		end
	else
		-- At this point, no one was able to observe the error.
		-- An error handler might still be attached if the error occurred
		-- synchronously. We'll wait one tick, and if there are still no
		-- observers, then we should put a message in the console.

		local err = tostring((...))

		coroutine.wrap(function()
			Promise._timeEvent:Wait()

			-- Someone observed the error, hooray!
			if not self._unhandledRejection then
				return
			end

			-- Build a reasonable message
			local message = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", err, self._source)

			for _, callback in ipairs(Promise._unhandledRejectionCallbacks) do
				task.spawn(callback, self, unpack(self._values, 1, self._valuesLength))
			end

			if Promise.TEST then
				-- Don't spam output when we're running tests.
				return
			end

			warn(message)
		end)()
	end

	self:_finalize()
end

--[[
	Calls any :finally handlers. We need this to be a separate method and
	queue because we must call all of the finally callbacks upon a success,
	failure, *and* cancellation.
]]
function Promise.prototype:_finalize()
	for _, callback in ipairs(self._queuedFinally) do
		-- Purposefully not passing values to callbacks here, as it could be the
		-- resolved values, or rejected errors. If the developer needs the values,
		-- they should use :andThen or :catch explicitly.
		coroutine.wrap(callback)(self._status)
	end

	self._queuedFinally = nil
	self._queuedReject = nil
	self._queuedResolve = nil

	-- Clear references to other Promises to allow gc
	if not Promise.TEST then
		self._parent = nil
		self._consumers = nil
	end

	task.defer(coroutine.close, self._thread)
end

--[=[
	Chains a Promise from this one that is resolved if this Promise is already resolved, and rejected if it is not resolved at the time of calling `:now()`. This can be used to ensure your `andThen` handler occurs on the same frame as the root Promise execution.

	```lua
	doSomething()
		:now()
		:andThen(function(value)
			print("Got", value, "synchronously.")
		end)
	```

	If this Promise is still running, Rejected, or Cancelled, the Promise returned from `:now()` will reject with the `rejectionValue` if passed, otherwise with a `Promise.Error(Promise.Error.Kind.NotResolvedInTime)`. This can be checked with [[Error.isKind]].

	@param rejectionValue? any -- The value to reject with if the Promise isn't resolved
	@return Promise
]=]
function Promise.prototype:now(rejectionValue)
	local traceback = debug.traceback(nil, 2)
	if self._status == Promise.Status.Resolved then
		return self:_andThen(traceback, function(...)
			return ...
		end)
	else
		return Promise.reject(rejectionValue == nil and Error.new({
			kind = Error.Kind.NotResolvedInTime,
			error = "This Promise was not resolved in time for :now()",
			context = ":now() was called at:\n\n" .. traceback,
		}) or rejectionValue)
	end
end

--[=[
	Repeatedly calls a Promise-returning function up to `times` number of times, until the returned Promise resolves.

	If the amount of retries is exceeded, the function will return the latest rejected Promise.

	```lua
	local function canFail(a, b, c)
		return Promise.new(function(resolve, reject)
			-- do something that can fail

			local failed, thing = doSomethingThatCanFail(a, b, c)

			if failed then
				reject("it failed")
			else
				resolve(thing)
			end
		end)
	end

	local MAX_RETRIES = 10
	local value = Promise.retry(canFail, MAX_RETRIES, "foo", "bar", "baz") -- args to send to canFail
	```

	@since 3.0.0
	@param callback (...: P) -> Promise<T>
	@param times number
	@param ...? P
	@return Promise<T>
]=]
function Promise.retry(callback, times, ...)
	assert(isCallable(callback), "Parameter #1 to Promise.retry must be a function")
	assert(type(times) == "number", "Parameter #2 to Promise.retry must be a number")

	local args, length = { ... }, select("#", ...)

	return Promise.resolve(callback(...)):catch(function(...)
		if times > 0 then
			return Promise.retry(callback, times - 1, unpack(args, 1, length))
		else
			return Promise.reject(...)
		end
	end)
end

--[=[
	Repeatedly calls a Promise-returning function up to `times` number of times, waiting `seconds` seconds between each
	retry, until the returned Promise resolves.

	If the amount of retries is exceeded, the function will return the latest rejected Promise.

	@since v3.2.0
	@param callback (...: P) -> Promise<T>
	@param times number
	@param seconds number
	@param ...? P
	@return Promise<T>
]=]
function Promise.retryWithDelay(callback, times, seconds, ...)
	assert(isCallable(callback), "Parameter #1 to Promise.retry must be a function")
	assert(type(times) == "number", "Parameter #2 (times) to Promise.retry must be a number")
	assert(type(seconds) == "number", "Parameter #3 (seconds) to Promise.retry must be a number")

	local args, length = { ... }, select("#", ...)

	return Promise.resolve(callback(...)):catch(function(...)
		if times > 0 then
			Promise.delay(seconds):await()

			return Promise.retryWithDelay(callback, times - 1, seconds, unpack(args, 1, length))
		else
			return Promise.reject(...)
		end
	end)
end

--[=[
	Converts an event into a Promise which resolves the next time the event fires.

	The optional `predicate` callback, if passed, will receive the event arguments and should return `true` or `false`, based on if this fired event should resolve the Promise or not. If `true`, the Promise resolves. If `false`, nothing happens and the predicate will be rerun the next time the event fires.

	The Promise will resolve with the event arguments.

	:::tip
	This function will work given any object with a `Connect` method. This includes all Roblox events.
	:::

	```lua
	-- Creates a Promise which only resolves when `somePart` is touched
	-- by a part named `"Something specific"`.
	return Promise.fromEvent(somePart.Touched, function(part)
		return part.Name == "Something specific"
	end)
	```

	@since 3.0.0
	@param event Event -- Any object with a `Connect` method. This includes all Roblox events.
	@param predicate? (...: P) -> boolean -- A function which determines if the Promise should resolve with the given value, or wait for the next event to check again.
	@return Promise<P>
]=]
function Promise.fromEvent(event, predicate)
	predicate = predicate or function()
		return true
	end

	return Promise._new(debug.traceback(nil, 2), function(resolve, _, onCancel)
		local connection
		local shouldDisconnect = false

		local function disconnect()
			connection:Disconnect()
			connection = nil
		end

		-- We use shouldDisconnect because if the callback given to Connect is called before
		-- Connect returns, connection will still be nil. This happens with events that queue up
		-- events when there's nothing connected, such as RemoteEvents

		connection = event:Connect(function(...)
			local callbackValue = predicate(...)

			if callbackValue == true then
				resolve(...)

				if connection then
					disconnect()
				else
					shouldDisconnect = true
				end
			elseif type(callbackValue) ~= "boolean" then
				error("Promise.fromEvent predicate should always return a boolean")
			end
		end)

		if shouldDisconnect and connection then
			return disconnect()
		end

		onCancel(disconnect)
	end)
end

--[=[
	Registers a callback that runs when an unhandled rejection happens. An unhandled rejection happens when a Promise
	is rejected, and the rejection is not observed with `:catch`.

	The callback is called with the actual promise that rejected, followed by the rejection values.

	@since v3.2.0
	@param callback (promise: Promise, ...: any) -- A callback that runs when an unhandled rejection happens.
	@return () -> () -- Function that unregisters the `callback` when called
]=]
function Promise.onUnhandledRejection(callback)
	table.insert(Promise._unhandledRejectionCallbacks, callback)

	return function()
		local index = table.find(Promise._unhandledRejectionCallbacks, callback)

		if index then
			table.remove(Promise._unhandledRejectionCallbacks, index)
		end
	end
end

return Promise

]==]

 

local u1 = {
    __mode = "k"
};

local function isCallable(p2) -- Line: 10
    if type(p2) == "function" then
        return true;
    end;

    local v3 = type(p2) == "table" and getmetatable(p2);

    if v3 then
        local v4 = rawget(v3, "__call");

        if type(v4) == "function" then
            return true;
        end;
    end;

    return false;
end;

local function makeEnum(u5, p6) -- Line: 28
    local v7 = {};

    for _, v in ipairs(p6) do
        v7[v] = v;
    end;

    return setmetatable(v7, {
        __index = function(p8, p9) -- Line: 36, Name: __index
            -- upvalues: u5 (copy)
            error(string.format("%s is not in %s!", p9, u5), 2);
        end,

        __newindex = function() -- Line: 39, Name: __newindex
            -- upvalues: u5 (copy)
            error(string.format("Creating new members in %s is not allowed!", u5), 2);
        end
    });
end;

local u10 = {
    Kind = makeEnum("Promise.Error.Kind", { "ExecutionError", "AlreadyCancelled", "NotResolvedInTime", "TimedOut" })
};
u10.__index = u10;

function u10.new(p11, p12) -- Line: 64
    -- upvalues: u10 (ref)
    local v13 = p11 or {};
    local v14 = {
        error = tostring(v13.error) or "[This error has no error text.]",
        trace = v13.trace,
        context = v13.context,
        kind = v13.kind,
        parent = p12,
        createdTick = os.clock(),
        createdTrace = debug.traceback()
    };

    return setmetatable(v14, u10);
end;

function u10.is(p15) -- Line: 77
    if type(p15) == "table" then
        local v16 = getmetatable(p15);

        if type(v16) == "table" then
            local v17;

            if rawget(p15, "error") == nil then
                v17 = false;
            else
                local v18 = rawget(v16, "extend");
                v17 = type(v18) == "function";
            end;

            return v17;
        end;
    end;

    return false;
end;

function u10.isKind(p19, p20) -- Line: 89
    -- upvalues: u10 (ref)
    assert(p20 ~= nil, "Argument #2 to Promise.Error.isKind must not be nil");
    local v21 = u10.is(p19) and p19.kind == p20;

    return v21;
end;

function u10.extend(p22, p23) -- Line: 95
    -- upvalues: u10 (ref)
    local v24 = p23 or {};
    v24.kind = v24.kind or p22.kind;

    return u10.new(v24, p22);
end;

function u10.getErrorChain(p25) -- Line: 103
    local v26 = { p25 };

    while v26[#v26].parent do
        table.insert(v26, v26[#v26].parent);
    end;

    return v26;
end;

function u10.__tostring(p27) -- Line: 113
    local v28 = { string.format("-- Promise.Error(%s) --", p27.kind or "?") };

    for _, v in ipairs(p27:getErrorChain()) do
        table.insert(v28, table.concat({ v.trace or v.error, v.context }, "\n"));
    end;

    return table.concat(v28, "\n");
end;

local function pack(...) -- Line: 137
    return select("#", ...), { ... };
end;

local function packResult(p29, ...) -- Line: 144
    return p29, select("#", ...), { ... };
end;

local function makeErrorHandler(u30) -- Line: 148
    -- upvalues: u10 (ref)
    assert(u30 ~= nil, "traceback is nil");

    return function(p31) -- Line: 151
        -- upvalues: u10 (ref), u30 (copy)
        if type(p31) == "table" then
            return p31;
        end;

        return u10.new({
            error = p31,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p31), 2),
            context = "Promise created at:\n\n" .. u30
        });
    end;
end;

local function runExecutor(u32, p33, ...) -- Line: 171
    -- upvalues: packResult (copy), u10 (ref)
    assert(u32 ~= nil, "traceback is nil");

    return packResult(xpcall(p33, function(p34) -- Line: 151
        -- upvalues: u10 (ref), u32 (copy)
        if type(p34) == "table" then
            return p34;
        end;

        return u10.new({
            error = p34,
            kind = u10.Kind.ExecutionError,
            trace = debug.traceback(tostring(p34), 2),
            context = "Promise created at:\n\n" .. u32
        });
    end, ...));
end;

local function createAdvancer(u35, u36, u37, u38) -- Line: 179
    -- upvalues: runExecutor (copy)
    return function(...) -- Line: 180
        -- upvalues: runExecutor (ref), u35 (copy), u36 (copy), u37 (copy), u38 (copy)
        local v39, v40, v41 = runExecutor(u35, u36, ...);

        if v39 then
            u37(unpack(v41, 1, v40));

            return;
        end;

        u38(v41[1]);
    end;
end;

local function isEmpty(p42) -- Line: 191
    return next(p42) == nil;
end;

local u43 = {
    Error = u10,
    Status = makeEnum("Promise.Status", { "Started", "Resolved", "Rejected", "Cancelled" }),
    _getTime = os.clock,
    _timeEvent = game:GetService("RunService").Heartbeat,
    _unhandledRejectionCallbacks = {},
    prototype = {}
};
u43.__index = u43.prototype;

function u43._new(p44, u45, p46) -- Line: 230
    -- upvalues: u43 (copy), u1 (copy), runExecutor (copy)
    if p46 ~= nil and not u43.is(p46) then
        error("Argument #2 to Promise.new must be a promise or nil", 2);
    end;

    local u47 = {
        _thread = nil,
        _values = nil,
        _valuesLength = -1,
        _unhandledRejection = true,
        _cancellationHook = nil,
        _source = p44,
        _status = u43.Status.Started,
        _queuedResolve = {},
        _queuedReject = {},
        _queuedFinally = {},
        _parent = p46,
        _consumers = setmetatable({}, u1)
    };

    if p46 and p46._status == u43.Status.Started then
        p46._consumers[u47] = true;
    end;

    setmetatable(u47, u43);

    local function resolve(...) -- Line: 278
        -- upvalues: u47 (copy)
        u47:_resolve(...);
    end;

    local function reject(...) -- Line: 282
        -- upvalues: u47 (copy)
        u47:_reject(...);
    end;

    local function onCancel(p48) -- Line: 286
        -- upvalues: u47 (copy), u43 (ref)
        if p48 then
            if u47._status == u43.Status.Cancelled then
                p48();
            else
                u47._cancellationHook = p48;
            end;
        end;

        return u47._status == u43.Status.Cancelled;
    end;

    u47._thread = coroutine.create(function() -- Line: 298
        -- upvalues: runExecutor (ref), u47 (copy), u45 (copy), resolve (copy), reject (copy), onCancel (copy)
        local v49, _, v50 = runExecutor(u47._source, u45, resolve, reject, onCancel);

        if not v49 then
            reject(v50[1]);
        end;
    end);
    task.spawn(u47._thread);

    return u47;
end;

function u43.new(p51) -- Line: 349
    -- upvalues: u43 (copy)
    return u43._new(debug.traceback(nil, 2), p51);
end;

function u43.__tostring(p52) -- Line: 353
    return string.format("Promise(%s)", p52._status);
end;

function u43.defer(u53) -- Line: 375
    -- upvalues: u43 (copy), runExecutor (copy)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u43._new(debug_traceback_ret, function(u54, u55, u56) -- Line: 378
        -- upvalues: u43 (ref), runExecutor (ref), debug_traceback_ret (copy), u53 (copy)
        local u57 = nil;
        u57 = u43._timeEvent:Connect(function() -- Line: 380
            -- upvalues: u57 (ref), runExecutor (ref), debug_traceback_ret (ref), u53 (ref), u54 (copy), u55 (copy), u56 (copy)
            u57:Disconnect();
            local v58, _, v59 = runExecutor(debug_traceback_ret, u53, u54, u55, u56);

            if not v58 then
                u55(v59[1]);
            end;
        end);
    end);
end;

u43.async = u43.defer;

function u43.resolve(...) -- Line: 418
    -- upvalues: pack (copy), u43 (copy)
    local u60, u61 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p62) -- Line: 420
        -- upvalues: u61 (copy), u60 (copy)
        p62(unpack(u61, 1, u60));
    end);
end;

function u43.reject(...) -- Line: 435
    -- upvalues: pack (copy), u43 (copy)
    local u63, u64 = pack(...);

    return u43._new(debug.traceback(nil, 2), function(p65, p66) -- Line: 437
        -- upvalues: u64 (copy), u63 (copy)
        p66(unpack(u64, 1, u63));
    end);
end;

function u43._try(p67, u68, ...) -- Line: 446
    -- upvalues: pack (copy), u43 (copy)
    local u69, u70 = pack(...);

    return u43._new(p67, function(p71) -- Line: 449
        -- upvalues: u68 (copy), u70 (copy), u69 (copy)
        p71(u68(unpack(u70, 1, u69)));
    end);
end;

function u43.try(p72, ...) -- Line: 477
    -- upvalues: u43 (copy)
    return u43._try(debug.traceback(nil, 2), p72, ...);
end;

function u43._all(p73, u74, u75) -- Line: 486
    -- upvalues: u43 (copy)
    if type(u74) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.all"), 3);
    end;

    for i, v in pairs(u74) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.all", (tostring(i))), 3);
        end;
    end;

    if #u74 == 0 or u75 == 0 then
        return u43.resolve({});
    end;

    return u43._new(p73, function(u76, u77, p78) -- Line: 504
        -- upvalues: u75 (copy), u74 (copy)
        local u79 = {};
        local u80 = {};
        local u81 = 0;
        local u82 = 0;
        local u83 = false;

        local function resolveOne(p84, ...) -- Line: 522
            -- upvalues: u83 (ref), u81 (ref), u75 (ref), u79 (copy), u74 (ref), u76 (copy), u80 (copy)
            if u83 then
                return;
            end;

            u81 = u81 + 1;

            if u75 == nil then
                u79[p84] = ...;
            else
                u79[u81] = ...;
            end;

            if u81 >= (u75 or #u74) then
                u83 = true;
                u76(u79);

                for _, v in ipairs(u80) do
                    v:cancel();
                end;
            end;
        end;

        p78(function() -- Line: 515, Name: cancel
            -- upvalues: u80 (copy)
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u74) do
            u80[i] = v:andThen(function(...) -- Line: 547
                -- upvalues: resolveOne (copy), i (copy)
                resolveOne(i, ...);
            end, function(...) -- Line: 549
                -- upvalues: u82 (ref), u75 (ref), u74 (ref), u80 (copy), u83 (ref), u77 (copy)
                u82 = u82 + 1;

                if u75 == nil or #u74 - u82 < u75 then
                    for _, v2 in ipairs(u80) do
                        v2:cancel();
                    end;

                    u83 = true;
                    u77(...);
                end;
            end);
        end;

        if u83 then
            for _, v in ipairs(u80) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.all(p85) -- Line: 591
    -- upvalues: u43 (copy)
    return u43._all(debug.traceback(nil, 2), p85);
end;

function u43.fold(p86, u87, p88) -- Line: 620
    -- upvalues: u43 (copy)
    local v89 = type(p86) == "table";
    assert(v89, "Bad argument #1 to Promise.fold: must be a table");
    local v90;

    if type(u87) == "function" then
        v90 = true;
    elseif type(u87) == "table" then
        local v91 = getmetatable(u87);

        if v91 then
            local v92 = rawget(v91, "__call");
            v90 = type(v92) == "function";
        else
            v90 = false;
        end;
    else
        v90 = false;
    end;

    assert(v90, "Bad argument #2 to Promise.fold: must be a function");
    local u93 = u43.resolve(p88);

    return u43.each(p86, function(u94, u95) -- Line: 625
        -- upvalues: u93 (ref), u87 (copy)
        u93 = u93:andThen(function(p96) -- Line: 626
            -- upvalues: u87 (ref), u94 (copy), u95 (copy)
            return u87(p96, u94, u95);
        end);
    end):andThen(function() -- Line: 629
        -- upvalues: u93 (ref)
        return u93;
    end);
end;

function u43.some(p97, p98) -- Line: 653
    -- upvalues: u43 (copy)
    local v99 = type(p98) == "number";
    assert(v99, "Bad argument #2 to Promise.some: must be a number");

    return u43._all(debug.traceback(nil, 2), p97, p98);
end;

function u43.any(p100) -- Line: 677
    -- upvalues: u43 (copy)
    return u43._all(debug.traceback(nil, 2), p100, 1):andThen(function(p101) -- Line: 678
        return p101[1];
    end);
end;

function u43.allSettled(u102) -- Line: 699
    -- upvalues: u43 (copy)
    if type(u102) ~= "table" then
        error(string.format("Please pass a list of promises to %s", "Promise.allSettled"), 2);
    end;

    for i, v in pairs(u102) do
        if not u43.is(v) then
            error(string.format("Non-promise value passed into %s at index %s", "Promise.allSettled", (tostring(i))), 2);
        end;
    end;

    if #u102 == 0 then
        return u43.resolve({});
    end;

    return u43._new(debug.traceback(nil, 2), function(u103, p104, p105) -- Line: 717
        -- upvalues: u102 (copy)
        local u106 = {};
        local u107 = {};
        local u108 = 0;

        local function u110(p109, ...) -- Line: 727
            -- upvalues: u108 (ref), u106 (copy), u102 (ref), u103 (copy)
            u108 = u108 + 1;
            u106[p109] = ...;

            if u108 >= #u102 then
                u103(u106);
            end;
        end;

        p105(function() -- Line: 737
            -- upvalues: u107 (copy)
            for _, v in ipairs(u107) do
                v:cancel();
            end;
        end);

        for i, v in ipairs(u102) do
            u107[i] = v:finally(function(...) -- Line: 746
                -- upvalues: u110 (copy), i (copy)
                u110(i, ...);
            end);
        end;
    end);
end;

function u43.race(u111) -- Line: 777
    -- upvalues: u43 (copy)
    local v112 = type(u111) == "table";
    assert(v112, string.format("Please pass a list of promises to %s", "Promise.race"));

    for i, v in pairs(u111) do
        local v113 = u43.is(v);
        local string_format = string.format;
        local v114 = tostring(i);
        assert(v113, string_format("Non-promise value passed into %s at index %s", "Promise.race", v114));
    end;

    return u43._new(debug.traceback(nil, 2), function(u115, u116, p117) -- Line: 784
        -- upvalues: u111 (copy)
        local u118 = {};
        local u119 = false;

        local function cancel() -- Line: 788
            -- upvalues: u118 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;

        local function finalize(u120) -- Line: 794
            -- upvalues: u118 (copy), u119 (ref)
            return function(...) -- Line: 795
                -- upvalues: u118 (ref), u119 (ref), u120 (copy)
                for _, v in ipairs(u118) do
                    v:cancel();
                end;

                u119 = true;

                return u120(...);
            end;
        end;

        if p117(function(...) -- Line: 795
            -- upvalues: u118 (copy), u119 (ref), u116 (copy)
            for _, v in ipairs(u118) do
                v:cancel();
            end;

            u119 = true;

            return u116(...);
        end) then
            return;
        end;

        for i, v in ipairs(u111) do
            u118[i] = v:andThen(function(...) -- Line: 795
                -- upvalues: u118 (copy), u119 (ref), u115 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u115(...);
            end, function(...) -- Line: 795
                -- upvalues: u118 (copy), u119 (ref), u116 (copy)
                for _, v2 in ipairs(u118) do
                    v2:cancel();
                end;

                u119 = true;

                return u116(...);
            end);
        end;

        if u119 then
            for _, v in ipairs(u118) do
                v:cancel();
            end;
        end;
    end);
end;

function u43.each(u121, u122) -- Line: 872
    -- upvalues: u43 (copy), u10 (ref)
    local v123 = type(u121) == "table";
    assert(v123, string.format("Please pass a list of promises to %s", "Promise.each"));
    local v124;

    if type(u122) == "function" then
        v124 = true;
    elseif type(u122) == "table" then
        local v125 = getmetatable(u122);

        if v125 then
            local v126 = rawget(v125, "__call");
            v124 = type(v126) == "function";
        else
            v124 = false;
        end;
    else
        v124 = false;
    end;

    assert(v124, string.format("Please pass a handler function to %s!", "Promise.each"));

    return u43._new(debug.traceback(nil, 2), function(p127, p128, p129) -- Line: 876
        -- upvalues: u121 (copy), u43 (ref), u10 (ref), u122 (copy)
        local v130 = {};
        local u131 = {};
        local u132 = false;

        local function _() -- Line: 882
            -- upvalues: u131 (copy)
            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end;

        p129(function() -- Line: 888
            -- upvalues: u132 (ref), u131 (copy)
            u132 = true;

            for _, v in ipairs(u131) do
                v:cancel();
            end;
        end);
        local v133 = {};

        for i, v in ipairs(u121) do
            if u43.is(v) then
                if v:getStatus() == u43.Status.Cancelled then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(u10.new({
                        error = "Promise is cancelled",
                        kind = u10.Kind.AlreadyCancelled,
                        context = string.format("The Promise that was part of the array at index %d passed into Promise.each was already cancelled when Promise.each began.\n\nThat Promise was created at:\n\n%s", i, v._source)
                    }));
                end;

                if v:getStatus() == u43.Status.Rejected then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(select(2, v:await()));
                end;

                local v134 = v:andThen(function(...) -- Line: 921
                    return ...;
                end);
                table.insert(u131, v134);
                v133[i] = v134;
            else
                v133[i] = v;
            end;
        end;

        for i, v in ipairs(v133) do
            local v135;

            if u43.is(v) then
                local v136;
                v136, v135 = v:await();

                if not v136 then
                    for _, v2 in ipairs(u131) do
                        v2:cancel();
                    end;

                    return p128(v135);
                end;
            else
                v135 = v;
            end;

            if u132 then
                return;
            end;

            local v137 = u43.resolve(u122(v135, i));
            table.insert(u131, v137);
            local v138, v139 = v137:await();

            if not v138 then
                for _, v2 in ipairs(u131) do
                    v2:cancel();
                end;

                return p128(v139);
            end;

            v130[i] = v139;
        end;

        p127(v130);
    end);
end;

function u43.is(p140) -- Line: 971
    -- upvalues: u43 (copy)
    if type(p140) ~= "table" then
        return false;
    end;

    local v141 = getmetatable(p140);

    if v141 == u43 then
        return true;
    end;

    if v141 ~= nil then
        if type(v141) == "table" then
            local v142 = rawget(v141, "__index");

            if type(v142) == "table" then
                local v143 = rawget(v141, "__index");
                local v144 = rawget(v143, "andThen");
                local v145;

                if type(v144) == "function" then
                    v145 = true;
                else
                    local v146 = type(v144) == "table" and getmetatable(v144);

                    if v146 then
                        local v147 = rawget(v146, "__call");
                        v145 = type(v147) == "function";
                    else
                        v145 = false;
                    end;
                end;

                if v145 then
                    return true;
                end;
            end;
        end;

        return false;
    end;

    local andThen = p140.andThen;

    if type(andThen) == "function" then
        return true;
    end;

    local v148 = type(andThen) == "table" and getmetatable(andThen);

    if v148 then
        local v149 = rawget(v148, "__call");

        if type(v149) == "function" then
            return true;
        end;
    end;

    return false;
end;

function u43.promisify(u150) -- Line: 1020
    -- upvalues: u43 (copy)
    return function(...) -- Line: 1021
        -- upvalues: u43 (ref), u150 (copy)
        return u43._try(debug.traceback(nil, 2), u150, ...);
    end;
end;

local u151 = nil;
local u152 = nil;

function u43.delay(p153) -- Line: 1051
    -- upvalues: u43 (copy), u152 (ref), u151 (ref)
    local v154 = type(p153) == "number";
    assert(v154, "Bad argument #1 to Promise.delay, must be a number.");
    local u155 = (p153 < 0.016666666666666666 or p153 == (1 / 0)) and 0.016666666666666666 or p153;

    return u43._new(debug.traceback(nil, 2), function(p156, p157, p158) -- Line: 1059
        -- upvalues: u43 (ref), u155 (ref), u152 (ref), u151 (ref)
        local v159 = u43._getTime();
        local v160 = v159 + u155;
        local u161 = {
            resolve = p156,
            startTime = v159,
            endTime = v160
        };

        if u152 == nil then
            u151 = u161;
            u152 = u43._timeEvent:Connect(function() -- Line: 1071
                -- upvalues: u43 (ref), u151 (ref), u152 (ref)
                local v162 = u43._getTime();

                while u151 ~= nil and u151.endTime < v162 do
                    local v163 = u151;
                    u151 = v163.next;

                    if u151 == nil then
                        u152:Disconnect();
                        u152 = nil;
                    else
                        u151.previous = nil;
                    end;

                    v163.resolve(u43._getTime() - v163.startTime);
                end;
            end);
        elseif u151.endTime < v160 then
            local v164 = u151;
            local next2 = v164.next;

            while next2 ~= nil and next2.endTime < v160 do
                v164 = next2;
                next2 = next2.next;
            end;

            v164.next = u161;
            u161.previous = v164;

            if next2 ~= nil then
                u161.next = next2;
                next2.previous = u161;
            end;
        else
            u161.next = u151;
            u151.previous = u161;
            u151 = u161;
        end;

        p158(function() -- Line: 1116
            -- upvalues: u161 (copy), u151 (ref), u152 (ref)
            local next2 = u161.next;

            if u151 == u161 then
                if next2 == nil then
                    u152:Disconnect();
                    u152 = nil;
                else
                    next2.previous = nil;
                end;

                u151 = next2;

                return;
            end;

            local previous = u161.previous;
            previous.next = next2;

            if next2 ~= nil then
                next2.previous = previous;
            end;
        end);
    end);
end;

function u43.prototype.timeout(p165, u166, u167) -- Line: 1180
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    return u43.race({ u43.delay(u166):andThen(function() -- Line: 1184
            -- upvalues: u43 (ref), u167 (copy), u10 (ref), u166 (copy), debug_traceback_ret (copy)
            return u43.reject(u167 == nil and u10.new({
                error = "Timed out",
                kind = u10.Kind.TimedOut,
                context = string.format("Timeout of %d seconds exceeded.\n:timeout() called at:\n\n%s", u166, debug_traceback_ret)
            }) or u167);
        end), p165 });
end;

function u43.prototype.getStatus(p168) -- Line: 1204
    return p168._status;
end;

function u43.prototype._andThen(u169, u170, u171, u172) -- Line: 1213
    -- upvalues: u43 (copy), runExecutor (copy)
    u169._unhandledRejection = false;

    if u169._status ~= u43.Status.Cancelled then
        return u43._new(u170, function(u173, u174, p175) -- Line: 1225
            -- upvalues: u171 (copy), u170 (copy), runExecutor (ref), u172 (copy), u169 (copy), u43 (ref)
            local u176;

            if u171 then
                local u177 = u170;
                local u178 = u171;

                u176 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u177 (copy), u178 (copy), u173 (copy), u174 (copy)
                    local v179, v180, v181 = runExecutor(u177, u178, ...);

                    if v179 then
                        u173(unpack(v181, 1, v180));

                        return;
                    end;

                    u174(v181[1]);
                end;
            else
                u176 = u173;
            end;

            if u172 then
                local u182 = u170;
                local u183 = u172;

                u174 = function(...) -- Line: 180
                    -- upvalues: runExecutor (ref), u182 (copy), u183 (copy), u173 (copy), u174 (copy)
                    local v184, v185, v186 = runExecutor(u182, u183, ...);

                    if v184 then
                        u173(unpack(v186, 1, v185));

                        return;
                    end;

                    u174(v186[1]);
                end;
            end;

            if u169._status == u43.Status.Started then
                table.insert(u169._queuedResolve, u176);
                table.insert(u169._queuedReject, u174);
                p175(function() -- Line: 1244
                    -- upvalues: u169 (ref), u43 (ref), u176 (ref), u174 (ref)
                    if u169._status == u43.Status.Started then
                        table.remove(u169._queuedResolve, table.find(u169._queuedResolve, u176));
                        table.remove(u169._queuedReject, table.find(u169._queuedReject, u174));
                    end;
                end);
            elseif u169._status == u43.Status.Resolved then
                u176(unpack(u169._values, 1, u169._valuesLength));
            elseif u169._status == u43.Status.Rejected then
                u174(unpack(u169._values, 1, u169._valuesLength));
            end;
        end, u169);
    end;

    local v187 = u43.new(function() -- Line: 1218
    end);
    v187:cancel();

    return v187;
end;

function u43.prototype.andThen(p188, p189, p190) -- Line: 1283
    local v191;

    if p189 == nil or type(p189) == "function" then
        v191 = true;
    elseif type(p189) == "table" then
        local v192 = getmetatable(p189);

        if v192 then
            local v193 = rawget(v192, "__call");
            v191 = type(v193) == "function";
        else
            v191 = false;
        end;
    else
        v191 = false;
    end;

    assert(v191, string.format("Please pass a handler function to %s!", "Promise:andThen"));
    local v194;

    if p190 == nil or type(p190) == "function" then
        v194 = true;
    elseif type(p190) == "table" then
        local v195 = getmetatable(p190);

        if v195 then
            local v196 = rawget(v195, "__call");
            v194 = type(v196) == "function";
        else
            v194 = false;
        end;
    else
        v194 = false;
    end;

    assert(v194, string.format("Please pass a handler function to %s!", "Promise:andThen"));

    return p188:_andThen(debug.traceback(nil, 2), p189, p190);
end;

function u43.prototype.catch(p197, p198) -- Line: 1310
    local v199;

    if p198 == nil or type(p198) == "function" then
        v199 = true;
    elseif type(p198) == "table" then
        local v200 = getmetatable(p198);

        if v200 then
            local v201 = rawget(v200, "__call");
            v199 = type(v201) == "function";
        else
            v199 = false;
        end;
    else
        v199 = false;
    end;

    assert(v199, string.format("Please pass a handler function to %s!", "Promise:catch"));

    return p197:_andThen(debug.traceback(nil, 2), nil, p198);
end;

function u43.prototype.tap(p202, u203) -- Line: 1331
    -- upvalues: u43 (copy), pack (copy)
    local v204;

    if type(u203) == "function" then
        v204 = true;
    elseif type(u203) == "table" then
        local v205 = getmetatable(u203);

        if v205 then
            local v206 = rawget(v205, "__call");
            v204 = type(v206) == "function";
        else
            v204 = false;
        end;
    else
        v204 = false;
    end;

    assert(v204, string.format("Please pass a handler function to %s!", "Promise:tap"));

    return p202:_andThen(debug.traceback(nil, 2), function(...) -- Line: 1333
        -- upvalues: u203 (copy), u43 (ref), pack (ref)
        local v207 = u203(...);

        if not u43.is(v207) then
            return ...;
        end;

        local u208, u209 = pack(...);

        return v207:andThen(function() -- Line: 1338
            -- upvalues: u209 (copy), u208 (copy)
            return unpack(u209, 1, u208);
        end);
    end);
end;

function u43.prototype.andThenCall(p210, u211, ...) -- Line: 1366
    -- upvalues: pack (copy)
    local v212;

    if type(u211) == "function" then
        v212 = true;
    elseif type(u211) == "table" then
        local v213 = getmetatable(u211);

        if v213 then
            local v214 = rawget(v213, "__call");
            v212 = type(v214) == "function";
        else
            v212 = false;
        end;
    else
        v212 = false;
    end;

    assert(v212, string.format("Please pass a handler function to %s!", "Promise:andThenCall"));
    local u215, u216 = pack(...);

    return p210:_andThen(debug.traceback(nil, 2), function() -- Line: 1369
        -- upvalues: u211 (copy), u216 (copy), u215 (copy)
        return u211(unpack(u216, 1, u215));
    end);
end;

function u43.prototype.andThenReturn(p217, ...) -- Line: 1396
    -- upvalues: pack (copy)
    local u218, u219 = pack(...);

    return p217:_andThen(debug.traceback(nil, 2), function() -- Line: 1398
        -- upvalues: u219 (copy), u218 (copy)
        return unpack(u219, 1, u218);
    end);
end;

function u43.prototype.cancel(p220) -- Line: 1414
    -- upvalues: u43 (copy)
    if p220._status ~= u43.Status.Started then
        return;
    end;

    p220._status = u43.Status.Cancelled;

    if p220._cancellationHook then
        p220._cancellationHook();
    end;

    coroutine.close(p220._thread);

    if p220._parent then
        p220._parent:_consumerCancelled(p220);
    end;

    for i in pairs(p220._consumers) do
        i:cancel();
    end;

    p220:_finalize();
end;

function u43.prototype._consumerCancelled(p221, p222) -- Line: 1442
    -- upvalues: u43 (copy)
    if p221._status ~= u43.Status.Started then
        return;
    end;

    p221._consumers[p222] = nil;

    if next(p221._consumers) == nil then
        p221:cancel();
    end;
end;

function u43.prototype._finally(u223, p224, u225) -- Line: 1458
    -- upvalues: u43 (copy)
    u223._unhandledRejection = false;

    return u43._new(p224, function(u226, u227, p228) -- Line: 1461
        -- upvalues: u223 (copy), u225 (copy), u43 (ref)
        local u229 = nil;
        p228(function() -- Line: 1464
            -- upvalues: u223 (ref), u229 (ref)
            u223:_consumerCancelled(u223);

            if u229 then
                u229:cancel();
            end;
        end);
        local v232 = u225 and function(...) -- Line: 1477
            -- upvalues: u225 (ref), u43 (ref), u229 (ref), u226 (copy), u223 (ref), u227 (copy)
            local v230 = u225(...);

            if not u43.is(v230) then
                u226(u223);

                return;
            end;

            u229 = v230;
            v230:finally(function(p231) -- Line: 1484
                -- upvalues: u43 (ref), u226 (ref), u223 (ref)
                if p231 ~= u43.Status.Rejected then
                    u226(u223);
                end;
            end):catch(function(...) -- Line: 1489
                -- upvalues: u227 (ref)
                u227(...);
            end);
        end or u226;

        if u223._status == u43.Status.Started then
            table.insert(u223._queuedFinally, v232);
        else
            v232(u223._status);
        end;
    end);
end;

function u43.prototype.finally(p233, p234) -- Line: 1559
    local v235;

    if p234 == nil or type(p234) == "function" then
        v235 = true;
    elseif type(p234) == "table" then
        local v236 = getmetatable(p234);

        if v236 then
            local v237 = rawget(v236, "__call");
            v235 = type(v237) == "function";
        else
            v235 = false;
        end;
    else
        v235 = false;
    end;

    assert(v235, string.format("Please pass a handler function to %s!", "Promise:finally"));

    return p233:_finally(debug.traceback(nil, 2), p234);
end;

function u43.prototype.finallyCall(p238, u239, ...) -- Line: 1573
    -- upvalues: pack (copy)
    local v240;

    if type(u239) == "function" then
        v240 = true;
    elseif type(u239) == "table" then
        local v241 = getmetatable(u239);

        if v241 then
            local v242 = rawget(v241, "__call");
            v240 = type(v242) == "function";
        else
            v240 = false;
        end;
    else
        v240 = false;
    end;

    assert(v240, string.format("Please pass a handler function to %s!", "Promise:finallyCall"));
    local u243, u244 = pack(...);

    return p238:_finally(debug.traceback(nil, 2), function() -- Line: 1576
        -- upvalues: u239 (copy), u244 (copy), u243 (copy)
        return u239(unpack(u244, 1, u243));
    end);
end;

function u43.prototype.finallyReturn(p245, ...) -- Line: 1599
    -- upvalues: pack (copy)
    local u246, u247 = pack(...);

    return p245:_finally(debug.traceback(nil, 2), function() -- Line: 1601
        -- upvalues: u247 (copy), u246 (copy)
        return unpack(u247, 1, u246);
    end);
end;

function u43.prototype.awaitStatus(p248) -- Line: 1613
    -- upvalues: u43 (copy)
    p248._unhandledRejection = false;

    if p248._status == u43.Status.Started then
        local coroutine_running_ret = coroutine.running();
        p248:finally(function() -- Line: 1620
            -- upvalues: coroutine_running_ret (copy)
            task.spawn(coroutine_running_ret);
        end):catch(function() -- Line: 1626
        end);
        coroutine.yield();
    end;

    if p248._status == u43.Status.Resolved then
        return p248._status, unpack(p248._values, 1, p248._valuesLength);
    end;

    if p248._status == u43.Status.Rejected then
        return p248._status, unpack(p248._values, 1, p248._valuesLength);
    end;

    return p248._status;
end;

local function awaitHelper(p249, ...) -- Line: 1641
    -- upvalues: u43 (copy)
    return p249 == u43.Status.Resolved, ...;
end;

function u43.prototype.await(p250) -- Line: 1666
    -- upvalues: awaitHelper (copy)
    return awaitHelper(p250:awaitStatus());
end;

local function expectHelper(p251, ...) -- Line: 1670
    -- upvalues: u43 (copy)
    if p251 ~= u43.Status.Resolved then
        error(... == nil and "Expected Promise rejected with no value." or ..., 3);
    end;

    return ...;
end;

function u43.prototype.expect(p252) -- Line: 1703
    -- upvalues: expectHelper (copy)
    return expectHelper(p252:awaitStatus());
end;

u43.prototype.awaitValue = u43.prototype.expect;

function u43.prototype._unwrap(p253) -- Line: 1717
    -- upvalues: u43 (copy)
    if p253._status == u43.Status.Started then
        error("Promise has not resolved or rejected.", 2);
    end;

    return p253._status == u43.Status.Resolved, unpack(p253._values, 1, p253._valuesLength);
end;

function u43.prototype._resolve(u254, ...) -- Line: 1727
    -- upvalues: u43 (copy), u10 (ref), pack (copy)
    if u254._status ~= u43.Status.Started then
        if u43.is((...)) then
            (...):_consumerCancelled(u254);
        end;

        return;
    end;

    if u43.is((...)) then
        if select("#", ...) > 1 then
            local string_format_ret = string.format("When returning a Promise from andThen, extra arguments are discarded! See:\n\n%s", u254._source);
            warn(string_format_ret);
        end;

        local u255 = ...;
        local v257 = u255:andThen(function(...) -- Line: 1748
            -- upvalues: u254 (copy)
            u254:_resolve(...);
        end, function(...) -- Line: 1750
            -- upvalues: u255 (copy), u10 (ref), u254 (copy)
            local v256 = u255._values[1];

            if u255._error then
                v256 = u10.new({
                    context = "[No stack trace available as this Promise originated from an older version of the Promise library (< v2)]",
                    error = u255._error,
                    kind = u10.Kind.ExecutionError
                });
            end;

            if u10.isKind(v256, u10.Kind.ExecutionError) then
                return u254:_reject(v256:extend({
                    error = "This Promise was chained to a Promise that errored.",
                    trace = "",
                    context = string.format("The Promise at:\n\n%s\n...Rejected because it was chained to the following Promise, which encountered an error:\n", u254._source)
                }));
            end;

            u254:_reject(...);
        end);

        if v257._status == u43.Status.Cancelled then
            u254:cancel();

            return;
        end;

        if v257._status == u43.Status.Started then
            u254._parent = v257;
            v257._consumers[u254] = true;
        end;

        return;
    end;

    u254._status = u43.Status.Resolved;
    local v258, v259 = pack(...);
    u254._valuesLength = v258;
    u254._values = v259;

    for _, v in ipairs(u254._queuedResolve) do
        coroutine.wrap(v)(...);
    end;

    u254:_finalize();
end;

function u43.prototype._reject(u260, ...) -- Line: 1798
    -- upvalues: u43 (copy), pack (copy)
    if u260._status ~= u43.Status.Started then
        return;
    end;

    u260._status = u43.Status.Rejected;
    local v261, v262 = pack(...);
    u260._valuesLength = v261;
    u260._values = v262;

    if next(u260._queuedReject) == nil then
        local u263 = tostring((...));
        coroutine.wrap(function() -- Line: 1820
            -- upvalues: u43 (ref), u260 (copy), u263 (copy)
            u43._timeEvent:Wait();

            if not u260._unhandledRejection then
                return;
            end;

            local string_format_ret = string.format("Unhandled Promise rejection:\n\n%s\n\n%s", u263, u260._source);

            for _, v in ipairs(u43._unhandledRejectionCallbacks) do
                task.spawn(v, u260, unpack(u260._values, 1, u260._valuesLength));
            end;

            if u43.TEST then
                return;
            end;

            warn(string_format_ret);
        end)();
    else
        for _, v in ipairs(u260._queuedReject) do
            coroutine.wrap(v)(...);
        end;
    end;

    u260:_finalize();
end;

function u43.prototype._finalize(p264) -- Line: 1852
    -- upvalues: u43 (copy)
    for _, v in ipairs(p264._queuedFinally) do
        coroutine.wrap(v)(p264._status);
    end;

    p264._queuedFinally = nil;
    p264._queuedReject = nil;
    p264._queuedResolve = nil;

    if not u43.TEST then
        p264._parent = nil;
        p264._consumers = nil;
    end;

    task.defer(coroutine.close, p264._thread);
end;

function u43.prototype.now(p265, p266) -- Line: 1889
    -- upvalues: u43 (copy), u10 (ref)
    local debug_traceback_ret = debug.traceback(nil, 2);

    if p265._status == u43.Status.Resolved then
        return p265:_andThen(debug_traceback_ret, function(...) -- Line: 1892
            return ...;
        end);
    end;

    local reject = u43.reject;

    if p266 == nil then
        p266 = u10.new({
            error = "This Promise was not resolved in time for :now()",
            kind = u10.Kind.NotResolvedInTime,
            context = ":now() was called at:\n\n" .. debug_traceback_ret
        }) or p266;
    end;

    return reject(p266);
end;

function u43.retry(u267, u268, ...) -- Line: 1934
    -- upvalues: u43 (copy)
    local v269;

    if type(u267) == "function" then
        v269 = true;
    elseif type(u267) == "table" then
        local v270 = getmetatable(u267);

        if v270 then
            local v271 = rawget(v270, "__call");
            v269 = type(v271) == "function";
        else
            v269 = false;
        end;
    else
        v269 = false;
    end;

    assert(v269, "Parameter #1 to Promise.retry must be a function");
    local v272 = type(u268) == "number";
    assert(v272, "Parameter #2 to Promise.retry must be a number");
    local u273 = { ... };
    local u274 = select("#", ...);

    return u43.resolve(u267(...)):catch(function(...) -- Line: 1940
        -- upvalues: u268 (copy), u43 (ref), u267 (copy), u273 (copy), u274 (copy)
        if u268 > 0 then
            return u43.retry(u267, u268 - 1, unpack(u273, 1, u274));
        end;

        return u43.reject(...);
    end);
end;

function u43.retryWithDelay(u275, u276, u277, ...) -- Line: 1962
    -- upvalues: u43 (copy)
    local v278;

    if type(u275) == "function" then
        v278 = true;
    elseif type(u275) == "table" then
        local v279 = getmetatable(u275);

        if v279 then
            local v280 = rawget(v279, "__call");
            v278 = type(v280) == "function";
        else
            v278 = false;
        end;
    else
        v278 = false;
    end;

    assert(v278, "Parameter #1 to Promise.retry must be a function");
    local v281 = type(u276) == "number";
    assert(v281, "Parameter #2 (times) to Promise.retry must be a number");
    local v282 = type(u277) == "number";
    assert(v282, "Parameter #3 (seconds) to Promise.retry must be a number");
    local u283 = { ... };
    local u284 = select("#", ...);

    return u43.resolve(u275(...)):catch(function(...) -- Line: 1969
        -- upvalues: u276 (copy), u43 (ref), u277 (copy), u275 (copy), u283 (copy), u284 (copy)
        if u276 <= 0 then
            return u43.reject(...);
        end;

        u43.delay(u277):await();

        return u43.retryWithDelay(u275, u276 - 1, u277, unpack(u283, 1, u284));
    end);
end;

function u43.fromEvent(u285, p286) -- Line: 2004
    -- upvalues: u43 (copy)
    local u287 = p286 or function() -- Line: 2005
        return true;
    end;

    return u43._new(debug.traceback(nil, 2), function(u288, p289, p290) -- Line: 2009
        -- upvalues: u285 (copy), u287 (ref)
        local u291 = nil;
        local u292 = false;

        local function disconnect() -- Line: 2013
            -- upvalues: u291 (ref)
            u291:Disconnect();
            u291 = nil;
        end;

        u291 = u285:Connect(function(...) -- Line: 2022
            -- upvalues: u287 (ref), u288 (copy), u291 (ref), u292 (ref)
            local v293 = u287(...);

            if v293 ~= true then
                if type(v293) ~= "boolean" then
                    error("Promise.fromEvent predicate should always return a boolean");
                end;

                return;
            end;

            u288(...);

            if not u291 then
                u292 = true;

                return;
            end;

            u291:Disconnect();
            u291 = nil;
        end);

        if u292 and u291 then
            return disconnect();
        end;

        p290(disconnect);
    end);
end;

function u43.onUnhandledRejection(u294) -- Line: 2056
    -- upvalues: u43 (copy)
    table.insert(u43._unhandledRejectionCallbacks, u294);

    return function() -- Line: 2059
        -- upvalues: u43 (ref), u294 (copy)
        local table_find_ret = table.find(u43._unhandledRejectionCallbacks, u294);

        if table_find_ret then
            table.remove(u43._unhandledRejectionCallbacks, table_find_ret);
        end;
    end;
end;

return u43;