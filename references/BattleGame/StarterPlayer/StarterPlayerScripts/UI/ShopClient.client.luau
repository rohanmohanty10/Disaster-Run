-- StarterPlayer > StarterPlayerScripts > ShopClient   (LocalScript, client)
--
-- The Store menu, styled after Anime Expeditions' Store (see ReplicatedStorage.Modules.ExpeditionUI);
-- the Bundles and Gamepasses cards follow Anime Origins' store:
--   Bundles    = Robux developer products (Gold packs, spins)
--   Gamepasses = your gamepasses, with Buy / Gift / Owned
--   Items      = the supply crate (a random item; View Odds lists them all), emote spins, codes
-- Everything it sells comes from ReplicatedStorage.Modules.ShopConfig. Opened by the Store button
-- in your top bar (StarterPlayerScripts > Icons calls shared.shopgui).

local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local ShopConfig = require(ReplicatedStorage.Modules:WaitForChild("ShopConfig"))
local ShopRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Shop")
local Purchase: RemoteFunction = ShopRemotes:WaitForChild("Purchase")
local Notify: RemoteEvent = ShopRemotes:WaitForChild("Notify")
-- Gamepass ownership and purchases go through the server, which also knows about gifted passes
local GamepassRemotes = ReplicatedStorage.Remotes:WaitForChild("Gamepasses")
local RequestGamepass: RemoteEvent = GamepassRemotes:WaitForChild("RequestGamepass")
local GamepassPurchased: RemoteEvent = GamepassRemotes:WaitForChild("GamepassPurchased")
local GetGamepasses: RemoteFunction = ReplicatedStorage.Remotes:WaitForChild("Comunicator"):WaitForChild("GetGamepasses")
local ItemModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Items")

-- neutral stone palette, the same as the Quests menu (the cards keep their rarity colors)
local THEME = ColorSequence.new(Color3.fromRGB(232, 226, 214), Color3.fromRGB(150, 142, 130))

local Menu = UI.Window({ Name = "StoreUI", Title = "Store", Gradient = THEME, Icon = UI.Images.StoreIcon })
local Scroll = UI.Scroller(Menu.Body, { Size = UDim2.fromScale(1, 1), Color = Color3.fromRGB(176, 170, 160), Padding = 12 })

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
local function Gold(): number
	return Player:GetAttribute(ShopConfig.Currency) or 0
end

-- Robux prices come from Roblox; cached so switching tabs doesn't ask again
local PriceCache: { [string]: number | false } = {}
local function RobuxPrice(Id: number, InfoType: Enum.InfoType): number?
	local Key = `{InfoType.Name}{Id}`
	if PriceCache[Key] == nil then
		local Ok, Info = pcall(MarketplaceService.GetProductInfo, MarketplaceService, Id, InfoType)
		PriceCache[Key] = if Ok and Info and Info.PriceInRobux then Info.PriceInRobux else false
	end
	return PriceCache[Key] or nil
end

-- A card: dark panel with a rarity-tinted gradient, a hover glow and a gentle bounce
local function Card(Parent: Instance, Height: number, Gradient: ColorSequence, LayoutOrder: number, Width: UDim?)
	local Root = UI.New("Frame", {
		Size = UDim2.new(Width or UDim.new(1, 0), UDim.new(0, Height)),
		BackgroundTransparency = 1,
		LayoutOrder = LayoutOrder,
		Parent = Parent,
	})
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(10), UI.Stroke(UI.Colors.DarkGray, 2) })
	-- the rarity color washes in from the top-left and fades out
	local Tint = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, BackgroundTransparency = 0, Parent = Visual }, { UI.Corner(10) })
	UI.New("UIGradient", {
		Color = Gradient,
		Rotation = 20,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.55, 0.85), NumberSequenceKeypoint.new(1, 1) }),
		Parent = Tint,
	})
	UI.Image({ Image = UI.Images.Checkered, ImageTransparency = 0.94, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(12, 12), Size = UDim2.fromScale(1, 1), Parent = Visual })
	local Hover = UI.HoverStroke(Visual, Gradient, 2.5, 10)
	UI.Bouncy(Root, Visual, { Grow = 0.012, HoverStroke = Hover, Silent = true })
	return Visual
end

-- big art on the left of a card: the image or 3D model on a dark box
local function Showcase(Parent: Instance, Art: any, Size: number, _Gradient: ColorSequence?)
	local Box = UI.New("Frame", { Size = UDim2.fromOffset(Size, Size), Position = UDim2.fromOffset(8, 8), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = 0.35, Parent = Parent }, { UI.Corner(8) })
	if typeof(Art) == "Instance" then
		UI.ModelView(Box, Art, UDim2.fromScale(0.95, 0.95), true)
	elseif Art then
		UI.Image({ Image = Art, Size = UDim2.fromScale(0.82, 0.82), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 2, Parent = Box })
	end
	return Box
end

