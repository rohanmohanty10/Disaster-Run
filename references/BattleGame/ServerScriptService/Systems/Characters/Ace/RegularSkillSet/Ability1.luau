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


--local Utility = shared.Utility
local WeldSystem = require(ReplicatedModules.WeldSystem)
local SoundHandler = require(ReplicatedModules.SoundHandler)

local Trove = require(ReplicatedModules.Trove)


local Sounds = ReplicatedStorage.Assets.Sounds


local NewAnimLocation = ReplicatedStorage.Assets.Animations.Ace.Hiken


local MoveSounds = Sounds.Characters


local ReplicateEffects_Set = RemotesContainer.Replicate.Set


local rad = math.rad

--local MapRayParams = RaycastParams.new()
--MapRayParams.FilterType = Enum.RaycastFilterType.Include
--MapRayParams.FilterDescendantsInstances = {workspace.World.Map}
--MapRayParams.RespectCanCollide = true
--MapRayParams.IgnoreWater = true


return {
	Start = function(Player: Player, Tool: Tool)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		local selfModule = require(script) -- Self-reference to this specific module
		
		if Character:GetAttribute("AbilityOneCoolDown") then return end

		
		local StartAnimation = NewAnimLocation.Hold
		local StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		local StartEvents = {}
		
		local Stun = StunHandler:Stun(Character, nil, true, 0, 0, true)
		
		RemotesContainer.ClientEffects:FireAllClients("AceFirstAbility", {
			Attacker = Character,
			SkillType = "hold", 
		})
		
		local released = false
		local holdSignal
		local function fireRelease()
			if released then return end
			released = true

			if holdSignal then holdSignal:Disconnect() end

			-- Capture the time right now before calling Release
			local chargeTime = Character:GetAttribute("HikenCharge")

			-- Pass the chargeTime as an argument!
			selfModule.Release(Player, Tool, chargeTime)

			RemotesContainer.ClientEffects:FireAllClients("AceFirstAbility", {
				Attacker = Character,
				SkillType = "endhold", 
			})

			task.delay(.6, function()
				StunHandler:Unstun(Character, Stun)
				if Character:GetAttribute("HoldAimStarted") then 
					RemotesContainer.HoldAimStart:FireClient(Player, "Stop")
					Character:SetAttribute("HoldAimStarted", false)
				end
			end)
		end

		-- This fires when the player LETS GO
		holdSignal = Character:GetAttributeChangedSignal("HikenCharge"):Connect(function()
			if not Character:GetAttribute("HikenCharge") then
				fireRelease()
			end
		end)

		-- This fires as a SAFETY NET (Auto-release after 5 seconds)
		task.delay(5, function()
			if Character:GetAttribute("HikenCharge") and not released then
				fireRelease()
			end
		end)
		
		if Character:GetAttribute("IsInAir") then --We only want them to fly while they are in the air, else nah.
			RemotesContainer.HoldAimStart:FireClient(Player, "Start")
			Character:SetAttribute("HoldAimStarted", true) --Fixes bugs with the hold aim.
		end
		
		StartEvents["freeze"] = StartTrack:GetMarkerReachedSignal("freeze"):Once(function()
			StartTrack:AdjustSpeed(0)
		end)
		
		StartTrack.Stopped:Once(function()
			for _,v in StartEvents do
				v:Disconnect()
			end
			
			-- If the track stops but HikenCharge is still there, it was canceled
			if Character:GetAttribute("HikenCharge") then
				Character:SetAttribute("HikenCharge", nil)
				StunHandler:Unstun(Character, Stun)
				RemotesContainer.HoldAimStart:FireClient(Player, "Stop")
			end
		end)	

		Character:SetAttribute("HikenCharge", workspace:GetServerTimeNow())		
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
	end,
	
	Release = function(Player: Player, Tool: Tool, passedStartTime)
		local Character = Player.Character
		local Humanoid: Humanoid = Character.Humanoid
		local HumRP: BasePart = Character.HumanoidRootPart
		
		if Character:GetAttribute("AbilityOneCoolDown") then return end

		-- 2. Validate StartTime BEFORE setting cooldown
		local startTime = passedStartTime or Character:GetAttribute("HikenCharge")
		if not startTime then
			return -- Silent exit if no charge exists
		end

		-- 3. Now commit to the move
		Character:SetAttribute("AbilityOneCoolDown", true)
	
		-- CALCULATE HOLD DURATION
		local holdDuration = workspace:GetServerTimeNow() - startTime
		Character:SetAttribute("HikenCharge", nil)
		
		local StartAnimation = nil
		local StartTrack = nil
		local StartEvents = nil
		
		StartAnimation = NewAnimLocation.Throw
		StartTrack = AnimationService:getAnimationTrack(Character, StartAnimation)
		StartEvents = {}
		
		StartEvents["hit"] = StartTrack:GetMarkerReachedSignal("hit"):Once(function()
			local hitActive = true
			local connection = nil 
			local lastPos = nil
			local Proxy = nil
			local Hitbox = nil
			
			local projectileID = "Hiken_" .. Player.UserId .. "_" .. tick()
			
			local MapRayParams = RaycastParams.new()
			MapRayParams.FilterType = Enum.RaycastFilterType.Include
			MapRayParams.FilterDescendantsInstances = {workspace.World.Map}

			Proxy = Instance.new("Part")
			Proxy.Name = projectileID
			Proxy.Size = Vector3.new(5, 5, 5) -- Scale hitbox size! (Removed)
			Proxy.Transparency = 1 -- Make invisible for production
			Proxy.CanCollide = false
			Proxy.Anchored = true
			Proxy.CFrame = HumRP.CFrame * CFrame.new(0, 0, -5)
			Proxy.Parent = workspace.World.Debris
			Debris:AddItem(Proxy, 2)

			local speed = 150 -- * powerScale -- Scale speed!
			local lifetime = 2 
			local direction = HumRP.CFrame.LookVector
			local spawnPos = Proxy.Position
			local startTimeThrow = workspace:GetServerTimeNow()
			lastPos = spawnPos

			RemotesContainer.ClientEffects:FireAllClients("AceFirstAbility", {
				Attacker = Character, 
				SkillType = "throw", 
				CFrame = HumRP.CFrame, 
				Lifetime = lifetime, 
				CurrentPos = spawnPos, 
				Speed = speed,
				StartTime = startTimeThrow, -- ADD THIS!
				ProjectileID = projectileID,
			})

			Hitbox = HitboxHandler.new()
			Hitbox.Size = Vector3.new(5, 5, 5)
			Hitbox.Method = "Box"
			Hitbox.Ignore = {Character}
			Hitbox.Instance = Proxy 

			local function TriggerExplosion(hitPosition, hitNormal, isMapHit)
				if not hitActive then return end
				hitActive = false
				
				if connection then
					connection:Disconnect()
					connection = nil
				end
				warn("SERVER: Triggering Explosion!") -- Check if this prints in F9
				-- Stop logic
				Hitbox:Destroy()
				Proxy:Destroy()

				-- Explosion Visuals
				RemotesContainer.ClientEffects:FireAllClients("AceFirstAbility", {
					Attacker = Character,
					SkillType = "explosion", 
					Position = hitPosition,
					Normal = hitNormal,
					ProjectileID = projectileID,
				})

				-- Optional: Secondary AOE Hitbox for the explosion itself
				-- HB:SimpleOnce(...) 

				-- Ground Effect Logic
				if isMapHit then
					local FloorRayParams = RaycastParams.new()
					FloorRayParams.FilterType = Enum.RaycastFilterType.Include -- Switch to Exclude for safety
					FloorRayParams.FilterDescendantsInstances = {workspace.World.Map.Baseplate}
					local floorRay = workspace:Raycast(hitPosition, Vector3.new(0, -10, 0), FloorRayParams)
					if floorRay then
						-- Only spawn if close to ground (e.g., hitPosition is within 10 studs of floor)
						--print("GroundEffects")
						--RemotesContainer.ClientEffects:FireAllClients("AceFirstAbility", {
						--	Attacker = Character,
						--	SkillType = "groundEffect",
						--	Position = floorRay.Position
						--})
					end
				end
			end

			Hitbox.onTouch = function(EnemyCharacter)
				print("Hitbox touched: " .. EnemyCharacter.Name) -- DEBUG 1
				--if hit == true then return end
				local EnemyHumanoid = EnemyCharacter:FindFirstChild("Humanoid")
				if EnemyHumanoid then
					DamageHandler:TakeDamage(Character, EnemyHumanoid, math.random(13, 17), nil, nil, false, false, true, true, true, nil, nil)	
					TriggerExplosion(Proxy.Position, Vector3.new(0, 1, 0), false)
					print("Hit enemy")
					RagdollHandler.ragdoll(EnemyHumanoid, 1.5)

					NewKnockback:Knockback(EnemyCharacter, { KnockbackType = "Velocity", MaxForce = Vector3.new(100000, 50000, 100000), Velocity = HumRP.CFrame.LookVector * 60 + Vector3.new(0, 20, 0) })
					--hit = true
				end
			end

			Hitbox:Start()

			connection = RunService.Heartbeat:Connect(function(dt)
				local now = workspace:GetServerTimeNow()
				local elapsed = now - startTimeThrow
				local currentPos = spawnPos + (direction * speed * elapsed)

				local rayDir = currentPos - lastPos
				local mapHit = workspace:Raycast(lastPos, rayDir, MapRayParams)

				if mapHit then
					connection:Disconnect()
					print("Map Hit Detected: " .. mapHit.Instance.Name) -- DEBUG 2
					TriggerExplosion(mapHit.Position, mapHit.Normal, true)
					return
				end

				if elapsed > lifetime then
					connection:Disconnect()
					print("Projectile timed out - Exploding in air") -- DEBUG 3
					TriggerExplosion(currentPos, Vector3.new(0, 1, 0), false)
					return
				end

				-- Update Proxy Position for Hitbox
				Proxy.Position = Proxy.Position + (direction * speed * dt)
				lastPos = currentPos
			end)
		end)
		
		StartTrack.Stopped:Once(function()
			for _, event in pairs(StartEvents) do
				if event then event:Disconnect() end
			end
			task.delay(.1, function()
				if Character and Character.Parent then
					Character:SetAttribute("AbilityOneCoolDown", false)
				end
			end)

		end)
		
		AnimationService:stopAll(Character)
		AnimationService:playAnimation(Character, StartAnimation)
		
		if holdDuration >= 0.7 then
			StartTrack:AdjustSpeed(1.3) -- Fast Throw
		else
			StartTrack:AdjustSpeed(1.0) -- Normal/Slow Throw
		end
		
	end,
}