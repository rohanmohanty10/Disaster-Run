local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris            = game:GetService("Debris")
local TS                = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")

local LocalPlayer      = Players.LocalPlayer
local VFXFunctions     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local GpDestroy        = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local BoatTween        = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)
local RemotesContainer = ReplicatedStorage.Remotes

local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)

local activeSpinVFX = {}
local activeTweens = {}
local SlashVFX = nil
local folder
return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local SwordWeapon = character.ZoroSwords.Shisui
	local VFXPart = SwordWeapon.VFXPart
	-- ── Helpers ───────────────────────────────────────────────────────────────


	local function tween(instance, tweenParams, goalTable)
		if not instance or not instance.Parent then return end
		if activeTweens[instance] then
			pcall(function() activeTweens[instance]:Stop() end)
		end
		local tweenInfo = {
			Time            = tweenParams[1],
			EasingStyle     = string.gsub(tostring(tweenParams[2]), "Enum.EasingStyle.", ""),
			EasingDirection = string.gsub(tostring(tweenParams[3]), "Enum.EasingDirection.", ""),
			RepeatCount     = tweenParams[4],
			Reverses        = tweenParams[5],
			DelayTime       = tweenParams[6],
			Goal            = goalTable,
		}
		local t = BoatTween:Create(instance, tweenInfo)
		activeTweens[instance] = t
		t:Play()
		t.Completed:Once(function() activeTweens[instance] = nil end)
		return t
	end

	local function tweenTransparency(instance, targetTransparency, easingDirection)
		tween(instance, { 0.45, "Quad", easingDirection, 0, false, 0 }, { Transparency = targetTransparency })
	end

	-- Camera FOV tween: only runs for the local player
	local function tweenFOV(targetFOV, outDuration, outStyle, returnFOV, returnDuration, returnStyle)
		if not isLocalPlayer then return end
		local t = TS:Create(
			workspace.CurrentCamera,
			TweenInfo.new(outDuration, outStyle, Enum.EasingDirection.Out),
			{ FieldOfView = targetFOV }
		)
		t.Completed:Connect(function()
			TS:Create(
				workspace.CurrentCamera,
				TweenInfo.new(returnDuration, returnStyle, Enum.EasingDirection.InOut),
				{ FieldOfView = returnFOV }
			):Play()
		end)
		t:Play()
	end

	local function emitParticles(parent)
		for _, descendant in ipairs(parent:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant:Emit(descendant:GetAttribute("EmitCount") or 0)
			end
		end
	end

	local function setParticlesEnabled(parent, enabled)
		for _, descendant in ipairs(parent:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = enabled
			end
		end
	end
	local function stopParticles(parent)
		for _, descendant in ipairs(parent:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = false
				descendant:Clear()
			end
		end
	end
	
	local tbl_13_upvr = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)



	local activeTweens = tbl_13_upvr

	local function GPTween(instance, tweenParams, goalTable, stepType, forceRestart)

		-- If forceRestart is true and a tween is already running on this instance, stop and destroy it
		if forceRestart ~= nil and activeTweens[instance] then
			local existingTween = activeTweens[instance][1]
			existingTween:Stop()
			existingTween:Destroy()
			activeTweens[instance] = nil
		end

		-- Early exit if instance is invalid
		if not instance or instance == nil or instance.Parent == nil then return end

		-- If a tween is already running on this instance, check if any goal properties overlap
		pcall(function()
			if activeTweens[instance] then
				local existingTween = activeTweens[instance][1]
				local existingGoal = activeTweens[instance][2]
				local hasOverlap = false

				for property, _ in goalTable do
					if existingGoal[property] then
						hasOverlap = true
					end
				end

				-- If properties overlap, stop the existing tween
				if hasOverlap then
					existingTween:Stop()
					existingTween:Destroy()
					activeTweens[instance] = nil
				end
			end
		end)

		-- Build tween info table for BoatTween
		local tweenInfo = {
			Time = tweenParams[1],
			EasingStyle = string.gsub(tostring(tweenParams[2]), "Enum.EasingStyle.", ""),
			EasingDirection = string.gsub(tostring(tweenParams[3]), "Enum.EasingDirection.", ""),
			RepeatCount = tweenParams[4],
			Reverses = tweenParams[5],
			DelayTime = tweenParams[6],
			StepType = stepType,
			CustomEventStepFreq = goalTable.CustomEventStepFreq or nil,
			Goal = goalTable,
		}

		-- Create and play the tween
		local tween = BoatTween_upvrGPO:Create(instance, tweenInfo)
		activeTweens[instance] = {tween, goalTable}
		tween:Play()

		-- Clean up when tween completes
		if tween ~= nil and tween.Completed ~= nil then
			local completedConnection
			completedConnection = tween.Completed:Connect(function()
				completedConnection:Disconnect()
				completedConnection = nil

				pcall(function()
					tween:Destroy()
				end)

				activeTweens[instance] = nil
				table.clear(goalTable)
			end)

			-- Clean up if instance is destroyed before tween completes
			instance.Destroying:Once(function()
				if completedConnection then
					completedConnection:Disconnect()
					completedConnection = nil
				end

				pcall(function()
					tween:Destroy()
				end)

				activeTweens[instance] = nil
				table.clear(goalTable)
			end)
		else
			activeTweens[instance] = nil
		end

		return tween
	end

	-- Clone, emit, and auto-destroy a VFX model at a given CFrame
	local function spawnVFX(template, cframe, lifetime)
		local clone = template:Clone()
		clone.CFrame = cframe
		clone.Parent = workspace.World.Debris
		emitParticles(clone)
		Debris:AddItem(clone, lifetime)
		return clone
	end

	-- Weld a Motor6D from part0 to part1 with optional C0/C1
	local function weldMotor(parent, part0, part1, c0, c1)
		local motor   = Instance.new("Motor6D", parent)
		motor.Part0   = part0
		motor.Part1   = part1
		motor.C0      = c0 or CFrame.new()
		motor.C1      = c1 or CFrame.new()
		return motor
	end

	
	if skillType == "move" then
		local Character: Model = attacker
		--local HumRP: BasePart


		local Speed = Instance.new("IntValue")
		Speed.Value = 80

		local Velocity = Instance.new("BodyVelocity")
		Velocity.Parent = hrp
		Velocity.MaxForce = Vector3.new(math.huge, 0, math.huge)


		local Connection
		Connection = RunService.RenderStepped:Connect(function()
			if not Velocity.Parent then
				return Connection:Disconnect()
			end

			Velocity.Velocity = hrp.CFrame.LookVector * Speed.Value
		end)


		TS:Create(Speed, TweenInfo.new(0.75), { Value = 70 }):Play()

		task.delay(0.75, function()
			Speed.Value = 80

			TS:Create(Speed, TweenInfo.new(0.55), { Value = 70} ):Play()
		end)

		task.delay(1.7, function()
			Speed.Value = 80

			TS:Create(Speed, TweenInfo.new(0.6), { Value = 5 }):Play()
		end)


		Debris:AddItem(Velocity, 2.45)
	end
	if skillType == "teleport" then
		if not isLocalPlayer then return end

		local destination = argumentData.Destination
		if not destination then return end

		hrp.Anchored = true

		TS:Create(hrp, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			CFrame = destination
		}):Play()

		task.delay(0.1, function()
			hrp.Anchored = false
		end)
	end
	--if skillType == "teleport" then
	--	if not isLocalPlayer then return end
	--	local destination = argumentData.Destination
	--	if not destination then return end
	--	hrp.CFrame = destination -- instant, no tween
	--end
	
	if skillType == "teleportVFX" then
		local origin      = argumentData.Origin      -- Vector3: where the dash started
		local dashCFrame  = argumentData.DashCFrame  -- CFrame: direction of the dash trail
		local destination = argumentData.Destination -- Vector3: where the character landed


		local lookDir  = hrp.CFrame.LookVector
		local flatLook = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
		
		local facingCFrame = CFrame.new(origin + flatLook * 15, origin + flatLook * 16) * CFrame.Angles(0, math.rad(180), 0)
		local facingCFrame2 = CFrame.new(origin + flatLook * 15, origin + flatLook * 16) * CFrame.Angles(0, math.rad(180), 0)

		--hideThenFadeIn(attacker)


		--spawnVFX(script.Teleport, CFrame.new(origin), 3)


		--spawnVFX(script.Teleport, facingCFrame, 3)
		spawnVFX(script.Dash, dashCFrame, 3)

		--spawnVFX(script.Onigiri.Part1, facingCFrame, 3)
		--spawnVFX(script.Onigiri.Part2, facingCFrame, 3)

		--spawnVFX(script.DashBetter, dashCFrame, 4)
	end
	
	if skillType == "spin" then
		local vfx = script.Spinning.VFX2:Clone()
		vfx.Position = Vector3.new(0, -character.PrimaryPart.Size.Y / 6.5, -character.PrimaryPart.Size.Y-1)
		
		vfx.Parent   = character.PrimaryPart
		
		
		VFXFunctions.EnableTime(vfx, true, 8)

		
		--setParticlesEnabled(vfx, true)
		activeSpinVFX[attacker] = vfx  -- store it
		
	end
	
	if skillType == "spinstop" then
		print("OK")
		local vfx = activeSpinVFX[character]
		if vfx then
			setParticlesEnabled(vfx, false)
			activeSpinVFX[character] = nil
		end		
		
		--local vfx = activeSpinVFX[character]
		--if vfx then
		--	stopParticles(vfx)
		--	activeSpinVFX[character] = nil
		--end

		
	end
	if skillType == "Camera" then

		if not isLocalPlayer then return end

		local Camera = workspace.CurrentCamera
		local camModel = script.CameraCutscene.NormalCam:Clone()
		--camModel:PivotTo(CFrame.new(hrp.Position, hrp.Position + hrp.CFrame.LookVector) * CFrame.Angles(0, math.rad(180), 0))	
		local enemyCFrame = argumentData.EnemyHRPCFrame

		camModel:PivotTo(CFrame.new(enemyCFrame.Position, enemyCFrame.Position + enemyCFrame.LookVector) * CFrame.Angles(0, math.rad(180), 0)* CFrame.new(0,0,2))
		camModel.Parent = workspace

		local camAnim = camModel.AnimationController.Animator:LoadAnimation(script.CameraCutscene.Cutscene)
		camAnim:Play(0)
		camAnim.Looped = false

		Camera.CameraType = Enum.CameraType.Scriptable

		local camConnection
		camConnection = RunService.RenderStepped:Connect(function()
			if camModel and camModel:IsDescendantOf(workspace) then
				Camera.CFrame = camModel.Cam.CFrame
			else
				camConnection:Disconnect()
			end
		end)

		camAnim.Stopped:Once(function()
			camConnection:Disconnect()
			camModel:Destroy()
			Camera.CameraType = Enum.CameraType.Custom
			Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
		end)



	end
	if skillType == "Flash" then		
		folder = Instance.new("Folder")
		folder.Parent = workspace.World.Visuals

		

		local Slash = script.SlashProjectile:Clone()
		local Mesh1  = Slash.Mesh1
		local Mesh2  = Slash.Mesh2
		local Mesh3  = Slash.Mesh3
		SlashVFX = Slash.VFX_Hit

		local lookDir  = hrp.CFrame.LookVector
		local flatLook = Vector3.new(lookDir.X, 0, lookDir.Z).Unit
		local facingAngle = math.atan2(-flatLook.X, -flatLook.Z)
		-- Position slash at attacker, impact at hit point
		local targetPos = argumentData.targetPosition
		
		local offset = CFrame.new(targetPos) * CFrame.Angles(0, facingAngle, 0) * CFrame.new(0, 0, 5)
		Slash:PivotTo(CFrame.new(offset.Position) * CFrame.Angles(0, facingAngle + math.rad(180), math.rad(149.998)))
		--0, 180, 149.998
		--Slash:PivotTo(CFrame.new(targetPos)) -- * CFrame.Angles(0, math.rad(90), 0))
		Slash.Parent     = folder

		--impactVFX.CFrame = impactCFrame

		--meshVFX.CFrame   = impactVFX.CFrame
		--	* CFrame.new(0, 4, 0)
		--	* CFrame.Angles(0, 0, math.pi / 2)

		
		-- Red-orange highlight on the mesh (occluded so it shows through geometry)
		local highlight = Instance.new("Highlight")
		highlight.DepthMode          = Enum.HighlightDepthMode.Occluded
		highlight.FillTransparency   = 0.25
		highlight.OutlineTransparency = 0.25
		highlight.FillColor          = Color3.fromRGB(0, 0, 0)
		highlight.OutlineColor       = Color3.fromRGB(190, 24, 255)
		highlight.Parent             = Mesh1
		
		
		local highlight2 = Instance.new("Highlight")
		highlight2.DepthMode          = Enum.HighlightDepthMode.Occluded
		highlight2.FillTransparency   = 0.25
		highlight2.OutlineTransparency = 0.25
		highlight2.FillColor          = Color3.fromRGB(0, 0, 0)
		highlight2.OutlineColor       = Color3.fromRGB(190, 24, 255)
		highlight2.Parent             = Mesh2
		
		local highlight3 = Instance.new("Highlight")
		highlight3.DepthMode          = Enum.HighlightDepthMode.Occluded
		highlight3.FillTransparency   = 0.25
		highlight3.OutlineTransparency = 0.25
		highlight3.FillColor          = Color3.fromRGB(0, 0, 0)
		highlight3.OutlineColor       = Color3.fromRGB(190, 24, 255)
		highlight3.Parent             = Mesh3
		

	
		-- Parent everything into the folder
		--slashVFX.Parent  = folder
		--impactVFX.Parent = folder
		--meshVFX.Parent   = folder

		
		VFXFunctions.EnableDescendants(SlashVFX)
		--VFXFunctions.EmitDescendants(impactVFX)



		--GPTween(Mesh1, { 4, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
		--	Transparency = 1,
		--})
		--GPTween(Mesh2, { 4, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
		--	Transparency = 1,
		--})
		--GPTween(Mesh3, { 4, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
		--	Transparency = 1,
		--})
		
		TS:Create(Mesh1, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1,
		}):Play()

		TS:Create(Mesh2, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1,
		}):Play()

		TS:Create(Mesh3, TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Transparency = 1,
		}):Play()

		-- Fade out beams on the slash VFX
		--for _, child in ipairs(slashVFX:GetDescendants()) do
		--	if child:IsA("Beam") then
		--		_G.tween(child, { .17, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
		--			Width0 = 0,
		--			Width1 = 0,
		--		})
		--	end
		--end

		--Cleanup after 1.5s (with a 1.5s fade)
		task.delay(8, function()
			--_G.destroy(folder, 1.5)
			GpDestroy(folder, 1.5)

		end)
		
		
		
		local function screenFlash(duration)
			local cc = Instance.new("ColorCorrectionEffect")
			cc.Brightness = 1    -- blast to white
			cc.Contrast   = 2
			cc.Saturation = -1   -- desaturate
			cc.TintColor  = Color3.fromRGB(0, 0, 0) -- black tint
			cc.Parent     = workspace.CurrentCamera

			-- fade back to normal
			TS:Create(cc, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Brightness = 0,
				Contrast   = 0,
				Saturation = 0,
				TintColor  = Color3.fromRGB(255, 255, 255),
			}):Play()

			task.delay(duration, cc.Destroy, cc)
		end
		print("Flash")
		screenFlash(.8)
		

	end
	if skillType == "SlashEnd" then
		VFXFunctions.DisableDescendants(SlashVFX)


	end
	if skillType == "blood" then
		local tarPos = argumentData.targetPosition
		local enemyCFrame = argumentData.enemyCFrame  -- pass this from server

		local bloodFX = script.Blood:Clone()
		bloodFX.Parent = workspace.World.Debris
		bloodFX.CFrame = enemyCFrame * CFrame.Angles(0, math.rad(90), 0)  -- already has position + rotation

		VFXFunctions.EnableDescendants(bloodFX)
		task.delay(.8, function()
			VFXFunctions.DisableDescendants(bloodFX)

		end)
		Debris:AddItem(bloodFX, 3)
		

	end
	if skillType == "fall" then


	end
	if skillType == "bloodsword" then
		
		--local BloodFX = script.BloodSword:Clone()
		--local SwordWeapon = character.ZoroSwords.Shisui
		--local VFXPart = SwordWeapon.VFXPart

		--BloodFX.CFrame = VFXPart.CFrame * CFrame.Angles(0,0,math.rad(0))
		--BloodFX.Parent = VFXPart

		--local weld = Instance.new("WeldConstraint")
		--weld.Part0 = VFXPart
		--weld.Part1 = BloodFX
		--weld.Parent = BloodFX

		VFXFunctions.EmitDescendants(VFXPart)
		
		
		--task.delay(3, function()
			--VFXFunctions.DisableDescendants(BloodFX) -- or setParticlesEnabled(BloodFX, false)
			--Debris:AddItem(BloodFX, 1)
		--end)
		
		
	end
	
end