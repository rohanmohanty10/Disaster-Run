local Debris = game:GetService('Debris')
local Players = game:GetService('Players')
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")


local ReplicateSet = game.ReplicatedStorage.Remotes.Replicate.Set
--local AnimationService = require(game.ServerStorage.SBGModules.AnimationService)


-- ── Smooth pull-in ───────────────────────────────────────────────────────────
-- false = the original behaviour, byte for byte (WeldConstraint parented after
--         TweenTime, server writes Part1.CFrame, clients lerp with PivotTo).
-- true  = animate the joint's OFFSET instead of the victim's position.
--
-- The only differences when true, and nothing else in this module changes:
--   1. legacy Weld instead of WeldConstraint (WeldConstraint has no animatable
--      offset — that limitation is why the original had to wait then parent)
--   2. parented at t=0 at the victim's CURRENT offset, so nothing visibly moves,
--      but the victim is never an unconstrained body in free-fall mid-pull
--   3. RootPriority on the attacker so the merged assembly roots on them and the
--      offset animation moves the victim, not the grabber (restored on teardown)
--   4. no Part1.CFrame write — the server sets the final C0 instead, which is the
--      same value the clients' lerp is already landing on
--
-- Deliberately NOT changed by this flag: PlatformStand, Massless, LifeTime,
-- Humanoid states, client state pushes, teardown timing. Nothing here touches
-- anything a ragdoll reads.
local USE_SMOOTH_C0 = false


local function clearVelocities(Part: Part, Ignore: BodyVelocity?)
	for _, Velocity in Part:GetDescendants() do
		if Velocity ~= Ignore and (Velocity:IsA("BodyVelocity") or Velocity:IsA("LinearVelocity") or Velocity:IsA("BodyPosition") or Velocity:IsA("BodyGyro") or Velocity:IsA("BodyAngularVelocity") or Velocity:IsA("BodyMover") or Velocity:IsA("BodyForce") or Velocity:IsA("BodyThrust") or Velocity:IsA("AngularVelocity") or Velocity:IsA("VelocityMotor")) then
			Velocity:Destroy()
		end
	end
end


-- Hand the victim's assembly back to its own player. Start() gives it away, and
-- the original never took it back, so a grabbed player stayed simulated on
-- someone else's machine permanently — which shows up as them standing in a
-- different place on their own screen than on everyone else's until they move.
-- Must be called AFTER the weld is destroyed: while the weld exists the attacker
-- and victim are one merged assembly, and assigning an owner then assigns the
-- pair rather than the victim.
local function restoreOwnership(part: BasePart?)
	if not (RunService:IsServer() and part and part.Parent) then return end
	local victimPlayer = Players:GetPlayerFromCharacter(part.Parent)
	pcall(function()
		if not part:CanSetNetworkOwnership() then return end

		-- No-op if the owner is already right. A SetNetworkOwner call is not free:
		-- it hands physics state to another machine, and doing that needlessly right
		-- before a ragdoll is applied can disturb the ragdoll. Only pay for it when
		-- the ownership is actually wrong.
		local current = part:GetNetworkOwner()
		if current == victimPlayer then return end

		if victimPlayer then
			part:SetNetworkOwner(victimPlayer)
		else
			part:SetNetworkOwnershipAuto()
		end
	end)
end


local WSys = {}
WSys.__index = WSys

function WSys.new(Part0, Part1, Offset, LifeTime)
	return setmetatable({
		Part0 = Part0,
		Part1 = Part1,
		Offset = Offset,
		LifeTime = LifeTime
	}, WSys)
end

