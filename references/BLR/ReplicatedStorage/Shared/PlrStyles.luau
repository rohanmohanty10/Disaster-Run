  

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function textColor(p1, p2) -- Line: 3
    return `<font color="#{p2:ToHex()}">{p1}</font>`;
end;

local v3 = `<font color="#{Color3.fromRGB(145, 0, 0):ToHex()}">S+</font>`;
local v4 = `<font color="#{Color3.fromRGB(255, 0, 0):ToHex()}">S</font>`;
local v5 = `<font color="#{Color3.fromRGB(255, 156, 35):ToHex()}">A</font>`;
local v6 = `<font color="#{Color3.fromRGB(255, 210, 32):ToHex()}">B</font>`;
local v7 = `<font color="#{Color3.fromRGB(39, 255, 93):ToHex()}">C</font>`;
local v8 = `<font color="#{Color3.fromRGB(52, 177, 255):ToHex()}">D</font>`;
("<font color=\"#%*\">F</font>"):format((Color3.fromRGB(198, 66, 255):ToHex()));
local v9 = `<font color="#{Color3.fromRGB(206, 206, 206):ToHex()}">N/A</font>`;
local v10 = `<font color="#{Color3.fromRGB(207, 30, 198):ToHex()}">Highly Skilled</font>`;
local v11 = `<font color="#{Color3.fromRGB(183, 38, 255):ToHex()}">Skilled</font>`;
local v12 = `<font color="#{Color3.fromRGB(255, 0, 0):ToHex()}">Hard</font>`;
local v13 = `<font color="#{Color3.fromRGB(255, 176, 39):ToHex()}">Medium</font>`;
local v14 = `<font color="#{Color3.fromRGB(38, 255, 0):ToHex()}">Easy</font>`;

local function grades(p15, p16, p17, p18, p19, p20) -- Line: 22
    return {
        SHT = p15,
        STE = p16,
        MOV = p17,
        DEF = p18,
        SUP = p19,
        DIFF = p20
    };
end;

