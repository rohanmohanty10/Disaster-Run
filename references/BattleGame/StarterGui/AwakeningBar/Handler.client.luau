--// Awakening Bar - Jujutsu Shenanigans style \\--
--
-- A port of the Juju ultimate HUD (PlayerGui.Main.Controls.Ultimate) onto this
-- game's data. Structure and motion are theirs; the values it reads are ours.
--
-- No art anywhere -- every piece is a Frame with a UIGradient and a 2px border,
-- so reskinning is just colour values and nothing needs uploading.
--
-- The fill does not tween. Every frame it eases a fraction of the way toward
-- its target:
--
--     scale += (target - scale) * (10 * dt)
--
-- which is why a Juju bar keeps drifting toward the value instead of snapping
-- when the number changes. Keep the 10; it is the whole feel of the thing.
--
-- Run this OR the Heroes handler, never both -- each builds its own bar.

--// Services \\--

local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local Debris = game.Debris

--// Modules \\--

local InfoModule = require(RS:WaitForChild("Info", 5))

--// Remotes \\--

local Remotes = RS.Remotes

--// Layout \\--

-- Bar and title share this, so widening the bar widens the title with it.
-- Juju's own is 300.
local BAR_WIDTH    = 330

-- How far the bar sits above the bottom of the screen, in pixels. This is the
-- height knob: LOWER it to drop the bar, raise it to lift it. Juju's own is 90.
-- The title and the timer are positioned relative to it, so all three move
-- together and keep their spacing.
local LIFT         = 85

local BAR_POS      = UDim2.new(0.5, 0, 1, -LIFT)
local BAR_SIZE     = UDim2.new(0, BAR_WIDTH, 0, 20)
local BAR_BG       = Color3.fromRGB(255, 255, 255)
local BAR_ALPHA    = 0.5
local BAR_BORDER   = 2

local TITLE_POS    = UDim2.new(0.5, 0, 1, -LIFT - 25)   -- 25px above the bar
local TITLE_SIZE   = UDim2.new(0, BAR_WIDTH, 0, 25)

local TIME_POS     = UDim2.new(0.5, 0, 1, -LIFT + 10)   -- 10px lower than the bar
local TIME_SIZE    = UDim2.new(1, 0, 0.1, 0)

local FILL2_HEIGHT = 4

--// Gradients - the real sequences from the Juju place \\--
--
-- The bar's own vertical fade. Solid along the top edge, roughly half
-- transparent by the bottom. Layered on top of BackgroundTransparency 0.5,
-- this is what stops the bar reading as a flat white slab -- without it the
-- frame is uniform and looks bland, which is exactly what a bare UIGradient
-- (white to white, no transparency) gives you.
local BAR_FADE = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.773006, 0.502762),
	NumberSequenceKeypoint.new(1, 0.530387),
})

-- The fill's own ramp runs the moveset colour into white along its height.
-- updateUlt rebuilds the colour half per moveset; this is the default.
local FILL_TOP = Color3.fromRGB(0, 170, 255)

-- The paired-resource strip fades in from its top edge.
local FILL2_FADE = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.5, 0),
	NumberSequenceKeypoint.new(1, 0),
})

-- Hidden positions, and the two easing profiles the source uses each way.
local TITLE_HIDDEN = UDim2.new(0.5, 0, 1, 50)
local BAR_HIDDEN   = UDim2.new(0.5, 0, 1, 75)

local HIDE_TIME  = 0.9
local SHOW_TIME  = 1.5
local SHOW_STYLE = Enum.EasingStyle.Exponential
local SHOW_DIR   = Enum.EasingDirection.Out

--// Type \\--
--
-- Heroes Battlegrounds' faces: the identity text is GothamSSm Bold Italic, the
-- instruction text is the same weight upright. Juju's own font is a custom
-- upload, so this is the closer match to what you are building toward.

