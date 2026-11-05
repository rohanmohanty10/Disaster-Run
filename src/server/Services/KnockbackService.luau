--!strict
-- Knockback. Players simulate their own character, so a player's knockback is sent to their
-- client (CombatController applies it); NPCs and dummies are pushed here on the server.
-- Old movers are cleared first so repeated knockbacks never stack into a fling.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Knockback = require(ReplicatedStorage.Shared.Util.Knockback)
local MoveGrace = require(ReplicatedStorage.Shared.Util.MoveGrace)

export type Options = {
	Velocity: Vector3?, -- exact velocity, or...
	From: Vector3?, -- ...push away from this point
	Direction: Vector3?, -- ...or along this direction
	Power: number?, -- horizontal speed (studs/s) for From / Direction
	Lift: number?, -- upward speed (studs/s)
	Duration: number?, -- seconds the push lasts (default 0.25)
}

local KnockbackService = {}

-- Works out the final velocity from the options.
function KnockbackService.Resolve(character: Model, options: Options): Vector3?
	if options.Velocity then
		return options.Velocity
	end
	local root = Characters.GetRoot(character)
	if not root then
		return nil
	end
	local direction = options.Direction
	if not direction and options.From then
		direction = root.Position - options.From
	end
	local flat = if direction then direction * Vector3.new(1, 0, 1) else Vector3.zero
	if flat.Magnitude < 0.01 then
		flat = -root.CFrame.LookVector * Vector3.new(1, 0, 1)
	end
	local velocity = flat.Unit * (options.Power or 40) + Vector3.new(0, options.Lift or 0, 0)
	if velocity.Magnitude > CombatConfig.MaxKnockbackSpeed then
		velocity = velocity.Unit * CombatConfig.MaxKnockbackSpeed
	end
	return velocity
end

function KnockbackService.Apply(character: Model, options: Options): boolean
	if not Characters.IsAlive(character) then
		return false
	end
	local velocity = KnockbackService.Resolve(character, options)
	if not velocity then
		return false
	end
	local duration = options.Duration or 0.25
	local player = Players:GetPlayerFromCharacter(character)
	if player then
		MoveGrace.Grant(character, duration + 1)
		Remotes.Event("Knockback"):FireClient(player, velocity, duration)
	else
		local root = Characters.GetRoot(character)
		if root and root:CanSetNetworkOwnership() then
			root:SetNetworkOwner(nil)
		end
		Knockback.Push(character, velocity, duration)
	end
	return true
end

function KnockbackService.Init() end

function KnockbackService.Start() end

return KnockbackService
