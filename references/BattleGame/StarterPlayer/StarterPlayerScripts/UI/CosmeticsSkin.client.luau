-- StarterPlayer > StarterPlayerScripts > CosmeticsSkin   (LocalScript, client)
--
-- Restyles the Cosmetics menu (PlayerGui.Cosmetics) to match the Store and Quests menus: Rubik
-- fonts, the dark panel with the black outline, neutral stone tabs and buttons, rounded cards.
-- It only changes looks. Nothing is moved, renamed or reparented, and the colors the Cosmetics and
-- Titles scripts set on tiles (equipped / locked / not owned) are left to them, so those scripts
-- keep working unchanged. Left alone on purpose: the wheels, and the title cards in the Titles tab
-- (their fonts and colors are the cosmetic itself).
-- To go back to the old look, disable this script.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- the same neutral stone palette as the Store and Quests menus
local THEME = ColorSequence.new(Color3.fromRGB(232, 226, 214), Color3.fromRGB(150, 142, 130))
local PANEL = Color3.fromRGB(14, 14, 14)
local CARD = Color3.fromRGB(24, 24, 24)
local MUTED = Color3.fromRGB(200, 194, 184)

-- tab button -> the page it shows (the Cosmetics script switches pages by Visible)
local PAGES = { Accessories = "AccessoriesScrollingFrame", Emotes = "EmotesScrollingFrame", Titles = "TitleList", Auras = "AurasScrollingFrame", Finisher = "FinisherScrollingFrame" }

------------------------------------------------------------------------
-- Small helpers
------------------------------------------------------------------------
local function Once(Object: Instance, ClassName: string, Name: string): Instance?
	-- adds a styling child only once, so restyling twice is harmless
	if Object:FindFirstChild(Name) then
		return nil
	end
	local Child = Instance.new(ClassName)
	Child.Name = Name
	return Child
end

local function Round(Object: GuiObject, Radius: number)
	if not Object:FindFirstChildOfClass("UICorner") then
		UI.Corner(Radius).Parent = Object
	end
end

local function Outline(Object: GuiObject, Color: Color3, Thickness: number)
	local Stroke = Once(Object, "UIStroke", "SkinStroke") :: UIStroke?
	if Stroke then
		Stroke.Color = Color
		Stroke.Thickness = Thickness
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Parent = Object
	end
end

-- Text outlines use the built-in text stroke: a button can only show one UIStroke, and the
-- buttons already use theirs for the border.
local function Font(Label: TextLabel | TextButton, Weight: string, Stroked: boolean)
	Label.FontFace = UI.Font(Weight)
	if Stroked then
		Label.TextStrokeColor3 = UI.Colors.Black
		Label.TextStrokeTransparency = 0
	end
end

-- a stone button look on any GuiObject (gradient fill, rounded, dark outline)
local function StoneButton(Button: GuiObject, Radius: number)
	Button.BackgroundColor3 = UI.Colors.White
	Button.BackgroundTransparency = 0
	if Button:IsA("ImageButton") then
		Button.ImageTransparency = 1
	end
	Round(Button, Radius)
	Outline(Button, UI.Colors.Black, 2)
	local Fill = Once(Button, "UIGradient", "SkinGradient") :: UIGradient?
	if Fill then
		Fill.Color = UI.Gradients.Grey
		Fill.Rotation = 90
		Fill.Parent = Button
	end
end

------------------------------------------------------------------------
-- The pieces
------------------------------------------------------------------------
-- An item tile (Accessories / Emotes / Auras / Finishers), made by the Cosmetics script from its
-- Frame template. Only its card and its fonts change.
local function SkinTile(Tile: Instance)
	if not Tile:IsA("Frame") or not Tile:FindFirstChild("Info") then
		return
	end
	Tile.BackgroundColor3 = CARD
	Tile.BackgroundTransparency = 0.15
	Round(Tile, 10)
	local Info = Tile:FindFirstChild("Info")
	if Info and Info:IsA("TextLabel") then
		Font(Info, "Bold", true)
		local Sub = Info:FindFirstChild("Info")
		if Sub and Sub:IsA("TextLabel") then
			Font(Sub, "Medium", true)
		end
	end
end

local function SkinGrid(Scroller: Instance?)
	if not (Scroller and Scroller:IsA("ScrollingFrame")) then
		return
	end
	Scroller.ScrollBarImageColor3 = Color3.fromRGB(176, 170, 160)
	for _, Child in Scroller:GetChildren() do
		SkinTile(Child)
	end
	Scroller.ChildAdded:Connect(function(Child)
		task.defer(SkinTile, Child) -- after the script has filled it in
	end)
end

local function SkinTabs(Main: Frame)
	local Buttons: { [string]: TextButton } = {}
	for Name in PAGES do
		local Tab = Main:FindFirstChild(Name)
		if Tab and Tab:IsA("TextButton") then
			Buttons[Name] = Tab
			StoneButton(Tab, 8)
			Font(Tab, "Bold", true)
		end
	end
	-- the open page's tab lights up in the stone theme, like the Store's tabs
	local function Refresh()
		for Name, Tab in Buttons do
			local Page = Main:FindFirstChild(PAGES[Name])
			local Open = Page ~= nil and (Page :: GuiObject).Visible
			local Fill = Tab:FindFirstChild("SkinGradient") :: UIGradient?
			if Fill then
				Fill.Color = if Open then THEME else UI.Gradients.Grey
			end
		end
	end
	for _, PageName in PAGES do
		local Page = Main:FindFirstChild(PageName)
		if Page and Page:IsA("GuiObject") then
			Page:GetPropertyChangedSignal("Visible"):Connect(Refresh)
		end
	end
	Refresh()
