--!strict
-- In-match UI, built in code (ROADMAP step 6 / GAME_PLAN.md Section 5):
--   * round bar: state, timer, round number, Runners left; banners and a notice feed
--   * Runner HUD: health, stamina, course progress, Q/E/R skill slots (+ mobile sprint/slide)
--   * God HUD: energy bar, 1-5 hotbar, Runner tracker
--   * spectating after elimination, and the end-of-match MVP leaderboard

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local RoundConfig = require(ReplicatedStorage.Shared.Config.RoundConfig)
local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Format = require(ReplicatedStorage.Shared.Util.Format)
local StrikeMath = require(ReplicatedStorage.Shared.Util.StrikeMath)

local Make = require(script.Parent.Make)
local UIController = require(script.Parent.UIController)
local AbilityController = require(script.Parent.AbilityController)
local MovementController = require(script.Parent.MovementController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui
local Theme = Make.Theme

local MatchHUDController = {}

local gui: ScreenGui
local ui: { [string]: any } = {}
local skillButtons: { { Frame: Frame, Cooldown: Frame, Index: number, CostLabel: TextLabel, Cost: number } } = {}
local skillKey = ""
local spectateIndex = 1
local spectating: Player? = nil
local updateProgressDots: () -> ()

local STATE_TEXT = {
	Waiting = "Waiting for players",
	Intermission = "Intermission",
	RoleSelection = "Choosing Gods",
	MapGeneration = "Building the canyon",
	Preparation = "Get ready",
	ActiveRun = "The Crossing",
	RoundEnd = "Round over",
	MatchEnd = "Match over",
}

local function matchActive(): boolean
	return ReplicatedStorage:GetAttribute("MatchActive") == true
end

local function role(): string?
	local r = LocalPlayer:GetAttribute("Role")
	return if type(r) == "string" then r else nil
end

local function runnersLeft(): number
	local count = 0
	for _, player in Players:GetPlayers() do
		if player:GetAttribute("Role") == "Runner" and not player:GetAttribute("Eliminated") then
			count += 1
		end
	end
	return count
end

-- ------------------------------------------------------------------ build
local function buildTop()
	local panel = Make.Panel({
		Name = "RoundBar",
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 8),
		Size = UDim2.fromOffset(340, 58),
		Parent = gui,
	}, Theme.Cyan)
	ui.State = Make.Label({ Size = UDim2.new(1, -16, 0.45, 0), Position = UDim2.fromOffset(8, 4), Text = "", Parent = panel })
	ui.Timer = Make.Label({ Size = UDim2.new(0.5, -8, 0.45, 0), Position = UDim2.new(0, 8, 0.5, 0), TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = Theme.Gold, Text = "", Parent = panel })
	ui.Info = Make.Label({ Size = UDim2.new(0.5, -8, 0.45, 0), Position = UDim2.new(0.5, 0, 0.5, 0), TextXAlignment = Enum.TextXAlignment.Right, TextColor3 = Theme.SubText, Text = "", Parent = panel })

	-- Course progress (Runners during a match).
	local bar, fill = Make.Bar({ Name = "Progress", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 72), Size = UDim2.fromOffset(420, 10), Parent = gui }, Theme.Green)
	ui.ProgressBar = bar
	ui.ProgressFill = fill
	Make.Label({ Size = UDim2.fromOffset(60, 14), Position = UDim2.new(1, 6, 0.5, -7), Text = "🏁", Parent = bar })

	ui.Banner = Make.Label({ Name = "Banner", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.3), Size = UDim2.fromScale(0.6, 0.08), FontFace = Theme.FontHeavy, Text = "", TextTransparency = 1, Parent = gui })
	ui.BannerSub = Make.Label({ AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.345), Size = UDim2.fromScale(0.5, 0.035), TextColor3 = Theme.SubText, Text = "", TextTransparency = 1, Parent = gui })

	local feed = Make.new("Frame", { Name = "Feed", BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0.35, 0), Size = UDim2.fromOffset(280, 200), Parent = gui }, {
		Make.new("UIListLayout", { Padding = UDim.new(0, 4), VerticalAlignment = Enum.VerticalAlignment.Bottom }),
	})
	ui.Feed = feed
