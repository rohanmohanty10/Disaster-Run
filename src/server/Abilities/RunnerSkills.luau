--!strict
-- Runner skill behaviours, driven by each skill's Behavior table in Kits.luau.
-- Movement (dashes, air jumps) runs on the player's own client for responsiveness
-- (SelfMove remote); the server grants iframes and does everything that affects others.
--
-- Templates: Buff, Dash, AirJump, Blink, Arm, Decoy, Rush, Shove, Swap, Pull, Domain,
--            TimeStop, Rewind, Accelerate, TimeErase.
-- Behavior.Aura = "<Stand>" shows that stand's aura on the caster (StandFx.luau on the client).

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)

local Services = script.Parent.Parent.Services
local CombatService = require(Services.CombatService)
local StatusEffectService = require(Services.StatusEffectService)
local KnockbackService = require(Services.KnockbackService)

local Common = require(script.Parent.Common)

export type Context = {
	Player: Player,
	Character: Model,
	Root: BasePart,
	Skill: any,
	Behavior: { [string]: any },
	Look: Vector3, -- flat camera direction
	Move: Vector3, -- flat movement direction (falls back to Look)
	Aim: Vector3?, -- world point under the crosshair
}

local RunnerSkills = {}

type Armed = { Kind: string, Until: number, Teleport: number, IFrames: number, Stun: number?, Player: Player }
local armed: { [Model]: Armed } = {}

type Sample = { Time: number, CFrame: CFrame, Health: number }
local history: { [Model]: { Sample } } = {}

local function selfMove(ctx: Context, info: { [string]: any })
	Remotes.Event("SelfMove"):FireClient(ctx.Player, info)
end

local function otherRunners(ctx: Context): { Model }
	local list = {}
	for _, player in Players:GetPlayers() do
		local character = player.Character
		if character and character ~= ctx.Character and Characters.GetRole(character) == "Runner" and Characters.IsAlive(character) then
			table.insert(list, character)
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

-- ------------------------------------------------------------------ templates
function RunnerSkills.Buff(ctx: Context)
	local b = ctx.Behavior
	local character = ctx.Character
	if b.Speed then
		Common.TimedAttribute(character, "SpeedBoost", b.Speed.Mult, b.Speed.Duration)
	end
	if b.Stamina then
		Remotes.Event("Stamina"):FireClient(ctx.Player, b.Stamina, "Skill")
	end
	if b.FreeSprint then
		Common.TimedAttribute(character, "FreeSprint", true, b.FreeSprint)
	end
	if b.Jump then
		Common.TimedAttribute(character, "JumpBoost", b.Jump.Mult, b.Jump.Duration)
	end
	if b.AirJumps then
		Common.TimedAttribute(character, "AirJumps", b.AirJumps.Count, b.AirJumps.Duration)
	end
	if b.IFrames then
		CombatService.GiveIFrames(character, b.IFrames)
	end
	if b.DamageReduction then
		Common.TimedAttribute(character, "DamageTakenMultiplier", 1 - b.DamageReduction, b.ReductionTime or b.Root or 1.5)
	end
	if b.Root then
		StatusEffectService.Apply(character, "Rooted", b.Root, { Force = true })
	end
	if b.KnockbackImmune then
		Common.TimedAttribute(character, "KnockbackImmune", true, b.Root or 1.5)
	end
	if b.Path then
		selfMove(ctx, { Kind = "Path", Duration = b.Path })
	end
	local duration = (b.Speed and b.Speed.Duration) or b.IFrames or b.Root or 1
	if b.Aura then
		Common.Fx({ Kind = "StandAura", Character = character, Stand = b.Aura, Duration = duration })
	else
		Common.Fx({ Kind = "Buff", Character = character, Duration = duration })
	end
end

