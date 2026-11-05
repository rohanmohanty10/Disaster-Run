-- Emote Wheel Handler
-- Radial replacement for the old panel UI in Handler.client.lua.
-- All emote data/equip/gamepass logic is unchanged; only the presentation differs.
-- Disable + move the old Handler to ServerStorage before enabling this one.

-- SERVICES --

local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UIS = game:GetService('UserInputService')
local PlayerService = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local ContextActionService = game:GetService('ContextActionService')

-- PLAYER --

local Player = PlayerService.LocalPlayer
repeat task.wait() until game:IsLoaded() and Player:GetAttribute("Loaded") == true
local Character = Player.Character or Player.CharacterAdded:Wait()

-- REMOTES --

local Remotes = ReplicatedStorage.Remotes
local EmotesSet = Remotes.Emotes.Set
local GetGamepasses = Remotes.Comunicator.GetGamepasses

-- CONFIG --

-- "billboard" = 3D wheel around your character (Gakuran's default)
-- "screen"    = flat 2D wheel centred on screen
-- "auto"      = billboard on desktop/gamepad, screen on touch
local WHEEL_MODE = "billboard"

local DEBUG = true                  -- prints slot state + click attempts to the console
local BIND_NUMBER_KEYS = true       -- 1-9,0 activate slots while the wheel is open (sunk, so no skill fires)

-- true  = cursor is freed so you can CLICK slots. Mouse-look stops while open;
--         right-click-drag still rotates the camera.
-- false = cursor stays locked, camera behaves completely normally, and the
--         wheel is number-keys-only.
local FREE_CURSOR = true

-- Size of the 2D wheel as a fraction of screen HEIGHT. Only used in "screen" mode.
local SCREEN_WHEEL_SCALE = 0.55

-- Where each slot sits on the ring.
--   "sequential" -- 1 at the top, then 2,3,4... clockwise. Numbers read in order.
--   "zigzag"     -- Gakuran's original: odds down the right, evens down the left.
--                   Reads well for their category names, confusing next to keys.
local RING_ORDER = "sequential"

-- Slow clockwise drift of the whole wheel.
local ROTATE_WHEEL = true
local ROTATE_SPEED = 6          -- degrees per second
-- false: slots orbit but each circle stays upright, so labels stay readable.
-- true:  circles spin with the wheel, so text tumbles upside-down at the bottom.
local ROTATE_SLOT_FACES = false

local USE_AVATAR_PREVIEWS = true    -- clone the player's R6 character into each slot

-- Frame every preview from a fixed reference instead of measuring the rig.
-- Measuring reacts to whatever is attached to the character -- a weapon Model,
-- oversized accessories, a scaled body -- so the same zoom looked right on one
-- character and tiny on another. Fixed framing is identical for everyone; a
-- larger character just overflows the circle, which is the intended trade.
local PREVIEW_FIXED_FRAMING = true

-- Height in studs the fixed framing is built around. A standard R6 character is
-- about 5. Lower this to make every character render bigger.
local PREVIEW_REFERENCE_HEIGHT = 5

-- How large the character appears inside its circle. 1 = whole rig framed with
-- a little padding (the default). Above ~1.3 the feet leave the circle, so pair
-- it with PREVIEW_VERTICAL_BIAS to keep the head and torso centred.
local PREVIEW_ZOOM = 1.0

-- Shifts what the camera looks at, as a fraction of the rig's height.
-- Positive = aim higher (head/torso), negative = aim lower.
local PREVIEW_VERTICAL_BIAS = 0.0

-- Show only your character in the preview. Strips equipped Tools and weapon
-- Models (the Whitebeard bisento and friends) from the clone. Accessories such
-- as hair and hats are kept.
local PREVIEW_BODY_ONLY = true

-- Size of the preview circle relative to its slot button. 1 = fills the button.
-- Above 1 the preview spills outside the circle, which usually looks wrong.
local PREVIEW_FRAME_SCALE = 1.0
local FALLBACK_EMOTE = 'Resolute'

-- Size of the world-space wheel, in studs. Raise this to make the whole wheel
-- (and therefore the circles) bigger on screen. Gakuran uses 9.
local WHEEL_STUDS = 9

-- Slot ring visibility. Gakuran tints its border ring to the player's hair
-- colour, so on a dark-haired character it reads as "no ring" -- which is what
-- the reference screenshot shows. 1 = fully invisible.
-- The small blue chevron on nav slots. It is the only visible blue left, since
-- both strokes sit at transparency 1, so turning it off makes the wheel fully
-- monochrome. OpensSubmenu drives nothing except the arrow, so gating it there
-- disables the label and every arrow tween in one place.
local SHOW_SUBMENU_ARROWS = false

local RING_IDLE = 1        -- outer stroke, idle
local RING_HOVER = 0.45    -- outer stroke, hovered (kept for click feedback)
local OUTLINE_IDLE = 1     -- inner border ring, idle

-- Only one wheel variant may run at a time; whichever loads first wins.
if shared.__emoteWheelActive then
	warn(("[EmoteWheel] %q already running - %q is standing down. Disable one of the two WheelHandler scripts.")
		:format(tostring(shared.__emoteWheelActive), WHEEL_MODE))
	return
end
shared.__emoteWheelActive = WHEEL_MODE

-- EMOTES --

local EmotesFolder = ReplicatedStorage.Assets.Animations.Emotes
local EmoteIds = {}

-- LAYOUT (mirrors Gakuran's EmoteWheelScreenReplica.Layout) --

local Layout = {
	WHEEL_RADIUS = 0.42,
	CENTER_POS = UDim2.new(0.5, 0, 0.5, 0),
	BUTTON_SIZE = UDim2.new(0.14, 0, 0.14, 0),
	HOVER_SIZE = UDim2.new(0.17, 0, 0.17, 0),
	TOUCH_BUTTON_SIZE = UDim2.new(0.17, 0, 0.17, 0),
	TOUCH_HOVER_SIZE = UDim2.new(0.2, 0, 0.2, 0),
	SLOT_KEY_NAMES = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" },
	MULTI_BADGE_TEXT = "LOCKED",
	MULTI_BADGE_COLOR = Color3.fromRGB(255, 195, 75),
	NAME_LABEL_POS = UDim2.new(0.1, 0, 0.15, 0),
	NAME_LABEL_SIZE = UDim2.new(0.8, 0, 0.4, 0),
	NAME_LABEL_POS_WITH_BADGE = UDim2.new(0.1, 0, 0.24, 0),
	NAME_LABEL_SIZE_WITH_BADGE = UDim2.new(0.8, 0, 0.32, 0),
	POS_INDEX_BY_SLOT = RING_ORDER == "zigzag"
		and { 1, 10, 2, 9, 3, 8, 4, 7, 5, 6 }
		or  { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
	SLOT_ANGLES = {},
}

local TAU_TENTH = math.pi * 2 / 10
local QUARTER = math.pi / 2

for i = 1, 10 do
	Layout.SLOT_ANGLES[i] = ((Layout.POS_INDEX_BY_SLOT[i] or i) - 1) * TAU_TENTH - QUARTER
end

-- Y grows downward in UI space, so an increasing angle reads as clockwise.
local function posFromAngle(a: number): UDim2
	return UDim2.new(
		0.5 + math.cos(a) * Layout.WHEEL_RADIUS, 0,
		0.5 + math.sin(a) * Layout.WHEEL_RADIUS, 0
	)
end

local function GetTargetPos(slot: number): UDim2
	return posFromAngle(Layout.SLOT_ANGLES[slot] or 0)
end

-- TWEENS / COLORS --

local TW_OPEN     = TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TW_CLOSE    = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local TW_HOVER    = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TW_PAGE_OUT = TweenInfo.new(0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local TW_PAGE_IN  = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TW_FLASH_IN = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TW_FLASH_OT = TweenInfo.new(0.28, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local ACCENT = Color3.fromRGB(120, 200, 255)
local REJECT = Color3.fromRGB(212, 116, 116)
local FILL_IDLE = Color3.fromRGB(30, 30, 35)
local FILL_HOVER = Color3.fromRGB(45, 45, 55)

local GAMEPAD_KEYS = {
	Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four,
	Enum.KeyCode.Five, Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight,
	Enum.KeyCode.Nine, Enum.KeyCode.Zero,
}

-- SHARED HELPERS (ported from the old Handler) --

local function GetEmoteAnim(emoteName)
	if not emoteName then return nil end
	local direct = EmotesFolder:FindFirstChild(emoteName)
	if direct and direct:IsA("Animation") then return direct end

	for _, folder in EmotesFolder:GetChildren() do
		if folder:IsA("Folder") then
			local emote = folder:FindFirstChild(emoteName)
			if emote and emote:IsA("Animation") then
				return emote
			end
		end
	end
	return nil
end

local function sfx(id, volume)
	if not shared.sfx then return end
	local ok, sound = pcall(shared.sfx, {
		SoundId = "rbxassetid://" .. id,
		Parent = workspace,
		Volume = volume or 0.75,
	})
	if ok and sound then sound:Play() end
end

local function ShouldUseScreenWheel(): boolean
	if WHEEL_MODE == "screen" then return true end
	if WHEEL_MODE == "billboard" then return false end
	return UIS.TouchEnabled and not UIS.GamepadEnabled
end

local function dbg(...)
	if DEBUG then 
		--print("[EmoteWheel]", ...) 
	end
end

-- Anything other than the body throws the framing off: an equipped Tool, a hat,
-- or -- as with the Whitebeard bisento -- a plain Model parented under the
-- character. Class checks miss that last case, so match body parts by name and
-- only as DIRECT children of the rig. A weapon Model's parts are grandchildren,
-- an Accessory's Handle is a grandchild, so both fall out automatically.
local BODY_PART_NAMES = {
	-- R6
	Head = true, Torso = true, HumanoidRootPart = true,
	["Left Arm"] = true, ["Right Arm"] = true,
	["Left Leg"] = true, ["Right Leg"] = true,
	-- R15
	UpperTorso = true, LowerTorso = true,
	LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
	RightUpperArm = true, RightLowerArm = true, RightHand = true,
	LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
	RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
}

local function bodyBounds(rig: Model): (Vector3?, Vector3?)
	local minV, maxV = nil, nil

	for _, d in ipairs(rig:GetChildren()) do
		if d:IsA("BasePart") and BODY_PART_NAMES[d.Name] then
			local half = d.Size * 0.5
			local lo, hi = d.Position - half, d.Position + half
			if minV then
				minV = Vector3.new(math.min(minV.X, lo.X), math.min(minV.Y, lo.Y), math.min(minV.Z, lo.Z))
				maxV = Vector3.new(math.max(maxV.X, hi.X), math.max(maxV.Y, hi.Y), math.max(maxV.Z, hi.Z))
			else
				minV, maxV = lo, hi
			end
		end
	end

	if not minV then return nil, nil end
	return (minV + maxV) * 0.5, maxV - minV
end

-- SLOT VIEWPORT --

local SlotViewport = {}
SlotViewport.__index = SlotViewport

function SlotViewport.new(parent: Instance)
	local self = setmetatable({}, SlotViewport)
	self._track = nil
	self._animator = nil
	self._clone = nil
	self._pendingAnimation = nil

	local vp = Instance.new("ViewportFrame")
	vp.Name = "EmotePreview"
	vp.Size = UDim2.new(PREVIEW_FRAME_SCALE, 0, PREVIEW_FRAME_SCALE, 0)
	vp.Position = UDim2.new(0.5, 0, 0.5, 0)
	vp.AnchorPoint = Vector2.new(0.5, 0.5)
	vp.BackgroundTransparency = 1
	vp.LightColor = Color3.fromRGB(242, 244, 255)
	vp.LightDirection = Vector3.new(-1, -1, 0)
	vp.Ambient = Color3.fromRGB(110, 120, 128)
	vp.Visible = false
	vp.Active = false
	vp.ZIndex = 2
	vp.Parent = parent

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = vp

	local world = Instance.new("WorldModel")
	world.Parent = vp

	local cam = Instance.new("Camera")
	cam.FieldOfView = 40
	cam.Parent = vp
	vp.CurrentCamera = cam

	self.ViewportFrame = vp
	self._world = world
	self._camera = cam
	return self
end

function SlotViewport:_stopTrack()
	if self._track then
		pcall(function() self._track:Stop(0) end)
		self._track = nil
	end
end

function SlotViewport:ClearRig()
	self:_stopTrack()
	self._animator = nil
	self._clone = nil
	for _, child in ipairs(self._world:GetChildren()) do
		child:Destroy()
	end
end

function SlotViewport:HasRig(): boolean
	return self._clone ~= nil and self._clone.Parent ~= nil
end

function SlotViewport:SetRig(rig: Model?)
	self:ClearRig()
	if not rig then return end

	rig.Parent = self._world
	self._clone = rig

	local hum = rig:FindFirstChildOfClass("Humanoid")
	if hum then
		self._animator = hum:FindFirstChildOfClass("Animator") or Instance.new("Animator", hum)
	end

	self:_frameCamera()

	-- the menu is built before rigs exist, so re-apply whatever was queued
	if self._pendingAnimation then
		self:SetAnimation(self._pendingAnimation)
	end
end

function SlotViewport:_frameCamera()
	local rig = self._clone
	if not rig then return end

	local hrp = rig:FindFirstChild("HumanoidRootPart")
	local look = (hrp and hrp:IsA("BasePart")) and hrp.CFrame.LookVector or Vector3.new(0, 0, -1)
	local origin = (hrp and hrp:IsA("BasePart")) and hrp.Position or Vector3.new(0, 0, 0)

	local extent, center

	if PREVIEW_FIXED_FRAMING then
		-- Every character is framed from the same constant, so nothing about the
		-- rig -- weapon, accessories, body scale -- can change the size. Anything
		-- taller or wider than the reference simply overflows the circle.
		extent = PREVIEW_REFERENCE_HEIGHT
		center = origin
	else
		local c, size = bodyBounds(rig)
		if not c then
			local ok, cf, s2 = pcall(function()
				local cc, sz = rig:GetBoundingBox()
				return cc, sz
			end)
			if not ok or not cf then return end
			c, size = cf.Position, s2
		end
		extent = math.max(size.X, size.Y, size.Z)
		center = c
	end

	if extent <= 0 then return end

	-- distance that exactly fits `extent`, times 1.25 padding, divided by the
	-- zoom: a larger zoom pulls the camera in, so the character fills more circle
	local zoom = math.max(PREVIEW_ZOOM, 0.05)
	local dist = (extent * 0.5) / math.tan(math.rad(self._camera.FieldOfView * 0.5)) * 1.25 / zoom
	local focus = center + Vector3.new(0, extent * PREVIEW_VERTICAL_BIAS, 0)

	self._camera.CFrame = CFrame.lookAt(focus + look * dist, focus)
end

function SlotViewport:SetAnimation(animationId: string?)
	self._pendingAnimation = animationId
	self:_stopTrack()
	if not animationId or animationId == "" or not self._animator then return end

	local anim = Instance.new("Animation")
	anim.AnimationId = animationId

	local ok, track = pcall(function()
		return self._animator:LoadAnimation(anim)
	end)
	if not ok or not track then return end

	track.Looped = true
	track:Play()
	self._track = track
end

function SlotViewport:SetRunning(running: boolean)
	-- no animation means this is a nav/empty/locked slot: never show a rig,
	-- otherwise Close/More/Empty render a T-posing character behind the label
	self.ViewportFrame.Visible = running and self:HasRig() and self._pendingAnimation ~= nil
	if not running then
		self:_stopTrack()
	end
end

function SlotViewport:Destroy()
	self:ClearRig()
	self.ViewportFrame:Destroy()
end

-- WHEEL --

local Wheel = {
	_isOpen = false,
	_uiState = "Closed",
	_page = 1,
	_stateToken = 0,
	_slots = {},
	_activeTweens = {},
	_screenGui = nil,
	_billboard = nil,
	_billboardAnchor = nil,
	_container = nil,
	_useScreenWheel = false,
	_slotButtonSize = Layout.BUTTON_SIZE,
	_slotHoverSize = Layout.HOVER_SIZE,
	_hoveredSlot = nil,
	_stickDeadzone = 0.28,
	_stickConn = nil,
	_anchorConn = nil,
	_rigsBuiltFor = nil,
	_jumpSinkBound = false,
}

-- cached server state
local Equipped = { [1] = {}, [2] = {} }
local Passes = { MoreEmotes = false, SecondPage = false }

local function refreshPasses()
	local ok1, more = pcall(function() return GetGamepasses:InvokeServer("MoreEmotes") end)
	local ok2, second = pcall(function() return GetGamepasses:InvokeServer("SecondPage") end)
	Passes.MoreEmotes = ok1 and more == true
	Passes.SecondPage = ok2 and second == true
end

local function maxSlotsOnPage(): number
	return Passes.MoreEmotes and 8 or 4
end

function Wheel:_playTween(info, obj, goal)
	local t = TweenService:Create(obj, info, goal)
	self._activeTweens[t] = true
	t.Completed:Connect(function()
		self._activeTweens[t] = nil
	end)
	t:Play()
	return t
end

function Wheel:_cancelActiveTweens()
	for t in pairs(self._activeTweens) do
		pcall(function() t:Cancel() end)
		self._activeTweens[t] = nil
	end
end

function Wheel:_bumpStateToken(): number
	self._stateToken += 1
	return self._stateToken
end

-- GUI CONSTRUCTION --

function Wheel:_buildSlot(parent: Instance, index: number)
	local btn = Instance.new("TextButton")
	btn.Name = "Slot" .. tostring(index)
	btn.Size = self._slotButtonSize
	btn.Position = Layout.CENTER_POS
	btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.BackgroundColor3 = FILL_IDLE
	btn.BackgroundTransparency = 0.15
	btn.Text = ""
	btn.Visible = false
	btn.AutoButtonColor = false
	btn.Parent = parent

	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 60, 70)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 30)),
	})
	grad.Rotation = 90
	grad.Parent = btn

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(1, 0)
	corner.Parent = btn

	local stroke = Instance.new("UIStroke")
	stroke.Color = ACCENT
	stroke.Thickness = 1.8
	stroke.Transparency = RING_IDLE
	stroke.Parent = btn

	local viewport = SlotViewport.new(btn)

	local name = Instance.new("TextLabel")
	name.Name = "EmoteName"
	name.Size = Layout.NAME_LABEL_SIZE
	name.Position = Layout.NAME_LABEL_POS
	name.BackgroundTransparency = 1
	name.Text = ""
	name.TextColor3 = Color3.new(1, 1, 1)
	name.Font = Enum.Font.GothamBold
	name.TextScaled = true
	name.ZIndex = 1
	name.Parent = btn

	local ghost = name:Clone()
	ghost.Name = "NameGhost"
	ghost.ZIndex = 3
	ghost.TextTransparency = 0.8
	ghost.Parent = btn

	local badge = Instance.new("TextLabel")
	badge.Name = "Badge"
	badge.Size = UDim2.new(0.8, 0, 0.16, 0)
	badge.Position = UDim2.new(0.1, 0, 0.06, 0)
	badge.BackgroundTransparency = 1
	badge.Text = Layout.MULTI_BADGE_TEXT
	badge.TextColor3 = Layout.MULTI_BADGE_COLOR
	badge.Font = Enum.Font.GothamBold
	badge.TextScaled = true
	badge.Visible = false
	badge.ZIndex = 3
	badge.Parent = btn

	local key = Instance.new("TextLabel")
	key.Name = "Key"
	key.Size = UDim2.new(0.8, 0, 0.25, 0)
	key.Position = UDim2.new(0.1, 0, 0.55, 0)
	key.BackgroundTransparency = 1
	key.Text = Layout.SLOT_KEY_NAMES[index]
	key.TextColor3 = Color3.fromRGB(200, 200, 200)
	key.Font = Enum.Font.GothamMedium
	key.TextScaled = true
	key.ZIndex = 3
	key.Parent = btn
	Instance.new("UIStroke").Parent = key

	local arrow = Instance.new("TextLabel")
	arrow.Name = "Arrow"
	arrow.Size = UDim2.new(0.3, 0, 0.3, 0)
	arrow.Position = UDim2.new(0.65, 0, 0.1, 0)
	arrow.AnchorPoint = Vector2.new(0.5, 0.5)
	arrow.BackgroundTransparency = 1
	arrow.Text = "\u{203A}"
	arrow.TextColor3 = ACCENT
	arrow.Font = Enum.Font.GothamBold
	arrow.TextScaled = true
	arrow.TextTransparency = 0.4
	arrow.Visible = false
	arrow.ZIndex = 3
	arrow.Parent = btn

	local outlineFrame = Instance.new("Frame")
	outlineFrame.Name = "SlotOutline"
	outlineFrame.Size = UDim2.new(1, 0, 1, 0)
	outlineFrame.BackgroundTransparency = 1
	outlineFrame.ZIndex = 2
	outlineFrame.Active = false
	outlineFrame.Selectable = false
	outlineFrame.Parent = btn

	local outlineCorner = Instance.new("UICorner")
	outlineCorner.CornerRadius = UDim.new(1, 0)
	outlineCorner.Parent = outlineFrame

	local outline = Instance.new("UIStroke")
	outline.Thickness = 2.5
	outline.Transparency = OUTLINE_IDLE
	outline.Color = ACCENT
	outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	outline.Parent = outlineFrame

	local slot = {
		Handler = nil,
		IsNavigation = false,
		OpensSubmenu = false,
		Button = btn,
		NameLabel = name,
		NameGhost = ghost,
		Badge = badge,
		KeyLabel = key,
		ArrowLabel = arrow,
		Stroke = stroke,
		OutlineStroke = outline,
		Viewport = viewport,
		TargetPos = GetTargetPos(index),
	}
	self._slots[index] = slot

	btn.Activated:Connect(function()
		dbg("Activated fired on slot", index)
		self:_activateSlot(index)
	end)

	btn.MouseButton1Down:Connect(function()
		dbg("MouseButton1Down on slot", index)
	end)

	btn.MouseEnter:Connect(function()
		if not self._isOpen or slot.Handler == nil then return end
		TweenService:Create(btn, TW_HOVER, {
			Size = self._slotHoverSize,
			BackgroundColor3 = FILL_HOVER,
		}):Play()
		TweenService:Create(stroke, TW_HOVER, { Transparency = RING_HOVER, Thickness = 2.5 }):Play()
		if slot.OpensSubmenu then
			TweenService:Create(arrow, TW_HOVER, { TextTransparency = 0 }):Play()
		end
	end)

	btn.MouseLeave:Connect(function()
		if not self._isOpen then return end
		TweenService:Create(btn, TW_HOVER, {
			Size = self._slotButtonSize,
			BackgroundColor3 = FILL_IDLE,
		}):Play()
		TweenService:Create(stroke, TW_HOVER, {
			Thickness = 1.8,
			Transparency = slot.Handler == nil and 1 or RING_IDLE,
		}):Play()
		if slot.OpensSubmenu then
			TweenService:Create(arrow, TW_HOVER, { TextTransparency = 0.4 }):Play()
		end
	end)
