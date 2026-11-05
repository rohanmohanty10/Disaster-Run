
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Modules = ReplicatedStorage:WaitForChild("Modules")
local DashCooldown = require(Modules:WaitForChild("DashCooldown"))

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")


local FRONT_ICON = "rbxassetid://84865076341319"
local BACK_ICON = "rbxassetid://132430737093990"
local LEFT_ICON = "rbxassetid://100145897883428"
local RIGHT_ICON = "rbxassetid://105649999959141"

local SLOT_CONFIG = {
	{
		name = "ForwardDashCD",
		key = DashCooldown.Keys.Forward,
		default = FRONT_ICON,
		icons = { Front = FRONT_ICON, Back = BACK_ICON },
	},
	{
		name = "SideDashCD",
		key = DashCooldown.Keys.Side,
		default = LEFT_ICON,
		icons = { Left = LEFT_ICON, Right = RIGHT_ICON },
	},
}

local DIRECTION_ATTRIBUTE = "LastDashDirection"

local TILE_TRANSPARENCY = 0.5
local TILE_COLOR = Color3.fromRGB(0, 0, 0)

--Cooldown fill.
local FILL_COLOR = Color3.fromRGB(255, 78, 78)
local FILL_TRANSPARENCY = 0.5
local FILL_READY_COLOR = Color3.fromRGB(255, 255, 255)

--The white pop when the cooldown ends.
local FLASH_COLOR = Color3.fromRGB(255, 255, 255)

local CORNER_RADIUS = UDim.new(0.25, 0)
local ASPECT_RATIO = 0.916066051
local MIN_TILE = Vector2.new(30, 30)
local MAX_TILE = Vector2.new(70, 70)

--Tween timings.
local FADE_IN = 0.64
local FADE_OUT = 1.5
local COLLAPSE = 0.23
local FLASH_POP = 0.23
local FLASH_FADE = 0.4
local READY_REFILL = 0.64
local READY_HOLD = 0.5
local READY_FADE = 1

--How far the tile drops as it leaves, in fractions of its own height.
local SLIDE_OUT = 0.6

--The original multiplies every duration by this before animating.
local TIMER_SCALE = 0.96

local CONTAINER_WIDTH = 0.506
local CONTAINER_HEIGHT = 0.069
local CONTAINER_SCALE = 0.85
local SLOT_WIDTH = 0.06
local SLOT_HEIGHT = 0.7
local SLOT_GAP = 0.008

local UP_OFFSET = 110
local RIGHT_OFFSET = 150


local START_SLID_OUT = false

--Build ----------------------------------------------------------------------

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DashCooldownGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 5
screenGui.Parent = PlayerGui

local container = Instance.new("Frame")
container.Name = "OtherCDS"
container.AnchorPoint = Vector2.new(0.5, 1)
container.BackgroundTransparency = 1
container.BorderSizePixel = 0
container.ClipsDescendants = false
container.Position = UDim2.new(0.5, RIGHT_OFFSET, 1, -UP_OFFSET)
container.Size = UDim2.fromScale(CONTAINER_WIDTH, CONTAINER_HEIGHT)
container.ZIndex = 0
container.Parent = screenGui

local containerScale = Instance.new("UIScale")
containerScale.Scale = CONTAINER_SCALE
containerScale.Parent = container

local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Horizontal
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
listLayout.Padding = UDim.new(SLOT_GAP, 0)
listLayout.Parent = container

--The draining bar. Cloned fresh per activation, exactly like the source clones
--ReplicatedStorage.Effects.Cooldown.
local function buildFill()
	local fill = Instance.new("Frame")
	fill.Name = "Cooldown"
	fill.AnchorPoint = Vector2.new(0.5, 0)
	fill.BackgroundColor3 = FILL_COLOR
	fill.BackgroundTransparency = FILL_TRANSPARENCY
	fill.BorderSizePixel = 0
	fill.Position = UDim2.new(0.5, 0, 0, 0)
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.ZIndex = 2

	local gradient = Instance.new("UIGradient")
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(88, 88, 88)),
	})
	gradient.Rotation = 90
	gradient.Parent = fill

	local corner = Instance.new("UICorner")
	corner.Name = "IconCorner"
	corner.CornerRadius = CORNER_RADIUS
	corner.Parent = fill

	return fill
end

--The white pop on the frame the cooldown ends.
local function buildFlash()
	local flash = Instance.new("Frame")
	flash.Name = "OffCD"
	flash.AnchorPoint = Vector2.new(0.5, 0)
	flash.BackgroundColor3 = FLASH_COLOR
	flash.BackgroundTransparency = 0
	flash.BorderSizePixel = 0
	flash.Position = UDim2.new(0.5, 0, -0.25, 0)
	flash.Size = UDim2.new(0, 0, 0, 0)
	flash.ZIndex = 3

	local corner = Instance.new("UICorner")
	corner.Name = "IconCorner"
	corner.CornerRadius = CORNER_RADIUS
	corner.Parent = flash

	return flash
