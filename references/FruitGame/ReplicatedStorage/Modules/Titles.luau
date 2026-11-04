 

local v1 = {}
local v2 = {
    ["Perks"] = { "1.5x DMG TO KRAKENS" },
    ["RoleColor"] = Color3.fromRGB(255, 0, 127),
    ["PerkTags"] = {
        ["NPC"] = "Kraken",
        ["dmgBoost"] = 1.5
    },
    ["Obtain"] = {
        ["Kills"] = 100,
        ["NPC"] = "Kraken"
    },
    ["ID"] = 1
}
v1["Kraken Slayer"] = v2
local v3 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 50000,
        ["Team"] = "Pirate",
        ["Grips"] = 20
    },
    ["ID"] = 2
}
v1["Cabin Boy"] = v3
local v4 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 100000,
        ["Team"] = "Pirate",
        ["Grips"] = 40
    },
    ["ID"] = 3
}
v1.Rookie = v4
local v5 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 4,
    ["Obtain"] = {
        ["Bounty"] = 250000,
        ["Team"] = "Pirate",
        ["Grips"] = 85
    }
}
v1["Great Pirate"] = v5
local v6 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(85, 85, 255),
    ["ID"] = 5,
    ["Obtain"] = {
        ["Bounty"] = 500000,
        ["Team"] = "Pirate",
        ["Grips"] = 120
    }
}
v1.Supernova = v6
local v7 = {
    ["Perks"] = { "Pirate and Marine ships do not chase you, as they are too scared." },
    ["PerkTags"] = {
        ["noShips"] = true
    },
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["ID"] = 6,
    ["removeable"] = true,
    ["Obtain"] = {
        ["Bounty"] = 1000000,
        ["Team"] = "Pirate",
        ["Grips"] = 300
    }
}
v1.Warlord = v7
local v8 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 50000,
        ["Team"] = "Marine",
        ["Arrests"] = 5
    },
    ["Rewards"] = { "Marine Officer Outfit" },
    ["removeable"] = true,
    ["ID"] = 7
}
v1.Officer = v8
local v9 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 100000,
        ["Team"] = "Marine",
        ["Arrests"] = 10
    },
    ["Rewards"] = { "Marine Lieutenant Outfit" },
    ["removeable"] = true,
    ["ID"] = 8
}
v1.Lieutenant = v9
local v10 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 250000,
        ["Team"] = "Marine",
        ["Arrests"] = 25
    },
    ["Rewards"] = { "Marine Commander Cape", "Marine Commander Outfit" },
    ["removeable"] = true,
    ["ID"] = 9
}
v1.Commander = v10
local v11 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 255, 255),
    ["Obtain"] = {
        ["Bounty"] = 500000,
        ["Team"] = "Marine",
        ["Arrests"] = 50
    },
    ["Rewards"] = { "Marine Captain Outfit", "Marine Captain Cape 2" },
    ["removeable"] = true,
    ["ID"] = 10
}
v1.Captain = v11
local v12 = {
    ["Perks"] = { "Pirate and Marine ships do not chase you, as they are too scared." },
    ["PerkTags"] = {
        ["noShips"] = true
    },
    ["RoleColor"] = Color3.fromRGB(85, 170, 255),
    ["Obtain"] = {
        ["Bounty"] = 1000000,
        ["Team"] = "Marine",
        ["Arrests"] = 100
    },
    ["Rewards"] = { "Marine Rear Admiral Outfit" },
    ["removeable"] = true,
    ["ID"] = 11
}
v1["Rear Admiral"] = v12
local v13 = {
    ["Perks"] = { "1.5x DMG TO SEA SERPENTS" },
    ["RoleColor"] = Color3.fromRGB(200, 0, 100),
    ["PerkTags"] = {
        ["NPC"] = "Sea Serpent",
        ["dmgBoost"] = 1.5
    },
    ["Obtain"] = {
        ["Kills"] = 100,
        ["NPC"] = "Sea Serpent"
    },
    ["ID"] = 12
}
v1["Beast Slayer"] = v13
local v14 = {
    ["Perks"] = { "Collect 2x the ammount of Wooden Planks" },
    ["RoleColor"] = Color3.fromRGB(170, 255, 127),
    ["Obtain"] = {
        ["Kills"] = 1000,
        ["NPC"] = "Wooden Plank"
    },
    ["ID"] = 13
}
v1["Wood Collector"] = v14
local v15 = {
    ["Perks"] = { "5% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.05
    },
    ["RoleColor"] = Color3.fromRGB(255, 170, 127),
    ["Obtain"] = {
        ["1v1Wins"] = 100
    },
    ["ID"] = 14
}
v1["Arena Warrior"] = v15
local v16 = {
    ["Perks"] = { "8% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.08
    },
    ["RoleColor"] = Color3.fromRGB(0, 0, 255),
    ["Obtain"] = {
        ["1v1Wins"] = 250
    },
    ["ID"] = 15
}
v1.Champion = v16
local v17 = {
    ["Perks"] = { "15% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.15
    },
    ["RoleColor"] = Color3.fromRGB(255, 85, 127),
    ["Obtain"] = {
        ["WinStreak"] = 150
    },
    ["ID"] = 16
}
v1.Immortal = v17
v1["Explorer of the Seas"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 17
}
v1["Devil\'s Luck"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 170, 255),
    ["ID"] = 18
}
local v18 = {
    ["Perks"] = { "50% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.5
    },
    ["RoleColor"] = Color3.fromRGB(73, 237, 255),
    ["ID"] = 19
}
v1.Tester = v18
v1["Content Creator"] = {
    ["Perks"] = { "Anonymous mode in battle royale" },
    ["RoleColor"] = Color3.fromRGB(170, 0, 0),
    ["OnFunction"] = function(p19) --[[ Name: OnFunction, Line 142 ]]
        if _G.arena == true then
            p19:SetAttribute("hidePlayerList", true)
        end
    end,
    ["OffFunction"] = function(p20) --[[ Name: OffFunction, Line 148 ]]
        p20:SetAttribute("hidePlayerList", nil)
    end,
    ["ID"] = 20
}
v1["Tik Toker"] = {
    ["Perks"] = { "\240\159\147\183\240\159\147\183\240\159\147\183\240\159\147\183\240\159\147\183\240\159\147\183" },
    ["RoleColor"] = Color3.fromRGB(170, 0, 0),
    ["ID"] = 21
}
local v21 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "1SS"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 22
}
v1["Beginner Swordsman"] = v21
local v22 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "2SS"
    },
    ["RoleColor"] = Color3.fromRGB(195, 130, 97),
    ["ID"] = 23
}
v1["Advanced Swordsman"] = v22
local v23 = {
    ["Perks"] = { "50% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.5
    },
    ["RoleColor"] = Color3.fromRGB(0, 255, 255),
    ["ID"] = 24
}
v1.Admin = v23
local v24 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["CombinedWins"] = 1
    },
    ["ID"] = 25
}
v1["Last One Standing"] = v24
local v25 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "FishmanKarate"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 26
}
v1["Way of the fish"] = v25
local v26 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "DragonClaw"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 27
}
v1["Dragon\'s Claw"] = v26
local v27 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "Electro"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 28
}
v1.Electro = v27
local v28 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 10
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 29
}
v1["Beginner Trader"] = v28
local v29 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 25
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 30
}
v1["Novice Trader"] = v29
local v30 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 50
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 31
}
v1["Intermediate Trader"] = v30
local v31 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 100
    },
    ["RoleColor"] = Color3.fromRGB(229, 255, 219),
    ["ID"] = 32
}
v1["Skilled Trader"] = v31
local v32 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 200
    },
    ["RoleColor"] = Color3.fromRGB(170, 255, 127),
    ["ID"] = 33
}
v1["Advanced Trader"] = v32
local v33 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 400
    },
    ["RoleColor"] = Color3.fromRGB(170, 255, 0),
    ["ID"] = 34
}
v1["Senior Trader"] = v33
local v34 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["TradesCompleted"] = 800
    },
    ["RoleColor"] = Color3.fromRGB(0, 255, 0),
    ["ID"] = 35
}
v1["Expert Trader"] = v34
local v35 = {
    ["Perks"] = { "Originates from the one" },
    ["Obtain"] = {
        ["Collectable"] = 1
    },
    ["removeable"] = true,
    ["RoleColor"] = Color3.fromRGB(0, 0, 0),
    ["ID"] = 36
}
v1.Collector = v35
local v36 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "BlackLeg"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 37
}
v1.Kicker = v36
local v37 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "Rokushiki"
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 38
}
v1.Superhuman = v37
local v38 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["BlackLeg"] = 7
    },
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 39
}
v1["Demon Step"] = v38
local v39 = {
    ["Perks"] = { "2X Logia Rates, 100% Legendary Fruit Chest in battle royales if victorious.", "10% DMG boost to all NPCs", "1/40 Legendary Pity for fruits instead of 1/100" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.1
    },
    ["Obtain"] = {
        ["BaseItem"] = "All Seeing Eye"
    },
    ["removeable"] = true,
    ["RoleColor"] = Color3.fromRGB(170, 170, 255),
    ["ID"] = 40
}
v1["The All Seeing"] = v39
local v40 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["KenV2"] = true
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 41
}
v1["Mind Reader"] = v40
local v41 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["BusoV2"] = true
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 42
}
v1["Spirit Enlightened"] = v41
v1["Gate Crasher"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(180, 180, 180),
    ["ID"] = 43
}
v1["True Gate Crasher"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(0, 0, 0),
    ["ID"] = 44
}
local v42 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["afkTime"] = 1000000
    },
    ["RoleColor"] = Color3.fromRGB(153, 255, 246),
    ["ID"] = 45
}
v1["NO LIFE"] = v42
v1.Patreon = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 255, 127),
    ["ID"] = 46
}
local v43 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FruitsUnboxed"] = 100
    },
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 47
}
v1["Fruit Unboxer"] = v43
local v44 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["CombinedWins"] = 15
    },
    ["ID"] = 48
}
v1["Tough One"] = v44
local v45 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["Obtain"] = {
        ["CombinedWins"] = 75
    },
    ["ID"] = 49
}
v1["Absolute Unit"] = v45
local v46 = {
    ["Perks"] = { "250% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 2.5
    },
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["ID"] = 50
}
v1.Developer = v46
local v47 = {
    ["Perks"] = { "All for one" },
    ["Obtain"] = {
        ["ToolTag"] = "Exclusive"
    },
    ["StartText"] = "<stroke color=\"#5555ff\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["removeable"] = true,
    ["RoleColor"] = Color3.fromRGB(0, 0, 0),
    ["ID"] = 51
}
v1["Exclusive Collector"] = v47
v1["2022 Anniversary Observer"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 127),
    ["ID"] = 52
}
v1["Phoeyu\'s Blessing"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(85, 85, 255),
    ["ID"] = 53
}
v1["Mythic Chest Opener"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(85, 85, 255),
    ["ID"] = 54
}
v1["Gear Second"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 255),
    ["ID"] = 55
}
local v48 = {
    ["Perks"] = { "5% DMG boost TO NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.05
    },
    ["RoleColor"] = Color3.fromRGB(0, 0, 0),
    ["StartText"] = "<stroke color=\"#da91da\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["ID"] = 56
}
v1["Event Winner"] = v48
v1["Middle Man"] = {
    ["Perks"] = { "" },
    ["RoleColor"] = Color3.fromRGB(0, 255, 127),
    ["ID"] = 57
}
local v49 = {
    ["Perks"] = { "50% DMG boost to NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.5
    },
    ["RoleColor"] = Color3.fromRGB(0, 255, 255),
    ["ID"] = 58
}
v1.Moderator = v49
local v50 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "Cyborg"
    },
    ["RoleColor"] = Color3.fromRGB(170, 255, 255),
    ["ID"] = 59
}
v1.Cyborg = v50
local v51 = {
    ["Perks"] = { "boss" },
    ["PerkTags"] = {
        ["NPC"] = "All/Players",
        ["dmgBoost"] = 20
    },
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 51, 10),
    ["ID"] = 60
}
v1["Sett, The Boss"] = v51
local v52 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["Impel Down"] = 1
    },
    ["ID"] = 61
}
v1["Impel Down Escapee"] = v52
local v53 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 85, 127),
    ["Obtain"] = {
        ["HighestImpelDownClear"] = 2
    },
    ["ID"] = 62
}
v1["Impel Down Challenger"] = v53
local v54 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(0, 85, 255),
    ["Obtain"] = {
        ["Race"] = "Dullahan"
    },
    ["ID"] = 63
}
v1.Dullahan = v54
local v55 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["Obtain"] = {
        ["Race"] = "Vampire"
    },
    ["ID"] = 64
}
v1.Vampire = v55
v1["2023 Anniversary Participant"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 127),
    ["ID"] = 65
}
v1["Gift Hunter"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["ID"] = 66
}
local v56 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 85, 127),
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["Obtain"] = {
        ["HighestImpelDownClear"] = 3
    },
    ["ID"] = 67
}
v1["Nightmare of Impel Down"] = v56
local v57 = {
    ["Perks"] = { "Pirate and Marine ships do not chase you, as they are too scared." },
    ["PerkTags"] = {
        ["noShips"] = true
    },
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 85, 0),
    ["ID"] = 68
}
v1.Yonko = v57
v1.Moonlit = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#55aaff\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(170, 255, 255),
    ["ID"] = 69
}
v1["Abyssal Strider"] = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(0, 85, 255),
    ["ID"] = 70
}
v1["Egg Hunter"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["ID"] = 71
}
local v58 = {
    ["Perks"] = { "1.20x DMG TO MEGALODONS" },
    ["RoleColor"] = Color3.fromRGB(85, 85, 85),
    ["PerkTags"] = {
        ["NPC"] = "Megalodon",
        ["dmgBoost"] = 1.2
    },
    ["Obtain"] = {
        ["Kills"] = 100,
        ["NPC"] = "Megalodon"
    },
    ["ID"] = 72
}
v1["Megalodon Slayer"] = v58
local v59 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 1
    },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 73
}
v1["Crafting Noob"] = v59
local v60 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 50
    },
    ["RoleColor"] = Color3.fromRGB(170, 255, 127),
    ["ID"] = 74
}
v1["Crafting Novice"] = v60
local v61 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 150
    },
    ["RoleColor"] = Color3.fromRGB(170, 255, 0),
    ["ID"] = 75
}
v1["Crafting Enthusiast"] = v61
local v62 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 500
    },
    ["RoleColor"] = Color3.fromRGB(170, 0, 255),
    ["ID"] = 76
}
v1["Creative Maestro"] = v62
local v63 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 500
    },
    ["RoleColor"] = Color3.fromRGB(170, 170, 255),
    ["ID"] = 77
}
v1["Creative Genius"] = v63
local v64 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["ItemsCrafted"] = 20000
    },
    ["StartText"] = "<font face=\"GrenzeGotisch\">",
    ["EndText"] = "</font>",
    ["RoleColor"] = Color3.fromRGB(85, 85, 255),
    ["ID"] = 78
}
v1["Master of Creation"] = v64
v1["God Human"] = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#aaffff\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 79
}
v1["Mobile Player"] = {
    ["Perks"] = { "have fun!" },
    ["RoleColor"] = Color3.fromRGB(170, 85, 127),
    ["ID"] = 80
}
v1["Console Player"] = {
    ["Perks"] = { "have fun!" },
    ["RoleColor"] = Color3.fromRGB(170, 85, 0),
    ["ID"] = 81
}
v1["Radiant One"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 99),
    ["ID"] = 82
}
v1["Trick or Treater"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 83
}
v1["Lucky Treater"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 84
}
v1["Unlucky Treater"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 85
}
local v65 = {
    ["Perks"] = { "Lure fish faster by 5%" },
    ["RoleColor"] = Color3.fromRGB(102, 178, 255),
    ["PerkTags"] = {
        ["Type"] = "FishLure",
        ["Boost"] = 1.05
    },
    ["Obtain"] = {
        ["FishesCaught"] = 50
    },
    ["ID"] = 86
}
v1["Novice Fisherman"] = v65
local v66 = {
    ["Perks"] = { "Lure fish faster by 15%" },
    ["PerkTags"] = {
        ["Type"] = "FishLure",
        ["Boost"] = 1.15
    },
    ["RoleColor"] = Color3.fromRGB(0, 128, 255),
    ["Obtain"] = {
        ["FishesCaught"] = 200
    },
    ["ID"] = 87
}
v1["Skilled Fisherman"] = v66
local v67 = {
    ["Perks"] = { "Catch rare fish more easily (1.25x chance)" },
    ["PerkTags"] = {
        ["Type"] = "FishChance",
        ["Boost"] = 1.25
    },
    ["RoleColor"] = Color3.fromRGB(0, 102, 204),
    ["Obtain"] = {
        ["FishesCaught"] = 1000
    },
    ["ID"] = 88
}
v1["Master Fisherman"] = v67
local v68 = {
    ["Perks"] = { "Catch rare fish more easily (2x chance)" },
    ["PerkTags"] = {
        ["Type"] = "FishChance",
        ["Boost"] = 2
    },
    ["StartText"] = "<stroke color=\"#aaffff\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(0, 128, 255),
    ["Obtain"] = {
        ["FishesCaught"] = 10000
    },
    ["ID"] = 89
}
v1["Godly Fisherman"] = v68
local v69 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "Iron Fist"
    },
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 0, 0),
    ["ID"] = 90
}
v1["Iron Fist"] = v69
v1["Sticky One"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 91
}
local v70 = {
    ["Perks"] = {},
    ["Obtain"] = {
        ["FightingStyle"] = "3SS"
    },
    ["RoleColor"] = Color3.fromRGB(85, 0, 255),
    ["ID"] = 92
}
v1["Master Swordsman"] = v70
local v71 = {
    ["Perks"] = { "1.10x DMG TO CUPID QUEEN" },
    ["RoleColor"] = Color3.fromRGB(255, 170, 255),
    ["PerkTags"] = {
        ["NPC"] = "Cupid Queen",
        ["dmgBoost"] = 1.1
    },
    ["Obtain"] = {
        ["Kills"] = 25,
        ["NPC"] = "Cupid Queen"
    },
    ["ArenaApply"] = true,
    ["ID"] = 93
}
v1["Cupid\'s Nemesis"] = v71
v1["Cupid\'s Survivor"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(156, 104, 156),
    ["ID"] = 94
}
v1["Cupid\'s Blessing"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 255),
    ["StartText"] = "<stroke color=\"#ff0000\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["ID"] = 95
}
v1["2024 Anniversary Participant"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 127),
    ["ID"] = 96
}
local v72 = {
    ["Perks"] = { "1.10x DMG TO Supreme Giftbox, Rocky" },
    ["RoleColor"] = Color3.fromRGB(85, 85, 255),
    ["PerkTags"] = {
        ["NPC"] = "Supreme Giftbox, Rocky",
        ["dmgBoost"] = 1.1
    },
    ["Obtain"] = {
        ["Kills"] = 100,
        ["NPC"] = "Supreme Giftbox, Rocky"
    },
    ["ArenaApply"] = true,
    ["ID"] = 97
}
v1["Rocky\'s Nemesis"] = v72
local v73 = {
    ["Perks"] = { "1.20x DMG TO Blo The Bunny" },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["PerkTags"] = {
        ["NPC"] = "Blo The Bunny",
        ["dmgBoost"] = 1.2
    },
    ["Obtain"] = {
        ["Kills"] = 50,
        ["NPC"] = "Blo The Bunny"
    },
    ["ArenaApply"] = true,
    ["ID"] = 98
}
v1["\240\159\144\176"] = v73
v1["\240\159\165\154"] = {
    ["Perks"] = { "Obtained from the roblox hatch event!" },
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ArenaApply"] = true,
    ["ID"] = 99
}
local v74 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(200, 200, 200),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 7
    },
    ["ID"] = 100
}
v1["7-Day Login"] = v74
local v75 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(210, 255, 210),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 30
    },
    ["ID"] = 101
}
v1["30-Day Login"] = v75
local v76 = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(170, 220, 255),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 75
    },
    ["ID"] = 102
}
v1["75-Day Login"] = v76
local v77 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#3a2a00\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 215, 0),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 100
    },
    ["ID"] = 103
}
v1["Centennial Login"] = v77
local v78 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#1f3b12\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(170, 255, 127),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 200
    },
    ["ID"] = 104
}
v1["200-Day Login"] = v78
local v79 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#0b2c59\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(85, 170, 255),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 300
    },
    ["ID"] = 105
}
v1["300-Day Login"] = v79
local v80 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#0a2a44\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(120, 200, 255),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 365
    },
    ["ID"] = 106
}
v1["Annual Login"] = v80
local v81 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#24004a\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(160, 100, 255),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 500
    },
    ["ID"] = 107
}
v1["Quincent Login"] = v81
local v82 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#003a2d\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(0, 255, 170),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 730
    },
    ["ID"] = 108
}
v1["Two-Year Login"] = v82
local v83 = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#000000\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["Obtain"] = {
        ["ConsecutiveLogins"] = 1000
    },
    ["ID"] = 109
}
v1["Millennium Login"] = v83
v1.Nightfall = {
    ["Perks"] = {},
    ["StartText"] = "<stroke color=\"#24004a\" joins=\"miter\" thickness=\"2\" transparency=\"0.05\">",
    ["EndText"] = "</stroke>",
    ["RoleColor"] = Color3.fromRGB(0, 0, 0),
    ["ID"] = 110
}
v1["Fruit Fisher"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(102, 178, 255),
    ["ID"] = 111
}
v1["Candy Scout"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 255),
    ["ID"] = 112
}
v1["Candy Champion"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 158, 102),
    ["ID"] = 113
}
v1["Candy King"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 103, 15),
    ["ID"] = 114
}
v1["High Spender"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 255, 127),
    ["ID"] = 115
}
v1["Tailored One"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 214, 133),
    ["ID"] = 116
}
local v84 = {
    ["Perks"] = { "1.10x DMG TO BIG MAMA" },
    ["RoleColor"] = Color3.fromRGB(255, 170, 255),
    ["PerkTags"] = {
        ["NPC"] = "Big Mama",
        ["dmgBoost"] = 1.1
    },
    ["Obtain"] = {
        ["Kills"] = 25,
        ["NPC"] = "Big Mama"
    },
    ["ID"] = 117
}
v1["Mama\'s Favorite"] = v84
v1["Whole Cake Survivor"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 222, 249),
    ["ID"] = 118
}
v1["Mama\'s Scholar"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(203, 246, 255),
    ["ID"] = 119
}
v1["Mama\'s Gardener"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 223, 60),
    ["ID"] = 120
}
v1["Mama\'s Baker"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 194, 125),
    ["ID"] = 121
}
v1["Mama\'s Treasurer"] = {
    ["Perks"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 170, 0),
    ["ID"] = 122
}
local v85 = {
    ["Perks"] = { "1% DMG boost TO NPCs" },
    ["PerkTags"] = {
        ["NPC"] = "All",
        ["dmgBoost"] = 1.01
    },
    ["RoleColor"] = Color3.fromRGB(54, 221, 54),
    ["StartText"] = "<stroke color=\"#c41e3a\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["ID"] = 123
}
v1["Holly Jolly"] = v85
v1["Unlimited Tailor"] = {
    ["Perks"] = { "Free unlimited tailoring while subscribed" },
    ["PerkTags"] = {},
    ["RoleColor"] = Color3.fromRGB(255, 214, 133),
    ["StartText"] = "<stroke color=\"#8B6914\" joins=\"miter\" thickness=\"1.5\" transparency=\"0.25\">",
    ["EndText"] = "</stroke>",
    ["ID"] = 124
}
return v1