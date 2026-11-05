  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(Knit.Util.Trove);

return {
    Inherit = {
        AbilityName = "Vergil"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p1) -- Line: 18, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if p1.Metadata.UnusualHueId == 72 then
                        v2.PoseMusic = "PoseMusic-2";

                        return v2;
                    end;

                    v2.PoseMusic = "PoseMusic-1";

                    return v2;
                end
            }
        }
    },
    Sounds = {
        ["LMB-1-Voiceline"] = {
            SoundId = 129023154755969,
            Volume = 2
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 89602891430722,
            Volume = 2
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 121304024541120,
            Volume = 2
        },
        ["LMB-5-Voiceline"] = {
            SoundId = 74947404519761,
            Volume = 2
        },
        ["LMB-1-SDT-Voiceline"] = {
            SoundId = 129023154755969,
            Volume = 2
        },
        ["LMB-3-SDT-Voiceline"] = {
            SoundId = 89602891430722,
            Volume = 2
        },
        ["LMB-4-SDT-Voiceline"] = {
            SoundId = 121304024541120,
            Volume = 2
        },
        ["LMB-5-SDT-Voiceline"] = {
            SoundId = 74947404519761,
            Volume = 2
        },
        vergil_aerial_cleave_voice = {
            SoundId = 84667107234102,
            Volume = 2
        },
        vergil_sdt_aerial_cleave_voice = {
            SoundId = 84667107234102,
            Volume = 2
        },
        vergil_aerial_rave_voice = {
            SoundId = 78947906655461,
            Volume = 2
        },
        vergil_barrage_voiceline = {
            SoundId = 92207824754005,
            Volume = 2
        },
        vergil_sdtonly_barrage_finisher_voice = {
            SoundId = 92207824754005,
            Volume = 2
        },
        vergil_judgement_cut_voiceline = {
            SoundId = 81913756047738,
            Volume = 2
        },
        vergil_manual_judgement_cut_voiceline = {
            SoundId = 85814904200283,
            Volume = 2
        },
        vergil_judgement_cut_end_voiceline1 = {
            SoundId = 73510628168816,
            Volume = 2
        },
        vergil_judgement_cut_end_voiceline2 = {
            SoundId = 82955314549043,
            Volume = 2
        },
        vergil_sdtonly_jce_voice1 = {
            SoundId = 93145982027093,
            Volume = 2
        },
        vergil_sdtonly_jce_voice2 = {
            SoundId = 93145982027093,
            Volume = 2
        },
        vergil_sdtonly_judgement_cut_voice1 = {
            SoundId = 127333229240029,
            Volume = 2
        },
        vergil_sdtonly_judgement_cut_voice2 = {
            SoundId = 117460533815447,
            Volume = 2
        },
        vergil_jackpot_voiceline = {
            SoundId = 115260208855859,
            Volume = 0
        },
        vergil_sdtonly_ijc_voice1 = {
            SoundId = 99454395361723,
            Volume = 2
        },
        vergil_sdtonly_ijc_voice2 = {
            SoundId = 108895094226124,
            Volume = 2
        },
        vergil_sdtonly_ijc_voice3 = {
            SoundId = 75595210788430,
            Volume = 2
        },
        vergil_risingstar_follow_up_voice = {
            SoundId = 97549433764108,
            Volume = 2
        },
        vergil_sdt_risingstar_follow_up_voice = {
            SoundId = 97549433764108,
            Volume = 2
        },
        vergil_rapid_slash_voiceline = {
            SoundId = 121049843031901,
            Volume = 2
        },
        vergil_sdtonly_rapid_slash_voiceline1 = {
            SoundId = 121049843031901,
            Volume = 2
        },
        vergil_sdt_activated_voice = {
            SoundId = 97251421991051,
            Volume = 2
        },
        vergil_doppelganger_activated_voice = {
            SoundId = 110292537010099,
            Volume = 2
        },
        vergil_trick_voice = {
            SoundId = 98409222928670,
            Volume = 2
        },
        vergil_sdtonly_upper_slash_voice = {
            SoundId = 102941199263548,
            Volume = 2
        },
        vergil_upper_slash_voiceline = {
            SoundId = 102941199263548,
            Volume = 2
        },
        vergil_upper_slash_2_voice = {
            SoundId = 140726146227301,
            Volume = 2
        },
        vergil_void_slash_voiceline = {
            SoundId = 120211566561642,
            Volume = 2
        },
        vergil_sdtonly_void_slash_voice1 = {
            SoundId = 120211566561642,
            Volume = 2
        },
        vergil_sdtonly_void_slash_voice2 = {
            SoundId = 120211566561642,
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 134519556728277,
            Volume = 1
        },
        MeterUp3 = {
            SoundId = 114908165614543,
            Volume = 1
        },
        ["SDT-Music-1"] = {
            SoundId = 9893964327,
            Volume = 1
        },
        ["PoseMusic-1"] = {
            SoundId = 120473187900875,
            Volume = 1
        },
        ["PoseMusic-2"] = {
            SoundId = 97653569990488,
            Volume = 2
        }
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = { {
                    SoundId = "rbxassetid://94799469616929",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "End of the line"
                        } }
                }, {
                    SoundId = "rbxassetid://74122346466687",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Not yet"
                        } }
                }, {
                    SoundId = "rbxassetid://111638615891513",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Let\'s go"
                        } }
                }, {
                    SoundId = "rbxassetid://126952680273745",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You a righty, or a left?"
                        } }
                }, {
                    SoundId = "rbxassetid://102385111059736",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "It\'s over"
                        } }
                } }
        }
    }
};