end

function Wheel:_ensureGui()
	self._useScreenWheel = ShouldUseScreenWheel()

	if self._useScreenWheel then
		if self._screenGui and self._screenGui.Parent then return end

		self._slotButtonSize = Layout.TOUCH_BUTTON_SIZE
		self._slotHoverSize = Layout.TOUCH_HOVER_SIZE

		local gui = Instance.new("ScreenGui")
		gui.Name = "EmoteWheelScreen"
		gui.ResetOnSpawn = false
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		gui.IgnoreGuiInset = true
		gui.DisplayOrder = 80
		gui.Enabled = false
		gui.Parent = Player:WaitForChild("PlayerGui")

		local holder = Instance.new("Frame")
		holder.Name = "EmoteWheelContainer"
		holder.AnchorPoint = Vector2.new(0.5, 0.5)
		holder.Position = UDim2.new(0.5, 0, 0.5, 0)
		holder.Size = UDim2.new(SCREEN_WHEEL_SCALE, 0, SCREEN_WHEEL_SCALE, 0)
		holder.BackgroundTransparency = 1
		holder.Active = false
		holder.Selectable = false
		holder.Parent = gui

		local square = Instance.new("Frame")
		square.Name = "EmoteWheelSquare"
		square.AnchorPoint = Vector2.new(0.5, 0.5)
		square.Position = UDim2.new(0.5, 0, 0.5, 0)
		square.Size = UDim2.new(1, 0, 1, 0)
		square.BackgroundTransparency = 1
		square.Active = false
		square.Selectable = false
		square.ClipsDescendants = false
		square.Parent = holder

		local ratio = Instance.new("UIAspectRatioConstraint")
		ratio.AspectRatio = 1
		ratio.DominantAxis = Enum.DominantAxis.Height
		ratio.Parent = square

		self._screenGui = gui
		self._container = square
		self._billboard = nil
	else
		if self._billboard and self._billboard.Parent then return end

		if UIS.TouchEnabled then
			self._slotButtonSize = Layout.TOUCH_BUTTON_SIZE
			self._slotHoverSize = Layout.TOUCH_HOVER_SIZE
		else
			self._slotButtonSize = Layout.BUTTON_SIZE
			self._slotHoverSize = Layout.HOVER_SIZE
		end

		local bb = Instance.new("BillboardGui")
		bb.Name = "EmoteWheel"
		bb.Size = UDim2.new(WHEEL_STUDS, 0, WHEEL_STUDS, 0)
		bb.AlwaysOnTop = true
		bb.LightInfluence = 0
		bb.Enabled = false
		bb.ResetOnSpawn = false
		bb.StudsOffsetWorldSpace = Vector3.new(0, -0.18, 0)
		bb.Parent = Player:WaitForChild("PlayerGui")

		local anchor = Instance.new("Part")
		anchor.Name = "EmoteWheelAnchor"
		anchor.Size = Vector3.new(0.2, 0.2, 0.2)
		anchor.Transparency = 1
		anchor.CanCollide = false
		anchor.CanTouch = false
		anchor.CanQuery = false
		anchor.Anchored = true
		anchor.Locked = true
		anchor.CFrame = CFrame.new(0, -10000, 0)
		anchor.Parent = workspace

		local holder = Instance.new("Frame")
		holder.Name = "Container"
		holder.Size = UDim2.new(1, 0, 1, 0)
		holder.BackgroundTransparency = 1
		holder.Parent = bb

		self._billboard = bb
		self._billboardAnchor = anchor
		self._container = holder
		self._screenGui = nil
	end

	-- Slots live inside a Rotator frame. Spinning that one frame rotates the
	-- whole ring, so slot Positions stay static and the open/close/page tweens
	-- never have to compete with the rotation.
	local rotator = Instance.new("Frame")
	rotator.Name = "Rotator"
	rotator.AnchorPoint = Vector2.new(0.5, 0.5)
	rotator.Position = UDim2.new(0.5, 0, 0.5, 0)
	rotator.Size = UDim2.new(1, 0, 1, 0)
	rotator.BackgroundTransparency = 1
	rotator.Active = false
	rotator.Selectable = false
	rotator.Parent = self._container
	self._rotator = rotator

	table.clear(self._slots)
	for i = 1, 10 do
		self:_buildSlot(rotator, i)
	end

	self:_applyAdornee()
