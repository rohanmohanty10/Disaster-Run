  

 

local v1 = {};

local function Lerp(p2, p3, p4) -- Line: 3
    return p2:Lerp(p3, p4);
end;

local function Quad(p5, p6, p7, p8) -- Line: 7
    -- upvalues: Lerp (copy)
    return Lerp(p5:Lerp(p6, p8), p6:Lerp(p7, p8), p8);
end;

v1.Ranks = { "Visitor", "Intern", "Research Assistant", "Junior Researcher", "Researcher", "Senior Researcher", "Lead Researcher", "Scientist", "Chief Scientist" };
v1.RankRewards = { { "{TITLE_145}", "Base Access" }, { "{TITLE_146}", "Keycard Clearance: 2" }, { "{TITLE_147}", "Keycard Clearance: 3" }, { "{TITLE_148}", "Keycard Clearance: 4" }, { "{TITLE_149}" }, { "{TITLE_150}" }, { "{TITLE_151}" }, { "{TITLE_152}" }, { "{TITLE_153}", "{MOUNT_56}" } };
v1.RankColors = {};
v1.Requirements = { 0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600 };
v1.ExchangeData = {
    ITEM_79 = 55,
    ITEM_915 = 50,
    ITEM_911 = 50,
    ITEM_15 = 150,
    ITEM_914 = 100,
    ITEM_908 = 20,
    ITEM_909 = 25,
    ITEM_910 = 80,
    ITEM_925 = 20
};
v1.ResearchData = {
    Drill1 = {
        Rank = 3,
        Description = "Allows fabrication of {ITEM_904}",
        DisplayName = "Mining Laser",
        Requirements = {
            ITEM_810 = 5,
            ITEM_811 = 2,
            ITEM_908 = 2
        }
    },
    Drill2 = {
        Rank = 7,
        Description = "Allows fabrication of {ITEM_905}",
        DisplayName = "Mining Laser MK2",
        Requirements = {
            ITEM_925 = 5,
            ITEM_911 = 3,
            ITEM_910 = 5
        }
    },
    Mats0 = {
        Rank = 4,
        Requirements = nil,
        Description = "Allows fabrication of {ITEM_913}. <i>Unlocked through dialogue with the Gateway Overseer</i>",
        DisplayName = "Rhythmic Channeling"
    },
    Mats1 = {
        Rank = 4,
        Description = "Allows fabrication of {ITEM_910}",
        DisplayName = "Advanced Materials",
        Requirements = {
            ITEM_909 = 6
        }
    },
    Mats2 = {
        Rank = 5,
        Requirements = nil,
        Description = "Allows fabrication of {ITEM_920} through an experimental infusion process. <i>Unlocked by showing {ITEM_911} to the Analytics Overseer.</i>",
        DisplayName = "Camellite Infusion"
    },
    Mats3 = {
        Rank = 6,
        Requirements = nil,
        Description = "Allows reactivation of {ITEM_916} and {ITEM_917} into {ITEM_923} and {ITEM_924} respectively by reverse-engineering cultist arsenal. <i>Unlocked by showing dormant weapons to the Analytics Overseer.</i>",
        DisplayName = "Reverse Engineering"
    },
    Mats4 = {
        Rank = 7,
        Requirements = nil,
        Description = "CONSTRUCT THE {ITEM_919}. <i>Unlocked through space progression.</i>",
        DisplayName = "FINAL CONDUIT"
    },
    Translator = {
        Rank = 6,
        Requirements = nil,
        Description = "Allows fabrication of {ITEM_918}. This technology is not of earth origin and its function is not verified. <i>Unlocked through space progression.</i>",
        DisplayName = "Alien Technology"
    },
    ItemCap1 = {
        Rank = 4,
        Description = "<b>Item</b> Inventory capacity <b>+2</b>",
        DisplayName = "Item Capacity+",
        Requirements = {
            ITEM_908 = 3,
            ITEM_909 = 3,
            ITEM_20 = 3
        }
    },
    StandCap1 = {
        Rank = 4,
        Description = "<b>Ability</b> Inventory capacity <b>+2</b>",
        DisplayName = "Ability Capacity+",
        Requirements = {
            ITEM_908 = 3,
            ITEM_909 = 3,
            ITEM_20 = 3
        }
    },
    SkinCap1 = {
        Rank = 4,
        Description = "<b>Skin</b> Inventory capacity <b>+5</b>",
        DisplayName = "Skin Capacity+",
        Requirements = {
            ITEM_908 = 3,
            ITEM_909 = 3,
            ITEM_20 = 3
        }
    },
    ItemCap2 = {
        Rank = 7,
        Description = "<b>Item</b> Inventory capacity <b>+3</b>",
        DisplayName = "Item Capacity++",
        Requirements = {
            ITEM_910 = 3,
            ITEM_911 = 3,
            ITEM_915 = 3
        }
    },
    StandCap2 = {
        Rank = 7,
        Description = "<b>Ability</b> Inventory capacity <b>+3</b>",
        DisplayName = "Ability Capacity++",
        Requirements = {
            ITEM_910 = 3,
            ITEM_911 = 3,
            ITEM_915 = 3
        }
    },
    SkinCap2 = {
        Rank = 7,
        Description = "<b>Skin</b> Inventory capacity <b>+10</b>",
        DisplayName = "Skin Capacity++",
        Requirements = {
            ITEM_910 = 3,
            ITEM_911 = 3,
            ITEM_915 = 3
        }
    },
    Cap1 = {
        Rank = 9,
        Description = "<b>Ability</b> and <b>Item</b> Inventory capacity <b>+5</b>, <b>Skin</b> Inventory capacity <b>+10</b>",
        DisplayName = "Capacity+",
        Requirements = {
            ITEM_919 = 1
        }
    },
    Tether_1 = {
        Rank = 5,
        Description = "The <font color=\"rgb(108,172,255)\"><b>Tether</b></font> takes <b>50%</b> less time to finish charging while on the <b>Fractured Island</b>, allowing for a quicker return.",
        DisplayName = "Tether Optimization",
        Requirements = {
            ITEM_910 = 3,
            ITEM_20 = 3
        }
    },
    Rad_0 = {
        Rank = 5,
        Description = "Allows you to withstand <font color=\"rgb(40,214,37)\">certain</font> more powerful levels of radiation. Additionally, <font color=\"rgb(255,181,96)\"><b>Radiation</b></font> builds up <b>10%</b> slower while on the <b>Fractured Island</b>.",
        DisplayName = "Enhanced Protection",
        Requirements = {
            ITEM_910 = 3,
            ITEM_925 = 2
        }
    },
    Rad_1 = {
        Rank = 6,
        Description = "<font color=\"rgb(255,181,96)\"><b>Radiation</b></font> builds up <b>30%</b> slower while on the <b>Fractured Island</b>, allowing for longer stays.",
        DisplayName = "Radiation Dampening",
        Requirements = {
            ITEM_910 = 4,
            ITEM_911 = 3,
            ITEM_925 = 3
        }
    },
    Sensor_1 = {
        Rank = 5,
        Description = "Be notified of the closest <b>fast travel</b> location to the next <b>Camellite Meteorite</b> impact in advance",
        DisplayName = "Meteorite Sensoring",
        Requirements = {
            ITEM_910 = 1,
            ITEM_925 = 3
        }
    },
    Implant_1 = {
        Rank = 6,
        Description = "You no longer need to hold a keycard for <b>clearance</b>",
        DisplayName = "Authorization Implant",
        Requirements = {
            ITEM_900 = 1,
            ITEM_925 = 3
        }
    }
};
v1.RefiningData = {
    ITEM_904 = {
        Requirements = {
            ITEM_908 = 2,
            ITEM_811 = 1
        },
        Dependencies = { "Drill1" }
    },
    ITEM_905 = {
        Requirements = {
            ITEM_904 = 1,
            ITEM_925 = 5,
            ITEM_911 = 1,
            ITEM_910 = 3
        },
        Dependencies = { "Drill1", "Drill2" }
    },
    ITEM_910 = {
        Requirements = {
            ITEM_909 = 3
        },
        Dependencies = { "Drill1", "Mats1" }
    },
    ITEM_912 = {
        Requirements = {
            ITEM_910 = 2,
            ITEM_20 = 2
        },
        Dependencies = { "Drill1", "Mats1" }
    },
    ITEM_913 = {
        Requirements = {
            ITEM_908 = 1,
            ITEM_810 = 2
        },
        Dependencies = { "Mats0" }
    },
    ITEM_918 = {
        Requirements = {
            ITEM_915 = 3,
            ITEM_910 = 1,
            ITEM_20 = 2
        },
        Dependencies = { "Translator" }
    },
    ITEM_920 = {
        Requirements = {
            ITEM_910 = 3,
            ITEM_911 = 1,
            ITEM_1 = 1
        },
        Dependencies = { "Mats1", "Mats2" }
    },
    ITEM_922 = {
        Requirements = {
            ITEM_908 = 3,
            ITEM_912 = 1
        },
        Dependencies = { "Drill1", "Mats1" }
    },
    ITEM_923 = {
        Requirements = {
            ITEM_916 = 1,
            ITEM_915 = 3,
            ITEM_910 = 2
        },
        Dependencies = { "Mats1", "Mats3" }
    },
    ITEM_924 = {
        Requirements = {
            ITEM_917 = 1,
            ITEM_915 = 3,
            ITEM_910 = 2
        },
        Dependencies = { "Mats1", "Mats3" }
    },
    ITEM_919 = {
        Requirements = {
            ITEM_915 = 5,
            ITEM_911 = 3,
            ITEM_914 = 1,
            ITEM_912 = 1
        },
        Dependencies = { "Mats1", "Translator", "Mats4" }
    },
    ITEM_933 = {
        Requirements = {
            ITEM_912 = 2,
            ITEM_925 = 3,
            ITEM_811 = 5
        },
        Dependencies = { "Mats1", "Translator", "Mats0" }
    },
    ITEM_934 = {
        Requirements = {
            ITEM_918 = 1,
            ITEM_910 = 1,
            ITEM_913 = 4,
            ITEM_811 = 4
        },
        Dependencies = { "Mats1", "Drill1", "Mats0" }
    }
};
local v9 = Color3.fromRGB(255, 234, 217);
local v10 = Color3.fromRGB(255, 155, 88);
local v11 = Color3.fromRGB(255, 82, 82);

for i = 1, #v1.Ranks do
    local v12 = i / #v1.Ranks;
    v1.RankColors[i] = v9:Lerp(v10, v12):Lerp(v10:Lerp(v11, v12), v12);
end;

return v1;