function RunnerSkills.Dash(ctx: Context)
	local b = ctx.Behavior
	local count = b.Count or 1
	for i = 1, count do
		CombatService.GiveIFrames(ctx.Character, b.IFrames)
		local direction = ctx.Move
		if b.Anim == "DashSide" then
			-- Alternate sides for multi-step sidesteps.
			local right = ctx.Look:Cross(Vector3.yAxis)
			direction = if i % 2 == 1 then right else -right
		end
		selfMove(ctx, { Kind = "Dash", Direction = direction, Distance = b.Dist, Duration = 0.22, Anim = b.Anim })
		if b.StunThrough or b.Trail then
			local start = ctx.Root.Position
			task.delay(0.22, function()
				local path: Common.Shape = { Kind = "Line", CFrame = CFrame.lookAt(start, start + direction), Length = b.Dist + 4, Width = 6 }
				if b.StunThrough then
					for _, victim in Common.Targets(ctx.Player, path, "RunnersPvP") do
						CombatService.Afflict(ctx.Player, victim, { Stun = b.StunThrough })
					end
				end
				if b.Trail then
					Common.Fx({ Kind = "Trail", CFrame = path.CFrame, Length = path.Length, Duration = b.Trail.Duration })
					for _, ally in Common.Targets(ctx.Player, path, "RunnersPvP") do
						Common.TimedAttribute(ally, "SpeedBoost", b.Trail.Mult, b.Trail.Duration)
					end
				end
			end)
		end
		if b.Steal then
			local nearest: Model? = nil
			local best = 20
			for _, other in otherRunners(ctx) do
				local root = Characters.GetRoot(other)
				local distance = if root then (root.Position - ctx.Root.Position).Magnitude else math.huge
				if distance < best then
					best = distance
					nearest = other
				end
			end
			Common.TimedAttribute(ctx.Character, "SpeedBoost", b.Steal.Mult, b.Steal.Duration)
			if nearest then
				CombatService.Afflict(ctx.Player, nearest, { Slow = { Factor = 1 / b.Steal.Mult, Duration = b.Steal.Duration } })
			end
		end
		if i < count then
			task.wait(0.28)
		end
	end
end

function RunnerSkills.AirJump(ctx: Context)
	local b = ctx.Behavior
	CombatService.GiveIFrames(ctx.Character, b.IFrames)
	selfMove(ctx, { Kind = "AirJump", Up = b.Up, Forward = b.Forward, Direction = ctx.Move })
end

function RunnerSkills.Blink(ctx: Context)
	local b = ctx.Behavior
	if b.Hold and b.Hold > 0 then
		Common.Fx({ Kind = "Charge", Character = ctx.Character, Duration = b.Hold })
		task.wait(b.Hold)
		if not Characters.IsAlive(ctx.Character) or not StatusEffectService.CanCast(ctx.Character) then
			return
		end
	end
	local root = ctx.Root
	local offset
	if b.UseMove then
		-- The full distance in the direction you're moving (Made in Heaven's Godly Speed).
		offset = ctx.Move * b.Dist
	else
		local goal = ctx.Aim or (root.Position + ctx.Look * b.Dist)
		offset = (goal - root.Position) * Vector3.new(1, 0, 1)
		if offset.Magnitude > b.Dist then
			offset = offset.Unit * b.Dist
		end
		if offset.Magnitude < 1 then
			offset = ctx.Look * b.Dist
		end
	end
	-- Stop short of walls.
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { ctx.Character }
	local wall = workspace:Raycast(root.Position, offset, params)
	if wall then
		offset = offset.Unit * math.max(wall.Distance - 2, 0)
	end
	local landing = Common.Ground(root.Position + offset) + Vector3.new(0, 3, 0)
	CombatService.GiveIFrames(ctx.Character, b.IFrames)
	Common.Fx({ Kind = "Blink", From = root.Position, To = landing, Stand = b.Aura })
	ctx.Character:PivotTo(CFrame.lookAt(landing, landing + ctx.Look))
end

function RunnerSkills.Arm(ctx: Context)
	local b = ctx.Behavior
	armed[ctx.Character] = {
		Kind = b.Kind,
		Until = os.clock() + b.Window,
		Teleport = b.Teleport,
		IFrames = b.IFrames,
		Stun = b.Stun,
		Player = ctx.Player,
	}
	if b.Kind == "Epitaph" then
		-- King Crimson Requiem's Epitaph: forehead face + counter aura while the window is open.
		local character = ctx.Character
		Common.Fx({ Kind = "Epitaph", Character = character, On = true, Duration = b.Window })
		task.delay(b.Window, function()
			local state = armed[character]
			if state and state.Kind == "Epitaph" and os.clock() >= state.Until - 0.05 then
				armed[character] = nil
				Common.Fx({ Kind = "Epitaph", Character = character, On = false })
			end
		end)
		return
	end
	Common.Fx({ Kind = "Buff", Character = ctx.Character, Duration = b.Window, Style = b.Kind })
end

-- Time Erasure (King Crimson Requiem): the Gods lose sight of you while time is erased.
function RunnerSkills.TimeErase(ctx: Context)
	local b = ctx.Behavior
	local character = ctx.Character
	Common.TimedAttribute(character, "TimeErased", true, b.Duration)
	if b.Speed then
		Common.TimedAttribute(character, "SpeedBoost", b.Speed, b.Duration)
	end
	Common.Fx({ Kind = "TimeErase", Character = character, Duration = b.Duration })
