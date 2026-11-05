--// Awakening Bar - Heroes Battlegrounds style \\--
--
-- Builds the bar in code and drives it. Every number below was measured off
-- your BarsTempCurr model, so what this produces is that layout, not an
-- approximation of it.
--
-- The bar does NOT fill by resizing. The fill layer carries a UIGradient whose
-- Transparency is a hard step:
--
--     {(0, 0), (0.0001, 1), (1, 1)}
--
-- opaque at the very left edge, transparent immediately after. Sliding its
-- Offset.X from 0 to 1 wipes the fill across with a razor edge that stays
-- vertical however slanted the art is. No ClipsDescendants, no resize.
--
-- Two tween profiles, from the source:
--     charging   1.00s  Circular Out
--     draining   0.32s  Linear        -- while awakened, reads as a timer

--// Services \\--

local RS = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local Players = game:GetService('Players')
local TS = game:GetService('TweenService')
local Debris = game.Debris

--// Modules \\--

local InfoModule = require(RS:WaitForChild("Info", 5))

--// Remotes \\--

local Remotes = RS.Remotes

--// Art \\--

local BAR_IMAGE  = "rbxassetid://77570239022684"    -- frame, also the shadow
local BAR_HOLDER = "rbxassetid://81845885043479"    -- never drawn, see below
local BAR_FILL   = "rbxassetid://94725711012841"    -- tinted at runtime
local DPAD_IMAGE = "rbxassetid://116601548120361"

--// Layout - measured off BarsTempCurr \\--

local MODE_POS      = UDim2.new(0.5, 0, 1, -76)
local MODE_SIZE     = UDim2.new(0.49, 0, 0.057, 0)
local MODE_SCALE    = 0.85

local BAR_POS       = UDim2.new(0, 0, 0.29169, 0)
local BAR_SIZE      = UDim2.new(1, 0, 0.7, 0)
local SHADOW_ALPHA  = 0.5

local HOLDER_POS    = UDim2.new(0.08188, 0, 0, 0)
local HOLDER_SIZE   = UDim2.new(0.843, 0, 1, 0)
local INSIDE_SIZE   = UDim2.new(0.99111, 0, 1, 0)

local TEXT_POS      = UDim2.new(0, 0, 0.18168, 0)
local TEXT_SIZE     = UDim2.new(1, 0, 0.81832, 0)

local TITLE_POS     = UDim2.new(0.08358, 0, -0.33361, 0)
local TITLE_SIZE    = UDim2.new(0.83584, 0, 0.83802, 0)
local TITLE_STROKE  = 2.75

local KEY_POS       = UDim2.new(0.2306, 0, 0.75001, 0)
local KEY_SIZE      = UDim2.new(0.54065, 0, 0.7004, 0)
local KEY_STROKE    = 1.75

local DPAD_POS      = UDim2.new(0.50016, 0, -2.58258, 0)
local DPAD_SIZE     = UDim2.new(0.12015, 0, 1.79199, 0)
local DPAD_RATIO    = 0.99
local DPAD_COLOR    = Color3.fromRGB(231, 231, 231)

local SHADOW_NUDGE  = Vector2.new(2, 1)   -- px offset of every text shadow
local MAX_TEXT_SIZE = 50

