-- StarterPlayer > StarterPlayerScripts > EmoteMenuClient   (LocalScript, client)
--
-- The Emotes menu (split out of the old Cosmetics menu), in the Store / Quests style:
--   left    every emote: yours play on your own avatar when hovered; the rest are dimmed
--   right   your wheel: the same 10 circles, in the same places, as the in-game emote wheel
--           (StarterGui.Emotes.WheelHandler2D). Pick an emote, then click a circle to put it there.
--   bottom  your emote spins: SPIN, and "Get spins" (opens the Store, which sells them)
--
-- It uses your existing server pipeline unchanged (the same calls the old EmotesModule made):
--   Remotes.Emotes.GetOwnedEmotes / GetEquippedEmotes / ChangeEmotes / SpinEmote
--   Remotes.Emotes.Set (UpdateOwnedEmotes, SlotUpdated), Player attribute EmoteSpins
--   Remotes.Comunicator.GetGamepasses ("MoreEmotes", "SecondPage"), Remotes.Gamepasses
-- The in-game wheel you use while fighting is untouched and still opens from the Emotes button.
-- This menu opens with shared.emotemenu() (the Emotes button in the Cosmetics menu, or a top-bar
-- button you add in Icons).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))

local Player = Players.LocalPlayer
repeat
	task.wait()
until game:IsLoaded() and Player:GetAttribute("Loaded") == true

local InfoModule = require(ReplicatedStorage:WaitForChild("Info"))
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local EmoteRemotes = Remotes:WaitForChild("Emotes")
local EmotesFolder = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Animations"):WaitForChild("Emotes")

------------------------------------------------------------------------
-- Look
------------------------------------------------------------------------
local RGB = Color3.fromRGB
local THEME = ColorSequence.new(RGB(232, 226, 214), RGB(150, 142, 130))
local DONE = ColorSequence.new(RGB(184, 216, 156), RGB(116, 162, 96))
local CARD = RGB(24, 24, 24)
local PANEL = RGB(16, 16, 16)
local EDGE = RGB(55, 55, 55)
local MUTED = RGB(170, 166, 158)
local RARITY_ORDER = { Secret = 7, Mythic = 6, Legendary = 5, Epic = 4, Rare = 3, Uncommon = 2, Common = 1 }

local function Sfx(Id: string, Volume: number)
	local Play = (shared :: any).sfx
	if Play then
		Play({ SoundId = Id, Parent = workspace, Volume = Volume }):Play()
	end
end

------------------------------------------------------------------------
-- Data
------------------------------------------------------------------------
type Emote = { Name: string, Rarity: string, Color: Color3, Animation: Animation }
local Emotes: { Emote } = {}
local ByName: { [string]: Emote } = {}

for _, Anim in EmotesFolder:GetDescendants() do
	if Anim:IsA("Animation") then
		local Rarity = if Anim.Parent and Anim.Parent:IsA("Folder") and Anim.Parent ~= EmotesFolder then Anim.Parent.Name else "Common"
		local Data = InfoModule.EmoteRarities and InfoModule.EmoteRarities[Rarity]
		local Entry = { Name = Anim.Name, Rarity = Rarity, Color = if Data then Data.Color else UI.Colors.White, Animation = Anim }
		table.insert(Emotes, Entry)
		ByName[Anim.Name] = Entry
	end
end
table.sort(Emotes, function(A, B)
	local RA, RB = RARITY_ORDER[A.Rarity] or 0, RARITY_ORDER[B.Rarity] or 0
	return if RA ~= RB then RA > RB else A.Name < B.Name
end)

local Owned: { [string]: boolean } = {}
local EquippedSlots: { [string]: string } = {} -- ["1_3"] = emote on page 1, slot 3
local HasMoreEmotes, HasSecondPage = false, false

pcall(function()
	for _, Name in EmoteRemotes.GetOwnedEmotes:InvokeServer() or {} do
		Owned[Name] = true
	end
	local Page1, Page2 = EmoteRemotes.GetEquippedEmotes:InvokeServer()
	for Slot, Name in Page1 or {} do
		EquippedSlots["1_" .. Slot] = Name
	end
	for Slot, Name in Page2 or {} do
		EquippedSlots["2_" .. Slot] = Name
	end
end)
local function RefreshPasses()
	pcall(function()
		HasMoreEmotes = Remotes.Comunicator.GetGamepasses:InvokeServer("MoreEmotes") == true
		HasSecondPage = Remotes.Comunicator.GetGamepasses:InvokeServer("SecondPage") == true
	end)
