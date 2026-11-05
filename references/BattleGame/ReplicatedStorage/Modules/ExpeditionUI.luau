-- ReplicatedStorage > Modules > ExpeditionUI   (ModuleScript, client)
--
-- Shared look for the Store and Quests menus, styled after Anime Expeditions' menus:
--   * menus are laid out at 1140 x 680 for a 1920 x 1009 screen and shrink/grow with a UIScale,
--     so they fit any screen (that's why the old one looked too big in Studio)
--   * header: gradient ribbon, the ship on the waves (rises in when it opens), drifting clouds
--     (different random ones each open), title, red close button
--   * every button/card bounces on a spring: bigger on hover, squashed on press, plus a hover
--     sound, a click sound and a glowing gradient outline
--
-- Images marked TEMP are Anime Expeditions' uploads, used as placeholders. They belong to that
-- game's developers and can stop loading at any time; swap them for your own before release.

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local UI = {}

------------------------------------------------------------------------
-- Colors, gradients, images, sounds
------------------------------------------------------------------------
UI.Colors = {
	Black = Color3.fromRGB(0, 0, 0),
	Panel = Color3.fromRGB(10, 10, 10),
	Card = Color3.fromRGB(20, 20, 20),
	DarkGray = Color3.fromRGB(55, 55, 55),
	DarkerGray = Color3.fromRGB(25, 25, 25),
	Gray = Color3.fromRGB(140, 140, 140),
	LightGray = Color3.fromRGB(191, 191, 191),
	White = Color3.new(1, 1, 1),
	Red = Color3.fromRGB(255, 65, 65),
	Green = Color3.fromRGB(150, 255, 46),
	Gold = Color3.fromRGB(255, 210, 60),
}

local function Sequence(...)
	local Colors = { ... }
	local Points = {}
	for Index, Color in Colors do
		table.insert(Points, ColorSequenceKeypoint.new((Index - 1) / (#Colors - 1), Color))
	end
	return ColorSequence.new(Points)
end

UI.Gradients = {
	Purple = Sequence(Color3.fromRGB(235, 83, 255), Color3.fromRGB(129, 19, 255)),
	Blue = Sequence(Color3.fromRGB(28, 255, 255), Color3.fromRGB(0, 153, 255)),
	Yellow = Sequence(Color3.fromRGB(251, 255, 0), Color3.fromRGB(255, 94, 0)),
	Green = Sequence(Color3.fromRGB(214, 255, 30), Color3.fromRGB(76, 240, 0)),
	Grey = Sequence(Color3.fromRGB(150, 150, 150), Color3.fromRGB(100, 100, 100)),
	Red = Sequence(Color3.fromRGB(255, 51, 51), Color3.fromRGB(153, 27, 27)),
	Gold = Sequence(Color3.fromRGB(255, 234, 41), Color3.fromRGB(255, 234, 41), Color3.fromRGB(255, 163, 26), Color3.fromRGB(255, 163, 26)),
	-- rarities (slot backgrounds)
	Common = Sequence(Color3.fromRGB(255, 255, 255), Color3.fromRGB(140, 154, 158), Color3.fromRGB(94, 95, 92)),
	Uncommon = Sequence(Color3.fromRGB(136, 255, 0), Color3.fromRGB(54, 180, 0)),
	Rare = Sequence(Color3.fromRGB(0, 149, 255), Color3.fromRGB(25, 60, 235)),
	Epic = Sequence(Color3.fromRGB(153, 10, 255), Color3.fromRGB(76, 39, 154)),
	Legendary = Sequence(Color3.fromRGB(255, 203, 14), Color3.fromRGB(218, 118, 4)),
	Mythic = Sequence(Color3.fromRGB(255, 7, 7), Color3.fromRGB(247, 221, 27), Color3.fromRGB(93, 229, 30), Color3.fromRGB(43, 174, 194), Color3.fromRGB(97, 61, 206)),
}

UI.Images = {
	-- menu header: the ship sailing on waves, a 4x4 flipbook of 256x256 frames
	-- (Dash/Shop/ShipIcon/Animated/ShipWaves_Flipbook_4x4.png). Upload it and put its id here.
	Ship = "rbxassetid://71837991992551",
	Wheel = "rbxassetid://117379986310860", -- TEMP, no longer shown
	-- header clouds: 8 clouds on one 1024x1024 sheet (Dash/Shop/Clouds_Atlas.png). Upload it and
	-- put its id here. Grey, so they take the menu's color.
	Clouds = "rbxassetid://96251519492623",
	Ribbon = "rbxassetid://96636463928154",
	-- menu icons (TEMP)
	StoreIcon = "rbxassetid://72335481356876",
	QuestIcon = "rbxassetid://126586572783786",
	-- small icons (TEMP)
	Close = "rbxassetid://89701503974482",
	Star = "rbxassetid://131908498209821",
	Clock = "rbxassetid://89385667206697",
	Search = "rbxassetid://136831385960096",
	Eye = "rbxassetid://17769663408",
	Gift = "rbxassetid://17790616460",
	Check = "rbxassetid://139144590557777",
	Pin = "rbxassetid://109637700317799",
	Coins = "rbxassetid://80297771892932", -- the same coin as the Gold display
	Dice = "rbxassetid://90522187215691",
	Locked = "rbxassetid://17860233849",
	-- decals (TEMP)
	Checkered = "rbxassetid://138476777747027",
	SoftGlow = "rbxassetid://134556475229858",
	Sparkle = "rbxassetid://108282003862789",
	-- reward art (TEMP)
	GoldPile = "rbxassetid://80297771892932", -- the same coin as the Gold display
	Bundle = "rbxassetid://127345120309392",
	Robux = "rbxasset://textures/ui/common/robux.png", -- Roblox's own
}

-- your existing menu sounds
UI.Sounds = {
	Hover = "rbxassetid://6909859846", -- Ultimate Battlegrounds' UI hover
	Click = "rbxassetid://137142927610972", -- uploaded by TimeStudios
	Open = "rbxassetid://101460924839026", -- "Charopen" (JS Test's BasicOpen), uploaded by TimeStudios
	Reward = "rbxassetid://130881859476591", -- "Success", uploaded by TimeStudios
	Error = "rbxassetid://74575287874284", -- "fa" (JS Test's Fail), uploaded by TimeStudios
}

local SoundCache: { [string]: Sound } = {}
function UI.Play(Name: string, Volume: number?)
	local Id = UI.Sounds[Name]
	if not Id then
		return
	end
	local Sound = SoundCache[Name]
	if not Sound then
		Sound = Instance.new("Sound")
		Sound.SoundId = Id
		Sound.Parent = SoundService
		SoundCache[Name] = Sound
	end
	Sound.Volume = Volume or 0.5
	Sound.TimePosition = 0
	Sound:Play()
end

------------------------------------------------------------------------
-- Building blocks
------------------------------------------------------------------------
function UI.New(ClassName: string, Props: { [any]: any }?, Children: { Instance }?): any
	local Object = Instance.new(ClassName)
	if Object:IsA("GuiObject") then
		Object.BorderSizePixel = 0
	end
	local Parent = nil
	for Key, Value in Props or {} do
		if Key == "Parent" then
			Parent = Value
		else
			Object[Key] = Value
		end
	end
	for _, Child in Children or {} do
		Child.Parent = Object
	end
	Object.Parent = Parent
	return Object
end

function UI.Corner(Radius: number): UICorner
	return UI.New("UICorner", { CornerRadius = UDim.new(0, Radius) })
end

function UI.Stroke(Color: Color3, Thickness: number, Gradient: ColorSequence?, Transparency: number?): UIStroke
	local Stroke = UI.New("UIStroke", {
		Color = if Gradient then UI.Colors.White else Color,
		Thickness = Thickness,
		Transparency = Transparency or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
	})
	if Gradient then
		UI.New("UIGradient", { Color = Gradient, Rotation = 45, Parent = Stroke })
	end
	return Stroke
end

function UI.Gradient(Color: ColorSequence, Rotation: number?): UIGradient
	return UI.New("UIGradient", { Color = Color, Rotation = Rotation or 90 })
end

-- Rubik, the font the JS Test place uses for nearly all its menus (Roblox's built-in copy, no
-- upload needed). UI.Font("Bold") etc. for anything that sets a font itself.
local RUBIK = "rbxassetid://12187365977"
function UI.Font(Weight: string?): Font
	return Font.new(RUBIK, Enum.FontWeight[Weight or "Bold"])
end

-- Rubik text with a black outline (and a color gradient, if given). Outlined text (titles,
-- buttons, numbers) is Bold; plain text without an outline (descriptions) is Medium.
-- Pass Weight = "ExtraBold" / "SemiBold" / "Regular" ... to choose another.
function UI.Text(Props: { [string]: any }): TextLabel
	local Gradient = Props.Gradient
	local NoStroke = Props.NoStroke
	local Weight = Props.Weight
	Props.Gradient = nil
	Props.NoStroke = nil
	Props.Weight = nil
	local Size = Props.TextSize or 18
	Props.BackgroundTransparency = 1
	Props.FontFace = Props.FontFace or UI.Font(Weight or (if NoStroke then "Medium" else "Bold"))
	Props.TextSize = Size
	Props.TextColor3 = Props.TextColor3 or UI.Colors.White
	Props.TextXAlignment = Props.TextXAlignment or Enum.TextXAlignment.Left
	local Label = UI.New("TextLabel", Props)
	if NoStroke ~= true then
		UI.New("UIStroke", {
			Thickness = math.max(1, Size / 13), -- Rubik is slimmer than Fredoka, so a thinner outline
			Color = UI.Colors.Black,
			LineJoinMode = Enum.LineJoinMode.Round,
			Parent = Label,
		})
	end
	if Gradient then
		UI.New("UIGradient", { Color = Gradient, Rotation = 90, Parent = Label })
	end
	return Label
end

function UI.Image(Props: { [string]: any }): ImageLabel
	Props.BackgroundTransparency = 1
	Props.ScaleType = Props.ScaleType or Enum.ScaleType.Fit
	return UI.New("ImageLabel", Props)
end

------------------------------------------------------------------------
-- Springs: the bouncy scale on hover/press
------------------------------------------------------------------------
local SPEED, DAMPING, KICK = 35, 0.65, 20 -- same feel as Anime Expeditions' buttons
type SpringState = { Target: number, Velocity: number }
local Springs: { [UIScale]: SpringState } = {}

RunService.RenderStepped:Connect(function(DeltaTime)
	local Step = math.min(DeltaTime, 1 / 30) / 2
	for Scale, State in Springs do
		if not Scale.Parent then
			Springs[Scale] = nil
			continue
		end
		local X = Scale.Scale
		for _ = 1, 2 do
			local Accel = SPEED * SPEED * (State.Target - X) - 2 * DAMPING * SPEED * State.Velocity
			State.Velocity += Accel * Step
			X += State.Velocity * Step
		end
		Scale.Scale = X
		if math.abs(State.Velocity) < 0.001 and math.abs(State.Target - X) < 0.001 then
			Scale.Scale = State.Target
			Springs[Scale] = nil
		end
	end
end)

local function SpringTo(Scale: UIScale, Target: number, Kick: number?)
	local State = Springs[Scale] or { Target = Scale.Scale, Velocity = 0 }
	State.Target = Target
	if Kick then
		State.Velocity += Kick
	end
	Springs[Scale] = State
end

-- Makes Root bounce: Visual (a child centered in Root) carries the UIScale, so it grows from its
-- middle. Optional HoverStroke fades in a gradient outline while hovered.
function UI.Bouncy(Root: GuiObject, Visual: GuiObject, Options: { Grow: number?, HoverStroke: UIStroke?, Silent: boolean? }?)
	local Opts = Options or {}
	local Grow = Opts.Grow or 0.06
	local Scale = Visual:FindFirstChildOfClass("UIScale") or UI.New("UIScale", { Parent = Visual })
	local Hovering, Pressing = false, false
	local function Update()
		local Target = 1
		if Hovering then
			Target += Grow
		end
		if Pressing then
			Target *= 0.88
		end
		SpringTo(Scale, Target)
		if Opts.HoverStroke then
			TweenService:Create(Opts.HoverStroke, TweenInfo.new(0.15), { Transparency = if Hovering then 0 else 1 }):Play()
		end
	end
	-- Closing a menu or switching its page under the mouse fires no MouseLeave, which left the
	-- hover outline stuck on; so a hover ends once the button is no longer on screen.
	local function Shown(): boolean
		local Object: Instance? = Root
		while Object and Object:IsA("GuiObject") do
			if not Object.Visible then
				return false
			end
			Object = Object.Parent
		end
		return Object ~= nil and Object:IsA("LayerCollector") and Object.Enabled
	end
	local HoverToken = 0
	Root.MouseEnter:Connect(function()
		Hovering = true
		if not Opts.Silent then
			UI.Play("Hover", 0.15)
		end
		Update()
		HoverToken += 1
		local Token = HoverToken
		task.spawn(function()
			while Hovering and Token == HoverToken do
				task.wait(0.2)
				if Hovering and Token == HoverToken and not Shown() then
					Hovering, Pressing = false, false
					Update()
				end
			end
		end)
	end)
	Root.MouseLeave:Connect(function()
		Hovering, Pressing = false, false
		Update()
	end)
	if Root:IsA("GuiButton") then
		Root.MouseButton1Down:Connect(function()
			Pressing = true
			SpringTo(Scale, Scale.Scale, -KICK * Grow * 4)
			Update()
		end)
		Root.MouseButton1Up:Connect(function()
			Pressing = false
			Update()
		end)
	end
end

-- An outline that only shows while hovered (pass to Bouncy as HoverStroke). It sits on its own
-- see-through frame, because an object only draws one UIStroke.
function UI.HoverStroke(Parent: Instance, Gradient: ColorSequence, Thickness: number?, Radius: number?): UIStroke
	local Overlay = UI.New("Frame", {
		Name = "HoverOutline",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 5,
		Parent = Parent,
	}, { UI.Corner(Radius or 8) })
	local Stroke = UI.Stroke(UI.Colors.White, Thickness or 2, Gradient, 1)
	Stroke.Parent = Overlay
	return Stroke
end

------------------------------------------------------------------------
-- Buttons
------------------------------------------------------------------------
-- A gradient button. Returns the clickable root and its parts.
function UI.Button(Props: {
	Parent: Instance,
	Size: UDim2,
	Position: UDim2?,
	AnchorPoint: Vector2?,
	Text: string?,
	TextSize: number?,
	Icon: string?,
	Gradient: ColorSequence?,
	TextGradient: ColorSequence?,
	LayoutOrder: number?,
	OnClick: (() -> ())?,
	Grow: number?,
	})
	local Root = UI.New("TextButton", {
		Name = Props.Text or "Button",
		Size = Props.Size,
		Position = Props.Position or UDim2.new(),
		AnchorPoint = Props.AnchorPoint or Vector2.zero,
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		LayoutOrder = Props.LayoutOrder or 0,
		Parent = Props.Parent,
	})
	local Visual = UI.New("Frame", {
		Name = "Visual",
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.White,
		Parent = Root,
	}, { UI.Corner(8) })
	local Fill = UI.Gradient(Props.Gradient or UI.Gradients.Grey, 90)
	Fill.Parent = Visual
	UI.Stroke(UI.Colors.Black, 2).Parent = Visual
	-- a darker lower half, like their glossy buttons
	UI.New("Frame", {
		Size = UDim2.new(1, -6, 0.45, -3),
		Position = UDim2.new(0, 3, 0.55, 0),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 0.82,
		Parent = Visual,
	}, { UI.Corner(6) })

	local Row = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Parent = Visual,
	}, {
		UI.New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	local Icon
	if Props.Icon then
		Icon = UI.Image({ Image = Props.Icon, Size = UDim2.fromOffset(22, 22), LayoutOrder = 1, Parent = Row })
	end
	local Label = UI.Text({
		Text = Props.Text or "",
		TextSize = Props.TextSize or 20,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		TextXAlignment = Enum.TextXAlignment.Center,
		Gradient = Props.TextGradient,
		LayoutOrder = 2,
		Parent = Row,
	})
	local HoverStroke = UI.HoverStroke(Visual, UI.Gradients.Common, 2)
	UI.Bouncy(Root, Visual, { Grow = Props.Grow or 0.06, HoverStroke = HoverStroke })
	if Props.OnClick then
		Root.Activated:Connect(function()
			UI.Play("Click", 0.4)
			Props.OnClick()
		end)
	end
	return { Root = Root, Visual = Visual, Fill = Fill, Label = Label, Icon = Icon }
end

-- Square icon button (the eye / gift / pin buttons)
function UI.IconButton(Parent: Instance, Image: string, Size: number, Gradient: ColorSequence, Position: UDim2?, OnClick: (() -> ())?)
	local Button = UI.Button({ Parent = Parent, Size = UDim2.fromOffset(Size, Size), Position = Position, Gradient = Gradient, OnClick = OnClick, Grow = 0.1 })
	UI.Image({
		Image = Image,
		Size = UDim2.fromScale(0.6, 0.6),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 3,
		Parent = Button.Visual,
	})
	return Button
end

------------------------------------------------------------------------
-- Small pieces
------------------------------------------------------------------------
-- A rounded pill like "1x Left" or the red "Gone in 1h, 55m" timer
function UI.Pill(Parent: Instance, Text: string, Props: { Color: Color3?, Icon: string?, Position: UDim2?, AnchorPoint: Vector2?, TextColor: Color3?, LayoutOrder: number? }?)
	local Opts = Props or {}
	local Pill = UI.New("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 26),
		Position = Opts.Position or UDim2.new(),
		AnchorPoint = Opts.AnchorPoint or Vector2.zero,
		BackgroundColor3 = Opts.Color or UI.Colors.Black,
		BackgroundTransparency = 0.25,
		LayoutOrder = Opts.LayoutOrder or 0,
		Parent = Parent,
	}, {
		UI.Corner(13),
		UI.Stroke(UI.Colors.DarkGray, 1.5),
		UI.New("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 10) }),
		UI.New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 5),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	if Opts.Icon then
		UI.Image({ Image = Opts.Icon, Size = UDim2.fromOffset(16, 16), LayoutOrder = 1, Parent = Pill })
	end
	local Label = UI.Text({
		Text = Text,
		TextSize = 15,
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 1, 0),
		TextColor3 = Opts.TextColor or UI.Colors.White,
		LayoutOrder = 2,
		Parent = Pill,
	})
	return Pill, Label
end

-- "★ Bundles" with a fading line under it
function UI.SectionTitle(Parent: Instance, Text: string, Gradient: ColorSequence, LayoutOrder: number?)
	local Holder = UI.New("Frame", {
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		LayoutOrder = LayoutOrder or 0,
		Parent = Parent,
	})
	local Star = UI.Image({ Image = UI.Images.Star, Size = UDim2.fromOffset(20, 20), Position = UDim2.fromOffset(4, 6), Parent = Holder })
	UI.Gradient(Gradient).Parent = Star
	UI.Text({ Text = Text, TextSize = 22, Size = UDim2.new(1, -32, 0, 28), Position = UDim2.fromOffset(30, 2), Gradient = Gradient, Parent = Holder })
	local Line = UI.New("Frame", {
		Size = UDim2.new(1, 0, 0, 2),
		Position = UDim2.new(0, 0, 1, -2),
		BackgroundColor3 = UI.Colors.White,
		Parent = Holder,
	})
	UI.New("UIGradient", {
		Color = Gradient,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6, 0.6), NumberSequenceKeypoint.new(1, 1) }),
		Parent = Line,
	})
	return Holder
end

-- The gray "Time-Limited" bar above a group of cards
function UI.SubHeader(Parent: Instance, Text: string, LayoutOrder: number?)
	local Bar = UI.New("Frame", {
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = UI.Colors.DarkerGray,
		LayoutOrder = LayoutOrder or 0,
		Parent = Parent,
	}, { UI.Corner(6) })
	UI.New("UIGradient", {
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }),
		Parent = Bar,
	})
	UI.Text({ Text = Text, TextSize = 17, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(1, -16, 1, 0), Position = UDim2.fromOffset(10, 0), Parent = Bar })
	return Bar
end

-- A reward slot: rarity-colored square with art, "2,000x" in the corner and a name underneath.
-- Art is an image id, or a Model to show in 3D.
function UI.Slot(Parent: Instance, Props: { Art: any, Count: number?, Name: string?, Rarity: string?, Size: number?, LayoutOrder: number? })
	local Size = Props.Size or 70
	local Root = UI.New("Frame", {
		Size = UDim2.fromOffset(Size, Size),
		BackgroundColor3 = UI.Colors.White,
		LayoutOrder = Props.LayoutOrder or 0,
		Parent = Parent,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.Black, 2) })
	UI.Gradient(UI.Gradients[Props.Rarity or "Common"] or UI.Gradients.Common, 90).Parent = Root
	-- darken the middle so the art pops
	UI.New("Frame", {
		Size = UDim2.new(1, -6, 1, -6),
		Position = UDim2.fromOffset(3, 3),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 0.45,
		Parent = Root,
	}, { UI.Corner(6) })
	UI.Image({ Image = UI.Images.Checkered, ImageTransparency = 0.9, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(8, 8), Size = UDim2.fromScale(1, 1), Parent = Root })

	if typeof(Props.Art) == "Instance" then
		UI.ModelView(Root, Props.Art, UDim2.fromScale(0.86, 0.86))
	elseif Props.Art then
		UI.Image({
			Image = Props.Art,
			Size = UDim2.fromScale(0.72, 0.72),
			Position = UDim2.fromScale(0.5, 0.46),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 2,
			Parent = Root,
		})
	end
	if Props.Count then
		UI.Text({
			Text = UI.Comma(Props.Count) .. "x",
			TextSize = 14,
			Size = UDim2.new(1, -6, 0, 16),
			Position = UDim2.fromOffset(4, 2),
			ZIndex = 3,
			Parent = Root,
		})
	end
	if Props.Name then
		UI.Text({
			Text = Props.Name,
			TextSize = 12,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Center,
			Size = UDim2.new(1, -4, 0, 26),
			Position = UDim2.new(0, 2, 1, -27),
			TextYAlignment = Enum.TextYAlignment.Bottom,
			ZIndex = 3,
			Parent = Root,
		})
	end
	return Root