local TITLE_FONT = Font.new("rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Bold, Enum.FontStyle.Italic)
local KEY_FONT = Font.new("rbxasset://fonts/families/GothamSSm.json",
	Enum.FontWeight.Bold, Enum.FontStyle.Normal)

local TEXT_COLOR   = Color3.fromRGB(255, 255, 255)
local TEXT_SHADOW  = Color3.fromRGB(0, 0, 0)
local DEFAULT_FILL = Color3.fromRGB(11, 210, 255)   -- inside's authored tint

--// Motion \\--

local CHARGE_TIME  = 1
local CHARGE_STYLE = Enum.EasingStyle.Circular
local CHARGE_DIR   = Enum.EasingDirection.Out

local DRAIN_TIME   = 0.32
local DRAIN_STYLE  = Enum.EasingStyle.Linear
local DRAIN_DIR    = Enum.EasingDirection.InOut

local TINT_TIME    = 1
local SLIDE_TIME   = 1
local HIDE_DROP    = 260    -- px below MODE_POS when hidden

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

local HIDDEN_POS = MODE_POS + UDim2.fromOffset(0, HIDE_DROP)

local Mode = Instance.new("Frame")
Mode.Name = "Mode"
Mode.AnchorPoint = Vector2.new(0.5, 1)
Mode.BackgroundTransparency = 1
Mode.Position = HIDDEN_POS
Mode.Size = MODE_SIZE
Mode.ZIndex = 0
Mode.Parent = GUI

local ModeScale = Instance.new("UIScale")
ModeScale.Name = "UIScale"
ModeScale.Scale = MODE_SCALE
ModeScale.Parent = Mode

-- Same rect as Bar at ZIndex -1. The frame art is semi-transparent, so this
-- deepens the interior rather than casting an offset drop shadow. Its gradient
-- fades it out at both tips.
local BarShadow = Instance.new("ImageLabel")
BarShadow.Name = "BarSHADOW"
BarShadow.BackgroundTransparency = 1
BarShadow.Image = BAR_IMAGE
BarShadow.ImageTransparency = SHADOW_ALPHA
BarShadow.Position = BAR_POS
BarShadow.Size = BAR_SIZE
BarShadow.ZIndex = -1
BarShadow.Parent = Mode

local ShadowGradient = Instance.new("UIGradient")
ShadowGradient.Rotation = 0
ShadowGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 1),
	NumberSequenceKeypoint.new(0.17, 0),
	NumberSequenceKeypoint.new(0.83, 0),
	NumberSequenceKeypoint.new(1, 1),
})
ShadowGradient.Parent = BarShadow

-- The frame doubles as a tap target.
local Bar = Instance.new("ImageButton")
Bar.Name = "Bar"
Bar.AutoButtonColor = false
Bar.BackgroundTransparency = 1
Bar.Image = BAR_IMAGE
Bar.Position = BAR_POS
Bar.Size = BAR_SIZE
Bar.ZIndex = 0
Bar.Parent = Mode

-- Invisible by design: it only insets the fill away from the frame's slanted
-- ends. Making it visible paints an opaque slab over the whole bar.
local BarHolder = Instance.new("ImageLabel")
BarHolder.Name = "BarHolder"
BarHolder.BackgroundTransparency = 1
BarHolder.ClipsDescendants = true
BarHolder.Image = BAR_HOLDER
BarHolder.ImageTransparency = 1
BarHolder.Position = HOLDER_POS
BarHolder.Size = HOLDER_SIZE
BarHolder.ZIndex = 0
BarHolder.Parent = Bar

local inside = Instance.new("ImageLabel")
inside.Name = "inside"
inside.BackgroundTransparency = 1
inside.Image = BAR_FILL
inside.ImageColor3 = DEFAULT_FILL
inside.Position = UDim2.new(0, 0, 0, 0)
inside.Size = INSIDE_SIZE
inside.ZIndex = 0
inside.Parent = BarHolder

local FillGradient = Instance.new("UIGradient")
FillGradient.Name = "UIGradient"
FillGradient.Rotation = 0
FillGradient.Transparency = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.0001, 1),
	NumberSequenceKeypoint.new(1, 1),
})
FillGradient.Offset = Vector2.new(0, 0)
FillGradient.Parent = inside

local DPAD = Instance.new("ImageLabel")
DPAD.Name = "DPAD"
DPAD.AnchorPoint = Vector2.new(0.5, 0)
DPAD.BackgroundTransparency = 1
DPAD.Image = DPAD_IMAGE
DPAD.ImageColor3 = DPAD_COLOR
DPAD.Position = DPAD_POS
DPAD.Size = DPAD_SIZE
DPAD.Visible = false
DPAD.ZIndex = 1
DPAD.Parent = Mode

