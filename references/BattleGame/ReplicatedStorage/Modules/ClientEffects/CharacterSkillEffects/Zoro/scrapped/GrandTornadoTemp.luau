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

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- script.VFX = your existing tornado VFX folder
	-- script.Visuals = the Visuals folder from GrandTornadoTemp (DashVFX, Wings, FlyVFX, etc.)
	local VFXTornado = script.VFXTornado
	local Visuals    = script.Visuals
	local Assets     = script -- AlignOrientation, LinearVelocity are direct children

	-- ── Helpers ───────────────────────────────────────────────────────────────

	local activeTweens = {}

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

	-- ── skillType handlers ────────────────────────────────────────────────────

	-- ── start: your existing tornado spin VFX ─────────────────────────────────
	if skillType == "start" then
		if not character then return end
		local primaryPart = character.PrimaryPart
		if not primaryPart then return end

		local playbackSpeed = 1
		local effectsFolder = Instance.new("Folder")
		effectsFolder.Parent = workspace.World.Debris

		local rootPart = character:WaitForChild("HumanoidRootPart")
		character:WaitForChild("Humanoid")

		local bottomVFX  = VFXTornado.BottomVFX:Clone()
		local tornadoVFX = VFXTornado.Tornado:Clone()
		local torn2      = VFXTornado.JetBack:Clone()

		task.wait(0.283 / playbackSpeed)

		bottomVFX.CFrame = rootPart.CFrame
		bottomVFX.Parent = effectsFolder
		emitParticles(bottomVFX)

		tornadoVFX.Parent = effectsFolder
		tweenTransparency(tornadoVFX.Twist, 0.5, nil)
		for _, descendant in ipairs(tornadoVFX:GetDescendants()) do
			if descendant:IsA("Decal") then tweenTransparency(descendant, 0.65, "In") end
		end

		torn2.Parent = effectsFolder
		tweenTransparency(torn2.Start, 0.5, nil)
		for _, descendant in ipairs(torn2:GetDescendants()) do
			if descendant:IsA("Decal") then tweenTransparency(descendant, 0.65, "In") end
		end

		task.delay(0.7, function()
			tweenTransparency(torn2.End, 0.5, nil)
			for _, descendant in ipairs(torn2:GetDescendants()) do
				if descendant:IsA("Decal") then tweenTransparency(descendant, 0.65, "In") end
			end
		end)

		local isSpinning = Instance.new("BoolValue")
		isSpinning.Parent = character

		task.spawn(function()
			require(script.TornadoRockModule):startTornado(primaryPart, isSpinning)
		end)

		setParticlesEnabled(tornadoVFX, true)

		local duration  = 3
		local startTime = tick()

		-- Beam bursts every 0.3s while spinning
		task.spawn(function()
			while tick() - startTime < duration do
				task.wait(0.3)
				if not effectsFolder or not effectsFolder.Parent then break end

				local beamClone = VFXTornado.Beams:Clone()
				beamClone.Parent = tornadoVFX
				beamClone.CFrame = tornadoVFX.PrimaryPart.CFrame

				for _, beam in ipairs(beamClone.Beams:GetChildren()) do
					if beam:IsA("Beam") then
						tween(beam, { 0.45, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, { Width0 = 0, Width1 = 0 })
					end
				end
				tween(beamClone, { 0.7, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
					CFrame = beamClone.CFrame * CFrame.new(0, 17, 0) * CFrame.Angles(0, math.rad(150), 0)
				})
				GpDestroy(beamClone, 0.7)
			end
		end)

		-- Spin torn2 fast around the character
		local renderConnection2
		task.spawn(function()
			local spinAngle2 = 0
			renderConnection2 = RunService.RenderStepped:Connect(function(dt)
				spinAngle2 = spinAngle2 + 1400 * dt
				torn2.Start:PivotTo(rootPart.CFrame * CFrame.new(0, 40, 0) * CFrame.Angles(0, math.rad(spinAngle2), 0))
				torn2.End:PivotTo(rootPart.CFrame   * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(spinAngle2), 0))
			end)
		end)

		-- Spin tornadoVFX around the character
		local spinAngle = 0
		local renderConnection = RunService.RenderStepped:Connect(function(dt)
			spinAngle = spinAngle + 500 * dt
			tornadoVFX:PivotTo(rootPart.CFrame * CFrame.new(0, 4.5, 0) * CFrame.Angles(0, math.rad(spinAngle), 0))
		end)

		-- Ground smoke while spinning
		local clockStart = os.clock()
		while os.clock() - clockStart < duration do
			local hit, hitPosition = shared.getRayFloor(primaryPart.CFrame, 8)
			if hit then
				tornadoVFX.VFX.SmokeEnab.WorldCFrame = CFrame.new(hitPosition)
			else
				tornadoVFX.VFX.SmokeEnab.WorldPosition = primaryPart.Position - Vector3.new(0, primaryPart.Size.Y, 0)
			end
			task.wait()
		end

		-- Fade out tornado visuals
		for _, descendant in ipairs(tornadoVFX:GetDescendants()) do
			if descendant:IsA("Decal") or descendant:IsA("Part") then
				tweenTransparency(descendant, 1.25, "Out")
			end
		end
		for _, descendant in ipairs(torn2:GetDescendants()) do
			if descendant:IsA("Decal") or descendant:IsA("Part") or descendant:IsA("MeshPart") then
				tweenTransparency(descendant, 1.25, "Out")
			end
		end

		setParticlesEnabled(tornadoVFX, false)
		isSpinning:Destroy()

		task.delay(1.5, function()
			renderConnection:Disconnect()
			if renderConnection2 then renderConnection2:Disconnect() end
			effectsFolder:Destroy()
		end)

		-- ── fly: initial horizontal dash burst + FOV widen ────────────────────────
	elseif skillType == "fly" then
		--tweenFOV(105, 0.5, Enum.EasingStyle.Exponential, 70, 1, Enum.EasingStyle.Cubic)
		if isLocalPlayer then
			local rootAttachment = hrp:FindFirstChild("RootAttachment")

			-- Attachment to drive AlignOrientation toward camera look
			local velocityAttachment = Instance.new("Attachment")
			velocityAttachment.Name   = "TornadoVelocityAttachment"
			velocityAttachment.Parent = hrp

			local alignOrientation = script.AlignOrientation:Clone()
			alignOrientation.Attachment0     = rootAttachment
			alignOrientation.RigidityEnabled = true
			alignOrientation.Parent          = hrp

			local lockingOrientation = true

			-- Every frame before physics: point character toward camera
			local orientConnection
			--orientConnection = RunService.PreSimulation:Connect(function()
			--	local lookDir = workspace.CurrentCamera.CFrame.LookVector
			--	if lookDir == lookDir and lookDir ~= Vector3.zero then
			--		local flatCFrame = CFrame.lookAlong(Vector3.zero, lookDir)
			--		if flatCFrame.Position == flatCFrame.Position then
			--			velocityAttachment.CFrame = hrp.CFrame.Rotation:Inverse() * flatCFrame
			--			alignOrientation.CFrame   = flatCFrame
			--		end
			--	end
			--	alignOrientation.Enabled = lockingOrientation
			--end)
			orientConnection = RunService.PreSimulation:Connect(function()
				local camLook = workspace.CurrentCamera.CFrame.LookVector

				-- Flatten to horizontal only so looking down doesn't affect movement direction
				local flatLook = Vector3.new(camLook.X, 0, camLook.Z)

				if flatLook.Magnitude < 0.01 then return end -- looking straight up/down, skip
				flatLook = flatLook.Unit

				local flatCFrame = CFrame.lookAlong(Vector3.zero, flatLook)
				velocityAttachment.CFrame = hrp.CFrame.Rotation:Inverse() * flatCFrame
				alignOrientation.CFrame = flatCFrame
				alignOrientation.Enabled = lockingOrientation
			end)
			
			

			-- LinearVelocity for movement
			local linearVelocity = script.LinearVelocity:Clone()
			linearVelocity.Attachment0    = velocityAttachment
			linearVelocity.RelativeTo     = Enum.ActuatorRelativeTo.Attachment0
			linearVelocity.VectorVelocity = Vector3.zero
			linearVelocity.Enabled        = true
			linearVelocity.Parent         = hrp

			-- Initial forward surge
			local surgeTween = TS:Create(linearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
				VectorVelocity = Vector3.new(0, 0, 30)
			})
			surgeTween:Play()
			surgeTween.Completed:Once(function()
				TS:Create(linearVelocity, TweenInfo.new(1.5, Enum.EasingStyle.Cubic), {
					VectorVelocity = Vector3.new(0, 0, -50)
				}):Play()
			end)

			-- Store for other markers to use
			_G.TornadoLinearVelocity    = linearVelocity
			_G.TornadoOrientConnection  = orientConnection
			_G.TornadoVelocityAttachment = velocityAttachment
			_G.TornadoAlignOrientation  = alignOrientation
			_G.TornadoLockingOrientation = function(val) lockingOrientation = val end
		end

		-- Burst VFX at root
		local burstClone = Visuals.InitialDashVFX:Clone()
		burstClone.CFrame  = hrp.CFrame
		burstClone.Parent  = workspace.World.Debris
		emitParticles(burstClone)
		Debris:AddItem(burstClone, 4)

		-- Slash mesh rotated sideways
		local meshCFrame = hrp.CFrame * CFrame.Angles(0, math.rad(90), math.rad(90))
		local meshClone  = Visuals.StartDashMesh:Clone()
		
		--meshClone.CFrame = meshCFrame
		meshClone:PivotTo(meshCFrame)

		meshClone.Parent = workspace.World.Debris
		emitParticles(meshClone)
		Debris:AddItem(meshClone, 3)

		-- Dash trail welded to root
		local dashTrail = Visuals.DashVFX:Clone()
		dashTrail:PivotTo(hrp.CFrame)
		dashTrail.Parent = workspace.World.Debris
		weldMotor(dashTrail, hrp, dashTrail.PrimaryPart, nil, CFrame.new(0, 3, 0))
		Debris:AddItem(dashTrail, 4)

		-- ── up: character launches upward ─────────────────────────────────────────
	elseif skillType == "up" then
		if isLocalPlayer and _G.TornadoLinearVelocity then
			_G.TornadoLockingOrientation(false)
			_G.TornadoLinearVelocity.VectorVelocity = Vector3.new(0, 60, 0)
			local upTween = TS:Create(_G.TornadoLinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				VectorVelocity = Vector3.new(0, 125, -20)
			})
			upTween:Play()
			upTween.Completed:Wait()
			TS:Create(_G.TornadoLinearVelocity, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
				VectorVelocity = Vector3.new(0, 40, 0)
			}):Play()
		end
		tweenFOV(90, 0.4, Enum.EasingStyle.Sine, 70, 2, Enum.EasingStyle.Sine)

		-- Upward fly VFX at root
		local flyClone = Visuals.FlyVFX:Clone()
		flyClone:PivotTo(hrp.CFrame)
		flyClone.Parent = workspace.World.Debris
		emitParticles(flyClone)

		-- Stop and destroy after 1s
		task.delay(1, function()
			for _, desc in flyClone:GetDescendants() do
				if desc:IsA("ParticleEmitter") then desc.Enabled = false end
			end
			task.delay(2, flyClone.Destroy, flyClone)
		end)

		-- Fly meshes angled upward
		local upwardCFrame = CFrame.new(hrp.Position) * CFrame.Angles(math.rad(180), math.rad(90), 0)

		local flyDashClone = Visuals.FlyDashMesh:Clone()
		--flyDashClone.CFrame = upwardCFrame
		flyDashClone:PivotTo(upwardCFrame) 
		flyDashClone.Parent = workspace.World.Debris
		emitParticles(flyDashClone)
		Debris:AddItem(flyDashClone, 3)

		local flyUpClone = Visuals.FlyUpMesh:Clone()
		
		--flyUpClone.CFrame = upwardCFrame
		flyUpClone:PivotTo(upwardCFrame)
		flyUpClone.Parent = workspace.World.Debris
		emitParticles(flyUpClone)
		Debris:AddItem(flyUpClone, 3)

		-- Upward dash trail welded to root at a -90° angle
		local upTrail = Visuals.DashUpVFX:Clone()
		upTrail:PivotTo(hrp.CFrame)
		upTrail.Parent = workspace.World.Debris
		weldMotor(upTrail, hrp, upTrail, nil, CFrame.new(0, 3, 0) * CFrame.Angles(math.rad(-90), 0, 0))

		task.delay(1, function()
			for _, desc in upTrail:GetDescendants() do
				if desc:IsA("ParticleEmitter") then desc.Enabled = false end
			end
			task.delay(2, upTrail.Destroy, upTrail)
		end)

		-- ── upback: arc backward, boost mesh ──────────────────────────────────────
	elseif skillType == "upback" then
		if isLocalPlayer and _G.TornadoLinearVelocity then
			TS:Create(_G.TornadoLinearVelocity, TweenInfo.new(0.3), {
				VectorVelocity = Vector3.new(0, 60, -70)
			}):Play()

			-- Manual gravity until Y velocity goes negative, then dive
			local gravConn
			gravConn = RunService.PreSimulation:Connect(function(dt)
				if not _G.TornadoLinearVelocity then gravConn:Disconnect() return end
				_G.TornadoLinearVelocity.VectorVelocity -= Vector3.new(0, 350 * dt, 0)
				if _G.TornadoLinearVelocity.VectorVelocity.Y < 0 then
					gravConn:Disconnect()
					TS:Create(_G.TornadoLinearVelocity, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
						VectorVelocity = Vector3.new(0, -300, -15)
					}):Play()
				end
			end)
		end
		local boostCFrame = hrp.CFrame * CFrame.Angles(math.rad(-40), math.rad(90), 0)
		local boostClone  = Visuals.FlyBoostMesh:Clone()
		
		--boostClone.CFrame = boostCFrame
		boostClone:PivotTo(boostCFrame)

		boostClone.Parent = workspace.World.Debris
		emitParticles(boostClone)
		Debris:AddItem(boostClone, 3)

		-- ── dive: spin trail + FOV + local player raycast fires server ────────────
	elseif skillType == "dive" then
		tweenFOV(90, 0.75, Enum.EasingStyle.Sine, 70, 1, Enum.EasingStyle.Sine)

		-- Downward dash trail welded to root
		local downDash = Visuals.DownwardsDash:Clone()
		downDash.Name   = downDash.Name .. character.Name
		downDash.CFrame = hrp.CFrame
		downDash.Parent = workspace.World.Debris

		local downWeld  = Instance.new("Motor6D", downDash)
		downWeld.Part0  = downDash
		downWeld.Part1  = hrp
		downWeld.C0     = CFrame.Angles(math.rad(-90), 0, 0)

		local diveTrail = Visuals.DashVFX:Clone()
		diveTrail:PivotTo(hrp.CFrame)
		diveTrail.Parent = downDash
		weldMotor(diveTrail, hrp, diveTrail.PrimaryPart, CFrame.Angles(math.rad(-90), 0, 0), nil)

		-- Only local player does the ground raycast and fires the server
		if isLocalPlayer then
			local rayParams = RaycastParams.new()
			rayParams.FilterType = Enum.RaycastFilterType.Exclude
			rayParams.FilterDescendantsInstances = { character }

			local diveConnection
			diveConnection = RunService.PostSimulation:Connect(function()
				local hit, hitPosition = shared.getRayFloor(hrp.CFrame, 8)
				if hit then
					--diveConnection:Disconnect()
					--downDash:Destroy()
					--RemotesContainer.GrandTornadoLanded:FireServer()
					
					diveConnection:Disconnect()
					downDash:Destroy()

					-- clean up movement
					if _G.TornadoLinearVelocity then _G.TornadoLinearVelocity:Destroy() end
					if _G.TornadoOrientConnection then _G.TornadoOrientConnection:Disconnect() end
					if _G.TornadoVelocityAttachment then _G.TornadoVelocityAttachment:Destroy() end
					if _G.TornadoAlignOrientation then _G.TornadoAlignOrientation:Destroy() end
					_G.TornadoLinearVelocity     = nil
					_G.TornadoOrientConnection   = nil
					_G.TornadoVelocityAttachment = nil
					_G.TornadoAlignOrientation   = nil

					RemotesContainer.GrandTornadoLanded:FireServer()
					
					
				end
			end)
		end

		-- ── impactVFX: crater VFX on landing ──────────────────────────────────────
	elseif skillType == "impactVFX" then
		local impactPos = argumentData.ImpactPosition

		tweenFOV(105, 0.3, Enum.EasingStyle.Sine, 70, 1, Enum.EasingStyle.Quad)

		local impactClone = Visuals.ImpactVFX:Clone()
		impactClone:PivotTo(CFrame.new(impactPos))
		impactClone.Parent = workspace.World.Debris
		emitParticles(impactClone)
		Debris:AddItem(impactClone, 5)

		local impactMeshCFrame = CFrame.new(impactPos) * CFrame.Angles(0, math.rad(90), 0) + Vector3.new(0, 10, 0)
		local meshClone = Visuals.ImpactMesh:Clone()
		--meshClone.CFrame = impactMeshCFrame
		meshClone:PivotTo(impactMeshCFrame)
		meshClone.Parent = workspace.World.Debris
		emitParticles(meshClone)
		Debris:AddItem(meshClone, 4)

		-- Glass shatter effect
		local glassClone = Visuals.GlassMesh:Clone()
		--glassClone.CFrame = CFrame.new(impactPos)
		
		--glassClone:PivotTo(impactPos)
		glassClone:PivotTo(CFrame.new(impactPos))


		glassClone.Parent = workspace.World.Debris
		emitParticles(glassClone)
		Debris:AddItem(glassClone, 3)

		-- ── explode: enemies blasted outward ──────────────────────────────────────
	elseif skillType == "explode" then
		local impactPos = argumentData.ImpactPosition

		tweenFOV(110, 0.2, Enum.EasingStyle.Exponential, 70, 1.5, Enum.EasingStyle.Cubic)

		-- Reuse ImpactVFX for the explosion blast
		local explodeClone = Visuals.ImpactVFX:Clone()
		explodeClone:PivotTo(CFrame.new(impactPos))
		explodeClone.Parent = workspace.World.Debris
		emitParticles(explodeClone)
		Debris:AddItem(explodeClone, 5)

		local flyDownClone = Visuals.FlyDownMesh:Clone()
		--flyDownClone.CFrame = CFrame.new(impactPos) * CFrame.Angles(0, math.rad(90), 0)
		flyDownClone:PivotTo(CFrame.new(impactPos) * CFrame.Angles(0, math.rad(90), 0))
		flyDownClone.Parent = workspace.World.Debris
		emitParticles(flyDownClone)
		Debris:AddItem(flyDownClone, 4)
	end
end