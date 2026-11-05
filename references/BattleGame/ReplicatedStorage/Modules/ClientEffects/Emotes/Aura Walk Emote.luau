-- ModuleScript:
-- ReplicatedStorage.Modules.ClientEffects.Emotes["Aura Walk Emote"]

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local CollectionService = game:GetService("CollectionService")
local Lighting = game:GetService("Lighting")

local localPlayer = Players.LocalPlayer
local assets = assert(
	script:WaitForChild("AuraWalkAssets", 10),
	"Put AuraWalkAssets under this ModuleScript"
)

local TAG = "AuraWalkActive"
local MAX_DISTANCE = 160

local SCREEN_OFFSET = Vector3.new(4.5, 3, 0)
local SCREEN_SIZE = Vector3.new(6, 4.5, 0.05)
local AFTERIMAGE_COLOR = Color3.fromRGB(120, 255, 235)

local ENABLE_PRESSURE = true
local ENABLE_COLOR_CORRECTION = true
local ENABLE_AFTERIMAGES = true

-- ReAura's lighting, applied locally to the emoting player only.
local EMOTE_LIGHTING = {
	-- ReAura is Brightness 1 / Exposure 0 / Ambient 115,108,92; lifted so it isn't as dark.
	Brightness = 2.5,
	ClockTime = 6,
	Ambient = Color3.fromRGB(150, 141, 120),
	OutdoorAmbient = Color3.fromRGB(160, 152, 145),
	ExposureCompensation = 0.4,
	EnvironmentDiffuseScale = 0.5,
	EnvironmentSpecularScale = 0.5,
	ShadowSoftness = 0.2,
	ColorShift_Top = Color3.new(0, 0, 0),
	ColorShift_Bottom = Color3.new(0, 0, 0),
	LightingStyle = Enum.LightingStyle.Realistic,
}

local EMOTE_ATMOSPHERE = {
	Density = 0.5,
	Offset = 0.75,
	Glare = 1,
	Haze = 2,
	Color = Color3.fromRGB(90, 77, 48),
	Decay = Color3.fromRGB(40, 26, 6),
}

local EMOTE_SKY = {
	SkyboxBk = "rbxassetid://16902383880",
	SkyboxDn = "rbxassetid://16902385467",
	SkyboxFt = "rbxassetid://16902387636",
	SkyboxLf = "rbxassetid://16902389596",
	SkyboxRt = "rbxassetid://16902391619",
	SkyboxUp = "rbxassetid://16902393708",
	CelestialBodiesShown = false,
	SunAngularSize = 21,
	MoonAngularSize = 11,
	StarCount = 3000,
}

local watches = {}
local active = {}

-- JJS's material-based footstep sounds.
local footstepIds = {
	Plastic = "5761648082",
	SmoothPlastic = "5761648082",
	Slate = "5639243489",
	Concrete = "5639243489",
	Brick = "5639243489",
	Cobblestone = "5639243489",
	Fabric = "619083295",
	Glass = "3437778169",
	Metal = "5639245164",
	DiamondPlate = "5639245590",
	Wood = "5632735811",
	WoodPlanks = "5632735811",
	Grass = "5639244517",
	Ground = "5639243992",
	Sand = "5639245918",
	Snow = "7437372937",
}

local function alive(s)
	return not s.dead
		and active[s.character] == s
		and s.character:GetAttribute("AuraWalkSession") == s.token
end

local function keep(s, object)
	table.insert(s.objects, object)
	return object
end

local function visualPart(part)
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.CastShadow = false
	part.Massless = true
end

local function cleanPartCopy(part)
	local copy = part:Clone()
	if not copy then return nil end

	for _, child in ipairs(copy:GetChildren()) do
		if not (
			child:IsA("DataModelMesh")
				or child:IsA("Decal")
				or child:IsA("Texture")
				or child:IsA("SurfaceAppearance")
			) then
			child:Destroy()
		end
	end

	visualPart(copy)
	copy.LocalTransparencyModifier = 0

	return copy
end

local function stop(s)
	if not s or s.dead then return end
	s.dead = true

	if active[s.character] == s then
		active[s.character] = nil
	end

	for _, connection in ipairs(s.connections) do
		connection:Disconnect()
	end

	if s.markerConnection then
		s.markerConnection:Disconnect()
	end

	if s.restoreLighting then
		s.restoreLighting()
		s.restoreLighting = nil
	end

	if s.stopAutoWalk then
		s.stopAutoWalk()
		s.stopAutoWalk = nil
	end

	for sound, volume in pairs(s.mutedSounds) do
		if sound.Parent and sound.Volume == 0 then
			sound.Volume = volume
		end
	end

	for _, object in ipairs(s.objects) do
		object:Destroy()
	end
