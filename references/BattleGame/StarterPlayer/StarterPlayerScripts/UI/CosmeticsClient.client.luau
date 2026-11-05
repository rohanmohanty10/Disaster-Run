-- StarterPlayer > StarterPlayerScripts > CosmeticsClient   (LocalScript, client)
--
-- The Cosmetics menu, laid out like Heroes Battlegrounds' (search, Inventory / Information,
-- a grid of items with their kill requirement, and an "unlock in / equip" bar at the bottom),
-- in the same style as the Store and Quests menus (ReplicatedStorage.Modules.ExpeditionUI).
--
-- Categories (tabs in the header): Accessories, Auras (shown once the server has any), Titles.
-- Emotes have their own menu (EmoteMenuClient); the "Emotes" button here opens it.
--
-- It uses your existing server pipeline unchanged:
--   Remotes.Cosmetics.Get  {Goal = "GetAllCosmetics" / "GetOwnedAccessories" / "GetOwnedAuras"}
--   Remotes.Cosmetics.Set  {Type = "Accessories" / "Auras" / "Titles", Name, State = "Equip"/"Unequip"}
--   Player.Cosmetics.Accessories / .Auras   (folders of what's equipped, kept by the server)
--   Player attribute EquippedTitleName       (the equipped title, set by the server)
--   ReplicatedStorage.Assets.Accessories     (the 3D models), .Assets.Cosmetics.Titles (the titles)
-- Replaces the old StarterGui.Cosmetics menu: disable its Cosmetics and Titles scripts.
-- Opened by the Cosmetics button in Icons (shared.cosgui).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))

local Player = Players.LocalPlayer
repeat
	task.wait()
until game:IsLoaded() and Player:GetAttribute("Loaded") == true

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CosmGet: RemoteFunction = Remotes.Cosmetics:WaitForChild("Get")
local CosmSet: RemoteEvent = Remotes.Cosmetics:WaitForChild("Set")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local AccessoryModels = Assets:WaitForChild("Accessories")
local TitleAssets = Assets:WaitForChild("Cosmetics"):WaitForChild("Titles")
local Equipped = Player:WaitForChild("Cosmetics")
local EquippedAccessories = Equipped:WaitForChild("Accessories")
local EquippedAuras = Equipped:WaitForChild("Auras")
local TotalKills = Player:WaitForChild("leaderstats"):WaitForChild("Total Kills")

------------------------------------------------------------------------
-- Look
------------------------------------------------------------------------
local RGB = Color3.fromRGB
local THEME = ColorSequence.new(RGB(232, 226, 214), RGB(150, 142, 130)) -- the neutral stone of Store/Quests
local DONE = ColorSequence.new(RGB(184, 216, 156), RGB(116, 162, 96))
local CARD = RGB(24, 24, 24)
local PANEL = RGB(16, 16, 16)
local EDGE = RGB(55, 55, 55)
local MUTED = RGB(170, 166, 158)
local EQUIPPED_COLOR = RGB(140, 220, 110)
local UNLOCKED_COLOR = RGB(200, 194, 182)
local LOCKED_COLOR = RGB(40, 40, 40)
local VIP_KILLS = 1000000 -- requirements above this mean VIP only (same rule as the old menu)

------------------------------------------------------------------------
-- Data
------------------------------------------------------------------------
type Item = {
	Category: string, -- "Accessories" / "Auras" / "Titles"
	Name: string,
	Kills: number, -- requirement (Titles: their Requirement attribute)
	ReqType: string?, -- Titles: "Kills" / "VIP" / "Special"
	ID: number?, -- Titles: the UserId for Special titles
	Title: TextLabel?, -- Titles: the styled label
	Description: string?,
	LayoutOrder: number,
}

local Items: { [string]: { Item } } = { Accessories = {}, Auras = {}, Titles = {} }
local Owned: { [string]: { string } } = { Accessories = {}, Auras = {} }

local function Fetch(Goal: string): any
	local Ok, Result = pcall(CosmGet.InvokeServer, CosmGet, { Goal = Goal })
	return if Ok then Result else nil
end

