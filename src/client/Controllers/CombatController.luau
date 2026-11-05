--!strict
-- Client side of combat:
--   * applies knockback and ragdoll to the local player's own character (the client owns it),
--   * shows "DODGED" and damage pop-ups from server hit feedback,
--   * plays the Infinite Void screen effect while the local character has that state.

local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local Audio = require(script.Parent.Audio)
local Knockback = require(ReplicatedStorage.Shared.Util.Knockback)

local LocalPlayer = Players.LocalPlayer

local CombatController = {}

local function localHumanoid(): (Model?, Humanoid?)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	return character, humanoid
end

-- ------------------------------------------------------------------ ragdoll
local function setRagdoll(on: boolean)
	local character, humanoid = localHumanoid()
	if not character or not humanoid then
		return
	end
	humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, not on)
	humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, not on)
	if on then
		humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		return
	end
	if humanoid.Health <= 0 then
		return
	end
	-- Stand back up where the body landed, facing the same way.
	local root = humanoid.RootPart
	if root then
		local look = root.CFrame.LookVector * Vector3.new(1, 0, 1)
		if look.Magnitude < 0.01 then
			look = Vector3.new(0, 0, -1)
		end
		local params = RaycastParams.new()
		params.FilterDescendantsInstances = { character }
		local ray = workspace:Raycast(root.Position, Vector3.new(0, -6, 0), params)
		local y = if ray then ray.Position.Y + humanoid.HipHeight + root.Size.Y / 2 else root.Position.Y
		local position = Vector3.new(root.Position.X, y, root.Position.Z)
		character:PivotTo(CFrame.lookAt(position, position + look.Unit))
		root.AssemblyLinearVelocity = Vector3.zero
		root.AssemblyAngularVelocity = Vector3.zero
	end
	humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

-- ------------------------------------------------------------------ pop-ups
local function popup(position: Vector3, text: string, color: Color3)
	local anchor = Instance.new("Part")
	anchor.Anchored = true
	anchor.CanCollide = false
	anchor.CanQuery = false
	anchor.CanTouch = false
	anchor.Transparency = 1
	anchor.Size = Vector3.one * 0.2
	anchor.Position = position + Vector3.new(math.random(-10, 10) / 10, 2.5, 0)
	anchor.Parent = workspace

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.fromOffset(160, 50)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 250
	billboard.Parent = anchor
	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	label.TextScaled = true
	label.TextColor3 = color
	label.Text = text
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Parent = label
	label.Parent = billboard

	TweenService:Create(anchor, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = anchor.Position + Vector3.new(0, 2.5, 0) }):Play()
	TweenService:Create(label, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { TextTransparency = 1 }):Play()
	TweenService:Create(stroke, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Transparency = 1 }):Play()
	task.delay(0.85, function()
		anchor:Destroy()
	end)
end

local function onFeedback(info: { [string]: any })
	if type(info) ~= "table" or typeof(info.Position) ~= "Vector3" then
		return
	end
	if info.Kind == "Dodged" then
		popup(info.Position, "DODGED", Color3.fromRGB(120, 220, 255))
	elseif info.Kind == "Damage" and type(info.Amount) == "number" then
		popup(info.Position, tostring(math.floor(info.Amount + 0.5)), Color3.fromRGB(255, 90, 90))
	end
end

-- ------------------------------------------------------------------ infinite void
local voidEffect: ColorCorrectionEffect? = nil

-- Greyed-out, high-contrast screen, a wide FOV and muted game audio (Audio.Group) while trapped
-- in the void.
local function setVoid(on: boolean)
	if on then
		if not voidEffect then
			local effect = Instance.new("ColorCorrectionEffect")
			effect.Name = "InfiniteVoid"
			effect.Parent = Lighting
			voidEffect = effect
		end
		local effect = voidEffect :: ColorCorrectionEffect
		effect.Enabled = true
		TweenService:Create(effect, TweenInfo.new(0.3), { Saturation = -1, Contrast = 0.8, TintColor = Color3.fromRGB(200, 170, 255) }):Play()
		TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { FieldOfView = 110 }):Play()
		Audio.FadeTo(0, 0.3)
	elseif voidEffect then
		Audio.FadeTo(1, 0.4)
		local effect = voidEffect
		TweenService:Create(effect, TweenInfo.new(0.4), { Saturation = 0, Contrast = 0, TintColor = Color3.new(1, 1, 1) }):Play()
		TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.4, Enum.EasingStyle.Sine), { FieldOfView = 70 }):Play()
		task.delay(0.4, function()
			if effect.Saturation > -0.05 then
				effect.Enabled = false
			end
		end)
	end
end

local function watchCharacter(character: Model)
	setVoid(false)
	character:GetAttributeChangedSignal("InfiniteVoid"):Connect(function()
		setVoid(character:GetAttribute("InfiniteVoid") == true)
	end)
end

function CombatController.Init()
	Remotes.Event("Knockback").OnClientEvent:Connect(function(velocity: Vector3, duration: number)
		local character = LocalPlayer.Character
		if character and typeof(velocity) == "Vector3" and type(duration) == "number" then
			Knockback.Push(character, velocity, math.clamp(duration, 0, 2))
		end
	end)
	Remotes.Event("Ragdoll").OnClientEvent:Connect(function(on: boolean)
		setRagdoll(on == true)
	end)
	Remotes.Event("CombatFeedback").OnClientEvent:Connect(onFeedback)
end

function CombatController.Start()
	if LocalPlayer.Character then
		watchCharacter(LocalPlayer.Character)
	end
	LocalPlayer.CharacterAdded:Connect(watchCharacter)
end

return CombatController
