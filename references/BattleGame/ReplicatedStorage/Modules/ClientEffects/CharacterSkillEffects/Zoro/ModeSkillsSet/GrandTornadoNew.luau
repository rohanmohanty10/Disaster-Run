--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local ParticlesModule = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler.Particles)
local Trove = require(ReplicatedStorage.Modules.Trove)
local SoundHandler = require(ReplicatedStorage.Modules.SoundHandler)
local Sounds = ReplicatedStorage.Assets.Sounds

local Effects = ReplicatedStorage.Assets.Effects

local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)
local DebreeController = require(ReplicatedStorage.Modules.Debree.DebreeController)
local RandomSeed = Random.new()

local spinVFX = {}

-- CHANGED: the dragon is now spawned + animated BY THE SERVER. We keep per-attacker
-- state here (the replicated dragon, its sounds, and the Elden VFX) so the
-- "DragonEnd" signal from the server can stop/fade everything.
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
				CFrame = EndPart.CFrame,
			}):Play()

			task.delay(ExtraLifetime, function()
				Tween = TS:Create(StartPart, TweenInformation, {
					Transparency = GoalTransparency,
				})

				Tween:Play()

				if StartDecal then
					for _, Decal in pairs(StartPart:GetChildren()) do
						if Decal:IsA("Decal") then
							TS:Create(Decal, TweenInformation, {
								Transparency = GoalTransparency,
							}):Play()
						end
					end
				end

				if StartMesh then
					Tween = TS:Create(StartMesh, TweenInformation, {
						Scale = EndMesh.Scale,
					}):Play()
				end
			end)
		else
			if StartMesh then
				TS:Create(StartMesh, TweenInformation, {
					Scale = EndMesh.Scale,
				}):Play()
			end

			if StartDecal then
				for _, randomVFX in pairs(StartPart:GetChildren()) do
					if randomVFX:IsA("Decal") then
						TS:Create(randomVFX, TweenInformation, {
							Transparency = GoalTransparency,
						}):Play()
					end
				end

				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size,
					CFrame = EndPart.CFrame,
				})

				Tween:Play()
			else
				Tween = TS:Create(StartPart, TweenInformation, {
					Size = EndPart.Size,
					Transparency = GoalTransparency,
					CFrame = EndPart.CFrame,
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
	local skillType = argumentData.SkillType
	local character = attacker
	local isLocalPlayer = LocalPlayer.Character == attacker

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	--local zoroEffects = script.

	local MoveFolder = script.VFX

	local function scaleModel(model, scale)
		local pivot = model:GetPivot()
		for _, part in ipairs(model:GetDescendants()) do
			if part:IsA("BasePart") then
				local localCFrame = pivot:ToObjectSpace(part.CFrame)
				part.Size = part.Size * scale
				part.CFrame = pivot * (localCFrame - localCFrame.Position) + localCFrame.Position * scale
			end
			if part:IsA("SpecialMesh") then
				part.Scale = part.Scale * scale
			end
		end
	end

	local function emitParticles(parent)
		for _, descendant in ipairs(parent:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant:Emit(descendant:GetAttribute("EmitCount") or 0)
			end
		end
	end

	-- Enable or disable all ParticleEmitters in a model
	local function setParticlesEnabled(parent, enabled)
		for _, descendant in ipairs(parent:GetDescendants()) do
			if descendant:IsA("ParticleEmitter") then
				descendant.Enabled = enabled
			end
		end
	end

	local table1 = {}
	local activeTweens = {}
	local BoatTween = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)

	local activeTweens = table1

	function _G.tween(instance, tweenParams, goalTable, stepType, forceRestart)
		-- If forceRestart is true and a tween is already running on this instance, stop and destroy it
		if forceRestart ~= nil and activeTweens[instance] then
			local existingTween = activeTweens[instance][1]
			existingTween:Stop()
			existingTween:Destroy()
			activeTweens[instance] = nil
		end

		-- Early exit if instance is invalid
		if not instance or instance == nil or instance.Parent == nil then
			return
		end

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
		local tween = BoatTween:Create(instance, tweenInfo)
		activeTweens[instance] = { tween, goalTable }
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

	local function tweenTransparency(instance, targetTransparency, easingDirection)
		_G.tween(instance, {
			0.45,
			"Quad",
			easingDirection,
			0,
			false,
			0,
		}, {
			Transparency = targetTransparency,
		})
	end

	if skillType == "ReleaseDebris" then
		if typeof(argumentData.DebrisTarget) == "string" then
			DebreeController.SetTarget(argumentData.DebrisTarget, nil)
		end
		return
	end

	if skillType == "start" then
		-- the absorbed debris spins around Zoro (DebreeController's "Tatsumaki" style) until the
		-- server's ReleaseDebris; the delay is a safety net if that never arrives
		local DebrisTarget = argumentData.DebrisTarget
		if typeof(DebrisTarget) == "string" then
			DebreeController.SetTarget(DebrisTarget, hrp)
			task.delay(8, function()
				DebreeController.SetTarget(DebrisTarget, nil)
			end)
		end

		local playbackSpeed = 1
		if character == nil then
			return
		end

		local primaryPart = character.PrimaryPart
		if primaryPart == nil then
			return
		end

		-- Set up a folder to hold all effects
		local effectsFolder = Instance.new("Folder")
		effectsFolder.Parent = workspace.World.Debris

		local rootPart = character:WaitForChild("HumanoidRootPart")
		character:WaitForChild("Humanoid")

		-- Clone VFX assets
		local bottomVFX = MoveFolder.BottomVFX:Clone()

		local tornadoVFX = MoveFolder.Tornado:Clone()

		local torn2 = MoveFolder.JetBack:Clone()

		bottomVFX.CFrame = rootPart.CFrame

		bottomVFX.Parent = effectsFolder

		emitParticles(bottomVFX)

		tornadoVFX.Parent = effectsFolder

		tweenTransparency(tornadoVFX.Twist, 0.5, nil)

		for _, descendant in ipairs(tornadoVFX:GetDescendants()) do
			if descendant:IsA("Decal") then
				tweenTransparency(descendant, 0.65, "In")
			end
		end

		torn2.Parent = effectsFolder
		tweenTransparency(torn2.Start, 0.5, nil)
		for _, descendant in ipairs(torn2:GetDescendants()) do
			if descendant:IsA("Decal") then
				tweenTransparency(descendant, 0.65, "In")
			end
		end

		task.delay(0.7, function()
			tweenTransparency(torn2.End, 0.5, nil)
			for _, descendant in ipairs(torn2:GetDescendants()) do
				if descendant:IsA("Decal") then
					tweenTransparency(descendant, 0.65, "In")
				end
			end
		end)

		-- Signal value used to stop the tornado rock module
		local isSpinning = Instance.new("BoolValue")
		isSpinning.Parent = character

		task.spawn(function()
			require(script.TornadoRockModule):startTornado(primaryPart, isSpinning)
		end)

		setParticlesEnabled(tornadoVFX, true)

		local duration = 3.5

		-- Spawn beam burst effect every 0.3s while spinning
		local startTime = tick()
		task.spawn(function()
			while tick() - startTime < duration do
				task.wait(0.3)

				-- safety check in case effectsFolder was destroyed early
				if not effectsFolder or not effectsFolder.Parent then
					break
				end

				local beamClone = MoveFolder.Beams:Clone()
				beamClone.Parent = tornadoVFX
				beamClone.CFrame = tornadoVFX.PrimaryPart.CFrame

				for _, beam in ipairs(beamClone.Beams:GetChildren()) do
					if beam:IsA("Beam") then
						_G.tween(beam, {
							0.45,
							"Quad",
							Enum.EasingDirection.Out,
							0,
							false,
							0,
						}, {
							Width0 = 0,
							Width1 = 0,
						})
					end
				end

				_G.tween(beamClone, {
					0.7,
					"Quad",
					Enum.EasingDirection.Out,
					0,
					false,
					0,
				}, {
					CFrame = beamClone.CFrame * CFrame.new(0, 17, 0) * CFrame.Angles(0, math.rad(150), 0),
				})

				GpDestroy(beamClone, 0.7)
			end
		end)

		local renderConnection2
		task.spawn(function()
			local spinAngle2 = 0
			renderConnection2 = RunService.RenderStepped:Connect(function(dt)
				spinAngle2 = spinAngle2 + 1400 * dt
				torn2.Start:PivotTo(rootPart.CFrame * CFrame.new(0, 40, 0) * CFrame.Angles(0, math.rad(spinAngle2), 0))
				torn2.End:PivotTo(rootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(spinAngle2), 0))
			end)
		end)

		local spinAngle = 0
		local renderConnection = RunService.RenderStepped:Connect(function(dt)
			spinAngle = spinAngle + 500 * dt
			tornadoVFX:PivotTo(rootPart.CFrame * CFrame.new(0, 25, 0) * CFrame.Angles(0, math.rad(spinAngle), 0))
			--torn2:PivotTo(rootPart.CFrame * CFrame.new(0, 4.5, 0) * CFrame.Angles(0, math.rad(spinAngle), 0))
		end)

		local start = os.clock()

		while os.clock() - start < duration do
			local hit, hitPosition = shared.getRayFloor(primaryPart.CFrame, 8)

			if hit then
				tornadoVFX.VFX.SmokeEnab.WorldCFrame = CFrame.new(hitPosition)
			else
				tornadoVFX.VFX.SmokeEnab.WorldPosition = primaryPart.Position - Vector3.new(0, primaryPart.Size.Y, 0)
			end

			task.wait()
		end

		for _, descendant in ipairs(tornadoVFX:GetDescendants()) do
			if descendant:IsA("Decal") or descendant:IsA("Part") then
				tweenTransparency(descendant, 1.25, "Out")
			end
		end

		for _, descendant in ipairs(torn2:GetDescendants()) do
			if descendant:IsA("Decal") or descendant:IsA("Part") or descendant:IsA("MeshPart") then
				tweenTransparency(descendant, 1.25, "Out")
			end
		end

		setParticlesEnabled(tornadoVFX, false)
		isSpinning:Destroy()

		local fadeOutSettings = { 0.25, "EntranceProductive", Enum.EasingDirection.Out, 0, false, 0 }

		task.delay(1.5, function()
			--renderConnection:Disconnect()
			if renderConnection2 then
				renderConnection2:Disconnect()
			end
			effectsFolder:Destroy()
		end)
	end

	if skillType == "Dragon" then
		local Character = attacker
		local LocalCharacter = isLocalPlayer
		local LocalChar = LocalPlayer.Character
		local HumRP = attacker.HumanoidRootPart

		local AssetsFolder = script.Dragon

		-- CHANGED: the dragon arrives from the SERVER, already pivoted to
		-- hrp.CFrame * CFrame.new(0, 10, 0), parented to workspace.World.Visuals,
		-- with SpinAnim playing (each client simulates the replicated animation
		-- locally). No clone, no Parent, no PivotTo, no LoadAnimation, and no
		-- speedup/end marker handling here — the server does all of that.
		local Dragon = argumentData.Dragon
		if not Dragon or not Dragon.Parent then
			return
		end

		-- state shared with the "DragonEnd" signal
		local state = { Dragon = Dragon }
		activeDragons[attacker] = state

		local Janitor = Trove.new()
		task.delay(10, function()
			Janitor:Destroy()
		end)

		local Elden = Janitor:Add(AssetsFolder.Elden:Clone())
		Elden:ScaleTo(1)
		Elden.Parent = workspace.World.Visuals
		state.Elden = Elden

		state.DragonLoop = SoundHandler:AddSound(
			Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.loopJ,
			Dragon.PrimaryPart.Head.UpperMouth
		)
		task.delay(0, function()
			state.DragonStart = SoundHandler:AddSound(
				Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.startG,
				Dragon.PrimaryPart.Head.UpperMouth
			)
		end)
		task.delay(0.6, function()
			state.DragonUser = SoundHandler:AddSound(
				Sounds.Characters.Zoro.Moves.Tatsumaki.Dragon.userG,
				Dragon.PrimaryPart.Head.UpperMouth
			)
		end)

		-- The rise/fall is still done LOCALLY on every client. It's deterministic
		-- (same start CFrame, same tween) so all clients stay in sync, and the
		-- server never writes the PrimaryPart CFrame after spawn so nothing
		-- fights the tween. The server-side animation only moves bones/vertices.
		local startCF = Dragon.PrimaryPart.CFrame

		local TweenUp =
			TS:Create(Dragon.PrimaryPart, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				CFrame = startCF * CFrame.new(0, 20, 0),
			})

		TweenUp.Completed:Once(function()
			if not Dragon.Parent then
				return
			end
			local upCF = Dragon.PrimaryPart.CFrame -- where it ended up
			local TweenDown =
				TS:Create(Dragon.PrimaryPart, TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					CFrame = upCF * CFrame.new(0, -20, 0),
				})
			TweenDown:Play()
		end)

		TweenUp:Play()

		ParticlesModule.Enabled(Elden, true)
		--VFXFunctions.EnableDescendants(Elden, true)

		task.delay(0.2, function()
			ParticlesModule.Emit(Elden)
			--VFXFunctions.EmitDescendants(Elden)
		end)

		local Roar = Janitor:Add(AssetsFolder.Roar:Clone())
		--Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.UpperMouth.WorldCFrame*CFrame.new(0, -10, 5))
		Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Head.UpperMouth.WorldCFrame * CFrame.new(0, -10, 5))

		Roar:ScaleTo(5)

		ParticlesModule.Enabled(Roar, false)
		--VFXFunctions.EnableDescendants(Roar, false)

		Roar.Parent = workspace.World.Visuals

		local ScaleMultiplier = 1.4

		task.spawn(function()
			local StartTime = tick()
			local LoopTimes = 0
			local LastTime = 0
			while Dragon.Parent and tick() - StartTime < 4.4 do
				LoopTimes += 1

				--Elden:PivotTo(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -10, 5) * CFrame.Angles(-1.7453292519943295, 0, 0))
				Elden:PivotTo(
					Dragon.PrimaryPart.Head.Hair.WorldCFrame
						* CFrame.new(0, -10, 5)
						* CFrame.Angles(-1.7453292519943295, 0, 0)
				)

				--Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.UpperMouth.WorldCFrame * CFrame.new(0, -10, -9))
				Roar:SetPrimaryPartCFrame(Dragon.PrimaryPart.Head.UpperMouth.WorldCFrame * CFrame.new(0, -10, -9))

				if LoopTimes % 4 == 0 then
					for _ = 1, 2 do
						local WindPurp = AssetsFolder.WindPurp:Clone()
						WindPurp:ScaleTo(RandomSeed:NextNumber(2, 3) * 0.6)
						PlayMesh({
							Model = WindPurp,
							T = 0,
							--Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, 5, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))),
							Anchor = Dragon.PrimaryPart.Head.Hair.WorldCFrame * CFrame.new(0, 5, 0) * CFrame.Angles(
								math.rad((RandomSeed:NextNumber(-15, 15))),
								math.rad((RandomSeed:NextNumber(0, 360))),
								(math.rad((RandomSeed:NextNumber(-15, 15))))
							),

							Info = TweenInfo.new(RandomSeed:NextNumber(0.2, 0.27), Enum.EasingStyle.Sine),
						})
					end
				end

				if LoopTimes % 3 == 0 and tick() - StartTime > 3.8 and tick() - LastTime > 0.1 then
					LastTime = tick()

					--	local XOrientation, YOrientation, ZOrientation = Dragon.RootPart.Bone.Hair.WorldCFrame:ToOrientation()
					local XOrientation, YOrientation, ZOrientation =
						Dragon.RootPart.Head.Hair.WorldCFrame:ToOrientation()

					--local v3503 = CFrame.new(Dragon.RootPart.Bone.Hair.WorldCFrame.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(-40, 0, 0) * CFrame.Angles(XOrientation, 0, ZOrientation)
					local v3503 = CFrame.new(Dragon.RootPart.Head.Hair.WorldCFrame.Position)
						* CFrame.Angles(0, YOrientation, 0)
						* CFrame.new(-40, 0, 0)
						* CFrame.Angles(XOrientation, 0, ZOrientation)

					local WindFirst = AssetsFolder.WindFirst:Clone()
					WindFirst:ScaleTo(1 * ScaleMultiplier)
					WindFirst.Start.Decal.Transparency = 0.8
					PlayMesh({
						Model = WindFirst,
						Anchor = v3503 * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966),
						Info = TweenInfo.new(0.85, Enum.EasingStyle.Sine),
					})

					local SecondWind = AssetsFolder.SecondWind:Clone()
					SecondWind:ScaleTo(1 * ScaleMultiplier)
					SecondWind.Start.Decal.Transparency = 0.8
					PlayMesh({
						Model = SecondWind,
						Anchor = v3503 * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966),
						Info = TweenInfo.new(0.45, Enum.EasingStyle.Sine),
					})
				end
				task.wait()
			end
		end)

		task.spawn(function()
			task.wait(0.5)

			if Character == LocalCharacter then
				TS:Create(LocalPlayer, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
					CameraMinZoomDistance = 75,
				}):Play()
			end

			for i = 1, 25 do
				--if LocalCharacter == Character or (LocalCharacter.PrimaryPart.Position - Dragon.PrimaryPart.Position).Magnitude <= 100 then
				--	shared.addshake(2)
				--end
				if not Dragon.Parent then
					break
				end

				local close = (Character == LocalChar)
				if not close and LocalChar and LocalChar.PrimaryPart and Dragon.PrimaryPart then
					close = (LocalChar.PrimaryPart.Position - Dragon.PrimaryPart.Position).Magnitude <= 100
				end
				if close then
					shared.addshake(2)
				end

				local Wind1 = AssetsFolder.Wind1:Clone()
				Wind1:ScaleTo(0.5)
				--Wind1:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * 6 * 2.5, 0) * CFrame.Angles(0, math.rad((math.random(0, 360))), 1.5707963267948966))
				Wind1:SetPrimaryPartCFrame(
					Dragon.PrimaryPart.Head.Hair.WorldCFrame
						* CFrame.new(0, HumRP.Size.Y * 6 * 2.5, 0)
						* CFrame.Angles(0, math.rad((math.random(0, 360))), 1.5707963267948966)
				)

				PlayMesh({
					Model = Wind1,
					Info = TweenInfo.new(0.75, Enum.EasingStyle.Exponential),
					T = 1,
				})

				local Wind22 = AssetsFolder.Wind22:Clone()
				Wind22:ScaleTo(0.6)

				--Wind22:SetPrimaryPartCFrame(Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, HumRP.Size.Y * -3 * 2.5, 0) * CFrame.Angles(-0.2617993877991494, math.rad((math.random(0, 360))), 1.5707963267948966))
				Wind22:SetPrimaryPartCFrame(
					Dragon.PrimaryPart.Head.Hair.WorldCFrame
						* CFrame.new(0, HumRP.Size.Y * -3 * 2.5, 0)
						* CFrame.Angles(-0.2617993877991494, math.rad((math.random(0, 360))), 1.5707963267948966)
				)

				PlayMesh({
					Model = Wind22,
					Info = TweenInfo.new(0.45, Enum.EasingStyle.Exponential),
					T = 1,
				})

				local WindTime = AssetsFolder.WindTime:Clone()
				WindTime:ScaleTo(RandomSeed:NextNumber(1, 1.5) * 1.2)
				PlayMesh({
					Model = WindTime,
					T = 0.95,
					--Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-15, 15))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-15, 15))))),
					Anchor = Dragon.PrimaryPart.Head.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(
						math.rad((RandomSeed:NextNumber(-15, 15))),
						math.rad((RandomSeed:NextNumber(0, 360))),
						(math.rad((RandomSeed:NextNumber(-15, 15))))
					),

					Info = TweenInfo.new(RandomSeed:NextNumber(0.3, 0.37), Enum.EasingStyle.Sine),
				})

				local WindTime2 = AssetsFolder.WindTime:Clone()
				WindTime2:ScaleTo(RandomSeed:NextNumber(1, 2) * 1.2)
				PlayMesh({
					Model = WindTime2,
					T = 0.85,
					--Anchor = Dragon.PrimaryPart.Bone.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(math.rad((RandomSeed:NextNumber(-75, 75))), math.rad((RandomSeed:NextNumber(0, 360))), (math.rad((RandomSeed:NextNumber(-75, 75))))),
					Anchor = Dragon.PrimaryPart.Head.Hair.WorldCFrame * CFrame.new(0, -15, 0) * CFrame.Angles(
						math.rad((RandomSeed:NextNumber(-75, 75))),
						math.rad((RandomSeed:NextNumber(0, 360))),
						(math.rad((RandomSeed:NextNumber(-75, 75))))
					),

					Info = TweenInfo.new(RandomSeed:NextNumber(0.3, 0.37), Enum.EasingStyle.Sine),
				})

				task.wait(0.05)
			end

			--ParticlesModule.Enabled(Brand, false)
		end)

		task.delay(4.5, function() end)
	end

	-- CHANGED: fired by the SERVER when the SpinAnim "end" marker is reached.
	-- This is the cleanup that used to live in the client's "end" marker handler:
	-- stop the dragon sounds, fade the parts, kill the Elden particles.
	-- The server destroys the dragon itself ~0.6s after firing this, so no
	-- Debris:AddItem here.
	if skillType == "DragonEnd" then
		local state = activeDragons[attacker]
		if not state then
			return
		end
		activeDragons[attacker] = nil

		local Dragon = state.Dragon

		task.spawn(function()
			if state.DragonLoop then
				SoundHandler:StopSound(state.DragonLoop, 0.1)
			end
			if state.DragonStart then
				SoundHandler:StopSound(state.DragonStart, 0.2)
			end
			if state.DragonUser then
				SoundHandler:StopSound(state.DragonUser, 0.3)
			end
			state.DragonLoop = nil
			state.DragonStart = nil
			state.DragonUser = nil
		end)

		task.wait(0.2)
		if Dragon and Dragon.Parent then
			for _, BasePart in Dragon:GetChildren() do
				if BasePart:IsA("BasePart") then
					TS:Create(BasePart, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {
						Transparency = 1,
					}):Play()
				end
			end
		end

		task.wait(0.2)

		if state.Elden then
			ParticlesModule.Enabled(state.Elden, false)
		end
	end

	-- Tornado: rebuild local cosmetic voxels and make them orbit + climb a funnel around the axis.
	local function tornadoVoxelList(voxelList, targetAttachment, params)
		if not voxelList or not targetAttachment then
			return
		end
		params = params or {} -- guard: your current call passes no params

		-- ===== Tunable knobs =====
		local MAX_PIECES = params.MaxPieces or 300
		local MIN_DIMENSIONS = params.MinPieceDim or 0.75

		local DURATION = params.Duration or 1.4
		local WAVE_TIME = 0.40
		local SPIN_SPEED = 60
		local SWIRL_NEAR = 2.0
		local LIFT_SPEED = 24
		local LIFT_JITTER = 20
		local BASE_RADIUS = 10
		local CONE_SLOPE = 0.30
		local MAX_RADIUS = 24
		local RADIAL_GAIN = 3
		local RADIAL_CLAMP = 45
		local MAX_HEIGHT = 100
		local FADE_IN_H = 5
		local FADE_OUT_H = 14
		local END_FADE = 0.5
		local STEER_RATE = 3.5
		local MAX_SPEED = 140
		local TURB_STRENGTH = 40
		local TURB_FREQ = 0.6

		-- ===== NEW: behavior chances + debris tween =====
		local FLING_CHANCE = params.FlingChance or 0.5 -- flung OUT of the funnel mid-spin
		local END_EXPLODE = params.ExplodeChance or 0.4 -- on end: burst outward
		local END_DROP = params.DropChance or 0.4 -- on end: drop under gravity
		-- leftover (~0.2) just fades out fast
		local LINGER_MIN = params.LingerMin or 1.0 -- seconds flying before the tween-out
		local LINGER_MAX = params.LingerMax or 2.0
		local SHRINK_TIME = params.ShrinkTime or 0.6 -- shrink + fade tween duration

		local function tangentOf(outward)
			return Vector3.yAxis:Cross(outward)
		end

		local function randomizePersonality(data)
			data.spinMul = 0.7 + math.random() * 0.8
			data.radiusMul = 0.55 + math.random() * 0.9
			data.lift = (LIFT_SPEED + math.random(-LIFT_JITTER, LIFT_JITTER)) * (0.6 + math.random() * 0.9)
			data.noiseSeed = math.random() * 1000
			data.wobblePhase = math.random() * 6.28
		end

		local active = {}
		local t0 = os.clock()
		local center0 = targetAttachment.WorldPosition

		local function outwardOf(piece, center)
			local flat = Vector3.new(piece.Position.X - center.X, 0, piece.Position.Z - center.Z)
			return flat.Magnitude > 1e-3 and flat.Unit
				or Vector3.new(math.cos(math.random() * 6.28), 0, math.sin(math.random() * 6.28))
		end

		-- Kinematic ejection: pieces stay anchored and we integrate gravity + spin
		-- ourselves. They collide with nothing and fall straight through the map;
		-- the linger + shrink tween destroys them before they get far below it.
		local ejected = {}
		local ejectConn

		local function ensureEjectLoop()
			if ejectConn then
				return
			end
			local ejMoveParts, ejMoveCFs = {}, {} -- reused each frame for one BulkMoveTo
			ejectConn = RunService.Heartbeat:Connect(function(dt)
				table.clear(ejMoveParts)
				table.clear(ejMoveCFs)

				for piece, data in ejected do
					if not piece.Parent then
						ejected[piece] = nil
						continue
					end

					data.vel -= Vector3.yAxis * (workspace.Gravity * dt)
					-- integrate the cached cf and queue for a single bulk write
					data.cf = (data.cf + data.vel * dt) * CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
					local n = #ejMoveParts + 1
					ejMoveParts[n] = piece
					ejMoveCFs[n] = data.cf
				end

				if #ejMoveParts > 0 then
					workspace:BulkMoveTo(ejMoveParts, ejMoveCFs, Enum.BulkMoveMode.FireCFrameChanged)
				end

				if next(ejected) == nil then
					ejectConn:Disconnect()
					ejectConn = nil
				end
			end)
		end

		-- NEW: hand a piece to the kinematic integrator, then shrink-tween it away after a linger
		local function ejectPiece(piece, data, velocity)
			data.mode = "ejected"
			active[piece] = nil -- the swirl loop ignores it now

			data.vel = velocity
			local spin = Vector3.new(math.random(-40, 40), math.random(-40, 40), math.random(-40, 40))
			if spin.Magnitude < 1e-3 then
				spin = Vector3.yAxis * 20
			end
			data.spinAxis = spin.Unit
			data.spinRate = spin.Magnitude
			ejected[piece] = data
			ensureEjectLoop()

			local linger = LINGER_MIN + math.random() * (LINGER_MAX - LINGER_MIN)
			task.delay(linger, function()
				if not piece.Parent then
					return
				end
				-- keep integrating during the shrink so it flies while fading, like
				-- the old physics version did (tween only touches Size/Transparency)
				local tween = TS:Create(
					piece,
					TweenInfo.new(SHRINK_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ Size = Vector3.new(0.05, 0.05, 0.05), Transparency = 1 }
				)
				tween.Completed:Once(function()
					if piece.Parent then
						piece:Destroy()
					end
				end)
				tween:Play()
			end)
		end

		local function seedAtBase(piece, data, center)
			randomizePersonality(data)
			local ang = math.random() * math.pi * 2
			local r = BASE_RADIUS * (0.45 + math.random() * 0.65)
			local outward = Vector3.new(math.cos(ang), 0, math.sin(ang))
			piece.CFrame = CFrame.new(center + outward * r + Vector3.new(0, 1 + math.random() * 2, 0))
				* CFrame.Angles(math.random() * 6.28, math.random() * 6.28, math.random() * 6.28)
			data.cf = piece.CFrame -- keep the cache authoritative after the reseat
			data.vel = tangentOf(outward) * SPIN_SPEED + Vector3.yAxis * data.lift
			data.recycled = true
		end

		-- entries are either snapshots ({CFrame, Size, Color, ...}) or real-part
		-- references ({Part = BasePart}) from special props like trees
		local function sizeOf(vData)
			if vData.Part ~= nil then
				return (typeof(vData.Part) == "Instance" and vData.Part:IsA("BasePart")) and vData.Part.Size or nil
			end
			return vData.Size
		end

		local filtered = {}
		for _, vData in voxelList do
			local s = sizeOf(vData)
			if s and math.min(s.X, s.Y, s.Z) >= MIN_DIMENSIONS then
				table.insert(filtered, vData)
			end
		end
		-- if the whole list is slivers, filtering everything means the skill silently
		-- does nothing — fall back to the raw list
		if #filtered == 0 then
			filtered = voxelList
		end

		-- keep the LARGEST pieces up to the cap instead of stride-sampling
		if #filtered > MAX_PIECES then
			table.sort(filtered, function(a, b)
				local sa, sb = sizeOf(a) or Vector3.zero, sizeOf(b) or Vector3.zero
				return sa.X * sa.Y * sa.Z > sb.X * sb.Y * sb.Z
			end)
			for i = #filtered, MAX_PIECES + 1, -1 do
				filtered[i] = nil
			end
		end
		voxelList = filtered

		for _, vData in voxelList do
			local piece
			if vData.Part ~= nil then
				local src = vData.Part
				if not (typeof(src) == "Instance" and src:IsA("BasePart")) then
					continue -- destroyed/not replicated (e.g. streamed out); skip this entry
				end
				-- real-mesh mode: clone the hidden original so fronds and trunk pieces
				-- keep their actual geometry and textures instead of becoming cubes;
				-- hideModel() saved the pre-hide transparency in __OrigTrans
				piece = src:Clone()
				piece.Transparency = piece:GetAttribute("__OrigTrans") or 0
				CollectionService:RemoveTag(piece, "WindShake")
				for _, d in piece:GetDescendants() do
					if d:IsA("BasePart") or d:IsA("Bone") then
						CollectionService:RemoveTag(d, "WindShake")
					elseif d:IsA("Texture") or d:IsA("Decal") then
						-- hideModel() hid these on the original too; unhide the copies
						local orig = d:GetAttribute("__OrigTrans")
						if orig ~= nil then
							d.Transparency = orig
						end
					end
				end
			else
				piece = Instance.new("Part")
				piece.CFrame, piece.Size, piece.Color, piece.Material =
					vData.CFrame, vData.Size, vData.Color, vData.Material
				-- without this, voxels from variant-textured parts (e.g. the white
				-- Plastic + FloorConcrete3 floor) rebuild as plain white blocks
				piece.MaterialVariant = vData.MaterialVariant or ""
			end
			piece.Anchored = true
			piece.CanCollide, piece.CanQuery, piece.CanTouch = false, false, false
			piece.Massless, piece.CastShadow = true, false
			piece.Parent = workspace.World.Debris

			local data = {
				cf = piece.CFrame, -- cached transform; the loop integrates this, never the engine
				vel = Vector3.zero,
				started = false,
				recycled = false,
				mode = "swirl", -- NEW
				startAt = t0 + math.random() * WAVE_TIME,
			}
			randomizePersonality(data)
			-- NEW: pre-pick the pieces that fling out, each at a random moment mid-spin
			if math.random() < FLING_CHANCE then
				data.flingAt = t0 + 0.3 + math.random() * math.max(DURATION - 0.3, 0.1)
			end
			active[piece] = data

			Debris:AddItem(piece, DURATION + LINGER_MAX + SHRINK_TIME + 1) -- generous safety net
		end

		local endStart = nil
		local moveParts, moveCFs = {}, {} -- reused each frame for one BulkMoveTo
		local conn
		conn = RunService.Heartbeat:Connect(function(dt)
			if not targetAttachment.Parent then
				conn:Disconnect()
				for piece in active do
					if piece.Parent then
						piece:Destroy()
					end
				end
				return
			end

			table.clear(moveParts)
			table.clear(moveCFs)

			local now = os.clock()
			local center = targetAttachment.WorldPosition
			local baseY = center.Y

			-- NEW: at end, give each still-swirling piece an exit behavior (once)
			if not endStart and now - t0 > DURATION then
				endStart = now
				local ejects = {}
				for piece, data in active do
					if data.mode ~= "swirl" then
						continue
					end
					local roll = math.random()
					if roll < END_EXPLODE then
						data.endKind = "explode"
						table.insert(ejects, piece)
					elseif roll < END_EXPLODE + END_DROP then
						data.endKind = "drop"
						table.insert(ejects, piece)
					else
						data.mode = "fade"
					end
				end
				for _, piece in ejects do
					local data = active[piece]
					local outward = outwardOf(piece, center)
					local vel
					if data.endKind == "explode" then
						vel = outward * math.random(70, 130) + Vector3.yAxis * math.random(25, 60)
					else -- drop
						vel = outward * math.random(4, 18) + Vector3.new(0, math.random(-8, 2), 0)
					end
					ejectPiece(piece, data, vel)
				end
			end

			local endAlpha = 1
			if endStart then
				endAlpha = math.clamp(1 - (now - endStart) / END_FADE, 0, 1)
			end

			local remaining = 0
			for piece, data in active do
				if not piece.Parent then
					active[piece] = nil
					continue
				end
				remaining += 1
				if now < data.startAt then
					continue
				end

				-- NEW: the "just fade" leftover group at end
				if data.mode == "fade" then
					piece.Transparency = 1 - endAlpha
					if endAlpha <= 0.02 then
						piece:Destroy()
						active[piece] = nil
					end
					continue
				end

				-- mode == "swirl"
				if not data.started then
					data.started = true
					-- kinematic: stays anchored for its whole life; tumble is integrated
					-- manually instead of handing the part to the physics engine
					local spin = Vector3.new(math.random(-18, 18), math.random(-18, 18), math.random(-18, 18))
					if spin.Magnitude < 1e-3 then
						spin = Vector3.yAxis * 9
					end
					data.spinAxis = spin.Unit
					data.spinRate = spin.Magnitude
				end

				local pos = data.cf.Position -- cached; avoids a per-frame engine read
				local flat = Vector3.new(pos.X - center.X, 0, pos.Z - center.Z)
				local radius = flat.Magnitude
				local outward = radius > 1e-3 and flat.Unit
					or Vector3.new(math.cos(math.random() * 6.28), 0, math.sin(math.random() * 6.28))
				local h = pos.Y - baseY

				-- NEW: fling OUT of the funnel at the scheduled moment, carrying orbital momentum
				if data.flingAt and now >= data.flingAt then
					local spin = SPIN_SPEED
						* data.spinMul
						* math.clamp(BASE_RADIUS / math.max(radius, 1), 0.6, SWIRL_NEAR)
					local flingVel = outward * math.random(60, 110)
						+ Vector3.yAxis * math.random(20, 50)
						+ tangentOf(outward) * spin * 0.5
					ejectPiece(piece, data, flingVel)
					continue
				end

				if h > MAX_HEIGHT then
					seedAtBase(piece, data, center)
					continue
				end

				local targetR = math.clamp((BASE_RADIUS + h * CONE_SLOPE) * data.radiusMul, 0, MAX_RADIUS)
				local spin = SPIN_SPEED * data.spinMul * math.clamp(BASE_RADIUS / math.max(radius, 1), 0.6, SWIRL_NEAR)

				local vSpin = tangentOf(outward) * spin
				local gust = 1 + 0.5 * math.noise(data.noiseSeed, now * 0.8)
				local vLift = Vector3.yAxis * data.lift * gust
				local vRadial = -outward * math.clamp((radius - targetR) * RADIAL_GAIN, -RADIAL_CLAMP, RADIAL_CLAMP)

				local f = now * TURB_FREQ
				local turb = Vector3.new(
					math.noise(f + data.noiseSeed, h * 0.08),
					math.noise(data.noiseSeed, f + 5.2) * 0.5,
					math.noise(f + 9.1, data.noiseSeed)
				) * TURB_STRENGTH

				local desired = vSpin + vRadial + vLift + turb
				data.vel = data.vel:Lerp(desired, math.clamp(STEER_RATE * dt, 0, 1))
				if data.vel.Magnitude > MAX_SPEED then
					data.vel = data.vel.Unit * MAX_SPEED
				end
				-- kinematic move: integrate the cached cf + spin ourselves (no physics
				-- engine), then queue it for a single BulkMoveTo at the end of the frame
				data.cf = (data.cf + data.vel * dt) * CFrame.fromAxisAngle(data.spinAxis, data.spinRate * dt)
				local n = #moveParts + 1
				moveParts[n] = piece
				moveCFs[n] = data.cf

				local fadeOut = math.clamp((MAX_HEIGHT - h) / FADE_OUT_H, 0, 1)
				local alpha = fadeOut
				if data.recycled then
					alpha = math.min(alpha, math.clamp(h / FADE_IN_H, 0, 1))
				end
				piece.Transparency = 1 - alpha
			end

			if #moveParts > 0 then
				workspace:BulkMoveTo(moveParts, moveCFs, Enum.BulkMoveMode.FireCFrameChanged)
			end

			if remaining == 0 or (endStart and endAlpha <= 0) then
				conn:Disconnect()
				for piece in active do
					if piece.Parent then
						piece:Destroy()
					end
				end
			end
		end)
	end

end