end

function Wheel:_applyAdornee()
	if not self._billboard then return end
	local hrp = Character and Character:FindFirstChild("HumanoidRootPart")
	self._billboard.Adornee = hrp
end

-- SLOT STATE --

function Wheel:_setSlot(index: number, label: string, handler, opensSubmenu: boolean?, locked: boolean?, animationId: string?)
	local slot = self._slots[index]
	if not slot then return end

	slot.Handler = handler
	slot.IsNavigation = false
	slot.OpensSubmenu = SHOW_SUBMENU_ARROWS and opensSubmenu == true

	slot.NameLabel.Text = label
	slot.NameGhost.Text = label

	local showBadge = locked == true
	slot.Badge.Visible = showBadge
	if showBadge then
		slot.NameLabel.Position = Layout.NAME_LABEL_POS_WITH_BADGE
		slot.NameLabel.Size = Layout.NAME_LABEL_SIZE_WITH_BADGE
	else
		slot.NameLabel.Position = Layout.NAME_LABEL_POS
		slot.NameLabel.Size = Layout.NAME_LABEL_SIZE
	end
	slot.NameGhost.Position = slot.NameLabel.Position
	slot.NameGhost.Size = slot.NameLabel.Size

	slot.ArrowLabel.Visible = slot.OpensSubmenu
	slot.Button.Visible = handler ~= nil or label ~= ""
	slot.KeyLabel.Visible = slot.Button.Visible

	slot.Stroke.Transparency = handler == nil and 1 or RING_IDLE
	slot.OutlineStroke.Transparency = handler == nil and 1 or OUTLINE_IDLE

	slot.Viewport:SetAnimation(animationId)
	slot.Viewport:SetRunning(self._isOpen and animationId ~= nil)
