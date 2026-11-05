-- ServerStorage > SBGModules > ItemService   (ModuleScript, server)
--
-- Usable items (Sniper, Cola Bomb, Muggy Ball, Buster Call):
--   * You hold one item at a time. M1 uses it, Backspace drops it, and it's gone when its ammo
--     runs out. While you hold one, the Character has the attribute HeldItem, and your M1 punch
--     is skipped (see the NewCombatSystem edit).
--   * The Sniper sits on a Motor6D like your animation rig. The Cola Bomb works like your trash
--     cans/barrels: it stands on the ground, M1 in front of it picks it up, you carry it over your
--     head, M1 throws it (once), and getting hit makes you drop it.
--   * Bought items come by seagull: it flies over and drops a package next to you. Opening the
--     package gives you the Sniper, or stands the Cola Bomb up for you to pick up.
-- Item numbers live in ReplicatedStorage.Modules.ItemConfig. The visuals are the "ItemEffects"
-- ClientEffects module; input is StarterPlayerScripts > ItemClient.
--
-- Required by ShopService and NewCombatSystem. Makes Remotes > Items > Use itself.

local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local ServerModules = ServerStorage.SBGModules
local DamageHandler = require(ServerModules.DamageHandler)
local RagdollHandler = require(ServerModules.RagdollHandler)
local StunHandler = require(ServerModules.StunHandler)
local AnimationService = require(ServerModules.AnimationService)
local iFramesService = require(ServerModules.iFramesService)
local DebreeService = require(ServerModules.DebreeService)
local Velocity = require(ReplicatedStorage.Modules.Velocity)
local ItemConfig = require(ReplicatedStorage.Modules.ItemConfig)
local QuestModule = ServerModules:FindFirstChild("QuestService")
local QuestService = if QuestModule then require(QuestModule) else nil -- "use an item" quests

local Remotes = ReplicatedStorage.Remotes
local ClientEffects: RemoteEvent = Remotes.ClientEffects
local ReplicateSet: RemoteEvent = Remotes.Replicate.Set
local ItemModels = ReplicatedStorage.Assets.Items
local Throwables = ServerStorage.Assets.Animations:FindFirstChild("Throwables") -- the barrel animations
local PickupAnimation: Animation? = Throwables and Throwables:FindFirstChild("Pickup")
local CarryAnimation: Animation? = Throwables and Throwables:FindFirstChild("Idle")
local ThrowAnimation: Animation? = Throwables and Throwables:FindFirstChild("Throw")

local World = workspace:WaitForChild("World")
local Live = World:WaitForChild("Live")

-- Every character: in Live itself (the Weakest Dummy) and in its folders (Live.Players, Live.Dummies)
local function LiveCharacters(): { Model }
	local Found = {}
	for _, Child in Live:GetChildren() do
		if Child:IsA("Model") then
			table.insert(Found, Child)
		elseif Child:IsA("Folder") then
			for _, Inner in Child:GetChildren() do
				if Inner:IsA("Model") then
					table.insert(Found, Inner)
				end
			end
		end
	end
	return Found
end
local Map = World:WaitForChild("Map")

local EFFECT = "ItemEffects"
local GRAB_TAG = "ItemGrab" -- items standing on the ground that M1 picks up

-- where a carried item sits on the HumanoidRootPart while being picked up (like the barrels);
-- over your head it's the item's Carry in ItemConfig
local GRAB_C0 = CFrame.new(0, -1, -3) * CFrame.Angles(math.rad(-30), 0, 0)
local GRAB_C1 = CFrame.new(0, 0.5, 0)
local CARRY_WALKSPEED = 16

local function Make(ClassName: string, Name: string, Parent: Instance): any
	local Existing = Parent:FindFirstChild(Name)
	if Existing then
		return Existing
	end
	local New = Instance.new(ClassName)
	New.Name = Name
	New.Parent = Parent
	return New
end

local ItemRemotes = Make("Folder", "Items", Remotes)
local UseRemote: RemoteEvent = Make("RemoteEvent", "Use", ItemRemotes)
local Pickups = Make("Folder", "ItemPickups", World) -- packages and items on the ground

local GroundParams = RaycastParams.new()
GroundParams.FilterType = Enum.RaycastFilterType.Include
GroundParams.FilterDescendantsInstances = { Map }

local GrabParams = OverlapParams.new()
GrabParams.FilterType = Enum.RaycastFilterType.Include
GrabParams.FilterDescendantsInstances = { Pickups }

local Rng = Random.new()

local ItemService = {}

type Held = {
	Id: string,
	Ammo: number,
	Model: Model,
	NextUse: number,
	Busy: boolean, -- picking up or throwing
	Stuns: { [Instance]: true }, -- our own stuns (carrying, picking up), which don't stop you using it
	Connections: { RBXScriptConnection },
	Weld: Weld?, -- the carry weld, for overhead items
	HoldTrack: AnimationTrack?, -- the item's HoldAnimation (ItemConfig), while it's held
}
local HeldBy: { [Model]: Held } = {} -- Character -> what it's holding

------------------------------------------------------------------------
-- Helpers
------------------------------------------------------------------------
local function Root(Model: Instance): BasePart?
	if Model:IsA("BasePart") then
		return Model
	end
	if Model:IsA("Model") then
		return Model.PrimaryPart or Model:FindFirstChildWhichIsA("BasePart", true)
	end
	return nil
end

-- A copy of an item's model, every part welded to one root
local function ItemModel(Id: string): Model?
	local Info = ItemConfig.Get(Id)
	local Template = Info and ItemModels:FindFirstChild(Info.Model)
	if not Template then
		warn("[ItemService] missing model ReplicatedStorage.Assets.Items." .. tostring(Info and Info.Model))
		return nil
	end
	local Model = Template:Clone()
	Model.Name = Id
	local Main = Root(Model)
	if not Main then
		return nil
	end
	Model.PrimaryPart = Main
	if Info.HoldScale ~= 1 then
		Model:ScaleTo(Model:GetScale() * Info.HoldScale)
	end
	for _, Part in Model:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.Anchored = false
			Part.CanCollide = false
			Part.CanQuery = false
			Part.CanTouch = false
			Part.Massless = true
			if Part ~= Main then
				local Weld = Instance.new("WeldConstraint")
				Weld.Part0 = Main
				Weld.Part1 = Part
				Weld.Parent = Part
			end
		end
	end
	return Model
