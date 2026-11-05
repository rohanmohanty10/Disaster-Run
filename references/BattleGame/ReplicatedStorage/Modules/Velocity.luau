local Velocity = {}
Velocity.__index = Velocity

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")


local Remotes = ReplicatedStorage.Remotes

local Trove = require(ReplicatedStorage.Modules.Trove)
--local Utility = require(ReplicatedStorage.Modules.Shared.Utilities.Utility)
local VelocityUtil = require(script.VelocityUtil)

local function CreateBodyVelocity(hrp, Name : string)
	return VelocityUtil.Create(hrp, Name)
end

function Velocity:Remove()
	if self.Removed then return end

	self.Removed = true
	self.Trove:Destroy()
end

function Velocity:Destroy()
	if self.Removed then return end
	
	self:Remove()
	
	if RunService:IsServer() then
		self.Player:SetAttribute("Velocity", nil)
	end
end

function Velocity:Create()
	if self.Removed then return end
	
	local NewBodyVelocity : BodyVelocity? = CreateBodyVelocity(self.RootPart, self.Settings.Name)

	if (NewBodyVelocity ~= nil) then
		NewBodyVelocity:SetAttribute("RemoveOn", self.Player and self.Player.Name)
		NewBodyVelocity:AddTag("RemoveOnEvasive", true)
		NewBodyVelocity.MaxForce = self.Settings.MaxForce or Vector3.one * 80000
		
		local Start = os.clock()

		local function UpdateVelocityForServer()
			local DurationTaper = 1;

			if not self.Settings.DontScale and self.Settings.Duration then
				-- It was bugged 💔 and i cant apply the fix globally without breaking everything
				if self.Settings.FixScale then
					DurationTaper = math.max(0, 1 - (os.clock() - Start) / self.Settings.Duration)
				else
					DurationTaper = math.max(0, self.Settings.Duration - (os.clock() - Start) / self.Settings.Duration)
				end
			end

			if self.Settings.Controllable then
				--if Utility.IsFacingOnAWall(self.LuaCharacter.RootPart) then
				if false then
					NewBodyVelocity.Velocity = Vector3.zero
				else
					local CF : CFrame = self.RootPart.CFrame;
					local ControlledVelocity: Vector3 = self.Settings.Velocity or Vector3.zero;

					if self.Settings.X then
						ControlledVelocity += CF.RightVector * self.Settings.X
					end

					if self.Settings.Y then
						ControlledVelocity += CF.UpVector * self.Settings.Y
					end

					if self.Settings.Z then
						ControlledVelocity += CF.LookVector * self.Settings.Z
					end

					NewBodyVelocity.Velocity = ControlledVelocity * DurationTaper;
				end

			elseif self.Settings.Velocity then
				NewBodyVelocity.Velocity = self.Settings.Velocity * DurationTaper;
			end
		end;
		
		task.spawn(UpdateVelocityForServer);
		self.Trove:Add(RunService.PreAnimation:Connect(UpdateVelocityForServer))

		NewBodyVelocity.Destroying:Once(function()
			self:Remove()
		end)

		self.Object = NewBodyVelocity
		NewBodyVelocity.Parent = self.RootPart
		
		self.Trove:Add(NewBodyVelocity)
		
		if self.Settings.Spin then
			local Spin = Instance.new("BodyAngularVelocity")
			Spin.MaxTorque = self.Settings.SpinTorque or (Vector3.one * 1e6)
			Spin.P = self.Settings.SpinPower or 1e5
			Spin.AngularVelocity = self.Settings.Spin -- rad/s, world-space
			Spin.Parent = self.RootPart
			self.Trove:Add(Spin) -- cleaned up with everything else on Remove
		end

	end
end
	
function Velocity:Fire()
	if self.Removed or not self.RootPart then return end

	if RunService:IsServer() then	
		if not self.Player then
			--pcall(function() self.RootPart:SetNetworkOwner(nil) end)
			self:Create()
		else
			self.Player:SetAttribute("Velocity", true)
			Remotes.Combat.Velocity:FireClient(self.Player, self.Settings)
		end		
	else
		--if not self.Settings.NeedsVelocityAttribute or self.LuaPlayer.Replication.Attributes:GetAttribute("Velocity") then
		if self.Settings.DoesntNeedVelocityAttribute or self.Player:GetAttribute("Velocity") then
			self:Create()
			--warn("Client Velocity new test1")

			if RunService:IsClient() then
				self.Trove:Add(self.Player:GetAttributeChangedSignal("Velocity"):Connect(function()
					if not self.Player:GetAttribute("Velocity") then
						self:Remove()
					end
				end))
			end
		end
	end
	
	if self.Settings.RemoveTime then
		task.delay(self.Settings.RemoveTime, self.Remove, self)
	end
end

local Main = {}
Main.Utility = require(script.VelocityUtil)

function Main.new(Character: Model)
	local self = setmetatable({}, Velocity)
	
	self.Character = Character
	self.RootPart  = Character:FindFirstChild("HumanoidRootPart")
	self.Humanoid  = Character:FindFirstChildOfClass("Humanoid")
	self.Player    = Players:GetPlayerFromCharacter(Character) -- nil for NPCs, fine
	
	self.Settings = {}
	self.Trove    = Trove.new()
	self.Removed  = false
	
	--if self.Humanoid then
	--	self.Trove:Add(self.Humanoid.Died:Connect(function()
	--		self:Remove()
	--	end))
	--end
	self.Trove:Add(self.Character.AncestryChanged:Connect(function()
		if not self.Character:IsDescendantOf(workspace) then
			self:Remove()
		end
	end))
	
	--local Params = RaycastParams.new()
	--Params.FilterDescendantsInstances = {workspace.Visuals, self.LuaCharacter.Model, workspace.Projectiles}
	--Params.FilterType = Enum.RaycastFilterType.Exclude

	--self.Params = Params
	
	--if RunService:IsClient() then
	--	self.Job:Task(self.LuaPlayer.Replication.Attributes:GetAttributeChangedSignal("Velocity"):Connect(function()
	--		if not self.LuaPlayer.Replication.Attributes:GetAttribute("Velocity") then
	--			self:Remove()
	--		end
	--	end))
	--end
	
	return self
end

return Main
