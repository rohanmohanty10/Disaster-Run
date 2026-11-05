--!strict
-- Fog of War on the client (GAME_PLAN.md Section 4B). Only active when FogConfig.Enabled.
--   * FogZone parts are drawn thick for Gods and as a light haze for Runners.
--   * Gods don't see Concealed Runners (LocalTransparencyModifier, name tags hidden).
--   * Exposed Runners get a white highlight Gods see through fog and walls.
-- The server decides who is Concealed / Exposed (FogService); this only draws it.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local FogConfig = require(ReplicatedStorage.Shared.Config.FogConfig)

local LocalPlayer = Players.LocalPlayer

local FogController = {}

local TAG = "FogZone"

local function isGod(): boolean
	return LocalPlayer:GetAttribute("Role") == "God"
end

local function styleZone(zone: Instance)
	if not zone:IsA("BasePart") then
		return
	end
	zone.Color = FogConfig.FogColor
	zone.Material = Enum.Material.SmoothPlastic
	zone.CastShadow = false
	zone.Transparency = if isGod() then FogConfig.GodFogTransparency else FogConfig.RunnerFogTransparency
end

local function restyleAll()
	for _, zone in CollectionService:GetTagged(TAG) do
		styleZone(zone)
	end
end

local function setHidden(character: Model, hidden: boolean)
	for _, d in character:GetDescendants() do
		if d:IsA("BasePart") or d:IsA("Decal") then
			(d :: any).LocalTransparencyModifier = if hidden then 1 else 0
		end
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.DisplayDistanceType = if hidden then Enum.HumanoidDisplayDistanceType.None else Enum.HumanoidDisplayDistanceType.Viewer
	end
end

local function setExposedHighlight(character: Model, on: boolean)
	local existing = character:FindFirstChild("FogExposed")
	if on and not existing then
		local highlight = Instance.new("Highlight")
		highlight.Name = "FogExposed"
		highlight.FillColor = FogConfig.ExposedColor
		highlight.OutlineColor = FogConfig.ExposedColor
		highlight.FillTransparency = 0.5
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		highlight.Parent = character
	elseif not on and existing then
		existing:Destroy()
	end
end

local lastHidden: { [Model]: boolean } = {}

local function update()
	local god = isGod()
	for _, player in Players:GetPlayers() do
		local character = player.Character
		if character and player ~= LocalPlayer then
			local hidden = god and character:GetAttribute("Concealed") == true
			if lastHidden[character] ~= hidden then
				lastHidden[character] = hidden
				setHidden(character, hidden)
			end
			setExposedHighlight(character, god and character:GetAttribute("Exposed") == true)
		end
	end
	for character in lastHidden do
		if not character.Parent then
			lastHidden[character] = nil
		end
	end
end

-- Is a ground point inside the Spawn Fog? (GodController turns the reticle red there.)
function FogController.InSpawnFog(point: Vector3): boolean
	if not FogConfig.Enabled then
		return false
	end
	for _, zone in CollectionService:GetTagged(TAG) do
		if zone:IsA("BasePart") and zone:GetAttribute("Kind") == "Spawn" then
			local localPoint = zone.CFrame:PointToObjectSpace(Vector3.new(point.X, zone.Position.Y, point.Z))
			local half = zone.Size / 2
			if math.abs(localPoint.X) <= half.X and math.abs(localPoint.Z) <= half.Z then
				return true
			end
		end
	end
	return false
end

function FogController.Init() end

function FogController.Start()
	if not FogConfig.Enabled then
		return
	end
	restyleAll()
	CollectionService:GetInstanceAddedSignal(TAG):Connect(styleZone)
	LocalPlayer:GetAttributeChangedSignal("Role"):Connect(function()
		restyleAll()
		-- Role changes reveal everyone again; the next update hides whoever should be.
		for character in lastHidden do
			setHidden(character, false)
		end
		table.clear(lastHidden)
	end)
	local timer = 0
	RunService.Heartbeat:Connect(function(dt)
		timer += dt
		if timer >= 0.1 then
			timer = 0
			update()
		end
	end)
end

return FogController
