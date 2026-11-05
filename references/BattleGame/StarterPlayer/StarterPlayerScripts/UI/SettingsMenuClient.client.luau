-- StarterPlayer > StarterPlayerScripts > SettingsMenuClient   (LocalScript, client)
--
-- One Settings menu for everything that used to be in the Settings and Admin dropdowns, laid
-- out like Universal TD's settings:
--   left    categories (All, Gameplay, Camera, Display, Audio, Mobile Controls, then the admin
--           ones for admins only)
--   top     search
--   right   two columns of rows under a header per category
-- The rows are the same top-bar icons Icons makes (shared.SettingsRows, shared.AdminIcon's
-- dropdown), so all the setting logic stays in Icons: a row shows its icon's label and image,
-- and clicking it runs that icon's own 'selected' handler (icon:select()). The volume/size rows
-- use icon.SettingsStep(-1 / 1).
-- Opened by the Settings button in Icons (shared.settingsmenu).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local Icon = require(ReplicatedStorage.Modules:WaitForChild("Icon"))

------------------------------------------------------------------------
-- Neutral palette (same as Quests)
------------------------------------------------------------------------
local RGB = Color3.fromRGB
local function Seq(Top: Color3, Bottom: Color3): ColorSequence
	return ColorSequence.new(Top, Bottom)
end
local THEME = Seq(RGB(232, 226, 214), RGB(150, 142, 130))
local ADMIN = Seq(RGB(222, 198, 188), RGB(146, 112, 100))
local ON = Seq(RGB(184, 216, 156), RGB(116, 162, 96))
local OFF = Seq(RGB(96, 92, 88), RGB(60, 58, 55))
local SCROLLBAR = RGB(176, 170, 160)

-- the images Icons uses for its ON/OFF rows
local GREEN_SQUARE, RED_SQUARE = "12343172777", "12343172715"

local Menu = UI.Window({ Name = "SettingsUI", Title = "Settings", Gradient = THEME, Icon = "rbxassetid://3687980595" })

------------------------------------------------------------------------
-- Categories
------------------------------------------------------------------------
local ORDER = { "All", "Gameplay", "Camera", "Display", "Audio", "Mobile Controls", "Commands", "Dummies", "Reset Players" }
local IS_ADMIN = { Commands = true, Dummies = true, ["Reset Players"] = true } -- shown under the PS+ heading

-- the general settings are sorted by what their label mentions; anything else is Gameplay
local KEYWORDS = {
	{ "Audio", { "music", "sound", "volume" } },
	{ "Camera", { "camera", "shiftlock", "shake" } },
	{ "Display", { "hide", "blood", "fast mode", "day night", "fps" } },
}
local function GeneralCategory(Text: string): string
	local Lower = Text:lower()
	for _, Entry in KEYWORDS do
		for _, Word in Entry[2] do
			if Lower:find(Word, 1, true) then
				return Entry[1]
			end
		end
	end
	return "Gameplay"
end

local KILL_ROWS = { ResetAll = true, ResetOthers = true, ResetSelf = true, ResetPlayer = true }
-- rows that open something on the screen: the menu gets out of the way first
local CLOSE_FIRST = { ResetPlayer = true, Move_Buttons = true, ["Update Log"] = true }

------------------------------------------------------------------------
-- Reading a row from its icon
------------------------------------------------------------------------
local function Parts(Icon: any): (Instance?, Instance?)
	local Ok1, Label = pcall(Icon.getInstance, Icon, "IconLabel")
	local Ok2, Image = pcall(Icon.getInstance, Icon, "IconImage")
	return if Ok1 then Label else nil, if Ok2 then Image else nil
end

