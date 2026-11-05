--!strict
-- The admin panel's server side. Every request re-checks admin rights here, so the panel is
-- safe to ship: non-admins never see it, and the server refuses them if they try anyway.
-- Admins: anyone in Studio, the game's creator (or group owner), and AdminConfig.Admins.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local AdminConfig = require(ReplicatedStorage.Shared.Config.AdminConfig)
local Kits = require(ReplicatedStorage.Shared.Data.Kits)
local Rarities = require(ReplicatedStorage.Shared.Data.Rarities)

local Requests = require(script.Parent.Requests)
local DataService = require(script.Parent.DataService)
local InventoryService = require(script.Parent.InventoryService)
local DevTestService = require(script.Parent.DevTestService)

local AdminService = {}

local groupOwner: number? = nil

function AdminService.IsAdmin(player: Player): boolean
	if RunService:IsStudio() then
		return true
	end
	if table.find(AdminConfig.Admins, player.UserId) then
		return true
	end
	if game.CreatorType == Enum.CreatorType.User then
		return player.UserId == game.CreatorId
	end
	return groupOwner ~= nil and player.UserId == groupOwner
end

-- Puts a kit straight into the player's inventory and equips it.
-- Mythical / Secret kits go to the Permanent Vault (like a real pull); others replace the selected slot.
function AdminService.EquipKit(player: Player, role: Kits.Role, kitId: string): (boolean, string)
	local kit = Kits.Get(role, kitId)
	if not kit then
		return false, "Unknown kit."
	end
	local data = DataService.Get(player)
	if not data then
		return false, "Your data is still loading."
	end
	local roleData = (data :: any)[role]
	if Rarities.Vaulted[kit.Rarity] then
		if not table.find(roleData.Vault, kitId) then
			table.insert(roleData.Vault, kitId)
		end
		roleData.VaultEquipped = kitId
	else
		roleData.Slots[roleData.Selected] = kitId
		roleData.VaultEquipped = ""
	end
	InventoryService.Refresh(player)
	DataService.Changed(player)
	return true, `Equipped {kit.Name} ({role}).`
end

local function deny(): Requests.Result
	return Requests.Fail("NotAdmin", "Admins only.")
end

function AdminService.Init()
	Requests.Register("AdminEquipKit", function(player, role, kitId)
		if not AdminService.IsAdmin(player) then
			return deny()
		end
		if not Kits.IsRole(role) or type(kitId) ~= "string" then
			return Requests.Fail("BadRequest")
		end
		local ok, message = AdminService.EquipKit(player, role, kitId)
		return { Ok = ok, Message = message }
	end)

	Requests.Register("AdminGiveSpins", function(player, role, spinType, amount)
		if not AdminService.IsAdmin(player) then
			return deny()
		end
		if not Kits.IsRole(role) or (spinType ~= "Normal" and spinType ~= "Lucky") or type(amount) ~= "number" then
			return Requests.Fail("BadRequest")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		amount = math.clamp(math.floor(amount), 1, 1000)
		local roleData = (data :: any)[role]
		if spinType == "Lucky" then
			roleData.LuckySpins += amount
		else
			roleData.Spins += amount
		end
		DataService.Changed(player)
		return { Ok = true, Message = `+{amount} {role} {if spinType == "Lucky" then "Lucky " else ""}Spins` }
	end)

	Requests.Register("AdminGiveCash", function(player, amount)
		if not AdminService.IsAdmin(player) then
			return deny()
		end
		if type(amount) ~= "number" then
			return Requests.Fail("BadRequest")
		end
		local data = DataService.Get(player)
		if not data then
			return Requests.Fail("NotLoaded")
		end
		amount = math.clamp(math.floor(amount), 1, 1e7)
		data.Cash += amount
		DataService.Changed(player)
		return { Ok = true, Message = `+${amount}` }
	end)

	-- Runs one of the /test commands (round start/end, dummies, hitboxes...).
	Requests.Register("AdminCommand", function(player, text)
		if not AdminService.IsAdmin(player) then
			return deny()
		end
		if type(text) ~= "string" or #text > 80 then
			return Requests.Fail("BadRequest")
		end
		return { Ok = true, Message = DevTestService.RunCommand(player, text) }
	end)
end

function AdminService.Start()
	if game.CreatorType == Enum.CreatorType.Group then
		task.spawn(function()
			local ok, info = pcall(function()
				return game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId)
			end)
			if ok and info and info.Owner then
				groupOwner = info.Owner.Id
				for _, player in Players:GetPlayers() do
					player:SetAttribute("IsAdmin", AdminService.IsAdmin(player) or nil)
				end
			end
		end)
	end
	local function mark(player: Player)
		player:SetAttribute("IsAdmin", AdminService.IsAdmin(player) or nil)
	end
	for _, player in Players:GetPlayers() do
		mark(player)
	end
	Players.PlayerAdded:Connect(mark)
end

return AdminService
