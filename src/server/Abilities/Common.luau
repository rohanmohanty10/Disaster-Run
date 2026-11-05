--!strict
-- Shared helpers for ability behaviours: ground snapping, strike shapes, telegraph / impact
-- broadcasts, timed attributes, near-miss refunds and cover damage.

local CollectionService = game:GetService("CollectionService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Characters = require(ReplicatedStorage.Shared.Util.Characters)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local MovementConfig = require(ReplicatedStorage.Shared.Config.MovementConfig)

local Services = script.Parent.Parent.Services
local CombatService = require(Services.CombatService)
local HitboxService = require(Services.HitboxService)

local Common = {}

-- ------------------------------------------------------------------ ground / geometry
local function characterList(): { Instance }
	local list: { Instance } = {}
	for _, player in Players:GetPlayers() do
		if player.Character then
			table.insert(list, player.Character)
		end
	end
	for _, name in { "TestDummies", "HitboxDebug", "AbilityDecoys" } do
		local folder = workspace:FindFirstChild(name)
		if folder then
			table.insert(list, folder)
		end
	end
	return list
end

-- The ground point under (or near) a position.
function Common.Ground(position: Vector3): Vector3
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = characterList()
	local result = workspace:Raycast(position + Vector3.new(0, 150, 0), Vector3.new(0, -400, 0), params)
	return if result then result.Position else position
end

function Common.Flat(direction: Vector3?, fallback: Vector3?): Vector3
	local flat = (direction or Vector3.zero) * Vector3.new(1, 0, 1)
	if flat.Magnitude < 0.01 then
		flat = (fallback or Vector3.new(0, 0, -1)) * Vector3.new(1, 0, 1)
	end
	if flat.Magnitude < 0.01 then
		flat = Vector3.new(0, 0, -1)
	end
	return flat.Unit
end

-- ------------------------------------------------------------------ visuals
function Common.Fx(info: { [string]: any })
	Remotes.Event("AbilityFx"):FireAllClients(info)
end

function Common.FxTo(player: Player, info: { [string]: any })
	Remotes.Event("AbilityFx"):FireClient(player, info)
end

-- ------------------------------------------------------------------ timed attributes
local attributeTokens: { [Instance]: { [string]: number } } = setmetatable({}, { __mode = "k" }) :: any

-- Sets an attribute for `duration` seconds; a newer call replaces an older one.
function Common.TimedAttribute(instance: Instance, name: string, value: any, duration: number)
	local tokens = attributeTokens[instance]
	if not tokens then
		tokens = {}
		attributeTokens[instance] = tokens
	end
	local token = (tokens[name] or 0) + 1
	tokens[name] = token
	instance:SetAttribute(name, value)
	task.delay(duration, function()
		if tokens[name] == token and instance.Parent then
			instance:SetAttribute(name, nil)
		end
	end)
end

-- ------------------------------------------------------------------ strikes
export type Shape = {
	Kind: "Circle" | "Line" | "Cone",
	CFrame: CFrame, -- Circle: centre on the ground; Line/Cone: start point, facing the direction
	Radius: number?, -- Circle
	Length: number?, -- Line / Cone
	Width: number?, -- Line
	Angle: number?, -- Cone (degrees)
}

-- Living Runners (or anything with the right filter) inside a ground shape.
function Common.Targets(caster: Player | Model, shape: Shape, filter: string?, maxTargets: number?): { Model }
	local params: HitboxService.Params
	if shape.Kind == "Circle" then
		local r = shape.Radius or 8
		params = { Shape = "Box", Size = Vector3.new(r * 2, 40, r * 2), CFrame = shape.CFrame }
	elseif shape.Kind == "Line" then
		local length, width = shape.Length or 40, shape.Width or 6
		params = { Shape = "Box", Size = Vector3.new(width, 40, length), CFrame = shape.CFrame * CFrame.new(0, 0, -length / 2) }
	else
		local length = shape.Length or 40
		params = { Shape = "Sphere", Size = length, CFrame = shape.CFrame }
	end
	params.Caster = caster
	params.Filter = (filter or "HostileToRunners") :: any
	params.Sorting = "Nearest"
	params.MaxTargets = maxTargets
	local found = HitboxService.Query(params)

	-- Trim the box down to the real shape.
	local result = {}
	local center = shape.CFrame.Position
	for _, character in found do
		local root = Characters.GetRoot(character)
		if root then
			local offset = (root.Position - center) * Vector3.new(1, 0, 1)
			local keep = true
			if shape.Kind == "Circle" then
				keep = offset.Magnitude <= (shape.Radius or 8) + 1.5
			elseif shape.Kind == "Cone" then
				local look = shape.CFrame.LookVector * Vector3.new(1, 0, 1)
				local angle = if offset.Magnitude > 0.1 and look.Magnitude > 0.1 then math.deg(math.acos(math.clamp(offset.Unit:Dot(look.Unit), -1, 1))) else 0
				keep = angle <= (shape.Angle or 60) / 2
			end
			if keep then
				table.insert(result, character)
			end
		end
	end
	return result
end

-- Damages DestructibleCover parts in a circle or line (basic version until the destruction port).
function Common.DamageCover(shape: Shape, damage: number)
	local size, cframe
	if shape.Kind == "Line" then
		size = Vector3.new(shape.Width or 6, 40, shape.Length or 40)
		cframe = shape.CFrame * CFrame.new(0, 0, -(shape.Length or 40) / 2)
	else
		local r = shape.Radius or shape.Length or 8
		size = Vector3.new(r * 2, 40, r * 2)
		cframe = shape.CFrame
	end
	for _, part in workspace:GetPartBoundsInBox(cframe, size) do
		if CollectionService:HasTag(part, "DestructibleCover") and part.Anchored then
			local health = (part:GetAttribute("Health") :: number?) or 100
			health -= damage
			part:SetAttribute("Health", health)
			if health <= 0 then
				CollectionService:RemoveTag(part, "DestructibleCover")
				part.Anchored = false
				part.AssemblyLinearVelocity = (part.Position - shape.CFrame.Position).Unit * 40 + Vector3.new(0, 40, 0)
				Debris:AddItem(part, 2)
			end
		end
	end
end

-- Runners just outside a strike get a stamina refund (GAME_PLAN.md: near-miss dodges).
function Common.NearMiss(shape: Shape, hit: { Model })
	if shape.Kind ~= "Circle" then
		return
	end
	local hitSet = {}
	for _, character in hit do
		hitSet[character] = true
	end
	local center = shape.CFrame.Position
	local r = shape.Radius or 8
	for _, player in Players:GetPlayers() do
		local character = player.Character
		if character and not hitSet[character] and Characters.GetRole(character) == "Runner" and Characters.IsAlive(character) then
			local root = Characters.GetRoot(character)
			local distance = if root then ((root.Position - center) * Vector3.new(1, 0, 1)).Magnitude else math.huge
			if distance > r and distance <= r + MovementConfig.NearMiss.Radius then
				local refund = MovementConfig.NearMiss.StaminaRefund
				if player:GetAttribute("Passive_AutonomousReflex") then
					refund = 30
				end
				Remotes.Event("Stamina"):FireClient(player, refund, "NearMiss")
				player:SetAttribute("NearMissAt", workspace:GetServerTimeNow())
			end
		end
	end
end

-- Builds Afflict args from a behaviour table. `center` drives outward knockback.
function Common.AfflictArgs(behavior: { [string]: any }, cast: any, center: Vector3, direction: Vector3?, damage: number?): CombatService.AfflictArgs
	local args: CombatService.AfflictArgs = {
		Cast = cast,
		Damage = damage or behavior.Dmg,
		Stun = behavior.Stun,
		Root = behavior.Root,
		Ragdoll = behavior.Ragdoll,
		Silence = behavior.Silence,
		InfiniteVoid = behavior.Void,
	}
	if behavior.Slow then
		args.Slow = { Factor = behavior.Slow.Factor, Duration = behavior.Slow.Duration }
	end
	if behavior.KB then
		if behavior.KB.Along and direction then
			args.Knockback = { Direction = direction, Power = behavior.KB.Power, Lift = behavior.KB.Lift }
		else
			args.Knockback = { From = center, Power = behavior.KB.Power, Lift = behavior.KB.Lift }
		end
	end
	return args
end

-- Extra on-hit effects that aren't part of Afflict (blind, invert, outline, burn).
function Common.OnHitExtras(attacker: Player, victim: Model, behavior: { [string]: any }, cast: any)
	local victimPlayer = Players:GetPlayerFromCharacter(victim)
	if behavior.Blind and victimPlayer then
		Common.FxTo(victimPlayer, { Kind = "Blind", Duration = behavior.Blind })
	end
	if behavior.Invert and victimPlayer then
		Common.FxTo(victimPlayer, { Kind = "Invert", Duration = behavior.Invert })
	end
	if behavior.Outline then
		local highlight = Instance.new("Highlight")
		highlight.Name = "AbilityOutline"
		highlight.FillTransparency = 1
		highlight.OutlineColor = Color3.fromRGB(255, 60, 60)
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = victim
		Debris:AddItem(highlight, behavior.Outline)
	end
	if behavior.Burn then
		local ticks = math.floor(behavior.Burn.Duration)
		task.spawn(function()
			for _ = 1, ticks do
				task.wait(1)
				if not Characters.IsAlive(victim) then
					break
				end
				CombatService.DealDamage(attacker, victim, behavior.Burn.Dps, cast)
			end
		end)
	end
end

return Common
