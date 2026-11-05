-- services --

local RS = game:GetService('ReplicatedStorage')
local RNS = game:GetService('RunService')
local CS = game:GetService('CollectionService')
local SvSt = game:GetService('ServerStorage')
local TS = game:GetService('TweenService')
local Debris = game:GetService('Debris')
local Players = game:GetService('Players')


-- bindables --

local StartAirDetection = RS.Bindables.AirDetector


-- assets --

local Assets = SvSt.Assets


-- remotes --

local Remotes = RS.Remotes

local Replicate = Remotes.Replicate.Set
local Comunicator = Remotes.Comunicator.Set


-- modules --

local SvModules = SvSt.SBGModules

local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local NewKnockback = require(SvModules.BodymoverService)
local HitboxHandler = require(SvModules.HitboxHandler)
local DamageHandler = require(SvModules.DamageHandler)

local SoundsModule = require(SvModules.SoundsModule)
--local DestructionHandler = require(SvSt.Modules.DestructionHandler)
local PhasingTracker = require(SvModules.PhasingTracker)



-- module --

local Ragdoll = {}



-- variables --

local JointMotor6D = {
	["RootJoint"] = {
		C0 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		C1 = CFrame.new(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		CurrentAngle = 0
	},
	["Left Hip"] = {
		C0 = CFrame.new(-1, -1, 0) * CFrame.Angles(0, math.rad(-90), 0),
		C1 = CFrame.new(-0.5, 1, 0) * CFrame.Angles(0, math.rad(-90), 0),
		CurrentAngle = 0
	},
	["Left Shoulder"] = {
		C0 = CFrame.new(-1, 0.5, 0) * CFrame.Angles(0, math.rad(-90), 0),
		C1 = CFrame.new(0.5, 0.5, 0) * CFrame.Angles(0, math.rad(-90), 0),
		CurrentAngle = 0
	},
	["Neck"] = {
		C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		C1 = CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(90), math.rad(180), 0),
		CurrentAngle = 0
	},
	["Right Hip"] = {
		C0 = CFrame.new(1, -1, 0) * CFrame.Angles(0, math.rad(90), 0),
		C1 = CFrame.new(0.5, 1, 0) * CFrame.Angles(0, math.rad(90), 0),
		CurrentAngle = 0,
	},
	["Right Shoulder"] = {
		C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0),
		C1 = CFrame.new(-0.5, 0.5, 0) * CFrame.Angles(0, math.rad(90), 0),
		CurrentAngle = 0,
	}
}

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = {
	workspace.World.Map--:WaitForChild("Arena"), 
}


-- module functions --

