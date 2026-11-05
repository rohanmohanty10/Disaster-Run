--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local RemotesContainer = ReplicatedStorage.Remotes

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local GpDestroy        = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local KillEffect = require(script.KillEffect)
local Trove = require(ReplicatedStorage.Modules.Trove)  -- you already require this in doc 3

local Effects = ReplicatedStorage.Assets.Effects
local EffectBlood = require(ReplicatedStorage.Modules.ClientEffects.Blood)

local mapRaycastParams = RaycastParams.new()
mapRaycastParams.FilterType = Enum.RaycastFilterType.Include
mapRaycastParams.FilterDescendantsInstances = {
	workspace:FindFirstChild("World"):FindFirstChild("Map")
}

local SLASH_ORIENTATIONS = {
	CFrame.Angles(0,       math.pi / 2, 0),  -- facing right
	CFrame.Angles(math.pi, math.pi / 2, 0),  -- facing left
}

local folder

return function(argumentData: any)
    local attacker: Model = argumentData.Char
    local skillType = argumentData.SkillType

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

	local function tintSmokeToGround(smokeModel, raycastResult)
		for _, child in smokeModel:GetDescendants() do
			if child:IsA("ParticleEmitter") and string.find(child.Name, "Smoke") then
				child.Color = ColorSequence.new(raycastResult.Instance.Color)
			end
		end
	end

    local function emitClone(clone)
        for _, v in ipairs(clone:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                local duration = v:GetAttribute("EmitDuration")
                if duration then
                    v.Enabled = true
                    task.delay(duration, function()
                        v.Enabled = false
                    end)
                else
                    v:Emit(v:GetAttribute("EmitCount"))
                end
            end
        end
	end
	
	
	
	local function spawnVFX(vfxTemplate, cframe, lifetime)
		local clone = vfxTemplate:Clone()
		clone.CFrame = cframe
		clone.Parent = workspace.World.Debris
		VFXFunctions.EmitDescendants(clone)
		Debris:AddItem(clone, lifetime)
		return clone
	end
	
	--local zoroEffects = Effects.Zoro.RegularAbilities.FirstAbility
	--local zoroEffectsNew = Effects.Zoro.RegularAbilities.FirstAbility.New
	
    
	
	if skillType == "barrage" then
		local SlashFolder = script.NewSlashes
		local rng = Random.new()

		-- which axis stays full-length; the other two go skinny.
		-- your .05, 4, .05 example keeps Y, so Y is the long axis.
		local LONG_AXIS = "Y"

		local function spawnSlash(scale, baseCF, doImpact)
			--local slashMesh = SlashFolder.SlashMesh:Clone()
			local slashMesh = SlashFolder.sliceNew:Clone()

			--local wind      = SlashFolder.Wind:Clone()
			local wind      = SlashFolder.swirl1:Clone()


			local spawnCF = baseCF
				* CFrame.new(math.random(-5, 5), 0, math.random(-8, -3))
				* CFrame.Angles(
					math.rad(math.random(-360, 360)),
					math.rad(math.random(-360, 360)),
					math.rad(math.random(-360, 360))
				)

			slashMesh.CFrame = spawnCF
			wind.CFrame      = spawnCF

			local lifetime = rng:NextNumber(0.05, 0.1)

			-- absolute skinny thickness in studs (random per slash)
			local thinSize = rng:NextNumber(0.25, 2)

			-- long axis = current size * scale; the other two = thinSize
			local slashFull = Vector3.new(
				LONG_AXIS == "X" and slashMesh.Size.X * scale or thinSize,
				LONG_AXIS == "Y" and slashMesh.Size.Y * scale or thinSize,
				LONG_AXIS == "Z" and slashMesh.Size.Z * scale or thinSize
			)

			-- spawn at full size, then shrink the thin axes (X & Z) to ~0 before it disappears.
			-- Y (height) stays the same the whole time.
			local slashEnd = Vector3.new(
				LONG_AXIS == "X" and slashFull.X or 0.05,
				LONG_AXIS == "Y" and slashFull.Y or 0.05,
				LONG_AXIS == "Z" and slashFull.Z or 0.05
			)

			slashMesh.Size = slashFull
			TS:Create(slashMesh,
				TweenInfo.new(lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = slashEnd }
			):Play()

			local windScale = scale * rng:NextNumber(1, 2.5)
			local windFull = wind.Size * windScale
			wind.Size = windFull * 0.15
			TS:Create(wind,
				TweenInfo.new(lifetime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				{ Size = windFull }
			):Play()

			if doImpact then
				--local bruh = QuickSlash.Bruh:Clone()
				--bruh:PivotTo(spawnCF)
				--bruh.Parent = workspace.World.Visuals
				--bruh:ScaleTo(scale * 0.8)
				--VFXFunctions.EmitDescendants(bruh)

				local slices = SlashFolder.Slices:Clone()
				slices:PivotTo(spawnCF)
				slices.Parent = workspace.World.Visuals
				slices:ScaleTo(scale * 0.8)
				VFXFunctions.EmitDescendants(slices)

				--Debris:AddItem(bruh, 3)
				Debris:AddItem(slices, 3)
			end

			wind.Name = "QuickWind"
			slashMesh.Name = "QuickSlashMesh"

			wind.Parent      = workspace.World.Visuals
			slashMesh.Parent = workspace.World.Visuals

			VFXFunctions.EmitDescendants(slashMesh)
			VFXFunctions.EmitDescendants(wind)

			Debris:AddItem(slashMesh, lifetime)
			Debris:AddItem(wind, lifetime)
		end

		for _ = 1, 20 do
			if not hrp.Parent then break end

			task.spawn(function()
				for _ = 1, 7 do
				--for _ = 1, 12 do

					if not hrp.Parent then break end

					if math.random(1, 2) == 1 then
						task.wait(rng:NextNumber(0.01, 0.09))

						--spawnSlash(rng:NextNumber(1.5, 3), hrp.CFrame * CFrame.new(0, 0, -15), true) --orig
						spawnSlash(rng:NextNumber(1.2, 2), hrp.CFrame * CFrame.new(0, 0, -10), true)

						if math.random(1, 2) == 1 then
							--spawnSlash(rng:NextNumber(0.8, 1.4), hrp.CFrame * CFrame.new(0, 0, -3), true) --orig
							
							
							
							--removed 7/22 bc some bum said too similar
							--spawnSlash(rng:NextNumber(0.5, 1), hrp.CFrame * CFrame.new(0, 0, -3), true)

						end

						task.wait(0.01)
					end
				end
			end)

			task.wait(0.04)
		end
	end
	if skillType == "newBarrage" then
		
		
		folder = Instance.new("Folder")
		folder.Parent = workspace.World.Visuals
		
		local SlashFinished = script.SlashFinished:Clone()
		SlashFinished.Parent     = folder
		SlashFinished.Weld.Part0 = hrp
		SlashFinished.Weld.C0    = CFrame.new(0, 0, -10)  -- 8 studs in front (negative Z = forward)
		
		VFXFunctions.EnableDescendants(SlashFinished)
		local Bind = argumentData.Bind
		if Bind then
			Bind.AncestryChanged:Connect(function()
				if not Bind.Parent then
					VFXFunctions.DisableDescendants(SlashFinished, true)
				end
			end)
		end
		task.delay(8, function()
			GpDestroy(folder, 1.5)

		end)
	end
	if skillType == "barrageend" then
		
	end
	
	if skillType == "move" then
		local BodyVelocity = Instance.new("BodyVelocity")
		BodyVelocity.Name = "moveme"
		BodyVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		BodyVelocity:SetAttribute("Speed", 60)
		BodyVelocity:SetAttribute("Fallout", .98)
		BodyVelocity:SetAttribute("End", 5)
		BodyVelocity.Parent = hrp
		
		task.delay(.5, function()
			if BodyVelocity then
				BodyVelocity:Destroy()
				BodyVelocity = nil
			end
		end)

		
	end
	if skillType == "KillEffect" then
		
		local EnemyCharacter = argumentData.Enemy
		if not EnemyCharacter or not EnemyCharacter:FindFirstChild("HumanoidRootPart") then return end

		EnemyCharacter.Archivable = true
		local corpse = EnemyCharacter:Clone()
		
		--attacker.Archivable = true
		--local corpse = attacker:Clone()

		-- break the rig so the pieces actually scatter instead of staying welded together
		for _, d in ipairs(corpse:GetDescendants()) do
			if d:IsA("Motor6D") or d:IsA("Weld") or d:IsA("WeldConstraint") then
				d:Destroy()
			end
		end
		local hum = corpse:FindFirstChildOfClass("Humanoid")
		if hum then hum:Destroy() end

		corpse.Parent = workspace.World.Visuals

		-- it yields (has task.wait loops), so spawn it so it doesn't block the handler
		task.spawn(KillEffect, corpse)
	end
	
	if skillType == "FinisherDash" then
		if attacker ~= Players.LocalPlayer.Character then return end

		local enemy = argumentData.Enemy
		local enemyHRP = enemy and enemy:FindFirstChild("HumanoidRootPart")

		local DashDone = RemotesContainer.MoveSkills:FindFirstChild("ZoroSlashFinisherDash")
		local function tellServerDone()
			if DashDone then DashDone:FireServer() end
		end

		if not hrp or not enemyHRP then
			tellServerDone() -- nothing to dash to; don't let the server hang
			return
		end

		local DASH_TIME = 0.35
		local STOP_DISTANCE = 5

		-- aim at the enemy, flattened horizontal, and stop 5 studs short of them
		local toEnemy = enemyHRP.Position - hrp.Position
		local flat = Vector3.new(toEnemy.X, 0, toEnemy.Z)
		if flat.Magnitude < 0.01 then flat = hrp.CFrame.LookVector end

		local landingPos = enemyHRP.Position - (flat.Unit * STOP_DISTANCE)
		landingPos = Vector3.new(landingPos.X, hrp.Position.Y, landingPos.Z) -- keep our own height
		local targetCFrame = CFrame.lookAt(landingPos, enemyHRP.Position)

		local tween = TS:Create(hrp, TweenInfo.new(DASH_TIME, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			CFrame = targetCFrame
		})
		tween:Play()

		tween.Completed:Once(function()
			tellServerDone()
		end)

		-- safety net: if the tween gets interrupted, still tell the server
		task.delay(DASH_TIME + 0.3, function()
			tellServerDone() -- FireServer twice is harmless; server guards with `resumed`
		end)
	end
	
	if skillType == "FinisherBarrage" then
		local folderName = "ZoroFinisherVFX_" .. attacker.Name

		-- only clear THIS attacker's stale folder, not everyone's
		local existing = workspace.World.Visuals:FindFirstChild(folderName)
		if existing then existing:Destroy() end

		local folder = Instance.new("Folder")
		folder.Name = folderName
		folder.Parent = workspace.World.Visuals

		local barrage = script.Finisher.Slashes:Clone()
		barrage:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4))
		barrage.Name = "Barrage"
		barrage.Parent = folder

		VFXFunctions.EnableDescendants(barrage)

		task.spawn(function()
			for _ = 1, 7 do
				if folder:GetAttribute("Frozen") then break end
				if not folder.Parent then break end -- folder destroyed = bail

				barrage:PivotTo(
					hrp.CFrame
						* CFrame.new(0, 0, -4)
						* CFrame.Angles(
							math.rad(math.random(-360, 360)),
							math.rad(math.random(-360, 360)),
							math.rad(math.random(-360, 360))
						)
				)
				VFXFunctions.EmitDescendants(barrage)
				task.wait(0.1)
			end
		end)

		task.delay(8, function()
			if folder and folder.Parent then folder:Destroy() end
		end)
	end

	if skillType == "FinisherFreeze" then
		--local EnemyCharacter = argumentData.Enemy
		--if EnemyCharacter then
		--	local enemyHum = EnemyCharacter:FindFirstChildOfClass("Humanoid")
		--	local enemyAnimator = enemyHum and enemyHum:FindFirstChildOfClass("Animator")
		--	if enemyAnimator then
		--		for _, track in ipairs(enemyAnimator:GetPlayingAnimationTracks()) do
		--			track:AdjustSpeed(0)
		--		end
		--	end
		--end
		
		
		local slowFolder = Instance.new("Folder")
		slowFolder.Name = "SlowFX_" .. attacker.Name
		slowFolder.Parent = workspace.World.Visuals

		local slow = script.Finisher.Slow:Clone()
		slow.Parent = slowFolder
		slow.Slash:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4))
		slow.SlashHit:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4))
		slow.SlashHitTime:PivotTo(hrp.CFrame * CFrame.new(0, 0, -4))

		--VFXFunctions.EmitEffects(slow)
		VFXFunctions.EmitDescendants(slow.Slash)
		VFXFunctions.EmitDescendants(slow.SlashHit)
		VFXFunctions.EmitDescendants(slow.SlashHitTime)
		


		task.delay(4 / 60, function()
			if not slowFolder.Parent then return end
			for _, particle in ipairs(slowFolder:GetDescendants()) do
				if particle:IsA("ParticleEmitter") then
					particle:SetAttribute("PreFreezeTimeScale", particle.TimeScale)
					particle.TimeScale = 0
				end
			end
		end)

		task.delay(6, function()
			if slowFolder and slowFolder.Parent then slowFolder:Destroy() end
		end)

		local barrageFolder = workspace.World.Visuals:FindFirstChild("ZoroFinisherVFX_" .. attacker.Name)
		if not barrageFolder then return end

		barrageFolder:SetAttribute("Frozen", true)

		for _, particle in ipairs(barrageFolder:GetDescendants()) do
			if particle:IsA("ParticleEmitter") then
				particle:SetAttribute("PreFreezeTimeScale", particle.TimeScale)
				particle.TimeScale = 0
			end
		end
	end
	
	if skillType == "FinisherDismember" then
		local EnemyCharacter = argumentData.Enemy
		local enemyHRP = EnemyCharacter and EnemyCharacter:FindFirstChild("HumanoidRootPart")
		if not enemyHRP then return end
		
		--local victim = argumentData.Victim
		EffectBlood.Explode(EnemyCharacter.HumanoidRootPart)
		-- clone the body as a free-physics corpse
		EnemyCharacter.Archivable = true
		local corpse = EnemyCharacter:Clone()
		for _, d in ipairs(corpse:GetDescendants()) do
			if d:IsA("Motor6D") or d:IsA("Weld") or d:IsA("WeldConstraint") then d:Destroy() end
		end

		-- keep the Humanoid (so Shirt/Pants stay on the limbs), just neutralize it
		local hum = corpse:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.PlatformStand = true
			hum.EvaluateStateMachine = false
			hum.RequiresNeck = false
			hum.BreakJointsOnDeath = false
			hum:ChangeState(Enum.HumanoidStateType.Physics)
		end

		corpse.Parent = workspace.World.Visuals
		local centre = corpse:GetPivot().Position

		local alwaysHidden = {"Sword1", "Sword2", "Handle", "VFXPart", "FakeHead",
			"Hitbox_LeftArm", "Hitbox_RightArm", "Hitbox_RightLeg", "Hitbox_LeftLeg",
			"Hitbox_Torso", "HumanoidRootPart", "Trail", "Hitbox_Head",
			"Right ArmC1", "Left ArmC1", "Right ArmC2", "Left ArmC2"}

		local function shouldHide(name)
			for _, n in ipairs(alwaysHidden) do
				if name == n then return true end
			end
			return false
		end

		-- force the corpse visible (it may have been cloned while the enemy was hidden mid-finisher)
		for _, d in ipairs(corpse:GetDescendants()) do
			if d:IsA("BasePart") and not shouldHide(d.Name) then
				d.Transparency = 0
			elseif d:IsA("Decal") or d:IsA("Texture") then
				d.Transparency = 0
			end
		end

		-- hide the original ONLY after the corpse is up and visible
		for _, d in ipairs(EnemyCharacter:GetDescendants()) do
			if d:IsA("BasePart") or d:IsA("Decal") then d.Transparency = 1 end
		end

		-- separate every part into its own free assembly so impulses aren't shared/damped
		corpse:BreakJoints()

		for _, part in ipairs(corpse:GetDescendants()) do
			if part:IsA("BasePart") then
				if shouldHide(part.Name) then
					part:Destroy()
				else
					part.Anchored = false
					part.CanCollide = true
					part.Massless = false

					local outward = (part.Position - centre) * Vector3.new(1, 0, 1)
					if outward.Magnitude < 0.1 then
						outward = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
					end
					outward = outward.Unit

					-- apply NEXT frame so the reparent/break doesn't overwrite it,
					-- and use impulse (mass-scaled) so it actually launches
					task.defer(function()
						if not part.Parent then return end
						local launch = outward * math.random(40, 70) + Vector3.new(0, math.random(45, 70), 0)
						part:ApplyImpulse(launch * part.AssemblyMass)
						part:ApplyAngularImpulse(Vector3.new(
							math.random(-30, 30), math.random(-30, 30), math.random(-30, 30)
							) * part.AssemblyMass)
					end)

					-- raycast-on-velocity landing detection (the LaunchLimb pattern)
					local landed = false
					local conn
					conn = RunService.Heartbeat:Connect(function()
						if not part.Parent then conn:Disconnect() return end
						if landed then return end
						local result = workspace:Raycast(part.Position, part.AssemblyLinearVelocity / 10, mapRaycastParams)
						if result then
							landed = true
							conn:Disconnect()
						end
					end)
				end
			end
		end

		Debris:AddItem(corpse, 6)
	end
	
	if skillType == "FinisherBarrageEnd" then
		local barrageFolder = workspace.World.Visuals:FindFirstChild("ZoroFinisherVFX_" .. attacker.Name)
		if barrageFolder then
			for _, particle in ipairs(barrageFolder:GetDescendants()) do
				if particle:IsA("ParticleEmitter") then
					particle.TimeScale = particle:GetAttribute("PreFreezeTimeScale") or 1
				end
			end
			GpDestroy(barrageFolder, 0.5)
		end

		local slowFolder = workspace.World.Visuals:FindFirstChild("SlowFX_" .. attacker.Name)
		if slowFolder then
			for _, particle in ipairs(slowFolder:GetDescendants()) do
				if particle:IsA("ParticleEmitter") then
					particle.TimeScale = particle:GetAttribute("PreFreezeTimeScale") or 1
				end
			end
			GpDestroy(slowFolder, 0.5)
		end
	end
	
end