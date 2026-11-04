 -- Original SourceAssetId: https://assetdelivery.roblox.com/v1/asset/?id=116382382498753

-- ! Source from the asset above; the game may have edited it since.

--[[
--!strict
return function(event: RBXScriptSignal, timeoutInSeconds: number): (boolean, ...any)
	local thread = coroutine.running()
	local connection: RBXScriptConnection?

	local function onEvent(...)
		if not connection then
			return
		end

		connection:Disconnect()
		connection = nil

		if coroutine.status(thread) == "suspended" then
			task.spawn(thread, false, ...)
		end
	end

	connection = event:Once(onEvent)

	task.delay(timeoutInSeconds, function()
		if not connection then
			return
		end

		connection:Disconnect()
		connection = nil

		if coroutine.status(thread) == "suspended" then
			task.spawn(thread, true)
		end
	end)

	return coroutine.yield()
end
]]

 

return function(p1: userdata, p2: number) -- Line: 2
    local coroutine_running_ret = coroutine.running();
    local u3 = nil;
    u3 = p1:Once(function(...) -- Line: 6, Name: onEvent
        -- upvalues: u3 (ref), coroutine_running_ret (copy)
        if not u3 then
            return;
        end;

        u3:Disconnect();
        u3 = nil;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret, false, ...);
        end;
    end);
    task.delay(p2, function() -- Line: 21
        -- upvalues: u3 (ref), coroutine_running_ret (copy)
        if not u3 then
            return;
        end;

        u3:Disconnect();
        u3 = nil;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            task.spawn(coroutine_running_ret, true);
        end;
    end);

    return coroutine.yield();
end;