 
-- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=5530714855

-- ! Source from the asset above; the game may have edited it since.

--[[
return function()
	local Promise = require(script.Parent)
	Promise.TEST = true

	local timeEvent = Instance.new("BindableEvent")
	Promise._timeEvent = timeEvent.Event

	local advanceTime
	do
		local injectedPromiseTime = 0

		Promise._getTime = function()
			return injectedPromiseTime
		end

		function advanceTime(delta)
			delta = delta or (1 / 60)

			injectedPromiseTime = injectedPromiseTime + delta
			timeEvent:Fire(delta)
		end
	end

	local function pack(...)
		local len = select("#", ...)

		return len, { ... }
	end

	describe("Promise.Status", function()
		it("should error if indexing nil value", function()
			expect(function()
				local _ = Promise.Status.wrong
			end).to.throw()
		end)
	end)

	describe("Unhandled rejection signal", function()
		it("should call unhandled rejection callbacks", function()
			local badPromise = Promise.new(function(_resolve, reject)
				reject(1, 2)
			end)

			local callCount = 0

			local function callback(promise, rejectionA, rejectionB)
				callCount += 1

				expect(promise).to.equal(badPromise)
				expect(rejectionA).to.equal(1)
				expect(rejectionB).to.equal(2)
			end

			local unregister = Promise.onUnhandledRejection(callback)

			advanceTime()

			expect(callCount).to.equal(1)

			unregister()

			Promise.new(function(_resolve, reject)
				reject(3, 4)
			end)

			advanceTime()

			expect(callCount).to.equal(1)
		end)
	end)

	describe("Promise.new", function()
		it("should instantiate with a callback", function()
			local promise = Promise.new(function() end)

			expect(promise).to.be.ok()
		end)

		it("should invoke the given callback with resolve and reject", function()
			local callCount = 0
			local resolveArg
			local rejectArg

			local promise = Promise.new(function(resolve, reject)
				callCount = callCount + 1
				resolveArg = resolve
				rejectArg = reject
			end)

			expect(promise).to.be.ok()

			expect(callCount).to.equal(1)
			expect(resolveArg).to.be.a("function")
			expect(rejectArg).to.be.a("function")
			expect(promise:getStatus()).to.equal(Promise.Status.Started)
		end)

		it("should resolve promises on resolve()", function()
			local callCount = 0

			local promise = Promise.new(function(resolve)
				callCount = callCount + 1
				resolve()
			end)

			expect(promise).to.be.ok()
			expect(callCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
		end)

		it("should reject promises on reject()", function()
			local callCount = 0

			local promise = Promise.new(function(resolve, reject)
				callCount = callCount + 1
				reject()
			end)

			expect(promise).to.be.ok()
			expect(callCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
		end)

		it("should reject on error in callback", function()
			local callCount = 0

			local promise = Promise.new(function()
				callCount = callCount + 1
				error("hahah")
			end)

			expect(promise).to.be.ok()
			expect(callCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(tostring(promise._values[1]):find("hahah")).to.be.ok()

			-- Loosely check for the pieces of the stack trace we expect
			expect(tostring(promise._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(promise._values[1]):find("runExecutor")).to.be.ok()
		end)

		it("should work with C functions", function()
			expect(function()
				Promise.new(tick):andThen(tick)
			end).to.never.throw()
		end)

		it("should have a nice tostring", function()
			expect(tostring(Promise.resolve()):gmatch("Promise(Resolved)")).to.be.ok()
		end)

		it("should allow yielding", function()
			local bindable = Instance.new("BindableEvent")
			local promise = Promise.new(function(resolve)
				bindable.Event:Wait()
				resolve(5)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			bindable:Fire()
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(5)
		end)

		it("should preserve stack traces of resolve-chained promises", function()
			local function nestedCall(text)
				error(text)
			end

			local promise = Promise.new(function(resolve)
				resolve(Promise.new(function()
					nestedCall("sample text")
				end))
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)

			local trace = tostring(promise._values[1])
			expect(trace:find("sample text")).to.be.ok()
			expect(trace:find("nestedCall")).to.be.ok()
			expect(trace:find("runExecutor")).to.be.ok()
			expect(trace:find("runPlanNode")).to.be.ok()
			expect(
				trace:find("...Rejected because it was chained to the following Promise, which encountered an error:")
			).to.be.ok()
		end)

		it("should report errors from Promises with _error (< v2)", function()
			local oldPromise = Promise.reject()
			oldPromise._error = "Sample error"

			local newPromise = Promise.resolve():andThenReturn(oldPromise)

			expect(newPromise:getStatus()).to.equal(Promise.Status.Rejected)

			local trace = tostring(newPromise._values[1])
			expect(trace:find("Sample error")).to.be.ok()
			expect(
				trace:find("...Rejected because it was chained to the following Promise, which encountered an error:")
			).to.be.ok()
			expect(trace:find("%[No stack trace available")).to.be.ok()
		end)

		it("should allow callable tables", function()
			local promise = Promise.new(setmetatable({}, {
				__call = function(_, resolve)
					resolve(1)
				end,
			}))

			local called = false
			promise:andThen(setmetatable({}, {
				__call = function(_, var)
					expect(var).to.equal(1)
					called = true
				end,
			}))

			expect(called).to.equal(true)
		end)

		itSKIP("should close the thread after resolve", function()
			local count = 0
			Promise.new(function(resolve)
				count += 1
				resolve()
				Promise.delay(1):await()
				count += 1
			end)

			task.wait(1)

			expect(count).to.equal(1)
		end)
	end)

	describe("Promise.defer", function()
		it("should execute after the time event", function()
			local callCount = 0
			local promise = Promise.defer(function(resolve, reject, onCancel, nothing)
				expect(type(resolve)).to.equal("function")
				expect(type(reject)).to.equal("function")
				expect(type(onCancel)).to.equal("function")
				expect(type(nothing)).to.equal("nil")

				callCount = callCount + 1

				resolve("foo")
			end)

			expect(callCount).to.equal(0)
			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			advanceTime()
			expect(callCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)

			advanceTime()
			expect(callCount).to.equal(1)
		end)
	end)

	describe("Promise.delay", function()
		it("should schedule promise resolution", function()
			local promise = Promise.delay(1)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			advanceTime()
			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			advanceTime(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
		end)

		it("should allow for delays to be cancelled", function()
			local promise = Promise.delay(2)

			Promise.delay(1):andThen(function()
				promise:cancel()
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			advanceTime()
			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			advanceTime(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Cancelled)
			advanceTime(1)
		end)
	end)

	describe("Promise.resolve", function()
		it("should immediately resolve with a value", function()
			local promise = Promise.resolve(5, 6)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(5)
			expect(promise._values[2]).to.equal(6)
		end)

		it("should chain onto passed promises", function()
			local promise = Promise.resolve(Promise.new(function(_, reject)
				reject(7)
			end))

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal(7)
		end)
	end)

	describe("Promise.reject", function()
		it("should immediately reject with a value", function()
			local promise = Promise.reject(6, 7)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal(6)
			expect(promise._values[2]).to.equal(7)
		end)

		it("should pass a promise as-is as an error", function()
			local innerPromise = Promise.new(function(resolve)
				resolve(6)
			end)

			local promise = Promise.reject(innerPromise)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal(innerPromise)
		end)
	end)

	describe("Promise:andThen", function()
		it("should allow yielding", function()
			local bindable = Instance.new("BindableEvent")
			local promise = Promise.resolve():andThen(function()
				bindable.Event:Wait()
				return 5
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			bindable:Fire()
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(5)
		end)

		it("should run andThens on a new thread", function()
			local bindable = Instance.new("BindableEvent")

			local resolve
			local parentPromise = Promise.new(function(_resolve)
				resolve = _resolve
			end)

			local deadlockedPromise = parentPromise:andThen(function()
				bindable.Event:Wait()
				return 5
			end)

			local successfulPromise = parentPromise:andThen(function()
				return "foo"
			end)

			expect(parentPromise:getStatus()).to.equal(Promise.Status.Started)
			resolve()
			expect(successfulPromise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(successfulPromise._values[1]).to.equal("foo")
			expect(deadlockedPromise:getStatus()).to.equal(Promise.Status.Started)
		end)

		it("should chain onto resolved promises", function()
			local args
			local argsLength
			local callCount = 0
			local badCallCount = 0

			local promise = Promise.resolve(5)

			local chained = promise:andThen(function(...)
				argsLength, args = pack(...)
				callCount = callCount + 1
			end, function()
				badCallCount = badCallCount + 1
			end)

			expect(badCallCount).to.equal(0)

			expect(callCount).to.equal(1)
			expect(argsLength).to.equal(1)
			expect(args[1]).to.equal(5)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(5)

			expect(chained).to.be.ok()
			expect(chained).never.to.equal(promise)
			expect(chained:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#chained._values).to.equal(0)
		end)

		it("should chain onto rejected promises", function()
			local args
			local argsLength
			local callCount = 0
			local badCallCount = 0

			local promise = Promise.reject(5)

			local chained = promise:andThen(function(...)
				badCallCount = badCallCount + 1
			end, function(...)
				argsLength, args = pack(...)
				callCount = callCount + 1
			end)

			expect(badCallCount).to.equal(0)

			expect(callCount).to.equal(1)
			expect(argsLength).to.equal(1)
			expect(args[1]).to.equal(5)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal(5)

			expect(chained).to.be.ok()
			expect(chained).never.to.equal(promise)
			expect(chained:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#chained._values).to.equal(0)
		end)

		it("should reject on error in callback", function()
			local callCount = 0

			local promise = Promise.resolve(1):andThen(function()
				callCount = callCount + 1
				error("hahah")
			end)

			expect(promise).to.be.ok()
			expect(callCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(tostring(promise._values[1]):find("hahah")).to.be.ok()

			-- Loosely check for the pieces of the stack trace we expect
			expect(tostring(promise._values[1]):find("init.spec")).to.be.ok()
			expect(tostring(promise._values[1]):find("runExecutor")).to.be.ok()
		end)

		it("should chain onto asynchronously resolved promises", function()
			local args
			local argsLength
			local callCount = 0
			local badCallCount = 0

			local startResolution
			local promise = Promise.new(function(resolve)
				startResolution = resolve
			end)

			local chained = promise:andThen(function(...)
				args = { ... }
				argsLength = select("#", ...)
				callCount = callCount + 1
			end, function()
				badCallCount = badCallCount + 1
			end)

			expect(callCount).to.equal(0)
			expect(badCallCount).to.equal(0)

			startResolution(6)

			expect(badCallCount).to.equal(0)

			expect(callCount).to.equal(1)
			expect(argsLength).to.equal(1)
			expect(args[1]).to.equal(6)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(6)

			expect(chained).to.be.ok()
			expect(chained).never.to.equal(promise)
			expect(chained:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#chained._values).to.equal(0)
		end)

		it("should chain onto asynchronously rejected promises", function()
			local args
			local argsLength
			local callCount = 0
			local badCallCount = 0

			local startResolution
			local promise = Promise.new(function(_, reject)
				startResolution = reject
			end)

			local chained = promise:andThen(function()
				badCallCount = badCallCount + 1
			end, function(...)
				args = { ... }
				argsLength = select("#", ...)
				callCount = callCount + 1
			end)

			expect(callCount).to.equal(0)
			expect(badCallCount).to.equal(0)

			startResolution(6)

			expect(badCallCount).to.equal(0)

			expect(callCount).to.equal(1)
			expect(argsLength).to.equal(1)
			expect(args[1]).to.equal(6)

			expect(promise).to.be.ok()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal(6)

			expect(chained).to.be.ok()
			expect(chained).never.to.equal(promise)
			expect(chained:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#chained._values).to.equal(0)
		end)

		it("should propagate errors through multiple levels", function()
			local x, y, z
			Promise.new(function(resolve, reject)
				reject(1, 2, 3)
			end):andThen(function() end):catch(function(a, b, c)
				x, y, z = a, b, c
			end)

			expect(x).to.equal(1)
			expect(y).to.equal(2)
			expect(z).to.equal(3)
		end)

		it("should not call queued callbacks from a cancelled sub-promise", function()
			local resolve
			local count = 0

			local root = Promise.new(function(r)
				resolve = r
			end)

			root:andThen(function()
				count += 1
			end)

			root
				:andThen(function()
					count += 1
				end)
				:cancel()

			resolve("foo")

			expect(count).to.equal(1)
		end)
	end)

	describe("Promise:cancel", function()
		it("should mark promises as cancelled and not resolve or reject them", function()
			local callCount = 0
			local finallyCallCount = 0
			local promise = Promise.new(function() end)
				:andThen(function()
					callCount = callCount + 1
				end)
				:finally(function()
					finallyCallCount = finallyCallCount + 1
				end)

			promise:cancel()
			promise:cancel() -- Twice to check call counts

			expect(callCount).to.equal(0)
			expect(finallyCallCount).to.equal(1)
			expect(promise:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should call the cancellation hook once", function()
			local callCount = 0

			local promise = Promise.new(function(resolve, reject, onCancel)
				onCancel(function()
					callCount = callCount + 1
				end)
			end)

			promise:cancel()
			promise:cancel() -- Twice to check call count

			expect(callCount).to.equal(1)
		end)

		it("should propagate cancellations", function()
			local promise = Promise.new(function() end)

			local consumer1 = promise:andThen()
			local consumer2 = promise:andThen()

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(consumer1:getStatus()).to.equal(Promise.Status.Started)
			expect(consumer2:getStatus()).to.equal(Promise.Status.Started)

			consumer1:cancel()

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(consumer1:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(consumer2:getStatus()).to.equal(Promise.Status.Started)

			consumer2:cancel()

			expect(promise:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(consumer1:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(consumer2:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should affect downstream promises", function()
			local promise = Promise.new(function() end)
			local consumer = promise:andThen()

			promise:cancel()

			expect(consumer:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should track consumers", function()
			local pending = Promise.new(function() end)
			local p0 = Promise.resolve()
			local p1 = p0:andThen(function()
				return pending
			end)
			local p2 = Promise.new(function(resolve)
				resolve(p1)
			end)
			local p3 = p2:andThen(function() end)

			expect(p1._parent).to.never.equal(p0)
			expect(p2._parent).to.never.equal(p1)
			expect(p2._consumers[p3]).to.be.ok()
			expect(p3._parent).to.equal(p2)
		end)

		it("should cancel resolved pending promises", function()
			local p1 = Promise.new(function() end)

			local p2 = Promise.new(function(resolve)
				resolve(p1)
			end):finally(function() end)

			p2:cancel()

			expect(p1._status).to.equal(Promise.Status.Cancelled)
			expect(p2._status).to.equal(Promise.Status.Cancelled)
		end)

		it("should close the promise thread", function()
			local count = 0
			local promise = Promise.new(function()
				count += 1
				Promise.delay(1):await()
				count += 1
			end)

			promise:cancel()
			advanceTime(2)

			expect(count).to.equal(1)
		end)
	end)

	describe("Promise:finally", function()
		it("should be called upon resolve, reject, or cancel", function()
			local callCount = 0

			local function finally()
				callCount = callCount + 1
			end

			-- Resolved promise
			Promise.new(function(resolve, reject)
				resolve()
			end):finally(finally)

			-- Chained promise
			Promise.resolve():andThen(function() end):finally(finally):finally(finally)

			-- Rejected promise
			Promise.reject():finally(finally)

			local cancelledPromise = Promise.new(function() end):finally(finally)
			cancelledPromise:cancel()

			expect(callCount).to.equal(5)
		end)

		it("should not forward return values", function()
			local value

			Promise.resolve(2)
				:finally(function()
					return 1
				end)
				:andThen(function(v)
					value = v
				end)

			expect(value).to.equal(2)
		end)

		it("should not consume rejections", function()
			local catchRan = false
			local thenRan = false
			Promise.reject(5)
				:finally(function()
					return 42
				end)
				:andThen(function()
					thenRan = true
				end)
				:catch(function(value)
					catchRan = true
					expect(value).to.equal(5)
				end)

			expect(catchRan).to.equal(true)
			expect(thenRan).to.equal(false)
		end)

		it("should wait for returned promises", function()
			local resolve
			local promise = Promise.reject("foo"):finally(function()
				return Promise.new(function(r)
					resolve = r
				end)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			resolve()

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			local _, value = promise:_unwrap()
			expect(value).to.equal("foo")
		end)

		it("should reject with a returned rejected promise's value", function()
			local reject
			local promise = Promise.reject("foo"):finally(function()
				return Promise.new(function(_, r)
					reject = r
				end)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			reject("bar")

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			local _, value = promise:_unwrap()
			expect(value).to.equal("bar")
		end)

		it("should reject when handler errors", function()
			local errorValue = {}
			local promise = Promise.reject("bar"):finally(function()
				error(errorValue)
			end)

			local ok, value = promise:_unwrap()

			expect(ok).to.equal(false)
			expect(value).to.equal(errorValue)
		end)

		it("should not prevent cancellation", function()
			local promise = Promise.new(function() end)

			local finallyRan = false
			promise:finally(function()
				finallyRan = true
			end)

			local consumer = promise:andThen(function() end)

			consumer:cancel()

			expect(promise:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(finallyRan).to.equal(true)
		end)

		it("should propagate cancellation downwards", function()
			local finallyRan = false
			local andThenRan = false
			local root = Promise.new(function() end)

			local consumer = root:finally(function()
				finallyRan = true
			end)

			root:cancel()

			expect(root:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(consumer:getStatus()).to.equal(Promise.Status.Cancelled)

			expect(finallyRan).to.equal(true)
			expect(andThenRan).to.equal(false)
		end)

		it("should propagate cancellation upwards", function()
			local finallyRan = false
			local andThenRan = false
			local root = Promise.new(function() end)

			local consumer = root:finally(function()
				finallyRan = true
			end)

			consumer:cancel()

			expect(root:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(consumer:getStatus()).to.equal(Promise.Status.Cancelled)

			expect(finallyRan).to.equal(true)
			expect(andThenRan).to.equal(false)
		end)

		it("should cancel returned promise if cancelled", function()
			local internal = Promise.new(function() end)

			local promise = Promise.resolve():finally(function()
				return internal
			end)

			promise:cancel()

			expect(internal:getStatus()).to.equal(Promise.Status.Cancelled)
		end)
	end)

	describe("Promise.all", function()
		it("should error if given something other than a table", function()
			expect(function()
				Promise.all(1)
			end).to.throw()
		end)

		it("should resolve instantly with an empty table if given no promises", function()
			local promise = Promise.all({})
			local success, value = promise:_unwrap()

			expect(success).to.equal(true)
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(value).to.be.a("table")
			expect(next(value)).to.equal(nil)
		end)

		it("should error if given non-promise values", function()
			expect(function()
				Promise.all({ {}, {}, {} })
			end).to.throw()
		end)

		it("should wait for all promises to be resolved and return their values", function()
			local resolveFunctions = {}

			local testValuesLength, testValues = pack(1, "A string", nil, false)

			local promises = {}

			for i = 1, testValuesLength do
				promises[i] = Promise.new(function(resolve)
					resolveFunctions[i] = { resolve, testValues[i] }
				end)
			end

			local combinedPromise = Promise.all(promises)

			for _, resolve in ipairs(resolveFunctions) do
				expect(combinedPromise:getStatus()).to.equal(Promise.Status.Started)
				resolve[1](resolve[2])
			end

			local resultLength, result = pack(combinedPromise:_unwrap())
			local success, resolved = unpack(result, 1, resultLength)

			expect(resultLength).to.equal(2)
			expect(success).to.equal(true)
			expect(resolved).to.be.a("table")
			expect(#resolved).to.equal(#promises)

			for i = 1, testValuesLength do
				expect(resolved[i]).to.equal(testValues[i])
			end
		end)

		it("should reject if any individual promise rejected", function()
			local rejectA
			local resolveB

			local a = Promise.new(function(_, reject)
				rejectA = reject
			end)

			local b = Promise.new(function(resolve)
				resolveB = resolve
			end)

			local combinedPromise = Promise.all({ a, b })

			expect(combinedPromise:getStatus()).to.equal(Promise.Status.Started)

			rejectA("baz", "qux")
			resolveB("foo", "bar")

			local resultLength, result = pack(combinedPromise:_unwrap())
			local success, first, second = unpack(result, 1, resultLength)

			expect(resultLength).to.equal(3)
			expect(success).to.equal(false)
			expect(first).to.equal("baz")
			expect(second).to.equal("qux")
			expect(b:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should not resolve if resolved after rejecting", function()
			local rejectA
			local resolveB

			local a = Promise.new(function(_, reject)
				rejectA = reject
			end)

			local b = Promise.new(function(resolve)
				resolveB = resolve
			end)

			local combinedPromise = Promise.all({ a, b })

			expect(combinedPromise:getStatus()).to.equal(Promise.Status.Started)

			rejectA("baz", "qux")
			resolveB("foo", "bar")

			local resultLength, result = pack(combinedPromise:_unwrap())
			local success, first, second = unpack(result, 1, resultLength)

			expect(resultLength).to.equal(3)
			expect(success).to.equal(false)
			expect(first).to.equal("baz")
			expect(second).to.equal("qux")
		end)

		it("should only reject once", function()
			local rejectA
			local rejectB

			local a = Promise.new(function(_, reject)
				rejectA = reject
			end)

			local b = Promise.new(function(_, reject)
				rejectB = reject
			end)

			local combinedPromise = Promise.all({ a, b })

			expect(combinedPromise:getStatus()).to.equal(Promise.Status.Started)

			rejectA("foo", "bar")

			expect(combinedPromise:getStatus()).to.equal(Promise.Status.Rejected)

			rejectB("baz", "qux")

			local resultLength, result = pack(combinedPromise:_unwrap())
			local success, first, second = unpack(result, 1, resultLength)

			expect(resultLength).to.equal(3)
			expect(success).to.equal(false)
			expect(first).to.equal("foo")
			expect(second).to.equal("bar")
		end)

		it("should error if a non-array table is passed in", function()
			local ok, err = pcall(function()
				Promise.all(Promise.new(function() end))
			end)

			expect(ok).to.be.ok()
			expect(err:find("Non%-promise")).to.be.ok()
		end)

		it("should cancel pending promises if one rejects", function()
			local p = Promise.new(function() end)
			expect(Promise.all({
				Promise.resolve(),
				Promise.reject(),
				p,
			}):getStatus()).to.equal(Promise.Status.Rejected)
			expect(p:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should cancel promises if it is cancelled", function()
			local p = Promise.new(function() end)
			p:andThen(function() end)

			local promises = {
				Promise.new(function() end),
				Promise.new(function() end),
				p,
			}

			Promise.all(promises):cancel()

			expect(promises[1]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[2]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[3]:getStatus()).to.equal(Promise.Status.Started)
		end)
	end)

	describe("Promise.fold", function()
		it("should return the initial value in a promise when the list is empty", function()
			local initialValue = {}
			local result = Promise.fold({}, function()
				error("should not be called")
			end, initialValue)

			expect(Promise.is(result)).to.equal(true)
			expect(result:getStatus()).to.equal(Promise.Status.Resolved)
			expect(result:expect()).to.equal(initialValue)
		end)

		it("should accept promises in the list", function()
			local resolve

			local sum = Promise.fold({ Promise.new(function(r)
				resolve = r
			end), 2, 3 }, function(sum, element)
				return sum + element
			end, 0)

			resolve(1)

			expect(Promise.is(sum)).to.equal(true)
			expect(sum:getStatus()).to.equal(Promise.Status.Resolved)
			expect(sum:expect()).to.equal(6)
		end)

		it("should always return a promise even if the list or reducer don't use them", function()
			local sum = Promise.fold({ 1, 2, 3 }, function(sum, element, index)
				if index == 2 then
					return Promise.delay(1):andThenReturn(sum + element)
				else
					return sum + element
				end
			end, 0)
			expect(Promise.is(sum)).to.equal(true)
			expect(sum:getStatus()).to.equal(Promise.Status.Started)
			advanceTime(2)
			expect(sum:getStatus()).to.equal(Promise.Status.Resolved)
			expect(sum:expect()).to.equal(6)
		end)

		it("should return the first rejected promise", function()
			local errorMessage = "foo"
			local sum = Promise.fold({ 1, 2, 3 }, function(sum, element, index)
				if index == 2 then
					return Promise.reject(errorMessage)
				else
					return sum + element
				end
			end, 0)
			expect(Promise.is(sum)).to.equal(true)
			local status, rejection = sum:awaitStatus()
			expect(status).to.equal(Promise.Status.Rejected)
			expect(rejection).to.equal(errorMessage)
		end)

		it("should return the first canceled promise", function()
			local secondPromise
			local sum = Promise.fold({ 1, 2, 3 }, function(sum, element, index)
				if index == 1 then
					return sum + element
				elseif index == 2 then
					secondPromise = Promise.delay(1):andThenReturn(sum + element)
					return secondPromise
				else
					error("this should not run if the promise is cancelled")
				end
			end, 0)
			expect(Promise.is(sum)).to.equal(true)
			expect(sum:getStatus()).to.equal(Promise.Status.Started)
			secondPromise:cancel()
			expect(sum:getStatus()).to.equal(Promise.Status.Cancelled)
		end)
	end)

	describe("Promise.race", function()
		it("should resolve with the first settled value", function()
			local promise = Promise.race({
				Promise.resolve(1),
				Promise.resolve(2),
			}):andThen(function(value)
				expect(value).to.equal(1)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
		end)

		it("should cancel other promises", function()
			local promise = Promise.new(function() end)
			promise:andThen(function() end)
			local promises = {
				promise,
				Promise.new(function() end),
				Promise.new(function(resolve)
					resolve(2)
				end),
			}

			local promise = Promise.race(promises)

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal(2)
			expect(promises[1]:getStatus()).to.equal(Promise.Status.Started)
			expect(promises[2]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[3]:getStatus()).to.equal(Promise.Status.Resolved)

			local p = Promise.new(function() end)
			expect(Promise.race({
				Promise.reject(),
				Promise.resolve(),
				p,
			}):getStatus()).to.equal(Promise.Status.Rejected)
			expect(p:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should error if a non-array table is passed in", function()
			local ok, err = pcall(function()
				Promise.race(Promise.new(function() end))
			end)

			expect(ok).to.be.ok()
			expect(err:find("Non%-promise")).to.be.ok()
		end)

		it("should cancel promises if it is cancelled", function()
			local p = Promise.new(function() end)
			p:andThen(function() end)

			local promises = {
				Promise.new(function() end),
				Promise.new(function() end),
				p,
			}

			Promise.race(promises):cancel()

			expect(promises[1]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[2]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[3]:getStatus()).to.equal(Promise.Status.Started)
		end)
	end)

	describe("Promise.promisify", function()
		it("should wrap functions", function()
			local function test(n)
				return n + 1
			end

			local promisified = Promise.promisify(test)
			local promise = promisified(1)
			local success, result = promise:_unwrap()

			expect(success).to.equal(true)
			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(result).to.equal(2)
		end)

		it("should catch errors after a yield", function()
			local bindable = Instance.new("BindableEvent")
			local test = Promise.promisify(function()
				bindable.Event:Wait()
				error("errortext")
			end)

			local promise = test()

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			bindable:Fire()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(tostring(promise._values[1]):find("errortext")).to.be.ok()
		end)
	end)

	describe("Promise.tap", function()
		it("should thread through values", function()
			local first, second

			Promise.resolve(1)
				:andThen(function(v)
					return v + 1
				end)
				:tap(function(v)
					first = v
					return v + 1
				end)
				:andThen(function(v)
					second = v
				end)

			expect(first).to.equal(2)
			expect(second).to.equal(2)
		end)

		it("should chain onto promises", function()
			local resolveInner, finalValue

			local promise = Promise.resolve(1)
				:tap(function()
					return Promise.new(function(resolve)
						resolveInner = resolve
					end)
				end)
				:andThen(function(v)
					finalValue = v
				end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(finalValue).to.never.be.ok()

			resolveInner(1)

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(finalValue).to.equal(1)
		end)
	end)

	describe("Promise.try", function()
		it("should catch synchronous errors", function()
			local errorText
			Promise.try(function()
				error("errortext")
			end):catch(function(e)
				errorText = tostring(e)
			end)

			expect(errorText:find("errortext")).to.be.ok()
		end)

		it("should reject with error objects", function()
			local object = {}
			local success, value = Promise.try(function()
				error(object)
			end):_unwrap()

			expect(success).to.equal(false)
			expect(value).to.equal(object)
		end)

		it("should catch asynchronous errors", function()
			local bindable = Instance.new("BindableEvent")
			local promise = Promise.try(function()
				bindable.Event:Wait()
				error("errortext")
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			bindable:Fire()
			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(tostring(promise._values[1]):find("errortext")).to.be.ok()
		end)
	end)

	describe("Promise:andThenReturn", function()
		it("should return the given values", function()
			local value1, value2

			Promise.resolve():andThenReturn(1, 2):andThen(function(one, two)
				value1 = one
				value2 = two
			end)

			expect(value1).to.equal(1)
			expect(value2).to.equal(2)
		end)
	end)

	describe("Promise:andThenCall", function()
		it("should call the given function with arguments", function()
			local value1, value2
			Promise.resolve():andThenCall(function(a, b)
				value1 = a
				value2 = b
			end, 3, 4)

			expect(value1).to.equal(3)
			expect(value2).to.equal(4)
		end)
	end)

	describe("Promise.some", function()
		it("should resolve once the goal is reached", function()
			local p = Promise.some({
				Promise.resolve(1),
				Promise.reject(),
				Promise.resolve(2),
			}, 2)
			expect(p:getStatus()).to.equal(Promise.Status.Resolved)
			expect(p._values[1][1]).to.equal(1)
			expect(p._values[1][2]).to.equal(2)
		end)

		it("should error if the goal can't be reached", function()
			expect(Promise.some({
				Promise.resolve(),
				Promise.reject(),
			}, 2):getStatus()).to.equal(Promise.Status.Rejected)

			local reject
			local p = Promise.some({
				Promise.resolve(),
				Promise.new(function(_, r)
					reject = r
				end),
			}, 2)

			expect(p:getStatus()).to.equal(Promise.Status.Started)
			reject("foo")
			expect(p:getStatus()).to.equal(Promise.Status.Rejected)
			expect(p._values[1]).to.equal("foo")
		end)

		it("should cancel pending Promises once the goal is reached", function()
			local resolve
			local pending1 = Promise.new(function() end)
			local pending2 = Promise.new(function(r)
				resolve = r
			end)

			local some = Promise.some({
				pending1,
				pending2,
				Promise.resolve(),
			}, 2)

			expect(some:getStatus()).to.equal(Promise.Status.Started)
			expect(pending1:getStatus()).to.equal(Promise.Status.Started)
			expect(pending2:getStatus()).to.equal(Promise.Status.Started)

			resolve()

			expect(some:getStatus()).to.equal(Promise.Status.Resolved)
			expect(pending1:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(pending2:getStatus()).to.equal(Promise.Status.Resolved)
		end)

		it("should error if passed a non-number", function()
			expect(function()
				Promise.some({}, "non-number")
			end).to.throw()
		end)

		it("should return an empty array if amount is 0", function()
			local p = Promise.some({
				Promise.resolve(2),
			}, 0)

			expect(p:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#p._values[1]).to.equal(0)
		end)

		it("should not return extra values", function()
			local p = Promise.some({
				Promise.resolve(1),
				Promise.resolve(2),
				Promise.resolve(3),
				Promise.resolve(4),
			}, 2)

			expect(p:getStatus()).to.equal(Promise.Status.Resolved)
			expect(#p._values[1]).to.equal(2)
			expect(p._values[1][1]).to.equal(1)
			expect(p._values[1][2]).to.equal(2)
		end)

		it("should cancel promises if it is cancelled", function()
			local p = Promise.new(function() end)
			p:andThen(function() end)

			local promises = {
				Promise.new(function() end),
				Promise.new(function() end),
				p,
			}

			Promise.some(promises, 3):cancel()

			expect(promises[1]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[2]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[3]:getStatus()).to.equal(Promise.Status.Started)
		end)

		describe("Promise.any", function()
			it("should return the value directly", function()
				local p = Promise.any({
					Promise.reject(),
					Promise.reject(),
					Promise.resolve(1),
				})

				expect(p:getStatus()).to.equal(Promise.Status.Resolved)
				expect(p._values[1]).to.equal(1)
			end)

			it("should error if all are rejected", function()
				expect(Promise.any({
					Promise.reject(),
					Promise.reject(),
					Promise.reject(),
				}):getStatus()).to.equal(Promise.Status.Rejected)
			end)
		end)
	end)

	describe("Promise.allSettled", function()
		it("should resolve with an array of PromiseStatuses", function()
			local reject
			local p = Promise.allSettled({
				Promise.resolve(),
				Promise.reject(),
				Promise.resolve(),
				Promise.new(function(_, r)
					reject = r
				end),
			})

			expect(p:getStatus()).to.equal(Promise.Status.Started)
			reject()
			expect(p:getStatus()).to.equal(Promise.Status.Resolved)
			expect(p._values[1][1]).to.equal(Promise.Status.Resolved)
			expect(p._values[1][2]).to.equal(Promise.Status.Rejected)
			expect(p._values[1][3]).to.equal(Promise.Status.Resolved)
			expect(p._values[1][4]).to.equal(Promise.Status.Rejected)
		end)

		it("should cancel promises if it is cancelled", function()
			local p = Promise.new(function() end)
			p:andThen(function() end)

			local promises = {
				Promise.new(function() end),
				Promise.new(function() end),
				p,
			}

			Promise.allSettled(promises):cancel()

			expect(promises[1]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[2]:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(promises[3]:getStatus()).to.equal(Promise.Status.Started)
		end)
	end)

	describe("Promise:await", function()
		it("should return the correct values", function()
			local promise = Promise.resolve(5, 6, nil, 7)

			local a, b, c, d, e = promise:await()

			expect(a).to.equal(true)
			expect(b).to.equal(5)
			expect(c).to.equal(6)
			expect(d).to.equal(nil)
			expect(e).to.equal(7)
		end)

		it("should work if yielding is needed", function()
			local ran = false
			task.spawn(function()
				local _, actualTime = Promise.delay(1):await()
				expect(type(actualTime)).to.equal("number")
				ran = true
			end)

			advanceTime(2)
			expect(ran).to.equal(true)
		end)
	end)

	describe("Promise:expect", function()
		it("should throw the correct values", function()
			local rejectionValue = {}
			local promise = Promise.reject(rejectionValue)

			local success, value = pcall(function()
				promise:expect()
			end)

			expect(success).to.equal(false)
			expect(value).to.equal(rejectionValue)
		end)
	end)

	describe("Promise:now", function()
		it("should resolve if the Promise is resolved", function()
			local success, value = Promise.resolve("foo"):now():_unwrap()

			expect(success).to.equal(true)
			expect(value).to.equal("foo")
		end)

		it("should reject if the Promise is not resolved", function()
			local success, value = Promise.new(function() end):now():_unwrap()

			expect(success).to.equal(false)
			expect(Promise.Error.isKind(value, "NotResolvedInTime")).to.equal(true)
		end)

		it("should reject with a custom rejection value", function()
			local success, value = Promise.new(function() end):now("foo"):_unwrap()

			expect(success).to.equal(false)
			expect(value).to.equal("foo")
		end)
	end)

	describe("Promise.each", function()
		it("should iterate", function()
			local ok, result = Promise.each({
				"foo",
				"bar",
				"baz",
				"qux",
			}, function(...)
				return { ... }
			end):_unwrap()

			expect(ok).to.equal(true)
			expect(result[1][1]).to.equal("foo")
			expect(result[1][2]).to.equal(1)
			expect(result[2][1]).to.equal("bar")
			expect(result[2][2]).to.equal(2)
			expect(result[3][1]).to.equal("baz")
			expect(result[3][2]).to.equal(3)
			expect(result[4][1]).to.equal("qux")
			expect(result[4][2]).to.equal(4)
		end)

		it("should iterate serially", function()
			local resolves = {}
			local callCounts = {}

			local promise = Promise.each({
				"foo",
				"bar",
				"baz",
			}, function(value, index)
				callCounts[index] = (callCounts[index] or 0) + 1

				return Promise.new(function(resolve)
					table.insert(resolves, function()
						resolve(value:upper())
					end)
				end)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(#resolves).to.equal(1)
			expect(callCounts[1]).to.equal(1)
			expect(callCounts[2]).to.never.be.ok()

			table.remove(resolves, 1)()

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(#resolves).to.equal(1)
			expect(callCounts[1]).to.equal(1)
			expect(callCounts[2]).to.equal(1)
			expect(callCounts[3]).to.never.be.ok()

			table.remove(resolves, 1)()

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(callCounts[1]).to.equal(1)
			expect(callCounts[2]).to.equal(1)
			expect(callCounts[3]).to.equal(1)

			table.remove(resolves, 1)()

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(type(promise._values[1])).to.equal("table")
			expect(type(promise._values[2])).to.equal("nil")

			local result = promise._values[1]

			expect(result[1]).to.equal("FOO")
			expect(result[2]).to.equal("BAR")
			expect(result[3]).to.equal("BAZ")
		end)

		it("should reject with the value if the predicate promise rejects", function()
			local promise = Promise.each({ 1, 2, 3 }, function()
				return Promise.reject("foobar")
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal("foobar")
		end)

		it("should allow Promises to be in the list and wait when it gets to them", function()
			local innerResolve
			local innerPromise = Promise.new(function(resolve)
				innerResolve = resolve
			end)

			local promise = Promise.each({
				innerPromise,
			}, function(value)
				return value * 2
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			innerResolve(2)

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1][1]).to.equal(4)
		end)

		it("should reject with the value if a Promise from the list rejects", function()
			local called = false
			local promise = Promise.each({ 1, 2, Promise.reject("foobar") }, function(value)
				called = true
				return "never"
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal("foobar")
			expect(called).to.equal(false)
		end)

		it("should reject immediately if there's a cancelled Promise in the list initially", function()
			local cancelled = Promise.new(function() end)
			cancelled:cancel()

			local called = false
			local promise = Promise.each({ 1, 2, cancelled }, function()
				called = true
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(called).to.equal(false)
			expect(promise._values[1].kind).to.equal(Promise.Error.Kind.AlreadyCancelled)
		end)

		it("should stop iteration if Promise.each is cancelled", function()
			local callCounts = {}

			local promise = Promise.each({
				"foo",
				"bar",
				"baz",
			}, function(value, index)
				callCounts[index] = (callCounts[index] or 0) + 1

				return Promise.new(function() end)
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)
			expect(callCounts[1]).to.equal(1)
			expect(callCounts[2]).to.never.be.ok()

			promise:cancel()

			expect(promise:getStatus()).to.equal(Promise.Status.Cancelled)
			expect(callCounts[1]).to.equal(1)
			expect(callCounts[2]).to.never.be.ok()
		end)

		it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function()
			local innerPromise

			local promise = Promise.each({
				"foo",
				"bar",
				"baz",
			}, function(value, index)
				innerPromise = Promise.new(function() end)
				return innerPromise
			end)

			promise:cancel()

			expect(innerPromise:getStatus()).to.equal(Promise.Status.Cancelled)
		end)

		it("should cancel Promises in the list if Promise.each is cancelled", function()
			local innerPromise = Promise.new(function() end)

			local promise = Promise.each({ innerPromise }, function() end)

			promise:cancel()

			expect(innerPromise:getStatus()).to.equal(Promise.Status.Cancelled)
		end)
	end)

	describe("Promise.retry", function()
		it("should retry N times", function()
			local counter = 0

			local promise = Promise.retry(function(parameter)
				expect(parameter).to.equal("foo")

				counter = counter + 1

				if counter == 5 then
					return Promise.resolve("ok")
				end

				return Promise.reject("fail")
			end, 5, "foo")

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal("ok")
		end)

		it("should reject if threshold is exceeded", function()
			local promise = Promise.retry(function()
				return Promise.reject("fail")
			end, 5)

			expect(promise:getStatus()).to.equal(Promise.Status.Rejected)
			expect(promise._values[1]).to.equal("fail")
		end)
	end)

	describe("Promise.retryWithDelay", function()
		it("should retry after a delay", function()
			local counter = 0

			local promise = Promise.retryWithDelay(function(parameter)
				expect(parameter).to.equal("foo")

				counter = counter + 1

				if counter == 3 then
					return Promise.resolve("ok")
				end

				return Promise.reject("fail")
			end, 3, 10, "foo")

			expect(counter).to.equal(1)

			advanceTime(11)

			expect(counter).to.equal(2)

			advanceTime(11)

			expect(counter).to.equal(3)

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal("ok")
		end)
	end)

	describe("Promise.fromEvent", function()
		it("should convert a Promise into an event", function()
			local event = Instance.new("BindableEvent")

			local promise = Promise.fromEvent(event.Event)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			event:Fire("foo")

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal("foo")
		end)

		it("should convert a Promise into an event with the predicate", function()
			local event = Instance.new("BindableEvent")

			local promise = Promise.fromEvent(event.Event, function(param)
				return param == "foo"
			end)

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			event:Fire("bar")

			expect(promise:getStatus()).to.equal(Promise.Status.Started)

			event:Fire("foo")

			expect(promise:getStatus()).to.equal(Promise.Status.Resolved)
			expect(promise._values[1]).to.equal("foo")
		end)
	end)

	describe("Promise.is", function()
		it("should work with current version", function()
			local promise = Promise.resolve(1)

			expect(Promise.is(promise)).to.equal(true)
		end)

		it("should work with any object with an andThen", function()
			local obj = {
				andThen = function()
					return 1
				end,
			}

			expect(Promise.is(obj)).to.equal(true)
		end)

		it("should work with older promises", function()
			local OldPromise = {}
			OldPromise.prototype = {}
			OldPromise.__index = OldPromise.prototype

			function OldPromise.prototype:andThen() end

			local oldPromise = setmetatable({}, OldPromise)

			expect(Promise.is(oldPromise)).to.equal(true)
		end)
	end)
end

]]

 

return function() -- Line: 1
    local script_Parent = require(script.Parent);
    script_Parent.TEST = true;
    local BindableEvent = Instance.new("BindableEvent");
    script_Parent._timeEvent = BindableEvent.Event;
    local u1 = 0;

    function script_Parent._getTime() -- Line: 12
        -- upvalues: u1 (ref)
        return u1;
    end;

    local function advanceTime(p2) -- Line: 16
        -- upvalues: u1 (ref), BindableEvent (copy)
        local v3 = p2 or 0.016666666666666666;
        u1 = u1 + v3;
        BindableEvent:Fire(v3);
    end;

    local function pack(...) -- Line: 24
        return select("#", ...), { ... };
    end;

    describe("Promise.Status", function() -- Line: 30
        -- upvalues: script_Parent (copy)
        it("should error if indexing nil value", function() -- Line: 31
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 32
                -- upvalues: script_Parent (ref)
                local _ = script_Parent.Status.wrong;
            end).to.throw();
        end);
    end);
    describe("Unhandled rejection signal", function() -- Line: 38
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should call unhandled rejection callbacks", function() -- Line: 39
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u6 = script_Parent.new(function(p4, p5) -- Line: 40
                p5(1, 2);
            end);
            local u7 = 0;
            local v11 = script_Parent.onUnhandledRejection(function(p8, p9, p10) -- Line: 46, Name: callback
                -- upvalues: u7 (ref), u6 (copy)
                u7 = u7 + 1;
                expect(p8).to.equal(u6);
                expect(p9).to.equal(1);
                expect(p10).to.equal(2);
            end);
            advanceTime();
            expect(u7).to.equal(1);
            v11();
            script_Parent.new(function(p12, p13) -- Line: 62
                p13(3, 4);
            end);
            advanceTime();
            expect(u7).to.equal(1);
        end);
    end);
    describe("Promise.new", function() -- Line: 72
        -- upvalues: script_Parent (copy)
        it("should instantiate with a callback", function() -- Line: 73
            -- upvalues: script_Parent (ref)
            local v14 = script_Parent.new(function() -- Line: 74
            end);
            expect(v14).to.be.ok();
        end);
        it("should invoke the given callback with resolve and reject", function() -- Line: 79
            -- upvalues: script_Parent (ref)
            local u15 = 0;
            local u16 = nil;
            local u17 = nil;
            local v20 = script_Parent.new(function(p18, p19) -- Line: 84
                -- upvalues: u15 (ref), u16 (ref), u17 (ref)
                u15 = u15 + 1;
                u16 = p18;
                u17 = p19;
            end);
            expect(v20).to.be.ok();
            expect(u15).to.equal(1);
            expect(u16).to.be.a("function");
            expect(u17).to.be.a("function");
            expect(v20:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        it("should resolve promises on resolve()", function() -- Line: 98
            -- upvalues: script_Parent (ref)
            local u21 = 0;
            local v23 = script_Parent.new(function(p22) -- Line: 101
                -- upvalues: u21 (ref)
                u21 = u21 + 1;
                p22();
            end);
            expect(v23).to.be.ok();
            expect(u21).to.equal(1);
            expect(v23:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should reject promises on reject()", function() -- Line: 111
            -- upvalues: script_Parent (ref)
            local u24 = 0;
            local v27 = script_Parent.new(function(p25, p26) -- Line: 114
                -- upvalues: u24 (ref)
                u24 = u24 + 1;
                p26();
            end);
            expect(v27).to.be.ok();
            expect(u24).to.equal(1);
            expect(v27:getStatus()).to.equal(script_Parent.Status.Rejected);
        end);
        it("should reject on error in callback", function() -- Line: 124
            -- upvalues: script_Parent (ref)
            local u28 = 0;
            local v29 = script_Parent.new(function() -- Line: 127
                -- upvalues: u28 (ref)
                u28 = u28 + 1;
                error("hahah");
            end);
            expect(v29).to.be.ok();
            expect(u28).to.equal(1);
            expect(v29:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v29._values[1]):find("hahah")).to.be.ok();
            expect(tostring(v29._values[1]):find("init.spec")).to.be.ok();
            expect(tostring(v29._values[1]):find("runExecutor")).to.be.ok();
        end);
        it("should work with C functions", function() -- Line: 142
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 143
                -- upvalues: script_Parent (ref)
                script_Parent.new(tick):andThen(tick);
            end).to.never.throw();
        end);
        it("should have a nice tostring", function() -- Line: 148
            -- upvalues: script_Parent (ref)
            expect(tostring(script_Parent.resolve()):gmatch("Promise(Resolved)")).to.be.ok();
        end);
        it("should allow yielding", function() -- Line: 152
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v31 = script_Parent.new(function(p30) -- Line: 154
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                p30(5);
            end);
            expect(v31:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            expect(v31:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v31._values[1]).to.equal(5);
        end);
        it("should preserve stack traces of resolve-chained promises", function() -- Line: 165
            -- upvalues: script_Parent (ref)
            local function nestedCall(p32) -- Line: 166
                error(p32);
            end;

            local v34 = script_Parent.new(function(p33) -- Line: 170
                -- upvalues: script_Parent (ref)
                p33(script_Parent.new(function() -- Line: 171
                    error("sample text");
                end));
            end);
            expect(v34:getStatus()).to.equal(script_Parent.Status.Rejected);
            local v35 = tostring(v34._values[1]);
            expect(v35:find("sample text")).to.be.ok();
            expect(v35:find("nestedCall")).to.be.ok();
            expect(v35:find("runExecutor")).to.be.ok();
            expect(v35:find("runPlanNode")).to.be.ok();
            expect(v35:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok();
        end);
        it("should report errors from Promises with _error (< v2)", function() -- Line: 188
            -- upvalues: script_Parent (ref)
            local v36 = script_Parent.reject();
            v36._error = "Sample error";
            local v37 = script_Parent.resolve():andThenReturn(v36);
            expect(v37:getStatus()).to.equal(script_Parent.Status.Rejected);
            local v38 = tostring(v37._values[1]);
            expect(v38:find("Sample error")).to.be.ok();
            expect(v38:find("...Rejected because it was chained to the following Promise, which encountered an error:")).to.be.ok();
            expect(v38:find("%[No stack trace available")).to.be.ok();
        end);
        it("should allow callable tables", function() -- Line: 204
            -- upvalues: script_Parent (ref)
            local v41 = script_Parent.new((setmetatable({}, {
                __call = function(p39, p40) -- Line: 206, Name: __call
                    p40(1);
                end
            })));
            local u42 = false;
            v41:andThen((setmetatable({}, {
                __call = function(p43, p44) -- Line: 213, Name: __call
                    -- upvalues: u42 (ref)
                    expect(p44).to.equal(1);
                    u42 = true;
                end
            })));
            expect(u42).to.equal(true);
        end);
        itSKIP("should close the thread after resolve", function() -- Line: 222
            -- upvalues: script_Parent (ref)
            local u45 = 0;
            script_Parent.new(function(p46) -- Line: 224
                -- upvalues: u45 (ref), script_Parent (ref)
                u45 = u45 + 1;
                p46();
                script_Parent.delay(1):await();
                u45 = u45 + 1;
            end);
            task.wait(1);
            expect(u45).to.equal(1);
        end);
    end);
    describe("Promise.defer", function() -- Line: 237
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should execute after the time event", function() -- Line: 238
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u47 = 0;
            local v52 = script_Parent.defer(function(p48, p49, p50, p51) -- Line: 240
                -- upvalues: u47 (ref)
                expect((type(p48))).to.equal("function");
                expect((type(p49))).to.equal("function");
                expect((type(p50))).to.equal("function");
                expect((type(p51))).to.equal("nil");
                u47 = u47 + 1;
                p48("foo");
            end);
            expect(u47).to.equal(0);
            expect(v52:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u47).to.equal(1);
            expect(v52:getStatus()).to.equal(script_Parent.Status.Resolved);
            advanceTime();
            expect(u47).to.equal(1);
        end);
    end);
    describe("Promise.delay", function() -- Line: 263
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should schedule promise resolution", function() -- Line: 264
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local v53 = script_Parent.delay(1);
            expect(v53:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(v53:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(1);
            expect(v53:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should allow for delays to be cancelled", function() -- Line: 276
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u54 = script_Parent.delay(2);
            script_Parent.delay(1):andThen(function() -- Line: 279
                -- upvalues: u54 (copy)
                u54:cancel();
            end);
            expect(u54:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime();
            expect(u54:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(1);
            expect(u54:getStatus()).to.equal(script_Parent.Status.Cancelled);
            advanceTime(1);
        end);
    end);
    describe("Promise.resolve", function() -- Line: 292
        -- upvalues: script_Parent (copy)
        it("should immediately resolve with a value", function() -- Line: 293
            -- upvalues: script_Parent (ref)
            local v55 = script_Parent.resolve(5, 6);
            expect(v55).to.be.ok();
            expect(v55:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v55._values[1]).to.equal(5);
            expect(v55._values[2]).to.equal(6);
        end);
        it("should chain onto passed promises", function() -- Line: 302
            -- upvalues: script_Parent (ref)
            local v58 = script_Parent.resolve(script_Parent.new(function(p56, p57) -- Line: 303
                p57(7);
            end));
            expect(v58).to.be.ok();
            expect(v58:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v58._values[1]).to.equal(7);
        end);
    end);
    describe("Promise.reject", function() -- Line: 313
        -- upvalues: script_Parent (copy)
        it("should immediately reject with a value", function() -- Line: 314
            -- upvalues: script_Parent (ref)
            local v59 = script_Parent.reject(6, 7);
            expect(v59).to.be.ok();
            expect(v59:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v59._values[1]).to.equal(6);
            expect(v59._values[2]).to.equal(7);
        end);
        it("should pass a promise as-is as an error", function() -- Line: 323
            -- upvalues: script_Parent (ref)
            local v61 = script_Parent.new(function(p60) -- Line: 324
                p60(6);
            end);
            local v62 = script_Parent.reject(v61);
            expect(v62).to.be.ok();
            expect(v62:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v62._values[1]).to.equal(v61);
        end);
    end);
    describe("Promise:andThen", function() -- Line: 336
        -- upvalues: script_Parent (copy), pack (copy)
        it("should allow yielding", function() -- Line: 337
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v63 = script_Parent.resolve():andThen(function() -- Line: 339
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();

                return 5;
            end);
            expect(v63:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            expect(v63:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v63._values[1]).to.equal(5);
        end);
        it("should run andThens on a new thread", function() -- Line: 350
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local u64 = nil;
            local v66 = script_Parent.new(function(p65) -- Line: 354
                -- upvalues: u64 (ref)
                u64 = p65;
            end);
            local v67 = v66:andThen(function() -- Line: 358
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();

                return 5;
            end);
            local v68 = v66:andThen(function() -- Line: 363
                return "foo";
            end);
            expect(v66:getStatus()).to.equal(script_Parent.Status.Started);
            u64();
            expect(v68:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v68._values[1]).to.equal("foo");
            expect(v67:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        it("should chain onto resolved promises", function() -- Line: 374
            -- upvalues: script_Parent (ref), pack (ref)
            local u69 = nil;
            local u70 = nil;
            local u71 = 0;
            local u72 = 0;
            local v73 = script_Parent.resolve(5);
            local v76 = v73:andThen(function(...) -- Line: 382
                -- upvalues: u70 (ref), u69 (ref), pack (ref), u71 (ref)
                local v74, v75 = pack(...);
                u70 = v74;
                u69 = v75;
                u71 = u71 + 1;
            end, function() -- Line: 385
                -- upvalues: u72 (ref)
                u72 = u72 + 1;
            end);
            expect(u72).to.equal(0);
            expect(u71).to.equal(1);
            expect(u70).to.equal(1);
            expect(u69[1]).to.equal(5);
            expect(v73).to.be.ok();
            expect(v73:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v73._values[1]).to.equal(5);
            expect(v76).to.be.ok();
            expect(v76).never.to.equal(v73);
            expect(v76:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v76._values).to.equal(0);
        end);
        it("should chain onto rejected promises", function() -- Line: 405
            -- upvalues: script_Parent (ref), pack (ref)
            local u77 = nil;
            local u78 = nil;
            local u79 = 0;
            local u80 = 0;
            local v81 = script_Parent.reject(5);
            local v84 = v81:andThen(function(...) -- Line: 413
                -- upvalues: u80 (ref)
                u80 = u80 + 1;
            end, function(...) -- Line: 415
                -- upvalues: u78 (ref), u77 (ref), pack (ref), u79 (ref)
                local v82, v83 = pack(...);
                u78 = v82;
                u77 = v83;
                u79 = u79 + 1;
            end);
            expect(u80).to.equal(0);
            expect(u79).to.equal(1);
            expect(u78).to.equal(1);
            expect(u77[1]).to.equal(5);
            expect(v81).to.be.ok();
            expect(v81:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v81._values[1]).to.equal(5);
            expect(v84).to.be.ok();
            expect(v84).never.to.equal(v81);
            expect(v84:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v84._values).to.equal(0);
        end);
        it("should reject on error in callback", function() -- Line: 436
            -- upvalues: script_Parent (ref)
            local u85 = 0;
            local v86 = script_Parent.resolve(1):andThen(function() -- Line: 439
                -- upvalues: u85 (ref)
                u85 = u85 + 1;
                error("hahah");
            end);
            expect(v86).to.be.ok();
            expect(u85).to.equal(1);
            expect(v86:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v86._values[1]):find("hahah")).to.be.ok();
            expect(tostring(v86._values[1]):find("init.spec")).to.be.ok();
            expect(tostring(v86._values[1]):find("runExecutor")).to.be.ok();
        end);
        it("should chain onto asynchronously resolved promises", function() -- Line: 454
            -- upvalues: script_Parent (ref)
            local u87 = nil;
            local u88 = nil;
            local u89 = 0;
            local u90 = 0;
            local u91 = nil;
            local v93 = script_Parent.new(function(p92) -- Line: 461
                -- upvalues: u91 (ref)
                u91 = p92;
            end);
            local v94 = v93:andThen(function(...) -- Line: 465
                -- upvalues: u87 (ref), u88 (ref), u89 (ref)
                u87 = { ... };
                u88 = select("#", ...);
                u89 = u89 + 1;
            end, function() -- Line: 469
                -- upvalues: u90 (ref)
                u90 = u90 + 1;
            end);
            expect(u89).to.equal(0);
            expect(u90).to.equal(0);
            u91(6);
            expect(u90).to.equal(0);
            expect(u89).to.equal(1);
            expect(u88).to.equal(1);
            expect(u87[1]).to.equal(6);
            expect(v93).to.be.ok();
            expect(v93:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v93._values[1]).to.equal(6);
            expect(v94).to.be.ok();
            expect(v94).never.to.equal(v93);
            expect(v94:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v94._values).to.equal(0);
        end);
        it("should chain onto asynchronously rejected promises", function() -- Line: 494
            -- upvalues: script_Parent (ref)
            local u95 = nil;
            local u96 = nil;
            local u97 = 0;
            local u98 = 0;
            local u99 = nil;
            local v102 = script_Parent.new(function(p100, p101) -- Line: 501
                -- upvalues: u99 (ref)
                u99 = p101;
            end);
            local v103 = v102:andThen(function() -- Line: 505
                -- upvalues: u98 (ref)
                u98 = u98 + 1;
            end, function(...) -- Line: 507
                -- upvalues: u95 (ref), u96 (ref), u97 (ref)
                u95 = { ... };
                u96 = select("#", ...);
                u97 = u97 + 1;
            end);
            expect(u97).to.equal(0);
            expect(u98).to.equal(0);
            u99(6);
            expect(u98).to.equal(0);
            expect(u97).to.equal(1);
            expect(u96).to.equal(1);
            expect(u95[1]).to.equal(6);
            expect(v102).to.be.ok();
            expect(v102:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v102._values[1]).to.equal(6);
            expect(v103).to.be.ok();
            expect(v103).never.to.equal(v102);
            expect(v103:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v103._values).to.equal(0);
        end);
        it("should propagate errors through multiple levels", function() -- Line: 534
            -- upvalues: script_Parent (ref)
            local u104 = nil;
            local u105 = nil;
            local u106 = nil;
            script_Parent.new(function(p107, p108) -- Line: 536
                p108(1, 2, 3);
            end):andThen(function() -- Line: 538
            end):catch(function(p109, p110, p111) -- Line: 538
                -- upvalues: u104 (ref), u105 (ref), u106 (ref)
                u104 = p109;
                u105 = p110;
                u106 = p111;
            end);
            expect(u104).to.equal(1);
            expect(u105).to.equal(2);
            expect(u106).to.equal(3);
        end);
        it("should not call queued callbacks from a cancelled sub-promise", function() -- Line: 547
            -- upvalues: script_Parent (ref)
            local u112 = nil;
            local u113 = 0;
            local v115 = script_Parent.new(function(p114) -- Line: 551
                -- upvalues: u112 (ref)
                u112 = p114;
            end);
            v115:andThen(function() -- Line: 555
                -- upvalues: u113 (ref)
                u113 = u113 + 1;
            end);
            v115:andThen(function() -- Line: 560
                -- upvalues: u113 (ref)
                u113 = u113 + 1;
            end):cancel();
            u112("foo");
            expect(u113).to.equal(1);
        end);
    end);
    describe("Promise:cancel", function() -- Line: 571
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should mark promises as cancelled and not resolve or reject them", function() -- Line: 572
            -- upvalues: script_Parent (ref)
            local u116 = 0;
            local u117 = 0;
            local v118 = script_Parent.new(function() -- Line: 575
            end):andThen(function() -- Line: 576
                -- upvalues: u116 (ref)
                u116 = u116 + 1;
            end):finally(function() -- Line: 579
                -- upvalues: u117 (ref)
                u117 = u117 + 1;
            end);
            v118:cancel();
            v118:cancel();
            expect(u116).to.equal(0);
            expect(u117).to.equal(1);
            expect(v118:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should call the cancellation hook once", function() -- Line: 591
            -- upvalues: script_Parent (ref)
            local u119 = 0;
            local v123 = script_Parent.new(function(p120, p121, p122) -- Line: 594
                -- upvalues: u119 (ref)
                p122(function() -- Line: 595
                    -- upvalues: u119 (ref)
                    u119 = u119 + 1;
                end);
            end);
            v123:cancel();
            v123:cancel();
            expect(u119).to.equal(1);
        end);
        it("should propagate cancellations", function() -- Line: 606
            -- upvalues: script_Parent (ref)
            local v124 = script_Parent.new(function() -- Line: 607
            end);
            local v125 = v124:andThen();
            local v126 = v124:andThen();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Started);
            v125:cancel();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Started);
            v126:cancel();
            expect(v124:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v125:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v126:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should affect downstream promises", function() -- Line: 629
            -- upvalues: script_Parent (ref)
            local v127 = script_Parent.new(function() -- Line: 630
            end);
            local v128 = v127:andThen();
            v127:cancel();
            expect(v128:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should track consumers", function() -- Line: 638
            -- upvalues: script_Parent (ref)
            local u129 = script_Parent.new(function() -- Line: 639
            end);
            local v130 = script_Parent.resolve();
            local u131 = v130:andThen(function() -- Line: 641
                -- upvalues: u129 (copy)
                return u129;
            end);
            local v133 = script_Parent.new(function(p132) -- Line: 644
                -- upvalues: u131 (copy)
                p132(u131);
            end);
            local v134 = v133:andThen(function() -- Line: 647
            end);
            expect(u131._parent).to.never.equal(v130);
            expect(v133._parent).to.never.equal(u131);
            expect(v133._consumers[v134]).to.be.ok();
            expect(v134._parent).to.equal(v133);
        end);
        it("should cancel resolved pending promises", function() -- Line: 655
            -- upvalues: script_Parent (ref)
            local u135 = script_Parent.new(function() -- Line: 656
            end);
            local v137 = script_Parent.new(function(p136) -- Line: 658
                -- upvalues: u135 (copy)
                p136(u135);
            end):finally(function() -- Line: 660
            end);
            v137:cancel();
            expect(u135._status).to.equal(script_Parent.Status.Cancelled);
            expect(v137._status).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should close the promise thread", function() -- Line: 668
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u138 = 0;
            script_Parent.new(function() -- Line: 670
                -- upvalues: u138 (ref), script_Parent (ref)
                u138 = u138 + 1;
                script_Parent.delay(1):await();
                u138 = u138 + 1;
            end):cancel();
            advanceTime(2);
            expect(u138).to.equal(1);
        end);
    end);
    describe("Promise:finally", function() -- Line: 683
        -- upvalues: script_Parent (copy)
        it("should be called upon resolve, reject, or cancel", function() -- Line: 684
            -- upvalues: script_Parent (ref)
            local u139 = 0;

            local function finally() -- Line: 687
                -- upvalues: u139 (ref)
                u139 = u139 + 1;
            end;

            script_Parent.new(function(p140, p141) -- Line: 692
                p140();
            end):finally(finally);
            script_Parent.resolve():andThen(function() -- Line: 697
            end):finally(finally):finally(finally);
            script_Parent.reject():finally(finally);
            script_Parent.new(function() -- Line: 702
            end):finally(finally):cancel();
            expect(u139).to.equal(5);
        end);
        it("should not forward return values", function() -- Line: 708
            -- upvalues: script_Parent (ref)
            local u142 = nil;
            script_Parent.resolve(2):finally(function() -- Line: 712
                return 1;
            end):andThen(function(p143) -- Line: 715
                -- upvalues: u142 (ref)
                u142 = p143;
            end);
            expect(u142).to.equal(2);
        end);
        it("should not consume rejections", function() -- Line: 722
            -- upvalues: script_Parent (ref)
            local u144 = false;
            local u145 = false;
            script_Parent.reject(5):finally(function() -- Line: 726
                return 42;
            end):andThen(function() -- Line: 729
                -- upvalues: u145 (ref)
                u145 = true;
            end):catch(function(p146) -- Line: 732
                -- upvalues: u144 (ref)
                u144 = true;
                expect(p146).to.equal(5);
            end);
            expect(u144).to.equal(true);
            expect(u145).to.equal(false);
        end);
        it("should wait for returned promises", function() -- Line: 741
            -- upvalues: script_Parent (ref)
            local u147 = nil;
            local v149 = script_Parent.reject("foo"):finally(function() -- Line: 743
                -- upvalues: script_Parent (ref), u147 (ref)
                return script_Parent.new(function(p148) -- Line: 744
                    -- upvalues: u147 (ref)
                    u147 = p148;
                end);
            end);
            expect(v149:getStatus()).to.equal(script_Parent.Status.Started);
            u147();
            expect(v149:getStatus()).to.equal(script_Parent.Status.Rejected);
            local _, v150 = v149:_unwrap();
            expect(v150).to.equal("foo");
        end);
        it("should reject with a returned rejected promise\'s value", function() -- Line: 758
            -- upvalues: script_Parent (ref)
            local u151 = nil;
            local v154 = script_Parent.reject("foo"):finally(function() -- Line: 760
                -- upvalues: script_Parent (ref), u151 (ref)
                return script_Parent.new(function(p152, p153) -- Line: 761
                    -- upvalues: u151 (ref)
                    u151 = p153;
                end);
            end);
            expect(v154:getStatus()).to.equal(script_Parent.Status.Started);
            u151("bar");
            expect(v154:getStatus()).to.equal(script_Parent.Status.Rejected);
            local _, v155 = v154:_unwrap();
            expect(v155).to.equal("bar");
        end);
        it("should reject when handler errors", function() -- Line: 775
            -- upvalues: script_Parent (ref)
            local u156 = {};
            local v157, v158 = script_Parent.reject("bar"):finally(function() -- Line: 777
                -- upvalues: u156 (copy)
                error(u156);
            end):_unwrap();
            expect(v157).to.equal(false);
            expect(v158).to.equal(u156);
        end);
        it("should not prevent cancellation", function() -- Line: 787
            -- upvalues: script_Parent (ref)
            local v159 = script_Parent.new(function() -- Line: 788
            end);
            local u160 = false;
            v159:finally(function() -- Line: 791
                -- upvalues: u160 (ref)
                u160 = true;
            end);
            v159:andThen(function() -- Line: 795
            end):cancel();
            expect(v159:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u160).to.equal(true);
        end);
        it("should propagate cancellation downwards", function() -- Line: 803
            -- upvalues: script_Parent (ref)
            local u161 = false;
            local v162 = script_Parent.new(function() -- Line: 806
            end);
            local v163 = v162:finally(function() -- Line: 808
                -- upvalues: u161 (ref)
                u161 = true;
            end);
            v162:cancel();
            expect(v162:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v163:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u161).to.equal(true);
            expect(false).to.equal(false);
        end);
        it("should propagate cancellation upwards", function() -- Line: 821
            -- upvalues: script_Parent (ref)
            local u164 = false;
            local v165 = script_Parent.new(function() -- Line: 824
            end);
            local v166 = v165:finally(function() -- Line: 826
                -- upvalues: u164 (ref)
                u164 = true;
            end);
            v166:cancel();
            expect(v165:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v166:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u164).to.equal(true);
            expect(false).to.equal(false);
        end);
        it("should cancel returned promise if cancelled", function() -- Line: 839
            -- upvalues: script_Parent (ref)
            local u167 = script_Parent.new(function() -- Line: 840
            end);
            script_Parent.resolve():finally(function() -- Line: 842
                -- upvalues: u167 (copy)
                return u167;
            end):cancel();
            expect(u167:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.all", function() -- Line: 852
        -- upvalues: script_Parent (copy), pack (copy)
        it("should error if given something other than a table", function() -- Line: 853
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 854
                -- upvalues: script_Parent (ref)
                script_Parent.all(1);
            end).to.throw();
        end);
        it("should resolve instantly with an empty table if given no promises", function() -- Line: 859
            -- upvalues: script_Parent (ref)
            local v168 = script_Parent.all({});
            local v169, v170 = v168:_unwrap();
            expect(v169).to.equal(true);
            expect(v168:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v170).to.be.a("table");
            expect(next(v170)).to.equal(nil);
        end);
        it("should error if given non-promise values", function() -- Line: 869
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 870
                -- upvalues: script_Parent (ref)
                script_Parent.all({ {}, {}, {} });
            end).to.throw();
        end);
        it("should wait for all promises to be resolved and return their values", function() -- Line: 875
            -- upvalues: pack (ref), script_Parent (ref)
            local v171, u172 = pack(1, "A string", nil, false);
            local u173 = {};
            local v174 = {};

            for i = 1, v171 do
                v174[i] = script_Parent.new(function(p175) -- Line: 883
                    -- upvalues: u173 (copy), i (copy), u172 (copy)
                    u173[i] = { p175, u172[i] };
                end);
                local _ = i;
            end;

            local v176 = script_Parent.all(v174);

            for _, v in ipairs(u173) do
                expect(v176:getStatus()).to.equal(script_Parent.Status.Started);
                v[1](v[2]);
            end;

            local v177, v178 = pack(v176:_unwrap());
            local v179, v180 = unpack(v178, 1, v177);
            expect(v177).to.equal(2);
            expect(v179).to.equal(true);
            expect(v180).to.be.a("table");
            expect(#v180).to.equal(#v174);

            for i = 1, v171 do
                expect(v180[i]).to.equal(u172[i]);
                local _ = i;
            end;
        end);
        it("should reject if any individual promise rejected", function() -- Line: 908
            -- upvalues: script_Parent (ref), pack (ref)
            local u181 = nil;
            local u182 = nil;
            local v185 = script_Parent.new(function(p183, p184) -- Line: 912
                -- upvalues: u181 (ref)
                u181 = p184;
            end);
            local v187 = script_Parent.new(function(p186) -- Line: 916
                -- upvalues: u182 (ref)
                u182 = p186;
            end);
            local v188 = script_Parent.all({ v185, v187 });
            expect(v188:getStatus()).to.equal(script_Parent.Status.Started);
            u181("baz", "qux");
            u182("foo", "bar");
            local v189, v190 = pack(v188:_unwrap());
            local v191, v192, v193 = unpack(v190, 1, v189);
            expect(v189).to.equal(3);
            expect(v191).to.equal(false);
            expect(v192).to.equal("baz");
            expect(v193).to.equal("qux");
            expect(v187:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should not resolve if resolved after rejecting", function() -- Line: 937
            -- upvalues: script_Parent (ref), pack (ref)
            local u194 = nil;
            local u195 = nil;
            local v199 = { script_Parent.new(function(p196, p197) -- Line: 941
                    -- upvalues: u194 (ref)
                    u194 = p197;
                end), (script_Parent.new(function(p198) -- Line: 945
                    -- upvalues: u195 (ref)
                    u195 = p198;
                end)) };
            local v200 = script_Parent.all(v199);
            expect(v200:getStatus()).to.equal(script_Parent.Status.Started);
            u194("baz", "qux");
            u195("foo", "bar");
            local v201, v202 = pack(v200:_unwrap());
            local v203, v204, v205 = unpack(v202, 1, v201);
            expect(v201).to.equal(3);
            expect(v203).to.equal(false);
            expect(v204).to.equal("baz");
            expect(v205).to.equal("qux");
        end);
        it("should only reject once", function() -- Line: 965
            -- upvalues: script_Parent (ref), pack (ref)
            local u206 = nil;
            local u207 = nil;
            local v212 = { script_Parent.new(function(p208, p209) -- Line: 969
                    -- upvalues: u206 (ref)
                    u206 = p209;
                end), (script_Parent.new(function(p210, p211) -- Line: 973
                    -- upvalues: u207 (ref)
                    u207 = p211;
                end)) };
            local v213 = script_Parent.all(v212);
            expect(v213:getStatus()).to.equal(script_Parent.Status.Started);
            u206("foo", "bar");
            expect(v213:getStatus()).to.equal(script_Parent.Status.Rejected);
            u207("baz", "qux");
            local v214, v215 = pack(v213:_unwrap());
            local v216, v217, v218 = unpack(v215, 1, v214);
            expect(v214).to.equal(3);
            expect(v216).to.equal(false);
            expect(v217).to.equal("foo");
            expect(v218).to.equal("bar");
        end);
        it("should error if a non-array table is passed in", function() -- Line: 996
            -- upvalues: script_Parent (ref)
            local success, result = pcall(function() -- Line: 997
                -- upvalues: script_Parent (ref)
                script_Parent.all(script_Parent.new(function() -- Line: 998
                end));
            end);
            expect(success).to.be.ok();
            expect(result:find("Non%-promise")).to.be.ok();
        end);
        it("should cancel pending promises if one rejects", function() -- Line: 1005
            -- upvalues: script_Parent (ref)
            local v219 = script_Parent.new(function() -- Line: 1006
            end);
            expect(script_Parent.all({ script_Parent.resolve(), script_Parent.reject(), v219 }):getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v219:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1015
            -- upvalues: script_Parent (ref)
            local v220 = script_Parent.new(function() -- Line: 1016
            end);
            v220:andThen(function() -- Line: 1017
            end);
            local v221 = { script_Parent.new(function() -- Line: 1020
                end), script_Parent.new(function() -- Line: 1021
                end), v220 };
            script_Parent.all(v221):cancel();
            expect(v221[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v221[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v221[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise.fold", function() -- Line: 1033
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should return the initial value in a promise when the list is empty", function() -- Line: 1034
            -- upvalues: script_Parent (ref)
            local v222 = {};
            local v223 = script_Parent.fold({}, function() -- Line: 1036
                error("should not be called");
            end, v222);
            expect(script_Parent.is(v223)).to.equal(true);
            expect(v223:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v223:expect()).to.equal(v222);
        end);
        it("should accept promises in the list", function() -- Line: 1045
            -- upvalues: script_Parent (ref)
            local u224 = nil;
            local v228 = script_Parent.fold({ script_Parent.new(function(p225) -- Line: 1048
                    -- upvalues: u224 (ref)
                    u224 = p225;
                end), 2, 3 }, function(p226, p227) -- Line: 1050
                return p226 + p227;
            end, 0);
            u224(1);
            expect(script_Parent.is(v228)).to.equal(true);
            expect(v228:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v228:expect()).to.equal(6);
        end);
        it("should always return a promise even if the list or reducer don\'t use them", function() -- Line: 1061
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local v232 = script_Parent.fold({ 1, 2, 3 }, function(p229, p230, p231) -- Line: 1062
                -- upvalues: script_Parent (ref)
                if p231 == 2 then
                    return script_Parent.delay(1):andThenReturn(p229 + p230);
                end;

                return p229 + p230;
            end, 0);
            expect(script_Parent.is(v232)).to.equal(true);
            expect(v232:getStatus()).to.equal(script_Parent.Status.Started);
            advanceTime(2);
            expect(v232:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v232:expect()).to.equal(6);
        end);
        it("should return the first rejected promise", function() -- Line: 1076
            -- upvalues: script_Parent (ref)
            local v236 = script_Parent.fold({ 1, 2, 3 }, function(p233, p234, p235) -- Line: 1078
                -- upvalues: script_Parent (ref)
                if p235 == 2 then
                    return script_Parent.reject("foo");
                end;

                return p233 + p234;
            end, 0);
            expect(script_Parent.is(v236)).to.equal(true);
            local v237, v238 = v236:awaitStatus();
            expect(v237).to.equal(script_Parent.Status.Rejected);
            expect(v238).to.equal("foo");
        end);
        it("should return the first canceled promise", function() -- Line: 1091
            -- upvalues: script_Parent (ref)
            local u239 = nil;
            local v243 = script_Parent.fold({ 1, 2, 3 }, function(p240, p241, p242) -- Line: 1093
                -- upvalues: u239 (ref), script_Parent (ref)
                if p242 == 1 then
                    return p240 + p241;
                end;

                if p242 == 2 then
                    u239 = script_Parent.delay(1):andThenReturn(p240 + p241);

                    return u239;
                end;

                error("this should not run if the promise is cancelled");
            end, 0);
            expect(script_Parent.is(v243)).to.equal(true);
            expect(v243:getStatus()).to.equal(script_Parent.Status.Started);
            u239:cancel();
            expect(v243:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.race", function() -- Line: 1110
        -- upvalues: script_Parent (copy)
        it("should resolve with the first settled value", function() -- Line: 1111
            -- upvalues: script_Parent (ref)
            local v245 = script_Parent.race({ script_Parent.resolve(1), script_Parent.resolve(2) }):andThen(function(p244) -- Line: 1115
                expect(p244).to.equal(1);
            end);
            expect(v245:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should cancel other promises", function() -- Line: 1122
            -- upvalues: script_Parent (ref)
            local v246 = script_Parent.new(function() -- Line: 1123
            end);
            v246:andThen(function() -- Line: 1124
            end);
            local v248 = { v246, script_Parent.new(function() -- Line: 1127
                end), script_Parent.new(function(p247) -- Line: 1128
                    p247(2);
                end) };
            local v249 = script_Parent.race(v248);
            expect(v249:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v249._values[1]).to.equal(2);
            expect(v248[1]:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v248[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v248[3]:getStatus()).to.equal(script_Parent.Status.Resolved);
            local v250 = script_Parent.new(function() -- Line: 1141
            end);
            expect(script_Parent.race({ script_Parent.reject(), script_Parent.resolve(), v250 }):getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v250:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should error if a non-array table is passed in", function() -- Line: 1150
            -- upvalues: script_Parent (ref)
            local success, result = pcall(function() -- Line: 1151
                -- upvalues: script_Parent (ref)
                script_Parent.race(script_Parent.new(function() -- Line: 1152
                end));
            end);
            expect(success).to.be.ok();
            expect(result:find("Non%-promise")).to.be.ok();
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1159
            -- upvalues: script_Parent (ref)
            local v251 = script_Parent.new(function() -- Line: 1160
            end);
            v251:andThen(function() -- Line: 1161
            end);
            local v252 = { script_Parent.new(function() -- Line: 1164
                end), script_Parent.new(function() -- Line: 1165
                end), v251 };
            script_Parent.race(v252):cancel();
            expect(v252[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v252[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v252[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise.promisify", function() -- Line: 1177
        -- upvalues: script_Parent (copy)
        it("should wrap functions", function() -- Line: 1178
            -- upvalues: script_Parent (ref)
            local v254 = script_Parent.promisify(function(p253) -- Line: 1179, Name: test
                return p253 + 1;
            end)(1);
            local v255, v256 = v254:_unwrap();
            expect(v255).to.equal(true);
            expect(v254:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v256).to.equal(2);
        end);
        it("should catch errors after a yield", function() -- Line: 1192
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v257 = script_Parent.promisify(function() -- Line: 1194
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                error("errortext");
            end)();
            expect(v257:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            expect(v257:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v257._values[1]):find("errortext")).to.be.ok();
        end);
    end);
    describe("Promise.tap", function() -- Line: 1208
        -- upvalues: script_Parent (copy)
        it("should thread through values", function() -- Line: 1209
            -- upvalues: script_Parent (ref)
            local u258 = nil;
            local u259 = nil;
            script_Parent.resolve(1):andThen(function(p260) -- Line: 1213
                return p260 + 1;
            end):tap(function(p261) -- Line: 1216
                -- upvalues: u258 (ref)
                u258 = p261;

                return p261 + 1;
            end):andThen(function(p262) -- Line: 1220
                -- upvalues: u259 (ref)
                u259 = p262;
            end);
            expect(u258).to.equal(2);
            expect(u259).to.equal(2);
        end);
        it("should chain onto promises", function() -- Line: 1228
            -- upvalues: script_Parent (ref)
            local u263 = nil;
            local u264 = nil;
            local v267 = script_Parent.resolve(1):tap(function() -- Line: 1232
                -- upvalues: script_Parent (ref), u263 (ref)
                return script_Parent.new(function(p265) -- Line: 1233
                    -- upvalues: u263 (ref)
                    u263 = p265;
                end);
            end):andThen(function(p266) -- Line: 1237
                -- upvalues: u264 (ref)
                u264 = p266;
            end);
            expect(v267:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u264).to.never.be.ok();
            u263(1);
            expect(v267:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(u264).to.equal(1);
        end);
    end);
    describe("Promise.try", function() -- Line: 1251
        -- upvalues: script_Parent (copy)
        it("should catch synchronous errors", function() -- Line: 1252
            -- upvalues: script_Parent (ref)
            local u268 = nil;
            script_Parent.try(function() -- Line: 1254
                error("errortext");
            end):catch(function(p269) -- Line: 1256
                -- upvalues: u268 (ref)
                u268 = tostring(p269);
            end);
            expect(u268:find("errortext")).to.be.ok();
        end);
        it("should reject with error objects", function() -- Line: 1263
            -- upvalues: script_Parent (ref)
            local u270 = {};
            local v271, v272 = script_Parent.try(function() -- Line: 1265
                -- upvalues: u270 (copy)
                error(u270);
            end):_unwrap();
            expect(v271).to.equal(false);
            expect(v272).to.equal(u270);
        end);
        it("should catch asynchronous errors", function() -- Line: 1273
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v273 = script_Parent.try(function() -- Line: 1275
                -- upvalues: BindableEvent2 (copy)
                BindableEvent2.Event:Wait();
                error("errortext");
            end);
            expect(v273:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire();
            expect(v273:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(tostring(v273._values[1]):find("errortext")).to.be.ok();
        end);
    end);
    describe("Promise:andThenReturn", function() -- Line: 1287
        -- upvalues: script_Parent (copy)
        it("should return the given values", function() -- Line: 1288
            -- upvalues: script_Parent (ref)
            local u274 = nil;
            local u275 = nil;
            script_Parent.resolve():andThenReturn(1, 2):andThen(function(p276, p277) -- Line: 1291
                -- upvalues: u274 (ref), u275 (ref)
                u274 = p276;
                u275 = p277;
            end);
            expect(u274).to.equal(1);
            expect(u275).to.equal(2);
        end);
    end);
    describe("Promise:andThenCall", function() -- Line: 1301
        -- upvalues: script_Parent (copy)
        it("should call the given function with arguments", function() -- Line: 1302
            -- upvalues: script_Parent (ref)
            local u278 = nil;
            local u279 = nil;
            script_Parent.resolve():andThenCall(function(p280, p281) -- Line: 1304
                -- upvalues: u278 (ref), u279 (ref)
                u278 = p280;
                u279 = p281;
            end, 3, 4);
            expect(u278).to.equal(3);
            expect(u279).to.equal(4);
        end);
    end);
    describe("Promise.some", function() -- Line: 1314
        -- upvalues: script_Parent (copy)
        it("should resolve once the goal is reached", function() -- Line: 1315
            -- upvalues: script_Parent (ref)
            local v282 = script_Parent.some({ script_Parent.resolve(1), script_Parent.reject(), script_Parent.resolve(2) }, 2);
            expect(v282:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v282._values[1][1]).to.equal(1);
            expect(v282._values[1][2]).to.equal(2);
        end);
        it("should error if the goal can\'t be reached", function() -- Line: 1326
            -- upvalues: script_Parent (ref)
            expect(script_Parent.some({ script_Parent.resolve(), script_Parent.reject() }, 2):getStatus()).to.equal(script_Parent.Status.Rejected);
            local u283 = nil;
            local v286 = script_Parent.some({ script_Parent.resolve(), script_Parent.new(function(p284, p285) -- Line: 1335
                    -- upvalues: u283 (ref)
                    u283 = p285;
                end) }, 2);
            expect(v286:getStatus()).to.equal(script_Parent.Status.Started);
            u283("foo");
            expect(v286:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v286._values[1]).to.equal("foo");
        end);
        it("should cancel pending Promises once the goal is reached", function() -- Line: 1346
            -- upvalues: script_Parent (ref)
            local u287 = nil;
            local v288 = script_Parent.new(function() -- Line: 1348
            end);
            local v290 = script_Parent.new(function(p289) -- Line: 1349
                -- upvalues: u287 (ref)
                u287 = p289;
            end);
            local v291 = script_Parent.some({ v288, v290, script_Parent.resolve() }, 2);
            expect(v291:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v288:getStatus()).to.equal(script_Parent.Status.Started);
            expect(v290:getStatus()).to.equal(script_Parent.Status.Started);
            u287();
            expect(v291:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v288:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v290:getStatus()).to.equal(script_Parent.Status.Resolved);
        end);
        it("should error if passed a non-number", function() -- Line: 1370
            -- upvalues: script_Parent (ref)
            expect(function() -- Line: 1371
                -- upvalues: script_Parent (ref)
                script_Parent.some({}, "non-number");
            end).to.throw();
        end);
        it("should return an empty array if amount is 0", function() -- Line: 1376
            -- upvalues: script_Parent (ref)
            local v292 = script_Parent.some({ script_Parent.resolve(2) }, 0);
            expect(v292:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v292._values[1]).to.equal(0);
        end);
        it("should not return extra values", function() -- Line: 1385
            -- upvalues: script_Parent (ref)
            local v293 = script_Parent.some({
                script_Parent.resolve(1),
                script_Parent.resolve(2),
                script_Parent.resolve(3),
                script_Parent.resolve(4)
            }, 2);
            expect(v293:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(#v293._values[1]).to.equal(2);
            expect(v293._values[1][1]).to.equal(1);
            expect(v293._values[1][2]).to.equal(2);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1399
            -- upvalues: script_Parent (ref)
            local v294 = script_Parent.new(function() -- Line: 1400
            end);
            v294:andThen(function() -- Line: 1401
            end);
            local v295 = { script_Parent.new(function() -- Line: 1404
                end), script_Parent.new(function() -- Line: 1405
                end), v294 };
            script_Parent.some(v295, 3):cancel();
            expect(v295[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v295[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v295[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
        describe("Promise.any", function() -- Line: 1416
            -- upvalues: script_Parent (ref)
            it("should return the value directly", function() -- Line: 1417
                -- upvalues: script_Parent (ref)
                local v296 = script_Parent.any({ script_Parent.reject(), script_Parent.reject(), script_Parent.resolve(1) });
                expect(v296:getStatus()).to.equal(script_Parent.Status.Resolved);
                expect(v296._values[1]).to.equal(1);
            end);
            it("should error if all are rejected", function() -- Line: 1428
                -- upvalues: script_Parent (ref)
                expect(script_Parent.any({ script_Parent.reject(), script_Parent.reject(), script_Parent.reject() }):getStatus()).to.equal(script_Parent.Status.Rejected);
            end);
        end);
    end);
    describe("Promise.allSettled", function() -- Line: 1438
        -- upvalues: script_Parent (copy)
        it("should resolve with an array of PromiseStatuses", function() -- Line: 1439
            -- upvalues: script_Parent (ref)
            local u297 = nil;
            local v300 = script_Parent.allSettled({
                script_Parent.resolve(),
                script_Parent.reject(),
                script_Parent.resolve(),
                script_Parent.new(function(p298, p299) -- Line: 1445
                    -- upvalues: u297 (ref)
                    u297 = p299;
                end)
            });
            expect(v300:getStatus()).to.equal(script_Parent.Status.Started);
            u297();
            expect(v300:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v300._values[1][1]).to.equal(script_Parent.Status.Resolved);
            expect(v300._values[1][2]).to.equal(script_Parent.Status.Rejected);
            expect(v300._values[1][3]).to.equal(script_Parent.Status.Resolved);
            expect(v300._values[1][4]).to.equal(script_Parent.Status.Rejected);
        end);
        it("should cancel promises if it is cancelled", function() -- Line: 1459
            -- upvalues: script_Parent (ref)
            local v301 = script_Parent.new(function() -- Line: 1460
            end);
            v301:andThen(function() -- Line: 1461
            end);
            local v302 = { script_Parent.new(function() -- Line: 1464
                end), script_Parent.new(function() -- Line: 1465
                end), v301 };
            script_Parent.allSettled(v302):cancel();
            expect(v302[1]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v302[2]:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(v302[3]:getStatus()).to.equal(script_Parent.Status.Started);
        end);
    end);
    describe("Promise:await", function() -- Line: 1477
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should return the correct values", function() -- Line: 1478
            -- upvalues: script_Parent (ref)
            local v303, v304, v305, v306, v307 = script_Parent.resolve(5, 6, nil, 7):await();
            expect(v303).to.equal(true);
            expect(v304).to.equal(5);
            expect(v305).to.equal(6);
            expect(v306).to.equal(nil);
            expect(v307).to.equal(7);
        end);
        it("should work if yielding is needed", function() -- Line: 1490
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u308 = false;
            task.spawn(function() -- Line: 1492
                -- upvalues: script_Parent (ref), u308 (ref)
                local _, v309 = script_Parent.delay(1):await();
                expect((type(v309))).to.equal("number");
                u308 = true;
            end);
            advanceTime(2);
            expect(u308).to.equal(true);
        end);
    end);
    describe("Promise:expect", function() -- Line: 1503
        -- upvalues: script_Parent (copy)
        it("should throw the correct values", function() -- Line: 1504
            -- upvalues: script_Parent (ref)
            local v310 = {};
            local u311 = script_Parent.reject(v310);
            local success, result = pcall(function() -- Line: 1508
                -- upvalues: u311 (copy)
                u311:expect();
            end);
            expect(success).to.equal(false);
            expect(result).to.equal(v310);
        end);
    end);
    describe("Promise:now", function() -- Line: 1517
        -- upvalues: script_Parent (copy)
        it("should resolve if the Promise is resolved", function() -- Line: 1518
            -- upvalues: script_Parent (ref)
            local v312, v313 = script_Parent.resolve("foo"):now():_unwrap();
            expect(v312).to.equal(true);
            expect(v313).to.equal("foo");
        end);
        it("should reject if the Promise is not resolved", function() -- Line: 1525
            -- upvalues: script_Parent (ref)
            local v314, v315 = script_Parent.new(function() -- Line: 1526
            end):now():_unwrap();
            expect(v314).to.equal(false);
            expect(script_Parent.Error.isKind(v315, "NotResolvedInTime")).to.equal(true);
        end);
        it("should reject with a custom rejection value", function() -- Line: 1532
            -- upvalues: script_Parent (ref)
            local v316, v317 = script_Parent.new(function() -- Line: 1533
            end):now("foo"):_unwrap();
            expect(v316).to.equal(false);
            expect(v317).to.equal("foo");
        end);
    end);
    describe("Promise.each", function() -- Line: 1540
        -- upvalues: script_Parent (copy)
        it("should iterate", function() -- Line: 1541
            -- upvalues: script_Parent (ref)
            local v318, v319 = script_Parent.each({ "foo", "bar", "baz", "qux" }, function(...) -- Line: 1547
                return { ... };
            end):_unwrap();
            expect(v318).to.equal(true);
            expect(v319[1][1]).to.equal("foo");
            expect(v319[1][2]).to.equal(1);
            expect(v319[2][1]).to.equal("bar");
            expect(v319[2][2]).to.equal(2);
            expect(v319[3][1]).to.equal("baz");
            expect(v319[3][2]).to.equal(3);
            expect(v319[4][1]).to.equal("qux");
            expect(v319[4][2]).to.equal(4);
        end);
        it("should iterate serially", function() -- Line: 1562
            -- upvalues: script_Parent (ref)
            local u320 = {};
            local u321 = {};
            local v325 = script_Parent.each({ "foo", "bar", "baz" }, function(u322, p323) -- Line: 1570
                -- upvalues: u321 (copy), script_Parent (ref), u320 (copy)
                u321[p323] = (u321[p323] or 0) + 1;

                return script_Parent.new(function(u324) -- Line: 1573
                    -- upvalues: u320 (ref), u322 (copy)
                    table.insert(u320, function() -- Line: 1574
                        -- upvalues: u324 (copy), u322 (ref)
                        u324(u322:upper());
                    end);
                end);
            end);
            expect(v325:getStatus()).to.equal(script_Parent.Status.Started);
            expect(#u320).to.equal(1);
            expect(u321[1]).to.equal(1);
            expect(u321[2]).to.never.be.ok();
            table.remove(u320, 1)();
            expect(v325:getStatus()).to.equal(script_Parent.Status.Started);
            expect(#u320).to.equal(1);
            expect(u321[1]).to.equal(1);
            expect(u321[2]).to.equal(1);
            expect(u321[3]).to.never.be.ok();
            table.remove(u320, 1)();
            expect(v325:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u321[1]).to.equal(1);
            expect(u321[2]).to.equal(1);
            expect(u321[3]).to.equal(1);
            table.remove(u320, 1)();
            expect(v325:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect((type(v325._values[1]))).to.equal("table");
            expect((type(v325._values[2]))).to.equal("nil");
            local v326 = v325._values[1];
            expect(v326[1]).to.equal("FOO");
            expect(v326[2]).to.equal("BAR");
            expect(v326[3]).to.equal("BAZ");
        end);
        it("should reject with the value if the predicate promise rejects", function() -- Line: 1613
            -- upvalues: script_Parent (ref)
            local v327 = script_Parent.each({ 1, 2, 3 }, function() -- Line: 1614
                -- upvalues: script_Parent (ref)
                return script_Parent.reject("foobar");
            end);
            expect(v327:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v327._values[1]).to.equal("foobar");
        end);
        it("should allow Promises to be in the list and wait when it gets to them", function() -- Line: 1622
            -- upvalues: script_Parent (ref)
            local u328 = nil;
            local v330 = { (script_Parent.new(function(p329) -- Line: 1624
                    -- upvalues: u328 (ref)
                    u328 = p329;
                end)) };
            local v332 = script_Parent.each(v330, function(p331) -- Line: 1630
                return p331 * 2;
            end);
            expect(v332:getStatus()).to.equal(script_Parent.Status.Started);
            u328(2);
            expect(v332:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v332._values[1][1]).to.equal(4);
        end);
        it("should reject with the value if a Promise from the list rejects", function() -- Line: 1642
            -- upvalues: script_Parent (ref)
            local u333 = false;
            local v335 = script_Parent.each({ 1, 2, script_Parent.reject("foobar") }, function(p334) -- Line: 1644
                -- upvalues: u333 (ref)
                u333 = true;

                return "never";
            end);
            expect(v335:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v335._values[1]).to.equal("foobar");
            expect(u333).to.equal(false);
        end);
        it("should reject immediately if there\'s a cancelled Promise in the list initially", function() -- Line: 1654
            -- upvalues: script_Parent (ref)
            local v336 = script_Parent.new(function() -- Line: 1655
            end);
            v336:cancel();
            local u337 = false;
            local v338 = script_Parent.each({ 1, 2, v336 }, function() -- Line: 1659
                -- upvalues: u337 (ref)
                u337 = true;
            end);
            expect(v338:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(u337).to.equal(false);
            expect(v338._values[1].kind).to.equal(script_Parent.Error.Kind.AlreadyCancelled);
        end);
        it("should stop iteration if Promise.each is cancelled", function() -- Line: 1668
            -- upvalues: script_Parent (ref)
            local u339 = {};
            local v342 = script_Parent.each({ "foo", "bar", "baz" }, function(p340, p341) -- Line: 1675
                -- upvalues: u339 (copy), script_Parent (ref)
                u339[p341] = (u339[p341] or 0) + 1;

                return script_Parent.new(function() -- Line: 1678
                end);
            end);
            expect(v342:getStatus()).to.equal(script_Parent.Status.Started);
            expect(u339[1]).to.equal(1);
            expect(u339[2]).to.never.be.ok();
            v342:cancel();
            expect(v342:getStatus()).to.equal(script_Parent.Status.Cancelled);
            expect(u339[1]).to.equal(1);
            expect(u339[2]).to.never.be.ok();
        end);
        it("should cancel the Promise returned from the predicate if Promise.each is cancelled", function() -- Line: 1692
            -- upvalues: script_Parent (ref)
            local u343 = nil;
            script_Parent.each({ "foo", "bar", "baz" }, function(p344, p345) -- Line: 1699
                -- upvalues: u343 (ref), script_Parent (ref)
                u343 = script_Parent.new(function() -- Line: 1700
                end);

                return u343;
            end):cancel();
            expect(u343:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
        it("should cancel Promises in the list if Promise.each is cancelled", function() -- Line: 1709
            -- upvalues: script_Parent (ref)
            local v346 = script_Parent.new(function() -- Line: 1710
            end);
            script_Parent.each({ v346 }, function() -- Line: 1712
            end):cancel();
            expect(v346:getStatus()).to.equal(script_Parent.Status.Cancelled);
        end);
    end);
    describe("Promise.retry", function() -- Line: 1720
        -- upvalues: script_Parent (copy)
        it("should retry N times", function() -- Line: 1721
            -- upvalues: script_Parent (ref)
            local u347 = 0;
            local v349 = script_Parent.retry(function(p348) -- Line: 1724
                -- upvalues: u347 (ref), script_Parent (ref)
                expect(p348).to.equal("foo");
                u347 = u347 + 1;

                if u347 == 5 then
                    return script_Parent.resolve("ok");
                end;

                return script_Parent.reject("fail");
            end, 5, "foo");
            expect(v349:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v349._values[1]).to.equal("ok");
        end);
        it("should reject if threshold is exceeded", function() -- Line: 1740
            -- upvalues: script_Parent (ref)
            local v350 = script_Parent.retry(function() -- Line: 1741
                -- upvalues: script_Parent (ref)
                return script_Parent.reject("fail");
            end, 5);
            expect(v350:getStatus()).to.equal(script_Parent.Status.Rejected);
            expect(v350._values[1]).to.equal("fail");
        end);
    end);
    describe("Promise.retryWithDelay", function() -- Line: 1750
        -- upvalues: script_Parent (copy), advanceTime (ref)
        it("should retry after a delay", function() -- Line: 1751
            -- upvalues: script_Parent (ref), advanceTime (ref)
            local u351 = 0;
            local v353 = script_Parent.retryWithDelay(function(p352) -- Line: 1754
                -- upvalues: u351 (ref), script_Parent (ref)
                expect(p352).to.equal("foo");
                u351 = u351 + 1;

                if u351 == 3 then
                    return script_Parent.resolve("ok");
                end;

                return script_Parent.reject("fail");
            end, 3, 10, "foo");
            expect(u351).to.equal(1);
            advanceTime(11);
            expect(u351).to.equal(2);
            advanceTime(11);
            expect(u351).to.equal(3);
            expect(v353:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v353._values[1]).to.equal("ok");
        end);
    end);
    describe("Promise.fromEvent", function() -- Line: 1781
        -- upvalues: script_Parent (copy)
        it("should convert a Promise into an event", function() -- Line: 1782
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v354 = script_Parent.fromEvent(BindableEvent2.Event);
            expect(v354:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("foo");
            expect(v354:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v354._values[1]).to.equal("foo");
        end);
        it("should convert a Promise into an event with the predicate", function() -- Line: 1795
            -- upvalues: script_Parent (ref)
            local BindableEvent2 = Instance.new("BindableEvent");
            local v356 = script_Parent.fromEvent(BindableEvent2.Event, function(p355) -- Line: 1798
                return p355 == "foo";
            end);
            expect(v356:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("bar");
            expect(v356:getStatus()).to.equal(script_Parent.Status.Started);
            BindableEvent2:Fire("foo");
            expect(v356:getStatus()).to.equal(script_Parent.Status.Resolved);
            expect(v356._values[1]).to.equal("foo");
        end);
    end);
    describe("Promise.is", function() -- Line: 1815
        -- upvalues: script_Parent (copy)
        it("should work with current version", function() -- Line: 1816
            -- upvalues: script_Parent (ref)
            local v357 = script_Parent.resolve(1);
            expect(script_Parent.is(v357)).to.equal(true);
        end);
        it("should work with any object with an andThen", function() -- Line: 1822
            -- upvalues: script_Parent (ref)
            expect(script_Parent.is({
                andThen = function() -- Line: 1824, Name: andThen
                    return 1;
                end
            })).to.equal(true);
        end);
        it("should work with older promises", function() -- Line: 1832
            -- upvalues: script_Parent (ref)
            local v358 = {
                prototype = {}
            };
            v358.__index = v358.prototype;

            function v358.prototype.andThen(p359) -- Line: 1837
            end;

            local v360 = setmetatable({}, v358);
            expect(script_Parent.is(v360)).to.equal(true);
        end);
    end);
end;