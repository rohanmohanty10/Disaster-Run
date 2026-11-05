-- StarterPlayer > StarterPlayerScripts > QuestClient   (LocalScript, client)
--
-- The Quests menu. Same pieces as before (search, Claim All, quest cards, the picked quest with
-- its objective bar, rewards and Claim button), laid out as:
--   left    category sidebar: All / Daily / Weekly / Monthly, then one entry per character
--   middle  the quests in the picked category
--   right   the picked quest
--   bottom  Total Progress for the picked category
-- Colors are a neutral palette kept in this script, so the Store keeps ExpeditionUI's colors.
-- Quests come from ReplicatedStorage.Modules.QuestConfig; progress and claiming go through
-- ReplicatedStorage.Remotes.Quests (made by QuestService). Opened by the Quests button in Icons
-- (shared.questgui).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local QuestConfig = require(ReplicatedStorage.Modules:WaitForChild("QuestConfig"))
local InfoModule = require(ReplicatedStorage:WaitForChild("Info"))
local QuestRemotes = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Quests")
local Request: RemoteFunction = QuestRemotes:WaitForChild("Request")
local Changed: RemoteEvent = QuestRemotes:WaitForChild("Changed")

------------------------------------------------------------------------
-- Neutral palette
------------------------------------------------------------------------
local RGB = Color3.fromRGB
local function Seq(Top: Color3, Bottom: Color3): ColorSequence
	return ColorSequence.new(Top, Bottom)
end
local STONE = RGB(150, 146, 140)
local THEME = Seq(RGB(232, 226, 214), RGB(150, 142, 130))
local TITLE = Seq(RGB(246, 241, 232), RGB(204, 195, 180))
local DONE = Seq(RGB(184, 216, 156), RGB(116, 162, 96))
local DONE_TEXT = RGB(178, 214, 150)
local SCROLLBAR = RGB(176, 170, 160)
local CATEGORY_GRADIENT: { [string]: ColorSequence } = {
	Daily = Seq(RGB(206, 212, 216), RGB(128, 138, 146)),
	Weekly = Seq(RGB(216, 202, 182), RGB(140, 124, 104)),
	Monthly = Seq(RGB(224, 206, 164), RGB(156, 132, 86)),
}
local CATEGORY_ICON: { [string]: string } = {}
-- characters: their glow color pulled most of the way to grey, and their moveset icon
for _, Category in QuestConfig.Categories do
	local Moveset = QuestConfig.Permanent[Category] and InfoModule.Movesets[Category]
	if Moveset then
		local Tint = (Moveset.Glow or STONE):Lerp(STONE, 0.6)
		CATEGORY_GRADIENT[Category] = Seq(Tint:Lerp(RGB(255, 255, 255), 0.3), Tint:Lerp(RGB(0, 0, 0), 0.3))
		if Moveset.Icon then
			CATEGORY_ICON[Category] = "rbxassetid://" .. string.format("%d", Moveset.Icon)
		end
	end
end

local function Label(Category: string): string
	return QuestConfig.Display[Category] or Category
end

local function GradientFor(Category: string): ColorSequence
	return CATEGORY_GRADIENT[Category] or THEME
end

local Menu = UI.Window({ Name = "QuestsUI", Title = "Quests", Gradient = THEME, Icon = UI.Images.QuestIcon })

------------------------------------------------------------------------
-- State
------------------------------------------------------------------------
type QuestEntry = { Category: string, Quest: any }
local State: any = nil -- the server's snapshot
local ReceivedAt = os.clock()
local Filter = "All"
local Search = ""
local Selected: QuestEntry? = nil

local function ServerNow(): number
	return if State then State.ServerTime + (os.clock() - ReceivedAt) else os.time()
end

local function Progress(Entry: QuestEntry): (number, boolean, boolean)
	local Period = State and State.Periods[Entry.Category]
	local Value = Period and Period.Progress[Entry.Quest.Id] or 0
	local Claimed = Period and Period.Claimed[Entry.Quest.Id] == true or false
	return math.min(Value, Entry.Quest.Goal), Value >= Entry.Quest.Goal, Claimed