local function LoadItems()
	local All = Fetch("GetAllCosmetics") or {}
	for _, Category in { "Accessories", "Auras" } do
		for _, Info in (All[Category] or {}) :: { any } do
			if type(Info) == "table" and Info.Name then
				table.insert(Items[Category], {
					Category = Category,
					Name = Info.Name,
					Kills = Info.Kills or 0,
					LayoutOrder = Info.Kills or 0,
				})
			end
		end
		table.sort(Items[Category], function(A, B)
			return if A.Kills ~= B.Kills then A.Kills < B.Kills else A.Name < B.Name
		end)
	end
	for _, Styled in TitleAssets:GetChildren() do
		if Styled:IsA("TextLabel") then
			local ReqType = Styled:GetAttribute("ReqType") or "Kills"
			local ID = Styled:GetAttribute("ID")
			if ReqType == "Special" and ID ~= Player.UserId then
				continue -- dev / staff titles only show to their owner
			end
			table.insert(Items.Titles, {
				Category = "Titles",
				Name = Styled.Name,
				Kills = Styled:GetAttribute("Requirement") or 0,
				ReqType = ReqType,
				ID = ID,
				Title = Styled,
				Description = Styled:GetAttribute("Description"),
				LayoutOrder = Styled:GetAttribute("LayoutOrder") or 0,
			})
		end
	end
	table.sort(Items.Titles, function(A, B)
		return A.LayoutOrder < B.LayoutOrder
	end)
end

local function RefreshOwned()
	Owned.Accessories = Fetch("GetOwnedAccessories") or {}
	Owned.Auras = Fetch("GetOwnedAuras") or {}
end

LoadItems()
RefreshOwned()

local function IsVip(Item: Item): boolean
	return Item.ReqType == "VIP" or (Item.Category ~= "Titles" and Item.Kills > VIP_KILLS)
end

local function IsUnlocked(Item: Item): boolean
	if Item.Category == "Titles" then
		if Item.ReqType == "Special" then
			return Item.ID == Player.UserId
		elseif Item.ReqType == "VIP" then
			return Player:GetAttribute("HasVIP") == true
		end
		return TotalKills.Value >= Item.Kills
	end
	if Item.Name == "Custom Cape" or table.find(Owned[Item.Category], Item.Name) then
		return true
	end
	return not IsVip(Item) and TotalKills.Value >= Item.Kills
end

local function IsEquipped(Item: Item): boolean
	if Item.Category == "Titles" then
		return Player:GetAttribute("EquippedTitleName") == Item.Name
	elseif Item.Category == "Auras" then
		return EquippedAuras:FindFirstChild(Item.Name) ~= nil
	end
	return EquippedAccessories:FindFirstChild(Item.Name) ~= nil
end

local function KillWord(Count: number): string
	return `{UI.Comma(Count)} {if Count == 1 then "KILL" else "KILLS"}`
end

local function Requirement(Item: Item): string
	if Item.Category == "Titles" and Item.ReqType == "Special" then
		return "SPECIAL"
	elseif IsVip(Item) then
		return "VIP"
	elseif Item.Kills <= 0 then
		return "FREE"
	end
	return KillWord(Item.Kills)
end

------------------------------------------------------------------------
-- The window
------------------------------------------------------------------------
local Menu = UI.Window({ Name = "CosmeticsUI", Title = "Cosmetics", Gradient = THEME })

-- Cosmetics and Emotes share this window: each fills its own page of the body, and the Emotes
-- header tab just swaps the pages (EmoteMenuClient builds into EmotesPage, shared.EmotesWindow)
local CosmeticsPage = UI.New("Frame", { Name = "CosmeticsPage", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Parent = Menu.Body })
local EmotesPage = UI.New("Frame", { Name = "EmotesPage", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, Parent = Menu.Body })

local Category = "Accessories"
local HeaderTab = Category -- the picked header tab: a category, or "Emotes"
local View = "Inventory" -- or "Information"
local Search = ""
local Selected: Item? = nil

local BAR_HEIGHT = 78
local ROW_HEIGHT = 42