end

-- A 3D look at a model (used for your items, which have no icons yet)
function UI.ModelView(Parent: Instance, Template: Model, Size: UDim2, Spin: boolean?): ViewportFrame
	local View = UI.New("ViewportFrame", {
		Size = Size,
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Ambient = Color3.fromRGB(200, 200, 200),
		LightColor = Color3.new(1, 1, 1),
		LightDirection = Vector3.new(-1, -1, -1),
		ZIndex = 2,
		Parent = Parent,
	})
	local Model = Template:Clone()
	for _, Item in Model:GetDescendants() do
		if Item:IsA("Script") or Item:IsA("LocalScript") then
			Item:Destroy()
		end
	end
	Model:PivotTo(CFrame.new())
	Model.Parent = View
	local Camera = UI.New("Camera", { FieldOfView = 30, Parent = View })
	View.CurrentCamera = Camera
	local Center, BoxSize = Model:GetBoundingBox()
	local Radius = BoxSize.Magnitude / 2
	local Distance = Radius / math.tan(math.rad(15)) * 1.05
	local function Aim(Angle: number)
		local Offset = CFrame.Angles(0, Angle, 0) * CFrame.Angles(math.rad(-18), 0, 0)
		Camera.CFrame = CFrame.new(Center.Position) * Offset * CFrame.new(0, 0, Distance)
	end
	Aim(math.rad(35))
	if Spin then
		local Connection
		Connection = RunService.RenderStepped:Connect(function()
			if not View.Parent then
				Connection:Disconnect()
				return
			end
			Aim(os.clock() * 0.6)
		end)
	end
	return View
