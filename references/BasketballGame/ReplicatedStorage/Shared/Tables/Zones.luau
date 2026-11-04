 
 

local v1 = {
    Zones = {
        Sprinter = {
            Name = "Sprinter",
            Desc = "Slightly Faster speed while running with and without ball.",
            Rarity = "Rare"
        },
        Lockdown = {
            Name = "Lockdown",
            Desc = "Shortened STEAL cooldown and increased defense speed.",
            Rarity = "Epic"
        },
        Quickdraw = {
            Name = "Quickdraw",
            UIName = "Quick Draw",
            Desc = "Release shots faster, ball reaches destination faster, aim assist slightly improved",
            Rarity = "Legendary"
        },
        Limitless = {
            Name = "Limitless",
            Desc = "Greatly improved aim assist, shots from further distance.",
            Rarity = "Legendary"
        },
        Hustle = {
            Name = "Hustle",
            Desc = "Faster movement speed when the ball is loose!",
            Rarity = "Rare"
        },
        Dime = {
            Name = "Dime",
            Desc = "Team-mates gain speed boost for a few seconds when you pass to them!",
            Rarity = "Epic"
        },
        Posterizer = {
            Name = "Posterizer",
            Desc = "Stops ANY block WHILE DUNKING and gives you a speed boost in the 2 point area.",
            Rarity = "Mythic"
        },
        StreetDribbler = {
            Name = "StreetDribbler",
            UIName = "Street Dribbler",
            Desc = "Gives you an extra dribble and makes you faster with the ball.",
            Rarity = "Mythic"
        },
        ["777"] = {
            Name = "777",
            Desc = "One of 3 boosts will be granted on activation! MAY LUCK BE ON YOUR SIDE",
            Rarity = "Mythic"
        },
        SpeedDribble = {
            Name = "SpeedDribble",
            UIName = "Speed Dribble",
            Desc = "You\'re faster while dribbling!",
            Rarity = "Legendary"
        },
        Unbreakable = {
            Name = "Unbreakable",
            Desc = "You won\'t get ankle broken from a failed steal and you\'re immune to unblockable dunks!",
            Rarity = "Mythic"
        },
        Perfectionist = {
            Name = "Perfectionist",
            Desc = "Extra dribble, speed increased and range buffed. Truly perfect.",
            Rarity = "PERFECT"
        },
        Animalistic = {
            Name = "Animalistic",
            Desc = "Increased jump height, faster speed and longer blocking window.",
            Rarity = "Mythic"
        },
        RealBasketball = {
            Name = "RealBasketball",
            UIName = "Real Basketball",
            Desc = "Unblockable dunks, increased shooting range and faster speed, show them what real basketball is.",
            Rarity = "Basketball God"
        },
        EmperorVision = {
            Name = "EmperorVision",
            UIName = "Emperor Vision",
            Desc = "25% chance nearby opponents miss shots, whole teams dribbling speed is increased, extra dribble, impossible to be ankle broken.",
            Rarity = "Miracle"
        },
        GoldVision = {
            Name = "GoldVision",
            UIName = "Gold Vision",
            Desc = "Increased dribble speed, extra dribble, increased pass speed.",
            Rarity = "Miracle"
        },
        CHAOS = {
            Name = "CHAOS",
            Desc = "Increased speed with the ball, increased shooting speed and 10% less cooldown on abilities.",
            Rarity = "Current."
        },
        PAINT = {
            Name = "PAINT",
            Desc = "Gain speed boost for a few seconds from paint puddles, increased speed without the ball, 25% chance of stunning someone for 5 seconds on ankle break, can\'t get ankle broken.",
            Rarity = "Current."
        },
        PRESIDENT = {
            Name = "PRESIDENT",
            Desc = "Whole teams shooting speed is increased and increase their zone by 20%.",
            Rarity = "4th of July"
        },
        Ordinary = {
            Name = "Ordinary",
            Desc = "Abilities have 15% less cooldown, extra dribble and faster run speed off ball.",
            Rarity = "PSYCHIC"
        },
        Shock = {
            Name = "Shock",
            Desc = "Reduces Psycho Bar 1% every second, extra dribble, incrased shooting range and shooting assist.",
            Rarity = "CYBER"
        },
        Rubber = {
            Name = "Rubber",
            Desc = "Can\'t be ankle broken and ankle breaks close enemy player when you ankle break someone.",
            Rarity = "Retired"
        },
        Senses = {
            Name = "Senses",
            Desc = "Faster movement speed overall, faster shooting speed and extra dribble.",
            Rarity = "SPIDER VS SYMBIOTE"
        },
        Darkness = {
            Name = "Darkness",
            Desc = "Faster with ball, increased dunk range and extra dribble.",
            Rarity = "SPIDER VS SYMBIOTE"
        },
        Vampiric = {
            Name = "Vampiric",
            Desc = "Immune to ankle breaks, steal drains the opponent, shorter cooldown on Time Stop Abilities (For Vampire and Scary Monster).",
            Rarity = "VAMPIRE"
        },
        Technical = {
            Name = "Technical",
            Desc = "33.3% Chance to disable an opponent\'s ability for 5 seconds when they attempt to use it, increased speed when defending and 10% less cooldown on abilities.",
            Rarity = "Retired"
        },
        Oldschool = {
            Name = "Oldschool",
            Desc = "Ankle breaks last longer, increased shooting range and 2 extra dribbles, but slower with ball.",
            Rarity = "Miracle"
        },
        HAHA = {
            Name = "HAHA",
            Desc = "Extra pumpfake, 25% longer cooldown for opponents in range, increased jump height and increased dunk range.",
            Rarity = "JOKER"
        },
        Spooky = {
            Name = "Spooky",
            Desc = "Unblockable dunks, immune to ankle breaks and increased pass speed.",
            Rarity = "GHOST"
        },
        Monster = {
            Name = "Monster",
            Desc = "Immune to unblockable dunks, increased block range and increased dunk range.",
            Rarity = "Miracle"
        },
        Melodical = {
            Name = "Melodical",
            Desc = "Unblockable dunks and ankle breaks close enemy player when you ankle break someone.",
            Rarity = "POPSTAR"
        },
        Majestic = {
            Name = "Majestic",
            Desc = "Immune to unblockable dunks, increased block range and significantly increased passing speed.",
            Rarity = "KING VS AIR"
        },
        Flight = {
            Name = "Flight",
            Desc = "Your shots are extra hard to block when jumping backwards, immune to ankle breaks and significantly increased dunk range.",
            Rarity = "KING VS AIR"
        },
        Samurai = {
            Name = "Samurai",
            Desc = "Significantly inreased dribble speed, but you lose a dribble.",
            Rarity = "Retired"
        },
        ["Luka \"Magic\""] = {
            Name = "Luka \"Magic\"",
            Desc = "Your dribbles knocks your opponents back, increased dribbling speed and increased shooting range.",
            Rarity = "LUKA DONČIĆ"
        },
        Wildcard = {
            Name = "Wildcard",
            Desc = "A card is drawn on activation! Whether it’s an Ace or a Joker decides the outcome.",
            Rarity = "Retired"
        },
        Control = {
            Name = "Control",
            Desc = "Pumpfakes become stealable, some unblockable passes become blockable, increased dribbling speed after stealing the ball and increased block range.",
            Rarity = "GENIUS"
        },
        InfinityVision = {
            Name = "InfinityVision",
            Desc = "Untouchable, other players cannot make contact, increased dribbling speed and increased shooting speed.",
            Rarity = "HONORED ONE"
        },
        MalevolentVision = {
            Name = "MalevolentVision",
            Desc = "Your enemies starts kneeling when you block them, increased blocking range and reduced cooldown on blocks.",
            Rarity = "CURSE KING"
        },
        Justice = {
            Name = "Justice",
            Desc = "33.3% chance to punish enemy when they ankle break you and 25% longer cooldown for opponents in range.",
            Rarity = "JUDGEMENT"
        },
        Formless = {
            Name = "Formless",
            Desc = "Formless shooting and full aim assist in the 2 point area. The only one who can beat you, is you.",
            Rarity = "Rewards"
        },
        GoldenSpin = {
            Name = "GoldenSpin",
            Desc = "Shooting speed and passing speed increased by the golden ratio on every shot or pass, extra dribble and increased speed without the ball.",
            Rarity = "JOHNNY"
        },
        Chef = {
            Name = "Chef",
            Desc = "10% chance for ball to go in when you would normally miss, increased shooting speed, increased shooting range and slightly improved aim assist.",
            Rarity = "GOAT"
        },
        LoveTrain = {
            Name = "LoveTrain",
            Desc = "Redirects misfortune. Hop back when blocked normally, unblockable dunks and immune to ankle breaks.",
            Rarity = "VALENTINE"
        },
        Shadow = {
            Name = "Shadow",
            Desc = "Shadow dribbles, extra dribble and significantly increased passing speed. Quicker dribbles, but less distance covered. You are a shadow.",
            Rarity = "Rewards"
        },
        CurrentVision = {
            Name = "CurrentVision",
            Desc = "Delay enemy shots, trip a close enemy when dribbling, immune to ankle breaks and immune to unblockable dunks.",
            Rarity = "Rewards"
        },
        Devour = {
            Name = "Devour",
            Desc = "Pillaging of Limited Styles allowed, steal up to 20% from the zone bars of enemies and disrupt their blocking range.",
            Rarity = "Legendary"
        },
        Extraterrestrial = {
            Name = "Extraterrestrial",
            Desc = "Bigger block and steal hitbox, increased jump height and increased shooting range.",
            Rarity = "ALIEN"
        },
        Liberty = {
            Name = "Liberty",
            Desc = "Increased dribbling speed, quicker layups, and when you\'re in the 2 point area, normal shots become floaters and you gain a speed boost.",
            Rarity = "KING OF NYC"
        },
        CRIMSON = {
            Name = "CRIMSON",
            Desc = "Increased speed with ball, increased steal speed and time skip shooting, but you can\'t pumpfake.",
            Rarity = "Current. V2"
        },
        DEATH = {
            Name = "DEATH",
            Desc = "Increased dribbling speed on steal, increased steal speed, increased speed without ball and can\'t get ankle broken.",
            Rarity = "Current. V2"
        },
        Tomoware = {
            Name = "Tomoware",
            Desc = "Stronger dribbles, countering abilities that steal or knocks the ball loose and increased dribbling speed.",
            Rarity = "Mythic"
        },
        Dinosaur = {
            Name = "Dinosaur",
            Desc = "Increased dribbling speed after picking up a loose ball, 10% less cooldown on abilities and the farther away the ball is, the faster you move.",
            Rarity = "SCARY MONSTER"
        },
        Manipulator = {
            Name = "Manipulator",
            Desc = "Whole teams shooting speed is increased, teammates are forced to dunk if they\'re in range when they get the ball from you and opponents are slowed. Always one step ahead.",
            Rarity = "KIRA"
        },
        Evolved = {
            Name = "Evolved",
            Desc = "Extra dribble, speed increased, bigger blocking window and teleports to the ball after blocking. Truly evolved to perfection.",
            Rarity = "PERFECT V2",
            New = true
        },
        Ascendant = {
            Name = "Ascendant",
            Desc = "Accelerated fades while shooting, abilities have 15% less cooldown, increased speed.",
            Rarity = "Rewards"
        },
        Clone = {
            Name = "Clone",
            Desc = "Creates a clone that shoots when you attempt to shoot or pumpfake, increased dribbling speed and increased speed overall.",
            Rarity = "NINJA"
        },
        Scary = {
            Name = "Scary",
            Desc = "You can fade forward, improved aim assist and when an enemy jumps near you, shooting speed is significantly increased. Don\'t get jumpscared! Get it? Haha...",
            Rarity = "Rewards"
        },
        PapayaVision = {
            Name = "PapayaVision",
            Desc = "Papaya Rules.",
            Rarity = "Dev"
        },
        NumberOneSkarpFan = {
            Name = "NumberOneSkarpFan",
            Desc = "Whole teams shooting speed is increased and increase their zone by 50%. Full aim assist, 3 extra dribbles and significantly increased jump height.",
            Rarity = "Dev"
        }
    }
};