-- Kind ("Toggle" / "Stepper" / "Value" / "Action"), title, and the value or ON state
local function Read(Icon: any): (string, string, any)
	local LabelObject, ImageObject = Parts(Icon)
	local Text = (if LabelObject then (LabelObject :: TextLabel).Text else ""):gsub("^%s+", "")
	local Image = if ImageObject then (ImageObject :: ImageLabel).Image else ""
	if Image:find(GREEN_SQUARE, 1, true) then
		return "Toggle", Text, true
	elseif Image:find(RED_SQUARE, 1, true) then
		return "Toggle", Text, false
	end
	local Name, Value = Text:match("^(.-):%s*(.+)$")
	if Name and Icon.SettingsStep then -- before ON/OFF: Music Volume shows "OFF" at 0
		return "Stepper", Name, Value
	elseif Name and (Value == "ON" or Value == "OFF") then
		return "Toggle", Name, Value == "ON"
	elseif Name then
		return "Value", Name, Value
	end
	return "Action", Text, nil
end

local function IsHeader(Icon: any): boolean
	local LabelObject = Parts(Icon)
	local Text = if LabelObject then (LabelObject :: TextLabel).Text else ""
	return Text:find("^%s*%[[%+%-]%]") ~= nil
end

type Row = { Icon: any, Category: string, Title: string, Root: GuiObject?, Refresh: (() -> ())? }

local function Collect(): { Row }
	local Shared = shared :: any
	local Rows: { Row } = {}
	for _, Child in Shared.SettingsRows or {} do
		if not IsHeader(Child) then
			local _, Title = Read(Child)
			table.insert(Rows, { Icon = Child, Category = Child.SettingsCategory or GeneralCategory(Title), Title = Title })
		end
	end
	local AdminIcon = Shared.AdminIcon
	if type(AdminIcon) == "table" and AdminIcon.childIconsDict then
		local Children = {}
		for UID in AdminIcon.childIconsDict do -- UID -> true
			local Child = Icon.getIconByUID(UID)
			if Child and not IsHeader(Child) then
				table.insert(Children, Child)
			end
		end
		local function Order(Child: any): number
			local Ok, Widget = pcall(Child.getInstance, Child, "Widget")
			return if Ok and Widget then Widget.LayoutOrder else 0
		end
		table.sort(Children, function(A, B)
			return Order(A) < Order(B)
		end)
		for _, Child in Children do
			local _, Title = Read(Child)
			local Category = if KILL_ROWS[Child.name] then "Reset Players" elseif Title:lower():find("dumm", 1, true) then "Dummies" else "Commands"
			table.insert(Rows, { Icon = Child, Category = Category, Title = Title })
		end
	end
	return Rows
end

------------------------------------------------------------------------
-- Layout
------------------------------------------------------------------------
local SIDEBAR_WIDTH, GAP, ROW_HEIGHT = 220, 12, 54

local SearchBox = UI.New("Frame", {
	Size = UDim2.new(0.4, 0, 0, 42),
	Position = UDim2.new(0.55, -30, 0, 14),
	BackgroundColor3 = UI.Colors.DarkerGray,
	Parent = Menu.Window,
}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
UI.Image({ Image = UI.Images.Search, Size = UDim2.fromOffset(22, 22), Position = UDim2.new(0, 10, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), ImageColor3 = UI.Colors.LightGray, Parent = SearchBox })
local SearchInput = UI.New("TextBox", {
	Size = UDim2.new(1, -46, 1, 0),
	Position = UDim2.fromOffset(40, 0),
	BackgroundTransparency = 1,
	PlaceholderText = "Search settings...",
	PlaceholderColor3 = UI.Colors.Gray,
	Text = "",
	TextColor3 = UI.Colors.White,
	FontFace = UI.Font("Medium"),
	TextSize = 18,
	TextXAlignment = Enum.TextXAlignment.Left,
	ClearTextOnFocus = false,
	Parent = SearchBox,
})

local Sidebar = UI.Scroller(Menu.Body, { Size = UDim2.new(0, SIDEBAR_WIDTH, 1, 0), Color = SCROLLBAR, Padding = 8 })
local Content = UI.Scroller(Menu.Body, {
	Size = UDim2.new(1, -(SIDEBAR_WIDTH + GAP), 1, 0),
	Position = UDim2.fromOffset(SIDEBAR_WIDTH + GAP, 0),
	Color = SCROLLBAR,
	Padding = 14,
})
local Empty = UI.Text({ Text = "", TextSize = 22, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 40), TextColor3 = UI.Colors.Gray, LayoutOrder = 1000, Visible = false, Parent = Content })

