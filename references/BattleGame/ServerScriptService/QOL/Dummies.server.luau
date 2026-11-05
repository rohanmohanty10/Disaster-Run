--Services
local Players = game:GetService('Players')
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local Workspace = game:GetService('Workspace')
local RNS = game:GetService('RunService')
local CollectionService = game:GetService("CollectionService")



--Bindables
local Bindables = SvSt.Bindables

local SpnDmy = Bindables.SpawnDummy



--Server Modules
local SvModules = SvSt.SBGModules

local AnimationService = require(SvModules.AnimationService)



--Remotes
local RemotesContainer = RS.Remotes


local ReplicateEffects_Set = RemotesContainer.Replicate.Set



--Variables
local LiveFolder = Workspace.World.Live
local RESPAWN_DELAY = 6
--local Assets = RS.Assets



--Behaviours
-- Dummy behaviour (Attack/Block/Counter) runs from THIS script rather than from a
-- Script parented inside the dummy. A dummy-parented script is destroyed with the
-- dummy, which tears down every thread and connection it created -- including the
-- machinery StunHandler builds to release stuns the dummy applied to PLAYERS. That is
-- what left victims permanently stunned on ClearDummies.
--
-- The trade: these loops now OUTLIVE the dummy, so every behaviour hands back a
-- cleanup function and stopBehaviour() must run on Destroying.
local BEHAVIOUR_NAMES = { "AttackScript", "BlockScript", "CounterScript" }

local Behaviours = {} -- [Dummy] = cleanup function

local function startBehaviour(Dummy: Model, ScriptName: string)
	local module = script.Scripts:FindFirstChild(ScriptName)
	if not module or not module:IsA("ModuleScript") then
		warn("Dummy behaviour missing or not a ModuleScript:", ScriptName)
		return
	end

	local ok, result = pcall(function()
		return require(module).start(Dummy)
	end)

	if not ok then
		warn("Dummy behaviour errored on start:", ScriptName, result)
		return
	end

	Behaviours[Dummy] = result -- may be nil if the behaviour declined to start
	Dummy:SetAttribute(ScriptName, true)
end

local function stopBehaviour(Dummy: Model)
	local cleanup = Behaviours[Dummy]
	Behaviours[Dummy] = nil
	if cleanup then
		local ok, err = pcall(cleanup)
		if not ok then
			warn("Dummy behaviour errored on cleanup:", err)
		end
	end
end

-- Which behaviour a dummy was spawned with, so a respawn keeps it
local function behaviourOf(Character: Model): string?
	for _, name in BEHAVIOUR_NAMES do
		if Character:GetAttribute(name) then
			return name
		end
	end
	return nil
end

--Functions
function HumanoidDied(Character: Model, InitialHp: number)
	if Character:HasTag('Destroying') then return end
	Character:AddTag("Destroying")

	local Humanoid: Humanoid = Character:FindFirstChild('Humanoid')
	if not Humanoid then
		return
	end

	if not Character:HasTag('DontDoDieFunction') then
		Character:AddTag('CantRagdollCancel')
		require(SvModules.StunHandler):Stun(Character, 5)
		require(SvModules.RagdollHandler).ragdoll(Humanoid)
	end

	--if not Character:HasTag('DontDoDieFunction') then
	--	if Humanoid.BreakJointsOnDeath then
	--		for _, v in Character:GetDescendants() do
	--			if v:IsA("Motor6D") or v:IsA("BallSocketConstraint") then
	--				v:Destroy()
	--			elseif v:IsA("Part") or v:IsA("BasePart") or v:IsA("MeshPart") then
	--				v.AssemblyLinearVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
	--				v.AssemblyAngularVelocity = Vector3.new(math.random(-15, 15), math.random(-15, 15), math.random(-15, 15))
	--			end
	--		end

	--		require(SvModules.StunHandler):Stun(Character, 5)
	--	else
	--		Character:AddTag('CantRagdollCancel')

	--		require(SvModules.RagdollHandler).ragdoll(Humanoid)
	--	end
	--end


	require(SvModules.iFramesService):RemoveAlliFrames(Character)
	workspace:SetAttribute("DummyDiedOnce", true)

	-- Covers CounterScript too; the old code only looked at Attack/Block, so a counter
	-- dummy came back without its behaviour.
	local behaviourName = behaviourOf(Character)
	local canRespawn = not Character:GetAttribute("RespawnDisabled")

	-- Single timer instead of a per-frame Heartbeat poll. This lives in a persistent
	-- script, which is why it survives to fire at all.
	task.delay(RESPAWN_DELAY, function()
		if not Character or not Character.Parent then return end

		Character:Destroy() -- Destroying fires stopBehaviour

		if canRespawn then
			-- Pass `true` so the respawned dummy can also respawn (the old code
			-- omitted this, so a dummy only ever respawned once).
			spawnDummy(nil, InitialHp, behaviourName, true)
		end
	end)

	--local respawnConnection
	--local respawnStartTime = os.clock()
	--local respawnDelay = 6

	--local Attacking = Character:GetAttribute("AttackScript") and "AttackScript"
	--local Blocking = Character:GetAttribute("BlockScript") and "BlockScript"

	--respawnConnection = RNS.Heartbeat:Connect(function(deltaTime)
	--	if Character then
	--		if not Character.Parent or Character ~= Character then 
	--			respawnConnection:Disconnect()
	--			return 
	--		end 
	--	end

	--	if not Character:GetAttribute("RespawnDisabled") then
	--		if (os.clock() - respawnStartTime) >= respawnDelay then
	--			Character:Destroy()
	--			spawnDummy(nil, InitialHp, Blocking or Attacking)

	--			respawnConnection:Disconnect()
	--			return
	--		end
	--	else
	--		--respawnStartTime = os.clock()
	--		--if respawnDelay ~= 2.5 then
	--		--	respawnDelay = 2.5
	--		--	return
	--		--end
	--		if (os.clock() - respawnStartTime) >= respawnDelay then
	--			Character:Destroy()
	--			--spawnDummy(nil, InitialHp, Blocking or Attacking)

	--			respawnConnection:Disconnect()
	--			return
	--		end
	--	end
	--end)
