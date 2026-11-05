local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local weaponModels = ReplicatedStorage.Assets.Weapons
local ServerStorageModels = ServerStorage.Assets.Weapons

local CharacterEquipment = {}

function CharacterEquipment.Apply(player: Player, character: Model)
	if player:GetAttribute("Character") == "Sanji" then
		local leftLeg = player.Character:WaitForChild("Left Leg")
		if leftLeg:FindFirstChild("FireLegBottom") or leftLeg:FindFirstChild("FireLegTop") or leftLeg:FindFirstChild("FireLegRightLowerLeg") then
			return
		end

		local source = ReplicatedStorage.Assets.Effects.Sanji.ModeFireLeg
		local Bottom = source.Bottom:Clone()
		local Top = source.Top:Clone()
		local RightLowerLeg = source.RightLowerLeg:Clone()

		Bottom.Name = "FireLegBottom"
		Top.Name = "FireLegTop"
		RightLowerLeg.Name = "FireLegRightLowerLeg"

		local offsets = {
			[Bottom] = CFrame.new(0, -0.605, 0),
			[Top] = CFrame.new(0, -0.329, 0),
			[RightLowerLeg] = CFrame.new(0, -0.201, 0),
		}

		for _, part in pairs({Bottom, Top, RightLowerLeg}) do
			part.CanCollide = false
			part.Transparency = 1
			part.Parent = leftLeg

			local weld = Instance.new("Weld")
			weld.Part0 = leftLeg
			weld.Part1 = part
			weld.C0 = offsets[part]
			weld.Parent = part
		end

		local rightLeg = player.Character:WaitForChild("Right Leg")
		if rightLeg:FindFirstChild("FireLegBottom") or rightLeg:FindFirstChild("FireLegTop") or rightLeg:FindFirstChild("FireLegRightLowerLeg") then
			return
		end
		local source = ReplicatedStorage.Assets.Effects.Sanji.ModeFireLeg
		local Bottom = source.Bottom:Clone()
		local Top = source.Top:Clone()
		local RightLowerLeg = source.RightLowerLeg:Clone()
		Bottom.Name = "FireLegBottom"
		Top.Name = "FireLegTop"
		RightLowerLeg.Name = "FireLegRightLowerLeg"
		local offsets = {
			[Bottom] = CFrame.new(0, -0.605, 0),
			[Top] = CFrame.new(0, -0.329, 0),
			[RightLowerLeg] = CFrame.new(0, -0.201, 0),
		}
		for _, part in pairs({Bottom, Top, RightLowerLeg}) do
			part.CanCollide = false
			part.Transparency = 1
			part.Parent = rightLeg
			local weld = Instance.new("Weld")
			weld.Part0 = rightLeg
			weld.Part1 = part
			weld.C0 = offsets[part]
			weld.Parent = part
		end

	elseif player:GetAttribute("Moveset") == "WhiteBeard" then
		local rightArm = character:WaitForChild("Right Arm")

		if character:FindFirstChild("Bisento") then
			return
		end

		local BisentoModel = ServerStorageModels.Bisento:Clone()
		BisentoModel.Name = "Bisento"
		BisentoModel.Parent = character

		local Handle = ServerStorageModels.Handle:Clone()
		Handle.Name = "Middle"
		Handle.Part0 = rightArm
		Handle.Part1 = BisentoModel.RightHandle
		--Handle.Parent = AllSwordsModel.Shisui
		Handle.Parent = BisentoModel.RightHandle

		Handle.C0 = CFrame.new(0, -0.85, 0)

	elseif player:GetAttribute("Moveset") == "Crocodile" then
		local rightArm = character:WaitForChild("Right Arm")

		if character:FindFirstChild("Hook") then
			return
		end

		local HookModel = ServerStorageModels.newhook:Clone()
		HookModel.Name = "Hook"
		HookModel.Parent = character

		local Handle = ServerStorageModels.Weld:Clone()
		Handle.Name = "handle"
		Handle.Part0 = rightArm
		Handle.Part1 = HookModel.hook
		--Handle.Parent = AllSwordsModel.Shisui
		Handle.Parent = rightArm

		Handle.C0 = CFrame.new(0.007, -1.505, 0.004) * CFrame.Angles(0,math.rad(180),0)

	elseif player:GetAttribute("Character") == "Zoro" then
		--task.wait(1)
		-- Adjust this if you use R15: "RightHand" instead of "Right Arm"
		local rightArm = character:WaitForChild("Right Arm")
		local leftArm = character:WaitForChild("Left Arm")



		local head = character:WaitForChild("Head")
		-- Avoid double-adding if character respawns or InitCharacter gets called twice
		if character:FindFirstChild("ZoroSwords") then
			return
		end

		-- Clone the sword model
		local AllSwordsModel = weaponModels.Zoro.ZoroSwords:Clone()
		AllSwordsModel.Name = "ZoroSwords"
		AllSwordsModel.Parent = character


		local Sword1 = weaponModels.Zoro["Handle"]:Clone()
		Sword1.Name = "Handle"
		Sword1.Part0 = rightArm
		Sword1.Part1 = AllSwordsModel.Shisui.Sword1
		Sword1.Parent = AllSwordsModel.Shisui
		Sword1.C0 = CFrame.new(-0.069, -0.995, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

		local Sword2 = weaponModels.Zoro["Handle"]:Clone()
		Sword2.Name = "Handle"
		Sword2.Part0 = leftArm
		Sword2.Part1 = AllSwordsModel["Sandai Kitetsu"].Sword2
		Sword2.Parent = AllSwordsModel["Sandai Kitetsu"]
		--Sword1.C0 = Sword1.C0 * CFrame.new(0, 0, 0)
		Sword2.C0 = CFrame.new(0.001, -0.993, 0.029) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))

		local Sword3 = weaponModels.Zoro["Handle"]:Clone()
		Sword3.Name = "Handle"
		Sword3.Part0 = head
		Sword3.Part1 = AllSwordsModel["Wado Ichimonji"].Handle
		Sword3.Parent = AllSwordsModel["Wado Ichimonji"]
		--Sword1.C0 = Sword1.C0 * CFrame.new(0, 0, 0)
		Sword3.C0 = CFrame.new(-0.001, -0.233, -0.721) * CFrame.Angles(0, math.rad(-90), math.rad(90))	

		local torso = character:WaitForChild("Torso")


		local Sheaths = weaponModels.Zoro.ZoroSwordSheaths:Clone()
		Sheaths.Name = "ZoroSwordSheaths"
		Sheaths.Parent = character

		local Sword1Sheath = weaponModels.Zoro["Handle"]:Clone()
		Sword1Sheath.Name = "Handle"
		Sword1Sheath.Part0 = torso
		Sword1Sheath.Part1 = Sheaths.Shisui.Handle3
		Sword1Sheath.Parent = Sheaths.Shisui
		Sword1Sheath.C0 = CFrame.new(1.116, -0.888, -0.045) * CFrame.Angles(math.rad(-.303), math.rad(-90.768), math.rad(90.002))
		Sword1Sheath.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		Sheaths.Shisui.SwordDec.Transparency = 1

		local Sword2Sheath = weaponModels.Zoro["Handle"]:Clone()
		Sword2Sheath.Name = "Handle"
		Sword2Sheath.Part0 = torso
		Sword2Sheath.Part1 = Sheaths["Sandai Kitetsu"].Handle1
		Sword2Sheath.Parent = Sheaths["Sandai Kitetsu"]
		Sword2Sheath.C0 = CFrame.new(1.012, -0.872, -0.045) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))
		Sword2Sheath.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		Sheaths["Sandai Kitetsu"].SwordDec.Transparency = 1

		local Sword3Sheath = weaponModels.Zoro["Handle"]:Clone()
		Sword3Sheath.Name = "Handle"
		Sword3Sheath.Part0 = torso
		Sword3Sheath.Part1 = Sheaths["Wado Ichimonji"].Handle2
		Sword3Sheath.Parent = Sheaths["Wado Ichimonji"]
		Sword3Sheath.C0 = CFrame.new(1.193, -0.974, -0.052) * CFrame.Angles(math.rad(0), math.rad(-90), math.rad(90))
		Sword3Sheath.C1 = CFrame.new(0,0,0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(0))
		Sheaths["Wado Ichimonji"].SwordDec.Transparency = 1

	elseif player:GetAttribute("Moveset") == "Luffy" then
		-- Left Leg  mesh and bones
		local LuffyAssets = ServerStorage.Assets.Models.Characters.Luffy
		local LGL = LuffyAssets.LGL:Clone()
		LGL.LGL.Part0 = character["Left Leg"]
		LGL.LGL.Part1 = LGL
		LGL.Parent = character
		local LeftLegBones = LuffyAssets.Bones["Left Leg"].LuffyWhip1:Clone()
		LeftLegBones.Parent = character["Left Leg"]


		-- Left Arm mesh and bones
		local LGM = LuffyAssets.LGM:Clone()
		LGM.LGM.Part0 = character["Left Arm"]
		LGM.LGM.Part1 = LGM
		LGM.Parent = character
		local LeftArmBones = LuffyAssets.Bones["Left Arm"].LArmBones:Clone()
		LeftArmBones.Parent = character["Left Arm"]


		-- Right Arm mesh and bones
		local RGM = LuffyAssets.RGM:Clone()
		RGM.RGM.Part0 = character["Right Arm"]
		RGM.RGM.Part1 = RGM
		RGM.Parent = character
		local LeftArmBones = LuffyAssets.Bones["Right Arm"].RArmBones:Clone()
		LeftArmBones.Parent = character["Right Arm"]	


		-- Now we make the legs and arms transparent. Later, we can make everything transparent if we create a custom mesh for luffy. Like the head and the torso.
		character["Left Leg"].Transparency = 1
		character["Left Arm"].Transparency = 1
		character["Right Arm"].Transparency = 1
	end
end

return CharacterEquipment