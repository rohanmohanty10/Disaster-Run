--// Services \\--
local Debris = game:GetService('Debris')
local TweenService = game:GetService('TweenService')
local SoundsGroup = game:GetService("SoundService").Sounds
--// Module \\--
local module = {}
local ThrownFolder = workspace.World.Debris or workspace.World:WaitForChild('Thrown', 5)

--// Module Functions \\--
local function destroySound(Sound: Sound)
	local parent = Sound.Parent
	Sound:Destroy()
	if parent and parent:IsA("Attachment") and parent.Parent == workspace.Terrain then
		parent:Destroy()
	end
end

-- TimeLength is 0 until the asset loads; runs fn once it's known.
local function whenLoaded(Sound: Sound, fn: (number) -> ())
	if Sound.IsLoaded then
		fn(Sound.TimeLength)
		return
	end
	Sound.Loaded:Once(function()
		if Sound.Parent then
			fn(Sound.TimeLength)
		end
	end)
end

--// Module Functions \\--
function module:AddSound(Sound: Sound, SoundParam, Parameters): Sound
	if typeof(Sound) ~= "Instance" or not Sound:IsA("Sound") or typeof(SoundParam) == "string" then return end
	if Sound:GetAttribute("_stopping") then return end
	Parameters = Parameters or {}
	
	local ParameterType = typeof(SoundParam)
	
	local TargetVolume = Sound.Volume
	local FadeIn = Parameters.FadeIn
	local FadeOut = Parameters.FadeOut
	
	if typeof(Sound) == "Instance" then
		Sound = Sound:Clone()
		Sound.SoundGroup = SoundsGroup
	elseif typeof(Sound) == "number" or typeof(Sound) == "string" then
		local RealSound = Instance.new("Sound")
		RealSound.SoundGroup = SoundsGroup
		RealSound.SoundId = typeof(Sound) == "number" and "rbxassetid://" .. tostring(Sound) or Sound
		RealSound.Volume = Parameters.Volume or 1
		RealSound.RollOffMaxDistance = Parameters.RollOffMaxDistance or 300
		RealSound.RollOffMinDistance = Parameters.RollOffMinDistance or 10
		RealSound.RollOffMode = Parameters.RollOffMode or Enum.RollOffMode.InverseTapered
		Sound = RealSound
	end
	
	local SoundParent
	if SoundParam == nil or (ParameterType ~= "Vector3" and ParameterType ~= "CFrame") then
		SoundParent = SoundParam or workspace
	elseif ParameterType == 'Vector3' or ParameterType == "CFrame" then
		local PositionName = "WorldPosition"
		if ParameterType == "CFrame" then
			PositionName = "WorldCFrame"
		end
		local SoundPart = Instance.new('Attachment')
		SoundPart.Parent = workspace.Terrain
		SoundPart[PositionName] = SoundParam
		SoundParent = SoundPart
	end

	Sound:SetAttribute("_stopping", false)

	Sound.Ended:Once(function()
		if not Sound:GetAttribute("_stopping") then
			Sound:Destroy()
			if SoundParent and SoundParent:IsA("Attachment") and SoundParent.Parent == workspace.Terrain then
				SoundParent:Destroy()
			end
		end
	end)
	
	if FadeIn and FadeIn > 0 then
		Sound.Volume = 0
	end
	
	Sound.Parent = SoundParent
	Sound:Play()

	if FadeIn and FadeIn > 0 then
		TweenService:Create(Sound, TweenInfo.new(FadeIn, Enum.EasingStyle.Linear), {
			Volume = TargetVolume,
		}):Play()
	end
	
	if FadeOut and FadeOut > 0 then
		whenLoaded(Sound, function(length)
			if Sound.Looped then
				warn("AddSound: FadeOut ignored on a looped sound; use StopSound instead")
				return
			end
			-- Start the fade so it lands exactly on the end of the clip.
			local startAt = math.max(0, length - FadeOut)
			task.delay(startAt, function()
				if not Sound.Parent or Sound:GetAttribute("_stopping") then return end
				Sound:SetAttribute("_stopping", true)
				local tween = TweenService:Create(Sound, TweenInfo.new(FadeOut, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Volume = 0,
				})
				tween.Completed:Once(function()
					destroySound(Sound)
				end)
				tween:Play()
			end)
		end)
	end
	
	return Sound
end

function module:StopSound(Sound: Sound, FadeTime: number?)
	if typeof(Sound) ~= "Instance" or not Sound:IsA("Sound") then return end
	local parent = Sound.Parent

	local function cleanup()
		Sound:Destroy()
		if parent and parent:IsA("Attachment") and parent.Parent == workspace.Terrain then
			parent:Destroy()
		end
	end

	if FadeTime and FadeTime > 0 then
		Sound:SetAttribute("_stopping", true)
		local tween = TweenService:Create(Sound, TweenInfo.new(FadeTime), { Volume = 0 })
		tween.Completed:Once(cleanup)
		tween:Play()
	else
		Sound:SetAttribute("_stopping", true)
		Sound:Stop()
		cleanup()
	end
end

return module