end

local function buildRunnerHud()
	local holder = Make.new("Frame", { Name = "RunnerHUD", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Parent = gui })
	ui.RunnerHUD = holder
	local health, healthFill = Make.Bar({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -54), Size = UDim2.fromOffset(300, 14), Parent = holder }, Theme.Red)
	local stamina, staminaFill = Make.Bar({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -34), Size = UDim2.fromOffset(300, 10), Parent = holder }, Theme.Cyan)
	ui.HealthFill = healthFill
	ui.StaminaFill = staminaFill
	ui.HealthText = Make.Label({ Size = UDim2.new(1, 0, 1, 0), Text = "", TextColor3 = Theme.Text, Parent = health })
	local _ = stamina
	-- Shown while iframes are active (GAME_PLAN.md 5C: "active iframes").
	ui.IFrames = Make.Label({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -72), Size = UDim2.fromOffset(160, 20), Text = "✦ IFRAMES ✦", TextColor3 = Theme.Cyan, Visible = false, Parent = holder })
	ui.RunnerSkills = Make.new("Frame", {
		Name = "Skills",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -16, 1, -20),
		Size = UDim2.fromOffset(380, 80),
		Parent = holder,
	}, { Make.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8) }) })

	-- The shoulder-shove slot (F): every Runner has it, so it isn't part of the kit's buttons.
	local shove = Make.Panel({ Name = "Shove", Size = UDim2.fromOffset(84, 84), LayoutOrder = 100, Parent = ui.RunnerSkills }, Theme.Purple)
	Make.Label({ Size = UDim2.new(1, -8, 0, 20), Position = UDim2.fromOffset(4, 2), Text = "F", TextColor3 = Theme.Gold, Parent = shove })
	Make.Label({ Size = UDim2.new(1, -8, 0, 34), Position = UDim2.fromOffset(4, 24), Text = "Shove", Parent = shove })
	Make.Label({ Size = UDim2.new(1, -8, 0, 16), Position = UDim2.new(0, 4, 1, -20), Text = tostring(MovementConfig.Shove.StaminaCost), TextColor3 = Theme.SubText, Parent = shove })
	ui.ShoveCooldown = Make.new("Frame", {
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 0),
		ZIndex = 5,
		Parent = shove,
	}, { Make.new("UICorner", { CornerRadius = UDim.new(0, 10) }) })
	local shoveButton = Make.new("TextButton", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 6, Parent = shove })
	shoveButton.Activated:Connect(AbilityController.Shove)

	-- Runner markers on the course progress bar (GAME_PLAN.md 5C: silhouettes racing to the flag).
	ui.ProgressDots = {} :: { [Player]: Frame }

	if UserInputService.TouchEnabled then
		local sprint = Make.new("TextButton", { Text = "SPRINT", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -16, 1, -110), Size = UDim2.fromOffset(80, 50), BackgroundColor3 = Theme.Slate, TextColor3 = Theme.Text, FontFace = Theme.Font, TextScaled = true, Parent = holder }, { Make.new("UICorner", {}) })
		sprint.MouseButton1Down:Connect(function()
			MovementController.SetSprint(true)
		end)
		sprint.MouseButton1Up:Connect(function()
			MovementController.SetSprint(false)
		end)
		local shoveTouch = Make.new("TextButton", { Text = "SHOVE", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -192, 1, -110), Size = UDim2.fromOffset(80, 50), BackgroundColor3 = Theme.Slate, TextColor3 = Theme.Text, FontFace = Theme.Font, TextScaled = true, Parent = holder }, { Make.new("UICorner", {}) })
		shoveTouch.Activated:Connect(AbilityController.Shove)
		local slideButton = Make.new("TextButton", { Text = "SLIDE", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -104, 1, -110), Size = UDim2.fromOffset(80, 50), BackgroundColor3 = Theme.Slate, TextColor3 = Theme.Text, FontFace = Theme.Font, TextScaled = true, Parent = holder }, { Make.new("UICorner", {}) })
		slideButton.Activated:Connect(MovementController.Slide)
	end
