  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 89, 124)) })
        },
        Pose = {
            BPM = 101,
            PrimaryColor = Color3.new(1, 0.741176, 0.137255),
            SecondaryColor = Color3.new(1, 0.67451, 0.972549),
            Callbacks = {
                PoseEnd = function(p2, p3) -- Line: 22, Name: PoseEnd
                    -- upvalues: u1 (copy)
                    local _ = p2.Stats;
                    u1.FireClient(p2.Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = false,
                        Character = p2.Character
                    });
                end,

                PoseTransition = function(p4, p5) -- Line: 32, Name: PoseTransition
                    -- upvalues: u1 (copy)
                    local Stats = p4.Stats;
                    local Player = p4.Player;
                    local Character = p4.Character;
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
            SoundId = 10397831030,
            Volume = 2
        }
    }
};