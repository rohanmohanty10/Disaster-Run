 

local v1 = {}
local v2 = {
    ["Icon"] = "",
    ["Description"] = "Rare Fishing Rod",
    ["GivenItem"] = "Rare Fishing Rod",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Rare Fish"] = 20,
        ["Fishing Rod"] = 1
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
v1["Rare Fishing Rod"] = v2
local v4 = {
    ["Icon"] = "",
    ["Description"] = "Epic Fishing Rod",
    ["GivenItem"] = "Epic Fishing Rod",
    ["UseRequiredItem"] = true,
    ["Requirements"] = {
        ["Legendary Fish"] = 15,
        ["Rare Fishing Rod"] = 1
    },
    ["Default"] = true
}
local v5 = {
    ["Legendary Fish"] = {
        ["AllowMultiple"] = true,
        ["BaseItem"] = "Legendary Fish"
    }
}
v4.RequirementsExtra = v5
v1["Epic Fishing Rod"] = v4
local v6 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Jack-O\'Rod</font>."):format(255, 6, 6),
    ["GivenItem"] = "Jack-O\'Rod",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Dark Skeletal Shark"] = 6,
        ["Skeletal Shark"] = 6,
        ["Jack-O\'-Bite"] = 6,
        ["Candy Corn Squid"] = 6
    }
}
v1["Jack-O\'Rod Blueprint"] = v6
local v7 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Angler Rod</font>."):format(255, 6, 6),
    ["GivenItem"] = "Angler Rod",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Anglerfish"] = 25
    }
}
v1["Angler Rod Blueprint"] = v7
local v8 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Devil Fruit Rod</font>."):format(255, 6, 6),
    ["GivenItem"] = "Devil Fruit Rod",
    ["IgnoreBaseItem"] = true,
    ["ClipList"] = true,
    ["Requirements"] = {
        ["Tori"] = 1,
        ["Kira"] = 1,
        ["Pteranodon"] = 1,
        ["Zushi"] = 1,
        ["Spin"] = 1,
        ["Goru"] = 1,
        ["Venom"] = 1,
        ["Mochi"] = 1,
        ["Ito"] = 1,
        ["Hie"] = 1,
        ["Goro"] = 1,
        ["Magu"] = 1,
        ["Pika"] = 1,
        ["Suke"] = 1
    }
}
v1["Devil Fruit Rod Blueprint"] = v8
local v9 = {
    ["Icon"] = "",
    ["Description"] = ("Crafting Blueprint for <font color=\"rgb(%*, %*, %*)\">Lovestruck Rod</font>."):format(255, 6, 6),
    ["GivenItem"] = "Lovestruck Rod",
    ["IgnoreBaseItem"] = true,
    ["Requirements"] = {
        ["Mero"] = 1,
        ["Merchants Banana Rod"] = 1
    }
}
v1["Lovestruck Rod Blueprint"] = v9
return v1