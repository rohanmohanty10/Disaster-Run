--Replicated Storage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityThree
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players           = game:GetService("Players")


local LocalPlayer      = Players.LocalPlayer

local Assets = ReplicatedStorage:WaitForChild("Assets")
local Effects = Assets:WaitForChild("Effects")
local VFXFunctions     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local GroundRocks = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler:WaitForChild("GroundRocks"))

local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local Modules = ReplicatedStorage:WaitForChild("Modules")

local activeFX = {}

--Variables
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)


local RandomSeed = Random.new()

local DefaultFilter = { workspace.World.Live, workspace.World.Debris }


local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = {
	workspace.World.Map,
	--workspace.Map:WaitForChild("Miscellaneous"), 
	--workspace.Map.Borders, 
	--workspace.Map:WaitForChild("Destroyable"):WaitForChild("Buildings")
}

local function performRaycast(rayData)
	local orig = rayData.orig
	local dir = rayData.dir
	local raycastParams = RaycastParams.new()

	raycastParams.FilterDescendantsInstances = rayData.Whitelist or rayData.Ignore or DefaultFilter
	if rayData.Whitelist then
		raycastParams.FilterType = Enum.RaycastFilterType.Include
	else
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	end

	if rayData.Blockcast then
		local result = workspace:Blockcast(orig, rayData.Blockcast, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	else
		local result = workspace:Raycast(orig, dir, raycastParams)
		if result then
			return result.Instance, result.Position, result.Material, result.Normal
		else
			return
		end
	end
end


--For sanji ability 4
return function(Params: any) --Got this from default in server script services.
	local character:Model = Params.Attacker --The character btw.
	local humanoid: Humanoid = character:FindFirstChild("Humanoid")

	local skillType = Params.SkillType
	local isLocalPlayer   = LocalPlayer.Character == character
	local rootPart = character and character:FindFirstChild("HumanoidRootPart")
	if not rootPart then return end


	local table1 = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

	local activeTweens = table1
	
	local function GPTween(instance, tweenParams, goalTable, stepType, forceRestart)

		-- If forceRestart is true and a tween is already running on this instance, stop and destroy it
		if forceRestart ~= nil and activeTweens[instance] then
			local existingTween = activeTweens[instance][1]
			existingTween:Stop()
			existingTween:Destroy()
			activeTweens[instance] = nil
		end

		-- Early exit if instance is invalid
		if not instance or instance == nil or instance.Parent == nil then return end

		-- If a tween is already running on this instance, check if any goal properties overlap
		pcall(function()
			if activeTweens[instance] then
				local existingTween = activeTweens[instance][1]
				local existingGoal = activeTweens[instance][2]
				local hasOverlap = false

				for property, _ in goalTable do
					if existingGoal[property] then
						hasOverlap = true
					end
				end

				-- If properties overlap, stop the existing tween
				if hasOverlap then
					existingTween:Stop()
					existingTween:Destroy()
					activeTweens[instance] = nil
				end
			end
		end)

		-- Build tween info table for BoatTween
		local tweenInfo = {
			Time = tweenParams[1],
			EasingStyle = string.gsub(tostring(tweenParams[2]), "Enum.EasingStyle.", ""),
			EasingDirection = string.gsub(tostring(tweenParams[3]), "Enum.EasingDirection.", ""),
			RepeatCount = tweenParams[4],
			Reverses = tweenParams[5],
			DelayTime = tweenParams[6],
			StepType = stepType,
			CustomEventStepFreq = goalTable.CustomEventStepFreq or nil,
			Goal = goalTable,
		}

		-- Create and play the tween
		local tween = BoatTween_upvrGPO:Create(instance, tweenInfo)
		activeTweens[instance] = {tween, goalTable}
		tween:Play()

		-- Clean up when tween completes
		if tween ~= nil and tween.Completed ~= nil then
			local completedConnection
			completedConnection = tween.Completed:Connect(function()
				completedConnection:Disconnect()
				completedConnection = nil

				pcall(function()
					tween:Destroy()
				end)

				activeTweens[instance] = nil
				table.clear(goalTable)
			end)

			-- Clean up if instance is destroyed before tween completes
			instance.Destroying:Once(function()
				if completedConnection then
					completedConnection:Disconnect()
					completedConnection = nil
				end

				pcall(function()
					tween:Destroy()
				end)

				activeTweens[instance] = nil
				table.clear(goalTable)
			end)
		else
			activeTweens[instance] = nil
		end

		return tween
	end
	
	
	if skillType == "jump" then
		if not isLocalPlayer then return end  -- add this

		local hrp = rootPart
		local rootAttachment = hrp:FindFirstChild("RootAttachment")

		-- Attachment to drive AlignOrientation toward camera look
		local velocityAttachment = Instance.new("Attachment")
		velocityAttachment.Name   = "TornadoVelocityAttachment"
		velocityAttachment.Parent = hrp

		local alignOrientation = script.AlignOrientation:Clone()
		alignOrientation.Attachment0     = rootAttachment
		alignOrientation.RigidityEnabled = true
		alignOrientation.Parent          = hrp

		local lockingOrientation = true

		-- Every frame before physics: point character toward camera
		local orientConnection
		--orientConnection = RunService.PreSimulation:Connect(function()
		--	local lookDir = workspace.CurrentCamera.CFrame.LookVector
		--	if lookDir == lookDir and lookDir ~= Vector3.zero then
		--		local flatCFrame = CFrame.lookAlong(Vector3.zero, lookDir)
		--		if flatCFrame.Position == flatCFrame.Position then
		--			velocityAttachment.CFrame = hrp.CFrame.Rotation:Inverse() * flatCFrame
		--			alignOrientation.CFrame   = flatCFrame
		--		end
		--	end
		--	alignOrientation.Enabled = lockingOrientation
		--end)
		orientConnection = RunService.PreSimulation:Connect(function()
			local camLook = workspace.CurrentCamera.CFrame.LookVector

			-- Flatten to horizontal only so looking down doesn't affect movement direction
			local flatLook = Vector3.new(camLook.X, 0, camLook.Z)

			if flatLook.Magnitude < 0.01 then return end -- looking straight up/down, skip
			flatLook = flatLook.Unit

			local flatCFrame = CFrame.lookAlong(Vector3.zero, flatLook)
			velocityAttachment.CFrame = hrp.CFrame.Rotation:Inverse() * flatCFrame
			alignOrientation.CFrame = flatCFrame
			alignOrientation.Enabled = lockingOrientation
		end)



		-- LinearVelocity for movement
		local linearVelocity = script.LinearVelocity:Clone()
		linearVelocity.Attachment0    = velocityAttachment
		linearVelocity.RelativeTo     = Enum.ActuatorRelativeTo.Attachment0
		linearVelocity.VectorVelocity = Vector3.zero
		linearVelocity.Enabled        = true
		linearVelocity.Parent         = hrp

		-- Initial forward surge
		--local surgeTween = TS:Create(linearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
		--	--VectorVelocity = Vector3.new(0, 0, 30)
		--	VectorVelocity = Vector3.new(0, 15, 0)
		--})
		local surgeTween = TS:Create(linearVelocity, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {
			--VectorVelocity = Vector3.new(0, 0, 30)
			VectorVelocity = Vector3.new(0, 15, 0)
		})
		surgeTween:Play()
		--surgeTween.Completed:Once(function()
		--	TS:Create(linearVelocity, TweenInfo.new(3, Enum.EasingStyle.Cubic), {
		--		VectorVelocity = Vector3.new(0, 0, -100)
		--	}):Play()
		--end)

		-- Store for other markers to use
		_G.LinearVelocity    = linearVelocity
		_G.OrientConnection  = orientConnection
		_G.VelocityAttachment = velocityAttachment
		_G.AlignOrientation  = alignOrientation
		_G.LockingOrientation = function(val) lockingOrientation = val end
	end
	
	if skillType == "spinstart"  then
		if not isLocalPlayer then return end  -- add this

		if not _G.LinearVelocity then return end
		-- Kill upward velocity instantly
		_G.LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0)
		TS:Create(_G.LinearVelocity, TweenInfo.new(2, Enum.EasingStyle.Cubic), {
			VectorVelocity = Vector3.new(0, 0, -100)
		}):Play()
		
		
		
	end
	
	if skillType == "up" then
		if not isLocalPlayer then return end  -- add this

		local hrp = rootPart

		-- Kill all the jump-phase _G stuff
		--task.delay(.1, function()
			if _G.LinearVelocity and _G.LinearVelocity.Parent then _G.LinearVelocity:Destroy() end
			if _G.OrientConnection then _G.OrientConnection:Disconnect() end
			if _G.VelocityAttachment and _G.VelocityAttachment.Parent then _G.VelocityAttachment:Destroy() end
			if _G.AlignOrientation and _G.AlignOrientation.Parent then _G.AlignOrientation:Destroy() end
			_G.LinearVelocity     = nil
			_G.OrientConnection   = nil
			_G.VelocityAttachment = nil
			_G.AlignOrientation   = nil
		--end)
		

		character:SetAttribute("FlameBarrageActive", false)
		character:SetAttribute("FlameBarrageActive", nil)

		local Bind: Accessory = character:WaitForChild(Params.BindName, 5)
		if not Bind then return end

		local attachment = Instance.new("Attachment")
		attachment.Name = "WhirlwindUpAttachment"
		attachment.Parent = hrp

		local lv = Instance.new("LinearVelocity")
		lv.Attachment0 = attachment
		lv.RelativeTo = Enum.ActuatorRelativeTo.World
		lv.MaxForce = 40000
		--lv.VectorVelocity = Vector3.new(0, 2, 0)
		
		local lookDir = hrp.CFrame.LookVector
		lv.VectorVelocity = Vector3.new(lookDir.X * 50, 2, lookDir.Z * 50) -- 20 = forward speed, tweak to taste
		
		lv.Parent = hrp
		
		--added
		--local lookDir = hrp.CFrame.LookVector
		--lv.VectorVelocity = Vector3.new(lookDir.X * 2, 1, lookDir.Z * 2)
		--local forwardBurst = Instance.new("LinearVelocity")
		--forwardBurst.Attachment0 = attachment
		--forwardBurst.RelativeTo = Enum.ActuatorRelativeTo.World
		--forwardBurst.MaxForce = 40000
		--forwardBurst.VectorVelocity = Vector3.new(lookDir.X, 0, lookDir.Z) * 60
		--forwardBurst.Parent = hrp
		--Debris:AddItem(forwardBurst, 0.3)
		
		Debris:AddItem(lv, 1.4)
		Debris:AddItem(attachment, 1.4)

		local velocity = 1.3
		if not workspace:Raycast(hrp.Position, Vector3.new(0, -15, 0), MapRayParams) then
			velocity = 1.1
			Debris:AddItem(lv, 0.3)
			Debris:AddItem(attachment, 0.3)
		end

		local startTime = tick()
		local stopLoop

		stopLoop = shared.loop(function()
			if not lv or not lv.Parent or tick() - startTime > 5 or not Bind.Parent then
				if lv and lv.Parent then lv:Destroy() end
				if attachment and attachment.Parent then attachment:Destroy() end
				return stopLoop()
			else
				if velocity >= 1 then
					lv.VectorVelocity = lv.VectorVelocity * Vector3.new(1, velocity, 1)
				else
					lv.VectorVelocity = lv.VectorVelocity * velocity
				end
				velocity = velocity * 0.99
			end
		end, 60)
	end

	if skillType == "down" then
		if not isLocalPlayer then return end  -- add this

		local hrp = rootPart
		local easingTime = 0.27560944733796294
		--local GoalCF: CFrame = Params.GoalCF
		--if not GoalCF then return end

		--local cframeValue = Instance.new("CFrameValue")
		--cframeValue.Value = hrp.CFrame
		--TS:Create(cframeValue, TweenInfo.new(easingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
		--	Value = GoalCF
		--}):Play()
		
		
		local GoalPos = hrp.Position - Vector3.new(0, 50, 0)
		local GroundRay = workspace:Raycast(hrp.Position, Vector3.new(0, -100, 0), MapRayParams)
		if GroundRay then
			GoalPos = GroundRay.Position + Vector3.new(0, 3, 0)
		end
		local GoalCF = CFrame.lookAlong(GoalPos, hrp.CFrame.LookVector)

		local cframeValue = Instance.new("CFrameValue")
		cframeValue.Value = hrp.CFrame
		TS:Create(cframeValue, TweenInfo.new(easingTime, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Value = GoalCF
		}):Play()
		
		

		local stepConnection
		stepConnection = RunService.Heartbeat:Connect(function()
			if not character or not character.Parent then
				stepConnection:Disconnect()
				return
			end
			local currentCF = hrp.CFrame
			local valueCF = cframeValue.Value
			local components = { currentCF:GetComponents() }
			components[1] = valueCF.X
			components[2] = valueCF.Y
			components[3] = valueCF.Z
			hrp.CFrame = CFrame.new(table.unpack(components))
		end)

		task.delay(easingTime, function()
			stepConnection:Disconnect()
			cframeValue:Destroy()
		end)
		local landed = false
		local groundConnection
		groundConnection = RunService.PostSimulation:Connect(function()
			if landed then return end
			local instance, position, normal = shared.getRayFloor(hrp.CFrame, 6)
			if instance then
				landed = true
				groundConnection:Disconnect()
				-- fire your VFX here
				ReplicatedStorage.Remotes.MoveSkills.SpectreDropLanded:FireServer(instance, position, normal)
			end
		end)

		-- Fallback in case raycast never hits
		--task.delay(easingTime + 0.3, function()
		--	if not landed then
		--		landed = true
		--		if groundConnection then groundConnection:Disconnect() end
		--		ReplicatedStorage.Remotes.SpectreDropLanded:FireServer()
		--	end
		--end)
		
	end
	
	if skillType == "explosion" then
		-- Rebuild the missing context (dustCFrame + groundPart) via a downward raycast
		-- Rebuild the missing context (dustCFrame + groundPart) via a downward raycast
		local impactPos  = rootPart.Position
		local groundPart = nil
		local groundRay  = workspace:Raycast(rootPart.Position, Vector3.new(0, -50, 0), MapRayParams)
		if groundRay then
			impactPos  = groundRay.Position
			groundPart = groundRay.Instance
		end

		local groundColor = (groundPart and groundPart:IsA("BasePart")) and groundPart.Color or Color3.fromRGB(120, 120, 120)

		-- Upright frame at the impact point, facing the character's look direction.
		-- No pitch tilt → local Y stays world-up → the shard fan sweeps a flat horizontal circle.
		local dir        = rootPart.CFrame.LookVector
		local dustCFrame = CFrame.new(impactPos, impactPos + dir)

		local ORANGE = Color3.fromRGB(255, 81, 0)
		
		local VARIANT_DUST_COLOR = {
			-- ["YourGreyConcreteVariant"] = Color3.fromRGB(120, 120, 120),
			-- ["YourSandVariant"]         = Color3.fromRGB(196, 178, 130),
			["StylizedConBrick"] = Color3.fromRGB(90, 96, 112),
			["FloorConcrete3"] = Color3.fromRGB(92, 105, 132),
		}

		local function groundDustColor(part)
			if not (part and part:IsA("BasePart")) then
				return Color3.fromRGB(120, 120, 120)
			end
			-- 1. explicit per-part override: set a Color3 attribute "DustColor" in Studio
			local attr = part:GetAttribute("DustColor")
			if typeof(attr) == "Color3" then
				return attr
			end
			-- 2. by variant name
			if part.MaterialVariant ~= "" and VARIANT_DUST_COLOR[part.MaterialVariant] then
				return VARIANT_DUST_COLOR[part.MaterialVariant]
			end
			-- 3. fall back to the part's own tint
			return part.Color
		end
		
		for i = 1, 8 do
			local angle     = math.rad(i * 45)
			local shardCF   = dustCFrame * CFrame.Angles(0, angle, 0) * CFrame.new(0, -2, 22.5)
			local facingCF  = CFrame.new(shardCF.Position, dustCFrame.Position) * CFrame.Angles(0, math.pi / 2, 0)

			-- Animated shard blade
			local shard = script.Cloud:Clone()
			shard.CFrame      = facingCF
			shard.Color       =  groundDustColor(groundPart)
			shard.Mesh.Offset = Vector3.new(0, 0, 0)
			shard.Mesh.Scale  = Vector3.new(0, 0, 0)
			shard.Parent      = workspace.World.Visuals

			GPTween(shard.Mesh,
				{ 0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true, 0 },
				{ Scale = Vector3.new(45, 45, 45), Offset = Vector3.new(10, 0, 0) }
			)
			GPTween(shard,
				{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
				{ CFrame = shard.CFrame * CFrame.Angles(0, 0, -math.pi / 2) }
			)
			GPTween(shard,
				{ 1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
				{ Transparency = 1 }
			)
			GpDestroy(shard, 5)

			-- Small flash sphere at each shard position
			local flash = script.Part:Clone()
			flash.CFrame     = facingCF
			flash.Mesh.Scale = Vector3.new(17.5, 17.5, 17.5)
			flash.Parent     = workspace.World.Visuals

			GPTween(flash.Mesh,
				{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
				{ Scale = Vector3.new(35, 35, 35) }
			)
			GPTween(flash,
				{ 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0 },
				{ Transparency = 1, Color = ORANGE }
			)
			GpDestroy(flash, 0.25)
		end
		
		
		local folder

		folder = Instance.new("Folder")
		folder.Parent = workspace.World.Visuals
		
		local impact = script.Impact2:Clone()
		local impact2 = script.ImpactFx:Clone()
		--local floor = script.Floor:Clone()
		--local floor2 = script.Floor2:Clone()

		
		impact.Parent = folder
		impact2.Parent = folder
		--floor.Parent = folder
		--floor2.Parent = folder

		
		impact.CFrame = rootPart.CFrame  * CFrame.new(0,-3,0)
		impact2.CFrame = rootPart.CFrame  * CFrame.new(0,-3,0)
		--floor.CFrame = rootPart.CFrame  * CFrame.new(0,-3,0)
		--floor2.CFrame = rootPart.CFrame  * CFrame.new(0,-2,0)


		
		VFXFunctions.EmitDescendants(impact)
		VFXFunctions.EmitDescendants(impact2)
		--VFXFunctions.EnableDescendants(floor)
		--VFXFunctions.EnableDescendants(floor2)

		task.delay(3, function()
			--VFXFunctions.DisableDescendants(floor)
			--VFXFunctions.DisableDescendants(floor2)

		end)
		
		task.delay(3, function()
			--_G.destroy(folder, 1.5)
			GpDestroy(folder, .2)

		end)


	end
	
	if skillType == "spinEffects" then
		local TILT_ANGLE = math.rad(30) -- Change this one value to adjust the diagonal angle

		local LIGHT_TWEEN_INFO = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
		local activeKicks = {}

		local function setEffects(parent, enabled, brightness)
			for _, child in parent:GetDescendants() do
				if child:IsA("ParticleEmitter") then
					child.Enabled = enabled
				elseif child:IsA("PointLight") then
					local tween = TS:Create(child, LIGHT_TWEEN_INFO, { Brightness = brightness })
					tween.Completed:Once(function()
						tween:Destroy()
					end)
					tween:Play()
				end
			end
		end

		local function spawnOrbitTrail(cache, rootPart, character)
			local trail = cache.Trail:Clone()
			Debris:AddItem(trail, 3.75)
			local tiltCFrame = rootPart.CFrame * CFrame.Angles(TILT_ANGLE, 0, 0)
			trail.CFrame = tiltCFrame
			trail.Parent = workspace.World.Visuals
			local angle     = math.random(-360, 360)
			local angleStep = -math.random(135, 195) / 10
			local radius    = math.random(5, 8)
			local yOffset   = math.random(0, 1)
			local origin    = tiltCFrame.Position + Vector3.new(0, yOffset, 0)
			for _ = 1, 18 do
				local radAngle = math.rad(angle)
				local x = math.sin(radAngle) * radius
				local y = math.random(-10, 10) / 100
				local z = math.cos(radAngle) * radius
				trail.Position = origin + tiltCFrame:VectorToWorldSpace(Vector3.new(x, y, z))
				angle = angle + angleStep
				task.wait()
			end
			setEffects(trail, false, 0)
		end

		local function attachLegParticles(cache, character, rootPart)
			for _, legName in { "Right Leg", "Left Leg" } do
				local leg = rootPart.Parent[legName]
				for _, particle in cache.LegParticles:GetChildren() do
					local clone = particle:Clone()
					Debris:AddItem(clone, 5)
					clone.Parent = leg
					task.delay(1.5, function()
						clone.Enabled = false
					end)
				end
			end
		end

		local cache = script.Spinning

		activeKicks[character] = true

		local mainVisual = cache.Spin:Clone()
		--mainVisual.CFrame = rootPart.CFrame * CFrame.Angles(TILT_ANGLE, 0, 0)
		mainVisual.CFrame = rootPart.CFrame

		mainVisual.Name = character.Name .. "'s kicks"
		mainVisual.Parent = workspace.World.Visuals
		mainVisual.Weld.C0 = CFrame.Angles(math.rad(-30), 0, 0)

		mainVisual.Weld.Part0 = mainVisual
		mainVisual.Weld.Part1 = rootPart
		setEffects(mainVisual, true, 3)

		attachLegParticles(cache, character, rootPart)

		for _ = 1, 12 do
			if not activeKicks[character] then break end
			task.spawn(spawnOrbitTrail, cache, rootPart, character)
			task.wait(0.075)
		end

		setEffects(mainVisual, false, 0)
		Debris:AddItem(mainVisual, 1)
		
		
	end
	
	
	--if skillType == "up" then
	--	local hrp = rootPart
	--	character:SetAttribute("FlameBarrageActive", false)
	--	character:SetAttribute("FlameBarrageActive", nil)
		
	--	_G.LockingOrientation(false)
	--	_G.LinearVelocity.VectorVelocity = Vector3.new(0, 10, 0)
	--	local upTween = TS:Create(_G.LinearVelocity, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
	--		VectorVelocity = Vector3.new(0, 20, -5)
	--	})
	--	upTween:Play()
		
	--end
	--if skillType == "down" then
	--	local hrp = rootPart
	--	TS:Create(_G.LinearVelocity, TweenInfo.new(0.2), {
	--		VectorVelocity = Vector3.new(0, 10, -15)
	--	}):Play()

	--	-- Manual gravity until Y velocity goes negative, then dive
	--	local gravConn
	--	gravConn = RunService.PreSimulation:Connect(function(dt)
	--		if not _G.LinearVelocity then gravConn:Disconnect() return end
	--		_G.LinearVelocity.VectorVelocity -= Vector3.new(0, 350 * dt, 0)
	--		if _G.LinearVelocity.VectorVelocity.Y < 0 then
	--			gravConn:Disconnect()
	--			TS:Create(_G.LinearVelocity, TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
	--				VectorVelocity = Vector3.new(0, -60, -5)
	--			}):Play()
	--		end
	--	end)
		
	--	local rayParams = RaycastParams.new()
	--	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	--	rayParams.FilterDescendantsInstances = { character }

	--	local diveConnection
	--	diveConnection = RunService.PostSimulation:Connect(function()
	--		local hit, hitPosition = shared.getRayFloor(hrp.CFrame, 8)
	--		if hit then
	--			--diveConnection:Disconnect()
	--			--downDash:Destroy()
	--			--RemotesContainer.GrandTornadoLanded:FireServer()

	--			diveConnection:Disconnect()
	--			--downDash:Destroy()

	--			-- clean up movement
	--			if _G.LinearVelocity then _G.LinearVelocity:Destroy() end
	--			if _G.OrientConnection then _G.OrientConnection:Disconnect() end
	--			if _G.VelocityAttachment then _G.VelocityAttachment:Destroy() end
	--			if _G.AlignOrientation then _G.AlignOrientation:Destroy() end
	--			_G.LinearVelocity     = nil
	--			_G.OrientConnection   = nil
	--			_G.VelocityAttachment = nil
	--			_G.AlignOrientation   = nil

	--			--RemotesContainer.GrandTornadoLanded:FireServer()


	--		end
	--	end)
	--end
	
	if skillType == "FlameBarrage" then
		character:SetAttribute("FlameBarrageActive", true)

		local function animateFireSegment(part, travelDist, sizeScale, thinness)
			local targetSize = part.Size * sizeScale
			local originalZ  = part.Size.Z
			part.Size = Vector3.new(thinness, thinness, originalZ)

			GPTween(part, {0.1, "Quad", Enum.EasingDirection.Out, 0, false, 0}, {
				Size         = targetSize + Vector3.new(0.2, 0.2, 5),
				Transparency = 1,
				CFrame       = part.CFrame * CFrame.new(0, 0, -travelDist),
			})
		end

		while character:GetAttribute("FlameBarrageActive") do
			-- Alternate between two fire colours randomly
			local fireColor = Color3.fromRGB(255, 114, 114)
			if math.random(1, 2) == 1 then
				fireColor = Color3.fromRGB(255, 81, 0)
			end

			local spawnCFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, -0.5, 0)

			-- Clone the trail model and orient it downward/outward at a random angle
			local trailModel  = script.Model:Clone()
			local pitchAngle  = math.rad(-math.random(30, 50))
			local yawAngle    = math.rad(math.random(-15, 15))
			local rollAngle   = math.random(-360, 360)
			local spawnOffset = CFrame.new(
				math.random(-1000, 1000) / 1000,
				math.random(-1000, 1000) / 1000,
				-4
			)
			trailModel:PivotTo(spawnCFrame * CFrame.Angles(pitchAngle, yawAngle, rollAngle) * spawnOffset)

			-- Randomise the length of this segment
			local sizeScale  = math.random(120, 150) / 100
			local thinness   = math.random(100, 200) / 1000
			local lengthMult = math.random(900, 1100) / 1700

			-- Apply the random length to both the core part and the flame mesh
			local corePart = trailModel.PrimaryPart
			corePart.Size  = Vector3.new(corePart.Size.X, corePart.Size.Y, corePart.Size.Z * lengthMult)

			local flamePart = trailModel.Flame
			flamePart.Size  = Vector3.new(flamePart.Size.X, flamePart.Size.Y, flamePart.Size.Z * lengthMult)
			flamePart.CFrame = flamePart.CFrame * CFrame.new(0, 0, -0.75)

			trailModel.Parent = workspace.World.Visuals

			-- Animate both parts outward
			animateFireSegment(corePart,  8, sizeScale, thinness)
			animateFireSegment(flamePart, 8, sizeScale, thinness)

			-- Shockwave ring at the tip of the trail
			local ringCFrame = corePart.CFrame
				* CFrame.new(0, 0, -14)
				* CFrame.Angles(math.pi / 2, math.random(-360, 360), 0)
			local ringSize = math.random(500, 1000) / 100

			--_G.PlayEffect("Shockwave2", nil,
			--	ringCFrame * CFrame.new(0, 1, 0),
			--	ringCFrame * CFrame.Angles(0, -math.pi, 0),
			--	BrickColor.new(fireColor),
			--	Vector3.new(ringSize, 0.3, ringSize),
			--	Vector3.new(2, 0.3, 2),
			--	0.1, 0, Enum.EasingStyle.Back,
			--	fireColor, Enum.Material.Neon, "Rings"
			--)

			GpDestroy(trailModel, 0.1)

			-- Scattered ember spheres around the spawn point
			--_G.PlayEffect("Spheres", nil, {
			--	startSize = Vector3.new(0, 0, 0),
			--	xrange    = 6.667,
			--	yrange    = 8,
			--	zrange    = 6.667,
			--	cf        = spawnCFrame * CFrame.Angles(math.pi / 4, 0, 0) * CFrame.new(0, -3, 0),
			--	ti        = 0.2,
			--	ti2       = 0.1,
			--	range     = 0,
			--	minThick  = 0.2,
			--	maxThick  = 5,
			--	part      = nil,
			--	color     = fireColor,
			--	am        = 1,
			--})

			game["Run Service"].Heartbeat:Wait()

			
		end
		


	end
	if skillType == "FlameBarrageStop" then
		character:SetAttribute("FlameBarrageActive", false)
		character:SetAttribute("FlameBarrageActive", nil)
	end
	
	local VFX = require(game.ReplicatedStorage.Modules.ClientEffects.G_VFX)
	local Essentials = require(game.ReplicatedStorage.Modules.ClientEffects.G_Essentials)

	local Emit        = VFX.Emit
	local TweenCreate = Essentials.Tween     -- re-exported from Essentials
	local Ess         = Essentials           -- if you also used Ess.Destroy: VFX.Destroy works
	
	if skillType == "GroundVFX" then
		--local ExplosionGroundMarks = script["ExplosionGroundMarks"]:Clone()
		--ExplosionGroundMarks.Anchored   = true
		--ExplosionGroundMarks.CanCollide = false
		--ExplosionGroundMarks.Massless   = true

		local Explosion = script["Explosion"]:Clone()
		Explosion.Anchored   = true
		Explosion.CanCollide = false
		Explosion.Massless   = true 

		-- handle either a CFrame or a Vector3 coming in
		local givenCF = typeof(Params.Position) == "CFrame"
			and Params.Position
			or CFrame.new(Params.Position)

		local rayParams = RaycastParams.new()
		rayParams.FilterType = Enum.RaycastFilterType.Include
		rayParams.FilterDescendantsInstances = { workspace.World.Map }
		rayParams.IgnoreWater = true

		local origin = givenCF.Position + Vector3.new(0, 5, 0)          -- start slightly above
		local hit = workspace:Raycast(origin, Vector3.new(0, -1000, 0), rayParams)

		if hit then
			--ExplosionGroundMarks.CFrame = givenCF.Rotation + hit.Position - Vector3.new(0, ExplosionGroundMarks.Size.Y / 2, 0)
			Explosion.CFrame = givenCF.Rotation + hit.Position - Vector3.new(0, Explosion.Size.Y / 2, 0)
		else
			--ExplosionGroundMarks.CFrame = givenCF
			Explosion.CFrame = givenCF
		end

		--ExplosionGroundMarks.Parent = workspace.World.Visuals
		Explosion.Parent = workspace.World.Visuals

		Emit(Explosion:GetDescendants(), true)

		task.spawn(function()
			task.wait(1.5)
			local FADE = 3   -- seconds to fade out
			local fadeInfo = TweenInfo.new(FADE, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

			local function fade(inst)
				if inst:IsA("Decal") then
					TweenCreate(inst, fadeInfo, { Transparency = 1 })
				elseif inst:IsA("BasePart") and inst.Transparency < 1 then
					TweenCreate(inst, fadeInfo, { Transparency = 1 })
				elseif inst:IsA("Light") then              -- PointLight / SpotLight / SurfaceLight And has a custom tween time to make it disappear quicker
					TweenCreate(inst, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Range = 0, Brightness = 0 })
				end
			end

			--fade(ExplosionGroundMarks)                              -- the part itself, if it's visible
			--for _, inst in ExplosionGroundMarks:GetDescendants() do -- any decals / sub-parts
			--	fade(inst)
			--end

			fade(Explosion)
			for _, inst in Explosion:GetDescendants() do
				fade(inst)
			end

			--Ess.Destroy(ExplosionGroundMarks, FADE)                 -- remove it exactly when the fade ends
			Ess.Destroy(Explosion, FADE)
		end)
	end
end