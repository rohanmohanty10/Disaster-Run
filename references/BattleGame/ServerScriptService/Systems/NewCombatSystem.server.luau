--Services
local TS = game:GetService("TweenService")
local RS = game:GetService("ReplicatedStorage")
local SvSt = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local ServerScriptService = game:GetService("ServerScriptService")
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")

--Remotes
local Remotes = RS.Remotes
local CombatRemotes = Remotes.Combat.Attack
local ReplicateRemotes = Remotes.Replicate
local ReplicateSet = ReplicateRemotes.Set

--Server Modules
local SvModules = SvSt.SBGModules
local DamageHandler = require(SvModules.DamageHandler)
local HitboxHandler = require(SvModules.HitboxHandler)
local RagdollHandler = require(SvModules.RagdollHandler)
local StunHandler = require(SvModules.StunHandler)
local AnimationService = require(SvModules.AnimationService)
local NewKnockback = require(SvModules.BodymoverService)
local iFramesService = require(SvModules.iFramesService)
local StatesHandler = require(SvModules.StatesHandler)
local ReplicatedHitboxes = require(SvModules.ReplicatedHitboxes)
local SoundsModule = require(SvModules.SoundsModule)
local ItemService = require(SvModules.ItemService)
local DebreeService = require(SvModules.DebreeService)

-- Arena (1v1 / 2v2): nil in Demon Fruits, so nothing below changes there.
local ArenaMatch = if require(RS:WaitForChild("Ranked"):WaitForChild("PlaceRole")).IsArena()
	then require(ServerScriptService:WaitForChild("Arena"):WaitForChild("ArenaMatch"))
	else nil

--Replicated Modules
local InfoModule = require(RS.Info)
local Trove = require(RS.Modules.Trove)
local DataManager = require(ServerScriptService.Data.DataManager)
local Velocity = require(RS.Modules.Velocity)
local SoundHandler = require(RS.Modules.SoundHandler)

--Assets
local Assets = SvSt.Assets
local Animations = Assets.Animations
local EmotesFolder = RS.Assets.Animations.Emotes
local Sounds = RS.Assets.Sounds

-- Requiring the character modules
local characterModule = ServerScriptService.Systems.Characters
local cachedCharacters = {} --We will cached the different characters here.
for _, module in characterModule:GetChildren() do --Getting children of Characters in SSS.
	if module:IsA("ModuleScript") then
		cachedCharacters[module.Name] = require(module)
	end
end

--Variables
local LastPunch = {}
local MaxCombo = 4
local M1Damage = require(game:GetService("ServerScriptService").CharacterConfig).M1Damage


local M1HitColors = {
	Sanji     = Color3.fromRGB(255, 200, 60),
	Zoro      = Color3.fromRGB(129, 208, 220),
	Luffy     = Color3.fromRGB(255, 255, 255),
	WhiteBeard= Color3.fromRGB(231, 247, 255),
	BlackBeard= Color3.fromRGB(38, 16, 57),
	Crocodile = Color3.fromRGB(210, 180, 120),
}
local DEFAULT_M1_COLOR = Color3.fromRGB(255, 255, 255)

--Functions
function ChangeCombo(Char: Model)
	if not Char:GetAttribute("Combo") then --For new players who have joined.
		Char:SetAttribute("Combo", 0)
	end

	if Char:GetAttribute("TrueComboCount") then
		Char:SetAttribute("Combo", Char:GetAttribute("TrueComboCount"))
		Char:SetAttribute("TrueComboCount", nil)
	else
		if LastPunch[Char] then
			if (time() - LastPunch[Char]) >= 1.5 then --Resets the combo if the last m1 was greater than 1.5 seconds.
				Char:SetAttribute("Combo", 1)
			else
				if Char:GetAttribute("Combo") >= MaxCombo then
					Char:SetAttribute("Combo", 1)
				else
					Char:SetAttribute("Combo", Char:GetAttribute("Combo") + 1)
				end
			end
		else --If we haven't created a punch timestamp then create one.
			Char:SetAttribute("Combo", Char:GetAttribute("Combo") + 1)
		end
	end

	LastPunch[Char] = time()

	return Char:GetAttribute("Combo")
end

function GetPunchAnim(Char: Model, Uppercut, Downslam)
	local CurrentCombo = Char:GetAttribute("Combo")
	local Player = Players:GetPlayerFromCharacter(Char)
	local Character = Player:GetAttribute("Character")

	local PunchesFolder = SvSt.Assets.Animations[Character].M1s
	local Player = Players:GetPlayerFromCharacter(Char)
	--if Player and CombatAnims.Punches:FindFirstChild(Player:GetAttribute("Moveset")) then
	--	PunchesFolder = CombatAnims.Punches[Player:GetAttribute("Moveset")]
	--end

	local Hum: Humanoid = Char.Humanoid
	local Animator: Animator = Hum.Animator
	local Animation = nil

	-- We will re add this once we have more than 1 punch anim
	if CurrentCombo < MaxCombo then
		Animation = PunchesFolder[tostring(CurrentCombo)]
	else
		if not Uppercut and not Downslam then
			Animation = PunchesFolder[tostring(MaxCombo)]
		else
			if Downslam then
				--Animation = CombatAnims.Punches.Downslam
				Animation = PunchesFolder.Downslam
				--Animation = PunchesFolder.Parent.tbsDownslam
			else
				if Uppercut then
					if Char:HasTag("HasSword") then
						--Animation = CombatAnims.Punches.SwordUppercut
					else
						--Animation = CombatAnims.Punches.Uppercut
						Animation = PunchesFolder.Uppercut
						--Animation = PunchesFolder.Parent.tbsUppercut
					end
				end
			end
		end
	end
	--print(Animation)
	--print(PunchesFolder[tostring(CurrentCombo - 1 > 0 and CurrentCombo - 1 or 4)])
	return Animation, PunchesFolder[tostring(CurrentCombo - 1 > 0 and CurrentCombo - 1 or 4)]
end

-- === Throwable helpers: support single BaseParts AND Models with a PrimaryPart ===
local function throwRoot(obj: Instance): BasePart?
	return (obj:IsA("Model") and obj.PrimaryPart) or (obj:IsA("BasePart") and obj) or nil
end

local function throwParts(obj: Instance): { BasePart }
	if obj:IsA("Model") then
		local parts = {}
		for _, d in obj:GetDescendants() do
			if d:IsA("BasePart") then table.insert(parts, d) end
		end
		return parts
	elseif obj:IsA("BasePart") then
		return { obj }
	end
	return {}
end

local function throwSize(obj: Instance): Vector3
	return obj:IsA("Model") and obj:GetExtentsSize() or obj.Size
end