-- top row: search, Inventory / Information
local SearchBox = UI.New("Frame", {
	Size = UDim2.new(0.5, -8, 0, ROW_HEIGHT),
	BackgroundColor3 = UI.Colors.DarkerGray,
	Parent = CosmeticsPage,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Image({ Image = UI.Images.Search, Size = UDim2.fromOffset(22, 22), Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ImageColor3 = UI.Colors.LightGray, Parent = SearchBox })
local SearchInput = UI.New("TextBox", {
	Size = UDim2.new(1, -52, 1, 0),
	Position = UDim2.fromOffset(44, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search cosmetics...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Medium"),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	Parent = SearchBox,
})

local Render -- defined below
local SelectView = UI.Tabs(CosmeticsPage, { "Inventory", "Information" }, THEME, function(Name)
	View = Name
	Render()
end, {
	Size = UDim2.new(0.5, 0, 0, ROW_HEIGHT),
	Position = UDim2.new(0.5, 0, 0, 0),
})

-- the middle: the grid (Inventory) or the picked item (Information)
local PAGE_TOP = ROW_HEIGHT + 10
local Pages = UI.New("Frame", {
	Size = UDim2.new(1, 0, 1, -(PAGE_TOP + BAR_HEIGHT + 10)),
	Position = UDim2.fromOffset(0, PAGE_TOP),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.2,
	ClipsDescendants = true,
	Parent = CosmeticsPage,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })

local Grid = UI.New("ScrollingFrame", {
	Size = UDim2.fromScale(1, 1),
	BackgroundTransparency = 1,
	ScrollBarThickness = 6,
	ScrollBarImageColor3 = RGB(176, 170, 160),
	ScrollingDirection = Enum.ScrollingDirection.Y,
	AutomaticCanvasSize = Enum.AutomaticSize.Y,
	CanvasSize = UDim2.new(),
	Parent = Pages,
}, {
	UI.New("UIGridLayout", {
		CellSize = UDim2.new(1 / 6, -10, 0, 196),
		CellPadding = UDim2.fromOffset(10, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
	}),
	UI.New("UIPadding", { PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 12) }),
})
local Empty = UI.Text({ Text = "Nothing here yet.", TextSize = 22, TextColor3 = UI.Colors.Gray, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 40), Position = UDim2.fromScale(0, 0.42), Visible = false, Parent = Pages })

-- Information page
local Info = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Visible = false, Parent = Pages })
local InfoPreview = UI.New("Frame", {
	Size = UDim2.new(0.44, -20, 1, -20),
	Position = UDim2.fromOffset(10, 10),
	BackgroundColor3 = CARD,
	ClipsDescendants = true,
	Parent = Info,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })
UI.Image({ Image = UI.Images.Checkered, ImageTransparency = 0.93, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(12, 12), Size = UDim2.fromScale(1, 1), Parent = InfoPreview })
local InfoSide = UI.New("Frame", { Size = UDim2.new(0.56, -20, 1, -20), Position = UDim2.new(0.44, 10, 0, 10), BackgroundTransparency = 1, Parent = Info })
local InfoName = UI.Text({ Text = "", TextSize = 34, Weight = "ExtraBold", TextScaled = true, Size = UDim2.new(1, 0, 0, 44), Parent = InfoSide })
UI.New("UITextSizeConstraint", { MaxTextSize = 34, Parent = InfoName })
local InfoTags = UI.New("Frame", { Size = UDim2.new(1, 0, 0, 28), Position = UDim2.fromOffset(0, 54), BackgroundTransparency = 1, Parent = InfoSide }, {
	UI.New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
})
local InfoDescription = UI.Text({ Text = "", TextSize = 18, NoStroke = true, TextColor3 = UI.Colors.LightGray, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 120), Position = UDim2.fromOffset(0, 96), Parent = InfoSide })
local InfoChat = UI.New("Frame", { Size = UDim2.new(1, 0, 0, 48), Position = UDim2.fromOffset(0, 226), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = 0.3, Visible = false, Parent = InfoSide }, { UI.Corner(8), UI.Stroke(EDGE, 1.5) })
local InfoChatText = UI.Text({ Text = "", TextSize = 18, NoStroke = true, RichText = true, Size = UDim2.new(1, -20, 1, 0), Position = UDim2.fromOffset(10, 0), Parent = InfoChat })

