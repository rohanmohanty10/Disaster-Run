  

 

local UnixTimestamp = DateTime.fromUniversalTime(2025, 1, 15).UnixTimestamp;
local v1 = {
    MOUNT_1 = {
        Name = "Bike",
        Rarity = 1,
        Description = "Fast and reliable!",
        Tradeable = false
    },
    MOUNT_2 = {
        Name = "Celestial Starboard",
        UPoints = 1750,
        Rarity = 5,
        Description = "Carried by a lunar being.",
        QuestObtainable = true
    },
    MOUNT_3 = {
        Name = "Hoverboard",
        Rarity = 1,
        Description = "State of the art technology!",
        Tradeable = false
    },
    MOUNT_4 = {
        Name = "Noobie",
        Available = false,
        Rarity = 9,
        Description = "Noobie Mount",
        Tradeable = false
    },
    MOUNT_5 = {
        Name = "Supercar",
        Available = false,
        Rarity = 9,
        Description = "Supercar Mount",
        Tradeable = false
    },
    MOUNT_6 = {
        Name = "Echoes Egg",
        UPoints = 2000,
        Rarity = 5,
        Description = "It\'s a joke. It\'s only a little joke.",
        QuestObtainable = true
    },
    MOUNT_7 = {
        Name = "Buggy Kart",
        UPoints = 850,
        Rarity = 3,
        Description = "🤡",
        QuestObtainable = true
    },
    MOUNT_8 = {
        Name = "Alien\'s Pod",
        UPoints = 500,
        Rarity = 3,
        Description = "A device that once served the emperor of the universe..",
        QuestObtainable = true
    },
    MOUNT_9 = {
        Name = "Stand Bike",
        UPoints = 1000,
        Available = true,
        Rarity = 4,
        Description = "Is this really your stand’s power?",
        Tradeable = true
    },
    MOUNT_10 = {
        Name = "Flying Cloud",
        UPoints = 500,
        Rarity = 3,
        Description = "A gift from Master Roshi.",
        QuestObtainable = true
    },
    MOUNT_11 = {
        Name = "Toilet",
        UPoints = 1000,
        Rarity = 3,
        Description = "Skibidi dop dop dop yes yes",
        QuestObtainable = true
    },
    MOUNT_12 = {
        Name = "Kazoo Car",
        UPoints = 1000,
        Rarity = 4,
        Description = "Haven\'t I seen this somewhere before?",
        QuestObtainable = true
    },
    MOUNT_13 = {
        Name = "Witch Broom",
        UPoints = 750,
        Rarity = 3,
        Description = "For the truly wicked..",
        QuestObtainable = true
    },
    MOUNT_14 = {
        Name = "Aokiji\'s Bike",
        UPoints = 500,
        Rarity = 3,
        Description = "Wielded by an admiral of the sea, the elements of ice prolong!",
        QuestObtainable = true
    },
    MOUNT_15 = {
        Name = "Batbike",
        UPoints = 2500,
        Rarity = 7,
        Description = "Perfect for bringing along a sidekick!"
    },
    MOUNT_16 = {
        Name = "Zenith",
        UPoints = 1250,
        Rarity = 5,
        Description = "FOR THE DELTA"
    },
    MOUNT_17 = {
        Name = "Musashi\'s Jetski",
        UPoints = 1750,
        Rarity = 5,
        Description = "Vroom vroom!"
    },
    MOUNT_18 = {
        Name = "Hell Cycle",
        Rarity = 5,
        UPoints = 1500,
        Description = "A stunt motorcycle, fueled by the hellfire of the Spirit of Vengeance."
    },
    MOUNT_19 = {
        Name = "Karoo",
        Rarity = 5,
        UPoints = 1500,
        Description = "Leader of the seven super spotted bill crew."
    },
    MOUNT_20 = {
        Name = "Subway Board",
        Rarity = 4,
        UPoints = 1000,
        QuestObtainable = true,
        Description = "Gotta make it to the subway!"
    },
    MOUNT_21 = {
        Name = "Xeno Genesis 1-X",
        Rarity = 7,
        UPoints = 2000,
        QuestObtainable = false,
        Description = "With its energy, it could accelerate beyond eons.\n\nModel and VFX done by Falunyx"
    },
    MOUNT_22 = {
        Name = "The Log",
        Rarity = 3,
        UPoints = 800,
        QuestObtainable = true,
        Description = "Pick it up and let it go! Log\'s gonna make them heads roll! IT\'S BIG... 🗣️🔥🔥\n\nModelled by itz_gaf"
    },
    MOUNT_23 = {
        Name = "Umbrella Palm Tree",
        Rarity = 3,
        UPoints = 800,
        QuestObtainable = true,
        Description = "Drop tilted"
    },
    MOUNT_24 = {
        Name = "Silver Umbrella",
        Rarity = 3,
        Description = "I just got a golden scar!"
    },
    MOUNT_25 = {
        Name = "Beach Umbrella",
        Rarity = 4,
        UPoints = 1000,
        QuestObtainable = true,
        Description = "Where we dropping boys?"
    },
    MOUNT_26 = {
        Name = "Minecart",
        Rarity = 4,
        UPoints = 1000,
        QuestObtainable = false,
        Description = "I found diamonds!"
    },
    MOUNT_27 = {
        Name = "Silver Board",
        Rarity = 3,
        UPoints = 800,
        QuestObtainable = true,
        Description = "Once wielded by the man who roamed the cosmos..."
    },
    MOUNT_28 = {
        Name = "Angry Bullet",
        Rarity = 5,
        UPoints = 1600,
        QuestObtainable = false,
        Description = "Artillery crafted out of the finest materials within a Kingdom known for its Mushrooms"
    },
    MOUNT_29 = {
        Name = "Patty Wagon",
        Rarity = 5,
        UPoints = 1600,
        QuestObtainable = true,
        Description = "You don\'t need a license to drive a sandwich"
    },
    MOUNT_30 = {
        Name = "Mini Merry",
        Rarity = 5,
        UPoints = 1600,
        QuestObtainable = true,
        Description = "To answer your question, Brook, Franky modeled this after the Going Merry"
    },
    MOUNT_31 = {
        Name = "Asta\'s Demon Slayer",
        Rarity = 4,
        UPoints = 1000,
        QuestObtainable = true,
        Description = "Anti-magic extends from the edges of this relic, summoned out of an open grimoire"
    },
    MOUNT_32 = {
        Name = "Striker",
        Rarity = 5,
        UPoints = 1500,
        QuestObtainable = true,
        Description = "Powered by the Mera Devil Fruit"
    },
    MOUNT_33 = {
        Name = "Pig",
        Rarity = 5,
        UPoints = 1600,
        QuestObtainable = false,
        Description = "I like porkchops"
    },
    MOUNT_34 = {
        Name = "Pizza Moped",
        Rarity = 4,
        UPoints = 1000,
        QuestObtainable = true,
        Description = "Pizza Time"
    },
    MOUNT_35 = {
        Name = "Billower Bike",
        Rarity = 3,
        UPoints = 800,
        QuestObtainable = true,
        Description = "Vehicle of Marine G-5\'s commander"
    },
    MOUNT_36 = {
        Name = "Batpod",
        Rarity = 4,
        UPoints = 1200,
        QuestObtainable = false,
        Description = "\"Self destruct sequence initiated. Goodbye.\""
    },
    MOUNT_37 = {
        Name = "Tesseract",
        Rarity = 7,
        UPoints = 2850,
        Available = true,
        Tradeable = true,
        QuestObtainable = false,
        Description = "Ever wanted to move around in a 4-dimensional polyhedron projected into 3-dimensional space rendered on your 2-dimensional screen? Well, now you can."
    },
    MOUNT_38 = {
        Name = "Friend Mount",
        Rarity = 5,
        UPoints = 1500,
        QuestObtainable = false,
        Description = "Savour through the lands of UG with the assistance of your friend!"
    },
    MOUNT_39 = {
        Name = "Hitsugibune",
        Rarity = 4,
        UPoints = 1100,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "This small craft was used to sail the unforgiving seas of the Grand Line."
    },
    MOUNT_40 = {
        Name = "Oppressor MKII",
        Rarity = 5,
        UPoints = 2000,
        QuestObtainable = false,
        Available = true,
        Tradeable = true,
        Description = "The Oppressor MKI was a landmark in hybrid vehicle design. Well, the MKII takes off where its little brother landed - and it never comes down. This is about the closest you can get to throwing a saddle on a rocket engine."
    },
    MOUNT_41 = {
        Name = "UG Kart",
        Rarity = 5,
        UPoints = 1200,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "Welcome to UG Karting!"
    },
    MOUNT_42 = {
        Name = "Totality Wolf",
        Rarity = 5,
        UPoints = 2350,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "Who\'s the best boy"
    },
    MOUNT_43 = {
        Name = "Pluto Bike",
        Rarity = 4,
        UPoints = 1400,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "I SAID GIRL WHY YOU BE CALLIN"
    },
    MOUNT_44 = {
        Name = "Stingray Curse",
        Rarity = 4,
        UPoints = 1100,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "Curse used by Suguru Geto for transportation."
    },
    MOUNT_45 = {
        Name = "Nue",
        Rarity = 5,
        UPoints = 1500,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "A winged shikigami of the Ten Shadows Technique."
    },
    MOUNT_46 = {
        Name = "C90",
        UPoints = 850,
        Rarity = 3,
        Tradeable = true,
        Available = true,
        Description = "SUPER CUB 90 BABYYY!"
    },
    MOUNT_47 = {
        Name = "Silver Bullet",
        UPoints = 850,
        Rarity = 3,
        Tradeable = true,
        Available = true,
        Description = "A horse once used by Diego Brando."
    },
    MOUNT_48 = {
        Name = "Valkyrie",
        UPoints = 850,
        Rarity = 3,
        Tradeable = true,
        Available = true,
        Description = "A horse once used by Gyro Zeppeli."
    },
    MOUNT_49 = {
        Name = "Slow Dancer",
        UPoints = 1100,
        Rarity = 4,
        Tradeable = true,
        Available = true,
        Description = "A horse once used by Johnny Joestar."
    },
    MOUNT_50 = {
        Name = "Candy Cane",
        UPoints = 1000,
        Rarity = 6,
        Tradeable = true,
        Description = "floating candy cane",
        Available = os.time() <= UnixTimestamp
    },
    MOUNT_51 = {
        Name = "Sleigh",
        UPoints = 1000,
        Rarity = 6,
        Tradeable = true,
        Description = "This is Santa\'s Ride... Although, it seems lack of reindeers.. Or gifts..",
        Available = os.time() <= UnixTimestamp
    },
    MOUNT_52 = {
        Name = "UG Express",
        UPoints = 1200,
        Rarity = 6,
        Tradeable = true,
        Description = "Where we heading!? Why, to the North Pole, of course!",
        Available = os.time() <= UnixTimestamp
    },
    MOUNT_53 = {
        Name = "Fishbone",
        Rarity = 4,
        UPoints = 1400,
        QuestObtainable = true,
        Available = true,
        Tradeable = true,
        Description = "What do you get when you combine a fish with a bone? A bone! Now tell me that wasn\'t fully, hah ahah hahah.."
    },
    MOUNT_54 = {
        Name = "Tralalero",
        Rarity = 5,
        UPoints = 1600,
        Tradeable = true,
        Description = "Tralalero Shark",
        Available = os.time() <= DateTime.fromUniversalTime(2025, 6, 1).UnixTimestamp
    },
    MOUNT_55 = {
        Name = "DELTA Bike",
        UPoints = 2250,
        Rarity = 7,
        Tradeable = true,
        Available = true,
        Description = "this is probably a reference"
    },
    MOUNT_56 = {
        Name = "Khronos Walker",
        UPoints = 3250,
        Rarity = 12,
        Tradeable = true,
        Description = "Prototype bipedal utility mech manufactured by Khronos LLC. Powered by a compact fusion core, featuring a reinforced titanium–ceramic alloy frame with modular limb hardpoints. The cockpit integrates adaptive neural-link controls and redundant life-support systems for optimal pilot safety and responsiveness.",
        Available = os.time() <= DateTime.fromUniversalTime(2025, 8, 13).UnixTimestamp
    },
    MOUNT_57 = {
        Name = "Street Surfer",
        UPoints = 1300,
        Rarity = 4,
        Tradeable = true,
        Description = "The Symbol of the City. Use this to get around the city quickly!"
    },
    MOUNT_58 = {
        Name = "Garou Slide",
        Rarity = 2,
        UPoints = 670,
        Tradeable = true,
        Available = true,
        Description = "Knock it off"
    }
};

if game.GameId == 2913165147 then
    v1.MOUNT_18.UPoints = 0;
    v1.MOUNT_18.Available = true;
    v1.MOUNT_1.UPoints = 0;
    v1.MOUNT_1.Available = true;
end;

return v1;