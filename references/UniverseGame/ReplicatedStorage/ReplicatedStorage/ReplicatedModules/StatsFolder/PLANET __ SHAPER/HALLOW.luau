  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 113, 42)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) })
        },
        Pose = {
            BPM = 101,
            PrimaryColor = Color3.new(1, 0.509804, 0.180392),
            SecondaryColor = Color3.new(0, 0, 0),
            Callbacks = {
                PoseEnd = function(p2, p3) -- Line: 22, Name: PoseEnd
                    -- upvalues: u1 (copy)
                    local _ = p2.Stats;
                    local Player = p2.Player;
                    local Character = p2.Character;
                    u1.FireClient(Player, "HALLOW_POSE", false);
                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = false,
                        Character = Character
                    });
                end,

                PoseTransition = function(p4, p5) -- Line: 32, Name: PoseTransition
                    -- upvalues: u1 (copy)
                    local Stats = p4.Stats;
                    local Player = p4.Player;
                    local Character = p4.Character;
                    u1.FireClient(Player, "HALLOW_POSE", true);
                    local v6 = Player.Data.Skin:GetAttribute("SkinName");
                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = true,
                        CustomBallReference = false,
                        Character = Character,
                        PrimaryColor = Stats.PrimaryColor or Color3.new(1, 0.74902, 0),
                        SecondaryColor = Stats.SecondaryColor or Color3.new(1, 0.152941, 0.34902),
                        BPM = Stats.BPM or 147,
                        VisualizerIntensity = Stats.VisualizerIntensity or 1,
                        CustomParticleName = v6 and v6 .. " PoseParticle" or "PoseParticle"
                    });
                end
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10393637048,
            Volume = 2
        },
        SummonEffects = {
            SoundId = 13119666698,
            Volume = 2
        },
        Desummon = {
            SoundId = 13119666776,
            Volume = 2
        }
    },
    Animations = {
        Action = {
            PoseTransition = 13479802923,
            PoseIdle = 13488396457,
            StandOffPoseTransition = 13488401008,
            StandOffPoseIdle = 13488402360
        }
    }
};