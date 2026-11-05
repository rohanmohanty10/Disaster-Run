--!strict
-- Lobby menus built in code (GAME_PLAN.md Section 3): level / XP bar, daily login reward,
-- daily quests and the rotating Divine Shard shop. Everything is a request to the server
-- (QuestService, ShopService); this only shows data and sends clicks.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local DailyConfig = require(ReplicatedStorage.Shared.Config.DailyConfig)
local ProgressionConfig = require(ReplicatedStorage.Shared.Config.ProgressionConfig)
local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)
local ProgressionMath = require(ReplicatedStorage.Shared.Util.ProgressionMath)
local ShardShop = require(ReplicatedStorage.Shared.Gacha.ShardShop)

local Make = require(script.Parent.Make)
local Net = require(script.Parent.Net)
local DataController = require(script.Parent.DataController)
local UIController = require(script.Parent.UIController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
local Theme = Make.Theme

local MenuController = {}

local gui: ScreenGui
local ui: { [string]: any } = {}
local openPanel: string? = nil
local shopRole: Kits.Role = "God"
local dailyPromptShown = false

local ERROR_COLOR = Color3.fromRGB(255, 120, 120)

local function serverNow(): number
	return workspace:GetServerTimeNow()
end

local function today(): number
	return ProgressionMath.Day(serverNow())
end

local function data(): { [string]: any }?
	return DataController.Data
end

-- "+$500 · +1 Spin" from a reward table.
local function describe(reward: DailyConfig.Reward): string
	local parts = {}
	if reward.Cash then
		table.insert(parts, `${reward.Cash}`)
	end
	if reward.Spins then
		table.insert(parts, `{reward.Spins} Spin{if reward.Spins == 1 then "" else "s"}`)
	end
	if reward.LuckySpins then
		table.insert(parts, `{reward.LuckySpins} Lucky`)
	end
	if reward.BoostedSpins then
		table.insert(parts, `{reward.BoostedSpins} Boosted`)
	end
	if reward.XP then
		table.insert(parts, `{reward.XP} XP`)
	end
	return table.concat(parts, " · ")
end

local function questDef(id: string): DailyConfig.QuestDef?
	for _, quest in DailyConfig.Quests do
		if quest.Id == id then
			return quest
		end
	end
	return nil
end

local function dailyClaimable(d: { [string]: any }): boolean
	local _, canClaim = ProgressionMath.ClaimStreak(d.Daily.LastClaimDay, d.Daily.Streak, today())
	return canClaim
end

local function questsClaimable(d: { [string]: any }): boolean
	if d.Quests.Day ~= today() then
		return false
	end
	for _, entry in d.Quests.List do
		local quest = questDef(entry.Id)
		if quest and not entry.Claimed and entry.Progress >= quest.Goal then
			return true
		end
	end
	return false
end

local function button(props: { [string]: any }, color: Color3?): TextButton
	local merged = {
		BackgroundColor3 = color or Theme.SlateLight,
		TextColor3 = Theme.Text,
		FontFace = Theme.Font,
		TextScaled = true,
		AutoButtonColor = true,
	}
	for key, value in props do
		merged[key] = value
	end
	local b = Make.new("TextButton", merged, { Make.new("UICorner", { CornerRadius = UDim.new(0, 8) }), Make.new("UIPadding", { PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6), PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4) }) })
	UIController.AnimateButton(b)
	return b
end

local function clear(frame: Instance)
	-- Everything, layouts included: each render adds its own UIListLayout.
	for _, child in frame:GetChildren() do
		child:Destroy()
	end
end

-- ------------------------------------------------------------------ panels
local function newPanel(name: string, title: string, accent: Color3): (Frame, Frame)
	local panel = Make.Panel({ Name = name, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromOffset(620, 420), Visible = false, BackgroundTransparency = 0.05, Parent = gui }, accent)
	Make.Label({ Position = UDim2.fromOffset(16, 10), Size = UDim2.new(1, -120, 0, 34), TextXAlignment = Enum.TextXAlignment.Left, FontFace = Theme.FontHeavy, TextColor3 = accent, Text = title, Parent = panel })
	local close = button({ Text = "X", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromOffset(36, 36), Parent = panel })
	close.Activated:Connect(function()
		MenuController.Close()
	end)
	local body = Make.new("Frame", { Name = "Body", BackgroundTransparency = 1, Position = UDim2.fromOffset(16, 56), Size = UDim2.new(1, -32, 1, -72), Parent = panel })
	return panel, body
end