function WSys:Start(TweenTime: number, Player: Player)
	if not self.Part1 then return end

	TweenTime = TweenTime or 0.25

	local Part0: Part = self.Part0
	local Part1: Part = self.Part1

	local Bind = Instance.new("Folder")
	Bind.Name = "#WeldBind_" .. Part0.Parent.Name .. "_" .. Part1.Parent.Name .. "_" .. tostring(os.clock())
	Bind.Parent = Part1
	self.Bind = Bind

	Part1.Massless = true
	if Part1.Parent:FindFirstChild("Humanoid") then
		for _,v in Part1.Parent:GetChildren() do
			if v:IsA("BasePart") then
				v.Massless = true
			end
		end

		self.VictimHumanoid = Part1.Parent.Humanoid
		self.VictimHumanoid.PlatformStand = true

		self.AntiRotateConnection = game.CollectionService:GetInstanceRemovedSignal("CantRotate"):Connect(function(c)
			if c == Part1.Parent then
				Part1.Parent:AddTag("CantRotate")
			end
		end)
	end

	Part1.Parent:AddTag("WeldedToReplicated")

	self.Weld = Instance.new(USE_SMOOTH_C0 and 'Weld' or 'WeldConstraint')
	self.Weld.Name = "GrabWeld"
	--if self.LifeTime and self.LifeTime > 0 then
	--	Debris:AddItem(self.Weld, self.LifeTime)
	--end

	self.Weld.Destroying:Once(function()
		if not self then return end

		if Part1 and Part1.Parent then
			Part1.Parent:RemoveTag("WeldedToReplicated")

			-- Only for a weld destroyed by something other than :Stop(). Stop() already restored
			-- these, right away; this handler runs deferred, so doing it again here undid whatever
			-- came right after the Stop(), e.g. a ragdoll making the limbs massless.
			if not self.StoppingViaStop then
				Part1.Massless = false

				if Part1.Parent:FindFirstChild("Humanoid") then
					for _,v in Part1.Parent:GetChildren() do
						if v:IsA("BasePart") then
							v.Massless = false
						end
					end
				end

				if self.VictimHumanoid then
					self.VictimHumanoid.PlatformStand = false
					self.VictimHumanoid = nil
				end
			end

			-- FIX: hand the victim's assembly back to its own player. Start() gives it
			-- away (line ~118) and the original never took it back, so a grabbed player
			-- stayed simulated on someone else's machine permanently. Lives here rather
			-- than in Stop() because the weld can also be destroyed externally (e.g.
			-- DamageHandler cleans up grab welds), and this handler always runs.
			-- Fallback ONLY for a weld destroyed by something other than :Stop()
			-- (DamageHandler cleans up grab welds directly, for one). When :Stop()
			-- is the caller it restores ownership itself, synchronously, right
			-- after the destroy — deferring it there would let the ownership change
			-- land in the middle of whatever the move does next, such as the ragdoll
			-- that usually follows a grab.
			if RunService:IsServer() and not self.KeepNetworkOwner and not self.StoppingViaStop then
				local victimPart = Part1
				task.defer(function()
					restoreOwnership(victimPart)
				end)
			end
		end



		if self.Bind then
			self.Bind:Destroy()
			self.Bind = nil
		end

		if self.TweenConnection then
			self.TweenConnection:Disconnect()
			self.TweenConnection = nil
		end

		if self.AntiRotateConnection then
			self.AntiRotateConnection:Disconnect()
		end

		-- only ever set by the USE_SMOOTH_C0 path
		if self.SavedRootPriority ~= nil and self.RootPart and self.RootPart.Parent then
			self.RootPart.RootPriority = self.SavedRootPriority
			self.SavedRootPriority = nil
		end

		setmetatable(self, nil)
	end)

	self.Weld.Part0 = Part0
	self.Weld.Part1 = Part1

	if USE_SMOOTH_C0 then
		-- Offset at the moment of the grab. Parenting with THIS means the weld
		-- attaches without moving anything; the pull-in is then purely an
		-- animation of the offset, which every client can reproduce locally.
		local startC0 = Part0.CFrame:ToObjectSpace(Part1.CFrame)
		local goalC0 = self.Offset

		self.Weld.C0 = startC0
		self.Weld.C1 = CFrame.identity

		-- make the merged assembly root on the attacker, so animating the offset
		-- moves the victim rather than dragging the grabber
		local rootPart = (Part0.Parent and Part0.Parent:FindFirstChild("HumanoidRootPart")) or Part0
		self.RootPart = rootPart
		self.SavedRootPriority = rootPart.RootPriority
		rootPart.RootPriority = 127

		self.Weld.Parent = Part1

		if RunService:IsServer() then
			if Player and Part1:CanSetNetworkOwnership() then
				Part1:SetNetworkOwner(Player)
			end
			clearVelocities(Part1)

			game.ReplicatedStorage.Remotes.Weld.RemoteEvent:FireAllClients({
				SmoothC0 = true,
				Weld = self.Weld,
				EnemyCharacter = Part1.Parent,
				StartC0 = startC0,
				GoalC0 = goalC0,
				TweenTime = TweenTime,
			})

			-- the single authoritative landing write; clients' lerp converges on
			-- this exact value at this exact moment, so there is nothing to snap
			task.delay(TweenTime, function()
				if self.Weld and self.Weld.Parent then
					self.Weld.C0 = goalC0
				end
			end)
		end

		return self.Weld
	end

	task.spawn(function()
		if RunService:IsServer() and Player then

			if Part1:CanSetNetworkOwnership() then
				Part1:SetNetworkOwner(Player)
			end
			clearVelocities(Part1)

			--ReplicateSet:FireClient(Player, "smoothweld", { Character = Part0.Parent, EnemyCharacter = Part1.Parent, TweenTime = TweenTime, Offset = self.Offset, Bind = Bind })
			-- FIX: was FireClient(Player, ...) — only ONE machine ran the pull-in lerp,
			-- so the grab looked right on a single screen and snapped for everyone else.
			-- Every client now runs the same lerp locally toward the same target.
			game.ReplicatedStorage.Remotes.Weld.RemoteEvent:FireAllClients({ Character = Part0.Parent, EnemyCharacter = Part1.Parent, TweenTime = TweenTime, Offset = self.Offset, Bind = Bind})
			task.wait(TweenTime)
		end

		if not self.Weld then return end
		Part1.CFrame = Part0.CFrame * self.Offset
		self.Weld.Parent = Part1
	end)

	return self.Weld
