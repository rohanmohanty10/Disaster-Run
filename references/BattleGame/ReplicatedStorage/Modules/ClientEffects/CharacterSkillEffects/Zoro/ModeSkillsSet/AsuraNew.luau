local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris            = game:GetService("Debris")
local TS                = game:GetService("TweenService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local ServerStorage = game:GetService("ServerStorage")

local LocalPlayer      = Players.LocalPlayer
local VFXFunctions     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local ParticlesModule     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler.Particles)

local GpDestroy        = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local BoatTween        = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)
local RemotesContainer = ReplicatedStorage.Remotes
local Trove = require(ReplicatedStorage.Modules.Trove)


local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local SlashModule = require(script.SlashModule)
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)
local Sounds = ReplicatedStorage.Assets.Sounds
local MoveSounds = Sounds.Characters

local activeSlashes = {}
local folder
local RandomSeed = Random.new()

local MapRayParams = RaycastParams.new()
MapRayParams.FilterType = Enum.RaycastFilterType.Include
MapRayParams.FilterDescendantsInstances = {
	workspace.World.Map,
}


-- CHANGED: was a single shared `local Dragon = nil` upvalue — that broke if two
-- Zoros used Asura at overlapping times. Now keyed per attacker, and it stores
-- the SERVER-owned dragon that arrives through the remote (we no longer clone one).
local activeDragons = {}

local function PlayMesh(MeshContainer)
	task.spawn(function()
		local Model = MeshContainer.Model
		local TweenInformation = MeshContainer.Info or TweenInfo.new(1, Enum.EasingStyle.Sine)
		local StartPart = Model:FindFirstChild("Start")
		local EndPart = Model:FindFirstChild("End")
		local NoDelete = MeshContainer.Stay
		local GoalCFrame = MeshContainer.Anchor
		local GoalTransparency = MeshContainer.EndT or 1
		local ExtraLifetime = MeshContainer.Del
		local Skip = MeshContainer.Skip


		Model.PrimaryPart = StartPart


		if not Skip then
			for _, eyes in pairs(Model:GetChildren()) do
				if eyes:IsA("BasePart") then
					eyes.CanCollide = false
					eyes.Anchored = true
				end
			end
		end

		if GoalCFrame then
			Model:PivotTo(GoalCFrame)
		end

		if MeshContainer.T then
			StartPart.Transparency = MeshContainer.T
		end


		EndPart.Transparency = 1
		Model.Parent = workspace.Thrown


		local StartDecal = StartPart:FindFirstChildOfClass("Decal")
		local StartMesh = StartPart:FindFirstChildOfClass("SpecialMesh")
		local EndMesh = EndPart:FindFirstChildOfClass("SpecialMesh")
		local EndDecal = EndPart:FindFirstChildOfClass("Decal")

		if EndDecal and not Skip then
			EndDecal.Transparency = 1
		end


		local Tween = nil

		if ExtraLifetime then
			TS:Create(StartPart, TweenInformation, {
				Size = EndPart.Size, 
				CFrame = EndPart.CFrame
			}):Play()

			task.delay(ExtraLifetime, function()
				Tween = TS:Create(StartPart, TweenInformation, {
					Transparency = GoalTransparency
				})

				Tween:Play()

				if StartDecal then
					for _, Decal in pairs(StartPart:GetChildren()) do
						if Decal:IsA("Decal") then
							TS:Create(Decal, TweenInformation, {
								Transparency = GoalTransparency
							}):Play()
						end
					end
				end

				if StartMesh then
					Tween = TS:Create(StartMesh, TweenInformation, {
						Scale = EndMesh.Scale
					}):Play()
				end
			end)

		else
			if StartMesh then
				TS:Create(StartMesh, TweenInformation, {
					Scale = EndMesh.Scale
				}):Play()
			end

			if StartDecal then
				for _, randomVFX in pairs(StartPart:GetChildren()) do
					if randomVFX:IsA("Decal") then
						TS:Create(randomVFX, TweenInformation, {
							Transparency = GoalTransparency
						}):Play()
					end
				end

				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size, 
					CFrame = EndPart.CFrame
				})

				Tween:Play()
			else
				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size, 
					Transparency = GoalTransparency, 
					CFrame = EndPart.CFrame
				})

				Tween:Play()
			end
		end


		if not NoDelete then
			if ExtraLifetime then
				task.wait(ExtraLifetime + 0.1)
			end

			Tween.Completed:Connect(function()
				Model:Destroy()
			end)
		end
	end)
