-- Arena HUD: team lives, phase timer, select camera, kill feed, AFK warning and results.
-- Does nothing in Demon Fruits. Reads replicated workspace attributes written by ArenaMatch
-- (ArenaPhase, ArenaPhaseEnds, ArenaRoster, ArenaQueue, ArenaCamera) plus the MatchState remote.
-- The UI is built here in code so the main game's StarterGui stays untouched; restyle freely.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local Ranked = ReplicatedStorage:WaitForChild("Ranked")
local PlaceRole = require(Ranked:WaitForChild("PlaceRole"))
if not PlaceRole.IsArena() then
	return
end
local MatchState = Ranked:WaitForChild("Remotes"):WaitForChild("MatchState")

local player = Players.LocalPlayer

-- no resetting in a match (it would cost a life)
task.spawn(function()
	for _ = 1, 30 do
		if pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", false) then
			break
		end
		task.wait(0.5)
	end
end)

local TEAM_COLORS = { Color3.fromRGB(80, 150, 255), Color3.fromRGB(255, 90, 90) }
local PANEL = Color3.fromRGB(14, 14, 20)
local MUTED = Color3.fromRGB(150, 150, 165)
local FONT = Enum.Font.GothamBold
local FONT_LIGHT = Enum.Font.GothamMedium

local function make(className: string, props: { [string]: any }, children: { Instance }?): any
	local inst = Instance.new(className)
	for key, value in props do
		inst[key] = value
	end
	for _, child in children or {} do
		child.Parent = inst
	end
	return inst
end

local function corner(px: number)
	return make("UICorner", { CornerRadius = UDim.new(0, px) })
end

local function label(props)
	local base = {
		BackgroundTransparency = 1,
		Font = FONT,
		TextColor3 = Color3.new(1, 1, 1),
		TextScaled = false,
		TextSize = 16,
	}
	for key, value in props do
		base[key] = value
	end
	return make("TextLabel", base)
end

------------------------------------------------------------------------
-- Build
------------------------------------------------------------------------

local gui = make("ScreenGui", {
	Name = "ArenaUI",
	ResetOnSpawn = false,
	DisplayOrder = 20,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

local top = make("Frame", {
	Name = "Top",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 6),
	Size = UDim2.new(0.7, 0, 0, 64),
	BackgroundTransparency = 1,
}, { make("UISizeConstraint", { MaxSize = Vector2.new(620, 64) }) })
top.Parent = gui

local teamFrames = {}
for team = 1, 2 do
	local frame = make("Frame", {
		Name = "Team" .. team,
		AnchorPoint = if team == 1 then Vector2.new(0, 0) else Vector2.new(1, 0),
		Position = if team == 1 then UDim2.fromScale(0, 0) else UDim2.fromScale(1, 0),
		Size = UDim2.fromScale(0.38, 1),
		BackgroundColor3 = PANEL,
		BackgroundTransparency = 0.2,
	}, {
		corner(8),
		make("UIStroke", { Color = TEAM_COLORS[team], Thickness = 2 }),
		make("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }),
		make("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 4),
		}),
	})
	frame.Parent = top
	teamFrames[team] = frame
end

local center = make("Frame", {
	Name = "Center",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.fromScale(0.5, 0),
	Size = UDim2.fromScale(0.22, 1),
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.2,
}, { corner(8) })
center.Parent = top
local phaseLabel = label({
	Size = UDim2.new(1, -8, 0.45, 0),
	Position = UDim2.new(0, 4, 0.08, 0),
	TextSize = 13,
	TextColor3 = MUTED,
	Text = "",
})
phaseLabel.Parent = center
local timerLabel = label({
	Size = UDim2.new(1, -8, 0.5, 0),
	Position = UDim2.new(0, 4, 0.45, 0),
	TextSize = 24,
	Text = "",
})
timerLabel.Parent = center

local hint = label({
	Name = "Hint",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 0, 76),
	Size = UDim2.new(0.9, 0, 0, 24),
	TextSize = 18,
	TextStrokeTransparency = 0.4,
	Text = "",
})
hint.Parent = gui

local big = label({
	Name = "Big",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.4),
	Size = UDim2.fromOffset(600, 120),
	TextSize = 84,
	TextStrokeTransparency = 0.2,
	Text = "",
})
big.Parent = gui

local afk = label({
	Name = "Afk",
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.fromScale(0.5, 0.22),
	Size = UDim2.new(0.9, 0, 0, 32),
	TextSize = 24,
	TextColor3 = Color3.fromRGB(255, 80, 80),
	TextStrokeTransparency = 0.3,
	Visible = false,
	Text = "",
})
afk.Parent = gui