local function M1(Player: Player)
	local Character = Player.Character
	if not Character or Character:GetAttribute("doPunch") ~= true or Character:GetAttribute("ThrowingPart") == true then
		return
	end
	
	if Character:GetAttribute("HeldItem") then
		return -- holding an item: M1 uses the item instead (ItemService)
	end
	if ItemService.TryGrab(Character) then
		return -- picked up an item standing in front of you (cola bomb), like a barrel
	end
	
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
	if not HumRP then
		return
	end
	local Humanoid: Humanoid = Character.Humanoid

	--start of barrel throw logic
	if Character:FindFirstChild("ThrowablePart") and Character.ThrowablePart:FindFirstChild("Weld") then
		if Character:GetAttribute("GrabbingThrowable") then return end

		local ThrowableObject = Character.ThrowablePart          -- part OR model
		local ThrowableRoot = throwRoot(ThrowableObject)         -- BasePart used for physics
		local ThrowableWeld: Weld = ThrowableObject.Weld
		if not ThrowableRoot then return end

		ThrowableObject:SetAttribute("BeingThrowed", true)
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local ThrowAnim = AnimationService:getAnimationTrack(Character, Animations.Throwables.Throw)
		local ThrowAnimEvents = {}
		local didThrow = false

		ThrowAnimEvents["throw"] = ThrowAnim:GetMarkerReachedSignal("throw"):Once(function()
			didThrow = true

			if ThrowableWeld then
				ThrowableWeld:Destroy()
				ThrowableWeld = nil
			end

			for _, p in throwParts(ThrowableObject) do p.CanCollide = true end
			ThrowableObject:SetAttribute("BeingThrowed", nil)
			ThrowableRoot:SetNetworkOwner(Player)
			ReplicateSet:FireAllClients("trashcanFloorHit", { ThrowableObject, Player })

			local Hitbox = ReplicatedHitboxes.new(Player)
			Hitbox.Instance = ThrowableRoot
			Hitbox.Size = throwSize(ThrowableObject) * 2.25
			Hitbox.Ignore = { Character }
			Hitbox.onTouch = function(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart

				if ThrowableRoot.AssemblyLinearVelocity.Magnitude <= 10 or EnemyHumanoid.Health <= 0 or EnemyCharacter:HasTag('Ragdolled') or iFramesService:HasiFrame(EnemyCharacter, 'Throwables') then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 16, nil, nil, false, true, false, true)
				if HitInfo.Countered == true then return end

				RagdollHandler.ragdoll(EnemyHumanoid, 2, false)
				NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 0, 100000), Velocity = ThrowableRoot.AssemblyLinearVelocity.Unit * 50 })
				SoundsModule:PlaySound(Sounds.Other.TrashDmg, EnemyHumRP)
			end

			Hitbox:Start(5, true)
			
			-- carve through destructibles while it's flying
			local CARVE_GROUP = "Phasing"  -- must still collide with the map floor (see below)
			local ARM_SPEED = 25           -- must exceed this once before the stop check arms
			local STOP_SPEED = 10          -- matches the hitbox's velocity guard

			-- snapshot the real groups so we restore exactly what each part had
			local originalGroups = {}
			for _, p in throwParts(ThrowableObject) do
				originalGroups[p] = p.CollisionGroup
				p.CollisionGroup = CARVE_GROUP
			end

			--local destroyHandle = DestructionHandler.attach(ThrowableRoot, {
			--	Size = throwSize(ThrowableObject) * 2,
			--	Shape = Enum.PartType.Ball,
			--	MaxDuration = 5,
			--	ExtrapolateWithPing = true,
			--	lookaheadTime = .3,
			--	Player = Player,
			--	MinimumSize = 4,
			--	TimeToReset = 20,
			--	VoxelDestroyChance = 0,
			--	FlingDestroyChance = 1,
			--	--SkipCustomizations = true,
			--	IgnoreFloor = true,
				
			--	VoxelVelocity = HumRP.CFrame.LookVector * 40
			--})

			local carveEnded, armed = false, false
			local watchConn

			local function endCarve()
				if carveEnded then return end
				carveEnded = true

				if watchConn then
					watchConn:Disconnect()
					watchConn = nil
				end
				--if destroyHandle then
				--	destroyHandle:Stop()
				--end
				for p, group in originalGroups do
					if p.Parent then
						p.CollisionGroup = group
					end
				end
			end

			watchConn = RunService.Heartbeat:Connect(function()
				if not ThrowableRoot.Parent then
					endCarve()
					return
				end

				local speed = ThrowableRoot.AssemblyLinearVelocity.Magnitude
				-- don't trip before the client's throw impulse replicates back
				if not armed then
					if speed >= ARM_SPEED then armed = true end
					return
				end
				if speed <= STOP_SPEED then
					endCarve()
				end
			end)

			ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 3 })
				
		end)	

		ThrowAnim.Stopped:Once(function()
			for _,v in ThrowAnimEvents do v:Disconnect() end
			StunHandler:Unstun(Character, Stun)
			ThrowableObject:SetAttribute("BeingThrowed", nil)
			Character:SetAttribute("ThrowingPart", nil)

			if not didThrow then
				for _, p in throwParts(ThrowableObject) do p.CanCollide = true end
				Debris:AddItem(ThrowableObject, 5)
			end

			if ThrowableWeld then
				ThrowableWeld:Destroy()
				ThrowableWeld = nil
			end

			ThrowableObject.Parent = workspace.Thrown
		end)

		Character:SetAttribute("ThrowingPart", true)
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, Animations.Throwables.Throw)

		if ThrowableWeld then
			TS:Create(ThrowableWeld, TweenInfo.new(0.533, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 2, 2) * CFrame.Angles(math.rad(140), 0, 0) }):Play()
			task.delay(0.533, function()
				if ThrowableWeld then
					TS:Create(ThrowableWeld, TweenInfo.new(0.1, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 3.25, -1.25) * CFrame.Angles(math.rad(70), 0, 0) }):Play()
				end
			end)
		end

	else
		local canGrab = not Character:HasTag("CantThrowable")

		local liveOverlapParams = OverlapParams.new()
		liveOverlapParams.FilterType = Enum.RaycastFilterType.Include
		liveOverlapParams.FilterDescendantsInstances = { workspace.World.Live }

		local hitPartsCheck = workspace:GetPartBoundsInBox(HumRP.CFrame * CFrame.new(0, 0, -3.5), Vector3.new(1, 1, 1) * 7, liveOverlapParams)
		if #hitPartsCheck > 0 then
			for _, Part: Part in hitPartsCheck do
				if Part and Part.Parent and Part.Parent:FindFirstChild("Humanoid") then
					local EnemyCharacter: Model = Part.Parent
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					if EnemyCharacter == Character or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead or EnemyCharacter:HasTag("Ragdolled") or iFramesService:HasiFrame(EnemyCharacter, 'M1') then
						continue
					end
					canGrab = false
					break
				end
			end
		end

		if canGrab then
			local hitparts = workspace:GetPartBoundsInBox(HumRP.CFrame * CFrame.new(0, 0, -3.5), Vector3.new(1, 1, 1) * 7)
			if #hitparts > 0 then
				for _, Part: Part in hitparts do
					if not (Part and Part.Parent and Part:IsDescendantOf(workspace)) then continue end

					-- resolve the tagged throwable: the part itself, or an ancestor model
					local Source
					if Part:HasTag("Throwable") then
						Source = Part
					else
						local m = Part:FindFirstAncestorWhichIsA("Model")
						while m do
							if m:HasTag("Throwable") then Source = m break end
							m = m:FindFirstAncestorWhichIsA("Model")
						end
					end
					if not Source then continue end

					local ThrowableObject = Source:Clone()
					ThrowableObject.Name = "ThrowablePart"
					ThrowableObject:RemoveTag("Throwable")

					local ThrowableRoot = throwRoot(ThrowableObject)
					if not ThrowableRoot then
						warn("Throwable model has no PrimaryPart:", Source.Name)
						ThrowableObject:Destroy()
						return
					end

					for _, p in throwParts(ThrowableObject) do
						p.CanCollide = false
						p.CanQuery = false
					end

					local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
					local ThrowableWeld

					ThrowableObject.Parent = Character

					local PickupAnim = AnimationService:getAnimationTrack(Character, Animations.Throwables.Pickup)
					local PickupAnimEvents = {}

					PickupAnimEvents["grab"] = PickupAnim:GetMarkerReachedSignal("grab"):Once(function()
						for _, p in throwParts(ThrowableObject) do
							p.Anchored = false
							p.Massless = true
						end

						ThrowableWeld = Instance.new("Weld")
						ThrowableWeld.Part0 = HumRP
						ThrowableWeld.Part1 = ThrowableRoot
						ThrowableWeld.Name = "Weld"
						ThrowableWeld.C0 = CFrame.new(0, -1, -3) * CFrame.Angles(math.rad(-30), 0, 0)
						ThrowableWeld.C1 = CFrame.new(0, 0.5, 0)
						ThrowableWeld.Parent = ThrowableObject

						SoundsModule:PlaySound(Sounds.Other.TrashGrab, ThrowableRoot)
					end)

					PickupAnimEvents["lift"] = PickupAnim:GetMarkerReachedSignal("lift"):Once(function()
						if ThrowableWeld then
							TS:Create(ThrowableWeld, TweenInfo.new(0.217/2, Enum.EasingStyle.Linear), { C0 = CFrame.new(0, 3.5, 0) * CFrame.Angles(math.rad(90), 0, 0), C1 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0) }):Play()
						end
					end)

					PickupAnim.Stopped:Once(function()
						task.delay(0.5, function()
							Character:SetAttribute("GrabbingThrowable", nil)
						end)
						for _,v in PickupAnimEvents do v:Disconnect() end
						StunHandler:Unstun(Character, Stun)

						if Character:HasTag("Stunned") then
							for _, p in throwParts(ThrowableObject) do p.CanCollide = true end
							Debris:AddItem(ThrowableObject, 5)
							if ThrowableWeld then ThrowableWeld:Destroy() end
							return
						end

						Stun = StunHandler:Stun(Character, nil, true, 16, 0, true, true)

						local IdleAnimation = Animations.Throwables.Idle
						local IdleTrack = AnimationService:getAnimationTrack(Character, IdleAnimation)

						IdleTrack.Stopped:Once(function()
							Stun:SetAttribute("WalkSpeed", 0)
							StunHandler:Unstun(Character, Stun)
							if Character:GetAttribute("ThrowingPart") == true then return end
							if ThrowableWeld then ThrowableWeld:Destroy() end
							for _, p in throwParts(ThrowableObject) do p.CanCollide = true end
							Debris:AddItem(ThrowableObject, 5)
						end)

						AnimationService:playAnimation(Character, IdleAnimation)
					end)

					AnimationService:stopAll(Character)
					AnimationService:playAnimation(Character, Animations.Throwables.Pickup, 2)

					Character:SetAttribute("GrabbingThrowable", true)

					-- hide the original for 30s so it can't be re-grabbed instantly
					for _, p in throwParts(Source) do
						p.Transparency = 1
						p.CanCollide = false
						p.CanQuery = false
					end
					Source:RemoveTag("Throwable")

					task.delay(30, function()
						for _, p in throwParts(Source) do
							p.Transparency = 0
							p.CanCollide = true
							p.CanQuery = true
						end
						Source:AddTag("Throwable")
					end)

					return
				end
			end
		end
	end
	--end of trashcan logic

	--if (Character:GetAttribute("NoAttack") or Character:HasTag('CantPunch') or Character:HasTag('Stunned') or Character:HasTag("Ragdolled") or Character:FindFirstChild("Stunned")) and not (Character:HasTag("PunchCDS")) then -- and Character:HasTag('ThrowableGrabbed')) then
	--if (Character:GetAttribute("NoAttack") or Character:HasTag('CantPunch') or Character:HasTag('Stunned') or Character:HasTag("Ragdolled") or Character:FindFirstChild("Stunned") or Character:HasTag("PunchCDS") or Character:GetAttribute("Dashing")) then -- and Character:HasTag('ThrowableGrabbed')) then
	if
		(
			Character:GetAttribute("NoAttack")
				or Character:HasTag("CantPunch")
				or Character:HasTag("Stunned")
				or Character:HasTag("Ragdolled")
		) and not (Character:HasTag("PunchCDS") and Character:HasTag("ThrowableGrabbed"))
	then
		task.spawn(function()
			task.wait(0.1)
			warn("recursive call")
			M1(Player)
		end)

		return
	elseif Character:HasTag("PunchCDS") or Character:HasTag("ThrowableGrabbed") then
		return
	end

	--When everything passes, then we stop animations for everything.
	for _, Anim in RS.Assets.Animations.Emotes:GetDescendants() do
		if Anim:IsA("Animation") then
			AnimationService:stopAnimation(Character, Anim)
		end
	end

	Character:AddTag("Punching")
	Character:AddTag("PunchCDS")

	local PerfectBlock = Character:HasTag("PerfectBlock") --Period for increased damage. Like flowstate in jjk. So PerfectBlock will be tree. And then it will be removed.
	Character:RemoveTag("PerfectBlock")
	local Hit = false
	local VelVector: Vector3, KnockData: { any }
	local CurrentCombo = ChangeCombo(Character)
	local CurrentType

	Character:SetAttribute("DefaultJumpPower", 0)
	Humanoid.JumpPower = 0

	local Params = {}
	Params.Downslam = Character:GetAttribute("IsInAir") --A boolean which is true if the player is currently in freefall
	if Character:GetAttribute("IsJumping") then
		Params.Uppercut = Character:GetAttribute("IsJumping")
		print("Holding Space?", Params.Uppercut)
	else
		Params.Uppercut = Humanoid.Jump
	end

	Character:SetAttribute("DefaultRunSpeed", 16)
	Character:SetAttribute("DefaultWalkSpeed", 16)

	Humanoid.WalkSpeed = 16

	local MovesetName = Player:GetAttribute("Moveset") or Player:GetAttribute("Character")

	local VoxelParameters = nil
	local Size, Offset = Vector3.new(7, 7, 7), CFrame.new(0, 0, -3.5)

	if CurrentCombo >= MaxCombo then --So if current combo is basically 4 then we do the knockback varients.
		if Params.Downslam then
			CurrentType = "Downslam"
			Size, Offset = Vector3.new(7, 14, 7), CFrame.new(0, -7, -3.5)
			VoxelParameters = {
				Velocity = HumRP.CFrame.UpVector,
				Multiplier = { 15, 50 },
				Size = Size,
				CFrame = HumRP.CFrame * Offset,
			}
		elseif Params.Uppercut then
			CurrentType = "Uppercut"
			Size, Offset = Vector3.new(7, 14, 7), CFrame.new(0, -7, -3.5)
			VoxelParameters = {
				Velocity = HumRP.CFrame.UpVector,
				Multiplier = { 15, 50 },
				Size = Size,
				CFrame = HumRP.CFrame * Offset,
			}
		else
			CurrentType = tostring(CurrentCombo)
			VoxelParameters = {
				Velocity = HumRP.CFrame.LookVector,
				Multiplier = { 15, 50 },
				Size = Size,
				CFrame = HumRP.CFrame * Offset,
			}
		end
	else --Else we do the m1 strings which don't knockback
		CurrentType = tostring(CurrentCombo)
	end

	Character:SetAttribute("LastM1Type", CurrentType)
	Character:SetAttribute("LastM1Time", tick())
	Character:SetAttribute("LastM1Position", HumRP.Position)

	local PunchAnim: Animation, PreviousAnimation: Animation = GetPunchAnim(Character, Params.Uppercut, Params.Downslam)

	local PunchAnimTrack: AnimationTrack, PunchEvents: RBXScriptConnection =
		AnimationService:getAnimationTrack(Character, PunchAnim)

	table.insert(PunchEvents, PunchAnimTrack:GetMarkerReachedSignal("swing"):Once(function() end))

	local HitCount = 0
	table.insert(
		PunchEvents,
		PunchAnimTrack:GetMarkerReachedSignal("hit"):Connect(function()
			--if (Character:GetAttribute("NoAttack") or Character:HasTag('CantPunch') or Character:HasTag('Stunned') or Character:HasTag("Ragdolled")) then return end
			HitCount += 1

			--Object, Size, Offset, Ignore, Method, HitType, onTouch, DestroyParams, Voxels. On touch is the huge method
			local hitClock = os.clock()
			HitboxHandler:SimpleOnce(HumRP, Size, Offset, { Character }, nil, nil, function(EnemyCharacter: Model)
				--print(("%s reached at +%.1f ms"):format(EnemyCharacter.Name, (os.clock()-hitClock)*1000))
				--local tDmg = os.clock()
				local EnemyPlayer = Players:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyAnimator: Animator = EnemyHumanoid.Animator

				--if EnemyCharacter == Character or (CurrentType ~= 'Downslam' and (EnemyHumanoid.Health <= 0 or EnemyCharacter:HasTag('Ragdolled'))) or iFramesService:HasiFrame(EnemyCharacter, 'M1') then warn("Couldn't hit player") return end
				if EnemyCharacter == Character or iFramesService:HasiFrame(EnemyCharacter, "M1") then
					return warn("Iframes")
				end
				if EnemyCharacter:FindFirstChild("RagdollGetup") then
					return warn("enemy getting up")
				end

				local HitsFolder
				if Sounds.Characters[MovesetName].Hits then
					HitsFolder = Sounds.Characters[MovesetName].Hits
				else
					HitsFolder = Sounds.Characters["Sanji"].Hits
				end

				local isDownslam = CurrentType == "Downslam"
				local isFinalHit = CurrentCombo >= MaxCombo
				local isDeadOrRagdolled = EnemyHumanoid.Health <= 0
					or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
					or EnemyCharacter:HasTag("Ragdolled")

				if isDeadOrRagdolled and not isDownslam then
					-- corpse: only the finisher M1 may touch it, and ONLY to knock it back (no damage, no kill credit)
					if not isFinalHit then
						return warn("Not final Hit")
					end

					Character:SetAttribute("LastM1Hit", EnemyCharacter.Name)

					local VelocityObject = Velocity.new(EnemyCharacter)
					VelocityObject.Settings.RemoveTime = 0.2
					VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000)
					VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 40 -- + Vector3.yAxis * 5
					VelocityObject:Fire()

					-- optional: hit sound so it still feels like a connect
					-- SoundHandler:AddSound(HitsFolder[tostring(CurrentCombo)], HumRP)
					SoundHandler:AddSound(HitsFolder[tostring(CurrentCombo)], HumRP)
					return
				end

				local Blockable = true
				if CurrentType == "Downslam" then
					Blockable = false
				end

				local Dmg = M1Damage[CurrentCombo] or 4
				if PerfectBlock == true then
					Dmg *= 2
				end

				local HitInfo = DamageHandler:TakeDamage(
					Character,
					EnemyHumanoid,
					Dmg,
					1,
					SvSt.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
					Blockable,
					true,
					false,
					true,
					true,
					"M1"
				)
				if HitInfo.Countered == true then
					return
				end
				--print(("  %s: TakeDamage %.1f ms | owner=%s"):format(
				--	EnemyCharacter.Name, (os.clock()-tDmg)*1000, tostring(EnemyHumRP:GetNetworkOwner())))

				if HitInfo.Blocked == true then
					local SFX: Sound
					if EnemyCharacter:HasTag("PerfectBlock") == true then
						--SoundsModule:PlaySound(CombatSounds.Hits.PerfectBlocked, EnemyHumRP)
					else
						SoundsModule:PlaySound(
							Sounds.Blocking.Hits:GetChildren()[math.random(1, #Sounds.Blocking.Hits:GetChildren())],
							EnemyHumRP
						)
					end
				else
					Hit = true

					Character:SetAttribute("LastM1Hit", EnemyCharacter.Name)

					--local HitsFolder = CombatSounds.Hits:FindFirstChild(Player:GetAttribute("Moveset")) or Sounds["Martial Artist"].Hits

					--if Sounds.Characters[MovesetName].Hits then
					--	HitsFolder = Sounds.Characters[MovesetName].Hits
					--else
					--	HitsFolder = Sounds.Characters["Sanji"].Hits
					--end

					if CurrentType == "Uppercut" then
						SoundHandler:AddSound(Sounds.Characters["Sanji"].Uppercut, HumRP)
						SoundHandler:AddSound(Sounds.Characters["Sanji"].uppercut_hit, HumRP)
					elseif CurrentType == "Downslam" then
						SoundHandler:AddSound(Sounds.Characters["Sanji"].Downslam, HumRP)
					else
						SoundHandler:AddSound(HitsFolder[tostring(CurrentCombo)], HumRP)
					end
					--hiteffects
					ReplicateSet:FireAllClients("M1HitHighlight", {
						EChar = EnemyCharacter,
						Color = M1HitColors[MovesetName] or DEFAULT_M1_COLOR,
					})
					
					if MovesetName == "Zoro" then
						ReplicateSet:FireAllClients("SwordEffect", { MainPart = EnemyHumRP })
						--hiteffects
						
					end

					if PerfectBlock == true then
						ReplicateSet:FireAllClients("PerfectHit", { MainPart = EnemyHumRP })

						--SoundsModule:PlaySound(CombatSounds.Hits.PerfectHit, EnemyHumRP)
					end

					if MovesetName == "Sanji" and Character:GetAttribute("Awakened") == true then
						Remotes.ClientEffects:FireAllClients(
							"SanjiMode",
							{ Attacker = Character, SkillType = "HitEffect", Target = EnemyCharacter }
						)
					end

					if CurrentCombo >= MaxCombo then -- The last m1
						local FirstProps = { Size = Vector3.new(0.6, 0.6, 0.6), Transparency = 0 }
						local FinalProps = { Size = Vector3.new(12, 0.6, 12), Transparency = 1 }
						local TN_Info = { Time = 0.25, Style = "Quad", Direction = "Out" }
						local checkAir = true
						local AddRagdoll = true

						if CurrentType == "Downslam" then
							checkAir = false
							ReplicateSet:FireAllClients(
								"Ring",
								{
									FirstProps = FirstProps,
									CF = EnemyHumRP.CFrame,
									TN_Info = TN_Info,
									FinalProps = FinalProps,
								}
							)
							ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 2 })

							local MovesetName = Player:GetAttribute("Moveset")

							ReplicateSet:FireAllClients(
								"Ground Crater",
								{
									Seed = math.random(1, 2000000000),
									start = EnemyHumRP,
									["end"] = Vector3.new(0, -17, 0),
									Crater2 = false,
									nosound = true,
								}
							)
							--ReplicateSet:FireAllClients('Ground Crater',{ Seed = math.random(1, 2000000000), start = EnemyHumRP, ["end"] = Vector3.new(0, -17, 0), Crater2 = false})

							EnemyHumRP.CFrame *= CFrame.Angles(math.pi / 2, 0, 0)
						elseif CurrentType == "Uppercut" then
							ReplicateSet:FireAllClients(
								"Ring",
								{
									FirstProps = FirstProps,
									CF = EnemyHumRP.CFrame,
									TN_Info = TN_Info,
									FinalProps = FinalProps,
								}
							)
							ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 3 })

							--local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
							--BodyAngularVelocity.MaxTorque = Vector3.new(50000, 50000, 50000)
							--BodyAngularVelocity.AngularVelocity =
							--	Vector3.new(math.random(2.5, 5), math.random(2.5, 5), math.random(2.5, 5))
							--BodyAngularVelocity.Parent = EnemyHumRP
							--Debris:AddItem(BodyAngularVelocity, 0.1)

							local VelocityObject = Velocity.new(EnemyCharacter)
							VelocityObject.Settings.RemoveTime = 0.1
							VelocityObject.Settings.Velocity = Vector3.yAxis * 57.5
							VelocityObject.Settings.Spin = Vector3.new(
								(math.random() - 0.5) * 2,
								(math.random() - 0.5) * 2,
								(math.random() - 0.5) * 2
							).Unit * 8
							VelocityObject:Fire()
						else
							local VelocityObject = Velocity.new(EnemyCharacter)
							VelocityObject.Settings.RemoveTime = 0.2
							VelocityObject.Settings.MaxForce = Vector3.new(10000, 10000, 10000) --Force
							VelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 40 + Vector3.yAxis * 8.5 --KnockbackVelocity * 40 + Vector3.yAxis * 8.5
							VelocityObject:Fire()
						end

						if AddRagdoll then
							RagdollHandler.ragdoll(EnemyHumanoid, 2, nil, nil, nil, nil, checkAir)
							--RagdollHandler.ragdoll(EnemyHumanoid, 2)
						end
						--task.delay(2.1, function() -- Match this delay to your ragdoll duration
						--	if EnemyCharacter and EnemyCharacter.Parent then
						--		iFramesService:RemoveAlliFrames(EnemyCharacter)
						--	end
						--end)
					else
						--local Velocity = HumRP.CFrame.LookVector * 13

						--NewKnockback:Knockback(Character, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = Velocity })
						--if not EnemyCharacter:HasTag("Knockbacked") then
						--	NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(math.huge, 0, math.huge), Velocity = Velocity })
						--end
						--local MaxForce = Vector3.new(1, 0, 1) * 10000
						local MaxForce = Vector3.new(1, 0, 1) * 10000

						local VictimVelocityObject = Velocity.new(EnemyCharacter)
						VictimVelocityObject.Settings.RemoveTime = 0.2
						VictimVelocityObject.Settings.MaxForce = MaxForce
						VictimVelocityObject.Settings.Velocity = HumRP.CFrame.LookVector * 10
						VictimVelocityObject:Fire()

						local AttackerVelocityObject = Velocity.new(Character)
						AttackerVelocityObject.Settings.Name = "M1PullIn"
						AttackerVelocityObject.Settings.Z = 10
						AttackerVelocityObject.Settings.RemoveTime = 0.2
						AttackerVelocityObject.Settings.MaxForce = MaxForce
						AttackerVelocityObject.Settings.Controllable = true
						AttackerVelocityObject:Fire()
					end
				end
			end, nil, VoxelParameters, false, true)

			if Hit == true then
				
			else
				if CurrentCombo >= MaxCombo then
					Character:SetAttribute("DefaultRunSpeed", 0)
					Character:SetAttribute("DefaultWalkSpeed", 0)

					Humanoid.WalkSpeed = 0
				end
			end

			if CurrentCombo >= MaxCombo then
				if CurrentType == "Downslam" then
					local slamCF, slamSize = HumRP.CFrame * CFrame.new(0, -5, -3.5), Vector3.new(5, 8, 5)
					DebreeService.Destroy(slamCF, slamSize, {
						Shape = "Box",
						Mode = "Auto", -- the floor cracks in place
						Direction = Vector3.new(0, -1, 0), -- a slam: wall pieces are driven down and stay put (JJS)
						Bounce = 8, -- the tiny pop JJS gives some ground breaks (0 = none)
						Attacker = Player,
					})
				elseif CurrentType == "Uppercut" then	
					local punchCF, punchSize = HumRP.CFrame * CFrame.new(0, -2, -3), Vector3.new(8, 8, 8)
					DebreeService.Destroy(punchCF, punchSize, {
						Shape = "Box",
						Mode = "Auto",
						--Power = 35,

						Direction = HumRP.CFrame.UpVector,
						Attacker = Player,
						KeepGround = true,
					})
				else
					local punchCF, punchSize = HumRP.CFrame * CFrame.new(0, -2, -3), Vector3.new(8, 8, 8)
					DebreeService.Destroy(punchCF, punchSize, {
						Shape = "Box",
						Mode = "Auto",
						Power = 35,
						
						Direction = HumRP.CFrame.LookVector,
						--Bounce = 8, -- the tiny pop JJS gives some ground breaks (0 = none)
						Attacker = Player,
						KeepGround = true,
					})
					
					--local punchCF, punchSize = HumRP.CFrame * CFrame.new(0, -1, -3), Vector3.new(6, 6, 4)
					--DebreeService.Destroy(punchCF, punchSize, {
					--	Shape = "Box",
					--	Mode = "Auto", -- walls slide away along the look direction, the floor cracks in place
					--	Direction = HumRP.CFrame.LookVector,
					--	Attacker = Player,
					--})
					
					
				end
			end
		end)
	)

	local ended = false --Original
	--local function EndFunction()
	--	if ended == true then return end
	--	ended = true

	--	Character:RemoveTag('Punching')

	--	local skillLock = false
	--	for _, f in Character:GetChildren() do
	--		if f:IsA("Folder") and f.Name == "Stunned" and f:HasTag("DestroyImmunity") then
	--			skillLock = true
	--			break
	--		end
	--	end

	--	task.spawn(function()
	--		for _,v in PunchEvents do
	--			v:Disconnect()
	--		end

	--		if skillLock then return end

	--		local Stun
	--		if Hit == false and CurrentCombo >= 4 then
	--			Stun = StunHandler:Stun(Character, 0.7, false, 0, 0, false)
	--		end

	--		local WaitTime = 0.15
	--		if CurrentCombo >= MaxCombo and Hit == false then
	--			WaitTime *= 2
	--		end

	--		Character:AddTag("CantBlock")
	--		task.delay(WaitTime, function()
	--			if not Character:HasTag('Punching') then
	--				Character:SetAttribute('DefaultRunSpeed', 25)
	--				Character:SetAttribute('DefaultWalkSpeed', 16)
	--				Character:SetAttribute('DefaultJumpPower', 50)

	--				Character:RemoveTag("CantBlock")

	--				Humanoid.JumpPower = 50
	--				Humanoid.WalkSpeed = 16
	--			end
	--		end)
	--	end)

	--	if CurrentCombo >= MaxCombo then
	--		task.delay(1.5, function()
	--			Character:RemoveTag('PunchCDS')
	--			if Character:GetAttribute("doPunch") == true then
	--				M1(Player)
	--			end
	--		end)
	--	else
	--		Character:RemoveTag('PunchCDS')

	--		if Character:GetAttribute("doPunch") == true then
	--			M1(Player)
	--		end
	--	end
	--end

	local function EndFunction()
		if ended == true then
			return
		end
		ended = true

		Character:RemoveTag("Punching")

		-- skill lock: a DestroyImmunity-tagged stun means an ability's self-stun
		-- took over mid-M1 (M1 -> instant skill cast stops the punch anim, which
		-- fires this via Stopped). Without this guard the delayed block below
		-- restores WalkSpeed/JumpPower over the skill's stun and the player can
		-- walk around during the skill animation.
		local skillLock = false
		for _, f in Character:GetChildren() do
			if f:IsA("Folder") and f.Name == "Stunned" and f:HasTag("DestroyImmunity") then
				skillLock = true
				break
			end
		end

		task.spawn(function()
			for _, v in PunchEvents do
				v:Disconnect()
			end

			if skillLock then
				-- the M1 start lowered the movement baselines (DefaultJumpPower 0,
				-- DefaultRunSpeed 16, whiffs even 0) and the normal restore below
				-- must not run mid-skill — but skipping it forever left the player
				-- unable to run or jump after the skill. So: wait for the skill
				-- lock to release, then restore the baselines.
				local lockStart = os.clock()
				local locked = true
				repeat
					task.wait(0.1)
					locked = false
					for _, f in Character:GetChildren() do
						if f:IsA("Folder") and f.Name == "Stunned" and f:HasTag("DestroyImmunity") then
							locked = true
							break
						end
					end
				until not locked or os.clock() - lockStart > 30 or not Character.Parent

				if not Character.Parent or Character:HasTag("Punching") then
					return -- died/despawned, or a new M1 chain owns the restore now
				end

				Character:SetAttribute("DefaultRunSpeed", 25)
				Character:SetAttribute("DefaultWalkSpeed", 16)
				Character:SetAttribute("DefaultJumpPower", 50)

				-- raw writes only when nothing else governs movement anymore
				if not Character:HasTag("Stunned") then
					Humanoid.JumpPower = 50
					Humanoid.WalkSpeed = 16
				end

				return
			end

			local Stun
			if Hit == false and CurrentCombo >= 4 then
				Stun = StunHandler:Stun(Character, 0.7, true, 0, 0, true)
			end

			local WaitTime = 0.15

			if CurrentCombo >= MaxCombo and Hit == false then
				WaitTime *= 2
			end

			Character:AddTag("CantBlock")
			task.delay(WaitTime, function()
				if not Character:HasTag("Punching") then
					Character:SetAttribute("DefaultRunSpeed", 25)
					Character:SetAttribute("DefaultWalkSpeed", 16)
					Character:SetAttribute("DefaultJumpPower", 50)

					Character:RemoveTag("CantBlock")

					Humanoid.JumpPower = 50
					Humanoid.WalkSpeed = 16
				end
			end)
		end)

		if CurrentCombo >= MaxCombo then
			task.delay(1.5, function()
				Character:RemoveTag("PunchCDS")
				if Character:GetAttribute("doPunch") == true then
					M1(Player)
				end
			end)
		else
			Character:RemoveTag("PunchCDS")

			if Character:GetAttribute("doPunch") == true then
				M1(Player)
			end
		end
	end

	table.insert(PunchEvents, PunchAnimTrack:GetMarkerReachedSignal("end"):Once(EndFunction))
	PunchAnimTrack.Stopped:Once(EndFunction)

	AnimationService:stopAnimation(Character, PreviousAnimation)
	AnimationService:playAnimation(Character, PunchAnim)

	if
		MovesetName == "KJ"
		or MovesetName == "Martial Artist"
		or MovesetName == "Hero Hunter"
		or MovesetName == "Monster Form"
	then
		PunchAnimTrack:AdjustSpeed(1.15 * workspace.Configuration.AttackSMult.Value)
	elseif MovesetName == "Black" or MovesetName == "The Dark Lord" then
		PunchAnimTrack:AdjustSpeed(1.35 * workspace.Configuration.AttackSMult.Value)
	elseif MovesetName == "Cursed Child" then
		PunchAnimTrack:AdjustSpeed(1.5 * workspace.Configuration.AttackSMult.Value)
	elseif MovesetName == "Frozen Warrior" then
		PunchAnimTrack:AdjustSpeed(1.15 * workspace.Configuration.AttackSMult.Value)

		ReplicateSet:FireAllClients(
			"frozenm1",
			{ Char = Character, Stage = "Swing", Combo = CurrentCombo, Type = CurrentType }
		)
	elseif MovesetName == "BlackBeard" then
		PunchAnimTrack:AdjustSpeed(0.85 * workspace.Configuration.AttackSMult.Value)

		Remotes.ClientEffects:FireAllClients("BlackBeardFistEffects", { Attacker = Character, SkillType = "m1" })
	elseif MovesetName == "Zoro" then
		
		PunchAnimTrack:AdjustSpeed(0.85 * workspace.Configuration.AttackSMult.Value)
		
	elseif MovesetName == "WhiteBeard" then
		PunchAnimTrack:AdjustSpeed(0.85 * workspace.Configuration.AttackSMult.Value)
	
	elseif MovesetName == "Crocodile" then
		local speed = 1

		if CurrentCombo == 1 then
			speed = 1.5 -- M1 1 speed
		elseif CurrentCombo == 2 then
			speed = 1.5 -- M1 2 speed
		end

		PunchAnimTrack:AdjustSpeed(speed * workspace.Configuration.AttackSMult.Value)

	elseif MovesetName == "Sanji" then
		PunchAnimTrack:AdjustSpeed(0.85 * workspace.Configuration.AttackSMult.Value)
	elseif MovesetName == "Luffy" then
		PunchAnimTrack:AdjustSpeed(1 * workspace.Configuration.AttackSMult.Value)
	end

	if CurrentType ~= "Uppercut" and CurrentType ~= "Downslam" then
		if MovesetName == "Martial Artist" then
			ReplicateSet:FireAllClients("suiryum1", { Stage = "M" .. CurrentCombo, Char = Character })
		elseif MovesetName == "Zoro" then
			local Part = nil
			if CurrentCombo == 1 or CurrentCombo == 2 or CurrentCombo == 4 then
				Part = Character.ZoroSwords.Shisui
			elseif CurrentCombo == 3 then
				Part = Character.ZoroSwords["Sandai Kitetsu"]
			end
			ReplicateSet:FireAllClients("SwordTrail", { Part = Part, Lifetime = PunchAnimTrack.Length })
			
		elseif MovesetName == "WhiteBeard" then
			local Part = nil
			if CurrentCombo == 1 or CurrentCombo == 2 or CurrentCombo == 4 then
				Part = Character.Bisento
			elseif CurrentCombo == 3 then
				Part = Character.Bisento
			end
			ReplicateSet:FireAllClients("SwordTrail", { Part = Part, Lifetime = PunchAnimTrack.Length })
		
		end
	end

	task.spawn(function()
		local SwingSFX: Sound

		if CurrentType == "Downslam" then
			SwingSFX = Sounds.Characters["Sanji"].Swings.Downslam
		else
			if Sounds.Characters[MovesetName].Swings[tostring(CurrentCombo)] ~= nil then
				SwingSFX = Sounds.Characters[MovesetName].Swings[tostring(CurrentCombo)]
			else
				SwingSFX = Sounds.Characters["Sanji"].Swings[tostring(CurrentCombo)]
			end
		end

		SoundHandler:AddSound(SwingSFX, HumRP)
	end)
