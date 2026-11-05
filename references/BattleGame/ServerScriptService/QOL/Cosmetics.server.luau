--Services
local Players = game:GetService("Players")
local RS = game:GetService('ReplicatedStorage')
local SvSt = game:GetService('ServerStorage')
local HttpService = game:GetService("HttpService")
local DataStoreService = game:GetService("DataStoreService")

local DataManager = require(script.Parent.Parent.Data.DataManager)



--Bindables
local Bindables = SvSt.Bindables

local CosmBind = Bindables.Cosmetics



--Remotes
local Remotes = RS.Remotes
local CosmeticsRems = Remotes.Cosmetics
local ComunicatorRems = Remotes.Comunicator

local CosmSet = CosmeticsRems.Set
local ComSet = ComunicatorRems.Set



--Assets
local Assets = RS.Assets
local Accessories = SvSt.Assets.Models.Cosmetics.Accessories


local ServerStorageAuras = SvSt.Assets.Models.Cosmetics.Auras



--Functions
local CustomAccessories = {
	["Red Gloves"] = function(Character: Model, Accessory: Model)
		local AccessoryClone = Accessory:Clone()
		AccessoryClone.Parent = Character
		AccessoryClone["Left Arm"].Weld.Part0 = Character["Left Arm"]
		AccessoryClone["Right Arm"].Weld.Part0 = Character["Right Arm"]

		return AccessoryClone
	end,

	["Bandages"] = function(Character: Model, Accessory: Model)
		local AccessoryClone = Accessory:Clone()
		AccessoryClone.Parent = Character
		AccessoryClone["Cube.007"].Weld.Part0 = Character["Right Arm"]
		AccessoryClone["Cube.008"].Weld.Part0 = Character["Left Arm"]
		AccessoryClone["MainWeld"].Part0 = Character["Torso"]

		return AccessoryClone
	end,

	["Bandage Wrap"] = function(Character: Model, Accessory: Model)
		local AccessoryClone = Accessory:Clone()
		AccessoryClone.Parent = Character
		AccessoryClone["Left Arm"].Weld.Part0 = Character["Left Arm"]
		AccessoryClone["Right Arm"].Weld.Part0 = Character["Right Arm"]
		AccessoryClone["Torso"].Weld.Part0 = Character["Torso"]

		return AccessoryClone
	end,

	["Spiral Cloth"] = function(Character: Model, Accessory: Model)
		local AccessoryClone = Accessory:Clone()
		AccessoryClone.Parent = Character
		AccessoryClone["Left Arm"].Weld.Part0 = Character["Left Arm"]
		AccessoryClone["Right Arm"].Weld.Part0 = Character["Right Arm"]
		AccessoryClone["Torso"].Weld.Part0 = Character["Torso"]

		return AccessoryClone
	end,

	["Leg Iron"] = function(Character: Model, Accessory: Model)
		local AccessoryClone = Accessory:Clone()
		AccessoryClone.Parent = Character
		AccessoryClone:PivotTo(Character:GetPivot())
		AccessoryClone.Sphere:AddTag("ballnchain")
		AccessoryClone.MainWeld.Part0 = Character["Left Leg"]

		return AccessoryClone
	end,

	["Custom Cape"] = function(Character: Model, Accessory: Model)
		local Player = Players:GetPlayerFromCharacter(Character)

		local CustomCapeDataStore
		pcall(function()
			CustomCapeDataStore = DataStoreService:GetDataStore("PlayerCapeData"):GetAsync("Cape_" .. Player.UserId)
		end)
		if not CustomCapeDataStore then return end


		local AccessoryClone = Accessory:Clone()
		local AccessoryPlane = AccessoryClone["Plane.002"]


		if CustomCapeDataStore.Decal then
			local DecalId = tonumber(CustomCapeDataStore.Decal)

			if DecalId then
				local IsFound, Asset = pcall(function()
					return game:GetService("InsertService"):LoadAsset(DecalId)
				end)


				if IsFound and Asset then
					local FoundDecal = Asset:FindFirstChildWhichIsA("Decal", true)

					AccessoryPlane.Decal.Texture = FoundDecal and FoundDecal.Texture or "rbxassetid://" .. DecalId
				else
					AccessoryPlane.Decal.Texture = "rbxassetid://" .. DecalId
				end
			else
				AccessoryPlane.Decal.Texture = tostring(CustomCapeDataStore.Decal)
			end
		end


		if CustomCapeDataStore.Color then
			AccessoryPlane.Color = Color3.new(unpack(CustomCapeDataStore.Color))
		end

		if CustomCapeDataStore.Value then
			AccessoryClone:SetAttribute("Value", CustomCapeDataStore.Value)
		end


		AccessoryClone.Parent = Character
		AccessoryClone.Weld.Part0 = Character:FindFirstChild("Torso")
		AccessoryClone:SetAttribute("Cosmetic", true)

		return AccessoryClone
	end
}


