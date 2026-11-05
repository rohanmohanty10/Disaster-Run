--!strict
-- NewShiftlock: replaces the old shiftlock while this script is enabled.
-- Disable it to go back to the old system (PlayerModule MouseLockController on PC,
-- Replication's instant 1.75 offset on mobile/console). Nothing else needs changing.
--
-- PC: Shift toggles. Mouse locks to center with a dot reticle, character faces the camera,
-- shoulder offset eases in/out. Mobile/console: Replication still owns the toggle and the
-- rotation; this script only eases its shoulder offset (see the _G.NewShiftlock check there).

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

--========================= CONFIG =========================
local KEYBINDS       = { Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift }
local TWEEN_INFO     = TweenInfo.new(0.3, Enum.EasingStyle.Sine)
local DEFAULT_OFFSET = 1.75 -- used if Configuration["Shiftlock Offset"] is missing
local RETICLE_IMAGE  = "rbxassetid://72180088379655"
local RETICLE_SIZE   = UDim2.fromOffset(5, 5)
--==========================================================

local player = Players.LocalPlayer
local config = player:WaitForChild("Configuration", 10)

-- Shuts off the old PC shiftlock (MouseLockController listens for this and unbinds Shift)
-- and shows Roblox's own Shift Lock setting as "set by developer".
-- Shuts off the old PC shiftlock: MouseLockController rebinds its keys whenever BoundKeys
-- changes, so clearing it leaves Shift to this script. BoundKeys only exists on non-touch devices.
task.spawn(function()
	local mouseLock = player:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")
		:WaitForChild("CameraModule"):WaitForChild("MouseLockController")
	local boundKeys = mouseLock:WaitForChild("BoundKeys", 10) :: StringValue?
	if boundKeys then
		boundKeys.Value = ""
	end
end)

local state = {
	pcLocked = false,
	mobileFrame = 0, -- stamped by Replication's Shiftlock() every frame it's active
}
_G.NewShiftlock = state

local alpha = Instance.new("NumberValue") -- 0..1, how much of the shoulder offset is applied
local alphaTarget = 0

local function tweenAlpha(target: number)
	if target == alphaTarget then return end
	alphaTarget = target
	TweenService:Create(alpha, TWEEN_INFO, { Value = target }):Play()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NewShiftlockReticle"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.DisplayOrder = 1000

local reticle = Instance.new("ImageLabel")
reticle.AnchorPoint = Vector2.new(0.5, 0.5)
reticle.Position = UDim2.fromScale(0.5, 0.5)
reticle.Size = RETICLE_SIZE
reticle.BackgroundTransparency = 1
reticle.Image = RETICLE_IMAGE
reticle.Visible = false
reticle.Parent = gui
gui.Parent = player:WaitForChild("PlayerGui")

UserInputService.InputBegan:Connect(function(input, processed)
	if processed or not table.find(KEYBINDS, input.KeyCode) then return end
	state.pcLocked = not state.pcLocked
end)

local wasPcActive = false

-- Runs right after the camera module (Camera priority) so the offset sits on top of its CFrame
RunService:BindToRenderStep("NewShiftlock", Enum.RenderPriority.Camera.Value + 1, function()
	local camera = workspace.CurrentCamera
	local character = player.Character
	local scriptable = camera.CameraType == Enum.CameraType.Scriptable
	local pcActive = state.pcLocked and not scriptable
	local mobileActive = os.clock() - state.mobileFrame < 0.1

	if pcActive then
		local cantRotate = character ~= nil and (character:HasTag("CantRotate") or character:GetAttribute("SanjiDiveBomb") == true)
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		UserInputService.MouseIconEnabled = false
		UserGameSettings.RotationType = if cantRotate then Enum.RotationType.MovementRelative else Enum.RotationType.CameraRelative
	elseif wasPcActive then
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
		UserInputService.MouseIconEnabled = true
		UserGameSettings.RotationType = Enum.RotationType.MovementRelative
	end
	wasPcActive = pcActive
	reticle.Visible = pcActive

	tweenAlpha(if pcActive or mobileActive then 1 else 0)

	if alpha.Value <= 0 or scriptable then return end
	if (camera.Focus.Position - camera.CFrame.Position).Magnitude < 1 then return end -- first person

	local offsetValue = config and config:FindFirstChild("Shiftlock Offset") :: NumberValue?
	local shoulder = if offsetValue then offsetValue.Value else DEFAULT_OFFSET
	-- Shift Focus with the camera, like Roblox's shiftlock; otherwise CameraRelative
	-- turns the character toward the unshifted Focus and it ends up angled left
	local shift = camera.CFrame.RightVector * shoulder * alpha.Value
	camera.CFrame += shift
	camera.Focus += shift
end)