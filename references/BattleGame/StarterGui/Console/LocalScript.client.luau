-- Services

local UIS = game:GetService("UserInputService")


-- GUI

local MainFrame = script.Parent:WaitForChild("ConsoleControls")

local JumpIcon = MainFrame:WaitForChild("Jump"):WaitForChild("Icon")
local DashIcon = MainFrame:WaitForChild("Dash"):WaitForChild("Icon")
local BlockIcon = MainFrame:WaitForChild("Block"):WaitForChild("Icon")
local M1Icon = MainFrame:WaitForChild("M1"):WaitForChild("Icon")
local LockOnIcon = MainFrame:WaitForChild("LockOn"):WaitForChild("Icon")
local ShiftlockIcon = MainFrame:WaitForChild("Shiftlock"):WaitForChild("Icon")


-- Runtime

local function UpdateUI()
    JumpIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.ButtonA) -- Jump
    DashIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.ButtonY) -- Dash
    BlockIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.ButtonX) -- Block
    M1Icon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.ButtonB) -- Punch
	--LockOnIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.Thumbstick1) -- LockOn
	LockOnIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.ButtonL3) -- LockOn

    ShiftlockIcon.Image = UIS:GetImageForKeyCode(Enum.KeyCode.DPadLeft) -- Shiftlock
end


UIS.GamepadConnected:Connect(function()
	UpdateUI()
end)

UIS.GamepadDisconnected:Connect(function()
    MainFrame.Visible = false
end)


UpdateUI()