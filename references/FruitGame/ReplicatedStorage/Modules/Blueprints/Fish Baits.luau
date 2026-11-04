 

local v1 = {}
local v2 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting recipe for <font color=\"rgb(%*, %*, %*)\">Common Fish Bait</font>."):format(198, 236, 136),
    ["GivenItem"] = "Common Fish Bait",
    ["Requirements"] = {
        ["Common Fish"] = 1
    },
    ["Default"] = true,
    ["BaseItem"] = "Common Fish",
    ["UseRequiredItem"] = true
}
v1["Common Fish Bait"] = v2
local v3 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting recipe for <font color=\"rgb(%*, %*, %*)\">Rare Fish Bait</font>."):format(198, 236, 136),
    ["GivenItem"] = "Rare Fish Bait",
    ["Requirements"] = {
        ["Rare Fish"] = 2
    }
}
local v4 = {
    ["Rare Fish"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Rare Fish"
    }
}
v3.RequirementsExtra = v4
v3.Default = true
v3.BaseItem = "Rare Fish"
v3.UseRequiredItem = true
v1["Rare Fish Bait"] = v3
local v5 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting recipe for <font color=\"rgb(%*, %*, %*)\">Legendary Fish Bait</font>."):format(236, 206, 56),
    ["GivenItem"] = "Legendary Fish Bait",
    ["Requirements"] = {
        ["Legendary Fish"] = 1
    },
    ["Default"] = true,
    ["BaseItem"] = "Legendary Fish",
    ["UseRequiredItem"] = true
}
v1["Legendary Fish Bait"] = v5
return v1