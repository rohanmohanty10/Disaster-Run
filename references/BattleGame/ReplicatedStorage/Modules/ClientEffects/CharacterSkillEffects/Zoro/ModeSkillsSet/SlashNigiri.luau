--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local Players           = game:GetService("Players")


local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)
local ParticlesModule     = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler.Particles)

local LocalPlayer      = Players.LocalPlayer


local spinVFX = {}


local IndestructibleParams = RaycastParams.new()
IndestructibleParams.FilterType = Enum.RaycastFilterType.Include
IndestructibleParams.FilterDescendantsInstances = { workspace.World.Map["Indestructible Map"] }
IndestructibleParams.RespectCanCollide = true

local WALL_BUFFER = 5


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

	-- quick forward lunge (local player only — they own their own root part)
	local function lungeForward(distance, duration)
		if not isLocalPlayer then return end

		local lunge = Instance.new("BodyVelocity")
		lunge.Name = "SlashLunge"
		lunge.MaxForce = Vector3.new(1e5, 0, 1e5)              -- horizontal only, gravity stays on
		lunge.Velocity = hrp.CFrame.LookVector * (distance / duration)
		lunge.Parent = hrp
		Debris:AddItem(lunge, duration)
	end
	
	
	-- play a slash VFX template from the Slashes folder at the attacker's HRP
	-- play a slash attachment from the Slashes folder, parented to the attacker's HRP
	local function playSlash(template, lifetime)
		local clone = template:Clone()
		clone.Parent = hrp
		VFXFunctions.EmitDescendants(clone)
		Debris:AddItem(clone, lifetime or 4)
		return clone
	end
	
	
	if skillType == "slash1" then
		lungeForward(20, 0.15)
		playSlash(script.Slashes.Slash1, 4)
	elseif skillType == "slash2" then
		lungeForward(20, 0.15)
		playSlash(script.Slashes.Slash2, 4)
	elseif skillType == "slash3" then
		lungeForward(20, 0.15)
		playSlash(script.Slashes.Slash3, 4)
	elseif skillType == "slash4" then
		playSlash(script.Slashes.Slash4, 4)
	end
	
	-- client side
	--local hideList = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"}

	-- hide/show everything visual on a character: body, accessories, hair, face, swords...
	local function setCharacterHidden(char, hidden)
		for _, inst in ipairs(char:GetDescendants()) do
			if inst:IsA("BasePart") or inst:IsA("Decal") or inst:IsA("Texture") then
				if hidden then
					-- remember the real transparency so we can put it back exactly
					if inst:GetAttribute("PreHideT") == nil then
						inst:SetAttribute("PreHideT", inst.Transparency)
					end
					inst.Transparency = 1
				else
					local orig = inst:GetAttribute("PreHideT")
					if orig ~= nil then
						inst.Transparency = orig
						inst:SetAttribute("PreHideT", nil)
					end
				end
			end
		end
	end
	if skillType == "transparent" then
		setCharacterHidden(attacker, true)
	end

	if skillType == "untransparent" then
		setCharacterHidden(attacker, false)
	end
	
	--if skillType == "NigiriFinisherDash" then
	--	if not isLocalPlayer then return end
	--	local target = argumentData.Target

	--	local targetHRP = target:FindFirstChild("HumanoidRootPart")
	--	if not hrp or not targetHRP then return end

	--	-- CHANGED: raycast the dash path against indestructible walls and clamp
	--	-- the landing point, same as the OniGiri / 3000 Worlds server dashes
	--	local desiredPos = targetHRP.Position + (targetHRP.CFrame.LookVector * -75)
	--	local toDest = desiredPos - hrp.Position
	--	local dashDist = toDest.Magnitude

	--	if dashDist > 0.01 then
	--		local dir = toDest.Unit
	--		local result = workspace:Raycast(hrp.Position, dir * dashDist, IndestructibleParams)
	--		if result then
	--			local clampedDist = math.max(result.Distance - WALL_BUFFER, 0)
	--			desiredPos = hrp.Position + dir * clampedDist
	--		end
	--	end

	--	-- guard: if the clamp landed us on top of the target, lookAt would be degenerate
	--	local lookTarget = targetHRP.Position
	--	if (desiredPos - lookTarget).Magnitude < 0.01 then
	--		lookTarget = desiredPos + hrp.CFrame.LookVector
	--	end
	--	local targetCFrame = CFrame.lookAt(desiredPos, lookTarget)

	--	TS:Create(hrp, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
	--		CFrame = targetCFrame
	--	}):Play()
	--	print("TweenDash")
	--end
	
	if skillType == "NigiriFinisherDash" then
		if not isLocalPlayer then return end
		local target = argumentData.Target

		local targetHRP = target:FindFirstChild("HumanoidRootPart")
		if not hrp or not targetHRP then return end

		-- direction from attacker to target, flattened
		local toTarget = targetHRP.Position - hrp.Position
		local flat = Vector3.new(toTarget.X, 0, toTarget.Z)
		if flat.Magnitude < 0.01 then
			flat = Vector3.new(hrp.CFrame.LookVector.X, 0, hrp.CFrame.LookVector.Z)
		end
		local dashDir = flat.Unit

		-- land 75 studs PAST the target, along my own approach line
		local desiredPos = targetHRP.Position + dashDir * 75

		local toDest = desiredPos - hrp.Position
		local dashDist = toDest.Magnitude

		if dashDist > 0.01 then
			local dir = toDest.Unit
			local result = workspace:Raycast(hrp.Position, dir * dashDist, IndestructibleParams)
			if result then
				local clampedDist = math.max(result.Distance - WALL_BUFFER, 0)
				desiredPos = hrp.Position + dir * clampedDist
			end
		end

		-- face back toward the target (Zoro sheathing pose behind the victim)
		local lookTarget = targetHRP.Position
		if (desiredPos - lookTarget).Magnitude < 0.01 then
			lookTarget = desiredPos + hrp.CFrame.LookVector
		end
		local targetCFrame = CFrame.lookAt(desiredPos, lookTarget)

		TS:Create(hrp, TweenInfo.new(0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			CFrame = targetCFrame
		}):Play()
	end
	
	if skillType == "FinisherDashEffect" then
		local target = argumentData.Target
		local targetHRP = target and target:FindFirstChild("HumanoidRootPart")
		if not targetHRP then return end

		-- snapshot facing ONCE, flattened to horizontal so camera pitch/turn can't drift it
		-- aim at the target ONCE, flattened to horizontal so camera turn can't drift it
		local startPos = hrp.Position
		local toTarget = targetHRP.Position - hrp.Position
		local flat = Vector3.new(toTarget.X, 0, toTarget.Z)
		if flat.Magnitude < 0.01 then flat = hrp.CFrame.LookVector end  -- fallback if stacked directly on target
		local originCF = CFrame.lookAlong(startPos, flat.Unit)

		local dashDistance = (hrp.Position - targetHRP.Position).Magnitude

		local Dash = script.Finish.Dash:Clone()
		Dash.Parent = workspace.World.Visuals
		Dash.CFrame = originCF
		VFXFunctions.EmitDescendants(Dash)
		VFXFunctions.TaskDebris(Dash, 4)

		local effect = script.FinisherEffects.dasheffectBuso:Clone()
		effect:PivotTo(originCF)
		effect.Parent = workspace.World.Visuals

		TS:Create(effect.woosh, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.woosh.CFrame * CFrame.new(0, -dashDistance-30, 0) * CFrame.Angles(0, 2.98, 0),
			Size = Vector3.new(1, 25, 1)
		}):Play()

		TS:Create(effect.ring, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.ring.CFrame * CFrame.new(0, dashDistance * 0.75, 0),
			Size = effect.ring.Size * Vector3.new(1.5, 0, 1.5)
		}):Play()

		effect.woosh.Attachment.Sparkles:Emit(1)
		effect.woosh.Attachment.Waves:Emit(6)

		local rng = Random.new()
		local sphere = effect.sphere

		for i = 0, .9, 0.02 do
			local clone = sphere:Clone()
			-- use the frozen originCF instead of live hrp.CFrame
			clone.CFrame = originCF * CFrame.new(rng:NextNumber(-9, 9), rng:NextNumber(-5, 8), -i * dashDistance * 0.25)

			TS:Create(clone, TweenInfo.new(i * 0.2 + 0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Transparency = 1,
				CFrame = originCF * CFrame.new(0, 0, -dashDistance + rng:NextNumber(-5, dashDistance)),
				Size = Vector3.new(0, 0, i * 4 + 3)
			}):Play()
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

		--TS:Create(effect.swirl1, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { --.9
		--	Transparency = 1,
		--	CFrame = effect.swirl1.CFrame * swirlRot,
		--	--Size = Vector3.new(30, 0, 30)
		--	Size = Vector3.new(50, 0, 50)

		--}):Play()

		--TS:Create(effect.swirl2, TweenInfo.new(.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { --1.2
		--	Transparency = 1,
		--	CFrame = effect.swirl2.CFrame * swirlRot,
		--	Size = Vector3.new(40, 0, 40) --25,0,25
		--}):Play()

		--TS:Create(effect.areaswirl, TweenInfo.new(1.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		--	Transparency = 1,
		--	CFrame = effect.areaswirl.CFrame * swirlRot,
		--	Size = effect.areaswirl.Size * 6
		--}):Play()

		--TS:Create(effect.sliceswirl, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
		--	Transparency = 1,
		--	CFrame = effect.sliceswirl.CFrame * CFrame.new(0, 8, 0) * swirlRot,
		--	Size = effect.sliceswirl.Size * Vector3.new(0.75, 2, 0.75)
		--}):Play()

		Debris:AddItem(effect, 3)
	end
	
	if skillType == "FinalSlash" then
		
		--local Explosion = Janitor:Add(AssetsFolder.ExplosionNew:Clone())
		local Explosion = script.FinisherEffects.Explosion:Clone()

		Explosion:PivotTo(hrp.CFrame * CFrame.new(0,-2,0))
		Explosion.Parent = workspace.World.Visuals
		ParticlesModule.Emit(Explosion)

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

		---- swirl tweens
		--TS:Create(effect.areaswirl1, TweenInfo.new(1.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		--	Transparency = 1,
		--	CFrame = effect.areaswirl1.CFrame * swirlRot,
		--	Size = effect.areaswirl1.Size * 4 --2
		--}):Play()

		--TS:Create(effect.areaswirl2, TweenInfo.new(1.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		--	Transparency = 1,
		--	CFrame = effect.areaswirl2.CFrame * swirlRot,
		--	Size = effect.areaswirl2.Size * 3
		--}):Play()

		TS:Create(effect.sliceswirl, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.sliceswirl.CFrame * CFrame.new(0, 24, 0) * swirlRot,
			Size = effect.sliceswirl.Size * Vector3.new(2.5, 4, 2.5)
		}):Play()

		TS:Create(effect.ring, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Transparency = 1,
			CFrame = effect.ring.CFrame * CFrame.new(0, 20, 0),
			Size = effect.ring.Size * Vector3.new(3.2, 0, 3.2) --1.8
		}):Play()

		Debris:AddItem(effect, 3)
	end
	
end