function Ragdoll.cancelRagdoll(Humanoid: Humanoid, _, DoKnockback: boolean, MainPart: BasePart, isCancel: boolean, fullCancel: boolean, ignoreComunication: boolean)
	if not Humanoid or not Humanoid.Parent or not Humanoid.Parent:GetAttribute("Ragdolled") or not Humanoid.Parent:FindFirstChild('HumanoidRootPart') then return end
	
	local Character: Model = Humanoid.Parent
	local Player = Players:GetPlayerFromCharacter(Character)
	local HumRP: BasePart = Character.HumanoidRootPart
	local Animator: Animator = Humanoid.Animator

	Humanoid.EvaluateStateMachine = true
	
	if fullCancel == true then
		for _,v in Character:GetChildren() do
			if v.Name == "Ragdoll" then
				v:Destroy()
			end
		end
	end

	--if Character:FindFirstChild('Ragdoll') then return end
	
	-- New thing to destroy ragdoll if it was there. For some reason, this wasn't here.
	
	local ragdolledFolder = Character:FindFirstChild("Ragdolled")
	if ragdolledFolder then
		ragdolledFolder:Destroy()  -- fires Destroying → launchHandle:Stop()
	end

	Character:RemoveTag("Ragdolled")
	Character:SetAttribute("Ragdolled", nil)

	if isCancel == true then
		local ragdollCancel = Instance.new('BoolValue')
		ragdollCancel.Name = 'RagdollCancel'
		ragdollCancel.Parent = Character
		Debris:AddItem(ragdollCancel, 2)
	end

	HumRP.CanCollide = true
	HumRP.CollisionGroup = "Players"
	HumRP.Massless = false

	Humanoid.PlatformStand = false

	for _,v in ipairs(Character:GetDescendants()) do
		if v:IsA("Part") then
			v.CollisionGroup = "Players"
		end
	end

	for _,v in ipairs(Character.Torso:GetChildren()) do
		if v:IsA("Motor6D") then
			if v.Part0.Name ~= "Torso" and v.Part0.Name ~= "Head" then
				v.Part0.CanCollide = true
			end

			v.Part0 = Character.Torso
			v.Enabled = true
		end
	end

	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("Part") or v:IsA("BasePart") then
			if v.Name:find("Hitbox_") then
				v.CanCollide = false
				v.Massless = true
				continue
			end
			
			v.CollisionGroup = "Players"

			if v.Name ~= "HumanoidRootPart" and v.Name ~= "Torso" then
				v.Massless = false
			end
		end
	end

	for i, v in pairs(Character:GetDescendants()) do
		if v:IsA("Motor6D") then
			if JointMotor6D[v.Name] then
				v.C0 = JointMotor6D[v.Name].C0
				v.C1 = JointMotor6D[v.Name].C1

				if JointMotor6D[v.Name]["CurrentAngle"] then
					v.CurrentAngle = JointMotor6D[v.Name]["CurrentAngle"]
				end
			end
		end
	end

	if Character:FindFirstChild("Dummy") then
		for _, v in pairs(Character:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("Part") then
				pcall(function()
					v:SetNetworkOwner(nil)
				end)
			end
		end
	else
		if Player then
			for _, v in pairs(Character:GetDescendants()) do
				if v:IsA("BasePart") or v:IsA("Part") then
					pcall(function()
						v:SetNetworkOwner(Player)
					end)
				end
			end
		end
	end

	Humanoid.PlatformStand = false

	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, true)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)

	if Humanoid.Health > 0 then
		Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
		Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)

		if Player then
			if not ignoreComunication then
				Comunicator:FireClient(Player, "Ragdoll", { State = false })
			end
		end
	end

	StunHandler:RemoveAllStuns(Character)

	Character:SetAttribute("Ragdolled", false)
	Character:RemoveTag('CantRotate')

	Character:AddTag('StunImmunity')
	task.delay(.5, function()
		Character:RemoveTag('StunImmunity')
	end)


	Humanoid.AutoRotate = true
	Humanoid.WalkSpeed = 16
	Humanoid.JumpPower = 50

	local RagdollGetup = Instance.new("Folder")
	RagdollGetup.Name = "RagdollGetup"
	RagdollGetup.Parent = Character
	Debris:AddItem(RagdollGetup, .2)


	if DoKnockback == true and MainPart ~= nil then
		Character:AddTag("CantRotate")
		Character:AddTag("Knockbacked")

		local EnemyStun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		local lookVector = MainPart.CFrame.LookVector

		local knockbackAnim = Assets.Animations.Other.Knockback
		local knockbackTrack = AnimationService:getAnimationTrack(Character, knockbackAnim)

		HumRP.CFrame = CFrame.lookAlong(Vector3.new(HumRP.Position.X, MainPart.Position.Y, HumRP.Position.Z), -HumRP.CFrame.LookVector)

		local bv = Instance.new('BodyVelocity')
		bv.MaxForce = Vector3.new(100000, 0, 100000)
		bv.Velocity = lookVector * 140
		bv.Parent = HumRP
		game.TweenService:Create(bv, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { Velocity = Vector3.zero }):Play()
		game.Debris:AddItem(bv, 0.6)

		knockbackTrack.Stopped:Once(function()
			pcall(function()
				bv:Destroy()
			end)

			StunHandler:Unstun(Character, EnemyStun)
			Character:RemoveTag("CantRotate")
			Character:RemoveTag("Knockbacked")
		end)

		AnimationService:playAnimation(Character, knockbackAnim)
		--SoundsModule:PlaySound(Assets.Sounds.Other.KnockbackLand, HumRP)
	end
end