local DPadRatio = Instance.new("UIAspectRatioConstraint")
DPadRatio.AspectRatio = DPAD_RATIO
DPadRatio.Parent = DPAD

-- Transparent button covering the text block, so tapping the label works too.
local TextHolder = Instance.new("TextButton")
TextHolder.Name = "ModeText"
TextHolder.AutoButtonColor = false
TextHolder.BackgroundTransparency = 1
TextHolder.Text = ""
TextHolder.Position = TEXT_POS
TextHolder.Size = TEXT_SIZE
TextHolder.ZIndex = 1
TextHolder.Parent = Mode

-- Shadows are siblings rather than children of their label. In the source they
-- are children and the ScreenGui runs Global ZIndexBehavior; as siblings the
-- layering is correct under either behaviour, so this cannot break if the
-- ScreenGui's setting changes.
local function newLabel(name, parent, pos, size, font, zindex, isShadow, strokeWidth)
	local label = Instance.new("TextLabel")
	label.Name = name
	label.BackgroundTransparency = 1
	label.FontFace = font
	label.Position = isShadow
		and UDim2.new(pos.X.Scale, pos.X.Offset + SHADOW_NUDGE.X, pos.Y.Scale, pos.Y.Offset + SHADOW_NUDGE.Y)
		or pos
	label.Size = size
	label.Text = ""
	label.TextColor3 = isShadow and TEXT_SHADOW or TEXT_COLOR
	label.TextScaled = true
	label.TextStrokeTransparency = 1
	label.TextWrapped = true
	label.TextXAlignment = Enum.TextXAlignment.Center
	label.TextYAlignment = Enum.TextYAlignment.Center
	label.ZIndex = zindex
	label.Parent = parent

	local cap = Instance.new("UITextSizeConstraint")
	cap.MaxTextSize = MAX_TEXT_SIZE
	cap.Parent = label

	if isShadow then
		local stroke = Instance.new("UIStroke")
		stroke.Color = TEXT_SHADOW
		stroke.Thickness = strokeWidth
		stroke.Parent = label
	end

	return label
end

-- Shadow first so it sits behind, then the white label over it.
local TitleShadow = newLabel("TitleShadow", TextHolder, TITLE_POS, TITLE_SIZE, TITLE_FONT, 1, true, TITLE_STROKE)
local Title       = newLabel("ModeText",    TextHolder, TITLE_POS, TITLE_SIZE, TITLE_FONT, 2, false)

local KeyShadow = newLabel("KeybindShadow", TextHolder, KEY_POS, KEY_SIZE, KEY_FONT, 9, true, KEY_STROKE)
local keybind   = newLabel("keybind",       TextHolder, KEY_POS, KEY_SIZE, KEY_FONT, 10, false)

KeyShadow.Visible = false
keybind.Visible = false

--// State \\--

local usingGamepad = false
local readyShown = false

local function isTouch()
	return UIS.PreferredInput == Enum.PreferredInput.Touch
end

local function inUlt()
	return Character ~= nil and Character:GetAttribute("Awakened")
end

--// Text \\--

local function movesetInfo()
	local name = Player:GetAttribute("Character") or Player:GetAttribute("Moveset")
	return name and InfoModule.Movesets[name] or nil
end

local function setUltName()
	local info = movesetInfo()

	local ultName = info and info.UltimateName
	ultName = ultName and tostring(ultName):upper() or "?"

	Title.Text = ultName
	TitleShadow.Text = ultName

	local color = info and info.AwakeningBarColor or DEFAULT_FILL
	if inside.ImageColor3 ~= color then
		TS:Create(inside, TweenInfo.new(TINT_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			ImageColor3 = color,
		}):Play()
	end
end

local function setKeybindText()
	local verb = "TO AWAKEN"
	local text

	if isTouch() then
		text = "TAP " .. verb
	elseif usingGamepad then
		text = "DPAD UP " .. verb
	else
		text = "PRESS [G] " .. verb
	end

	keybind.Text = text
	KeyShadow.Text = text
