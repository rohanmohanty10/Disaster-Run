local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local BoatTween = require(script.BoatTween)

local Assets = ReplicatedStorage:WaitForChild("Assets")
local GeneralEffects = Assets:WaitForChild("Effects"):WaitForChild("GeneralEffects")
local createFunction = {}

function createFunction:Ring(size, goalSize, speed, duration, position, rotation,cf)
	local ring = GeneralEffects.Ring:Clone()
	ring.Size = size
	ring.Position = position
	ring.Rotation = rotation
	ring.Parent = workspace.FX
	
	if cf then
		ring.CFrame = cf
	end

	local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Linear)
	local transparencyTween = TweenService:Create(ring, tweenInfo, { Transparency = 1 })
	local sizeTween = TweenService:Create(ring, tweenInfo, { Size = goalSize })

	sizeTween:Play()
	transparencyTween:Play()
	
	game.Debris:AddItem(ring,duration)
	return ring
end

function createFunction:AfterImageFist(size, goalSize, speed, duration, cf, endCFrame)
	local fist = GeneralEffects.SouFist:Clone()
	fist.Size = size
	fist.CFrame = cf
	fist.Parent = workspace.FX

	local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
	local transparencyTween = TweenService:Create(fist, tweenInfo, { Transparency = 1})
	local sizeTween = TweenService:Create(fist, tweenInfo, { Size = goalSize , CFrame = cf * endCFrame})

	sizeTween:Play()
	transparencyTween:Play()

	game.Debris:AddItem(fist,duration)
	return fist
end

function createFunction:ShockWave(cf, radius, endradius, startwidth, endwidth, startSpeed, endSpeed, popuptime, endtime, midtransparency, duration)
	local shockwavePart = GeneralEffects:WaitForChild("Shockwave"):Clone()
	shockwavePart.CFrame = cf
	
	game:GetService("RunService").Heartbeat:Wait()
	
	shockwavePart.Parent = workspace.World.Visuals
	
	local currentTransparency = shockwavePart.BeamF.Transparency
	local farFromCenter = radius/2
	local farFromCenterEnd = endradius/2
	
	local startTransparency = NumberSequence.new(1)
	
	
	local middleTransparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,midtransparency),
		NumberSequenceKeypoint.new(0.5,midtransparency),
		NumberSequenceKeypoint.new(1,midtransparency)
	})
	
	
	local endTransparency = NumberSequence.new(1)
	
	shockwavePart.First.CFrame = CFrame.new(0,0,farFromCenter)
	shockwavePart.Second.CFrame = CFrame.new(0,0,-farFromCenter) * CFrame.Angles(0,math.rad(180),0)
	
	shockwavePart.BeamF.CurveSize0 = farFromCenter*1.35
	shockwavePart.BeamF.CurveSize1 = farFromCenter*1.35
	shockwavePart.BeamF.TextureSpeed = startSpeed
	shockwavePart.BeamF.Transparency = middleTransparency
	shockwavePart.BeamF.Width0 = startwidth
	shockwavePart.BeamF.Width1 = startwidth
	
	shockwavePart.BeamS.CurveSize0 = farFromCenter*1.35
	shockwavePart.BeamS.CurveSize1 = farFromCenter*1.35
	shockwavePart.BeamS.TextureSpeed = startSpeed
	shockwavePart.BeamS.Transparency = middleTransparency
	shockwavePart.BeamS.Width0 = startwidth
	shockwavePart.BeamS.Width1 = startwidth

	local shockwaveBeamFEndTween = BoatTween:Create(shockwavePart.BeamF,{
		Time = endtime;
		EasingStyle = "Linear";
		EasingDirection = "Out";

		Reverses = false;
		DelayTime = 0;
		RepeatCount = 0;

		StepType = "Heartbeat";

		Goal = {
			Transparency = endTransparency;
		};
	})
	
	local shockwaveBeamSEndTween = BoatTween:Create(shockwavePart.BeamS,{
		Time = endtime;
		EasingStyle = "Linear";
		EasingDirection = "Out";

		Reverses = false;
		DelayTime = 0;
		RepeatCount = 0;

		StepType = "Heartbeat";

		Goal = {
			Transparency = endTransparency;
		};
	})

	local shockwaveBeamFSizeTween = TweenService:Create(shockwavePart.BeamF, TweenInfo.new(popuptime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Width0 = endwidth, Width1 = endwidth, CurveSize0 = farFromCenterEnd*1.35, CurveSize1 = farFromCenterEnd*1.35, TextureSpeed = endSpeed})
	local shockwaveBeamSSizeTween = TweenService:Create(shockwavePart.BeamS, TweenInfo.new(popuptime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Width0 = endwidth, Width1 = endwidth, CurveSize0 = farFromCenterEnd*1.35, CurveSize1 = farFromCenterEnd*1.35, TextureSpeed = endSpeed})

	local endScaleF = TweenService:Create(shockwavePart.First, TweenInfo.new(popuptime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,farFromCenterEnd)})
	local endScaleS = TweenService:Create(shockwavePart.Second, TweenInfo.new(popuptime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,-farFromCenterEnd) * CFrame.Angles(0,math.rad(180),0)})
	
	local shockwaveBeamFSizeLastTween = TweenService:Create(shockwavePart.BeamF, TweenInfo.new(duration+endtime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Width0 = endwidth-endwidth, Width1 = endwidth-endwidth, CurveSize0 = (farFromCenterEnd+farFromCenterEnd)*1.35, CurveSize1 = (farFromCenterEnd+farFromCenterEnd)*1.35, TextureSpeed = endSpeed/2})
	local shockwaveBeamSSizeLastTween = TweenService:Create(shockwavePart.BeamS, TweenInfo.new(duration+endtime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Width0 = endwidth-endwidth, Width1 = endwidth-endwidth, CurveSize0 = (farFromCenterEnd+farFromCenterEnd)*1.35, CurveSize1 = (farFromCenterEnd+farFromCenterEnd)*1.35, TextureSpeed = endSpeed/2})

	local endScaleFLast = TweenService:Create(shockwavePart.First, TweenInfo.new(duration+endtime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,farFromCenterEnd+farFromCenterEnd)})
	local endScaleSLast = TweenService:Create(shockwavePart.Second, TweenInfo.new(duration+endtime,Enum.EasingStyle.Linear,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,-farFromCenterEnd-farFromCenterEnd) * CFrame.Angles(0,math.rad(180),0)})

	
	shockwaveBeamFSizeTween:Play()
	shockwaveBeamSSizeTween:Play()
	
	endScaleF:Play()
	endScaleS:Play()
	
	task.wait(popuptime)
	
	shockwaveBeamFSizeLastTween:Play()
	shockwaveBeamSSizeLastTween:Play()
	
	endScaleFLast:Play()
	endScaleSLast:Play()
	
	shockwaveBeamFEndTween:Play()
	shockwaveBeamSEndTween:Play()
	game.Debris:AddItem(shockwavePart,duration+endtime)