end

local function TimeLeft(Category: string): string
	if QuestConfig.Permanent[Category] then
		return "Permanent"
	end
	local Period = State and State.Periods[Category]
	return if Period then UI.TimeLeft(Period.ResetAt - ServerNow()) else "..."
end

------------------------------------------------------------------------
-- Layout
------------------------------------------------------------------------
local SIDEBAR_WIDTH, DETAIL_WIDTH, GAP, FOOTER_HEIGHT = 220, 340, 12, 56
local CONTENT_HEIGHT = -(FOOTER_HEIGHT + GAP)

-- search + claim all, next to the header
local SearchBox = UI.New("Frame", {
	Size = UDim2.new(0.33, 0, 0, 42),
	Position = UDim2.new(0.42, -30, 0, 14),
	BackgroundColor3 = UI.Colors.DarkerGray,
	Parent = Menu.Window,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Image({ Image = UI.Images.Search, Size = UDim2.fromOffset(22, 22), Position = UDim2.new(0, 10, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ImageColor3 = UI.Colors.LightGray, Parent = SearchBox })
local SearchInput = UI.New("TextBox", {
	Size = UDim2.new(1, -46, 1, 0),
	Position = UDim2.fromOffset(40, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search...",
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
local SelectFilter -- defined below

local ClaimAll = UI.Button({
	Parent = Menu.Window,
	Size = UDim2.new(0.2, 0, 0, 42),
	Position = UDim2.new(0.75, -22, 0, 14),
	Gradient = UI.Gradients.Grey,
	Text = "Claim All",
	TextSize = 18,
	OnClick = function()
		if not State then
			return
		end
		local Keys = {}
		for Category, Period in State.Periods do
			Keys[Category] = Period.Key
		end
		local Ok, Message, NewState = Request:InvokeServer("ClaimAll", nil, nil, Keys)
		if NewState then
			State, ReceivedAt = NewState, os.clock()
		end
		UI.Toast(if typeof(Message) == "string" then Message else "Couldn't claim.", Ok)
		Render()
	end,
})

-- left: categories
local Sidebar = UI.Scroller(Menu.Body, { Size = UDim2.new(0, SIDEBAR_WIDTH, 1, CONTENT_HEIGHT), Color = SCROLLBAR, Padding = 8 })

-- middle: quests
local List = UI.Scroller(Menu.Body, {
	Size = UDim2.new(1, -(SIDEBAR_WIDTH + DETAIL_WIDTH + GAP * 2), 1, CONTENT_HEIGHT),
	Position = UDim2.fromOffset(SIDEBAR_WIDTH + GAP, 0),
	Color = SCROLLBAR,
	Padding = 8,
})

-- right: the picked quest
local Detail = UI.New("Frame", {
	Size = UDim2.new(0, DETAIL_WIDTH, 1, CONTENT_HEIGHT),
	Position = UDim2.new(1, -DETAIL_WIDTH, 0, 0),
	BackgroundColor3 = UI.Colors.Card,
	ClipsDescendants = true,
	Parent = Menu.Body,
}, { UI.Corner(10), UI.Stroke(UI.Colors.DarkGray, 2) })
local DetailWash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, Parent = Detail }, { UI.Corner(10) })
local DetailWashGradient = UI.New("UIGradient", {
	Color = THEME,
	Rotation = 90,
	Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.7), NumberSequenceKeypoint.new(0.6, 0.92), NumberSequenceKeypoint.new(1, 1) }),
	Parent = DetailWash,
})
UI.Image({ Image = UI.Images.Checkered, ImageTransparency = 0.95, ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.fromOffset(12, 12), Size = UDim2.fromScale(1, 1), Parent = Detail })
local DetailCategory = UI.Text({ Text = "", TextSize = 18, Size = UDim2.new(1, -24, 0, 20), Position = UDim2.fromOffset(14, 12), Gradient = THEME, Parent = Detail })
local DetailTitle = UI.Text({ Text = "", TextSize = 30, TextScaled = true, Size = UDim2.new(1, -28, 0, 34), Position = UDim2.fromOffset(14, 32), Gradient = TITLE, Parent = Detail })
UI.New("UITextSizeConstraint", { MaxTextSize = 30, Parent = DetailTitle })
local _, DetailTimerText = UI.Pill(Detail, "", { Position = UDim2.fromOffset(14, 72), Icon = UI.Images.Clock })
local DetailDescription = UI.Text({ Text = "", TextSize = 17, NoStroke = true, TextColor3 = UI.Colors.LightGray, TextWrapped = true, Size = UDim2.new(1, -28, 0, 40), Position = UDim2.fromOffset(14, 108), TextYAlignment = Enum.TextYAlignment.Top, Parent = Detail })

local Objective = UI.New("Frame", { Size = UDim2.new(1, -28, 0, 64), Position = UDim2.fromOffset(14, 152), BackgroundColor3 = UI.Colors.Black, BackgroundTransparency = 0.3, Parent = Detail }, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 1.5) })
local ObjectiveText = UI.Text({ Text = "", TextSize = 15, Size = UDim2.new(1, -20, 0, 20), Position = UDim2.fromOffset(10, 6), Parent = Objective })
local Bar = UI.New("Frame", { Size = UDim2.new(1, -20, 0, 22), Position = UDim2.fromOffset(10, 32), BackgroundColor3 = UI.Colors.DarkerGray, Parent = Objective }, { UI.Corner(6), UI.Stroke(UI.Colors.Black, 1.5) })
local BarFill = UI.New("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = UI.Colors.White, Parent = Bar }, { UI.Corner(6) })
local BarGradient = UI.Gradient(THEME, 90)
BarGradient.Parent = BarFill
local BarText = UI.Text({ Text = "", TextSize = 15, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = Bar })

UI.Text({ Text = "Rewards", TextSize = 18, Size = UDim2.new(1, -28, 0, 20), Position = UDim2.fromOffset(14, 230), Parent = Detail })
local Rewards = UI.New("Frame", { Size = UDim2.new(1, -28, 0, 84), Position = UDim2.fromOffset(14, 254), BackgroundTransparency = 1, Parent = Detail }, {
	UI.New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
})

local DetailClaim = UI.Button({
	Parent = Detail,
	Size = UDim2.new(1, -28, 0, 54),
	Position = UDim2.new(0, 14, 1, -14),
	AnchorPoint = Vector2.new(0, 1),
	Text = "Incomplete",
	TextSize = 24,
	OnClick = function()
		local Entry = Selected
		if not (Entry and State) then
			return
		end
		local _, Done, Claimed = Progress(Entry)
		if not Done or Claimed then
			return
		end
		local Ok, Message, NewState = Request:InvokeServer("Claim", Entry.Category, Entry.Quest.Id, State.Periods[Entry.Category].Key)
		if NewState then
			State, ReceivedAt = NewState, os.clock()
		end
		UI.Toast(if typeof(Message) == "string" then Message else "Couldn't claim.", Ok)
		Render()
	end,
})

-- bottom: total progress for the picked category
local Footer = UI.New("Frame", { Size = UDim2.new(1, 0, 0, FOOTER_HEIGHT), Position = UDim2.new(0, 0, 1, -FOOTER_HEIGHT), BackgroundTransparency = 1, Parent = Menu.Body })
local TotalText = UI.Text({ Text = "Total Progress: 0%", TextSize = 20, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 24), Parent = Footer })
local TotalBar = UI.New("Frame", { Size = UDim2.new(1, 0, 0, 24), Position = UDim2.new(0, 0, 1, -24), BackgroundColor3 = UI.Colors.DarkerGray, Parent = Footer }, { UI.Corner(6), UI.Stroke(UI.Colors.Black, 1.5) })
local TotalFill = UI.New("Frame", { Size = UDim2.fromScale(0, 1), BackgroundColor3 = UI.Colors.White, Parent = TotalBar }, { UI.Corner(6) })
local TotalGradient = UI.Gradient(THEME, 90)
TotalGradient.Parent = TotalFill
local TotalBarText = UI.Text({ Text = "", TextSize = 15, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = TotalBar })