end

local function buildGodHud()
	local holder = Make.new("Frame", { Name = "GodHUD", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Visible = false, Parent = gui })
	ui.GodHUD = holder
	local energy, energyFill = Make.Bar({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -112), Size = UDim2.fromOffset(420, 14), Parent = holder }, Theme.Cyan)
	ui.EnergyFill = energyFill
	ui.EnergyText = Make.Label({ Size = UDim2.fromScale(1, 1), Text = "", Parent = energy })
	ui.GodSkills = Make.new("Frame", {
		Name = "Hotbar",
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -16),
		Size = UDim2.fromOffset(460, 88),
		Parent = holder,
	}, { Make.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0, 8) }) })
	Make.Label({ AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -132), Size = UDim2.fromOffset(500, 18), TextColor3 = Theme.SubText, Text = "WASD to pan · scroll to zoom · 1-5 to cast (hold to charge)", Parent = holder })

	local tracker = Make.Panel({ Name = "Tracker", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -12, 0, 90), Size = UDim2.fromOffset(240, 260), Parent = holder }, Theme.Red)
	Make.Label({ Size = UDim2.new(1, -12, 0, 22), Position = UDim2.fromOffset(6, 4), Text = "RUNNERS", TextColor3 = Theme.Red, Parent = tracker })
	ui.TrackerList = Make.new("Frame", { BackgroundTransparency = 1, Position = UDim2.fromOffset(8, 30), Size = UDim2.new(1, -16, 1, -36), Parent = tracker }, {
		Make.new("UIListLayout", { Padding = UDim.new(0, 4) }),
	})
end

local function buildSpectate()
	local panel = Make.Panel({ Name = "Spectate", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -20), Size = UDim2.fromOffset(360, 50), Visible = false, Parent = gui }, Theme.Purple)
	ui.Spectate = panel
	ui.SpectateName = Make.Label({ Position = UDim2.fromScale(0.15, 0.15), Size = UDim2.fromScale(0.7, 0.7), Text = "", Parent = panel })
	for _, info in { { "<", 0.02, -1 }, { ">", 0.86, 1 } } do
		local button = Make.new("TextButton", { Text = info[1], Position = UDim2.fromScale(info[2] :: number, 0.1), Size = UDim2.fromScale(0.12, 0.8), BackgroundTransparency = 1, TextColor3 = Theme.Text, FontFace = Theme.FontHeavy, TextScaled = true, Parent = panel })
		button.Activated:Connect(function()
			spectateIndex += info[3] :: number
		end)
	end
end

-- ------------------------------------------------------------------ skills
local function makeSkillButton(parent: Instance, index: number, keyText: string, name: string, cost: number, isUlt: boolean): Frame
	local frame = Make.Panel({ Size = UDim2.fromOffset(84, 84), Parent = parent }, if isUlt then Theme.Gold else Theme.Cyan)
	Make.Label({ Size = UDim2.new(1, -8, 0, 20), Position = UDim2.fromOffset(4, 2), Text = keyText, TextColor3 = Theme.Gold, Parent = frame })
	Make.Label({ Size = UDim2.new(1, -8, 0, 34), Position = UDim2.fromOffset(4, 24), Text = name, TextWrapped = true, Parent = frame })
	local costLabel = Make.Label({ Size = UDim2.new(1, -8, 0, 16), Position = UDim2.new(0, 4, 1, -20), Text = if cost > 0 then tostring(cost) else "", TextColor3 = Theme.SubText, Parent = frame })
	local cooldown = Make.new("Frame", {
		Name = "Cooldown",
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.fromScale(1, 0),
		ZIndex = 5,
		Parent = frame,
	}, { Make.new("UICorner", { CornerRadius = UDim.new(0, 10) }) })
	local button = Make.new("TextButton", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 6, Parent = frame })
	button.MouseButton1Down:Connect(function()
		AbilityController.Press(index)
	end)
	button.MouseButton1Up:Connect(function()
		AbilityController.Release(index)
	end)
	table.insert(skillButtons, { Frame = frame, Cooldown = cooldown, Index = index, CostLabel = costLabel, Cost = cost })
	return frame