end

local slots = {}
local slotsByKey = {}

local function buildSlot(config, order)
	--Outer frame: owned by the list layout, never animated.
	local comp = Instance.new("Frame")
	comp.Name = config.name
	comp.AnchorPoint = Vector2.new(0, 0)
	comp.BackgroundTransparency = 1
	comp.BorderSizePixel = 0
	comp.ClipsDescendants = false
	comp.LayoutOrder = order
	comp.Size = UDim2.fromScale(SLOT_WIDTH, SLOT_HEIGHT)
	comp.ZIndex = 1
	comp.Parent = container

	local sizeConstraint = Instance.new("UISizeConstraint")
	sizeConstraint.MinSize = MIN_TILE
	sizeConstraint.MaxSize = MAX_TILE
	sizeConstraint.Parent = comp

	--Inner frame: the visible tile, and the only thing the animation moves.
	local frame = Instance.new("Frame")
	frame.Name = "Frame"
	frame.AnchorPoint = Vector2.new(0, 0)
	frame.BackgroundColor3 = TILE_COLOR
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ClipsDescendants = false
	frame.Position = UDim2.new(0, 0, 0, 0)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.ZIndex = 1
	frame.Parent = comp

	--Stored once, then used as the target of every slide. The source keeps this
	--on an attribute for the same reason: once the tile has slid away, its
	--Position no longer tells you where it belongs.
	frame:SetAttribute("pos", frame.Position)

	if START_SLID_OUT then
		frame.Position = frame.Position + UDim2.new(0, 0, SLIDE_OUT, 0)
	end

	local gradient = Instance.new("UIGradient")
	gradient.Name = "IconGradient"
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(220, 220, 220)),
	})
	gradient.Rotation = 90
	gradient.Parent = frame

	local corner = Instance.new("UICorner")
	corner.Name = "IconCorner"
	corner.CornerRadius = CORNER_RADIUS
	corner.Parent = frame

	local icon = Instance.new("ImageLabel")
	icon.Name = "IconImage"
	icon.AnchorPoint = Vector2.new(0.5, 0.5)
	icon.BackgroundTransparency = 1
	icon.BorderSizePixel = 0
	icon.Image = config.default
	icon.ImageTransparency = 1
	icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	icon.ScaleType = Enum.ScaleType.Fit
	icon.Size = UDim2.new(1, 0, 1, 0)
	icon.ZIndex = 1
	icon.Parent = frame

	local aspect = Instance.new("UIAspectRatioConstraint")
	aspect.AspectRatio = ASPECT_RATIO
	aspect.Parent = frame

	local scale = Instance.new("UIScale")
	scale.Scale = 1
	scale.Parent = frame

	local slot = {
		key = config.key,
		comp = comp,
		frame = frame,
		icon = icon,
		icons = config.icons,
		default = config.default,
		fill = nil,
		--Bumped on every activation and every cancel. Anything running async
		--checks it before touching the slot, which is how the source's
		--_cdguiCleanups table stops a finished cooldown from stomping a new one.
		token = 0,
		tweens = {},
	}

	table.insert(slots, slot)

	local list = slotsByKey[config.key]
	if not list then
		list = {}
		slotsByKey[config.key] = list
	end

	table.insert(list, slot)
end

for order, config in SLOT_CONFIG do
	buildSlot(config, order)
end

--Animation ------------------------------------------------------------------

--Plays a tween and remembers it, so a restart can cancel it mid flight.
local function play(slot, instance, info, goal)
	local tween = TweenService:Create(instance, info, goal)
	table.insert(slot.tweens, tween)
	tween:Play()

	return tween
end

local function cancelTweens(slot)
	for _, tween in slot.tweens do
		tween:Cancel()
	end

	table.clear(slot.tweens)
end

--Fades the tile out and drops it by SLIDE_OUT. Used both when a cooldown ends
--cleanly and when it is cleared early.
local function slideAway(slot, duration)
	local rest = slot.frame:GetAttribute("pos")

	play(slot, slot.frame, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
		BackgroundTransparency = 1,
		Position = rest + UDim2.new(0, 0, SLIDE_OUT, 0),
	})

	play(slot, slot.icon, TweenInfo.new(duration, Enum.EasingStyle.Quad), {
		ImageTransparency = 1,
	})
end

--The cooldown reached zero: pop the flash, flick the fill white and refill it,
--then take the tile away.
local function finish(slot, token)
	local fill = slot.fill

	if fill and fill.Parent then
		local flash = buildFlash()
		flash.Parent = fill

		TweenService:Create(flash, TweenInfo.new(FLASH_POP, Enum.EasingStyle.Circular), {
			Position = UDim2.new(0.5, 0, -0.25, 0),
			Size = UDim2.new(1.5, 0, 1.5, 0),
		}):Play()

		TweenService:Create(flash, TweenInfo.new(FLASH_FADE, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 1,
		}):Play()

		Debris:AddItem(flash, 1)

		play(slot, fill, TweenInfo.new(READY_REFILL, Enum.EasingStyle.Circular), {
			BackgroundColor3 = FILL_READY_COLOR,
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
		})
	end

	slideAway(slot, FADE_OUT)

	task.delay(READY_HOLD, function()
		if slot.token ~= token then
			return
		end

		if fill and fill.Parent then
			play(slot, fill, TweenInfo.new(READY_FADE, Enum.EasingStyle.Quad), {
				BackgroundTransparency = 1,
			})
		end
	end)
