--!strict
-- ClashClient
-- Place at: StarterPlayer.StarterPlayerScripts.ClashClient  (LocalScript)
--
-- Handles ONLY the shared cinematic feel and the Random-mode flash.
-- The QTE bar itself is owned by ReplicatedStorage.QuickTimeEvents (its own _client
-- clone is parented into PlayerGui by the server when ClashMode == "QTE"), so this
-- script does NOT build or drive the bar.

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ClashRemotes = RS.Remotes:WaitForChild("Clash")

--==================================================================================
-- Minimal full-screen flash GUI (built in code so there's nothing extra to import)
--==================================================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ClashFeedback"
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 50
screenGui.Parent = PlayerGui

local flash = Instance.new("Frame")
flash.Name = "Flash"
flash.Size = UDim2.fromScale(1, 1)
flash.BackgroundColor3 = Color3.new(1, 1, 1)
flash.BackgroundTransparency = 1
flash.BorderSizePixel = 0
flash.Visible = false
flash.Parent = screenGui

local label = Instance.new("TextLabel")
label.Name = "ClashText"
label.AnchorPoint = Vector2.new(0.5, 0.5)
label.Position = UDim2.fromScale(0.5, 0.4)
label.Size = UDim2.fromScale(0.6, 0.2)
label.BackgroundTransparency = 1
label.Font = Enum.Font.GothamBlack
label.TextScaled = true
label.TextColor3 = Color3.new(1, 1, 1)
label.TextStrokeTransparency = 0
label.TextTransparency = 1
label.Text = "CLASH!"
label.Parent = screenGui

local function pulse(text: string, color: Color3)
	label.Text = text
	label.TextColor3 = color

	flash.Visible = true
	flash.BackgroundColor3 = color
	flash.BackgroundTransparency = 0.4
	label.TextTransparency = 0

	TweenService:Create(flash, TweenInfo.new(0.45), { BackgroundTransparency = 1 }):Play()
	TweenService:Create(label, TweenInfo.new(0.6), { TextTransparency = 1 }):Play()

	task.delay(0.6, function()
		flash.Visible = false
	end)
end

--==================================================================================
-- Remote handlers
--==================================================================================

ClashRemotes.Start.OnClientEvent:Connect(function(data)
	-- Shared feel for both modes. (Camera shake is fired separately by the server
	-- via your existing "ShakeCamera" replicate event.)
	pulse("CLASH!", Color3.fromRGB(255, 255, 255))
	-- The QTE bar (if ClashMode == "QTE") appears on its own from QuickTimeEvents.
end)

ClashRemotes.Result.OnClientEvent:Connect(function(data)
	local result = data and data.Result
	if result == "win" then
		pulse("WIN", Color3.fromRGB(120, 255, 120))
	elseif result == "lose" then
		pulse("LOSE", Color3.fromRGB(255, 90, 90))
	else
		pulse("DRAW", Color3.fromRGB(255, 220, 110))
	end
end)
