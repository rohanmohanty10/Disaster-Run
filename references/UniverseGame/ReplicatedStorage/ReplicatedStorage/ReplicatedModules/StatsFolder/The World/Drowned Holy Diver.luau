  

 

local _ = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "The World"
    },
    Stats = {
        Summon = {
            AuraColor = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(79, 152, 216)), ColorSequenceKeypoint.new(0.6, Color3.fromRGB(56, 120, 138)), ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 87, 90)) })
        }
    }
};