end

------------------------------------------------------------------------
-- Text helpers
------------------------------------------------------------------------
function UI.Comma(Number: number): string
	local Text = tostring(math.floor(Number))
	local Result = Text:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (Result:gsub("^,", ""))
end

-- 9000 -> "2h, 30m", 90 -> "1m, 30s"
function UI.TimeLeft(Seconds: number): string
	Seconds = math.max(0, math.floor(Seconds))
	local Days = math.floor(Seconds / 86400)
	local Hours = math.floor(Seconds % 86400 / 3600)
	local Minutes = math.floor(Seconds % 3600 / 60)
	if Days > 0 then
		return `{Days}d, {Hours}h`
	elseif Hours > 0 then
		return `{Hours}h, {Minutes}m`
	end
	return `{Minutes}m, {Seconds % 60}s`
end

------------------------------------------------------------------------
-- The menu window
------------------------------------------------------------------------
local DESIGN_SCREEN = Vector2.new(1920, 1009) -- the menus are laid out for this screen size
local MENU_SIZE = Vector2.new(1140, 680)

-- the header ship's flipbook sheet: 16 frames of 256x256, 4 per row, read left to right
local SHIP_FRAME = 256
local SHIP_COLUMNS = 4
local SHIP_FRAMES = 16
local SHIP_FPS = 8 -- one trip through the 16 frames every 2 seconds
-- where it sits: bigger than the old wheel and raised, so the bottom of the waves ends above the
-- menu's content (tabs like "All") instead of covering it. Positions are relative to the header.
local SHIP_SIZE = 200
local SHIP_HOME = UDim2.new(0, -104, 0.5, -47)
local SHIP_START = UDim2.new(0, -168, 3, 0) -- where it rises up from when the menu opens

