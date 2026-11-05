--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

local FX_ATTRIBUTE = "_AuraFarming"

return function(argumentData: any)
	local Character = argumentData.Character
	if not Character then return end

	-- destroy every effect this emote added (tagged by attribute)
	local function clearFX()
		for _, d in Character:GetDescendants() do
			if d:GetAttribute(FX_ATTRIBUTE) then d:Destroy() end
		end
	end

	if argumentData.Status == "Stop" then
		clearFX()
		return
	end

	clearFX()  -- clear any stale set first

	-- Each folder under the asset is named after an R6 limb; clone its contents
	-- onto the matching limb of the character.
	local assets = script
	if not assets then
		warn("Aura Farming Emote asset folder not found under", script:GetFullName())
		return
	end

	for _, limbFolder in assets:GetChildren() do
		local limb = Character:FindFirstChild(limbFolder.Name)
		if limb then
			for _, effect in limbFolder:GetChildren() do
				local clone = effect:Clone()
				clone:SetAttribute(FX_ATTRIBUTE, true)   -- tag for cleanup
				clone.Parent = limb
			end
		end
	end
end