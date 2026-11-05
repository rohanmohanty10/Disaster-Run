--!strict
-- ShiftLock (SkillBuilder-exact): toggle + reticle + rotation only.
-- Shoulder offset is applied in Client/init.client.lua via Humanoid.CameraOffset.

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

--========================= CONFIG =========================
local RETICLE_IMAGE = "rbxassetid://72180088379655"
local RETICLE_SIZE  = UDim2.fromOffset(5, 5)
local KEYBINDS      = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
--==========================================================

local player = Players.LocalPlayer

_G.ShiftLock = false

local gui = Instance.new("ScreenGui")
gui.Name = "ShiftLockReticle"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000
gui.Parent = player:WaitForChild("PlayerGui")

local reticle = Instance.new("ImageLabel")
reticle.AnchorPoint = Vector2.new(0.5, 0.5)
reticle.Position = UDim2.fromScale(0.5, 0.5)
reticle.Size = RETICLE_SIZE
reticle.BackgroundTransparency = 1
reticle.Image = RETICLE_IMAGE
reticle.Visible = false
reticle.Parent = gui

local function updateShift()
	if _G.ShiftLock then
		UserGameSettings.RotationType = Enum.RotationType.CameraRelative
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		reticle.Visible = true
	else
		UserGameSettings.RotationType = Enum.RotationType.MovementRelative
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
		reticle.Visible = false
	end
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	for _, key in KEYBINDS do
		if input.KeyCode == key then
			_G.ShiftLock = not _G.ShiftLock
			updateShift()
			return
		end
	end
end)

player.CharacterAdded:Connect(updateShift)

RunService.Heartbeat:Connect(function()
	if _G.ShiftLock and UserGameSettings.RotationType ~= Enum.RotationType.CameraRelative then
		UserGameSettings.RotationType = Enum.RotationType.CameraRelative
	end
end)