end
RefreshPasses()

------------------------------------------------------------------------
-- Your avatar, for the previews (body only, framed the same as the wheel's)
------------------------------------------------------------------------
local PREVIEW_HEIGHT = 5

local function BuildRig(): Model?
	local Character = Player.Character
	if not Character or not Character:FindFirstChild("HumanoidRootPart") then
		return nil
	end
	local Was = Character.Archivable
	Character.Archivable = true
	local Ok, Clone = pcall(Character.Clone, Character)
	Character.Archivable = Was
	if not Ok or not Clone then
		return nil
	end
	for _, Child in Clone:GetChildren() do
		if Child:IsA("Tool") or Child:IsA("Model") then
			Child:Destroy()
		end
	end
	for _, Item in Clone:GetDescendants() do
		if Item:IsA("BaseScript") or Item:IsA("ModuleScript") or Item:IsA("Sound") or Item:IsA("ParticleEmitter") or Item:IsA("Trail") then
			Item:Destroy()
		elseif Item:IsA("BasePart") then
			Item.CanCollide, Item.CanQuery, Item.CanTouch = false, false, false
		end
	end
	local Humanoid = Clone:FindFirstChildOfClass("Humanoid")
	if Humanoid then
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		if not Humanoid:FindFirstChildOfClass("Animator") then
			Instance.new("Animator").Parent = Humanoid
		end
	end
	pcall(Clone.PivotTo, Clone, CFrame.new())
	local Root = Clone:FindFirstChild("HumanoidRootPart")
	if Root and Root:IsA("BasePart") then
		Root.Anchored = true
	end
	return Clone
end

type Stage = { Viewport: ViewportFrame, World: WorldModel, Camera: Camera, Rig: Model?, Animator: Animator?, Track: AnimationTrack? }

local function MakeStage(Parent: GuiObject, Size: UDim2, Fov: number): Stage
	local Viewport = UI.New("ViewportFrame", {
		Size = Size,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		LightColor = RGB(242, 244, 255),
		LightDirection = Vector3.new(-1, -1, 0),
		Ambient = RGB(110, 120, 128),
		ZIndex = 2,
		Parent = Parent,
	})
	local World = UI.New("WorldModel", { Parent = Viewport })
	local Camera = UI.New("Camera", { FieldOfView = Fov, Parent = Viewport })
	Viewport.CurrentCamera = Camera
	return { Viewport = Viewport, World = World, Camera = Camera }
end

-- (re)puts your avatar on the stage if it isn't there; true when it's ready
local function Dress(Stage: Stage): boolean
	if Stage.Rig and Stage.Rig.Parent then
		return true
	end
	Stage.World:ClearAllChildren()
	local Rig = BuildRig()
	if not Rig then
		return false
	end
	Rig.Parent = Stage.World
	Stage.Rig = Rig
	local Humanoid = Rig:FindFirstChildOfClass("Humanoid")
	Stage.Animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
	local Root = Rig:FindFirstChild("HumanoidRootPart") :: BasePart?
	local Look = if Root then Root.CFrame.LookVector else Vector3.new(0, 0, -1)
	local Origin = if Root then Root.Position else Vector3.zero
	local Distance = (PREVIEW_HEIGHT * 0.5) / math.tan(math.rad(Stage.Camera.FieldOfView * 0.5)) * 1.25
	Stage.Camera.CFrame = CFrame.lookAt(Origin + Look * Distance, Origin)
	return true
end

-- Frozen = hold one pose (paused) until hovered. Returns false if your avatar isn't ready yet
-- (no character), so the caller can try again later.
local function Pose(Stage: Stage, Anim: Animation?, Frozen: boolean): boolean
	if Stage.Track then
		pcall(function()
			(Stage.Track :: AnimationTrack):Stop(0)
		end)
		Stage.Track = nil
	end
	if not Anim then
		Stage.Viewport.Visible = false
		return true
	end
	if not Dress(Stage) or not Stage.Animator then
		Stage.Viewport.Visible = false
		return false
	end
	local Ok, Track = pcall(function()
		return (Stage.Animator :: Animator):LoadAnimation(Anim)
	end)
	if not Ok or not Track then
		return false
	end
	Track.Looped = true
	Track:Play(0)
	if Frozen then
		Track:AdjustSpeed(0)
		Track.TimePosition = 0.1
	end
	Stage.Track = Track
	Stage.Viewport.Visible = true
	return true
end

------------------------------------------------------------------------
-- The window
------------------------------------------------------------------------
-- Emotes is a page of the Cosmetics window: CosmeticsClient makes the page and the header tab
-- that shows it (shared.EmotesWindow), so switching to it doesn't reopen anything
repeat
	task.wait()
until (shared :: any).EmotesWindow
local Window = (shared :: any).EmotesWindow
local Menu = { Body = Window.Body }

local ROW_HEIGHT, BAR_HEIGHT = 42, 78
local LEFT = 0.58 -- share of the width the emote list takes

local Filter = "Owned"
local Search = ""
local Picked: string? = nil
local Page = 1

local Render -- defined below

-- left, top row: search + Owned / All
local SearchBox = UI.New("Frame", {
	Size = UDim2.new(LEFT * 0.55, -8, 0, ROW_HEIGHT),
	BackgroundColor3 = UI.Colors.DarkerGray,
	Parent = Menu.Body,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Image({ Image = UI.Images.Search, Size = UDim2.fromOffset(22, 22), Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ImageColor3 = UI.Colors.LightGray, Parent = SearchBox })
local SearchInput = UI.New("TextBox", {
	Size = UDim2.new(1, -52, 1, 0),
	Position = UDim2.fromOffset(44, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search emotes...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Medium"),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	Parent = SearchBox,
})
local SelectFilter = UI.Tabs(Menu.Body, { "Owned", "All" }, THEME, function(Name)
	Filter = Name
	Render()
end, {
	Size = UDim2.new(LEFT * 0.45, -8, 0, ROW_HEIGHT),
	Position = UDim2.new(LEFT * 0.55, 0, 0, 0),
})

-- left: the emote grid
local PAGE_TOP = ROW_HEIGHT + 10
local ListPanel = UI.New("Frame", {
	Size = UDim2.new(LEFT, -8, 1, -(PAGE_TOP + BAR_HEIGHT + 10)),
	Position = UDim2.fromOffset(0, PAGE_TOP),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.2,
	ClipsDescendants = true,
	Parent = Menu.Body,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })
local Grid = UI.New("ScrollingFrame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = RGB(176, 170, 160),
	ScrollingDirection = Enum.ScrollingDirection.Y,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new(),
	Parent = ListPanel,
}, {
	UI.New("UIGridLayout", { CellSize = UDim2.new(0.25, -10, 0, 170), CellPadding = UDim2.fromOffset(10, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
	UI.New("UIPadding", { PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 12) }),
})
local Empty = UI.Text({ Text = "No emotes yet. Spin for some below!", TextSize = 20, TextColor3 = UI.Colors.Gray, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 40), Position = UDim2.fromScale(0, 0.42), Visible = false, Parent = ListPanel })

-- right: your wheel
local WheelPanel = UI.New("Frame", {
	Size = UDim2.new(1 - LEFT, -8, 1, -(BAR_HEIGHT + 10)),
	Position = UDim2.new(1, 0, 0, 0),
	AnchorPoint = Vector2.new(1, 0),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.2,
	Parent = Menu.Body,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })
UI.Text({ Text = "Your Wheel", TextSize = 24, Weight = "ExtraBold", Gradient = THEME, Size = UDim2.new(1, -24, 0, 30), Position = UDim2.fromOffset(14, 10), Parent = WheelPanel })
local Hint = UI.Text({ Text = "Pick an emote, then click a circle.", TextSize = 15, NoStroke = true, TextColor3 = MUTED, Size = UDim2.new(1, -24, 0, 20), Position = UDim2.fromOffset(14, 40), Parent = WheelPanel })
local RingHolder = UI.New("Frame", {
	Size = UDim2.new(1, -20, 1, -74),
	Position = UDim2.new(0.5, 0, 1, -8),
	AnchorPoint = Vector2.new(0.5, 1),
	BackgroundTransparency = 1,
	Parent = WheelPanel,
})
local Ring = UI.New("Frame", {
	Size = UDim2.fromScale(1, 1),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundTransparency = 1,
	Parent = RingHolder,
}, { UI.New("UIAspectRatioConstraint", { AspectRatio = 1, DominantAxis = Enum.DominantAxis.Height }) })
-- the faint disc behind the circles
UI.New("Frame", {
	Size = UDim2.fromScale(0.62, 0.62),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = UI.Colors.White,
	BackgroundTransparency = 0.94,
	Parent = Ring,
}, { UI.New("UICorner", { CornerRadius = UDim.new(1, 0) }), UI.Stroke(RGB(90, 86, 80), 2) })

------------------------------------------------------------------------
-- The wheel: same layout as the in-game wheel (keep in step with WheelHandler2D)
--   circle 1 (top)     page number
--   circles 2-9        slots 1-8
--   circle 10 (bottom) page switch ("More" until you own the passes)
------------------------------------------------------------------------
local WHEEL_RADIUS = 0.42
local CIRCLE_SIZE = UDim2.fromScale(0.15, 0.15)
local CIRCLE_HOVER = UDim2.fromScale(0.175, 0.175)
local KEY_NAMES = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }
local FILL_IDLE, FILL_HOVER = RGB(30, 30, 35), RGB(48, 46, 44)
local HOVER = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function RingPosition(Index: number): UDim2
	local Angle = (Index - 1) * (math.pi * 2 / 10) - math.pi / 2
	return UDim2.fromScale(0.5 + math.cos(Angle) * WHEEL_RADIUS, 0.5 + math.sin(Angle) * WHEEL_RADIUS)
end

type Circle = { Button: TextButton, Stroke: UIStroke, NameLabel: TextLabel, Badge: TextLabel, Stage: Stage, Interactive: boolean }
local Circles: { Circle } = {}

for Index = 1, 10 do
	local Button = UI.New("TextButton", {
		Name = "Circle" .. Index,
		Size = CIRCLE_SIZE,
		Position = RingPosition(Index),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = FILL_IDLE,
		BackgroundTransparency = 0.1,
		Text = "",
		AutoButtonColor = false,
		Parent = Ring,
	}, { UI.New("UICorner", { CornerRadius = UDim.new(1, 0) }) })
	UI.Gradient(ColorSequence.new(RGB(70, 68, 64), RGB(25, 25, 28)), 90).Parent = Button
	local Stroke = UI.Stroke(RGB(80, 78, 74), 2)
	Stroke.Parent = Button
	local Stage = MakeStage(Button, UDim2.fromScale(1, 1), 40)
	Stage.Viewport.Visible = false
	UI.New("UICorner", { CornerRadius = UDim.new(1, 0), Parent = Stage.Viewport })
	local NameLabel = UI.Text({ Text = "", TextSize = 14, TextScaled = true, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(0.84, 0.3), Position = UDim2.fromScale(0.08, 0.2), ZIndex = 3, Parent = Button })
	UI.New("UITextSizeConstraint", { MaxTextSize = 15, Parent = NameLabel })
	local Badge = UI.Text({ Text = "LOCKED", TextSize = 11, TextColor3 = RGB(255, 195, 75), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(0.8, 0.16), Position = UDim2.fromScale(0.1, 0.06), Visible = false, ZIndex = 3, Parent = Button })
	local Key = UI.Text({ Text = KEY_NAMES[Index], TextSize = 16, TextColor3 = RGB(210, 206, 198), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(0.8, 0.22), Position = UDim2.fromScale(0.1, 0.6), ZIndex = 3, Parent = Button })
	Key.Visible = Index >= 2 and Index <= 9
	local Circle: Circle = { Button = Button, Stroke = Stroke, NameLabel = NameLabel, Badge = Badge, Stage = Stage, Interactive = false }
	Button.MouseEnter:Connect(function()
		if Circle.Interactive then
			UI.Play("Hover", 0.15)
			TweenService:Create(Button, HOVER, { Size = CIRCLE_HOVER, BackgroundColor3 = FILL_HOVER }):Play()
		end
	end)
	Button.MouseLeave:Connect(function()
		TweenService:Create(Button, HOVER, { Size = CIRCLE_SIZE, BackgroundColor3 = FILL_IDLE }):Play()
	end)
	Circles[Index] = Circle
end

local function PaintSlot(Circle: Circle, EmoteName: string?, Locked: boolean)
	Circle.Badge.Visible = Locked
	Circle.Interactive = not Locked
	local Entry = EmoteName and ByName[EmoteName]
	if Locked then
		Circle.NameLabel.Text = "Locked"
		Circle.NameLabel.TextColor3 = RGB(160, 160, 160)
		Circle.Stroke.Color = RGB(80, 78, 74)
		Pose(Circle.Stage, nil, false)
	elseif Entry and Owned[Entry.Name] then
		Circle.NameLabel.Text = Entry.Name
		Circle.NameLabel.TextColor3 = UI.Colors.White
		Circle.Stroke.Color = Entry.Color
		Pose(Circle.Stage, Entry.Animation, false)
	else
		Circle.NameLabel.Text = "Empty"
		Circle.NameLabel.TextColor3 = RGB(130, 130, 130)
		Circle.Stroke.Color = RGB(80, 78, 74)
		Pose(Circle.Stage, nil, false)
	end
end

local function RefreshWheel()
	local CanPage2 = HasMoreEmotes and HasSecondPage
	if not CanPage2 then
		Page = 1
	end
	local MaxSlots = if HasMoreEmotes then 8 else 4
	-- circle 1: which page this is
	local Top = Circles[1]
	Top.Interactive = true -- clicking it switches pages too
	Top.Badge.Visible = false
	Top.NameLabel.Text = "Page " .. Page
	Top.NameLabel.TextColor3 = UI.Colors.White
	-- circles 2-9: the slots
	for Slot = 1, 8 do
		PaintSlot(Circles[Slot + 1], EquippedSlots[Page .. "_" .. Slot], Slot > MaxSlots)
	end
	-- circle 10: switch pages
	local Switch = Circles[10]
	Switch.Interactive = true
	Switch.Badge.Visible = not CanPage2
	Switch.NameLabel.Text = if CanPage2 then (if Page == 1 then "Page 2" else "Page 1") else "More"
	Switch.NameLabel.TextColor3 = if CanPage2 then UI.Colors.White else RGB(160, 160, 160)
	Hint.Text = if Picked then `Click a circle to put {Picked} there.` else "Pick an emote, then click a circle."
end

-- slots 1-8: put the picked emote there (locked slots ask for the More Emotes pass)
for Slot = 1, 8 do
	local Circle = Circles[Slot + 1]
	Circle.Button.Activated:Connect(function()
		if not Circle.Interactive then
			Sfx("rbxassetid://5797580410", 0.75)
			Remotes.Gamepasses.RequestGamepass:FireServer("MoreEmotes")
			return
		end
		if not Picked then
			UI.Toast("Pick an emote first.", false)
			return
		end
		local Ok, Set = pcall(function()
			return EmoteRemotes.ChangeEmotes:InvokeServer({ Slot = tostring(Slot), EmoteName = Picked, Page = if Page == 1 then "Emotes" else "Emotes2" })
		end)
		if Ok and Set then
			EquippedSlots[Page .. "_" .. Slot] = Picked
			Sfx("rbxassetid://6895079853", 0.5)
			Picked = nil
			Render()
		else
			UI.Toast("Couldn't set that slot.", false)
		end
	end)
end

-- circle 1 (the page number) and circle 10 both switch pages. Page 2 needs both the More Emotes
-- and the Second Page passes; without them, say so and offer the one that's missing.
local function SwitchPage()
	Sfx("rbxassetid://5797580410", 0.75)
	if not (HasMoreEmotes and HasSecondPage) then
		local Missing = if HasMoreEmotes then "SecondPage" else "MoreEmotes"
		UI.Toast(if HasMoreEmotes then "Page 2 needs the Second Page pass." else "Page 2 needs the More Emotes and Second Page passes.", false)
		Remotes.Gamepasses.RequestGamepass:FireServer(Missing)
		return
	end
	Page = if Page == 1 then 2 else 1
	RefreshWheel()
end
Circles[1].Button.Activated:Connect(SwitchPage)
Circles[10].Button.Activated:Connect(SwitchPage)

------------------------------------------------------------------------
-- Emote tiles
------------------------------------------------------------------------
type Tile = { Entry: Emote, Root: TextButton, Visual: Frame, Stroke: UIStroke, Stage: Stage, Veil: Frame, Pick: UIStroke, Posed: boolean }
local Tiles: { Tile } = {}

for Index, Entry in Emotes do
	local Root = UI.New("TextButton", { Name = Entry.Name, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Index, Parent = Grid })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = CARD,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(10) })
	local Stroke = UI.Stroke(Entry.Color, 2)
	Stroke.Parent = Visual
	-- a soft wash of the rarity colour from the bottom, like Heroes Battlegrounds' tinted cards
	local Wash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Entry.Color, Parent = Visual }, { UI.Corner(10) })
	UI.New("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.55, 0.92), NumberSequenceKeypoint.new(1, 0.72) }), Parent = Wash })
	local Stage = MakeStage(Visual, UDim2.fromScale(1, 0.8), 40)
	Stage.Viewport.Position = UDim2.fromScale(0.5, 0.42)
	Stage.Viewport.Visible = false

	local RarityBox = UI.New("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 20),
		Position = UDim2.fromOffset(6, 6),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 0.25,
		ZIndex = 4,
		Parent = Visual,
	}, { UI.Corner(6), UI.New("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }) })
	UI.Text({ Text = string.upper(Entry.Rarity), TextSize = 12, TextColor3 = Entry.Color, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), ZIndex = 4, Parent = RarityBox })
	local NameLabel = UI.Text({ Text = Entry.Name, TextSize = 16, TextScaled = true, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, -12, 0, 22), Position = UDim2.new(0, 6, 1, -28), ZIndex = 4, Parent = Visual })
	UI.New("UITextSizeConstraint", { MaxTextSize = 16, Parent = NameLabel })

	local Veil = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = 0.5, ZIndex = 3, Parent = Visual })
	UI.Text({ Text = "???", TextSize = 30, TextColor3 = UI.Colors.Gray, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 34), Position = UDim2.fromScale(0, 0.32), ZIndex = 3, Parent = Veil })

	local Pick = UI.HoverStroke(Visual, DONE, 3, 10)
	local Hover = UI.HoverStroke(Visual, UI.Gradients.Common, 2, 10)
	UI.Bouncy(Root, Visual, { Grow = 0.03, HoverStroke = Hover })

	local Tile: Tile = { Entry = Entry, Root = Root, Visual = Visual, Stroke = Stroke, Stage = Stage, Veil = Veil, Pick = Pick, Posed = false }
	-- yours play while hovered, and hold a pose otherwise
	Root.MouseEnter:Connect(function()
		if Tile.Stage.Track then
			Tile.Stage.Track:AdjustSpeed(1)
		end
	end)
	Root.MouseLeave:Connect(function()
		if Tile.Stage.Track then
			Tile.Stage.Track:AdjustSpeed(0)
		end
	end)
	Root.Activated:Connect(function()
		if not Owned[Entry.Name] then
			UI.Play("Error", 0.4)
			UI.Toast(`You don't have {Entry.Name} yet. Spin for it!`, false)
			return
		end
		UI.Play("Click", 0.3)
		Picked = if Picked == Entry.Name then nil else Entry.Name
		Render()
	end)
	table.insert(Tiles, Tile)