-- where each cloud is on the cloud sheet
local CLOUDS = {
	{ Offset = Vector2.new(30, 39), Size = Vector2.new(452, 177) },
	{ Offset = Vector2.new(559, 48), Size = Vector2.new(417, 160) },
	{ Offset = Vector2.new(112, 318), Size = Vector2.new(288, 132) },
	{ Offset = Vector2.new(593, 298), Size = Vector2.new(349, 172) },
	{ Offset = Vector2.new(74, 565), Size = Vector2.new(363, 149) },
	{ Offset = Vector2.new(581, 555), Size = Vector2.new(374, 170) },
	{ Offset = Vector2.new(31, 820), Size = Vector2.new(450, 152) },
	{ Offset = Vector2.new(604, 820), Size = Vector2.new(328, 151) },
}
-- the header's cloud spots (centers, relative to the header). Each open puts a different random
-- cloud in each spot, sometimes mirrored. From = where it slides in from, relative to its spot.
local CLOUD_SPOTS = {
	{ Center = Vector2.new(104, -8), Width = 190, Rotation = 0, From = Vector2.new(-48, 64), ZIndex = 21 }, -- above the title
	{ Center = Vector2.new(262, -24), Width = 120, Rotation = 4, From = Vector2.new(-60, 40), ZIndex = 19 }, -- small one peeking from behind
	-- along the top edge of the window, over the tabs
	{ Center = Vector2.new(560, -20), Width = 150, Rotation = 2, From = Vector2.new(-70, 20), ZIndex = 21 },
	{ Center = Vector2.new(770, -28), Width = 175, Rotation = -3, From = Vector2.new(-90, 20), ZIndex = 21 },
	{ Center = Vector2.new(960, -18), Width = 130, Rotation = 3, From = Vector2.new(-110, 20), ZIndex = 21 },
}
-- the drift, like Anime Squadron's headers: each cloud slides sideways and tilts a little, then
-- back, at its own timing. Menus snap to whole pixels, so a slow, short drift steps visibly; this
-- distance keeps the steps small and frequent enough to look smooth.
local CLOUD_DRIFT = 40 -- pixels
-- the clouds keep their own grey and white instead of taking the menu's color. Change this to tint
-- them (it multiplies, like ImageColor3: white = as drawn).
local CLOUD_COLOR = Color3.new(1, 1, 1)
local CLOUD_TILT = 3 -- degrees
local CLOUD_PERIOD = 6 -- seconds there and back

