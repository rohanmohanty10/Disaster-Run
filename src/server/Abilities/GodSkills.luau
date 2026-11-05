--!strict
-- God skill behaviours, driven by each skill's Behavior table in Kits.luau.
-- Every strike shows a telegraph first (GAME_PLAN.md: 0.5-1.5s warning), then hits.
--
-- Templates: Circle, Line, Cone, Homing, Rain. Options a behaviour can add:
--   Charge (hold up to N s), RMin (radius grows with charge), DmgMax (damage grows with charge),
--   Bolts (many small strikes inside the circle), Chain (lightning jumps), Linger (damage zone),
--   Shots (repeat the line), DmgEdge (falloff), HealthPercent (Cleave), RootAtFull.

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local Services = script.Parent.Parent.Services
local CombatService = require(Services.CombatService)

local Common = require(script.Parent.Common)

export type Context = {
	Player: Player,
	Skill: any,
	Behavior: { [string]: any },
	Target: Vector3, -- ground point under the reticle
	Direction: Vector3, -- flat aim direction (for lines / cones)
	Charge: number, -- 0-1 how long the key was held, relative to Behavior.Charge
	GetAim: () -> Vector3, -- latest reticle position (for held skills)
	IsHeld: () -> boolean,
}

local GodSkills = {}

local function lerp(a: number, b: number, t: number): number
	return a + (b - a) * t
end

-- Telegraph, wait, then hit everything in the shape. Returns the characters hit.
local function strike(ctx: Context, shape: Common.Shape, telegraph: number, damageFn: ((Model) -> number?)?, cast: any?): { Model }
	local b = ctx.Behavior
	cast = cast or CombatService.NewCast()
	Common.Fx({
		Kind = "Telegraph",
		Shape = shape.Kind,
		CFrame = shape.CFrame,
		Radius = shape.Radius,
		Length = shape.Length,
		Width = shape.Width,
		Angle = shape.Angle,
		Duration = telegraph,
		Element = b.Vfx,
		Skill = if ctx.Skill then ctx.Skill.Name else nil,
	})
	task.wait(telegraph)
	Common.Fx({
		Kind = "Impact",
		Shape = shape.Kind,
		CFrame = shape.CFrame,
		Radius = shape.Radius,
		Length = shape.Length,
		Width = shape.Width,
		Angle = shape.Angle,
		Element = b.Vfx,
		Skill = if ctx.Skill then ctx.Skill.Name else nil,
	})
	local hits = Common.Targets(ctx.Player, shape, "HostileToRunners", b.MaxTargets)
	local center = shape.CFrame.Position
	for _, victim in hits do
		local damage = if damageFn then damageFn(victim) else nil
		local args = Common.AfflictArgs(b, cast, center, shape.CFrame.LookVector, damage)
		local landed = CombatService.Afflict(ctx.Player, victim, args)
		if landed then
			Common.OnHitExtras(ctx.Player, victim, b, cast)
		end
	end
	if b.DestroyCover then
		Common.DamageCover(shape, (b.Dmg or 30) * 2)
	end
	Common.NearMiss(shape, hits)
	return hits
end

-- A damage zone that ticks for Linger.Duration (pull, slow, damage).
local function linger(ctx: Context, shape: Common.Shape, cast: any)
	local b = ctx.Behavior
	local l = b.Linger
	Common.Fx({
		Kind = "Linger",
		Shape = shape.Kind,
		CFrame = shape.CFrame,
		Radius = shape.Radius,
		Length = shape.Length,
		Width = shape.Width,
		Duration = l.Duration,
		Element = b.Vfx,
		Skill = if ctx.Skill then ctx.Skill.Name else nil,
	})
	local center = shape.CFrame.Position
	local elapsed = 0
	while elapsed < l.Duration do
		for _, victim in Common.Targets(ctx.Player, shape, "HostileToRunners") do
			local args = Common.AfflictArgs(b, cast, center, nil, if (l.Dmg or 0) > 0 then l.Dmg else nil)
			args.Knockback = nil
			args.Ragdoll = nil
			if l.Pull then
				args.Knockback = { Velocity = Common.Flat(center - (Characters.GetRoot(victim) :: BasePart).Position) * l.Pull, Duration = l.Tick }
			end
			local landed = CombatService.Afflict(ctx.Player, victim, args)
			if landed then
				Common.OnHitExtras(ctx.Player, victim, b, cast)
			end
		end
		task.wait(l.Tick)
		elapsed += l.Tick
	end
