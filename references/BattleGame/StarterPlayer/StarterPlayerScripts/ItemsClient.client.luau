-- StarterPlayer > StarterPlayerScripts > ItemClient   (LocalScript, client)
--
-- Controls for the item in your hand (see ServerStorage > SBGModules > ItemService):
--   M1 / R2           use it (shoot the sniper, throw the cola bomb) where you aim
--   hold RMB / L2     look down the sniper's scope
--   Backspace / DPad down   drop it
-- Also puts the item in a slot after your moves in the hotbar (name, ammo, cooldown, controls
-- tip) while you hold one, and plays
-- the item's own animations (Animation objects inside its model in Assets > Items):
--   Idle standing, Walk walking, Run sprinting, AimIn then AimIdle while scoped, Reload after a shot.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local ItemConfig = require(ReplicatedStorage.Modules:WaitForChild("ItemConfig"))
local ItemModels = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Items")
local UseRemote: RemoteEvent = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Items"):WaitForChild("Use")

-- Load the item models and explosion particles now, not the first time one shows up: loading the
-- Den Den Mushi and the Buster Call explosions mid-fight froze the game for about half a second.
task.spawn(function()
	local Effects = ReplicatedStorage.Assets:FindFirstChild("Effects")
	pcall(game:GetService("ContentProvider").PreloadAsync, game:GetService("ContentProvider"), {
		ItemModels,
		Effects and Effects:FindFirstChild("Items"),
	})
end)

local DEFAULT_MOVES = { idle = true, walk = true, run = true } -- Animate's folders the item replaces
local SCOPE_FOV = 12
local SCOPE_SENSITIVITY = 0.15 -- mouse speed while scoped, compared to normal
local AIM_RANGE = 1500

------------------------------------------------------------------------
-- The item's slot in your hotbar (after your moves), the way JJS shows a held item: a copy of
-- your own move slot with the item's name, "M1" as its key, ammo in the corner, your red
-- cooldown sweep after each shot, and the controls as a small tip (on hover, and the first time
-- you hold each item).
------------------------------------------------------------------------
local TweenService = game:GetService("TweenService")

local Slot: Frame? = nil
local SlotAmmo: TextLabel? = nil
local SlotTip: TextLabel? = nil
local SeenTip: { [string]: boolean } = {}
local TipToken = 0

local function HotbarRow(): Frame?
	local Gui = Player.PlayerGui:FindFirstChild("Hotbar")
	return Gui and Gui:FindFirstChild("Hotbar") :: Frame?
end

local function ShowTip(Seconds: number?)
	local Tip = SlotTip
	if not Tip then
		return
	end
	TipToken += 1
	local Mine = TipToken
	Tip.Visible = true
	if Seconds then
		task.delay(Seconds, function()
			if TipToken == Mine then
				Tip.Visible = false
			end
		end)
	end
end