-- the bottom bar: UNLOCK IN / YOUR KILLS / EQUIP (Heroes Battlegrounds' unlock bar)
local Bar = UI.New("Frame", {
	Size = UDim2.new(1, 0, 0, BAR_HEIGHT),
	Position = UDim2.new(0, 0, 1, -BAR_HEIGHT),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.1,
	Parent = CosmeticsPage,
}, { UI.Corner(10), UI.Stroke(EDGE, 2) })

local function BarBox(X: number, Width: number, Caption: string): TextLabel
	UI.Text({ Text = Caption, TextSize = 16, TextColor3 = MUTED, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(Width, -16, 0, 20), Position = UDim2.new(X, 8, 0, 6), Parent = Bar })
	local Box = UI.New("Frame", {
		Size = UDim2.new(Width, -16, 0, 38),
		Position = UDim2.new(X, 8, 0, 30),
		BackgroundColor3 = CARD,
		Parent = Bar,
	}, { UI.Corner(8), UI.Stroke(EDGE, 2) })
	return UI.Text({ Text = "-", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = Box })
end
local UnlockText = BarBox(0, 0.27, "UNLOCK IN:")
local KillsText = BarBox(0.27, 0.27, "YOUR KILLS:")
local Progress = UI.New("Frame", { Size = UDim2.new(1, -16, 0, 4), Position = UDim2.new(0, 8, 1, -7), BackgroundColor3 = UI.Colors.DarkerGray, Parent = KillsText.Parent }, { UI.Corner(2) })
local ProgressFill = UI.New("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = UI.Colors.White, Parent = Progress }, { UI.Corner(2) })
local ProgressGradient = UI.Gradient(THEME, 0)
ProgressGradient.Parent = ProgressFill

local Equip = UI.Button({
	Parent = Bar,
	Size = UDim2.new(0.46, -16, 0, 56),
	Position = UDim2.new(1, -8, 0.5, 0),
	AnchorPoint = Vector2.new(1, 0.5),
	Text = "EQUIP",
	TextSize = 28,
	OnClick = function()
		local Item = Selected
		if not Item or not IsUnlocked(Item) then
			UI.Play("Error", 0.4)
			return
		end
		CosmSet:FireServer({ Type = Item.Category, Name = Item.Name, State = if IsEquipped(Item) then "Unequip" else "Equip" })
	end,
})

------------------------------------------------------------------------
-- Tiles
------------------------------------------------------------------------
type Tile = { Item: Item, Root: TextButton, Visual: Frame, Stroke: UIStroke, Badge: TextLabel, BadgeBox: Frame, NameLabel: TextLabel, Preview: GuiObject?, Lock: Frame, LineFill: Frame, Pick: UIStroke }
local Tiles: { Tile } = {}

-- the item itself: a 3D accessory, an aura, or the styled title label
local function MakePreview(Item: Item, Parent: GuiObject, Size: UDim2, Spin: boolean): GuiObject?
	if Item.Category == "Titles" and Item.Title then
		local Label = Item.Title:Clone()
		Label.Size = UDim2.new(0.9, 0, 0.3, 0)
		Label.Position = UDim2.fromScale(0.5, 0.45)
		Label.AnchorPoint = Vector2.new(0.5, 0.5)
		Label.TextScaled = true
		Label.BackgroundTransparency = 1
		Label.ZIndex = 2
		Label.Visible = true
		Label.Parent = Parent
		return Label
	end
	local Model = if Item.Category == "Accessories" then AccessoryModels:FindFirstChild(Item.Name) else nil
	if Model and Model:IsA("Model") then
		local Viewport = UI.ModelView(Parent, Model, Size, Spin)
		Viewport.Position = UDim2.fromScale(0.5, 0.45)
		return Viewport
	end
	-- auras (and anything without a model): a sparkle placeholder
	return UI.Image({ Image = UI.Images.Sparkle, Size = Size, Position = UDim2.fromScale(0.5, 0.45), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 2, Parent = Parent })
end

local function PaintTile(Tile: Tile)
	local Item = Tile.Item
	local Unlocked, On = IsUnlocked(Item), IsEquipped(Item)
	Tile.Stroke.Color = if On then EQUIPPED_COLOR elseif Unlocked then UNLOCKED_COLOR else LOCKED_COLOR
	Tile.Stroke.Thickness = if On then 3 else 2
	Tile.Badge.Text = if On then "EQUIPPED" elseif Unlocked then "UNLOCKED" else Requirement(Item)
	Tile.BadgeBox.BackgroundColor3 = if On then RGB(60, 110, 50) else UI.Colors.Black
	Tile.NameLabel.TextColor3 = if Unlocked then UI.Colors.White else MUTED
	Tile.Lock.Visible = not Unlocked
	-- locked accessories show as a black silhouette, like before
	local Preview = Tile.Preview
	if Preview and Preview:IsA("ViewportFrame") then
		Preview.ImageColor3 = if Unlocked then UI.Colors.White else RGB(10, 10, 12)
	end
	local Ratio = if Unlocked then 1 elseif IsVip(Item) or Item.Kills <= 0 then 0 else math.clamp(TotalKills.Value / Item.Kills, 0, 1)
	Tile.LineFill.Size = UDim2.fromScale(Ratio, 1)
	Tile.Pick.Transparency = if Selected == Item then 0 else 1
end

local function MakeTile(Item: Item, Order: number): Tile
	local Root = UI.New("TextButton", { Name = Item.Name, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Order, Parent = Grid })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = CARD,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(10) })
	local Stroke = UI.Stroke(UNLOCKED_COLOR, 2)
	Stroke.Parent = Visual
	UI.Image({ Image = UI.Images.Checkered, ImageTransparency = 0.94, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(8, 8), Size = UDim2.fromScale(1, 1), Parent = Visual })
	local Preview = MakePreview(Item, Visual, UDim2.fromScale(0.82, 0.62), false)

	-- requirement badge, top left (Heroes Battlegrounds' "2000 KILLS")
	local BadgeBox = UI.New("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 22),
		Position = UDim2.fromOffset(6, 6),
		BackgroundColor3 = UI.Colors.Black,
		BackgroundTransparency = 0.25,
		ZIndex = 4,
		Parent = Visual,
	}, { UI.Corner(6), UI.New("UIPadding", { PaddingLeft = UDim.new(0, 7), PaddingRight = UDim.new(0, 7) }) })
	local Badge = UI.Text({ Text = "", TextSize = 13, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), ZIndex = 4, Parent = BadgeBox })

	local NameLabel = UI.Text({
		Text = Item.Name,
		TextSize = 17,
		TextScaled = true,
		TextXAlignment = Enum.TextXAlignment.Center,
		Size = UDim2.new(1, -12, 0, 22),
		Position = UDim2.new(0, 6, 1, -34),
		ZIndex = 4,
		Parent = Visual,
	})
	UI.New("UITextSizeConstraint", { MaxTextSize = 17, Parent = NameLabel })

	-- kill progress along the bottom
	local Line = UI.New("Frame", { Size = UDim2.new(1, -16, 0, 4), Position = UDim2.new(0, 8, 1, -9), BackgroundColor3 = UI.Colors.DarkGray, ZIndex = 4, Parent = Visual }, { UI.Corner(2) })
	local LineFill = UI.New("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = UI.Colors.White, ZIndex = 4, Parent = Line }, { UI.Corner(2) })
	UI.Gradient(THEME, 0).Parent = LineFill

	-- locked: a veil and a lock in the corner (a LOCKED word in the middle covered the titles)
	local Lock = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = if Item.Category == "Titles" then 0.8 else 0.55, ZIndex = 3, Parent = Visual })
	UI.Image({ Image = UI.Images.Locked, Size = UDim2.fromOffset(20, 20), Position = UDim2.new(1, -8, 0, 7), AnchorPoint = Vector2.new(1, 0), ImageColor3 = UI.Colors.LightGray, ZIndex = 4, Parent = Lock })

	-- picked: a bright outline that stays on
	local Pick = UI.HoverStroke(Visual, THEME, 3, 10)
	local Hover = UI.HoverStroke(Visual, UI.Gradients.Common, 2, 10)
	UI.Bouncy(Root, Visual, { Grow = 0.03, HoverStroke = Hover })

	local Tile: Tile = { Item = Item, Root = Root, Visual = Visual, Stroke = Stroke, Badge = Badge, BadgeBox = BadgeBox, NameLabel = NameLabel, Preview = Preview, Lock = Lock, LineFill = LineFill, Pick = Pick }
	Root.Activated:Connect(function()
		UI.Play("Click", 0.3)
		if Selected == Item and IsUnlocked(Item) then
			-- clicking the picked item again toggles it, like the old menu's click-to-equip
			CosmSet:FireServer({ Type = Item.Category, Name = Item.Name, State = if IsEquipped(Item) then "Unequip" else "Equip" })
		end
		Selected = Item
		Render()
	end)
	return Tile