function Ragdoll.ragdoll(Humanoid: Humanoid, Duration, HardRagdoll, Ragdoller, _, _, checkAir: boolean, params)
	if not Humanoid.Parent or not Humanoid.Parent:FindFirstChild('HumanoidRootPart') then return end -- or Humanoid.BreakJointsOnDeath then return end
	Duration = Duration or -1
	params = params or {}
	if Duration ~= -1 and Duration < 0 then return end


	local Character: Model = Humanoid.Parent
	local Player = Players:GetPlayerFromCharacter(Character)
	local RagdollerPlayer = Players:GetPlayerFromCharacter(Ragdoller)
	if workspace.Configuration.NoRagdoll.Value == true or (Player and Player.Commands.NoRagdoll.Value == true) then return end
	local HumRP: BasePart = Character.HumanoidRootPart
	local WasRagdolled = Character:HasTag("Ragdolled")


	Character:AddTag('Ragdolled')
	Character:SetAttribute("Ragdolled", true)
	Character:SetAttribute('lastRagdoll', tick())

	local Ragdolled = Instance.new("Folder")
	Ragdolled.Name = "Ragdolled"
	Ragdolled.Parent = Character


	AnimationService:stopAll(Character)


	if not Player then
		if HumRP:CanSetNetworkOwnership() then
			HumRP:SetNetworkOwner(nil)
		end
	end
	
	--if Player then
	--	pcall(function()
	--		HumRP:SetNetworkOwner(nil)
	--		warn("Changed player's network owner to nil.")
	--	end)
	--end

	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("Part") or v:IsA("BasePart") then
			if v.Name:find("Hitbox_") then
				v.CanCollide = true
				v.Massless = true
				continue
			end
			
			v.CollisionGroup = "NoCol"

			if v.Name ~= "HumanoidRootPart" and v.Name ~= "Torso" then
				v.Massless = true
			end
		end
	end

	Humanoid.AutoRotate = false
	Humanoid.PlatformStand = true
	if not Player then
		-- NPCs only. The closest player's client simulates an airborne NPC, and its Humanoid can
		-- overwrite PlatformStand; with no state machine it can't "stand" against a wall mid-ragdoll.
		Humanoid.EvaluateStateMachine = false

		-- With no state machine the Humanoid can't enter Dead, so Died wouldn't fire until the
		-- ragdoll ends (or ever, for an endless one). Turn it back on the moment it dies.
		local deathGuard = Humanoid.HealthChanged:Connect(function(Health)
			if Health <= 0 then
				Humanoid.EvaluateStateMachine = true
			end
		end)
		Ragdolled.Destroying:Once(function()
			deathGuard:Disconnect()
		end)
	end
	HumRP.CollisionGroup = "Players"


	Character:AddTag('CantRotate')
	
	--Cosmetic ragdolls are just a limp-body visual for a grab/cutscene, so the victim must not be
	--able to evasive out of them. Every dash gate already checks CantRagdollCancel first.
	if params.Cosmetic then
		Character:AddTag('CantRagdollCancel')
		Ragdolled:SetAttribute("Cosmetic", true)

		Ragdolled.Destroying:Once(function()
			--ragdoll() doesn't clear an existing Ragdolled folder, so two can overlap.
			--Only the last cosmetic one out clears the tag.
			for _, other in Character:GetChildren() do
				if other ~= Ragdolled and other.Name == "Ragdolled" and other:GetAttribute("Cosmetic") then
					return
				end
			end

			Character:RemoveTag('CantRagdollCancel')
		end)
	end

	local Velocity = params.Velocity
	local MaxForce = params.MaxForce or Vector3.new(math.huge, math.huge, math.huge)
	local Time = params.Time or 0.1

	if not Player then
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
		
		--if Velocity then                          -- dummy: server owns + simulates
		--	for _, m in Character:GetDescendants() do
		--		if m:IsA("BodyVelocity") or m:IsA("LinearVelocity")
		--			or m:IsA("BodyPosition") or m:IsA("BodyGyro")
		--			or m:IsA("BodyAngularVelocity") or m:IsA("BodyForce")
		--			or m:IsA("BodyThrust") or m:IsA("AngularVelocity")
		--			or m:IsA("AlignPosition") or m:IsA("AlignOrientation")
		--			or m:IsA("VectorForce") then
		--			m:Destroy()
		--		end
		--	end

		--	--warn("Ragdoll velocity added")
		--	local bv = Instance.new("BodyVelocity")
		--	bv.MaxForce = MaxForce
		--	bv.Velocity = Velocity
		--	bv.Parent = HumRP
		--	Debris:AddItem(bv, Time)
		--end
	else
		--if Velocity then
		--	--pcall(function() HumRP:SetNetworkOwner(nil) end) -- server owns
			
		--	for _, m in Character:GetDescendants() do
		--		if m:IsA("BodyVelocity") or m:IsA("LinearVelocity")
		--			or m:IsA("BodyPosition") or m:IsA("BodyGyro")
		--			or m:IsA("BodyAngularVelocity") or m:IsA("BodyForce")
		--			or m:IsA("BodyThrust") or m:IsA("AngularVelocity")
		--			or m:IsA("AlignPosition") or m:IsA("AlignOrientation")
		--			or m:IsA("VectorForce") then
		--			m:Destroy()
		--		end
		--	end
			
		--	local bv = Instance.new("BodyVelocity")
		--	bv.MaxForce = MaxForce
		--	bv.Velocity = Velocity
		--	bv.Parent = HumRP
		--	Debris:AddItem(bv, Time)
		--end
		
		--if Velocity then
		--	--pcall(function()
		--	--	if HumRP:CanSetNetworkOwnership() then
		--	--		HumRP:SetNetworkOwner(nil)   -- server simulates
		--	--	end
		--	--end)
		--	warn("Applied server velocity to player")

		--	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
		--	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
		--	Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp, false)
		--	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, false)
		--	Humanoid:ChangeState(Enum.HumanoidStateType.Physics)

		--	for _, m in Character:GetDescendants() do
		--		if m:IsA("BodyVelocity") or m:IsA("LinearVelocity")
		--			or m:IsA("BodyPosition") or m:IsA("BodyGyro")
		--			or m:IsA("BodyAngularVelocity") or m:IsA("BodyForce")
		--			or m:IsA("BodyThrust") or m:IsA("AngularVelocity")
		--			or m:IsA("AlignPosition") or m:IsA("AlignOrientation")
		--			or m:IsA("VectorForce") then
		--			m:Destroy()
		--		end
		--	end

		--	local bv = Instance.new("BodyVelocity")
		--	bv.MaxForce = MaxForce
		--	bv.Velocity = Velocity
		--	bv.Parent = HumRP
		--	Debris:AddItem(bv, Time)
		--end


		Comunicator:FireClient(Player, "Ragdoll", { State = true})
	end

	for _,v in ipairs(Character.Torso:GetChildren()) do
		if v:IsA("Motor6D") and v.Part0 == Character.Torso then
			if v.Name == "Neck" then continue end
			if v.Name == "RootJoint" then continue end

			v.Enabled = false
		end
	end


	if Duration ~= -1 and Duration > 0 then
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0)

		Ragdolled.Destroying:Once(function()
			StunHandler:Unstun(Character, Stun)
		end)

		task.delay(Duration, function()
			Ragdolled:Destroy()
			if Character:FindFirstChild("Ragdolled") then return end

			Ragdoll.cancelRagdoll(Humanoid)
		end)
	else
		StunHandler:Stun(Character)
	end

	if HardRagdoll == true then
		local LoopTask = nil
		LoopTask = task.spawn(function()
			local PastTime = 0
			while true do
				if PastTime < 0.4 then PastTime += task.wait() continue end

				if Character and Character.Parent then
					local Velocity = HumRP.AssemblyLinearVelocity
					local HitRay = workspace:Raycast(HumRP.Position, Vector3.new(math.clamp(Velocity.X, -5.3, 5.3), math.clamp(Velocity.Y, -5.3, 5.3), math.clamp(Velocity.Z, -5.3, 5.3)), MapRayParams)
					if HitRay then
						local Position = HitRay.Position


						Replicate:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position + Vector3.new(0, 0.10000000149011612, 0, 0), ["end"] = Vector3.new(0, -24, 0, 0), amount = 6, size = 0.3 })
						Replicate:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position + Vector3.new(0, 0.10000000149011612, 0, 0), ["end"] = Vector3.new(0, -14, 0, 0), amount = 6, sizemult = 1.35, size = 2})
						Replicate:FireAllClients("Ground Crater", { Seed = math.random(1, 2000000000), start = HumRP.Position + Vector3.new(0, 0.10000000149011612, 0, 0), ["end"] = Vector3.new(0, -14, 0, 0), amount = 9, sizemult = 1.75, size = 3 })
						shared.fireTo(Replicate, { Player, RagdollerPlayer }, { "Camshake", { Intensity = 8, Last = 0.75 } })


						local Size, Offset = Vector3.new(20, 20, 20), CFrame.new(0, 0, 0)
						local VoxelParameters = { Velocity = HumRP.CFrame.UpVector, Multiplier = { 15, 50 }, Size = Size, CFrame = HumRP.CFrame * Offset }

						HitboxHandler:SimpleOnce(HumRP, Size, Offset, { Character, Ragdoller }, nil, nil, function(EnemyCharacter: Model)
							local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
							local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
							local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

							local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 12, nil, nil, false, false, false, true, false, nil, 13)
							NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })
							Ragdoll.ragdoll(EnemyHumanoid, 2)

						end, nil, VoxelParameters)

						break
					else
						task.wait()
					end
				else
					break
				end
			end

			LoopTask = nil
		end)

		task.delay(6, function()
			pcall(function()
				task.cancel(LoopTask)
			end)
			LoopTask = nil
		end)
	else
		if checkAir ~= false then
			StartAirDetection:Fire(Character, false, true)
		end
	end
	
	Character.HumanoidRootPart.CanCollide = true
	
	--if params.DestructionAttach then
	--	local phasingRef = PhasingTracker.acquire(Character, "Ragdoll")
	--	params.Phasing = false -- we don't want double phasing since it does it in attach function. Just a extra guard if its true by accident.
	--	local launchHandle = DestructionHandler.attach(HumRP, params)
	--	if params.LaunchKnockback then 
	--		NewKnockback:Knockback(Character, params.LaunchKnockback)
	--	end
	--	Ragdolled.Destroying:Once(function()
	--		if launchHandle then
	--			pcall(function() launchHandle:Stop() end)
	--		end
	--		PhasingTracker.release(phasingRef)
	--	end)
	--end


	return Ragdolled
end

return Ragdoll
