local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")


local LocalPlayer = Players.LocalPlayer

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local RockHandler = require(ReplicatedStorage.Modules.ClientEffects.RockHandler)
local Trove = require(ReplicatedStorage.Modules.Trove)
local BoatTween = require(ReplicatedStorage.Resources.LegacyReplication.library.BoatTween)
local MeshFlipbooks = require(ReplicatedStorage.Modules.MeshFlipbooks)
local ParticlesModule = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler.Particles)

local VFX = script.VFX
local RandomSeed = Random.new()
local Debris = game:GetService("Debris")


-- Clone a VFX *folder*, pivot all its parts to a target CFrame, parent to Visuals
local function spawnFolderVFX(folder, cframe, lifetime)
	local clone = folder:Clone()

	local root = clone:FindFirstChildWhichIsA("BasePart", true)
	if root then
		local rootCF = root.CFrame
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				local offset = rootCF:ToObjectSpace(v.CFrame)
				v.CFrame = cframe * offset
			end
		end
	end

	clone.Parent = workspace.World.Visuals
	VFXFunctions.EmitDescendants(clone)
	VFXFunctions.TaskDebris(clone, lifetime or 4)
	return clone
end

local function QuickFX(Parameters)
	local FX = Parameters.FX
	local AnchorPoint = Parameters.Anchor
	local Maid = Parameters.Maid

	FX = FX:Clone()

	if FX:IsA("Model") then
		FX:PivotTo(AnchorPoint)
	elseif FX:IsA("BasePart") then
		FX.CFrame = AnchorPoint
	end

	if FX:IsA("Attachment") then
		FX.Parent = AnchorPoint
	else
		FX.Parent = workspace.Thrown
	end

	if Maid then
		Maid:Add(FX)
	else
		Debris:AddItem(FX, 30)
	end

	return FX
end

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