end

------------------------------------------------------------------------
-- Drawing
------------------------------------------------------------------------
local InfoPreviewObject: GuiObject? = nil
local InfoFor: Item? = nil

local function Tag(Text: string, Color: Color3, Order: number)
	local Box = UI.New("Frame", {
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 26),
		BackgroundColor3 = Color,
		LayoutOrder = Order,
		Parent = InfoTags,
	}, { UI.Corner(13), UI.Stroke(UI.Colors.Black, 2), UI.New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }) })
	UI.Text({ Text = Text, TextSize = 14, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.fromScale(0, 1), Parent = Box })
end

local function ShowInfo(Item: Item?)
	for _, Child in InfoTags:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	if InfoFor ~= Item and InfoPreviewObject then
		InfoPreviewObject:Destroy()
		InfoPreviewObject = nil
	end
	InfoFor = Item
	InfoChat.Visible = false
	if not Item then
		InfoName.Text = "Pick something"
		InfoDescription.Text = "Choose an item in Inventory to see it here."
		return
	end
	if not InfoPreviewObject then
		InfoPreviewObject = MakePreview(Item, InfoPreview, UDim2.fromScale(0.86, 0.8), true)
	end
	if InfoPreviewObject and InfoPreviewObject:IsA("ViewportFrame") then
		InfoPreviewObject.ImageColor3 = if IsUnlocked(Item) then UI.Colors.White else RGB(10, 10, 12)
	end
	InfoName.Text = if Item.Category == "Titles" and Item.Title then Item.Title.Text else Item.Name
	local On, Unlocked = IsEquipped(Item), IsUnlocked(Item)
	local Singular = { Accessories = "Accessory", Auras = "Aura", Titles = "Title" }
	Tag(Singular[Item.Category] or Item.Category, RGB(70, 70, 70), 1)
	Tag(if On then "Equipped" elseif Unlocked then "Unlocked" else "Locked", if On then RGB(80, 140, 60) elseif Unlocked then RGB(110, 104, 94) else RGB(120, 40, 40), 2)
	Tag(Requirement(Item), RGB(45, 45, 45), 3)
	local Lines = {}
	if Item.Description and Item.Description ~= "" then
		table.insert(Lines, Item.Description)
	end
	if IsVip(Item) then
		table.insert(Lines, "Comes with the VIP gamepass.")
	elseif Item.ReqType == "Special" then
		table.insert(Lines, "A special title, just for you.")
	elseif Item.Kills > 0 and not Unlocked then
		table.insert(Lines, `Unlocks at {UI.Comma(Item.Kills)} total {if Item.Kills == 1 then "kill" else "kills"}. You have {UI.Comma(TotalKills.Value)}.`)
	elseif Item.Kills <= 0 then
		table.insert(Lines, "Free for everyone.")
	end
	if Item.Category == "Accessories" then
		table.insert(Lines, "You can wear several accessories at once.")
	end
	InfoDescription.Text = table.concat(Lines, "\n\n")
	-- titles: how it looks in chat (chat can't show gradients, so it's flat)
	if Item.Category == "Titles" and Item.Title then
		InfoChat.Visible = true
		-- the title's gradient color, brightened if it's too dark to read on the black box
		local Gradient = Item.Title:FindFirstChildOfClass("UIGradient")
		local Color = if Gradient then Gradient.Color.Keypoints[1].Value else Item.Title.TextColor3
		local _, _, Brightness = Color:ToHSV()
		if Brightness < 0.55 then
			Color = Color:Lerp(UI.Colors.White, 0.45)
		end
		InfoChatText.Text = `<font color="#{Color:ToHex()}">[{Item.Title.Text}]</font> {Player.DisplayName}: Greetings!`
	end
