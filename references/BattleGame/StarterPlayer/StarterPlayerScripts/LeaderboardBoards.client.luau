-- Leaderboard boards (client)
-- 1. Each board's "Board" SurfaceGui stays under its Screen part so it can be edited in Studio.
--    At runtime this player gets their own copy in PlayerGui, adorned back onto the same part, and
--    it is filled in locally (that is how the "You" row differs per player).
--    Scrolling needs the Screen part's CanQuery left ON - with it off the board ignores the mouse.
-- 2. The copy is filled from ReplicatedStorage.LeaderboardData, which the server
--    (ServerScriptService.Data.Leaderboards) refreshes every 2 minutes. Nothing from the Studio
--    preview data is shown in game: boards start empty until real data arrives.
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local root = workspace:WaitForChild("World"):WaitForChild("Leaderboards")

local BOARDS = { "AllTimeKills", "MonthlyKills", "AllTimeTopDonators", "MonthlyTopDonators" }
local KILL_BOARDS = { AllTimeKills = "TotalKills", MonthlyKills = "MonthlyKills" } -- board -> attribute for the You row

local guis = {} -- board name -> PlayerGui copy
local lastEntries = {} -- board name -> entries last drawn
local dataFolder

local function fmt(n)
	local s = tostring(math.floor(n or 0))
	local r
	repeat
		s, r = string.gsub(s, "^(-?%d+)(%d%d%d)", "%1,%2")
	until r == 0
	return s
end

local function thumb(kind, id, size)
	return string.format("rbxthumb://type=%s&id=%d&w=%d&h=%d", kind, id, size, size)
end

local function displayName(e)
	return e.d or e.u or "Player"
end

local function escape(s)
	return (string.gsub(string.gsub(string.gsub(s, "&", "&amp;"), "<", "&lt;"), ">", "&gt;"))
end

-- keeps a label's rich-text styling and swaps only the number inside its first <font> tag
local function setAmount(label, value)
	local text, n = string.gsub(label.Text, ">[%d,]+<", ">" .. fmt(value) .. "<", 1)
	label.Text = n > 0 and text or fmt(value)
end

local function read(name)
	local value = dataFolder and dataFolder:FindFirstChild(name)
	if not value or value.Value == "" then
		return nil
	end
	local ok, data = pcall(HttpService.JSONDecode, HttpService, value.Value)
	return ok and data or nil
end

-- Months follow UTC, same as the server and Ranked. Uses server time so a wrong device clock can't skew it.
local function seasonClock()
	local now = math.floor(workspace:GetServerTimeNow())
	local u = DateTime.fromUnixTimestamp(now):ToUniversalTime()
	local year, month = u.Year, u.Month + 1
	if month == 13 then
		year, month = year + 1, 1
	end
	local resetAt = DateTime.fromUniversalTime(year, month, 1).UnixTimestamp
	local label = string.upper(DateTime.fromUniversalTime(u.Year, u.Month, 1):FormatUniversalTime("MMMM YYYY", "en-us"))
	return label, math.max(0, resetAt - now)
end

local function resetText(seconds)
	local d, h, m = seconds // 86400, (seconds % 86400) // 3600, (seconds % 3600) // 60
	if d > 0 then
		return string.format("Resets in %dd %02dh", d, h)
	elseif h > 0 then
		return string.format("Resets in %dh %02dm", h, m)
	end
	return string.format("Resets in %dm", math.max(1, m))
end

-- shows rows 4-100 that have an entry, hides the rest; returns the list's content height
local function fillRows(list, entries, valueLabel)
	local layout = list:FindFirstChildOfClass("UIListLayout")
	local gap = layout and layout.Padding.Offset or 0
	local shown, rowH = 0, 0
	for rank = 4, 100 do
		local row = list:FindFirstChild("Row" .. rank)
		if row then
			local e = entries[rank]
			row.Visible = e ~= nil
			if e then
				shown += 1
				rowH = row.Size.Y.Offset
				row.Rank.Text = "#" .. rank
				row.PlayerName.Text = displayName(e)
				row.Avatar.Image.Image = thumb("AvatarHeadShot", e.id, 150)
				if valueLabel == "Amount" then
					setAmount(row.Amount, e.v)
				else
					row[valueLabel].Text = fmt(e.v)
				end
			end
		end
	end
	return shown > 0 and (shown * (rowH + gap) - gap) or 0
end

local function renderYou(name)
	local gui = guis[name]
	if not gui then
		return
	end
	local you = gui.Panel.You
	local myRank
	for i, e in lastEntries[name] or {} do
		if e.id == player.UserId then
			myRank = i
			break
		end
	end
	local value = player:GetAttribute(KILL_BOARDS[name]) or 0
	you.Rank.Text = myRank and ("#" .. myRank) or (value > 0 and "100+" or "-")
	you.Kills.Text = fmt(value)
	you.Avatar.Image.Image = thumb("AvatarHeadShot", player.UserId, 150)
end

