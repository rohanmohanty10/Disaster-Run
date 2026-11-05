--[[
		Store gamepass names, productIds, and award functions

]]


local Info = require(game:GetService("ReplicatedStorage").Info)

local ProductList = {}

-- Product name -> ID (as a string), built from ReplicatedStorage.Info's Gifts, Products and Donations.
-- The IDs themselves live only in Info.
ProductList.Names = {}
for _, group in { Info.Gifts, Info.Products, Info.Donations } do
	for name, id in group do
		assert(ProductList.Names[name] == nil, "Duplicate product name in Info: " .. name)
		ProductList.Names[name] = tostring(id)
	end
end

-- Gift product name -> the pass (ID as a string) it gives
ProductList.GiftPassMap = {
	VipGift        = tostring(Info.Passes.VIP),
	MoreEmoteGift  = tostring(Info.Passes.MoreEmotes),
	SecondPageGift = tostring(Info.Passes.SecondPage),
}

-- Item gift products -> the item the receiver gets (ShopConfig / ItemConfig ids; SupplyCrate rolls one)
ProductList.GiftItemMap = {
	SniperGift      = "Sniper",
	ColaBombGift    = "ColaBomb",
	SupplyCrateGift = "SupplyCrate",
}


function ProductList.GetProductId(name: string)
	return tostring(ProductList.Names[name])
end

return ProductList