local Empty = UI.Text({ Text = "Loading quests...", TextSize = 22, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 40), Position = UDim2.fromScale(0, 0.4), TextColor3 = UI.Colors.Gray, Parent = List })

------------------------------------------------------------------------
-- The picked quest
------------------------------------------------------------------------
local function ShowDetail(Entry: QuestEntry?)
	Selected = Entry
	Detail.Visible = Entry ~= nil
	if not Entry then
		return
	end
	local Quest = Entry.Quest
	local Value, Done, Claimed = Progress(Entry)
	local Gradient = GradientFor(Entry.Category)
	DetailCategory.Text = `{Label(Entry.Category)} Quest`
	DetailCategory:FindFirstChildOfClass("UIGradient").Color = Gradient
	DetailWashGradient.Color = Gradient
	DetailTitle.Text = Quest.Title
	DetailTimerText.Text = TimeLeft(Entry.Category)
	DetailDescription.Text = Quest.Description
	ObjectiveText.Text = "• " .. Quest.Description
	local Ratio = Value / Quest.Goal
	TweenService:Create(BarFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = UDim2.fromScale(math.clamp(Ratio, 0, 1), 1) }):Play()
	BarGradient.Color = if Done then DONE else Gradient
	BarText.Text = `{UI.Comma(Value)}/{UI.Comma(Quest.Goal)} ({math.floor(Ratio * 100)}%)`

	for _, Child in Rewards:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	local Order = 0
	for _, Kind in { "Gold", "Spins" } do
		local Amount = Quest[Kind]
		local Art = QuestConfig.RewardArt[Kind]
		if Amount and Amount > 0 and Art then
			Order += 1
			UI.Slot(Rewards, { Art = Art.Art, Count = Amount, Name = Art.Name, Rarity = Art.Rarity, Size = 80, LayoutOrder = Order })
		end
	end

	DetailClaim.Fill.Color = if Claimed then UI.Gradients.Grey elseif Done then DONE else UI.Gradients.Grey
	DetailClaim.Label.Text = if Claimed then "Claimed" elseif Done then "Claim" else "Incomplete"
	DetailClaim.Label.TextColor3 = if Done and not Claimed then UI.Colors.White else UI.Colors.LightGray
