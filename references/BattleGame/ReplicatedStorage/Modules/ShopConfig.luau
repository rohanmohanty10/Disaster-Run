-- ReplicatedStorage > Modules > ShopConfig   (ModuleScript, shared by server and client)
--
-- Everything the Store sells. ShopService (server) and ShopClient (the Store menu) both read it.
--   Bundles    = developer products (Robux): Gold packs etc. Your ProductManager hands them out.
--                A Gold pack can have a Bonus, shown as "+ 500 Bonus" on its card. It's only the
--                label: ProductManager decides how much Gold the pack really gives.
--   Gamepasses = your gamepasses.
--   Items      = bought with Gold: your usable items (need an ItemConfig entry), the supply
--                crate, and emote spins. Items with a ProductId can also be bought with Robux,
--                and with Gift / GiftProductId be gifted (developer products; ProductManager).
--
-- Image ids marked TEMP are Anime Expeditions' art, used as placeholders until you have your own.
-- Items without an Image show their 3D model from ReplicatedStorage > Assets > Items.

local Info = require(game:GetService("ReplicatedStorage").Info) -- every pass / product ID lives in Info

local ShopConfig = {}

ShopConfig.Currency = "Gold"
ShopConfig.PurchaseCooldown = 0.6 -- seconds between purchases
ShopConfig.AmountOptions = { 1, 3 } -- how many you can buy at once
ShopConfig.DeliveryTime = 0.5 -- seconds before the seagull sets off

------------------------------------------------------------------------
-- Items tab (Gold)
------------------------------------------------------------------------
ShopConfig.Items = {
	{
		Id = "Sniper",
		Name = "Sniper",
		Rarity = "Rare",
		Model = "Rifle", -- shown in 3D from Assets > Items
		Price = 250,
		ProductId = Info.Products["Sniper"],
		Gift = "SniperGift",
		GiftProductId = Info.Gifts.SniperGift,
		Description = "Scope in with right-click and pick people off from across the map.",
		Stats = { "3 shots", "30 damage", "Breaks cover" },
	},
	{
		Id = "ColaBomb",
		Name = "Cola Bomb",
		Rarity = "Uncommon",
		Model = "ColaBomb",
		Price = 180,
		ProductId = Info.Products["Cola Bomb"],
		Gift = "ColaBombGift",
		GiftProductId = Info.Gifts.ColaBombGift,
		Description = "Pick it up, throw it, run. Blows up everyone nearby, you included.",
		Stats = { "1 throw", "28 damage", "16 stud blast" },
	},
	{
		Id = "MuggyBall",
		Name = "Muggy Ball",
		Rarity = "Rare",
		Model = "MuggyBall",
		Price = 220,
		Description = "Buggy's cannonball. Throw it, watch it blink, run.",
		Stats = { "1 throw", "35 damage", "18 stud blast" },
	},
	{
		Id = "BusterCall",
		Name = "Buster Call",
		Rarity = "Legendary",
		Model = "denden",
		Price = 600,
		Description = "Ring the golden Den Den Mushi and the Marine fleet shells wherever you point.",
		Stats = { "1 call", "22 shells", "30 stud zone" },
	},
}