--Titles helpers
local VIP_GAMEPASS = tostring(require(RS.Info).Passes.VIP)

-- Maps a title's ReqType to the live player attribute that holds the player's
-- progress for it. Anything not listed falls back to "<ReqType>Progress".
local ProgressAttributeByType = {
	Kills = "TotalKills",
	Robux = "TotalDonated",
}

local function getTitlesFolder(): Folder?
	local assets = RS:FindFirstChild("Assets")
	local cosmetics = assets and assets:FindFirstChild("Cosmetics")
	return cosmetics and cosmetics:FindFirstChild("Titles")
end

local function getTitleProgress(Player: Player, ReqType: string): number
	local attribute = ProgressAttributeByType[ReqType] or (ReqType .. "Progress")
	return Player:GetAttribute(attribute) or 0
end

-- Chat prefixes are flat rich text (no gradients), so we carry ONE representative
-- colour into chat: an explicit ChatColor attribute if set, otherwise the middle
-- of the title's UIGradient, otherwise its plain TextColor3.
local function evalColorSequence(seq: ColorSequence, t: number): Color3
	local kps = seq.Keypoints
	if t <= kps[1].Time then return kps[1].Value end
	if t >= kps[#kps].Time then return kps[#kps].Value end
	for i = 1, #kps - 1 do
		local a, b = kps[i], kps[i + 1]
		if t >= a.Time and t <= b.Time then
			return a.Value:Lerp(b.Value, (t - a.Time) / (b.Time - a.Time))
		end
	end
	return kps[1].Value
end

local function getTitleChatColor(Title: TextLabel): Color3
	local override = Title:GetAttribute("ChatColor")
	if typeof(override) == "Color3" then
		return override
	end

	local gradient = Title:FindFirstChildOfClass("UIGradient")
	if gradient then
		return evalColorSequence(gradient.Color, 0.5)
	end

	return Title.TextColor3
end

-- Server-authoritative unlock check. A title can be equipped if it's already
-- been granted/owned, is a Special title matching this UserId, is a VIP title
-- and the player owns VIP, or the player's live progress meets the Requirement.
local function canEquipTitle(Player: Player, profile, Title: TextLabel): boolean
	if table.find(profile.Data.Cosmetics.OwnedTitles, Title.Name) then
		return true
	end

	local ReqType = Title:GetAttribute("ReqType") or "Kills"

	if ReqType == "Special" then
		return Player.UserId == Title:GetAttribute("ID")
	elseif ReqType == "VIP" then
		local pass = profile.Data.Gamepasses[VIP_GAMEPASS]
		return pass ~= nil and pass.owned == true
	end

	local Requirement = Title:GetAttribute("Requirement") or 0
	return getTitleProgress(Player, ReqType) >= Requirement
end

local function removeOverheadTitle(Character: Model)
	local head = Character and (Character:FindFirstChild("Head") or Character:FindFirstChild("FakeHead"))
	local existing = head and head:FindFirstChild("TitleTag")
	if existing then
		existing:Destroy()
	end
end

-- Builds the floating name-tag above the character's head by cloning the styled
-- title label (keeping its UIGradient/UIStroke children) into a BillboardGui.
-- The GUI lives inside the character in Workspace, so it replicates to every
-- client automatically.
local function applyOverheadTitle(Character: Model, Title: TextLabel)
	local head = Character:FindFirstChild("Head") or Character:FindFirstChild("FakeHead")
	if not head then return end

	removeOverheadTitle(Character)

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "TitleTag"
	billboard.Adornee = head
	billboard.Size = UDim2.fromOffset(200, 32)
	billboard.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
	billboard.MaxDistance = 60
	billboard.LightInfluence = 0

	local labelClone = Title:Clone()
	labelClone.Name = "Title"
	labelClone.Size = UDim2.fromScale(1, 1)
	labelClone.Position = UDim2.fromScale(0, 0)
	labelClone.BackgroundTransparency = 1
	labelClone.Parent = billboard
	labelClone.TextScaled = true
	billboard.Parent = head
end


local function Cosmetic(Player: Player, Params: {any})
	local Character = Player.Character
	local profile = DataManager.Profiles[Player]

	if not profile then return end
	if not Character then return end

	local PlayerCosmeticsData = profile.Data.Cosmetics.OwnedAccessories
	local CosmeticName: string = Params.Name
	if Params.Type == "Accessories" then
		if Params.State == "Equip" then

			if Character:FindFirstChild(CosmeticName) then 
				warn("Already equipped!")
				return 
			end

			--local TotalKills = Player.leaderstats:FindFirstChild("Total Kills", true)
			local TotalKills = profile.Data.TotalKills
			local Accessory = Accessories:FindFirstChild(CosmeticName)

			if Accessory and (TotalKills >= (Accessory:GetAttribute("Kills") or 0) or table.find(profile.Data.Cosmetics.OwnedAccessories, Params.Name)) then

				if CosmeticName == "Spiral Cloth" and Player:GetAttribute("Moveset") ~= "Monster Form" then
					ComSet:FireClient(Player, "SendNotification", { Title = 'NOTIFICATION'; Text = "THIS COSMETIC IS FOR MONSTER FORM"; })

					return
				elseif CosmeticName == "Blocky Body" then
					local AssetsFolder = Character:FindFirstChild("Assets")

					for _, v in Character:GetChildren() do
						if v.Name == "CharacterMesh" then
							v.Parent = AssetsFolder
						end
					end
				end

				if CosmeticName:match("Cape") then --T0 make sure player can only have 2 capes. But I changed this to 1.
					local CapeCount = 0

					for _,v in Character:GetChildren() do
						if v.Name:match("Cape") and v:GetAttribute("Cosmetic") == true then
							CapeCount += 1
						end
					end

					if CapeCount >= 1 then
						ComSet:FireClient(Player, "SendNotification", { Title = 'NOTIFICATION'; Text = "YOU CAN'T EQUIP MORE THAN 2 CAPES"; })

						return
					end
				end

				if CosmeticName ~= "Blocky Body" then
					local AccessoryClone
					local CustomFunction = CustomAccessories[CosmeticName]

					if CustomFunction then
						AccessoryClone = CustomFunction(Character, Accessory)

					else
						AccessoryClone = Accessory:Clone()
						for _, part in AccessoryClone:GetDescendants() do
							if part:IsA("BasePart") then
								--part.CollisionFidelity = Enum.CollisionFidelity.Box
								part.CanCollide = false
								part.CanTouch = false
								part.CanQuery = false
								part.Massless = true
								part.Anchored = false
							end
						end
						AccessoryClone.Parent = Character
						AccessoryClone.MainWeld.Part0 = Character[AccessoryClone.MainWeld:GetAttribute("BodyPart")]


						local Animation = AccessoryClone:FindFirstChildOfClass("Animation")
						local Animator = AccessoryClone:FindFirstChildWhichIsA("Animator", true)
						if Animation and Animator then
							Animator:LoadAnimation(Animation):Play(0)
							Animation:Destroy()
						end

					end

					if AccessoryClone then
						AccessoryClone:SetAttribute("Cosmetic", true)
					end
				end

				-- 1. Only add to OWNED data if they don't have it yet
				if not table.find(profile.Data.Cosmetics.OwnedAccessories, CosmeticName) then
					table.insert(profile.Data.Cosmetics.OwnedAccessories, CosmeticName)
				end

				-- 2. Only add to EQUIPPED data if it isn't already there
				if not table.find(profile.Data.Cosmetics.EquippedAccessories, CosmeticName) then
					table.insert(profile.Data.Cosmetics.EquippedAccessories, CosmeticName)
				end			

				-- 3. Create the StringValue for the Client UI
				if not Player.Cosmetics.Accessories:FindFirstChild(CosmeticName) then
					local Value = Instance.new('StringValue')
					Value.Name = CosmeticName
					Value.Parent = Player.Cosmetics.Accessories
				end
			end

		elseif Params.State == "Unequip" then
			if CosmeticName == "Blocky Body" then
				local AssetsFolder = Character:FindFirstChild("Assets")

				if AssetsFolder then
					for _, v in AssetsFolder:GetChildren() do
						if v.Name == "CharacterMesh" then
							v.Parent = Character
						end
					end
				end

				PlayerCosmeticsData.Accessories[CosmeticName] = nil
				Player.Cosmetics.Accessories[CosmeticName]:Destroy()
			else
				local Accessory = Character:FindFirstChild(CosmeticName)
				if Accessory then
					Player.Cosmetics.Accessories[CosmeticName]:Destroy()

					local index = table.find(profile.Data.Cosmetics.EquippedAccessories, CosmeticName)

					if index then
						if table.find(profile.Data.Cosmetics.EquippedAccessories, CosmeticName) then
							table.remove(profile.Data.Cosmetics.EquippedAccessories, index) --Remove only works with numbers. So we had to find the index first.
						end
					end
					Accessory:Destroy()

				end
			end
		end

	elseif Params.Type == "Auras" then
		if Params.State == "Equip" then
			--if Character:FindFirstChild(CosmeticName, true) or not table.find(profile.Data.Cosmetics.OwnedAccessories, Params.Name) then return end
			if Character:FindFirstChild(CosmeticName, true) then
				warn("Already has aura equipped")
				return
			end

			local TotalKills = profile.Data.TotalKills
			local AuraContainer = ServerStorageAuras:FindFirstChild(CosmeticName)

			if AuraContainer and (TotalKills >= (AuraContainer:GetAttribute("Kills") or 0) or table.find(profile.Data.Cosmetics.OwnedAuras, Params.Name)) then

				if profile.Data.Cosmetics.EquippedAuras ~= "" then  --We remove old aura so we can later equip new one.
					for _, v in Character:GetDescendants() do
						if v.Name == profile.Data.Cosmetics.EquippedAuras then
							v:Destroy()
						end
					end
					local CosmeticInstance = Player.Cosmetics.Auras:FindFirstChild(profile.Data.Cosmetics.EquippedAuras)

					if CosmeticInstance then
						CosmeticInstance:Destroy() --Destroy the instance of the currently equipped aura on the client. So we can grey it out when someone equips something different.
					end
				end

				for _, BodyPart in AuraContainer:GetChildren() do -- Equiping new aura
					for _, Particle in BodyPart:GetChildren() do
						local Clone = Particle:Clone()
						Clone.Parent = Character[BodyPart.Name]
					end
				end

				-- 1. Only add to OWNED data if they don't have it yet
				if not table.find(profile.Data.Cosmetics.OwnedAuras, CosmeticName) then
					table.insert(profile.Data.Cosmetics.OwnedAuras, CosmeticName)
				end

				-- 2. Only add to EQUIPPED data if it isn't already there
				if profile.Data.Cosmetics.EquippedAuras ~= CosmeticName then
					profile.Data.Cosmetics.EquippedAuras = CosmeticName
				end			

				-- 3. Create the StringValue for the Client UI
				local CosmeticInstance = Player.Cosmetics.Auras:FindFirstChild(CosmeticName)
				if not CosmeticInstance then
					local Value = Instance.new('StringValue')
					Value.Name = CosmeticName
					Value.Parent = Player.Cosmetics.Auras
				end
			end

		elseif Params.State == "Unequip" then
			for _, v in Character:GetDescendants() do
				if v.Name == CosmeticName then
					v:Destroy()
				end
			end

			if profile.Data.Cosmetics.EquippedAuras == CosmeticName then
				profile.Data.Cosmetics.EquippedAuras = "" 
			end


			local CosmeticInstance = Player.Cosmetics.Auras:FindFirstChild(CosmeticName)
			if CosmeticInstance then
				CosmeticInstance:Destroy()
			end

		end
	elseif Params.Type == "Titles" then
		local Titles = getTitlesFolder()
		if not Titles then
			warn("Titles folder missing at ReplicatedStorage.Assets.Cosmetics.Titles")
			return
		end

		if Params.State == "Equip" then
			local Title = Titles:FindFirstChild(CosmeticName)
			if not Title then
				warn("No title named " .. tostring(CosmeticName))
				return
			end

			if not canEquipTitle(Player, profile, Title) then
				warn(Player.Name .. " does not meet the requirement for title: " .. CosmeticName)
				return
			end

			-- Persist: remember ownership, and set the single equipped title.
			if not table.find(profile.Data.Cosmetics.OwnedTitles, CosmeticName) then
				table.insert(profile.Data.Cosmetics.OwnedTitles, CosmeticName)
			end
			profile.Data.Cosmetics.EquippedTitle = CosmeticName

			-- Replicated display. The chat hook in Replication.client.luau reads
			-- these two attributes; the over-head tag is built below.
			Player:SetAttribute("EquippedTitle", Title.Text)
			Player:SetAttribute("TitleColor", getTitleChatColor(Title)) -- representative colour for the flat chat prefix
			Player:SetAttribute("EquippedTitleName", Title.Name) -- unique key the menu highlights by

			applyOverheadTitle(Character, Title)

		elseif Params.State == "Unequip" then
			profile.Data.Cosmetics.EquippedTitle = ""
			Player:SetAttribute("EquippedTitle", nil)
			Player:SetAttribute("TitleColor", nil)
			Player:SetAttribute("EquippedTitleName", nil)
			removeOverheadTitle(Character)
		end
	end
end


--Events
Remotes.Cosmetics.Set.OnServerEvent:Connect(Cosmetic)
CosmBind.Event:Connect(Cosmetic)

RS.Remotes.Cosmetics.Get.OnServerInvoke = function(Player: Player, Parameters)
	local Goal = Parameters.Goal
	local Cosmetics = SvSt.Assets.Models.Cosmetics
	--local Cosmetics = RS.Assets.Accessories

	if Goal == "GetAllCosmetics" then
		local AccessoriesInformation = {
			["Accessories"] = {},
			["Auras"] = {}
		}

		for _, Category: Folder in Cosmetics:GetChildren() do
			for _, Cosmetic in Category:GetChildren() do
				AccessoriesInformation[Category.Name][Cosmetic:GetAttribute("Index")] = {
					Name = Cosmetic.Name,
					Kills = Cosmetic:GetAttribute("Kills"),
				}
			end
		end

		return AccessoriesInformation
	end

	if Goal == "GetOwnedAccessories" then
		return DataManager.getOwnedAccessories(Player)
	end

	if Goal == "GetOwnedAuras" then
		return DataManager.getOwnedAuras(Player)
	end

	if Goal == "GetRemainingCosmetics" then
		return DataManager.getRemainingCosmetics(Player)
	end

	if Goal == "GetEquippedAccessories" then
		return DataManager.getEquippedAccessories(Player)
	end 

	if Goal == "GetEquippedAuras" then
		return DataManager.getEquippedAuras(Player)
	end
end