end

local function Block(Player: Player)
	local Character = Player.Character
	if not Character or Character:GetAttribute("doBlock") ~= true then
		return
	end
	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")
	if not Humanoid then
		return
	end
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
	if not HumRP then
		return
	end

	if
		Character:HasTag("CantBlock")
		or Character:HasTag("Stunned")
		or Character:HasTag("Punching")
		or Character:HasTag("Ragdolled")
	then
		task.delay(0.1, function()
			Block(Player)
			warn("Recursive")
		end)

		--for _, Anim in Animations.Throwables:GetDescendants() do
		--	if Anim:IsA("Animation") and Anim.Name == 'Idle' then
		--		AnimationService:stopAnimation(Character, Anim)
		--	end
		--end

		return
	elseif Character:HasTag("ThrowableGrabbed") or Character:HasTag("Blocking") then
		return
	end

	local Actions = {
		"CantPunch",
		"CantDash",
		"CantSideDash",
		"CantBlock",
		"Blocking",
		"CantRun",
	}

	local Connections = {}
	local Stopped
	local MovesetName = Player:GetAttribute("Character")
	local Anim

	if MovesetName == "Zoro" then
		Anim = Animations.Zoro.BlockIdle
	elseif MovesetName == "Sanji" then
		Anim = Animations.Sanji.BlockIdle
	else
		Anim = Animations.Character.BlockIdle
	end

	SoundsModule:PlaySound(Sounds.Blocking.StartNew, HumRP)

	local function stopBlock()
		if Stopped then
			return
		end
		Stopped = true

		for _, v in Connections do
			v:Disconnect()
		end

		Character:SetAttribute("DefaultRunSpeed", 25)
		Character:SetAttribute("DefaultWalkSpeed", 16)
		Character:SetAttribute("DefaultJumpPower", 50)

		Humanoid.WalkSpeed = 16
		Humanoid.JumpPower = 50

		for _, Action in ipairs(Actions) do
			Character:RemoveTag(Action)
		end

		SoundsModule:PlaySound(Sounds.Blocking.StartNew, HumRP)
	end

	local BlockAnimTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, Anim)

	Connections["Stopped"] = BlockAnimTrack.Stopped:Once(function()
		if Character:GetAttribute("DivineForm") then
			return
		end

		stopBlock()
	end)
	Connections["StopLoop"] = Character:GetAttributeChangedSignal("doBlock"):Connect(function()
		if not Character:GetAttribute("doBlock") then
			AnimationService:stopAnimation(Character, Anim)

			stopBlock()
		end
	end)

	AnimationService:stopAll(Character)
	AnimationService:playAnimation(Character, Anim)

	Character:SetAttribute("DefaultRunSpeed", 8)
	Character:SetAttribute("DefaultWalkSpeed", 8)

	Humanoid.WalkSpeed = 8
	Humanoid.JumpPower = 0

	for _, Action in ipairs(Actions) do
		Character:AddTag(Action)
	end

	local Perfect = true
	local PC: RBXScriptConnection
	PC = Character.ChildAdded:Connect(function(Child)
		if Child.Name == "DamagedLog" and Child:HasTag("IsM1") and Perfect == true then
			if PC then
				PC:Disconnect()
				PC = nil
			end

			Character:AddTag("PerfectBlock")
			task.delay(1, function()
				Character:RemoveTag("PerfectBlock")
			end)
		end
	end)

	task.delay(0.25, function()
		if PC then
			PC:Disconnect()
			PC = nil
		end

		Perfect = false
	end)
