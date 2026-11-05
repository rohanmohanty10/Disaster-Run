--!strict
-- Shared UI behaviour: HUD buttons, opening/closing screens, toast pop-ups,
-- button hover/press animations, sounds and stroke scaling across screen sizes.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local UIConfig = require(ReplicatedStorage.Shared.Config.UIConfig)
local Format = require(ReplicatedStorage.Shared.Util.Format)

local DataController = require(script.Parent.DataController)

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") :: PlayerGui

local UIController = {}

-- Screens opened from HUD buttons: [button frame name] = { open = fn, close = fn, isOpen = fn }
type Screen = { Open: () -> (), Close: () -> (), IsOpen: () -> boolean }
local screens: { [string]: Screen } = {}

local toastGui: ScreenGui
local toastHolder: Frame
local blur: BlurEffect? = nil

-- ------------------------------------------------------------------ sounds
local soundCache: { [string]: Sound } = {}

function UIController.PlaySound(name: string, speed: number?)
	local id = (UIConfig.Sounds :: any)[name]
	if not id then
		return
	end
	local sound = soundCache[name]
	if not sound then
		sound = Instance.new("Sound")
		sound.SoundId = id
		sound.Volume = 0.5
		sound.Parent = SoundService
		soundCache[name] = sound
	end
	local s = sound :: Sound
	s.PlaybackSpeed = speed or 1
	SoundService:PlayLocalSound(s)
end

-- ------------------------------------------------------------------ toasts
-- Short message at the top of the screen (the vault screens' "Effects:Popup").
function UIController.Popup(text: string, duration: number?, color: Color3?)
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 0)
	label.AutomaticSize = Enum.AutomaticSize.Y
	label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
	label.TextScaled = false
	label.TextSize = 26
	label.TextWrapped = true
	label.TextColor3 = color or Color3.new(1, 1, 1)
	label.TextTransparency = 1
	label.Text = text
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Transparency = 1
	stroke.Parent = label
	label.Parent = toastHolder

	local info = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(label, info, { TextTransparency = 0 }):Play()
	TweenService:Create(stroke, info, { Transparency = 0 }):Play()
	task.delay(duration or 2, function()
		local fade = TweenInfo.new(0.35)
		TweenService:Create(label, fade, { TextTransparency = 1 }):Play()
		TweenService:Create(stroke, fade, { Transparency = 1 }):Play()
		task.wait(0.35)
		label:Destroy()
	end)
end

local function buildToasts()
	toastGui = Instance.new("ScreenGui")
	toastGui.Name = "Toasts"
	toastGui.ResetOnSpawn = false
	toastGui.DisplayOrder = 100
	toastGui.IgnoreGuiInset = true
	toastGui.Parent = PlayerGui

	toastHolder = Instance.new("Frame")
	toastHolder.BackgroundTransparency = 1
	toastHolder.AnchorPoint = Vector2.new(0.5, 0)
	toastHolder.Position = UDim2.fromScale(0.5, 0.12)
	toastHolder.Size = UDim2.fromScale(0.6, 0.4)
	toastHolder.Parent = toastGui
	local layout = Instance.new("UIListLayout")
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	layout.Padding = UDim.new(0, 4)
	layout.Parent = toastHolder
end