end

local function addBodyAura(s)
	local model = assets.ReAura.Aura:Clone()
	keep(s, model)

	-- The template welds its limbs to its Torso. Combined with the per-limb
	-- welds below, that rigidly locks the real limbs and kills the animation.
	for _, joint in ipairs(model:GetDescendants()) do
		if joint:IsA("JointInstance") or joint:IsA("WeldConstraint") then
			joint:Destroy()
		end
	end

	for _, limbTemplate in ipairs(model:GetChildren()) do
		if limbTemplate:IsA("BasePart") then
			local limb = s.character:FindFirstChild(limbTemplate.Name)

			if limb and limb:IsA("BasePart") then
				visualPart(limbTemplate)
				limbTemplate.Anchored = false
				limbTemplate.Transparency = 1
				limbTemplate.CFrame = limb.CFrame

				local weld = Instance.new("WeldConstraint")
				weld.Part0 = limb
				weld.Part1 = limbTemplate
				weld.Parent = limbTemplate
			else
				limbTemplate:Destroy()
			end
		end
	end

	model.Parent = s.container
	s.emitters = {}

	for _, emitter in ipairs(model:GetDescendants()) do
		if emitter:IsA("ParticleEmitter") then
			table.insert(s.emitters, {
				object = emitter,
				rate = emitter.Rate,
				enabled = emitter.Enabled,
			})
		end
	end
end

local function addScreen(s)
	local gui = keep(s, assets.AuraMonsterUI:Clone())
	gui.Name = "AuraWalkScreen_" .. s.token
	gui.ResetOnSpawn = false

	local surface = assert(
		gui:FindFirstChildWhichIsA("SurfaceGui", true),
		"Missing SurfaceGui"
	)

	local viewport = assert(
		surface:FindFirstChildWhichIsA("ViewportFrame", true),
		"Missing ViewportFrame"
	)

	-- Keep the UI styling, replacing its dummy with this player's appearance.
	for _, child in ipairs(viewport:GetChildren()) do
		if child:IsA("WorldModel") or child:IsA("Camera") then
			child:Destroy()
		end
	end

	local world = Instance.new("WorldModel")
	world.Parent = viewport

	local avatar = Instance.new("Model")
	avatar.Name = "LivePortrait"
	avatar.Parent = world

	local portraitHumanoid = Instance.new("Humanoid")
	portraitHumanoid.DisplayDistanceType =
		Enum.HumanoidDisplayDistanceType.None
	portraitHumanoid.Parent = avatar

	s.portraitParts = {}

	local function addPart(original, parent)
		local copy = cleanPartCopy(original)
		if not copy then return end

		copy.CFrame = s.root.CFrame:ToObjectSpace(original.CFrame)
		copy.Parent = parent

		table.insert(s.portraitParts, {
			source = original,
			copy = copy,
		})
	end

	for _, child in ipairs(s.character:GetChildren()) do
		if child:IsA("BasePart") then
			addPart(child, avatar)

		elseif child:IsA("Clothing")
			or child:IsA("ShirtGraphic")
			or child:IsA("BodyColors")
			or child:IsA("CharacterMesh") then

			child:Clone().Parent = avatar
		end
	end

	-- Accessories aren't always direct children (this game parents them
	-- under FakeHead), so search the whole character.
	for _, item in ipairs(s.character:GetDescendants()) do
		if item:IsA("Accessory") then
			local handle = item:FindFirstChild("Handle")

			if handle and handle:IsA("BasePart") then
				local accessory = Instance.new("Accessory")
				accessory.Name = item.Name
				accessory.Parent = avatar

				addPart(handle, accessory)
			end
		end
	end

	local camera = Instance.new("Camera")
	camera.FieldOfView = 10
	camera.CFrame = CFrame.lookAt(
		Vector3.new(0, 1.5, -20),
		Vector3.new(0, 1.5, 0)
	)
	camera.Parent = viewport
	viewport.CurrentCamera = camera

	local panel = Instance.new("Part")
	panel.Name = "AuraWalkScreenSurface"
	visualPart(panel)

	panel.Size = SCREEN_SIZE
	panel.Transparency = 1
	panel.CFrame = s.root.CFrame * CFrame.new(SCREEN_OFFSET)
	panel.Parent = s.container

	s.panel = panel
	s.surface = surface

	surface.Face = Enum.NormalId.Front
	surface.Adornee = panel
	surface.AlwaysOnTop = false
	surface.MaxDistance = MAX_DISTANCE

	gui.Parent = localPlayer:FindFirstChildOfClass("PlayerGui")
