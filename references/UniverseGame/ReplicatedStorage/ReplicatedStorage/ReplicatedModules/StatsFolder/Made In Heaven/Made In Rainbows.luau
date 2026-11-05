  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Made In Heaven"
    },
    Stats = {
        Pose = {
            Callbacks = {
                Transformer = function(p1) -- Line: 13, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if not Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "StandOffPoseMusic";

                        return v2;
                    end;

                    v2.PoseMusic = "StandOnPoseMusic";
                    v2.StartAnim = "StandPoseTransition";
                    v2.LoopAnim = "StandPoseIdle";

                    return v2;
                end
            }
        }
    },
    Sounds = {
        StandOffPoseMusic = {
            SoundId = 14945353523,
            Volume = 2,
            Looped = true,
            PlaybackSpeed = 1,
            TimePosition = 0,
            SoundEffects = {}
        },
        StandOnPoseMusic = {
            SoundId = 18494186529,
            Volume = 2,
            Looped = true,
            PlaybackSpeed = 1,
            TimePosition = 0,
            SoundEffects = {}
        }
    }
};