local function renderDaily()
	local d = data()
	local body: Frame = ui.DailyBody
	clear(body)
	if not d then
		return
	end
	local claimable = dailyClaimable(d)
	local nextStreak = ProgressionMath.ClaimStreak(d.Daily.LastClaimDay, d.Daily.Streak, today())
	local currentIndex = ProgressionMath.StreakIndex(if claimable then nextStreak else d.Daily.Streak, #DailyConfig.Rewards)
	local row = Make.new("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 170), Parent = body }, {
		Make.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 6) }),
	})
	for i, reward in DailyConfig.Rewards do
		local isToday = i == currentIndex
		local done = i < currentIndex or (i == currentIndex and not claimable)
		local card = Make.Panel({ Size = UDim2.new(1 / #DailyConfig.Rewards, -6, 1, 0), LayoutOrder = i, Parent = row }, if isToday then Theme.Gold else Theme.SlateLight)
		Make.Label({ Position = UDim2.fromScale(0.05, 0.05), Size = UDim2.fromScale(0.9, 0.18), Text = `DAY {i}`, TextColor3 = if isToday then Theme.Gold else Theme.SubText, Parent = card })
		Make.Label({ Position = UDim2.fromScale(0.05, 0.3), Size = UDim2.fromScale(0.9, 0.5), TextWrapped = true, Text = describe(reward), Parent = card })
		if done then
			Make.Label({ Position = UDim2.fromScale(0.05, 0.8), Size = UDim2.fromScale(0.9, 0.16), Text = "✓", TextColor3 = Theme.Green, Parent = card })
		end
	end
	Make.Label({ Position = UDim2.fromOffset(0, 182), Size = UDim2.new(1, 0, 0, 22), TextColor3 = Theme.SubText, Text = `Every claim also gives {DailyConfig.BoostedSpinsPerClaim} Boosted Spins (doubled high-tier odds) in both vaults. Streak: {d.Daily.Streak} day(s).`, Parent = body })
	local claim = button({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 220), Size = UDim2.fromOffset(220, 50), Text = if claimable then "CLAIM" else "COME BACK TOMORROW", Parent = body }, if claimable then Color3.fromRGB(34, 140, 80) else Theme.SlateLight)
	claim.Activated:Connect(function()
		if not claimable then
			return
		end
		local result = Net.Request("ClaimDaily")
		if result.Ok then
			UIController.PlaySound("Reveal")
			UIController.Popup(`Day {result.Streak} reward: {result.Text}`, 3, Theme.Gold)
		elseif result.Message then
			UIController.Popup(result.Message, 2, ERROR_COLOR)
		end
	end)
end

local function renderQuests()
	local d = data()
	local body: Frame = ui.QuestsBody
	clear(body)
	if not d then
		return
	end
	Make.new("UIListLayout", { Padding = UDim.new(0, 10), Parent = body })
	if d.Quests.Day ~= today() then
		Make.Label({ Size = UDim2.new(1, 0, 0, 30), TextColor3 = Theme.SubText, Text = "New quests are on their way...", Parent = body })
		-- Saved quests are from an earlier day: ask the server to roll today's (the data update
		-- re-renders this panel).
		if not ui.QuestRefreshPending then
			ui.QuestRefreshPending = true
			task.spawn(function()
				Net.Request("RefreshQuests")
				ui.QuestRefreshPending = nil
			end)
		end
		return
	end
	for index, entry in d.Quests.List do
		local quest = questDef(entry.Id)
		if quest then
			local done = entry.Progress >= quest.Goal
			local card = Make.Panel({ Size = UDim2.new(1, 0, 0, 86), LayoutOrder = index, Parent = body }, if entry.Claimed then Theme.SlateLight elseif done then Theme.Green else Theme.Cyan)
			Make.Label({ Position = UDim2.fromOffset(12, 8), Size = UDim2.new(0.7, -12, 0, 26), TextXAlignment = Enum.TextXAlignment.Left, Text = (string.gsub(quest.Text, "{goal}", tostring(quest.Goal))), Parent = card })
			Make.Label({ Position = UDim2.fromOffset(12, 38), Size = UDim2.new(0.7, -12, 0, 18), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Theme.Gold, Text = describe(quest.Reward), Parent = card })
			local _, fill = Make.Bar({ Position = UDim2.fromOffset(12, 64), Size = UDim2.new(0.7, -12, 0, 10), Parent = card }, if done then Theme.Green else Theme.Cyan)
			fill.Size = UDim2.fromScale(math.clamp(entry.Progress / quest.Goal, 0, 1), 1)
			local label = if entry.Claimed then "CLAIMED" elseif done then "CLAIM" else `{math.floor(entry.Progress)}/{quest.Goal}`
			local claim = button({ AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), Size = UDim2.new(0.25, 0, 0, 44), Text = label, Parent = card }, if done and not entry.Claimed then Color3.fromRGB(34, 140, 80) else Theme.SlateLight)
			claim.Activated:Connect(function()
				if entry.Claimed or not done then
					return
				end
				local result = Net.Request("ClaimQuest", index)
				if result.Ok then
					UIController.PlaySound("Reveal")
					UIController.Popup(`Quest reward: {result.Text}`, 3, Theme.Gold)
				elseif result.Message then
					UIController.Popup(result.Message, 2, ERROR_COLOR)
				end
			end)
		end
	end
	Make.Label({ Size = UDim2.new(1, 0, 0, 20), LayoutOrder = 100, TextColor3 = Theme.SubText, Text = "New quests every day (UTC midnight).", Parent = body })
