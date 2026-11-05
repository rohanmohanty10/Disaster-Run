

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local VFX = {}

local IS_CLIENT = RunService:IsClient()
local RNG = Random.new()

-- Visuals folder: workspace.World.Visuals
local function getVisualsFolder()
	local world = workspace:FindFirstChild("World")
	if not world then
		world = Instance.new("Folder")
		world.Name = "World"
		world.Parent = workspace
	end

	local visuals = world:FindFirstChild("Visuals")
	if not visuals then
		visuals = Instance.new("Folder")
		visuals.Name = "Visuals"
		visuals.Parent = world
	end

	return visuals
end

-- Centralized, graphics-aware emit scaling
local function getEmitMultiplier()
	if not IS_CLIENT then
		return 1
	end
	local saved = UserSettings().GameSettings.SavedQualityLevel
	--print(
	--	"[VFX] Quality:",
	--	saved,
	--	saved.Value,
	--	"Multiplier preview:",
	--	saved == Enum.SavedQualitySetting.Automatic and 0.5 or "manual"
	--)

	-- Treat Automatic as max quality
	if saved == Enum.SavedQualitySetting.Automatic then
		return 1
	end

	local raw = tonumber(saved.Value) or 10
	local q = math.clamp(raw, 1, 10)
	local t = (q - 1) / 9

	-- 1 -> 0.25 | 10 -> 1.0
	return 0.25 + (0.75 * t)
end


function VFX.Emit(particleEmitter: ParticleEmitter, amount: number)
	if not particleEmitter or not particleEmitter:IsA("ParticleEmitter") then
		return
	end

	local mult = tonumber(getEmitMultiplier()) or 1
	local amt = tonumber(amount) or 0
	local final = math.max(0, math.floor(amt * mult + 0.5))

	--print("[VFX.Emit]", particleEmitter:GetFullName(), "amount=", amount, "mult=", mult, "final=", final)

	if final > 0 then
		particleEmitter:Emit(final)
	end
end

-- Emit for every ParticleEmitter descendant using attributes (EmitDelay, EmitCount)
--function VFX.EmitDescendants(object: Instance, count: number?)
--	if not object then
--		return
--	end

--	for _, v in ipairs({object, unpack(object:GetDescendants())}) do

--		if v:IsA("ParticleEmitter") then
--			local delayTime = v:GetAttribute("EmitDelay") or 0
--			local emitCount = count or v:GetAttribute("EmitCount") or 30

--			task.delay(delayTime, function()
--				VFX.Emit(v, final) -- (or VFX.Emit(v, emitCountNum) and let Emit compute final)

--			end)
--		end
--	end
--end

function VFX.EmitDescendants(object: Instance, overrideCount: number?)
	if not object then return end

	for _, v in ipairs({object, unpack(object:GetDescendants())}) do
		if v:IsA("ParticleEmitter") then
			local delayTime = v:GetAttribute("EmitDelay") or 0

			-- Use the emitter’s EmitCount by default (like EmitAll),
			-- allow optional override if you want.
			local baseCount = overrideCount
				or v:GetAttribute("EmitCount")
				or 30

			task.delay(delayTime, function()
				-- IMPORTANT: call your scaled emitter
				VFX.Emit(v, baseCount)
			end)
		end
	end
end



function VFX.EmitAll(Parent: Instance, Descendants : boolean) --// Emits all ParticleEmitters parented to (Parent) using their EmitCount attribute
	if not Descendants then
		for _, v in Parent:GetChildren() do
			if v:IsA("ParticleEmitter") and v:GetAttribute("EmitCount") then
				task.delay(v:GetAttribute("EmitDelay"), function()
					v:Emit(v:GetAttribute("EmitCount"))
				end)
			end
		end
	else
		for _, v in Parent:GetDescendants() do
			if v:IsA("ParticleEmitter") and v:GetAttribute("EmitCount") then
				task.delay(v:GetAttribute("EmitDelay"), function()
					v:Emit(v:GetAttribute("EmitCount"))
				end)
			end
		end
	end
end

