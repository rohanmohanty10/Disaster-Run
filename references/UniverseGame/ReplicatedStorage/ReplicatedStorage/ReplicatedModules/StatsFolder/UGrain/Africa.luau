  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
require(PathShortcuts.EnumsModule);
require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = nil;
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 20
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy), u3 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.StatsFolder["The Mercenaries"]["The Mercenaries"].Common);
end);

return {
    Inherit = {
        AbilityName = "UGrain"
    },
    Stats = {},
    Sounds = {
        PoseMusic = {
            SoundId = 72981678901496,
            Volume = 1,
            PlaybackSpeed = 15.87
        },
        ["Awakening Music 1"] = {
            SoundId = 72981678901496,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 15.87
            }
        },
        ["Awakening Music 2"] = {
            SoundId = 72981678901496,
            Volume = 1,
            Looped = true,
            Attributes = {
                GoalPitch = 15.87
            }
        }
    }
};