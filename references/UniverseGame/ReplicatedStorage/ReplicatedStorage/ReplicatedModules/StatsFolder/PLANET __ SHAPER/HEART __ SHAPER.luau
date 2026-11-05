  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u1 = require(PathShortcuts.KnitPath.Knit).GetService("EffectService");

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    Stats = {
        ["SUMMON // ME"] = {
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 120, 222)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 25, 194)) })
        },
        Pose = {
            BPM = 90,
            PrimaryColor = Color3.new(1, 0.686275, 0.878431),
            SecondaryColor = Color3.new(1, 0.32549, 0.933333),
            Callbacks = {
                PoseEnd = function(p2, p3) -- Line: 22, Name: PoseEnd
                    -- upvalues: u1 (copy)
                    local _ = p2.Stats;
                    local Player = p2.Player;
                    local Character = p2.Character;
                    u1.FireClient(Player, "HEART_SHAPER_POSE", false);
                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = false,
                        Character = Character
                    });
                end,

                PoseTransition = function(p4, p5) -- Line: 32, Name: PoseTransition
                    -- upvalues: u1 (copy), PathShortcuts (copy)
                    local Stats = p4.Stats;
                    local Player = p4.Player;
                    local Character = p4.Character;
                    u1.FireClient(Player, "HEART_SHAPER_POSE", true);
                    local v6 = Player.Data.Skin:GetAttribute("SkinName");
                    u1.FireClient(Player, "PLANET_SHAPER_POSE_EFFECT", {
                        Toggling = true,
                        Character = Character,
                        PrimaryColor = Stats.PrimaryColor or Color3.new(1, 0.74902, 0),
                        SecondaryColor = Stats.SecondaryColor or Color3.new(1, 0.152941, 0.34902),
                        BPM = Stats.BPM or 147,
                        CustomBallReference = PathShortcuts.ClientAssets["P//S_R"]["HEART // SHAPER Visualizer Ball"],
                        VisualizerIntensity = Stats.VisualizerIntensity or 1,
                        CustomParticleName = v6 and v6 .. " PoseParticle" or "PoseParticle"
                    });
                end
            }
        }
    },
    Sounds = {
        PoseMusic = {
            SoundId = 10393845647,
            Volume = 2
        }
    }
};