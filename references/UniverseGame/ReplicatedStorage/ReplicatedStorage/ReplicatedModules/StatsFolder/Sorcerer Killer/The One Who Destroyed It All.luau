  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 6
    -- upvalues: u1 (ref), Knit (copy)
    u1 = Knit.GetService("EffectService");
end);

return {
    Inherit = {
        AbilityName = "Sorcerer Killer"
    },
    Stats = {
        Pose = {
            From = "Combat.Pose",
            Callbacks = {
                Transformer = function(p2) -- Line: 19, Name: Transformer
                    -- upvalues: TableUtil (copy)
                    local v3 = TableUtil.Copy(p2.Stats, true);
                    local v4 = p2.Character:GetAttribute("Weapon") or "PlayfulCloud";
                    v3.StartAnim = v4 .. "PoseTransition";
                    v3.LoopAnim = v4 .. "PoseIdle";
                    v3.PoseMusic = "PoseMusic" .. math.random(1, 2);

                    return v3;
                end
            }
        }
    },
    Sounds = {
        UnrelentingAssaultVoiceline = {
            SoundId = "rbxassetid://133371963262523",
            Volume = 2
        },
        BreakneckSliceVoiceline = {
            SoundId = "rbxassetid://96207717732793",
            Volume = 2
        },
        AssassinationVoiceline = {
            SoundId = "rbxassetid://112808139988341",
            Volume = 2
        },
        UnwaveringRampageVoiceline = {
            SoundId = "rbxassetid://127014347448761",
            Volume = 2
        },
        WhirlwindBreakerVoiceline = {
            SoundId = "rbxassetid://75360675452572",
            Volume = 2
        },
        EliminationVoiceline = {
            SoundId = "rbxassetid://106638017074362",
            Volume = 2
        },
        SwiftStabStartupVoiceline = {
            SoundId = "rbxassetid://118394643473943",
            Volume = 2
        },
        UnwaveringFlurryVoiceline = {
            SoundId = "rbxassetid://81460951027191",
            Volume = 2
        },
        ViolentFlourishVoiceline = {
            SoundId = "rbxassetid://99166218038057",
            Volume = 2
        },
        ChainOfAThousandMilesVoiceline = {
            SoundId = "rbxassetid://112482462101423",
            Volume = 2
        },
        SwiftExecutionVoiceline = {
            SoundId = "rbxassetid://111779111852145",
            Volume = 2
        },
        Carnage = {
            SoundId = "rbxassetid://129859672424040",
            Volume = 2
        },
        CarnageVoiceline = {
            SoundId = "rbxassetid://74132266378892",
            Volume = 2
        },
        PoseMusic1 = {
            SoundId = "rbxassetid://93545517831060",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true
        },
        PoseMusic2 = {
            SoundId = "rbxassetid://119909833908620",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true
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
                    SoundId = "rbxassetid://137339099077707",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I can\'t wait to see the looks on my family\'s faces when I become a bigshot sorcerer, after all the years they\'ve spent looking down on me."
                        } }
                }, {
                    SoundId = "rbxassetid://111817633115053",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Don\'t get distracted."
                        } }
                }, {
                    SoundId = "rbxassetid://122711532402656",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "There, you\'re dead."
                        } }
                } }
        }
    }
};