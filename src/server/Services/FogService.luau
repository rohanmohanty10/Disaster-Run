--!strict
-- Fog of War (GAME_PLAN.md Section 4B). Fog only blocks the Gods' view.
--   * Runners inside a FogZone are Concealed (character attribute): God clients hide them and
--     the Runner tracker leaves them out (FogController / MatchHUDController).
--   * Gods can't aim into the Spawn Fog (AbilityService asks BlocksCast).
--   * Exposure: too long in fog, or too long without moving forward, makes a Runner Exposed
--     (character attribute): a white highlight Gods see through fog and walls.
--
-- Switched off by FogConfig.Enabled = false (ROADMAP: don't turn fog on until Rohan says so).
-- Fog volumes: parts tagged "FogZone" with Kind = "Spawn" | "Patch" (MapService places patches).

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FogConfig = require(ReplicatedStorage.Shared.Config.FogConfig)
local MapConfig = require(ReplicatedStorage.Shared.Config.MapConfig)
local Characters = require(ReplicatedStorage.Shared.Util.Characters)

local FogService = {}

local TAG = "FogZone"

type RunnerState = {
	FogTime: number,
	OutSince: number?, -- os.clock() the Runner last left fog
	ExposedSince: number?,
	BestProgress: number,
	LastProgressAt: number,
	WasInSpawn: boolean,
	Round: number, -- timers start over every round
}

local states: { [Player]: RunnerState } = {}

-- Is a world point inside one fog zone part?
function FogService.Contains(zone: BasePart, position: Vector3): boolean
	local radius = zone:GetAttribute("Radius")
	local shape = if zone:IsA("Part") then zone.Shape else nil
	local round = type(radius) == "number" or shape == Enum.PartType.Ball or shape == Enum.PartType.Cylinder
	if round then
		local r = if type(radius) == "number" then radius else math.max(zone.Size.X, zone.Size.Z) / 2
		local offset = position - zone.Position
		return Vector3.new(offset.X, 0, offset.Z).Magnitude <= r and math.abs(offset.Y) <= zone.Size.Y / 2 + 4
	end
	local localPoint = zone.CFrame:PointToObjectSpace(position)
	local half = zone.Size / 2
	return math.abs(localPoint.X) <= half.X and math.abs(localPoint.Y) <= half.Y + 4 and math.abs(localPoint.Z) <= half.Z
end

-- The fog zone at a position (Spawn wins over Patch), and its kind.
function FogService.ZoneAt(position: Vector3): (BasePart?, string?)
	local found: BasePart? = nil
	local kind: string? = nil
	for _, zone in CollectionService:GetTagged(TAG) do
		if zone:IsA("BasePart") and zone:IsDescendantOf(workspace) and FogService.Contains(zone, position) then
			local zoneKind = zone:GetAttribute("Kind")
			if zoneKind == "Spawn" then
				return zone, "Spawn"
			end
			found = zone
			kind = if type(zoneKind) == "string" then zoneKind else "Patch"
		end
	end
	return found, kind
end

-- Gods may not aim strikes into the Spawn Fog.
function FogService.BlocksCast(target: Vector3): boolean
	if not FogConfig.Enabled then
		return false
	end
	for _, zone in CollectionService:GetTagged(TAG) do
		if zone:IsA("BasePart") and zone:GetAttribute("Kind") == "Spawn" then
			-- Ignore height: the reticle is on the ground, the zone may sit above it.
			local flatTarget = Vector3.new(target.X, zone.Position.Y, target.Z)
			if FogService.Contains(zone, flatTarget) then
				return true
			end
		end
	end
	return false
end

-- Makes a fog volume part (invisible on the server; clients draw it per role).
function FogService.MakeZone(kind: "Spawn" | "Patch", cframe: CFrame, size: Vector3, radius: number?, parent: Instance): Part
	local part = Instance.new("Part")
	part.Name = if kind == "Spawn" then "SpawnFog" else "FogPatch"
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Transparency = 1
	part.Size = size
	part.CFrame = cframe
	if radius then
		part.Shape = Enum.PartType.Cylinder
		part.Size = Vector3.new(size.Y, radius * 2, radius * 2)
		part.CFrame = cframe * CFrame.Angles(0, 0, math.rad(90))
		part:SetAttribute("Radius", radius)
	end
	part:SetAttribute("Kind", kind)
	CollectionService:AddTag(part, TAG)
	part.Parent = parent
	return part
end

-- Adds the Spawn Fog over the start bunker if the course doesn't have one.
local function ensureSpawnFog()
	for _, zone in CollectionService:GetTagged(TAG) do
		if zone:GetAttribute("Kind") == "Spawn" then
			return
		end
	end
	local course = workspace:FindFirstChild("Course")
	local barrier = course and course:FindFirstChild("StartBarrier")
	local origin = if barrier and barrier:IsA("BasePart") then barrier.Position else MapConfig.Origin
	local cfg = FogConfig.Spawn
	local back = 60 -- the bunker behind the barrier
	local length = back + cfg.PastBarrier
	local centerZ = origin.Z + back - length / 2 -- the course runs toward -Z
	local folder = workspace:FindFirstChild("FogZones") or Instance.new("Folder")
	folder.Name = "FogZones"
	folder.Parent = workspace
	FogService.MakeZone("Spawn", CFrame.new(origin.X, MapConfig.Origin.Y + cfg.Height / 2, centerZ), Vector3.new(MapConfig.Width, cfg.Height, length), nil, folder)
end

-- ------------------------------------------------------------------ exposure
local function stateFor(player: Player): RunnerState
	local round = (ReplicatedStorage:GetAttribute("RoundNumber") :: number?) or 0
	local state = states[player]
	if not state or state.Round ~= round then
		local fresh: RunnerState = { FogTime = 0, BestProgress = 0, LastProgressAt = os.clock(), WasInSpawn = false, Round = round }
		states[player] = fresh
		return fresh
	end
	return state
end

local function clearCharacter(character: Model?)
	if character then
		character:SetAttribute("Concealed", nil)
		character:SetAttribute("Exposed", nil)
	end
end

local function tick(dt: number)
	local running = ReplicatedStorage:GetAttribute("RoundState") == "ActiveRun"
	local inMatch = ReplicatedStorage:GetAttribute("MatchActive") == true
	local exposure = FogConfig.Exposure
	local now = os.clock()
	for _, player in Players:GetPlayers() do
		local character = player.Character
		local root = character and Characters.GetRoot(character)
		local active = inMatch
			and player:GetAttribute("Role") == "Runner"
			and not player:GetAttribute("Finished")
			and character ~= nil
			and root ~= nil
			and Characters.IsAlive(character)
		if not active then
			states[player] = nil
			clearCharacter(character)
			continue
		end
		local state = stateFor(player)
		local _, kind = FogService.ZoneAt((root :: BasePart).Position)
		local inFog = kind ~= nil

		if running then
			-- Fog timer (doesn't reset until ResetAfterOutOfFog seconds out of fog).
			if inFog then
				state.FogTime += dt
				state.OutSince = nil
				state.WasInSpawn = kind == "Spawn"
			else
				state.OutSince = state.OutSince or now
				if now - (state.OutSince :: number) >= exposure.ResetAfterOutOfFog then
					state.FogTime = 0
				end
			end
			local limit = if state.WasInSpawn then exposure.SpawnFogLimit else exposure.FogLimit
			if inFog and state.FogTime >= limit and not state.ExposedSince then
				state.ExposedSince = now
			end

			-- No forward progress for too long.
			local progress = ((player:GetAttribute("Progress") :: number?) or 0) * MapConfig.Length
			if progress >= state.BestProgress + exposure.ProgressStep then
				state.BestProgress = progress
				state.LastProgressAt = now
			elseif now - state.LastProgressAt >= exposure.NoProgressLimit and not state.ExposedSince then
				state.ExposedSince = now
				state.LastProgressAt = now
			end

			-- Clearing: at least MinDuration, and out of fog for ClearAfterOutOfFog.
			if state.ExposedSince then
				local outFor = if state.OutSince then now - state.OutSince else 0
				if now - state.ExposedSince >= exposure.MinDuration and not inFog and outFor >= exposure.ClearAfterOutOfFog then
					state.ExposedSince = nil
				end
			end
		else
			state.LastProgressAt = now
		end

		local exposed = state.ExposedSince ~= nil
		local c = character :: Model
		c:SetAttribute("Exposed", exposed or nil)
		c:SetAttribute("Concealed", (inFog and not exposed) or nil)
	end
end

function FogService.Init() end

function FogService.Start()
	if not FogConfig.Enabled then
		return
	end
	ensureSpawnFog()
	Players.PlayerRemoving:Connect(function(player)
		states[player] = nil
	end)
	task.spawn(function()
		while true do
			local dt = task.wait(FogConfig.Tick)
			local ok, err = pcall(tick :: any, dt)
			if not ok then
				warn(`[FogService] {err}`)
			end
		end
	end)
end

return FogService
