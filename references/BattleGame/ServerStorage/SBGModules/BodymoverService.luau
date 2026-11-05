local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")
--local ClientEffects = ReplicatedStorage.Remotes.ClientEffects
local ReplicateEffects_Set = ReplicatedStorage.Remotes.Replicate.Set


local BMS = {}

function BMS:Knockback(Character: Model?, Data): BodyVelocity
	if not Data.Velocity and not Data.Position then return end
	
	local Bodymover
	
	Data.MaxForce = Data.MaxForce or Vector3.new(math.huge, math.huge, math.huge)

	--ReplicatedStorage.Remotes.Replicate.Set:FireAllClients('RemoveAllBodyMovers', Character)
	for _, BodyMover: BodyVelocity in Character:GetDescendants() do
		--if BodyMover:IsA('BodyVelocity') or BodyMover:IsA('LinearVelocity') or BodyMover:IsA('BodyPosition') then
		if (BodyMover:IsA("BodyVelocity") or BodyMover:IsA("LinearVelocity") or BodyMover:IsA("BodyPosition") or BodyMover:IsA("BodyGyro") or BodyMover:IsA("BodyAngularVelocity") or BodyMover:IsA("BodyMover") or BodyMover:IsA("BodyForce") or BodyMover:IsA("BodyThrust") or BodyMover:IsA("AngularVelocity") or BodyMover:IsA("VelocityMotor")) then
			BodyMover:Destroy()
		end
	end

	if Data.KnockbackType == "Velocity" or not Data.KnockbackType then
		--print("Body velocity works")
		Bodymover = Instance.new("BodyVelocity")
		Bodymover.MaxForce = Data.MaxForce
		Bodymover.Velocity = Data.Velocity
		if Data.P then
			Bodymover.P = Data.P
		end
		if Data.D  then
			Bodymover.D = Data.D
		end
	elseif Data.KnockbackType == "Position" then
		Bodymover = Instance.new("BodyPosition")
		Bodymover.MaxForce = Data.MaxForce 
		Bodymover.Position = Data.Position
		if Data.P then
			Bodymover.P = Data.P
		end
		if Data.D  then
			Bodymover.D = Data.D
		end
	elseif Data.KnockbackType == "Linear" then
		Bodymover = Instance.new("LinearVelocity")
		Bodymover.ForceLimitMode = Enum.ForceLimitMode.PerAxis
		Bodymover.MaxAxesForce = Data.MaxForce
		Bodymover.VectorVelocity = Data.Velocity
		if Data.P then
			Bodymover.P = Data.P
		end
		if Data.D  then
			Bodymover.D = Data.D
		end
		Bodymover.Attachment0 = Character.HumanoidRootPart.RootAttachment
	elseif Data.KnockbackType == "VelocityTweenDown" then
		Bodymover = Instance.new("BodyVelocity")
		Bodymover.MaxForce = Data.MaxForce
		if Data.P then
			Bodymover.P = Data.P
		end
		if Data.D  then
			Bodymover.D = Data.D
		end

		if Data.Inverse == true then
			Bodymover.Velocity = Vector3.zero
			TS:Create(Bodymover, TweenInfo.new(Data.Time, Enum.EasingStyle[Data.Style or "Sine"], Enum.EasingDirection[Data.Direction or "Out"]), { Velocity = Data.Velocity }):Play()

		else
			Bodymover.Velocity = Data.Velocity
			TS:Create(Bodymover, TweenInfo.new(Data.Time, Enum.EasingStyle[Data.Style or "Sine"], Enum.EasingDirection[Data.Direction or "Out"]), { Velocity = Vector3.zero }):Play()

		end
	end

	if Character:FindFirstChild('Humanoid') then
		Bodymover.Parent = Character.HumanoidRootPart
	else
		Bodymover.Parent = Character
		
		-- Use to be if typeof(Data.Owner) == 'Player' then
		if typeof(Data.Owner) == "Instance" and Data.Owner:IsA("Player") then
			Character:SetNetworkOwner(Data.Owner)
			--pcall(function()
			--Character:SetNetworkOwner(nil)
			--end)
		end
	end


	--if Data.ApplyAngular then
	--	local BasePart: BasePart = Character:FindFirstChild("HumanoidRootPart") or Character
	--	if BasePart:IsA("BasePart") then
	--		BasePart.AssemblyAngularVelocity = Vector3.new(math.random(-270, 270), math.random(-270, 270), math.random(-270, 270))
	--	end
	--end
	
	if Data.ApplyAngular then
		local HumRP = Character:FindFirstChild("HumanoidRootPart")
		local rootAttachment = HumRP and HumRP:FindFirstChild("RootAttachment")
		if not rootAttachment then return end

		local spinSign = (math.random(0, 1) == 0) and 1 or -1
		local spinVec = Data.SpinVec or Vector3.new(spinSign * 1, spinSign * 1, spinSign*60)
		local spinTime = Data.SpinTime or 1

		local EnemyPlayer = Players:GetPlayerFromCharacter(Character)
		if EnemyPlayer then
			ReplicateEffects_Set:FireClient(EnemyPlayer, "ApplySpin", { SpinVec = spinVec })
		else
			task.defer(function()
				if not HumRP.Parent then return end

				local av = Instance.new("AngularVelocity")
				av.Attachment0 = rootAttachment
				av.AngularVelocity = spinVec
				av.MaxTorque = 200
				av.RelativeTo = Enum.ActuatorRelativeTo.World
				av.Parent = HumRP
				Debris:AddItem(av, spinTime)
			end)
		end
	end
	
	
	if Data.Time then
		Debris:AddItem(Bodymover, Data.Time)
	else
		Debris:AddItem(Bodymover, .1)
	end

	return Bodymover