end

function RunnerSkills.Decoy(ctx: Context)
	local b = ctx.Behavior
	local character = ctx.Character
	local wasArchivable = character.Archivable
	character.Archivable = true
	local clone = character:Clone()
	character.Archivable = wasArchivable
	if not clone then
		return
	end
	for _, d in clone:GetDescendants() do
		if d:IsA("BaseScript") or d:IsA("ModuleScript") or d.Name == "RagdollComponents" then
			d:Destroy()
		end
	end
	clone.Name = `{character.Name} `
	clone:SetAttribute("Role", "Runner")
	clone:SetAttribute("Decoy", true)
	local folder = workspace:FindFirstChild("AbilityDecoys")
	if not folder then
		folder = Instance.new("Folder")
		folder.Name = "AbilityDecoys"
		folder.Parent = workspace
	end
	clone.Parent = folder
	local root = Characters.GetRoot(clone)
	local humanoid = clone:FindFirstChildOfClass("Humanoid")
	if root and humanoid then
		root:SetNetworkOwner(nil)
		humanoid.WalkSpeed = MovementConfig.SprintSpeed
		local goal = root.Position + ctx.Move * MovementConfig.SprintSpeed * b.Duration
		humanoid:MoveTo(goal)
	end
	task.delay(b.Duration, function()
		clone:Destroy()
	end)
end

function RunnerSkills.Rush(ctx: Context)
	local b = ctx.Behavior
	selfMove(ctx, { Kind = "Dash", Direction = ctx.Look, Distance = b.Dist, Duration = 0.2, Anim = "DashForward" })
	task.wait(0.15)
	local root = ctx.Root
	local shape: Common.Shape = { Kind = "Line", CFrame = CFrame.lookAt(root.Position - ctx.Look * 2, root.Position + ctx.Look), Length = 8, Width = 6 }
	local victims = Common.Targets(ctx.Player, shape, "RunnersPvP", 1)
	for _, victim in victims do
		CombatService.Afflict(ctx.Player, victim, {
			Stun = b.Stun,
			Knockback = { Direction = ctx.Look, Power = b.KB.Power, Lift = b.KB.Lift },
		})
	end
end

function RunnerSkills.Shove(ctx: Context)
	local b = ctx.Behavior
	local root = ctx.Root
	local shape: Common.Shape = { Kind = "Line", CFrame = CFrame.lookAt(root.Position, root.Position + ctx.Look), Length = b.Range + 2, Width = 5 }
	for _, victim in Common.Targets(ctx.Player, shape, "RunnersPvP", 1) do
		CombatService.Afflict(ctx.Player, victim, {
			Stun = 0.3,
			Knockback = { Direction = ctx.Look, Power = b.KB.Power, Lift = b.KB.Lift },
		})
	end
end

function RunnerSkills.Swap(ctx: Context)
	local b = ctx.Behavior
	local root = ctx.Root
	-- The Runner closest to the crosshair direction, within range.
	local best: Model? = nil
	local bestScore = math.huge
	for _, other in otherRunners(ctx) do
		local otherRoot = Characters.GetRoot(other)
		if otherRoot then
			local offset = otherRoot.Position - root.Position
			local distance = offset.Magnitude
			if distance <= b.Range and distance > 0.5 then
				local angle = math.deg(math.acos(math.clamp(Common.Flat(offset):Dot(ctx.Look), -1, 1)))
				if angle < 35 and angle + distance * 0.5 < bestScore then
					bestScore = angle + distance * 0.5
					best = other
				end
			end
		end
	end
	if not best then
		Common.FxTo(ctx.Player, { Kind = "Toast", Text = "No Runner to swap with!" })
		return
	end
	local target = best :: Model
	if StatusEffectService.IsInvulnerable(target) then
		Common.Fx({ Kind = "Dodged", Position = (Characters.GetRoot(target) :: BasePart).Position })
		return
	end
	local mine = ctx.Character:GetPivot()
	local theirs = target:GetPivot()
	Common.Fx({ Kind = "Swap", From = mine.Position, To = theirs.Position })
	ctx.Character:PivotTo(theirs)
	target:PivotTo(mine)
	CombatService.GiveIFrames(ctx.Character, b.IFrames)
end