local TITLE_FONT  = Font.new("rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Bold, Enum.FontStyle.Italic)

-- The prompt sits in the same family of shapes as Juju's own face -- bold,
-- slightly technical, tight enough to read at 20px -- without being it. Their
-- font is a custom upload, so this is a deliberate near miss rather than a
-- copy. Swap the family below if you want a different flavour; Oswald is more
-- condensed, RobotoCondensed is plainer, Sarpanch is squarer.
local PROMPT_FONT = Font.new("rbxasset://fonts/families/TitilliumWeb.json",
	Enum.FontWeight.Bold, Enum.FontStyle.Normal)

-- Juju's prompt is black text with a WHITE outline, which is what makes it
-- readable sitting on top of the fill. The title is the other way round.
local PROMPT_TEXT      = Color3.fromRGB(0, 0, 0)
local PROMPT_STROKE    = Color3.fromRGB(255, 255, 255)
local PROMPT_THICKNESS = 1

local TITLE_TEXT       = Color3.fromRGB(255, 255, 255)
local TITLE_STROKE     = Color3.fromRGB(0, 0, 0)

--// Behaviour \\--

-- The per-frame easing factor. Higher snaps harder.
local FILL_LERP = 10

local DEFAULT_FILL = Color3.fromRGB(85, 255, 255)

--// Player \\--

local Player: Player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")

local Character = Player.Character or Player.CharacterAdded:Wait()
local AwakeningProgress: NumberValue = Player:WaitForChild("AwakeningProgress", 5)

--// Build \\--

local GUI = script.Parent

local legacy = GUI:FindFirstChild("UltimateBar")
if legacy then
	legacy.Visible = false
end

local function stroke(parent, thickness, color)
	local s = Instance.new("UIStroke")
	s.Thickness = thickness
	s.Color = color or Color3.fromRGB(0, 0, 0)
	s.Parent = parent
	return s
end

local function gradient(parent, rotation, transparency, color)
	local g = Instance.new("UIGradient")
	g.Rotation = rotation
	if transparency then
		g.Transparency = transparency
	end
	if color then
		g.Color = color
	end
	g.Parent = parent
	return g
end

local Ultimate = Instance.new("Frame")
Ultimate.Name = "Ultimate"
Ultimate.BackgroundTransparency = 1
Ultimate.Size = UDim2.fromScale(1, 1)
Ultimate.Parent = GUI

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.AnchorPoint = Vector2.new(0.5, 1)
Title.BackgroundTransparency = 1
Title.FontFace = TITLE_FONT
Title.Position = TITLE_HIDDEN
Title.Size = TITLE_SIZE
Title.Text = "?"
Title.TextColor3 = TITLE_TEXT
Title.TextScaled = true
Title.ZIndex = 1
Title.Parent = Ultimate
stroke(Title, 1, TITLE_STROKE)

local Bar = Instance.new("Frame")
Bar.Name = "Bar"
Bar.AnchorPoint = Vector2.new(0.5, 1)
Bar.BackgroundColor3 = BAR_BG
Bar.BackgroundTransparency = BAR_ALPHA
Bar.BorderSizePixel = BAR_BORDER
Bar.Position = BAR_HIDDEN
Bar.Size = BAR_SIZE
Bar.ZIndex = 1
Bar.Parent = Ultimate
gradient(Bar, 90, BAR_FADE)

local Fill = Instance.new("Frame")
Fill.Name = "Fill"
Fill.BackgroundColor3 = DEFAULT_FILL
Fill.BorderSizePixel = 0
Fill.Position = UDim2.new(0, 0, 0, 0)
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.ZIndex = 1
Fill.Parent = Bar
local FillGradient = gradient(Fill, -90, nil,
	ColorSequence.new(FILL_TOP, Color3.new(1, 1, 1)))

-- Second meter, for movesets that carry a paired resource. Hidden unless fed.
local Fill2 = Instance.new("Frame")
Fill2.Name = "Fill2"
Fill2.AnchorPoint = Vector2.new(0, 1)
Fill2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Fill2.BorderSizePixel = 0
Fill2.ClipsDescendants = true
Fill2.Position = UDim2.new(0, 0, 1, 0)
Fill2.Size = UDim2.new(0, 0, 0, FILL2_HEIGHT)
Fill2.Visible = false
Fill2.ZIndex = 2
Fill2.Parent = Bar
gradient(Fill2, 90, FILL2_FADE)

local Ready = Instance.new("Frame")
Ready.Name = "Ready"
Ready.BackgroundTransparency = 1
Ready.Size = UDim2.fromScale(1, 1)
Ready.Visible = false
Ready.ZIndex = 10
Ready.Parent = Bar

local function readyLabel(name, text)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.AnchorPoint = Vector2.new(0.5, 0.5)
	label.BackgroundTransparency = 1
	label.FontFace = PROMPT_FONT
	label.Position = UDim2.fromScale(0.5, 0.5)
	label.Size = UDim2.fromScale(1, 1)
	label.Text = text
	label.TextColor3 = PROMPT_TEXT
	label.TextScaled = true
	label.Visible = false
	label.ZIndex = 1
	label.Parent = Ready
	stroke(label, PROMPT_THICKNESS, PROMPT_STROKE)
	return label
end

local ReadyKey   = readyLabel("Ready", "Press G to activate")
local ReadyPad   = readyLabel("ReadyPad", "Press DPAD UP to activate")
local ReadyTouch = readyLabel("ReadyTouch", "Tap here to activate")

-- Transparent hit area over the whole bar.
local Touch = Instance.new("ImageButton")
Touch.Name = "Touch"
Touch.BackgroundTransparency = 1
Touch.ImageTransparency = 1
Touch.Size = UDim2.fromScale(1, 1)
Touch.ZIndex = 10
Touch.Parent = Bar

local TimeLabel = Instance.new("TextLabel")
TimeLabel.Name = "Time"
TimeLabel.AnchorPoint = Vector2.new(0.5, 1)
TimeLabel.BackgroundTransparency = 1
TimeLabel.FontFace = TITLE_FONT
TimeLabel.Position = TIME_POS
TimeLabel.Size = TIME_SIZE
TimeLabel.Text = ""
TimeLabel.TextColor3 = TITLE_TEXT
TimeLabel.TextScaled = true
TimeLabel.Visible = false
TimeLabel.ZIndex = 2
TimeLabel.Parent = Ultimate
stroke(TimeLabel, 2, TITLE_STROKE)

--// State \\--

local shown = false
local lastProgress = AwakeningProgress.Value

local function inUlt()
	return Character ~= nil and Character:GetAttribute("Awakened")
end

--// Ready prompt \\--

local function refreshReadyVariant()
	local touch = UIS.PreferredInput == Enum.PreferredInput.Touch
	local pad = UIS.PreferredInput == Enum.PreferredInput.Gamepad

	ReadyTouch.Visible = touch
	ReadyPad.Visible = not touch and pad
	ReadyKey.Visible = not touch and not pad
end

UIS:GetPropertyChangedSignal("PreferredInput"):Connect(refreshReadyVariant)

--// Title and colour \\--

local function movesetInfo()
	local name = Player:GetAttribute("Character") or Player:GetAttribute("Moveset")
	return name and InfoModule.Movesets[name] or nil
end

local function updateUlt()
	local info = movesetInfo()

	local ultName = info and info.UltimateName
	Title.Text = ultName and tostring(ultName) or "?"

	local color = info and info.AwakeningBarColor or DEFAULT_FILL
	Fill.BackgroundColor3 = color
	FillGradient.Color = ColorSequence.new(color, Color3.new(1, 1, 1))
end

--// The full flash \\--

local function playReadyBurst()
	-- Not from Juju: their bar makes no sound here. Kept because your old bar
	-- did, and losing the cue is worse than the small deviation. Delete this
	-- block for a strictly faithful port.
	local info = movesetInfo()
	local Indicator = info and info.Indicator
	if Indicator and Character:FindFirstChild("Torso") then
		shared.sfx({
			SoundId = Indicator.Sound,
			Parent = Character.Torso,
			Volume = Indicator.Volume,
			RollOffMaxDistance = 100,
		}):Play()
	end

	local Highlight = Instance.new("Highlight")
	Highlight.FillColor = Color3.new(1, 1, 1)
	Highlight.FillTransparency = 0
	Highlight.Parent = Character
	Debris:AddItem(Highlight, 2)
	TS:Create(Highlight, TweenInfo.new(1.25), { FillTransparency = 1 }):Play()
	TS:Create(Highlight, TweenInfo.new(2), { OutlineTransparency = 1 }):Play()

	local torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
	if torso then
		local PointLight = Instance.new("PointLight")
		PointLight.Brightness = 10
		PointLight.Parent = torso
		Debris:AddItem(PointLight, 2)
		TS:Create(PointLight, TweenInfo.new(2), { Brightness = 0, Range = 4 }):Play()
	end
end

--// Activation \\--

local function ActivateAwk()
	if AwakeningProgress.Value < 100 or Character:HasTag('Stunned') or Character:GetAttribute("Awakened") then return end
	if game.PlaceId == workspace:GetAttribute("DuelsHubPlaceId") then return end

	Remotes.ModeRequest:FireServer('Awakening')
end

--// Per-frame update \\--

RunService.Stepped:Connect(function(_, dt)
	if not Character or not Character.Parent then
		return
	end

	local target = math.clamp(AwakeningProgress.Value / 100, 0, 1)

	-- The Juju easing. Not a tween: it chases the value every frame.
	local scale = Fill.Size.X.Scale
	Fill.Size = UDim2.new(scale + (target - scale) * (FILL_LERP * dt), 0, 1, 0)

	Ready.Visible = target >= 1 and not inUlt()

	local progress = AwakeningProgress.Value
	if progress >= 100 and lastProgress < 100 and not inUlt() then
		playReadyBurst()
	end
	lastProgress = progress
end)

--// Connections \\--

Touch.MouseButton1Down:Connect(ActivateAwk)

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end

	if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.DPadUp then
		ActivateAwk()
	end
end)

