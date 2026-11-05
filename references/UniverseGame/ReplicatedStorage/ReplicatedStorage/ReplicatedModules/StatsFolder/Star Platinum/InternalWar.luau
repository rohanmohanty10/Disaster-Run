  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.OnStart():await();
require(Knit.Util.TableUtil);
local u1 = Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Star Platinum"
    },
    Stats = {
        Summon = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            LeaveParts = { "StandHumanoidRootPart", "FakeHead" }
        },
        ["Star Breaker"] = {
            HitSounds = {
                Hit = {
                    SoundId = 260430117,
                    PlaybackSpeed = 0.95,
                    Volume = 5
                }
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 14066815635,
            Volume = 1,
            Looped = true
        },
        ["Star Breaker Voiceline"] = {
            SoundId = 7146792142,
            Volume = 2
        },
        ["Star Breaker Whoosh"] = {
            SoundId = 588693579,
            Volume = 2,
            PlaybackSpeed = 0.95
        }
    },
    Metadata = {
        PostRig = function(p2) -- Line: 53, Name: PostRig
            -- upvalues: u1 (copy)
            u1.FireAllClients("InternalWarOpacity", p2.Character);
        end
    }
};