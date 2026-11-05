--!strict
-- The shoulder-shove every Runner has on F, whatever their kit (GAME_PLAN.md Section 2B:
-- "push competitors out from safe cover into active God reticles").
-- It doesn't damage: it shoves the nearest Runner in front of you and staggers them briefly.
-- Iframes dodge it. Landed shoves count toward the "Shoves Landed" match stat and quests.
--
-- Replicated: player attribute ShoveReady = server time the shove is ready again.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local CombatService = require(script.Parent.CombatService)
local StatusEffectService = require(script.Parent.StatusEffectService)
local MovementService = require(script.Parent.MovementService)

local ShoveService = {}

-- (attacker: Player, victim: Model) after a shove lands.
ShoveService.Landed = Signal.new()

local function now(): number
	return workspace:GetServerTimeNow()
end

local function flat(v: Vector3): Vector3
	local f = Vector3.new(v.X, 0, v.Z)
	return if f.Magnitude > 0.01 then f.Unit else Vector3.zero
end

-- Living Runners (players and dummies) other than `character`.
local function candidates(character: Model): { Model }
	local list = {}
	for _, player in Players:GetPlayers() do
		local other = player.Character
		if other and other ~= character and Characters.GetRole(other) == "Runner" and Characters.IsAlive(other) then
			table.insert(list, other)
		end
	end
	local dummies = workspace:FindFirstChild("TestDummies")
	if dummies then
		for _, dummy in dummies:GetChildren() do
			if dummy:IsA("Model") and Characters.IsAlive(dummy) then
				table.insert(list, dummy)
			end
		end
	end
	return list
end

-- The nearest Runner inside the shove cone, or nil.
function ShoveService.FindTarget(character: Model, facing: Vector3): Model?
	local root = Characters.GetRoot(character)
	if not root then
		return nil
	end
	local cfg = MovementConfig.Shove
	local forward = flat(facing)
	if forward == Vector3.zero then
		forward = flat(root.CFrame.LookVector)
	end
	local best: Model? = nil
	local bestDistance = cfg.Range
	local cosLimit = math.cos(math.rad(cfg.Angle / 2))
	for _, other in candidates(character) do
		local otherRoot = Characters.GetRoot(other)
		if otherRoot then
			local offset = otherRoot.Position - root.Position
			local distance = offset.Magnitude
			local direction = flat(offset)
			if distance <= bestDistance and math.abs(offset.Y) < 6 and direction:Dot(forward) >= cosLimit then
				best = other
				bestDistance = distance
			end
		end
	end
	return best
end

-- Handles the "Shove" ability action. data.Direction is the client's camera look (validated).
function ShoveService.TryShove(player: Player, character: Model, data: { [string]: any })
	if player:GetAttribute("Role") == "God" or not Characters.IsAlive(character) then
		return
	end
	if not StatusEffectService.CanCast(character) or not StatusEffectService.CanMove(character) then
		return
	end
	local ready = player:GetAttribute("ShoveReady")
	if type(ready) == "number" and ready > now() then
		return
	end
	local cfg = MovementConfig.Shove
	if not MovementService.SpendStamina(player, cfg.StaminaCost, true) then
		Remotes.Event("AbilityFx"):FireClient(player, { Kind = "Toast", Text = "Not enough stamina!" })
		return
	end
	player:SetAttribute("ShoveReady", now() + cfg.Cooldown)

	local root = Characters.GetRoot(character) :: BasePart
	local look = data.Direction
	local facing = if typeof(look) == "Vector3" and look == look and look.Magnitude < 1e4 then look else root.CFrame.LookVector
	local target = ShoveService.FindTarget(character, facing)
	Remotes.Event("AbilityFx"):FireAllClients({ Kind = "Shove", Character = character, Target = target })
	if not target then
		return
	end
	local targetRoot = Characters.GetRoot(target) :: BasePart
	local push = flat(targetRoot.Position - root.Position)
	if push == Vector3.zero then
		push = flat(facing)
	end
	local landed = CombatService.Afflict(player, target, {
		Stun = cfg.Stun,
		Knockback = { Direction = push, Power = cfg.Power, Lift = cfg.Lift, Duration = 0.3 },
	})
	if landed then
		ShoveService.Landed:Fire(player, target)
	end
end

function ShoveService.Init() end

function ShoveService.Start()
	Players.PlayerAdded:Connect(function(player)
		player.CharacterAdded:Connect(function()
			player:SetAttribute("ShoveReady", nil)
		end)
	end)
end

return ShoveService
