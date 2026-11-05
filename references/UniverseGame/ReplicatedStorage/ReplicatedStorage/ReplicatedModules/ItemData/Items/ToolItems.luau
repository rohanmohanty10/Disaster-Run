  

 

local function CalcMaxPrice(p1, p2) -- Line: 20
    return math.floor(p1 * 1.5);
end;

local v3 = {
    ITEM_1 = {
        Name = "Arrow",
        Description = "This bizarre arrow seems to be imbued with mysterious power.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25,
        Available = false
    },
    ITEM_2 = {
        Name = "DIO\'s Diary",
        Description = "A terrifying artifact, detailing a madman\'s plan to \"Obtain Heaven\".",
        Type = "Item",
        BlackMarketBasePrice = 200,
        Rarity = 3
    },
    ITEM_3 = {
        Name = "DIO\'s Bone",
        Description = "A bone fragment that emanates a terrifying aura.",
        Type = "Item",
        BlackMarketBasePrice = 200,
        Rarity = 3
    },
    ITEM_4 = {
        Name = "Corrupted Soul",
        Description = "Contains remnants of an evil power",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_5 = {
        Name = "Corrupted Arrow",
        Description = "A heavenly arrow now infected. An uneasy feeling occurs from wielding this.",
        Type = "Item",
        BlackMarketBasePrice = 7500,
        Rarity = 5,
        Available = false,
        UPoints = 1000
    },
    ITEM_6 = {
        Name = "Demonic Scroll",
        Description = "",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_7 = {
        Name = "Fragment of Death",
        Description = "",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_8 = {
        Name = "Heavenly Nectar",
        Description = "",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        UPoints = 500
    },
    ITEM_9 = {
        Name = "Godly Doctor\'s Poison",
        Description = "",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false,
        UPoints = 1000
    },
    ITEM_10 = {
        Name = "Sovereign\'s Chapter",
        Description = "",
        Type = "Item",
        Rarity = 7,
        Available = false
    },
    ITEM_11 = {
        Name = "A New Fable",
        Description = "",
        Type = "Item",
        Rarity = 7,
        Available = false
    },
    ITEM_12 = {
        Name = "Sovereign\'s Sword",
        Description = "",
        Type = "Item",
        Rarity = 7,
        Available = false
    },
    ITEM_15 = {
        Name = "Cursed Orb",
        Description = "This accursed object seems to have manifested within our reality... do you accept it\'s dark gift?",
        Type = "Item",
        Rarity = 7,
        BlackMarketBasePrice = 40000
    },
    ITEM_16 = {
        Name = "Heart of the Saint",
        Description = "The Heart of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_17 = {
        Name = "Saints Arms",
        Description = "The Arms of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_18 = {
        Name = "Saints Eyes",
        Description = "The Eyes of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_20 = {
        Name = "Cosmic Fragments",
        Description = "The stars are watching",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_22 = {
        Name = "Evil Fragments",
        Description = "",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200,
        Available = true
    },
    ITEM_23 = {
        Name = "Tales Of The Universe",
        Description = "Tales of an ancient universe, within this tome lies many of it\'s secrets.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_24 = {
        Name = "Watch",
        Description = "A mysterious watch that has the bizarre ability of stopping the flow of time itself.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_25 = {
        Name = "Bone",
        Description = "A bone with a blue aura. Seems like it will give you a bad time.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_26 = {
        Name = "Yo-Yo",
        Description = "Is it a mere toy..? Or could it possess much greater potential?",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25,
        Available = false
    },
    ITEM_27 = {
        Name = "Pumpkin",
        Description = "Celebrate Halloween with this spooky item!",
        Type = "Item",
        Rarity = 6,
        BlackMarketBasePrice = 1200,
        Crates = {}
    },
    ITEM_29 = {
        Name = "Saints Skull",
        Description = "The Skull of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false
    },
    ITEM_30 = {
        Name = "Shaper\'s Essence",
        Description = "A smooth, crystalline stone. You can feel its rythm and energy by merely holding it.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true,
        Tradeable = true
    },
    ITEM_35 = {
        Name = "Dragon Ball",
        Description = "GRAAAAAAAAHHHHHHHHHH!",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_36 = {
        Name = "Mysterious Hat",
        Description = "I feel like I have seen this hat somewhere...",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_37 = {
        Name = "Bat",
        Description = "A superficial, plastic looking bat. Seems like it came straight out of a bullet hell rogue-like.",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100
    },
    ITEM_39 = {
        Name = "Requiem Arrow",
        Description = "A beetle is inscribed on this arrow, and the shaft is broken off... Could it possess an even greater gift?",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_41 = {
        Name = "Azakana Mask",
        Description = "An ancient relic belonging to The Unforgotten. Emits malevolent energy.",
        Type = "Item",
        BlackMarketBasePrice = 1500,
        Rarity = 4,
        Available = true
    },
    ITEM_42 = {
        Name = "Ancient Sword",
        Description = "An ancient relic belonging to The Unforgiven, wielder of air itself.",
        Type = "Item",
        BlackMarketBasePrice = 1500,
        Rarity = 4,
        Available = true,
        UPoints = 200
    },
    ITEM_46 = {
        Name = "Saints Legs",
        Description = "The Legs of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_47 = {
        Name = "Saints Ribcage",
        Description = "The Ribcage of the Saint, preserved after his death.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_51 = {
        Name = "Saint\'s Corpse",
        Description = "The Corpse of the Saint, preserved and re-assembled after his death. ",
        Type = "Item",
        BlackMarketBasePrice = 7500,
        Rarity = 5,
        Available = false
    },
    ITEM_52 = {
        Name = "Sword",
        Description = "A nostalgic relic of the old times. A remnant of The Heights.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_53 = {
        Name = "Paintball Gun",
        Description = "A nostalgic relic of the old times. A superficial paintball gun.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_54 = {
        Name = "Bomb",
        Description = "A nostalgic relic of the old times. Kwha-BOOOM!",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_55 = {
        Name = "Trowel",
        Description = "A nostalgic relic of the old times. A superficial building tool.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_56 = {
        Name = "Ban Hammer",
        Description = "A nostalgic relic of the old times. An extraordinary hammer.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_57 = {
        Name = "Slingshot",
        Description = "A nostalgic relic of the old times. A superficial slingshot.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_58 = {
        Name = "Rocket Launcher",
        Description = "A nostalgic relic of the old times. A superficial rocket launcher.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_59 = {
        Name = "Superball",
        Description = "A nostalgic relic of the old times. Feels bouncy.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_60 = {
        Name = "Frog",
        Description = "An ordinary yet bizarre looking frog. I wonder if anyone could use it to demonstrate something.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_61 = {
        Name = "Hamon Imbued Frog",
        Description = "The trainer said I can use this to signal him to meet me for our fight.",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 5
    },
    ITEM_62 = {
        Name = "Letter to Jonathan",
        Description = "Zeppeli gave me this referral to go speak to a man named Jonathan...",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 2
    },
    ITEM_63 = {
        Name = "Letter to Joseph",
        Description = "Speedwagon gave me this referral to go speak to a man named Joseph...",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 2
    },
    ITEM_64 = {
        Name = "Jonathan\'s Signal",
        Description = "This item was given to me to summon Jonathan.. What does he mean to summon him?",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 4,
        Crates = {}
    },
    ITEM_65 = {
        Name = "Jonathan\'s Worn Out Gloves",
        Description = "Jonathan\'s worn out gloves. I got them after he forgot them after our battle. I should return these to him.",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 4,
        Crates = {}
    },
    ITEM_66 = {
        Name = "Bait Vampire Mask",
        Description = "Jonathan told me to use this to lure Dio Brando.",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 5,
        Crates = {}
    },
    ITEM_67 = {
        Name = "Rundown Mask",
        Description = "The vampire mask took a beating during our battle. I should return this to Jonathan.",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 5,
        Crates = {}
    },
    ITEM_68 = {
        Name = "Caesar\'s Headband",
        Description = "The headband of a master of the ripples best friend.",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100
    },
    ITEM_69 = {
        Name = "Aja Stone",
        Description = "This is a strange mysterious red gem.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200
    },
    ITEM_70 = {
        Name = "Clackers",
        Description = "I think someone could use these in a battle.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 25
    },
    ITEM_71 = {
        Name = "Joseph\'s Signal",
        Description = "This item was given to me to summon Joseph.. What does he mean to summon him?",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 4,
        Crates = {}
    },
    ITEM_72 = {
        Name = "Worn Out Scarf",
        Description = "I picked this scarf up after the battle of Joseph Joestar.. I should probably return it to him.",
        Type = "Item",
        Tradeable = false,
        Available = false,
        Rarity = 4,
        Crates = {}
    },
    ITEM_73 = {
        Name = "Stone Mask",
        Description = "This mask seems a bit odd...",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_74 = {
        Name = "Dio\'s Charm",
        Description = "A charm with an ounce of energy once possessed by late Dio Brando.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200
    },
    ITEM_75 = {
        Name = "Dio\'s Remains",
        Description = "A bag containing Dio Brando\'s remains, which can be placed at the boss spawner to resurrect him, however, resurrecting him is risky and whoever does it must be careful about that.",
        Type = "Item",
        Rarity = 3,
        Available = false,
        BlackMarketBasePrice = 0
    },
    ITEM_76 = {
        Name = "Heart",
        Description = "It fills you with DETERMINATION.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_77 = {
        Name = "Gojo\'s Blindfold",
        Description = "The blindfold of a once-in-a-thousand-years sorcerer.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_78 = {
        Name = "Sukuna\'s Finger",
        Description = "A powerful cursed object, said to have once been attached to the four-armed \"king of curses\" Ryoumen Sukuna.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_79 = {
        Name = "Mysterious Fragment",
        Description = "Strange artifact of unknown origin. Time seems to dilate in it\'s proximity...",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_80 = {
        Name = "Tactical Vest",
        Description = "A device adorned upon the chest for protection against ballistic projectiles. Who needed this for protection...?",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_81 = {
        Name = "Arm Band",
        Description = "A cloth wrap worn \'round the arm to signify allegience. Must have been dropped by some kind of gang member.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_82 = {
        Name = "Used Arrow",
        Description = "An arrow that echoes a sentiment of a dried up well of potential. It seems as though it contains no energy whatsoever.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_83 = {
        Name = "Sorcerer\'s Scarf",
        Description = "Red scarf typical of a \'jujutsu sorcerer\' studying at the overseas \'jujutsu high\'.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_84 = {
        Name = "Ope Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 7,
        BlackMarketBasePrice = 40000,
        Available = false,
        SpawnSound = 17300403909
    },
    ITEM_85 = {
        Name = "Mero Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false,
        SpawnSound = 17300403909
    },
    ITEM_86 = {
        Name = "Suna Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false,
        SpawnSound = 17300403909
    },
    ITEM_87 = {
        Name = "Law\'s Cap",
        Description = "A sleek black and white cap worn by the greatest surgeon of all time.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_88 = {
        Name = "Knight\'s Blade",
        Description = "A mysterious blade, once wielded by a fierce knight.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_89 = {
        Name = "Kuma\'s Book",
        Description = "The religious book of a Tyrant",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200
    },
    ITEM_90 = {
        Name = "Green Baby",
        Description = "A mysterious baby, known to be formed by DIO.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_91 = {
        Name = "Blood of Joseph",
        Description = "The blood of a fallen hamon legend.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_92 = {
        Name = "Bouquet Of Flowers",
        Description = "Smells nice",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false
    },
    ITEM_93 = {
        Name = "Claw Fragment",
        Description = "A fragment that seems to make up a larger part of a weapon.",
        Type = "Item",
        Rarity = 3,
        Available = false
    },
    ITEM_94 = {
        Name = "Sanji\'s Cookbook",
        Description = "NEVER COOK AGAIN😲😲😲😲😲😲😲😲😲😲",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true
    },
    ITEM_95 = {
        Name = "Baroque Works Contractor Den Den",
        Description = "The communication device between the Baroque Works organization",
        Type = "Item",
        Rarity = 5,
        Available = false
    },
    ITEM_96 = {
        Name = "Joestar Blood Vial",
        Description = "A vial which contains the blood of a young Joestar... which may allow the possession of his abilities.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false
    },
    ITEM_97 = {
        Name = "Golden Hook",
        Description = "The weapon of one of the Warlords of the Sea",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_98 = {
        Name = "True Stone Mask",
        Description = "Aw dang it",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_525 = {
        Name = "Phoenix Gemstone",
        Description = "A gemstone, with abilities related to a folklore bird. Known to be a fragment formed using the powers of Dawn.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_526 = {
        Name = "Kinetic Gemstone",
        Description = "A gemstone, with kinetic abilities. Known to be a fragment formed using the powers of Locke.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_527 = {
        Name = "Monochromatic Gemstone",
        Description = "A gemstone, with spectral abilities. Known to be a fragment formed using the powers of Xeno.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 7500
    },
    ITEM_528 = {
        Name = "Soul Gemstone",
        Description = "A gemstone, with abilities related to a soul harvester. Known to be a fragment formed using the powers of Reaper.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_529 = {
        Name = "Draconic Gemstone",
        Description = "A gemstone, with draconic abilities. Known to be a fragment formed using the powers of a mysterious knight who wielded powers equivalent to a dragon.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_530 = {
        Name = "Monochromatic Orb",
        Description = "? ? ?",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        UPoints = 500
    },
    ITEM_531 = {
        Name = "Kinetic Orb",
        Description = "You are a.. 😨",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_532 = {
        Name = "Cursed Gemstone",
        Description = "😨😨😨😨",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 7500
    },
    ITEM_533 = {
        Name = "Bisento",
        Description = "A mighty weapon wielded by Whitebeard.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 7500
    },
    ITEM_534 = {
        Name = "Slime Energy",
        Description = "Use this to wield the legendary powers of Shadow.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        BlackMarketBasePrice = 40000
    },
    ITEM_535 = {
        Name = "Busoshoku Manual",
        Description = "A book which teaches it\'s user about the powers of a haki type.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200
    },
    ITEM_536 = {
        Name = "Haoshoku Manual",
        Description = "A book which teaches it\'s user about the powers of a haki type.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 7500
    },
    ITEM_537 = {
        Name = "Kenbunshoku Manual",
        Description = "A book which teaches it\'s user about the powers of a haki type.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500
    },
    ITEM_538 = {
        Name = "Gomu Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false,
        SpawnSound = 17300403909
    },
    ITEM_539 = {
        Name = "Hito Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 7,
        BlackMarketBasePrice = 40000,
        Available = false
    },
    ITEM_540 = {
        Name = "Haki Shard",
        Description = "A fragment, present in this universe only due to a mishap",
        Type = "Item",
        BlackMarketBasePrice = 1500,
        Rarity = 4
    },
    ITEM_541 = {
        Name = "Limitless Technique Scroll",
        Description = "The Strongest\'s Mastery Item",
        Type = "Item",
        Rarity = 5
    },
    ITEM_542 = {
        Name = "Wheel of Dharma",
        Description = "King of Curses\' Mastery Item (20)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_551 = {
        Name = "King of Curses Shard",
        Description = "Contains remnants of a strong entity",
        Type = "Item",
        Available = false,
        Rarity = 7,
        BlackMarketBasePrice = 7500
    },
    ITEM_552 = {
        Name = "Remembrance of the Fallen",
        Description = "Cursed Energy emits out of this substance.",
        Type = "Item",
        Available = false,
        Rarity = 7,
        BlackMarketBasePrice = 40000
    },
    ITEM_553 = {
        Name = "The Vessel Shard",
        Description = "Contains remnants of a strong entity.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_554 = {
        Name = "Remembrance of the Vessel",
        Description = "Cursed Energy emits out of this substance.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_555 = {
        Name = "Sorcerer Killer Shard",
        Description = "Contains remnants of a strong entity.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_556 = {
        Name = "Remembrance of the Sorcerer Killer",
        Description = "..",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_557 = {
        Name = "Remembrance of the Strongest",
        Description = "Nah I\'d win.",
        Type = "Item",
        Available = false,
        Rarity = 5,
        BlackMarketBasePrice = 7500
    },
    ITEM_543 = {
        Name = "Split Soul Katana",
        Description = "Sorcerer Killer\'s Mastery Item (1)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_544 = {
        Name = "Playful Cloud",
        Description = "Sorcerer Killer\'s Mastery Item (2)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_545 = {
        Name = "Inverted Spear of Heaven",
        Description = "Sorcerer Killer\'s Mastery Item (3)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_546 = {
        Name = "Heavenly Restriction Awakening",
        Description = "Sorcerer Killer\'s Mastery Item (4)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_547 = {
        Name = "Simple Domain Essence",
        Description = "The Vessel\'s Mastery Item (1)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_548 = {
        Name = "Cursed Arm",
        Description = "The Vessel\'s Mastery Item (2)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_549 = {
        Name = "Death Painting",
        Description = "The Vessel\'s Mastery Item (3)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_550 = {
        Name = "Shrine Item",
        Description = "The Vessel\'s Mastery Item (4)",
        Type = "Item",
        Rarity = 5
    },
    ITEM_580 = {
        Name = "Gun Parts",
        Description = "Perhaps these could be repurposed...",
        Type = "Item",
        Rarity = 5
    },
    ITEM_581 = {
        Name = "Chest Key",
        Description = "yooo what?? a key???????",
        Type = "Item",
        Rarity = 4
    },
    ITEM_582 = {
        Name = "Inhumane Spirit",
        Description = "Positive energy is constantly negated by this spirit, be careful of what you say around it.",
        Type = "Item",
        Available = false,
        Rarity = 4
    },
    ITEM_583 = {
        Name = "Cursed Apple",
        Description = "bad energy, once again.",
        Type = "Item",
        Available = false,
        Rarity = 6
    },
    ITEM_600 = {
        Name = "Meat On A Bone",
        Description = "One of the Straw Hat Captain\'s favorite dinners.",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100
    },
    ITEM_601 = {
        Name = "West Blue Juice",
        Description = "Shanks sure loves his beverages.",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100
    },
    ITEM_602 = {
        Name = "Manual of Gryphon\'s Techniques",
        Description = "This book was given by Shanks. Wonder if you can learn a thing or two in here.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_620 = {
        Name = "Candy Bag",
        Description = "A bag filled with sugary goodness!",
        Type = "Candy",
        Rarity = 5,
        Available = false,
        Tradeable = false,
        Store = false
    },
    ITEM_750 = {
        Name = "Altered Steel Ball",
        Description = "An altered steel ball which possesses unique abilities.",
        Type = "Item",
        Rarity = 4,
        Available = true
    },
    ITEM_800 = {
        Name = "Stocking",
        Description = "A stocking that contains jolly, sugary goodness!",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false,
        Store = false
    },
    ITEM_801 = {
        Name = "Candy Cutlass Blade",
        Description = "A fragment of the legendary Candy Cutlass Sword.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false
    },
    ITEM_802 = {
        Name = "Knife",
        Description = "Knife from a secretive Mercenary",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100,
        Tradeable = true
    },
    ITEM_803 = {
        Name = "Flamethrower",
        Description = "Smells like oil",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200,
        Tradeable = true
    },
    ITEM_804 = {
        Name = "Eyelander",
        Description = "Insert Scottish Yelling here",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Tradeable = true
    },
    ITEM_805 = {
        Name = "Grenade Launcher",
        Description = "Smells like fire and metal and other stuff, it smells bad",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200,
        Tradeable = true
    },
    ITEM_806 = {
        Name = "Medic\'s Equipment",
        Description = "German science is the best in the world!",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Tradeable = true
    },
    ITEM_807 = {
        Name = "Chargin\' Targe",
        Description = "YAAGHHHH",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200,
        Tradeable = true
    },
    ITEM_808 = {
        Name = "Vampirism Mastery",
        Description = "A book containing details to evolve your vampirism ability to another similar to Dio Brando.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_809 = {
        Name = "Coal",
        Description = "A stone used for cooking and melting.",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 100,
        Available = false
    },
    ITEM_810 = {
        Name = "Metal Scraps",
        Description = "Some scraps of metal which were once used for different things that have now been thrown away.",
        Type = "Item",
        Rarity = 1,
        BlackMarketBasePrice = 100
    },
    ITEM_811 = {
        Name = "Metal Ingot",
        Description = "An ingot formed out of metal, used for making things.",
        Type = "Item",
        Rarity = 3,
        Available = false,
        BlackMarketBasePrice = 200
    },
    ITEM_812 = {
        Name = "Light of Hope",
        Description = "A magical light, which signifies hope.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_813 = {
        Name = "Nanotech Fragments",
        Description = "Fragments which use nanotechnology to bind objects with each other, it\'s some weird stuff I have no clue tbh...",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_814 = {
        Name = "Anshen\'s Chestplate",
        Description = "A piece of armor which is identical to one which Anshen wears.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_815 = {
        Name = "Anshen\'s Helmet",
        Description = "A piece of armor which, identical to one which Anshen wears.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_816 = {
        Name = "Anshen\'s Wing Set",
        Description = "A set of two wings which are similar to ones that Anshen has.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_817 = {
        Name = "Anshen\'s Arm Plates",
        Description = "A piece of armor which, identical to one which Anshen wears.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_818 = {
        Name = "Anshen\'s Leg Plates",
        Description = "A piece of armor which, identical to one which Anshen wears.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_819 = {
        Name = "Anshen\'s Lance",
        Description = "A lance identical to one that Anshen uses.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_820 = {
        Name = "Anshen\'s Suit",
        Description = "A suit that mimics Anshen\'s suit, powered by magical energy & nanotechnology.",
        Type = "Item",
        BlackMarketBasePrice = 7500,
        Rarity = 5,
        Available = false
    },
    ITEM_821 = {
        Name = "Metal Loot",
        Description = "A chest filled with metal scraps.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 200
    },
    ITEM_822 = {
        Name = "Coal Loot",
        Description = "A chest filled with a bunch of coal.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 1500
    },
    ITEM_828 = {
        Name = "Locacaca",
        Description = "A mysterious fruit.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_829 = {
        Name = "Spin Energy Fragment",
        Description = "???",
        Type = "Item",
        Rarity = 4,
        Available = true,
        BlackMarketBasePrice = 1500
    },
    ITEM_830 = {
        Name = "Whitebeard\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_831 = {
        Name = "Shanks\' Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_832 = {
        Name = "Kars\' Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_833 = {
        Name = "Umbra\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_834 = {
        Name = "Mahoraga\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_835 = {
        Name = "Shadow\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_836 = {
        Name = "The Denzien Of Hell\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_837 = {
        Name = "Sukuna\'s Calamity Force",
        Description = "???",
        Type = "Item",
        Rarity = 5,
        Available = false,
        BlackMarketBasePrice = 1500
    },
    ITEM_838 = {
        Name = "The Total Force Of Calamity",
        Description = "???",
        Type = "Item",
        Rarity = 7,
        Available = false,
        BlackMarketBasePrice = 40000
    },
    ITEM_839 = {
        Name = "Dragon Slayer",
        Description = "An extremely heavy greatsword.",
        Type = "Item",
        Rarity = 4,
        UPoints = 2000,
        Available = false,
        Tradeable = false
    },
    ITEM_860 = {
        Name = "Mysterious Dagger",
        Description = "This dagger looks oddly familiar. Though, has a distinct aura to it.",
        Type = "Item",
        Rarity = 4,
        UPoints = 500,
        Available = true,
        Tradeable = true
    },
    ITEM_861 = {
        Name = "Demonfire Dagger",
        Description = "This dagger now radiates a distinct aura that screams madness.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_862 = {
        Name = "Scroll of Fist Reversal",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 3,
        UPoints = 850,
        Available = false,
        Tradeable = false
    },
    ITEM_863 = {
        Name = "Scroll of the Remembrance",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 3,
        UPoints = 850,
        Available = false,
        Tradeable = false
    },
    ITEM_864 = {
        Name = "Scroll of the Resurgence",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 3,
        UPoints = 850,
        Available = false,
        Tradeable = false
    },
    ITEM_865 = {
        Name = "Scroll of Essence of Sumo Slap",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 4,
        UPoints = 1200,
        Available = false,
        Tradeable = false
    },
    ITEM_866 = {
        Name = "Scroll of Dragon of Dojima \'88",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 4,
        UPoints = 1200,
        Available = false,
        Tradeable = false
    },
    ITEM_867 = {
        Name = "Scroll of Tiger Drop",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 4,
        UPoints = 1200,
        Available = false,
        Tradeable = false
    },
    ITEM_868 = {
        Name = "Scroll of The Dragon",
        Description = "This scroll awakens the dragon.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_869 = {
        Name = "Scroll of Triple Rush Attack Finisher",
        Description = "Earn this from one of Komaki\'s pupils.",
        Type = "Item",
        Rarity = 4,
        UPoints = 1200,
        Available = false,
        Tradeable = false
    },
    ITEM_900 = {
        Name = "Keycard",
        Description = "A biometrically encrypted keycard, bound to your genetic signature, granting exclusive access to the lab.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        Tradeable = false
    },
    ITEM_904 = {
        Name = "Mining Laser",
        Description = "A high-precision mining tool that uses concentrated energy beams to swiftly and cleanly penetrate even the hardest of materials. May require user-driven recalibration on some materials.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_905 = {
        Name = "Mining Laser MK2",
        Description = "An upgraded version of the standard Mining Laser, allowing for higher energy output and better yield.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_908 = {
        Name = "Camellite Fragment",
        Description = "A small fragment taken from a mysterious meteorite. It\'s damaged and resonates with a rhythm...",
        Type = "Item",
        Rarity = 4,
        Available = false,
        Tradeable = true
    },
    ITEM_909 = {
        Name = "Camellite",
        Description = "A chunk of a mineral acquried through breaking Camellite deposits. It\'s in good condition and resonates with a stronger rhythm...",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_910 = {
        Name = "Refined Camellite",
        Description = "A chunk of Camellite that has been mechanically purified, ridding it of almost all imperfections.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_911 = {
        Name = "Crystalline Core",
        Description = "This chunk of minerals was extracted from a formidable golem. It resonates a rhythm akin to Camellite, yet it feels much more powerful. It would be a good idea to show this to Analytics.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_912 = {
        Name = "Catalyst",
        Description = "This apparatus, which is also partially integrated in the tethering protocol, is capable of storing and outputting incredible amounts of energy. However, exposing it to too much energy may cause unforeseen consequences.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_913 = {
        Name = "Calibrated Manifold",
        Description = "Constructed from Camellite Fragments and scavenged metals, this manifold channels rhythmic energy for use in stable wormhole activation.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_914 = {
        Name = "Geode",
        Description = "A dense mineral formation with a crystalline interior. Formed under extreme conditions near Camellite veins, its inner structure pulses faintly with rhythmic energy. Perhaps Analytics can make use of it.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = true
    },
    ITEM_915 = {
        Name = "Fractured Sigil",
        Description = "A sigil bearing the mark of the \'DELTA\'. Strangely enough, it seems to retain its enigmatic energy, even after being disconnected from its host. Holding it feels strange, as if there was a force trying to enter your mind.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        Tradeable = true
    },
    ITEM_916 = {
        Name = "Dormant Dagger",
        Description = "An old ceremonial blade, its once-luminous edge now dulled to lifeless granite-like material. Perhaps it could be reactivated.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_917 = {
        Name = "Dormant Staff",
        Description = "A strange staff, seemingly devoid of its former energy. The sigil has dulled, but its construction hints at a purpose not yet lost. Perhaps it could be reawakened.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_918 = {
        Name = "Harmonic Decoder",
        Description = "A compact device engineered to detect and interpret anomalous signatures found on the Fractured Island. The exact function is unknown, but whatever resides on the Fractured Island wants you to have it.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_919 = {
        Name = "STAR SEED",
        Description = "COMPLETE THE CONVERGENCE.",
        Type = "Item",
        Rarity = 12,
        Available = false,
        Tradeable = false
    },
    ITEM_925 = {
        Name = "Cosmic Remnant",
        Description = "Found on the Fractured Island, these mysterious energy-dense objects make for ideal power supplies in technologies.",
        Type = "Item",
        Rarity = 4,
        Available = false,
        Tradeable = true
    },
    ITEM_922 = {
        Name = "SHAPER // SWORD",
        Description = "Holds a manifestation that can shape the world!",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_920 = {
        Name = "Camellite Arrow",
        Description = "An ordinary Stand Arrow transformed by the synchronized energy of Camellite and Crystalline Cores. Its presence pulses through you, resonating with untapped potential.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_921 = {
        Name = "NUCLEAR-CORE",
        Description = "Unknown object left behind by your predecessor, Seems to resonate with Made in Heaven specifically.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_924 = {
        Name = "Cultist Staff",
        Description = "The dormant staff, reawakened with the same energy that connected it to the cultists. Holding it slowly makes your mind go numb. Will you submit to this higher force?",
        Type = "Item",
        Rarity = 2,
        Available = false,
        Tradeable = false
    },
    ITEM_923 = {
        Name = "Cultist Dagger",
        Description = "The blade now pulses with the same rhythm that once guided its wielders, slowly making your mind become dark. Will you submit to this higher force?",
        Type = "Item",
        Rarity = 2,
        Available = false,
        Tradeable = false
    },
    ITEM_930 = {
        Name = "Strange Briefcase",
        Description = "A mysterious briefcase requested by someone in the Lab.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false,
        Store = false
    },
    ITEM_931 = {
        Name = "Yuta\'s Katana",
        Description = "A sword that once belonged to the Cursed Child.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = true
    },
    ITEM_932 = {
        Name = "Talking Sign",
        Description = "Hi @Boat",
        Type = "Item",
        Rarity = 8,
        Available = false,
        Tradeable = false
    },
    ITEM_933 = {
        Name = "Ancient Alloy",
        Description = "An alloy with ancient origins uncovered by the experts at The Khronos Labs. A wonder of The Fractured Island, greatly enhancing whatever it comes in contact with.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_934 = {
        Name = "Lifeblood Extractor",
        Description = "An impressive technological breakthrough made possible by the bright minds at The Khronos Labs. Allows the extraction of DNA structure from mighty beings.",
        Type = "Item",
        Rarity = 5,
        Available = false
    },
    ITEM_935 = {
        Name = "Dio Brando\'s Genes",
        Description = "",
        Rarity = 5,
        Type = "Item",
        Available = false,
        Tradeable = false
    },
    ITEM_936 = {
        Name = "Kars\' Genes",
        Description = "",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_937 = {
        Name = "The Sovereign\'s Genes",
        Description = "",
        Rarity = 5,
        Type = "Item",
        Available = false,
        Tradeable = false
    },
    ITEM_938 = {
        Name = "Mahoraga\'s Genes",
        Description = "",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_939 = {
        Name = "Perfected Aja Stone",
        Description = "A perfected version of the Aja Stone.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_940 = {
        Name = "Ultimate Stone Mask",
        Description = "The ultimate stone mask, can be used to evolve Kars.",
        Type = "Item",
        Rarity = 7,
        Available = false,
        Tradeable = false
    },
    ITEM_941 = {
        Name = "Perfected Aja Mask",
        Description = "A perfected version of the stone mask, with the aja stone embedded into it.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_942 = {
        Name = "Perfected Stone Mask",
        Description = "A perfected version of the stone mask.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_943 = {
        Name = "Unbound Blood Vial",
        Description = "...",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_944 = {
        Name = "Blood Concoction",
        Description = "...",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_945 = {
        Name = "Lifeblood Extractor (Full)",
        Description = "A Lifeblood Extractor, filled up with almighty DNA",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_946 = {
        Name = "Speed Force Fragment",
        Description = "...",
        Type = "Item",
        Rarity = 2,
        BlackMarketBasePrice = 250,
        Available = false,
        Tradeable = os.time() >= DateTime.fromUniversalTime(2025, 10, 4).UnixTimestamp
    },
    ITEM_947 = {
        Name = "Speed Force Shard",
        Description = "...",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 500,
        Available = false,
        Tradeable = os.time() >= DateTime.fromUniversalTime(2025, 10, 4).UnixTimestamp
    },
    ITEM_948 = {
        Name = "Speed Force Conduit",
        Description = "...",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false,
        Tradeable = os.time() >= DateTime.fromUniversalTime(2025, 10, 4).UnixTimestamp
    },
    ITEM_949 = {
        Name = "Speed Force Nexus",
        Description = "...",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = false,
        Tradeable = os.time() >= DateTime.fromUniversalTime(2025, 10, 4).UnixTimestamp
    },
    ITEM_950 = {
        Name = "Holy Resolve",
        Description = "Use it to evolve Tusk ACT: 2 further.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = false
    },
    ITEM_951 = {
        Name = "Spiritual Pressure Ticket",
        Description = "Use it to gain spiritual pressure levels",
        Type = "Item",
        Rarity = 4,
        Available = false,
        Tradeable = false,
        UPoints = 1000
    },
    ITEM_952 = {
        Name = "Hogyoku Resonance",
        Description = "Use it on Aizen for obtaining Hogyoku!",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true,
        UPoints = 500
    },
    ITEM_953 = {
        Name = "Tenshintai",
        Description = "Use it on Ichigo Kurosaki with ascension 5 to obtain Bankai!",
        Type = "Item",
        UPoints = 1000,
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_954 = {
        Name = "Compound V",
        Description = "Use it to obtain UGrain!",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_1000 = {
        Name = "Yhwach Blood",
        Description = "",
        Type = "Item",
        Rarity = 5,
        Available = false,
        UPoints = 500
    },
    ITEM_1001 = {
        Name = "Enya\'s Arrow",
        Description = "???",
        Type = "Item",
        Rarity = 3,
        Available = false,
        BlackMarketBasePrice = 500,
        UPoints = 250
    },
    ITEM_1002 = {
        Name = "Pochita",
        Description = "Looks oddly like a dog, but it has a chainsaw blade and handle attached to it. My beloved.",
        Type = "Item",
        Rarity = 5,
        Available = false,
        Tradeable = true
    },
    ITEM_1003 = {
        Name = "Hie Devil Fruit",
        Description = "Within the depths of the shadowed seas, whispers abound of this accursed fruit...will you dare to accept its wonderous gift?",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false,
        SpawnSound = 17300403909
    },
    ITEM_1004 = {
        Name = "Rokushiki Manual",
        Description = "Use this item to learn the Rokushiki technique.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = false
    },
    ITEM_1005 = {
        Name = "Techniques Of The Ashura",
        Description = "Use this item to learn the techniques of the Ashura.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true
    },
    ITEM_500 = {
        Name = "Slayer Blade",
        Description = "Use this item to unlock slayer abilities.",
        Type = "Item",
        Rarity = 3,
        BlackMarketBasePrice = 500,
        Available = true
    },
    ITEM_501 = {
        Name = "Water Blade",
        Description = "Use this item to unlock water breathing abilities.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true
    },
    ITEM_502 = {
        Name = "Thunder Blade",
        Description = "Use this item to unlock thunder breathing abilities.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true
    },
    ITEM_503 = {
        Name = "Insect Blade",
        Description = "Use this item to unlock insect breathing abilities.",
        Type = "Item",
        Rarity = 4,
        BlackMarketBasePrice = 1500,
        Available = true
    },
    ITEM_504 = {
        Name = "Moon Blade",
        Description = "Use this item to unlock moon breathing abilities.",
        Type = "Item",
        Rarity = 5,
        BlackMarketBasePrice = 7500,
        Available = true
    }
};
local v4 = { 100, 250, 500, 1500, 7500, 15000, 40000 };

for _, v in v3 do
    if v.Tradeable ~= false then
        local v5 = v4[v.Rarity] or 100;

        if not v.BlackMarketBasePrice then
            v.BlackMarketBasePrice = v5;
        end;

        if not v.BlackMarketMaxPrice then
            local _ = v.Rarity;
            v.BlackMarketMaxPrice = math.floor(v.BlackMarketBasePrice * 1.5);
        end;
    end;
end;

return v3;