-- opening/closing: fade + grow, like the Custom Servers menu in the JS Test place
local FADE_TIME = 0.2 -- seconds
local POP_FROM = 0.6 -- size it grows from (and shrinks back to)
local BLUR_SIZE = 18 -- blur on the world behind the menu
local DIM_AMOUNT = 0.35 -- how dark the screen behind it gets (0 = not at all)

-- one blur shared by all menus (only on your own screen)
local Blur: BlurEffect? = nil
local function MenuBlur(): BlurEffect
	if not Blur or not Blur.Parent then
		Blur = Instance.new("BlurEffect")
		Blur.Name = "MenuBlur"
		Blur.Size = 0
		Blur.Parent = game:GetService("Lighting")
	end
	return Blur :: BlurEffect
end

local OpenMenus: { any } = {}

------------------------------------------------------------------------
-- One menu at a time, together with the game's own menus
------------------------------------------------------------------------
-- The game's menus each keep their own open/closed state, so they're opened and closed only
-- through their own functions (never by hiding their frames from here):
--   Cosmetics  shared.cosgui()   toggles PlayerGui.Cosmetics.Frame
--   Gifting    shared.giftgui()  toggles PlayerGui.Gifting.Frame
--   Emotes     shared.emotegui() toggles the wheel, shared.closeEmoteWheel() closes it
--   top-bar dropdowns (shared.CharactersIcon, SettingsIcon, AdminIcon, ServersIcon): :deselect()
local GAME_TOGGLES = { "cosgui", "giftgui", "emotegui" }
local GAME_ICONS = { "CharactersIcon", "SettingsIcon", "AdminIcon", "ServersIcon" }
local Wrapped: { [string]: any } = {} -- our wrappers, put in shared in place of theirs
local Originals: { [string]: any } = {} -- theirs, for closing them without closing ours
local Owned: { [any]: boolean } = {} -- shared functions that open one of OUR menus: never wrapped

-- For a menu built with this kit that takes over one of the game's shared functions (the new
-- Cosmetics menu is shared.cosgui): sets it, and keeps it out of the game-menu handling, since
-- our menus already close each other.
function UI.Own(Name: string, Fn: (...any) -> ...any)
	Owned[Fn] = true
	(shared :: any)[Name] = Fn
end

local function GameToggle(Name: string): any
	local Current = (shared :: any)[Name]
	if Current ~= nil and Owned[Current] then
		return nil -- one of ours
	end
	if Current ~= nil and Current == Wrapped[Name] then
		return Originals[Name]
	end
	return Current
end

local function CloseOurMenus()
	for _, Menu in OpenMenus do
		if Menu.IsOpen then
			Menu:SetOpen(false)
		end
	end
end

-- Closes whichever of the game's menus is open (called when one of ours opens).
local function CloseGameMenus()
	local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
	local function Showing(GuiName: string): boolean
		local Gui = PlayerGui and PlayerGui:FindFirstChild(GuiName)
		local Main = Gui and Gui:FindFirstChild("Frame")
		return Main ~= nil and Main:IsA("GuiObject") and Main.Visible
	end
	local Shared = shared :: any
	local Cosmetics, Gifting = GameToggle("cosgui"), GameToggle("giftgui")
	if Showing("Cosmetics") and Cosmetics then
		pcall(Cosmetics)
	end
	if Showing("Gifting") and Gifting then
		pcall(Gifting)
	end
	if Shared.closeEmoteWheel then
		pcall(Shared.closeEmoteWheel)
	end
	for _, Name in GAME_ICONS do
		local Icon = Shared[Name]
		if Icon and Icon.isSelected then
			pcall(Icon.deselect, Icon)
		end
	end
end

-- Closes every menu, ours and the game's (the top bar's hide button in Icons uses it).
function UI.CloseAllMenus()
	CloseOurMenus()
	CloseGameMenus()
end

-- The other way round: opening one of the game's menus closes ours. Their open functions are
-- wrapped (and re-wrapped whenever their script sets them again, e.g. after a respawn), and their
-- dropdown icons get a 'selected' hook.
local Hooked: { [any]: boolean } = setmetatable({}, { __mode = "k" }) :: any
task.spawn(function()
	while true do
		local Shared = shared :: any
		for _, Name in GAME_TOGGLES do
			local Current = Shared[Name]
			if type(Current) == "function" and Current ~= Wrapped[Name] and not Owned[Current] then
				local Original = Current
				Originals[Name] = Original
				Wrapped[Name] = function(...)
					CloseOurMenus()
					return Original(...)
				end
				Shared[Name] = Wrapped[Name]
			end
		end
		for _, Name in GAME_ICONS do
			local Icon = Shared[Name]
			if type(Icon) == "table" and not Hooked[Icon] and Icon.bindEvent then
				Hooked[Icon] = true
				pcall(Icon.bindEvent, Icon, "selected", CloseOurMenus)
			end
		end
		task.wait(1)
	end
end)

