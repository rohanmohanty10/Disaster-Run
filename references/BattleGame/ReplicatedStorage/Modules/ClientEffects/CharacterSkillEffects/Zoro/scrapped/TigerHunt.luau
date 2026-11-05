--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)

local Effects = ReplicatedStorage.Assets.Effects
local GpDestroy = require(ReplicatedStorage.Modules.ClientEffects.EffectHelper.CustomDeb)


local spinVFX = {}

return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

	
	
	local tbl_13_upvr = {}
	local activeTweens = {}
	local BoatTween_upvrGPO = require(game.ReplicatedStorage.Modules.ClientEffects.EffectHelper.BoatTween)



	local activeTweens = tbl_13_upvr

	function _G.tween(instance, tweenParams, goalTable, stepType, forceRestart)

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
	
	
	local function spawnVFX(vfxTemplate, cframe, lifetime)
		local clone = vfxTemplate:Clone()
		clone.CFrame = cframe
		clone.Parent = workspace.World.Debris
		VFXFunctions.EmitDescendants(clone)
		Debris:AddItem(clone, lifetime)
		return clone
	end
	
	--local zoroEffects = Effects.Zoro.RegularAbilities.FirstAbility
	--local zoroEffectsNew = Effects.Zoro.RegularAbilities.FirstAbility.New
	
    if skillType == "jump" then
		spawnVFX(script.Jump, hrp.CFrame - Vector3.new(0, -3, 0), 3)
		
	end
	
	if skillType == "swing" then
		--spawnVFX(script.Tigerhunt, hrp.CFrame, 3)
		--spawnVFX(script.Tigerhunt3, hrp.CFrame, 3)

		----spawnVFX(script.Tigerhunt2, hrp.CFrame, .5)
		
		
		--local clone = script.Tigerhunt2:Clone()
		--clone.CFrame = hrp.CFrame
		--clone.Parent = workspace.World.Debris
		--VFXFunctions.EnableTime(clone, true, .3)
		--task.delay(.3, function()
		--	VFXFunctions.DisableDescendants(clone)

		--end)
		
		
		
		local folder = Instance.new("Folder")
		folder.Parent = workspace.World.Visuals

		--local hrp = attacker:WaitForChild("HumanoidRootPart")
		--character:WaitForChild("Humanoid")

		-- Clone VFX assets
		--local slashVFX   = script.Tigerhunt:Clone()
		local slashVFX   = script.UltraTigerHunt:Clone()

		local impactVFX  = script.Impact2:Clone()
		local meshVFX    = script.Mesh:Clone()
		
		

		-- Position slash at attacker, impact at hit point
		slashVFX.CFrame  = hrp.CFrame
		slashVFX.Parent     = workspace.World.Debris
		
		--impactVFX.CFrame = impactCFrame
		impactVFX.CFrame = hrp.CFrame * CFrame.new(0, -2, -6)

		meshVFX.CFrame   = impactVFX.CFrame
			* CFrame.new(0, 4, 0)
			* CFrame.Angles(0, 0, math.pi / 2)

		--_G.PlaySound(character.PrimaryPart, script["3ssTigerHuntSlash"])

		-- Ground-color-matched debris if floor detected
		--local groundMaterial = _G.getRayFloor(impactCFrame, 2)
		--if groundMaterial then
		--	_G.recolorParticles(impactVFX, groundMaterial.Color)

		--	_G.PlayEffect("GroundRocks4", nil, {
		--		Segments          = 20,
		--		Position          = impactVFX.Position + Vector3.new(0, 5, 0),
		--		DistanceRandomness = Vector2.new(0.25, 1),
		--		Duration          = 2,
		--		TweenDuration     = 1,
		--		Radius            = 9,
		--		Direction         = Vector3.new(0, -15, 0),
		--	})

		--	_G.PlayEffect("RockDebris", nil, {
		--		PartCount              = 8,
		--		RandomVelocityMagnitude = Vector2.new(-55, 55) / 2,
		--		Position               = impactVFX.Position,
		--		Direction              = Vector3.new(0, 65, 0),
		--		RaycastDirection       = Vector3.new(0, -30, 0),
		--		Size                   = Vector3.new(0.7, 0.7, 0.7),
		--		TrailEnabled           = true,
		--	})
		--end

		-- Red-orange highlight on the mesh (occluded so it shows through geometry)
		local highlight = Instance.new("Highlight")
		highlight.DepthMode          = Enum.HighlightDepthMode.Occluded
		highlight.FillTransparency   = 0.25
		highlight.OutlineTransparency = 0.25
		highlight.FillColor          = Color3.fromRGB(0, 0, 0)
		highlight.OutlineColor       = Color3.fromRGB(157, 242, 255)
		highlight.Parent             = meshVFX

		-- Apply optional recolor
		--if recolor then
		--	_G.PlayEffect("3SSRecolor", nil, { impactVFX, slashVFX, meshVFX }, recolor)
		--	highlight.OutlineColor = recolor
		--end

		-- Parent everything into the folder
		slashVFX.Parent  = folder
		impactVFX.Parent = folder
		meshVFX.Parent   = folder

		-- Emit slash particles
		--_G.customEmit(slashVFX)
		VFXFunctions.EmitDescendants(slashVFX)
		VFXFunctions.EmitDescendants(impactVFX)


		-- Emit ground smash particles only if flagged
		--if doGroundSmash then
		--	_G.customEmit(impactVFX)
		--	_G.PlaySound(impactVFX, script["3ssTigerHuntGroundSmash"], {
		--		RandomPitch = true,
		--	})
		--end

		-- Expand mesh outward (horizontal slash ring)
		_G.tween(meshVFX, { 0.35, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
			Size         = Vector3.new(18, 0, 0),
			Transparency = 0.04,
		})

		-- Fade out beams on the slash VFX
		for _, child in ipairs(slashVFX:GetDescendants()) do
			if child:IsA("Beam") then
				_G.tween(child, { .17, "Quad", Enum.EasingDirection.Out, 0, false, 0 }, {
					Width0 = 0,
					Width1 = 0,
				})
			end
		end

		 --Cleanup after 1.5s (with a 1.5s fade)
		task.delay(15, function()
			--_G.destroy(folder, 1.5)
			GpDestroy(folder, 1.5)
			
		end)

		



	end
	
	if skillType == "hit" then
		

		
		--spawnVFX(script.Teleport, CFrame.new(origin), 3)
		
		
		--spawnVFX(script.Impact2, argumentData.Position, 3)


		--spawnVFX(script.Dash, dashCFrame, 4)

		



	end
	
end