end

Remotes.ChooseCharacter.OnServerEvent:Connect(function(Player: Player, CharacterName)
	if not Player:FindFirstChild("LoadedData") then
		return
	end
	if not Player:GetAttribute("Loaded") then
		return
	end

	if ArenaMatch then
		local allowed, reason = ArenaMatch.CanChooseCharacter(Player, CharacterName)
		if not allowed then
			Remotes.Comunicator.Set:FireClient(Player, "SendNotification", { Title = "NOTIFICATION", Text = reason })
			return
		end
	end

	if CharacterName == Player:GetAttribute("Character") then
		Remotes.Comunicator.Set:FireClient(
			Player,
			"SendNotification",
			{ Title = "NOTIFICATION", Text = "YOU ARE ALREADY PLAYING THIS CHARACTER." }
		)

		return
	end

	local Character = Player.Character
	local Humanoid: Humanoid = Character.Humanoid
	if not Character or Character:HasTag("Stunned") then
		Remotes.Comunicator.Set:FireClient(
			Player,
			"SendNotification",
			{ Title = "NOTIFICATION", Text = "YOU CAN'T CHANGE MOVESETS RIGHT NOW." }
		)
		return
	end

	local MovesetInfo = require(ServerScriptService.Systems.Characters[CharacterName])
	if not MovesetInfo then
		return warn("Invalid characterName from client:", CharacterName)
	end

	local MovesetFolder = SvSt.Movesets:FindFirstChild(CharacterName)
	if not MovesetFolder then
		return warn("Couldn't find moveset in storage:", CharacterName)
	end

	if Player:HasTag("MovesetCD") then
		Remotes.Comunicator.Set:FireClient(
			Player,
			"SendNotification",
			{ Title = "NOTIFICATION", Text = "CAN'T EQUIP MOVESET, YOU ARE ON COOLDOWN." }
		)
		return
	end

	local function isAdmin(Player: Player)
		return Player:GetAttribute("Admin")
	end
	
	if MovesetInfo.IsAdmin == true and not isAdmin(Player) then --and not hasAccessToAdminMovesets(Player) then
		Remotes.Comunicator.Set:FireClient(Player, 'SendNotification', { Title = 'NOTIFICATION'; Text = "YOU CAN'T USE THIS MOVESET BECAUSE IT'S ADMIN-ONLY."; })
		return
	end

	--if MovesetInfo.isQuest == true and not shared.playerClasses[Player.UserId].CompletedQuest then
	--	local message = "YOU MUST COMPLETE THE QUEST TO USE THIS MOVESET.\n" .. "You need a 30 killstreak."

	--	Remotes.Comunicator.Set:FireClient(
	--		Player,
	--		"SendNotification",
	--		{ Title = "THE COLDEST DETERMINATION", Text = message, Time = 5 }
	--	)
	--	return
	--end

	-- Early Access characters (Info.Movesets[...].isEA) need the Early Access pass; admins and the
	-- owner skip it. The profile knows about gifted passes too; GamepassManager handles the purchase.
	local MovesetData = InfoModule.Movesets[CharacterName]
	if MovesetData and MovesetData.isEA == true and not isAdmin(Player) and not Player:GetAttribute("Owner") then
		local Profile = DataManager.Profiles[Player]
		local Pass = Profile and Profile.Data.Gamepasses[tostring(InfoModule.Passes.EarlyAccess)]
		if not (Pass and Pass.owned) then
			Remotes.Comunicator.Set:FireClient(Player, 'SendNotification', { Title = 'EARLY ACCESS'; Text = CharacterName:upper() .. " IS IN EARLY ACCESS. GET THE EARLY ACCESS GAMEPASS TO PLAY THEM NOW."; })
			pcall(game:GetService("MarketplaceService").PromptGamePassPurchase, game:GetService("MarketplaceService"), Player, InfoModule.Passes.EarlyAccess)
			return
		end
	end

	local DamagerLog: ObjectValue = Player.Character:FindFirstChild("DamagerLog")
	local DamagedLog: ObjectValue = Player.Character:FindFirstChild("DamagedLog")

	if (DamagerLog and not DamagerLog.Value:FindFirstChild("Dummy")) or (DamagedLog and not DamagedLog.Value:FindFirstChild("Dummy")) then
		local DamagerTime, DamagedTime = 0, 0

		if DamagerLog then
			DamagerTime = math.round(DamagerLog.TimeRemaining.Value)
		end

		if DamagedLog then
			DamagedTime = math.round(DamagedLog.TimeRemaining.Value)
		end

		local HighestTime = math.max(DamagerTime, DamagedTime)

		if HighestTime > 0 then
			Remotes.Comunicator.Set:FireClient(
				Player,
				"SendNotification",
				{
					Title = "NOTIFICATION",
					Text = "CAN'T CHANGE MOVESETS RIGHT NOW, WAIT " .. HighestTime .. " SECONDS.",
				}
			)

			return
		end
	end

	Player:AddTag("MovesetCD")
	task.delay(2, function()
		Player:RemoveTag("MovesetCD")
	end)

	Player.AwakeningProgress.Value = 0

	Player.Configuration.Moveset.Value = CharacterName
	Player:SetAttribute("Character", CharacterName)
	Player:SetAttribute("Moveset", CharacterName)
	DataManager.lastCharacter(Player, CharacterName)

	--print(("[Server] %s chose %s"):format(Player.Name, CharacterName))
	if ArenaMatch then
		ArenaMatch.BeforeCharacterSwap(Player)
	end
	Humanoid.Health = 0
end)