function UI.Window(Config: { Name: string, Title: string, Gradient: ColorSequence, Icon: string? })
	local Gradient = Config.Gradient
	local Gui = UI.New("ScreenGui", {
		Name = Config.Name,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 30,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Enabled = false,
		Parent = Player:WaitForChild("PlayerGui"),
	})
	-- the darkening behind the menu: a plain frame, so it doesn't take clicks
	local Dim = UI.New("Frame", {
		Name = "Dim",
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 1,
		Parent = Gui,
	})
	-- clicking outside the menu closes it. This catches those clicks everywhere except the top bar,
	-- so the top-bar buttons (including the one that opened this menu) still work.
	local Outside = UI.New("TextButton", {
		Name = "Outside",
		BackgroundTransparency = 1,
		Text = "",
		AutoButtonColor = false,
		Parent = Gui,
	})
	local function FitOutside()
		local TopBar = GuiService:GetGuiInset().Y
		local Ok, Inset = pcall(function()
			return GuiService.TopbarInset
		end)
		if Ok and typeof(Inset) == "Rect" then
			TopBar = math.max(TopBar, Inset.Max.Y)
		end
		Outside.Position = UDim2.fromOffset(0, TopBar)
		Outside.Size = UDim2.new(1, 0, 1, -TopBar)
	end
	FitOutside()
	pcall(function()
		GuiService:GetPropertyChangedSignal("TopbarInset"):Connect(FitOutside)
	end)

	-- everything sits in Scaler, which grows/shrinks with the screen
	local Scaler = UI.New("Frame", {
		Name = "Scaler",
		Size = UDim2.fromOffset(MENU_SIZE.X, MENU_SIZE.Y),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Parent = Gui,
	})
	local ScreenScale = UI.New("UIScale", { Parent = Scaler })
	local FitScale = 1 -- fits the screen
	local PopScale = 1 -- the open/close grow and shrink, on top of that
	local function Rescale()
		local Viewport = workspace.CurrentCamera.ViewportSize
		local Fit = math.min(Viewport.X / DESIGN_SCREEN.X, Viewport.Y / DESIGN_SCREEN.Y)
		-- and always leave room around it for the header and the close button
		local Room = math.min((Viewport.X - 40) / (MENU_SIZE.X + 60), (Viewport.Y - 60) / (MENU_SIZE.Y + 80))
		FitScale = math.clamp(math.min(Fit, Room), 0.35, 1.5)
		ScreenScale.Scale = FitScale * PopScale
	end
	Rescale()
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(Rescale)

	local Window = UI.New("Frame", {
		Name = "Window",
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 0.05,
		Parent = Scaler,
	}, { UI.Corner(12), UI.Stroke(UI.Colors.Black, 4) })
	-- glowing border: bright in the middle of each edge, fading to the corners
	local Glow = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Parent = Window,
	}, { UI.Corner(12) })
	local GlowStroke = UI.Stroke(UI.Colors.White, 3)
	GlowStroke.Parent = Glow
	UI.New("UIGradient", {
		Color = Gradient,
		Rotation = 90,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.55), NumberSequenceKeypoint.new(1, 0) }),
		Parent = GlowStroke,
	})
	-- soft colored glow spilling outside the window
	local Halo = UI.Image({
		Image = UI.Images.SoftGlow,
		Size = UDim2.new(1, 104, 1, 104),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ImageTransparency = 0.8,
		ScaleType = Enum.ScaleType.Stretch,
		ZIndex = 0,
		Parent = Window,
	})
	UI.Gradient(Gradient, 45).Parent = Halo

	-- header
	local Header = UI.New("Frame", {
		Name = "Header",
		Size = UDim2.fromOffset(408, 62),
		Position = UDim2.fromOffset(52, 4),
		BackgroundTransparency = 1,
		ZIndex = 20,
		Parent = Window,
	})
	local Ribbon = UI.Image({
		Name = "Ribbon",
		Image = UI.Images.Ribbon,
		Size = UDim2.fromOffset(464, 120),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 20,
		Parent = Header,
	})
	local RibbonGradient = UI.Gradient(Gradient, 0)
	RibbonGradient.Parent = Ribbon
	local Clouds: { { Image: ImageLabel, Spot: any, Phase: number } } = {}
	for _, Spot in CLOUD_SPOTS do
		local Cloud = UI.Image({
			Name = "Cloud",
			Image = UI.Images.Clouds,
			ImageColor3 = CLOUD_COLOR,
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromOffset(Spot.Center.X, Spot.Center.Y),
			Rotation = Spot.Rotation,
			ZIndex = Spot.ZIndex,
			Parent = Header,
		})
		table.insert(Clouds, { Image = Cloud, Spot = Spot, Phase = 0 })
	end
	-- a different random cloud in each spot, some mirrored, each drifting at its own timing
	local function ShuffleClouds()
		local Order = {}
		for Index = 1, #CLOUDS do
			table.insert(Order, math.random(1, Index), Index)
		end
		for Index, Cloud in Clouds do
			local Art = CLOUDS[Order[Index]]
			local Image = Cloud.Image
			if math.random() < 0.5 then
				Image.ImageRectOffset = Art.Offset
				Image.ImageRectSize = Art.Size
			else
				Image.ImageRectOffset = Art.Offset + Vector2.new(Art.Size.X, 0)
				Image.ImageRectSize = Vector2.new(-Art.Size.X, Art.Size.Y)
			end
			Image.Size = UDim2.fromOffset(Cloud.Spot.Width, math.floor(Cloud.Spot.Width * Art.Size.Y / Art.Size.X))
			Cloud.Phase = math.random() * math.pi * 2
		end
	end
	ShuffleClouds()
	-- the ship on the waves, where the wheel used to be (in its own colors, not tinted). It plays
	-- the flipbook: one 256x256 frame of the 4x4 sheet at a time.
	local Ship = UI.Image({
		Name = "Ship",
		Image = UI.Images.Ship,
		ImageRectSize = Vector2.new(SHIP_FRAME, SHIP_FRAME),
		ImageRectOffset = Vector2.zero,
		Size = UDim2.fromOffset(SHIP_SIZE, SHIP_SIZE),
		Position = SHIP_HOME,
		AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 22,
		Parent = Header,
	})
	local TitleRow = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromOffset(78, 0),
		BackgroundTransparency = 1,
		ZIndex = 23,
		Parent = Header,
	}, {
		UI.New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	if Config.Icon then
		UI.Image({ Image = Config.Icon, Size = UDim2.fromOffset(52, 52), Rotation = -15, LayoutOrder = 1, ZIndex = 24, Parent = TitleRow })
	end
	UI.Text({ Text = Config.Title, TextSize = 32, Weight = "ExtraBold", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), LayoutOrder = 2, ZIndex = 24, Parent = TitleRow })

	-- close button, half outside the top-right corner
	local Close = UI.Button({
		Parent = Window,
		Size = UDim2.fromOffset(46, 46),
		Position = UDim2.new(1, -8, 0, 8),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Gradient = UI.Gradients.Red,
		Grow = 0.12,
	})
	Close.Root.ZIndex = 30
	Close.Visual:FindFirstChildOfClass("UICorner").CornerRadius = UDim.new(1, 0)
	Close.Visual.HoverOutline:FindFirstChildOfClass("UICorner").CornerRadius = UDim.new(1, 0)
	Close.Visual:FindFirstChildOfClass("UIStroke").Color = UI.Colors.White
	UI.Image({ Image = UI.Images.Close, Size = UDim2.fromScale(0.55, 0.55), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 4, Parent = Close.Visual })

	-- the content area under the header
	local Body = UI.New("Frame", {
		Name = "Body",
		Size = UDim2.new(1, -28, 1, -86),
		Position = UDim2.fromOffset(14, 72),
		BackgroundTransparency = 1,
		Parent = Window,
	})

	local Menu = { Gui = Gui, Window = Window, Header = Header, Body = Body, IsOpen = false, OnOpen = nil :: (() -> ())? }

	-- the ship plays its flipbook (sailing, bobbing, waves moving) and tips in as it arrives, like
	-- the wheel used to whip round; the ribbon's gradient slowly scrolls; the clouds slide in, then
	-- drift
	local OpenedAt = 0
	local Spinner: RBXScriptConnection? = nil
	local function Animate()
		local Since = os.clock() - OpenedAt
		local Intro = 1 - math.clamp(Since / 0.45, 0, 1)
		Intro = Intro * Intro
		local Frame = math.floor(os.clock() * SHIP_FPS) % SHIP_FRAMES
		Ship.ImageRectOffset = Vector2.new((Frame % SHIP_COLUMNS) * SHIP_FRAME, math.floor(Frame / SHIP_COLUMNS) * SHIP_FRAME)
		Ship.Rotation = -Intro * 25
		RibbonGradient.Offset = Vector2.new(math.sin(os.clock() * 0.8) * 0.25, 0)
		local Arrive = math.clamp(Since / 0.45, 0, 1)
		local Away = (1 - Arrive) ^ 5 -- quint out
		for _, Cloud in Clouds do
			local Spot = Cloud.Spot
			local Drift = (1 - math.cos(os.clock() * math.pi * 2 / CLOUD_PERIOD + Cloud.Phase)) / 2 -- 0..1, eases at both ends
			local Center = Spot.Center + Spot.From * Away + Vector2.new(CLOUD_DRIFT * Drift, 0)
			Cloud.Image.Position = UDim2.fromOffset(Center.X, Center.Y)
			Cloud.Image.Rotation = Spot.Rotation - CLOUD_TILT + CLOUD_TILT * Drift
		end
	end

	-- Fade + grow, like the Custom Servers menu: over FADE_TIME everything fades in from invisible
	-- while the menu grows from 60% to full size and the world behind blurs; closing does the
	-- reverse. Each element's normal transparency is remembered so it fades back to exactly that.
	local Faded: { { Object: Instance, Props: { [string]: number } } } = {}
	local Fading: RBXScriptConnection? = nil
	local Joining: RBXScriptConnection? = nil
	local Shown = 0 -- 0 = invisible, 1 = fully shown

	local function Show(Alpha: number, Entries: { any })
		for _, Entry in Entries do
			local Object = Entry.Object :: any
			if Object.Parent then
				for Prop, Normal in Entry.Props do
					Object[Prop] = 1 - (1 - Normal) * Alpha
				end
			end
		end
	end

	-- Each element's normal transparency, kept between opens. It's only (re)read while the menu
	-- is fully shown, never while it's faded out -- reading it then would remember "invisible".
	local Normals: { [Instance]: { [string]: number } } = setmetatable({}, { __mode = "k" }) :: any

	local function Read(Object: Instance): { [string]: number }?
		local Props = {}
		if Object:IsA("GuiObject") then
			Props.BackgroundTransparency = Object.BackgroundTransparency
			if Object:IsA("TextLabel") or Object:IsA("TextButton") or Object:IsA("TextBox") then
				Props.TextTransparency = Object.TextTransparency
				Props.TextStrokeTransparency = Object.TextStrokeTransparency
			elseif Object:IsA("ImageLabel") or Object:IsA("ImageButton") or Object:IsA("ViewportFrame") then
				Props.ImageTransparency = Object.ImageTransparency
			end
			if Object:IsA("ScrollingFrame") then
				Props.ScrollBarImageTransparency = Object.ScrollBarImageTransparency
			end
		elseif Object:IsA("UIStroke") then
			Props.Transparency = Object.Transparency
		else
			return nil
		end
		return Props
	end

	-- Fresh = read the element's current look as its normal one (only when fully shown, or for an
	-- element that's never been faded)
	local function Capture(Object: Instance, Fresh: boolean)
		local Props = Normals[Object]
		if Fresh or not Props then
			Props = Read(Object)
			if not Props then
				return
			end
			Normals[Object] = Props
		end
		local Entry = { Object = Object, Props = Props :: { [string]: number } }
		table.insert(Faded, Entry)
		if Fading then -- made mid-fade (e.g. Store cards built as it opens): join in, don't pop in
			Show(Shown, { Entry })
		end
	end

	local function Remember(Fresh: boolean)
		table.clear(Faded)
		for _, Object in Scaler:GetDescendants() do
			Capture(Object, Fresh)
		end
	end

	local function Transition(Opening: boolean, Done: (() -> ())?)
		if Fading then
			Fading:Disconnect() -- reversing mid-fade: carry on from where it is, with what we remembered
		else
			-- closing from fully open: read everything fresh (picks up selections, hovers etc.);
			-- opening from closed: everything is faded out, so use what was remembered
			Remember(not Opening)
		end
		local From, Started = Shown, os.clock()
		local Target = if Opening then 1 else 0
		local Blur = MenuBlur()
		if not Joining then
			Joining = Scaler.DescendantAdded:Connect(function(Object)
				task.defer(function() -- after its creator has finished setting it up
					if Fading and Object.Parent then
						Capture(Object, true) -- brand new, so its current look is its normal one
					end
				end)
			end)
		end
		Fading = RunService.RenderStepped:Connect(function()
			local T = math.clamp((os.clock() - Started) / FADE_TIME, 0, 1)
			local Eased = 1 - (1 - T) * (1 - T) -- quad out, like a default TweenInfo
			Shown = From + (Target - From) * Eased
			Show(Shown, Faded)
			PopScale = POP_FROM + (1 - POP_FROM) * Shown
			ScreenScale.Scale = FitScale * PopScale
			Dim.BackgroundTransparency = 1 - DIM_AMOUNT * Shown
			Blur.Size = BLUR_SIZE * Shown
			if T >= 1 then
				(Fading :: RBXScriptConnection):Disconnect()
				Fading = nil
				if Joining then
					Joining:Disconnect()
					Joining = nil
				end
				if Done then
					Done()
				end
			end
		end)
	end

	function Menu:SetOpen(Open: boolean)
		if Menu.IsOpen == Open then
			return
		end
		Menu.IsOpen = Open
		if Open then
			CloseGameMenus() -- the game's own menus (Cosmetics, Gifting, Emotes, dropdowns)
			for _, Other in OpenMenus do -- one menu at a time
				if Other ~= Menu and Other.IsOpen then
					Other:SetOpen(false)
				end
			end
			Gui.Enabled = true
			UI.Play("Open", 0.5)
			OpenedAt = os.clock()
			if not Spinner then
				Spinner = RunService.RenderStepped:Connect(Animate)
			end
			Transition(true)
			-- the ship rises and the ribbon slides into place while the menu fades in
			Ship.Position = SHIP_START -- rises up into place, same as the wheel did
			TweenService:Create(Ship, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = SHIP_HOME }):Play()
			Ribbon.Position = UDim2.fromScale(0.25, 1.5)
			Ribbon.Rotation = -15
			TweenService:Create(Ribbon, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.fromScale(0.5, 0.5), Rotation = 0 }):Play()
			ShuffleClouds() -- new clouds each time; Animate slides them in
			if Menu.OnOpen then
				task.spawn(Menu.OnOpen)
			end
		else
			Transition(false, function()
				if not Menu.IsOpen then
					Gui.Enabled = false
					if Spinner then
						Spinner:Disconnect()
						Spinner = nil
					end
				end
			end)
		end
	end

	function Menu:Toggle()
		Menu:SetOpen(not Menu.IsOpen)
	end

	Close.Root.Activated:Connect(function()
		UI.Play("Click", 0.4)
		Menu:SetOpen(false)
	end)
	-- Plain frames don't stop clicks, so a click on any empty part of the menu reaches Outside
	-- too: only close when it really landed outside the menu.
	local function Over(Object: GuiObject, Point: Vector2): boolean
		local Min, Size = Object.AbsolutePosition, Object.AbsoluteSize
		return Point.X >= Min.X and Point.Y >= Min.Y and Point.X <= Min.X + Size.X and Point.Y <= Min.Y + Size.Y
	end
	Outside.Activated:Connect(function()
		local Point = UserInputService:GetMouseLocation() -- includes the top bar inset, like this IgnoreGuiInset gui
		for _, Part in { Window, Header, Ship, Close.Root } do
			if Over(Part, Point) then
				return
			end
		end
		Menu:SetOpen(false)
	end)
	UserInputService.InputBegan:Connect(function(Input, Processed)
		if not Processed and Menu.IsOpen and (Input.KeyCode == Enum.KeyCode.Escape or Input.KeyCode == Enum.KeyCode.ButtonB) then
			Menu:SetOpen(false)
		end
	end)

	table.insert(OpenMenus, Menu)
	return Menu
