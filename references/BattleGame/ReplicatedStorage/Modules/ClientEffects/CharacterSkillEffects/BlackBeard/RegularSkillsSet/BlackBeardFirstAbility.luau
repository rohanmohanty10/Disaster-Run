local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer


local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local RNG = Random.new()

local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)

local RayParams = RaycastParams.new()
RayParams.FilterType = Enum.RaycastFilterType.Include
RayParams.FilterDescendantsInstances = {
	workspace.World.Map.Destroyable.Map,
	workspace.World.Map["Indestructible Map"],
}

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	local RightArm = attacker and attacker:FindFirstChild("Right Arm")

	if not hrp then return end

	local tbl_13_upvr = {}
	local activeTweens = {}
	local BoatTweenG = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)



	local activeTweens = tbl_13_upvr

	function _G.tween(instance, tweenParams, goalTable, stepType, forceRestart)

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
		local tween = BoatTweenG:Create(instance, tweenInfo)
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



	local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
		local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
		local rootCFrame = rootPart.CFrame
		for _, v in ipairs(cloneFolder:GetDescendants()) do
			if v:IsA("BasePart") then
				local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
				v.CFrame = facingCFrame * relativeOffset
			end
		end
	end

	local function getFacingCFrame(torso, offset)
		local look = torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
	end

	local function GetRandomPointInFront(character, size)
		local hrp = character.HumanoidRootPart

		-- 1. Define how far in front the center of the box is
		-- If depth is 20, we should put the center 10 studs out so it starts at our feet
		local forwardOffset = size.Z / 2 

		-- 2. Pick random offsets within the box dimensions
		local randomX = math.random(-size.X/2, size.X/2)
		local randomY = math.random(-size.Y/2, size.Y/2)
		local randomZ = math.random(-size.Z/2, size.Z/2)

		-- 3. Combine them into a relative CFrame
		local relativeCFrame = CFrame.new(randomX, randomY, -forwardOffset + randomZ)

		-- 4. Convert to World Position based on where the player is looking
		return (hrp.CFrame * relativeCFrame)
	end

	local function createDebree(debrisList, targetAttachment)
		for _, debrisData in debrisList do
			local piece = Instance.new("Part")
			piece.CanCollide = false
			piece.Massless = true

			local boxSize = Vector3.new(20, 5, 40)
			local spawnPos = GetRandomPointInFront(attacker, boxSize)

			--piece.Position = debrisData[1]
			piece.CFrame = spawnPos
			piece.Orientation = debrisData[2]
			piece.Color = debrisData[3]
			piece.Material = debrisData[4]
			piece.Size = debrisData[5]

			--piece.Velocity = RNG:NextUnitVector() * RNG:NextInteger(60, 100)
			local direction = (targetAttachment.Position - piece.Position).Unit
			-- 2. Add a little bit of "up" so they don't just drag on the floor
			local upwardForce = Vector3.new(0, math.random(1, 10), 0) 
			-- 3. Combine them and multiply by speed
			local speed = RNG:NextInteger(30, 60)
			piece.Velocity = (direction + upwardForce).Unit * speed
			piece.RotVelocity = Vector3.new(
				math.random(-20, 20),
				math.random(-20, 20),
				math.random(-20, 20)
			)
			piece.Parent = workspace.World.Debris
			Debris:AddItem(piece, .5)

			if math.random(1, 10) == 1 then
				--FXController:DebreeSound(piece)
			end

			-- After 0.2s start pulling the piece toward the target attachment
			task.delay(0.1, function()
				local pieceAttachment = Instance.new("Attachment", piece)
				pieceAttachment.Name = "BlueGrab"
				local alignPos = Instance.new("AlignPosition", pieceAttachment)
				alignPos.Responsiveness = 0
				TS:Create(alignPos, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Responsiveness = 50
				}):Play()
				alignPos.Attachment0 = pieceAttachment

				-- If target is itself an attachment, pull toward it directly
				--if targetAttachment.Parent:IsA("Attachment") then
				--	pieceAttachment = targetAttachment.Parent or pieceAttachment
				--end
				alignPos.Attachment1 = targetAttachment
			end)
		end

	end

	-- One-shot: rebuild local cosmetic copies from real voxel data, then suck them in.
	local function absorbVoxelList(voxelList, targetAttachment)
		if not voxelList or not targetAttachment then return end


		-- Knobs — slow, controlled intake (~1.5s)
		local WAVE_TIME      = 0.18
		local PULL_ACCEL     = 150
		local PROXIMITY_GAIN = 150
		local MAX_SPEED      = 95     -- was 36; covers the distance in ~0.5s
		local DAMPING        = 1.5
		local SPIN_SPEED     = 9      -- less swirl = more direct = arrives sooner
		local SHRINK_RADIUS  = 5
		local CONSUME_RADIUS = 1.5
		local MAX_LIFETIME   = 0.9    -- hard ceiling on the whole effect


		-- entries are either snapshots ({CFrame, Size, Color, ...}) or real-part
		-- references ({Part = BasePart}) from special-destruction debris
		local function sourceCFrame(vData)
			if vData.Part ~= nil then
				return (typeof(vData.Part) == "Instance" and vData.Part:IsA("BasePart")) and vData.Part.CFrame or nil
			end
			return vData.CFrame
		end

		local center0 = targetAttachment.WorldPosition
		local maxDist = 1
		for _, vData in voxelList do
			local cf = sourceCFrame(vData)
			local d = cf and (cf.Position - center0).Magnitude or 0
			if d > maxDist then maxDist = d end
		end

		local active = {}
		local t0 = os.clock()
		for _, vData in voxelList do
			local piece
			if vData.Part ~= nil then
				local src = vData.Part
				if not (typeof(src) == "Instance" and src:IsA("BasePart")) then
					continue -- destroyed/not replicated (e.g. streamed out); skip this entry
				end
				-- real-mesh mode: clone the hidden original so debris pieces keep their
				-- actual geometry and textures instead of becoming cubes
				piece = src:Clone()
				piece.Transparency = piece:GetAttribute("__OrigTrans") or 0
				CollectionService:RemoveTag(piece, "WindShake")
				for _, d in piece:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Bone") then
						CollectionService:RemoveTag(d, "WindShake")
					elseif d:IsA("Texture") or d:IsA("Decal") then
						local orig = d:GetAttribute("__OrigTrans")
						if orig ~= nil then
							d.Transparency = orig
						end
					end
				end
			else
				piece = Instance.new("Part")
				piece.CFrame, piece.Size, piece.Color, piece.Material = vData.CFrame, vData.Size, vData.Color, vData.Material
				-- without this, voxels from variant-textured parts (e.g. the white
				-- Plastic + FloorConcrete3 floor) rebuild as plain white blocks
				piece.MaterialVariant = vData.MaterialVariant or ""
			end
			piece.Anchored = true
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.Massless, piece.CastShadow = true, false
			piece.Parent = workspace.World.Debris

			local dist = (piece.Position - center0).Magnitude
			active[piece] = {
				vel = Vector3.zero, started = false,
				startAt = t0 + (dist / maxDist) * WAVE_TIME,                       -- closer = sooner
				offset  = Vector3.new(math.random(-15,15), math.random(-10,10), math.random(-15,15)) / 10,  -- anti-pile
				baseSize = piece.Size,
			}
			Debris:AddItem(piece, WAVE_TIME + 3)
		end

		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not targetAttachment.Parent then
				conn:Disconnect()
				for piece in active do if piece.Parent then piece:Destroy() end end
				return
			end
			if os.clock() - t0 > MAX_LIFETIME then        -- guarantees the effect ends on time
				conn:Disconnect()
				for piece in active do if piece.Parent then piece:Destroy() end end
				return
			end

			local center, now, remaining = targetAttachment.WorldPosition, os.clock(), 0

			for piece, data in active do
				if not piece.Parent then active[piece] = nil continue end
				remaining += 1
				if now < data.startAt then continue end

				if not data.started then
					data.started = true
					-- kinematic: stays anchored for its whole life; tumble is integrated
					-- manually instead of handing the part to the physics engine
					local spin = Vector3.new(math.random(-16,16), math.random(-16,16), math.random(-16,16))
					if spin.Magnitude < 1e-3 then
						spin = Vector3.yAxis * 8
					end
					data.spinAxis = spin.Unit
					data.spinRate = spin.Magnitude
					local toC = center - piece.Position
					local nrm = toC.Magnitude > 0 and toC.Unit or Vector3.yAxis
					local tangent = nrm:Cross(Vector3.yAxis)
					tangent = tangent.Magnitude > 1e-3 and tangent.Unit or nrm:Cross(Vector3.xAxis).Unit
					data.vel = tangent * SPIN_SPEED
				end

				local offset = (center + data.offset) - piece.Position
				local d = offset.Magnitude

				if d < SHRINK_RADIUS then                      -- dissolve into the core, no glob
					local k = math.clamp(d / SHRINK_RADIUS, 0.05, 1)
					piece.Size = data.baseSize * k
					piece.Transparency = 1 - k
					data.offset *= 0.9                          -- let it actually reach center
				end

				if d < CONSUME_RADIUS then piece:Destroy() active[piece] = nil continue end

				local accel = offset.Unit * (PULL_ACCEL + PROXIMITY_GAIN / math.max(d, 1))
				local vel = (data.vel + accel * dt) * (1 - DAMPING * dt)
				if vel.Magnitude > MAX_SPEED then vel = vel.Unit * MAX_SPEED end
				data.vel = vel
				-- kinematic move: integrate position + spin ourselves, no physics engine
				piece.CFrame = (piece.CFrame + vel * dt)
					* CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
			end

			if remaining == 0 then conn:Disconnect() end
		end)
	end
	
	if skillType == "Vortex" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 1000) == false then 
			return
		end
		--local stopSignal = argumentData.StopSignal
		--local chargePart = argumentData.ChargePart
		--local attackerModel = argumentData.AttackerModel

		--if not _G.checkRenderDistance(chargePart.Position, 600) then return end

		--while stopSignal.Name ~= "done" do
		local source = ReplicatedStorage.Assets.Effects.BlackBeard.RegularAbilities

		local chargePart = source.Orb.WindTrails
		local endTime = os.clock() + 1.2 -- set your duration here

		local doVFX = true
		local attrConnection
		attrConnection = attacker:GetAttributeChangedSignal("VortexGrabbedVfxEnd"):Connect(function()
			doVFX = false
			attrConnection:Disconnect()
		end)

		while doVFX and os.clock() < endTime do
			task.wait()
			if attacker:GetAttribute("VortexGrabbedVfxEnd") == true then break end

			for _ = 1, 12 do
				-- Trail particles
				local trailAttach0 = Instance.new("Attachment")
				local trailAttach1 = Instance.new("Attachment")
				trailAttach0.Parent = chargePart
				trailAttach1.Parent = chargePart

				local trail = chargePart.Folder.Trail:Clone()
				trail.Name = "TrailDupe"
				trail.Attachment0 = trailAttach0
				trail.Attachment1 = trailAttach1
				trail.Parent = chargePart.Folder

				local spawnRange = 45
				trailAttach0.Position = Vector3.new(
					math.random(-spawnRange, spawnRange),
					math.random(-spawnRange, spawnRange),
					math.random(-spawnRange, spawnRange)
				)
				trailAttach1.Position = trailAttach0.Position + Vector3.new(
					math.random(-8, 8),
					math.random(-8, 8),
					math.random(-8, 8)
				)

				_G.tween(trailAttach0, {0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0}, {
					Position = Vector3.new(0, 0, 0)
				})
				_G.tween(trailAttach1, {0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0}, {
					Position = Vector3.new(0, 0, 0)
				})
				_G.tween(chargePart, {50, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0, true, 0}, {
					Orientation = Vector3.new(0, 6000, 0)
				})

				GpDestroy(trailAttach0, 0.9)
				GpDestroy(trailAttach1, 0.9)
				GpDestroy(trail, 0.9)

				-- Lightning beams
				--local arm = attacker:FindFirstChild("Right Arm")


				local beamAttach0 = Instance.new("Attachment")
				beamAttach0.Orientation = Vector3.new(
					math.random(-360, 360),
					math.random(-360, 360),
					math.random(-360, 360)
				)
				--beamAttach0.Parent = attackerModel.PrimaryPart
				beamAttach0.Parent = hrp --* CFrame.new(3,0,-3)
				beamAttach0.Position = Vector3.new(1.5, 2, -5) 


				local beamAttach1 = Instance.new("Attachment")
				beamAttach1.Orientation = Vector3.new(
					math.random(-360, 360),
					math.random(-360, 360),
					math.random(-360, 360)
				)
				beamAttach1.Position = Vector3.new(

					--math.random(-15, 15),
					--math.random(12, 30),
					--math.random(-15, 15)

					--original
					--math.random(-10, 10),
					--math.random(-10, 10),
					--math.random(-30, -18)

					math.random(-8, 8),
					math.random(-8, 8),
					math.random(-40, -30)

				)
				--beamAttach1.Parent = attackerModel.PrimaryPart
				beamAttach1.Parent = hrp
				--local beam = script.beam:Clone()
				local beam = source.Orb.beam:Clone()
				--local beam = source.Orb.beam2:Clone()

				beam.Attachment0 = beamAttach0
				beam.Attachment1 = beamAttach1
				--beam.CurveSize0 = math.random(5, 15)
				beam.CurveSize0 = math.random(7, 10)

				if math.random(1, 2) == 1 then
					beam.CurveSize0 = -beam.CurveSize0
				end
				--beam.CurveSize1 = beam.CurveSize0 * -2
				beam.CurveSize1 = beam.CurveSize0 * -1.8

				--beam.Width0 = math.random(10, 20)
				beam.Width0 = math.random(9, 13)

				beam.Parent = hrp


				_G.tween(beam, {0.75, "Quad", Enum.EasingDirection.Out, 0, false, 0}, {
					CurveSize0 = beam.CurveSize0 * -2,
					CurveSize1 = beam.CurveSize1 * 2,
					Width0 = 0,
				})
				_G.tween(beamAttach0, {1, "Sine", Enum.EasingDirection.Out, 0, false, 0}, {
					Position = Vector3.new(0, 0, 0),
				})

				GpDestroy({beamAttach0, beamAttach1, beam}, 1)
			end

			task.wait(0.1)
		end

		if attrConnection then
			attrConnection:Disconnect()
			attrConnection = nil
		end
		return
	elseif skillType == "VortexOrbSpawn" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 1000) == false then 
			return
		end
		local source = script

		--local Primary = source.PullVFX.Primary:Clone()
		--Primary.Parent        = workspace.World.Debris

		--Primary.Weld.Part1    = hrp
		--Primary.Weld.C0    = Primary.Weld.C0 * CFrame.Angles(0, math.rad(90),0) * CFrame.new(1, 0, 2) 


		--local Beams = source.PullVFX.Beams:Clone()
		--Beams.Parent        = workspace.World.Debris

		--Beams.Weld.Part1    = hrp
		--Beams.Weld.C0    = Primary.Weld.C0 * CFrame.Angles(0,math.rad(90),0 ) *  CFrame.new(1, 0, 2) 

		local Beams = source.PullVFX.Beams:Clone()
		Beams.Parent        = workspace.World.Visuals

		Beams.Weld.Part1    = hrp
		Beams.Weld.C0    = Beams.Weld.C0 * CFrame.Angles(0, math.rad(-90),0) * CFrame.new(0, 0, 2.5) 

		local Primary = source.PullVFX.Primary:Clone()
		Primary.Parent        = workspace.World.Visuals

		Primary.Weld.Part1    = hrp
		Primary.Weld.C0    = Primary.Weld.C0  *  CFrame.new(-47, 0, -1)*  CFrame.Angles(0, math.rad(-90),0)

		VFXFunctions.EnableTime(Beams, true, .6)
		VFXFunctions.EnableTime(Primary, true, .6)
		return
	end

	if skillType == "newHit" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 300) == false then
			return
		end
		local ToUse = script.PunchEffects
		local clone = ToUse:Clone()
		local EnemyCharacter = argumentData.Enemy
		clone.CFrame = EnemyCharacter.HumanoidRootPart.CFrame
		clone.Parent = workspace.World.Visuals

		EffectUtilities.Emit(clone)
		Debris:AddItem(clone, 5)
		return
	end

	if skillType == "rightArmAura" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then -- we return if other players to far since we don't want to create these effects.
			return
		end
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local Arm = attacker:FindFirstChild("Right Arm")
		local ToUse = script["Left Arm"]
		local clone = ToUse:Clone()
		clone.CFrame = Arm.CFrame
		clone.Parent = workspace.World.Visuals

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.Parent = clone

		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 2)
		return
	end
	
	if skillType == "leftArmAura" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 200) == false then 
			return
		end
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local Arm = attacker:FindFirstChild("Left Arm")
		local ToUse = script["Left Arm"]
		local clone = ToUse:Clone()
		clone.CFrame = Arm.CFrame
		clone.Parent = workspace.World.Visuals

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.Parent = clone

		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 2)
		return
	end

	if skillType == "finalHit" then
		if EffectUtilities.CheckRenderDistance(attacker.HumanoidRootPart.CFrame, 400) == false then 
			return
		end
		local function changeCFrame(mesh, cframe) 
			if mesh:IsA("Model") then
				-- PivotTo is the modern, most efficient way to move models
				mesh:PivotTo(cframe)
			elseif mesh:IsA("BasePart") then
				mesh.CFrame = cframe 
			else
				-- If it's a Folder or a Model without a PrimaryPart, move all parts inside
				for _, desc in ipairs(mesh:GetDescendants()) do
					if desc:IsA("BasePart") then
						-- Note: This will stack all parts on the exact same spot 
						-- unless you calculate offsets.
						desc.CFrame = cframe
					end
				end
			end
		end
		local ReplicatedStorage = game:GetService("ReplicatedStorage")

		local vfx = require(ReplicatedStorage.Modules.ClientEffects.ForgeVFX) -- Replace with the path to wherever you put the module

		vfx.init()
		local attackerRoot = attacker.HumanoidRootPart.CFrame
		local source = script.FinalSlamEffects

		local blackSlam = source:FindFirstChild("BlackSlam"):Clone()
		blackSlam.CFrame = attackerRoot * CFrame.new(0,-2,0)
		blackSlam.Parent = workspace.World.Visuals
		Debris:AddItem(blackSlam, 5)
		if blackSlam.Dust then
			local rootPart = blackSlam
			local rayResult = workspace:Raycast(rootPart.Position, Vector3.new(0, -100, 0), RayParams)
			if rayResult then
				blackSlam.Dust.Smoke3.Color = ColorSequence.new(rayResult.Instance.Color)
			end
		end
		
		shared.vfx.emit(blackSlam)

		-- 2. MESH 2 (Secondary Ring/VFX)
		local mesh2 = source:FindFirstChild("Mesh2"):Clone()
		-- Example special CFrame: offset slightly forward
		mesh2.Start.CFrame = attackerRoot * CFrame.Angles(0, 0, math.rad(90)) *  CFrame.new(10, 0, 0) 
		mesh2.End.CFrame = attackerRoot * CFrame.Angles(0, 0, math.rad(90)) *  CFrame.new(10, 0, 0) 
		mesh2.Parent = workspace.World.Visuals
		Debris:AddItem(mesh2, 5)
		shared.vfx.emit(mesh2)

		-- 3. MESH 4 (Extra Details)
		--local mesh4 = source:FindFirstChild("mesh4"):Clone()
		---- Example special CFrame: rotate to face up or down
		--mesh4.Start.CFrame = attackerRoot * CFrame.Angles(0, 0, math.rad(90)) *  CFrame.new(20, 0, 0) 
		--mesh4.End.CFrame = attackerRoot * CFrame.Angles(0, 0, math.rad(90)) *  CFrame.new(20, 0, 0) 
		--mesh4.Parent = workspace.World.Debris
		--Debris:AddItem(mesh4, 5)
		--shared.vfx.emit(mesh4)
		return
	end
	
	if skillType == "Voxels" then
		absorbVoxelList(argumentData.voxelList, argumentData.targetAttachment)
		return
	end
	
	if skillType == "Rocks" then
		--warn("CreatingRocks")
		local debrisList = argumentData.debrisList
		local targetAttachment = argumentData.targetAttachment

		local duration = .4
		local start = os.clock()
		task.spawn(function()
			while os.clock() - start < duration do
				createDebree(debrisList, targetAttachment)
				task.wait(.1)
			end
		end)
		return
	end

	if skillType == "EnemyPulledRocks" then
		local EnemyCharacter = argumentData.EnemyCharacter
		local RootPart = EnemyCharacter.HumanoidRootPart
		local Torso = EnemyCharacter.Torso

		local function GetPosition()
			local CF = CFrame.lookAlong(Torso.Position, RootPart.CFrame.LookVector) * CFrame.new(0, 0, -1.5)

			return (CF.Position + (Vector3.yAxis * 1.5))
		end

		task.spawn(function()
			local CraterDirection = Vector3.yAxis * -15


			for Index = 1, 8 do
				local Position = GetPosition()

				task.spawn(RockHandler.Rockst, Position, CraterDirection, {
					Size = {0.1, 0.3},
					Count = 5,
					Velocity = 10,
					SpawnVariance = 0.5;
				})

				RockHandler.Rocks("Dragged", Position)
				--Smoke(Torso, 7.5, 1.5)

				task.wait(0.05)
			end
		end)
		return
	end

	-- For slam crater
	if skillType == "FinalRockDebree" then

		local Position = (hrp.CFrame * CFrame.new(0, -3, -1.9)).Position
		local Direction = Vector3.yAxis * -5

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 10,
			Distance = 7,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},

			BaseZ = 2.7,
			SizeMultiplier = 1.6,
			CraterSmoke = false,
			CastShadow = false

		})

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 15,
			Distance = 12,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},

			BaseZ = 2.7,
			SizeMultiplier = 1.6,
			CraterSmoke = false,
			CastShadow = false
		})
		return
	end
end