-- ------------------------------------------------------------------ focus / blur
-- Background blur + pop-in for a menu frame (the reference UIController's Focus()).
function UIController.Focus(open: boolean, frame: GuiObject?)
	local camera = workspace.CurrentCamera
	if open then
		if not blur then
			local b = Instance.new("BlurEffect")
			b.Size = 0
			b.Parent = Lighting
			blur = b
		end
		TweenService:Create(blur :: BlurEffect, TweenInfo.new(0.3), { Size = 15 }):Play()
		local scale = frame and frame:FindFirstChildOfClass("UIScale")
		if scale then
			scale.Scale = 0
			TweenService:Create(scale, TweenInfo.new(0.15, Enum.EasingStyle.Sine), { Scale = 1 }):Play()
		end
		TweenService:Create(camera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { FieldOfView = 90 }):Play()
	else
		if blur then
			TweenService:Create(blur, TweenInfo.new(0.3), { Size = 0 }):Play()
		end
		TweenService:Create(camera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { FieldOfView = 70 }):Play()
	end
end

-- ------------------------------------------------------------------ buttons
-- Hover / press scale animation. Animates the button's own UIScale, or its parent frame's.
function UIController.AnimateButton(button: GuiButton, target: GuiObject?)
	local owner = target or button
	local scale = owner:FindFirstChildOfClass("UIScale")
	if not scale then
		scale = Instance.new("UIScale")
		scale.Parent = owner
	end
	local s = scale :: UIScale
	local icon = owner:FindFirstChild("Icon")
	local iconScale = icon and icon:FindFirstChildOfClass("UIScale")
	local hovering = false
	local function tweenTo(value: number, iconValue: number, time: number, style: Enum.EasingStyle)
		TweenService:Create(s, TweenInfo.new(time, style, Enum.EasingDirection.Out), { Scale = value }):Play()
		if iconScale then
			TweenService:Create(iconScale, TweenInfo.new(time, style, Enum.EasingDirection.Out), { Scale = iconValue }):Play()
		end
	end
	button.MouseEnter:Connect(function()
		hovering = true
		tweenTo(1.08, 1.18, 0.16, Enum.EasingStyle.Back)
	end)
	button.MouseLeave:Connect(function()
		hovering = false
		tweenTo(1, 1, 0.14, Enum.EasingStyle.Quad)
	end)
	button.MouseButton1Down:Connect(function()
		tweenTo(0.98, 1.04, 0.07, Enum.EasingStyle.Quad)
	end)
	button.MouseButton1Up:Connect(function()
		tweenTo(if hovering then 1.08 else 1, if hovering then 1.18 else 1, 0.18, Enum.EasingStyle.Quad)
	end)
end

-- Pulsing glow + bobbing "!" on a HUD button (reference UIController's Alert()).
function UIController.Alert(frame: Instance, on: boolean)
	local glow = frame:FindFirstChild("GlowOutline") :: ImageLabel?
	local alert = frame:FindFirstChild("Alert") :: GuiObject?
	if not glow or not alert then
		return
	end
	if not on then
		frame:SetAttribute("Alert", nil)
		glow.Visible = false
		alert.Visible = false
		return
	end
	if frame:GetAttribute("Alert") then
		return
	end
	frame:SetAttribute("Alert", true)
	glow.Visible = true
	alert.Visible = true
	local glowScale = glow:FindFirstChildOfClass("UIScale")
	local home = alert.Position
	task.spawn(function()
		while frame.Parent and frame:GetAttribute("Alert") do
			if glowScale then
				glowScale.Scale = 0.5
				TweenService:Create(glowScale, TweenInfo.new(0.72, Enum.EasingStyle.Quad), { Scale = 0.9 }):Play()
			end
			glow.ImageTransparency = 1
			TweenService:Create(glow, TweenInfo.new(0.45, Enum.EasingStyle.Quad), { ImageTransparency = 0.25 }):Play()
			task.delay(0.62, function()
				TweenService:Create(glow, TweenInfo.new(0.25, Enum.EasingStyle.Quad), { ImageTransparency = 1 }):Play()
			end)
			local up = TweenService:Create(alert, TweenInfo.new(0.4, Enum.EasingStyle.Sine), {
				Position = UDim2.new(home.X.Scale, home.X.Offset, home.Y.Scale - 0.05, home.Y.Offset),
			})
			up:Play()
			task.wait(0.4)
			TweenService:Create(alert, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { Position = home }):Play()
			task.wait(0.4)
		end
		alert.Position = home
	end)
end

-- ------------------------------------------------------------------ strokes
-- Keeps UIStroke thickness consistent on every screen size (reference UIStrokes module).
local function scaleStroke(stroke: UIStroke)
	local base = stroke:GetAttribute("BaseThickness")
	if base == nil then
		base = stroke.Thickness
		stroke:SetAttribute("BaseThickness", base)
	end
	local viewport = workspace.CurrentCamera.ViewportSize
	local design = UIConfig.DesignResolution
	local ratio = math.min(viewport.X, viewport.Y) / math.min(design.X, design.Y)
	stroke.Thickness = (base :: number) * ratio
end

local function setupStrokes()
	for _, d in PlayerGui:GetDescendants() do
		if d:IsA("UIStroke") then
			scaleStroke(d)
		end
	end
	PlayerGui.DescendantAdded:Connect(function(d)
		if d:IsA("UIStroke") then
			scaleStroke(d)
		end
	end)
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		for _, d in PlayerGui:GetDescendants() do
			if d:IsA("UIStroke") then
				scaleStroke(d)
			end
		end
	end)
end

-- ------------------------------------------------------------------ HUD
function UIController.GetHUD(): ScreenGui
	return PlayerGui:WaitForChild("HUD") :: ScreenGui
end

function UIController.SetHUDVisible(visible: boolean)
	UIController.GetHUD().Enabled = visible
end

-- A HUD button frame (HUD.Buttons[name]) opens this screen.
function UIController.RegisterScreen(name: string, screen: Screen)
	screens[name] = screen
end

-- Closes every registered screen and shows the HUD again.
function UIController.CloseAll()
	for _, screen in screens do
		if screen.IsOpen() then
			screen.Close()
		end
	end
end

local function popInHUD(hud: ScreenGui)
	local buttons = hud:FindFirstChild("Buttons") :: Frame?
	if not buttons then
		return
	end
	local frames = {}
	for _, child in buttons:GetChildren() do
		if child:IsA("Frame") and child:FindFirstChildOfClass("UIScale") then
			table.insert(frames, child)
		end
	end
	table.sort(frames, function(a, b)
		return a.LayoutOrder < b.LayoutOrder
	end)
	for _, frame in frames do
		local scale = frame:FindFirstChildOfClass("UIScale") :: UIScale
		scale.Scale = 0
	end
	for i, frame in frames do
		if not hud.Enabled then
			return
		end
		UIController.PlaySound("Click", 1 + i * 0.03)
		TweenService:Create(frame:FindFirstChildOfClass("UIScale") :: UIScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
		task.wait(0.055)
	end
end

local function setupHUD()
	local hud = UIController.GetHUD()
	local buttons = hud:WaitForChild("Buttons")
	for _, frame in buttons:GetChildren() do
		local button = frame:FindFirstChild("ImageButton")
		if frame:IsA("Frame") and button and button:IsA("GuiButton") then
			UIController.AnimateButton(button, frame)
			button.Activated:Connect(function()
				local screen = screens[frame.Name]
				if not screen then
					UIController.Popup("Coming soon!")
					return
				end
				UIController.CloseAll()
				screen.Open()
			end)
		end
	end

	local amount = hud:FindFirstChild("Amount", true) :: TextLabel?
	local function updateCash(data)
		if amount then
			amount.Text = Format.Cash(data.Cash or 0)
		end
	end
	DataController.Changed:Connect(updateCash)
	if DataController.Data then
		updateCash(DataController.Data)
	end

	hud:GetPropertyChangedSignal("Enabled"):Connect(function()
		if hud.Enabled then
			task.spawn(popInHUD, hud)
		end
	end)
	hud.Enabled = true
	task.spawn(popInHUD, hud)
end

function UIController.Init()
	buildToasts()
	Remotes.Event("Notify").OnClientEvent:Connect(function(text: string, color: Color3?)
		UIController.Popup(text, 2.5, color)
	end)
end

function UIController.Start()
	setupHUD()
	setupStrokes()
end

return UIController