end

------------------------------------------------------------------------
-- A card shell shared by the quest cards and the sidebar entries
------------------------------------------------------------------------
local function CardShell(Parent: Instance, Name: string, Height: number, Order: number, Gradient: ColorSequence)
	local Root = UI.New("TextButton", { Name = Name, Size = UDim2.new(1, 0, 0, Height), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Order, Parent = Parent })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
	-- selected: the card fills with the category color
	local Wash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, BackgroundTransparency = 1, Parent = Visual }, { UI.Corner(8) })
	UI.New("UIGradient", {
		Color = Gradient,
		Rotation = 0,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0.75) }),
		Parent = Wash,
	})
	-- the colored strip on the left edge
	local Strip = UI.New("Frame", { Size = UDim2.new(0, 6, 1, 0), BackgroundColor3 = UI.Colors.White, Parent = Visual })
	UI.Gradient(Gradient, 90).Parent = Strip
	-- ready to claim: a green outline that stays on
	local Ready = UI.HoverStroke(Visual, DONE, 3, 8)
	Ready.Transparency = 1
	local Hover = UI.HoverStroke(Visual, Gradient, 2, 8)
	UI.Bouncy(Root, Visual, { Grow = 0.015, HoverStroke = Hover })
	return Root, Visual, Wash, Ready
