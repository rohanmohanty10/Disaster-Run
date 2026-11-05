--!strict
-- Pure gacha maths shared by the server (which rolls) and the client (which shows the odds),
-- so the odds list always matches what the server actually does.

local Shared = script.Parent.Parent
local Kits = require(Shared.Data.Kits)
local Rarities = require(Shared.Data.Rarities)
local GachaConfig = require(Shared.Config.GachaConfig)
local Banners = require(script.Parent.Banners)

export type SpinType = "Normal" | "Lucky"

export type KitChance = { Id: string, Chance: number }
export type RarityChance = { Rarity: string, Chance: number, Kits: { KitChance } }

-- The pity part of a role's saved data that the roller needs.
export type PityState = {
	AdBoost: number,
	Pity: { Normal: number, LuckyMythical: number, LuckySecret: number },
}

local Roller = {}

-- Which odds table the *next* spin of this type will use.
function Roller.TableFor(state: PityState, spinType: SpinType): string
	local caps = GachaConfig.Pity
	if spinType == "Lucky" then
		if state.Pity.LuckySecret + 1 >= caps.LuckySecret then
			return "LuckySecretPity"
		elseif state.Pity.LuckyMythical + 1 >= caps.LuckyMythical then
			return "LuckyMythicalPity"
		end
		return "Lucky"
	end
	if state.AdBoost > 0 then
		return "Boosted"
	elseif state.Pity.Normal + 1 >= caps.Normal then
		return "NormalPity"
	end
	return "Normal"
end

-- Kit ids of a rarity that can be rolled at `now` (event kits only while their banner is live).
function Roller.Pool(role: Kits.Role, rarity: string, now: number): { string }
	local pool = {}
	for _, kitId in Kits.ByRarity(role, rarity) do
		if Banners.IsRollable(role, kitId, now) then
			table.insert(pool, kitId)
		end
	end
	return pool
end

-- Every rarity and kit in a table with its chance (0-1), rarities in Rarities.Order.
-- boostedKit (optional) gets GachaConfig.BoostedKitMultiplier weight inside its rarity.
-- now: Unix seconds for banner checks (defaults to os.time()).
function Roller.Chances(role: Kits.Role, tableName: string, boostedKit: string?, now: number?): { RarityChance }
	local odds = GachaConfig.Odds[tableName]
	assert(odds, `Unknown odds table {tableName}`)
	local at = now or os.time()

	local weights: { [string]: number } = {}
	local total = 0
	for _, entry in odds do
		local rarity, weight = entry[1] :: string, entry[2] :: number
		if #Roller.Pool(role, rarity, at) > 0 then
			weights[rarity] = (weights[rarity] or 0) + weight
			total += weight
		end
	end
	assert(total > 0, `Odds table {tableName} has no kits for {role}`)

	local result: { RarityChance } = {}
	for _, rarity in Rarities.Order do
		local weight = weights[rarity]
		if weight then
			local rarityChance = weight / total
			local ids = Roller.Pool(role, rarity, at)
			local kitWeights: { number } = {}
			local kitTotal = 0
			for i, id in ids do
				local w = if id == boostedKit then GachaConfig.BoostedKitMultiplier else 1
				kitWeights[i] = w
				kitTotal += w
			end
			local kits: { KitChance } = {}
			for i, id in ids do
				table.insert(kits, { Id = id, Chance = rarityChance * kitWeights[i] / kitTotal })
			end
			table.insert(result, { Rarity = rarity, Chance = rarityChance, Kits = kits })
		end
	end
	return result
end

-- Rolls one kit. Returns kitId, rarity.
function Roller.Roll(role: Kits.Role, tableName: string, boostedKit: string?, rng: Random, now: number?): (string, string)
	local chances = Roller.Chances(role, tableName, boostedKit, now)
	local pick = rng:NextNumber()
	local running = 0
	local last: KitChance? = nil
	local lastRarity = ""
	for _, rarityChance in chances do
		for _, kit in rarityChance.Kits do
			running += kit.Chance
			last = kit
			lastRarity = rarityChance.Rarity
			if pick < running then
				return kit.Id, rarityChance.Rarity
			end
		end
	end
	-- Floating point leftovers land on the last entry.
	assert(last, "No kits to roll")
	return last.Id, lastRarity
end

-- Applies the pity counter changes for a finished spin (mutates state).
function Roller.UpdatePity(state: PityState, spinType: SpinType, tableName: string, rarity: string)
	if spinType == "Lucky" then
		state.Pity.LuckyMythical += 1
		state.Pity.LuckySecret += 1
		if Rarities.AtLeast(rarity, "Mythical") then
			state.Pity.LuckyMythical = 0
		end
		if rarity == "Secret" then
			state.Pity.LuckySecret = 0
		end
		return
	end
	if tableName == "Boosted" then
		-- Boosted spins don't move the normal pity counter.
		state.AdBoost = math.max(state.AdBoost - 1, 0)
		return
	end
	state.Pity.Normal += 1
	if Rarities.AtLeast(rarity, "Legendary") then
		state.Pity.Normal = 0
	end
end

return Roller