--Combat System
local CombatSetEvent = Remotes.Combat.Attack.OnServerEvent
CombatSetEvent:Connect(function(Player, Action, Params)
	if not Player:FindFirstChild("LoadedData") then
		return
	end
	if not Player:GetAttribute("Loaded") then
		return
	end

	local Character = Player.Character
	if not Character or not Character.Parent then
		return
	end
	local HumRP: BasePart = Character:FindFirstChild("HumanoidRootPart")
	local Humanoid: Humanoid = Character:FindFirstChild("Humanoid")

	if not HumRP or not HumRP.Parent or not Humanoid or not Humanoid.Parent then
		return
	end
	--if game.PlaceId == workspace:GetAttribute("DuelsHubPlaceId") then return end

	if Action == "PunchStart" then
		if workspace.Configuration.NoAttack.Value == true or Player.Commands.NoAttack.Value == true then
			return
		end

		Character:SetAttribute("doPunch", true)
		Character:SetAttribute("IsJumping", Params and Params.Uppercut == true)

		M1(Player)
	elseif Action == "PunchEnd" then
		Character:SetAttribute("doPunch", false)
	elseif Action == "Block" then
		if Params.Stage == true then
			--if workspace.Configuration.NoBlock.Value == true or Player.Commands.NoBlock.Value == true then return end

			Character:SetAttribute("doBlock", true)
			Block(Player)
		else
			Character:SetAttribute("doBlock", false)
		end
	elseif Action == "SetJumping" then
		Character:SetAttribute("IsJumping", Params.HoldingSpace or false)
	elseif Action == "SetAirState" then
		Character:SetAttribute("IsInAir", Params.InAir or false)
	end
end)