end

local function SkinSpinners(Main: Frame)
	local List = Main:FindFirstChild("SpinList")
	if not List then
		return
	end
	local function SkinSpinner(Spinner: Instance)
		if not Spinner:IsA("Frame") then
			return
		end
		local Button = Spinner:FindFirstChild("Button")
		if Button and Button:IsA("GuiObject") then
			StoneButton(Button, 8)
			local Label = Button:FindFirstChild("TextLabel")
			if Label and Label:IsA("TextLabel") then
				Label.TextColor3 = UI.Colors.White
				Font(Label, "Bold", true)
			end
		end
		local Result = Spinner:FindFirstChild("Frame")
		if Result and Result:IsA("Frame") then
			Result.BackgroundColor3 = PANEL
			Result.BackgroundTransparency = 0.1
			Round(Result, 8)
			Outline(Result, Color3.fromRGB(55, 55, 55), 2)
			local Label = Result:FindFirstChild("TextLabel")
			if Label and Label:IsA("TextLabel") then
				Font(Label, "Bold", true)
			end
		end
		local Title = Spinner:FindFirstChild("Title")
		if Title and Title:IsA("TextLabel") then
			Title.TextColor3 = MUTED
			Font(Title, "Medium", true)
		end
	end
	for _, Spinner in List:GetChildren() do
		SkinSpinner(Spinner)
	end
end

local function SkinMain(Main: Frame)
	-- the panel: the menus' black window with the stone glow edge
	Main.BackgroundColor3 = PANEL
	Main.BackgroundTransparency = 0.08
	Round(Main, 12)
	Outline(Main, UI.Colors.Black, 4)
	local Glow = Once(Main, "Frame", "SkinGlow") :: Frame?
	if Glow then
		Glow.Size = UDim2.fromScale(1, 1)
		Glow.BackgroundTransparency = 1
		Glow.ZIndex = 0
		UI.Corner(12).Parent = Glow
		local Edge = UI.Stroke(UI.Colors.White, 2)
		Edge.Parent = Glow
		UI.New("UIGradient", {
			Color = THEME,
			Rotation = 90,
			Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.6), NumberSequenceKeypoint.new(1, 0) }),
			Parent = Edge,
		})
		Glow.Parent = Main
	end

	SkinTabs(Main)
	for Name, PageName in PAGES do
		if Name ~= "Titles" then
			SkinGrid(Main:FindFirstChild(PageName))
		end
	end

	-- Titles tab: only its backing panel (the cards are the cosmetic)
	local TitleList = Main:FindFirstChild("TitleList")
	local Backing = TitleList and TitleList:FindFirstChild("Background")
	if Backing and Backing:IsA("Frame") then
		Backing.BackgroundColor3 = PANEL
		Backing.BackgroundTransparency = 0.1
		Round(Backing, 10)
	end

	SkinSpinners(Main)

	local Spins = Main:FindFirstChild("Spins")
	local SpinsLabel = Spins and Spins:FindFirstChild("Spins")
	if SpinsLabel and SpinsLabel:IsA("TextLabel") then
		SpinsLabel.TextColor3 = UI.Colors.White
		Font(SpinsLabel, "Bold", true)
	end

	-- "BUY EMOTE SPINS: 1000 GOLD": a dark pill like the Store's price tags
	local Buy = Main:FindFirstChild("BuyEmoteSpins")
	if Buy and Buy:IsA("TextButton") then
		Buy.BackgroundColor3 = PANEL
		Buy.BackgroundTransparency = 0.1
		Round(Buy, 10)
		Outline(Buy, Color3.fromRGB(176, 170, 160), 2)
		Font(Buy, "Bold", true)
		Buy.Text = Buy.Text:gsub('color="rgb%(255, 85, 85%)"', 'color="rgb(255, 210, 60)"') -- gold, not red
	end

	-- bulk spin buttons (1 / 3 / 5 spins and emote spins)
	for _, BulkName in { "EmoteBulk", "AccessoriesBulk" } do
		local Bulk = Main:FindFirstChild(BulkName)
		if Bulk then
			for _, Label in Bulk:GetDescendants() do
				if Label:IsA("TextButton") and Label.Name == "Spin" then
					Font(Label, "Bold", true)
				end
			end
		end
	end
end

local function Skin(Gui: Instance)
	if Gui.Name ~= "Cosmetics" or not Gui:IsA("ScreenGui") then
		return
	end
	local Main = Gui:WaitForChild("Frame", 10)
	if Main and Main:IsA("Frame") then
		SkinMain(Main)
	end
end

-- the Cosmetics gui may be recreated on respawn
for _, Gui in PlayerGui:GetChildren() do
	task.spawn(Skin, Gui)
end
PlayerGui.ChildAdded:Connect(function(Gui)
	task.spawn(Skin, Gui)
end)