end

function Wheel:_setNavSlot(index: number, label: string, handler)
	self:_setSlot(index, label, handler, true, false, nil)
	local slot = self._slots[index]
	if slot then slot.IsNavigation = true end
end

function Wheel:_flashSlotRejected(index: number)
	local slot = self._slots[index]
	if not slot then return end

	local stroke, outline = slot.Stroke, slot.OutlineStroke
	TweenService:Create(stroke, TW_FLASH_IN, { Color = REJECT, Transparency = 0 }):Play()
	TweenService:Create(outline, TW_FLASH_IN, { Color = REJECT, Transparency = 0 }):Play()

	task.delay(TW_FLASH_IN.Time, function()
		TweenService:Create(stroke, TW_FLASH_OT, {
			Color = ACCENT,
			Transparency = slot.Handler == nil and 1 or RING_IDLE,
		}):Play()
		TweenService:Create(outline, TW_FLASH_OT, {
			Color = ACCENT,
			Transparency = slot.Handler == nil and 1 or OUTLINE_IDLE,
		}):Play()
	end)
end

-- PREVIEW RIGS --

local function buildPreviewRig(): Model?
	if not USE_AVATAR_PREVIEWS then return nil end

	local char = Player.Character
	if not char then return nil end
	if not char:FindFirstChildOfClass("Humanoid") then return nil end
	if not char:FindFirstChild("HumanoidRootPart") then return nil end

	local wasArchivable = char.Archivable
	char.Archivable = true
	local ok, clone = pcall(function() return char:Clone() end)
	char.Archivable = wasArchivable

	if not ok or not clone then return nil end

	for _, d in ipairs(clone:GetDescendants()) do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") then
			d:Destroy()
		elseif d:IsA("BasePart") then
			d.Anchored = false
			d.CanCollide = false
			d.CanQuery = false
			d.CanTouch = false
		elseif d:IsA("Sound") or d:IsA("ParticleEmitter") or d:IsA("Trail") then
			d:Destroy()
		end
	end

	if PREVIEW_BODY_ONLY then
		-- Tools and weapon Models sit directly under the character; drop them so
		-- the preview shows you, not a bisento filling the circle. Accessories
		-- (hair, hats) are kept -- they are part of how the character looks.
		for _, child in ipairs(clone:GetChildren()) do
			if child:IsA("Tool") or child:IsA("Model") then
				child:Destroy()
			end
		end
	end

	local hum = clone:FindFirstChildOfClass("Humanoid")
	if hum then
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.HealthDisplayDistance = 0
		hum.NameDisplayDistance = 0
		if not hum:FindFirstChildOfClass("Animator") then
			Instance.new("Animator").Parent = hum
		end
	end

	pcall(function()
		clone:PivotTo(CFrame.new(0, 0, 0))
	end)

	-- anchor the root so the rig can't drift; Motor6Ds still drive the animation
	local hrp = clone:FindFirstChild("HumanoidRootPart")
	if hrp and hrp:IsA("BasePart") then
		hrp.Anchored = true
	end

	return clone
