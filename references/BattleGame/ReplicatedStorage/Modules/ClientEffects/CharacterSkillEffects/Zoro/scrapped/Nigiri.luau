--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local Players           = game:GetService("Players")


local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local LocalPlayer      = Players.LocalPlayer


local spinVFX = {}

return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType
	local isLocalPlayer   = LocalPlayer.Character == attacker

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

  
	local function spawnVFX(vfxTemplate, cframe, lifetime)
		local clone = vfxTemplate:Clone()
		clone.CFrame = cframe
		clone.Parent = workspace.World.Debris
		VFXFunctions.EmitDescendants(clone)
		Debris:AddItem(clone, lifetime)
		return clone
	end

	
	if skillType == "Dash" then
		local Dash = script.DashCur:Clone()
		Dash.CFrame = hrp.CFrame
		Dash.Parent = workspace.World.Visuals

		VFXFunctions.EmitDescendants(Dash)
		
		VFXFunctions.TaskDebris(Dash, 4)
		
		local dashVelocity = Instance.new("BodyVelocity")
		--dashVelocity.Name = "FrontDashVelocity"
		dashVelocity.MaxForce = Vector3.new(40000, 0, 40000)
		
		--shared.clearVelocities(hrp, BodyVelocity)
		dashVelocity.Parent = hrp


		task.spawn(function()
			shared.addshake(2.5)
		end)


		local Speed = 140
		local stopLoop = nil
		stopLoop = shared.loop(function()
			if Speed > 26 and dashVelocity and dashVelocity.Parent then
				Speed *= 0.93

				dashVelocity.Velocity = hrp.CFrame.LookVector	* Speed
			else
				stopLoop()
			end
		end)
	end
	
	
	if skillType == "Slash1" then
		print("slash")
		local Slash = script.Slash:Clone()
		Slash.Parent = workspace.World.Visuals
		Slash.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
		VFXFunctions.EmitDescendants(Slash.slash1)

		VFXFunctions.TaskDebris(Slash, 4)
	end
	if skillType == "Slash2" then
		local Slash = script.Slash:Clone()
		Slash.Parent = workspace.World.Visuals

		Slash.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
		VFXFunctions.EmitDescendants(Slash.slash2)

		VFXFunctions.TaskDebris(Slash, 4)
	end
	if skillType == "Slash3" then
		local Slash = script.Slash:Clone()
		Slash.Parent = workspace.World.Visuals

		Slash.CFrame = hrp.CFrame * CFrame.new(0,0,-3)
		VFXFunctions.EmitDescendants(Slash.slash3)

		VFXFunctions.TaskDebris(Slash, 4)
	end
	
	-- client side
	local hideList = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

	if skillType == "transparent" then
		for _, name in ipairs(hideList) do
			local part = attacker:FindFirstChild(name, true)
			if part then
				part.Transparency = 1
			end
		end
		-- hide swords specifically
		local zoroSwords = attacker:FindFirstChild("ZoroSwords")
		if zoroSwords then
			local sword = zoroSwords:FindFirstChild("Sword", true)
			if sword then
				sword.Transparency = 1
			end
		end
	end

	if skillType == "untransparent" then
		for _, name in ipairs(hideList) do
			local part = attacker:FindFirstChild(name, true)
			if part then
				part.Transparency = 0
			end
		end
		-- show swords specifically
		local zoroSwords = attacker:FindFirstChild("ZoroSwords")
		if zoroSwords then
			local sword = zoroSwords:FindFirstChild("Sword", true)
			if sword then
				sword.Transparency = 0
			end
		end
	end
	if skillType == "NigiriFinisherDash" then
		if not isLocalPlayer then return end
		local target = argumentData.Target

		local targetHRP = target:FindFirstChild("HumanoidRootPart")
		if not hrp or not targetHRP then return end

		local targetCFrame = CFrame.lookAt(
			targetHRP.Position + (targetHRP.CFrame.LookVector * -45),
			targetHRP.Position
		)

		TS:Create(hrp, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			CFrame = targetCFrame
		}):Play()
		print("TweenDash")

	end
	if skillType == "FinisherDashEffect" then
		local target = argumentData.Target
		local targetHRP = target and target:FindFirstChild("HumanoidRootPart")
		if not targetHRP then return end

		local dashDistance = (hrp.Position - targetHRP.Position).Magnitude
		
		local Dash = script.Finish.Dash:Clone()
		Dash.Parent = workspace.World.Visuals
		Dash.CFrame = hrp.CFrame * CFrame.new(0, 0, 0)
		VFXFunctions.EmitDescendants(Dash)
		VFXFunctions.TaskDebris(Dash, 4)
		
		-- woosh tween
		local effect = script.FinisherEffects.dasheffectBuso:Clone()
		effect:PivotTo(hrp.CFrame)
		effect.Parent = workspace.World.Visuals

		TS:Create(effect.woosh, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.woosh.CFrame * CFrame.new(0, -dashDistance-30, 0) * CFrame.Angles(0, 2.98, 0),
			Size = Vector3.new(1, 25, 1)
		}):Play()

		-- ring tween
		TS:Create(effect.ring, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.ring.CFrame * CFrame.new(0, dashDistance * 0.75, 0),
			Size = effect.ring.Size * Vector3.new(1.5, 0, 1.5)
		}):Play()

		-- particles
		effect.woosh.Attachment.Sparkles:Emit(1)
		effect.woosh.Attachment.Waves:Emit(6)

		-- sphere trail
		local rng = Random.new()
		local sphere = effect.sphere
		--local alternate = false

		for i = 0, .9, 0.02 do
			local clone = sphere:Clone()
			clone.CFrame = hrp.CFrame * CFrame.new(rng:NextNumber(-9, 9), rng:NextNumber(-5, 8), -i * dashDistance * 0.25)

			--if alternate then
				--clone.BrickColor = BrickColor.new("Light blue")
			--end

			--clone.Parent = effect

			TS:Create(clone, TweenInfo.new(i * 0.2 + 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1,
				CFrame = hrp.CFrame * CFrame.new(0, 0, -dashDistance + rng:NextNumber(-5, dashDistance)),
				Size = Vector3.new(0, 0, i * 4 + 3)
			}):Play()

			--alternate = not alternate
		end

		task.delay(0.2, function()
			if effect and effect.Parent then
				effect.woosh.new3.Enabled = false
			end
		end)

		sphere:Destroy()
		Debris:AddItem(effect, 5.5)
	end
	if skillType == "TowerSlash" then
		--if not _G.checkRenderDistance or _G.checkRenderDistance(hrp.Position) == false then return end

		--_G.PlaySound(hrp, script.Parent.sounds.shortslash)
		--_G.PlaySound(hrp, script.Parent.sounds.longslash)

		local effect = script.FinisherEffects.slashBuso:Clone()
		effect:PivotTo(hrp.CFrame)
		effect.Parent = workspace.World.Visuals

		local rng = Random.new()
		
		local Dash = script.Finish.Hit:Clone()
		Dash.Parent = workspace.World.Visuals
		Dash.CFrame = hrp.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0,0,10)
		VFXFunctions.EmitDescendants(Dash)
		VFXFunctions.TaskDebris(Dash, 4)

		-- slasha/slashb decal + mesh loop
		task.spawn(function()
			for v = -0.9, 1.2, 0.3 do
				effect.slasha.root.CFrame = effect.slasha.root.CFrame * CFrame.Angles(0, 0.9, 0)
				effect.slashb.root.CFrame = effect.slashb.root.CFrame * CFrame.Angles(0, 0.9, 0)
				effect.slasha.root.Decal.Transparency = v
				effect.slasha.Part.Decal.Transparency = v
				effect.slashb.root.Decal.Transparency = v
				effect.slashb.Part.Decal.Transparency = v
				effect.slasha.root.Mesh.Scale = effect.slasha.root.Mesh.Scale + Vector3.new(2.2, 0, 2.2)
				effect.slasha.Part.Mesh.Scale = effect.slasha.Part.Mesh.Scale - Vector3.new(2.2, 0, 2.2)
				effect.slashb.root.Mesh.Scale = effect.slashb.root.Mesh.Scale + Vector3.new(2.2, 0, 2.2)
				effect.slashb.Part.Mesh.Scale = effect.slashb.Part.Mesh.Scale - Vector3.new(2.2, 0, 2.2)
				game:GetService("RunService").Heartbeat:Wait()
			end
		end)

		-- slice1 tween
		TS:Create(effect.slice1, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.slice1.CFrame * CFrame.new(0, 0, 20),
			Size = effect.slice1.Size * Vector3.new(0, 0, 4)
		}):Play()

		-- tiny slice scatter
		local tinyslice = effect.tinyslice
		for i = 1, 10 do
			local speed = rng:NextNumber(1, 3)
			local dist = rng:NextNumber(0, i)
			local clone = tinyslice:Clone()
			clone.CFrame = effect.slice1.CFrame * CFrame.new(rng:NextNumber(-1, 1), rng:NextNumber(-2, 2), rng:NextNumber(-1, 1))
			clone.Parent = effect
			TS:Create(clone, TweenInfo.new(rng:NextNumber(0.2, 0.5), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1,
				CFrame = clone.CFrame * CFrame.new(0, 0, 6 * dist) * CFrame.Angles(0, 0, rng:NextNumber(0, 1.5)),
				Size = Vector3.new(0.05, 0.1, 4 * speed)
			}):Play()
		end
		tinyslice:Destroy()

		-- swirl tweens
		local swirlRot = CFrame.Angles(0, 3.047, 0)

		TS:Create(effect.swirl1, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.swirl1.CFrame * swirlRot,
			Size = Vector3.new(30, 0, 30)
		}):Play()

		TS:Create(effect.swirl2, TweenInfo.new(1.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.swirl2.CFrame * swirlRot,
			Size = Vector3.new(25, 0, 25)
		}):Play()

		TS:Create(effect.areaswirl, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.areaswirl.CFrame * swirlRot,
			Size = effect.areaswirl.Size * 6
		}):Play()

		TS:Create(effect.sliceswirl, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.sliceswirl.CFrame * CFrame.new(0, 8, 0) * swirlRot,
			Size = effect.sliceswirl.Size * Vector3.new(0.75, 2, 0.75)
		}):Play()

		Debris:AddItem(effect, 3)
	end
	
	if skillType == "FinalSlash" then
		local effect = script.FinisherEffects.finalslashBuso:Clone()
		effect:PivotTo(hrp.CFrame)
		effect.Parent = workspace.World.Visuals

		-- color correction if close enough
		if (workspace.CurrentCamera.CFrame.Position - hrp.Position).Magnitude < 100 then
			local cc = effect.ColorCorrection
			cc.Parent = workspace.CurrentCamera
			TS:Create(cc, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
				Contrast = 0,
				Enabled = false
			}):Play()
			Debris:AddItem(cc, 0.5)
		end
		
		local Dash = script.Finish.Finalslash:Clone()
		Dash.Parent = workspace.World.Visuals
		Dash.CFrame = hrp.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0,0,10)
		VFXFunctions.EmitDescendants(Dash)
		VFXFunctions.TaskDebris(Dash, 4)

		local swirlRot = CFrame.Angles(0, 3.047, 0)

		-- slasha/slashb decal + mesh loop
		task.spawn(function()
			for v = -2.2, 1.2, 0.2 do
				effect.slasha.root.CFrame = effect.slasha.root.CFrame * CFrame.Angles(0, 0.9, 0)
				effect.slashb.root.CFrame = effect.slashb.root.CFrame * CFrame.Angles(0, 0.9, 0)
				effect.slasha.root.Decal.Transparency = v
				effect.slasha.Part.Decal.Transparency = v
				effect.slashb.root.Decal.Transparency = v
				effect.slashb.Part.Decal.Transparency = v
				effect.slasha.root.Mesh.Scale = effect.slasha.root.Mesh.Scale + Vector3.new(3.2, 1, 3.2)
				effect.slasha.Part.Mesh.Scale = effect.slasha.Part.Mesh.Scale - Vector3.new(3.2, 1, 3.2)
				effect.slashb.root.Mesh.Scale = effect.slashb.root.Mesh.Scale + Vector3.new(3.2, 1, 3.2)
				effect.slashb.Part.Mesh.Scale = effect.slashb.Part.Mesh.Scale - Vector3.new(3.2, 1, 3.2)
				game:GetService("RunService").Heartbeat:Wait()
			end
		end)

		-- bigslice tween
		TS:Create(effect.bigslice, TweenInfo.new(1.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			CFrame = effect.bigslice.CFrame * CFrame.new(0, 0, 30),
			Size = effect.bigslice.Size * Vector3.new(0.15, 0.15, 5)
		}):Play()

		task.delay(0.2, function()
			if not effect.Parent then return end
			TS:Create(effect.bigslice.Mesh, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
				Scale = Vector3.new(0, 1, 0),
				Offset = Vector3.new(0, 0, 50)
			}):Play()
		end)

		-- sparkles
		--effect.root.Attachment.Sparkles:Emit(16)

		-- horislice tweens
		TS:Create(effect.horislice1, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.horislice1.CFrame * CFrame.new(0, 0, 14),
			Size = effect.horislice1.Size * Vector3.new(0.1, 0, 4)
		}):Play()

		TS:Create(effect.horislice2, TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.horislice2.CFrame * CFrame.new(0, 0, 14),
			Size = effect.horislice2.Size * Vector3.new(0, 0.1, 4)
		}):Play()

		-- swirl tweens
		TS:Create(effect.areaswirl1, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.areaswirl1.CFrame * swirlRot,
			Size = effect.areaswirl1.Size * 2
		}):Play()

		TS:Create(effect.areaswirl2, TweenInfo.new(1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.areaswirl2.CFrame * swirlRot,
			Size = effect.areaswirl2.Size * 3
		}):Play()

		TS:Create(effect.sliceswirl, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.sliceswirl.CFrame * CFrame.new(0, 24, 0) * swirlRot,
			Size = effect.sliceswirl.Size * Vector3.new(2.5, 4, 2.5)
		}):Play()

		TS:Create(effect.ring, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.ring.CFrame * CFrame.new(0, 20, 0),
			Size = effect.ring.Size * Vector3.new(1.8, 0, 1.8)
		}):Play()

		Debris:AddItem(effect, 3)
	end
	
end