local feed = make("Frame", {
	Name = "Feed",
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -12, 0, 80),
	Size = UDim2.fromOffset(260, 160),
	BackgroundTransparency = 1,
}, {
	make("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Right,
		Padding = UDim.new(0, 4),
	}),
})
feed.Parent = gui

local results = make("Frame", {
	Name = "Results",
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.52),
	Size = UDim2.new(0.9, 0, 0, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	BackgroundColor3 = PANEL,
	BackgroundTransparency = 0.08,
	Visible = false,
}, {
	corner(12),
	make("UISizeConstraint", { MaxSize = Vector2.new(560, math.huge) }),
	make("UIPadding", {
		PaddingTop = UDim.new(0, 16),
		PaddingBottom = UDim.new(0, 16),
		PaddingLeft = UDim.new(0, 16),
		PaddingRight = UDim.new(0, 16),
	}),
	make("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8) }),
})
results.Parent = gui

gui.Parent = player:WaitForChild("PlayerGui")

------------------------------------------------------------------------
-- Roster / team panels
------------------------------------------------------------------------

local roster = {}
local rosterRaw = nil
local nameById = {}

local function myEntry()
	for _, entry in roster do
		if entry.UserId == player.UserId then
			return entry
		end
	end
	return nil
end

local function rebuildTeams()
	for team = 1, 2 do
		for _, child in teamFrames[team]:GetChildren() do
			if child:IsA("Frame") then
				child:Destroy()
			end
		end
	end
	local lives = (require(Ranked.Config).Arena.Lives)
	for _, entry in roster do
		nameById[entry.UserId] = entry.Name
		local frame = teamFrames[entry.Team]
		if not frame then
			continue
		end
		local row = make("Frame", {
			Name = tostring(entry.UserId),
			LayoutOrder = entry.Slot or 1,
			Size = UDim2.new(1, 0, 0, 22),
			BackgroundTransparency = 1,
		})
		local you = entry.UserId == player.UserId
		local name = label({
			Size = UDim2.new(1, -54, 1, 0),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextSize = 15,
			TextColor3 = if entry.Gone then MUTED elseif you then Color3.fromRGB(255, 230, 120) else Color3.new(1, 1, 1),
			Text = (entry.Name or "?") .. (if entry.Gone then " (left)" else ""),
		})
		name.Parent = row
		local pips = make("Frame", {
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.fromScale(1, 0.5),
			Size = UDim2.fromOffset(50, 12),
			BackgroundTransparency = 1,
		}, {
			make("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Right,
				Padding = UDim.new(0, 4),
			}),
		})
		for i = 1, math.max(lives, entry.Lives or 0) do
			make("Frame", {
				Size = UDim2.fromOffset(12, 12),
				BackgroundColor3 = if i <= (entry.Lives or 0) then TEAM_COLORS[entry.Team] else Color3.fromRGB(55, 55, 65),
			}, { make("UICorner", { CornerRadius = UDim.new(1, 0) }) }).Parent = pips
		end
		pips.Parent = row
		row.Parent = frame
	end
end

local function readRoster()
	local raw = workspace:GetAttribute("ArenaRoster")
	if raw == rosterRaw then
		return
	end
	rosterRaw = raw
	local ok, data = pcall(HttpService.JSONDecode, HttpService, raw or "[]")
	roster = if ok and type(data) == "table" then data else {}
	rebuildTeams()
end

------------------------------------------------------------------------
-- Select camera
------------------------------------------------------------------------

local selectCameraOn = false
local function setSelectCamera(on: boolean)
	if on == selectCameraOn then
		return
	end
	selectCameraOn = on
	if on then
		-- every frame, because the game's own camera scripts (shiftlock, follow) also set it
		RunService:BindToRenderStep("ArenaSelectCamera", Enum.RenderPriority.Camera.Value + 1, function()
			local cf = workspace:GetAttribute("ArenaCamera")
			local camera = workspace.CurrentCamera
			if typeof(cf) == "CFrame" and camera then
				camera.CameraType = Enum.CameraType.Scriptable
				camera.CFrame = cf
			end
		end)
	else
		RunService:UnbindFromRenderStep("ArenaSelectCamera")
		local camera = workspace.CurrentCamera
		if camera then
			camera.CameraType = Enum.CameraType.Custom
			local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				camera.CameraSubject = humanoid
			end
		end
	end
