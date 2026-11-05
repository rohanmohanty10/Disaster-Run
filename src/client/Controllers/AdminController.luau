--!strict
-- Admin panel (F2 or the ADMIN button; only shown to admins — the server re-checks every request).
--   GOD KITS / RUNNER KITS: equip any kit instantly. Completed kits are listed first and marked.
--   TOOLS: the dev test area (try kits as Runner or God with no match), spins, Cash, start a
--          test match as Runner or God, end the round, dummies, hitboxes.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local AdminConfig = require(ReplicatedStorage.Shared.Config.AdminConfig)
local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local RoundConfig = require(ReplicatedStorage.Shared.Config.RoundConfig)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)

local Make = require(script.Parent.Make)
local Net = require(script.Parent.Net)
local UIController = require(script.Parent.UIController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
local Theme = Make.Theme

local AdminController = {}

local gui: ScreenGui
local panel: Frame
local content: ScrollingFrame
local toggleButton: TextButton
local currentTab = "God"
local tabButtons: { [string]: TextButton } = {}

local function isAdmin(): boolean
	return LocalPlayer:GetAttribute("IsAdmin") == true
end

local function report(result: { [string]: any })
	local message = result.Message or (if result.Ok then "Done." else "Failed.")
	UIController.Popup(tostring(message), 2, if result.Ok then Color3.fromRGB(120, 255, 160) else Color3.fromRGB(255, 120, 120))
end

local function button(parent: Instance, text: string, color: Color3?, onClick: () -> ()): TextButton
	local b = Make.new("TextButton", {
		Text = text,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = color or Theme.SlateLight,
		TextColor3 = Theme.Text,
		FontFace = Theme.Font,
		TextScaled = true,
		AutoButtonColor = true,
		Parent = parent,
	}, {
		Make.new("UICorner", { CornerRadius = UDim.new(0, 8) }),
		Make.new("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6) }),
	})
	b.Activated:Connect(onClick)
	return b
end

local function clearContent()
	for _, child in content:GetChildren() do
		if child:IsA("GuiObject") then
			child:Destroy()
		end
	end
end

-- Completed kits first, then by rarity (high to low), then display order.
local function sortedKits(role: Kits.Role): { Kits.Kit }
	local completed = AdminConfig.CompletedKits[role] or {}
	local list: { Kits.Kit } = {}
	for _, id in Kits.Order[role] do
		local kit = Kits.Get(role, id)
		if kit then
			table.insert(list, kit)
		end
	end
	local order: { [string]: number } = {}
	for i, id in Kits.Order[role] do
		order[id] = i
	end
	table.sort(list, function(a, b)
		local ca, cb = table.find(completed, a.Id) ~= nil, table.find(completed, b.Id) ~= nil
		if ca ~= cb then
			return ca
		end
		local ra, rb = Rarities.Rank[a.Rarity] or 0, Rarities.Rank[b.Rarity] or 0
		if ra ~= rb then
			return ra > rb
		end
		return order[a.Id] < order[b.Id]
	end)
	return list
end

local function showKits(role: Kits.Role)
	clearContent()
	local completed = AdminConfig.CompletedKits[role] or {}
	local equipped = LocalPlayer:GetAttribute(`Equipped{role}Kit`)
	for index, kit in sortedKits(role) do
		local isDone = table.find(completed, kit.Id) ~= nil
		local row = Make.new("TextButton", {
			Text = "",
			LayoutOrder = index,
			Size = UDim2.new(1, 0, 0, 46),
			BackgroundColor3 = Theme.SlateLight,
			AutoButtonColor = true,
			Parent = content,
		}, {
			Make.new("UICorner", { CornerRadius = UDim.new(0, 8) }),
			Make.new("UIStroke", { Color = Rarities.Colors[kit.Rarity] or Theme.Cyan, Thickness = if equipped == kit.Id then 2.5 else 1, Transparency = if equipped == kit.Id then 0 else 0.4 }),
		})
		Make.new("Frame", { BackgroundColor3 = Rarities.Colors[kit.Rarity] or Theme.Cyan, BorderSizePixel = 0, Size = UDim2.new(0, 6, 1, -12), Position = UDim2.fromOffset(6, 6), Parent = row }, {
			Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})
		Make.Label({ Position = UDim2.fromOffset(20, 4), Size = UDim2.new(0.55, -20, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, Text = kit.Name, Parent = row })
		Make.Label({ Position = UDim2.fromOffset(20, 26), Size = UDim2.new(0.55, -20, 0, 16), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Rarities.Colors[kit.Rarity] or Theme.SubText, Text = `{kit.Rarity} · {#kit.Skills} skills`, Parent = row })
		local tags = {}
		if isDone then
			table.insert(tags, "✨ COMPLETE")
		end
		if equipped == kit.Id then
			table.insert(tags, "EQUIPPED")
		end
		Make.Label({ AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.new(0.42, 0, 0, 20), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = if isDone then Theme.Gold else Theme.Green, Text = table.concat(tags, " · "), Parent = row })
		row.Activated:Connect(function()
			local result = Net.Request("AdminEquipKit", role, kit.Id)
			report(result)
			task.wait(0.3)
			if currentTab == role then
				showKits(role)
			end
		end)
	end
end

local function command(text: string)
	report(Net.Request("AdminCommand", text))
end

local function showTools()
	clearContent()
	local function header(text: string)
		Make.Label({ Size = UDim2.new(1, 0, 0, 22), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Theme.Gold, Text = text, Parent = content })
	end
	local inside = LocalPlayer:GetAttribute("InTestArea") == true
	header(if inside then `TEST AREA (you're a {LocalPlayer:GetAttribute("Role") or "?"})` else "TEST AREA (no match needed)")
	button(content, "Test as Runner", Color3.fromRGB(30, 90, 60), function()
		command("area runner")
	end)
	button(content, "Test as God (test area)", Color3.fromRGB(90, 40, 90), function()
		command("area god")
	end)
	button(content, "Test as God over the course", Color3.fromRGB(90, 40, 90), function()
		command("area god course")
	end)
	if inside then
		button(content, `No cooldowns: {if LocalPlayer:GetAttribute("TestNoCooldowns") then "ON" else "OFF"}`, nil, function()
			command("area cooldowns")
		end)
		button(content, `Moving dummies: {if workspace:GetAttribute("TestDummiesMove") then "ON" else "OFF"}`, nil, function()
			command("area move")
		end)
		button(content, "Reset cover + dummies", nil, function()
			command("area reset")
		end)
		button(content, "Heal me", nil, function()
			command("me heal")
		end)
		button(content, "Leave test area", Color3.fromRGB(110, 40, 40), function()
			command("area leave")
		end)
	end
	header("SPINS & CASH")
	button(content, "+10 God Spins", nil, function()
		report(Net.Request("AdminGiveSpins", "God", "Normal", 10))
	end)
	button(content, "+10 God Lucky Spins", nil, function()
		report(Net.Request("AdminGiveSpins", "God", "Lucky", 10))
	end)
	button(content, "+10 Runner Spins", nil, function()
		report(Net.Request("AdminGiveSpins", "Runner", "Normal", 10))
	end)
	button(content, "+10 Runner Lucky Spins", nil, function()
		report(Net.Request("AdminGiveSpins", "Runner", "Lucky", 10))
	end)
	button(content, "+$10,000 Cash", nil, function()
		report(Net.Request("AdminGiveCash", 10000))
	end)
	header("MATCH")
	if game:GetService("RunService"):IsStudio() then
		local override = ReplicatedStorage:GetAttribute("AutoStartMatches")
		local autoOn = if override ~= nil then override == true else RoundConfig.StudioAutoStart
		button(content, `Auto-start matches in Studio: {if autoOn then "ON" else "OFF (press Start match)"}`, nil, function()
			command("round auto")
			task.wait(0.2)
			if currentTab == "Tools" then
				showTools()
			end
		end)
	end
	button(content, "Start match as Runner", Color3.fromRGB(30, 90, 60), function()
		command("round runner")
		command("round start")
	end)
	button(content, "Start match as God", Color3.fromRGB(90, 40, 90), function()
		command("round god")
		command("round start")
	end)
	button(content, "End round / match", Color3.fromRGB(110, 40, 40), function()
		command("round end")
	end)
	header("LOBBY TESTING")
	button(content, "Use Runner skills in lobby", nil, function()
		command("role runner")
	end)
	button(content, "Clear lobby role", nil, function()
		command("role none")
	end)
	button(content, "Respawn test dummies", nil, function()
		command("dummies")
	end)
	button(content, "Toggle hitbox visuals", nil, function()
		command("hitboxes")
	end)
	button(content, "Heal me", nil, function()
		command("me heal")
	end)
end

local function selectTab(tab: string)
	currentTab = tab
	for name, b in tabButtons do
		b.BackgroundColor3 = if name == tab then Theme.Cyan else Theme.SlateLight
		b.TextColor3 = if name == tab then Theme.Slate else Theme.Text
	end
	if tab == "Tools" then
		showTools()
	else
		showKits(tab :: Kits.Role)
	end
end

local function setOpen(open: boolean)
	panel.Visible = open and isAdmin()
	if panel.Visible then
		selectTab(currentTab)
	end
end

local function build()
	gui = Make.new("ScreenGui", { Name = "AdminPanel", ResetOnSpawn = false, DisplayOrder = 90, Enabled = false, Parent = PlayerGui })
	toggleButton = Make.new("TextButton", {
		Text = "ADMIN",
		Position = UDim2.fromOffset(12, 12),
		Size = UDim2.fromOffset(80, 30),
		BackgroundColor3 = Theme.Slate,
		TextColor3 = Theme.Gold,
		FontFace = Theme.FontHeavy,
		TextScaled = true,
		Parent = gui,
	}, {
		Make.new("UICorner", { CornerRadius = UDim.new(0, 8) }),
		Make.new("UIStroke", { Color = Theme.Gold, Thickness = 1.5 }),
		Make.new("UIPadding", { PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 5) }),
	})
	toggleButton.Activated:Connect(function()
		setOpen(not panel.Visible)
	end)

	panel = Make.Panel({
		Name = "Panel",
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.fromOffset(12, 50),
		Size = UDim2.new(0, 360, 0.75, 0),
		Visible = false,
		Parent = gui,
	}, Theme.Gold)
	Make.Label({ Position = UDim2.fromOffset(12, 8), Size = UDim2.new(1, -60, 0, 24), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Theme.Gold, Text = `ADMIN PANEL  ({AdminConfig.ToggleKey.Name})`, Parent = panel })
	local close = Make.new("TextButton", { Text = "✕", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 6), Size = UDim2.fromOffset(28, 28), BackgroundTransparency = 1, TextColor3 = Theme.Text, FontFace = Theme.FontHeavy, TextScaled = true, Parent = panel })
	close.Activated:Connect(function()
		setOpen(false)
	end)

	local tabs = Make.new("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(12, 40), Size = UDim2.new(1, -24, 0, 32), Parent = panel }, {
		Make.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6) }),
	})
	for _, info in { { "God", "GOD KITS" }, { "Runner", "RUNNER KITS" }, { "Tools", "TOOLS" } } do
		local b = Make.new("TextButton", {
			Text = info[2],
			Size = UDim2.new(1 / 3, -4, 1, 0),
			BackgroundColor3 = Theme.SlateLight,
			TextColor3 = Theme.Text,
			FontFace = Theme.Font,
			TextScaled = true,
			Parent = tabs,
		}, {
			Make.new("UICorner", { CornerRadius = UDim.new(0, 8) }),
			Make.new("UIPadding", { PaddingTop = UDim.new(0, 7), PaddingBottom = UDim.new(0, 7) }),
		})
		tabButtons[info[1]] = b
		b.Activated:Connect(function()
			selectTab(info[1])
		end)
	end

	content = Make.new("ScrollingFrame", {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(12, 82),
		Size = UDim2.new(1, -24, 1, -94),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollBarThickness = 6,
		Parent = panel,
	}, {
		Make.new("UIListLayout", { Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }),
		Make.new("UIPadding", { PaddingRight = UDim.new(0, 8) }),
	})
end

local function refreshAccess()
	gui.Enabled = isAdmin()
	if not isAdmin() then
		panel.Visible = false
	end
end

function AdminController.Init()
	build()
end

function AdminController.Start()
	refreshAccess()
	LocalPlayer:GetAttributeChangedSignal("IsAdmin"):Connect(refreshAccess)
	-- Keep the TOOLS tab's test-area buttons in step (role, no-cooldowns, moving dummies).
	local function refreshTools()
		if panel.Visible and currentTab == "Tools" then
			showTools()
		end
	end
	for _, name in { "InTestArea", "Role", "TestNoCooldowns", "TestAreaSpot" } do
		LocalPlayer:GetAttributeChangedSignal(name):Connect(refreshTools)
	end
	workspace:GetAttributeChangedSignal("TestDummiesMove"):Connect(refreshTools)
	for _, role in Kits.Roles do
		LocalPlayer:GetAttributeChangedSignal(`Equipped{role}Kit`):Connect(function()
			if panel.Visible and currentTab == role then
				showKits(role)
			end
		end)
	end
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == AdminConfig.ToggleKey then
			setOpen(not panel.Visible)
		end
	end)
end

return AdminController
