 

local v1 = {}
local v2 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Legendary Fruit Chest</font>."):format(255, 255, 0),
    ["GivenItem"] = "Legendary Fruit Chest",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Legendary Fruit"] = 5
    }
}
local v3 = {
    ["Legendary Fruit"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Legendary Fruit"
    }
}
v2.RequirementsExtra = v3
v1["Legendary Fruit Chest Blueprint"] = v2
local v4 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Shark Blood Bottle</font>."):format(255, 6, 6),
    ["GivenItem"] = "Shark Blood Bottle",
    ["Requirements"] = {
        ["Shark Tooth"] = 10
    }
}
v1["Shark Blood Bottle Blueprint"] = v4
local v5 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Megalodon Armor Set</font>."):format(255, 118, 0),
    ["GivenItem"] = "Megalodon Armor Set",
    ["Requirements"] = {
        ["Megalodon Teeth"] = 10,
        ["Kraken Armor Set"] = 1
    }
}
v1["Megalodon Armor Set Blueprint"] = v5
local v6 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Megalodon Helmet</font>."):format(255, 6, 6),
    ["GivenItem"] = "Megalodon Helmet",
    ["Requirements"] = {
        ["Megalodon Teeth"] = 10,
        ["Shark Blood Bottle"] = 3,
        ["Slayer\'s Mask"] = 1
    }
}
v1["Megalodon Helmet Blueprint"] = v6
local v7 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Boneshiver</font>."):format(236, 174, 16),
    ["GivenItem"] = "Boneshiver",
    ["Requirements"] = {
        ["Megalodon Teeth"] = 5,
        ["Kiribachi"] = 1
    }
}
v1["Boneshiver Blueprint"] = v7
local v8 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Egg Phone</font>."):format(255, 6, 6),
    ["GivenItem"] = "Egg Phone",
    ["Requirements"] = {
        ["Blue Star Egghead"] = 1,
        ["Orange n Yellow Egghead"] = 1,
        ["Peach Dots Egghead"] = 1,
        ["Pink Squiggly Egghead"] = 1,
        ["White Glowing Egghead"] = 1
    }
}
v1["Egg Phone Blueprint"] = v8
local v9 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Swordfish Rapier</font>."):format(255, 6, 6),
    ["GivenItem"] = "Swordfish Rapier",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Swordfish"] = 25
    }
}
v1["Swordfish Rapier Blueprint"] = v9
local v10 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Skeletal Shark Mask</font>."):format(255, 6, 6),
    ["GivenItem"] = "Skeletal Shark Mask",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Skeletal Shark"] = 8
    }
}
v1["Skeletal Shark Mask Blueprint"] = v10
local v11 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Dark Skeletal Shark Mask</font>."):format(255, 6, 6),
    ["GivenItem"] = "Dark Skeletal Shark Mask",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Dark Skeletal Shark"] = 15
    }
}
v1["Dark Skeletal Shark Mask Blueprint"] = v11
local v12 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Angler\'s Lantern</font>."):format(255, 6, 6),
    ["GivenItem"] = "Angler\'s Lantern",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Anglerfish"] = 8
    }
}
v1["Angler\'s Lantern Blueprint"] = v12
local v13 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Grappling Hook</font>."):format(255, 6, 6),
    ["GivenItem"] = "Grappling Hook",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Golden Hook"] = 1,
        ["Ito"] = 1,
        ["Cyborg Gear"] = 10
    }
}
v1["Grappling Hook Blueprint"] = v13
for v14, v15 in pairs(v1) do
    v15.Requirements[v14] = 1
end
return v1