end

------------------------------------------------------------------------
-- Phase display
------------------------------------------------------------------------

local QUEUE_NAMES = {
	Ranked1v1 = "RANKED 1v1",
	Casual1v1 = "CASUAL 1v1",
	Ranked2v2 = "RANKED 2v2",
	Casual2v2 = "CASUAL 2v2",
}

local lastPhase = nil
local fightShownAt = 0

local function secondsLeft(): number
	local ends = workspace:GetAttribute("ArenaPhaseEnds") or 0
	return math.max(0, math.ceil(ends - workspace:GetServerTimeNow()))
end

local function update()
	readRoster()
	local phase = workspace:GetAttribute("ArenaPhase") or "Loading"
	local queue = QUEUE_NAMES[workspace:GetAttribute("ArenaQueue") or ""] or "ARENA"
	local left = secondsLeft()

	if phase ~= lastPhase then
		if phase == "Fight" then
			fightShownAt = os.clock()
		end
		setSelectCamera(phase == "Select")
		lastPhase = phase
	end

	if phase == "Loading" then
		local loaded, total = 0, 0
		for _, entry in roster do
			total += 1
			if entry.Loaded then
				loaded += 1
			end
		end
		phaseLabel.Text = queue
		timerLabel.Text = if left > 0 then tostring(left) else ""
		hint.Text = if total > 0 then ("Waiting for players... %d/%d"):format(loaded, total) else "Finding your match..."
		big.Text = ""
	elseif phase == "Select" then
		phaseLabel.Text = "CHARACTER SELECT"
		timerLabel.Text = tostring(left)
		hint.Text = "Pick your character from the Characters menu (top left)"
		big.Text = ""
	elseif phase == "Countdown" then
		phaseLabel.Text = queue
		timerLabel.Text = ""
		hint.Text = ""
		big.Text = if left > 0 then tostring(left) else ""
	elseif phase == "Fight" then
		phaseLabel.Text = queue
		local mine = myEntry()
		timerLabel.Text = if mine then ("%d / %d"):format(mine.Kills or 0, mine.Deaths or 0) else ""
		hint.Text = if mine and (mine.Lives or 0) <= 0 then "Out of lives" else ""
		big.Text = if os.clock() - fightShownAt < 1.2 then "FIGHT!" else ""
	elseif phase == "Results" then
		phaseLabel.Text = queue
		timerLabel.Text = ""
		hint.Text = ""
		big.Text = ""
	elseif phase == "Cancelled" then
		phaseLabel.Text = queue
		timerLabel.Text = ""
		big.Text = ""
		hint.Text = "Match cancelled: " .. tostring(workspace:GetAttribute("ArenaCancelReason") or "") .. ". Returning to the Lobby..."
	end
end

local accumulator = 0
RunService.Heartbeat:Connect(function(dt)
	accumulator += dt
	if accumulator >= 0.1 then
		accumulator = 0
		update()
	end
end)
update()

------------------------------------------------------------------------
-- Events: kill feed, AFK warning, results
------------------------------------------------------------------------

local function addFeed(text: string, color: Color3)
	local item = label({
		Size = UDim2.fromOffset(260, 24),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = PANEL,
		BackgroundTransparency = 0.25,
		TextSize = 14,
		TextColor3 = color,
		Text = "  " .. text .. "  ",
		LayoutOrder = -math.floor(os.clock() * 100),
	}, nil)
	corner(6).Parent = item
	item.Parent = feed
	task.delay(5, function()
		TweenService:Create(item, TweenInfo.new(0.4), { TextTransparency = 1, BackgroundTransparency = 1 }):Play()
		task.wait(0.45)
		item:Destroy()
	end)
end

local function teamOf(userId: number): number?
	for _, entry in roster do
		if entry.UserId == userId then
			return entry.Team
		end
	end
	return nil
end

local function signed(n: number): string
	return if n >= 0 then "+" .. n else tostring(n)
end

