-- 3SS Daisen Sekai - Client VFX Handler

local Effects = script.Move6
local Anims = Effects.Anims
local FALLBACK_TIMEOUT = 10.5

local DaisenSekaiEffect = {}

-- ──────────────────────────────────────────────
-- Helpers
-- ──────────────────────────────────────────────

--- Enables or disables all ParticleEmitters in a model
local function setParticlesEnabled(parent, enabled)
	for _, v in ipairs(parent:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = enabled
		end
	end
end

--- Tweens the TimeScale of all ParticleEmitters in a model
local function tweenParticleTimeScale(parent, targetScale)
	for _, v in ipairs(parent:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			_G.tween(v, { 0.45, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
				TimeScale = targetScale
			})
		end
	end
end

--- Finds the top and bottom trail attachments on a part based on its longest axis
function GetTopAndBottomTrailAttachments(part)
	local size = part.Size
	local cf   = part.CFrame

	local axes = {
		{ axis = "X", size = size.X },
		{ axis = "Y", size = size.Y },
		{ axis = "Z", size = size.Z },
	}
	table.sort(axes, function(a, b) return a.size > b.size end)

	local longestAxis = axes[1].axis
	local halfLength  = axes[1].size / 2

	local offsetA, offsetB
	if longestAxis == "X" then
		offsetA = Vector3.new(-halfLength, 0, 0)
		offsetB = Vector3.new( halfLength, 0, 0)
	elseif longestAxis == "Y" then
		offsetA = Vector3.new(0, -halfLength, 0)
		offsetB = Vector3.new(0,  halfLength, 0)
	elseif longestAxis == "Z" then
		offsetA = Vector3.new(0, 0, -halfLength)
		offsetB = Vector3.new(0, 0,  halfLength)
	end

	local worldA = cf:PointToWorldSpace(offsetA)
	local worldB = cf:PointToWorldSpace(offsetB)

	local bestDistA = math.huge
	local bestDistB = math.huge
	local attA, attB = nil, nil

	for _, trail in ipairs(part:GetChildren()) do
		if trail:IsA("Trail") and trail.Name ~= "notTrail" then
			local att0 = trail.Attachment0
			local att1 = trail.Attachment1
			if att0 and att1 then
				local distToB = (att0.WorldPosition - worldB).Magnitude
				local distToA = (att1.WorldPosition - worldA).Magnitude
				if distToB < bestDistA then
					attA = att0
					bestDistA = distToB
				end
				if distToA < bestDistB then
					attB = att1
					bestDistB = distToA
				end
			end
		end
	end

	return attA, attB
end

--- Positions the InnerEdge1/2/3 attachments along the blade's trail
function PositionInnerEdgeAttachments(blade, attachmentMap)
	local topAtt, bottomAtt = GetTopAndBottomTrailAttachments(blade)
	if not (topAtt and bottomAtt) then
		warn("Top or bottom attachment not found!")
		return
	end

	local top    = bottomAtt.WorldPosition
	local bottom = topAtt.WorldPosition

	local positions = {
		InnerEdge1 = top,
		InnerEdge2 = bottom + (top - bottom).Unit * (0.05 * (top - bottom).Magnitude),
		InnerEdge3 = bottom,
	}

	for name, worldPos in pairs(positions) do
		local att = attachmentMap[name]
		if att and att:IsA("Attachment") then
			att.WorldPosition = worldPos
		else
			warn(name .. " attachment not found or is not an Attachment!")
		end
	end
end

--- Builds a CFrame aligned to a surface normal
local function buildSurfaceCFrame(originCFrame, normal)
	local pos     = originCFrame.Position
	local right   = originCFrame.LookVector:Cross(normal).Unit
	right = (right.Magnitude > 0.001 and right or originCFrame.RightVector).Unit
	local forward = right:Cross(normal).Unit
	return CFrame.fromMatrix(pos, right, normal, forward)
end

--- Spawns a teleport dash flash VFX at the given CFrame
local function spawnDashFlash(cframe, hakiColor)
	local vfx = script.Move6.DashTP:Clone()
	vfx.CFrame = cframe
	if hakiColor then
		_G.PlayEffect("3SSRecolor", nil, vfx, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
	end
	vfx.Parent = workspace.Effects
	_G.customEmit(vfx)
	_G.destroy(vfx, 3)
end

--- Fires callback when animation marker is reached, with a fallback timeout
local function onMarkerOrTimeout(animTrack, markerName, timeout, callback)
	local fired = false
	animTrack:GetMarkerReachedSignal(markerName):Connect(function()
		if not fired then
			fired = true
			callback()
		end
	end)
	task.delay(timeout, function()
		if not fired then
			fired = true
			callback()
		end
	end)
end

-- ──────────────────────────────────────────────
-- Blade trail setup helpers
-- ──────────────────────────────────────────────

--- Adds trails and edge attachments to a blade part, remapping trail attachments to clones
local function setupBladeTrails(blade, trailList, hakiColor)
	local templateChildren = script.Blade:GetChildren()
	local clonedMap = {}   -- name → cloned attachment
	local trailClones = {} -- trail clones needing remapping

	for _, template in ipairs(templateChildren) do
		local clone = template:Clone()
		if clone:IsA("Trail") then
			clone.Name = "notTrail"
			table.insert(trailClones, clone)
		else
			clonedMap[clone.Name] = clone
		end
		clone.Parent = blade
		table.insert(trailList, clone)
	end

	-- Remap trail attachments to their cloned equivalents
	for _, trail in ipairs(trailClones) do
		trail.Attachment0 = clonedMap[trail.Attachment0.Name]
		trail.Attachment1 = clonedMap[trail.Attachment1.Name]
	end

	if hakiColor then
		_G.PlayEffect("3SSRecolor", nil, trailClones, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
	end

	PositionInnerEdgeAttachments(blade, clonedMap)
end

--- Sets up blade trails on all swords in the character
local function setupAllBlades(character, trailList, hakiColor)
	for _, child in ipairs(character:GetChildren()) do
		if child:FindFirstChild("Blade") then
			setupBladeTrails(child.Blade, trailList, hakiColor)
		end
	end
end

--- Disables and schedules cleanup of all blade trails
local function cleanupBladeTrails(trailList)
	for _, item in ipairs(trailList) do
		if item:IsA("Trail") then
			item.Enabled = false
		end
		_G.destroy(item, 3)
	end
end

-- ──────────────────────────────────────────────
-- Main
-- ──────────────────────────────────────────────

function DaisenSekaiEffect.start(_, data)
	local character  = data.Character
	local isCutscene = data.CutsceneHit
	if not character then return end

	local root = character.PrimaryPart
	if not root then return end
	if not _G.checkRenderDistance(root.Position) then return end

	local folder     = Instance.new("Folder")
	folder.Parent    = workspace.Effects

	local hrp        = character:WaitForChild("HumanoidRootPart")
	local humanoid   = character:WaitForChild("Humanoid")
	local enemy      = data.Enemy
	local remote     = data.remote
	local isLocal    = character == game.Players.LocalPlayer.Character
	local hakiColor  = data.hakiColor

	-- ── Slash-only mode (replicated hit CFrame passed in) ────────────────
	if data.slashCFrame then
		local groundMat, groundPos, groundNormal = _G.getRayFloor(data.slashCFrame, 8)
		local groundAlignedCF = CFrame.new(groundPos, groundPos + groundNormal)
			* CFrame.Angles(-math.pi/2, math.rad(math.random(0, 360)), 0)

		local slashVFX = Effects.Slash:Clone()
		slashVFX.CFrame = data.slashCFrame

		if groundMat then
			slashVFX.VFX.WorldCFrame = groundAlignedCF
			_G.recolorParticles(slashVFX, groundMat.Color)
		else
			_G.removeParticles(slashVFX)
		end

		if hakiColor then
			_G.PlayEffect("3SSRecolor", nil, slashVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
		end

		slashVFX.Parent = workspace.Effects

		-- Pierce beam between start and slash positions
		local startCF   = data.startCFrame
		local dist      = (startCF.Position - data.slashCFrame.Position).Magnitude
		local pierceVFX = Effects.Pierce:Clone()
		pierceVFX.CFrame = CFrame.new(startCF.Position, data.slashCFrame.Position)
			* CFrame.Angles(0, -math.pi/2, 0)
			* CFrame.new(-dist / 2, 0, 0)
		pierceVFX.Size = Vector3.new(dist, 20, 20)

		local highlight = Instance.new("Highlight")
		highlight.DepthMode        = Enum.HighlightDepthMode.Occluded
		highlight.FillTransparency = 0
		highlight.OutlineColor     = hakiColor or Color3.fromRGB(87, 168, 255)
		highlight.FillColor        = Color3.fromRGB(0, 0, 0)
		highlight.Parent           = pierceVFX

		pierceVFX.Parent = workspace.Effects

		_G.tween(pierceVFX, { 0.1, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, {
			Size = Vector3.new(dist, 0, 0)
		})
		_G.destroy(pierceVFX, 0.1)
		_G.customEmit(slashVFX)
		_G.destroy(slashVFX, 5)

		spawnDashFlash(CFrame.new(character.UpperTorso.Position), hakiColor)
		return
	end

	local bladeTrails = {}

	-- ── Cutscene mode ────────────────────────────────────────────────────
	if isCutscene then
		local isExecute      = data.exucuted
		local localInvolved  = isLocal or enemy == game.Players.LocalPlayer.Character

		-- Drag VFX follows attacker
		local dragVFX = Effects.Drag:Clone()
		dragVFX.CFrame = hrp.CFrame * CFrame.new(0, 0, -2)
		if hakiColor then
			_G.PlayEffect("3SSRecolor", nil, dragVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
		end
		dragVFX.Attachment2.Lines.Acceleration = hrp.CFrame.LookVector * -800
		dragVFX.Parent = folder
		setParticlesEnabled(dragVFX, true)

		if localInvolved then
			workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
			_G.PlayEffect("CameraHideUI", nil, true)
		end

		local enemyHumanoid = enemy.Humanoid
		humanoid.AutoRotate = false
		humanoid.AutomaticScalingEnabled = false
		enemyHumanoid.AutomaticScalingEnabled = false

		-- Load and play animations
		local attackAnim = humanoid:LoadAnimation(Anims.Cutscene)
		attackAnim:Play(0)
		attackAnim.Looped = false

		local victimAnim = enemyHumanoid:LoadAnimation(
			isExecute and Anims.VictimCutscene or Anims.VictimCutsceneNormal
		)
		victimAnim:Play(0)
		victimAnim.Looped = false

		local enemyRoot = enemy.PrimaryPart
		if enemy:FindFirstChild("LowerTorso") then
			enemyRoot = enemy.LowerTorso
		end
		_G.PlaySound(enemyRoot.CFrame, script["Audio/3ssDaisenSekaiHit"])

		-- Camera model
		local camModel  = Effects.NormalCam:Clone()
		local cutsceneVFX = Effects.CutsceneVictimVFX
		local slashesVFX  = cutsceneVFX.SlashesEnable:Clone()

		if hakiColor then
			_G.PlayEffect("3SSRecolor", nil, slashesVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			_G.PlayEffect("3SSRecolor", nil, camModel,   hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
		end

		-- Continuous slash flash loop on enemy for ~2 seconds
		task.spawn(function()
			local slashModel = Instance.new("Model")
			slashModel.Parent = workspace.Effects

			local flashHighlight = Instance.new("Highlight")
			flashHighlight.FillColor          = hakiColor or Color3.fromRGB(90, 156, 255)
			flashHighlight.DepthMode          = Enum.HighlightDepthMode.Occluded
			flashHighlight.OutlineTransparency = 1
			flashHighlight.FillTransparency   = 0.8
			flashHighlight.Parent             = slashModel

			local startTime = tick()
			while tick() - startTime < 2 do
				local beamSlash = Effects.BeamSlashes:Clone()
				local glassMesh = Effects.Glass:Clone()

				beamSlash.CFrame = enemy.HumanoidRootPart.CFrame
					* CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
				glassMesh.CFrame = beamSlash.CFrame

				if hakiColor then
					_G.PlayEffect("3SSRecolor", nil, beamSlash, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
				end

				beamSlash.Parent = folder
				glassMesh.Parent = slashModel

				for _, beam in ipairs(beamSlash:GetDescendants()) do
					if beam:IsA("Beam") then
						_G.tween(beam, { 0.11, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
							Width0 = 0, Width1 = 0
						})
					end
				end

				_G.tween(glassMesh, { 0.1, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
					Size = Vector3.new(23, 0, 0)
				})
				_G.destroy(glassMesh, 0.3)
				_G.destroy(beamSlash, 0.3)

				task.wait(0.12)
			end
		end)

		setupAllBlades(character, bladeTrails, hakiColor)

		if localInvolved then
			workspace.CurrentCamera.FieldOfView = 50
		end

		camModel.Parent = folder
		slashesVFX.Parent = enemy.UpperTorso
		camModel:PivotTo(hrp.CFrame * CFrame.new(0, 0, -2))

		local camAnim = camModel.AnimationController.Animator:LoadAnimation(
			isExecute and Anims.CameraCutscene or Anims.CameraCutsceneNormal
		)
		camAnim:Play(0)
		camAnim.Looped = false

		-- Drive camera from the model every frame
		if localInvolved then
			local camConnection
			camConnection = game:GetService("RunService").RenderStepped:Connect(function()
				if camModel and camModel:IsDescendantOf(workspace) then
					workspace.CurrentCamera.CFrame = camModel.Cam.CFrame
				else
					camConnection:Disconnect()
				end
			end)
		end

		-- Slash particles on/off timing
		task.spawn(function()
			setParticlesEnabled(slashesVFX, true)
			task.delay(0.35, function() tweenParticleTimeScale(slashesVFX, 0) end)
			task.delay(0.90, function() tweenParticleTimeScale(slashesVFX, 1) end)
			task.wait(1.55)
			setParticlesEnabled(slashesVFX, false)
		end)

		-- CamEffect marker: emit camera + hide drag
		onMarkerOrTimeout(victimAnim, "CamEffect", 1.633, function()
			if localInvolved then
				_G.customEmit(camModel)
				workspace.CurrentCamera.FieldOfView = 40
			end
			setParticlesEnabled(dragVFX, false)
		end)

		local cutBlood      = cutsceneVFX.CutBlood:Clone()
		local enableBleeding = cutsceneVFX.EnableBleeding:Clone()
		local bleedingParticles = {}

		-- Split marker: blood, FOV squeeze, blade particles
		onMarkerOrTimeout(victimAnim, "Split", 2.233, function()
			local groundMat = _G.getRayFloor(character.PrimaryPart.CFrame, 8)

			local airVFX = Effects.Air:Clone()
			if groundMat then
				_G.recolorParticles(airVFX, groundMat.Color)
			else
				_G.removeParticles(airVFX)
			end

			if localInvolved then
				_G.tween(workspace.CurrentCamera, { 0.19, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
					FieldOfView = 35
				})
			end

			if hakiColor then
				_G.PlayEffect("3SSRecolor", nil, { airVFX }, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			end

			cutBlood.Parent      = enemy.UpperTorso
			enableBleeding.Parent = enemy.UpperTorso
			airVFX.Parent        = folder
			airVFX.CFrame        = hrp.CFrame * CFrame.new(0, 4, -9)

			_G.customEmit(cutBlood)
			setParticlesEnabled(airVFX, true)
			setParticlesEnabled(enableBleeding, true)

			-- Add bleeding particles to each sword blade
			for _, child in ipairs(character:GetChildren()) do
				if child.Name:match("Sword") and child:FindFirstChild("Blade") then
					for _, template in ipairs(script.Particles:GetChildren()) do
						local particle = template:Clone()
						particle.Enabled = true
						particle.Name    = "notTrail"
						particle.Rate    = particle.Rate / 2
						particle.Parent  = child.Blade
						table.insert(bleedingParticles, particle)
					end
				end
			end

			if hakiColor then
				_G.PlayEffect("3SSRecolor", nil, bleedingParticles, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			end

			if isExecute then
				_G.PlaySound(enemy.UpperTorso, script.excu)
			end

			task.wait(1.7)
			setParticlesEnabled(airVFX, false)
			task.wait(2.2)

			if localInvolved then
				_G.tween(workspace.CurrentCamera, { 0.4, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
					FieldOfView = 45
				})
			end
		end)

		-- Swing marker: sweep VFX, cleanup, restore camera
		onMarkerOrTimeout(attackAnim, "Swing", 6.617, function()
			local groundMat, groundPos = _G.getRayFloor(character.PrimaryPart.CFrame, 8)

			local sweepVFX = Effects.Sweep:Clone()
			if groundMat then
				_G.recolorParticles(sweepVFX, groundMat.Color)
			else
				_G.removeParticles(sweepVFX)
			end

			sweepVFX.CFrame = CFrame.new(character.UpperTorso.Position - Vector3.new(0, 0.3, 0))
			sweepVFX.Parent = folder

			if hakiColor then
				_G.PlayEffect("3SSRecolor", nil, sweepVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			end

			-- Expanding ring mesh
			local ringMesh = Effects.Mesh:Clone()
			ringMesh.CFrame = sweepVFX.CFrame * CFrame.new(0, -3.2, 0)
			ringMesh.Parent = folder

			local ringHighlight = Instance.new("Highlight")
			ringHighlight.OutlineTransparency = 1
			ringHighlight.DepthMode           = Enum.HighlightDepthMode.Occluded
			ringHighlight.FillTransparency    = 1
			ringHighlight.Parent              = ringMesh

			_G.tween(ringMesh, { 0.4, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
				Size = Vector3.new(26, 0, 26)
			})
			_G.destroy(ringMesh, 0.4)
			_G.customEmit(sweepVFX)

			-- Stop bleeding particles
			_G.particleEnabled(cutBlood, false)
			_G.particleEnabled(enableBleeding, false)
			_G.destroy({ cutBlood, enableBleeding }, 5)

			for _, p in ipairs(bleedingParticles) do
				p.Enabled = false
				_G.destroy(p, 3)
			end

			cleanupBladeTrails(bladeTrails)

			task.wait(1)
			attackAnim:Stop(0)
			victimAnim:Stop(0)
			camModel:Destroy()

			humanoid.AutomaticScalingEnabled  = true
			enemyHumanoid.AutomaticScalingEnabled = true

			if localInvolved then
				workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
				workspace.CurrentCamera.CameraType    = Enum.CameraType.Custom
				workspace.CurrentCamera.FieldOfView   = 70
				_G.PlayEffect("CameraHideUI", nil, false)
			end

			character.PrimaryPart.Velocity = Vector3.zero
			enemy.PrimaryPart.Velocity     = Vector3.zero
			humanoid.AutoRotate            = true
			_G.destroy(folder, 2)
		end)

		-- ── Startup / spin mode ──────────────────────────────────────────────
	else
		local startupAnim = humanoid:LoadAnimation(Anims.Startup)
		startupAnim:Play(0)
		startupAnim.Looped = false
		startupAnim:AdjustSpeed(2)

		local startupSFX = _G.PlaySound(hrp, script["Audio/3ssDaisenSekaiStart"])
		startupSFX.Parent = hrp

		if isLocal then _G.FaceMouse = true end

		local spinConnection = startupAnim:GetMarkerReachedSignal("SpinStart"):Connect(function()
			-- Fade out startup sound
			_G.tween(startupSFX, { 0.5, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, { Volume = 0 })
			_G.destroy(startupSFX, 0.5)
			startupAnim:AdjustSpeed(1)

			local groundMat, groundPos, groundNormal = _G.getRayFloor(character.PrimaryPart.CFrame, 8)
			local groundCF = CFrame.new(groundPos, groundPos + groundNormal)
				* CFrame.Angles(-math.pi/2, math.rad(math.random(0, 360)), 0)

			local loopSFX = _G.PlaySound(hrp, script["Audio/3ssDaisenSekaiChargeLoop"])
			loopSFX.Parent = hrp

			-- Spinning VFX attached to root
			local spinVFX = Effects.Spinning.VFX2:Clone()
			spinVFX.Position = Vector3.new(0, -character.PrimaryPart.Size.Y / 6.5, -character.PrimaryPart.Size.Y)
			spinVFX.Parent   = character.PrimaryPart

			if hakiColor then
				_G.PlayEffect("3SSRecolor", nil, spinVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			end

			-- Ground smoke
			local smokeVFX = Effects.SpinningSmoke:Clone()
			smokeVFX.CFrame = groundCF
			smokeVFX.Parent = folder

			if hakiColor then
				_G.PlayEffect("3SSRecolor", nil, smokeVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
			end

			if groundMat then
				_G.recolorParticles(smokeVFX, groundMat.Color)
			else
				_G.removeParticles(smokeVFX)
				smokeVFX.CFrame = character.PrimaryPart.CFrame - Vector3.new(0, 2.8, 0)
			end

			setParticlesEnabled(spinVFX,  true)
			setParticlesEnabled(smokeVFX, true)
			setupAllBlades(character, bladeTrails, hakiColor)

			-- SpinStop marker: charge burst, then wait for Hit
			startupAnim:GetMarkerReachedSignal("SpinStop"):Connect(function()
				setParticlesEnabled(spinVFX,  false)
				setParticlesEnabled(smokeVFX, false)
				_G.destroy(spinVFX, 1)

				_G.tween(loopSFX, { 0.25, "Sine", Enum.EasingDirection.Out, 0, false, 0 }, { Volume = 0 })
				_G.destroy(loopSFX, 0.25)

				local chargeVFX = Effects.Charge:Clone()
				chargeVFX.CFrame  = hrp.CFrame
				chargeVFX.Parent  = folder
				if hakiColor then
					_G.PlayEffect("3SSRecolor", nil, chargeVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
				end
				_G.customEmit(chargeVFX)

				-- Hit marker: dash flash, anchor, fire server
				startupAnim:GetMarkerReachedSignal("Hit"):Connect(function()
					if isLocal then _G.FaceMouse = false end

					local groundMat2, groundPos2, groundNormal2 = _G.getRayFloor(hrp.CFrame, 8)
					local dashSectionVFX = Effects.DashSection:Clone()
					dashSectionVFX.CFrame = hrp.CFrame * CFrame.new(0, -2, 0)

					if groundMat2 then
						dashSectionVFX.CFrame = buildSurfaceCFrame(
							CFrame.new(Vector3.zero, hrp.CFrame.LookVector) + groundPos2,
							groundNormal2
						) * CFrame.new(0, 0, -10)
					end

					if hakiColor then
						_G.PlayEffect("3SSRecolor", nil, dashSectionVFX, hakiColor, "isBlue", Color3.fromRGB(74, 156, 255))
					end

					dashSectionVFX.Parent = folder
					_G.customEmit(dashSectionVFX)
					spawnDashFlash(character.PrimaryPart.CFrame, hakiColor)

					-- Fire server + FOV punch for local player
					if remote and isLocal then
						hrp.Anchored = true
						remote:FireServer(hrp.CFrame)

						_G.tween(workspace.CurrentCamera, { 0.05, "Quad", Enum.EasingDirection.Out, 0, true, 0 }, {
							FieldOfView = 90
						})

						local zoomVFX = script.Move6.cameraZoom:Clone()
						zoomVFX.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.75)
						zoomVFX.Parent = workspace.Effects

						local startTime = tick()
						local zoomConnection
						zoomConnection = game:GetService("RunService").RenderStepped:Connect(function()
							zoomVFX.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -0.75)
							if tick() - startTime >= 3 then
								zoomConnection:Disconnect()
								_G.destroy(zoomVFX, 3)
							end
						end)
						_G.customEmit(zoomVFX)
					end

					_G.PlaySound(character.PrimaryPart, script["Audio/3ssDaisenSekaiDash"]).Parent = character.PrimaryPart

					task.wait(0.1)
					task.delay(0.7, function()
						cleanupBladeTrails(bladeTrails)
						startupAnim:Stop()
					end)

					if isLocal then
						task.wait(0.7)
						if not character:FindFirstChild("GrabTag") then
							hrp.Anchored = false
						end
					end

					if not isCutscene then
						FALLBACK_TIMEOUT = 4
					end
				end)
			end)
		end)

		-- Fallback cleanup if SpinStart never fires
		task.delay(FALLBACK_TIMEOUT, function()
			spinConnection:Disconnect()
			_G.destroy(folder, 2)
		end)
	end
end

return DaisenSekaiEffect