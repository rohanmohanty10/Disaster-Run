--[[
	SupplyDropService (Script)

	Every few minutes a Marine supply crate falls somewhere open on the island. Everyone gets a
	warning and a red marker where it'll land. The first player to open it gets Gold and a random
	item, rolled with the Store crate's odds (ShopConfig.Crate.Odds).

	Settings are just below.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")

local ShopConfig = require(ReplicatedStorage.Modules.ShopConfig)
local ItemConfig = require(ReplicatedStorage.Modules.ItemConfig)
local ItemService = require(ServerStorage.SBGModules.ItemService)
local DebreeService = require(ServerStorage.SBGModules.DebreeService)
local DataManager = require(ServerScriptService.Data.DataManager)

local ComSet: RemoteEvent = ReplicatedStorage.Remotes.Comunicator.Set
local ReplicateSet: RemoteEvent = ReplicatedStorage.Remotes.Replicate.Set

-- Settings
local FIRST_DROP = 120 -- seconds after the server starts
local INTERVAL = { 240, 420 } -- seconds between drops, random in this range
local MIN_PLAYERS = 2 -- no drops with fewer players than this
local WARNING_TIME = 8 -- seconds from the announcement to the landing (the fall is the last FALL_TIME)
local FALL_TIME = 3
local FALL_HEIGHT = 350
local OPEN_TIME = 2.5 -- seconds you hold the prompt to open it
local CRATE_LIFE = 150 -- an unopened crate disappears after this
local GOLD = 150 -- given on top of the item
local CRATE_SCALE = 2.2
local CRATER_SIZE = 14

local World = workspace:WaitForChild("World")
local Map = World:WaitForChild("Map")
local Floor = Map:WaitForChild("Indestructible Map"):WaitForChild("IndestructableFloor")
local Template = ReplicatedStorage.Assets.Items.SupplyCrate

local Folder = Instance.new("Folder")
Folder.Name = "SupplyDrops"
Folder.Parent = World

local GroundParams = RaycastParams.new()
GroundParams.FilterType = Enum.RaycastFilterType.Include
GroundParams.FilterDescendantsInstances = { Map }

local Rng = Random.new()

local function Announce(Text: string)
	ComSet:FireAllClients("ChatMessage", `<font face='GothamBold' color='#4FA3FF'>[MARINE SUPPLY DROP]</font> <font face='GothamBold'>{Text}</font>`)
end

local function RollItem(): string
	local Total = 0
	for _, Weight in ShopConfig.Crate.Odds do
		Total += Weight
	end
	local Pick = Rng:NextNumber(0, Total)
	for Id, Weight in ShopConfig.Crate.Odds do
		Pick -= Weight
		if Pick <= 0 then
			return Id
		end
	end
	return (next(ShopConfig.Crate.Odds))
end

-- open street on the island: not on a roof, not out on the walls or scenery, not in the water
local function PickSpot(): Vector3?
	local Center, Size = Floor:GetBoundingBox()
	for _ = 1, 40 do
		local Offset = Vector3.new(Rng:NextNumber(-0.42, 0.42) * Size.X, 0, Rng:NextNumber(-0.42, 0.42) * Size.Z)
		local Hit = workspace:Raycast(Center.Position + Offset + Vector3.yAxis * 300, Vector3.yAxis * -600, GroundParams)
		if Hit
			and Hit.Position.Y > 20 and Hit.Position.Y < 45
			and not Hit.Instance:FindFirstAncestor("Building")
			and not Hit.Instance:FindFirstAncestor("OutsideWall")
			and not Hit.Instance:FindFirstAncestor("OutsideScenery")
		then
			return Hit.Position
		end
	end
	return nil
end

local function MakeMarker(Ground: Vector3): BasePart
	local Marker = Instance.new("Part")
	Marker.Name = "DropMarker"
	Marker.Shape = Enum.PartType.Cylinder
	Marker.Size = Vector3.new(0.2, CRATER_SIZE + 4, CRATER_SIZE + 4)
	Marker.CFrame = CFrame.new(Ground + Vector3.yAxis * 0.15) * CFrame.Angles(0, 0, math.pi / 2)
	Marker.Anchored = true
	Marker.CanCollide = false
	Marker.CanQuery = false
	Marker.CanTouch = false
	Marker.Material = Enum.Material.Neon
	Marker.Color = Color3.fromRGB(255, 45, 45)
	Marker.Transparency = 0.55
	Marker.Parent = Folder
	TweenService:Create(Marker, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), { Transparency = 0.85 }):Play()
	return Marker
end

local function MakeCrate(): Model
	local Crate = Template:Clone()
	Crate.Name = "MarineSupplyCrate"
	local Biggest: BasePart? = nil
	for _, Part in Crate:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.Anchored = true
			Part.CanTouch = false
			if not Biggest or Part.Size.Magnitude > Biggest.Size.Magnitude then
				Biggest = Part
			end
		end
	end
	Crate.PrimaryPart = Biggest
	Crate:ScaleTo(Crate:GetScale() * CRATE_SCALE)

	local Glow = Instance.new("Highlight")
	Glow.FillTransparency = 1
	Glow.OutlineColor = Color3.fromRGB(80, 165, 255)
	Glow.DepthMode = Enum.HighlightDepthMode.Occluded
	Glow.Parent = Crate
	return Crate
end

local function ShakeNear(Position: Vector3)
	for _, Player in Players:GetPlayers() do
		local Root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
		if Root and (Root.Position - Position).Magnitude < 120 then
			ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 8, Last = 0.4 })
		end
	end