end

--// Fill \\--

local function setProgress(alpha)
	alpha = math.clamp(alpha, 0, 1)

	local info = inUlt()
		and TweenInfo.new(DRAIN_TIME, DRAIN_STYLE, DRAIN_DIR)
		or TweenInfo.new(CHARGE_TIME, CHARGE_STYLE, CHARGE_DIR)

	TS:Create(FillGradient, info, { Offset = Vector2.new(alpha, 0) }):Play()
end

--// Ready \\--

local function showReady()
	if readyShown then return end
	readyShown = true

	setKeybindText()
	keybind.Visible = true
	KeyShadow.Visible = true
	DPAD.Visible = usingGamepad and not inUlt()

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

	local lightTemplate = script:FindFirstChild("Light")
	if lightTemplate and Character:FindFirstChild("Torso") then
		local Light = lightTemplate:Clone()
		Light.Parent = Character.Torso
		TS:Create(Light, TweenInfo.new(2, Enum.EasingStyle.Linear), { Brightness = 0 }):Play()
		Debris:AddItem(Light, 2)
	end

	local hTemplate = script:FindFirstChild("HLight")
	if hTemplate then
		local HLight = hTemplate:Clone()
		HLight.Parent = Character
		TS:Create(HLight, TweenInfo.new(2, Enum.EasingStyle.Linear), {
			FillTransparency = 1,
			OutlineTransparency = 1,
		}):Play()
		Debris:AddItem(HLight, 2)
	end
end

local function hideReady()
	readyShown = false
	keybind.Visible = false
	KeyShadow.Visible = false
	DPAD.Visible = false
end

--// Activation \\--

local function ActivateAwk()
	if AwakeningProgress.Value < 100 or Character:HasTag('Stunned') or Character:GetAttribute("Awakened") then return end
	if game.PlaceId == workspace:GetAttribute("DuelsHubPlaceId") then return end

	Remotes.ModeRequest:FireServer('Awakening')
end

--// Connections \\--

AwakeningProgress:GetPropertyChangedSignal('Value'):Connect(function()
	local alpha = math.clamp(AwakeningProgress.Value / 100, 0, 1)
	setProgress(alpha)

	if alpha >= 1 then
		showReady()
	else
		hideReady()
	end
end)

UIS.LastInputTypeChanged:Connect(function(inputType)
	usingGamepad = table.find({
		Enum.UserInputType.Gamepad1,
		Enum.UserInputType.Gamepad2,
		Enum.UserInputType.Gamepad3,
	}, inputType) ~= nil

	shared.controllerpressed = usingGamepad

	if keybind.Visible then
		setKeybindText()
		DPAD.Visible = usingGamepad and not inUlt()
	end
end)

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end

	if input.KeyCode == Enum.KeyCode.G or input.KeyCode == Enum.KeyCode.DPadUp then
		ActivateAwk()
	end
end)

Bar.Activated:Connect(ActivateAwk)
TextHolder.Activated:Connect(ActivateAwk)

Player:GetAttributeChangedSignal("Moveset"):Connect(setUltName)
Player:GetAttributeChangedSignal("Character"):Connect(setUltName)

Player:GetPropertyChangedSignal('Character'):Connect(function()
	Character = Player.Character or Player.CharacterAdded:Wait()
	setUltName()
end)

-- Clear the gamepad hint the moment the ult starts, the way the source does.
task.spawn(function()
	while task.wait(0.25) do
		if DPAD.Visible and inUlt() then
			DPAD.Visible = false
		end
	end
end)

--// Public \\--

shared.triggerAwkbar = function(State)
	TS:Create(Mode, TweenInfo.new(SLIDE_TIME, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Position = State and MODE_POS or HIDDEN_POS,
	}):Play()
end

--// Init \\--

setUltName()
setKeybindText()
hideReady()
setProgress(math.clamp(AwakeningProgress.Value / 100, 0, 1))

if AwakeningProgress.Value >= 100 then
	showReady()
end