return function(argumentData)
	local attacker = argumentData.Attacker
	local skillType = argumentData.SkillType
	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	local torso = attacker:FindFirstChild("Torso")
	if not hrp then return end

	local IsMainPlayer = (LocalPlayer.Character == attacker)

	-- ─────────────────────────────────────────
	-- JUMP
	-- ─────────────────────────────────────────
	if skillType == "jump" then
		spawnFolderVFX(VFX.JumpUp, hrp.CFrame, 4)

		task.spawn(function()
			shared.addshake(2)
		end)

		if IsMainPlayer then
			local active = true

			local UpVelocity = Instance.new("LinearVelocity")
			UpVelocity.VelocityConstraintMode = Enum.VelocityConstraintMode.Line
			UpVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
			UpVelocity.LineDirection = vector.create(0, 1, 0)
			UpVelocity.MaxForce = math.huge
			UpVelocity.Attachment0 = hrp.RootAttachment
			UpVelocity.LineVelocity = 30
			UpVelocity.Parent = hrp

			task.delay(0.4, function()
				UpVelocity:Destroy()
			end)

			for _, bv in ipairs(hrp:GetChildren()) do
				if bv:IsA("BodyVelocity") then
					bv:Destroy()
				end
			end

			local ForwardVelocity = Instance.new("BodyVelocity")
			ForwardVelocity.Name = "SanjiAbilityOne"
			ForwardVelocity.Velocity = hrp.CFrame.LookVector
			ForwardVelocity.MaxForce = Vector3.new(80_000, 0, 80_000)
			ForwardVelocity.Parent = hrp

			local SpeedValue = Instance.new("NumberValue")
			SpeedValue.Value = 60
			SpeedValue.Parent = ForwardVelocity

			task.delay(0.5, function()
				TS:Create(SpeedValue, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Value = 0
				}):Play()
			end)

			task.spawn(function()
				while active and ForwardVelocity.Parent ~= nil and hrp.Parent ~= nil do
					ForwardVelocity.Velocity = hrp.CFrame.LookVector * SpeedValue.Value
					RunService.PreSimulation:Wait()
				end
				ForwardVelocity:Destroy()
				SpeedValue:Destroy()
			end)

			task.delay(5, function()
				active = false
				if ForwardVelocity and ForwardVelocity.Parent then
					ForwardVelocity:Destroy()
				end
			end)
			-- fire ConcasseDrop the moment we genuinely hit the ground
			task.spawn(function()
				local fired = false
				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Exclude
				params.FilterDescendantsInstances = {attacker, workspace.World.Visuals }
				params.IgnoreWater = true

				local started = os.clock()
				task.wait(0.45) -- let the launch-up happen before we start watching

				while not fired and hrp.Parent and (os.clock() - started) < 8 do
					local hitResult = workspace:Raycast(hrp.Position, Vector3.new(0, -8, 0), params)
					local descending = hrp.AssemblyLinearVelocity.Y <= 2
					if hitResult and descending then
						fired = true
						local Position = (hrp.CFrame * CFrame.new(0, -2.64, -1.9)).Position
						ReplicatedStorage.Remotes.MoveSkills.ConcasseDrop:FireServer(Position)
						break
					end
					RunService.PreSimulation:Wait()
				end
			end)
			
		end
		

		local Position = (hrp.CFrame * CFrame.new(0, -2.64, -1.9)).Position
		local Direction = Vector3.yAxis * -5
		
		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 3,
			Distance = 3,

			LookAt = {
				Min = 10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},
			BaseZ = 2.5,
			SizeMultiplier = 1.2,
			CraterSmoke = false,
			CastShadow = false
		})
		
		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 6,
			Distance = 6,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},

			BaseZ = 2.7,
			SizeMultiplier = 1.4,
			CraterSmoke = false,
			CastShadow = false
		})
	end

	-- ─────────────────────────────────────────
	-- SPIN START (Wind is a single Part, not a folder)
	-- ─────────────────────────────────────────
	if skillType == "spinStart" then
		local Wind = VFX.Wind:Clone()
		Wind.CFrame = (torso or hrp).CFrame
		Wind.Parent = workspace.World.Visuals
		VFXFunctions.EnableDescendants(Wind)
		VFXFunctions.weld(Wind, torso or hrp)
		VFXFunctions.TaskDebris(Wind, 6)

		for _, item in ipairs(VFX.In_Torso:GetChildren()) do
			local trail = item:Clone()
			trail.Parent = torso or hrp
		end

		VFXFunctions.EnableTrails(torso or hrp)

		task.spawn(function()
			shared.addshake(1.5)
		end)
	end

	-- ─────────────────────────────────────────
	-- SPIN END
	-- ─────────────────────────────────────────
	if skillType == "spinEnd" then
		for _, v in ipairs(workspace.World.Visuals:GetChildren()) do
			if v.Name == "Wind" then
				VFXFunctions.DisableDescendants(v)
				VFXFunctions.TaskDebris(v, 3)
			end
		end
	end

	-- ─────────────────────────────────────────
	-- REMOVE TRAIL
	-- ─────────────────────────────────────────
	if skillType == "removeTrail" then
		VFXFunctions.DisableTrails(torso or hrp)
	end

	-- ─────────────────────────────────────────
	-- SLAM
	-- ─────────────────────────────────────────
	if skillType == "slam" then
		
		--task.spawn(function()
		--	local Resources = game.ReplicatedStorage.Resources
		--	Ring.Parent = workspace.Thrown
		--	Ring.CFrame = hrp.CFrame

		--	for Prop, Value in Params.FirstProps do
		--		if Ring[Prop] then
		--			Ring[Prop] = Value
		--		end
		--	end

		--	TS:Create(Ring, TweenInfo.new(Params.TN_Info.Time, Enum.EasingStyle[Params.TN_Info.Style], Enum.EasingDirection[Params.TN_Info.Direction]), Params.FinalProps):Play()
		--	Debris:AddItem(Ring, Params.LF or Params.TN_Info.Time)
		--end)
		
		spawnFolderVFX(VFX.Slam, hrp.CFrame, 4)

		task.spawn(function()
			shared.addshake(2)
		end)

		local Position = (hrp.CFrame * CFrame.new(0, -2.64, -1.9)).Position
		local Direction = Vector3.yAxis * -5

		local Attachment = Instance.new("Attachment")
		Attachment.WorldPosition = Position
		Attachment.Parent = workspace.Terrain
		task.delay(3, Attachment.Destroy, Attachment)

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 14,
			Distance = 9,

			LookAt = {
				Min = -10,
				Max = -10
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},

			BaseZ = 2.7,
			SizeMultiplier = 1.6,
			CraterSmoke = false,
		})

		coroutine.wrap(RockHandler.Crater)(Position, Direction, {
			Amount = 24,
			Distance = 11,

			LookAt = {
				Min = 14,
				Max = -14
			},

			Exposure = {
				Min = 1,
				Max = 1.4
			},
			BaseZ = 2.7,
			SizeMultiplier = 1.4,
			CraterSmoke = false,
		})

		coroutine.wrap(RockHandler.Rockst)(Position, Direction, {
			Count = 20,
			Size = {0.35, 0.9},
			Velocity = 20,
		})
		--if IsMainPlayer then
		--	ReplicatedStorage.Remotes.MoveSkills.ConcasseDrop:FireServer(Position)
		--end
	end
	
	if skillType == "slam2" then
		local Janitor = Trove.new()
		local AssetsFolder = script.Explode
		local HumRP = hrp
		local Character = attacker

		
			local _, YOrientation = HumRP.CFrame:ToOrientation()
			
			_, YOrientation = HumRP.CFrame:ToOrientation()				

			local SpinWind = AssetsFolder.SpinWind:Clone()
			SpinWind:ScaleTo(1.19)
			PlayMesh({
				Model = SpinWind, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 4.8999999999999995, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(1.0499999999999998, Enum.EasingStyle.Exponential)
			})

			local SpinWind_2 = AssetsFolder.SpinWind:Clone()
			SpinWind_2:ScaleTo(1.19)
			PlayMesh({
				Model = SpinWind_2, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 11.2, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(1.0499999999999998, Enum.EasingStyle.Exponential)
			})

			local SpinWind_3 = AssetsFolder.SpinWind:Clone()
			SpinWind_3:ScaleTo(1.19)
			PlayMesh({
				Model = SpinWind_3, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 9.799999999999999, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(2.55, Enum.EasingStyle.Exponential)
			})

			local Thing4 = AssetsFolder.Thing4:Clone()
			Thing4:ScaleTo(2.0999999999999996)
			PlayMesh({
				Model = Thing4, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 0.7, -2) * CFrame.Angles(0, 0, -1.5707963267948966),
				Info = TweenInfo.new(1.7999999999999998, Enum.EasingStyle.Exponential)
			})

			local Bright = AssetsFolder.Bright:Clone()
			Bright:ScaleTo(4.199999999999999)
			PlayMesh({
				Model = Bright, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 4.199999999999999, -2) * CFrame.Angles(0, 0, 0),
				Info = TweenInfo.new(1.7999999999999998, Enum.EasingStyle.Exponential)
			})

			local Bright2 = AssetsFolder.Bright2:Clone()
			Bright2:ScaleTo(2.8)
			PlayMesh({
				Model = Bright2, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 0.7, -2) * CFrame.Angles(0, 0, 0),
				Info = TweenInfo.new(3.3, Enum.EasingStyle.Exponential)
			})

			local Grad = AssetsFolder.Grad:Clone()
			Grad:ScaleTo(0.7)
			PlayMesh({
				Model = Grad, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 4.8999999999999995, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(2.4000000000000004, Enum.EasingStyle.Exponential)
			})

			local Linger3 = AssetsFolder.Linger3:Clone()
			Linger3:ScaleTo(2.0999999999999996)
			PlayMesh({
				Model = Linger3, 
				EndT = 1,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 11.899999999999999, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(2.4000000000000004, Enum.EasingStyle.Exponential)
			})

			local Final = AssetsFolder.Final:Clone()
			Final:ScaleTo(0.9099999999999999)
			PlayMesh({
				Model = Final,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 6.3, -2) * CFrame.Angles(0, 0, 1.5707963267948966),
				Info = TweenInfo.new(2.4000000000000004, Enum.EasingStyle.Exponential)
			})


			local erm = QuickFX({
				FX = AssetsFolder.erm,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, 2, 0),
				Maid = Janitor
			})

			erm:ScaleTo(0.7)
			ParticlesModule.Emit(erm)


			local Beams = QuickFX({
				FX = AssetsFolder.Beams, 
				Maid = Janitor,
				Anchor = CFrame.new(Character.Torso.Position) * CFrame.Angles(0, YOrientation, 0) * CFrame.new(0, -6, -2) * CFrame.Angles(1.5707963267948966, 0, 0)
			})

			local BeamsScale = Janitor:Add(Instance.new("NumberValue"))
			Janitor:Add(BeamsScale.Changed:Connect(function()
				Beams:ScaleTo(BeamsScale.Value)
			end))

			BeamsScale.Value = 1

			TS:Create(BeamsScale, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
				Value = 3
			}):Play()

			TS:Create(Beams.PrimaryPart, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
				CFrame = Beams.PrimaryPart.CFrame * CFrame.Angles(0, 0, 0.4363323129985824)
			}):Play()

			for _, Part in Beams:GetDescendants() do
				if Part.Name == "A1" then
					TS:Create(Part, TweenInfo.new(0.2, Enum.EasingStyle.Sine), {
						CFrame = Part.CFrame * CFrame.new(0, 10, 10)
					}):Play()

				elseif Part:IsA("Beam") then
					Part.TextureSpeed *= 0.5

					BoatTween:Create(Part, {
						Time = 0.75, 
						EasingStyle = "Sine", 
						Goal = {
							TextureSpeed = 0.3, 
							Width0 = 10, 
							Width1 = 10, 
							Transparency = NumberSequence.new({
								NumberSequenceKeypoint.new(0, 1), 
								NumberSequenceKeypoint.new(1, 1)
							})
						}
					}):Play()

					Debris:AddItem(Part, 0.75)
				end
			end
		--end)
	end
end