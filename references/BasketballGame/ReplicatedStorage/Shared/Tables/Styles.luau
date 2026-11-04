 
 

local v1 = {
    Styles = {
        Sniper = {
            Name = "Sniper",
            Desc = "A master of precision, dominate the court with your signature full-court three-pointers.",
            Rarity = "Legendary"
        },
        Phantom = {
            Name = "Phantom",
            Desc = "The Invisible Playmaker, control the game with your off-ball movement, passing, and dribbling ability.",
            Rarity = "Epic"
        },
        Clutch = {
            Name = "Clutch",
            Desc = "A reliable all-rounder with a clutch shooter’s mentality, and decent defense.",
            Rarity = "Rare"
        },
        Star = {
            Name = "Star",
            Desc = "An explosive athlete with unmatched leaping ability, soar past defenders and throw down thunderous dunks.",
            Rarity = "Legendary"
        },
        Ace = {
            Name = "Ace",
            Desc = "A relentless offensive force, a unpredictable, streetball-inspired style makes you nearly impossible to guard one-on-one. No one stands a chance against you.",
            Rarity = "Mythic",
            AwakeningOutfitDelay = 5.4
        },
        Giant = {
            Name = "Giant",
            Desc = "Unleashing raw power on the court, he’s a relentless force known for explosive dunks. Fueled by an unyielding drive, he’ll stop at nothing to lead his team to victory, leaving a trail of defeat in his wake.",
            Rarity = "Mythic"
        },
        Flash = {
            Name = "Flash",
            Desc = "Moving like a bolt of lightning, his dribbles leaving defenders in the dust. With unmatched speed and agility, he’s the spark that ignites his team’s fast-paced offense, being always one step ahead.",
            Rarity = "Legendary"
        },
        Playmaker = {
            Name = "Playmaker",
            Desc = "Playmaker is a confident and playful strategist, known for outsmarting opponents and uplifting teammates. His competitive spirit keeps everyone on their toes.",
            Rarity = "Epic"
        },
        Jackpot = {
            Name = "Jackpot",
            Desc = "LADY LUCK BE ON MY SIDE",
            Rarity = "Mythic"
        },
        Chuck = {
            Name = "Chuck",
            Desc = "The egoist that misses 50% of their shots",
            Rarity = "Rare"
        },
        Lock = {
            Name = "Lock",
            Desc = "FIRST DEFENSE BASED STYLE WOWOWO",
            Rarity = "Legendary",
            NoBallAwakening = true
        },
        Copycat = {
            Name = "Copycat",
            Desc = "The only one who has a chance against anyone.",
            Rarity = "Mythic"
        },
        Perfection = {
            Name = "Perfection",
            UIName = "Perfection V1",
            Desc = "You\'re either perfect or you\'re not me.",
            Rarity = "PERFECT",
            AwakeningOutfitDelay = 5.6
        },
        Emperor = {
            Name = "Emperor",
            Desc = "The absolute king anywhere and everywhere. Bow down and stay down..",
            Rarity = "Miracle"
        },
        BasketballGod = {
            Name = "BasketballGod",
            UIName = "Basketball God",
            Desc = "He\'s here to teach everyone what real basketball is.",
            Rarity = "Basketball God",
            NoBallAwakening = true
        },
        Quick = {
            Name = "Quick",
            Desc = "I AM SPEEEEEEEEEEEEEEEEEEEEEEEEED",
            Rarity = "Rare",
            NoBallAwakening = true
        },
        Fetch = {
            Name = "Fetch",
            Desc = "The one and only you were looking for, catches every ball, gives his everything. He is..HIM.",
            Rarity = "Epic"
        },
        Gold = {
            Name = "Gold",
            Desc = "You thought you\'re good? Hah, funny kid aren\'t ya? Now sit down and watch me win.",
            Rarity = "Miracle"
        },
        Tatlis = {
            Name = "Tatlis",
            UIName = "Tatlis V1",
            Desc = "The Co-Creator of Basketball: Zero",
            Rarity = "Current.",
            NoBallAwakening = true
        },
        Chrollo = {
            Name = "Chrollo",
            UIName = "Chrollo V1",
            Desc = "The Creator of Basketball: Zero",
            Rarity = "Current.",
            NoBallAwakening = true
        },
        LazyWorker = {
            Name = "LazyWorker",
            UIName = "Lazy Worker",
            Desc = "I\'LL BE IN THE NEXT GAME..I PROMISE!",
            Rarity = "Retired",
            AwakeningOutfitDelay = 6.35
        },
        UncleSam = {
            Name = "UncleSam",
            UIName = "Uncle Sam",
            Desc = "WE NEED YOU IN THE GAME!",
            Rarity = "4th of July",
            NoBallAwakening = true
        },
        Switcher = {
            Name = "Switcher",
            UIName = "Switcher",
            Desc = "Only you and I — we are the only exceptions, my brother.",
            Rarity = "Retired",
            NoBallAwakening = true
        },
        Cyber = {
            Name = "Cyber",
            UIName = "Cyber",
            Desc = "There are no happy endings in basketball, but i\'ll make sure you have one.",
            Rarity = "CYBER",
            NoBallAwakening = true,
            AwakeningOutfitDelay = 17.667
        },
        OGCyber = {
            Name = "OGCyber",
            UIName = "OG Cyber",
            Desc = "There are no happy endings in basketball, but i\'ll make sure you have one.",
            Rarity = "Retired",
            NoBallAwakening = true,
            AwakeningOutfitDelay = 17.667
        },
        Psychic = {
            Name = "Psychic",
            Desc = "i just live an ordinary life",
            Rarity = "PSYCHIC"
        },
        Rubberman = {
            Name = "Rubberman",
            Desc = "THE DRUMS OF BASKETBALL.. I CAN HEAR THEM!",
            Rarity = "Retired",
            BaseMoveCount = 3
        },
        Spider = {
            Name = "Spider",
            Desc = "I\'ll save everyone in here, including that monster.",
            Rarity = "SPIDER VS SYMBIOTE"
        },
        Symbiote = {
            Name = "Symbiote",
            Desc = "You wanted to save me? There is no one left to save, we\'re one.",
            Rarity = "SPIDER VS SYMBIOTE",
            NoBallAwakening = true
        },
        Vampire = {
            Name = "Vampire",
            UIName = "Vampire",
            Desc = "Your only desire is to achieve peace but i? I want BASKETBALL GAME.",
            Rarity = "VAMPIRE",
            NoBallAwakening = true
        },
        Referee = {
            Name = "Referee",
            Desc = "I don\'t just play the game... I control it.",
            Rarity = "Retired",
            NoBallAwakening = true
        },
        BasketballUnc = {
            Name = "BasketballUnc",
            UIName = "Basketball Unc",
            Desc = "Been running this court longer than you\'ve been dribbling.",
            Rarity = "Miracle"
        },
        Joker = {
            Name = "Joker",
            Desc = "One laugh, one shot, one big boom.",
            Rarity = "JOKER",
            AwakeningOutfitDelay = 5
        },
        Ghost = {
            Name = "Ghost",
            Desc = "Spooky.",
            Rarity = "GHOST",
            NoBallAwakening = true
        },
        Silver = {
            Name = "Silver",
            Desc = "A beast that towers above all. Power and reach beyond human limits.",
            Rarity = "Miracle",
            NoBallAwakening = true
        },
        Popstar = {
            Name = "Popstar",
            Desc = "I\'m the number one player in the world. So make sure to treat me like that, got it?",
            Rarity = "POPSTAR",
            NoBallAwakening = true
        },
        King = {
            Name = "King",
            Desc = "Greatness isn\'t handed to you. You earn it, and the kingdom follows.",
            Rarity = "KING VS AIR",
            AwakeningOutfitDelay = 6.167
        },
        Air = {
            Name = "Air",
            Desc = "Unstoppable in flight. Above the rim and beyond limits!",
            Rarity = "KING VS AIR",
            AwakeningOutfitDelay = 10.567
        },
        Eclipse = {
            Name = "Eclipse",
            Desc = "Embrace without fear, and you shall never truly oof.",
            Rarity = "Retired",
            NoBallAwakening = true
        },
        LukaDoncic = {
            Name = "LukaDoncic",
            UIName = "Luka Dončić",
            Desc = "The One and Only Luka Donćíć.",
            Rarity = "LUKA DONČIĆ"
        },
        Dealer = {
            Name = "Dealer",
            Desc = "The deal isn\'t over yet. Cards stay hidden... until the game is worth playing.",
            Rarity = "Retired"
        },
        Genius = {
            Name = "Genius",
            Desc = "Every move predicted before it starts, every option shut down with flawless precision.",
            Rarity = "GENIUS",
            NoBallAwakening = true
        },
        HonoredOne = {
            Name = "HonoredOne",
            UIName = "Honored One",
            Desc = "Nah, I\'d win.",
            Rarity = "HONORED ONE",
            NoBallAwakening = true
        },
        CurseKing = {
            Name = "CurseKing",
            UIName = "Curse King",
            Desc = "Know your place.",
            Rarity = "CURSE KING"
        },
        Judgement = {
            Name = "Judgement",
            Desc = "Even if I\'m the only one, I want to keep my eyes open.",
            Rarity = "JUDGEMENT",
            NoBallAwakening = true
        },
        Johnny = {
            Name = "Johnny",
            Desc = "It\'s truly been a roundabout path... Thank you... BASKETBALL GAME.",
            Rarity = "JOHNNY"
        },
        Goat = {
            Name = "Goat",
            Desc = "An assassin with unmatched range and quick release, constantly creating space and breaking defenses.",
            Rarity = "GOAT"
        },
        Valentine = {
            Name = "Valentine",
            Desc = "My heart and actions are utterly unclouded. They are all those for BASKETBALL GAME.",
            Rarity = "VALENTINE"
        },
        Thief = {
            Name = "Thief",
            Desc = "The one who leaves opponents with nothing. Why copy greatness when you can steal it?",
            Rarity = "Legendary"
        },
        Alien = {
            Name = "Alien",
            Desc = "Born to reach the cosmos, not the dust.",
            Rarity = "ALIEN",
            NoBallAwakening = true
        },
        KingOfNYC = {
            Name = "KingOfNYC",
            UIName = "King Of NYC",
            Desc = "The cosmos has its aliens, but New York has its King.",
            Rarity = "KING OF NYC"
        },
        ChrolloV2 = {
            Name = "ChrolloV2",
            UIName = "Chrollo V2",
            Desc = "The Creator of Basketball: Zero",
            Rarity = "Current. V2",
            NoBallAwakening = true,
            AwakeningOutfitDelay = 17.4
        },
        TatlisV2 = {
            Name = "TatlisV2",
            UIName = "Tatlis V2",
            Desc = "The Co-Creator of Basketball: Zero",
            Rarity = "Current. V2",
            NoBallAwakening = true
        },
        Izure = {
            Name = "Izure",
            Desc = "A speedster with dribbling beyond comparison, leaving nothing but afterimages behind.",
            Rarity = "Mythic"
        },
        ScaryMonster = {
            Name = "ScaryMonster",
            UIName = "Scary Monster",
            Desc = "Not a vampire, but a cold-blooded competitor who sees everyone else as prey and victory as his birthright.",
            Rarity = "SCARY MONSTER",
            NoBallAwakening = true
        },
        Kira = {
            Name = "Kira",
            Desc = "I\'ll take a potato chip... and eat it!",
            Rarity = "KIRA"
        },
        PerfectionV2 = {
            Name = "PerfectionV2",
            UIName = "Perfection V2",
            Desc = "Allow me to show you what perfection truly looks like.",
            Rarity = "PERFECT V2",
            NoBallAwakening = true,
            New = true
        },
        Ninja = {
            Name = "Ninja",
            UIName = "Ninja",
            Desc = "With a thousand clones, this court is mine! Dattebayo!",
            Rarity = "NINJA",
            NoBallAwakening = true
        },
        AMG = {
            Name = "AMG",
            UIName = "AMG",
            Desc = "Still I Rise.",
            Rarity = "Dev",
            NoBallAwakening = true
        },
        Skarp = {
            Name = "Skarp",
            UIName = "Skarp",
            Desc = "You\'re not supposed to have this.",
            Rarity = "Dev",
            AwakeningOutfitDelay = 5.4
        }
    },
    Setting = {
        Sniper = "Shooter",
        Phantom = "Slasher",
        Clutch = "Shooter",
        Star = "Slasher",
        Ace = "Slasher",
        Giant = "Slasher",
        Flash = "Slasher",
        Playmaker = "Shooter",
        Jackpot = "Shooter",
        Chuck = "Shooter",
        Lock = "Slasher",
        Copycat = "Slasher",
        Perfection = "Shooter",
        Emperor = "Shooter",
        BasketballGod = "Slasher",
        Quick = "Slasher",
        Fetch = "Slasher",
        Gold = "Slasher",
        Tatlis = "Slasher",
        Chrollo = "Slasher",
        LazyWorker = "Shooter",
        UncleSam = "Shooter",
        Switcher = "Shooter",
        Cyber = "Slasher",
        OGCyber = "Slasher",
        Psychic = "Shooter",
        Rubberman = "Slasher",
        Spider = "Shooter",
        Symbiote = "Shooter",
        Vampire = "Slasher",
        Referee = "Slasher",
        BasketballUnc = "Shooter",
        Joker = "Shooter",
        Ghost = "Slasher",
        Silver = "Slasher",
        Popstar = "Slasher",
        King = "Slasher",
        Air = "Slasher",
        Eclipse = "Slasher",
        LukaDoncic = "Shooter",
        Dealer = "Shooter",
        Genius = "Slasher",
        HonoredOne = "Shooter",
        CurseKing = "Shooter",
        Judgement = "Slasher",
        Johnny = "Shooter",
        Goat = "Shooter",
        Valentine = "Slasher",
        Thief = "Slasher",
        Alien = "Shooter",
        KingOfNYC = "Shooter",
        ChrolloV2 = "Slasher",
        TatlisV2 = "Slasher",
        Izure = "Shooter",
        ScaryMonster = "Slasher",
        Kira = "Slasher",
        PerfectionV2 = "Shooter",
        Ninja = "Slasher",
        AMG = "Slasher",
        Skarp = "Slasher"
    },
    Colors = {
        Sniper = Color3.new(0.407843, 1, 0.27451),
        Phantom = Color3.new(0.447059, 0.658824, 1),
        Clutch = Color3.new(0.803922, 0.854902, 1),
        Star = Color3.new(1, 0.2, 0.2),
        Ace = Color3.new(0.137255, 0.196078, 1),
        Giant = Color3.new(0.901961, 0.168627, 1),
        Flash = Color3.new(1, 0.960784, 0.431373),
        Playmaker = Color3.new(1, 0.466667, 0.360784),
        Jackpot = Color3.new(0.309804, 1, 0.258824),
        Chuck = Color3.new(0.521569, 0.992157, 1),
        Lock = Color3.new(0.431373, 0.101961, 1),
        Copycat = Color3.new(1, 0.870588, 0.564706),
        Perfection = Color3.new(0.286275, 1, 0.286275),
        Emperor = Color3.new(1, 0.180392, 0.180392),
        BasketballGod = Color3.new(1, 0.862745, 0.584314),
        Quick = Color3.new(0.705882, 0.862745, 1),
        Fetch = Color3.new(0.929412, 0.921569, 1),
        Gold = Color3.new(1, 0.878431, 0.576471),
        Tatlis = Color3.new(0.172549, 0.0745098, 0.658824),
        Chrollo = Color3.new(0, 0, 0),
        LazyWorker = Color3.fromRGB(107, 198, 255),
        UncleSam = Color3.new(0.290196, 0.537255, 1),
        Switcher = Color3.new(0, 0.5, 1),
        Cyber = Color3.new(0.466667, 1, 0.776471),
        OGCyber = Color3.new(0.466667, 1, 0.776471),
        Psychic = Color3.new(0.937255, 0.223529, 1),
        Rubberman = Color3.new(1, 1, 1),
        Spider = Color3.new(1, 0, 0),
        Symbiote = Color3.new(0, 0, 0),
        Vampire = Color3.new(1, 0, 0),
        Referee = Color3.new(0.607843, 0.607843, 0.607843),
        BasketballUnc = Color3.new(1, 0.764706, 0),
        Joker = Color3.new(0.607843, 0, 1),
        Ghost = Color3.new(0.113725, 1, 0.541176),
        Silver = Color3.new(0.184314, 1, 0.454902),
        Popstar = Color3.new(0.803922, 0.705882, 1),
        King = Color3.new(1, 0.803922, 0),
        Air = Color3.new(1, 0, 0.215686),
        Eclipse = Color3.new(0.470588, 0, 0),
        LukaDoncic = Color3.new(1, 0.941176, 0.121569),
        Dealer = Color3.new(0.713725, 0.258824, 1),
        Genius = Color3.new(0.521569, 1, 0.388235),
        HonoredOne = Color3.new(0.270588, 0.690196, 0.823529),
        CurseKing = Color3.new(1, 0, 0.0980392),
        Judgement = Color3.new(1, 0.666667, 0.376471),
        Johnny = Color3.new(0.709804, 0.905882, 1),
        Goat = Color3.new(1, 0.803922, 0.262745),
        Valentine = Color3.new(1, 0.607843, 0.772549),
        Thief = Color3.new(0.14902, 0.482353, 1),
        Alien = Color3.new(0.439216, 1, 0.196078),
        KingOfNYC = Color3.new(1, 0.45098, 0),
        ChrolloV2 = Color3.new(0, 0, 0),
        TatlisV2 = Color3.new(0, 0, 0),
        Izure = Color3.new(0.215686, 0.396078, 1),
        ScaryMonster = Color3.new(0.156863, 0.509804, 1),
        Kira = Color3.new(1, 0.168627, 0.168627),
        PerfectionV2 = Color3.new(0.286275, 1, 0.286275),
        Ninja = Color3.new(1, 0.603922, 0.203922),
        AMG = Color3.new(0, 0.631373, 0.611765),
        Skarp = Color3.new(0, 0, 0)
    },
    OGs = { "Cyber" },
    Removed = { "FormerGreatest", "VampireV2" }
};

if not game:GetService("RunService"):IsStudio() then
    local _ = game.PlaceId == 82710350236919;
end;

return v1;