end

-- ------------------------------------------------------------------ templates
function GodSkills.Circle(ctx: Context)
	local b = ctx.Behavior
	local radius = b.R
	if b.RMin then
		radius = lerp(b.RMin, b.R, ctx.Charge)
	end
	local shape: Common.Shape = { Kind = "Circle", CFrame = CFrame.new(ctx.Target), Radius = radius }
	local cast = CombatService.NewCast()

	if b.Bolts then
		-- Many small strikes scattered inside the area (Lightning Wrath, Sacred Jewel Barrage).
		Common.Fx({ Kind = "Telegraph", Shape = "Circle", CFrame = shape.CFrame, Radius = radius, Duration = b.Tel + b.Bolts.Count * b.Bolts.Interval, Element = b.Vfx,
		Skill = if ctx.Skill then ctx.Skill.Name else nil, Faint = true })
		task.wait(b.Tel)
		local rng = Random.new()
		for _ = 1, b.Bolts.Count do
			local angle = rng:NextNumber(0, math.pi * 2)
			local distance = math.sqrt(rng:NextNumber()) * (radius - b.Bolts.R * 0.5)
			local point = Common.Ground(ctx.Target + Vector3.new(math.cos(angle) * distance, 0, math.sin(angle) * distance))
			task.spawn(function()
				local boltCtx = table.clone(ctx)
				boltCtx.Behavior = { Dmg = b.Bolts.Dmg, Vfx = b.Vfx, Stun = b.Stun, Slow = b.Slow }
				strike(boltCtx, { Kind = "Circle", CFrame = CFrame.new(point), Radius = b.Bolts.R }, b.Bolts.Tel, nil, cast)
			end)
			task.wait(b.Bolts.Interval)
		end
		return
	end

	if b.Linger and not b.Dmg then
		Common.Fx({ Kind = "Telegraph", Shape = "Circle", CFrame = shape.CFrame, Radius = radius, Duration = b.Tel, Element = b.Vfx, Skill = ctx.Skill.Name })
		task.wait(b.Tel)
		if b.RootAtFull and ctx.Charge >= 0.95 then
			for _, victim in Common.Targets(ctx.Player, shape, "HostileToRunners") do
				CombatService.Afflict(ctx.Player, victim, { Cast = cast, Root = b.RootAtFull })
			end
		end
		linger(ctx, shape, cast)
		return
	end

	local damageFn: ((Model) -> number?)? = nil
	if b.DmgMax then
		local damage = lerp(b.Dmg, b.DmgMax, ctx.Charge)
		damageFn = function()
			return damage
		end
	elseif b.DmgEdge then
		damageFn = function(victim)
			local root = Characters.GetRoot(victim)
			if not root then
				return b.Dmg
			end
			local t = math.clamp(((root.Position - ctx.Target) * Vector3.new(1, 0, 1)).Magnitude / radius, 0, 1)
			return lerp(b.Dmg, b.DmgEdge, t)
		end
	elseif b.HealthPercent then
		damageFn = function(victim)
			local humanoid = victim:FindFirstChildOfClass("Humanoid")
			local health = if humanoid then humanoid.Health else 100
			return math.clamp(health * b.HealthPercent, b.DmgMin or 0, b.Dmg)
		end
	end
	strike(ctx, shape, b.Tel, damageFn, cast)
	if b.Linger then
		linger(ctx, shape, cast)
	end
end