end

local function renderShop()
	local d = data()
	local body: Frame = ui.ShopBody
	clear(body)
	if not d then
		return
	end
	local now = serverNow()
	local left = math.max(ShardShop.EndsAt(now) - now, 0)
	Make.Label({ Position = UDim2.fromOffset(0, 0), Size = UDim2.new(0.5, 0, 0, 24), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Theme.Purple, Text = `✦ {d.DivineShards} Divine Shards`, Parent = body })
	ui.ShopTimer = Make.Label({ Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0.5, 0, 0, 24), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = Theme.SubText, Text = `New offers in {math.floor(left / 3600)}h {math.floor(left % 3600 / 60)}m`, Parent = body })
	for i, role in Kits.Roles do
		local tab = button({ Position = UDim2.new((i - 1) * 0.5, if i == 1 then 0 else 4, 0, 32), Size = UDim2.new(0.5, -4, 0, 34), Text = `{string.upper(role)} KITS`, Parent = body }, if role == shopRole then Theme.Cyan else Theme.SlateLight)
		tab.Activated:Connect(function()
			shopRole = role :: Kits.Role
			renderShop()
		end)
	end
	local grid = Make.new("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(0, 76), Size = UDim2.new(1, 0, 1, -76), Parent = body }, {
		Make.new("UIGridLayout", { CellSize = UDim2.new(0.5, -6, 0.5, -6), CellPadding = UDim2.fromOffset(12, 12) }),
	})
	local roleData = d[shopRole]
	for _, kitId in ShardShop.Offers(shopRole, ShardShop.Rotation(now)) do
		local kit = Kits.Get(shopRole, kitId)
		local price = ShardShop.Price(shopRole, kitId)
		if kit and price then
			local owned = ShardShop.Owns(roleData, kitId)
			local color = Rarities.Colors[kit.Rarity] or Theme.Text
			local card = Make.Panel({ Parent = grid }, color)
			Make.Label({ Position = UDim2.fromScale(0.05, 0.06), Size = UDim2.fromScale(0.9, 0.24), Text = string.upper(kit.Name), TextColor3 = color, Parent = card })
			Make.Label({ Position = UDim2.fromScale(0.05, 0.32), Size = UDim2.fromScale(0.9, 0.16), Text = kit.Rarity, TextColor3 = Theme.SubText, Parent = card })
			local buy = button({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 0.93), Size = UDim2.fromScale(0.8, 0.34), Text = if owned then "OWNED" else `✦ {price}`, Parent = card }, if owned then Theme.SlateLight elseif d.DivineShards >= price then Color3.fromRGB(110, 70, 200) else Theme.SlateLight)
			buy.Activated:Connect(function()
				if owned then
					return
				end
				local result = Net.Request("ShopBuy", shopRole, kitId)
				if result.Ok then
					UIController.PlaySound("Reveal")
					UIController.Popup(`{kit.Name} added ({result.Where})!`, 3, color)
				elseif result.Message then
					UIController.Popup(result.Message, 2.5, ERROR_COLOR)
				end
			end)
		end
	end
end

local RENDER: { [string]: () -> () } = {
	Daily = renderDaily,
	Quests = renderQuests,
	Shop = renderShop,
}

function MenuController.Open(name: string)
	if openPanel == name then
		MenuController.Close()
		return
	end
	UIController.CloseAll()
	MenuController.Close()
	openPanel = name
	ui[name].Visible = true
	RENDER[name]()
end

function MenuController.Close()
	if openPanel then
		ui[openPanel].Visible = false
	end
	openPanel = nil
end

