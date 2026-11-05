-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Create the communication event
local DestroyEvent = Instance.new("BindableEvent")
DestroyEvent.Name = "DestroyEvent"
DestroyEvent.Parent = ReplicatedStorage

--- Handles the actual destruction logic
DestroyEvent.Event:Connect(function(target, delayTime)
	if not target then
		warn("[DestroyEvent] No target provided for destruction.")
		return
	end

	-- Internal helper to safely destroy a single object
	local function secureDestroy(obj)
		if typeof(obj) == "Instance" then
			if delayTime and delayTime > 0 then
				task.delay(delayTime, function()
					if obj.Parent then obj:Destroy() end
				end)
			else
				obj:Destroy()
			end
		else
			warn(string.format("[DestroyEvent] Cannot destroy %s; it is not an Instance.", tostring(obj)))
		end
	end

	-- Process tables or single instances
	if typeof(target) == "table" then
		for _, item in ipairs(target) do
			secureDestroy(item)
		end
	else
		secureDestroy(target)
	end
end)

--- The main function returned by the module
-- @param target (Instance|table) The object or list of objects to destroy
-- @param delayTime (number?) Optional time to wait before destruction
return function(target, delayTime)
	if not target then return end

	-- If no delay is provided, handle immediate destruction efficiently
	if delayTime == nil or delayTime <= 0 then
		if typeof(target) == "table" then
			for i, item in ipairs(target) do
				if typeof(item) == "Instance" then
					item:Destroy()
				end

				-- Yield slightly for massive tables to prevent frame drops
				if i % 100 == 0 then
					RunService.Heartbeat:Wait()
				end
			end
		elseif typeof(target) == "Instance" then
			target:Destroy()
		end
		return
	end

	-- If there is a delay, delegate to the BindableEvent
	DestroyEvent:Fire(target, delayTime)
end