local function Row(Parent: Instance, Props: { [string]: any }): Frame
	local Frame = UI.New("Frame", {
		Size = Props.Size,
		Position = Props.Position,
		BackgroundTransparency = 1,
		Parent = Parent,
	}, {
		UI.New("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, Props.Padding or 6),
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalAlignment = Props.Align or Enum.HorizontalAlignment.Left,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
	return Frame
end

local Busy = false
local function BuyWithGold(Kind: string, Id: string?, Amount: number, Name: string)
	if Busy then
		return
	end
	Busy = true
	local Called, Ok, Detail = pcall(Purchase.InvokeServer, Purchase, Kind, Id, Amount)
	Busy = false
	if not Called then
		UI.Toast("The store didn't answer. Try again.", false)
	elseif Ok then
		UI.Toast(if Kind == "Spin" then `Purchased {Amount} Emote Spin{Amount > 1 and "s" or ""}.` else `Purchased {Name}. A seagull is delivering it.`)
	else
		UI.Toast(if typeof(Detail) == "string" then Detail else "Couldn't buy that.", false)
	end
end

------------------------------------------------------------------------
-- Anime Origins-style cards (Bundles and Gamepasses): a black-edged panel with a coloured inner
-- edge, a dark inside with a halftone pattern and a light streak, the art big on the right, the
-- text top-left, and the green Robux button (plus a pink gift button) along the bottom.
------------------------------------------------------------------------
local HALFTONE = "rbxassetid://120634198686862" -- TEMP (Anime Origins)
local STREAK = "rbxassetid://109076442581026" -- TEMP (Anime Origins)
local RED_GOLD = ColorSequence.new(Color3.fromRGB(255, 51, 51), Color3.fromRGB(255, 201, 76))
local PINK = ColorSequence.new(Color3.fromRGB(239, 20, 255), Color3.fromRGB(255, 133, 235))
local BONUS = ColorSequence.new(Color3.fromRGB(25, 167, 255), Color3.fromRGB(99, 229, 255))
local TAG = ColorSequence.new(Color3.fromRGB(255, 170, 240), Color3.fromRGB(205, 120, 255))

local function PackCard(Parent: Instance, Order: number, Edge: ColorSequence, Art: string?): Frame
	local Root = UI.New("Frame", { BackgroundTransparency = 1, LayoutOrder = Order, Parent = Parent })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(8, 8, 8),
		Parent = Root,
	}, { UI.Corner(12), UI.Stroke(UI.Colors.Black, 4) })
	local Inside = UI.New("Frame", { Size = UDim2.new(1, -6, 1, -6), Position = UDim2.fromOffset(3, 3), BackgroundTransparency = 1, ClipsDescendants = true, Parent = Visual }, { UI.Corner(10) })
	UI.Stroke(UI.Colors.White, 2, Edge).Parent = Inside
	local Dots = UI.Image({ Image = HALFTONE, ImageTransparency = 0.8, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), Parent = Inside })
	UI.Corner(10).Parent = Dots
	UI.Gradient(Edge, -90).Parent = Dots
	UI.Image({ Image = STREAK, ImageTransparency = 0.5, ScaleType = Enum.ScaleType.Crop, Size = UDim2.fromScale(1, 1), Parent = Inside })
	if Art then
		UI.Image({ Image = Art, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.6, 0.6), Position = UDim2.new(1, -8, 0.44, 0), AnchorPoint = Vector2.new(1, 0.5), Parent = Inside })
	end
	local Hover = UI.HoverStroke(Visual, Edge, 2.5, 12)
	UI.Bouncy(Root, Visual, { Grow = 0.012, HoverStroke = Hover, Silent = true })
	return Inside
end

-- the bottom row: a green Robux button, and a pink gift button when it can be gifted
local function PackButtons(Inside: Frame, Props: { [string]: any })
	local Bar = Row(Inside, { Size = UDim2.new(1, -24, 0, 48), Position = UDim2.new(0, 12, 1, -12), Padding = 8, Align = Enum.HorizontalAlignment.Center })
	Bar.AnchorPoint = Vector2.new(0, 1)
	local Buy = UI.Button({
		Parent = Bar,
		Size = UDim2.new(if Props.OnGift then 0.7 else 0.8, 0, 1, 0),
		Gradient = Props.Gradient or UI.Gradients.Green,
		Icon = Props.Icon,
		Text = Props.Text,
		TextSize = 22,
		LayoutOrder = 1,
		OnClick = Props.OnBuy,
	})
	if Props.OnGift then
		UI.IconButton(Bar, UI.Images.Gift, 48, PINK, nil, Props.OnGift).Root.LayoutOrder = 2
	end
	return Buy
end

