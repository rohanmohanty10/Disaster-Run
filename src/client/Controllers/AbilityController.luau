--!strict
-- Ability input for both roles (ROADMAP step 2).
--   Runner: Q / E / R  -> skills 1 / 2 / 3 (aimed with the camera)
--   God:    1 - 5      -> skills 1 - 5     (aimed with the ground reticle)
-- Quick local checks (cooldown, stamina, stuns) avoid pointless requests; the server re-checks all.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)

local MovementController = require(script.Parent.MovementController)
local GodController = require(script.Parent.GodController)
local UIController = require(script.Parent.UIController)

local LocalPlayer = Players.LocalPlayer

local AbilityController = {}

local RUNNER_KEYS = { [Enum.KeyCode.Q] = 1, [Enum.KeyCode.E] = 2, [Enum.KeyCode.R] = 3 }
local GOD_KEYS = {
	[Enum.KeyCode.One] = 1,
	[Enum.KeyCode.Two] = 2,
	[Enum.KeyCode.Three] = 3,
	[Enum.KeyCode.Four] = 4,
	[Enum.KeyCode.Five] = 5,
}
local CAST_LOCKS = { "Stunned", "Silenced", "Ragdolled", "InfiniteVoid" }

local held: { [number]: boolean } = {}

local function role(): string?
	local r = LocalPlayer:GetAttribute("Role")
	return if type(r) == "string" then r else nil
end

-- The current kit for the local player's role.
function AbilityController.GetKit(): Kits.Kit?
	local r = role()
	if r ~= "God" and r ~= "Runner" then
		return nil
	end
	local kitId = LocalPlayer:GetAttribute(`Equipped{r}Kit`)
	return if type(kitId) == "string" then Kits.Get(r, kitId) else nil
end

-- Seconds until skill `index` is ready (0 if ready).
function AbilityController.CooldownLeft(index: number): number
	local ready = LocalPlayer:GetAttribute(`Cooldown{index}`)
	if type(ready) ~= "number" then
		return 0
	end
	return math.max(ready - workspace:GetServerTimeNow(), 0)
end

local function aimPoint(): Vector3?
	local camera = workspace.CurrentCamera
	local viewport = camera.ViewportSize
	local ray = camera:ViewportPointToRay(viewport.X / 2, viewport.Y / 2)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = if LocalPlayer.Character then { LocalPlayer.Character } else {}
	local result = workspace:Raycast(ray.Origin, ray.Direction * 300, params)
	return if result then result.Position else ray.Origin + ray.Direction * 60
end

local function canCastLocally(index: number): boolean
	local kit = AbilityController.GetKit()
	local skill = kit and kit.Skills[index]
	if not skill then
		return false
	end
	local character = LocalPlayer.Character
	if not character then
		return false
	end
	for _, lock in CAST_LOCKS do
		if character:GetAttribute(lock) then
			return false
		end
	end
	if AbilityController.CooldownLeft(index) > 0 then
		return false
	end
	if role() == "Runner" and skill.Cost > MovementController.Stamina then
		UIController.Popup("Not enough stamina!", 1, Color3.fromRGB(255, 120, 120))
		return false
	end
	if role() == "God" then
		local energy = (LocalPlayer:GetAttribute("Energy") :: number?) or 0
		if energy < skill.Cost then
			UIController.Popup("Not enough energy!", 1, Color3.fromRGB(255, 120, 120))
			return false
		end
	end
	return true
end

function AbilityController.Press(index: number)
	local r = role()
	if r == "God" then
		GodController.SetSelected(index)
		if not GodController.IsActive() or not canCastLocally(index) then
			return
		end
		held[index] = true
		Remotes.Event("Ability"):FireServer("Press", index, {
			Target = GodController.GetTarget(),
			Direction = GodController.GetDirection(),
		})
		-- Keep the server's aim point fresh while the key is held (charges, Meteor Fury).
		task.spawn(function()
			while held[index] do
				Remotes.Unreliable("Aim"):FireServer(GodController.GetTarget())
				task.wait(0.1)
			end
		end)
	elseif r == "Runner" then
		if not canCastLocally(index) then
			return
		end
		local character = LocalPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		held[index] = true
		Remotes.Event("Ability"):FireServer("Press", index, {
			Direction = workspace.CurrentCamera.CFrame.LookVector,
			Move = if humanoid then humanoid.MoveDirection else nil,
			Target = aimPoint(),
		})
	end
end

function AbilityController.Release(index: number)
	if not held[index] then
		return
	end
	held[index] = nil
	Remotes.Event("Ability"):FireServer("Release", index, {})
end

function AbilityController.Init() end

function AbilityController.Start()
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then
			return
		end
		local r = role()
		local index = if r == "God" then GOD_KEYS[input.KeyCode] elseif r == "Runner" then RUNNER_KEYS[input.KeyCode] else nil
		if index then
			AbilityController.Press(index)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		local index = GOD_KEYS[input.KeyCode] or RUNNER_KEYS[input.KeyCode]
		if index then
			AbilityController.Release(index)
		end
	end)
	LocalPlayer:GetAttributeChangedSignal("Role"):Connect(function()
		table.clear(held)
	end)
end

return AbilityController