function GodSkills.Line(ctx: Context)
	local b = ctx.Behavior
	-- The line starts at the reticle and runs along the camera's facing.
	local start = ctx.Target - ctx.Direction * (b.L * 0.15)
	local shape: Common.Shape = {
		Kind = "Line",
		CFrame = CFrame.lookAt(start, start + ctx.Direction),
		Length = b.L,
		Width = b.W,
	}
	local cast = CombatService.NewCast()
	if b.Wall and b.Linger then
		Common.Fx({ Kind = "Telegraph", Shape = "Line", CFrame = shape.CFrame, Length = b.L, Width = b.W, Duration = b.Tel, Element = b.Vfx, Skill = ctx.Skill.Name })
		task.wait(b.Tel)
		linger(ctx, shape, cast)
		return
	end
	local shots = if b.Shots then b.Shots.Count else 1
	for shot = 1, shots do
		local hits
		if shot == 1 then
			hits = strike(ctx, shape, b.Tel, nil, cast)
		else
			-- Follow-up shots skip the long telegraph.
			hits = strike(ctx, shape, b.Shots.Interval, nil, cast)
		end
		if b.Chain and #hits > 0 then
			local chained: { [Model]: boolean } = {}
			for _, character in hits do
				chained[character] = true
			end
			local from = hits[1]
			for _ = 1, b.Chain.Count do
				local fromRoot = Characters.GetRoot(from)
				if not fromRoot then
					break
				end
				local nextTarget: Model? = nil
				local best = b.Chain.Range
				for _, candidate in Common.Targets(ctx.Player, { Kind = "Circle", CFrame = CFrame.new(fromRoot.Position), Radius = b.Chain.Range }, "HostileToRunners") do
					local root = Characters.GetRoot(candidate)
					local distance = if root then (root.Position - fromRoot.Position).Magnitude else math.huge
					if not chained[candidate] and distance <= best then
						best = distance
						nextTarget = candidate
					end
				end
				if not nextTarget then
					break
				end
				local targetRoot = Characters.GetRoot(nextTarget :: Model) :: BasePart
				Common.Fx({ Kind = "Bolt", From = fromRoot.Position, To = targetRoot.Position, Element = b.Vfx, Skill = ctx.Skill.Name })
				chained[nextTarget :: Model] = true
				CombatService.Afflict(ctx.Player, nextTarget :: Model, { Cast = cast, Damage = b.Chain.Dmg, Stun = b.Stun })
				from = nextTarget :: Model
				task.wait(0.08)
			end
		end
	end
end

function GodSkills.Cone(ctx: Context)
	local b = ctx.Behavior
	local start = ctx.Target - ctx.Direction * (b.L * 0.3)
	strike(ctx, {
		Kind = "Cone",
		CFrame = CFrame.lookAt(start, start + ctx.Direction),
		Length = b.L,
		Angle = b.Angle,
	}, b.Tel)
end

-- Seeks the nearest Runners to the reticle and strikes each where they stand (Hound Blaze).
function GodSkills.Homing(ctx: Context)
	local b = ctx.Behavior
	local cast = CombatService.NewCast()
	local targets = Common.Targets(ctx.Player, { Kind = "Circle", CFrame = CFrame.new(ctx.Target), Radius = b.Range }, "HostileToRunners", b.Count)
	if #targets == 0 then
		-- Nobody close: still land the strikes around the reticle so the cast isn't wasted.
		strike(ctx, { Kind = "Circle", CFrame = CFrame.new(ctx.Target), Radius = b.R }, b.Tel, nil, cast)
		return
	end
	for _, victim in targets do
		local root = Characters.GetRoot(victim)
		if root then
			local point = Common.Ground(root.Position + root.AssemblyLinearVelocity * Vector3.new(1, 0, 1) * (b.Tel * 0.5))
			task.spawn(strike, ctx, { Kind = "Circle", CFrame = CFrame.new(point), Radius = b.R }, b.Tel, nil, cast)
		end
		task.wait(0.15)
	end
end

-- Strikes keep landing wherever the reticle points while the key is held (Meteor Fury).
function GodSkills.Rain(ctx: Context)
	local b = ctx.Behavior
	local cast = CombatService.NewCast()
	local rng = Random.new()
	local started = os.clock()
	while os.clock() - started < b.Duration and ctx.IsHeld() do
		local aim = ctx.GetAim()
		local point = Common.Ground(aim + Vector3.new(rng:NextNumber(-6, 6), 0, rng:NextNumber(-6, 6)))
		task.spawn(strike, ctx, { Kind = "Circle", CFrame = CFrame.new(point), Radius = b.R }, b.Tel, nil, cast)
		task.wait(b.Interval)
	end
end

-- A small follow-up quake (World Shaker's Aftershock passive).
function GodSkills.Aftershock(player: Player, target: Vector3)
	task.wait(1)
	local ctx: Context = {
		Player = player,
		Skill = nil,
		Behavior = { Dmg = 10, Vfx = "Quake" },
		Target = target,
		Direction = Vector3.new(0, 0, -1),
		Charge = 0,
		GetAim = function()
			return target
		end,
		IsHeld = function()
			return false
		end,
	}
	strike(ctx, { Kind = "Circle", CFrame = CFrame.new(target), Radius = 8 }, 0.4)
end

return GodSkills