end

------------------------------------------------------------------------
-- The sidebar
------------------------------------------------------------------------
type SidebarEntry = { Select: (boolean) -> (), Ready: UIStroke, Timer: TextLabel? }
local SidebarEntries: { [string]: SidebarEntry } = {}

local function AddSidebarEntry(Name: string, Order: number)
	local Character = QuestConfig.Permanent[Name] == true
	local Timed = Name ~= "All" and not Character
	local Height = if Timed then 72 elseif Character then 58 else 46
	local Gradient = if Name == "All" then THEME else GradientFor(Name)
	local Root, Visual, Wash, Ready = CardShell(Sidebar, Name, Height, Order, Gradient)

	local Art: ImageLabel? = nil
	local Timer: TextLabel? = nil
	if Timed then
		-- banner: name, reset timer, faint scroll behind
		Art = UI.Image({ Image = UI.Images.QuestIcon, Size = UDim2.new(0.45, 0, 1.4, 0), Position = UDim2.new(1, -6, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ImageTransparency = 0.85, Parent = Visual })
		UI.Gradient(Gradient, 0).Parent = Art
		UI.Text({ Text = Label(Name), TextSize = 24, Size = UDim2.new(1, -30, 0, 28), Position = UDim2.fromOffset(18, 8), Gradient = Gradient, Parent = Visual })
		local _, TimerLabel = UI.Pill(Visual, TimeLeft(Name), { Icon = UI.Images.Clock, Position = UDim2.fromOffset(18, 38) })
		Timer = TimerLabel
	elseif Character then
		-- character icon + name
		Art = UI.Image({ Image = CATEGORY_ICON[Name] or UI.Images.QuestIcon, Size = UDim2.fromOffset(40, 40), Position = UDim2.new(0, 16, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), Parent = Visual })
		UI.Text({ Text = Label(Name), TextSize = 21, Size = UDim2.new(1, -72, 1, 0), Position = UDim2.fromOffset(64, 0), Parent = Visual })
	else
		UI.Text({ Text = Label(Name), TextSize = 21, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromScale(1, 1), Parent = Visual })
	end

	local function Select(On: boolean)
		Wash.BackgroundTransparency = if On then 0 else 1
		if Art and Timed then
			Art.ImageTransparency = if On then 0.7 else 0.85
		end
	end
	Root.Activated:Connect(function()
		UI.Play("Click", 0.3)
		SelectFilter(Name)
	end)
	SidebarEntries[Name] = { Select = Select, Ready = Ready, Timer = Timer }
end

do
	local Order = 0
	local function Next(): number
		Order += 1
		return Order
	end
	AddSidebarEntry("All", Next())
	local HeaderAdded = false
	for _, Category in QuestConfig.Categories do
		if QuestConfig.Permanent[Category] and not HeaderAdded then
			HeaderAdded = true
			UI.Text({ Text = "Characters", TextSize = 17, TextColor3 = UI.Colors.Gray, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 24), LayoutOrder = Next(), Parent = Sidebar })
		end
		AddSidebarEntry(Category, Next())
	end
end

------------------------------------------------------------------------
-- The list
------------------------------------------------------------------------
local Cards: { [string]: { Entry: QuestEntry, Timer: TextLabel, Select: (boolean) -> () } } = {}