------------------------------------------------------------------------
-- State
------------------------------------------------------------------------
local Current = "All"
local Rows: { Row } = {}
local Sections: { [string]: { Holder: Frame, Rows: { Row } } } = {}
local SidebarEntries: { [string]: (boolean) -> () } = {}
local Connections: { RBXScriptConnection } = {}

local function Clear(Parent: Instance)
	for _, Child in Parent:GetChildren() do
		if Child:IsA("GuiObject") and Child ~= Empty then
			Child:Destroy()
		end
	end
end

local function GradientFor(Category: string): ColorSequence
	return if IS_ADMIN[Category] then ADMIN else THEME
end

------------------------------------------------------------------------
-- Filtering
------------------------------------------------------------------------
local function ApplyFilter()
	local Query = SearchInput.Text:lower()
	local Searching = Query ~= ""
	local Shown = 0
	for Category, Section in Sections do
		local InCategory = Searching or Current == "All" or Current == Category
		local Visible = 0
		for _, Row in Section.Rows do
			local Match = InCategory and (not Searching or Row.Title:lower():find(Query, 1, true) ~= nil)
			if Row.Root then
				Row.Root.Visible = Match
			end
			if Match then
				Visible += 1
			end
		end
		Section.Holder.Visible = Visible > 0
		Shown += Visible
	end
	Empty.Visible = Shown == 0
	Empty.Text = if #Rows == 0 then "Loading settings..." else "No settings match."
	for Name, Select in SidebarEntries do
		Select(Name == Current and not Searching)
	end
end

------------------------------------------------------------------------
-- Rows
------------------------------------------------------------------------
local function Press(Row: Row)
	if CLOSE_FIRST[Row.Icon.name] or CLOSE_FIRST[Row.Title] then
		Menu:SetOpen(false)
	end
	-- the icon's own handler does the work (and plays the game's click sound)
	local Ok, Err = pcall(Row.Icon.select, Row.Icon)
	if not Ok then
		warn("[SettingsMenu] " .. Row.Title .. ": " .. tostring(Err))
	end
	task.defer(function()
		if Row.Refresh then
			Row.Refresh()
		end
	end)
end

