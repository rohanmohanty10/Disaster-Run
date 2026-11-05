  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "Dawn"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 13, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if math.random(1, 2) == 2 then
                        v2.PoseMusic = "PoseMusic";

                        return v2;
                    end;

                    v2.PoseMusic = "Radiance";

                    return v2;
                end
            }
        }
    },
    Sounds = {
        Radiance = {
            SoundId = 14113097219,
            Volume = 2.5
        },
        PoseMusic = {
            SoundId = 139917146317494,
            Volume = 2,
            Looped = true,
            PlaybackSpeed = 1.53
        }
    }
};