end

function spawnDummy(CF: CFrame, InitialHp: number, ScriptName: string, CanRespawn)
	local dummyName = "Weakest Dummy"
	local existingDummies = 0
	for _,v in workspace.World.Live:GetChildren() do
		if v:FindFirstChild("Dummy") then
			existingDummies += 1
		end
	end

	local DidDieFunction = false
	local Dummy = script["Weakest Dummy"]:Clone()
	local HumRP = Dummy.HumanoidRootPart
	local Torso = Dummy.Torso
	local Humanoid = Dummy.Humanoid
	Humanoid.BreakJointsOnDeath = false

	if existingDummies > 0 then
		dummyName = "Weakest Dummy " .. tostring(existingDummies)
		Humanoid.DisplayName = "Weakest Dummy"
	end

	Dummy.Name = dummyName
	Dummy.Parent = LiveFolder
	CollectionService:AddTag(Dummy, "Character")


	task.wait()

	AnimationService:loadAnimations(Dummy)

	-- Behaviour is driven from this script now, not cloned into the dummy. Because it
	-- outlives the dummy, this teardown is mandatory -- without it the punch/block loop
	-- keeps running against a destroyed model forever.
	Dummy.Destroying:Once(function()
		stopBehaviour(Dummy)
	end)

	if ScriptName then
		startBehaviour(Dummy, ScriptName)
	end

	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming, false)
	Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing, false)

	local block
	local function AddStunIndicatorServer(character: Model)
		block = Instance.new("Part")
		block.Name = "StunIndicator"
		block.Size = Vector3.new(1,1,1)
		block.Anchored = false 
		block.CanCollide = false
		block.CanQuery = false
		block.CanTouch = false
		block.Material = Enum.Material.Neon
		block.Transparency = 0.15
		block.CastShadow = false
		block.CollisionGroup = "NoCol"
		block.Parent = Torso

		local weld = Instance.new("Weld")
		weld.Part0 = block
		weld.Part1 = Torso
		weld.C0 = CFrame.new(0, -4.5, 0)
		weld.Parent = block

		local STUNNED = Color3.fromRGB(255, 0, 0)
		local FREE    = Color3.fromRGB(0, 255, 0)

		local function refresh()
			if not block or not block.Parent then return end
			block.Color = character:HasTag("Stunned") and STUNNED or FREE
		end

		local conn = character:GetAttributeChangedSignal("Stunned"):Connect(refresh)

		block.Destroying:Once(function()
			conn:Disconnect()
		end)

		refresh()  -- initial state
	end
	AddStunIndicatorServer(Dummy)

	Dummy.Humanoid.Died:Once(function()
		if DidDieFunction == true then return end
		DidDieFunction = true

		if block then
			block:Destroy()
			block = nil
		end

		HumanoidDied(Dummy, InitialHp)
	end)

	Dummy.HumanoidRootPart:GetPropertyChangedSignal('Parent'):Connect(function()
		if DidDieFunction == true or not Dummy or not Dummy.Parent or not Dummy:FindFirstChild('HumanoidRootPart') then return end
		DidDieFunction = true

		if block then
			block:Destroy()
			block = nil
		end

		HumanoidDied(Dummy, InitialHp)
	end)

	if CF then
		Dummy:PivotTo(CF)
	else
		Dummy:PivotTo(CFrame.new(0, 3, 0))
	end

	if InitialHp then
		Dummy.Health.Enabled = false
		Humanoid.Health = InitialHp
	end

	if CanRespawn then
		Dummy:SetAttribute("RespawnDisabled", false)
	else
		Dummy:SetAttribute("RespawnDisabled", true)
	end

	task.spawn(function()
		if ScriptName then return end

		if workspace:GetAttribute("DummyDiedOnce") then
			--local DummyEmotes = require(script.DummyEmotes)
			--DummyEmotes.EmoteVariants[math.random(1, #DummyEmotes.EmoteVariants)](Dummy)
		end
	end)
end


--Events
SpnDmy.Event:Connect(function(CF: CFrame, InitialHp: number, ScriptName: string)
	--if game.PlaceId == workspace:GetAttribute("DuelsHubPlaceId") or game.PlaceId == workspace:GetAttribute("DuelsPlaceId") then return end
	--warn("spawn dummy with remote")
	spawnDummy(CF, InitialHp, ScriptName, false)
end)

-- no training dummy in the middle of the 1v1 / 2v2 arena
local IsArena = require(RS:WaitForChild("Ranked"):WaitForChild("PlaceRole")).IsArena()
if not IsArena and game.PlaceId ~= workspace:GetAttribute("DuelsHubPlaceId") and game.PlaceId ~= workspace:GetAttribute("DuelsPlaceId") then
	--warn("Spawned dummy")
	spawnDummy(CFrame.new(0, 3, 0), nil, nil, true)
end