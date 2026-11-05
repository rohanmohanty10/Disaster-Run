  

 

return {
    DefaultMoveState = "Universal",
    Groups = {
        Universal = {
            Visible = true,
            Priority = 3
        },
        SwordBowUniversal = {
            Visible = true,
            Priority = 3
        },
        Sword = {
            Visible = false,
            Priority = 5
        },
        Bow = {
            Visible = true,
            Priority = 6
        },
        ["Vollständig"] = {
            Visible = false,
            Priority = 7
        },
        Passives = {
            Visible = false,
            Priority = 8
        }
    },
    MovesInfo = {
        ["Fern Schuss"] = {
            State = "Passives",
            Description = "Your meter gauge won\'t drain when you’re within a certain range of players/npcs"
        },
        ["Soul Docking"] = {
            State = "Passives",
            Description = "The further you are from a target the more damage the arrows will do"
        },
        ["Schwert Detonieren"] = {
            DefaultKeybind = "T+",
            State = "Sword",
            Equipped = true,
            Description = "All targets marked with the icon hit with the thrown seeles will explode."
        },
        Falle = {
            DefaultKeybind = "T+",
            State = "Bow",
            Equipped = true,
            Description = "Explodes all Seele Schneider that were placed by the user if more than two are placed down then it creates a shape out of them that damages anyone stuck within the beams.",
            IndicatorInfo = {
                Visible = false
            }
        },
        ["Rush Attack"] = {
            DefaultKeybind = "MouseButton1",
            Equipped = true,
            MoveCapCount = false
        },
        Block = {
            DefaultKeybind = "F",
            Equipped = true,
            MoveCapCount = false
        },
        Quickstep = {
            DefaultKeybind = "C",
            Equipped = true,
            MoveCapCount = false
        },
        Grab = {
            DefaultKeybind = "X",
            Equipped = true,
            MoveCapCount = false
        },
        ["Letzt Stil"] = {
            DefaultKeybind = "G",
            Equipped = true,
            State = "SwordBowUniversal",
            Description = "The user jumps in the air and arrows rain down from the sky."
        },
        ["Stance Switch"] = {
            DefaultKeybind = "Q+",
            Equipped = true,
            State = "SwordBowUniversal",
            Description = "Upon pressing this key you toggle between your bow and your sword"
        },
        ["A for Antithesis"] = {
            DefaultKeybind = "Y",
            LevelRequirement = 75,
            Description = "You are able to redirect all status effects applied to you back to the person who dealt them. Note that this only works for some status effects that are supported."
        },
        ["Vollständig"] = {
            DefaultKeybind = "H",
            State = "SwordBowUniversal",
            LevelRequirement = 100,
            Description = "Transform gaining wings and some armor with some new moves and buffs."
        },
        ["Licht Regen"] = {
            DefaultKeybind = "E",
            Equipped = true,
            State = "Bow",
            Description = "Shoot a bunch of arrows forward with some slight randomness that pushes you back."
        },
        ["Licht Hagel"] = {
            DefaultKeybind = "E+",
            State = "Bow",
            LevelRequirement = 50,
            Description = "Shoot an arrow into the sky that will release a flurry of arrows down where it explodes."
        },
        ["Spiritual Pressure"] = {
            DefaultKeybind = "R",
            Equipped = true,
            Description = "Release your reiatsu in a small area around you dealing large damage and stunning anyone near you. Mastery for this move can be obtained through killing people that are using bleach abilities with bleach abilities, spiritual levels 3, 5, 8, and 10 grant buffs to this move."
        },
        ["Quincy Arrow"] = {
            DefaultKeybind = "Q",
            Equipped = true,
            State = "Bow",
            Description = "Shoot an arrow forward, on a successful shot a qte will appear that will teleport you behind the enemy to shoot out an ugotrackable shot."
        },
        Verwerfen = {
            DefaultKeybind = "T",
            Equipped = true,
            State = "Bow",
            Description = "Place down a Seele Schneider on the floor. The most you can place is 5."
        },
        ["Heilig Pfeil"] = {
            DefaultKeybind = "E",
            Equipped = true,
            State = "Sword",
            Description = "Three sword slashes, if there is no one within a certain radius of the user than it shoots out some projecties instead."
        },
        ["Lichtschärpe"] = {
            DefaultKeybind = "R+",
            State = "Sword",
            LevelRequirement = 25,
            Description = "The user dashes forward, if they hit someone 3 times within a certain amount of time then arrows will rain down on the target."
        },
        ["Schwert Werfen"] = {
            DefaultKeybind = "T",
            Equipped = true,
            State = "Sword",
            Description = "he user throws their sword forward and equips a new one, if it hits someone then it will be attached to them and they will be marked with an icon over their head."
        },
        ["Enhanced Heilig Pfeil"] = {
            DefaultKeybind = "E",
            Equipped = true,
            State = "Vollständig",
            Description = "The user charges reishi as areas around the user start exploding that lead behind healing areas for the user and their party."
        },
        ["Composite Heilig Pfeil"] = {
            DefaultKeybind = "R+",
            Equipped = true,
            State = "Vollständig",
            Description = "The user creates some small arrows that get combined into a bigger arrow that is shot forward and creates massive damage."
        },
        Sternenstaub = {
            DefaultKeybind = "T",
            Equipped = true,
            State = "Vollständig",
            Description = "The user summons a bow that shoots out a large beam of reishi."
        },
        Federzwinger = {
            DefaultKeybind = "G",
            Equipped = true,
            State = "Vollständig",
            Description = "The user shoots out an arrow that when makes contaxt creates a hexagonal prison around the target and explodes as it closes in on them."
        },
        Fly = {
            DefaultKeybind = "V",
            Equipped = true,
            State = "Vollständig",
            Description = "User boosts flys using Reishi. Holding down the key will make you fly for longer. Your heat drains as you skate."
        }
    }
};