if not game:GetService("RunService"):IsStudio() then
    local _ = game.PlaceId == 82710350236919;
end;

v1.DistBuffZones = {
    Limitless = 130,
    RealBasketball = 125,
    Perfectionist = 125,
    Shock = 125,
    Oldschool = 125,
    ["Luka \"Magic\""] = 125,
    Chef = 125,
    Extraterrestrial = 125
};
v1.DunkDistBuffZones = {
    Darkness = 0.3,
    HAHA = 0.3,
    Monster = 0.3,
    Flight = 0.6
};
v1.StealDistBuffZones = {
    Extraterrestrial = 0.6
};
v1.BlockDistBuffZones = {
    Monster = 0.3,
    Control = 0.3,
    MalevolentVision = 0.3,
    Extraterrestrial = 0.2,
    PapayaVision = 0.3
};
v1.BlockDistDebuffZones = {
    Devour = 0.15
};
v1.JumpScareZones = {
    Scary = {
        ShootingSpeed = 0.3,
        CantBlock = 0.25,
        Range = 25,
        Duration = 2.5,
        RetriggerWindow = 0.5
    }
};
v1.AssistBuffZones = {
    Quickdraw = 30,
    Limitless = 35,
    Shock = 30,
    Chef = 15,
    Scary = 30
};
v1.ZoneDribbles = {
    StreetDribbler = 4,
    Perfectionist = 4,
    EmperorVision = 4,
    GoldVision = 4,
    Senses = 4,
    Darkness = 4,
    ["777"] = 5,
    Ordinary = 4,
    Shock = 4,
    Oldschool = 5,
    Samurai = 2,
    GoldenSpin = 4,
    Shadow = 4,
    Evolved = 4,
    NumberOneSkarpFan = 6
};
v1.ZoneDribblingSpeed = {
    SpeedDribble = 0.35,
    GoldVision = 0.25,
    Samurai = 0.6,
    ["Luka \"Magic\""] = 0.15,
    InfinityVision = 0.25,
    Liberty = 0.15,
    Tomoware = 0.35,
    Clone = 0.25
};
v1.ZoneDribblingSpeedOnSteal = {
    Control = 0.35,
    DEATH = 0.35,
    PapayaVision = 0.35
};
v1.ZoneDribblingSpeedOnPickupLooseBall = {
    Dinosaur = 0.35
};
v1.ZoneDribblingDuration = {
    Shadow = 0.275
};
v1.ZonePumpFakes = {
    HAHA = 2
};
v1.BlockWindow = {
    Animalistic = { 2, 0.2 },
    Evolved = { 1, 1 }
};
v1.JumpHeight = {
    Animalistic = 12,
    HAHA = 12,
    Extraterrestrial = 12,
    NumberOneSkarpFan = 24
};
v1.JumpSpeed = {
    MalevolentVision = 1.2
};
v1.StealCooldowns = {
    Lockdown = 1.8
};
v1.AbilityCooldown = {
    CHAOS = 0.9,
    Ordinary = 0.85,
    Technical = 0.9,
    Dinosaur = 0.9,
    Ascendant = 0.85
};
v1.ZoneIncrease = {
    PRESIDENT = 20,
    NumberOneSkarpFan = 50
};
v1.ZoneDecrease = {
    Devour = 20
};
v1.ShootIncrease = {
    PRESIDENT = true,
    Manipulator = true,
    NumberOneSkarpFan = true
};
v1.ShootDecrease = {
    CurrentVision = true
};
v1.DribbleIncrease = {
    EmperorVision = true
};
v1.NoColorChange = { "Posterizer", "Dime", "777", "GoldVision", "CHAOS", "PRESIDENT", "Rubber", "Darkness", "Senses", "HAHA", "Melodical", "Majestic", "Flight", "Chef", "Extraterrestrial", "NumberOneSkarpFan" };
v1.ZoneSpeedBoosts = {
    Sprinter = { 0, 0, 2.25, 2.25, 0 },
    Hustle = { 0, 0, 0, 0, 0, 4 },
    Posterizer = { 0, 0, 0, 0, 0, 0, 3 },
    StreetDribbler = { 0, 3.5, 0, 3.5, 0 },
    Lockdown = { 0, 0, 0, 0, 2.25 },
    Perfectionist = { 2, 2, 2, 2 },
    Animalistic = { 2.25, 2.25, 2.25, 2.25 },
    RealBasketball = { 3, 3, 3, 3 },
    CHAOS = { 0, 3, 0, 3 },
    PAINT = { 3, 0, 3, 0 },
    Ordinary = { 2.5, 0, 2.5, 0 },
    Senses = { 2.5, 2.5, 2.5, 2.5 },
    Darkness = { 0, 0, 0, 3.25 },
    Technical = { 0, 0, 0, 0, 3 },
    Oldschool = { 0, -3, 0, -3 },
    GoldenSpin = { 3, 0, 3, 0 },
    Liberty = { 0, 0, 0, 0, 0, 0, 3 },
    CRIMSON = { 0, 3, 0, 3 },
    DEATH = { 3, 0, 3, 0 },
    Evolved = { 2, 2, 2, 2 },
    Ascendant = { 4, 4, 4, 4 },
    Ninja = { 2.5, 2.5, 2.5, 2.5 }
};
v1.ZoneIncreasedShootingSpeed = {
    Senses = 0.2,
    Quickdraw = 0.2,
    CHAOS = 0.2,
    InfinityVision = 0.2,
    Chef = 0.2
};
v1.ZoneIncreasedPassingSpeed = {
    GoldVision = 0.5,
    Spooky = 0.5,
    Majestic = 0.5,
    Shadow = 0.5
};
v1.ZoneIncreasedLayupSpeed = {
    Liberty = 0.5
};
v1.ZoneIncreasedFadingSpeed = {
    Ascendant = 0.8
};
v1.ZoneIncreasedStealingSpeed = {
    CRIMSON = 0.5,
    DEATH = 0.5
};
v1.ZoneCantBeAnkleBroken = {
    Unbreakable = true,
    EmperorVision = true,
    PAINT = true,
    Rubber = true,
    Vampiric = true,
    Spooky = true,
    Flight = true,
    LoveTrain = true,
    CurrentVision = true,
    DEATH = true
};
v1.ZoneDunksCantBeBlocked = {
    Posterizer = true,
    RealBasketball = true,
    Spooky = true,
    Melodical = true,
    LoveTrain = true
};
v1.ZoneIgnoreDunksCantBeBlocked = {
    Unbreakable = true,
    Monster = true,
    Majestic = true,
    CurrentVision = true
};
v1.ZoneIgnorePumpfakes = {
    Control = true,
    PapayaVision = true
};
v1.ZoneStrongerDribbles = {
    Tomoware = true
};

return v1;