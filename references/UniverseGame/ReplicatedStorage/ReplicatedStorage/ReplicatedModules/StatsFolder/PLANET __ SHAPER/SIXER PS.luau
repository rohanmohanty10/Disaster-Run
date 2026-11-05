  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
Knit.GetService("AnimationService");
Knit.GetService("EffectService");
local TableUtil = require(Knit.Util.TableUtil);
local TweenModule = require(PathShortcuts.ClientModulesPath.TweenModule);

return {
    Inherit = {
        AbilityName = "PLANET // SHAPER"
    },
    QuoteInfo = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Quotes = {
            Universal = {
                {
                    SoundId = "rbxassetid://133258219418499",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    StandHead = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.Arcade,
                        TextColor3 = Color3.fromRGB(179, 73, 255)
                    },
                    FullQuote = { {
                            Quote = "Stay with me."
                        } }
                },
                {
                    SoundId = "rbxassetid://97110073355979",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    StandHead = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.Arcade,
                        TextColor3 = Color3.fromRGB(179, 73, 255)
                    },
                    FullQuote = { {
                            Quote = "But why...? This again...."
                        } }
                },
                {
                    SoundId = "rbxassetid://117307140062151",
                    SoundVolume = 2,
                    YieldSound = true,
                    Visible = true,
                    StandHead = true,
                    TextStyle = {
                        TextStrokeTransparency = 0.7,
                        Font = Enum.Font.Arcade,
                        TextColor3 = Color3.fromRGB(179, 73, 255)
                    },
                    FullQuote = { {
                            Quote = "All I asked was for you to stay with me. I\'ve done everything I could...yet you prefer the company of obsequious fakes... "
                        } }
                }
            }
        }
    },
    Sounds = {
        PoseMusic1 = {
            SoundId = 73528117114524,
            Volume = 2,
            PlaybackSpeed = 2
        },
        PoseMusic2 = {
            SoundId = 102473670733251,
            Volume = 2,
            PlaybackSpeed = 0.5
        },
        PoseMusic3 = {
            SoundId = 87981720094831,
            Volume = 2,
            PlaybackSpeed = 1.6393442623
        },
        StandOffPoseMusic1 = {
            SoundId = 134041386534967,
            Volume = 2
        },
        StandOffPoseMusic2 = {
            SoundId = 103323729376936,
            Volume = 2
        },
        StandOffPoseMusic3 = {
            SoundId = 97533435519849,
            Volume = 2
        },
        MeterUp2 = {
            SoundId = 115967821362734,
            Volume = 2
        },
        MeterUp4 = {
            SoundId = 127216374366624,
            Volume = 2
        },
        ["ASTRAL // CATALYST Voiceline"] = {
            SoundId = 140359246559256,
            Volume = 2
        },
        ["ASTRAL // BEAT Voiceline"] = {
            SoundId = 117116138684231,
            Volume = 2
        },
        ["BLAZING // STAR Voiceline"] = {
            SoundId = 116761219887942,
            Volume = 2
        },
        ["BREAKNECK // ASSAULT Voiceline"] = {
            SoundId = 138457304131612,
            Volume = 2
        },
        ["DASH // ATTACK Voiceline"] = {
            SoundId = 107180213897484,
            Volume = 2
        },
        ["DEVA // STATION Startup Voiceline"] = {
            SoundId = 133723609002573,
            Volume = 2
        },
        ["DEVA // STATION Voiceline"] = {
            SoundId = 131161206774818,
            Volume = 2
        },
        ["FULL // SEND Voiceline"] = {
            SoundId = 90802625414931,
            Volume = 2
        },
        ["METEOR // IMPACT Voiceline"] = {
            SoundId = 78761079166590,
            Volume = 2
        },
        ["METEOR // IMPACT Startup Voiceline"] = {
            SoundId = 92495107129042,
            Volume = 2
        },
        ["MONSTROUS // ROAR Voiceline"] = {
            SoundId = 138876518619014,
            Volume = 2
        },
        ["RIP // TEAR Voiceline"] = {
            SoundId = 84052304883505,
            Volume = 2
        },
        ["TRIPLE // STRIKE Voiceline"] = {
            SoundId = 83900689960708,
            Volume = 2
        },
        ["VISCERAL // ATTACK Voiceline"] = {
            SoundId = 136221865553112,
            Volume = 2
        },
        ["VOID // GATE Startup Voiceline"] = {
            SoundId = 102661327990376,
            Volume = 2
        },
        ["VOID // GATE Teleport Voiceline"] = {
            SoundId = 121621204058805,
            Volume = 2
        },
        SummonVoiceline = {
            SoundId = 131161206774818,
            Volume = 2
        },
        DesummonVoiceline = {
            SoundId = 131161206774818,
            Volume = 2
        }
    },
    Stats = {
        Pose = {
            BPM = 124,
            PrimaryColor = Color3.new(0.615686, 0.0823529, 1),
            SecondaryColor = Color3.new(0.87451, 0.788235, 0.439216),
            Callbacks = {
                Transformer = function(p1) -- Line: 191, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = math.random(1, 3);
                    local v3 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v3.PoseMusic = "PoseMusic" .. v2;

                        return v3;
                    end;

                    v3.PoseMusic = "StandOffPoseMusic" .. v2;

                    return v3;
                end
            }
        },
        ["SUMMON // ME"] = {
            OnSummon = function(p4, p5) -- Line: 204, Name: OnSummon
                -- upvalues: TweenModule (copy)
                local Character = p4.Character;
                local _ = Character.Humanoid;
                local Animator = p4.Animator;

                if p5 then
                    Animator:GetAnimation("Summon"):Play();
                    TweenModule:GetTweenObject(Character.Stand:FindFirstChild("StandOffKatana"), TweenInfo.new(0.3), {
                        Transparency = 1
                    }):Play();

                    for _, descendant in pairs(Character.Stand:FindFirstChild("StandOffKatana"):GetDescendants()) do
                        if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                            descendant.Enabled = false;
                        end;

                        if descendant:IsA("BasePart") then
                            TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                                Transparency = 1
                            }):Play();
                        end;
                    end;

                    return;
                end;

                Animator:GetAnimation("Desummon"):Play();
                TweenModule:GetTweenObject(Character.Stand:FindFirstChild("StandOffKatana"), TweenInfo.new(0.3), {
                    Transparency = 1
                }):Play();

                for _, descendant in pairs(Character.Stand:FindFirstChild("StandOffKatana"):GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                        descendant.Enabled = true;
                    end;

                    if descendant:IsA("BasePart") then
                        TweenModule:GetTweenObject(descendant, TweenInfo.new(0.3), {
                            Transparency = 0
                        }):Play();
                    end;
                end;
            end
        }
    }
};