end

-- anything solid counts as ground for packages and items (spawn pads and props aren't in Map)
local LandParams = RaycastParams.new()
LandParams.FilterType = Enum.RaycastFilterType.Exclude
LandParams.FilterDescendantsInstances = { Live, Pickups, World:WaitForChild("Debris"), World:WaitForChild("Visuals"), World:WaitForChild("Hitboxes"), workspace:WaitForChild("Thrown") }
LandParams.RespectCanCollide = true

local function GroundBelow(Position: Vector3): Vector3
	local Hit = workspace:Raycast(Position + Vector3.yAxis * 30, Vector3.yAxis * -300, LandParams)
	return if Hit then Hit.Position else Position - Vector3.yAxis * 3
end

-- stunned by something other than our own carry/pickup stuns
local function StunnedByOthers(Character: Model, Held: Held?): boolean
	for _, Child in Character:GetChildren() do
		if Child.Name == "Stunned" and not (Held and Held.Stuns[Child]) then
			return true
		end
	end
	return false
end

local function CanAct(Character: Model, Held: Held?): boolean
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	return Humanoid ~= nil
		and Humanoid.Health > 0
		and not Character:HasTag("Ragdolled")
		and not StunnedByOthers(Character, Held)
end

local function ShakeNear(Position: Vector3, Radius: number, Intensity: number, Last: number)
	for _, Player in Players:GetPlayers() do
		local Root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
		if Root and (Root.Position - Position).Magnitude <= Radius then
			ReplicateSet:FireClient(Player, "ShakeCamera", { Intensity = Intensity, Last = Last })
		end
	end
end

-- Damage + knockback + ragdoll, the same way the moves do it
local function HitCharacter(Attacker: Model, Enemy: Model, Damage: number, Push: Vector3, RagdollTime: number, Blockable: boolean)
	local Humanoid = Enemy:FindFirstChildOfClass("Humanoid")
	if not Humanoid or Humanoid.Health <= 0 or iFramesService:HasiFrame(Enemy, 2) then
		return
	end
	local HitInfo = DamageHandler:TakeDamage(Attacker, Humanoid, Damage, nil, nil, Blockable, false, true, true, true, "Item")
	if not HitInfo or HitInfo.Blocked or HitInfo.Countered or Humanoid.Health <= 0 then
		return
	end
	if Enemy:HasTag("Ragdolled") then
		RagdollHandler.cancelRagdoll(Humanoid, nil, false, nil, nil, true)
	end
	local Push2 = Velocity.new(Enemy)
	Push2.Settings.RemoveTime = 0.2
	Push2.Settings.MaxForce = Vector3.new(100000, 100000, 100000)
	Push2.Settings.Velocity = Push
	Push2:Fire()
	RagdollHandler.ragdoll(Humanoid, RagdollTime, false, nil, nil, nil, true)
end

local function CharacterFromPart(Part: Instance): Model?
	local Model = Part:FindFirstAncestorOfClass("Model")
	while Model and Model.Parent ~= Live and Model.Parent.Parent ~= Live do -- in Live or one of its folders
		Model = Model:FindFirstAncestorOfClass("Model")
	end
	return Model
end

------------------------------------------------------------------------
-- Holding
------------------------------------------------------------------------
local function AddStun(Character: Model, Held: Held, WalkSpeed: number): Instance?
	local Stun = StunHandler:Stun(Character, nil, true, WalkSpeed, 0, true, true) -- nil with NoStun on
	if Stun then
		Held.Stuns[Stun] = true
	end
	return Stun
end

-- StunHandler keeps one "Stunned" folder at a time (a new stun destroys the old one), so a stun
-- of ours may already be gone; only undo it if it's still there.
local function RemoveStun(Character: Model, Held: Held, Stun: Instance?)
	if Stun and Held.Stuns[Stun] then
		Held.Stuns[Stun] = nil
		if Stun.Parent then
			StunHandler:Unstun(Character, Stun :: Folder)
		end
	end
end

local function ClearHeld(Character: Model)
	local Held = HeldBy[Character]
	if not Held then
		return
	end
	HeldBy[Character] = nil
	for _, Connection in Held.Connections do
		Connection:Disconnect()
	end
	for Stun in Held.Stuns do
		RemoveStun(Character, Held, Stun)
	end
	if CarryAnimation and ItemConfig.Get(Held.Id).Overhead then
		AnimationService:stopAnimation(Character, CarryAnimation, 0.2)
	end
	if Held.HoldTrack then
		Held.HoldTrack:Stop(0.2)
		Held.HoldTrack:Destroy()
	end
	if Held.Model.Parent then
		Held.Model:Destroy()
	end
	if Character.Parent then
		Character:SetAttribute("HeldItem", nil)
		Character:SetAttribute("ItemAmmo", nil)
	end
end

local function NewHeld(Character: Model, Id: string, Ammo: number, Model: Model): Held
	local Held: Held = { Id = Id, Ammo = Ammo, Model = Model, NextUse = 0, Busy = false, Stuns = {}, Connections = {} }
	HeldBy[Character] = Held
	Character:SetAttribute("HeldItem", Id)
	Character:SetAttribute("ItemAmmo", Ammo)
	return Held
end

local MakePickup, StandItem -- defined below

-- Puts a Joint/Grip item (the Sniper) in the character's hands. Anything already held is dropped.
function ItemService.Hold(Character: Model, Id: string, Ammo: number?): boolean
	local Info = ItemConfig.Get(Id)
	local Attach = Character:FindFirstChild(if Info and Info.Joint then Info.Joint.Part0 else "Right Arm")
	if not Info or Info.Overhead or not (Attach and Attach:IsA("BasePart")) then
		return false
	end
	if HeldBy[Character] then
		ItemService.Drop(Character)
	end
	local Model = ItemModel(Id)
	if not Model then
		return false
	end
	local Joint: JointInstance
	if Info.Joint then
		Joint = Instance.new("Motor6D")
		Joint.Name = Info.Joint.Name
		Joint.C0 = Info.Joint.C0
		Joint.C1 = Info.Joint.C1
		Joint.Parent = Attach -- like the rig: the joint lives in the Torso
	else
		Joint = Instance.new("Weld")
		Joint.Name = "ItemGrip"
		Joint.C0 = Info.Grip
		Joint.Parent = Model.PrimaryPart
	end
	Joint.Part0 = Attach
	Joint.Part1 = Model.PrimaryPart
	-- Move the whole model into the hand first. Otherwise the joint snaps only the main part over
	-- from where the template is stored, and any WeldConstraint that locks after that snap keeps
	-- its part back there (the Den Den Mushi's shell ended up hundreds of studs below you).
	local InHand = Attach.CFrame * Joint.C0 * Joint.C1:Inverse()
	Model:PivotTo(InHand * Model.PrimaryPart.CFrame:Inverse() * Model:GetPivot())
	Model.Destroying:Once(function()
		Joint:Destroy()
	end)
	Model.Name = "HeldItem"
	Model.Parent = Character
	local Held = NewHeld(Character, Id, Ammo or Info.Ammo, Model)
	if Info.HoldWalkSpeed then
		-- walking only, like carrying a Cola Bomb. Any other stun replaces this one (StunHandler keeps
		-- one at a time), so it's put back once that one's over, as long as it's still held
		AddStun(Character, Held, Info.HoldWalkSpeed)
		table.insert(Held.Connections, Character.ChildRemoved:Connect(function(Child)
			if Child.Name ~= "Stunned" then
				return
			end
			task.defer(function()
				if HeldBy[Character] == Held and not Held.Busy and not Character:FindFirstChild("Stunned") then
					AddStun(Character, Held, Info.HoldWalkSpeed)
				end
			end)
		end))
	end
	-- e.g. the Den Den Mushi: arm held straight out with the snail on the fist
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Animator = Humanoid and Humanoid:FindFirstChildOfClass("Animator")
	if Info.HoldAnimation and Animator then
		local Animation = Instance.new("Animation")
		Animation.AnimationId = Info.HoldAnimation
		local Track = Animator:LoadAnimation(Animation)
		Track.Priority = Enum.AnimationPriority.Action -- over walking, so the arm stays out
		Track.Looped = true
		Track:Play(0.15)
		Held.HoldTrack = Track
	end
	return true
end

function ItemService.Drop(Character: Model)
	local Held = HeldBy[Character]
	local HumRP = Character:FindFirstChild("HumanoidRootPart")
	if not Held then
		return
	end
	local Id, Ammo = Held.Id, Held.Ammo
	ClearHeld(Character)
	if HumRP and Ammo > 0 then
		local Ground = GroundBelow(HumRP.Position + HumRP.CFrame.LookVector * 3)
		if ItemConfig.Get(Id).Overhead then
			StandItem(Id, Ammo, Ground, ItemConfig.PickupLife)
		else
			MakePickup(Id, Ammo, Ground)
		end
	end
end

-- Uses one ammo; at zero the item is gone (the sniper shatters)
local function Spend(Character: Model, Held: Held)
	Held.Ammo -= 1
	Character:SetAttribute("ItemAmmo", Held.Ammo)
	if Held.Ammo <= 0 then
		local At = Held.Model.PrimaryPart and Held.Model.PrimaryPart.Position
		ClearHeld(Character)
		if At and Held.Id == "Sniper" then
			ClientEffects:FireAllClients(EFFECT, { SkillType = "ItemBreak", Character = Character, Position = At, Id = Held.Id })
		end
	end
end

------------------------------------------------------------------------
-- Overhead items (Cola Bomb): pick up with M1 like a barrel
------------------------------------------------------------------------
-- Stands an overhead item up on the ground, ready to be picked up with M1
StandItem = function(Id: string, Ammo: number, Ground: Vector3, Life: number)
	local Model = ItemModel(Id)
	if not Model then
		return
	end
	local Main = Model.PrimaryPart :: BasePart
	for _, Part in Model:GetDescendants() do
		if Part:IsA("BasePart") then
			Part.CanCollide = true
			Part.CanQuery = true -- M1 finds it with an overlap check
		end
	end
	Main.Anchored = true
	local _, Size = Model:GetBoundingBox()
	Model:PivotTo(CFrame.new(Ground + Vector3.yAxis * (Size.Y / 2)) * CFrame.Angles(0, Rng:NextNumber(0, math.pi * 2), 0))
	Model:SetAttribute("Ammo", Ammo)
	Model:AddTag(GRAB_TAG)
	Model.Parent = Pickups
	task.delay(Life, function()
		if Model.Parent then
			Model:Destroy()
		end
	end)
end

-- Being hit while carrying it makes you drop it where you stand
local function WatchCarrier(Character: Model, Held: Held)
	local function Knocked()
		if HeldBy[Character] == Held then
			ItemService.Drop(Character)
		end
	end
	table.insert(Held.Connections, CollectionService:GetInstanceAddedSignal("Ragdolled"):Connect(function(Instance)
		if Instance == Character then
			Knocked()
		end
	end))
	table.insert(Held.Connections, Character.ChildAdded:Connect(function(Child)
		if Child.Name == "Stunned" then
			task.defer(function() -- our own stuns are registered right after StunHandler makes them
				if Child.Parent and not Held.Stuns[Child] then
					Knocked()
				end
			end)
		end
	end))
end

local function Grab(Character: Model, Ground: Model)
	local HumRP = Character:FindFirstChild("HumanoidRootPart") :: BasePart
	local Id = Ground.Name
	local Ammo = Ground:GetAttribute("Ammo") or ItemConfig.Get(Id).Ammo
	local At = Ground:GetPivot()
	Ground:RemoveTag(GRAB_TAG)
	Ground:Destroy()

	local Model = ItemModel(Id) :: Model
	Model.Name = "HeldItem"
	local Overhead: CFrame = ItemConfig.Get(Id).Carry
	local Held = NewHeld(Character, Id, Ammo, Model)
	Held.Busy = true
	local PickupStun = AddStun(Character, Held, 0)
	WatchCarrier(Character, Held)

	-- in your hands: welded the barrel way, swung up over your head on "lift"
	local function Attach(C0: CFrame, C1: CFrame)
		if Held.Weld then
			return
		end
		Model:PivotTo(At)
		local Weld = Instance.new("Weld")
		Weld.Name = "Weld"
		Weld.Part0 = HumRP
		Weld.Part1 = Model.PrimaryPart
		Weld.C0 = C0
		Weld.C1 = C1
		Weld.Parent = Model
		Held.Weld = Weld
		Model.Parent = Character
	end
	local function Lift()
		Attach(GRAB_C0, GRAB_C1)
		TweenService:Create(Held.Weld :: Weld, TweenInfo.new(0.11, Enum.EasingStyle.Linear), { C0 = Overhead, C1 = CFrame.identity }):Play()
	end
	local function Carry()
		if HeldBy[Character] ~= Held then
			return
		end
		Attach(Overhead, CFrame.identity) -- if the animation had no markers
		RemoveStun(Character, Held, PickupStun)
		AddStun(Character, Held, CARRY_WALKSPEED) -- slower, no jumping or moves, like a barrel
		if CarryAnimation then
			AnimationService:playAnimation(Character, CarryAnimation)
		end
		Held.Busy = false
	end

	if PickupAnimation then
		AnimationService:stopAll(Character)
		local Track = AnimationService:getAnimationTrack(Character, PickupAnimation)
		AnimationService:playAnimation(Character, PickupAnimation, 2)
		if Track then
			table.insert(Held.Connections, Track:GetMarkerReachedSignal("grab"):Once(function()
				Attach(GRAB_C0, GRAB_C1)
			end))
			table.insert(Held.Connections, Track:GetMarkerReachedSignal("lift"):Once(Lift))
			table.insert(Held.Connections, Track.Stopped:Once(Carry))
			return
		end
	end
	Lift()
	task.delay(0.3, Carry)
end

-- NewCombatSystem calls this at the start of M1: picks up an overhead item standing in front of
-- you. Returns true if it did (so you don't punch).
function ItemService.TryGrab(Character: Model): boolean
	local HumRP = Character:FindFirstChild("HumanoidRootPart")
	if HeldBy[Character] or not (HumRP and HumRP:IsA("BasePart")) or not CanAct(Character, nil) then
		return false
	end
	local Parts = workspace:GetPartBoundsInBox(HumRP.CFrame * CFrame.new(0, 0, -3.5), Vector3.one * 7, GrabParams)
	for _, Part in Parts do
		local Model = Part:FindFirstAncestorOfClass("Model")
		while Model and not Model:HasTag(GRAB_TAG) do
			Model = Model:FindFirstAncestorOfClass("Model")
		end
		if Model then
			Grab(Character, Model)
			return true
		end
	end
	return false
end

------------------------------------------------------------------------
-- Pickups (dropped sniper) and seagull packages
------------------------------------------------------------------------
local function Prompt(Parent: Instance, Action: string, Object: string): ProximityPrompt
	local Prompt = Instance.new("ProximityPrompt")
	Prompt.ActionText = Action
	Prompt.ObjectText = Object
	Prompt.HoldDuration = 0.4
	Prompt.MaxActivationDistance = 10
	Prompt.RequiresLineOfSight = false
	Prompt.Parent = Parent
	return Prompt
end

-- A hand-held item lying on the ground; anyone can pick it up
MakePickup = function(Id: string, Ammo: number, Ground: Vector3)
	local Info = ItemConfig.Get(Id)
	local Model = Info and ItemModel(Id)
	if not Model then
		return
	end
	local Main = Model.PrimaryPart :: BasePart
	Main.Anchored = true
	local _, Size = Model:GetBoundingBox()
	-- laid on its side, so its old width is now its height
	Model:PivotTo(CFrame.new(Ground + Vector3.yAxis * (Size.X / 2 + 0.1)) * CFrame.Angles(0, Rng:NextNumber(0, math.pi * 2), math.pi / 2))
	Model:SetAttribute("Ammo", Ammo)
	Model.Parent = Pickups

	local Used = false
	Prompt(Main, "Pick up", Info.Name).Triggered:Connect(function(Player)
		local Character = Player.Character
		if Used or not Character or not CanAct(Character, HeldBy[Character]) then
			return
		end
		Used = true
		Model:Destroy()
		ItemService.Hold(Character, Id, Ammo)
	end)
	task.delay(ItemConfig.PickupLife, function()
		if Model.Parent then
			Model:Destroy()
		end
	end)
end

local function MakePackage(Id: string, Owner: Player, DropPoint: Vector3, Ground: Vector3)
	local Delivery = ItemConfig.Delivery
	local Info = ItemConfig.Get(Id)
	local Template = ItemModels:FindFirstChild("Package")
	local Package: BasePart
	local Whole: Instance -- what gets removed when it's opened
	if Template then -- your own package model, if you add one
		local Model = Template:Clone()
		Package = Root(Model) :: BasePart
		for _, Part in Model:GetDescendants() do
			if Part:IsA("BasePart") then
				Part.Anchored = Part == Package
				Part.CanCollide = false
				if Part ~= Package then
					local Weld = Instance.new("WeldConstraint")
					Weld.Part0, Weld.Part1, Weld.Parent = Package, Part, Part
				end
			end
		end
		Model.Parent = Pickups
		Whole = Model
	else
		Package = Instance.new("Part")
		Package.Name = "Package"
		Package.Size = Vector3.new(2.6, 2.2, 2.6)
		Package.Material = Enum.Material.WoodPlanks
		Package.Color = Color3.fromRGB(150, 108, 66)
		Package.Anchored = true
		Package.CanCollide = false
		Package.Parent = Pickups
		local Glow = Instance.new("Highlight")
		Glow.FillTransparency = 0.85
		Glow.OutlineColor = Color3.fromRGB(255, 210, 90)
		Glow.Parent = Package
		Whole = Package
	end
	local Landing = Ground + Vector3.yAxis * (Package.Size.Y / 2)
	Package.CFrame = CFrame.new(DropPoint) * CFrame.Angles(0, Rng:NextNumber(0, math.pi * 2), 0)

	local Fall = TweenService:Create(Package, TweenInfo.new(Delivery.FallTime, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		CFrame = Package.CFrame.Rotation + Landing,
	})
	Fall.Completed:Once(function()
		ClientEffects:FireAllClients(EFFECT, { SkillType = "PackageLand", Position = Landing })
		local Notify = Remotes:FindFirstChild("Shop") and Remotes.Shop:FindFirstChild("Notify")
		if Notify and Owner.Parent then
			Notify:FireClient(Owner, "Delivered", { Id })
		end

		local Opened = false
		local LandedAt = os.clock()
		Prompt(Package, "Open", Info and Info.Name or Id).Triggered:Connect(function(Player)
			local Character = Player.Character
			if Opened or not Character or not CanAct(Character, HeldBy[Character]) then
				return
			end
			if Player ~= Owner and os.clock() - LandedAt < Delivery.OwnerOnly then
				return
			end
			Opened = true
			Whole:Destroy()
			if Info and Info.Overhead then
				-- the bomb stands where the package was; M1 in front of it to pick it up
				StandItem(Id, Info.Ammo, Ground, Delivery.PackageLife)
			else
				ItemService.Hold(Character, Id)
			end
		end)
		task.delay(Delivery.PackageLife, function()
			if not Opened then
				Whole:Destroy()
			end
		end)
	end)
	Fall:Play()
end

-- Hands an item over on the spot, like opening a package does (the world supply drops)
function ItemService.Give(Character: Model, Id: string)
	local Info = ItemConfig.Get(Id)
	local HumRP = Character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not Info or not HumRP then
		return
	end
	if Info.Overhead then
		StandItem(Id, Info.Ammo, GroundBelow(HumRP.Position + HumRP.CFrame.LookVector * 4), ItemConfig.Delivery.PackageLife)
	else
		ItemService.Hold(Character, Id)
	end
end

-- The shop calls this: one seagull per item, a moment apart
function ItemService.Deliver(Player: Player, Ids: { string })
	local Delivery = ItemConfig.Delivery
	for Index, Id in Ids do
		task.delay((Index - 1) * 0.5, function()
			local Character = Player.Character
			local HumRP = Character and Character:FindFirstChild("HumanoidRootPart")
			if not Player.Parent or not HumRP then
				return
			end
			local Spot = HumRP.Position + Vector3.new(Rng:NextNumber(-7, 7), 0, Rng:NextNumber(-7, 7))
			local Ground = GroundBelow(Spot)
			local Drop = Ground + Vector3.yAxis * Delivery.FlyHeight
			local Angle = Rng:NextNumber(0, math.pi * 2)
			local Across = Vector3.new(math.cos(Angle), 0, math.sin(Angle))
			local From = Drop - Across * Delivery.FlyDistance + Vector3.yAxis * 25
			local To = Drop + Across * Delivery.FlyDistance + Vector3.yAxis * 45

			-- everyone starts the seagull at the same server time, so it lets go right where the
			-- package appears
			local StartAt = workspace:GetServerTimeNow() + 0.25
			ClientEffects:FireAllClients(EFFECT, {
				SkillType = "Seagull",
				From = From,
				Drop = Drop,
				To = To,
				StartAt = StartAt,
				ArriveTime = Delivery.ArriveTime,
				LeaveTime = Delivery.LeaveTime,
			})
			task.delay(0.25 + Delivery.ArriveTime, MakePackage, Id, Player, Drop, Ground)
		end)
	end
end

------------------------------------------------------------------------
-- Sniper
------------------------------------------------------------------------
local function FireSniper(Player: Player, Character: Model, Held: Held, AimPoint: Vector3)
	local Info = ItemConfig.Items.Sniper
	local Head = Character:FindFirstChild("Head") :: BasePart?
	if not Head then
		return
	end
	local Direction = AimPoint - Head.Position
	if Direction.Magnitude < 1 then
		return
	end
	Direction = Direction.Unit
	local Muzzle = Held.Model.PrimaryPart and Held.Model.PrimaryPart.Position or Head.Position

	local BulletId = Rng:NextInteger(1, 2 ^ 30)
	ClientEffects:FireAllClients(EFFECT, {
		SkillType = "SniperFire",
		Character = Character,
		Id = BulletId,
		Origin = Head.Position,
		Muzzle = Muzzle,
		Direction = Direction,
		Speed = Info.BulletSpeed,
	})
	ShakeNear(Head.Position, 25, 6, 0.25)
	Spend(Character, Held)
	if Held.Ammo > 0 then
		task.delay(0.45, function()
			ClientEffects:FireAllClients(EFFECT, { SkillType = "SniperBolt", Character = Character })
		end)
	end

	-- the bullet: moves BulletSpeed studs a second, raycasting the stretch it covered each frame
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = { Character, Pickups, World:FindFirstChild("Visuals") }
	local Position = Head.Position
	local Travelled = 0
	local Connection
	Connection = RunService.Heartbeat:Connect(function(DeltaTime)
		local Step = math.min(Info.BulletSpeed * DeltaTime, Info.Range - Travelled)
		local Hit = workspace:Raycast(Position, Direction * Step, Params)
		Travelled += Step
		if not Hit then
			Position += Direction * Step
			if Travelled >= Info.Range then
				Connection:Disconnect()
				ClientEffects:FireAllClients(EFFECT, { SkillType = "BulletEnd", Id = BulletId, Position = Position })
			end
			return
		end
		Connection:Disconnect()
		local Enemy = CharacterFromPart(Hit.Instance)
		ClientEffects:FireAllClients(EFFECT, {
			SkillType = "BulletEnd",
			Id = BulletId,
			Position = Hit.Position,
			Normal = Hit.Normal,
			Victim = Enemy,
		})
		if Enemy then
			HitCharacter(Character, Enemy, Info.Damage, Direction * Info.Knockback + Vector3.yAxis * 10, Info.Ragdoll, true)
		elseif Info.WallHole > 0 and Hit.Instance:IsDescendantOf(Map) then
			DebreeService.Destroy(CFrame.new(Hit.Position), Vector3.one * Info.WallHole, {
				Shape = "Ball",
				Direction = Direction,
				Power = 20,
				GridSize = 1.5,
				GroundGridSize = 1.5,
				Attacker = Player,
			})
		end
	end)
end

------------------------------------------------------------------------
-- Cola Bomb and Muggy Ball (ItemConfig Bomb = true)
------------------------------------------------------------------------
local function Explode(Player: Player, Character: Model, Id: string, Position: Vector3)
	local Info = ItemConfig.Items[Id]
	ClientEffects:FireAllClients(EFFECT, {
		SkillType = if Info.Explosion then "BombExplode" else "ColaExplode",
		Position = Position,
		Radius = Info.Radius,
		Explosion = Info.Explosion,
	})
	ShakeNear(Position, Info.Radius * 4, 10, 0.4)

	for _, Victim in LiveCharacters() do
		local VictimRoot = Victim:FindFirstChild("HumanoidRootPart")
		if not (VictimRoot and VictimRoot:IsA("BasePart")) or (Victim == Character and not Info.HitSelf) then
			continue
		end
		local Offset = VictimRoot.Position - Position
		local Distance = Offset.Magnitude
		if Distance > Info.Radius then
			continue
		end
		local T = Distance / Info.Radius
		local Away = Vector3.new(Offset.X, 0, Offset.Z)
		Away = if Away.Magnitude > 0.1 then Away.Unit else Vector3.zAxis
		local Damage = Info.NearDamage + (Info.FarDamage - Info.NearDamage) * T
		local Force = Info.Knockback * (1 - T * 0.5)
		HitCharacter(Character, Victim, Damage, Away * Force + Vector3.yAxis * Info.Lift * (1 - T * 0.5), Info.Ragdoll, true)
	end

	if Info.Crater > 0 then
		DebreeService.Destroy(CFrame.new(Position), Vector3.one * Info.Crater, {
			Shape = "Ball",
			Outward = true,
			GroundOutward = true, -- the ground blows out too
			Destroyed = Info.Destroyed, -- share of the pieces removed outright (less lag)
			Power = 45,
			Lift = 20,
			GridSize = Info.PieceSize,
			GroundGridSize = Info.PieceSize,
			Attacker = Player,
		})
	end
end

local function ThrowBomb(Player: Player, Character: Model, Held: Held, AimPoint: Vector3)
	local Id = Held.Id
	local Info = ItemConfig.Items[Id]
	local HumRP = Character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if not HumRP then
		return
	end
	-- aim no farther than ThrowRange, and face it
	local Flat = Vector3.new(AimPoint.X - HumRP.Position.X, 0, AimPoint.Z - HumRP.Position.Z)
	if Flat.Magnitude > Info.ThrowRange then
		AimPoint = HumRP.Position + Flat.Unit * Info.ThrowRange + Vector3.yAxis * (AimPoint.Y - HumRP.Position.Y)
	end
	if Flat.Magnitude > 0.5 then
		HumRP.CFrame = CFrame.lookAlong(HumRP.Position, Flat.Unit)
	end

	Held.Busy = true
	local ThrowStun = AddStun(Character, Held, 0) -- stand still for the throw, like a barrel
	-- pull it back behind your head while the arms wind up, then it's let go on "throw"
	if Held.Weld then
		TweenService:Create(Held.Weld, TweenInfo.new(Info.WindUpTime, Enum.EasingStyle.Linear), { C0 = Info.WindUp }):Play()
	end
	local Released = false
	local function Release()
		if Released then
			return
		end
		Released = true
		if HeldBy[Character] ~= Held or not Character.Parent then
			return -- dropped it (got hit) before letting go
		end
		local Hand = Held.Model.PrimaryPart
		local From = if Hand then Hand.Position else HumRP.Position + Vector3.yAxis * 3.5
		local Facing = Vector3.new(HumRP.CFrame.LookVector.X, 0, HumRP.CFrame.LookVector.Z)
		Spend(Character, Held) -- one throw: this removes the carried bomb and your carry stun
		RemoveStun(Character, Held, ThrowStun)

		local Bomb = ItemModel(Id)
		if not Bomb then
			return
		end
		local Main = Bomb.PrimaryPart :: BasePart
		Bomb.Name = "Thrown" .. Id
		-- standing up the whole way, so it lands on its bottom and sits upright while the fuse runs
		local Upright = if Facing.Magnitude > 0.01 then CFrame.lookAlong(From, Facing.Unit) else CFrame.new(From)
		Bomb:PivotTo(Upright)
		for _, Part in Bomb:GetDescendants() do
			if Part:IsA("BasePart") then
				Part.Massless = Part ~= Main
			end
		end
		Main.CanCollide = true
		Main.CustomPhysicalProperties = PhysicalProperties.new(1, 0.8, 0.05) -- heavy, grippy, no bounce
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = Main
		local KeepUp = Instance.new("AlignOrientation")
		KeepUp.Mode = Enum.OrientationAlignmentMode.OneAttachment
		KeepUp.Attachment0 = Attachment
		KeepUp.CFrame = Upright.Rotation
		KeepUp.RigidityEnabled = true
		KeepUp.Parent = Main
		-- launch so it reaches the aim point in ThrowTime seconds
		local G = workspace.Gravity
		local T = Info.ThrowTime
		Main.AssemblyLinearVelocity = (AimPoint - From) / T + Vector3.yAxis * (0.5 * G * T)
		Bomb.Parent = World:FindFirstChild("Visuals") or workspace
		Main:SetNetworkOwner(nil)
		if Info.BlinkTime then
			-- the Light on top starts blinking red when it lands
			ClientEffects:FireAllClients(EFFECT, { SkillType = "BombBlink", Bomb = Bomb, BlinkAt = workspace:GetServerTimeNow() + Info.Fuse - Info.BlinkTime })
		else
			ClientEffects:FireAllClients(EFFECT, { SkillType = "ColaFuse", Bomb = Bomb, Fuse = Info.Fuse })
		end

		task.delay(Info.Fuse, function()
			local At = if Main.Parent then Main.Position else AimPoint
			Bomb:Destroy()
			Explode(Player, Character, Id, At)
		end)
	end

	if ThrowAnimation then
		local Track = AnimationService:getAnimationTrack(Character, ThrowAnimation)
		AnimationService:playAnimation(Character, ThrowAnimation)
		if Track then
			table.insert(Held.Connections, Track:GetMarkerReachedSignal("throw"):Once(Release))
		end
	end
	task.delay(0.8, Release) -- in case the animation has no "throw" marker (it's at 0.63s)
end

------------------------------------------------------------------------
-- Buster Call (the golden Den Den Mushi)
------------------------------------------------------------------------
local PendingAim: { [Model]: (Vector3) -> () } = {} -- callers aiming right now

-- The barrage only lands on the ground, never on buildings (Models named "Building": the houses,
-- warehouses and lighthouse). A spot with a building over it is re-rolled.
local function OpenGround(Position: Vector3): Vector3?
	local Hit = workspace:Raycast(Position + Vector3.yAxis * 150, Vector3.yAxis * -400, GroundParams)
	if not Hit or Hit.Instance:FindFirstAncestor("Building") then
		return nil
	end
	return Hit.Position
end

-- the ground at a spot even when it's under a building (the aim landed on a roof)
local function GroundUnderBuildings(Position: Vector3): Vector3
	local Skip = {}
	for _, Model in Map:GetDescendants() do
		if Model:IsA("Model") and Model.Name == "Building" then
			table.insert(Skip, Model)
		end
	end
	local Params = RaycastParams.new()
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.FilterDescendantsInstances = Skip
	local Hit = workspace:Raycast(Position + Vector3.yAxis * 30, Vector3.yAxis * -300, Params)
	return if Hit then Hit.Position else GroundBelow(Position)
end

local function Barrage(Player: Player, Character: Model, Target: Vector3)
	local Info = ItemConfig.Items.BusterCall
	local HumRP = Character:FindFirstChild("HumanoidRootPart") :: BasePart?
	if HumRP then
		local Flat = Vector3.new(Target.X - HumRP.Position.X, 0, Target.Z - HumRP.Position.Z)
		if Flat.Magnitude > Info.CallRange then
			Target = HumRP.Position + Flat.Unit * Info.CallRange + Vector3.yAxis * (Target.Y - HumRP.Position.Y)
		end
	end
	local Center = OpenGround(Target) or GroundUnderBuildings(Target)

	-- every rocket's path, landing time and size, picked here so every client sees the same barrage.
	-- Fired like cannons from a fleet far behind you (out of sight, along your look): each one is
	-- lobbed high and drops onto the zone on a real arc (ItemEffects works the arc out from From, To,
	-- the flight time and Info.Gravity). Most land near the middle of the marker, a few past its edge.
	local Now = workspace:GetServerTimeNow()
	local Look = if HumRP then Vector3.new(Center.X - HumRP.Position.X, 0, Center.Z - HumRP.Position.Z) else Vector3.zero
	Look = if Look.Magnitude > 0.1 then Look.Unit else Vector3.zAxis
	local Side = Look:Cross(Vector3.yAxis)
	local Fleet = (if HumRP then HumRP.Position else Center) - Look * Info.FleetDistance + Vector3.yAxis * Info.FleetHeight
	local Rockets = {}
	local Destroys: { [any]: number } = {} -- the rockets that make a hole, and how much of it is removed outright
	local From = if HumRP then HumRP.Position else Center
	for WaveIndex, Wave in Info.Waves do
	local WaveRockets = {}
	for _ = 1, Wave.Count do
		local Spot
		for _ = 1, 10 do
			local Distance = if Rng:NextNumber() < Info.OuterShare
				then Rng:NextNumber(Info.Spread, Info.OuterSpread) -- the outskirts
				else Info.Spread * Rng:NextNumber() ^ Info.Focus -- bunched toward the middle
			local Angle = Rng:NextNumber(0, math.pi * 2)
			Spot = OpenGround(Center + Vector3.new(math.cos(Angle) * Distance, 0, math.sin(Angle) * Distance))
			if Spot then
				break
			end
		end
		Spot = Spot or Center
		-- a cannon somewhere along the fleet's line
		local Start = Fleet + Side * Rng:NextNumber(-Info.FleetWidth, Info.FleetWidth) + Look * Rng:NextNumber(-20, 20)
		-- the closer to you, the sooner it lands; the far ones come a bit later
		local Away = Vector3.new(Spot.X - From.X, 0, Spot.Z - From.Z).Magnitude
		local LaunchAt = Now + 0.3 + Wave.Delay + Away * Info.DistanceDelay + Rng:NextNumber(0, Info.LaunchSpread)
		local Rocket = {
			From = Start,
			To = Spot,
			LaunchAt = LaunchAt,
			LandAt = LaunchAt + Rng:NextNumber(Info.FlightTime[1], Info.FlightTime[2]),
			Scale = Rng:NextNumber(Info.Scale[1], Info.Scale[2]),
			Radius = 0, -- set below: how big its landing marker is
		}
		Rocket.Radius = Info.BlastRadius * Rocket.Scale
		table.insert(Rockets, Rocket)
		table.insert(WaveRockets, Rocket)
	end
	-- only the first Craters of each wave to land make a hole (the first wave has most of them, the
	-- later waves only a few, so it isn't laggy); of those, some remove everything they break (no
	-- debris) and the others remove Info.Destroyed of it
	table.sort(WaveRockets, function(A, B)
		return A.LandAt < B.LandAt
	end)
	for Index = 1, math.min(Wave.Craters, #WaveRockets) do
		Destroys[WaveRockets[Index]] = if Rng:NextNumber() < Info.FullDestroyChance then 1 else Info.Destroyed
	end
	end
	ClientEffects:FireAllClients(EFFECT, { SkillType = "BusterCall", Center = Center, Rockets = Rockets, Explosion = Info.Explosion })

	local Hits: { [Model]: number } = {}
	for _, Rocket in Rockets do
		task.delay(Rocket.LandAt - workspace:GetServerTimeNow(), function()
			local Position = Rocket.To
			local Radius = Info.BlastRadius * Rocket.Scale
			ShakeNear(Position, Radius * 4, 4 + 3 * Rocket.Scale, 0.3)
			for _, Victim in LiveCharacters() do
				local VictimRoot = Victim:FindFirstChild("HumanoidRootPart")
				if not (VictimRoot and VictimRoot:IsA("BasePart")) or (Victim == Character and not Info.HitSelf) then
					continue
				end
				local Offset = VictimRoot.Position - Position
				if Offset.Magnitude > Radius or (Hits[Victim] or 0) >= Info.MaxHits then
					continue
				end
				-- the first rocket to catch you hurts the most, like Soulbound's
				local Damage = if Hits[Victim] then Info.RepeatDamage else Rng:NextInteger(Info.FirstDamage[1], Info.FirstDamage[2])
				Hits[Victim] = (Hits[Victim] or 0) + 1
				local Away = Vector3.new(Offset.X, 0, Offset.Z)
				Away = if Away.Magnitude > 0.1 then Away.Unit else Vector3.zAxis
				-- ragdolled and thrown up into the air
				HitCharacter(Character, Victim, Damage, Away * Info.Knockback + Vector3.yAxis * Info.Lift, Info.Ragdoll, true)
			end
			if Info.Crater > 0 and Destroys[Rocket] then
				DebreeService.Destroy(CFrame.new(Position), Vector3.one * Info.Crater * Rocket.Scale, {
					Shape = "Ball",
					Outward = true,
					GroundOutward = true, -- the ground blows out too
					Destroyed = Destroys[Rocket], -- share of the pieces removed outright (less lag)
					Power = 40,
					Lift = 18,
					GridSize = Info.PieceSize,
					GroundGridSize = Info.PieceSize,
					Attacker = Player,
				})
			end
		end)
	end
end

-- M1: the snail rings while you aim for AimTime (ItemEffects BusterCallAim shows you the marker and
-- sends back where it ended up), then the barrage comes down there
local function CallBusterCall(Player: Player, Character: Model, Held: Held, AimPoint: Vector3)
	local Info = ItemConfig.Items.BusterCall
	Held.Busy = true
	local AimStun = AddStun(Character, Held, 0) -- stand still while you aim, like Soulbound
	ClientEffects:FireAllClients(EFFECT, { SkillType = "BusterCallRing", Character = Character, Time = Info.AimTime })
	ClientEffects:FireClient(Player, EFFECT, { SkillType = "BusterCallAim", Character = Character, Time = Info.AimTime, Range = Info.CallRange })

	local Called = false
	local function Call(Point: Vector3)
		if Called then
			return
		end
		Called = true
		if PendingAim[Character] == Call then
			PendingAim[Character] = nil
		end
		RemoveStun(Character, Held, AimStun)
		if HeldBy[Character] ~= Held or not Character.Parent then
			return -- died while aiming
		end
		Spend(Character, Held)
		Barrage(Player, Character, Point)
	end
	PendingAim[Character] = Call
	task.delay(Info.AimTime + 0.75, Call, AimPoint) -- the client never answered: use where they first clicked
end

------------------------------------------------------------------------
-- Input from ItemClient
------------------------------------------------------------------------
UseRemote.OnServerEvent:Connect(function(Player: Player, Action: any, AimPoint: any)
	local Character = Player.Character
	local Held = Character and HeldBy[Character]
	if not Held or typeof(Action) ~= "string" then
		return
	end
	if Action == "Drop" then
		if not Held.Busy then
			ItemService.Drop(Character)
		end
		return
	end
	if Action == "Scope" then
		ClientEffects:FireAllClients(EFFECT, { SkillType = "Scope", Character = Character, On = AimPoint == true })
		return
	end
	if Action == "Aim" then
		local Call = PendingAim[Character]
		if Call and typeof(AimPoint) == "Vector3" and AimPoint == AimPoint then
			Call(AimPoint)
		end
		return
	end
	if Action ~= "Use" or typeof(AimPoint) ~= "Vector3" or AimPoint ~= AimPoint then
		return
	end
	local Now = os.clock()
	if Held.Busy or Now < Held.NextUse or not CanAct(Character, Held) then
		return
	end
	if Held.Id == "Sniper" then
		Held.NextUse = Now + ItemConfig.Items.Sniper.ShotCooldown
		FireSniper(Player, Character, Held, AimPoint)
	elseif ItemConfig.Get(Held.Id).Bomb then
		Held.NextUse = Now + ItemConfig.Get(Held.Id).ThrowCooldown
		ThrowBomb(Player, Character, Held, AimPoint)
	elseif Held.Id == "BusterCall" then
		Held.NextUse = Now + 1
		CallBusterCall(Player, Character, Held, AimPoint)
	else
		return
	end
	if QuestService then
		QuestService.Add(Player, "ItemsUsed", 1)
	end
end)

-- a held item is lost when you die or respawn
local function Watch(Player: Player)
	Player.CharacterRemoving:Connect(ClearHeld)
	Player.CharacterAdded:Connect(function(Character)
		local Humanoid = Character:WaitForChild("Humanoid", 10)
		if Humanoid then
			Humanoid.Died:Connect(function()
				ClearHeld(Character)
			end)
		end
	end)
end
Players.PlayerAdded:Connect(Watch)
for _, Player in Players:GetPlayers() do
	Watch(Player)
end

return ItemService
