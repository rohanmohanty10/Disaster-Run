local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local Debris            = game:GetService("Debris")
local SoundService      = game:GetService("SoundService")

--local Packages = ReplicatedStorage.Packages
--local Network  = Packages.Network
local Signal   = require(script.Signal)

local DEFAULT_ANIM_PARAMS = {
	TimePosition = 0,
	Speed        = 1,
}

local rayParams = RaycastParams.new()
rayParams.IgnoreWater                 = true
rayParams.FilterDescendantsInstances  = { workspace.World.Debris }
rayParams.FilterType                  = Enum.RaycastFilterType.Exclude
rayParams.CollisionGroup              = "OnlyDefault"

local function rayCheck(origin, direction, distance)
	return workspace:Raycast(origin, direction * distance, rayParams)
end

local function isNumInfinite(n)
	return math.isinf(n)
end

local function isVector3Valid(vec)
	if isNumInfinite(vec.X) or isNumInfinite(vec.Y) or isNumInfinite(vec.Z) then
		return false
	end
	return not math.isnan(vec.X) and not math.isnan(vec.Y) and not math.isnan(vec.Z)
end

local Utility = {
	isntNan       = isVector3Valid,
	isNumInfinite = isNumInfinite,

	-- Fires skill replication to all clients, only others, or only the main player.
	-- mode: "All" | "OnlyMain" | "Others"
	--fireClientsPOV = function(player, tool, serverTime, data, mode)
	--	if not tool then return end
	--	local fireMode   = mode or "All"
	--	data.main_plr    = player
	--	data.tool        = tool
	--	data.st          = serverTime or workspace:GetServerTimeNow()
	--	coroutine.wrap(function()
	--		if fireMode ~= "OnlyMain" then
	--			for _, otherPlayer in Players:GetPlayers() do
	--				if not player or otherPlayer.UserId ~= player.UserId then
	--					coroutine.wrap(function()
	--						pcall(function()
	--							Network.SkillsReplicator:InvokeClient(otherPlayer, data)
	--						end)
	--					end)()
	--				end
	--			end
	--		end
	--	end)()
	--	if fireMode ~= "Others" and player then
	--		pcall(function()
	--			Network.SkillsReplicator:InvokeClient(player, data)
	--		end)
	--	end
	--end,

	-- Hides all visible descendants of model for duration seconds, then restores them.
	-- transparency defaults to 1 (fully hidden).
	HideCharacter = function(model, duration, transparency)
		if not (model and duration) then return end
		local targetTransparency = transparency or 1;
		(function(target)
			for _, descendant in target:GetDescendants() do
				if not descendant:GetAttribute("dontHide") then
					if descendant:IsA("BasePart") or descendant:IsA("MeshPart")
						or descendant:IsA("Decal") or descendant:IsA("UIStroke") then
						if descendant.Transparency ~= 1 then
							if not descendant:GetAttribute("SavedTransparency") then
								descendant:SetAttribute("SavedTransparency", descendant.Transparency)
							end
							descendant.Transparency = targetTransparency
						end
					elseif descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
						if descendant.BackgroundTransparency < 1 then
							if not descendant:GetAttribute("SavedBackgroundTransparency") then
								descendant:SetAttribute("SavedBackgroundTransparency", descendant.BackgroundTransparency)
							end
							descendant.BackgroundTransparency = targetTransparency
						end
						if descendant.TextTransparency < 1 then
							if not descendant:GetAttribute("SavedTextTransparency") then
								descendant:SetAttribute("SavedTextTransparency", descendant.TextTransparency)
							end
							descendant.TextTransparency = targetTransparency
						end
					elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
						if descendant.BackgroundTransparency < 1 then
							if not descendant:GetAttribute("SavedBackgroundTransparency") then
								descendant:SetAttribute("SavedBackgroundTransparency", descendant.BackgroundTransparency)
							end
							descendant.BackgroundTransparency = targetTransparency
						end
						if descendant.ImageTransparency < 1 then
							if not descendant:GetAttribute("SavedImageTransparency") then
								descendant:SetAttribute("SavedImageTransparency", descendant.ImageTransparency)
							end
							descendant.ImageTransparency = targetTransparency
						end
					elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")
						or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
						if not descendant:GetAttribute("SavedEnabled") then
							descendant:SetAttribute("SavedEnabled", descendant.Enabled)
						end
						descendant.Enabled = false
						if descendant:IsA("ParticleEmitter") then descendant:Clear() end
					end
				end
			end
			task.delay(duration, function()
				for _, descendant in target:GetDescendants() do
					if not descendant:GetAttribute("dontHide") then
						descendant:FindFirstAncestorWhichIsA("Model")
						if descendant:IsA("BasePart") or descendant:IsA("MeshPart")
							or descendant:IsA("Decal") or descendant:IsA("UIStroke") then
							if descendant:GetAttribute("SavedTransparency") then
								descendant.Transparency = descendant:GetAttribute("SavedTransparency")
							end
						elseif descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
							if descendant:GetAttribute("SavedBackgroundTransparency") then
								descendant.BackgroundTransparency = descendant:GetAttribute("SavedBackgroundTransparency")
							end
							if descendant:GetAttribute("SavedTextTransparency") then
								descendant.TextTransparency = descendant:GetAttribute("SavedTextTransparency")
							end
						elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
							if descendant:GetAttribute("SavedBackgroundTransparency") then
								descendant.BackgroundTransparency = descendant:GetAttribute("SavedBackgroundTransparency")
							end
							if descendant:GetAttribute("SavedImageTransparency") then
								descendant.ImageTransparency = descendant:GetAttribute("SavedImageTransparency")
							end
						elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")
							or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
							descendant.Enabled = descendant:GetAttribute("SavedEnabled")
						end
					end
				end
			end)
		end)(model)
	end,

	-- Helper for calculating a second delay accounting for elapsed time.
	get2nd_delayNum = function(elapsed, total, offset)
		local diff        = elapsed - offset
		local clampedDiff = math.min(diff, 0)
		local remaining   = total - math.abs(clampedDiff)
		return math.max(remaining, 0)
	end,

	-- Destroys all Motor6D joints to fully ragdoll a character.
	breakJoints = function(character)
		if character and character:FindFirstChild("IsRagdoll") then
			character:SetAttribute("JointsBroken", true)
			character.IsRagdoll.Value = false
			task.wait()
			for _, descendant in character:GetDescendants() do
				if descendant:IsA("Motor6D") then descendant:Destroy() end
			end
		end
	end,

	-- Applies a LinearVelocity to hrp that pushes it forward, optionally decelerating
	-- over duration. Set gradual=true for 10-step deceleration with wall detection.
	moveBP_Forward = function(hrp, duration, speed, maxForce, gradual, extraDirection)
		local dirOffset = extraDirection or Vector3.new(0, 0, 0)
		for _, child in hrp:GetChildren() do
			if child:IsA("LinearVelocity") then child:Destroy() end
		end
		local linVel = script.LinearVelocity:Clone()
		Debris:AddItem(linVel, duration)
		linVel.Parent             = hrp
		linVel.ForceLimitsEnabled = true
		linVel.MaxAxesForce       = maxForce or Vector3.new(100000, 100000, 100000)
		linVel.Attachment0        = hrp.RootAttachment
		if gradual then
			pcall(function()
				for i = 1, 10 do
					local hit = rayCheck(hrp.CFrame.Position, hrp.CFrame.LookVector + dirOffset, speed)
					local velocity = hit
						and (hrp.CFrame.LookVector + dirOffset) * (hit.Distance / 2) * 10
						or  (hrp.CFrame.LookVector + dirOffset) * speed * 10
					if isVector3Valid(velocity) then linVel.VectorVelocity = velocity end
					local lerpedVel = linVel.VectorVelocity:Lerp(Vector3.new(0, 0, 0), i / 10)
					if isVector3Valid(lerpedVel) then linVel.VectorVelocity = lerpedVel end
					task.wait((duration or 0.3) / 10)
				end
			end)
		else
			local hit = rayCheck(hrp.CFrame.Position, hrp.CFrame.LookVector + dirOffset, speed)
			local velocity = hit
				and (hrp.CFrame.LookVector + dirOffset) * (hit.Distance / 2) * 10
				or  (hrp.CFrame.LookVector + dirOffset) * speed * 10
			if isVector3Valid(velocity) then linVel.VectorVelocity = velocity end
			pcall(function()
				for i = 1, 10 do
					local lerpedVel = velocity:Lerp(Vector3.new(0, 0, 0), i / 10)
					if isVector3Valid(lerpedVel) then linVel.VectorVelocity = lerpedVel end
					task.wait((duration or 0.3) / 10)
				end
			end)
		end
	end,

	-- Clones the CutsceneCamera rig from Packages, parents it to the character,
	-- and welds it to the HRP so it follows during cutscenes.
	--loadCutsceneCamera = function(character, lifetime)
	--	if character and character:FindFirstChild("HumanoidRootPart") then
	--		local hrp    = character.HumanoidRootPart
	--		local camRig = Packages.CutsceneCamera:Clone()
	--		Debris:AddItem(camRig, lifetime)
	--		camRig.Parent               = character
	--		camRig.root_part.CFrame     = hrp.CFrame
	--		camRig.root_part.Weld.Part0 = hrp
	--		return camRig
	--	end
	--end,

	-- Returns true if humanoid would die from damage and hasn't already played a finisher.
	canPlayFinisher = function(humanoid, damage)
		if not (humanoid and damage and humanoid:IsA("Humanoid")) then return false end
		if humanoid.Health <= 0 or humanoid:GetAttribute("_finisher_aPlayed") then return false end
		if ReplicatedStorage.Config["Finishers Only"].Value then
			humanoid:SetAttribute("_finisher_aPlayed", true)
			return true
		end
		local wouldDie = humanoid.Health - damage <= 1
		if wouldDie then humanoid:SetAttribute("_finisher_aPlayed", true) end
		return wouldDie
	end,

	-- Tweens a mesh part from its Start position to its End position using TweenTime attribute.
	PlayMeshAnimation = function(meshTemplate, cframe, _customParent)
		if not meshTemplate then return end
		local clone      = meshTemplate:Clone()
		clone.Parent     = workspace.World.Visuals
		local startPart  = clone.Start
		local endPart    = clone.End
		local relCFrame  = startPart.CFrame:ToObjectSpace(endPart.CFrame)
		local worldCFrame = cframe * startPart.Offset.C0
		startPart.CFrame = worldCFrame
		task.delay(0.02, function()
			TweenService:Create(startPart, TweenInfo.new(startPart:GetAttribute("TweenTime")), {
				Size         = endPart.Size,
				CFrame       = worldCFrame * relCFrame,
				Transparency = endPart.Transparency,
				Color        = endPart.Color,
			}):Play()
			Debris:AddItem(clone, startPart:GetAttribute("TweenTime"))
		end)
	end,

	-- Plays an impact frame animation on a ScreenGui container at the given fps.
	-- sequenceName: child folder name inside container containing ImageLabels.
	-- reverse: if true, plays the sequence in reverse.
	PlayImpactFrames = function(container, fps, sequenceName, reverse)
		if not (container and fps) then return end
		local sequence = (not sequenceName) or container:FindFirstChild(sequenceName)
		if not sequence then return end
		local totalFrames  = #sequence:GetChildren()
		local frameCount   = totalFrames
		pcall(function()
			if Players.LocalPlayer.gameplaySettings["Photosensitive Mode"].Value then
				frameCount = 0
			end
		end)
		if frameCount <= 0 then return end
		container.Enabled = true
		local msPerFrame  = frameCount / fps * 1000
		local startTime   = tick()
		local conn        = nil
		for _, label in sequence:GetChildren() do
			if label:IsA("ImageLabel") then
				label.Visible  = not reverse
				label.Position = UDim2.fromScale(0.5, 0.5)
				label.ZIndex   = totalFrames - (tonumber(label.Name) or 0)
			end
		end
		-- FIX: store connection so it can be properly disconnected when animation ends
		conn = RunService.RenderStepped:Connect(function()
			local elapsed      = (tick() - startTime) * 1000 / msPerFrame * frameCount
			local currentFrame = math.floor(elapsed) + 1
			if frameCount < currentFrame then
				if conn then conn:Disconnect(); conn = nil end
				for _, label in sequence:GetChildren() do
					if label:IsA("ImageLabel") then
						label.Position = UDim2.fromScale(2, 0.5)
						label.Visible  = true
					end
				end
			else
				for _, label in sequence:GetChildren() do
					if label:IsA("ImageLabel") then
						label.Visible = currentFrame <= tonumber(label.Name)
					end
				end
				if currentFrame <= 1 then
					local frame = sequence:FindFirstChild(currentFrame)
					if not frame then return end
					frame.Visible = true
				else
					local prevFrame = sequence:FindFirstChild(currentFrame - 1)
					if not prevFrame then return end
					prevFrame.Visible = false
				end
				if reverse then
					local nextFrame = sequence:FindFirstChild(currentFrame + 1)
					if not nextFrame then return end
					nextFrame.Visible = true
				end
			end
		end)
	end,

	-- Plays an awakening music sound on the player's character torso.
	PlayAwakeningMusic = function(player, soundAsset)
		if not (player and soundAsset) then return end
		local torso = player.Character:FindFirstChild("Torso")
		if not torso then return end
		local sound = soundAsset:Clone()
		sound.Parent             = torso
		sound.SoundGroup         = SoundService.AwakeningMusic
		sound.RollOffMinDistance = 150
		sound.RollOffMinDistance = 50  -- original sets this twice
		sound:Play()
		sound.Ended:Once(function() sound:Destroy() end)
		return sound
	end,

	-- Returns true if model exists in workspace and has a PrimaryPart.
	vExists = function(model)
		return model and model:IsDescendantOf(workspace) and model.PrimaryPart and true or false
	end,

	-- Shows a vignette effect on the local player's screen. Server call fires it to targetPlayer.
	emitVignetteEffect = function(color, _, fadeInTime, holdTime, targetTransparency, targetPlayer)
		if RunService:IsServer() then
			if targetPlayer and targetPlayer:IsA("Player") then
				script.replication:FireClient(targetPlayer, "emitVignetteEffect", color, nil, fadeInTime, holdTime, targetTransparency)
			end
		else
			local safeTime = math.max(fadeInTime, 0.1)
			local vignette = script.Vignette:Clone()
			Debris:AddItem(vignette, safeTime + holdTime)
			vignette.ImageTransparency = 1
			vignette.ImageColor3       = color
			vignette.Parent            = Players.LocalPlayer.PlayerGui.GameUI
			TweenService:Create(vignette, TweenInfo.new(safeTime), {
				ImageTransparency = targetTransparency,
			}):Play()
			task.delay(safeTime, function()
				TweenService:Create(vignette, TweenInfo.new(holdTime), {
					ImageTransparency = 1,
				}):Play()
			end)
		end
	end,

	-- Emits, enables, or times a single ParticleEmitter, Beam, or Trail using its attributes.
	-- Attributes used: EmitCount, EmitDelay, EmitDuration, SetEnabled.
	emit_effect = function(fx)
		if not fx then return end
		if fx:IsA("ParticleEmitter") then
			if fx:GetAttribute("EmitCount") and fx:GetAttribute("EmitCount") > 0 then
				if not (fx:GetAttribute("EmitDelay") or fx:GetAttribute("EmitDuration")) then
					fx:Emit(fx:GetAttribute("EmitCount"))
					return
				end
				if fx:GetAttribute("EmitDelay") then
					task.delay(fx:GetAttribute("EmitDelay"), function()
						fx:Emit(fx:GetAttribute("EmitCount"))
					end)
				else
					fx:Emit(fx:GetAttribute("EmitCount"))
				end
				if fx:GetAttribute("EmitDuration") then
					fx.Enabled = true
					task.delay(fx:GetAttribute("EmitDuration"), function() fx.Enabled = false end)
				end
			else
				if fx:GetAttribute("EmitDuration") and fx:GetAttribute("EmitDuration") > 0 then
					fx.Enabled = true
					task.delay(fx:GetAttribute("EmitDuration"), function() fx.Enabled = false end)
					return
				end
				if fx:GetAttribute("SetEnabled") then
					fx.Enabled = true
				end
			end
		elseif fx:IsA("Beam") or fx:IsA("Trail") then
			if fx:GetAttribute("EmitDuration") and fx:GetAttribute("EmitDuration") > 0 then
				fx.Enabled = true
				task.delay(fx:GetAttribute("EmitDuration"), function() fx.Enabled = false end)
			end
		end
	end,

	-- Sets all BasePart collision groups in character to NoHumanoid (disable=true) or Humanoid.
	disable_humanoid_collisions = function(character, disable)
		if not character then return end
		if not character:FindFirstChild("Humanoid") then return end
		if character:FindFirstChild("IsRagdoll") and character.IsRagdoll.Value then return end
		for _, descendant in character:GetDescendants() do
			if descendant:IsA("BasePart") then
				descendant.CollisionGroup = disable and "NoHumanoid" or "Humanoid"
			end
		end
	end,

	-- Creates a NumberValue janitor that fires callback when it reaches threshold.
	addM1_janitor = function(janitorHolder, threshold, janitorType, callback)
		if not (janitorHolder and threshold and janitorType and callback) then return end
		local janitor = Instance.new("NumberValue", janitorHolder._M1sJanitor)
		janitor.Name  = "Janitor"
		janitor:SetAttribute("Type", janitorType)
		local conn = nil
		conn = janitor.Changed:Connect(function(value)
			if value >= threshold then
				conn:Disconnect(); conn = nil
				janitor:Destroy()
				callback(); callback = nil
			end
		end)
		janitor.Destroying:Once(function()
			if conn then conn:Disconnect(); conn = nil end
			callback = nil
			janitor  = nil
		end)
		return janitor
	end,

	-- Applies an ice/freeze overlay to each body part of character for duration seconds.
	emitFreezeEffect = function(character, duration)
		if not (character and duration) then return end
		local safeDuration = math.max(duration, 0.2)
		for _, rigPart in script.FrozenRig:GetChildren() do
			if character:FindFirstChild(rigPart.Name) and character[rigPart.Name]:IsA("BasePart") then
				local bodyPart = character[rigPart.Name]
				local clone    = rigPart:Clone()
				Debris:AddItem(clone, safeDuration)
				clone.Size         = Vector3.new(0, 0, 0)
				clone.Transparency = 1
				clone.CFrame       = bodyPart.CFrame
				clone.Weld.Part0   = bodyPart
				clone.Weld.Part1   = clone
				clone.Parent       = bodyPart
				TweenService:Create(clone, TweenInfo.new(0.1), {
					Size         = clone.Name == "Head" and Vector3.new(1.33, 1.33, 1.33) or bodyPart.Size * 1.1,
					Transparency = 0.5,
				}):Play()
				task.delay(safeDuration - 0.1, function()
					TweenService:Create(clone, TweenInfo.new(0.1), { Transparency = 1 }):Play()
				end)
			end
		end
	end,

	meshEmit     = require(script.meshEmit),
	bubbleModule = require(script.BubbleModule),

	-- Spawns ground smoke particles under part at smokeRate/s for duration seconds.
	emitRocksTrail = function(part, duration, smokeRate, _rocksRate, customParams)
		local startTime = tick()
		local params    = customParams or rayParams
		coroutine.wrap(function()
			while true do
				local groundHit = workspace:Raycast(part.CFrame.Position, -part.CFrame.UpVector * 5, params)
				if groundHit then
					local smoke = script.HK_Smoke:Clone()
					smoke.Parent = workspace.World.Debris
					smoke.CFrame = CFrame.new(groundHit.Position, groundHit.Position + part.CFrame.LookVector) * CFrame.new(0, 0.3, 0)
					task.delay(0.01, function()
						smoke.ParticleEmitter.Color = ColorSequence.new(groundHit.Instance.Color)
						smoke.ParticleEmitter:Emit(math.random(4, 5))
						Debris:AddItem(smoke, smoke.ParticleEmitter.Lifetime.Max)
					end)
				end
				task.wait(1 / smokeRate)
				if duration < tick() - startTime then return end
			end
		end)()
	end,

	-- Calls emit_effect on every descendant of fxInstance after a 0.02s delay.
	emitFX = function(fxInstance)
		task.delay(0.02, function()
			for _, descendant in fxInstance:GetDescendants() do
				Utility.emit_effect(descendant)
			end
		end)
	end,

	-- Continuously tweens part toward target over duration, updating each RenderStepped.
	-- offset: CFrame offset (X, Y, Z) applied after alignment.
	tweenPartIntoPart = function(part, target, duration, offset)
		local startTime = tick()
		local conn      = nil
		conn = RunService.RenderStepped:Connect(function()
			if duration <= tick() - startTime
				or not (part   and part:IsDescendantOf(workspace)
					and     target and target:IsDescendantOf(workspace)) then
				conn:Disconnect(); conn = nil
				return
			end
			local distance  = (part.Position - target.Position).Magnitude
			local direction = (target.Position - part.Position).Unit
			if isVector3Valid(direction) then
				local remaining = duration - (tick() - startTime)
				local goal = {}
				goal.CFrame = CFrame.new(part.Position, part.Position + direction * 9999)
					* CFrame.new(offset.X, offset.Y, -math.max(distance + offset.Z, 0))
				TweenService:Create(part, TweenInfo.new(math.max(remaining, 0)), goal):Play()
			end
		end)
		return conn
	end,

	-- Schedules animation marker events from a markers table with latency compensation.
	-- markers: { [timePosition] = { Name, Value } }
	-- options: { TimePosition, Speed, FireEventsAnyway, cs_behavior }
	CreateAnimationThreads = function(markers, _character, options)
		local opts = options or DEFAULT_ANIM_PARAMS
		if not markers then return end
		local timePos    = opts.TimePosition or DEFAULT_ANIM_PARAMS.TimePosition
		local speed      = opts.Speed        or DEFAULT_ANIM_PARAMS.Speed
		local fireAnyway = opts.FireEventsAnyway
		local threads    = {}
		local cancelled  = false
		for markerTime, marker in markers do
			if not threads[marker.Name] then
				threads[marker.Name] = {
					Reached      = Signal.new(),
					TimePosition = markerTime,
				}
			end
			if markerTime >= (opts.TimePosition or DEFAULT_ANIM_PARAMS.TimePosition) or fireAnyway then
				local delay = math.max(markerTime / speed - timePos / speed, 0)
				task.delay(delay, function()
					if not cancelled then
						if threads[marker.Name] then
							threads[marker.Name].Reached:Fire(marker.Value)
						end
					end
				end)
			end
		end
		return threads
	end,

	-- Hides all parts in a radius and all characters in Live folders for duration seconds.
	-- overlapParams: OverlapParams with FilterDescendantsInstances for excluded models.
	hideAreaInRadius = function(position, duration, radius, overlapParams)
		local startTime = tick()
		coroutine.wrap(function()
			local processed = {}
			for _ = 1, 50 do
				for _, part in workspace:GetPartBoundsInRadius(position, radius, overlapParams) do
					if part.CollisionGroup ~= "Leaderboards" and not processed[part] then
						processed[part]    = true
						local savedTransparency = part.Transparency
						part.Transparency  = 1
						local wasChanged   = false
						local transparencyConn = part:GetPropertyChangedSignal("Transparency"):Connect(function()
							wasChanged        = true
							part.Transparency = 1
						end)
						task.delay(duration, function()
							if transparencyConn then transparencyConn:Disconnect(); transparencyConn = nil end
							if savedTransparency > 0 and not wasChanged then
								part.Transparency = 1
								return
							elseif savedTransparency <= 0 and wasChanged then
								part.Transparency = 1
							else
								part.Transparency = 0
							end
						end)
					end
				end
				task.wait(duration / 50)
			end
			table.clear(processed)
		end)()

		local function onCharacterAdded(character)
			if table.find(overlapParams.FilterDescendantsInstances, character) then return end
			local remaining = duration - (tick() - startTime)
			if remaining > 0 then Utility.HideCharacter(character, remaining) end
		end

		local dummiesFolder = workspace.World.Live:FindFirstChild("Dummies")
		local playersFolder = workspace.World.Live:FindFirstChild("Players")

		if dummiesFolder then
			for _, dummy in dummiesFolder:GetChildren() do
				if not table.find(overlapParams.FilterDescendantsInstances, dummy) then
					local remaining = duration - (tick() - startTime)
					if remaining > 0 then Utility.HideCharacter(dummy, remaining) end
				end
			end
		end

		if playersFolder then
			for _, player in playersFolder:GetChildren() do
				if not table.find(overlapParams.FilterDescendantsInstances, player) then
					local remaining = duration - (tick() - startTime)
					if remaining > 0 then Utility.HideCharacter(player, remaining) end
				end
			end
		end

		local dummiesConn = dummiesFolder and dummiesFolder.ChildAdded:Connect(onCharacterAdded)
		local playersConn = playersFolder and playersFolder.ChildAdded:Connect(onCharacterAdded)

		task.delay(duration, function()
			if dummiesConn then dummiesConn:Disconnect(); dummiesConn = nil end
			if playersConn then playersConn:Disconnect(); playersConn = nil end
		end)
	end,
}

if RunService:IsClient() then
	script.replication.OnClientEvent:Connect(function(funcName, ...)
		Utility[funcName](...)
	end)
end

return Utility