  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("EffectService");
local TableUtil = require(Knit.Util.TableUtil);

return {
    Inherit = {
        AbilityName = "δ: FOR THE DELTA"
    },
    Stats = {
        Pose = {
            Callbacks = {
                Transformer = function(p1) -- Line: 14, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);
                    print("?");

                    if math.random(1, 3) == 1 then
                        v2.PoseMusic = "PoseMusic2";
                    end;

                    return v2;
                end
            }
        }
    },
    Sounds = {
        PoseMusic2 = {
            SoundId = 120376565195671,
            Volume = 3
        }
    },
    Animations = {
        Action = {
            PoseTransition = 80461285379613,
            PoseIdle = 80827989790821
        }
    }
};