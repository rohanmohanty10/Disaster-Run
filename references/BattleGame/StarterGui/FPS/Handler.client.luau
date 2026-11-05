local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- PLAYER --

local player = Players.LocalPlayer
repeat task.wait() until game:IsLoaded() and player:GetAttribute("Loaded") == true --and Player:FindFirstChild('LoadedData') and Player:HasTag("DataLoaded")
local Character = player.Character or player.CharacterAdded:Wait()

local ConfigFolder = player:WaitForChild("Configuration")
local hideFPS = ConfigFolder:WaitForChild("Hide FPS")

local fpsLabel = script.Parent:WaitForChild("FPStext")
local gradient = fpsLabel:FindFirstChildWhichIsA("UIGradient")

-- The Gold display: the amount, then the coin, small in the bottom-right corner (like JJS and
-- Fisch). On phones the bottom right is the Punch / Dash / Block buttons, so there it sits in the
-- top-right corner instead. The old "GOLD: 1110" text (Goldtext) stays hidden.
local UserInputService = game:GetService("UserInputService")
local UI = require(ReplicatedStorage.Modules:WaitForChild("ExpeditionUI"))
local COIN = "rbxassetid://80297771892932" -- TEMP (Anime Origins' coin)

local onPhone = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local oldGold = script.Parent:WaitForChild("Goldtext")
oldGold.Visible = false
local goldChip = UI.New("Frame", {
	Name = "GoldChip",
	Size = UDim2.fromScale(0.3, 0.05), -- 5% of the screen tall; the aspect ratio sets the width
	AnchorPoint = if onPhone then Vector2.new(1, 0) else Vector2.new(1, 1),
	Position = if onPhone then UDim2.new(1, -16, 0, 8) else UDim2.new(1, -18, 1, -14),
	BackgroundTransparency = 1,
	Parent = script.Parent,
}, { UI.New("UIAspectRatioConstraint", { AspectRatio = 3.4 }) })
UI.Image({ Image = COIN, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromScale(0.3, 1.1), Position = UDim2.new(1, 2, 0.5, 0), AnchorPoint = Vector2.new(1, 0.5), ZIndex = 2, Parent = goldChip })
local goldTextLabel = UI.Text({
	Text = "0",
	TextScaled = true,
	Weight = "ExtraBold",
	Gradient = UI.Gradients.Gold,
	Size = UDim2.new(0.7, -4, 0.78, 0),
	Position = UDim2.new(0, 0, 0.5, 0),
	AnchorPoint = Vector2.new(0, 0.5),
	ZIndex = 2,
	Parent = goldChip,
})
goldTextLabel.TextXAlignment = Enum.TextXAlignment.Right -- the number grows leftward, away from the coin

-- the "Hide Gold" setting
local hideGold = ConfigFolder:FindFirstChild("Hide Gold")
if hideGold then
	goldChip.Visible = not hideGold.Value
	hideGold.Changed:Connect(function()
		goldChip.Visible = not hideGold.Value
	end)
end

local TARGET_FPS = 60
local frameTimes = {}
local conn = nil

local function stepFPS()
	local now = os.clock()
	table.insert(frameTimes, now)
	while frameTimes[1] and now - frameTimes[1] > 1 do
		table.remove(frameTimes, 1)
	end

	local fps = #frameTimes
	fpsLabel.Text = fps
	if gradient then
		local t = math.clamp(fps / TARGET_FPS, 0, 1)
		gradient.Color = ColorSequence.new(
			Color3.fromRGB(255, 255, 255),
			Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), t)
		)
	end
end

local function apply()
	local hidden = hideFPS.Value

	fpsLabel.Visible = not hidden

	if hidden then
		if conn then
			conn:Disconnect()
			conn = nil
		end
	elseif not conn then
		table.clear(frameTimes)   -- stale samples would read as a bogus spike
		conn = RunService.RenderStepped:Connect(stepFPS)
	end
end

hideFPS:GetPropertyChangedSignal("Value"):Connect(apply)
apply()   -- initial state on join

local GOLD_TWEEN_TIME = 1   -- seconds for the number to travel to its new value

local displayedGold   = player:GetAttribute("Gold") or 0
local targetGold      = displayedGold
local startGold       = displayedGold
local startTime       = 0
local goldConn        = nil
local goldInitialized = false

local function renderGold(n)
	goldTextLabel.Text = UI.Comma(math.floor(n))
end

local function stepGold()
	local alpha = math.clamp((os.clock() - startTime) / GOLD_TWEEN_TIME, 0, 1)
	local eased = 1 - (1 - alpha) ^ 3          -- ease-out cubic
	displayedGold = startGold + (targetGold - startGold) * eased
	renderGold(displayedGold)

	if alpha >= 1 then
		displayedGold = targetGold
		renderGold(displayedGold)              -- snap to the exact value
		if goldConn then goldConn:Disconnect(); goldConn = nil end
	end
end

local function updateGold()
	local newValue = player:GetAttribute("Gold") or 0

	-- First value on join: show it immediately, don't count up from 0 every spawn.
	if not goldInitialized then
		goldInitialized = true
		displayedGold, targetGold = newValue, newValue
		renderGold(newValue)
		return
	end

	if newValue == targetGold then return end

	-- Re-anchor from wherever the number currently sits, so rapid changes
	-- (spend then refund) chain smoothly instead of snapping.
	startGold  = displayedGold
	targetGold = newValue
	startTime  = os.clock()

	if not goldConn then
		goldConn = RunService.Heartbeat:Connect(stepGold)
	end
end

player:GetAttributeChangedSignal("Gold"):Connect(updateGold)
updateGold()
