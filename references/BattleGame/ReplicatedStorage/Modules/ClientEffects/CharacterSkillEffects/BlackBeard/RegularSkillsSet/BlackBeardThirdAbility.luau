--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)
local EffectBlood = require(ReplicatedStorage.Modules.ClientEffects.Blood)

local RNG = Random.new()

local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local VoxelSerializer = require(ReplicatedStorage.Modules.VoxelSerializer)

local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)
local Emit       = VFX.Emit
local Tween      = Essentials.Tween

return function(argumentData: any)
	local Attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = Attacker and Attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

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

	local tbl_13_upvr = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)



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


	local function getFacingCFrame(torso, offset)
		local look = torso.CFrame.LookVector
		local flatLook = Vector3.new(look.X, 0, look.Z).Unit
		return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
	end

	if skillType == "start" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 500) == false then 
			return
		end
		
		local Torso = Attacker:FindFirstChild("Torso") or Attacker:FindFirstChild("HumanoidRootPart")
		local Arm = Attacker:FindFirstChild("Right Arm")
		local Pull = script.Pull
		local clone = Pull:Clone()
		clone.Parent = workspace.World.Visuals

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.C0 = CFrame.new(0, 1, 0)
		weld.Parent = clone

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.ZOffset = v.ZOffset + 1
			end
		end
		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 5)

		-- Dust collect not in use, to laggy for now.

		--local DustCollect = script.DustCollect
		--local DCclone = DustCollect:Clone()
		--DCclone.Parent = workspace.World.Visuals

		--local weld2 = Instance.new("Weld")
		--weld2.Part0 = DCclone
		--weld2.Part1 = Arm
		--weld.C0 = CFrame.new(0, 1, 0)
		--weld2.Parent = DCclone

		--for _, v in ipairs(DCclone:GetDescendants()) do
		--	if v:IsA("ParticleEmitter") then
		--		v:Emit(v:GetAttribute("EmitCount"))
		--		v.ZOffset = v.ZOffset + 1
		--		task.spawn(function()
		--			v.Enabled = true
		--			task.wait(v:GetAttribute("EmitDuration"))
		--			v.Enabled = false
		--		end)

		--	end
		--end

		--game:GetService("Debris"):AddItem(DCclone, 5)
		
		return
	end

	if skillType == "violentPart" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 500) == false then 
			return
		end
		
		local Torso = Attacker:FindFirstChild("Torso") or Attacker:FindFirstChild("HumanoidRootPart")
		local Arm = Attacker:FindFirstChild("Right Arm")
		local Pull = script.Absorb
		local clone = Pull:Clone()
		clone.Parent = workspace.World.Visuals

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.C0 = CFrame.new(0, 1, 0)
		weld.Parent = clone

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.ZOffset = v.ZOffset + 1
			end
		end
		
		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 5)

		-- Same with this dust collect

		--local DustCollect = script.DustMoreCollect
		--local DCclone = DustCollect:Clone()
		--DCclone.Parent = workspace.World.Visuals

		--local weld2 = Instance.new("Weld")
		--weld2.Part0 = DCclone
		--weld2.Part1 = Arm
		--weld.C0 = CFrame.new(0, 1, 0)
		--weld2.Parent = DCclone

		--for _, v in ipairs(DCclone:GetDescendants()) do
		--	if v:IsA("ParticleEmitter") then
		--		v:Emit(v:GetAttribute("EmitCount"))

		--		v.ZOffset = v.ZOffset + 1

		--		task.spawn(function()
		--			v.Enabled = true
		--			task.wait(v:GetAttribute("EmitDuration"))
		--			v.Enabled = false
		--		end)

		--	end
		--end

		--Debris:AddItem(DCclone, 5)

		task.spawn(function()
			local startClock = os.clock()

			local container = Instance.new("Model")
			container.Parent = workspace.World.Visuals

			local highlight = Instance.new("Highlight")
			highlight.Enabled = false
			highlight.Parent  = container

			while os.clock() - startClock < 1.2 do
				local bubble = script.Bubble:Clone()
				bubble.CFrame = clone.CFrame
				bubble.Size   = Vector3.new(15, 15, 15)
				bubble.Parent = container

				TS:Create(bubble, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
					Size         = Vector3.new(2, 2, 2),
					Transparency = 1,
				}):Play()

				Essentials.Destroy(bubble, 0.25)
				task.wait(0.25)
			end

			Essentials.Destroy(container, 0.35)
		end)
		
		return
	end

	if skillType == "finisherHit" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 300) == false then 
			return
		end
		local Torso = Attacker:FindFirstChild("Torso") or Attacker:FindFirstChild("HumanoidRootPart")
		local Arm = Attacker:FindFirstChild("Right Arm")
		local ToUse = script.ToUse
		local clone = ToUse:Clone()
		clone.CFrame = Arm.CFrame
		clone.Parent = workspace.World.Visuals

		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 5)
		
		return
	end

	if skillType == "explode" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 600) == false then 
			return
		end
		
		local victim = argumentData.Victim
		EffectBlood.ExplodeHead(victim.Head)
		
		return
	end

	if skillType == "armAura" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 200) == false then 
			return
		end
		
		local Torso = Attacker:FindFirstChild("Torso") or Attacker:FindFirstChild("HumanoidRootPart")
		local Arm = Attacker:FindFirstChild("Left Arm")
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

	if skillType == "throw" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 300) == false then 
			return
		end
		
		local ToUse =  script.StrongPunch2
		local clone = ToUse:Clone()
		clone.CFrame = hrp.CFrame * CFrame.new(-1.05, 1.8, -2.4) * CFrame.Angles(math.rad(30), math.rad(180), math.rad(13)) --* CFrame.Angles(math.rad(30), math.rad(154), math.rad(13))
		clone.Parent = workspace.World.Visuals

		EffectUtilities.Emit(clone)
		Debris:AddItem(clone, 5)
		
		return
	end

	if skillType == "VortexSphere" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 500) == false then 
			return
		end
		
		local source = ReplicatedStorage.Assets.Effects.BlackBeard.RegularAbilities
		local Arm = Attacker:FindFirstChild("Right Arm")

		local chargePart = source.Orb.WindTrails
		local endTime = os.clock() + 2 -- set your duration here

		local doVFX = true
		local attrConnection
		attrConnection = Attacker:GetAttributeChangedSignal("VortexGrabbedVfxEnd"):Connect(function()
			doVFX = false
			attrConnection:Disconnect()
		end)

		task.spawn(function()
			local startClock = os.clock()

			local container = Instance.new("Model")
			container.Parent = workspace.World.Visuals

			local highlight = Instance.new("Highlight")
			highlight.Enabled = false
			highlight.Parent  = container

			while os.clock() - startClock < 1.3 do
				local bubble = script.Bubble:Clone()
				bubble.CFrame = Attacker["Right Arm"].CFrame * CFrame.new(0, -1, 0)
				bubble.Size   = Vector3.new(6, 6, 6)
				bubble.Parent = container

				TS:Create(bubble, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
					Size         = Vector3.new(2, 2, 2),
					Transparency = 1,
				}):Play()

				Essentials.Destroy(bubble, 0.25)
				task.wait(0.25)
			end

			Essentials.Destroy(container, 0.35)
		end)

		while doVFX and os.clock() < endTime do
			task.wait()
			if Attacker:GetAttribute("VortexGrabbedVfxEnd") == true then break end

			for _ = 1, 12 do
				-- Trail particles
				local radius = 15
				local randomDir = Vector3.new(
					math.random(-100, 100),
					math.random(-100, 100),
					math.random(-100, 100)
				).Unit * radius

				local beamAttach0 = Instance.new("Attachment")
				beamAttach0.Orientation = Vector3.new(
					math.random(-360, 360),
					math.random(-360, 360),
					math.random(-360, 360)
				)
				beamAttach0.Position = randomDir  -- outer point on sphere
				beamAttach0.Parent = Arm

				local beamAttach1 = Instance.new("Attachment")
				beamAttach1.Orientation = Vector3.new(
					math.random(-360, 360),
					math.random(-360, 360),
					math.random(-360, 360)
				)
				beamAttach1.Position = randomDir * 0.5  -- halfway between outer and center
				beamAttach1.Parent = Arm

				local beam = source.Orb.beam:Clone()

				--local beam = source.Orb.beam2:Clone()

				beam.Attachment0 = beamAttach0
				beam.Attachment1 = beamAttach1
				beam.CurveSize0 = math.random(3,5)
				if math.random(1, 2) == 1 then
					beam.CurveSize0 = -beam.CurveSize0
				end
				beam.CurveSize1 = beam.CurveSize0 * -1.2
				beam.Width0 = math.random(4,7)
				beam.Parent = Arm

				_G.tween(beam, {0.75, "Quad", Enum.EasingDirection.Out, 0, false, 0}, {
					CurveSize0 = beam.CurveSize0 * -1.5,
					CurveSize1 = beam.CurveSize1 * 1.5,
					Width0 = 0,
				})
				_G.tween(beamAttach0, {0.5, "Sine", Enum.EasingDirection.Out, 0, false, 0}, {
					Position = Vector3.new(0, 0, 0),
				})

				GpDestroy({beamAttach0,
					beamAttach1,
					beam
				}, 1)
			end

			task.wait(0.1)
		end

		if attrConnection then
			attrConnection:Disconnect()
			attrConnection = nil
		end
		
		return
	end	


	local function Absorb(voxelList, targetAttachment, opts)
		if not voxelList or not targetAttachment then
			return
		end
		opts = opts or {}

		local WAVE_TIME = opts.WaveTime or 0.18
		local PULL_ACCEL = opts.PullAccel or 150
		local PROXIMITY_GAIN = opts.ProximityGain or 150
		local MAX_SPEED = opts.MaxSpeed or 95
		local DAMPING = opts.Damping or 1.5
		local SPIN_SPEED = opts.SpinSpeed or 9
		local CONSUME_RADIUS = opts.ConsumeRadius or 1.5
		local MAX_LIFETIME = opts.MaxLifetime or 0.9
		local TUMBLE = opts.Tumble or 16
		local MIN_SCALE = opts.MinScale or 0.03

		local KILL_SCALE = opts.KillScale or 0.15
		local FADE_START = opts.FadeStart or 0.45

		local SPAWN_PULL_IN = opts.SpawnPullIn or 1.5

		local PARENT = opts.Parent or workspace.World.Debris

		-- entries are either snapshots ({CFrame, Size, Color, ...}) or real-part
		-- references ({Part = BasePart}) from special props like chairs and bushes
		local function sourceCFrame(vData)
			if vData.Piece ~= nil then
				return vData.Piece.CFrame
			end
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
			if d > maxDist then
				maxDist = d
			end
		end

		local active = {}
		local t0 = os.clock()
		for _, vData in voxelList do
			local piece
			if vData.Piece ~= nil then
				-- existing GlassFragment picked up nearby; absorb the real part directly
				piece = vData.Piece
			elseif vData.Part ~= nil then
				local src = vData.Part
				if not (typeof(src) == "Instance" and src:IsA("BasePart")) then
					continue -- destroyed/not replicated (e.g. streamed out); skip this entry
				end
				-- real-mesh mode: clone the hidden original so chairs/bushes keep their
				-- actual geometry and textures instead of becoming cubes; hideModel()
				-- saved the pre-hide transparency in __OrigTrans
				piece = src:Clone()
				-- __OrigTrans: SpecialDestruction/hideModel convention (trees, bushes).
				-- (shatterable windows, absorbed flings) — without this fallback glass
				-- windows clone fully opaque instead of see-through.
				piece.Transparency = piece:GetAttribute("__OrigTrans")
					or 0
				CollectionService:RemoveTag(piece, "WindShake")
				for _, d in piece:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Bone") then
						CollectionService:RemoveTag(d, "WindShake")
					elseif d:IsA("Texture") or d:IsA("Decal") then
						-- hideModel() hid these on the original too; unhide the copies
						local orig = d:GetAttribute("__OrigTrans")
						if orig ~= nil then
							d.Transparency = orig
						end
					end
				end
			else
				piece = Instance.new("Part")
				piece.CFrame, piece.Size, piece.Color, piece.Material =
					vData.CFrame, vData.Size, vData.Color, vData.Material
				piece.MaterialVariant = vData.MaterialVariant or ""
			end
			piece.Anchored = true
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.Massless, piece.CastShadow = true, false
			local toAnchor = center0 - piece.Position
			if toAnchor.Magnitude > 0.001 then
				piece.CFrame += toAnchor.Unit * math.min(SPAWN_PULL_IN * math.random(), toAnchor.Magnitude * 0.5)
			end
			piece.Parent = PARENT

			local dist = (piece.Position - center0).Magnitude
			active[piece] = {
				cf = piece.CFrame,
				vel = Vector3.zero,
				started = false,
				startAt = t0 + (dist / maxDist) * WAVE_TIME,
				offset = Vector3.new(math.random(-15, 15), math.random(-10, 10), math.random(-15, 15)) / 10,
				baseSize = piece.Size,
				baseTransparency = piece.Transparency,  -- fade blends from this, not from opaque
				startDist = math.max(dist, 1),
				shrink = 1,
			}
			Debris:AddItem(piece, MAX_LIFETIME + 1)
		end

		local moveParts, moveCFs = {}, {}
		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not targetAttachment.Parent or os.clock() - t0 > MAX_LIFETIME then
				conn:Disconnect()
				for piece in active do
					if piece.Parent then
						piece:Destroy()
					end
				end
				return
			end


			table.clear(moveParts)
			table.clear(moveCFs)

			local center, now, remaining = targetAttachment.WorldPosition, os.clock(), 0
			for piece, data in active do
				if not piece.Parent then active[piece] = nil; continue end
				remaining += 1
				if now < data.startAt then continue end

				local pos = data.cf.Position -- CHANGED: was piece.Position (engine read)

				if not data.started then
					data.started = true
					-- kinematic: pieces stay anchored for their whole life; tumble is
					-- integrated manually instead of handing them to the physics engine
					local spin = Vector3.new(
						(math.random() * 2 - 1) * TUMBLE,
						(math.random() * 2 - 1) * TUMBLE,
						(math.random() * 2 - 1) * TUMBLE
					)
					if spin.Magnitude < 1e-3 then
						spin = Vector3.yAxis * TUMBLE
					end
					data.spinAxis = spin.Unit
					data.spinRate = spin.Magnitude
					local toC = center - pos
					local nrm = toC.Magnitude > 0 and toC.Unit or Vector3.yAxis
					local tangent = nrm:Cross(Vector3.yAxis)
					tangent = tangent.Magnitude > 1e-3 and tangent.Unit or nrm:Cross(Vector3.xAxis).Unit
					data.vel = tangent * SPIN_SPEED
				end


				local offset = (center + data.offset) - pos
				local d = offset.Magnitude

				local kDist = math.clamp(d / data.startDist, 0, 1)
				local kTime = math.clamp(1 - (now - data.startAt) / (MAX_LIFETIME * 0.9), 0, 1)
				local k = math.min(data.shrink, kDist, kTime)
				data.shrink = k

				-- CHANGED: step the writes instead of writing every frame
				--local scale = math.max(k, MIN_SCALE)
				--if (data.lastScale or 1) - scale > 0.07 then
				--	data.lastScale = scale
				--	piece.Size = data.baseSize * scale
				--	piece.Transparency = math.clamp(1 - k / 0.35, 0, 1) -- opaque until the end, then fast fade
				--end
				if d < CONSUME_RADIUS or k <= KILL_SCALE then
					piece:Destroy(); active[piece] = nil; continue
				end

				if (data.lastScale or 1) - k > 0.07 then
					data.lastScale = k
					piece.Size = data.baseSize * k
					-- fade spans FADE_START -> KILL_SCALE and reaches ~1 as the piece dies,
					-- so the destroy is the end of the fade: no visible pop. Blend from the
					-- piece's own base transparency so glass starts see-through, not opaque.
					local fade = math.clamp((FADE_START - k) / (FADE_START - KILL_SCALE), 0, 1)
					local base = data.baseTransparency
					piece.Transparency = base + (1 - base) * fade
				end
				data.offset *= 0.96

				if d < CONSUME_RADIUS or k <= MIN_SCALE then
					piece:Destroy(); active[piece] = nil; continue
				end

				local accel = offset.Unit * (PULL_ACCEL + PROXIMITY_GAIN / math.max(d, 1))
				local vel = (data.vel + accel * dt) * (1 - DAMPING * dt)
				if vel.Magnitude > MAX_SPEED then vel = vel.Unit * MAX_SPEED end
				data.vel = vel

				-- CHANGED: integrate the cached cf, queue for bulk move
				data.cf = (data.cf + vel * dt) * CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
				local n = #moveParts + 1
				moveParts[n] = piece
				moveCFs[n] = data.cf
			end

			if #moveParts > 0 then
				workspace:BulkMoveTo(moveParts, moveCFs, Enum.BulkMoveMode.FireCFrameChanged)
			end
			if remaining == 0 then conn:Disconnect() end
		end)
	end

	if skillType == "Voxels" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 700) == false then 
			return
		end
		
		local anchor = Instance.new("Attachment")
		anchor.Parent = argumentData.PartToUse -- attacker's HRP, already replicated on this client
		Debris:AddItem(anchor, 6)
		local list = {}
		-- new path: binary buffer (Ability4). fallback: raw table (grab / Ability3)
		if argumentData.voxelBuffer then
			for _, snap in VoxelSerializer.decode(argumentData.voxelBuffer) do
				table.insert(list, snap)
			end
		elseif argumentData.voxelList then
			for _, snap in argumentData.voxelList do
				table.insert(list, snap)
			end
		end
		if argumentData.specialParts then
			for _, part in argumentData.specialParts do
				if typeof(part) == "Instance" and part:IsA("BasePart") then
					table.insert(list, { Part = part })
				end
			end
		end

		if #list > 0 then
			Absorb(list, anchor)
		end

		-- Pick up the glass shards FractureGlass already scattered nearby. They are
		-- CLIENT-ONLY parts (RenderGlass builds them per-client in workspace.Terrain),
		-- so the server never saw them — grabbing them has to happen here. Small delay
		-- so this-absorb's shatter fragments have spawned before we scan.
		task.delay(0.12, function()
			if not anchor.Parent then
				return
			end
			local center = anchor.WorldPosition
			local params = OverlapParams.new()
			params.FilterType = Enum.RaycastFilterType.Include
			params.FilterDescendantsInstances = { workspace.Terrain }
			local glassList = {}
			for _, frag in workspace:GetPartBoundsInBox(CFrame.new(center), Vector3.new(60, 60, 60), params) do
				if frag.Name == "GlassFragment" then
					table.insert(glassList, { Piece = frag })
				end
			end
			if #glassList > 0 then
				Absorb(glassList, anchor)
			end
		end)
		
		return
	end

	-- Spawns small cosmetic debris from the ground around the target, then sucks it in (reuses Absorb).
	local function AbsorbFromGround(targetAttachment, opts)
		if not targetAttachment then
			return
		end
		opts = opts or {}
		local duration = opts.Duration or 2 -- total time debris keeps erupting (match your grab)
		local rate = opts.Rate or 0.12 -- seconds between batches
		local perBatch = opts.PerBatch or 3 -- chunks per batch
		local radius = opts.Radius or 12
		local minSize = opts.MinSize or 0.6
		local maxSize = opts.MaxSize or 1.4
		local rayUp = opts.RayUp or 25
		local rayDown = opts.RayDown or 60

		local params = opts.RaycastParams
		if not params then
			params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Include
			-- VoxBreaker disables CanQuery on destroyed floor and parents the recut
			-- pieces to World.Voxel, so rays must see that folder or they fall through
			-- and sample the foundation under the real ground (white debris)
			local filter = { workspace.World.Map.Destroyable.Map }
			local VoxelFolder = workspace.World:FindFirstChild("Voxel")
			if VoxelFolder then
				table.insert(filter, VoxelFolder)
			end
			params.FilterDescendantsInstances = filter
			params.IgnoreWater = true
		end

		-- World.Voxel also holds launched (unanchored) chunks — this skill fills the air
		-- with them — so step past those and sample the static ground underneath
		local function staticRaycast(origin, direction)
			local from, remaining = origin, direction
			for _ = 1, 4 do
				local hit = workspace:Raycast(from, remaining, params)
				if not hit then
					return nil
				end
				if hit.Instance.Anchored then
					return hit
				end
				local step = direction.Unit * 0.1
				remaining = remaining - (hit.Position - from) - step
				from = hit.Position + step
			end
			return nil
		end

		local absorbOpts = {
			SpinSpeed = opts.SpinSpeed or 20,
			Tumble = opts.Tumble or 32,
			MaxLifetime = opts.MaxLifetime or 0.8,
			PullAccel = opts.PullAccel or 130,
			WaveTime = opts.WaveTime or 0.08,
		}

		task.spawn(function()
			local start = os.clock()
			while os.clock() - start < duration do
				if not targetAttachment.Parent then
					break
				end -- hole gone → stop erupting

				local center = targetAttachment.WorldPosition
				local list = {}
				for _ = 1, perBatch do
					local ang = math.random() * math.pi * 2
					local dist = math.sqrt(math.random()) * radius
					local x, z = center.X + math.cos(ang) * dist, center.Z + math.sin(ang) * dist
					local hit =
						staticRaycast(Vector3.new(x, center.Y + rayUp, z), Vector3.new(0, -(rayUp + rayDown), 0))
					if hit then
						-- TEMP DEBUG: remove once ground debris colors are confirmed working
						table.insert(list, {
							CFrame = CFrame.new(hit.Position)
								* CFrame.Angles(math.random() * 6.28, math.random() * 6.28, math.random() * 6.28),
							Size = Vector3.new(
								math.random() * (maxSize - minSize) + minSize,
								math.random() * (maxSize - minSize) + minSize,
								math.random() * (maxSize - minSize) + minSize
							),
							Color = hit.Instance.Color,
							Material = hit.Instance.Material,
							MaterialVariant = hit.Instance.MaterialVariant,
						})
					end
				end

				if #list > 0 then
					Absorb(list, targetAttachment, absorbOpts)
				end
				task.wait(rate)
			end
		end)
	end

	if skillType == "GroundDebris" then
		if EffectUtilities.CheckRenderDistance(Attacker.HumanoidRootPart.CFrame, 500) == false then 
			return
		end
		
		AbsorbFromGround(argumentData.targetAttachment, {
			Duration = 2, -- ← set to your grab length
			Rate = 0.12,
			PerBatch = 3,
			Radius = 12,
			SpinSpeed = 10,
			Tumble = 16,
		})
		
		return
	end
end