Remotes.Dash.OnServerEvent:Connect(function(Player: Player, Parameters: { Key: EnumItem })
	if not Player:FindFirstChild("LoadedData") then
		return
	end
	if not Player:GetAttribute("Loaded") then
		return
	end

	local Character = Player.Character
	local Humanoid = Character and Character:FindFirstChild("Humanoid")
	local HumRP = Character and Character:FindFirstChild("HumanoidRootPart")
	if not (Character and Humanoid and HumRP) then
		return
	end

	local Keypressed = Parameters.Key

	if Keypressed == Enum.KeyCode.Q then
		local Direction = Parameters.Direction

		if Direction == "Front" or Direction == "Back" then
			if Direction == "Back" then
				if not Character:HasTag("Ragdolled") and not Character:HasTag("Knockbacked") then
					if
						(
							Character:HasTag("DashCD")
								and not Player.Commands.NoDashCD.Value
								and not workspace.Configuration.NoDashCD.Value
						)
							or Character:HasTag("CantDash")
							or Character:HasTag("Stunned")
					then
						return
					end
				else
					if
						not Character:HasTag("CantRagdollCancel")
						and Character:GetAttribute("RagdollCancel") ~= false
					then
						task.spawn(function()
							RagdollHandler.cancelRagdoll(Humanoid, nil, false, nil, true, true)

							ReplicateSet:FireAllClients("Evasive", { Char = Character })
							SoundsModule:PlaySound(Sounds.Dashing.Evasive, Character.HumanoidRootPart)

							Character:SetAttribute("RagdollCancel", false)
							task.delay(30, function()
								Character:SetAttribute("RagdollCancel", true)
							end)
						end)
					else
						return
					end
				end

				local Jantior = Trove.new()

				Character:AddTag("DashCD")
				task.delay(5, function()
					Character:RemoveTag("DashCD")
				end)

				--AnimationService:stopAnimation(Character, Animations.Other.Knockback)

				for _, Anim in EmotesFolder:GetDescendants() do
					if Anim:IsA("Animation") then
						AnimationService:stopAnimation(Character, Anim)
					end
				end

				--StunHandler:Stun(Character, 1.017, true, 0, 0, true) -- old stun with longer animation
				StunHandler:Stun(Character, .5, true, 0, 0, true) -- old stun with longer animation
				--SoundsModule:PlaySound(Sounds.Dashing.BackDash, HumRP)
				SoundsModule:PlaySound(Sounds.Dashing["BackDash New"], HumRP)
				SoundsModule:PlaySound(Sounds.Dashing["Back First Woosh"], HumRP)

				task.delay(0.05, function()
					iFramesService:AddBaseiFrames(Character)
					task.delay(0.75, function()
						iFramesService:RemoveAlliFrames(Character)
					end)

					local SmallDebris = Jantior:Add(shared.cfolder({ Name = "SmallDebris" }, 0.2))
					SmallDebris:AddTag("SmallDebris")
					SmallDebris.Parent = Character

					ReplicateSet:FireAllClients("smokeEffect", { time = 0.2, char = Character })
					--SoundsModule:PlaySound(Sounds.Dashing["Back Second Woosh"], HumRP)
				end)

				--task.delay(0.5, function()
				--	ReplicateSet:FireAllClients("smokeEffect", { time = 0.35, char = Character })

				--	local SmallDebris = Jantior:Add(shared.cfolder({ Name = "SmallDebris" }, 0.4))
				--	SmallDebris:AddTag("SmallDebris")
				--	SmallDebris.Parent = Character

				--	SoundsModule:PlaySound(Sounds.Dashing["Back Second Woosh"], HumRP)
				--end)

				task.delay(1.2, function()
					Jantior:Clean()
				end)

				local limbNames = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }
				for i, v in pairs(Character:GetChildren()) do
					if v:IsA("BasePart") then
						if table.find(limbNames, v.Name) then
							ReplicateSet:FireAllClients(
								"armTrailEffect",
								{ char = Character, lifeTime = 0.65, limbName = v.Name }
							)
						end
					end
				end
			else
				if Character:HasTag("Stunned") then
					return
				end

				local Player = Players:GetPlayerFromCharacter(Character)
				local HumRP: BasePart = Character.HumanoidRootPart
				local Humanoid: Humanoid = Character.Humanoid

				if not Character:HasTag("Ragdolled") and not Character:HasTag("Knockbacked") then
					if
						(
							Character:HasTag("DashCD")
								and not Player.Commands.NoDashCD.Value
								and not workspace.Configuration.NoDashCD.Value
						)
							or Character:HasTag("CantDash")
							or Character:HasTag("Stunned")
					then
						return
					end
				end

				Character:AddTag("NoHeadFollow")
				Character:AddTag("CantDash")
				Character:AddTag("DashCD")
				task.delay(5, function()
					if Character then
						Character:RemoveTag("CantDash")
						Character:RemoveTag("DashCD")
					end
				end)

				local dashVelocity = Instance.new("BodyVelocity")
				dashVelocity.Name = "FrontDashVelocity"
				dashVelocity.MaxForce = Vector3.new(40000, 0, 40000)

				local SmallDebris = shared.cfolder({ Name = "SmallDebris" }, 1)
				CollectionService:AddTag(SmallDebris, "SmallDebris")
				SmallDebris.Parent = Character

				Remotes.ClientEffects:FireAllClients("DashEffects", { Attacker = Character, SkillType = "groundRocks" })

				task.delay(0.1, function()
					ReplicateSet:FireAllClients("Ring", {
						FirstProps = {
							Size = Vector3.new(2.589, 0.896, 2.589),
							Transparency = 0.25,
						},

						CF = HumRP.CFrame * CFrame.Angles(1.5707963267948966, 0, 0),

						TN_Info = {
							Time = 0.3,
							Style = "Quad",
							Direction = "Out",
						},

						FinalProps = {
							Size = Vector3.new(9.874, 0.1, 9.874),
							Transparency = 1,
						},
					})
				end)

				local Moveset = Player:GetAttribute("Moveset")
				local DashStartAnim = SvSt.Assets.Animations[Moveset].Dash.Dash
					or SvSt.Assets.Animations.Sanji.Dash.Dash
				local DashHitAnim = SvSt.Assets.Animations[Moveset].Dash.DashHit
					or SvSt.Assets.Animations.Sanji.Dash.DashHit -- new hit anim

				local DashTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, DashStartAnim)
				local DashEvents = {}
				local HitTrack: AnimationTrack = AnimationService:getAnimationTrack(Character, DashHitAnim)
				local HitEvents = {}

				local DetectedEnemy
				local EarlyDectectionSystem = false
				local playedDashHitAnim = false
				local PendingEarlyHit = false
				local MinHitTime = 0.15 -- minimum dash travel time before a close-range hit triggers
				local Hit = false
				local Blocked = false
				local Ended = false
				
				
				local Time = time()
				local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
				local NearEnemys = {}

				local Jantior = Trove.new()

				local dashingForward = Jantior:Add(shared.cfolder({ Name = "dashingForward" }))
				dashingForward.Parent = Character

				local function endDash()
					if Ended then
						return
					end
					Ended = true
					Character:RemoveTag("NoHeadFollow")

					--DashTrack:AdjustSpeed(1)
					--DashTrack:Stop()

					for _, v in DashEvents do
						v:Disconnect()
					end
					for _, v in HitEvents do
						v:Disconnect()
					end
					Character:SetAttribute("Dashing", false)
					if Hit then
						warn("Hit someone, short stun")
						if Stun then
							StunHandler:Unstun(Character, Stun)
						end
					elseif Blocked then
						task.delay(0.3, function()
							if Stun then
								StunHandler:Unstun(Character, Stun)
							end
						end)
					else
						--warn("Missed, long stun")
						--task.delay(0.5, function()
						task.delay(0.0, function()

							if Stun then
								StunHandler:Unstun(Character, Stun)
							end
						end)
					end

					if dashVelocity then
						--warn("Velocty destroyed")
						dashVelocity:Destroy()
					end

					shared.safeDestroy(SmallDebris)
					
					if Jantior then
						--warn("Janitor gone")
						Jantior:Destroy()
						Jantior = nil
					end

					--warn("True end Dash function")
				end

				local function playHitAnimation()
					if Ended then
						return
					end
					-- dash clash (archived in ServerStorage.Archived.Dash Clash System)
					--if Character:GetAttribute("InClash") then
					--	return
					--end
					if playedDashHitAnim then
						return
					end
					playedDashHitAnim = true

					--warn("Unfroze dash track")
					--DashTrack:AdjustSpeed(1)
					--DashTrack:Stop(0.1)

					-- Stop the lunge, play the attack
					--AnimationService:stopAnimation(Character, DashStartAnim)

					-- This is where your hitbox logic goes, triggered by hit marker
					HitEvents["hit"] = HitTrack:GetMarkerReachedSignal("hit"):Once(function()
						if Ended then
							return
						end

						--ReplicateSet:FireAllClients("destroyAmbient", {
						--	Velocity = HumRP.CFrame.LookVector,
						--	Multiplier = { 15, 50 },
						--	Size = Vector3.one * 8,
						--	CFrame = HumRP,
						--	Offset = CFrame.new(0, 1, -4),
						--	Voxels = true
						--})
						ReplicateSet:FireAllClients("DashMiss", { PrimaryPart = HumRP, YAngle = math.pi })
						
						SoundsModule:PlaySound(Sounds.Dashing.FrontDashSwingRework, HumRP)
						SoundsModule:PlaySound(Sounds.Dashing.FrontDashSwingRework2, HumRP)
						--SoundsModule:PlaySound(Sounds.Dashing.FrontDashSwing2, HumRP)
						
						if dashVelocity and dashVelocity.Parent then
							warn("Destroyed DashVelocity in hit anim")
							dashVelocity:Destroy()
						end

						local Hitbox = ReplicatedHitboxes.new(Player)
						Hitbox.Instance = HumRP
						Hitbox.Size = Vector3.new(8, 8, 8)
						Hitbox.Offset = CFrame.new(0, 1, -4)
						Hitbox.Ignore = { Character }

						Hitbox.onTouch = function(EnemyCharacter)
							warn("Hit")
							local EnemyHumRP = EnemyCharacter.HumanoidRootPart
							local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
							local Ragdolled = EnemyCharacter:HasTag("Ragdolled")
							local inAir = EnemyCharacter:FindFirstChild("inAir")
								or (
									EnemyCharacter:GetAttribute("TouchedGround")
									and tick() - EnemyCharacter:GetAttribute("TouchedGround") <= 0.25
								)

							if EnemyCharacter ~= DetectedEnemy then
								if
									iFramesService:HasiFrame(EnemyCharacter, "M1")
									or EnemyHumanoid.Health <= 0
									or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
									or (Ragdolled and not inAir)
								then
									return
								end
							end

							local HitInfo = DamageHandler:TakeDamage(
								Character,
								EnemyHumanoid,
								4,
								1,
								SvSt.Assets.Animations.Character.Damaged["Damaged" .. tostring(math.random(0, 4))],
								true,
								true,
								true
							)
							if HitInfo.Blocked == true then
								Blocked = true
								SoundsModule:PlaySound(
									Sounds.Blocking.Hits:GetChildren()[math.random(
										1,
										#Sounds.Blocking.Hits:GetChildren()
									)],
									EnemyHumRP
								)
								return
							elseif HitInfo.Countered == true then
								return
							end

							if not Hit then
								print("Hit is now true")
								Hit = true

								ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = 2 })
							end

							ReplicateSet:FireAllClients(
								"DashHit",
								{
									Char = Character,
									EChar = EnemyCharacter,
									RootPart = EnemyHumRP,
									LookVector = HumRP.CFrame.LookVector,
								}
							)
							SoundsModule:PlaySound(Sounds.Dashing.FrontDashHitRework, EnemyHumRP)

							if dashingForward then
								Debris:AddItem(dashingForward, 0.1)
							end

							if Ragdolled or table.find(NearEnemys, EnemyCharacter) then
								if Ragdolled then
									RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, false, true)
								end

								EnemyHumRP.AssemblyLinearVelocity = Vector3.zero

								local selfToOtherChar = (EnemyHumRP.Position - HumRP.Position).Unit
								local lookVector = Character.HumanoidRootPart.CFrame.LookVector

								local dotProduct = lookVector:Dot(selfToOtherChar)
								if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air then
									dotProduct = 1
								end

								local at = Character.HumanoidRootPart.Position
								local forward = Character.HumanoidRootPart.CFrame.LookVector
								local lookposition = CFrame.lookAt(at, at + Vector3.new(forward.X, 0, forward.Z))

								if EnemyHumanoid.FloorMaterial ~= Enum.Material.Air or not inAir then
									require(SvModules.PerfectKnockback).KnockBack(nil, EnemyCharacter, {
										LookVector = lookposition.LookVector,
										LookForce = 58.5,
										LookFinalForce = 55,
										LookAt = lookposition,
										DestroyRagdoll = true,
										GroundStunTime = 0.95,
										Escapable = false,
										FallingDetectDelay = 0.2,
										Dot = dotProduct,
										DotParams = { 0.4, 1 },
										canHitWall = true,
									}, Character)
								else
									require(SvModules.PerfectKnockback).KnockBack(nil, EnemyCharacter, {
										LookVector = lookposition.LookVector,
										LookForce = 58.5,
										LookFinalForce = 55,
										LookAt = lookposition,
										DestroyRagdoll = true,
										GroundStunTime = 0.95,
										Escapable = false,
										FallingDetectDelay = 0.2,
										Dot = dotProduct,
										DotParams = { 0.4, 1 },
										canHitWall = true,
									}, Character)
								end

								NewKnockback:makeEnemyFaceCharacter(EnemyCharacter, Character)

								ReplicateSet:FireAllClients("Ring", {
									FirstProps = {
										Size = Vector3.new(2.589, 0.896, 2.589),
										Transparency = 0.25,
									},

									CF = EnemyHumRP.CFrame * CFrame.new(0, 0, -3.5) * CFrame.Angles(math.rad(90), 0, 0),

									TN_Info = {
										Time = 0.3,
										Style = "Quad",
										Direction = "Out",
									},

									FinalProps = {
										Size = Vector3.new(9.874, 0.1, 9.874),
										Transparency = 1,
									},
								})
							end

							task.delay(0.1, function()
								if Stun then
									StunHandler:Unstun(Character, Stun)
								end
							end)
						end
						Hitbox:Once()
					end)

					HitTrack.Stopped:Once(function()
						-- cleanup
						endDash()
						shared.safeDestroy(SmallDebris)
					end)

					AnimationService:stopAll(Character)
					AnimationService:playAnimation(Character, DashHitAnim)
				end

				--for _, CloseEnemy in workspace.World.Live:GetChildren() do
				--	if CloseEnemy == Character then
				--		continue
				--	end

				--	local CloseHumRP: BasePart = CloseEnemy:FindFirstChild("HumanoidRootPart")
				--	if CloseHumRP then
				--		if (CloseHumRP.Position - HumRP.Position).Magnitude < 15 then
				--			table.insert(NearEnemys, CloseEnemy)
				--		end
				--	end
				--end
				local function scanForNearEnemies(folder)
					for _, CloseEnemy in folder:GetChildren() do
						if CloseEnemy == Character or not CloseEnemy:IsA("Model") then
							continue
						end

						local CloseHumRP: BasePart = CloseEnemy:FindFirstChild("HumanoidRootPart")
						if CloseHumRP then
							if (CloseHumRP.Position - HumRP.Position).Magnitude < 15 then
								table.insert(NearEnemys, CloseEnemy)
							end
						end
					end
				end

				scanForNearEnemies(workspace.World.Live)                     -- dummies
				local livePlayers = workspace.World.Live:FindFirstChild("Players")
				if livePlayers then
					scanForNearEnemies(livePlayers)                          -- player characters
				end

				DashEvents["dash"] = DashTrack:GetMarkerReachedSignal("dash"):Once(function()
					--if Ended then return end
				end)

				DashTrack.Stopped:Once(function() --If player gets hit when they do the dash.
					for _, v in DashEvents do
						v:Disconnect()
					end
					if not Ended and not playedDashHitAnim then
						warn("Dash cancelled externally / stunned")

						endDash()
					end
				end)

				--if Character:HasTag('HasKnife') then
				--	ReplicateSet:FireAllClients("CharaDash", { Stage = "Start",  Char = Character })

				--elseif Player:GetAttribute("Moveset") == "Hero Hunter" or Player:GetAttribute("Moveset") == "Monster Form" then
				--	local Effect = Player:GetAttribute("Moveset") == "Monster Form" and "RedPalm" or "waterpalm"

				--	ReplicateSet:FireAllClients(Effect, { Char = Character, Time = 0.7, Limb = "Right Arm" })
				--end
				--ReplicateSet:FireAllClients("DashMiss", { PrimaryPart = HumRP })

				task.delay(0.55, function()
					if Character and Character.Parent then
						Character:SetAttribute("Dashing", false)
					end
				end)

				task.delay(0.7, function()
					if not Ended then
						playHitAnimation()
					end
				end)

				task.delay(2, function()
					if not Ended then
						endDash()
					end
				end)

				local limbNames = { "Right Arm", "Left Arm", "Right Leg", "Left Leg" }
				for i, v in Character:GetChildren() do
					if v:IsA("BasePart") then
						if table.find(limbNames, v.Name) then
							ReplicateSet:FireAllClients(
								"armTrailEffect",
								{ char = Character, lifeTime = 0.875, limbName = v.Name }
							)
						end
					end
				end

				AnimationService:stopAll(Character)
				AnimationService:playAnimation(Character, DashStartAnim)

				Character:SetAttribute("Dashing", true)

				dashVelocity.Parent = HumRP
				Debris:AddItem(dashVelocity, 0.85)

				SoundsModule:PlaySound(Sounds.Dashing.FrontDash2, HumRP)
				local DetectHitbox = ReplicatedHitboxes.new(Player)
				DetectHitbox.Instance = HumRP
				DetectHitbox.Size = Vector3.new(8, 8, 8)
				DetectHitbox.Offset = CFrame.new(0, 1, -4)
				DetectHitbox.Ignore = { Character }
				DetectHitbox.onTouch = function(EnemyCharacter)
					--warn("Found An Early Target")
					--if not EarlyDectectionSystem then
					--	DetectHitbox:Stop()
					--	DetectHitbox = nil
					--	EarlyDectectionSystem = true
					--	return
					--end
					
					local EnemyHumRP = EnemyCharacter.HumanoidRootPart
					local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
					local Ragdolled = EnemyCharacter:GetAttribute("Ragdolled") --EnemyCharacter:HasTag('Ragdolled')
					
					--[[
					-- If we got claimed by a clash already, stop our own dash from hitting.
					if Character:GetAttribute("InClash") then
						return
					end

					-- Both players front-dashing into each other -> start a clash instead of a hit.
					if EnemyCharacter:GetAttribute("Dashing") == true and not EnemyCharacter:GetAttribute("InClash") then
						local dot = HumRP.CFrame.LookVector:Dot(EnemyHumRP.CFrame.LookVector)
						if dot < -0.4 then -- facing toward each other
							if ClashService.tryStartClash(Character, EnemyCharacter) then
								if dashVelocity and dashVelocity.Parent then
									dashVelocity:Destroy()
								end
								if DetectHitbox then
									DetectHitbox:Destroy()
									DetectHitbox = nil
								end
								return -- skip the normal dash hit
							end
						end
					end
					]]

					local inAir = EnemyCharacter:FindFirstChild("inAir") or (EnemyCharacter:GetAttribute("TouchedGround") and tick() - EnemyCharacter:GetAttribute("TouchedGround") <= 0.25)

					if iFramesService:HasiFrame(EnemyCharacter, "M1") == true
						or EnemyHumanoid.Health <= 0
						or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead
						or (Ragdolled and not inAir)
					then
						return
					end
					--if iFramesService:HasiFrame(EnemyCharacter, "M1") == true or EnemyHumanoid.Health <= 0 or EnemyHumanoid:GetState() == Enum.HumanoidStateType.Dead or Ragdolled then return end

					if not Ended then
						if Character:GetAttribute("Combo") == 3 then
							shared.safeDestroy(dashVelocity)

							Character:SetAttribute("Combo", 0)
						end

						--if time() - Time < 0.15 then
						--if time() - Time < 0.1 then

						--	warn("Time difference: " .. tostring(time() - Time))
						--	warn("BLOCKED BY TIME")
						--	return
						--end

						--if DetectHitbox ~= nil then
						--	DetectHitbox:Destroy()
						--	DetectHitbox = nil
						--end

						--warn("Calling endDash")
						--DetectedEnemy = EnemyCharacter
						----endDash()
						--if dashVelocity and dashVelocity.Parent then
						--	dashVelocity:Destroy()
						--end

						--playHitAnimation()
						
						local function triggerHit()
							if Ended or playedDashHitAnim --[[or Character:GetAttribute("InClash")]] then -- dash clash archived
								return
							end

							if DetectHitbox ~= nil then
								DetectHitbox:Destroy()
								DetectHitbox = nil
							end

							DetectedEnemy = EnemyCharacter
							if dashVelocity and dashVelocity.Parent then
								dashVelocity:Destroy()
							end

							playHitAnimation()
						end

						local sinceStart = time() - Time
						if sinceStart < MinHitTime then
							-- Hitbox only reports each enemy ONCE, so returning here means the hit
							-- never fires. Schedule it for when the minimum time elapses instead.
							if not PendingEarlyHit then
								PendingEarlyHit = true
								task.delay(MinHitTime - sinceStart, triggerHit)
							end
							return
						end

						triggerHit()
					end
				end

				DetectHitbox:Start(0.7, true)
			end
		elseif Direction == "Right" or Direction == "Left" then
			if not Character:HasTag("Ragdolled") and not Character:HasTag("Knockbacked") then
				if
					(
						Character:HasTag("SideDashCD")
							and not Player.Commands.NoDashCD.Value
							and not workspace.Configuration.NoDashCD.Value
					)
						or Character:HasTag("CantSideDash")
						or Character:HasTag("Stunned")
				then
					return
				end
			else
				if not Character:HasTag("CantRagdollCancel") and Character:GetAttribute("RagdollCancel") ~= false then
					task.spawn(function()
						RagdollHandler.cancelRagdoll(Humanoid, nil, false, nil, true, true)

						--ReplicateSet:FireAllClients("Evasive", { Char = Character })
						SoundsModule:PlaySound(Sounds.Dashing.Evasive, Character.HumanoidRootPart)

						Character:SetAttribute("RagdollCancel", false)
						task.delay(30, function()
							Character:SetAttribute("RagdollCancel", true)
						end)
					end)
				else
					return
				end
			end

			local Jantior = Trove.new()

			--AnimationService:stopAnimation(Character, Animations.Other.Knockback)

			for _, Anim in EmotesFolder:GetDescendants() do
				if Anim:IsA("Animation") then
					AnimationService:stopAnimation(Character, Anim)
				end
			end

			SoundsModule:PlaySound(Sounds.Dashing.SideDash, HumRP)
			SoundsModule:PlaySound(Sounds.Dashing.SideDash2, HumRP)
			--SoundsModule:PlaySound(Sounds.Dashing[Direction .. "Woosh"], HumRP)
			SoundsModule:PlaySound(Sounds.Dashing["Right" .. "Woosh"], HumRP)


			if Character:GetAttribute("TpDash") then
				Character:SetAttribute("Invisible", true)
				task.delay(0.45, function()
					Character:SetAttribute("Invisible", false)
				end)
			else
				--task.spawn(function()
				--	local SmallDebris = Jantior:Add(shared.cfolder({ Name = "SmallDebris" }, 0.25))
				--	SmallDebris:AddTag("SmallDebris")
				--	SmallDebris.Parent = Character

				--	ReplicateSet:FireAllClients("smokeEffect", { time = 0.3, char = Character })
				--end)
				
				Character:SetAttribute("SideDashing", true)
				Remotes.ClientEffects:FireAllClients("DashEffects", { Attacker = Character, SkillType = "side dash rocks", Direction = Direction })

				task.delay(0.7, function()
					Jantior:Clean()
				end)				
			end

			Character:AddTag("SideDashCD")
			task.delay(2, function()
				Character:RemoveTag("SideDashCD")
			end)

			Character:AddTag("CantDash")
			task.delay(0.6, function()
				Character:RemoveTag("CantDash")
				Character:SetAttribute("SideDashing", nil)
			end)
		end
	end