end

local function rebuildSkills()
	local kit = AbilityController.GetKit()
	local r = role()
	local key = `{r}|{if kit then kit.Id else ""}`
	if key == skillKey then
		return
	end
	skillKey = key
	for _, entry in skillButtons do
		entry.Frame:Destroy()
	end
	table.clear(skillButtons)
	if not kit then
		return
	end
	local parent = if r == "God" then ui.GodSkills else ui.RunnerSkills
	local runnerKeys = { "Q", "E", "R" }
	for index, skill in kit.Skills do
		local keyText = if r == "God" then tostring(index) else runnerKeys[index] or "?"
		makeSkillButton(parent, index, keyText, skill.Name, skill.Cost, skill.Ultimate)
	end
end

-- ------------------------------------------------------------------ notices
local function feed(text: string, color: Color3?)
	local label = Make.Label({ Size = UDim2.new(1, 0, 0, 22), Text = text, TextXAlignment = Enum.TextXAlignment.Left, TextColor3 = color or Theme.Text, Parent = ui.Feed })
	task.delay(5, function()
		TweenService:Create(label, TweenInfo.new(0.5), { TextTransparency = 1 }):Play()
		task.wait(0.5)
		label:Destroy()
	end)
end

local bannerToken = 0
local function showBanner(text: string, sub: string?, color: Color3?)
	bannerToken += 1
	local token = bannerToken
	ui.Banner.Text = text
	ui.Banner.TextColor3 = color or Theme.Text
	ui.BannerSub.Text = sub or ""
	ui.Banner.TextTransparency = 1
	ui.BannerSub.TextTransparency = 1
	TweenService:Create(ui.Banner, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
	TweenService:Create(ui.BannerSub, TweenInfo.new(0.25), { TextTransparency = 0 }):Play()
	task.delay(2.6, function()
		if bannerToken ~= token then
			return
		end
		TweenService:Create(ui.Banner, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
		TweenService:Create(ui.BannerSub, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
	end)
end

-- ------------------------------------------------------------------ results
local function showResults(info: { [string]: any })
	if ui.Results then
		ui.Results:Destroy()
	end
	local panel = Make.Panel({ Name = "Results", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.fromScale(0.8, 0.8), BackgroundTransparency = 0.05, Parent = gui }, Theme.Gold)
	ui.Results = panel
	Make.Label({ Position = UDim2.fromScale(0.05, 0.02), Size = UDim2.fromScale(0.9, 0.07), FontFace = Theme.FontHeavy, TextColor3 = Theme.Gold, Text = if info.Winner then `{info.Winner} WINS!` else "THE GODS WIN", Parent = panel })

	-- Award cards.
	local cards = Make.new("Frame", { BackgroundTransparency = 1, Position = UDim2.fromScale(0.03, 0.11), Size = UDim2.fromScale(0.94, 0.3), Parent = panel }, {
		Make.new("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0.01, 0) }),
	})
	for _, award in (info.Awards or {}) :: { any } do
		local card = Make.Panel({ Size = UDim2.fromScale(0.155, 1) }, Theme.Gold)
		card.Parent = cards
		local avatar = Make.new("ImageLabel", { BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.05), Size = UDim2.fromScale(0.55, 0.45), Parent = card }, {
			Make.new("UIAspectRatioConstraint", {}),
			Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }),
		})
		task.spawn(function()
			local ok, image = pcall(Players.GetUserThumbnailAsync, Players, award.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
			if ok then
				avatar.Image = image
			end
		end)
		Make.Label({ Position = UDim2.fromScale(0.05, 0.52), Size = UDim2.fromScale(0.9, 0.15), TextColor3 = Theme.Gold, Text = string.upper(award.Title), Parent = card })
		Make.Label({ Position = UDim2.fromScale(0.05, 0.68), Size = UDim2.fromScale(0.9, 0.14), Text = award.Name, Parent = card })
		Make.Label({ Position = UDim2.fromScale(0.05, 0.83), Size = UDim2.fromScale(0.9, 0.12), TextColor3 = Theme.SubText, Text = award.Value or "", Parent = card })
	end

	-- Results table.
	local columns = { "#", "Player", "Rounds", "Time", "Kills", "Damage", "Score", "Cash" }
	local widths = { 0.05, 0.3, 0.1, 0.1, 0.1, 0.12, 0.11, 0.12 }
	local list = Make.new("ScrollingFrame", { BackgroundTransparency = 1, Position = UDim2.fromScale(0.03, 0.45), Size = UDim2.fromScale(0.94, 0.5), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 6, Parent = panel }, {
		Make.new("UIListLayout", { Padding = UDim.new(0, 2) }),
	})
	local function row(values: { string }, color: Color3)
		local frame = Make.new("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 26), Parent = list })
		local x = 0
		for i, value in values do
			Make.Label({ Position = UDim2.fromScale(x, 0), Size = UDim2.fromScale(widths[i], 1), Text = value, TextColor3 = color, Parent = frame })
			x += widths[i]
		end
	end
	row(columns, Theme.SubText)
	for rank, data in (info.Rows or {}) :: { any } do
		local color = if rank == 1 then Theme.Gold elseif rank == 2 then Color3.fromRGB(203, 213, 225) elseif rank == 3 then Color3.fromRGB(217, 119, 6) else Theme.Text
		row({
			tostring(rank),
			(if data.Winner then "👑 " else "") .. tostring(data.Name),
			tostring(data.RoundsSurvived),
			`{data.TimeSurvived}s`,
			tostring(data.Kills),
			tostring(data.Damage),
			tostring(data.Score),
			Format.Cash(data.Cash or 0),
		}, color)
	end

	local close = Make.new("TextButton", { Text = "CLOSE", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 10), Size = UDim2.fromOffset(90, 34), BackgroundColor3 = Theme.SlateLight, TextColor3 = Theme.Text, FontFace = Theme.Font, TextScaled = true, Parent = panel }, { Make.new("UICorner", {}) })
	close.Activated:Connect(function()
		panel:Destroy()
	end)
	task.delay(RoundConfig.MatchEndTime + 5, function()
		if panel.Parent then
			panel:Destroy()
		end
	end)
end

local function onRoundEvent(info: { [string]: any })
	if type(info) ~= "table" then
		return
	end
	if info.Kind == "Banner" then
		showBanner(tostring(info.Text or ""), info.Sub, info.Color)
	elseif info.Kind == "FinalRun" then
		showBanner("FINAL RUN", "Only two Runners remain", Theme.Red)
	elseif info.Kind == "Eliminated" then
		feed(`☠ {info.Name} was eliminated`, Theme.Red)
	elseif info.Kind == "Finished" then
		feed(`🏁 {info.Name} reached the Sanctuary`, Theme.Green)
	elseif info.Kind == "Results" then
		showResults(info)
	end
end

-- ------------------------------------------------------------------ update
local function updateSpectate()
	local shouldSpectate = matchActive() and role() == "Runner" and LocalPlayer:GetAttribute("Eliminated") == true
	local camera = workspace.CurrentCamera
	if not shouldSpectate then
		if spectating then
			spectating = nil
			local character = LocalPlayer.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if humanoid then
				camera.CameraSubject = humanoid
			end
		end
		ui.Spectate.Visible = false
		return
	end
	local alive = {}
	for _, player in Players:GetPlayers() do
		local character = player.Character
		if player ~= LocalPlayer and player:GetAttribute("Role") == "Runner" and not player:GetAttribute("Eliminated") and character and Characters.IsAlive(character) then
			table.insert(alive, player)
		end
	end
	ui.Spectate.Visible = true
	if #alive == 0 then
		ui.SpectateName.Text = "No Runners left"
		return
	end
	spectateIndex = ((spectateIndex - 1) % #alive) + 1
	local target = alive[spectateIndex]
	if target ~= spectating then
		spectating = target
		local humanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			camera.CameraSubject = humanoid
		end
	end
	ui.SpectateName.Text = `Spectating {target.DisplayName}`
end

local function updateTracker()
	for _, child in ui.TrackerList:GetChildren() do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	for _, player in Players:GetPlayers() do
		-- Fog of War: Runners hidden in fog are left off the God's tracker (GAME_PLAN.md 4B).
		local hidden = player.Character ~= nil and player.Character:GetAttribute("Concealed") == true
		if player:GetAttribute("Role") == "Runner" and not hidden then
			local eliminated = player:GetAttribute("Eliminated") == true
			local finished = player:GetAttribute("Finished") == true
			local character = player.Character
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			local health = if humanoid and not eliminated then humanoid.Health / math.max(humanoid.MaxHealth, 1) else 0
			local entry = Make.new("Frame", { BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 24), Parent = ui.TrackerList })
			Make.Label({ Size = UDim2.new(0.55, 0, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Text = player.DisplayName, TextColor3 = if eliminated then Theme.SubText elseif finished then Theme.Green else Theme.Text, Parent = entry })
			local bar, fill = Make.Bar({ Position = UDim2.new(0.57, 0, 0.3, 0), Size = UDim2.new(0.28, 0, 0.4, 0), Parent = entry }, Theme.Red)
			fill.Size = UDim2.fromScale(math.clamp(health, 0, 1), 1)
			local _ = bar
			local progress = (player:GetAttribute("Progress") :: number?) or 0
			Make.Label({ Position = UDim2.new(0.86, 0, 0, 0), Size = UDim2.new(0.14, 0, 1, 0), Text = `{math.floor(progress * 100)}%`, TextColor3 = Theme.SubText, Parent = entry })
		end
	end
end

-- One dot per Runner on the progress bar; yours is bigger and gold.
updateProgressDots = function()
	local dots: { [Player]: Frame } = ui.ProgressDots
	local seen: { [Player]: boolean } = {}
	if ui.ProgressBar.Visible then
		for _, player in Players:GetPlayers() do
			if player:GetAttribute("Role") == "Runner" and not player:GetAttribute("Eliminated") then
				seen[player] = true
				local dot = dots[player]
				if not dot then
					local mine = player == LocalPlayer
					dot = Make.new("Frame", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.fromOffset(if mine then 16 else 11, if mine then 16 else 11),
						BackgroundColor3 = if mine then Theme.Gold else Theme.Text,
						BorderSizePixel = 0,
						ZIndex = 3,
						Parent = ui.ProgressBar,
					}, { Make.new("UICorner", { CornerRadius = UDim.new(1, 0) }), Make.new("UIStroke", { Thickness = 1.5, Color = Theme.Slate }) })
					dots[player] = dot
				end
				local progress = math.clamp((player:GetAttribute("Progress") :: number?) or 0, 0, 1)
				dot.Position = UDim2.fromScale(progress, 0.5)
			end
		end
	end
	for player, dot in dots do
		if not seen[player] then
			dot:Destroy()
			dots[player] = nil
		end
	end
end

local trackerTimer = 0
local function update(dt: number)
	local state = ReplicatedStorage:GetAttribute("RoundState")
	local endsAt = ReplicatedStorage:GetAttribute("RoundEndsAt")
	ui.State.Text = STATE_TEXT[state :: any] or ""
	ui.Timer.Text = if type(endsAt) == "number" then `⏱ {math.max(math.ceil(endsAt - workspace:GetServerTimeNow()), 0)}s` else ""
	local roundNumber = ReplicatedStorage:GetAttribute("RoundNumber")
	ui.Info.Text = if matchActive() then `Round {roundNumber or 1} · {runnersLeft()} left` else ""

	local r = role()
	local isGod = r == "God" and (matchActive() or LocalPlayer:GetAttribute("InTestArea") == true) -- test area: TestAreaService
	ui.GodHUD.Visible = isGod
	ui.RunnerHUD.Visible = not isGod
	ui.ProgressBar.Visible = matchActive() and r == "Runner"
	ui.ProgressFill.Size = UDim2.fromScale(math.clamp((LocalPlayer:GetAttribute("Progress") :: number?) or 0, 0, 1), 1)
	updateProgressDots()

	-- The lobby HUD (vault buttons) only shows outside matches.
	local hud = PlayerGui:FindFirstChild("HUD") :: ScreenGui?
	if hud and matchActive() and hud.Enabled then
		UIController.CloseAll()
		hud.Enabled = false
	end

	rebuildSkills()
	for _, entry in skillButtons do
		local kit = AbilityController.GetKit()
		local skill = kit and kit.Skills[entry.Index]
		local left = AbilityController.CooldownLeft(entry.Index)
		local fraction = if skill and skill.Cooldown > 0 then left / skill.Cooldown else 0
		entry.Cooldown.Size = UDim2.fromScale(1, math.clamp(fraction, 0, 1))
		if entry.Cost > 0 then
			-- Passives like Four Arms lower the next cost: show the real price, in green.
			local multiplier = LocalPlayer:GetAttribute("CostMultiplier")
			local discounted = type(multiplier) == "number" and isGod
			entry.CostLabel.Text = tostring(if discounted then StrikeMath.DiscountedCost(entry.Cost, multiplier :: number) else entry.Cost)
			entry.CostLabel.TextColor3 = if discounted then Theme.Green else Theme.SubText
		end
	end

	if not isGod then
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		ui.IFrames.Visible = character ~= nil and character:GetAttribute("Invulnerable") == true
		local shoveLeft = AbilityController.ShoveCooldownLeft()
		ui.ShoveCooldown.Size = UDim2.fromScale(1, math.clamp(shoveLeft / MovementConfig.Shove.Cooldown, 0, 1))
		if humanoid then
			ui.HealthFill.Size = UDim2.fromScale(math.clamp(humanoid.Health / math.max(humanoid.MaxHealth, 1), 0, 1), 1)
			ui.HealthText.Text = `{math.ceil(humanoid.Health)}`
		end
		ui.StaminaFill.Size = UDim2.fromScale(MovementController.Stamina / MovementConfig.Stamina.Max, 1)
		ui.StaminaFill.BackgroundColor3 = if MovementController.Sprinting then Theme.Gold else Theme.Cyan
	else
		local energy = (LocalPlayer:GetAttribute("Energy") :: number?) or 0
		local max = (LocalPlayer:GetAttribute("MaxEnergy") :: number?) or RoundConfig.GodEnergy.Max
		ui.EnergyFill.Size = UDim2.fromScale(math.clamp(energy / max, 0, 1), 1)
		ui.EnergyText.Text = `{math.floor(energy)} / {max}`
		trackerTimer += dt
		if trackerTimer > 0.5 then
			trackerTimer = 0
			updateTracker()
		end
	end
	updateSpectate()
end

function MatchHUDController.Init()
	gui = Make.new("ScreenGui", { Name = "MatchHUD", ResetOnSpawn = false, IgnoreGuiInset = false, DisplayOrder = 10, Parent = PlayerGui })
	buildTop()
	buildRunnerHud()
	buildGodHud()
	buildSpectate()
	Remotes.Event("RoundEvent").OnClientEvent:Connect(onRoundEvent)
end

function MatchHUDController.Start()
	ReplicatedStorage:GetAttributeChangedSignal("MatchActive"):Connect(function()
		if not matchActive() then
			UIController.SetHUDVisible(true)
		end
	end)
	RunService.Heartbeat:Connect(update)
end

return MatchHUDController
