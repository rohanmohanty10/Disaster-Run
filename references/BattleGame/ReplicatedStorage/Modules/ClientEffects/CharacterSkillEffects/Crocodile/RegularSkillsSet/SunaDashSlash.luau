local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

local RNG = Random.new()

local function playBladeGrow(blade, elapsed)
	elapsed = elapsed or 0

	local SIZES = {
		Vector3.new(1, 2, 0.2),
		Vector3.new(2.925, 4.131, 0.368),
		Vector3.new(4.3875, 6.195, 0.552),
		Vector3.new(6, 8, 0.8),
		Vector3.new(11, 15, 1.1),
		Vector3.new(4, 6, 0.5),
		Vector3.new(1, 2, 0.2),
	}
	local DURS   = { 0.100, 0.117, 0.233, 0.150, 0.233, 0.317 }
	local STYLES = { Enum.EasingStyle.Sine, Enum.EasingStyle.Sine, Enum.EasingStyle.Quad, Enum.EasingStyle.Quad, Enum.EasingStyle.Sine, Enum.EasingStyle.Sine }
	local DIRS   = { Enum.EasingDirection.Out, Enum.EasingDirection.Out, Enum.EasingDirection.Out, Enum.EasingDirection.Out, Enum.EasingDirection.In, Enum.EasingDirection.Out }

	local FADE_TIME = 0.05
	-- fade out transparency + shrink, then destroy
	local function fadeOut()
		if not blade.Parent then return end
		local endSize = blade.Size * 0.5
		TweenService:Create(blade, TweenInfo.new(FADE_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1,
			Size = endSize,
		}):Play()
		task.delay(FADE_TIME, function()
			if blade.Parent then blade:Destroy() end
		end)
	end
	
	local function setEmitters(blade, on)
		for _, d in blade:GetDescendants() do
			if d:IsA("ParticleEmitter") then
				d.Enabled = on
			end
		end
	end

	local starts = {}
	local t = 0
	for i = 1, #DURS do starts[i] = t; t += DURS[i] end
	local total = t

	if elapsed >= total then
		blade.Size = SIZES[#SIZES]
		fadeOut()
		return
	end

	for i = 1, #DURS do
		local segStart, segEnd = starts[i], starts[i] + DURS[i]
		local isLast = (i == #DURS)

		local function playSeg(dur, fromLerp)
			if fromLerp then
				blade.Size = SIZES[i]:Lerp(SIZES[i + 1], fromLerp)
			end
			
			if i == 4 then
				setEmitters(blade, false)   -- kill emitters as the 5th tween (shrink) begins
			end
			
			local tw = TweenService:Create(blade, TweenInfo.new(dur, STYLES[i], DIRS[i]), {
				Size = SIZES[i + 1],
			})
			if isLast then
				tw.Completed:Once(fadeOut)   -- fade after the final shrink lands
			end
			tw:Play()
		end

		if elapsed >= segEnd then
			-- already done; if it's the last one, fade immediately
			if isLast then fadeOut() end
		elseif elapsed >= segStart then
			local into = elapsed - segStart
			playSeg(DURS[i] - into, into / DURS[i])
		else
			local delay = segStart - elapsed
			task.delay(delay, function()
				if blade.Parent then playSeg(DURS[i]) end
			end)
		end
	end
end

return function(argumentData: any)
	local Attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	if not Attacker then
		return
	end

	local HumRP: BasePart = Attacker:FindFirstChild("HumanoidRootPart")
	if not HumRP then
		return
	end
	
	if skillType == "StartSlash" then
		local Character = Attacker
		if not Character then return end

		local RightArm = Character:FindFirstChild("Right Arm")
		if not RightArm then return end

		-- clean up any copy first
		local oldBlade = Character:FindFirstChild("BigBlade2")
		if oldBlade then oldBlade:Destroy() end

		local Blade = script.Blade2:Clone()
		Blade.Anchored = false
		Blade.CanCollide = false
		Blade.CanTouch = false
		Blade.CanQuery = false
		Blade.Massless = true
		Blade.Size = Vector3.new(1, 2, 0.2)          -- start at frame-0 size
		Blade.Parent = RightArm

		local Motor = script.BigBlade:Clone()
		Motor.Part0 = RightArm
		Motor.Part1 = Blade
		Motor.Parent = RightArm      
		
		local startTime = argumentData.StartTime or workspace:GetServerTimeNow()
		local elapsed = workspace:GetServerTimeNow() - startTime   
		playBladeGrow(Blade, elapsed)
		Debris:AddItem(Blade, 2.5)     
		
		local groundParams = RaycastParams.new()
		groundParams.FilterType = Enum.RaycastFilterType.Include
		groundParams.FilterDescendantsInstances = { workspace.World.Map }
		groundParams.IgnoreWater = true

		local rightOffset = HumRP.CFrame.RightVector * 3   
		local origin = HumRP.Position + rightOffset + HumRP.CFrame.LookVector * 2  

		local groundResult = workspace:Raycast(origin, Vector3.new(0, -5, 0), groundParams)
		if groundResult then
			local sparks = script.DashDust:Clone()
			sparks.CFrame = CFrame.new(groundResult.Position + Vector3.new(0, 0.066, 0))
			sparks.Parent = workspace.World.Visuals
			Debris:AddItem(sparks, 3) 
			
			EffectUtilities.Emit(sparks)
		end
		
		local tipAttach = Blade:FindFirstChild("MiddleAttachment")  
		if not tipAttach then return end

		task.spawn(function()
			local elapsed = 0
			local lastSpawnPos = nil

			while elapsed < 0.2 and Blade.Parent do
				elapsed += RunService.Heartbeat:Wait()

				local tipPos = tipAttach.WorldPosition   -- exact point on the blade, no axis guessing

				if not lastSpawnPos or (tipPos - lastSpawnPos).Magnitude >= 2 then
					lastSpawnPos = tipPos

					local anchorCF = CFrame.lookAt(
						Vector3.new(tipPos.X, HumRP.Position.Y, tipPos.Z),
						Vector3.new(tipPos.X, HumRP.Position.Y, tipPos.Z) + HumRP.CFrame.LookVector
					)

					RockHandler.RegularRockLines(anchorCF, {
						Amount = 1,
						Spacing = 1.4,
						SideSpacing = 0.9,
						Angle = 0,
						RandomJitter = 0,
						Size = 1.15,
						SizeIndex = 0,
						ExposeLevel = -0.2,
					})
				end
			end
		end)
		
		local FloorTrail = require(ReplicatedStorage.Modules.ClientEffects.FloorTrail)
		FloorTrail.Start({
			Object = Blade,
			Attachment = tipAttach,
			Duration = .2,
			Width = .1,
			MoveThreshold = 0.3,
			StartColor = Color3.fromRGB(255, 128, 38),
			EndColor = Color3.fromRGB(0, 0, 0),
			FadeDelay = 0.6,                          
			FadeTime = 0.5,
		})
		return
	end
	
	if skillType == "Semi Circle" then
		local CFrameToUse = argumentData.CFrameToUse or HumRP.CFrame
		RockHandler.SemiCircleCrater(
			-- the server's swing position too (not this client's view of Crocodile), so the crater
			-- lines up with the destruction for everyone
			CFrameToUse.Position + CFrameToUse.LookVector * 5,
			-- The ray runs from half this above Position to half below it. The root is ~3 studs above
			-- the ground, so -4 (from +2 to -2) stopped a stud short of it and the crater never spawned.
			Vector3.new(0, -12, 0),
			CFrameToUse,           
			{ Amount = 6, ArcDegrees = 150, Distance = 8, SizeMultiplier = 1.4, CraterSmoke = false }
		)
		
		local main = script.Hit["dust explosion"]:Clone() 
		main.CFrame = HumRP.CFrame * CFrame.new(0, 0, -5.5)
		main.Parent = workspace.World.Visuals
		EffectUtilities.Emit(main)
		Debris:AddItem(main, 3)
		return
	end
	
	if skillType == "HitEnemy" then
		local EnemyCharacter = argumentData.Enemy or argumentData.Victim
		if not EnemyCharacter then return end

		local Torso = EnemyCharacter:FindFirstChild("Torso")
		if not Torso then return end

		local main = script.Hit.Hit:Clone()   
		main.Parent = Torso
		
		local weld = script.Hit.Weld:Clone()
		weld.Part0 = Torso
		weld.Part1 = main
		weld.Parent = main

		EffectUtilities.Emit(main)
		
		Debris:AddItem(main, 3)
		return
	end
end