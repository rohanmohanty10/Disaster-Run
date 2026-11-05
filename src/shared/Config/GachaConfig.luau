--!strict
-- Every gacha number in one place (see GAME_PLAN.md Section 3).
-- Product / game pass ids are 0 until they're created on the Creator Dashboard;
-- a 0 id makes that purchase button show "Coming soon" instead of prompting.

export type OddsEntry = { any } -- { rarity: string, weight: number }

local GachaConfig = {}

GachaConfig.CurrencyName = "Cash"

-- Spending
GachaConfig.CashSpinCost = 2000 -- normal spin price when the player has no spins left
GachaConfig.StarterSpins = 10 -- normal spins each role starts with

-- Slots
GachaConfig.BaseSlots = 4
GachaConfig.MaxSlots = 8

-- Pity: the spin that reaches the cap uses that pity table.
GachaConfig.Pity = {
	Normal = 50, -- normal spins without Legendary+
	LuckyMythical = 75, -- lucky spins without Mythical+
	LuckySecret = 250, -- lucky spins without Secret
}

-- Odds tables. Weights are percentages; rarities without kits are skipped automatically.
GachaConfig.Odds = {
	Normal = {
		{ "Common", 55 },
		{ "Rare", 30 },
		{ "Epic", 11.5 },
		{ "Legendary", 3 },
		{ "Mythical", 0.49 },
		{ "Secret", 0.01 },
	},
	-- Ad / daily boosted normal spins: doubled high-tier odds.
	Boosted = {
		{ "Common", 51.5 },
		{ "Rare", 30 },
		{ "Epic", 11.5 },
		{ "Legendary", 6 },
		{ "Mythical", 0.98 },
		{ "Secret", 0.02 },
	},
	Lucky = {
		{ "Legendary", 92 },
		{ "Mythical", 7 },
		{ "Secret", 1 },
	},
	NormalPity = {
		{ "Legendary", 92 },
		{ "Mythical", 7 },
		{ "Secret", 1 },
	},
	LuckyMythicalPity = {
		{ "Mythical", 95 },
		{ "Secret", 5 },
	},
	LuckySecretPity = {
		{ "Secret", 100 },
	},
} :: { [string]: { OddsEntry } }

-- Clicking a kit in the odds list multiplies its weight inside its rarity.
GachaConfig.BoostedKitMultiplier = 2

-- Duplicates
GachaConfig.Duplicate = {
	LuckySpinRefund = 10, -- vault duplicate from a lucky spin
	CashRefundMin = 10000, -- vault duplicate from a normal spin
	CashRefundMax = 25000,
	Shards = { -- Divine Shards for any duplicate, by rarity
		Common = 0,
		Rare = 1,
		Epic = 5,
		Legendary = 25,
		Mythical = 100,
		Secret = 250,
	} :: { [string]: number },
}

-- Ask "are you sure?" before a normal spin replaces a slot kit of this rarity or higher.
GachaConfig.ConfirmAtOrAbove = "Legendary"

-- Number of boosted spins one ad / daily boost grants.
GachaConfig.AdBoostSpins = 3

-- Reel animation: how many names flash past before the result.
GachaConfig.ReelTicks = { Min = 25, Max = 35 }

-- Server-side spin rate limit (seconds between spins).
GachaConfig.SpinCooldown = 0.35

-- Game pass that lets players skip the reel. 0 = everyone can skip.
GachaConfig.SkipSpinGamePassId = 0

-- Robux products. Robux is display only; the real price is set on the dashboard.
GachaConfig.Products = {
	Spins = {
		God = {
			Normal = {
				{ Amount = 10, ProductId = 0, Robux = 499 },
				{ Amount = 30, ProductId = 0, Robux = 899 },
				{ Amount = 50, ProductId = 0, Robux = 1199 },
			},
			Lucky = {
				{ Amount = 10, ProductId = 0, Robux = 999 },
				{ Amount = 30, ProductId = 0, Robux = 1899 },
				{ Amount = 50, ProductId = 0, Robux = 2499 },
			},
		},
		Runner = {
			Normal = {
				{ Amount = 10, ProductId = 0, Robux = 499 },
				{ Amount = 30, ProductId = 0, Robux = 899 },
				{ Amount = 50, ProductId = 0, Robux = 1199 },
			},
			Lucky = {
				{ Amount = 10, ProductId = 0, Robux = 999 },
				{ Amount = 30, ProductId = 0, Robux = 1899 },
				{ Amount = 50, ProductId = 0, Robux = 2499 },
			},
		},
	},
	-- Extra slots 5-8 per role.
	Slots = {
		God = { [5] = 0, [6] = 0, [7] = 0, [8] = 0 },
		Runner = { [5] = 0, [6] = 0, [7] = 0, [8] = 0 },
	},
}

return GachaConfig