local function MakeRow(Parent: Instance, Row: Row, Order: number)
	local Gradient = GradientFor(Row.Category)
	local Root = UI.New("TextButton", { Name = Row.Title, BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Order, Parent = Parent })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		Parent = Root,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
	local Hover = UI.HoverStroke(Visual, Gradient, 2, 8)
	UI.Bouncy(Root, Visual, { Grow = 0.015, HoverStroke = Hover })
	local Title = UI.Text({ Text = Row.Title, TextSize = 19, TextTruncate = Enum.TextTruncate.AtEnd, Size = UDim2.new(1, -120, 1, 0), Position = UDim2.fromOffset(16, 0), Parent = Visual })

	local Kind = Read(Row.Icon)
	local Refresh: () -> ()
	if Kind == "Toggle" then
		local Switch = UI.New("Frame", {
			Size = UDim2.fromOffset(76, 30),
			Position = UDim2.new(1, -14, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = UI.Colors.White,
			Parent = Visual,
		}, { UI.Corner(15), UI.Stroke(UI.Colors.Black, 2) })
		local Fill = UI.Gradient(OFF, 90)
		Fill.Parent = Switch
		local Knob = UI.New("Frame", {
			Size = UDim2.fromOffset(22, 22),
			Position = UDim2.new(0, 4, 0.5, 0),
			AnchorPoint = Vector2.new(0, 0.5),
			BackgroundColor3 = UI.Colors.White,
			ZIndex = 3,
			Parent = Switch,
		}, { UI.Corner(11), UI.Stroke(UI.Colors.Black, 1.5) })
		local State = UI.Text({ Text = "OFF", TextSize = 14, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, -30, 1, 0), ZIndex = 3, Parent = Switch })
		local First = true
		Refresh = function()
			local _, Name, On = Read(Row.Icon)
			Title.Text = Name
			Fill.Color = if On then ON else OFF
			State.Text = if On then "ON" else "OFF"
			State.Position = if On then UDim2.fromOffset(4, 0) else UDim2.fromOffset(26, 0)
			local KnobAt = if On then UDim2.new(1, -26, 0.5, 0) else UDim2.new(0, 4, 0.5, 0)
			if First then
				Knob.Position = KnobAt
			else
				TweenService:Create(Knob, TweenInfo.new(0.15, Enum.EasingStyle.Quad), { Position = KnobAt }):Play()
			end
			First = false
		end
		Root.Activated:Connect(function()
			Press(Row)
		end)
	elseif Kind == "Stepper" then
		Title.Size = UDim2.new(1, -200, 1, 0)
		local function Step(Direction: number)
			UI.Play("Click", 0.4)
			pcall(Row.Icon.SettingsStep, Direction)
		end
		UI.Button({ Parent = Visual, Size = UDim2.fromOffset(34, 32), Position = UDim2.new(1, -12, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), Text = "+", TextSize = 22, Grow = 0.1, OnClick = function() Step(1) end })
		local Value = UI.Text({ Text = "", TextSize = 18, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.fromOffset(74, 32), Position = UDim2.new(1, -50, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), Parent = Visual })
		UI.Button({ Parent = Visual, Size = UDim2.fromOffset(34, 32), Position = UDim2.new(1, -128, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), Text = "-", TextSize = 22, Grow = 0.1, OnClick = function() Step(-1) end })
		Refresh = function()
			local _, Name, Amount = Read(Row.Icon)
			Title.Text = Name
			Value.Text = tostring(Amount or "")
		end
	elseif Kind == "Value" then
		Title.Size = UDim2.new(1, -150, 1, 0)
		local _, ValueLabel = UI.Pill(Visual, "", { Position = UDim2.new(1, -14, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5) })
		Refresh = function()
			local _, Name, Amount = Read(Row.Icon)
			Title.Text = Name
			ValueLabel.Text = tostring(Amount or "")
		end
		Root.Activated:Connect(function()
			Press(Row)
		end)
	else
		Title.Size = UDim2.new(1, -130, 1, 0)
		local Word = if CLOSE_FIRST[Row.Icon.name] or CLOSE_FIRST[Row.Title] then "Open" else "Run"
		UI.Button({ Parent = Visual, Size = UDim2.fromOffset(88, 34), Position = UDim2.new(1, -12, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), Text = Word, TextSize = 17, Gradient = Gradient, Grow = 0.06, OnClick = function() Press(Row) end })
		Refresh = function()
			local _, Name = Read(Row.Icon)
			Title.Text = Name
		end
		Root.Activated:Connect(function()
			Press(Row)
		end)
	end

	Refresh()
	Row.Root, Row.Refresh = Root, Refresh
	-- Icons changes the label/image when a setting changes (from here or anywhere else)
	local LabelObject, ImageObject = Parts(Row.Icon)
	if LabelObject then
		table.insert(Connections, LabelObject:GetPropertyChangedSignal("Text"):Connect(Refresh))
	end
	if ImageObject then
		table.insert(Connections, ImageObject:GetPropertyChangedSignal("Image"):Connect(Refresh))
	end
end

