local RunService = game:GetService("RunService")

local FrameMarker = {}
FrameMarker.__index = FrameMarker

FrameMarker.new = function(params)
	return setmetatable({
		Framerate = params.Framerate or 60,
		ElapsedFrames = 0,
		ScheduledEvents = {},
	}, FrameMarker)
end

FrameMarker.At = function(instance, frame, callback)
	instance.ScheduledEvents[frame] = callback
end

FrameMarker.Chain = function(instance, sequence)
	for frame, callback in sequence do
		instance:At(frame, callback)
	end
	instance:Play()
	return instance
end

FrameMarker.Update = function(instance, deltaTime)
	instance.ElapsedFrames = instance.ElapsedFrames + deltaTime * instance.Framerate
end

FrameMarker.Play = function(instance)
	instance._Connection = RunService.Heartbeat:Connect(function(deltaTime)
		for frame, callback in instance.ScheduledEvents do
			if frame <= instance.ElapsedFrames then
				task.spawn(callback, instance)
				instance.ScheduledEvents[frame] = nil
			end
		end
		instance.ElapsedFrames = instance.ElapsedFrames + deltaTime * instance.Framerate
	end)
end

FrameMarker.Stop = function(instance)
	instance.Framerate = 0
end

FrameMarker.Destroy = function(instance)
	if instance._Connection then
		instance._Connection:Disconnect()
	end
	instance:Stop()
	setmetatable(instance, nil)
end

return FrameMarker