end

function BMS:KnockbackTrash(Character, Data)
	if not Data.Velocity and not Data.Position then return end
	if not Character or not Character.Parent then return end

	local HumRP = Character:FindFirstChild("HumanoidRootPart") or Character
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	-- Clean slate
	for _, m in Character:GetDescendants() do
		if m:IsA("BodyMover") or m:IsA("LinearVelocity") or m:IsA("VectorForce")
			or m:IsA("AngularVelocity") or m:IsA("AlignPosition") or m:IsA("AlignOrientation") then
			m:Destroy()
		end
	end
	if HumRP:IsA("BasePart") then
		HumRP.AssemblyLinearVelocity = Vector3.zero
		HumRP.AssemblyAngularVelocity = Vector3.zero
	end

	-- Take ownership + suspend Humanoid for the duration
	local restorePlatform = false
	if Humanoid then
		if HumRP:IsA("BasePart") then
			pcall(function() HumRP:SetNetworkOwner(nil) end)
		end
		if not Humanoid.PlatformStand then
			Humanoid.PlatformStand = true
			restorePlatform = true
		end
	end

	-- ...create the BodyMover as you do now, but prefer LinearVelocity...
	local mover = Instance.new("LinearVelocity")
	mover.Attachment0 = HumRP.RootAttachment
	mover.RelativeTo = Enum.ActuatorRelativeTo.World
	mover.ForceLimitMode = Enum.ForceLimitMode.PerAxis
	mover.MaxAxesForce = Data.MaxForce or Vector3.one * 1e6
	mover.VectorVelocity = Data.Velocity
	mover.Parent = HumRP

	local duration = Data.Time or 0.3
	task.delay(duration, function()
		if mover.Parent then mover:Destroy() end
		if Humanoid and Humanoid.Parent then
			if restorePlatform then Humanoid.PlatformStand = false end
			if HumRP:IsA("BasePart") then
				pcall(function() HumRP:SetNetworkOwnershipAuto() end)
			end
		end
	end)

	return mover
end

function BMS:makeEnemyFaceCharacter(Enemy, Character, to)
	if to == true then
		Enemy.HumanoidRootPart.CFrame = CFrame.lookAt(Enemy.HumanoidRootPart.Position, Character.HumanoidRootPart.Position)
	else
		Enemy.HumanoidRootPart.CFrame = CFrame.lookAlong(Enemy.HumanoidRootPart.Position, Character.HumanoidRootPart.CFrame.LookVector) * CFrame.Angles(0, math.pi, 0)
	end
end

return BMS