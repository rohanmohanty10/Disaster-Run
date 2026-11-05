local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris            = game:GetService("Debris")
local TS                = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local Lighting          = game:GetService("Lighting")

local LocalPlayer  = Players.LocalPlayer
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local BoatTween    = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)
local Velocity     = require(ReplicatedStorage.Modules.Velocity2)
local MilkVFX      = require(ReplicatedStorage.Modules.ClientEffects.RandomModules2.VFXLibrary)

local currentCamera = workspace.CurrentCamera
local followUpAnimTrack = script.user1

-- ============================================================================
--  HELPERS
-- ============================================================================

-- Emits every child in `container` that has a "Start" child (mesh-emit pattern).
local function emitMeshGroup(cframe, container)
	for _, meshEffect in container:GetChildren() do
		if meshEffect:FindFirstChild("Start") then
			MilkVFX.mesh_emit.EmitAt(cframe, meshEffect)
		end
	end
end

-- Clone a particle template, emit it, schedule cleanup.
--local function spawnParticle(parent, template, lifetime, weld)
--	local clone = template:Clone()
--	clone.Parent = parent
--	if weld then
--		local w = Instance.new("Weld")
--		w.Part0 = parent
--		w.Part1 = clone
--		w.Parent = clone
--	end
--	VFXFunctions.EmitDescendants(clone)
--	if lifetime then
--		task.delay(lifetime,     function() VFXFunctions.DisableDescendants(clone) end)
--		task.delay(lifetime + 1, function() if clone.Parent then clone:Destroy() end end)
--	end
--	return clone
--end

local function spawnParticle(parent, template, lifetime, weld)
	local clone = template:Clone()
	clone.Parent = parent
	if weld then
		local weldInstance = Instance.new("Weld")
		weldInstance.Part0 = parent
		weldInstance.Part1 = clone
		weldInstance.Parent = clone
	end
	MilkVFX.Particles.enableParticles(clone)
	if lifetime then
		task.delay(lifetime, MilkVFX.Particles.disableParticles, clone)
		task.delay(lifetime + 1, clone.Destroy, clone)
	end
	return clone
end