return {
    Isagi = {
        Name = "Isagi",
        Desc = "A strategic playmaker, reads the game well and excels at positioning and teamwork.",
        Rarity = "Rare",
        BallColor = Color3.fromRGB(0, 157, 255),
        Grades = {
            SHT = v6,
            STE = v9,
            MOV = v7,
            DEF = v9,
            SUP = v9,
            DIFF = v14
        }
    },
    Chigiri = {
        Name = "Chigiri",
        Desc = "A speed-focused character, mastering swift dashes, enhanced sprinting, and boundless stamina.",
        Rarity = "Rare",
        BallColor = Color3.fromRGB(250, 96, 255),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v14
        }
    },
    Hiori = {
        Name = "NEL Hiori",
        Desc = "Perhaps the best passer in soccer history 🥶🥶🥶 YEEHAWWW",
        Rarity = "Epic",
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v8,
            DEF = v9,
            SUP = v5,
            DIFF = v14
        }
    },
    Igaguri = {
        Name = "Igaguri",
        Desc = "Expert at the reverse foul technique",
        Rarity = "Rare",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(255, 255, 6),
        Grades = {
            SHT = v9,
            STE = v3,
            MOV = v9,
            DEF = v9,
            SUP = v5,
            DIFF = v13
        }
    },
    Gagamaru = {
        Name = "Gagamaru",
        Desc = "Beastly GOALKEEPER with sharp instincts and unmatched reflexes.",
        Rarity = "Rare",
        BallColor = Color3.fromRGB(255, 190, 39),
        Grades = {
            SHT = v8,
            STE = v9,
            MOV = v9,
            DEF = v7,
            SUP = v4,
            DIFF = v11
        }
    },
    Otoya = {
        Name = "Otoya",
        Desc = "An actual ninja on the field.",
        Rarity = "Epic",
        Grades = {
            SHT = v6,
            STE = v6,
            MOV = v7,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        },
        BallColor = Color3.fromRGB(23, 255, 42)
    },
    Kurona = {
        Name = "Kurona",
        Desc = "All he\'s missing is a fin!",
        Rarity = "Rare",
        BallColor = Color3.fromRGB(192, 33, 255),
        Grades = {
            SHT = v9,
            STE = v5,
            MOV = v9,
            DEF = v9,
            SUP = v6,
            DIFF = v12
        }
    },
    Bachira = {
        Name = "Bachira",
        Desc = "An energetic dribbler, great at unpredictable plays and ankle breakers.",
        Rarity = "Epic",
        BallColor = Color3.fromRGB(255, 234, 0),
        Grades = {
            SHT = v8,
            STE = v7,
            MOV = v7,
            DEF = v9,
            SUP = v7,
            DIFF = v11
        }
    },
    Nagi = {
        Name = "Nagi",
        Desc = "Natural Talent, highly skilled at trapping.\nWould you like fries with that?",
        Rarity = "Legendary",
        BallColor = Color3.fromRGB(255, 255, 255),
        Grades = {
            SHT = v4,
            STE = v9,
            MOV = v5,
            DEF = v5,
            SUP = v9,
            DIFF = v10
        }
    },
    Karasu = {
        Name = "Karasu",
        Desc = "Fearless defender and striker able to appear anywhere at anytime",
        Rarity = "Epic",
        BallColor = Color3.fromRGB(138, 43, 255),
        Grades = {
            SHT = v9,
            STE = v5,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Kunigami = {
        Name = "Kunigami",
        Desc = "The fallen gambler that\'s back to get his revenge",
        Rarity = "Legendary",
        BallColor = Color3.fromRGB(255, 97, 44),
        Grades = {
            SHT = v5,
            STE = v5,
            MOV = v7,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Yukimiya = {
        Name = "Yukimiya",
        Desc = "Street ball legend, ultimate dribbler.",
        Rarity = "Mythic",
        BallColor = Color3.fromRGB(255, 0, 0),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v12
        }
    },
    King = {
        Name = "King",
        Desc = "The King Has Returned to reclaim his crown.",
        Rarity = "Legendary",
        BallColor = Color3.fromRGB(255, 0, 0),
        Grades = {
            SHT = v4,
            STE = v4,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Reo = {
        Name = "Reo",
        Desc = "The Chameleon, a copy artist who masters every play.",
        Rarity = "Mythic",
        BallColor = Color3.fromRGB(170, 23, 255),
        Grades = {
            SHT = v6,
            STE = v6,
            MOV = v6,
            DEF = v5,
            SUP = v5,
            DIFF = v13
        }
    },
    Shidou = {
        Name = "Shidou",
        Desc = "A wild striker thriving on chaos and unpredictability.",
        Rarity = "Mythic",
        BallColor = Color3.fromRGB(239, 11, 255),
        Grades = {
            SHT = v5,
            STE = v5,
            MOV = v5,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Aiku = {
        Name = "Aiku",
        Desc = " An impenetrable wall, who stops any goals from being scored while on the field",
        Rarity = "Legendary",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(20, 255, 40),
        Grades = {
            SHT = v9,
            STE = v5,
            MOV = v9,
            DEF = v4,
            SUP = v5,
            DIFF = v12
        }
    },
    ["NEL Bachira"] = {
        Name = "NEL Bachira",
        Desc = "Floats like a butterfly, stings like a bee, an unstoppable dribbler, who can solo entire teams.",
        Rarity = "Mythic",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(255, 201, 6),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v12
        }
    },
    ["NEL Chigiri"] = {
        Name = "NEL Chigiri",
        Desc = "-",
        Rarity = "World Class",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(255, 105, 208),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v12
        }
    },
    Ness = {
        Name = "Ness",
        Desc = "The Magician",
        Rarity = "Mythic",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(255, 0, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Charles = {
        Name = "Charles",
        Desc = "And then I said \"👅\"",
        Rarity = "Mythic",
        BallColor = Color3.fromRGB(255, 234, 129),
        Grades = {
            SHT = v9,
            STE = v7,
            MOV = v4,
            DEF = v5,
            SUP = v3,
            DIFF = v14
        }
    },
    ["NEL Nagi"] = {
        Name = "NEL Nagi",
        Desc = "Lazy. Genius. Prodigy. What else must be said?",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(255, 255, 255),
        Grades = {
            SHT = v4,
            STE = v9,
            MOV = v7,
            DEF = v3,
            SUP = v9,
            DIFF = v14
        }
    },
    ["NEL Isagi"] = {
        Name = "NEL Isagi",
        Desc = "Truly, an out of this world player.",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(12, 255, 20),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v5,
            DEF = v9,
            SUP = v4,
            DIFF = v12
        }
    },
    ["NEL Rin"] = {
        Name = "NEL Rin",
        Desc = "Tactical striker with deadly curves, precise shots, and unmatched control.",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["NEL Shidou"] = {
        Name = "NEL Shidou",
        Desc = "A chaotic striker that has an obsession for goals",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(255, 97, 179),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["NEL King"] = {
        Name = "NEL King",
        Desc = "A chaotic striker that has an obsession for goals",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(255, 58, 61),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["NEL Aiku"] = {
        Name = "NEL Aiku",
        Desc = "",
        Rarity = "World Class",
        Unobtainable = true,
        BallColor = Color3.fromRGB(200, 35, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Sae = {
        Name = "Sae",
        Desc = "Genius playmaker with unrivaled skills, precise passes, and unstoppable shots.",
        Rarity = "World Class",
        BallColor = Color3.fromRGB(255, 19, 251),
        Grades = {
            SHT = v4,
            STE = v5,
            MOV = v5,
            DEF = v9,
            SUP = v3,
            DIFF = v13
        }
    },
    Kaiser = {
        Name = "Kaiser",
        Desc = "A fitting title for one heck of a player.",
        Rarity = "World Class",
        Skins = {
            Easter = {
                displayName = "Easter Kaiser",
                Rarity = "Limited",
                EffectsFolder = ReplicatedStorage.Effects.KaiserEasterSkin
            }
        },
        BallColor = Color3.fromRGB(33, 129, 255),
        Grades = {
            SHT = v3,
            STE = v7,
            MOV = v4,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Don Lorenzo"] = {
        Name = "Don Lorenzo",
        Desc = "I found this guy on the street and he said \"Gimme.. lucky spins..\"",
        Rarity = "World Class",
        BallColor = Color3.fromRGB(109, 45, 186),
        Grades = {
            SHT = v9,
            STE = v4,
            MOV = v4,
            DEF = v5,
            SUP = v9,
            DIFF = v11
        }
    },
    Bunny = {
        Name = "Bunny",
        Desc = "The Sae-Slayer",
        Rarity = "World Class",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(153, 51, 255),
        Grades = {
            SHT = v6,
            STE = v6,
            MOV = v7,
            DEF = v9,
            SUP = v5,
            DIFF = v12
        }
    },
    Loki = {
        Name = "Loki",
        Desc = "Ummm, is this okay? From this distance you have nothing but weak spots.",
        Rarity = "Master",
        BallColor = Color3.fromRGB(153, 51, 255),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v3,
            DEF = v6,
            SUP = v9,
            DIFF = v12
        }
    },
    Lavinho = {
        Name = "Lavinho",
        Desc = "IT\'S.. SHOWTIME!",
        Rarity = "Master",
        BallColor = Color3.fromRGB(0, 255, 81),
        Grades = {
            SHT = v5,
            STE = v9,
            MOV = v6,
            DEF = v9,
            SUP = v9,
            DIFF = v12
        }
    },
    Snuffy = {
        Name = "Snuffy",
        Desc = "A master tactician who commands the field.",
        Rarity = "Master",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(230, 180, 80),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Niko = {
        Name = "Niko",
        Desc = "A strategic defender who reads the field and intercepts plays.",
        Rarity = "Mythic",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(57, 111, 255),
        Grades = {
            SHT = v9,
            STE = v5,
            MOV = v7,
            DEF = v4,
            SUP = v6,
            DIFF = v12
        }
    },
    BachiraNew = {
        Name = "BachiraNew",
        Desc = "After succumbing to satisfaction, he takes up a new pursuit",
        Rarity = "Dev",
        AnalyticsExcluded = true,
        Unobtainable = true,
        BallColor = Color3.fromRGB(255, 247, 0),
        Grades = {
            DIFF = nil,
            SHT = v4,
            STE = v9,
            MOV = v5,
            DEF = v3,
            SUP = v14
        }
    },
    ["McNagi Fryshiro"] = {
        Name = "McNagi Fryshiro",
        Desc = "After succumbing to satisfaction, he takes up a new pursuit",
        Rarity = "Limited",
        AnalyticsExcluded = true,
        Unobtainable = true,
        BallColor = Color3.fromRGB(255, 247, 0),
        Grades = {
            SHT = v4,
            STE = v9,
            MOV = v5,
            DEF = v3,
            SUP = v9,
            DIFF = v14
        }
    },
    ["Reaper Sae"] = {
        Name = "Reaper Sae",
        Desc = "Anything to be the best, right?",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(154, 65, 255),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Demon Shidou"] = {
        Name = "Demon Shidou",
        Desc = "I took the demon oath and absolutely nothing changed. SCAMMED!",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(227, 70, 255),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Blood Moon Rin"] = {
        Name = "Blood Moon Rin",
        Desc = "I\'LL MANGLE YOU",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(227, 70, 255),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Phantom Isagi"] = {
        Name = "Phantom Isagi",
        Desc = "The Haunted Egoist",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Skeleton Nagi"] = {
        Name = "Skeleton Nagi",
        Desc = "A monster can\'t keep up with something already dead.",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Elf Emperor"] = {
        Name = "Elf Emperor",
        Desc = "The Elf Monarch whos cold as winter",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Krampus Barou"] = {
        Name = "Krampus Barou",
        Desc = "The King who stole Christmas",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Gingerbread Charles"] = {
        Name = "Gingerbread Charles",
        Desc = "A playmaker fresh out the oven",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Subzero Loki"] = {
        Name = "Subzero Loki",
        Desc = "A snow-born speedster with icy precision 🥶",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Santa Lavinho"] = {
        Name = "Santa Lavinho",
        Desc = "Brazilian flair wrapped in winter magic",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Firework Bachira"] = {
        Name = "Firework Bachira",
        Desc = "The Firework Monster",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        TextColor = Color3.fromRGB(64, 255, 128),
        BallColor = Color3.fromRGB(47, 255, 0),
        Grades = {
            SHT = v9,
            STE = v9,
            MOV = v9,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Rin = {
        Name = "Rin",
        Desc = "Tactical striker with deadly curves, precise shots, and unmatched control.",
        Rarity = "Mythic",
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Raichi = {
        Name = "Raichi",
        Desc = "This hot headed mid fielder guards tight, and never lets go.",
        Rarity = "Rare",
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    ["Easter Yukimiya"] = {
        Name = "Easter Yukimiya",
        Desc = "-",
        Rarity = "Limited",
        Unobtainable = true,
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Kiyora = {
        Name = "Kiyora",
        Desc = "The Breakdancer",
        Rarity = "Legendary",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Sendou = {
        Name = "Sendou",
        Desc = "U20 Japans Striker",
        Rarity = "Epic",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    },
    Zantetsu = {
        Name = "Zantetsu",
        Desc = "-",
        Rarity = "Legendary",
        AnalyticsExcluded = true,
        BallColor = Color3.fromRGB(82, 246, 255),
        Grades = {
            SHT = v5,
            STE = v6,
            MOV = v3,
            DEF = v9,
            SUP = v9,
            DIFF = v13
        }
    }
};