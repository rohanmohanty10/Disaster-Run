--ProjectileService — server-authoritative projectiles.
--A projectile is pure math on the server (Position + Direction stepped per frame).
--Clients render a visual for the replication handle and lerp toward server positions.
--Auto-creates its remotes + workspace folder; no manual setup.

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local HitboxHandler = require(ServerStorage.SBGModules.HitboxHandler)

local Remotes = ReplicatedStorage.Remotes

local function GetOrCreate(parent: Instance, name: string, className: string): Instance
	local found = parent:FindFirstChild(name)
	if not found then
		found = Instance.new(className)
		found.Name = name
		found.Parent = parent
	end
	return found
end

local ProjectileRemotes = GetOrCreate(Remotes, "Projectile", "Folder")
local CreateRemote: RemoteEvent = GetOrCreate(ProjectileRemotes, "Create", "RemoteEvent")
local UpdateRemote: RemoteEvent = GetOrCreate(ProjectileRemotes, "Update", "RemoteEvent")

local ProjectileFolder = GetOrCreate(workspace, "Projectiles", "Folder")

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local DownwardVector = Vector3.yAxis * -30

----------------------------------------------------------------------------------

local Projectile = {}
Projectile.__index = Projectile

local ActiveProjectiles = {}

function Projectile.new(Name: string, OwnerCharacter: Model, Origin: Vector3, Direction: Vector3, Settings: {}?)
	Settings = Settings or {}

	local self = setmetatable({}, Projectile)

	self.OwnerCharacter = OwnerCharacter

	self.MaxDistance = Settings.MaxDistance or 150
	self.MaxTime = Settings.MaxTime or 5
	self.DetectionSize = Settings.DetectionSize or 5
	self.HeightenWithGround = Settings.HeightenWithGround or false
	self.Height = Settings.Height or 0

	self.HeightVector = Vector3.yAxis * self.Height
	self.BlockcastSize = Vector3.new(self.DetectionSize, self.DetectionSize, 0.001)

	self.Traveled = 0
	self.Active = false

	self.Position = Origin + self.HeightVector
	self.Direction = Direction

	self.onHit = nil
	self.onMapHit = nil
	self.onExpire = nil

	self.Hitbox = HitboxHandler.new()
	self.Hitbox.Size = Vector3.one * self.DetectionSize
	self.Hitbox.Ignore = { OwnerCharacter }
	self.Hitbox.Visualize = Settings.Visualize or false
	self.Hitbox.HitType = Settings.HitType
	self.Hitbox.onTouch = function(EnemyCharacter)
		if self.onHit then
			self.onHit(EnemyCharacter)
		end
	end

	self.Instance = Instance.new("Configuration")
	self.Instance.Name = Name
	self.Instance.Parent = ProjectileFolder

	CreateRemote:FireAllClients(self.Instance, self.Position, self.Direction)

	return self
end

function Projectile:Update(Delta: number)
	if not self.Active then return end

	if self.Traveled >= self.MaxDistance or (os.clock() - self.StartTime) > self.MaxTime then
		if self.onExpire then
			self.onExpire()
		end
		return self:Destroy()
	end

	local Position: Vector3 = self.Position
	local StepVector: Vector3 = self.Direction * Delta

	self.Hitbox.Instance = CFrame.new(Position)
	self.Hitbox:Once()

	if not self.Active then return end

	local Raycast = workspace:Blockcast(CFrame.new(Position), self.BlockcastSize, StepVector, MapRayParams)

	if Raycast then
		if self.onMapHit then
			self.onMapHit(Raycast)
		end
		return self:Destroy()
	end

	local NewPosition = Position + StepVector

	if self.HeightenWithGround then
		local GroundRaycast = workspace:Raycast(Position, DownwardVector, MapRayParams)
		if GroundRaycast then
			NewPosition = GroundRaycast.Position + self.HeightVector + StepVector
		end
	end

	self.Position = NewPosition
	self.Traveled += StepVector.Magnitude

	UpdateRemote:FireAllClients(self.Instance, self.Position, StepVector)
end

function Projectile:SetDirection(Direction: Vector3)
	self.Direction = Direction
end

function Projectile:Start()
	if not self.Active then
		self.Active = true
		self.StartTime = os.clock()
		ActiveProjectiles[self] = true
	end
end

function Projectile:Stop()
	if self.Active then
		self.Active = false
		ActiveProjectiles[self] = nil
	end
end

function Projectile:Destroy()
	self:Stop()

	if self.Hitbox then
		self.Hitbox:Destroy()
		self.Hitbox = nil
	end

	if self.Instance then
		self.Instance:Destroy()
		self.Instance = nil
	end
end

----------------------------------------------------------------------------------

RunService.PostSimulation:Connect(function(Delta)
	for ActiveProjectile in ActiveProjectiles do
		ActiveProjectile:Update(Delta)
	end
end)

return Projectile