-- ------------------------------------------------------------------ level bar + buttons
local function refreshLevel()
	local d = data()
	if not d then
		return
	end
	local need = ProgressionMath.XPToNext(d.Level, ProgressionConfig.XPCurve)
	local maxed = d.Level >= ProgressionConfig.MaxLevel
	ui.LevelText.Text = `Lv {d.Level}`
	ui.XPFill.Size = UDim2.fromScale(if maxed then 1 else math.clamp(d.XP / need, 0, 1), 1)
	ui.XPText.Text = if maxed then "MAX" else `{math.floor(d.XP)} / {need} XP`
	ui.DailyAlert.Visible = dailyClaimable(d)
	ui.QuestsAlert.Visible = questsClaimable(d)
end

local function buildSide()
	local level = Make.Panel({ Name = "Level", Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(240, 46), Parent = gui }, Theme.Cyan)
	ui.LevelText = Make.Label({ Position = UDim2.fromOffset(8, 4), Size = UDim2.fromOffset(70, 38), FontFace = Theme.FontHeavy, TextColor3 = Theme.Cyan, Text = "Lv 1", Parent = level })
	local _, fill = Make.Bar({ Position = UDim2.fromOffset(84, 10), Size = UDim2.new(1, -96, 0, 12), Parent = level }, Theme.Cyan)
	ui.XPFill = fill
	ui.XPText = Make.Label({ Position = UDim2.fromOffset(84, 25), Size = UDim2.new(1, -96, 0, 16), TextColor3 = Theme.SubText, Text = "", Parent = level })

	local column = Make.new("Frame", { Name = "MenuButtons", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 12, 0.5, 0), Size = UDim2.fromOffset(120, 200), Parent = gui }, {
		Make.new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
	})
	local entries: { { Name: string, Text: string, Color: Color3 } } = {
		{ Name = "Daily", Text = "DAILY", Color = Theme.Gold },
		{ Name = "Quests", Text = "QUESTS", Color = Theme.Green },
		{ Name = "Shop", Text = "SHARD SHOP", Color = Theme.Purple },
	}
	for order, entry in entries do
		local name, text, color = entry.Name, entry.Text, entry.Color
		local b = button({ Name = name, LayoutOrder = order, Size = UDim2.fromOffset(120, 50), Text = text, Parent = column }, Theme.Slate)
		Make.new("UIStroke", { Color = color, Thickness = 2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = b })
		local alert = Make.new("Frame", { Name = "Alert", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(1, 0), Size = UDim2.fromOffset(16, 16), BackgroundColor3 = Theme.Red, Visible = false, Parent = b }, {
			Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})
		ui[`{name}Alert`] = alert
		b.Activated:Connect(function()
			MenuController.Open(name)
		end)
	end
end

function MenuController.Init()
	gui = Make.new("ScreenGui", { Name = "Menus", ResetOnSpawn = false, DisplayOrder = 8, Parent = PlayerGui })
	buildSide()
	local daily, dailyBody = newPanel("Daily", "DAILY REWARD", Theme.Gold)
	ui.Daily, ui.DailyBody = daily, dailyBody
	local quests, questsBody = newPanel("Quests", "DAILY QUESTS", Theme.Green)
	ui.Quests, ui.QuestsBody = quests, questsBody
	local shop, shopBody = newPanel("Shop", "DIVINE SHARD SHOP", Theme.Purple)
	ui.Shop, ui.ShopBody = shop, shopBody
	for name in RENDER do
		UIController.RegisterScreen(`Menu{name}`, {
			Open = function()
				MenuController.Open(name)
			end,
			Close = function()
				if openPanel == name then
					MenuController.Close()
				end
			end,
			IsOpen = function()
				return openPanel == name
			end,
		})
	end
end

function MenuController.Start()
	DataController.Wait()
	refreshLevel()
	DataController.Changed:Connect(function()
		refreshLevel()
		if openPanel then
			RENDER[openPanel]()
		end
	end)
	-- Only in the lobby: hidden during matches and while a vault screen is open.
	local hud = UIController.GetHUD()
	local timer = 0
	RunService.Heartbeat:Connect(function(dt)
		local show = hud.Enabled and ReplicatedStorage:GetAttribute("MatchActive") ~= true
		if gui.Enabled ~= show then
			gui.Enabled = show
			if not show then
				MenuController.Close()
			end
		end
		timer += dt
		if timer >= 30 then
			timer = 0
			refreshLevel() -- day rollover lights the alerts
		end
	end)
	-- Offer the daily reward once per session.
	task.delay(4, function()
		local d = data()
		if d and not dailyPromptShown and dailyClaimable(d) and gui.Enabled then
			dailyPromptShown = true
			MenuController.Open("Daily")
		end
	end)
end

return MenuController
