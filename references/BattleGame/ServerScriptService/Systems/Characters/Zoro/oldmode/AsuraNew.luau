local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayersService = game:GetService("Players")


local ServerModules = ServerStorage.SBGModules

local ReplicatedModules = ReplicatedStorage.Modules
local RemotesContainer = ReplicatedStorage.Remotes


local StunHandler = require(ServerModules.StunHandler)
local HitboxHandler = require(ServerModules.HitboxHandler)
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local NewKnockback = require(ServerModules.BodymoverService)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
--local WeaponsHandler = require(ServerModules.WeaponsHandler)
local CollisionsModule = require(ServerModules.CollisionsModule)
local SoundsModule = require(ServerModules.SoundsModule)
local KnockbackModule = require(ServerModules.KnockbackModule)
local ReplicatedHitbox = require(ServerModules.ReplicatedHitboxes)
local StatesHandler = require(ServerModules.StatesHandler)
--local DestructionHandler = require(ServerStorage.Modules.DestructionHandler)


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ServerStorage.Assets.Animations.Zoro.Moveset.ModeMoveSet["Asura"]


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set

local assets = ReplicatedStorage.Assets

local weaponModels = assets.Weapons

-- NEW: server-side dragon rig. Move ONLY the "DragonNew" model out of the client
-- script's Dragon folder into ReplicatedStorage.Assets.VFX.Zoro.DragonNew
-- (create the VFX/Zoro folders if they don't exist). Brand/Elden/Roar/Wind
-- meshes etc. stay under the client script — only the rig moves.
--local DragonRig = assets.VFX.Zoro.DragonNew
local DragonRig = ServerStorage.Assets.Dragon.DragonNew

local rad = math.rad

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = { workspace.World.Map }
MapRayParams.RespectCanCollide = true
MapRayParams.IgnoreWater = true

local function removeFace(part: BasePart)
	for _, d in part:GetChildren() do
		if d:IsA("Decal") then   -- catches "face" and any custom face
			d:Destroy()
		end
	end
end
-- Clone whatever is welded to the real head/fakehead (hair, hats — Accessory or bare part)
-- onto a cloned head. Weld-based so it works even if the game stripped the Accessory wrapper.
local function cloneHeadAccessories(character: Model, sourceHead: BasePart, targetHead: BasePart)
	local clones = {}
	local fakeHead = character:FindFirstChild("FakeHead")
	local function isHeadPart(p)
		return p == sourceHead or (fakeHead and p == fakeHead)
	end
	local bodyParts = {
		["Head"] = true, ["FakeHead"] = true, ["Torso"] = true, ["HumanoidRootPart"] = true,
		["Left Arm"] = true, ["Right Arm"] = true, ["Left Leg"] = true, ["Right Leg"] = true,
	}
	local seen = {}

	for _, w in character:GetDescendants() do
		if w:IsA("Weld") or w:IsA("Motor6D") or w:IsA("WeldConstraint") then
			local p0, p1 = w.Part0, w.Part1
			local acc
			if isHeadPart(p0) and p1 and not isHeadPart(p1) then
				acc = p1
			elseif isHeadPart(p1) and p0 and not isHeadPart(p0) then
				acc = p0
			end
			if acc and acc:IsA("BasePart") and not bodyParts[acc.Name] and not seen[acc] then
				seen[acc] = true
				-- bake offset relative to the REAL head
				local offset = sourceHead.CFrame:ToObjectSpace(acc.CFrame)
				local newPart = acc:Clone()
				for _, d in newPart:GetChildren() do
					if d:IsA("Attachment") or d:IsA("Weld") or d:IsA("Motor6D") or d:IsA("WeldConstraint") then
						d:Destroy()
					end
				end
				newPart.Name = "HeadAccessoryClone"   -- not "Handle", so "0"/"1" toggle it
				newPart.Anchored = false
				newPart.CanCollide = false
				newPart.CanTouch = false
				newPart.CanQuery = false
				newPart.Massless = true
				newPart.CollisionGroup = "NoCol"
				newPart.Parent = character

				local nw = Instance.new("Weld")
				nw.Part0 = targetHead
				nw.Part1 = newPart
				nw.C0 = offset
				nw.Parent = newPart

				table.insert(clones, newPart)
			end
		end
	end

	print("cloneHeadAccessories:", #clones, "onto", targetHead.Name)
	return clones
end

local function createGhostRig(character: Model): Model
	local model = Instance.new("Model")
	model.Name = "AsuraClothedRig"

	local humanoid = Instance.new("Humanoid")
	humanoid.RequiresNeck = false                                    -- don't die from having no head
	humanoid.EvaluateStateMachine = false                           -- keep it completely inert
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.Parent = model

	local shirtSource = character:FindFirstChildOfClass("Shirt")
	if shirtSource then
		shirtSource:Clone().Parent = model
	end

	model.Parent = workspace                                          -- must be in workspace to render
	return model
end

-- Clones a visible arm that KEEPS its real body-part name (so the engine clothes it),
-- then welds it to the invisible animated bone so it follows the animation.
local function addClothedLimb(ghostModel: Model, sourceLimb: BasePart, bone: BasePart, limbName: string)
	local limb = sourceLimb:Clone()
	limb.Name = limbName            -- MUST stay "Right Arm"/"Left Arm"
	limb.Anchored = false           -- it follows the bone via the weld, not anchored
	limb.Massless = true
	limb.CanCollide = false
	limb.CanTouch = false
	limb.CanQuery = false
	limb.CollisionGroup = "NoCol"
	limb.Parent = ghostModel

	local weld = Instance.new("Weld")
	weld.Part0 = bone               -- invisible animated bone in the main rig
	weld.Part1 = limb
	weld.C0 = CFrame.new()          -- identical clones → perfect overlap
	weld.Parent = limb              -- parented to the limb so it dies with the ghost model

	return limb
end

local function cloneExtraLimbs(character: Model)
	--Duplicate Arms and Heads
	local rightArm = character:FindFirstChild("Right Arm")
	local leftArm = character:FindFirstChild("Left Arm")
	local head = character:FindFirstChild("Head")

	local rightArmC1:BasePart = rightArm:Clone()
	rightArmC1.Name = "Right ArmC1"
	rightArmC1.Parent = character
	rightArmC1.Transparency = 1
	rightArmC1.CanCollide = false
	rightArmC1.CanTouch = false
	rightArmC1.CanQuery = false
	rightArmC1.CollisionGroup = "NoCol"
	--rightArmC1:SetAttribute("NoSwapCollisions", true)

	-- Clone the Motor6D from torso and point it to the new arm
	local rightShoulderC1 = character.Torso["Right Shoulder"]:Clone()
	rightShoulderC1.Name = "Right ArmC1"
	rightShoulderC1.Part0 = character.Torso
	rightShoulderC1.Part1 = rightArmC1
	rightShoulderC1.Parent = character.Torso

	local leftArmC1 = leftArm:Clone()
	leftArmC1.Name = "Left ArmC1"
	leftArmC1.Parent = character
	leftArmC1.Transparency = 1
	leftArmC1.CanCollide = false
	leftArmC1.CanTouch = false
	leftArmC1.CanQuery = false
	leftArmC1.CollisionGroup = "NoCol"
	--leftArmC1:SetAttribute("NoSwapCollisions", true)

	local leftShoulderC1 = character.Torso["Left Shoulder"]:Clone()
	leftShoulderC1.Name = "Left ArmC1"
	leftShoulderC1.Part0 = character.Torso
	leftShoulderC1.Part1 = leftArmC1
	leftShoulderC1.Parent = character.Torso

	local headC1 = head:Clone()
	headC1.Name = "HeadC1"
	headC1.Parent = character
	headC1.Transparency = 0
	headC1.CanCollide = false
	headC1.CanTouch = false
	headC1.CanQuery = false
	headC1.CollisionGroup = "NoCol"
	--headC1:SetAttribute("NoSwapCollisions", true)

	local neckC1 = character.Torso["Neck"]:Clone()
	neckC1.Name = "HeadC1"
	neckC1.Part0 = character.Torso
	neckC1.Part1 = headC1
	neckC1.Parent = character.Torso
	local existingWeldC1 = headC1:FindFirstChildOfClass("Weld")
	if existingWeldC1 then existingWeldC1:Destroy() end
	removeFace(headC1)

	print("headC1 name:", headC1.Name)
	for _, v in ipairs(headC1:GetChildren()) do
		print(v.Name, v.ClassName)
	end


	-- Repeat the same for C2
	local rightArmC2 = rightArm:Clone()
	rightArmC2.Name = "Right ArmC2"
	rightArmC2.Parent = character
	rightArmC2.Transparency = 1
	rightArmC2.CanCollide = false
	rightArmC2.CanTouch = false
	rightArmC2.CanQuery = false
	rightArmC2.CollisionGroup = "NoCol"
	--rightArmC2:SetAttribute("NoSwapCollisions", true)

	local rightShoulderC2 = character.Torso["Right Shoulder"]:Clone()
	rightShoulderC2.Name = "Right ArmC2"
	rightShoulderC2.Part0 = character.Torso
	rightShoulderC2.Part1 = rightArmC2
	rightShoulderC2.Parent = character.Torso

	local leftArmC2 = leftArm:Clone()
	leftArmC2.Name = "Left ArmC2"
	leftArmC2.Parent = character
	leftArmC2.Transparency = 1
	leftArmC2.CanCollide = false
	leftArmC2.CanTouch = false
	leftArmC2.CanQuery = false
	leftArmC2.CollisionGroup = "NoCol"
	--leftArmC2:SetAttribute("NoSwapCollisions", true)

	local leftShoulderC2 = character.Torso["Left Shoulder"]:Clone()
	leftShoulderC2.Name = "Left ArmC2"
	leftShoulderC2.Part0 = character.Torso
	leftShoulderC2.Part1 = leftArmC2
	leftShoulderC2.Parent = character.Torso

	local headC2 = head:Clone()
	headC2.Name = "HeadC2"
	headC2.Parent = character
	headC2.Transparency = 0
	headC2.CanCollide = false
	headC2.CanTouch = false
	headC2.CanQuery = false
	headC2.CollisionGroup = "NoCol"
	--headC2:SetAttribute("NoSwapCollisions", true)

	local neckC2 = character.Torso["Neck"]:Clone()
	neckC2.Name = "HeadC2"
	neckC2.Part0 = character.Torso
	neckC2.Part1 = headC2
	neckC2.Parent = character.Torso
	local existingWeldC2 = headC2:FindFirstChildOfClass("Weld")
	if existingWeldC2 then existingWeldC2:Destroy() end
	removeFace(headC2)

	local ghostC1 = createGhostRig(character)
	addClothedLimb(ghostC1, rightArm, rightArmC1, "Right Arm")
	addClothedLimb(ghostC1, leftArm,  leftArmC1,  "Left Arm")

	local ghostC2 = createGhostRig(character)
	addClothedLimb(ghostC2, rightArm, rightArmC2, "Right Arm")
	addClothedLimb(ghostC2, leftArm,  leftArmC2,  "Left Arm")


	-- Clone sword models for C1
	local AllSwordsModelC1 = weaponModels.Zoro.ZoroSwords:Clone()
	AllSwordsModelC1.Name = "ZoroSwordsC1"
	AllSwordsModelC1.Parent = character
	--for _, part in ipairs(AllSwordsModelC1:GetDescendants()) do
	--	if part:IsA("BasePart") or part:IsA("MeshPart") then part.Transparency = 1 end
	--end

	for _, part in ipairs(AllSwordsModelC1:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.Massless = true
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.CollisionGroup = "NoCol"
		end
	end

	local Sword1C1 = weaponModels.Zoro["Handle"]:Clone()
	Sword1C1.Name = "Handle"
	Sword1C1.Part0 = rightArmC1
	Sword1C1.Part1 = AllSwordsModelC1.Shisui.Sword1
	Sword1C1.Parent = AllSwordsModelC1.Shisui
	Sword1C1.C0 = CFrame.new(-0.069, -0.995, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

	local Sword2C1 = weaponModels.Zoro["Handle"]:Clone()
	Sword2C1.Name = "Handle"
	Sword2C1.Part0 = leftArmC1
	Sword2C1.Part1 = AllSwordsModelC1["Sandai Kitetsu"].Sword2
	Sword2C1.Parent = AllSwordsModelC1["Sandai Kitetsu"]
	Sword2C1.C0 = CFrame.new(0.001, -0.993, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

	local Sword3C1 = weaponModels.Zoro["Handle"]:Clone()
	Sword3C1.Name = "Handle"
	Sword3C1.Part0 = headC1
	Sword3C1.Part1 = AllSwordsModelC1["Wado Ichimonji"].Handle
	Sword3C1.Parent = AllSwordsModelC1["Wado Ichimonji"]
	Sword3C1.C0 = CFrame.new(-0.001, -0.233, -0.721) * CFrame.Angles(0, math.rad(-90), math.rad(90))

	-- Clone sword models for C2
	local AllSwordsModelC2 = weaponModels.Zoro.ZoroSwords:Clone()
	AllSwordsModelC2.Name = "ZoroSwordsC2"
	AllSwordsModelC2.Parent = character
	--for _, part in ipairs(AllSwordsModelC2:GetDescendants()) do
	--	if part:IsA("BasePart") or part:IsA("MeshPart") then part.Transparency = 1 end
	--end
	for _, part in ipairs(AllSwordsModelC2:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.Massless = true
			part.CanCollide = false
			part.CanTouch = false
			part.CanQuery = false
			part.CollisionGroup = "NoCol"
		end
	end

	local Sword1C2 = weaponModels.Zoro["Handle"]:Clone()
	Sword1C2.Name = "Handle"
	Sword1C2.Part0 = rightArmC2
	Sword1C2.Part1 = AllSwordsModelC2.Shisui.Sword1
	Sword1C2.Parent = AllSwordsModelC2.Shisui
	Sword1C2.C0 = CFrame.new(-0.069, -0.995, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

	local Sword2C2 = weaponModels.Zoro["Handle"]:Clone()
	Sword2C2.Name = "Handle"
	Sword2C2.Part0 = leftArmC2
	Sword2C2.Part1 = AllSwordsModelC2["Sandai Kitetsu"].Sword2
	Sword2C2.Parent = AllSwordsModelC2["Sandai Kitetsu"]
	Sword2C2.C0 = CFrame.new(0.001, -0.993, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

	local Sword3C2 = weaponModels.Zoro["Handle"]:Clone()
	Sword3C2.Name = "Handle"
	Sword3C2.Part0 = headC2
	Sword3C2.Part1 = AllSwordsModelC2["Wado Ichimonji"].Handle
	Sword3C2.Parent = AllSwordsModelC2["Wado Ichimonji"]
	Sword3C2.C0 = CFrame.new(-0.001, -0.233, -0.721) * CFrame.Angles(0, math.rad(-90), math.rad(90))

	local headAccC1 = cloneHeadAccessories(character, head, headC1)
	local headAccC2 = cloneHeadAccessories(character, head, headC2)

	return {
		rightArmC1, leftArmC1, headC1,
		rightShoulderC1, leftShoulderC1, neckC1,
		rightArmC2, leftArmC2, headC2,
		rightShoulderC2, leftShoulderC2, neckC2,
		AllSwordsModelC1, AllSwordsModelC2,
		ghostC1, ghostC2,                 -- clothed follower rigs
		table.unpack(headAccC1), table.unpack(headAccC2),  -- cloned head accessories
	}

end



return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		local Torso: BasePart = Character:FindFirstChild("Torso")

		if Character:HasTag("Stunned") then return end
		if Player:GetAttribute("ModeAbilityFourCooldown") then return end
		if Character:GetAttribute("ZoroFourthAbility") then return end

		Player:SetAttribute("ModeAbilityFourCooldown", true)
		Character:SetAttribute("ZoroFourthAbility", true)

		local CooldownTime = 40
		if Player.Commands.NoCooldown.Value == true then
			CooldownTime = .5
		end

		local Janitor = Trove.new()

		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)

		local extraLimbs = cloneExtraLimbs(Character)
		local function destroyExtraLimbs()
			for _, inst in extraLimbs do
				if inst then
					inst:Destroy()
				end
			end
			table.clear(extraLimbs)
		end


		--local initialAnim = NewAnimLocation.Miss
		local initialAnim = NewAnimLocation.Miss

		local StartAnimation = initialAnim
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}

		local Assets = {}
		local Container = {}

		local Hit = false

		-- NEW: server-owned dragon state (spawned on hit, follows the anim, drives destruction)
		local dragonModel: Model? = nil
		local dragonMover: BasePart? = nil
		local dragonMoverConn: RBXScriptConnection? = nil
		local dragonDestruction = nil

		local function cleanupDragon()
			if dragonMoverConn then
				dragonMoverConn:Disconnect()
				dragonMoverConn = nil
			end
			if dragonDestruction then
				pcall(function() dragonDestruction.Stop() end)
				dragonDestruction = nil
			end
			if dragonModel then
				Debris:AddItem(dragonModel, 0.5)
				dragonModel = nil
			end
			if dragonMover then
				Debris:AddItem(dragonMover, 0.5)
				dragonMover = nil
			end
		end


		--StartEvents["transparent"] = StartTrack:GetMarkerReachedSignal("transparent"):Once(function()
		--	RemotesContainer.ClientEffects:FireAllClients("Asura", {
		--		Attacker  = Character,
		--		SkillType = "untransparent",            
		--	})
		--end)

		StartEvents["tp"] = StartTrack:GetMarkerReachedSignal("tp"):Connect(function()
			RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
				Attacker  = Character,
				SkillType = "tp",
			})
			SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.tp, HumRP)
		end)



		local Hitbox = HitboxHandler.new()
		StartEvents["move"] = StartTrack:GetMarkerReachedSignal("move"):Once(function()
			RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
				Attacker  = Character,
				SkillType = "move",            
			})

			Hitbox.Instance = HumRP
			Hitbox.Size = Vector3.new(15, 10, 30)

			Hitbox.Offset = CFrame.new(0, 0, -18)

			Hitbox.Ignore = { Character }
			Hitbox.Visualize = false
			Hitbox.onTouch = function(EnemyCharacter)
				Hitbox:Destroy()
				ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })


				local EnemyPlayer = PlayersService:GetPlayerFromCharacter(EnemyCharacter)
				local EnemyHumanoid: Humanoid = EnemyCharacter.Humanoid
				local EnemyHumRP: BasePart = EnemyCharacter.HumanoidRootPart
				local EnemyTorso: BasePart = EnemyCharacter:FindFirstChild("Torso")






				--if Hit == true or iFramesService:HasiFrame(EnemyCharacter, Tool.Name)  then return end
				if Hit == true or iFramesService:HasiFrame(EnemyCharacter, 2)  then return end

				local HitInfo = DamageHandler:TakeDamage(Character, EnemyHumanoid, 1.5, nil, nil, false, EnemyCharacter:HasTag('DEATH') and true or false, true, true, false, nil, 15)
				if HitInfo.Countered then return end
				Hit = true


				if EnemyCharacter:HasTag("Ragdolled") then
					RagdollHandler.cancelRagdoll(EnemyHumanoid, nil, false, nil, nil, true)
				end

				EnemyCharacter:AddTag("CantRotate")
				Character:AddTag("CantRotate")


				iFramesService:AddAlliFrames(Character)
				iFramesService:AddAlliFrames(EnemyCharacter)

				CollisionsModule:SetCollisionGroup(Character, "Phasing")
				CollisionsModule:SetCollisionGroup(EnemyCharacter, "Phasing")

				local EnemyStun = StunHandler:Stun(EnemyCharacter, nil, true, 0, 0, true)




				local myLook = HumRP.CFrame.LookVector
				local targetPos = EnemyHumRP.Position
				EnemyHumRP.CFrame = CFrame.lookAt(targetPos, targetPos + myLook)

				--local Weld = WeldSystem.new(HumRP, EnemyHumRP, CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0), -1)
				--local Weld = WeldSystem.new(EnemyHumRP, HumRP, CFrame.new(0, 0, 0) * CFrame.Angles(0, math.pi, 0), -1)
				local Weld = WeldSystem.new(EnemyHumRP, HumRP, CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0), -1)
				local UserAnimation = NewAnimLocation.UserNew
				local VictimAnimation = NewAnimLocation.VictimNew

				local VictimTrack = AnimationService:getAnimationTrack(EnemyCharacter, VictimAnimation)
				local UserTrack, UserEvents = AnimationService:getAnimationTrack(Character, UserAnimation)

				local destructionHandlePlayer
				local destructionHandleEnemy

				--destructionHandlePlayer = DestructionHandler.attach(Torso, {
				--	Size = Vector3.new(10, 10, 10),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 15,
				--	Player = Player,
				--	MinimumSize = 5,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	Phasing = false,
				--	ExtrapolateWithPing = true,
				--	Shake = true,
				--	IgnoreFloor = true,
				--	Visualize = false,

				--	VoxelVelocity = Torso.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
				--})

				--destructionHandleEnemy = DestructionHandler.attach(EnemyTorso, {
				--	Size = Vector3.new(10, 10, 10),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 15,
				--	Player = EnemyPlayer,
				--	MinimumSize = 5,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	Phasing = false,
				--	ExtrapolateWithPing = true,
				--	Shake = true,
				--	IgnoreFloor = true,
				--	Visualize = false,

				--	VoxelVelocity = EnemyTorso.CFrame.LookVector * 30 + Vector3.new(0, 10, 0),
				--})

				RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
					Attacker  = Character,
					SkillType = "OniGiri", 
					targetPosition = targetPos,
					attackerLook = HumRP.CFrame.LookVector  -- add this
				})

				SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Dash, HumRP)
				SoundHandler:AddSound(MoveSounds.Zoro.Moves.OniGiri.Hit, HumRP)

				UserEvents["1"] = UserTrack:GetMarkerReachedSignal("1"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "1",            
					})
				end)

				UserEvents["0"] = UserTrack:GetMarkerReachedSignal("0"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "0",            
					})
				end)
				--table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("tp"):Connect(function()
				--	RemotesContainer.ClientEffects:FireAllClients("Asura", {
				--		Attacker  = Character,
				--		SkillType = "tp", 
				--		targetPosition = targetPos
				--	})
				--end))
				UserEvents["tp"] = UserTrack:GetMarkerReachedSignal("tp"):Connect(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "tp", 
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.tp, HumRP)

				end)

				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash1"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "slash1", 
						targetPosition = targetPos,
						enemyChar = EnemyCharacter
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit3, HumRP)

				end))
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash2"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "slash2", 
						--targetPosition = targetPos
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit4, HumRP)

				end))
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash3"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "slash3", 
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit3, HumRP)

					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "DragonStart", 
					})
				end))
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash4"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "slash4", 
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit4, HumRP)

				end))
				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash5"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "slash5", 
						targetPosition = targetPos
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit3, HumRP)

				end))
				for i = 6, 16 do
					table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("slash"..i):Once(function()
						RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
							Attacker  = Character,
							SkillType = "slash"..i,
							targetPosition = targetPos
						})
						SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.NewHits.Hit4, HumRP)

					end))
				end

				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("spin"):Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "spin", 
						targetPosition = targetPos
					})
					SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.Spin, HumRP)


				end))

				table.insert(UserEvents, UserTrack:GetMarkerReachedSignal("knockback"):Once(function()
					--local results = DestructionHandler.destroy(Vector3.new(40,40,40), HumRP.CFrame, Enum.PartType.Ball, {
					--	MinimumSize = 5,
					--	TimeToReset = 30,
					--	Player = Player,
					--	VoxelDestroyChance = 1,
					--	FlingDestroyChance = 1,
					--	--SkipCustomizations = true,
					--	--CaptureSnapshots = true,   -- new
					--	--AbsorbSpecials = true,
					--	Visualize = false
					--})
					if Weld then
						pcall(function() 
							Weld:Stop() 
						end)
						Weld = nil
					end
					DamageHandler:TakeDamage(Character, EnemyHumanoid, 15, nil, nil, false, false, true, true, true, nil, nil)

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(1, 100000, 1), Velocity = HumRP.CFrame.UpVector * 75 })
					task.delay(.05, function()
						RagdollHandler.ragdoll(EnemyHumanoid, 2)

					end)
					-- cleanup AFTER
					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					EnemyCharacter:RemoveTag("CantRotate")

					for RockValue = 1, 3 do
						local Position = {
							Seed = math.random(1, 8) + RockValue,
							start = HumRP.Position + Vector3.new(0, 0.1, 0),
							["end"] = Vector3.new(0, -80, 0),
							amount = 6 + RockValue / 2,
							nosound = true,
							nosmoke = RockValue > 2
						}
						local minusValue = RockValue <= 2 and { minus = 0 } or false
						Position.stronger = minusValue
						Position.sizemult = 0.55 * RockValue
						Position.size = 0.85 * RockValue
						ReplicateEffects_Set:FireAllClients('Ground Crater', Position)
					end

				end))



				VictimTrack.Stopped:Once(function()
					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end


					StunHandler:Unstun(EnemyCharacter, EnemyStun)
					iFramesService:RemoveAlliFrames(EnemyCharacter)
					EnemyCharacter:RemoveTag("CantRotate")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")

					if destructionHandleEnemy then
						destructionHandleEnemy.Stop()
						destructionHandleEnemy = nil
					end
				end)

				UserTrack.Stopped:Once(function()
					RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
						Attacker  = Character,
						SkillType = "0",
					})

					if Weld then
						pcall(function()
							Weld:Stop()
						end)
						Weld = nil
					end
					--RemotesContainer.ClientEffects:FireAllClients("Asura", {
					--	Attacker  = Character,
					--	SkillType = "transparent",            
					--})

					StunHandler:Unstun(Character, Stun)
					iFramesService:RemoveAlliFrames(Character)
					CollisionsModule:SetCollisionGroup(Character, "Players")
					Character:RemoveTag("CantRotate")
					CollisionsModule:SetCollisionGroup(EnemyCharacter, "Players")

					destroyExtraLimbs()

					Character:SetAttribute("ZoroFourthAbility", nil)

					Player:SetAttribute("ModeAbilityFourCooldown", CooldownTime)
					task.delay(CooldownTime, function()
						if Player then
							Player:SetAttribute("ModeAbilityFourCooldown", false)
						end
					end)

					if destructionHandlePlayer then
						destructionHandlePlayer.Stop()
						destructionHandlePlayer = nil
					end
				end)


				AnimationService:stopAll(Character)
				AnimationService:stopAll(EnemyCharacter)


				AnimationService:playAnimation(Character, UserAnimation)
				AnimationService:playAnimation(EnemyCharacter, VictimAnimation)


				-- ============================================================
				-- NEW: spawn the dragon ON THE SERVER so destruction can follow it.
				-- The server owns the rig + animation (cheap to replicate); clients
				-- keep owning all the Brand/Elden/Roar/wind VFX that dress it up.
				-- ============================================================
				dragonModel = DragonRig:Clone()
				for _, p in dragonModel:GetDescendants() do
					if p:IsA("BasePart") then
						p.Transparency = 1
						p.Anchored = true
						p.CanCollide = false
						p.CanTouch = false
						p.CanQuery = false
					end
				end
				dragonModel:PivotTo(HumRP.CFrame)
				task.delay(1, function()
					dragonModel:PivotTo(HumRP.CFrame)

				end)
				dragonModel.Parent = workspace.World.Visuals

				local dragonTrack = dragonModel.AnimationController:LoadAnimation(dragonModel.DragonAnim)
				dragonTrack:Play()

				-- invisible mover that traces the animated head bone; destruction follows this
				dragonMover = Instance.new("Part")
				dragonMover.Name = "DragonDestructionMover"
				dragonMover.Size = Vector3.one
				dragonMover.Transparency = 1
				dragonMover.Anchored = true
				dragonMover.CanCollide = false
				dragonMover.CanTouch = false
				dragonMover.CanQuery = false
				dragonMover.CFrame = HumRP.CFrame
				dragonMover.Parent = workspace.World.Visuals

				local headBone = dragonModel.PrimaryPart.Bone.UpperMouth  -- same bone the client VFX tracks
				dragonMoverConn = RunService.Heartbeat:Connect(function()
					-- TransformedWorldCFrame includes the animation Transform on the server.
					-- If the destruction sphere ends up offset from the visual dragon,
					-- swap this to headBone.WorldCFrame.
					dragonMover.CFrame = headBone.TransformedWorldCFrame
				end)

				--dragonDestruction = DestructionHandler.attach(dragonMover, {
				--	Size = Vector3.new(18, 18, 18),
				--	Shape = Enum.PartType.Ball,
				--	MaxDuration = 12,
				--	Player = Player,
				--	MinimumSize = 5,
				--	VoxelDestroyChance = .7,
				--	FlingDestroyChance = 1,
				--	Phasing = false,
				--	Shake = true,
				--	IgnoreFloor = false,
				--	Visualize = false,

				--	VoxelVelocity = Vector3.new(0, 15, 0),
				--})

				dragonTrack.Stopped:Once(function()
					cleanupDragon()
				end)
				-- safety net in case the track never fires Stopped
				task.delay(15, cleanupDragon)

				-- hand the replicated dragon instance to every client to dress up
				RemotesContainer.ClientEffects:FireAllClients("AsuraNew", {
					Attacker  = Character,
					SkillType = "DragonAnim", 
					Dragon    = dragonModel,
					targetPosition = targetPos
				})

				Weld:Start(nil, EnemyPlayer)

				shared.fireTo(ReplicateEffects_Set, { Player, EnemyPlayer }, { "ShakeCamera", { Intensity = 4, Last = 3 } })

			end


			Hitbox:Start()

		end)	

		StartTrack.Stopped:Once(function()

			if Hitbox then
				pcall(function()
					Hitbox:Destroy()
				end)
				Hitbox = nil
			end

			for _,v in StartEvents do
				v:Disconnect()
			end


			if Hit then return end
			--RemotesContainer.ClientEffects:FireAllClients("Asura", {
			--	Attacker  = Character,
			--	SkillType = "transparent",            
			--})
			destroyExtraLimbs()

			StunHandler:Unstun(Character, Stun)
			Character:SetAttribute("ZoroFourthAbility", nil)

			Player:SetAttribute("ModeAbilityFourCooldown", CooldownTime)
			task.delay(CooldownTime, function()
				if Player then
					Player:SetAttribute("ModeAbilityFourCooldown", false)
				end
			end)
		end)

		ReplicateEffects_Set:FireAllClients("clearVelocities", { Char = Character })

		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.Start, HumRP)
		SoundHandler:AddSound(MoveSounds.Zoro.Moves.Asura.random, HumRP)
		--temp
		--RemotesContainer.ClientEffects:FireAllClients("TigerHunt", {Attacker = Character, SkillType =  "start",})
	end
}