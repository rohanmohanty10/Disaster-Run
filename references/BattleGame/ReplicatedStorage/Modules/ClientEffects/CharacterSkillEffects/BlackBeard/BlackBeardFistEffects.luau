local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer


local EffectUtilities = require(ReplicatedStorage.Modules.ClientEffects.EffectUtilities)

return function(argumentData: any)
	local attacker: Model = argumentData.Attacker
	local skillType = argumentData.SkillType

	local hrp = attacker and attacker:FindFirstChild("HumanoidRootPart")
	local RightArm = attacker and attacker:FindFirstChild("Right Arm")

	if not hrp then return end

	if skillType == "m1" then
		local function applyArmVFX(armName)
			local Arm = attacker:FindFirstChild(armName)
			if not Arm then return end

			local clone = script.Punches.Effect:Clone()
			local flame1 = script.Punches.Flame:Clone()
			local flame2 = script.Punches.Flame2:Clone()

			clone.Parent = workspace.World.Debris
			flame1.Parent = Arm
			flame2.Parent = Arm

			flame1.Enabled = true
			flame2.Enabled = true
			task.delay(0.25, function()
				flame1.Enabled = false
				flame2.Enabled = false
			end)

			clone["2"].fire.Enabled = true
			task.delay(.2, function()
				clone["2"].fire.Enabled = false
			end)

			local weld = Instance.new("Weld")
			weld.Part0 = clone
			weld.Part1 = Arm
			weld.C1 = CFrame.new(0, -1, 0)
			weld.Parent = clone

			--task.delay(0.25, function()
			--	for _, v in ipairs(clone:GetDescendants()) do
			--		if v:IsA("Trail") then
			--			v.Enabled = false
			--		end
			--	end
			--end)

			Debris:AddItem(clone, 1.05)
			Debris:AddItem(flame1, 1)
			Debris:AddItem(flame2, 1)
		end

		applyArmVFX("Right Arm")
		applyArmVFX("Left Arm")
	end

	if skillType == "rightArmAura" then
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local Arm = attacker:FindFirstChild("Right Arm")
		local ToUse = ReplicatedStorage.Assets.Effects.BlackBeard.RegularAbilities.ThirdAbility["Left Arm"]
		local clone = ToUse:Clone()
		clone.CFrame = Arm.CFrame
		clone.Parent = workspace.World.Debris

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.Parent = clone

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.ZOffset = v.ZOffset + 1
			end
		end
		
		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 2)
	end
	
	if skillType == "leftArmAura" then
		local Torso = attacker:FindFirstChild("Torso") or attacker:FindFirstChild("HumanoidRootPart")
		local Arm = attacker:FindFirstChild("Left Arm")
		local ToUse = ReplicatedStorage.Assets.Effects.BlackBeard.RegularAbilities.ThirdAbility["Left Arm"]
		local clone = ToUse:Clone()
		clone.CFrame = Arm.CFrame
		clone.Parent = workspace.World.Debris

		local weld = Instance.new("Weld")
		weld.Part0 = clone
		weld.Part1 = Arm
		weld.Parent = clone

		for _, v in ipairs(clone:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.ZOffset = v.ZOffset + 1
			end
		end
		
		EffectUtilities.Emit(clone)

		Debris:AddItem(clone, 2)
	end
end