local function renderKills(name)
	local gui = guis[name]
	local entries = read(name) or {}
	lastEntries[name] = entries
	local scroll = gui.Panel.Scroll
	for rank = 1, 3 do
		local paper = scroll.Posters["Poster" .. rank].Paper
		local e = entries[rank]
		paper.Photo.Avatar.Image = e and thumb("Avatar", e.id, 420) or ""
		paper.PlayerName.Text = e and string.upper(displayName(e)) or "UNCLAIMED"
		paper.Bounty.Text = "฿" .. fmt(e and e.v or 0) .. "-"
	end
	local list = scroll.List
	local height = fillRows(list, entries, "Kills")
	scroll.CanvasSize = UDim2.fromOffset(0, list.Position.Y.Offset + height + 16)
	renderYou(name)
end

local function renderDonors(name)
	local gui = guis[name]
	local entries = read(name) or {}
	lastEntries[name] = entries
	local panel = gui.Panel
	for rank = 1, 3 do
		local card = panel:FindFirstChild("Rank" .. rank)
		if card then
			local e = entries[rank]
			card.Avatar.Image.Image = e and thumb(rank == 1 and "AvatarBust" or "AvatarHeadShot", e.id, 420) or ""
			card.PlayerName.Text = e and displayName(e) or "No one yet"
			local username = card:FindFirstChild("Username")
			if username then
				username.Text = (e and e.u) and ("@" .. e.u) or ""
			end
			setAmount(card.Amount, e and e.v or 0)
		end
	end
	panel.List.CanvasSize = UDim2.fromOffset(0, fillRows(panel.List, entries, "Amount"))
end

local function renderSeason()
	local label, secondsLeft = seasonClock()
	local monthlyKills = guis.MonthlyKills
	if monthlyKills then
		local bar = monthlyKills.Panel.SeasonBar
		bar.Season.Text = label .. " SEASON"
		bar.Reset.Text = resetText(secondsLeft)
		local meta = read("Meta")
		local champ = meta and meta.champion
		bar.Champion.Text = champ
				and string.format(
					'%s champion: <font color="#F1E6CC"><b>%s</b></font> · %s kills',
					champ.month,
					escape(displayName(champ)),
					fmt(champ.v)
				)
			or "First season: no champion yet"
	end
	local monthlyDonors = guis.MonthlyTopDonators
	if monthlyDonors then
		monthlyDonors.Panel.Reset.Text = resetText(secondsLeft)
	end
end

local function render(name)
	if not guis[name] then
		return
	end
	if KILL_BOARDS[name] then
		renderKills(name)
	else
		renderDonors(name)
	end
	if name == "MonthlyKills" or name == "MonthlyTopDonators" then
		renderSeason()
	end
end

for _, name in BOARDS do
	task.spawn(function()
		local screen = root:WaitForChild(name):WaitForChild("Screen")
		local template = screen:WaitForChild("Board")
		local gui = template:Clone()
		template:Destroy() -- local only: stops the world copy drawing underneath this one
		gui.Name = name .. "Board"
		gui.Adornee = screen
		gui.ResetOnSpawn = false
		gui.Parent = playerGui
		guis[name] = gui
		render(name) -- empty until the server's data arrives, so preview data never shows
	end)
end

task.spawn(function()
	dataFolder = ReplicatedStorage:WaitForChild("LeaderboardData")
	local function hook(value)
		if not value:IsA("StringValue") then
			return
		end
		local function update()
			if value.Name == "Meta" then
				renderSeason()
			else
				render(value.Name)
			end
		end
		value.Changed:Connect(update)
		update()
	end
	for _, value in dataFolder:GetChildren() do
		hook(value)
	end
	dataFolder.ChildAdded:Connect(hook)
end)

-- your own kills update the You row live, between board refreshes
for name, attribute in KILL_BOARDS do
	player:GetAttributeChangedSignal(attribute):Connect(function()
		renderYou(name)
	end)
end

-- keep the reset countdown ticking
task.spawn(function()
	while true do
		task.wait(20)
		renderSeason()
	end
end)

-- A board only takes mouse input while you're close enough to use it, so far-away boards don't
-- listen to the mouse for nothing. It switches back on as you walk up, so scrolling and the
-- Donate buttons still work.
local MOUSE_RANGE = 100 -- studs from the camera
local function setInRange(gui, part, cameraPosition)
	if part and part:IsA("BasePart") then
		gui.Active = (part.Position - cameraPosition).Magnitude <= MOUSE_RANGE
	else
		gui.Active = false
	end
end
task.spawn(function()
	while true do
		local cameraPosition = workspace.CurrentCamera.CFrame.Position
		for _, gui in guis do
			setInRange(gui, gui.Adornee, cameraPosition)
		end
		local donate = root:FindFirstChild("Donate")
		local donateScreen = donate and donate:FindFirstChild("Screen")
		local donateUI = donateScreen and donateScreen:FindFirstChild("UI")
		if donateUI then
			setInRange(donateUI, donateScreen, cameraPosition)
		end
		task.wait(0.5)
	end
end)