end

-- A row of tabs; the chosen one takes the gradient, the rest are grey
function UI.Tabs(Parent: Instance, Names: { string }, Gradient: ColorSequence, OnSelect: (string) -> (), Props: { Size: UDim2, Position: UDim2 })
	local Bar = UI.New("Frame", {
		Size = Props.Size,
		Position = Props.Position,
		BackgroundTransparency = 1,
		Parent = Parent,
	}, {
		UI.New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, 6),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	local Buttons = {}
	local Width = 1 / #Names
	local function Select(Name: string)
		for TabName, Button in Buttons do
			Button.Fill.Color = if TabName == Name then Gradient else UI.Gradients.Grey
		end
		OnSelect(Name)
	end
	for Index, Name in Names do
		Buttons[Name] = UI.Button({
			Parent = Bar,
			Size = UDim2.new(Width, -6, 1, 0),
			Text = Name,
			TextSize = 18,
			LayoutOrder = Index,
			Grow = 0.04,
			OnClick = function()
				Select(Name)
			end,
		})
	end
	return Select, Buttons
end

-- A dark scrolling list with their thin bright scrollbar
function UI.Scroller(Parent: Instance, Props: { Size: UDim2, Position: UDim2?, Padding: number?, Color: Color3? })
	local Scroll = UI.New("ScrollingFrame", {
		Size = Props.Size,
		Position = Props.Position or UDim2.new(),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Props.Color or UI.Colors.White,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		CanvasSize = UDim2.new(),
		Parent = Parent,
	}, {
		UI.New("UIListLayout", { Padding = UDim.new(0, Props.Padding or 10), SortOrder = Enum.SortOrder.LayoutOrder }),
		UI.New("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 14) }),
	})
	return Scroll
end

-- Your game's normal notification, the same as the server's "SendNotification" (your
-- Notification sound + Roblox's notification popup), so item/quest messages look like the rest.
function UI.Notify(Text: string, Title: string?)
	local Sounds = game:GetService("ReplicatedStorage"):FindFirstChild("Assets")
	local Sound = Sounds and Sounds:FindFirstChild("Sounds") and Sounds.Sounds:FindFirstChild("Notification")
	Sound = Sound and Sound:FindFirstChild("Sound1")
	if Sound and Sound:IsA("Sound") then
		Sound:Play()
	end
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", { Title = Title or "NOTIFICATION", Text = Text })
	end)
end

-- Short message: everything goes out as a normal notification (UI.Notify) in the corner,
-- errors too ("You need 50 more Gold"). The big red text under the hotbar is no longer used.
function UI.Toast(Text: string, Good: boolean?)
	UI.Notify(Text, if Good == false then "NOTICE" else nil)
end

return UI