-- a grid of cards under a section header
local function CardGrid(Columns: number, Height: number, Order: number): Frame
	return UI.New("Frame", { Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = Order, Parent = Scroll }, {
		UI.New("UIGridLayout", { CellSize = UDim2.new(1 / Columns, -12 * (Columns - 1) / Columns, 0, Height), CellPadding = UDim2.fromOffset(12, 12), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
end

------------------------------------------------------------------------
-- Bundles
------------------------------------------------------------------------
local function BundleCard(Parent: Instance, Product, Order: number)
	local Inside = PackCard(Parent, Order, RED_GOLD, Product.Art)
	UI.Text({ Text = Product.Name, TextSize = 30, Weight = "ExtraBold", TextScaled = true, Gradient = RED_GOLD, Size = UDim2.new(1, -28, 0, 36), Position = UDim2.fromOffset(14, 10), Parent = Inside })
	local Reward = Product.Rewards and Product.Rewards[1]
	if Reward then
		UI.Text({ Text = `Grants {UI.Comma(Reward.Count)} {Reward.Name}.`, TextSize = 19, Size = UDim2.new(1, -28, 0, 24), Position = UDim2.fromOffset(14, 48), Parent = Inside })
		if Reward.Name == "Gold" then
			UI.Text({ Text = `+ {UI.Comma(Product.Bonus or 0)} Bonus`, TextSize = 19, Gradient = BONUS, Size = UDim2.new(1, -28, 0, 24), Position = UDim2.fromOffset(14, 74), Parent = Inside })
		end
	end
	if Product.Tag then
		UI.Text({ Text = Product.Tag, TextSize = 24, Weight = "ExtraBold", Gradient = TAG, TextXAlignment = Enum.TextXAlignment.Right, Size = UDim2.new(1, -28, 0, 30), Position = UDim2.new(1, -14, 1, -66), AnchorPoint = Vector2.new(1, 1), Parent = Inside })
	end
	local Price = RobuxPrice(Product.ProductId, Enum.InfoType.Product)
	PackButtons(Inside, {
		Icon = UI.Images.Robux,
		Text = if Price then UI.Comma(Price) else "Buy",
		OnBuy = function()
			MarketplaceService:PromptProductPurchase(Player, Product.ProductId)
		end,
	})
end

local function ShowBundles()
	UI.SectionTitle(Scroll, "Bundles", THEME, 1)
	local Order = 2
	for _, Section in ShopConfig.Bundles.Sections do
		UI.SubHeader(Scroll, Section.Title, Order)
		local Grid = CardGrid(3, 250, Order + 1)
		Order += 2
		for Index, Product in Section.Products do
			task.spawn(BundleCard, Grid, Product, Index) -- each looks up its price on its own
		end
	end
end

------------------------------------------------------------------------
-- Gifting (replaces the old Gifting menu): pick who gets the pass, then send it. The gift is
-- your existing developer product (the pass's GiftProductId); the server's RequestGiftingProduct
-- takes the pass's Gift name, exactly as the old menu sent it.
------------------------------------------------------------------------
local RequestGift: RemoteEvent = ReplicatedStorage.Remotes:WaitForChild("DevProducts"):WaitForChild("RequestGiftingProduct")

local GiftVeil = UI.New("TextButton", {
	Name = "GiftVeil",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = UI.Colors.Black,
	BackgroundTransparency = 0.35,
	Text = "",
	AutoButtonColor = false,
	ZIndex = 50,
	Visible = false,
	Parent = Menu.Window,
}, { UI.Corner(12) })
local GiftPanel = UI.New("Frame", {
	Size = UDim2.fromOffset(520, 520),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(14, 14, 14),
	ZIndex = 51,
	Parent = GiftVeil,
}, { UI.Corner(12), UI.Stroke(UI.Colors.Black, 4) })
local GiftEdge = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 51, Parent = GiftPanel }, { UI.Corner(12) })
UI.Stroke(UI.Colors.White, 2, THEME).Parent = GiftEdge
local GiftTitle = UI.Text({ Text = "", TextSize = 26, Weight = "ExtraBold", Gradient = THEME, Size = UDim2.new(1, -80, 0, 32), Position = UDim2.fromOffset(18, 14), ZIndex = 52, Parent = GiftPanel })
local GiftNote = UI.Text({ Text = "", TextSize = 15, NoStroke = true, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(1, -36, 0, 20), Position = UDim2.fromOffset(18, 48), ZIndex = 52, Parent = GiftPanel })

local GiftSearchBox = UI.New("Frame", {
	Size = UDim2.new(1, -36, 0, 40),
	Position = UDim2.fromOffset(18, 76),
	BackgroundColor3 = UI.Colors.DarkerGray,
	ZIndex = 52,
	Parent = GiftPanel,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Image({ Image = UI.Images.Search, Size = UDim2.fromOffset(20, 20), Position = UDim2.new(0, 12, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ImageColor3 = UI.Colors.LightGray, ZIndex = 53, Parent = GiftSearchBox })
local GiftSearch = UI.New("TextBox", {
	Size = UDim2.new(1, -50, 1, 0),
	Position = UDim2.fromOffset(42, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search a username...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Medium"),
	TextSize = 17,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	ZIndex = 53,
	Parent = GiftSearchBox,
})
local GiftList = UI.Scroller(GiftPanel, { Size = UDim2.new(1, -36, 1, -210), Position = UDim2.fromOffset(18, 126), Padding = 6, Color = Color3.fromRGB(176, 170, 160) })
GiftList.ZIndex = 52

local GiftPass = nil -- the pass being gifted
local GiftTo: number? = nil -- the chosen user id
local GiftRows: { [number]: { Root: TextButton, Name: string, Display: string, Select: (boolean) -> () } } = {}

local GiftSend = UI.Button({
	Parent = GiftPanel,
	Size = UDim2.new(1, -36, 0, 50),
	Position = UDim2.new(0, 18, 1, -18),
	AnchorPoint = Vector2.new(0, 1),
	Icon = UI.Images.Robux,
	Text = "Gift",
	TextSize = 22,
	OnClick = function()
		if not (GiftPass and GiftTo) then
			UI.Toast("Pick who to gift it to first.", false)
			return
		end
		RequestGift:FireServer(GiftTo, GiftPass.Gift)
		GiftVeil.Visible = false
	end,
})
GiftSend.Root.ZIndex = 52

local function PickRecipient(UserId: number)
	GiftTo = UserId
	for Id, Row in GiftRows do
		Row.Select(Id == UserId)
	end
	GiftSend.Fill.Color = UI.Gradients.Green
end

local function GiftRow(UserId: number, Name: string, Display: string)
	if GiftRows[UserId] or UserId == Player.UserId then
		return
	end
	local Root = UI.New("TextButton", { Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = Color3.fromRGB(26, 26, 26), Text = "", AutoButtonColor = false, ZIndex = 53, Parent = GiftList }, { UI.Corner(8) })
	local Stroke = UI.Stroke(UI.Colors.DarkGray, 2)
	Stroke.Parent = Root
	local Avatar = UI.Image({ Image = `rbxthumb://type=AvatarHeadShot&id={UserId}&w=150&h=150`, Size = UDim2.fromOffset(42, 42), Position = UDim2.new(0, 6, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ScaleType = Enum.ScaleType.Crop, ZIndex = 54, Parent = Root })
	UI.Corner(21).Parent = Avatar
	UI.Text({ Text = Display, TextSize = 18, Size = UDim2.new(1, -64, 0, 22), Position = UDim2.fromOffset(58, 6), ZIndex = 54, Parent = Root })
	UI.Text({ Text = "@" .. Name, TextSize = 14, NoStroke = true, TextColor3 = UI.Colors.Gray, Size = UDim2.new(1, -64, 0, 18), Position = UDim2.fromOffset(58, 30), ZIndex = 54, Parent = Root })
	local function Select(On: boolean)
		Stroke.Color = if On then Color3.fromRGB(140, 220, 110) else UI.Colors.DarkGray
		Root.BackgroundColor3 = if On then Color3.fromRGB(34, 44, 30) else Color3.fromRGB(26, 26, 26)
	end
	Root.Activated:Connect(function()
		UI.Play("Click", 0.3)
		PickRecipient(UserId)
	end)
	GiftRows[UserId] = { Root = Root, Name = Name, Display = Display, Select = Select }
end

-- the server's players, then your friends
local function FillGiftList()
	for _, Other in Players:GetPlayers() do
		GiftRow(Other.UserId, Other.Name, Other.DisplayName)
	end
	pcall(function()
		local Pages = Players:GetFriendsAsync(Player.UserId)
		while true do
			for _, Friend in Pages:GetCurrentPage() do
				GiftRow(Friend.Id, Friend.Username, Friend.DisplayName)
			end
			if Pages.IsFinished then
				break
			end
			Pages:AdvanceToNextPageAsync()
		end
	end)
end
Players.PlayerAdded:Connect(function(Other)
	GiftRow(Other.UserId, Other.Name, Other.DisplayName)
end)

-- a username that isn't in the list: look it up
local SearchToken = 0
GiftSearch:GetPropertyChangedSignal("Text"):Connect(function()
	local Needle = string.lower(GiftSearch.Text)
	for _, Row in GiftRows do
		Row.Root.Visible = Needle == "" or string.find(string.lower(Row.Name), Needle, 1, true) ~= nil or string.find(string.lower(Row.Display), Needle, 1, true) ~= nil
	end
	SearchToken += 1
	local Token = SearchToken
	if #Needle < 3 then
		return
	end
	task.delay(0.5, function()
		if Token ~= SearchToken then
			return -- still typing
		end
		local Ok, UserId = pcall(Players.GetUserIdFromNameAsync, Players, GiftSearch.Text)
		if Ok and UserId and not GiftRows[UserId] then
			local Display = GiftSearch.Text
			pcall(function()
				local Info = game:GetService("UserService"):GetUserInfosByUserIdsAsync({ UserId })[1]
				if Info then
					Display = Info.DisplayName
				end
			end)
			GiftRow(UserId, GiftSearch.Text, Display)
		end
	end)
end)

-- clicking outside the panel cancels (plain frames don't stop clicks, so check where it landed)
GiftVeil.Activated:Connect(function()
	local Point = game:GetService("UserInputService"):GetMouseLocation()
	local Min, Size = GiftPanel.AbsolutePosition, GiftPanel.AbsoluteSize
	local Inside = Point.X >= Min.X and Point.Y >= Min.Y and Point.X <= Min.X + Size.X and Point.Y <= Min.Y + Size.Y
	if not Inside then
		GiftVeil.Visible = false
	end
end)
UI.IconButton(GiftPanel, UI.Images.Close, 40, UI.Gradients.Red, UDim2.new(1, -54, 0, 14), function()
	GiftVeil.Visible = false
end).Root.ZIndex = 53

local GiftListFilled = false
local function OpenGift(Pass)
	GiftPass = Pass
	GiftTo = nil
	for _, Row in GiftRows do
		Row.Select(false)
	end
	GiftTitle.Text = `Gift {Pass.Name}`
	GiftNote.Text = if Pass.PassId then "Pick who gets it. They'll get the pass for free." else "Pick who gets it. A seagull brings it to them, now or next time they play."
	GiftSend.Fill.Color = UI.Gradients.Grey
	local Price = Pass.GiftProductId and RobuxPrice(Pass.GiftProductId, Enum.InfoType.Product)
	GiftSend.Label.Text = if Price then `Gift  {UI.Comma(Price)}` else "Gift"
	GiftSearch.Text = ""
	GiftVeil.Visible = true
	if not GiftListFilled then
		GiftListFilled = true
		task.spawn(FillGiftList)
	end
end

------------------------------------------------------------------------
-- Gamepasses
------------------------------------------------------------------------
local function GamepassCard(Parent: Instance, Pass, Order: number)
	local Edge = UI.Gradients[Pass.Rarity] or UI.Gradients.Rare
	local Inside = PackCard(Parent, Order, Edge, Pass.Icon)
	UI.Text({ Text = Pass.Name, TextSize = 30, Weight = "ExtraBold", TextScaled = true, Gradient = Edge, Size = UDim2.new(0.62, -14, 0, 36), Position = UDim2.fromOffset(14, 10), Parent = Inside })
	UI.Text({ Text = Pass.Description, TextSize = 16, TextColor3 = UI.Colors.LightGray, NoStroke = true, TextWrapped = true, Size = UDim2.new(0.58, -14, 0, 40), Position = UDim2.fromOffset(14, 48), TextYAlignment = Enum.TextYAlignment.Top, Parent = Inside })
	for Index, Perk in Pass.Perks or {} do
		UI.Text({ Text = "• " .. Perk, TextSize = 16, Size = UDim2.new(0.58, -14, 0, 20), Position = UDim2.fromOffset(14, 74 + Index * 21), Parent = Inside })
	end

	-- Ask the server (profile), not Roblox: UserOwnsGamePassAsync doesn't know about gifted passes,
	-- so a gifted player would see "Buy" and could pay for a pass they already have.
	local Owned = false
	pcall(function()
		Owned = GetGamepasses:InvokeServer(Pass.Id) == true
	end)
	local Price = RobuxPrice(Pass.PassId, Enum.InfoType.GamePass)
	return PackButtons(Inside, {
		Gradient = if Owned then UI.Gradients.Grey else UI.Gradients.Green,
		Icon = if Owned then UI.Images.Check else UI.Images.Robux,
		Text = if Owned then "Owned" elseif Price then UI.Comma(Price) else "Buy",
		OnBuy = function()
			if not Owned then
				-- the server checks the profile and Roblox ownership before it prompts
				RequestGamepass:FireServer(Pass.Id)
			end
		end,
		-- gift it to someone, right here in the Store
		OnGift = if Pass.Gift then function()
			OpenGift(Pass)
		end else nil,
	})
end

local function ShowGamepasses()
	UI.SectionTitle(Scroll, "Gamepasses", THEME, 1)
	local Grid = CardGrid(2, 250, 2)
	for Index, Pass in ShopConfig.Gamepasses do
		task.spawn(GamepassCard, Grid, Pass, Index) -- each looks up its price/ownership on its own
	end
end

------------------------------------------------------------------------
-- Items (Gold): only the Supply Crate (a random item) and emote spins, in the menu's neutral
-- colours, then Codes. The items themselves are listed in the crate's odds panel.
------------------------------------------------------------------------
local GoldLabels: { TextLabel } = {}

-- the Gold buy button + x1/x3, bottom-right of a card
local function GoldBuyControls(Visual: Frame, Price: number, OnBuy: (number) -> ())
	local Amount = ShopConfig.AmountOptions[1]
	local Controls = Row(Visual, { Size = UDim2.fromOffset(330, 46), Position = UDim2.new(1, -12, 1, -12), Padding = 8, Align = Enum.HorizontalAlignment.Right })
	Controls.AnchorPoint = Vector2.new(1, 1)
	local Buy
	local AmountButtons = {}
	local function Refresh()
		for Option, Button in AmountButtons do
			Button.Fill.Color = if Option == Amount then THEME else UI.Gradients.Grey
		end
		Buy.Label.Text = UI.Comma(Price * Amount)
		-- red price when you can't afford it, like their store
		local Gradient = Buy.Label:FindFirstChildOfClass("UIGradient")
		if Gradient then
			Gradient.Color = if Gold() >= Price * Amount then UI.Gradients.Gold else UI.Gradients.Red
		end
	end
	for Index, Option in ShopConfig.AmountOptions do
		AmountButtons[Option] = UI.Button({
			Parent = Controls,
			Size = UDim2.fromOffset(52, 46),
			Text = `x{Option}`,
			TextSize = 18,
			LayoutOrder = Index,
			Grow = 0.1,
			OnClick = function()
				Amount = Option
				Refresh()
			end,
		})
	end
	Buy = UI.Button({
		Parent = Controls,
		Size = UDim2.fromOffset(170, 46),
		Gradient = UI.Gradients.Green,
		Icon = UI.Images.Coins,
		Text = "",
		TextSize = 22,
		TextGradient = UI.Gradients.Gold,
		LayoutOrder = 10,
		OnClick = function()
			OnBuy(Amount)
		end,
	})
	table.insert(GoldLabels, Buy.Label)
	Refresh()
	Player:GetAttributeChangedSignal(ShopConfig.Currency):Connect(Refresh)
end

-- Robux buy + gift, top-right of an item card (the item's developer products in ShopConfig)
local function RobuxControls(Visual: Frame, Thing)
	if not Thing.ProductId then
		return
	end
	local Controls = Row(Visual, { Size = UDim2.fromOffset(260, 40), Position = UDim2.new(1, -12, 0, 12), Padding = 8, Align = Enum.HorizontalAlignment.Right })
	Controls.AnchorPoint = Vector2.new(1, 0)
	local Buy = UI.Button({
		Parent = Controls,
		Size = UDim2.fromOffset(150, 40),
		Gradient = UI.Gradients.Green,
		Icon = UI.Images.Robux,
		Text = "Buy",
		TextSize = 18,
		LayoutOrder = 1,
		OnClick = function()
			MarketplaceService:PromptProductPurchase(Player, Thing.ProductId)
		end,
	})
	task.spawn(function()
		local Price = RobuxPrice(Thing.ProductId, Enum.InfoType.Product)
		if Price then
			Buy.Label.Text = `Buy  {UI.Comma(Price)}`
		end
	end)
	if Thing.Gift then
		local GiftButton = UI.IconButton(Controls, UI.Images.Gift, 40, THEME, nil, function()
			OpenGift(Thing)
		end)
		GiftButton.Root.LayoutOrder = 2
	end
end

------------------------------------------------------------------------
-- Odds: everything the crate can give, with its rarity and chance (opened from the crate card)
------------------------------------------------------------------------
local OddsVeil = UI.New("TextButton", {
	Name = "OddsVeil",
	Size = UDim2.fromScale(1, 1),
	BackgroundColor3 = UI.Colors.Black,
	BackgroundTransparency = 0.35,
	Text = "",
	AutoButtonColor = false,
	ZIndex = 50,
	Visible = false,
	Parent = Menu.Window,
}, { UI.Corner(12) })
local OddsPanel = UI.New("Frame", {
	Size = UDim2.fromOffset(560, 500),
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	BackgroundColor3 = Color3.fromRGB(14, 14, 14),
	ZIndex = 51,
	Parent = OddsVeil,
}, { UI.Corner(12), UI.Stroke(UI.Colors.Black, 4) })
local OddsEdge = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 51, Parent = OddsPanel }, { UI.Corner(12) })
UI.Stroke(UI.Colors.White, 2, THEME).Parent = OddsEdge
UI.Text({ Text = "Crate Odds", TextSize = 26, Weight = "ExtraBold", Gradient = THEME, Size = UDim2.new(1, -80, 0, 32), Position = UDim2.fromOffset(18, 14), ZIndex = 52, Parent = OddsPanel })
UI.Text({ Text = "Every crate gives one of these, picked at random.", TextSize = 15, NoStroke = true, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(1, -36, 0, 20), Position = UDim2.fromOffset(18, 48), ZIndex = 52, Parent = OddsPanel })
local OddsList = UI.Scroller(OddsPanel, { Size = UDim2.new(1, -36, 1, -96), Position = UDim2.fromOffset(18, 80), Padding = 6, Color = Color3.fromRGB(176, 170, 160) })
OddsList.ZIndex = 52
UI.IconButton(OddsPanel, UI.Images.Close, 40, UI.Gradients.Red, UDim2.new(1, -54, 0, 14), function()
	OddsVeil.Visible = false
end).Root.ZIndex = 53
-- clicking outside the panel closes it (plain frames don't stop clicks, so check where it landed)
OddsVeil.Activated:Connect(function()
	local Point = game:GetService("UserInputService"):GetMouseLocation()
	local Min, Size = OddsPanel.AbsolutePosition, OddsPanel.AbsoluteSize
	if not (Point.X >= Min.X and Point.Y >= Min.Y and Point.X <= Min.X + Size.X and Point.Y <= Min.Y + Size.Y) then
		OddsVeil.Visible = false
	end
end)

local function OpenOdds()
	for _, Child in OddsList:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	for Index, Entry in ShopConfig.CrateChances() do
		local Item = Entry.Item
		local Row = UI.New("Frame", { Size = UDim2.new(1, 0, 0, 70), BackgroundColor3 = Color3.fromRGB(26, 26, 26), LayoutOrder = Index, ZIndex = 53, Parent = OddsList }, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
		local Box = UI.New("Frame", { Size = UDim2.fromOffset(58, 58), Position = UDim2.fromOffset(6, 6), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = 0.35, ZIndex = 54, Parent = Row }, { UI.Corner(6) })
		local Model = Item.Model and ItemModels:FindFirstChild(Item.Model)
		if Model then
			UI.ModelView(Box, Model, UDim2.fromScale(0.95, 0.95), true)
		elseif Item.Image then
			UI.Image({ Image = Item.Image, Size = UDim2.fromScale(0.85, 0.85), Position = UDim2.fromScale(0.5, 0.5), AnchorPoint = Vector2.new(0.5, 0.5), ZIndex = 55, Parent = Box })
		end
		UI.Text({ Text = Item.Name, TextSize = 20, Size = UDim2.new(1, -190, 0, 24), Position = UDim2.fromOffset(76, 10), ZIndex = 54, Parent = Row })
		-- the rarity is the one bit of colour left
		UI.Text({ Text = string.upper(Item.Rarity), TextSize = 14, Gradient = UI.Gradients[Item.Rarity] or THEME, Size = UDim2.new(1, -190, 0, 18), Position = UDim2.fromOffset(76, 38), ZIndex = 54, Parent = Row })
		UI.Text({ Text = string.format("%d%%", math.floor(Entry.Chance * 100 + 0.5)), TextSize = 26, Weight = "ExtraBold", Gradient = THEME, TextXAlignment = Enum.TextXAlignment.Right, Size = UDim2.fromOffset(100, 30), Position = UDim2.new(1, -14, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ZIndex = 54, Parent = Row })
	end
	OddsList.CanvasPosition = Vector2.zero
	OddsVeil.Visible = true
end

local function CrateCard(Order: number)
	local Crate = ShopConfig.Crate
	local Visual = Card(Scroll, 176, THEME, Order)
	Showcase(Visual, Crate.Model and ItemModels:FindFirstChild(Crate.Model) or Crate.Image, 160)
	UI.Text({ Text = Crate.Name, TextSize = 26, Size = UDim2.new(1, -420, 0, 30), Position = UDim2.fromOffset(184, 10), Gradient = THEME, Parent = Visual })
	UI.Text({ Text = Crate.Description, TextSize = 15, TextColor3 = UI.Colors.LightGray, NoStroke = true, Size = UDim2.new(1, -420, 0, 20), Position = UDim2.fromOffset(184, 42), Parent = Visual })
	UI.Button({ Parent = Visual, Size = UDim2.fromOffset(150, 40), Position = UDim2.fromOffset(184, 76), Text = "View Odds", TextSize = 18, OnClick = OpenOdds })
	GoldBuyControls(Visual, Crate.Price, function(Amount)
		BuyWithGold("Crate", Crate.Id, Amount, "Your crate")
	end)
	RobuxControls(Visual, Crate)
end

local function SpinCard(Order: number)
	local Spin = ShopConfig.EmoteSpin
	local Visual = Card(Scroll, 150, THEME, Order)
	Showcase(Visual, Spin.Image, 134)
	UI.Text({ Text = Spin.Name, TextSize = 26, Size = UDim2.new(1, -420, 0, 30), Position = UDim2.fromOffset(160, 10), Gradient = THEME, Parent = Visual })
	UI.Text({ Text = Spin.Description, TextSize = 15, TextColor3 = UI.Colors.LightGray, NoStroke = true, Size = UDim2.new(1, -420, 0, 20), Position = UDim2.fromOffset(160, 42), Parent = Visual })
	local Owned = UI.Pill(Visual, "", { Position = UDim2.fromOffset(160, 72), Icon = UI.Images.Dice })
	local function RefreshSpins()
		local Label = Owned:FindFirstChildWhichIsA("TextLabel")
		if Label then
			Label.Text = `You have {Player:GetAttribute("EmoteSpins") or 0}`
		end
	end
	RefreshSpins()
	Player:GetAttributeChangedSignal("EmoteSpins"):Connect(RefreshSpins)
	GoldBuyControls(Visual, Spin.Price, function(Amount)
		BuyWithGold("Spin", Spin.Id, Amount, Spin.Name)
	end)
end

-- Codes (ServerScriptService.Systems.CodeService)
local RedeemCode: RemoteFunction = ShopRemotes:WaitForChild("RedeemCode")
local Redeeming = false
local function CodesCard(Order: number)
	local Visual = Card(Scroll, 126, THEME, Order)
	UI.Text({ Text = "Redeem codes from updates and events!", TextSize = 20, Gradient = THEME, Size = UDim2.new(1, -32, 0, 26), Position = UDim2.fromOffset(16, 12), Parent = Visual })
	local Box = UI.New("Frame", {
		Size = UDim2.new(1, -212, 0, 52),
		Position = UDim2.fromOffset(16, 54),
		BackgroundColor3 = UI.Colors.DarkerGray,
		Parent = Visual,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
	local Input = UI.New("TextBox", {
		Size = UDim2.new(1, -24, 1, 0),
		Position = UDim2.fromOffset(12, 0),
		BackgroundTransparency = 1,
		PlaceholderText = "Enter code...",
		PlaceholderColor3 = UI.Colors.Gray,
		Text = "",
		TextColor3 = UI.Colors.White,
		FontFace = UI.Font("Bold"),
		TextSize = 20,
		TextXAlignment = Enum.TextXAlignment.Left,
		ClearTextOnFocus = false,
		Parent = Box,
	})
	local function Submit()
		local Code = (Input.Text:gsub("%s", ""))
		if Code == "" then
			UI.Toast("Type a code first.", false)
			return
		end
		if Redeeming then
			return
		end
		Redeeming = true
		local Called, Ok, Message = pcall(RedeemCode.InvokeServer, RedeemCode, Code)
		Redeeming = false
		if not Called then
			UI.Toast("Codes didn't answer. Try again.", false)
		else
			UI.Toast(if typeof(Message) == "string" then Message elseif Ok then "Redeemed!" else "Couldn't redeem that code.", Ok == true)
			if Ok then
				Input.Text = ""
			end
		end
	end
	Input.FocusLost:Connect(function(Enter)
		if Enter then
			Submit()
		end
	end)
	UI.Button({
		Parent = Visual,
		Size = UDim2.fromOffset(170, 52),
		Position = UDim2.new(1, -16, 0, 54),
		AnchorPoint = Vector2.new(1, 0),
		Gradient = UI.Gradients.Green,
		Text = "Redeem",
		TextSize = 22,
		OnClick = Submit,
	})
end

local function ShowItems()
	local Title = UI.SectionTitle(Scroll, "Items", THEME, 1)
	local _, GoldText = UI.Pill(Title, "", { Position = UDim2.new(1, 0, 0, 2), AnchorPoint = Vector2.new(1, 0), Icon = UI.Images.Coins })
	local function RefreshGold()
		GoldText.Text = `{UI.Comma(Gold())} Gold`
	end
	RefreshGold()
	Player:GetAttributeChangedSignal(ShopConfig.Currency):Connect(RefreshGold)

	UI.SubHeader(Scroll, "Supply Drops", 2)
	CrateCard(3)
	UI.SubHeader(Scroll, "Emotes", 4)
	SpinCard(5)
	UI.SubHeader(Scroll, "Codes", 6)
	CodesCard(7)
end

------------------------------------------------------------------------
-- Tabs
------------------------------------------------------------------------
local Pages = { Bundles = ShowBundles, Gamepasses = ShowGamepasses, Items = ShowItems }
local FIRST_TAB = "Items" -- the Store button always opens on the first tab
local Current = FIRST_TAB
local function Show(Name: string)
	Current = Name
	for _, Child in Scroll:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	table.clear(GoldLabels)
	Scroll.CanvasPosition = Vector2.zero
	Pages[Name]()
end
local SelectTab = UI.Tabs(Menu.Window, { "Items", "Bundles", "Gamepasses" }, THEME, Show, {
	Size = UDim2.new(0.56, 0, 0, 42),
	Position = UDim2.new(0.42, -30, 0, 14),
})

Menu.OnOpen = function()
	SelectTab(Current)
end

-- opened by the Store button in Icons
shared.shopgui = function()
	if not Menu.IsOpen then
		Current = FIRST_TAB
	end
	Menu:Toggle()
end
shared.shoptab = function(Name: string) -- e.g. shared.shoptab("Gamepasses") from somewhere else
	Menu:SetOpen(true)
	SelectTab(Name)
end

-- the server granted a pass (bought, synced or gifted): refresh so it says Owned.
-- Fired after the grant, so the server-side ownership check above sees it.
GamepassPurchased.OnClientEvent:Connect(function()
	if Menu.IsOpen and Current == "Gamepasses" then
		Show("Gamepasses")
	end
end)

Notify.OnClientEvent:Connect(function(Kind: string, Detail: any)
	if Kind == "Delivered" then
		UI.Toast("Your package was delivered.")
	elseif Kind == "Refund" and typeof(Detail) == "string" then
		UI.Toast(Detail, false)
	end
end)
