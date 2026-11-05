--!strict
-- Destructible cover (GAME_PLAN.md Section 4: "Cover objects carry a DestructibleCover tag with an
-- integer Health attribute... strikes split parts into voxels... debris clears after a moment").
--
-- The server only tracks health and removes broken parts. The voxel debris is simulated on each
-- client (FxController "Shatter"), so 25 players' worth of flying rubble costs no server physics
-- or network ownership churn.
--
-- Ruins: parts sharing a "Group" attribute fall together. When every wall of a group is gone,
-- its roof ("Roof" = true) collapses too.

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MapConfig = require(ReplicatedStorage.Shared.Config.MapConfig)
local Remotes = require(ReplicatedStorage.Shared.Network.Remotes)
local Signal = require(ReplicatedStorage.Shared.Util.Signal)

local DestructionService = {}

local TAG = "DestructibleCover"

-- (part, origin) after a cover part breaks.
DestructionService.Broken = Signal.new()

local function shatter(part: BasePart, origin: Vector3)
	local cfg = MapConfig.Destruction
	Remotes.Event("AbilityFx"):FireAllClients({
		Kind = "Shatter",
		CFrame = part.CFrame,
		Size = part.Size,
		Color = part:GetAttribute("BaseColor") or part.Color,
		Material = part.Material,
		Origin = origin,
		Power = cfg.Power,
		CellSize = cfg.CellSize,
		MaxCells = cfg.MaxCells,
		Life = cfg.DebrisLife,
	})
end

-- Breaks a cover part right away.
function DestructionService.Break(part: BasePart, origin: Vector3?)
	if not part.Parent or not CollectionService:HasTag(part, TAG) then
		return
	end
	local from = origin or part.Position
	CollectionService:RemoveTag(part, TAG)
	shatter(part, from)
	local group = part:GetAttribute("Group")
	local parent = part.Parent
	part:Destroy()
	DestructionService.Broken:Fire(part, from)

	-- Roof collapse: no walls left in the group brings its roof down.
	if group ~= nil and parent then
		local wallsLeft = 0
		local roofs = {}
		for _, sibling in parent:GetChildren() do
			if sibling:IsA("BasePart") and sibling:GetAttribute("Group") == group and CollectionService:HasTag(sibling, TAG) then
				if sibling:GetAttribute("Roof") then
					table.insert(roofs, sibling)
				else
					wallsLeft += 1
				end
			end
		end
		if wallsLeft == 0 then
			for _, roof in roofs do
				task.delay(0.15, DestructionService.Break, roof, from)
			end
		end
	end
end

-- Damages a cover part. Returns true if it broke.
function DestructionService.Damage(part: BasePart, amount: number, origin: Vector3?): boolean
	if not CollectionService:HasTag(part, TAG) or amount <= 0 then
		return false
	end
	local maxHealth = part:GetAttribute("MaxHealth")
	local health = (part:GetAttribute("Health") :: number?) or 100
	if type(maxHealth) ~= "number" then
		maxHealth = health
		part:SetAttribute("MaxHealth", health)
		part:SetAttribute("BaseColor", part.Color)
	end
	health -= amount
	part:SetAttribute("Health", health)
	if health <= 0 then
		DestructionService.Break(part, origin)
		return true
	end
	-- Cracked: darken as it weakens.
	local fraction = health / (maxHealth :: number)
	if fraction < MapConfig.Destruction.CrackAt then
		local base = part:GetAttribute("BaseColor")
		if typeof(base) == "Color3" then
			part.Color = base:Lerp(Color3.new(0.15, 0.13, 0.12), (1 - fraction) * 0.6)
		end
	end
	return false
end

function DestructionService.Init() end

function DestructionService.Start() end

return DestructionService