local function showResults(data)
	for _, child in results:GetChildren() do
		if child:IsA("GuiObject") then
			child:Destroy()
		end
	end
	local mine = nil
	for _, row in data.Players or {} do
		if row.UserId == player.UserId then
			mine = row
		end
	end
	local title = if mine then (if mine.Won then "VICTORY" else "DEFEAT") else ("TEAM %d WINS"):format(data.Winner or 0)
	label({
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 44),
		TextSize = 38,
		TextColor3 = if mine and mine.Won then Color3.fromRGB(255, 215, 90) else Color3.fromRGB(235, 235, 245),
		Text = title,
	}).Parent = results
	label({
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 18),
		Font = FONT_LIGHT,
		TextSize = 14,
		TextColor3 = MUTED,
		Text = ("%s  ·  %s  ·  fight %ds"):format(QUEUE_NAMES[data.Queue or ""] or "", tostring(data.Reason or ""), data.FightSeconds or 0),
	}).Parent = results

	local header = make("Frame", { LayoutOrder = 3, Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1 })
	local columns = {
		{ "PLAYER", 0, 0.4, Enum.TextXAlignment.Left },
		{ "K / D", 0.4, 0.14 },
		{ "DMG", 0.54, 0.14 },
		{ if data.Ranked then "ELO" else "", 0.68, 0.17 },
		{ "GOLD", 0.85, 0.15 },
	}
	for _, col in columns do
		label({
			Position = UDim2.fromScale(col[2], 0),
			Size = UDim2.fromScale(col[3], 1),
			TextSize = 12,
			TextColor3 = MUTED,
			TextXAlignment = col[4] or Enum.TextXAlignment.Center,
			Text = col[1],
		}).Parent = header
	end
	header.Parent = results

	local rows = table.clone(data.Players or {})
	table.sort(rows, function(a, b)
		if a.Team ~= b.Team then
			return a.Team == data.Winner
		end
		return (a.Kills or 0) > (b.Kills or 0)
	end)
	for i, row in rows do
		local line = make("Frame", {
			LayoutOrder = 10 + i,
			Size = UDim2.new(1, 0, 0, 30),
			BackgroundColor3 = TEAM_COLORS[row.Team] or PANEL,
			BackgroundTransparency = 0.82,
		}, { corner(6) })
		local values = {
			(row.Name or "?") .. (if row.Left then " (" .. row.Left .. ")" else ""),
			("%d / %d"):format(row.Kills or 0, row.Deaths or 0),
			tostring(row.Damage or 0),
			if data.Ranked then ("%s  (%d)"):format(signed(row.EloDelta or 0), row.EloAfter or 0) else "",
			if (row.Gold or 0) > 0 then "+" .. row.Gold else "0",
		}
		for c, col in columns do
			local deltaColor = nil
			if c == 4 and data.Ranked then
				deltaColor = if (row.EloDelta or 0) >= 0 then Color3.fromRGB(120, 230, 140) else Color3.fromRGB(255, 120, 120)
			elseif c == 5 then
				deltaColor = Color3.fromRGB(255, 215, 90)
			end
			label({
				Position = UDim2.new(col[2], if c == 1 then 8 else 0, 0, 0),
				Size = UDim2.new(col[3], if c == 1 then -8 else 0, 1, 0),
				TextSize = 15,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = col[4] or Enum.TextXAlignment.Center,
				TextColor3 = deltaColor or (if row.UserId == player.UserId then Color3.fromRGB(255, 230, 120) else Color3.new(1, 1, 1)),
				Text = values[c],
			}).Parent = line
		end
		line.Parent = results
	end

	if mine and mine.Notes and #mine.Notes > 0 then
		label({
			LayoutOrder = 90,
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			Font = FONT_LIGHT,
			TextSize = 13,
			TextWrapped = true,
			TextColor3 = MUTED,
			Text = table.concat(mine.Notes, "  ·  "),
		}).Parent = results
	end
	label({
		LayoutOrder = 99,
		Size = UDim2.new(1, 0, 0, 18),
		Font = FONT_LIGHT,
		TextSize = 13,
		TextColor3 = MUTED,
		Text = "Returning to the Lobby...",
	}).Parent = results
	results.Visible = true
end

MatchState.OnClientEvent:Connect(function(kind: string, data)
	data = data or {}
	if kind == "Kill" then
		local victim = nameById[data.Victim] or "?"
		local team = teamOf(data.Killer or data.Victim) or 1
		if data.Killer then
			addFeed((nameById[data.Killer] or "?") .. "  killed  " .. victim, TEAM_COLORS[team])
		else
			addFeed(victim .. " died", MUTED)
		end
	elseif kind == "AfkWarning" then
		afk.Text = ("Move or you'll be removed in %d seconds!"):format(data.Seconds or 10)
		afk.Visible = true
		task.delay(5, function()
			afk.Visible = false
		end)
	elseif kind == "Results" then
		setSelectCamera(false)
		showResults(data)
	elseif kind == "Cancelled" then
		setSelectCamera(false)
	end
end)