------------------------------------------------------------------------
-- Sidebar
------------------------------------------------------------------------
local function AddSidebarEntry(Name: string, Order: number, Count: number)
	local Gradient = GradientFor(Name)
	local Root = UI.New("TextButton", { Name = Name, Size = UDim2.new(1, 0, 0, 46), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Order, Parent = Sidebar })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
	local Wash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, BackgroundTransparency = 1, Parent = Visual }, { UI.Corner(8) })
	UI.New("UIGradient", {
		Color = Gradient,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0.75) }),
		Parent = Wash,
	})
	local Strip = UI.New("Frame", { Size = UDim2.new(0, 6, 1, 0), BackgroundColor3 = UI.Colors.White, Parent = Visual })
	UI.Gradient(Gradient, 90).Parent = Strip
	UI.Text({ Text = Name, TextSize = 20, Size = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(18, 0), Gradient = Gradient, Parent = Visual })
	UI.Text({ Text = tostring(Count), TextSize = 16, TextColor3 = UI.Colors.LightGray, TextXAlignment = Enum.TextXAlignment.Right, Size = UDim2.new(0, 40, 1, 0), Position = UDim2.new(1, -12, 0, 0), AnchorPoint = Vector2.new(1, 0), Parent = Visual })
	local Hover = UI.HoverStroke(Visual, Gradient, 2, 8)
	UI.Bouncy(Root, Visual, { Grow = 0.02, HoverStroke = Hover })
	SidebarEntries[Name] = function(Selected: boolean)
		Wash.BackgroundTransparency = if Selected then 0 else 1
	end
	Root.Activated:Connect(function()
		UI.Play("Click", 0.4)
		Current = Name
		SearchInput.Text = ""
		ApplyFilter()
		Content.CanvasPosition = Vector2.zero
	end)
end

------------------------------------------------------------------------
-- Building (every time the menu opens, so it always matches Icons)
------------------------------------------------------------------------
local function Build()
	for _, Connection in Connections do
		Connection:Disconnect()
	end
	table.clear(Connections)
	Clear(Sidebar)
	Clear(Content)
	table.clear(Sections)
	table.clear(SidebarEntries)

	Rows = Collect()
	local ByCategory: { [string]: { Row } } = {}
	for _, Row in Rows do
		ByCategory[Row.Category] = ByCategory[Row.Category] or {}
		table.insert(ByCategory[Row.Category], Row)
	end

	local SawAdmin = false
	for Index, Category in ORDER do
		local List = if Category == "All" then Rows else ByCategory[Category]
		if not List or #List == 0 then
			continue
		end
		if IS_ADMIN[Category] and not SawAdmin then
			SawAdmin = true
			UI.Text({ Text = "PS+", TextSize = 15, TextColor3 = UI.Colors.Gray, Size = UDim2.new(1, 0, 0, 22), Position = UDim2.fromOffset(6, 0), LayoutOrder = Index * 10 - 1, Parent = Sidebar })
		end
		AddSidebarEntry(Category, Index * 10, #List)
		if Category == "All" then
			continue
		end

		local Holder = UI.New("Frame", {
			Name = Category,
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = Index,
			Parent = Content,
		}, { UI.New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }) })
		UI.SectionTitle(Holder, Category, GradientFor(Category), 1)
		local Grid = UI.New("Frame", {
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = 2,
			Parent = Holder,
		}, {
			UI.New("UIGridLayout", {
				CellSize = UDim2.new(0.5, -5, 0, ROW_HEIGHT),
				CellPadding = UDim2.fromOffset(10, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
			UI.New("UIPadding", { PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2) }),
		})
		for RowIndex, Row in List do
			MakeRow(Grid, Row, RowIndex)
		end
		Sections[Category] = { Holder = Holder, Rows = List }
	end

	if not SidebarEntries[Current] then
		Current = "All"
	end
	ApplyFilter()
end

SearchInput:GetPropertyChangedSignal("Text"):Connect(ApplyFilter)

Menu.OnOpen = Build

UI.Own("settingsmenu", function()
	Menu:Toggle()
end)
