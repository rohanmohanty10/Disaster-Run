--!strict
-- The one hit pipeline every ability uses (SorceryGame reference's Afflict, adapted).
-- Order: valid target -> iframes ("DODGED") -> damage (per-cast cap + per-second ceiling)
--        -> stun / slow / root / silence -> ragdoll -> knockback.
--
--   local cast = CombatService.NewCast()
--   hitbox.Hit:Connect(function(victim)
--       CombatService.Afflict(player, victim, {
--           Cast = cast, Damage = 30, Stun = 0.6,
--           Knockback = { From = center, Power = 50, Lift = 30 },
--       })
--   end)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CombatConfig = require(ReplicatedStorage.Shared.Config.CombatConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local StatusEffectService = require(script.Parent.StatusEffectService)
local RagdollService = require(script.Parent.RagdollService)
local KnockbackService = require(script.Parent.KnockbackService)

export type Cast = { Id: number, Dealt: { [Model]: number } }

export type AfflictArgs = {
	Cast: Cast?, -- groups every hit of one cast for the per-cast damage cap
	Damage: number?,
	Stun: number?, -- seconds
	Slow: { Factor: number, Duration: number }?,
	Root: number?, -- seconds
	Silence: number?, -- seconds
	InfiniteVoid: number?, -- seconds (true stun + client warp)
	Ragdoll: number?, -- seconds
	Knockback: KnockbackService.Options?,
	IgnoreIFrames: boolean?, -- for unblockable scripted moments only
	Uncapped: boolean?, -- skip the damage caps (environment hazards, etc.)
}

export type DamageRecord = { Attacker: Player?, Amount: number, Time: number }

local CombatService = {}

-- (victim: Model, attacker: Player?, amount: number)
CombatService.Damaged = Signal.new()
-- (victim: Model, killer: Player?, assists: { Player })
CombatService.Killed = Signal.new()

local nextCastId = 0
local damageLog: { [Model]: { DamageRecord } } = {}
local watchedDeaths: { [Model]: boolean } = {}

-- Starts a new cast. Pass it to every Afflict() that belongs to the same ability use.
function CombatService.NewCast(): Cast
	nextCastId += 1
	return { Id = nextCastId, Dealt = setmetatable({}, { __mode = "k" }) :: any }
end

local function feedback(kind: string, character: Model, amount: number?)
	local root = Characters.GetRoot(character)
	if root then
		Remotes.Event("CombatFeedback"):FireAllClients({ Kind = kind, Position = root.Position, Amount = amount })
	end
end

local function recentDamage(victim: Model, window: number): number
	local log = damageLog[victim]
	if not log then
		return 0
	end
	local now = os.clock()
	local total = 0
	for i = #log, 1, -1 do
		local record = log[i]
		if now - record.Time > CombatConfig.AssistWindow then
			table.remove(log, i)
		elseif now - record.Time <= window then
			total += record.Amount
		end
	end
	return total
end

local function watchDeath(victim: Model)
	if watchedDeaths[victim] then
		return
	end
	local humanoid = victim:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	watchedDeaths[victim] = true
	humanoid.Died:Once(function()
		watchedDeaths[victim] = nil
		local log = damageLog[victim] or {}
		damageLog[victim] = nil
		local killer: Player? = nil
		local now = os.clock()
		local perAttacker: { [Player]: number } = {}
		for i = #log, 1, -1 do
			local record = log[i]
			if record.Attacker and now - record.Time <= CombatConfig.AssistWindow then
				if killer == nil then
					killer = record.Attacker -- the last hit gets the kill
				end
				perAttacker[record.Attacker] = (perAttacker[record.Attacker] or 0) + record.Amount
			end
		end
		local assists = {}
		for player, amount in perAttacker do
			if player ~= killer and amount >= CombatConfig.AssistDamage then
				table.insert(assists, player)
			end
		end
		CombatService.Killed:Fire(victim, killer, assists)
	end)
	victim.AncestryChanged:Connect(function(_, parent)
		if parent == nil then
			watchedDeaths[victim] = nil
			damageLog[victim] = nil
		end
	end)
end

-- Deals damage with the caps applied. Returns the damage actually dealt.
function CombatService.DealDamage(attacker: Player?, victim: Model, amount: number, cast: Cast?, uncapped: boolean?): number
	local humanoid = victim:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 or amount <= 0 then
		return 0
	end
	if not uncapped then
		if cast then
			local dealt = cast.Dealt[victim] or 0
			amount = math.min(amount, CombatConfig.MaxDamagePerCast - dealt)
		else
			amount = math.min(amount, CombatConfig.MaxDamagePerCast)
		end
		amount = math.min(amount, CombatConfig.MaxDamagePerSecond - recentDamage(victim, 1))
	end
	amount = math.min(amount, humanoid.Health)
	if amount <= 0 then
		return 0
	end
	if cast then
		cast.Dealt[victim] = (cast.Dealt[victim] or 0) + amount
	end

	watchDeath(victim)
	local log = damageLog[victim]
	if not log then
		log = {}
		damageLog[victim] = log
	end
	table.insert(log, { Attacker = attacker, Amount = amount, Time = os.clock() })

	humanoid.Health -= amount
	feedback("Damage", victim, amount)
	CombatService.Damaged:Fire(victim, attacker, amount)
	return amount
end

--[[
	Applies a hit. attacker is the Player (or character) responsible; nil for hazards.
	Returns (hit: boolean, reason: string) where reason is "Hit", "IFrames", "Dead" or "Invalid".
]]
function CombatService.Afflict(attacker: (Player | Model)?, victim: Model, args: AfflictArgs): (boolean, string)
	if typeof(victim) ~= "Instance" or not victim:IsA("Model") then
		return false, "Invalid"
	end
	if not Characters.IsAlive(victim) then
		return false, "Dead"
	end
	local attackerPlayer: Player? = nil
	if attacker then
		if attacker:IsA("Player") then
			attackerPlayer = attacker :: Player
		else
			attackerPlayer = Players:GetPlayerFromCharacter(attacker :: Model)
		end
	end

	if not args.IgnoreIFrames and StatusEffectService.IsInvulnerable(victim) then
		feedback("Dodged", victim)
		return false, "IFrames"
	end

	if args.Damage then
		CombatService.DealDamage(attackerPlayer, victim, args.Damage, args.Cast, args.Uncapped)
		if not Characters.IsAlive(victim) then
			return true, "Hit" -- killed: no point stunning a corpse
		end
	end

	local force = if args.IgnoreIFrames then { Force = true } else nil
	if args.Stun then
		StatusEffectService.Apply(victim, "Stunned", args.Stun, force)
	end
	if args.InfiniteVoid then
		StatusEffectService.Apply(victim, "InfiniteVoid", args.InfiniteVoid, force)
	end
	if args.Slow then
		StatusEffectService.Apply(victim, "Slowed", args.Slow.Duration, { Factor = args.Slow.Factor, Force = args.IgnoreIFrames })
	end
	if args.Root then
		StatusEffectService.Apply(victim, "Rooted", args.Root, force)
	end
	if args.Silence then
		StatusEffectService.Apply(victim, "Silenced", args.Silence, force)
	end
	if args.Ragdoll then
		RagdollService.Ragdoll(victim, args.Ragdoll)
	end
	if args.Knockback then
		KnockbackService.Apply(victim, args.Knockback)
	end
	return true, "Hit"
end

-- Gives a character iframes for `duration` seconds (dodges, slides, invulnerability skills).
function CombatService.GiveIFrames(character: Model, duration: number)
	StatusEffectService.Apply(character, "Invulnerable", duration, { Force = true })
end

function CombatService.Init() end

function CombatService.Start() end

return CombatService