end

------------------------------------------------------------------------
-- Spins (bottom bar)
------------------------------------------------------------------------
local Bar = UI.New("Frame", {
	Size = UDim2.new(1, 0, 0, BAR_HEIGHT),
	Position = UDim2.new(0, 0, 1, -BAR_HEIGHT),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.1,
	Parent = Menu.Body,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })

local function BarBox(X: number, Width: number, Caption: string): TextLabel
	UI.Text({ Text = Caption, TextSize = 16, TextColor3 = MUTED, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(Width, -16, 0, 20), Position = UDim2.new(X, 8, 0, 6), Parent = Bar })
	local Box = UI.New("Frame", { Size = UDim2.new(Width, -16, 0, 38), Position = UDim2.new(X, 8, 0, 30), BackgroundColor3 = CARD, Parent = Bar }, { UI.Corner(8), UI.Stroke(EDGE, 2) })
	return UI.Text({ Text = "-", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = Box })
end
local SpinsText = BarBox(0, 0.18, "YOUR SPINS:")
local ResultText = BarBox(0.18, 0.38, "LAST SPIN:")

local Spinning = false
local SpinButton = UI.Button({
	Parent = Bar,
	Size = UDim2.new(0.22, -12, 0, 56),
	Position = UDim2.new(0.56, 6, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	Text = "SPIN",
	TextSize = 26,
	Gradient = DONE,
	OnClick = function()
		if Spinning then
			return
		end
		Spinning = true
		local Ok, Success, RealName, Rarity, GoldAwarded, RolledName = pcall(function()
			return EmoteRemotes.SpinEmote:InvokeServer()
		end)
		if not (Ok and Success) then
			Spinning = false
			UI.Play("Error", 0.5)
			UI.Toast("No spins left. Get more in the Store!", false)
			return
		end
		-- the roulette: random names, slowing down, then the real one
		local Pool = {}
		for _, Entry in Emotes do
			table.insert(Pool, Entry)
		end
		for Step = 1, 30 do
			local Fake = Pool[math.random(1, #Pool)]
			ResultText.Text = Fake.Name
			ResultText.TextColor3 = Fake.Color
			Sfx("rbxassetid://116394299154002", 0.5)
			task.wait(Step * 0.015)
		end
		local Data = InfoModule.EmoteRarities and InfoModule.EmoteRarities[Rarity]
		ResultText.TextColor3 = if Data then Data.Color else UI.Colors.White
		if RealName then
			ResultText.Text = RealName
			Owned[RealName] = true
			Sfx("rbxassetid://4612378086", 0.4)
			UI.Notify(`You got {RealName}!`)
		else
			ResultText.Text = `{RolledName or "?"} (+{GoldAwarded or 0} Gold)`
			Sfx("rbxassetid://6895079853", 0.6)
		end
		Spinning = false
		Render()
	end,
})
UI.Button({
	Parent = Bar,
	Size = UDim2.new(0.22, -14, 0, 56),
	Position = UDim2.new(1, -8, 0.5, 0),
	AnchorPoint = Vector2.new(1, 0.5),
	Text = "Get spins",
	TextSize = 22,
	Gradient = THEME,
	OnClick = function()
		local Open = (shared :: any).shoptab
		if Open then
			Open("Items") -- Emote Spins are in the Store's Items tab
		end
	end,
})
SpinButton.Root.Name = "Spin"

local function RefreshSpins()
	SpinsText.Text = tostring(Player:GetAttribute("EmoteSpins") or 0)
end
Player:GetAttributeChangedSignal("EmoteSpins"):Connect(RefreshSpins)
RefreshSpins()

------------------------------------------------------------------------
-- Drawing
------------------------------------------------------------------------
Render = function()
	local Needle = string.lower(Search)
	local Shown = 0
	for _, Tile in Tiles do
		local Mine = Owned[Tile.Entry.Name] == true
		local Visible = (Filter == "All" or Mine) and (Needle == "" or string.find(string.lower(Tile.Entry.Name), Needle, 1, true) ~= nil)
		Tile.Root.Visible = Visible
		if Visible then
			Shown += 1
		end
		Tile.Veil.Visible = not Mine
		Tile.Pick.Transparency = if Picked == Tile.Entry.Name then 0 else 1
		-- your avatar only goes on tiles you own (and only once they're on screen)
		if Mine and Visible and not Tile.Posed then
			Tile.Posed = Pose(Tile.Stage, Tile.Entry.Animation, true)
		end
	end
	Empty.Visible = Shown == 0
	Empty.Text = if Filter == "Owned" and Needle == "" then "No emotes yet. Spin for some below!" else "No emotes found."
	RefreshWheel()
	RefreshSpins()
end

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
	Search = SearchInput.Text
	Render()
end)

------------------------------------------------------------------------
-- Keeping up with the server
------------------------------------------------------------------------
EmoteRemotes.Set.OnClientEvent:Connect(function(Action: string, Params: any)
	if Action == "UpdateOwnedEmotes" and type(Params) == "table" then
		for _, Name in Params.OwnedEmotes or {} do
			Owned[Name] = true
		end
	elseif Action == "SlotUpdated" and type(Params) == "table" then
		local PageIndex = if Params.Page == "Emotes" then 1 else 2
		EquippedSlots[PageIndex .. "_" .. tostring(Params.Slot)] = Params.EmoteName
	end
	if Window.IsOpen() then
		Render()
	end
end)

Remotes.Gamepasses.GamepassPurchased.OnClientEvent:Connect(function()
	RefreshPasses()
	if Window.IsOpen() then
		RefreshWheel()
	end
end)

-- a new character means new avatar clones for the previews
Player.CharacterAdded:Connect(function()
	for _, Circle in Circles do
		Circle.Stage.Rig = nil
		Circle.Stage.Track = nil
	end
	for _, Tile in Tiles do
		Tile.Stage.Rig = nil
		Tile.Stage.Track = nil
		Tile.Posed = false
	end
end)

-- runs each time the Emotes tab is picked
;(shared :: any).EmotesShown = function()
	SelectFilter(Filter)
end

UI.Own("emotemenu", function()
	Window.Open()
end)
