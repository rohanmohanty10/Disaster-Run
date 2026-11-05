-- StarterPlayer > StarterPlayerScripts > UpdateLogClient   (LocalScript, client)
--
-- The Update Log, in the style of the other menus (ReplicatedStorage.Modules.ExpeditionUI):
--   left    every update, newest first (version and date)
--   right   the picked update: its title, date and notes
-- What it shows comes from ReplicatedStorage.Modules.UpdateLog. Opened by the newspaper button at
-- the top right (Icons, shared.updatelog).

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local Updates = require(ReplicatedStorage.Modules:WaitForChild("UpdateLog"))

local RGB = Color3.fromRGB
local THEME = ColorSequence.new(RGB(232, 226, 214), RGB(150, 142, 130))
local TITLE = ColorSequence.new(RGB(246, 241, 232), RGB(204, 195, 180))
local SCROLLBAR = RGB(176, 170, 160)

local SIDEBAR_WIDTH, GAP = 240, 12

local Menu = UI.Window({ Name = "UpdateLogUI", Title = "Updates", Gradient = THEME })

------------------------------------------------------------------------
-- Layout
------------------------------------------------------------------------
local Sidebar = UI.Scroller(Menu.Body, { Size = UDim2.new(0, SIDEBAR_WIDTH, 1, 0), Color = SCROLLBAR, Padding = 8 })

local Detail = UI.New("Frame", {
	Size = UDim2.new(1, -(SIDEBAR_WIDTH + GAP), 1, 0),
	Position = UDim2.fromOffset(SIDEBAR_WIDTH + GAP, 0),
	BackgroundColor3 = UI.Colors.Card,
	ClipsDescendants = true,
	Parent = Menu.Body,
}, { UI.Corner(10), UI.Stroke(UI.Colors.DarkGray, 2) })
local Wash = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, Parent = Detail }, { UI.Corner(10) })
UI.New("UIGradient", {
	Color = THEME,
	Rotation = 90,
	Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.75), NumberSequenceKeypoint.new(0.5, 0.94), NumberSequenceKeypoint.new(1, 1) }),
	Parent = Wash,
})
local DetailTitle = UI.Text({ Text = "", TextSize = 34, Weight = "ExtraBold", TextScaled = true, Gradient = TITLE, Size = UDim2.new(1, -40, 0, 40), Position = UDim2.fromOffset(20, 18), Parent = Detail })
UI.New("UITextSizeConstraint", { MaxTextSize = 34, Parent = DetailTitle })
local _, DetailDate = UI.Pill(Detail, "", { Position = UDim2.fromOffset(20, 66), Icon = UI.Images.Clock })
local Notes = UI.Scroller(Detail, { Size = UDim2.new(1, -24, 1, -112), Position = UDim2.fromOffset(12, 104), Color = SCROLLBAR, Padding = 6 })

local Empty = UI.Text({ Text = "No updates yet.", TextSize = 22, TextColor3 = UI.Colors.Gray, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 0, 40), Position = UDim2.fromScale(0, 0.42), Visible = #Updates == 0, Parent = Detail })

------------------------------------------------------------------------
-- The picked update
------------------------------------------------------------------------
local function ShowUpdate(Update: any)
	for _, Child in Notes:GetChildren() do
		if Child:IsA("GuiObject") then
			Child:Destroy()
		end
	end
	DetailTitle.Text = tostring(Update.Title or ("Update " .. tostring(Update.Version)))
	DetailDate.Text = if Update.Version then `v{Update.Version}  •  {Update.Date or ""}` else tostring(Update.Date or "")
	for Index, Line in Update.Notes or {} do
		Line = tostring(Line)
		if string.sub(Line, 1, 1) == "#" then
			UI.Text({
				Text = string.gsub(string.sub(Line, 2), "^%s+", ""),
				TextSize = 22,
				Gradient = THEME,
				Size = UDim2.new(1, 0, 0, 34),
				TextYAlignment = Enum.TextYAlignment.Bottom,
				LayoutOrder = Index,
				Parent = Notes,
			})
		else
			UI.Text({
				Text = "•  " .. Line,
				TextSize = 18,
				NoStroke = true,
				TextColor3 = UI.Colors.LightGray,
				TextWrapped = true,
				AutomaticSize = Enum.AutomaticSize.Y,
				Size = UDim2.new(1, -8, 0, 22),
				LayoutOrder = Index,
				Parent = Notes,
			})
		end
	end
	Notes.CanvasPosition = Vector2.zero
end

------------------------------------------------------------------------
-- The list
------------------------------------------------------------------------
local Selectors: { (boolean) -> () } = {}

local function Pick(Index: number)
	for Other, Select in Selectors do
		Select(Other == Index)
	end
	ShowUpdate(Updates[Index])
end

for Index, Update in Updates do
	local Root = UI.New("TextButton", { Name = tostring(Update.Version), Size = UDim2.new(1, 0, 0, 64), BackgroundTransparency = 1, Text = "", AutoButtonColor = false, LayoutOrder = Index, Parent = Sidebar })
	local Visual = UI.New("Frame", {
		Size = UDim2.fromScale(1, 1),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = UI.Colors.Card,
		ClipsDescendants = true,
		Parent = Root,
	}, { UI.Corner(8), UI.Stroke(UI.Colors.DarkGray, 2) })
	local Picked = UI.New("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = UI.Colors.White, BackgroundTransparency = 1, Parent = Visual }, { UI.Corner(8) })
	UI.New("UIGradient", {
		Color = THEME,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(1, 0.75) }),
		Parent = Picked,
	})
	local Strip = UI.New("Frame", { Size = UDim2.new(0, 6, 1, 0), BackgroundColor3 = UI.Colors.White, Parent = Visual })
	UI.Gradient(THEME, 90).Parent = Strip
	UI.Text({ Text = if Update.Version then "v" .. tostring(Update.Version) else tostring(Update.Title), TextSize = 22, Gradient = THEME, Size = UDim2.new(1, -30, 0, 26), Position = UDim2.fromOffset(18, 8), Parent = Visual })
	UI.Text({ Text = tostring(Update.Date or ""), TextSize = 15, NoStroke = true, TextColor3 = UI.Colors.LightGray, Size = UDim2.new(1, -30, 0, 20), Position = UDim2.fromOffset(18, 36), Parent = Visual })
	UI.Bouncy(Root, Visual, { Grow = 0.02, HoverStroke = UI.HoverStroke(Visual, THEME, 2, 8) })
	Selectors[Index] = function(Selected: boolean)
		Picked.BackgroundTransparency = if Selected then 0 else 1
	end
	Root.Activated:Connect(function()
		UI.Play("Click", 0.4)
		Pick(Index)
	end)
end

Menu.OnOpen = function()
	if #Updates > 0 then
		Pick(1) -- the newest
	end
end

UI.Own("updatelog", function()
	Menu:Toggle()
end)