-- ============================================================================
return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local victim: Model   = argumentData.Victim
	local isLocalPlayer   = LocalPlayer.Character == attacker
	local isVictim        = victim and LocalPlayer.Character == victim

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	-- ================================================================
	--  slashSwing
	-- ================================================================
	if skillType == "slashSwing" then
		local leftArm  = attacker:FindFirstChild("Left Arm")
		local rightArm = attacker:FindFirstChild("Right Arm")

		if leftArm and rightArm then
			local leftStar = script.slashSwing.Star:Clone()
			leftStar.Parent = leftArm
			VFXFunctions.EmitDescendants(leftStar)

			local rightStar = script.slashSwing.Star:Clone()
			rightStar.Parent = rightArm
			VFXFunctions.EmitDescendants(rightStar)

			task.delay(0.38, function()
				if leftStar.Parent  then leftStar:Destroy()  end
				if rightStar.Parent then rightStar:Destroy() end
			end)
		end

		-- Character highlight flash
		MilkVFX.Highlight.tweenHighlight(attacker,
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
			0.5, Enum.HighlightDepthMode.Occluded, "In", 0.3
		)

		if isLocalPlayer then
			MilkVFX.Lighting.colorCorrectionFlash(0.05, 0.2, 1.5, Color3.fromRGB(176, 204, 255), 0.3)
			-- camera shake here if you have one
		end

		MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(200, 73, 255), 0.6, 5, 15, 2)

		-- Mesh swing burst
		emitMeshGroup(hrp.CFrame, script.slashSwing.Swings)

		-- Main swing beam
		script.slashSwing.Swings.Beam.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.slashSwing.Swings.Beam, {
			RotationSpeed = 0,
			Rotation = true,
			Duration = 0.9,
			Easing = "Quad",
			EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = 0.6, Width0 = 0, Width1 = 6 },
			Offset = CFrame.new(0, 0, 0),
		})

		-- Swing particles
		local swingParticles = script.slashSwing.SwingsAtt:Clone()
		swingParticles.Parent = hrp
		VFXFunctions.EmitDescendants(swingParticles)
		task.delay(4, function() if swingParticles.Parent then swingParticles:Destroy() end end)

		-- Side beams
		script.slashSwing.Swings.SideBeams.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.slashSwing.Swings.SideBeams, {
			RotationSpeed = 0,
			Rotation = true,
			Duration = 0.75,
			Easing = "Quad",
			EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = 1.1, Width0 = 1, Width1 = 24 },
			Offset = CFrame.new(0, 0, 0),
		})
	end

	-- ================================================================
	--  slashHit
	-- ================================================================
	if skillType == "slashHit" then
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")

		if isLocalPlayer then
			-- camera shake here if you have one
		end

		if victimHrp then
			local hitParticles = script.slashHit.Hit:Clone()
			hitParticles.Parent = victimHrp
			VFXFunctions.EmitDescendants(hitParticles)
			task.delay(4, function() if hitParticles.Parent then hitParticles:Destroy() end end)

			local hitPart = script.slashHit.HitPart:Clone()
			hitPart.Parent = workspace.World.Visuals
			hitPart.CFrame = victimHrp.CFrame
			VFXFunctions.EmitDescendants(hitPart)
			task.delay(4, function() if hitPart.Parent then hitPart:Destroy() end end)

			-- KarsBeams (12 studs in front of victim)
			script.slashHit.KarsBeams.CFrame = victimHrp.CFrame * CFrame.new(0, 0, -12)
			MilkVFX.Beam.Spawn(script.slashHit.KarsBeams, {
				RotationSpeed = 5,
				Rotation = true,
				Duration = 0.35,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 16, TextureSpeed = 0, Width0 = 0, Width1 = 0 },
				Offset = CFrame.new(0, 0, 0),
			})

			-- Spin beams
			script.slashHit.Spindeezbeams.CFrame = victimHrp.CFrame
			MilkVFX.Beam.Spawn(script.slashHit.Spindeezbeams, {
				RotationSpeed = 2,
				Rotation = true,
				Duration = 0.7,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = 0.45, Width0 = 10, Width1 = 0 },
				Offset = CFrame.new(0, 0, -12),
			})
		end
	end

	-- ================================================================
	--  followUpDash
	-- ================================================================
	if skillType == "followUpDash" then
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")
		if not victimHrp then return end

		local spinLifetime = 0.5167  -- must match server task.delay

		MilkVFX.Highlight.tweenHighlight(attacker,
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
			1, Enum.HighlightDepthMode.Occluded, "In", 0.3
		)

		local launchParticles = script.Attachments.Launch:Clone()
		launchParticles.Parent = hrp
		VFXFunctions.EmitDescendants(launchParticles)
		task.delay(4, function() if launchParticles.Parent then launchParticles:Destroy() end end)

		spawnParticle(attacker.Torso,       script.Attachments.Spin,      spinLifetime, false)
		spawnParticle(attacker["Left Arm"],  script.Attachments.JumpTrail, spinLifetime, false)
		spawnParticle(attacker["Right Arm"], script.Attachments.JumpTrail, spinLifetime, false)
		local MainDash = script.MainDash:Clone()
		MainDash.Parent = attacker
		MainDash.Weld.Part0 = attacker.HumanoidRootPart
		VFXFunctions.ToggleAll(MainDash, true, false, true, true)
		task.delay(spinLifetime, function()
			VFXFunctions.ToggleAll(MainDash, false, false, true, true)
			VFXFunctions.TaskDebris(MainDash, 2)
		end)
		
		
		--spawnParticle(attacker.Torso,       script.MainDash,      spinLifetime, false)
		
		task.delay(spinLifetime, function()
			local landParticles = script.Attachments.Land:Clone()
			landParticles.Parent = hrp
			VFXFunctions.EmitDescendants(landParticles)
			task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)
		end)

		if isLocalPlayer then
			local localChar = LocalPlayer.Character
			local localHrp  = localChar and localChar:FindFirstChild("HumanoidRootPart")
			if not localHrp then return end

			followUpAnimTrack = localChar.Humanoid.Animator:LoadAnimation(script.user1)
			followUpAnimTrack:Play()

			local meshTimer = 0

			Velocity.bezier(
				localHrp,
				victimHrp,
				CFrame.new(-25, 10, 0),
				spinLifetime,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.Out,
				CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
				false,
				function(orientCF, heading, dt)
					local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
						* CFrame.Angles(0, -math.pi / 2, 0)
					
					if MainDash and MainDash.Weld then
						MainDash.Weld.C0 = hrp.CFrame:ToObjectSpace(faceCFrame) * CFrame.Angles(0, math.rad(90), 0)
					end
					
					
					meshTimer += dt
					if meshTimer > 0.0833 then
						--emitMeshGroup(faceCFrame, script.Rush)
						meshTimer = 0
					end
				end
			)

			TS:Create(currentCamera,
				TweenInfo.new(0.3333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true),
				{ FieldOfView = 50 }
			):Play()

			task.delay(spinLifetime, function()
				-- camera shake here if you have one
			end)
		end
	end

	-- ================================================================
	--  followUpImpact
	-- ================================================================
	if skillType == "followUpImpact" then
		local victimHrp   = victim and victim:FindFirstChild("HumanoidRootPart")
		local targetCFrame = victimHrp and victimHrp.CFrame or hrp.CFrame * CFrame.new(0, 0, -10)

		if isLocalPlayer or isVictim then
			TS:Create(currentCamera,
				TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
				{ FieldOfView = 50 }
			):Play()

			MilkVFX.Lighting.colorCorrectionFlash(0, 0.2, 3, Color3.fromRGB(143, 127, 150), 1.6)

			task.delay(0.3, function()
				TS:Create(currentCamera,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
					{ FieldOfView = 80 }
				):Play()
				MilkVFX.Lighting.colorCorrectionFlash(0.05, 0.2, 1.5, Color3.fromRGB(176, 204, 255), 0.3)
			end)
		end

		if isLocalPlayer then
			local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if localHrp then
				local rootAtt = localHrp:FindFirstChild("RootAttachment")
				if rootAtt then Velocity.Stop(rootAtt) end
				localHrp.AssemblyLinearVelocity = Vector3.zero
			end

			if followUpAnimTrack then
				followUpAnimTrack.TimePosition = 0.6167
				followUpAnimTrack:AdjustSpeed(0)
				task.delay(0.3, function()
					if followUpAnimTrack then
						followUpAnimTrack:AdjustSpeed(1)
						followUpAnimTrack = nil
					end
				end)
			end
		end

		local spinFX = attacker.Torso:FindFirstChild("Spin")
		if spinFX then spinFX:Destroy() end
		local leftTrail  = attacker["Left Arm"]:FindFirstChild("JumpTrail")
		if leftTrail  then leftTrail:Destroy()  end
		local rightTrail = attacker["Right Arm"]:FindFirstChild("JumpTrail")
		if rightTrail then rightTrail:Destroy() end

		local landParticles = script.Attachments.Land:Clone()
		landParticles.Parent = hrp
		VFXFunctions.EmitDescendants(landParticles)
		task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)

		local windupParticles = script.Attachments.Windup:Clone()
		windupParticles.Parent = hrp
		VFXFunctions.EmitDescendants(windupParticles)
		task.delay(4, function() if windupParticles.Parent then windupParticles:Destroy() end end)

		spawnParticle(hrp, script.Wind, 0.3, true)

		script.Windup.SideBeams2.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.Windup.SideBeams2, {
			RotationSpeed = 0,
			Rotation = true,
			Duration = 0.3,
			Easing = "Quad",
			EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 14 },
			Offset = CFrame.new(0, 0, 0),
		})

		task.delay(0.3, function()
			local bigSlash = script.Attachments.BigSlash:Clone()
			bigSlash.Parent = hrp
			VFXFunctions.EmitDescendants(bigSlash)
			task.delay(4, function() if bigSlash.Parent then bigSlash:Destroy() end end)

			local groundFX = script.FX:Clone()
			groundFX.Parent = workspace.World.Visuals
			groundFX.CFrame = hrp.CFrame
			VFXFunctions.EmitDescendants(groundFX)
			task.delay(4, function() if groundFX.Parent then groundFX:Destroy() end end)

			script.FinalSlash.SideBeams.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams, {
				RotationSpeed = 0,
				Rotation = true,
				Duration = 1,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -0.6, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.SideBeams2.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams2, {
				RotationSpeed = 0,
				Rotation = true,
				Duration = 0.5,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 166, 94), 0.2, 5, 12, 12)
			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 143, 69), 1.5, 5, 15, 2)

			emitMeshGroup(hrp.CFrame, script.FinalSlash)

			script.FinalSlash.KarsBeams.CFrame = hrp.CFrame * CFrame.new(0, 0, -12)
			MilkVFX.Beam.Spawn(script.FinalSlash.KarsBeams, {
				RotationSpeed = 5,
				Rotation = true,
				Duration = 0.5,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 16, TextureSpeed = 0, Width0 = 0, Width1 = 0 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.Beam.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.Beam, {
				RotationSpeed = 0,
				Rotation = true,
				Duration = 1,
				Easing = "Quad",
				EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = 0.6, Width0 = 0, Width1 = 6 },
				Offset = CFrame.new(0, 0, 0),
			})
		end)
	end
	-- ================================================================
	--  followUpDash2  (mirrors followUpDash, bezier flipped to the RIGHT)
	-- ================================================================
	if skillType == "followUpDash2" then
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")
		if not victimHrp then return end

		local spinLifetime = 0.5167

		MilkVFX.Highlight.tweenHighlight(attacker,
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
			1, Enum.HighlightDepthMode.Occluded, "In", 0.3
		)

		local launchParticles = script.Attachments.Launch:Clone()
		launchParticles.Parent = hrp
		VFXFunctions.EmitDescendants(launchParticles)
		task.delay(4, function() if launchParticles.Parent then launchParticles:Destroy() end end)

		spawnParticle(attacker.Torso,       script.Attachments.Spin,      spinLifetime, false)
		spawnParticle(attacker["Left Arm"],  script.Attachments.JumpTrail, spinLifetime, false)
		spawnParticle(attacker["Right Arm"], script.Attachments.JumpTrail, spinLifetime, false)
		--spawnParticle(attacker.Torso,       script.MainDash,      spinLifetime, false)
		local MainDash = script.MainDash:Clone()
		MainDash.Parent = attacker
		MainDash.Weld.Part0 = attacker.HumanoidRootPart
		VFXFunctions.ToggleAll(MainDash, true, false, true, true)
		task.delay(spinLifetime, function()
			VFXFunctions.ToggleAll(MainDash, false, false, true, true)
			VFXFunctions.TaskDebris(MainDash, 2)
		end)

		task.delay(spinLifetime, function()
			local landParticles = script.Attachments.Land:Clone()
			landParticles.Parent = hrp
			VFXFunctions.EmitDescendants(landParticles)
			task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)
		end)

		if isLocalPlayer then
			local localChar = LocalPlayer.Character
			local localHrp  = localChar and localChar:FindFirstChild("HumanoidRootPart")
			if not localHrp then return end

			followUpAnimTrack = localChar.Humanoid.Animator:LoadAnimation(script.user2)
			followUpAnimTrack:Play()

			local meshTimer = 0
			
			Velocity.bezier(
				localHrp,
				victimHrp,
				CFrame.new(25, 5, 0),
				spinLifetime,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.Out,
				CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
				false,
				function(orientCF, heading, dt)
					local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
						* CFrame.Angles(0, math.pi / 2, 0)
					if MainDash and MainDash.Weld then
						MainDash.Weld.C0 = hrp.CFrame:ToObjectSpace(faceCFrame) * CFrame.Angles(0, math.rad(-90), 0)
					end
					meshTimer += dt
					if meshTimer > 0.0833 then
						--emitMeshGroup(faceCFrame, script.Rush)
						meshTimer = 0
					end
				end
			)
			

			--Velocity.bezier(
			--	localHrp,
			--	victimHrp,
			--	CFrame.new(40, 10, 0),  -- ← mirrored to the right (was -25)
			--	spinLifetime,
			--	Enum.EasingStyle.Sine,
			--	Enum.EasingDirection.Out,
			--	CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
			--	false,
			--	function(orientCF, heading, dt)
			--		local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
			--			* CFrame.Angles(0, -math.pi / 2, 0)
			--		meshTimer += dt
			--		if meshTimer > 0.0833 then
			--			emitMeshGroup(faceCFrame, script.Rush2)
			--			meshTimer = 0
			--		end
			--	end
			--)

			TS:Create(currentCamera,
				TweenInfo.new(0.3333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true),
				{ FieldOfView = 50 }
			):Play()

			task.delay(spinLifetime, function()
				-- camera shake here if you have one
			end)
		end
	end

	
	if skillType == "followUpImpact2" then
		--if isLocalPlayer or isVictim then
		--	TS:Create(currentCamera,
		--		TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		--		{ FieldOfView = 50 }
		--	):Play()

		--	MilkVFX.Lighting.colorCorrectionFlash(0, 0.2, 3, Color3.fromRGB(143, 127, 150), 1.6)

		--	task.delay(0.3, function()
		--		TS:Create(currentCamera,
		--			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		--			{ FieldOfView = 70 }
		--		):Play()
		--		MilkVFX.Lighting.colorCorrectionFlash(0.05, 0.2, 1.5, Color3.fromRGB(176, 204, 255), 0.3)
		--	end)
		--end

		if isLocalPlayer then
			local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if localHrp then
				local rootAtt = localHrp:FindFirstChild("RootAttachment")
				if rootAtt then Velocity.Stop(rootAtt) end
				localHrp.AssemblyLinearVelocity = Vector3.zero
			end

			if followUpAnimTrack then
				followUpAnimTrack.TimePosition = 0.6167
				followUpAnimTrack:AdjustSpeed(0)
				task.delay(0.3, function()
					if followUpAnimTrack then
						followUpAnimTrack:AdjustSpeed(1)
						followUpAnimTrack = nil
					end
				end)
			end
		end

		local spinFX = attacker.Torso:FindFirstChild("Spin")
		if spinFX then spinFX:Destroy() end
		local leftTrail  = attacker["Left Arm"]:FindFirstChild("JumpTrail")
		if leftTrail  then leftTrail:Destroy()  end
		local rightTrail = attacker["Right Arm"]:FindFirstChild("JumpTrail")
		if rightTrail then rightTrail:Destroy() end

		local landParticles = script.Attachments.Land:Clone()
		landParticles.Parent = hrp
		VFXFunctions.EmitDescendants(landParticles)
		task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)

		local windupParticles = script.Attachments.Windup:Clone()
		windupParticles.Parent = hrp
		VFXFunctions.EmitDescendants(windupParticles)
		task.delay(4, function() if windupParticles.Parent then windupParticles:Destroy() end end)

		spawnParticle(hrp, script.Wind, 0.3, true)

		script.Windup.SideBeams2.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.Windup.SideBeams2, {
			RotationSpeed = 0, Rotation = true, Duration = 0.3, Easing = "Quad", EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 14 },
			Offset = CFrame.new(0, 0, 0),
		})

		task.delay(0.3, function()
			local bigSlash = script.Attachments.BigSlash:Clone()
			bigSlash.Parent = hrp
			VFXFunctions.EmitDescendants(bigSlash)
			task.delay(4, function() if bigSlash.Parent then bigSlash:Destroy() end end)

			local groundFX = script.FX:Clone()
			groundFX.Parent = workspace.World.Visuals
			groundFX.CFrame = hrp.CFrame
			VFXFunctions.EmitDescendants(groundFX)
			task.delay(4, function() if groundFX.Parent then groundFX:Destroy() end end)

			script.FinalSlash.SideBeams.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -0.6, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.SideBeams2.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams2, {
				RotationSpeed = 0, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 166, 94), 0.2, 5, 12, 12)
			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 143, 69), 1.5, 5, 15, 2)

			emitMeshGroup(hrp.CFrame, script.FinalSlash)

			script.FinalSlash.KarsBeams.CFrame = hrp.CFrame * CFrame.new(0, 0, -12)
			MilkVFX.Beam.Spawn(script.FinalSlash.KarsBeams, {
				RotationSpeed = 5, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 16, TextureSpeed = 0, Width0 = 0, Width1 = 0 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.Beam.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.Beam, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = 0.6, Width0 = 0, Width1 = 6 },
				Offset = CFrame.new(0, 0, 0),
			})
		end)
	end
	
	
	
	if skillType == "followUpDash3" then
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")
		if not victimHrp then return end

		local spinLifetime = 0.5167

		MilkVFX.Highlight.tweenHighlight(attacker,
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
			1, Enum.HighlightDepthMode.Occluded, "In", 0.3
		)

		local launchParticles = script.Attachments.Launch:Clone()
		launchParticles.Parent = hrp
		VFXFunctions.EmitDescendants(launchParticles)
		task.delay(4, function() if launchParticles.Parent then launchParticles:Destroy() end end)

		spawnParticle(attacker.Torso,       script.Attachments.Spin,      spinLifetime, false)
		spawnParticle(attacker["Left Arm"],  script.Attachments.JumpTrail, spinLifetime, false)
		spawnParticle(attacker["Right Arm"], script.Attachments.JumpTrail, spinLifetime, false)
		--spawnParticle(attacker.Torso,       script.MainDash,      spinLifetime, false)
		local MainDash = script.MainDash:Clone()
		MainDash.Parent = attacker
		MainDash.Weld.Part0 = attacker.HumanoidRootPart
		VFXFunctions.ToggleAll(MainDash, true, false, true, true)
		task.delay(spinLifetime, function()
			VFXFunctions.ToggleAll(MainDash, false, false, true, true)
			VFXFunctions.TaskDebris(MainDash, 2)
		end)

		task.delay(spinLifetime, function()
			local landParticles = script.Attachments.Land:Clone()
			landParticles.Parent = hrp
			VFXFunctions.EmitDescendants(landParticles)
			task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)
		end)

		if isLocalPlayer then
			local localChar = LocalPlayer.Character
			local localHrp  = localChar and localChar:FindFirstChild("HumanoidRootPart")
			if not localHrp then return end

			followUpAnimTrack = localChar.Humanoid.Animator:LoadAnimation(script.user3)
			followUpAnimTrack:Play()

			local meshTimer = 0

			Velocity.bezier(
				localHrp,
				victimHrp,
				CFrame.new(5, 35, 0),
				spinLifetime,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.Out,
				CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
				false,
				function(orientCF, heading, dt)
					local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
						* CFrame.Angles(0, -math.pi / 2, 0)
					if MainDash and MainDash.Weld then
						MainDash.Weld.C0 = hrp.CFrame:ToObjectSpace(faceCFrame) * CFrame.Angles(0, math.rad(90), 0)
					end
					meshTimer += dt
					if meshTimer > 0.0833 then
						--emitMeshGroup(faceCFrame, script.Rush)
						meshTimer = 0
					end
				end
			)


			--Velocity.bezier(
			--	localHrp,
			--	victimHrp,
			--	CFrame.new(40, 10, 0),  -- ← mirrored to the right (was -25)
			--	spinLifetime,
			--	Enum.EasingStyle.Sine,
			--	Enum.EasingDirection.Out,
			--	CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
			--	false,
			--	function(orientCF, heading, dt)
			--		local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
			--			* CFrame.Angles(0, -math.pi / 2, 0)
			--		meshTimer += dt
			--		if meshTimer > 0.0833 then
			--			emitMeshGroup(faceCFrame, script.Rush2)
			--			meshTimer = 0
			--		end
			--	end
			--)

			TS:Create(currentCamera,
				TweenInfo.new(0.3333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true),
				{ FieldOfView = 50 }
			):Play()

			task.delay(spinLifetime, function()
				-- camera shake here if you have one
			end)
		end
	end

	
	if skillType == "followUpImpact3" then
		--if isLocalPlayer or isVictim then
		--	TS:Create(currentCamera,
		--		TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		--		{ FieldOfView = 50 }
		--	):Play()

		--	MilkVFX.Lighting.colorCorrectionFlash(0, 0.2, 3, Color3.fromRGB(143, 127, 150), 1.6)

		--	task.delay(0.3, function()
		--		TS:Create(currentCamera,
		--			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		--			{ FieldOfView = 70 }
		--		):Play()
		--		MilkVFX.Lighting.colorCorrectionFlash(0.05, 0.2, 1.5, Color3.fromRGB(176, 204, 255), 0.3)
		--	end)
		--end

		if isLocalPlayer then
			local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if localHrp then
				local rootAtt = localHrp:FindFirstChild("RootAttachment")
				if rootAtt then Velocity.Stop(rootAtt) end
				localHrp.AssemblyLinearVelocity = Vector3.zero
			end

			if followUpAnimTrack then
				followUpAnimTrack.TimePosition = 0.6167
				followUpAnimTrack:AdjustSpeed(0)
				task.delay(0.3, function()
					if followUpAnimTrack then
						followUpAnimTrack:AdjustSpeed(1)
						followUpAnimTrack = nil
					end
				end)
			end
		end

		local spinFX = attacker.Torso:FindFirstChild("Spin")
		if spinFX then spinFX:Destroy() end
		local leftTrail  = attacker["Left Arm"]:FindFirstChild("JumpTrail")
		if leftTrail  then leftTrail:Destroy()  end
		local rightTrail = attacker["Right Arm"]:FindFirstChild("JumpTrail")
		if rightTrail then rightTrail:Destroy() end

		local landParticles = script.Attachments.Land:Clone()
		landParticles.Parent = hrp
		VFXFunctions.EmitDescendants(landParticles)
		task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)

		local windupParticles = script.Attachments.Windup:Clone()
		windupParticles.Parent = hrp
		VFXFunctions.EmitDescendants(windupParticles)
		task.delay(4, function() if windupParticles.Parent then windupParticles:Destroy() end end)

		spawnParticle(hrp, script.Wind, 0.3, true)

		script.Windup.SideBeams2.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.Windup.SideBeams2, {
			RotationSpeed = 0, Rotation = true, Duration = 0.3, Easing = "Quad", EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 14 },
			Offset = CFrame.new(0, 0, 0),
		})

		task.delay(0.3, function()
			local bigSlash = script.Attachments.BigSlash:Clone()
			bigSlash.Parent = hrp
			VFXFunctions.EmitDescendants(bigSlash)
			task.delay(4, function() if bigSlash.Parent then bigSlash:Destroy() end end)

			local groundFX = script.FX:Clone()
			groundFX.Parent = workspace.World.Visuals
			groundFX.CFrame = hrp.CFrame
			VFXFunctions.EmitDescendants(groundFX)
			task.delay(4, function() if groundFX.Parent then groundFX:Destroy() end end)

			script.FinalSlash.SideBeams.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -0.6, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.SideBeams2.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams2, {
				RotationSpeed = 0, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 166, 94), 0.2, 5, 12, 12)
			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 143, 69), 1.5, 5, 15, 2)

			emitMeshGroup(hrp.CFrame, script.FinalSlash)

			script.FinalSlash.KarsBeams.CFrame = hrp.CFrame * CFrame.new(0, 0, -12)
			MilkVFX.Beam.Spawn(script.FinalSlash.KarsBeams, {
				RotationSpeed = 5, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 16, TextureSpeed = 0, Width0 = 0, Width1 = 0 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.Beam.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.Beam, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = 0.6, Width0 = 0, Width1 = 6 },
				Offset = CFrame.new(0, 0, 0),
			})
		end)
	end
	
	
	if skillType == "followUpDash4" then
		local victimHrp = victim and victim:FindFirstChild("HumanoidRootPart")
		if not victimHrp then return end

		local spinLifetime = 0.5167

		MilkVFX.Highlight.tweenHighlight(attacker,
			Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255),
			1, Enum.HighlightDepthMode.Occluded, "In", 0.3
		)

		local launchParticles = script.Attachments.Launch:Clone()
		launchParticles.Parent = hrp
		VFXFunctions.EmitDescendants(launchParticles)
		task.delay(4, function() if launchParticles.Parent then launchParticles:Destroy() end end)

		spawnParticle(attacker.Torso,       script.Attachments.Spin,      spinLifetime, false)
		spawnParticle(attacker["Left Arm"],  script.Attachments.JumpTrail, spinLifetime, false)
		spawnParticle(attacker["Right Arm"], script.Attachments.JumpTrail, spinLifetime, false)
		--spawnParticle(attacker.Torso,       script.MainDash,      spinLifetime, false)
		
		local MainDash = script.MainDash:Clone()
		MainDash.Parent = attacker
		MainDash.Weld.Part0 = attacker.HumanoidRootPart
		VFXFunctions.ToggleAll(MainDash, true, false, true, true)
		task.delay(spinLifetime, function()
			VFXFunctions.ToggleAll(MainDash, false, false, true, true)
			VFXFunctions.TaskDebris(MainDash, 2)
		end)

		task.delay(spinLifetime, function()
			local landParticles = script.Attachments.Land:Clone()
			landParticles.Parent = hrp
			VFXFunctions.EmitDescendants(landParticles)
			task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)
		end)

		if isLocalPlayer then
			local localChar = LocalPlayer.Character
			local localHrp  = localChar and localChar:FindFirstChild("HumanoidRootPart")
			if not localHrp then return end

			followUpAnimTrack = localChar.Humanoid.Animator:LoadAnimation(script.user3)
			followUpAnimTrack:Play()

			local meshTimer = 0

			Velocity.bezier(
				localHrp,
				victimHrp,
				CFrame.new(-20, 35, 0),
				spinLifetime,
				Enum.EasingStyle.Sine,
				Enum.EasingDirection.Out,
				CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
				false,
				function(orientCF, heading, dt)
					local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
						* CFrame.Angles(0, -math.pi / 2, 0)
					if MainDash and MainDash.Weld then
						MainDash.Weld.C0 = hrp.CFrame:ToObjectSpace(faceCFrame) * CFrame.Angles(0, math.rad(90), 0)
					end
					meshTimer += dt
					if meshTimer > 0.0833 then
						--emitMeshGroup(faceCFrame, script.Rush)
						meshTimer = 0
					end
				end
			)


			--Velocity.bezier(
			--	localHrp,
			--	victimHrp,
			--	CFrame.new(40, 10, 0),  -- ← mirrored to the right (was -25)
			--	spinLifetime,
			--	Enum.EasingStyle.Sine,
			--	Enum.EasingDirection.Out,
			--	CFrame.new(0, 0, -2) * CFrame.Angles(0, math.pi, 0),
			--	false,
			--	function(orientCF, heading, dt)
			--		local faceCFrame = CFrame.lookAt(hrp.CFrame.Position, orientCF.Position)
			--			* CFrame.Angles(0, -math.pi / 2, 0)
			--		meshTimer += dt
			--		if meshTimer > 0.0833 then
			--			emitMeshGroup(faceCFrame, script.Rush2)
			--			meshTimer = 0
			--		end
			--	end
			--)

			TS:Create(currentCamera,
				TweenInfo.new(0.3333, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true),
				{ FieldOfView = 50 }
			):Play()

			task.delay(spinLifetime, function()
				-- camera shake here if you have one
			end)
		end
	end


	if skillType == "followUpImpact4" then
		--if isLocalPlayer or isVictim then
		--	TS:Create(currentCamera,
		--		TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
		--		{ FieldOfView = 50 }
		--	):Play()

		--	MilkVFX.Lighting.colorCorrectionFlash(0, 0.2, 3, Color3.fromRGB(143, 127, 150), 1.6)

		--	task.delay(0.3, function()
		--		TS:Create(currentCamera,
		--			TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		--			{ FieldOfView = 70 }
		--		):Play()
		--		MilkVFX.Lighting.colorCorrectionFlash(0.05, 0.2, 1.5, Color3.fromRGB(176, 204, 255), 0.3)
		--	end)
		--end

		if isLocalPlayer then
			local localHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
			if localHrp then
				local rootAtt = localHrp:FindFirstChild("RootAttachment")
				if rootAtt then Velocity.Stop(rootAtt) end
				localHrp.AssemblyLinearVelocity = Vector3.zero
			end

			if followUpAnimTrack then
				followUpAnimTrack.TimePosition = 0.6167
				followUpAnimTrack:AdjustSpeed(0)
				task.delay(0.3, function()
					if followUpAnimTrack then
						followUpAnimTrack:AdjustSpeed(1)
						followUpAnimTrack = nil
					end
				end)
			end
		end

		local spinFX = attacker.Torso:FindFirstChild("Spin")
		if spinFX then spinFX:Destroy() end
		local leftTrail  = attacker["Left Arm"]:FindFirstChild("JumpTrail")
		if leftTrail  then leftTrail:Destroy()  end
		local rightTrail = attacker["Right Arm"]:FindFirstChild("JumpTrail")
		if rightTrail then rightTrail:Destroy() end

		local landParticles = script.Attachments.Land:Clone()
		landParticles.Parent = hrp
		VFXFunctions.EmitDescendants(landParticles)
		task.delay(4, function() if landParticles.Parent then landParticles:Destroy() end end)

		local windupParticles = script.Attachments.Windup:Clone()
		windupParticles.Parent = hrp
		VFXFunctions.EmitDescendants(windupParticles)
		task.delay(4, function() if windupParticles.Parent then windupParticles:Destroy() end end)

		spawnParticle(hrp, script.Wind, 0.3, true)

		script.Windup.SideBeams2.CFrame = hrp.CFrame
		MilkVFX.Beam.Spawn(script.Windup.SideBeams2, {
			RotationSpeed = 0, Rotation = true, Duration = 0.3, Easing = "Quad", EasingDirection = "Out",
			Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 14 },
			Offset = CFrame.new(0, 0, 0),
		})

		task.delay(0.3, function()
			local bigSlash = script.Attachments.BigSlash:Clone()
			bigSlash.Parent = hrp
			VFXFunctions.EmitDescendants(bigSlash)
			task.delay(4, function() if bigSlash.Parent then bigSlash:Destroy() end end)

			local groundFX = script.FX:Clone()
			groundFX.Parent = workspace.World.Visuals
			groundFX.CFrame = hrp.CFrame
			VFXFunctions.EmitDescendants(groundFX)
			task.delay(4, function() if groundFX.Parent then groundFX:Destroy() end end)

			script.FinalSlash.SideBeams.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -0.6, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.SideBeams2.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.SideBeams2, {
				RotationSpeed = 0, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = -1.1, Width0 = 1, Width1 = 24 },
				Offset = CFrame.new(0, 0, 0),
			})

			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 166, 94), 0.2, 5, 12, 12)
			MilkVFX.Lighting.PointLight(hrp, Color3.fromRGB(255, 143, 69), 1.5, 5, 15, 2)

			emitMeshGroup(hrp.CFrame, script.FinalSlash)

			script.FinalSlash.KarsBeams.CFrame = hrp.CFrame * CFrame.new(0, 0, -12)
			MilkVFX.Beam.Spawn(script.FinalSlash.KarsBeams, {
				RotationSpeed = 5, Rotation = true, Duration = 0.5, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 16, TextureSpeed = 0, Width0 = 0, Width1 = 0 },
				Offset = CFrame.new(0, 0, 0),
			})

			script.FinalSlash.Beam.CFrame = hrp.CFrame
			MilkVFX.Beam.Spawn(script.FinalSlash.Beam, {
				RotationSpeed = 0, Rotation = true, Duration = 1, Easing = "Quad", EasingDirection = "Out",
				Properties = { Brightness = 0, TextureSpeed = 0.6, Width0 = 0, Width1 = 6 },
				Offset = CFrame.new(0, 0, 0),
			})
		end)
	end
	
	
	if skillType == "Hit1" then
		local Hit1 = require(script.Hit1)
		Hit1.start(nil, attacker)
	end
	
	if skillType == "Hit2" then
		local Hit2 = require(script.Hit2)
		Hit2.start(nil, attacker)
	end
	
	if skillType == "Hit3" then
		local Hit3 = require(script.Hit3)
		Hit3.start(nil, attacker)
	end
	
	if skillType == "Hit4" then
		local Hit4 = require(script.Hit4)
		Hit4.start(nil, attacker)
	end
	
end