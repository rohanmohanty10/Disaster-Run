--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")

local VFXFunctions = require(ReplicatedStorage.Modules.ClientEffects.VfxHandler)


return function(argumentData: any)
    local attacker: Model = argumentData.Attacker
    local skillType = argumentData.SkillType

    local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local function applyFacingCFrame(sourceFolder, cloneFolder, facingCFrame)
        local rootPart = cloneFolder:FindFirstChildWhichIsA("BasePart", true)
        local rootCFrame = rootPart.CFrame
        for _, v in ipairs(cloneFolder:GetDescendants()) do
            if v:IsA("BasePart") then
                local relativeOffset = rootCFrame:ToObjectSpace(v.CFrame)
                v.CFrame = facingCFrame * relativeOffset
            end
        end
    end

    local function getFacingCFrame(torso, offset)
        local look = torso.CFrame.LookVector
        local flatLook = Vector3.new(look.X, 0, look.Z).Unit
        return CFrame.lookAt(torso.CFrame.Position, torso.CFrame.Position + flatLook) * (offset or CFrame.new())
    end

    local function emitClone(clone)
        for _, v in ipairs(clone:GetDescendants()) do
            if v:IsA("ParticleEmitter") then
                local duration = v:GetAttribute("EmitDuration")
                if duration then
                    v.Enabled = true
                    task.delay(duration, function()
                        v.Enabled = false
                    end)
                else
                    v:Emit(v:GetAttribute("EmitCount"))
                end
            end
        end
    end

    if skillType == "start" then
        local Torso = attacker:FindFirstChild("Torso") or hrp
        local LeftLeg = attacker:FindFirstChild("Left Leg")
        local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Start

        local facingCFrame = getFacingCFrame(Torso)

        -- AirWind
        local clone = source:Clone()
        clone.Parent = workspace.World.Visuals

        local airWindRoot = clone.AirWind
        airWindRoot.CFrame = facingCFrame * CFrame.new(0, -.7, .4)
        emitClone(clone.AirWind)

        -- Sweep
        clone.sweep.CFrame = facingCFrame * CFrame.new(.5, -1.9, .4)
        emitClone(clone.sweep)

        Debris:AddItem(clone, 4)
    end

    if skillType == "spin" then
        local Torso = attacker:FindFirstChild("Torso") or hrp
        local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Start

        local facingCFrame = getFacingCFrame(Torso)

        local clone = source:Clone()
        clone.Parent = workspace.World.Visuals

        clone.sweep.CFrame = facingCFrame * CFrame.new(.5, -1.9, .4)
        emitClone(clone.sweep)

        Debris:AddItem(clone, 4)
    end

    if skillType == "move" then
		local Torso = attacker:FindFirstChild("Torso") or hrp
		local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Move
		local facingCFrame = getFacingCFrame(hrp)
		local clone = source:Clone()
		clone.Parent = workspace.World.Visuals

		clone.fxStep2.CFrame = facingCFrame * CFrame.new(-.05, -.3, 1.162)
		clone.DustKickLeft.CFrame = facingCFrame * CFrame.new(-.05, -2.3, 0)

		-- Weld all parts to HRP so they follow the player
		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = false
				local weld = Instance.new("Weld")
				weld.Part0 = hrp
				weld.Part1 = v
				weld.Parent = v
			end
		end

		emitClone(clone.fxStep2)
		emitClone(clone.DustKickLeft)

		Debris:AddItem(clone, 5)

    end

	if skillType == "hit" then
		local Torso = attacker:FindFirstChild("Torso") or hrp
		local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Hit
		local facingCFrame = getFacingCFrame(hrp)
		local clone = source:Clone()
		clone.Parent = workspace.World.Visuals

		clone.fxThrow.CFrame = facingCFrame * CFrame.new(-1.1, .6, -4.4)
		clone.StrongPunch2.CFrame = facingCFrame * CFrame.new(-1.05, .6, -5.2)

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("BasePart") then
				v.Anchored = false
				local weld = Instance.new("Weld")
				weld.Part0 = hrp
				weld.Part1 = v
				-- C0 preserves the offset between HRP and the part's current CFrame
				weld.C0 = hrp.CFrame:ToObjectSpace(v.CFrame) * CFrame.Angles(0,math.rad(180), 0)
				weld.Parent = v
			end
		end

		emitClone(clone.fxThrow)
		task.delay(.2, function()
			for _, v in ipairs(clone:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v.LockedToPart = false
				end
			end
		end)
		emitClone(clone.StrongPunch2)

		Debris:AddItem(clone, 5)
	end
	
	
	
	if skillType == "FireLegMoutonKickStartup" then
		
		local names = {"FireLegBottom", "FireLegTop", "FireLegRightLowerLeg"}

		local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Linear)
		
		task.spawn(function()
			for _, name in pairs(names) do
				local part = attacker["Left Leg"]:FindFirstChild(name)
				if part then
					local tween = TS:Create(part, tweenInfo, {Transparency = 0})
					tween:Play()

				end
			end
		end)
		
		VFXFunctions.EnableDescendants(attacker["Left Leg"].FireLegRightLowerLeg)
		
	end
	
	if skillType == "FireCharge" then
		local FireChargeVFX = require(script.FireCharge)
		local origin = attacker:FindFirstChild("Left Leg") --or hrp

		-- Signature: (originPart, isFire, minDist, maxDist, count)
		--   isFire = true  -> red "Mera" palette + MeraChargeParticles
		--   minDist/maxDist -> radius of the shell the streaks spawn from
		--   count -> number of streaks
		FireChargeVFX(origin, true, 8, 10, 1.25)	
	end

	if skillType == "FireLegMoutonKickDestroy" then

		local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Linear)
		local names = {"FireLegBottom", "FireLegTop", "FireLegRightLowerLeg"}
		task.spawn(function()
			for _, name in pairs(names) do
				local part = attacker["Left Leg"]:FindFirstChild(name)
				if part then
					local tween = TS:Create(part, tweenInfo, {Transparency = 1})
					tween:Play()
					
				end
			end
		end)
		
		VFXFunctions.DisableDescendants(attacker["Left Leg"].FireLegRightLowerLeg, false)

	end
	

    if skillType == "finisherHit" then
        local Torso = attacker:FindFirstChild("Torso") or hrp
        local source = ReplicatedStorage.Assets.Effects.Sanji.RegularAbilities.FirstAbility.Finisher

        local facingCFrame = getFacingCFrame(hrp)

        local clone = source:Clone()
        clone.Parent = workspace.World.Visuals

		clone.SlideCut.CFrame = facingCFrame * CFrame.new(1.05, 1, -2.9) * CFrame.Angles(math.rad(11), math.rad(168), 0)	
		
		for _, v in ipairs(clone.SlideCut:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		Debris:AddItem(clone, 5)
		print("finisherHitEffects")
    end
end