-- (re)makes the slot; the hotbar is rebuilt when you respawn, so this is checked every time
local function ItemSlot(): Frame?
	if Slot and Slot.Parent then
		return Slot
	end
	local Row = HotbarRow()
	local Template = Row and (Row:FindFirstChild("1") or Row:FindFirstChild("2"))
	if not (Row and Template and Template:FindFirstChild("Base")) then
		return nil
	end
	local New = Template:Clone()
	New.Name = "Item"
	New.LayoutOrder = 100 -- after every move slot
	New.Visible = false
	local Base = New:FindFirstChild("Base") :: TextButton
	for _, Child in Base:GetChildren() do -- clear anything the move slot was showing
		if Child.Name == "Cooldown" then
			Child:Destroy()
		end
	end
	for _, Name in { "Bar", "Description" } do
		local Child = Base:FindFirstChild(Name)
		if Child and Child:IsA("GuiObject") then
			Child.Visible = false
		end
	end
	local Key = Base:FindFirstChild("Number")
	if Key and Key:IsA("TextLabel") then
		Key.Text = "M1"
	end

	local Name = Base:FindFirstChild("ToolName") :: TextLabel?
	local Ammo = Instance.new("TextLabel")
	Ammo.Name = "Ammo"
	Ammo.BackgroundTransparency = 1
	Ammo.AnchorPoint = Vector2.new(1, 1)
	Ammo.Position = UDim2.new(1, -3, 1, -2)
	Ammo.Size = UDim2.fromScale(0.6, 0.27)
	Ammo.TextScaled = true
	Ammo.TextXAlignment = Enum.TextXAlignment.Right
	Ammo.FontFace = if Name then Name.FontFace else Font.fromEnum(Enum.Font.SourceSansBold)
	Ammo.FontFace = Font.new(Ammo.FontFace.Family, Enum.FontWeight.Bold)
	Ammo.TextColor3 = Color3.fromRGB(255, 214, 90)
	Ammo.TextStrokeTransparency = 0.3
	Ammo.ZIndex = Base.ZIndex + 2
	Ammo.Parent = Base

	local Tip = Instance.new("TextLabel")
	Tip.Name = "Tip"
	Tip.AnchorPoint = Vector2.new(0.5, 1)
	Tip.Position = UDim2.new(0.5, 0, 0, -24) -- above the slot's key number
	Tip.AutomaticSize = Enum.AutomaticSize.X
	Tip.Size = UDim2.fromOffset(0, 24)
	Tip.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	Tip.BackgroundTransparency = 0.25
	Tip.BorderSizePixel = 0
	Tip.TextSize = 15
	Tip.FontFace = Ammo.FontFace
	Tip.TextColor3 = Color3.new(1, 1, 1)
	Tip.Visible = false
	Tip.ZIndex = Base.ZIndex + 10
	local Pad = Instance.new("UIPadding")
	Pad.PaddingLeft, Pad.PaddingRight = UDim.new(0, 8), UDim.new(0, 8)
	Pad.Parent = Tip
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 6)
	Corner.Parent = Tip
	Tip.Parent = New
	Base.MouseEnter:Connect(function()
		ShowTip()
	end)
	Base.MouseLeave:Connect(function()
		TipToken += 1
		Tip.Visible = false
	end)

	New.Parent = Row
	Slot, SlotAmmo, SlotTip = New, Ammo, Tip
	return New
end

-- your hotbar's red cooldown sweep (the Handler's Cooldown template), over the item slot
local function SlotCooldown(Duration: number)
	local Frame = ItemSlot()
	local Base = Frame and Frame:FindFirstChild("Base") :: GuiObject?
	local Handler = Player.PlayerGui:FindFirstChild("Hotbar") and Player.PlayerGui.Hotbar:FindFirstChild("Handler")
	local Template = Handler and Handler:FindFirstChild("Cooldown")
	if not (Base and Template) then
		return
	end
	local Old = Base:FindFirstChild("Cooldown")
	if Old then
		Old:Destroy()
	end
	local Sweep = Template:Clone() :: Frame
	Sweep.Name = "Cooldown"
	Sweep.ZIndex = Base.ZIndex + 5
	Sweep.Visible = true
	Sweep.AnchorPoint = Vector2.new(0, 1)
	Sweep.Position = UDim2.fromScale(0, 1)
	Sweep.Size = UDim2.fromScale(1, 1)
	Sweep.Parent = Base
	TweenService:Create(Sweep, TweenInfo.new(Duration, Enum.EasingStyle.Linear), { Size = UDim2.fromScale(1, 0) }):Play()
	game:GetService("Debris"):AddItem(Sweep, Duration + 0.1)
end

