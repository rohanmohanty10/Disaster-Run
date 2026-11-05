  

 

local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.Independent.TagService);
require(Knit.Util.Trove);
require(Knit.Util.Promise);
require(PathShortcuts.EnumsModule);
game:GetService("CollectionService");
game:GetService("UserInputService");
game.ReplicatedStorage:WaitForChild("Client Assets");
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 21
    -- upvalues: u2 (ref), PathShortcuts (copy), u1 (ref)
    u2 = require(PathShortcuts.ReplicatedModules.AnimationHandler);
    u1 = require(PathShortcuts.AnimsModule);
end);

return {
    Stats = {},
    MoveGroups = {
        SubPowers = {
            Visible = true,
            Priority = 100
        }
    },
    MovesInfo = {
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
        Summon = {
            DefaultKeybind = "Q",
            Equipped = true,
            MoveCapCount = false
        },
        Pose = {
            DefaultKeybind = "P",
            Equipped = true,
            MoveCapCount = false
        }
    }
};