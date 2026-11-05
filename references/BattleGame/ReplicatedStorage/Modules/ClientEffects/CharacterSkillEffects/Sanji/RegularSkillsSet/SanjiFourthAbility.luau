--Replicated Storage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityThree
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Assets = ReplicatedStorage:WaitForChild("Assets")
local Effects = Assets:WaitForChild("Effects")

local GroundRocks = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler:WaitForChild("GroundRocks"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Modules = ReplicatedStorage:WaitForChild("Modules")

local activeFX = {}

--Variables


--local LegacyReplication = Assets.Effects.LegacyReplication
local LegacyReplication = ReplicatedStorage.Resources.LegacyReplication

local RandomSeed = Random.new()

local DefaultFilter = { workspace.World.Live, workspace.World.Debris }


local function performRaycast(rayData)
	local orig = rayData.orig
	local dir = rayData.dir
	local raycastParams = RaycastParams.new()

	raycastParams.FilterDescendantsInstances = rayData.Whitelist or rayData.Ignore or DefaultFilter
	if rayData.Whitelist then
		raycastParams.FilterType = Enum.RaycastFilterType.Include
	else
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	end

	if rayData.Blockcast then
		local result = workspace:Blockcast(orig, rayData.Blockcast, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	else
		local result = workspace:Raycast(orig, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	end
end


--For sanji ability 4
return function(Params: any) --Got this from default in server script services.
	local character:Model = Params.Char --The character btw.
	local humanoid: Humanoid = character:FindFirstChild("Humanoid")

	local skillType = Params.SkillType

	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end

	local function find(name)
		for _, fx in ipairs(activeFX) do
			if fx and fx.Name == name then
				return fx
			end
		end
		return nil
	end

	local function removeFXByInstance(instance)
		for i, fx in ipairs(activeFX) do
			if fx == instance then
				table.remove(activeFX, i)
				--print("Removed from activeFX", fx.Name)
				break
			end
		end
	end

	local function scaleNumberSequence(seq: NumberSequence, scale: number)
		local newKeys = {}

		for _, keypoint in ipairs(seq.Keypoints) do
			table.insert(newKeys, NumberSequenceKeypoint.new(
				keypoint.Time,
				keypoint.Value * scale,
				keypoint.Envelope * scale
				))
		end

		return NumberSequence.new(newKeys)
	end

	if skillType == "barrage" then
		print("barrage")
		--local character = Params.Char
		--local rootPart = character.HumanoidRootPart
		local bind = Params.Bind

		local arms = {
			--character["Left Arm"],
			--character["Right Arm"],
			character["Left Leg"],
			--character["Right Leg"],
		}
		local armModels = {}

		-- Create ghost arm models for the punch effect
		for _, arm in pairs(arms) do
			local clonedArm = arm:Clone()
			clonedArm.Transparency = 0
			arm.Transparency = 1

			local model = Instance.new("Model")
			--local shirt = (character:FindFirstChildOfClass("Shirt") or Instance.new("Shirt")):Clone()
			local shirt = (character:FindFirstChildOfClass("Pants") or Instance.new("Pants")):Clone()

			Instance.new("Humanoid", model)

			clonedArm:ClearAllChildren()
			model.PrimaryPart = clonedArm
			shirt.Parent = model
			clonedArm.Anchored = true
			clonedArm.CanCollide = false
			clonedArm.Parent = model

			table.insert(armModels, model)
		end

		-- Play punch sound
		local punchSound = shared.sfx({
			SoundId = "rbxassetid://81254588778644",
			Parent = rootPart,
			PlaybackSpeed = Params.Cyborg and 3.5 or 1,
			Volume = Params.Cyborg and 3 or 1
		})
		punchSound:Play()

		local lastPunchTime = 0
		local spawnedModels = {}
		local hasHit = false
		local stopLoop = nil
		
		--character:FindFirstChild("Right Leg").Transparency = 1

		do
			local localLastPunchTime = lastPunchTime
			local localHasHit = hasHit
			local localStopLoop = stopLoop

			-- Helper to fade arms back and clean up
			local function cleanUp()
				TS:Create(punchSound, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Volume = 0
				}):Play()

				for _, arm in pairs(arms) do
					TS:Create(arm, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Transparency = 0
					}):Play()
				end

				for _, model in pairs(spawnedModels) do
					model:Destroy()
				end
				
				--character:FindFirstChild("Right Leg").Transparency = 0

				localStopLoop()
			end

			localStopLoop = shared.loop(function()
				-- Stop if bind or character is gone
				if not bind.Parent or not character.Parent then
					cleanUp()
				end

				punchSound.PlaybackSpeed = 1 - (bind:GetAttribute("Delay") or 0)

				if tick() - localLastPunchTime > bind:GetAttribute("Delay") / 1.25 then
					local punchCount = bind:GetAttribute("Times")

					if not (punchCount and rootPart) or not rootPart.Parent then
						cleanUp()
						return localStopLoop()
					end

					local rootPosition = rootPart.Position
					local camera = workspace:FindFirstChildOfClass("Camera")
					local _, isOnScreen = camera:WorldToScreenPoint(rootPosition)

					if isOnScreen then
						for _ = 1, punchCount or 2 do
							--local spawnedModel = armModels[math.random(1, 2)]:Clone()
							local spawnedModel = armModels[1]:Clone()
							local spawnedPart = spawnedModel.PrimaryPart
							spawnedPart.CFrame = character[spawnedPart.Name].CFrame

							local trailAttachments = {}
							local trails = {}

							-- Create wind trails on the arm unless Cyborg mode
							local function createWindTrail(offset)

								local attachmentA = Instance.new("Attachment")
								attachmentA.Position = offset
								attachmentA.Name = "WindTrail"
								attachmentA.Parent = spawnedPart

								local attachmentB = Instance.new("Attachment")
								attachmentB.Position = offset - Vector3.new(0, 0.2 or -0.75, 0)
								attachmentB.Name = "WindTrail"
								attachmentB.Parent = spawnedPart

								table.insert(trailAttachments, attachmentA)
								table.insert(trailAttachments, attachmentB)

								local trail = LegacyReplication.Trail:Clone()
								trail.Attachment0 = attachmentA
								trail.Attachment1 = attachmentB
								trail.Enabled = true
								trail.Parent = attachmentA

								table.insert(trails, trail)
							end

							--createWindTrail(Vector3.new(0.5, 0.5, 0.5))
							--createWindTrail(Vector3.new(-0.5, 0.5, -0.5))
							--createWindTrail(Vector3.new(-0.5, 0.5, 0.5))
							--createWindTrail(Vector3.new(0.5, 0.5, -0.5))

							local travelSpeed = 0.1
							local armStartPosition = spawnedPart.Position
							local rootCFrame = rootPart.CFrame

							-- Calculate random horizontal scatter
							
							-- Original
							--local scatterMin = -(punchCount + 1)
							--local scatterMax = punchCount + 1
							--local scatterX = RandomSeed:NextNumber(scatterMin, scatterMax)
							--local scatterY = RandomSeed:NextNumber(-punchCount, punchCount)
							
							-- Cone shape: start tight at the leg, spread out at the target
							local coneSpread = 2.5 -- how wide the cone is at the end, tweak this
							local scatterX = RandomSeed:NextNumber(-coneSpread, coneSpread)
							local scatterY = RandomSeed:NextNumber(-coneSpread * 0.5, coneSpread * 0.5) -- less vertical spread

							-- Start position is tight near the leg (small offset)
							--local startOffset = CFrame.new(
							--	RandomSeed:NextNumber(-0.3, 0.3),
							--	RandomSeed:NextNumber(-0.3, 0.3),
							--	0
							--)
							local startOffset = CFrame.new(
								RandomSeed:NextNumber(0, .7),
								RandomSeed:NextNumber(-1.6, -1.35),
								--RandomSeed:NextNumber(-3, -2.75)
								RandomSeed:NextNumber(-2.3, -1.7) -- This will be closer to the player.
							)
							armStartPosition = (rootCFrame * startOffset).p
							
							--
							--local targetCFrame = rootCFrame * CFrame.new(scatterX, scatterY, 0)
							--local punchTarget = targetCFrame + rootPart.CFrame.lookVector * 7
							local targetCFrame = rootCFrame * CFrame.new(scatterX, scatterY, 0)

							-- Create a direction rotated 30 degrees down from where the character is facing
							local aimRotation = rootPart.CFrame * CFrame.Angles(math.rad(-45), 0, 0)

							-- Push the target 7 studs out in that new downward direction
							local punchTarget = targetCFrame + (aimRotation.LookVector * 7)

							local borosMult = 1
							if bind:GetAttribute("Boros") then
								borosMult = 2
							end

							-- Raycast to check for walls
							--local hitPart, hitPosition = performRaycast({
							--	orig = targetCFrame.p,
							--	dir = (punchTarget.p - targetCFrame.p).unit * 9,
							--	Ignore = { workspace.Thrown, character }
							--})

							--if hitPart then
							--	punchTarget = CFrame.new(hitPosition)
							--	travelSpeed = 0.15
							--end

							-- Calculate bezier curve control point
							local midCFrame = CFrame.new((armStartPosition + punchTarget.p) / 2, rootPart.CFrame.p)
							
							
							--Original
							--local bezierScatterX = RandomSeed:NextNumber(-6, 6) * borosMult
							--local bezierScatterY = RandomSeed:NextNumber(-4, 4) * borosMult
							--local controlPoint = (midCFrame * CFrame.new(bezierScatterX, bezierScatterY, 0)).p
							
							-- Small control point = mostly straight path
							local bezierScatterX = RandomSeed:NextNumber(-0.5, 0.5)
							local bezierScatterY = RandomSeed:NextNumber(-0.5, 0.5)
							local controlPoint = (midCFrame * CFrame.new(bezierScatterX, bezierScatterY, 0)).p


							--Weird stuff if you hit them..
							--if hitPart then
							--	midCFrame = CFrame.new((armStartPosition + punchTarget.p) / 2, rootPart.CFrame.p)
							--	bezierScatterX = RandomSeed:NextNumber(-6, 6) * borosMult
							--	bezierScatterY = RandomSeed:NextNumber(-4, 4) * borosMult
							--	controlPoint = (midCFrame * CFrame.new(bezierScatterX, bezierScatterY, 0)).p
							--	travelSpeed = 0.15
							--end

							do
								local localTravelSpeed = travelSpeed
								local localPunchTarget = punchTarget
								local localTargetCFrame = targetCFrame
								local localControlPoint = controlPoint

								task.spawn(function()
									local accumulator = 0
									local dt = 0
									local isMoving = true
									local progress = 0

									-- Animate the arm along a bezier curve
									local function stepArm()
										if spawnedModel.Parent ~= workspace.Thrown then
											spawnedModel.Parent = workspace.Thrown
										end

										-- Quadratic bezier curve position
										local p0 = armStartPosition
										local p1 = localControlPoint
										local p2 = localPunchTarget.p

										local bezierPos = p0 + (p1 - p0) * progress
										local nextP1 = p1 + (p2 - p1) * progress
										local currentPos = bezierPos + (nextP1 - bezierPos) * progress

										-- Lookahead point for orientation
										local nextProgress = progress + 1
										local lookaheadA = p0 + (p1 - p0) * nextProgress
										local lookaheadB = p1 + (p2 - p1) * nextProgress
										local lookaheadPos = lookaheadA + (lookaheadB - lookaheadA) * nextProgress

										local targetArmCFrame = CFrame.new(currentPos, lookaheadPos) * CFrame.Angles(math.pi / 2, 0, 0)
										--local targetArmCFrame = CFrame.new(currentPos, lookaheadPos) * CFrame.Angles((math.pi / 2) + math.rad(30), 0, 0)

										TS:Create(spawnedPart, TweenInfo.new(0.01, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
											CFrame = targetArmCFrame
										}):Play()

										progress = progress + localTravelSpeed
										if progress >= 1 then
											isMoving = false
										end
									end

									while isMoving do
										accumulator = accumulator + dt
										while accumulator >= 0.016666666666666666 do
											stepArm()
											accumulator = accumulator - 0.016666666666666666
											if not isMoving then break end
										end
										dt = game:GetService("RunService").RenderStepped:wait()
									end

									if not localHasHit then
										localHasHit = true
									end

									-- Spawn impact ring effect
									--ring.Size = Vector3.new(1, 0.9, 1)
									--ring.CFrame = localTargetCFrame
									--ring.Transparency = 0.4
									
									

									----local ringCFrame = CFrame.new(ring.Position, targetCFrame.p)
									--local ringCFrame = CFrame.new(localPunchTarget.p, rootPart.CFrame.p)
									--local randomAngle = math.rad(RandomSeed:NextNumber(-360, 360))
									--ring.CFrame = ringCFrame * CFrame.Angles(math.pi / 2, randomAngle, 0)
									--ring.Parent = workspace.Thrown

									--TS:Create(ring, TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
									--	Size = Vector3.new(2.2, 0.1, 2.2),
									--	Transparency = 1
									--}):Play()

									--game:GetService("Debris"):AddItem(ring, 0.35)
									
									-- Spawn wind Effect after each kick
									
									local WindLines = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FourthAbility.WindLines:Clone()
									WindLines.CFrame = CFrame.new(localPunchTarget.p, rootPart.CFrame.p) * CFrame.Angles(math.rad(90),math.rad(0),0)
									WindLines.Parent = workspace.World.Debris
									
									--local weld = Instance.new("Weld")
									--weld.Part0 = rootPart
									--weld.Part1 = WindLines
									--weld.C0 = CFrame.Angles(math.rad(90),math.rad(0),0)
									--weld.Parent = WindLines
									
									for _, v in ipairs(WindLines:GetDescendants()) do
										if v:IsA("ParticleEmitter") then
											v:Emit(v:GetAttribute("EmitCount"))
										end
									end
									
									game:GetService("Debris"):AddItem(WindLines, .35)
									
									--local HitLines = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FourthAbility.HitLines:Clone()
									--HitLines.CFrame = CFrame.new(localPunchTarget.p, rootPart.CFrame.p) * CFrame.Angles(math.rad(90),math.rad(0),0)
									--HitLines.Parent = workspace.World.Debris
									
									--local weld1 = Instance.new("Weld")
									--weld1.Part0 = rootPart
									--weld1.Part1 = HitLines
									--weld1.C0 = CFrame.Angles(math.rad(90),math.rad(0),0)
									--weld1.Parent = HitLines
									
									--for _, v in ipairs(HitLines:GetDescendants()) do
									--	if v:IsA("ParticleEmitter") then
									--		v:Emit(v:GetAttribute("EmitCount"))
									--	end
									--end

									--game:GetService("Debris"):AddItem(HitLines, .25)
					
									spawnedModel:Destroy()

								end)
							end
						end
					end

					localLastPunchTime = tick()
				end
			end, 85)
		end
	end
	
	if skillType == "BarrageEffects" then
			
		local LeftLeg = character:FindFirstChild("Left Leg")
		local barrage = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FourthAbility

		local clone = barrage:Clone()
		clone.Parent = workspace.World.Debris

		---- Position it at the leg first
		--clone.HitLines.CFrame = LeftLeg.CFrame * CFrame.new(0, -3, 0)
		--clone.HitLines.Wind.CFrame = CFrame.new(0,-3,0)

		---- Weld HitLines to the LeftLeg
		--local weld = Instance.new("WeldConstraint")
		--weld.Part0 = LeftLeg
		--weld.Part1 = clone.HitLines
		--weld.Parent = clone.HitLines

		--for _, v in ipairs(clone.HitLines:GetDescendants()) do
		--	if v:IsA("ParticleEmitter") then
		--		local emitDuration = v:GetAttribute("EmitDuration")
		--		v.Enabled = true
		--		task.delay(emitDuration, function()
		--			v.Enabled = false
		--		end)
		--	end
		--end

		clone.Blur.CFrame = rootPart.CFrame 
		local weld1 = Instance.new("Weld")
		weld1.Part0 = rootPart
		weld1.Part1 = clone.Blur
		weld1.Parent = clone.Blur
		weld1.C0 =  CFrame.Angles(0,math.rad(0), 0) * CFrame.new(0,-.3,-4.3) -- A bit lower and a bit farther ahead

		for _, v in ipairs(clone.Blur:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				local emitDuration = v:GetAttribute("EmitDuration")
				v.Enabled = true
				task.delay(emitDuration, function()
					v.Enabled = false
				end)
			end
		end

		game:GetService("Debris"):AddItem(clone, 6) -- extra buffer for particle lifetime

	end
end