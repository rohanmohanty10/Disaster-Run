--ReplicatedStorage Settings Module
local Settings = {}

local defaults = {
	AutoRun = false,
	ShowDamageNumbers = false,
	CameraShake = true,
	DayNightCycle = true,
	AwakeningMusic = true,
	LowCameraShakeMode = false,
	normalWalk = true,
}

for i, j in pairs(defaults) do
	Settings[i] = j
end

local changedEvent = Instance.new("BindableEvent")
Settings.Changed = changedEvent.Event

function Settings.Get(key) --getter of the value
	return Settings[key]
end

function Settings.Set(key, value) --setter of the value from the key
	if Settings[key] == value then --If it is the same then just return
		return
	end
	
	Settings[key] = value
	changedEvent:Fire(key, value) --So we know which one was changed and the value which was changed. 
end

return Settings
