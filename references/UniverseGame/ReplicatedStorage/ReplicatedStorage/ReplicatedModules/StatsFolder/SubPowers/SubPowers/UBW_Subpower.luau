  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local EnumsModule = require(PathShortcuts.EnumsModule);
local v1 = {
    Moveset = {
        MovesInfo = {
            ["Unlimited Blade Works"] = {
                DefaultKeybind = "5",
                Unlocked = true,
                Description = "Archer"
            }
        }
    },
    Stats = {},
    Animations = {},
    Sounds = {}
};
v1.Stats["Unlimited Blade Works"] = {
    Active = true,
    Damage = 10,
    Actionable = {
        Ragdolled = false,
        Stunned = false,
        Timestopped = false,

        Check = function(p2) -- Line: 38, Name: Check
            return true;
        end
    },
    Cooldown = {
        Time = 60,
        AfterMove = true
    },
    Meter = {
        RequiredAmount = 1,
        RemoveMeter = false
    },
    Stun = {
        Time = 1.25,
        Priority = EnumsModule.Stun.Medium
    },
    Block = {
        Blockable = true,
        PerfectBlockable = false,
        BlockBreak = false
    },
    Hitbox = {
        Size = 11.5
    }
};

return v1;