end

function Wheel:_ensureSlotRigs()
	local char = Player.Character
	if not char then return end
	if self._rigsBuiltFor == char then
		local intact = true
		for i = 1, 10 do
			local slot = self._slots[i]
			if slot and not slot.Viewport:HasRig() then intact = false break end
		end
		if intact then return end
	end

	for i = 1, 10 do
		local slot = self._slots[i]
		if slot then
			slot.Viewport:SetRig(buildPreviewRig())
		end
	end
	self._rigsBuiltFor = char
end

function Wheel:_clearSlotRigs()
	for i = 1, 10 do
		local slot = self._slots[i]
		if slot then slot.Viewport:ClearRig() end
	end
	self._rigsBuiltFor = nil
end

function Wheel:_setSlotViewportsRunning(running: boolean)
	for i = 1, 10 do
		local slot = self._slots[i]
		if slot then slot.Viewport:SetRunning(running) end
	end
end

-- PLAY / NAVIGATION --

local function playEmote(emoteName: string): boolean
	local anim = GetEmoteAnim(emoteName)
	if not anim then return false end

	local cooldown = anim:GetAttribute("Cooldown")
	if cooldown and anim:HasTag("OnCDS") then
		sfx(5797580410, 0.75)
		return false
	end

	EmotesSet:FireServer('PlayEmote', emoteName)

	if cooldown then
		anim:AddTag("OnCDS")
		task.delay(cooldown, function()
			anim:RemoveTag("OnCDS")
		end)
	end
	return true
end

function Wheel:_transitionRebuild(kind: string, mutate)
	if not self._isOpen then
		mutate()
		self:_applyMenu()
		return
	end
	if self._uiState == "Switching" or self._uiState == "Closing" then return end

	local token = self:_bumpStateToken()
	self._uiState = "Switching"
	self:_setHoveredSlot(nil)
	self:_cancelActiveTweens()

	for _, slot in ipairs(self._slots) do
		if slot.Button.Visible then
			self:_playTween(TW_PAGE_OUT, slot.Button, {
				BackgroundTransparency = 1,
				Position = Layout.CENTER_POS,
			})
			self:_playTween(TW_PAGE_OUT, slot.Stroke, { Transparency = 1 })
			self:_playTween(TW_PAGE_OUT, slot.OutlineStroke, { Transparency = 1 })
			self:_playTween(TW_PAGE_OUT, slot.NameLabel, { TextTransparency = 1 })
			self:_playTween(TW_PAGE_OUT, slot.NameGhost, { TextTransparency = 1 })
			self:_playTween(TW_PAGE_OUT, slot.KeyLabel, { TextTransparency = 1 })
			if slot.Badge.Visible then
				self:_playTween(TW_PAGE_OUT, slot.Badge, { TextTransparency = 1 })
			end
			if slot.OpensSubmenu then
				self:_playTween(TW_PAGE_OUT, slot.ArrowLabel, { TextTransparency = 1 })
			end
		end
	end

	task.delay(TW_PAGE_OUT.Time, function()
		if not self._isOpen or self._stateToken ~= token then return end

		mutate()
		self:_applyMenu()

		for _, slot in ipairs(self._slots) do
			if slot.Button.Visible then
				slot.Button.Position = Layout.CENTER_POS
				slot.Button.BackgroundTransparency = 1
				slot.NameLabel.TextTransparency = 1
				slot.NameGhost.TextTransparency = 1
				slot.KeyLabel.TextTransparency = 1

				self:_playTween(TW_PAGE_IN, slot.Button, {
					Position = slot.TargetPos,
					BackgroundTransparency = 0.15,
				})
				self:_playTween(TW_PAGE_IN, slot.Stroke, {
					Transparency = slot.Handler == nil and 1 or RING_IDLE,
				})
				self:_playTween(TW_PAGE_IN, slot.OutlineStroke, {
					Transparency = slot.Handler == nil and 1 or OUTLINE_IDLE,
				})
				self:_playTween(TW_PAGE_IN, slot.NameLabel, { TextTransparency = 0 })
				self:_playTween(TW_PAGE_IN, slot.NameGhost, { TextTransparency = 0.8 })
				self:_playTween(TW_PAGE_IN, slot.KeyLabel, { TextTransparency = 0 })
				if slot.Badge.Visible then
					slot.Badge.TextTransparency = 1
					self:_playTween(TW_PAGE_IN, slot.Badge, { TextTransparency = 0 })
				end
				if slot.OpensSubmenu then
					slot.ArrowLabel.TextTransparency = 1
					self:_playTween(TW_PAGE_IN, slot.ArrowLabel, { TextTransparency = 0.4 })
				end
			end
		end

		task.delay(TW_PAGE_IN.Time, function()
			if self._isOpen and self._stateToken == token and self._uiState == "Switching" then
				self._uiState = "Open"
			end
		end)
	end)