end

local function Drop()
	local Ground = PickSpot()
	if not Ground then
		warn("[SupplyDropService] couldn't find open ground for a drop")
		return
	end

	Announce("A crate is falling on the island! First to open it gets Gold and an item.")
	ComSet:FireAllClients("SendNotification", { Title = "MARINE SUPPLY DROP", Text = "A crate is falling on the island!", Duration = 6 })
	local Marker = MakeMarker(Ground)
	task.wait(WARNING_TIME - FALL_TIME)

	local Crate = MakeCrate()
	local _, Size = Crate:GetBoundingBox()
	local Landed = CFrame.new(Ground + Vector3.yAxis * (Size.Y / 2)) * CFrame.Angles(0, Rng:NextNumber(0, math.pi * 2), 0)
	local Height = Instance.new("NumberValue")
	Height.Value = FALL_HEIGHT
	Height.Changed:Connect(function(Value)
		Crate:PivotTo(Landed + Vector3.yAxis * Value)
	end)
	Crate:PivotTo(Landed + Vector3.yAxis * FALL_HEIGHT)
	Crate.Parent = Folder
	local Fall = TweenService:Create(Height, TweenInfo.new(FALL_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { Value = 0 })
	Fall:Play()
	Fall.Completed:Wait()
	Height:Destroy()
	Marker:Destroy()

	DebreeService.Destroy(CFrame.new(Ground), Vector3.one * CRATER_SIZE, {
		Shape = "Ball",
		Outward = true,
		Power = 35,
	})
	ShakeNear(Ground)

	local Opened = false
	local Prompt = Instance.new("ProximityPrompt")
	Prompt.ActionText = "Open"
	Prompt.ObjectText = "Marine Supply Crate"
	Prompt.HoldDuration = OPEN_TIME
	Prompt.MaxActivationDistance = 12
	Prompt.RequiresLineOfSight = false
	Prompt.Parent = Crate.PrimaryPart
	Prompt.Triggered:Connect(function(Player)
		local Character = Player.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		if Opened or not Humanoid or Humanoid.Health <= 0 or Character:HasTag("Ragdolled") or Character:FindFirstChild("Stunned") then
			return
		end
		Opened = true
		Crate:Destroy()

		local Id = RollItem()
		DataManager.addGold(Player, GOLD)
		ItemService.Give(Character, Id)
		local Info = ItemConfig.Get(Id)
		Announce(`{Player.DisplayName} opened the crate and got {GOLD} Gold and a {Info and Info.Name or Id}!`)
	end)

	task.delay(CRATE_LIFE, function()
		if not Opened and Crate.Parent then
			Crate:Destroy()
			Announce("Nobody opened the crate. The Marines took it back.")
		end
	end)
end

task.wait(FIRST_DROP)
while true do
	if #Players:GetPlayers() >= MIN_PLAYERS then
		local ok, err = pcall(Drop)
		if not ok then
			warn("[SupplyDropService] drop failed:", err)
		end
	end
	task.wait(Rng:NextNumber(INTERVAL[1], INTERVAL[2]))
end