-- a random item, delivered by seagull
ShopConfig.Crate = {
	Id = "SupplyCrate",
	Name = "Marine Supply Crate",
	Rarity = "Legendary",
	Model = "SupplyCrate", -- shown in 3D from Assets > Items (a copy of the docks' Box1)
	Price = 700, -- 10 kills. JJS's delivery is $5 (1 kill), but its items also spawn free on the map
	ProductId = Info.Products["Marine Supply Crate"],
	Gift = "SupplyCrateGift",
	GiftProductId = Info.Gifts.SupplyCrateGift,
	Description = "A random item, dropped by a seagull right next to you.",
	Odds = {
		ColaBomb = 45,
		MuggyBall = 27,
		Sniper = 18,
		BusterCall = 10,
	},
}

-- JJS's rate (wiki): a random emote is $250 = 50 kills there ($5 a kill), and a kill gives 70 Gold
-- here. ServerScriptService.QOL.Emotes
-- (the Cosmetics menu's Buy Emote Spin button) charges the same.
ShopConfig.EmoteSpin = {
	Id = "EmoteSpin",
	Name = "Emote Spin",
	Rarity = "Epic",
	Image = "rbxassetid://90522187215691", -- TEMP
	Price = 3500,
	Description = "One spin on the emote wheel. Duplicates give Gold back.",
}

------------------------------------------------------------------------
-- Gamepasses tab (your real pass ids, TEMP icons)
-- Gift / GiftProductId: the developer product that gifts this pass to someone else (your
-- existing gifting products; the server's RequestGiftingProduct takes the Gift name). A pass
-- without them has no gift button.
------------------------------------------------------------------------
ShopConfig.Gamepasses = {
	{
		Id = "VIP",
		PassId = Info.Passes.VIP,
		Gift = "VipGift",
		GiftProductId = Info.Gifts.VipGift,
		Name = "VIP",
		Rarity = "Legendary",
		Icon = "rbxassetid://81618977064455", -- crown (from Anime Origins)
		Description = "Permanently unlock exclusive VIP benefits!",
		Perks = { "150 Gold per kill (instead of 70)", "Exclusive [VIP] title", "VIP chat tag" },
	},
	{
		Id = "MoreEmotes",
		PassId = Info.Passes.MoreEmotes,
		Gift = "MoreEmoteGift",
		GiftProductId = Info.Gifts.MoreEmoteGift,
		Name = "More Emotes",
		Rarity = "Epic",
		Icon = "rbxassetid://73961661735148", -- three figures, "MORE EMOTES"
		Description = "More room for the emotes you love.",
		Perks = { "Extra emote slots", "Keep more emotes equipped" },
	},
	{
		Id = "SecondPage",
		PassId = Info.Passes.SecondPage,
		Gift = "SecondPageGift",
		GiftProductId = Info.Gifts.SecondPageGift,
		Name = "Second Emote Page",
		Rarity = "Rare",
		Icon = "rbxassetid://114909530750977", -- the book, "SECOND PAGE"
		Description = "A whole second emote wheel, one key away.",
		Perks = { "8 more emote slots", "Switch pages mid-fight" },
	},
	{
		Id = "EarlyAccess", -- no gift product yet, so no gift button
		PassId = 2064411304,
		Name = "Early Access",
		Rarity = "Legendary",
		Icon = "rbxassetid://109626691633355", -- mystery figure, "EARLY ACCESS"
		Description = "Play new characters before everyone else.",
		Perks = { "Every Early Access character", "Right now: Whitebeard" },
	},
}

------------------------------------------------------------------------
-- Bundles tab (developer products)
------------------------------------------------------------------------
ShopConfig.Bundles = {
	Sections = {
		{
			Title = "Gold Packs",
			Products = {
				{
					Id = "Gold500",
					ProductId = Info.Products["500 Gold"],
					Name = "Gold Pouch",
					Description = "A quick pouch of Gold for items and supply drops.",
					Art = "rbxassetid://102213596709818", -- TEMP (Anime Origins' coin)
					Rewards = { { Name = "Gold", Count = 5600, Art = "rbxassetid://80297771892932", Rarity = "Legendary" } },
				},
				{
					Id = "Gold1500",
					ProductId = Info.Products["1500 Gold"],
					Name = "Gold Chest",
					Description = "Stock up: a chest full of Gold.",
					Tag = "Popular!",
					Art = "rbxassetid://82007296861051", -- TEMP (Anime Origins' coins)
					Rewards = { { Name = "Gold", Count = 14560, Art = "rbxassetid://80297771892932", Rarity = "Legendary" } },
				},
			},
		},
		{
			Title = "Emote Packs",
			Products = {
				{
					Id = "Spins5",
					ProductId = Info.Products["Random Emote x5"],
					Name = "5 Emote Spins",
					Description = "Roll for dances and victory poses at a bulk discount.",
					Tag = "BEST Value!",
					Art = "rbxassetid://90522187215691", -- the dice (random emotes)
					Rewards = { { Name = "Spins", Count = 5, Art = "rbxassetid://90522187215691", Rarity = "Epic" } },
				},
			},
		},
	},
}

------------------------------------------------------------------------
function ShopConfig.GetItem(Id: string)
	for _, Item in ShopConfig.Items do
		if Item.Id == Id then
			return Item
		end
	end
	return nil
end

-- the crate's odds as { Item, Chance (0..1) }, most likely first
function ShopConfig.CrateChances()
	local Total = 0
	for _, Weight in ShopConfig.Crate.Odds do
		Total += Weight
	end
	local List = {}
	for Id, Weight in ShopConfig.Crate.Odds do
		local Item = ShopConfig.GetItem(Id)
		if Item and Total > 0 then
			table.insert(List, { Item = Item, Chance = Weight / Total })
		end
	end
	table.sort(List, function(A, B)
		return A.Chance > B.Chance
	end)
	return List
end

return ShopConfig