end

function WSys:Stop(dontDelete, keepNetworkOwner)
	self.KeepNetworkOwner = keepNetworkOwner == true
	-- tells the Destroying handler to leave the ownership restore to us, so it
	-- happens once and at a moment the caller can reason about
	self.StoppingViaStop = true

	if self.Weld then
		local Part1 = self.Weld.Part1
		if Part1 and Part1.Parent then

			Part1.Parent:RemoveTag("WeldedToReplicated")
			Part1.Massless = false

			if Part1.Parent:FindFirstChild("Humanoid") then
				for _,v in Part1.Parent:GetChildren() do
					if v:IsA("BasePart") then
						v.Massless = false
					end
				end

				if self.VictimHumanoid then
					self.VictimHumanoid.PlatformStand = false
					self.VictimHumanoid = nil
				end
			end
		end

		self.Weld:Destroy()
		self.Weld = nil

		-- Synchronous, and only now that the weld is gone: the attacker and victim
		-- are two assemblies again, so this assigns the VICTIM's assembly. Doing it
		-- here rather than on a deferred thread means ownership is already settled
		-- before the caller's next line runs — which for most grabs is the ragdoll.
		if not self.KeepNetworkOwner then
			restoreOwnership(Part1)
		end
	end

	if self.Bind then
		self.Bind:Destroy()
		self.Bind = nil
	end

	if self.TweenConnection then
		self.TweenConnection:Disconnect()
		self.TweenConnection = nil
	end

	if self.AntiRotateConnection then
		self.AntiRotateConnection:Disconnect()
	end

	if dontDelete ~= true then
		setmetatable(self, nil)
	end
end


return WSys