end

local function addPressure(s)
	if s.character ~= localPlayer.Character then return end

	if ENABLE_PRESSURE then
		local pressure = keep(s, assets.ReAura.Pressure:Clone())
		visualPart(pressure)

		pressure.Transparency = 1
		pressure.Parent = s.container

		s.pressure = pressure
		s.pressureEmitters = {}

		for _, emitter in ipairs(pressure:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				table.insert(s.pressureEmitters, {
					object = emitter,
					enabled = emitter.Enabled,
				})

				emitter.Enabled = false
			end
		end
	end

	if ENABLE_COLOR_CORRECTION then
		local correction = keep(
			s,
			assets.AuraColorCorrection:Clone()
		)

		correction.Name = "AuraWalkColor_" .. s.token
		-- On for the whole emote, not just while sprinting.
		correction.Enabled = true
		correction.Parent = Lighting

		s.correction = correction
	end
end

local function addLighting(s)
	if s.character ~= localPlayer.Character then return end

	local savedProps = {}
	for property, value in pairs(EMOTE_LIGHTING) do
		local ok, old = pcall(function() return Lighting[property] end)
		if ok and pcall(function() Lighting[property] = value end) then
			savedProps[property] = old
		end
	end

	-- Pull the place's own sky/atmosphere/bloom/sunrays out locally and put
	-- them back on stop. Server-side Lighting is never touched.
	local hidden = {}
	for _, child in ipairs(Lighting:GetChildren()) do
		if child:IsA("Sky") or child:IsA("Atmosphere")
			or child:IsA("BloomEffect") or child:IsA("SunRaysEffect") then
			table.insert(hidden, child)
			child.Parent = nil
		end
	end

	local atmosphere = keep(s, Instance.new("Atmosphere"))
	for property, value in pairs(EMOTE_ATMOSPHERE) do
		atmosphere[property] = value
	end
	atmosphere.Parent = Lighting

	local sky = keep(s, Instance.new("Sky"))
	for property, value in pairs(EMOTE_SKY) do
		sky[property] = value
	end
	sky.Parent = Lighting

	s.restoreLighting = function()
		atmosphere:Destroy()
		sky:Destroy()
		for property, value in pairs(savedProps) do
			pcall(function() Lighting[property] = value end)
		end
		for _, child in ipairs(hidden) do
			pcall(function() child.Parent = Lighting end)
		end
	end
end

-- Keeps the emoting player walking forward. Movement input still steers;
-- when it's released they carry on in whatever direction they now face.
local function addAutoWalk(s)
	if s.character ~= localPlayer.Character then return end

	local controls
	pcall(function()
		controls = require(
			localPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
		):GetControls()
	end)

	local bindName = "AuraWalkAutoWalk_" .. s.token

	-- Runs right after the ControlModule's own Move so it overrides idle input.
	RunService:BindToRenderStep(bindName, Enum.RenderPriority.Input.Value + 1, function()
		if not alive(s) then return end

		local input = controls and controls:GetMoveVector() or Vector3.zero
		if input.Magnitude > 0.05 then return end

		local look = s.root.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		if flat.Magnitude > 0.01 then
			s.humanoid:Move(flat.Unit, false)
		end
	end)

	s.stopAutoWalk = function()
		RunService:UnbindFromRenderStep(bindName)
		pcall(function() s.humanoid:Move(Vector3.zero, false) end)
	end
end

local function afterimage(s)
	local ghost = Instance.new("Model")
	ghost.Name = "AuraWalkAfterimage"

	for _, part in ipairs(s.character:GetChildren()) do
		if part:IsA("BasePart")
			and part.Name ~= "HumanoidRootPart"
			and part.Transparency < 1 then

			local copy = cleanPartCopy(part)

			if copy then
				for _, child in ipairs(copy:GetChildren()) do
					if child:IsA("SpecialMesh") then
						child.TextureId = ""
					elseif not child:IsA("DataModelMesh") then
						child:Destroy()
					end
				end

				if copy:IsA("MeshPart") then
					copy.TextureID = ""
				end

				copy.Material = Enum.Material.Neon
				copy.Color = AFTERIMAGE_COLOR
				copy.Transparency = 0.7
				copy.CFrame = part.CFrame
				copy.Parent = ghost

				TweenService:Create(
					copy,
					TweenInfo.new(
						0.45,
						Enum.EasingStyle.Quad,
						Enum.EasingDirection.Out
					),
					{ Transparency = 1 }
				):Play()
			end
		end
	end

	ghost.Parent = s.container
	Debris:AddItem(ghost, 0.5)
end

local function playStep(s, side)
	if not alive(s) or (side ~= "L" and side ~= "R") then
		return
	end

	if os.clock() - (s.lastStep or 0) < 0.08 then
		return
	end

	s.lastStep = os.clock()

	local camera = workspace.CurrentCamera
	if not camera
		or (camera.CFrame.Position - s.root.Position).Magnitude > MAX_DISTANCE then
		return
	end

	local foot = s.character:FindFirstChild(
		side == "L" and "Left Leg" or "Right Leg"
	)
	if not foot then return end

	local origin = (
		foot.CFrame * CFrame.new(0, -foot.Size.Y / 2, 0)
	).Position + Vector3.new(0, 0.75, 0)

	local direction = Vector3.new(0, -4, 0)
	local params = RaycastParams.new()
	params.IgnoreWater = false

	-- Check the animated platforms before checking the environment.
	local prop = s.character:FindFirstChild("AuraWalkPlatforms")
	local hit

	if prop then
		params.FilterType = Enum.RaycastFilterType.Include
		params.FilterDescendantsInstances = { prop }

		hit = workspace:Raycast(origin, direction, params)
	end

	if not hit then
		params.FilterType = Enum.RaycastFilterType.Exclude

		local ignore = { s.character, s.container }
		local live = workspace:FindFirstChild("Live")
		local thrown = workspace:FindFirstChild("Thrown")

		if live then table.insert(ignore, live) end
		if thrown then table.insert(ignore, thrown) end

		params.FilterDescendantsInstances = ignore
		hit = workspace:Raycast(origin, direction, params)
	end

	if not hit or hit.Material == Enum.Material.Air then
		return
	end

	local anchor = Instance.new("Part")
	visualPart(anchor)

	anchor.Name = "AuraWalkFootstep"
	anchor.Size = Vector3.new(0.1, 0.1, 0.1)
	anchor.Transparency = 1
	anchor.Position = hit.Position
	anchor.Parent = s.container

	local sound = Instance.new("Sound")
	local water = hit.Material == Enum.Material.Water

	sound.SoundId = water and assets.WaterSound.SoundId
		or "rbxassetid://"
		.. (footstepIds[hit.Material.Name] or footstepIds.Plastic)

	sound.Volume = 0.5
	sound.PlaybackSpeed = side == "L" and 0.9 or 1
	sound.RollOffMinDistance = 8
	sound.RollOffMaxDistance = 65
	sound.PlayOnRemove = false
	sound.Parent = anchor
	sound:Play()

	Debris:AddItem(anchor, 5)

	if water then
		local splash = assets.WaterSplash:Clone()
		visualPart(splash)

		splash.CFrame = CFrame.lookAt(
			hit.Position + hit.Normal * 0.1,
			hit.Position + hit.Normal
		) * CFrame.Angles(-math.pi / 2, 0, 0)

		splash.Parent = s.container

		for _, emitter in ipairs(splash:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Enabled = false

				emitter:Emit(
					emitter.Name == "Ring" and 3
						or emitter.Name == "Splash" and 7
						or emitter:GetAttribute("EmitCount")
						or 1
				)
			end
		end

		Debris:AddItem(splash, 4)
	end
end

local function bindTrack(s, track)
	local animation = track.Animation

	if not animation
		or animation.AnimationId
		~= s.character:GetAttribute("AuraWalkAnimationId") then
		return
	end

	if s.track == track and s.markerConnection then
		return
	end

	if s.markerConnection then
		s.markerConnection:Disconnect()
	end

	s.track = track
	s.markerConnection = track:GetMarkerReachedSignal("Step"):Connect(
		function(value)
			playStep(s, value)
		end
	)
end

local function refreshVisibility(s, visible, sprinting)
	local key = tostring(visible) .. tostring(sprinting)
	if s.visibilityKey == key then return end

	s.visibilityKey = key
	s.surface.Enabled = visible

	for _, item in ipairs(s.emitters) do
		item.object.Enabled = visible and item.enabled
		item.object.Rate = item.rate * (sprinting and 1 or 0.45)
	end

	for _, item in ipairs(s.pressureEmitters or {}) do
		item.object.Enabled = visible and sprinting and item.enabled

		if not item.object.Enabled then
			item.object:Clear()
		end
	end

end

local function setup(s)
	s.root = s.character:WaitForChild("HumanoidRootPart", 5)
	s.humanoid = s.character:FindFirstChildOfClass("Humanoid")

	if not alive(s) then return end

	assert(
		s.root and s.humanoid,
		"Aura Walk character is missing its root/humanoid"
	)

	local animator = s.humanoid:WaitForChild("Animator", 5)
	if not alive(s) then return end

	assert(animator, "Aura Walk character is missing its Animator")

	s.container = keep(s, Instance.new("Folder"))
	s.container.Name = "AuraWalkFX_" .. s.token
	s.container.Parent = workspace

	addBodyAura(s)
	addScreen(s)
	addPressure(s)
	addLighting(s)
	addAutoWalk(s)

	table.insert(
		s.connections,
		animator.AnimationPlayed:Connect(function(track)
			bindTrack(s, track)
		end)
	)

	for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
		bindTrack(s, track)
	end

	local ghostTime = 0
	local scanTime = 0

	table.insert(
		s.connections,
		RunService.PreRender:Connect(function(dt)
			if not alive(s)
				or not s.root.Parent
				or s.humanoid.Health <= 0 then

				stop(s)
				return
			end

			local camera = workspace.CurrentCamera
			if not camera then return end

			local distance = (
				camera.CFrame.Position - s.root.Position
			).Magnitude

			local visible = distance <= MAX_DISTANCE
			-- Full effects (pressure, afterimages, aura rate) for the whole emote.
			local sprinting = true

			refreshVisibility(s, visible, sprinting)

			-- Silence the default running loop during marker-driven footsteps.
			local running = s.root:FindFirstChild("Running")

			if running and running:IsA("Sound") then
				if s.mutedSounds[running] == nil then
					s.mutedSounds[running] = running.Volume
				end

				running.Volume = 0
			end

			scanTime += dt

			if scanTime >= 0.25 then
				scanTime = 0

				if not s.track or not s.track.IsPlaying then
					for _, track in ipairs(
						animator:GetPlayingAnimationTracks()
						) do
						bindTrack(s, track)
					end
				end
			end

			if not visible then return end

			local position =
				s.root.CFrame:PointToWorldSpace(SCREEN_OFFSET)

			if (camera.CFrame.Position - position).Magnitude > 0.01 then
				s.panel.CFrame = CFrame.lookAt(
					position,
					camera.CFrame.Position
				)
			end

			-- Mirror the character's current pose into the portrait.
			for _, pair in ipairs(s.portraitParts) do
				if pair.source.Parent then
					pair.copy.CFrame = s.root.CFrame:ToObjectSpace(
						pair.source.CFrame
					)
					pair.copy.Transparency = pair.source.Transparency
				end
			end

			if s.pressure then
				s.pressure.CFrame = camera.CFrame
			end

			ghostTime += dt

			if ENABLE_AFTERIMAGES and sprinting and ghostTime >= 0.12 then
				ghostTime = 0
				afterimage(s)
			end
		end)
	)
end

local function reconcile(character)
	local token = character:GetAttribute("AuraWalkSession")
	local current = active[character]

	if current and current.token == token then return end
	stop(current)

	if type(token) ~= "string"
		or not CollectionService:HasTag(character, TAG) then
		return
	end

	local s = {
		character = character,
		token = token,
		objects = {},
		connections = {},
		mutedSounds = {},
	}

	active[character] = s

	task.spawn(function()
		local ok, message = xpcall(function()
			setup(s)
		end, debug.traceback)

		if not ok then
			stop(s)
			warn("[Aura Walk] " .. tostring(message))
		end
	end)
end

local function unwatch(character)
	stop(active[character])

	local connections = watches[character]
	if connections then
		for _, connection in ipairs(connections) do
			connection:Disconnect()
		end

		watches[character] = nil
	end
end

local function watch(character)
	if not character:IsA("Model") then return end

	if watches[character] then
		reconcile(character)
		return
	end

	watches[character] = {
		character:GetAttributeChangedSignal("AuraWalkSession"):Connect(
			function()
				reconcile(character)
			end
		),

		character.AncestryChanged:Connect(function()
			if not character:IsDescendantOf(workspace) then
				unwatch(character)
			end
		end),
	}

	reconcile(character)
end

-- Discover active emotes, including late joiners and streamed-in characters.
CollectionService:GetInstanceAddedSignal(TAG):Connect(watch)
CollectionService:GetInstanceRemovedSignal(TAG):Connect(unwatch)

for _, character in ipairs(CollectionService:GetTagged(TAG)) do
	watch(character)
end

-- Called by your existing ClientEffects dispatcher.
return function(data)
	if type(data) ~= "table"
		or typeof(data.Character) ~= "Instance" then
		return
	end

	local s = active[data.Character]

	if data.Status == "Stop" and s and s.token == data.Session then
		stop(s)
	end
end