end

local function ShowBar()
	local Item = Selected
	KillsText.Text = UI.Comma(TotalKills.Value)
	if not Item then
		UnlockText.Text = "-"
		ProgressFill.Size = UDim2.fromScale(0, 1)
		Equip.Label.Text = "EQUIP"
		Equip.Fill.Color = UI.Gradients.Grey
		return
	end
	local Unlocked, On = IsUnlocked(Item), IsEquipped(Item)
	if Unlocked then
		UnlockText.Text = "UNLOCKED"
	elseif IsVip(Item) then
		UnlockText.Text = "VIP ONLY"
	else
		UnlockText.Text = KillWord(math.max(0, Item.Kills - TotalKills.Value))
	end
	local Ratio = if Unlocked then 1 elseif Item.Kills > 0 and not IsVip(Item) then TotalKills.Value / Item.Kills else 0
	TweenService:Create(ProgressFill, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { Size = UDim2.fromScale(math.clamp(Ratio, 0, 1), 1) }):Play()
	Equip.Label.Text = if not Unlocked then "LOCKED" elseif On then "UNEQUIP" else "EQUIP"
	Equip.Fill.Color = if Unlocked and not On then DONE else UI.Gradients.Grey
end

local Built: string? = nil -- which category the grid holds

Render = function()
	if Built ~= Category then
		for _, Tile in Tiles do
			Tile.Root:Destroy()
		end
		table.clear(Tiles)
		for Index, Item in Items[Category] do
			table.insert(Tiles, MakeTile(Item, Index))
		end
		Built = Category
		if Selected and Selected.Category ~= Category then
			Selected = nil
		end
	end
	local Needle = string.lower(Search)
	local Shown = 0
	for _, Tile in Tiles do
		local Visible = Needle == "" or string.find(string.lower(Tile.Item.Name), Needle, 1, true) ~= nil
		Tile.Root.Visible = Visible
		if Visible then
			Shown += 1
		end
		PaintTile(Tile)
	end
	Grid.Visible = View == "Inventory"
	Info.Visible = View == "Information"
	Empty.Visible = View == "Inventory" and Shown == 0
	if View == "Information" then
		ShowInfo(Selected)
	end
	ShowBar()