function RunnerSkills.Pull(ctx: Context)
	local b = ctx.Behavior
	local point = Common.Ground(ctx.Root.Position + ctx.Look * b.Ahead) + Vector3.new(0, 2, 0)
	Common.Fx({ Kind = "Linger", Shape = "Circle", CFrame = CFrame.new(point), Radius = b.R, Duration = b.Duration, Element = "Gravity" })
	local elapsed = 0
	while elapsed < b.Duration do
		for _, other in otherRunners(ctx) do
			local root = Characters.GetRoot(other)
			if root and (root.Position - point).Magnitude <= b.R and not StatusEffectService.IsInvulnerable(other) then
				KnockbackService.Apply(other, { Velocity = Common.Flat(point - root.Position) * b.Power, Duration = 0.12 })
			end
		end
		task.wait(0.1)
		elapsed += 0.1
	end
end

function RunnerSkills.Domain(ctx: Context)
	local b = ctx.Behavior
	local center = ctx.Root.Position
	Common.Fx({ Kind = "Domain", CFrame = CFrame.new(center), Radius = b.R, Duration = b.Void, Element = "Void" })
	for _, victim in Common.Targets(ctx.Player, { Kind = "Circle", CFrame = CFrame.new(center), Radius = b.R }, "RunnersPvP") do
		CombatService.Afflict(ctx.Player, victim, { InfiniteVoid = b.Void })
	end
end

function RunnerSkills.TimeStop(ctx: Context)
	local b = ctx.Behavior
	CombatService.GiveIFrames(ctx.Character, b.IFrames)
	Common.Fx({ Kind = "TimeStop", Duration = b.Freeze, Caster = ctx.Character })
	for _, other in otherRunners(ctx) do
		CombatService.Afflict(ctx.Player, other, { Stun = b.Freeze })
	end
end

function RunnerSkills.Rewind(ctx: Context)
	local b = ctx.Behavior
	local samples = history[ctx.Character]
	if not samples or #samples == 0 then
		return
	end
	local goalTime = os.clock() - b.Back
	local chosen = samples[1]
	for _, sample in samples do
		if sample.Time <= goalTime then
			chosen = sample
		end
	end
	local humanoid = ctx.Character:FindFirstChildOfClass("Humanoid")
	Common.Fx({ Kind = "Blink", From = ctx.Root.Position, To = chosen.CFrame.Position })
	ctx.Character:PivotTo(chosen.CFrame)
	if humanoid then
		local lost = chosen.Health - humanoid.Health
		if lost > 0 then
			humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + math.min(lost, b.HealMax))
		end
	end
end

-- Made in Heaven's Time Acceleration, ending in Universe Reset (StandGame's skill-tree order):
--   accelerate: you speed up and sprint free, your other cooldowns tick faster, and Runners in
--               range are trapped in the accelerated time with you (slowed);
--   reset:      when it ends you heal, and every Runner in range becomes an "alternate universe"
--               version of themselves for a moment (silenced + slowed).
function RunnerSkills.Accelerate(ctx: Context)
	local b = ctx.Behavior
	local character = ctx.Character
	local player = ctx.Player
	local function inRange(other: Model): boolean
		if not b.Range then
			return true
		end
		local root = Characters.GetRoot(other)
		return root ~= nil and (root.Position - ctx.Root.Position).Magnitude <= b.Range
	end

	Common.TimedAttribute(character, "SpeedBoost", b.Speed, b.Duration)
	Common.TimedAttribute(character, "FreeSprint", true, b.Duration)
	Common.Fx({ Kind = "TimeAccel", Caster = character, Duration = b.Duration, Radius = b.Range })
	for _, other in otherRunners(ctx) do
		if inRange(other) then
			CombatService.Afflict(player, other, { Slow = { Factor = b.Slow, Duration = b.Duration } })
		end
	end

	-- Your Q / E cooldowns run `OwnCooldownRate` times faster while time is accelerated.
	local rate = b.OwnCooldownRate or 1
	local elapsed = 0
	while elapsed < b.Duration do
		local dt = task.wait(0.1)
		elapsed += dt
		if rate > 1 then
			local now = workspace:GetServerTimeNow()
			for i = 1, 2 do
				local ready = player:GetAttribute(`Cooldown{i}`)
				if type(ready) == "number" and ready > now then
					player:SetAttribute(`Cooldown{i}`, math.max(ready - dt * (rate - 1), now))
				end
			end
		end
		if not Characters.IsAlive(character) then
			return
		end
	end

	local reset = b.Reset
	if not reset then
		return
	end
	local center = (Characters.GetRoot(character) or ctx.Root).Position
	Common.Fx({ Kind = "UniverseReset", Caster = character, CFrame = CFrame.new(center), Radius = reset.Radius })
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid and reset.Heal then
		humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + reset.Heal)
	end
	for _, victim in Common.Targets(player, { Kind = "Circle", CFrame = CFrame.new(center), Radius = reset.Radius }, "RunnersPvP") do
		CombatService.Afflict(player, victim, { Silence = reset.Silence, Slow = reset.Slow })
		local victimPlayer = Players:GetPlayerFromCharacter(victim)
		if victimPlayer then
			Common.FxTo(victimPlayer, { Kind = "AlternateUniverse", Duration = reset.Silence })
		end
	end