end

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType       = argumentData.SkillType
	local character       = attacker
	local isLocalPlayer   = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local table = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)
	local activeTweens = table

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

	-- Weld a Motor6D from part0 to part1 with optional C0/C1
	local alwaysHidden = {"Sword1", "Sword2", "Handle", "VFXPart", "FakeHead", "Hitbox_LeftArm", 
		"Hitbox_RightArm", "Hitbox_RightLeg", "Hitbox_LeftLeg", "Hitbox_Torso", "HumanoidRootPart", "Trail", "Hitbox_Head",
		"Right ArmC1", "Left ArmC1", "Right ArmC2", "Left ArmC2",
	}

	local function shouldAlwaysHide(name)
		for _, n in ipairs(alwaysHidden) do
			if name == n then return true end
		end
		return false
	end
	--if skillType == "OniGiri" then
	--	local targetPosition = argumentData.targetPosition
	--	local atkCFrame = hrp.CFrame
	--	if targetPosition then
	--		atkCFrame = CFrame.lookAt(hrp.Position, Vector3.new(targetPosition.X, hrp.Position.Y, targetPosition.Z))
	--	end
	--	SlashModule.Play(script.OniGiri, character, atkCFrame, isLocalPlayer)
	--end
	if skillType == "OniGiri" then
		local attackerLook = argumentData.attackerLook
		local atkCFrame
		if attackerLook then
			local flat = Vector3.new(attackerLook.X, 0, attackerLook.Z)
			if flat.Magnitude > 0.01 then
				atkCFrame = CFrame.lookAlong(hrp.Position, flat.Unit)
			else
				atkCFrame = hrp.CFrame
			end
		else
			atkCFrame = hrp.CFrame
		end
		atkCFrame = atkCFrame * CFrame.new(0, 0, 20)
		SlashModule.Play(script.OniGiri, character, atkCFrame, isLocalPlayer)
	end

	if skillType == "untransparent" then
		local targets = {"ZoroSwordsC1", "ZoroSwordsC2", "Right ArmC1", "Left ArmC1", "HeadC1", "Right ArmC2", "Left ArmC2", "HeadC2"}
		for _, name in ipairs(targets) do
			local obj = character:FindFirstChild(name)
			if obj then
				if obj:IsA("BasePart") and not shouldAlwaysHide(obj.Name) then
					obj.Transparency = 0
				end
				for _, part in ipairs(obj:GetDescendants()) do
					if (part:IsA("BasePart") or part:IsA("MeshPart")) and not shouldAlwaysHide(part.Name) then
						part.Transparency = 0
					end
				end
			end
		end
	end

	if skillType == "transparent" then
		local targets = {"ZoroSwordsC1", "ZoroSwordsC2", "Right ArmC1", "Left ArmC1", "HeadC1", "Right ArmC2", "Left ArmC2", "HeadC2"}
		for _, name in ipairs(targets) do
			local obj = character:FindFirstChild(name)
			if obj then
				if obj:IsA("BasePart") then
					obj.Transparency = 1
				end
				for _, part in ipairs(obj:GetDescendants()) do
					if part:IsA("BasePart") or part:IsA("MeshPart") then
						part.Transparency = 1
					end
				end
			end
		end
	end

	if skillType == "1" then
		for _, part in ipairs(character:GetDescendants()) do
			if part:IsA("BasePart") or part:IsA("MeshPart") then
				part.Transparency = 1
			end
		end
	end

	if skillType == "0" then
		for _, part in ipairs(character:GetDescendants()) do
			if (part:IsA("BasePart") or part:IsA("MeshPart")) and not shouldAlwaysHide(part.Name) then
				part.Transparency = 0
			end
		end
		-- also restore accessory handles (hair/hats) — "Handle" is in alwaysHidden for swords,
		-- but that wrongly keeps accessory handles hidden too
		for _, acc in character:GetDescendants() do
			if acc:IsA("Accessory") then
				local handle = acc:FindFirstChild("Handle")
				if handle and handle:IsA("BasePart") then
					handle.Transparency = 0
				end
			end
		end
	end


	if skillType == "move" then
		local Character: Model = attacker
		--local HumRP: BasePart


		local Speed = Instance.new("IntValue")
		Speed.Value = 80

		local Velocity = Instance.new("BodyVelocity")
		Velocity.Parent = hrp
		Velocity.MaxForce = Vector3.new(math.huge, 0, math.huge)


		local Connection
		Connection = RunService.RenderStepped:Connect(function()
			if not Velocity.Parent then
				return Connection:Disconnect()
			end

			Velocity.Velocity = hrp.CFrame.LookVector * Speed.Value
		end)


		TS:Create(Speed, TweenInfo.new(0.75), { Value = 70 }):Play()

		task.delay(0.75, function()
			Speed.Value = 80

			TS:Create(Speed, TweenInfo.new(0.55), { Value = 70} ):Play()
		end)

		task.delay(2.8, function()
			Speed.Value = 80

			TS:Create(Speed, TweenInfo.new(0.6), { Value = 5 }):Play()
		end)


		Debris:AddItem(Velocity, 3.2)
	end

	if skillType == "tp" then
		--print("TP fired")
		--print("script.tp exists:", script:FindFirstChild("tp"))
		--print("Torso exists:", character:FindFirstChild("Torso"))
		local tpFX = script.tp:Clone()
		--print("tpFX cloned:", tpFX)
		tpFX.CFrame = character.Torso.CFrame
		tpFX.Parent = workspace.World.Visuals
		--print("tpFX parented to:", tpFX.Parent)
		VFXFunctions.EmitDescendants(tpFX)
		Debris:AddItem(tpFX, 1.5)
	end

	if skillType == "slash1" then
		local enemyChar = argumentData.enemyChar
		if enemyChar then
			local torso = enemyChar:FindFirstChild("Torso")
			if torso then
				local slashes = script.Slashes:Clone()
				slashes.CFrame = torso.CFrame
				slashes.Weld.Part0 = torso
				slashes.Parent = workspace.World.Visuals
				activeSlashes[attacker] = slashes
				task.delay(8, function()
					Debris:AddItem(slashes, 3) -- cleanup fallback
					task.delay(2, function()
						activeSlashes[attacker] = nil
					end)

				end)
				VFXFunctions.EmitDescendants(slashes.slash1)
			end
		end
	end

	if skillType == "slash2" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash2)
		end
	end

	if skillType == "slash3" then

		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash3)
		end
	end

	if skillType == "slash4" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash4)
		end
	end

	if skillType == "slash5" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash5)
		end
	end

	if skillType == "slash6" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash6)
		end
	end

	if skillType == "slash7" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash7)
		end
	end

	if skillType == "slash8" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash8)
		end
	end

	if skillType == "slash9" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash9)
		end
	end

	if skillType == "slash10" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash10)
		end
	end

	if skillType == "slash11" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash11)
		end
	end

	if skillType == "slash12" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash12)
		end
	end

	if skillType == "slash13" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash13)
		end
	end

	if skillType == "slash14" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash14)
		end
	end

	if skillType == "slash15" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash15)
		end
	end

	if skillType == "slash16" then
		local slashes = activeSlashes[attacker]
		if slashes then
			VFXFunctions.EmitDescendants(slashes.slash16)
		end
	end


	if skillType == "spin" then
		local swordModels = {"ZoroSwords", "ZoroSwordsC1", "ZoroSwordsC2"}
		for _, modelName in ipairs(swordModels) do
			local zoroSwords = character:FindFirstChild(modelName)
			if zoroSwords then
				for _, accessory in ipairs(zoroSwords:GetChildren()) do
					local sword = accessory:FindFirstChild("Sword", true)
					if sword then
						local trail = script.CharFX.LegTrail:Clone()
						trail.Parent = sword
						Debris:AddItem(trail, 2)
					end
				end
			end
		end
	end

	if skillType == "DragonAnim" then
		-- CHANGED: the dragon is now spawned, animated, and destroyed BY THE SERVER
		-- (so destruction can follow it). We just grab the replicated instance here.
		-- No clone, no PivotTo, no LoadAnimation, no transparency loop — the server
		-- already parented it invisible and started the animation, which each client
		-- simulates locally.
		local serverDragon = argumentData.Dragon
		if serverDragon then
			activeDragons[attacker] = serverDragon
		end
	end


	if skillType == "DragonStart" then
		-- CHANGED: look up the server dragon per attacker. Guard because a client
		-- that streamed in late (or missed DragonAnim) won't have it yet.
		local Dragon = activeDragons[attacker]
		if not Dragon or not Dragon.Parent then return end
		-- CHANGED: removed Dragon:PivotTo(hrp.CFrame) — the server owns the
		-- dragon's position now; a local pivot would fight replication.

		local DragonLoop
		local DragonStart
		local DragonUser

		local Character = attacker
		local HumRP: BasePart = Character.HumanoidRootPart
		--local AwakeningMusic: Sound


		local AssetsFolder = script.Dragon
		local Janitor = Trove.new()
		task.delay(10, function()
			Janitor:Destroy()
		end)
		local LocalCharacter = isLocalPlayer
		local LocalChar = LocalPlayer.Character

		--if Character == LocalCharacter then
		--	TS:Create(LocalPlayer, TweenInfo.new(2, Enum.EasingStyle.Sine), {
		--		CameraMinZoomDistance = 37.5
		--	}):Play()
		--end


		--local Dragon = AssetsFolder.DragonNew:Clone()

		for _, BasePart in Dragon:GetDescendants() do
			if BasePart:IsA("MeshPart") then
				BasePart.Transparency = 0
			end
		end

		--local DragonCamera = Instance.new("ObjectValue")
		--DragonCamera.Value = Dragon
		--DragonCamera.Name = "DragonCamera"
		--DragonCamera.Parent = Character

		--for _, BasePart in Dragon:GetDescendants() do
		--	if BasePart:IsA("BasePart") then
		--		BasePart.Transparency = 1
		--	end
		--end

		--Dragon.Parent = workspace.World.Visuals

		--Character:PivotTo(Params.cfr)
		--Dragon:PivotTo(Params.cfr * CFrame.new(1.37329102E-4, 10.4784584, 20.4187012))
		--Dragon:PivotTo(hrp.CFrame)


		--local DragonAnimation = Dragon.AnimationController:LoadAnimation(Dragon.DragonAnim)
		--DragonAnimation:Play(0)
		--DragonAnimation:Stop(0)


		--shared.sfx({
		--	SoundId = "rbxassetid://131924802317571", 
		--	Parent = Dragon.RootPart.Root.LowerJaw.LowerMouth, 
		--	Volume = 10
		--}):Play()

		--if AwakeningMusic then
		--	AwakeningMusic.Parent = Dragon.RootPart.Root.LowerJaw.LowerMouth
		--end

		--for i = 1, 2 do
		--	shared.sfx({
		--		SoundId = "rbxassetid://133459833664514", 
		--		Parent = Dragon.RootPart.Root.LowerJaw.LowerMouth, 
		--		Volume = 10
		--	}):Play()
		--end
		DragonLoop = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.loopJ, Dragon.PrimaryPart.Bone.UpperMouth)


		local Brand = Janitor:Add(AssetsFolder.Brand:Clone())

		--Brand:PivotTo(Params.cfr * CFrame.new(0, 0, -15))
		--Brand:PivotTo(Dragon:GetPivot() * CFrame.new(0, 0, -15))
		task.spawn(function()
			local StartTime = tick()
			--local LoopTimes = 0
			local LastTime = 0
			while Dragon.Parent and tick() - StartTime < 3 do
				--LoopTimes += 1
				Brand:PivotTo(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -10, 5) * CFrame.Angles(-1.7453292519943295, 0, 0))
				task.wait()

			end
		end)




		Brand.Parent = workspace.World.Visuals




		task.wait(0.5)


		--DragonAnimation:Play()


		local Elden = Janitor:Add(AssetsFolder.Elden:Clone())
		Elden:ScaleTo(1.5)
		Elden.Parent = workspace.World.Visuals

		ParticlesModule.Enabled(Elden, true)
		--VFXFunctions.EnableDescendants(Elden, true)


		task.delay(0.2, function()
			ParticlesModule.Emit(Elden)
			--VFXFunctions.EmitDescendants(Elden)

		end)


		local Roar = Janitor:Add(AssetsFolder.Roar:Clone())
		--Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Root.UpperMouth.WorldCFrame)
		Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.UpperMouth.WorldCFrame*CFrame.new(0, -10, 5))

		Roar:ScaleTo(12.5)

		ParticlesModule.Enabled(Roar, false)
		--VFXFunctions.EnableDescendants(Roar, false)

		Roar.Parent = workspace.World.Visuals

		task.delay(0.5, function()
			--for _, Eye in Eyes do
			--	ParticlesModule.Enabled(Eye, false)
			--end

			ParticlesModule.Enabled(Brand, false)


			task.wait(0.5)


			for _, Beam in Brand:GetDescendants() do
				if Beam:IsA("Beam") then
					BoatTween:Create(Beam, {
						Time = 0.25, 
						EasingStyle = "Sine", 
						Goal = {
							Transparency = NumberSequence.new({
								NumberSequenceKeypoint.new(0, 1), 
								NumberSequenceKeypoint.new(1, 1)
							})
						}
					}):Play()

					Debris:AddItem(Beam, 0.25)
				end
			end
		end)


		local ScaleMultiplier = 1.4

		task.spawn(function()
			local StartTime = tick()
			local LoopTimes = 0
			local LastTime = 0

			task.delay(0, function()
				DragonStart = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.startG, Dragon.PrimaryPart.Bone.UpperMouth)

			end)
			task.delay(.6, function()
				DragonUser = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.userG, Dragon.PrimaryPart.Bone.UpperMouth)

			end)
			while Dragon.Parent and tick() - StartTime < 4.4 do
				LoopTimes += 1


				--Elden:PivotTo(Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, -4, -5) * CFrame.Angles(-1.7453292519943295, 0, 0))
				Elden:PivotTo(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -10, 5) * CFrame.Angles(-1.7453292519943295, 0, 0))

				--Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Root.UpperMouth.WorldCFrame * CFrame.new(0, 4, -9))
				Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.UpperMouth.WorldCFrame * CFrame.new(0, -2, -9))


				if LoopTimes % 4 == 0 then
					for _ = 1, 2 do
						local WindPurp = AssetsFolder.WindPurp:Clone()

						WindPurp:ScaleTo(RandomSeed:NextNumber(1,1.5) * 0.6)
						PlayMesh({
							Model = WindPurp, 
							T = 0, 
							--Anchor = Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, 15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))),
							Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))), 

							Info = TweenInfo.new(RandomSeed:NextNumber(0.2, 0.27), Enum.EasingStyle.Sine)
						})
					end
				end

				if LoopTimes % 3 == 0 and tick() - StartTime > 3.8 and tick() - LastTime > 0.1 then
					LastTime = tick()

					--local XOrientation, YOrientation, ZOrientation = Dragon.RootPart.Root.UpperHair.WorldCFrame:ToOrientation()
					local XOrientation, YOrientation, ZOrientation = Dragon.RootPart.Bone.Hair.WorldCFrame:ToOrientation()

					--local v3503 = CFrame.new(Dragon.RootPart.Root.UpperHair.WorldCFrame.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(-40, 0, 0) * CFrame.Angles(XOrientation, 0, ZOrientation)
					local v3503 = CFrame.new(Dragon.RootPart.Bone.Hair.WorldCFrame.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(-40, 0, 0) * CFrame.Angles(XOrientation, 0, ZOrientation)

					local WindFirst = AssetsFolder.WindFirst:Clone()
					WindFirst:ScaleTo(1 * ScaleMultiplier)
					WindFirst.Start.Decal.Transparency = 0.8
					PlayMesh({
						Model = WindFirst, 
						Anchor = v3503 * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
						Info = TweenInfo.new(0.85, Enum.EasingStyle.Sine)
					})

					local SecondWind = AssetsFolder.SecondWind:Clone()
					SecondWind:ScaleTo(1 * ScaleMultiplier)
					SecondWind.Start.Decal.Transparency = 0.8
					PlayMesh({
						Model = SecondWind, 
						Anchor = v3503 * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
						Info = TweenInfo.new(0.45, Enum.EasingStyle.Sine)
					})
				end
				task.wait()
			end
		end)


		task.spawn(function()
			task.wait(2.2)


			if Character == LocalCharacter then
				TS:Create(LocalPlayer, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
					CameraMinZoomDistance = 75
				}):Play()
			end

			for i = 1, 25 do
				--if LocalCharacter == Character or (LocalCharacter.PrimaryPart.Position - Dragon.PrimaryPart.Position).Magnitude <= 100 then
				--	shared.addshake(2)
				--end
				if not Dragon.Parent then break end

				local close = (Character == LocalChar)
				if not close and LocalChar and LocalChar.PrimaryPart and Dragon.PrimaryPart then
					close = (LocalChar.PrimaryPart.Position - Dragon.PrimaryPart.Position).Magnitude <= 100
				end
				if close then
					shared.addshake(2)
				end


				local Wind1 = AssetsFolder.Wind1:Clone()
				Wind1:ScaleTo(.5)
				--Wind1:SetPrimaryPartCFrame(Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * 6 * 2.5, 0) * CFrame.Angles(0, math.rad((math.random(0, 360))), 1.5707963267948966))
				Wind1:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * 6 * 2.5, 0) * CFrame.Angles(0, math.rad((math.random(0, 360))), 1.5707963267948966))

				PlayMesh({
					Model = Wind1, 
					Info = TweenInfo.new(0.75, Enum.EasingStyle.Exponential), 
					T = 1
				})

				local Wind22 = AssetsFolder.Wind22:Clone()
				Wind22:ScaleTo(.6)
				--Wind22:SetPrimaryPartCFrame(Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * -3 * 2.5, 0) * CFrame.Angles(-0.2617993877991494, math.rad((math.random(0, 360))), 1.5707963267948966))
				Wind22:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * -3 * 2.5, 0) * CFrame.Angles(-0.2617993877991494, math.rad((math.random(0, 360))), 1.5707963267948966))

				PlayMesh({
					Model = Wind22, 
					Info = TweenInfo.new(0.45, Enum.EasingStyle.Exponential), 
					T = 1
				})

				local WindTime = AssetsFolder.WindTime:Clone()
				WindTime:ScaleTo(RandomSeed:NextNumber(1,1.5) * 1.2)
				PlayMesh({
					Model = WindTime, 
					T = 0.95, 
					--Anchor = Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))), 
					Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))), 

					Info = TweenInfo.new(RandomSeed:NextNumber(0.3, 0.37), Enum.EasingStyle.Sine)
				})

				local WindTime2 = AssetsFolder.WindTime:Clone()
				WindTime2:ScaleTo(RandomSeed:NextNumber(1,2) * 1.2)
				PlayMesh({
					Model = WindTime2, 
					T = 0.85, 
					--Anchor = Dragon.PrimaryPart.Root.LowerHair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-75, 75))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-75, 75))))),
					Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-75, 75))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-75, 75))))), 

					Info = TweenInfo.new(RandomSeed:NextNumber(0.3, 0.37), Enum.EasingStyle.Sine)
				})


				task.wait(0.05)
			end

			ParticlesModule.Enabled(Brand, false)
		end)


		task.wait(0.1)


		for _, BasePart in Dragon:GetChildren() do
			if BasePart:IsA("BasePart") then
				BasePart.Transparency = 1

				if BasePart ~= Dragon.PrimaryPart and not string.match(string.lower(BasePart.Name), "outline") and BasePart.Name ~= "Eyes" then
					TS:Create(BasePart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
						Transparency = 0
					}):Play()

				elseif BasePart.Name == "Eyes" then
					task.delay(0.3, function()
						TS:Create(BasePart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
							Transparency = 0
						}):Play()
					end)

				end
			end
		end

		ScaleMultiplier = 1.5

		--task.delay(3.7, function()
		--	for i = 1, 2 do
		--		shared.sfx({
		--			SoundId = "rbxassetid://84383719975352", 
		--			CFrame = Params.cfr * CFrame.new(0, -HumRP.Size.Y * 1.5, -20), 
		--			Volume = 10
		--		}):Play()
		--	end
		--end)

		task.delay(3.5, function()
			--if AwakeningMusic then
			--	AwakeningMusic.Parent = HumRP.AwakeningMusic
			--end

			--if LocalCharacter == Character then
			--	shared.sfx({
			--		SoundId = "rbxassetid://101455823308565", 
			--		Parent = Character.Torso, 
			--		Volume = 2
			--	}):Play()

			--	LocalPlayer.CameraMinZoomDistance = 0.5
			--end

			--if DragonCamera and DragonCamera.Parent then
			--	DragonCamera:Destroy()
			--end

			--SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.Roar2, Dragon.PrimaryPart.Bone.UpperMouth)
			SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Asura.Dragon.Roar2, HumRP)
			local soundSkip = SoundHandler:AddSound(Sounds.Characters.Zoro.Moves.Asura.Dragon.explode, HumRP)
			soundSkip.TimePosition = 1   -- start 2s into the 7s sound
			--local Explosion = Janitor:Add(AssetsFolder.Explosion:Clone()) --Old one
			local Explosion = Janitor:Add(AssetsFolder.ExplosionNew:Clone())

			--Explosion:SetPrimaryPartCFrame(Params.cfr * CFrame.new(0, -HumRP.Size.Y * 1.5, -20))
			Explosion:SetPrimaryPartCFrame(hrp.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, -5))
			--local Beams1 = Janitor:Add(AssetsFolder.Beams1:Clone())
			--local Beams2 = Janitor:Add(AssetsFolder.Beams2:Clone())
			--Beams1.CFrame = hrp.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, -5)
			--Beams2.CFrame = hrp.CFrame * CFrame.new(0, -HumRP.Size.Y * 1.5, -5)

			if LocalCharacter == Character then
				Character:PivotTo(Explosion.PrimaryPart.CFrame + Vector3.new(0, 4, 0))


			end

			--ParticlesModule.scaleLifetime(Explosion.GoodWind, 2)
			--ParticlesModule.scaleLifetime(Explosion.Part, 2.5)

			Explosion.Parent = workspace.World.Debris
			--Beams1.Parent = workspace.World.Debris
			--Beams2.Parent = workspace.World.Debris

			ParticlesModule.Emit(Explosion)
			ParticlesModule.Enabled(Elden, false)


			local ExplosionCFrame = Explosion.PrimaryPart.CFrame
			local WindFirst = AssetsFolder.WindFirst:Clone()
			WindFirst:ScaleTo(1 * ScaleMultiplier)
			PlayMesh({
				Model = WindFirst, 
				Anchor = ExplosionCFrame * CFrame.new(0, 9 * ScaleMultiplier, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
				Info = TweenInfo.new(3.995, Enum.EasingStyle.Exponential)
			})

			local SecondWind = AssetsFolder.SecondWind:Clone()
			SecondWind:ScaleTo(1 * ScaleMultiplier)
			PlayMesh({
				Model = SecondWind, 
				Anchor = ExplosionCFrame * CFrame.new(0, 8 * ScaleMultiplier, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
				Info = TweenInfo.new(2.115, Enum.EasingStyle.Exponential)
			})

			local Mesh = AssetsFolder.Mesh:Clone()
			Mesh:ScaleTo(1 * ScaleMultiplier)
			PlayMesh({
				Model = Mesh, 
				Anchor = ExplosionCFrame * CFrame.new(0, 17, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
				Info = TweenInfo.new(3.5250000000000004, Enum.EasingStyle.Exponential)
			})

			local Mesh2 = AssetsFolder.Mesh2:Clone()
			Mesh2:ScaleTo(0.7 * ScaleMultiplier)
			PlayMesh({
				Model = Mesh2, 
				Anchor = ExplosionCFrame * CFrame.new(0, 27, 0) * CFrame.Angles(0, 0, 1.5707963267948966), 
				Info = TweenInfo.new(3.5250000000000004, Enum.EasingStyle.Exponential)
			})

		end)


		task.wait(3.5)


		ParticlesModule.Enabled(Elden, false)

		SoundHandler:StopSound(DragonLoop,.1)
		SoundHandler:StopSound(DragonStart,.2)
		SoundHandler:StopSound(DragonUser,.3)
		DragonStart = nil
		DragonUser = nil
		DragonLoop = nil


		task.wait(0.1)


		for _, BasePart in Dragon:GetChildren() do
			if BasePart:IsA("BasePart") then
				TS:Create(BasePart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
					Transparency = 1
				}):Play()
			end
		end

		-- CHANGED: removed Debris:AddItem(Dragon, 0.1) — the SERVER destroys the
		-- dragon when its animation track stops. Locally destroying a server-owned
		-- instance desyncs replication. The fade-out tween above is fine to keep.


		task.wait(0.5)


		ParticlesModule.Enabled(Brand, false)
		ParticlesModule.Enabled(Elden, false)
		activeDragons[attacker] = nil
	end




end