function VFX.DisableDescendants(object: Instance, destroy: boolean?)
	if not object then
		return
	end

	for _, v in ipairs(object:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = false
			if destroy ~= false then
				-- Lifetime is NumberRange; use Max as worst-case
				local maxLife = (typeof(v.Lifetime) == "NumberRange") and v.Lifetime.Max or 0
				task.delay(maxLife + 2, function()
					if v and v.Parent then
						v:Destroy()
					end
				end)
			end
		end
	end
end

function VFX.EnableTime(target, enabled, timeout) --part, true/false, time
	local fallbackTimeout = timeout or 1

	if target:IsA("ParticleEmitter") then
		local duration = target:GetAttribute("EmitDuration")
		target.Enabled = enabled
		task.delay(fallbackTimeout or duration, function()
			target.Enabled = false
		end)
	else
		for _, child in target:GetDescendants() do
			if child:IsA("ParticleEmitter") or child:IsA("Trail") or child:IsA("Beam") then
				task.spawn(function()
					local duration = child:GetAttribute("EmitDuration")
					child.Enabled  = enabled
					task.delay(fallbackTimeout or duration, function()
						child.Enabled = false
					end)
				end)
			end
		end
	end
end

function VFX.EnableDescendants(object: Instance)
	if not object then
		return
	end

	for _, v in ipairs(object:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			v.Enabled = true
		end
	end
end



function VFX.DisableTrails(object: Instance, destroy: boolean?)
	if not object then
		return
	end

	for _, v in ipairs(object:GetDescendants()) do
		if v:IsA("Trail") then
			v.Enabled = false
			if destroy ~= false then
				task.delay(v.Lifetime, function()
					if v and v.Parent then
						v:Destroy()
					end
				end)
			end
		end
	end
end

function VFX.EnableTrails(object: Instance)
	if not object then
		return
	end

	for _, v in ipairs(object:GetDescendants()) do
		if v:IsA("Trail") then
			v.Enabled = true
		end
	end
end


function VFX.weld(a: BasePart, b: BasePart)
	if not a or not b then
		return nil
	end
	local weldc = Instance.new("WeldConstraint")
	weldc.Part0 = a
	weldc.Part1 = b
	weldc.Parent = a
	return weldc
end

-- Match ground color for particle emitters (uses RaycastParams; ignores Visuals folder)
function VFX.MatchGround(object: Instance, groundResult: RaycastResult?)
	if not object then
		return nil
	end

	local basePart = object
	if object:IsA("Attachment") then
		basePart = object.Parent
	end
	if not basePart or not basePart:IsA("BasePart") then
		return nil
	end

	if not groundResult then
		local visuals = getVisualsFolder()
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = { visuals }
		params.IgnoreWater = true

		groundResult = workspace:Raycast(basePart.Position, Vector3.new(0, -15, 0), params)
	end

	if groundResult and groundResult.Instance then
		for _, emitter in ipairs(object:GetDescendants()) do
			if emitter:IsA("ParticleEmitter") then
				emitter.Color = ColorSequence.new(groundResult.Instance.Color)
			end
		end
	end

	return groundResult
end

function VFX.ToggleAll(Parent: Instance, Value: boolean, Switch: boolean, IncludeBeams: boolean, Descendants : boolean) --// Toggles the Enabled property ParticleEmitters (and Beams if IncludeBeams is true) in (Parent) to (Value), or reverses the value if (Switch)
	if not Descendants then  		
		for _, v in Parent:GetChildren() do
			if v:IsA("ParticleEmitter") then
				if Switch then
					v.Enabled = not v.Enabled
				else
					v.Enabled = Value
				end
			end
			if IncludeBeams and (v:IsA("Beam") or v:IsA("Trail")) then
				if Switch then
					v.Enabled = not v.Enabled
				else
					v.Enabled = Value
				end
			end
		end
	else
		for _, v in Parent:GetDescendants() do
			if v:IsA("ParticleEmitter") then
				if Switch then
					v.Enabled = not v.Enabled
				else
					v.Enabled = Value
				end
			end
			if IncludeBeams and (v:IsA("Beam") or v:IsA("Trail")) then
				if Switch then
					v.Enabled = not v.Enabled
				else
					v.Enabled = Value
				end
			end
		end
	end
end

-- add alongside your other VFX functions
function VFX.PlayImpactFrames(container, fps, sequenceName, reverse)
	if not (container and fps) then return end

	-- if sequenceName is given, find that child folder; otherwise use container itself
	local sequence = sequenceName and container:FindFirstChild(sequenceName) or container
	if not sequence then return end

	local frameCount  = #sequence:GetChildren()
	local totalFrames = frameCount

	-- respect photosensitive mode if the game has it
	pcall(function()
		if Players.LocalPlayer.gameplaySettings["Photosensitive Mode"].Value then
			totalFrames = 0
		end
	end)

	if totalFrames <= 0 then return end

	container.Enabled = true

	local msPerFrame = totalFrames / fps * 1000
	local startTime  = tick()
	local conn       = nil

	-- set up all labels
	for _, label in sequence:GetChildren() do
		if label:IsA("ImageLabel") then
			label.Visible  = not reverse
			label.Position = UDim2.fromScale(0.5, 0.5)
			label.ZIndex   = frameCount - (tonumber(label.Name) or 0)
		end
	end

	conn = RunService.RenderStepped:Connect(function()
		local elapsed      = (tick() - startTime) * 1000 / msPerFrame * totalFrames
		local currentFrame = math.floor(elapsed) + 1

		if currentFrame > totalFrames then
			-- sequence finished: move labels off-screen
			if conn then conn:Disconnect(); conn = nil end
			for _, label in sequence:GetChildren() do
				if label:IsA("ImageLabel") then
					label.Position = UDim2.fromScale(2, 0.5)
					label.Visible  = true
				end
			end
			return
		end

		-- show/hide labels based on current frame
		for _, label in sequence:GetChildren() do
			if label:IsA("ImageLabel") then
				label.Visible = currentFrame <= tonumber(label.Name)
			end
		end

		if currentFrame <= 1 then
			local frame = sequence:FindFirstChild(tostring(currentFrame))
			if not frame then return end
			frame.Visible = true
		else
			local frame = sequence:FindFirstChild(tostring(currentFrame - 1))
			if not frame then return end
			frame.Visible = false
		end

		if reverse then
			local frame = sequence:FindFirstChild(tostring(currentFrame + 1))
			if not frame then return end
			frame.Visible = true
		end
	end)
end


function VFX.EmitEffects(Folder: Folder, Parent: Instance, WorldPosition: (CFrame | Vector3)?, NormalPosition: (CFrame | Vector3)?)
	local UndefinedTimeout = 60
	local ToCreateThread = false
	local Thread
	local Lifetime = 0
	local Items = {}

	local Attachment = Instance.new("Attachment")

	local function UpdateLifetime(Length: number)
		if Thread then
			task.cancel(Thread)
		end
		Lifetime = math.max(Lifetime, Length)
		if ToCreateThread then
			Thread = task.delay(Lifetime, Attachment.Destroy, Attachment)
		end
	end

	local function PlaySound(Sound: Sound, OnPlayed: ((length: number) -> ())?)
		local WasLoaded = Sound.IsLoaded
		local function Play()
			if OnPlayed then
				OnPlayed(Sound.TimeLength)
			end
			Sound:Play()
		end
		if not WasLoaded then
			Sound.Loaded:Once(Play)
		else
			Play()
		end
		return WasLoaded
	end

	if WorldPosition ~= nil then
		if typeof(WorldPosition) == "Vector3" then
			Attachment.WorldPosition = WorldPosition
		elseif typeof(WorldPosition) == "CFrame" then
			Attachment.WorldCFrame = WorldPosition
		end
	elseif NormalPosition ~= nil then
		if typeof(NormalPosition) == "Vector3" then
			Attachment.Position = NormalPosition
		elseif typeof(NormalPosition) == "CFrame" then
			Attachment.CFrame = NormalPosition
		end
	end

	Attachment.Parent = Parent

	for _, Item in ipairs(Folder:GetChildren()) do
		if Item:IsA("Folder") and Item.Name == "Random" then
			local Children = Item:GetChildren()
			local ChosenItem = Children[math.random(1, #Children)]:Clone()
			ChosenItem.Name = "RandomSound"
			ChosenItem.Parent = Attachment

			local WasLoaded = PlaySound(ChosenItem, UpdateLifetime)
			if not WasLoaded then
				UpdateLifetime(UndefinedTimeout)
			end

			Items[ChosenItem] = true

		elseif Item:IsA("ParticleEmitter") then
			local NewItem = Item:Clone()
			NewItem.Name = "Particle"
			NewItem.Parent = Attachment

			local EmitDuration = NewItem:GetAttribute("EmitDuration")

			if EmitDuration ~= nil and EmitDuration ~= 0 then
				NewItem.Enabled = true
				task.delay(EmitDuration, function()
					NewItem.Enabled = false
				end)
				UpdateLifetime(
					(EmitDuration + (NewItem.Lifetime.Min + NewItem.Lifetime.Max)) / NewItem.TimeScale
				)
			else
				local EmitCount = NewItem:GetAttribute("EmitCount") or 1
				local EmitDelay = NewItem:GetAttribute("EmitDelay") or 0

				if EmitDelay ~= 0 then
					task.delay(EmitDelay, function()
						VFX.Emit(NewItem, EmitCount)
					end)
					UpdateLifetime(
						(EmitDelay + (NewItem.Lifetime.Min + NewItem.Lifetime.Max)) / NewItem.TimeScale
					)
				else
					VFX.Emit(NewItem, EmitCount)
					UpdateLifetime(
						(NewItem.Lifetime.Min + NewItem.Lifetime.Max) / NewItem.TimeScale
					)
				end
			end

			Items[NewItem] = true

		elseif Item:IsA("Sound") then
			local NewItem = Item:Clone()
			NewItem.Name = "Sound"
			NewItem.Parent = Attachment

			local WasLoaded = PlaySound(NewItem, UpdateLifetime)
			if not WasLoaded then
				UpdateLifetime(UndefinedTimeout)
			end

			Items[NewItem] = true
		end
	end

	ToCreateThread = true
	UpdateLifetime(Lifetime)

	return Items, Attachment
end


--was : before
function VFX.TaskDebris(Object: Instance, Lifetime: number) --// Destroys (Object) after (Lifetime) seconds using the task library
	task.delay(Lifetime, function() Object:Destroy() end)
end



return VFX
