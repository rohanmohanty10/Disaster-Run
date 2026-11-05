--!strict
-- The rotating Divine Shard shop (GAME_PLAN.md Section 3D). Offers depend only on the rotation
-- number, so every server and client shows the same kits without any networking.

local Shared = script.Parent.Parent
local Kits = require(Shared.Data.Kits)
local GachaConfig = require(Shared.Config.GachaConfig)
local ProgressionMath = require(Shared.Util.ProgressionMath)

local ShardShop = {}

-- Rotation number for a Unix time.
function ShardShop.Rotation(now: number): number
	return math.floor(now / (GachaConfig.ShardShop.RotationHours * 3600))
end

-- Unix time the current rotation ends.
function ShardShop.EndsAt(now: number): number
	local length = GachaConfig.ShardShop.RotationHours * 3600
	return (ShardShop.Rotation(now) + 1) * length
end

-- Shard price for a kit, or nil if it's never sold (Common, Secret, event kits, unpriced rarities).
function ShardShop.Price(role: string, kitId: string): number?
	local kit = Kits.Get(role :: any, kitId)
	if not kit or kit.Event then
		return nil
	end
	return GachaConfig.ShardShop.Prices[kit.Rarity]
end

-- The kit ids on sale for a role in a rotation.
function ShardShop.Offers(role: string, rotation: number): { string }
	local eligible = {}
	for _, kitId in (Kits.Order :: any)[role] do
		if ShardShop.Price(role, kitId) then
			table.insert(eligible, kitId)
		end
	end
	local roleSalt = if role == "God" then 7919 else 104729
	local picks = ProgressionMath.PickIndexes(rotation * 31 + roleSalt, #eligible, GachaConfig.ShardShop.OffersPerRole)
	local offers = {}
	for _, index in picks do
		table.insert(offers, eligible[index])
	end
	return offers
end

-- Does the player own this kit (in a slot or the vault)? `roleData` is the saved role table.
function ShardShop.Owns(roleData: { Slots: { string }, Vault: { string } }, kitId: string): boolean
	return table.find(roleData.Slots, kitId) ~= nil or table.find(roleData.Vault, kitId) ~= nil
end

return ShardShop