end

-- MENU --

function Wheel:_applyMenu()
	self:_ensureGui()

	local page = self._page
	local slotsThisPage = maxSlotsOnPage()

	-- slot 1: close (page 1) or back to page 1 (page 2)
	if page == 1 then
		self:_setNavSlot(1, "Close", function()
			self:Close()
		end)
	else
		self:_setNavSlot(1, "Back", function()
			self:_transitionRebuild("page", function()
				self._page = 1
			end)
		end)
	end

	-- slots 2-9: the eight emotes of the current page
	for i = 2, 9 do
		local slotNum = i - 1                       -- 1..8 within the page
		-- the server may key these by string or by number; accept either
		local pageTbl = Equipped[page] or {}
		local emoteName = pageTbl[tostring(slotNum)] or pageTbl[slotNum]
		local unlocked = slotNum <= slotsThisPage

		if not unlocked then
			self:_setSlot(i, "Locked", function()
				self:_flashSlotRejected(i)
				sfx(5797580410, 0.75)
				Remotes.Gamepasses.RequestGamepass:FireServer("MoreEmotes")
			end, false, true, nil)
		elseif emoteName and emoteName ~= "" then
			local anim = GetEmoteAnim(emoteName)
			if not anim then
				emoteName = FALLBACK_EMOTE
				anim = GetEmoteAnim(FALLBACK_EMOTE)
			end

			if anim then
				EmoteIds[emoteName] = anim.AnimationId
				local captured = emoteName
				self:_setSlot(i, captured, function()
					if playEmote(captured) then
						sfx(6493287948, 0.65)
						self:Close()
					end
				end, false, false, anim.AnimationId)
			else
				self:_setSlot(i, "", nil)
			end
		else
			self:_setSlot(i, "Empty", nil, false, false, nil)
		end
	end

	-- slot 10: page navigation
	if page == 1 then
		if Passes.MoreEmotes and Passes.SecondPage then
			self:_setNavSlot(10, "More", function()
				self:_transitionRebuild("page", function()
					self._page = 2
				end)
			end)
		else
			self:_setSlot(10, "More", function()
				self:_flashSlotRejected(10)
				sfx(5797580410, 0.75)
				if not Passes.MoreEmotes then
					Remotes.Gamepasses.RequestGamepass:FireServer("MoreEmotes")
				else
					Remotes.Gamepasses.RequestGamepass:FireServer("SecondPage")
				end
			end, false, true, nil)
		end
	else
		self:_setNavSlot(10, "Page 1", function()
			self:_transitionRebuild("page", function()
				self._page = 1
			end)
		end)
	end
end

-- HOVER / GAMEPAD --

function Wheel:_setHoveredSlot(index: number?)
	if self._hoveredSlot == index then return end

	local prev = self._hoveredSlot and self._slots[self._hoveredSlot]
	if prev then
		TweenService:Create(prev.Button, TW_HOVER, {
			Size = self._slotButtonSize,
			BackgroundColor3 = FILL_IDLE,
		}):Play()
		TweenService:Create(prev.Stroke, TW_HOVER, {
			Thickness = 1.8,
			Transparency = prev.Handler == nil and 1 or RING_IDLE,
		}):Play()
		if prev.OpensSubmenu then
			TweenService:Create(prev.ArrowLabel, TW_HOVER, { TextTransparency = 0.4 }):Play()
		end
	end

	self._hoveredSlot = index

	local cur = index and self._slots[index]
	if cur and cur.Handler ~= nil then
		TweenService:Create(cur.Button, TW_HOVER, {
			Size = self._slotHoverSize,
			BackgroundColor3 = FILL_HOVER,
		}):Play()
		TweenService:Create(cur.Stroke, TW_HOVER, { Transparency = RING_HOVER, Thickness = 2.5 }):Play()
		if cur.OpensSubmenu then
			TweenService:Create(cur.ArrowLabel, TW_HOVER, { TextTransparency = 0 }):Play()
		end
	end
end

local function readStick(deadzone: number): (number, number)
	local state = UIS:GetGamepadState(Enum.UserInputType.Gamepad1)
	local bx, by, bm = 0, 0, 0
	for _, input in ipairs(state) do
		if input.KeyCode == Enum.KeyCode.Thumbstick1 or input.KeyCode == Enum.KeyCode.Thumbstick2 then
			local x, y = input.Position.X, input.Position.Y
			local mag = math.sqrt(x * x + y * y)
			if mag > bm then bx, by, bm = x, y, mag end
		end
	end
	if bm < deadzone then return 0, 0 end
	return bx, by
end

function Wheel:_getClosestSlotToStick(x: number, y: number): number?
	local target = math.atan2(-y, x)
	local best, bestDelta = nil, math.huge
	for i = 1, 10 do
		local slot = self._slots[i]
		if slot and slot.Handler ~= nil then
			local d = self:_slotAngle(i) - target
			local delta = math.abs(math.atan2(math.sin(d), math.cos(d)))
			if delta < bestDelta then best, bestDelta = i, delta end
		end
	end
	return best
end

-- Number keys must go through ContextActionService, not UserInputService:
-- UIS cannot consume input, so the combat system would fire a skill on the
-- same keypress. Sink here so 1-0 belong to the wheel while it is open.
function Wheel:_bindNumberKeys()
	if not BIND_NUMBER_KEYS or self._numberKeysBound then return end

	ContextActionService:BindActionAtPriority("EmoteWheelSlots", function(_, state, input)
		if state ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Sink
		end
		for i, keyCode in ipairs(GAMEPAD_KEYS) do
			if input.KeyCode == keyCode then
				self:_activateSlot(i)
				break
			end
		end
		-- sink regardless of whether the slot was usable, so no skill fires
		return Enum.ContextActionResult.Sink
	end, false, 3000, table.unpack(GAMEPAD_KEYS))

	self._numberKeysBound = true
	dbg("number keys bound (sinking 1-0)")
