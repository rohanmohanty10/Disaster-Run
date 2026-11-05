--!strict
-- Rarity tiers, their colours and helpers. Odds live in Config/GachaConfig.

local Rarities = {}

Rarities.Order = { "Common", "Rare", "Epic", "Legendary", "Mythical", "Secret" }

Rarities.Rank = {} :: { [string]: number }
for index, rarity in Rarities.Order do
	Rarities.Rank[rarity] = index
end

-- Text / slot colours. Rare-Secret match the vault screen's original palette.
Rarities.Colors = {
	Common = Color3.fromRGB(190, 190, 190),
	Rare = Color3.new(0.184314, 0.85098, 1),
	Epic = Color3.new(0.4, 0, 1),
	Legendary = Color3.new(1, 0.615686, 0),
	Mythical = Color3.new(1, 0, 0),
	Secret = Color3.fromRGB(255, 254, 237),
} :: { [string]: Color3 }

-- Pulls of these rarities go to the Permanent Vault instead of a slot.
Rarities.Vaulted = {
	Mythical = true,
	Secret = true,
} :: { [string]: boolean }

-- Pulls of these rarities get the blackout reveal sequence.
Rarities.Dramatic = {
	Mythical = true,
	Secret = true,
} :: { [string]: boolean }

function Rarities.IsValid(rarity: any): boolean
	return type(rarity) == "string" and Rarities.Rank[rarity] ~= nil
end

function Rarities.AtLeast(rarity: string, minimum: string): boolean
	return (Rarities.Rank[rarity] or 0) >= (Rarities.Rank[minimum] or math.huge)
end

return Rarities