end

-- ------------------------------------------------------------------ setup
function RunnerSkills.Init()
	-- Substitution / Silver Reflex / Epitaph: the first hit while armed is cancelled and you blink away.
	CombatService.AddInterceptor(function(attacker, victim)
		local state = armed[victim]
		if not state then
			return false
		end
		if os.clock() > state.Until then
			armed[victim] = nil
			return false
		end
		armed[victim] = nil
		local root = Characters.GetRoot(victim)
		if root and state.Kind == "Epitaph" then
			Common.Fx({ Kind = "Epitaph", Character = victim, On = false })
			-- Hit by a Runner: appear right behind them (as in the original) and stun them.
			local attackerCharacter = attacker and attacker.Character
			local attackerRoot = attackerCharacter and Characters.GetRoot(attackerCharacter)
			local landing: CFrame
			if attackerCharacter and attackerRoot and Characters.GetRole(attackerCharacter) == "Runner" and (attackerRoot.Position - root.Position).Magnitude <= 70 then
				local behind = attackerRoot.Position - Common.Flat(attackerRoot.CFrame.LookVector) * 5
				landing = CFrame.lookAt(behind, Vector3.new(attackerRoot.Position.X, behind.Y, attackerRoot.Position.Z))
				local stun = state.Stun
				local hitter = attackerCharacter :: Model
				if stun then
					task.defer(function()
						CombatService.Afflict(state.Player, hitter, { Stun = stun })
					end)
				end
			else
				local look = Common.Flat(root.CFrame.LookVector)
				local spot = Common.Ground(root.Position + look * state.Teleport) + Vector3.new(0, 3, 0)
				landing = CFrame.lookAt(spot, spot + look)
			end
			Common.Fx({ Kind = "EpitaphHit", Character = victim, From = root.Position, To = landing.Position })
			victim:PivotTo(landing)
			CombatService.GiveIFrames(victim, state.IFrames)
			return true
		end
		if root then
			local direction
			if state.Kind == "SilverReflex" then
				local side = root.CFrame.RightVector * (if math.random() < 0.5 then 1 else -1)
				direction = side
			else
				-- Substitution: leave a log behind and appear further ahead.
				local log = Instance.new("Part")
				log.Name = "SubstitutionLog"
				log.Size = Vector3.new(1.5, 4, 1.5)
				log.Color = Color3.fromRGB(120, 80, 45)
				log.Material = Enum.Material.Wood
				log.CFrame = root.CFrame
				log.CanCollide = false
				log.Anchored = true
				log.Parent = workspace
				game:GetService("Debris"):AddItem(log, 2)
				direction = root.CFrame.LookVector
			end
			local landing = Common.Ground(root.Position + Common.Flat(direction) * state.Teleport) + Vector3.new(0, 3, 0)
			Common.Fx({ Kind = "Blink", From = root.Position, To = landing })
			victim:PivotTo(CFrame.lookAt(landing, landing + root.CFrame.LookVector * Vector3.new(1, 0, 1)))
		end
		CombatService.GiveIFrames(victim, state.IFrames)
		return true
	end)
end

function RunnerSkills.Start()
	-- Position history for Rewind: a sample every 0.25s, 4s kept.
	local accumulator = 0
	RunService.Heartbeat:Connect(function(dt)
		accumulator += dt
		if accumulator < 0.25 then
			return
		end
		accumulator = 0
		local now = os.clock()
		for _, player in Players:GetPlayers() do
			local character = player.Character
			local root = character and Characters.GetRoot(character)
			local humanoid = character and character:FindFirstChildOfClass("Humanoid")
			if character and root and humanoid and character:GetAttribute("TracksHistory") then
				local samples = history[character]
				if not samples then
					samples = {}
					history[character] = samples
					character.AncestryChanged:Connect(function(_, parent)
						if not parent then
							history[character] = nil
							armed[character] = nil
						end
					end)
				end
				table.insert(samples, { Time = now, CFrame = root.CFrame, Health = humanoid.Health })
				while #samples > 0 and now - samples[1].Time > 4 do
					table.remove(samples, 1)
				end
			end
		end
	end)
end

return RunnerSkills