end

function Wheel:_unbindNumberKeys()
	if not self._numberKeysBound then return end
	ContextActionService:UnbindAction("EmoteWheelSlots")
	self._numberKeysBound = false
	dbg("number keys released")
end

-- Rotation is driven by advancing every slot's TargetPos, so the open/close and
-- page tweens keep aiming at the live position instead of snapping back to the
-- static ring. Only Position moves, so the circles stay upright by default.
function Wheel:_slotAngle(index: number): number
	local spin = self._rotator and math.rad(self._rotator.Rotation) or 0
	return (Layout.SLOT_ANGLES[index] or 0) + spin
end

-- One looping linear tween on the Rotator, plus one per button to counter it so
-- the circles stay upright. The engine interpolates these in C: no Lua runs per
-- frame, so the drift cannot stutter from script scheduling.
function Wheel:_startRotation()
	self:_stopRotation()
	if not (ROTATE_WHEEL and self._rotator) then return end

	local info = TweenInfo.new(
		360 / math.max(ROTATE_SPEED, 0.01),
		Enum.EasingStyle.Linear,
		Enum.EasingDirection.InOut,
		-1 -- repeat forever; 360 deg wraps to 0 so the loop is seamless
	)

	self._rotator.Rotation = 0
	local spin = TweenService:Create(self._rotator, info, { Rotation = 360 })
	spin:Play()
	self._rotationTweens = { spin }

	if not ROTATE_SLOT_FACES then
		for i = 1, 10 do
			local slot = self._slots[i]
			if slot then
				slot.Button.Rotation = 0
				local counter = TweenService:Create(slot.Button, info, { Rotation = -360 })
				counter:Play()
				table.insert(self._rotationTweens, counter)
			end
		end
	end
	dbg("rotation started:", ROTATE_SPEED, "deg/sec")
end

function Wheel:_stopRotation()
	if self._rotationTweens then
		for _, t in ipairs(self._rotationTweens) do
			pcall(function() t:Cancel() end)
		end
		self._rotationTweens = nil
	end
	if self._rotator then self._rotator.Rotation = 0 end
	for i = 1, 10 do
		local slot = self._slots[i]
		if slot then slot.Button.Rotation = 0 end
	end
end

-- Shiftlock and first person pin the cursor to screen centre, and there
-- mouse-look IS the camera control -- a free cursor kills it outright.
--
-- This has to be re-checked every frame, not decided once at open: shiftlock
-- can be toggled WHILE the wheel is up. Deciding once left Modal forcing the
-- cursor free after the camera had gone to LockCenter, so the reticle showed
-- but the mouse still slid around.
--
-- We never assign MouseBehavior ourselves. CameraUtils saves/restores it by
-- comparing against its own last override, so writing it from outside corrupts
-- that bookkeeping. Modal alone is enough to free the cursor.
function Wheel:_updateCursorMode()
	local wantModal = FREE_CURSOR and UIS.MouseBehavior ~= Enum.MouseBehavior.LockCenter
	if wantModal ~= self._modalOn then
		self:_setModal(wantModal)
		dbg(wantModal and "cursor freed (clickable)" or "cursor locked - camera has it, number keys only")
	end
end

function Wheel:_setModal(on: boolean)
	self._modalOn = on
	for i = 1, 10 do
		local slot = self._slots[i]
		if slot then slot.Button.Modal = on end
	end
end

function Wheel:_startStickPolling()
	if self._stickConn then return end
	self._stickConn = RunService.Heartbeat:Connect(function()
		if not self._isOpen then return end

		self:_updateCursorMode()

		if self._uiState ~= "Open" then return end
		local x, y = readStick(self._stickDeadzone)
		if x == 0 and y == 0 then
			if self._hoveredSlot ~= nil then self:_setHoveredSlot(nil) end
			return
		end
		local target = self:_getClosestSlotToStick(x, y)
		if target ~= self._hoveredSlot then self:_setHoveredSlot(target) end
	end)
end

function Wheel:_stopStickPolling()
	if self._stickConn then
		self._stickConn:Disconnect()
		self._stickConn = nil
	end
	self:_setHoveredSlot(nil)
end

function Wheel:_setControllerJumpBlocked(blocked: boolean)
	if self._jumpSinkBound then
		ContextActionService:UnbindAction("EmoteWheelBlockJump")
		self._jumpSinkBound = false
	end
	if not blocked then return end

	ContextActionService:BindActionAtPriority("EmoteWheelBlockJump", function()
		return Enum.ContextActionResult.Sink
	end, false, 3000, Enum.KeyCode.ButtonA)
	self._jumpSinkBound = true
end

function Wheel:_activateSlot(index: number)
	if not self._isOpen then
		dbg("activate rejected: wheel not open")
		return
	end
	if self._uiState ~= "Open" and self._uiState ~= "Opening" then
		dbg("activate rejected: uiState is", self._uiState)
		return
	end

	local slot = self._slots[index]
	if not slot then
		dbg("activate rejected: no slot", index)
		return
	end
	if slot.Handler == nil then
		dbg("activate rejected: slot", index, "has no handler (label:", slot.NameLabel.Text .. ")")
		return
	end

	if slot.IsNavigation then
		sfx(5797580410, 0.75)
	end
	slot.Handler()
end

-- OPEN / CLOSE --

function Wheel:_openVisual()
	self:_ensureGui()

	if self._useScreenWheel then
		if not self._screenGui then return end
		self._screenGui.Enabled = true
	else
		if not self._billboard then return end
		self:_applyAdornee()
		self._billboard.Enabled = true
	end

	self:_cancelActiveTweens()
	self:_ensureSlotRigs()
	self:_setSlotViewportsRunning(true)
	self:_startRotation()
	self:_startStickPolling()

	local token = self:_bumpStateToken()
	self._uiState = "Opening"

	for _, slot in ipairs(self._slots) do
		if slot.Button.Visible then
			slot.Button.Position = Layout.CENTER_POS
			slot.Button.BackgroundTransparency = 0.15
			slot.NameLabel.TextTransparency = 0
			slot.NameGhost.TextTransparency = 0.8
			slot.KeyLabel.TextTransparency = 0
			if slot.Badge.Visible then slot.Badge.TextTransparency = 0 end
			if slot.OpensSubmenu then slot.ArrowLabel.TextTransparency = 0.4 end

			self:_playTween(TW_OPEN, slot.Button, { Position = slot.TargetPos })
			self:_playTween(TW_OPEN, slot.Stroke, {
				Thickness = 1.8,
				Transparency = slot.Handler == nil and 1 or RING_IDLE,
			})
			self:_playTween(TW_OPEN, slot.OutlineStroke, {
				Transparency = slot.Handler == nil and 1 or OUTLINE_IDLE,
			})
		else
			slot.Button.Position = Layout.CENTER_POS
			slot.KeyLabel.Visible = false
		end
	end

	task.delay(TW_OPEN.Time + 0.01, function()
		if not self._isOpen or self._stateToken ~= token then return end
		if self._uiState == "Opening" then self._uiState = "Open" end
	end)