Player:GetAttributeChangedSignal("Moveset"):Connect(updateUlt)
Player:GetAttributeChangedSignal("Character"):Connect(updateUlt)

Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character or Player.CharacterAdded:Wait()
	updateUlt()
end)

--// Public \\--

-- Slide the HUD in and out. The source uses a quick ease out and a slow
-- exponential ease in, which is why it snaps away but drifts back.
shared.triggerAwkbar = function(State)
	if shown == (State and true or false) then
		return
	end
	shown = State and true or false

	local info = shown
		and TweenInfo.new(SHOW_TIME, SHOW_STYLE, SHOW_DIR)
		or TweenInfo.new(HIDE_TIME)

	TS:Create(Title, info, { Position = shown and TITLE_POS or TITLE_HIDDEN }):Play()
	TS:Create(Bar,   info, { Position = shown and BAR_POS   or BAR_HIDDEN   }):Play()
end

-- The paired-resource strip inside the bar. Pass 0..1, or nil to hide it.
shared.setUltSecondary = function(alpha)
	if alpha then
		Fill2.Visible = true
		Fill2.Size = UDim2.new(math.clamp(alpha, 0, 1), 0, 0, FILL2_HEIGHT)
	else
		Fill2.Visible = false
		Fill2.Size = UDim2.new(0, 0, 0, FILL2_HEIGHT)
	end
end

shared.setUltTimer = function(seconds)
	if seconds then
		TimeLabel.Text = tostring(math.floor(seconds))
		TimeLabel.Visible = true
	else
		TimeLabel.Visible = false
	end
end

--// Init \\--

refreshReadyVariant()
updateUlt()
