--ReplicatedStorage/Modules/ClientEffects/CharacterSkillEffects/Sanji/SanjiAbilityOne
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

return function(argumentData: any)
	local Character: Model = argumentData.Character

	local HumRP = Character and Character:FindFirstChild("HumanoidRootPart")
	if not HumRP then return end

	-- stop: destroy this character's effect container
	if argumentData.Status == "Stop" then
		local existing = HumRP:FindFirstChild("_HonoredOneFX")
		if existing then existing:Destroy() end
		return
	end

	-- play (clear any stale one first)
	local old = HumRP:FindFirstChild("_HonoredOneFX")
	if old then old:Destroy() end

	local container = Instance.new("Folder")
	container.Name = "_HonoredOneFX"
	container.Parent = HumRP

	local assets = script["Honored One"] -- effect models, in ReplicatedStorage

	local function attach(template)
		local fx = template:Clone()
		fx:PivotTo(HumRP.CFrame)
		for _, part in fx:GetDescendants() do
			if part:IsA("BasePart") then
				part.Anchored = false
				part.CanCollide = false
				part.Massless = true
				local weld = Instance.new("WeldConstraint")  -- follows the character, no loop needed
				weld.Part0 = HumRP
				weld.Part1 = part
				weld.Parent = part
			end
		end
		fx.Parent = container
		return fx
	end

	attach(assets.HonoredOne)
end