end

function Wheel:_closeVisual()
	local token = self:_bumpStateToken()
	self._uiState = "Closing"
	self:_stopStickPolling()

	for _, slot in ipairs(self._slots) do
		if slot.Button.Visible then
			self:_playTween(TW_CLOSE, slot.Button, {
				Position = Layout.CENTER_POS,
				BackgroundTransparency = 1,
			})
			self:_playTween(TW_CLOSE, slot.Stroke, { Transparency = 1 })
			self:_playTween(TW_CLOSE, slot.OutlineStroke, { Transparency = 1 })
			self:_playTween(TW_CLOSE, slot.NameLabel, { TextTransparency = 1 })
			self:_playTween(TW_CLOSE, slot.NameGhost, { TextTransparency = 1 })
			self:_playTween(TW_CLOSE, slot.KeyLabel, { TextTransparency = 1 })
			if slot.Badge.Visible then
				self:_playTween(TW_CLOSE, slot.Badge, { TextTransparency = 1 })
			end
			if slot.OpensSubmenu then
				self:_playTween(TW_CLOSE, slot.ArrowLabel, { TextTransparency = 1 })
			end
		end
	end

	task.delay(TW_CLOSE.Time, function()
		if self._stateToken ~= token then return end
		if self._screenGui then self._screenGui.Enabled = false end
		if self._billboard then self._billboard.Enabled = false end
		self:_setSlotViewportsRunning(false)
		self:_setModal(false)
		self:_stopRotation()
		self._uiState = "Closed"
	end)
end

function Wheel:IsOpen(): boolean
	return self._isOpen
end

function Wheel:Open()
	if self._uiState ~= "Closed" then return end

	local char = Player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	Character = char
	self._isOpen = true
	self._page = 1
	self:_setControllerJumpBlocked(true)
	self:_bindNumberKeys()

	-- ContextActionService sinking does NOT stop UserInputService.InputBegan
	-- listeners, and the hotbar listens that way. Other scripts check this flag.
	shared.emoteWheelOpen = true

	self._modalOn = false
	self:_updateCursorMode()

	self:_applyMenu()
	self:_openVisual()
end

function Wheel:Close()
	if self._uiState ~= "Open" and self._uiState ~= "Opening" and self._uiState ~= "Switching" then
		return
	end
	self._isOpen = false
	shared.emoteWheelOpen = false
	self:_setControllerJumpBlocked(false)
	self:_unbindNumberKeys()
	self:_setModal(false)
	self:_cancelActiveTweens()
	self:_closeVisual()
end

function Wheel:Toggle()
	if self._uiState == "Opening" or self._uiState == "Closing" or self._uiState == "Switching" then
		return
	end
	if self._isOpen then self:Close() else self:Open() end
end

-- DATA WIRING --

local function refreshEquipped()
	local ok, p1, p2 = pcall(function()
		return Remotes.Emotes.GetEquippedEmotes:InvokeServer()
	end)
	if not ok then
		dbg("GetEquippedEmotes FAILED:", p1)
		return
	end
	Equipped[1] = p1 or {}
	Equipped[2] = p2 or {}

	if DEBUG then
		for page = 1, 2 do
			local parts = {}
			for k, v in pairs(Equipped[page]) do
				table.insert(parts, string.format("[%s(%s)]=%s", tostring(k), typeof(k), tostring(v)))
			end
			dbg("equipped page " .. page .. ":", #parts > 0 and table.concat(parts, " ") or "(empty)")
		end
	end
end

local function cacheOwnedEmotes()
	local ok, owned = pcall(function()
		return Remotes.Emotes.GetOwnedEmotes:InvokeServer()
	end)
	if not ok or not owned then return end
	for _, emoteName in owned do
		local anim = GetEmoteAnim(emoteName)
		if anim then EmoteIds[anim.Name] = anim.AnimationId end
	end
end

refreshPasses()
cacheOwnedEmotes()
refreshEquipped()

Wheel:_ensureGui()
Wheel:_applyMenu()

-- live updates from the server (same contract as the old Handler)
EmotesSet.OnClientEvent:Connect(function(Action: string, Params: { any })
	if Action == 'UpdateOwnedEmotes' then
		for _, emoteName in Params.OwnedEmotes do
			if EmoteIds[emoteName] then continue end
			local anim = GetEmoteAnim(emoteName)
			if anim then EmoteIds[emoteName] = anim.AnimationId end
		end
	elseif Action == "SlotUpdated" then
		local pageIndex = Params.Page == "Emotes" and 1 or 2
		local slotNum = tostring(Params.Slot)
		Equipped[pageIndex] = Equipped[pageIndex] or {}
		Equipped[pageIndex][slotNum] = Params.EmoteName
		if Wheel._isOpen and Wheel._page == pageIndex then
			Wheel:_applyMenu()
		end
	end
end)

Remotes.Gamepasses.GamepassPurchased.OnClientEvent:Connect(function()
	refreshPasses()
	refreshEquipped()
	if Wheel._isOpen then
		Wheel:_applyMenu()
	end
end)

Player.CharacterAdded:Connect(function(char)
	Character = char
	Wheel:_clearSlotRigs()
	if Wheel._isOpen then Wheel:Close() end
	task.defer(function()
		Wheel:_applyAdornee()
	end)
end)

-- INPUT --

UIS.InputBegan:Connect(function(input, processed)
	if processed and input.UserInputType ~= Enum.UserInputType.Gamepad1 then return end
	if UIS:GetFocusedTextBox() ~= nil then return end
	if not Wheel._isOpen then return end

	if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonA then
		local target = Wheel._hoveredSlot
		if not target then
			local x, y = readStick(Wheel._stickDeadzone)
			if x ~= 0 or y ~= 0 then
				target = Wheel:_getClosestSlotToStick(x, y)
			end
		end
		if target then Wheel:_activateSlot(target) end
		return
	end

	if input.UserInputType == Enum.UserInputType.Gamepad1 and input.KeyCode == Enum.KeyCode.ButtonB then
		Wheel:Close()
		return
	end

	-- number keys are handled by ContextActionService (see _bindNumberKeys) so
	-- they can be sunk; handling them here too would double-fire.
end)

-- PUBLIC TOGGLE (kept identical to the old Handler's contract) --

shared.emotegui = function()
	if not Wheel:IsOpen() then
		for _, ScreenGUI in pairs(Player.PlayerGui:GetChildren()) do
			if ScreenGUI.Name == "Cape Customization"
				or ScreenGUI.Name == "Awakening Outfit"
				or ScreenGUI.Name == "Kill Sound" then
				game:GetService("Debris"):AddItem(ScreenGUI, 0)
			end

			if ScreenGUI.Name == "Cosmetics" or ScreenGUI.Name == "Gifting" then
				local GoalFrame = ScreenGUI:FindFirstChild("Frame")
				if GoalFrame then
					GoalFrame.Visible = true
					GoalFrame.Visible = false
				end
			end
		end
	end

	Wheel:Toggle()
end

--print("Emote wheel handler started")