end

function createFunction:ShockWaveWind(cf, radius, endradius, startwidth, endwidth, startSpeed, endSpeed, popuptime, endtime, midtransparency, duration)
	local shockwavePart = GeneralEffects:WaitForChild("Wind"):Clone()
	shockwavePart.CFrame = cf

	game:GetService("RunService").Heartbeat:Wait()

	shockwavePart.Parent = workspace.FX

	local currentTransparency = shockwavePart.BeamF.Transparency
	local farFromCenter = radius/2
	local farFromCenterEnd = endradius/2

	local startTransparency = NumberSequence.new(1)


	local middleTransparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0,midtransparency),
		NumberSequenceKeypoint.new(0.5,midtransparency),
		NumberSequenceKeypoint.new(1,midtransparency)
	})


	local endTransparency = NumberSequence.new(1)

	shockwavePart.First.CFrame = CFrame.new(0,0,farFromCenter)
	shockwavePart.Second.CFrame = CFrame.new(0,0,-farFromCenter) * CFrame.Angles(0,math.rad(180),0)

	shockwavePart.BeamF.CurveSize0 = farFromCenter*1.35
	shockwavePart.BeamF.CurveSize1 = farFromCenter*1.35
	shockwavePart.BeamF.TextureSpeed = startSpeed
	shockwavePart.BeamF.Transparency = middleTransparency
	shockwavePart.BeamF.Width0 = startwidth
	shockwavePart.BeamF.Width1 = startwidth

	shockwavePart.BeamS.CurveSize0 = farFromCenter*1.35
	shockwavePart.BeamS.CurveSize1 = farFromCenter*1.35
	shockwavePart.BeamS.TextureSpeed = startSpeed
	shockwavePart.BeamS.Transparency = middleTransparency
	shockwavePart.BeamS.Width0 = startwidth
	shockwavePart.BeamS.Width1 = startwidth

	local shockwaveBeamFEndTween = BoatTween:Create(shockwavePart.BeamF,{
		Time = endtime;
		EasingStyle = "Quad";
		EasingDirection = "Out";

		Reverses = false;
		DelayTime = 0;
		RepeatCount = 0;

		StepType = "Heartbeat";

		Goal = {
			Transparency = endTransparency;
		};
	})

	local shockwaveBeamSEndTween = BoatTween:Create(shockwavePart.BeamS,{
		Time = endtime;
		EasingStyle = "Quad";
		EasingDirection = "Out";

		Reverses = false;
		DelayTime = 0;
		RepeatCount = 0;

		StepType = "Heartbeat";

		Goal = {
			Transparency = endTransparency;
		};
	})

	local shockwaveBeamFSizeTween = TweenService:Create(shockwavePart.BeamF, TweenInfo.new(duration,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Width0 = endwidth, Width1 = endwidth, CurveSize0 = farFromCenterEnd*1.35, CurveSize1 = farFromCenterEnd*1.35, TextureSpeed = endSpeed})
	local shockwaveBeamSSizeTween = TweenService:Create(shockwavePart.BeamS, TweenInfo.new(duration,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Width0 = endwidth, Width1 = endwidth, CurveSize0 = farFromCenterEnd*1.35, CurveSize1 = farFromCenterEnd*1.35, TextureSpeed = endSpeed})

	local endScaleF = TweenService:Create(shockwavePart.First, TweenInfo.new(duration,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,farFromCenterEnd)})
	local endScaleS = TweenService:Create(shockwavePart.Second, TweenInfo.new(duration,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {CFrame = CFrame.new(0,0,-farFromCenterEnd) * CFrame.Angles(0,math.rad(180),0)})

	shockwaveBeamFSizeTween:Play()
	shockwaveBeamSSizeTween:Play()

	endScaleF:Play()
	endScaleS:Play()

	task.wait(popuptime)
	
	shockwaveBeamFEndTween:Play()
	shockwaveBeamSEndTween:Play()
	game.Debris:AddItem(shockwavePart,duration+endtime)
end


function createFunction:Impact(size, goalSize, speed, duration, position, rotation,cf)
	local ring = GeneralEffects.Impact:Clone()
	ring.Size = size
	ring.Position = position
	ring.Rotation = rotation
	ring.Parent = workspace.World.Visuals

	if cf then
		ring.CFrame = cf
	end
	
	ring.CFrame = ring.CFrame * CFrame.Angles(0,math.rad(math.random(-180,180)),0)

	local tweenInfo = TweenInfo.new(speed, Enum.EasingStyle.Linear)
	local transparencyTween = TweenService:Create(ring, tweenInfo, { Transparency = 1 })
	local sizeTween = TweenService:Create(ring, tweenInfo, { Size = goalSize })
	local rotationTween = TweenService:Create(ring, tweenInfo, { CFrame = ring.CFrame * CFrame.Angles(0,math.rad(math.random(-180,180)),0) })


	rotationTween:Play()
	sizeTween:Play()
	transparencyTween:Play()

	game.Debris:AddItem(ring,duration)
	return ring
end


function createFunction:Sphere(size, goalSize, speed, duration, position, rotation)
	local sphere = Instance.new("Part")
	sphere.Shape = Enum.PartType.Ball
	sphere.Size = size
	sphere.Position = position
	sphere.Rotation = rotation
	sphere.Parent = workspace

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	local transparencyTween = TweenService:Create(sphere, tweenInfo, { Transparency = 1 })
	local sizeTween = TweenService:Create(sphere, tweenInfo, { Size = goalSize })

	sizeTween:Play()
	transparencyTween:Play()

	wait(duration)
	sphere:Destroy()
end

function createFunction:Box(size, goalSize, speed, duration, position, rotation)
	local box = Instance.new("Part")
	box.Shape = Enum.PartType.Block
	box.Size = size
	box.Position = position
	box.Rotation = rotation
	box.Parent = workspace

	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
	local transparencyTween = TweenService:Create(box, tweenInfo, { Transparency = 1 })
	local sizeTween = TweenService:Create(box, tweenInfo, { Size = goalSize })

	sizeTween:Play()
	transparencyTween:Play()

	wait(duration)
	box:Destroy()
end

return createFunction
