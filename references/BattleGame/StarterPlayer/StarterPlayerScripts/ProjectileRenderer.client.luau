--ProjectileRenderer — client half of the projectile system.
--Builds a visual per replication handle (looked up by name in Visuals) and lerps
--it toward the latest server position. Add a builder for each projectile type.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

--local LightningBolt = require(ReplicatedStorage.Modules.LightningBolt)
local LightningBolt = require(ReplicatedStorage.Modules.ClientEffects.LightningBolt)


local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local ProjectileRemotes = Remotes:WaitForChild("Projectile")
local CreateRemote = ProjectileRemotes:WaitForChild("Create")
local UpdateRemote = ProjectileRemotes:WaitForChild("Update")

----------------------------------------------------------------------------------

local Visuals = {}

function Visuals.SunaPesado(Origin: Vector3, Direction: Vector3): BasePart
	local PURPLE = Color3.fromRGB(148, 121, 255)

	--local Visual = Instance.new("Part")
	--Visual.Name = "CrocodileRailgun"
	--Visual.Shape = Enum.PartType.Ball
	--Visual.Material = Enum.Material.Neon
	--Visual.Color = PURPLE
	--Visual.Size = Vector3.new(2.5, 2.5, 2.5)
	--Visual.Anchored = true
	--Visual.CanCollide = false
	--Visual.CanQuery = false
	--Visual.CanTouch = false
	--Visual.CastShadow = false
	--Visual.CFrame = CFrame.lookAlong(Origin, Direction)
	local Visual = ReplicatedStorage.Modules.ClientEffects.CharacterSkillEffects.Crocodile.RegularSkillsSet.SunaPesado.NewFx.SunaUltProjectile:Clone()
	Visual.CFrame = CFrame.lookAlong(Origin, Direction)
	Visual.Parent = workspace.World.Visuals

	--Lightning trail: arc a bolt from the previous point to the current one
	--whenever the core has moved > 5 studs (the Pesado "move" behaviour).
	local lastPos = Origin
	local conn
	conn = RunService.PreSimulation:Connect(function(dt)
		if not Visual.Parent then
			conn:Disconnect()
			return
		end
		
		local range = 15
		local function randomPurple()
			return Color3.fromRGB(
				math.random(148-range, 148+range),   -- R
				math.random(121-range, 121+range),    -- G
				math.random(255-range, 255)    -- B
			)
		end
		
		local pos = Visual.Position
		if (pos - lastPos).Magnitude < 5 then return end

		local a0 = Instance.new("Attachment")
		a0.Parent = workspace.Terrain
		a0.WorldPosition = lastPos
		Debris:AddItem(a0, 1)

		local a1 = Instance.new("Attachment")
		a1.Parent = workspace.Terrain
		a1.WorldPosition = pos
			+ Vector3.new(math.random(-3,3), math.random(-3, 3), math.random(-3, 0))
		Debris:AddItem(a1, 1)

		local bolt = LightningBolt.new(a0, a1, 20)
		bolt.Color = randomPurple()
		bolt.CurveSize0 = 0
		bolt.CurveSize1 = 0
		bolt.PulseSpeed = math.random(15, 50)
		bolt.PulseLength = math.random(1, 3)
		bolt.FadeLength = 0.1
		bolt.Thickness = math.random(120, 500) / 500
		bolt.Frequency = math.random(10, 50) / 100
		bolt.MaxRadius = math.random(3, 7)

		lastPos = pos
	end)

	Visual.Destroying:Once(function()
		conn:Disconnect()
	end)

	return Visual
end

----------------------------------------------------------------------------------

local Active = {}

local Projectile = {}
Projectile.__index = Projectile

function Projectile.new(Handle: Configuration, Origin: Vector3, Direction: Vector3)
	local Builder = Visuals[Handle.Name]
	if Builder == nil then return end

	local self = setmetatable({}, Projectile)

	self.Handle = Handle
	self.Visual = Builder(Origin, Direction)
	self.TargetCFrame = CFrame.lookAlong(Origin, Direction)

	Active[Handle] = self

	self.Connection = RunService.PreSimulation:Connect(function(Delta)
		self.Visual.CFrame = self.Visual.CFrame:Lerp(self.TargetCFrame, math.min(0.4 * (Delta * 60), 1))
	end)

	Handle.Destroying:Once(function()
		self:Destroy()
	end)

	return self
end

function Projectile:SetTarget(Position: Vector3, Direction: Vector3)
	if Direction.Magnitude > 0.001 then
		self.TargetCFrame = CFrame.lookAlong(Position, Direction)
	else
		self.TargetCFrame = CFrame.new(Position) * self.TargetCFrame.Rotation
	end
end

function Projectile:Destroy()
	Active[self.Handle] = nil

	self.Connection:Disconnect()

	for _, Descendant in self.Visual:GetDescendants() do
		if Descendant:IsA("ParticleEmitter") then
			Descendant.Enabled = false
		end
	end
	self.Visual.Transparency = 1

	local Light = self.Visual:FindFirstChildOfClass("PointLight")
	if Light then
		Light.Enabled = false
	end

	self.Visual:Destroy()
	--Debris:AddItem(self.Visual, 0.5)
end

----------------------------------------------------------------------------------

CreateRemote.OnClientEvent:Connect(function(Handle: Configuration?, Origin: Vector3, Direction: Vector3)
	if Handle ~= nil and Handle.Parent ~= nil and Active[Handle] == nil then
		Projectile.new(Handle, Origin, Direction)
	end
end)

UpdateRemote.OnClientEvent:Connect(function(Handle: Configuration?, Position: Vector3, Direction: Vector3)
	if Handle == nil then return end

	local self = Active[Handle]

	if self then
		self:SetTarget(Position, Direction)
	elseif Handle.Parent ~= nil then
		Projectile.new(Handle, Position, Direction)
	end
end)