-- the scope's crosshair: a thin cross and a dot in the middle of the screen
local Crosshair = Instance.new("ScreenGui")
Crosshair.Name = "SniperScope"
Crosshair.IgnoreGuiInset = true
Crosshair.ResetOnSpawn = false
Crosshair.Enabled = false
Crosshair.Parent = Player.PlayerGui
for _, Line in { { UDim2.new(1, 0, 0, 1) }, { UDim2.new(0, 1, 1, 0) }, { UDim2.fromOffset(4, 4) } } do
	local Frame = Instance.new("Frame")
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.fromScale(0.5, 0.5)
	Frame.Size = Line[1]
	Frame.BackgroundColor3 = Color3.new(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Parent = Crosshair
end
local Ring = Instance.new("Frame")
Ring.AnchorPoint = Vector2.new(0.5, 0.5)
Ring.Position = UDim2.fromScale(0.5, 0.5)
Ring.Size = UDim2.fromScale(0.9, 0.9)
Ring.BackgroundTransparency = 1
Ring.Parent = Crosshair
local RingShape = Instance.new("UIAspectRatioConstraint")
RingShape.Parent = Ring
local RingCorner = Instance.new("UICorner")
RingCorner.CornerRadius = UDim.new(0.5, 0)
RingCorner.Parent = Ring
local RingStroke = Instance.new("UIStroke")
RingStroke.Thickness = 3
RingStroke.Parent = Ring

------------------------------------------------------------------------
-- The held item's animations (played on your character, so everyone sees them)
------------------------------------------------------------------------
local Tracks: { [string]: AnimationTrack } = {}
local AnimatedId: string? = nil -- the item the loaded tracks belong to

-- While this is set (only on your own screen), the Client script stops the character's normal
-- idle/walk/run, so only the item's own Idle/Walk/Run play until you stop holding it.
local function SetItemAnimating(On: boolean)
	if Player.Character then
		Player.Character:SetAttribute("ItemAnimating", if On then true else nil)
	end
end

local function StopTracks()
	for _, Track in Tracks do
		Track:Stop(0.15)
	end
	table.clear(Tracks)
	AnimatedId = nil
	SetItemAnimating(false)
end

local function LoadTracks(Id: string)
	StopTracks()
	local Info = ItemConfig.Get(Id)
	local Model = Info and ItemModels:FindFirstChild(Info.Model)
	local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
	local Animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
	if not (Model and Animator) then
		return
	end
	for _, Animation in Model:GetChildren() do
		if Animation:IsA("Animation") then
			Tracks[Animation.Name] = Animator:LoadAnimation(Animation)
		end
	end
	AnimatedId = Id
	-- set here so it doesn't matter what they were uploaded with
	for Name, Priority in { Idle = Enum.AnimationPriority.Idle, Walk = Enum.AnimationPriority.Movement, Run = Enum.AnimationPriority.Movement, AimIn = Enum.AnimationPriority.Action, AimIdle = Enum.AnimationPriority.Action } do
		if Tracks[Name] then
			Tracks[Name].Priority = Priority
			Tracks[Name].Looped = Name ~= "AimIn"
		end
	end
	if Tracks.Reload then
		Tracks.Reload.Priority = Enum.AnimationPriority.Action2 -- on top of AimIdle when you shoot scoped
	end
	if Tracks.Idle then
		Tracks.Idle:Play(0.2)
	end
	SetItemAnimating(Tracks.Idle ~= nil or Tracks.Walk ~= nil or Tracks.Run ~= nil)
end

local function Play(Name: string, Restart: boolean?)
	local Track = Tracks[Name]
	if Track and (Restart or not Track.IsPlaying) then
		Track:Play(0.15)
	end
end

local function Stop(Name: string)
	local Track = Tracks[Name]
	if Track and Track.IsPlaying then
		Track:Stop(0.15)
	end
end

------------------------------------------------------------------------
-- Scope
------------------------------------------------------------------------
local Scoped = false
local SavedSensitivity = UserInputService.MouseDeltaSensitivity
local SavedFov = 70
local ScopeConnection: RBXScriptConnection?

local function SetScope(On: boolean)
	if Scoped == On then
		return
	end
	Scoped = On
	UseRemote:FireServer("Scope", On)
	local Camera = workspace.CurrentCamera
	if On then
		-- raise the gun, then hold it there
		local AimIn = Tracks.AimIn
		if AimIn then
			AimIn:Play(0.1)
			AimIn.Stopped:Once(function()
				if Scoped then
					Play("AimIdle")
				end
			end)
		else
			Play("AimIdle")
		end
		SavedSensitivity = UserInputService.MouseDeltaSensitivity
		SavedFov = Camera.FieldOfView
		Player.CameraMode = Enum.CameraMode.LockFirstPerson
		UserInputService.MouseDeltaSensitivity = SavedSensitivity * SCOPE_SENSITIVITY
		Crosshair.Enabled = true
		ScopeConnection = RunService.RenderStepped:Connect(function()
			local Humanoid = Player.Character and Player.Character:FindFirstChildOfClass("Humanoid")
			if Humanoid then
				Humanoid.CameraOffset = Vector3.zero -- no shift-lock offset while looking down the scope
			end
			Camera.FieldOfView = SCOPE_FOV
		end)
	else
		Stop("AimIn")
		Stop("AimIdle")
		if ScopeConnection then
			ScopeConnection:Disconnect()
			ScopeConnection = nil
		end
		Crosshair.Enabled = false
		Player.CameraMode = Enum.CameraMode.Classic
		UserInputService.MouseDeltaSensitivity = SavedSensitivity
		Camera.FieldOfView = SavedFov
		-- first person leaves the camera zoomed all the way in; push it back out
		local MinZoom = Player.CameraMinZoomDistance
		Player.CameraMinZoomDistance = 10
		task.wait(0.1)
		Player.CameraMinZoomDistance = MinZoom
	end
end

------------------------------------------------------------------------
-- Aiming: what's under the crosshair (scoped) or the mouse (not scoped)
------------------------------------------------------------------------
local function AimPoint(): Vector3
	local Camera = workspace.CurrentCamera
	local Screen = if Scoped or UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
		then Camera.ViewportSize / 2
		else UserInputService:GetMouseLocation()
	local Ray = Camera:ViewportPointToRay(Screen.X, Screen.Y)
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	local World = workspace:FindFirstChild("World")
	Params.FilterDescendantsInstances = {
		Player.Character,
		World and World:FindFirstChild("Visuals"),
		World and World:FindFirstChild("ItemPickups"),
	}
	local Hit = workspace:Raycast(Ray.Origin, Ray.Direction * AIM_RANGE, Params)
	return if Hit then Hit.Position else Ray.Origin + Ray.Direction * AIM_RANGE
end

------------------------------------------------------------------------
-- Following the item in your hand
------------------------------------------------------------------------
local function Holding(): string?
	return Player.Character and Player.Character:GetAttribute("HeldItem")
end

local function Refresh()
	local Character = Player.Character
	local Id = Holding()
	local Info = Id and ItemConfig.Get(Id)
	local Frame = ItemSlot()
	if Frame then
		Frame.Visible = Info ~= nil
		if Info and Character then
			local Name = Frame:FindFirstChild("Base") and Frame.Base:FindFirstChild("ToolName")
			if Name and Name:IsA("TextLabel") then
				Name.Text = Info.Name
			end
			if SlotAmmo then -- one-use items (the Cola Bomb) don't need an ammo count
				SlotAmmo.Text = if Info.Ammo > 1 then `{Character:GetAttribute("ItemAmmo") or Info.Ammo}/{Info.Ammo}` else ""
			end
			if SlotTip then
				SlotTip.Text = Info.Controls
			end
			if not SeenTip[Id] then -- first time holding this item: show the controls for a bit
				SeenTip[Id] = true
				ShowTip(5)
			end
		elseif SlotTip then
			SlotTip.Visible = false
		end
	end
	if Id ~= "Sniper" then
		task.spawn(SetScope, false)
	end
	if Id ~= AnimatedId then
		if Id then
			LoadTracks(Id)
		else
			StopTracks()
		end
	end
end

local function OnCharacter(Character: Model)
	task.spawn(SetScope, false)
	table.clear(Tracks) -- those belonged to the old character
	AnimatedId = nil
	Character:GetAttributeChangedSignal("HeldItem"):Connect(Refresh)
	Character:GetAttributeChangedSignal("ItemAmmo"):Connect(Refresh)
	-- knocked down or killed: the scope comes off
	Character.AncestryChanged:Connect(Refresh)
	local Humanoid = Character:WaitForChild("Humanoid", 10)
	if Humanoid then
		Humanoid.Died:Connect(function()
			task.spawn(SetScope, false)
		end)
	end
	Refresh()
end
Player.CharacterAdded:Connect(OnCharacter)
if Player.Character then
	OnCharacter(Player.Character)
end

RunService.Heartbeat:Connect(function()
	local Character = Player.Character
	if Scoped and Character and Character:HasTag("Ragdolled") then
		task.spawn(SetScope, false)
	end
	-- Idle standing still, Walk walking, Run sprinting, using the same checks as the Client script.
	-- Nothing in the air (your jump/fall animations play then). Scoped, you always Walk (AimIdle
	-- covers the upper body).
	local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (AnimatedId and Humanoid and Root) then
		return
	end
	local State = Humanoid:GetState()
	local InAir = State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall
	local Speed = (Root.AssemblyLinearVelocity * Vector3.new(1, 0, 1)).Magnitude
	local Moving = Humanoid.MoveDirection.Magnitude > 0.1 or Speed > 2
	local Sprinting = Character:GetAttribute("Running") == true and Humanoid.WalkSpeed > 16 and not Scoped

	local Wanted = nil -- the one of Idle/Walk/Run that should play right now
	if InAir or Character:HasTag("Ragdolled") then
		Wanted = nil
	elseif not Moving then
		Wanted = "Idle"
	elseif Sprinting and Tracks.Run then
		Wanted = "Run"
	else
		Wanted = if Tracks.Walk then "Walk" else "Run"
	end
	for _, Name in { "Idle", "Walk", "Run" } do
		if Name == Wanted then
			Play(Name)
		else
			Stop(Name)
		end
	end

	-- the default Animate script's idle/walk/run (its jump/fall/climb stay)
	local Animator = Humanoid:FindFirstChildOfClass("Animator")
	if Animator then
		for _, Track in Animator:GetPlayingAnimationTracks() do
			local Animation = Track.Animation
			local Folder = Animation and Animation.Parent
			if Folder and Folder.Parent and Folder.Parent.Name == "Animate" and DEFAULT_MOVES[Folder.Name] then
				Track:Stop(0)
			end
		end
	end
end)

-- HoldPose "ArmOut" (the Den Den Mushi): everyone holding one has their right arm held straight
-- out, like Roblox's default tool hold. The shoulder joint itself (C0) is turned while it's held,
-- which animations can't undo, and the arm's own animation is cleared each frame so it doesn't
-- swing; walking, idling and jumping still move the rest of the body normally. Put back after.
local ARM_OUT = CFrame.Angles(0, 0, math.pi / 2)
local LiveFolder = workspace:WaitForChild("World"):WaitForChild("Live")
local Posed: { [Motor6D]: CFrame } = {} -- shoulder -> its normal C0
-- characters sit in Live itself and in its folders (Live.Players, Live.Dummies)
local function LiveCharacters(): { Model }
	local Found = {}
	for _, Child in LiveFolder:GetChildren() do
		if Child:IsA("Model") then
			table.insert(Found, Child)
		elseif Child:IsA("Folder") then
			for _, Inner in Child:GetChildren() do
				if Inner:IsA("Model") then
					table.insert(Found, Inner)
				end
			end
		end
	end
	return Found
end
RunService.PreSimulation:Connect(function()
	local Still: { [Motor6D]: boolean } = {}
	for _, Other in LiveCharacters() do
		local Id = Other:GetAttribute("HeldItem")
		local Info = Id and ItemConfig.Get(Id)
		if Info and Info.HoldPose == "ArmOut" and not Other:HasTag("Ragdolled") then
			local Torso = Other:FindFirstChild("Torso")
			local Shoulder = Torso and Torso:FindFirstChild("Right Shoulder")
			if Shoulder and Shoulder:IsA("Motor6D") then
				if not Posed[Shoulder] then
					Posed[Shoulder] = Shoulder.C0
				end
				Shoulder.C0 = Posed[Shoulder] * ARM_OUT -- every frame, in case something resets the joint
				Shoulder.Transform = CFrame.identity
				Still[Shoulder] = true
			end
		end
	end
	for Shoulder, Normal in Posed do
		if not Still[Shoulder] then
			Posed[Shoulder] = nil
			if Shoulder.Parent then
				Shoulder.C0 = Normal
			end
		end
	end
end)

------------------------------------------------------------------------
-- Input
------------------------------------------------------------------------
local USE = { [Enum.UserInputType.MouseButton1] = true, [Enum.KeyCode.ButtonR2] = true }
local SCOPE = { [Enum.UserInputType.MouseButton2] = true, [Enum.KeyCode.ButtonL2] = true }
local DROP = { [Enum.KeyCode.Backspace] = true, [Enum.KeyCode.DPadDown] = true }

local NextShot = 0

local function Matches(List, Input: InputObject): boolean
	return List[Input.UserInputType] or List[Input.KeyCode] or false
end

UserInputService.InputBegan:Connect(function(Input, GameProcessed)
	local Id = Holding()
	if GameProcessed or not Id then
		return
	end
	if Matches(USE, Input) then
		UseRemote:FireServer("Use", AimPoint())
		-- the shot's recoil + bolt; same cooldown as the server so it only plays on real shots
		if Id == "Sniper" and os.clock() >= NextShot and not Player.Character:HasTag("Stunned") then
			NextShot = os.clock() + ItemConfig.Items.Sniper.ShotCooldown
			Play("Reload", true)
			SlotCooldown(ItemConfig.Items.Sniper.ShotCooldown)
		end
	elseif Matches(SCOPE, Input) and Id == "Sniper" then
		SetScope(true)
	elseif Matches(DROP, Input) then
		UseRemote:FireServer("Drop")
	end
end)

UserInputService.InputEnded:Connect(function(Input)
	if Matches(SCOPE, Input) then
		SetScope(false)
	end
end)