local function QuestCard(Entry: QuestEntry, Order: number)
	local Quest = Entry.Quest
	local Value, Done, Claimed = Progress(Entry)
	local Gradient = GradientFor(Entry.Category)
	local Root, Visual, Wash, Ready = CardShell(List, Quest.Id, 108, Order, Gradient)
	Ready.Transparency = if Done and not Claimed then 0 else 1

	-- faint scroll (or the character's icon) on the right
	local Watermark = UI.Image({ Image = CATEGORY_ICON[Entry.Category] or UI.Images.QuestIcon, Size = UDim2.new(0.35, 0, 1.4, 0), Position = UDim2.new(1, -10, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ImageTransparency = 0.88, Parent = Visual })
	UI.Gradient(Gradient, 0).Parent = Watermark

	local Top = UI.New("Frame", { Size = UDim2.new(1, -60, 0, 24), Position = UDim2.fromOffset(20, 10), BackgroundTransparency = 1, Parent = Visual }, {
		UI.New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	UI.Text({ Text = `{Label(Entry.Category)} Quest`, TextSize = 17, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Gradient = Gradient, LayoutOrder = 1, Parent = Top })
	local _, Timer = UI.Pill(Top, TimeLeft(Entry.Category), { Icon = if QuestConfig.Permanent[Entry.Category] then nil else UI.Images.Clock, LayoutOrder = 2 })

	local TitleRow = UI.New("Frame", { Size = UDim2.new(1, -40, 0, 32), Position = UDim2.fromOffset(20, 38), BackgroundTransparency = 1, Parent = Visual }, {
		UI.New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	UI.Text({ Text = Quest.Title, TextSize = 27, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 1, 0), Gradient = if Claimed then UI.Gradients.Grey else TITLE, LayoutOrder = 1, Parent = TitleRow })
	if Done then
		local Check = UI.Image({ Image = UI.Images.Check, Size = UDim2.fromOffset(24, 24), LayoutOrder = 2, Parent = TitleRow })
		UI.Gradient(DONE, 90).Parent = Check
	end
	UI.Text({
		Text = Quest.Description,
		TextSize = 16,
		TextColor3 = if Done then DONE_TEXT else UI.Colors.White,
		Size = UDim2.new(1, -40, 0, 20),
		Position = UDim2.fromOffset(20, 72),
		Parent = Visual,
	})
	-- thin progress line along the bottom
	local Line = UI.New("Frame", { Size = UDim2.new(1, -26, 0, 4), Position = UDim2.new(0, 20, 1, -9), BackgroundColor3 = UI.Colors.DarkGray, Parent = Visual }, { UI.Corner(2) })
	local LineFill = UI.New("Frame", { Size = UDim2.fromScale(math.clamp(Value / Quest.Goal, 0, 1), 1), BackgroundColor3 = UI.Colors.White, Parent = Line }, { UI.Corner(2) })
	UI.Gradient(if Done then DONE else Gradient, 0).Parent = LineFill

	local function Select(On: boolean)
		Wash.BackgroundTransparency = if On then 0 else 1
		Watermark.ImageTransparency = if On then 0.7 else 0.88
	end
	Root.Activated:Connect(function()
		UI.Play("Click", 0.3)
		for _, Card in Cards do
			Card.Select(false)
		end
		Select(true)
		ShowDetail(Entry)
	end)
	if Claimed then
		Visual.BackgroundTransparency = 0.4
	end
	Cards[Entry.Category .. Quest.Id] = { Entry = Entry, Timer = Timer, Select = Select }
end

local function InFilter(Category: string): boolean
	return Filter == "All" or Filter == Category
end

local function UpdateTotals()
	local Total, Complete = 0, 0
	local ReadyIn: { [string]: boolean } = {}
	if State then
		for _, Category in QuestConfig.Categories do
			for _, Quest in QuestConfig.Quests[Category] do
				local _, Done, Claimed = Progress({ Category = Category, Quest = Quest })
				if Done and not Claimed then
					ReadyIn[Category] = true
					ReadyIn.All = true
				end
				if InFilter(Category) then
					Total += 1
					if Done then
						Complete += 1
					end
				end
			end
		end
	end
	for Name, Entry in SidebarEntries do
		Entry.Ready.Transparency = if ReadyIn[Name] then 0 else 1
		if Entry.Timer then
			Entry.Timer.Text = TimeLeft(Name)
		end
	end
	local Ratio = if Total > 0 then Complete / Total else 0
	TotalText.Text = `Total Progress: {math.floor(Ratio * 100)}%`
	TotalBarText.Text = `{Complete}/{Total} quests`
	TotalGradient.Color = if Filter == "All" then THEME else GradientFor(Filter)
	TweenService:Create(TotalFill, TweenInfo.new(0.3, Enum.EasingStyle.Quad), { Size = UDim2.fromScale(math.clamp(Ratio, 0, 1), 1) }):Play()
end

Render = function()
	for _, Child in List:GetChildren() do
		if Child:IsA("GuiObject") and Child ~= Empty then
			Child:Destroy()
		end
	end
	table.clear(Cards)
	UpdateTotals()
	if not State then
		Empty.Visible = true
		Empty.Text = "Loading quests..."
		ShowDetail(nil)
		return
	end

	-- ready to claim first, then in progress, then already claimed
	local Entries: { QuestEntry } = {}
	local Needle = string.lower(Search)
	for _, Category in QuestConfig.Categories do
		if InFilter(Category) then
			for _, Quest in QuestConfig.Quests[Category] do
				local Text = string.lower(Quest.Title .. " " .. Quest.Description)
				if Needle == "" or string.find(Text, Needle, 1, true) then
					table.insert(Entries, { Category = Category, Quest = Quest })
				end
			end
		end
	end
	local function Rank(Entry: QuestEntry): number
		local _, Done, Claimed = Progress(Entry)
		return if Claimed then 3 elseif Done then 1 else 2
	end
	table.sort(Entries, function(A, B)
		local RA, RB = Rank(A), Rank(B)
		if RA ~= RB then
			return RA < RB
		end
		return table.find(QuestConfig.Categories, A.Category) < table.find(QuestConfig.Categories, B.Category)
	end)

	local AnyReady = false
	for Index, Entry in Entries do
		QuestCard(Entry, Index)
		if Rank(Entry) == 1 then
			AnyReady = true
		end
	end
	ClaimAll.Fill.Color = if AnyReady then DONE else UI.Gradients.Grey
	Empty.Visible = #Entries == 0
	Empty.Text = "No quests found."

	-- keep the picked quest picked (or pick the first one)
	local Keep = Selected and Cards[Selected.Category .. Selected.Quest.Id]
	local Pick = Keep or (Entries[1] and Cards[Entries[1].Category .. Entries[1].Quest.Id])
	if Pick then
		Pick.Select(true)
		ShowDetail(Pick.Entry)
	else
		ShowDetail(nil)
	end
end

SelectFilter = function(Name: string)
	Filter = Name
	for EntryName, Entry in SidebarEntries do
		Entry.Select(EntryName == Name)
	end
	Render()
end

SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
	Search = SearchInput.Text
	Render()
end)

------------------------------------------------------------------------
-- Data
------------------------------------------------------------------------
local function Load()
	local Ok, Result = Request:InvokeServer("Get")
	if Ok and typeof(Result) == "table" then
		State, ReceivedAt = Result, os.clock()
		Render()
	else
		task.delay(2, Load) -- profile still loading
	end
end

Changed.OnClientEvent:Connect(function(NewState)
	State, ReceivedAt = NewState, os.clock()
	if Menu.IsOpen then
		Render()
	end
end)

-- count the timers down while the menu is open
task.spawn(function()
	while true do
		task.wait(1)
		if Menu.IsOpen and State then
			for _, Card in Cards do
				Card.Timer.Text = TimeLeft(Card.Entry.Category)
			end
			for Name, Entry in SidebarEntries do
				if Entry.Timer then
					Entry.Timer.Text = TimeLeft(Name)
				end
			end
			if Selected then
				DetailTimerText.Text = TimeLeft(Selected.Category)
			end
		end
	end
end)

Menu.OnOpen = function()
	SelectFilter(Filter)
	if not State then
		Load()
	end
end

shared.questgui = function()
	Menu:Toggle()
end

SelectFilter(Filter)
task.spawn(Load)