end

--A cooldown started. Everything after this point runs on tweens, so there is
--no per frame work while a bar drains.
local function start(slot, duration, direction)
	duration = duration * TIMER_SCALE
	if duration <= 0 then
		return
	end

	slot.token += 1
	local token = slot.token

	cancelTweens(slot)

	if slot.fill then
		slot.fill:Destroy()
		slot.fill = nil
	end

	--Point the tile at the direction that started this cooldown. Both callers
	--only start a cooldown that is not already running, so the icon is always
	--faded out at this moment and the swap is never visible.
	slot.icon.Image = (direction and slot.icons[direction]) or slot.default

	local rest = slot.frame:GetAttribute("pos")

	play(slot, slot.frame, TweenInfo.new(FADE_IN, Enum.EasingStyle.Quad), {
		BackgroundTransparency = TILE_TRANSPARENCY,
		Position = rest,
	})

	play(slot, slot.icon, TweenInfo.new(FADE_IN, Enum.EasingStyle.Quad), {
		ImageTransparency = 0,
	})

	local fill = buildFill()
	fill.Parent = slot.frame
	slot.fill = fill

	play(slot, fill, TweenInfo.new(FADE_IN, Enum.EasingStyle.Quad), {
		Size = UDim2.new(1, 0, 1, 0),
		Position = UDim2.new(0.5, 0, 0, 0),
	})

	--The source waits out the fade in before starting the drain, so the bar
	--only begins falling once the tile is fully up.
	local drain = duration - FADE_IN

	task.delay(FADE_IN, function()
		if slot.token ~= token or not fill.Parent then
			return
		end

		if drain > 0 then
			play(slot, fill, TweenInfo.new(drain, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0),
				Position = UDim2.new(0.5, 0, 1, 0),
			})
		end

		task.delay(math.max(drain, 0), function()
			if slot.token ~= token then
				return
			end

			finish(slot, token)
		end)
	end)
end

--The cooldown was cleared before it ran out, so drop everything early.
local function cancel(slot)
	slot.token += 1

	cancelTweens(slot)
	slideAway(slot, FADE_OUT)

	local fill = slot.fill
	slot.fill = nil

	if fill and fill.Parent then
		TweenService:Create(fill, TweenInfo.new(COLLAPSE, Enum.EasingStyle.Quad), {
			Size = UDim2.new(1, 0, 0, 0),
		}):Play()

		Debris:AddItem(fill, 0.25)
	end
end

--Snaps a slot back to rest with no animation. Respawn only.
local function reset(slot)
	slot.token += 1

	cancelTweens(slot)

	if slot.fill then
		slot.fill:Destroy()
		slot.fill = nil
	end

	local rest = slot.frame:GetAttribute("pos")

	slot.frame.BackgroundTransparency = 1
	slot.frame.Position = if START_SLID_OUT then rest + UDim2.new(0, 0, SLIDE_OUT, 0) else rest
	slot.icon.ImageTransparency = 1
end

--Wiring ---------------------------------------------------------------------

--DashCooldown fires Changed on Start and on Clear, never on natural expiry --
--which is all this needs, since the drain is a tween that finishes on its own.
DashCooldown.Changed:Connect(function(key)
	local list = slotsByKey[key]
	if not list then
		return
	end

	local running = DashCooldown.GetRemaining(key) > 0

	--DashCheck writes the direction before it starts anything, so by the time
	--this fires the attribute already describes the dash that caused it. That
	--holds for the front dash too: the direction is written locally on the
	--keypress, while the cooldown only arrives once the server tags DashCD, and
	--nothing else can dash in between because the cooldown is running.
	local character = Player.Character
	local direction = character and character:GetAttribute(DIRECTION_ATTRIBUTE)

	for _, slot in list do
		if running then
			start(slot, DashCooldown.GetDuration(key), direction)
		else
			cancel(slot)
		end
	end
end)

--The client predicts its own side and back dashes, but the front dash cooldown
--is only known once the server tags the character, so pick those up too.
for key, tag in DashCooldown.Tags do
	CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance)
		if instance == Player.Character then
			DashCooldown.StartIfIdle(key, instance)
		end
	end)
end

Player.CharacterAdded:Connect(function()
	DashCooldown.ClearAll()

	for _, slot in slots do
		reset(slot)
	end
end)

for _, config in SLOT_CONFIG do
	for direction, icon in config.icons do
		if icon == "rbxassetid://0" then
			warn(`DashCooldownHud: no icon set for the {direction} dash.`)
		end
	end
end