end)

Remotes.SkillRequest.OnServerEvent:Connect(function(Player, Slot, ToolName, isReleased, ArgumentData)
	if not Player:FindFirstChild("LoadedData") then
		return
	end
	
	if not Player:GetAttribute("Loaded") then
		return
	end
	
	local character = Player.Character
	if not character or not character:IsA("Model") then
		warn("No character")
		return
	end

	if typeof(Slot) ~= "number" or Slot ~= math.floor(Slot) or Slot < 1 or Slot > 4 then
		--warn(Player.Name .. " sent an invalid slot: " .. tostring(Slot))
		return
	end

	local Tool: Tool = Player.Moveset:FindFirstChild(ToolName)
	if not Tool then warn("No tool") return end

	local characterName = Player:GetAttribute("Character")

	local abilityModule = cachedCharacters[characterName]
	if not abilityModule then return warn ("No ability module") end
	
	local skill = abilityModule.Skills[Slot]
	if not skill then warn("No skill data") return end

	if isReleased and not skill.Holdable then
		--warn("Not holdable")
		return
	end
	
	if typeof(ArgumentData) ~= "table" then
		ArgumentData = {}
	end

	ArgumentData.IsReleased = isReleased
	
	skill.Activate(Player, skill, ArgumentData)
end)

Remotes.ModeSkillRequest.OnServerEvent:Connect(function(Player, Slot, ToolName, isReleased, ArgumentData)
	if not Player:FindFirstChild("LoadedData") then
		return
	end
	if not Player:GetAttribute("Loaded") then
		return
	end

	if typeof(Slot) ~= "number" or Slot ~= math.floor(Slot) or Slot < 1 or Slot > 4 then
		warn(Player.Name .. " sent an invalid slot: " .. tostring(Slot))
		return
	end

	local character = Player.Character
	if not character or not character:IsA("Model") then
		warn("No character")
		return
	end

	if not character:GetAttribute("Awakened") then
		return
	end

	local Tool: Tool = Player.Moveset:FindFirstChild(ToolName)
	if not Tool then
		warn("No tool")
		return
	end

	local characterName = Player:GetAttribute("Character")
	local newSkillData = InfoModule.Movesets[characterName].Ultimate[Slot] --Calls the cached module. Inside that module, there is a table of skill data. Like the damage and cooldowns.

	if not newSkillData then
		warn("No skill data")
		return
	end

	if isReleased and not newSkillData.Holdable then
		--warn("Not holdable")
		return -- Don't do anything if they release a non-holdable move
	end

	local cooldown = newSkillData.Cooldown or 1
	local damage = newSkillData.Damage or 1
	local MoveName = newSkillData.Name
	--print("MoveName:", MoveName)
	--print("newSkillData:", newSkillData)

	--if ToolName == "Vanishing Kick" then
	--	print("Doing2nd")
	--	if character:GetAttribute("VanishingKickStomp") == true and not character:HasTag("Stunned") and not character:HasTag("Blocking") then
	--		character:SetAttribute("VanishingKickStomp", nil)
	--		print("niled vanishKick")
	--		return Tool, false
	--	end
	--end
	local abilityModule = cachedCharacters[characterName]
	if not abilityModule then
		return
	end

	local actionName = isReleased and "Release" or "Start"

	local slotNames = { "FirstAbilityMode", "SecondAbilityMode", "ThirdAbilityMode", "FourthAbilityMode" }
	local targetAbility = abilityModule[slotNames[Slot]]

	if typeof(ArgumentData) ~= "table" then
		ArgumentData = {}
	end

	ArgumentData.IsReleased = isReleased
	if targetAbility then
		targetAbility(character, cooldown, damage, ArgumentData)
	end

	--print("Processed " .. actionName .. " for slot: " .. Slot)
end)