end

-- header tabs: the categories (Auras appear once the server has some)
local CategoryNames = { "Accessories" }
if #Items.Auras > 0 then
	table.insert(CategoryNames, "Auras")
end
table.insert(CategoryNames, "Titles")
table.insert(CategoryNames, "Emotes") -- a page of this window, built by EmoteMenuClient
;(shared :: any).CosmeticsTabs = CategoryNames
local SelectCategory = UI.Tabs(Menu.Window, CategoryNames, THEME, function(Name)
	HeaderTab = Name
	CosmeticsPage.Visible = Name ~= "Emotes"
	EmotesPage.Visible = Name == "Emotes"
	if Name == "Emotes" then
		local Shown = (shared :: any).EmotesShown
		if Shown then
			Shown()
		end
		return
	end
	Category = Name
	Grid.CanvasPosition = Vector2.zero
	Render()
end, {
	Size = UDim2.new(math.min(0.18 * #CategoryNames, 0.54), 0, 0, ROW_HEIGHT),
	Position = UDim2.new(0.42, -30, 0, 14),
})

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
	Search = SearchInput.Text
	if Menu.IsOpen then
		Render()
	end
end)

------------------------------------------------------------------------
-- Keeping up with the server
------------------------------------------------------------------------
local Pending, NeedOwned = false, false
local function Soon(RefetchOwned: boolean)
	-- several changes in a row (equip + owned + respawn) draw once, and only after the owned
	-- list has come back from the server (drawing first showed new items as still locked)
	NeedOwned = NeedOwned or RefetchOwned
	if Pending then
		return
	end
	Pending = true
	task.delay(0.1, function()
		if NeedOwned then
			NeedOwned = false
			RefreshOwned()
		end
		Pending = false
		if Menu.IsOpen then
			Render()
		end
	end)
end

for _, Folder in { EquippedAccessories, EquippedAuras } do
	Folder.ChildAdded:Connect(function()
		Soon(true)
	end)
	Folder.ChildRemoved:Connect(function()
		Soon(true)
	end)
end
Player:GetAttributeChangedSignal("EquippedTitleName"):Connect(function()
	Soon(false)
end)
Player:GetAttributeChangedSignal("HasVIP"):Connect(function()
	Soon(false)
end)
TotalKills:GetPropertyChangedSignal("Value"):Connect(function()
	Soon(false)
end)

Menu.OnOpen = function()
	SelectView(View)
	SelectCategory(HeaderTab)
	Soon(true) -- something may have been bought or unlocked while it was closed
end

UI.Own("cosgui", function()
	if not Menu.IsOpen then
		HeaderTab = Category -- the Cosmetics button opens on the cosmetics, not Emotes
	end
	Menu:Toggle()
end)

-- the Emotes menu's header tabs come back here
;(shared :: any).costab = function(Name: string)
	if Items[Name] then
		Category = Name
	end
	HeaderTab = if Name == "Emotes" then "Emotes" else Category
	if Menu.IsOpen then
		SelectCategory(HeaderTab)
	else
		Menu:SetOpen(true)
	end
end

-- the Emotes page, for EmoteMenuClient
;(shared :: any).EmotesWindow = {
	Body = EmotesPage,
	Open = function()
		local ShowTab = (shared :: any).costab
		ShowTab("Emotes")
	end,
	IsOpen = function(): boolean
		return Menu.IsOpen and EmotesPage.Visible
	end,
}
