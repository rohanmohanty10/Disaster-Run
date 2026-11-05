--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

return function(argumentData: any)
	local Character = argumentData.Character
	if not Character then return end

	-- destroy every particle this emote added (tagged by attribute)
	local function clearFX()
		for _, d in Character:GetDescendants() do
			if d:GetAttribute("_HakariFX") then d:Destroy() end
		end
	end

	if argumentData.Status == "Stop" then
		clearFX()
		return
	end

	clearFX()  -- clear any stale set first

	local assets = script.Hakari
	local torsoParticles = assets.TorsoParticle:GetChildren()
	local armParticles = assets.ArmParticle:GetChildren()
	


	local limbs = { "Torso", "Left Arm", "Right Arm" }  -- R6 limb names
	for _, limbName in limbs do
		local limb = Character:FindFirstChild(limbName)
		if limb then
			local source = (limbName == "Torso") and torsoParticles or armParticles
			for _, particle in source do
				local clone = particle:Clone()
				clone:SetAttribute("_HakariFX", true)   -- tag for cleanup
				clone.Parent = limb
			end
		end
	end
	
	local attachments = { "4", "5", "6" }  -- R6 limb names
	for _, attachment in attachments do
		local torso = Character:FindFirstChild("Torso")
		if torso then
			local clone = script.Hakari:FindFirstChild(attachment):Clone()
			clone:SetAttribute("_HakariFX", true)   -- tag for cleanup
			clone.Parent = Character:FindFirstChild("HumanoidRootPart")
		end
	end
end