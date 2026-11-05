-- SERVICES --

local ServerStorage = game:GetService('ServerStorage')
local ReplicatedStorage = game:GetService('ReplicatedStorage')


-- SERVER MODULES --

local ServerModules = ServerStorage.Modules

local AnimationService = require(ServerModules.AnimationService)


-- VARIABLES --

local SeathTasks = {}


-- SERVER ASSETS --

local ServerAssets = ServerStorage.Assets

local WeaponModels = ServerAssets.Models.Weapons
local SeathAnim = ServerAssets.Animations.Other.Seath
local UnseathAnim = ServerAssets.Animations.Other.Unseath


-- FUNCTIONS --

local function TriggerTransparency(Sword: Model?, State: boolean)
	if Sword:IsA('Model') then
		for _,Part: Part in Sword:GetDescendants() do
			if Part:IsA('Part') or Part:IsA('MeshPart') or Part:IsA('UnionOperation') then 
				if Part:HasTag('Invisible') then continue end

				if State == false then
					Part.Transparency = 0
				else
					Part.Transparency = 1
				end
			end
		end
	else
		if State == false then
			Sword.Transparency = 0
		else
			Sword.Transparency = 1
		end
	end
end


-- MODULE --

local module = {}
function module:AddSword(Character: Model, MovesetName: string)

end

function module:AddWeapon(Character: Model, MovesetName: string)
	if MovesetName == "Cursed Child" then
		local Knife: Model = WeaponModels["Cursed Child"].Knife:Clone()
		Knife.Parent = Character
		Knife.Weld.Part0 = Character['Right Arm']
		
		Character:AddTag('HasKnife')
		
	elseif MovesetName == "The Dark Lord" then
		local Spear: Model = WeaponModels["The Dark Lord"].Spear:Clone()
		Spear.Parent = Character
		Spear.Name = "SpearWeapon"
		Spear["2-outline"].Handle.Part0 = Character["Left Arm"]
		
		for _,v in Spear:GetChildren() do
			if v:IsA("MeshPart") then
				v.Transparency = 0
			end
		end
		
		Character:AddTag('HasSpear')
	end
end

function module:RemoveWeapons(Character: Model)
	for _, Weapon: Model in Character:GetChildren() do
		if Weapon:HasTag('Weapon') then
			Weapon:Destroy()
		end
	end
	
	Character:RemoveTag('HasSword')
	Character:RemoveTag('HasDaggers')
	Character:RemoveTag('HasKnife')
end

function module:TriggerSeath(Character: Model, State: boolean)
	local Sword: Model = Character.Sword
	if State ~= nil then
		Sword:SetAttribute('Seathed', State)
	else
		Sword:SetAttribute('Seathed', not Sword:GetAttribute('Seathed'))
	end

	if Sword:GetAttribute('Seathed') == true then
		if Sword:HasTag('CantSeath') then return end
		AnimationService:playAnimation(Character, SeathAnim)
		task.delay(.667, function()
			if not Character:FindFirstChild('Sword') then return end
			
			Sword.WeaponHold.MainSword.Enabled = false
			Sword.Seath.SwordsSeathWelds.Main.Enabled = true
		end)
	else
		Sword.Seath.SwordsSeathWelds.Main.Enabled = false
		Sword.WeaponHold.MainSword.Enabled = true
		
		
		if SeathTasks[Character] then
			task.cancel(SeathTasks[Character])
			SeathTasks[Character] = nil
		end
		
		SeathTasks[Character] = task.delay(15, function()
			if not Character:FindFirstChild('Sword') then return end
			
			module:TriggerSeath(Character, true)
		end)
	end
end

function module:TriggerTrail(Character: Model, State: boolean)
	local Sword: Model = Character.Sword
	if State ~= nil then
		for _, Trail: Trail in Sword:GetDescendants() do
			if Trail:IsA('Trail') then
				Trail.Enabled = State
			end
		end
	else
		for _, Trail: Trail in Sword:GetDescendants() do
			if Trail:IsA('Trail') then
				Trail.Enabled = not Trail.Enabled
			end
		end
	end
end

function module:AddAwakeningSword(Character: Model)
	local Sword = Character:FindFirstChild('Sword')
	if not Sword then return end
	
	
	TriggerTransparency(Sword.Main, true)
	TriggerTransparency(Sword.AwakeningMain, false)
end

function module:RemoveAwakeningSword(Character: Model)
	local Sword = Character:FindFirstChild('Sword')
	if not Sword then return end


	TriggerTransparency(Sword.Main, false)
	TriggerTransparency(Sword.AwakeningMain, true)
end


return module