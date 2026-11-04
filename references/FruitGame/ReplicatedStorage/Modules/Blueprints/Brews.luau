 

local v1 = {}
local v2 = {
    ["Icon"] = "",
    ["Description"] = "Basic Fish Luck Brew",
    ["GivenItem"] = "Basic Fish Luck Brew",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Rare Fish"] = 10
    },
    ["Default"] = true
}
local v3 = {
    ["Rare Fish"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Rare Fish"
    }
}
v2.RequirementsExtra = v3
v1["Basic Fish Luck Brew"] = v2
local v4 = {
    ["Icon"] = "",
    ["Description"] = "Stench of the Deep",
    ["GivenItem"] = "Stench of the Deep",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Rare Fish"] = 3
    },
    ["Default"] = true
}
local v5 = {
    ["Rare Fish"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Rare Fish"
    }
}
v4.RequirementsExtra = v5
v1["Stench of the Deep"] = v4
local v6 = {
    ["Icon"] = "",
    ["Description"] = "Rare Fish Luck Brew",
    ["GivenItem"] = "Rare Fish Luck Brew",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Legendary Fish"] = 3
    },
    ["Default"] = true
}
local v7 = {
    ["Legendary Fish"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Legendary Fish"
    }
}
v6.RequirementsExtra = v7
v1["Rare Fish Luck Brew"] = v6
return v1