  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
game:GetService("CollectionService");
game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 15
    -- upvalues: PathShortcuts (copy), u1 (ref)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);

return {
    Inherit = {
        AbilityName = "Dragon Sage"
    },
    Animations = {
        Action = {
            PoseTransitionMeditate = 80004746841258,
            PoseIdleMeditate = 139256403455242
        },
        Idle = {
            Idle = 94396042581142
        }
    },
    Stats = {
        Pose = {
            Callbacks = {
                Transformer = function(p2) -- Line: 36, Name: Transformer
                    -- upvalues: TableUtil (copy), u1 (ref)
                    local v3 = Random.new():NextInteger(1, 5) >= 2;
                    local v4 = TableUtil.Copy(p2.Stats, true);
                    v4.PoseMusic = "PoseMusic-" .. Random.new():NextInteger(1, 5);
                    v4.StartAnim = "PoseTransition" .. (v3 and "Meditate" or "");
                    v4.LoopAnim = "PoseIdle" .. (v3 and "Meditate" or "");

                    if not v3 then
                        u1.PlaySound(p2.Character, "RapidSwings");
                    end;

                    return v4;
                end
            }
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = 17874178015,
            Volume = 2
        },
        ["LMB-2"] = {
            SoundId = 17874177314,
            Volume = 2
        },
        ["LMB-3"] = {
            SoundId = 17874177113,
            Volume = 2
        },
        ["LMB-4"] = {
            SoundId = 17874176709,
            Volume = 2
        },
        ["LMB-1-Voiceline"] = {
            SoundId = 137534313220547,
            Volume = 5.25
        },
        ["LMB-2-Voiceline"] = {
            SoundId = 119234351292624,
            Volume = 5.25
        },
        ["LMB-3-Voiceline"] = {
            SoundId = 90900015752965,
            Volume = 5.25
        },
        ["LMB-4-Voiceline"] = {
            SoundId = 106274521734193,
            Volume = 5.25
        },
        ["Seismic Toss Hit Voiceline"] = {
            SoundId = 109116007003805,
            Volume = 7.5
        },
        ["Seismic Toss Hit"] = {
            Volume = 0.5
        },
        ["Seismic Toss Hit 2"] = {
            SoundId = 129378348975947,
            Volume = 3.25
        },
        ["Seismic Toss Hit Throw"] = {
            SoundId = 133986001612197,
            Volume = 4
        },
        ["Seismic Toss Hit Air"] = {
            SoundId = 116663013889405,
            Volume = 4
        },
        ["Lightning Drop Ground Voiceline"] = {
            SoundId = 133183620447861,
            Volume = 4
        },
        ["Lightning Drop Air Voiceline"] = {
            SoundId = 97734331207060,
            Volume = 4.5
        },
        ["Lightning Elbow Voiceline"] = {
            SoundId = 118234778008114,
            Volume = 8.5
        },
        ["Electric Smite Voiceline"] = {
            SoundId = 84727643026904,
            Volume = 5
        },
        ["Thundering Leap Voiceline"] = {
            SoundId = 71616079750791,
            Volume = 5
        },
        Dash = {
            Volume = 1
        },
        ["Dash Voiceline"] = {
            SoundId = 131667859465861,
            Volume = 6
        },
        TeleportSFX = {
            SoundId = 4826619573,
            PlaybackSpeed = 1.1,
            PlaybackRegionsEnabled = true,
            Volume = 1,
            PlaybackRegion = NumberRange.new(0.5, 600000)
        },
        TeleportSFX2 = {
            SoundId = 898367467,
            PlaybackSpeed = 1,
            Volume = 3
        },
        DevilThrowStartup = {
            SoundId = 11159624051,
            Volume = 3,
            PlaybackRegionsEnabled = true,
            PlaybackSpeed = 1.1,
            PlaybackRegion = NumberRange.new(0.1, 600000)
        },
        DevilThrowStartupVoiceline = {
            SoundId = 97353541105332,
            Volume = 5,
            PlaybackSpeed = 1
        },
        ["PoseMusic-1"] = {
            SoundId = 70625154773746,
            Volume = 3,
            PlaybackSpeed = 1
        },
        ["PoseMusic-2"] = {
            SoundId = 95812671067338,
            Volume = 3
        },
        ["PoseMusic-3"] = {
            SoundId = 75585815791076,
            Volume = 3.75,
            PlaybackSpeed = 1.666
        },
        ["PoseMusic-4"] = {
            SoundId = 10406484175,
            Volume = 4.5,
            PlaybackSpeed = 1
        },
        ["PoseMusic-5"] = {
            SoundId = 9062271360,
            Volume = 3,
            PlaybackSpeed = 1
        },
        DeathSound = {
            SoundId = 4912621731,
            PlaybackRegionsEnabled = true,
            Volume = 2,
            PlaybackRegion = NumberRange.new(3.02, 600000)
        },
        UIAuraSFX = {
            SoundId = 75567314581899,
            Looped = true,
            RollOffMaxDistance = 60,
            RollOffMinDistance = 25,
            Volume = 4.75
        }
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
                    SoundId = "rbxassetid://123141901393884",
                    SoundVolume = 9,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Timing = 0.03,
                            EndLag = 2.45,
                            Quote = "The real fight starts now."
                        } }
                },
                {
                    SoundId = "rbxassetid://100134767011946",
                    SoundVolume = 8,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Think again!"
                        } }
                },
                {
                    SoundId = "rbxassetid://125178514605908",
                    SoundVolume = 8,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "No use."
                        } }
                },
                {
                    SoundId = "rbxassetid://126228264186250",
                    SoundVolume = 6.5,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This.. is Ultra Instinct."
                        } }
                },
                {
                    SoundId = "rbxassetid://114645663379524",
                    SoundVolume = 8,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I\'m fighting for everyone. I won\'t lose!"
                        } }
                },
                {
                    SoundId = "rbxassetid://116771299954455",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You\'re not gonna win."
                        } }
                },
                {
                    SoundId = "rbxassetid://78964520688044",
                    SoundVolume = 8,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "I refuse to let all of them down!"
                        } }
                },
                {
                    SoundId = "rbxassetid://114973716404360",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You don\'t have what it takes to beat me."
                        } }
                },
                {
                    SoundId = "rbxassetid://138103507621871",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Now that\'s enough."
                        } }
                },
                {
                    SoundId = "rbxassetid://91053518962954",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "This is where the real fight starts!"
                        } }
                },
                {
                    SoundId = "rbxassetid://104134596824408",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Right then. Let\'s GO!"
                        } }
                },
                {
                    SoundId = "rbxassetid://116172486468445",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Try and stop me."
                        } }
                },
                {
                    SoundId = "rbxassetid://103412756214933",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "You don\'t stand a chance.. against me."
                        } }
                },
                {
                    SoundId = "rbxassetid://75590449711847",
                    SoundVolume = 6,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "What\'s wrong? Is that all you\'ve got?"
                        } }
                },
                {
                    SoundId = "rbxassetid://123842038833184",
                    SoundVolume = 7,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "Prepare yourself!"
                        } }
                },
                {
                    SoundId = "rbxassetid://5612259294",
                    SoundVolume = 10,
                    YieldSound = true,
                    Visible = true,
                    FullQuote = { {
                            Quote = "HEY IT\'S ME GOKU!"
                        } }
                }
            }
        }
    },
    Metadata = {
        PostRig = function(p5) -- Line: 401, Name: PostRig
            -- upvalues: Trove (copy), AssetHandler (copy), TweenService (copy), u1 (ref)
            local Player = p5.Player;
            local Character = p5.Character;
            local _ = p5.SkinName;

            repeat
                task.wait(0.25);
            until Character:WaitForChild("Head");

            if Player:IsA("Player") then
                Player:HasAppearanceLoaded();
            end;

            local v6 = Trove.new();
            local v7 = TweenInfo.new(0.75, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
            local v8 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
            local u9 = Player.Name .. "_HairMoves";
            local v10 = AssetHandler.CloneAsset("Particles/Aura", {
                AbilityName = "Dragon Sage",
                SkinName = "The Instinctive"
            });

            for _, child in v10:GetChildren() do
                for _, child2 in child:GetChildren() do
                    Character[child.Name]:SetAttribute("IgnoresUnusuals", true);
                    child2.Parent = Character[child.Name];

                    if child2:IsA("BasePart") then
                        child2.Weld.Part0 = Character[child.Name];
                    end;
                end;
            end;

            v6:Add(v10);
            local v11 = (p5.Humanoid or p5.Character.Humanoid):GetAccessories();
            local u12 = {
                In = {},
                Out = {}
            };

            for _, v in v11 do
                local v13 = v:FindFirstChild("Handle") or v:FindFirstChildWhichIsA("BasePart");
                local v14;

                if v13 then
                    v14 = v13:FindFirstChildOfClass("Weld");
                else
                    v14 = v13;
                end;

                local v15;

                if v13 then
                    v15 = v13:FindFirstChild("HairAttachment");
                else
                    v15 = v13;
                end;

                if v15 and v14 then
                    local v16 = v13:Clone();
                    local v17 = v16:FindFirstChild("Mesh") or v16:FindFirstChildOfClass("SpecialMesh");
                    local v18;

                    if v17 then
                        v18 = v16:FindFirstChildOfClass("Weld") or v14:Clone();
                    else
                        v18 = v17;
                    end;

                    v18.Enabled = false;

                    if v17 then
                        v18.Part0 = v16;
                        v18.Part1 = v14.Part1;
                        v18.Parent = v13;
                        v16.Massless = true;
                        v16.Parent = workspace.Effects;
                        v16.Transparency = 1;
                        v18.Enabled = true;
                        v17.TextureId = "rbxassetid://15642357165";
                        v17.VertexColor = Vector3.new(5, 5, 5);
                        table.insert(u12.In, TweenService:Create(v16, v7, {
                            Transparency = 0
                        }));
                        table.insert(u12.Out, TweenService:Create(v16, v8, {
                            Transparency = 1
                        }));
                        table.insert(u12.In, TweenService:Create(v13, v7, {
                            Transparency = 1
                        }));
                        table.insert(u12.Out, TweenService:Create(v13, v8, {
                            Transparency = 0
                        }));
                        v6:Add(v16);
                    else
                        v16:Destroy();
                    end;
                end;
            end;

            table.clear(v11);

            if #u12.In >= 1 then
                local u19 = u1.GetHook("Moves");
                local u20 = nil;
                u19:Hook("PreMove", u9, 2, function(p21) -- Line: 468
                    -- upvalues: Character (copy), u20 (ref), u12 (copy)
                    if Character == p21.Character then
                        if u20 then
                            task.cancel(u20);

                            for _, v in u12.Out do
                                v:Cancel();
                            end;
                        end;

                        for _, v in u12.In do
                            v:Play();
                        end;

                        u20 = task.delay(0.75, function() -- Line: 481
                            -- upvalues: u12 (ref)
                            for _, v in u12.In do
                                v:Cancel();
                            end;

                            for _, v in u12.Out do
                                v:Play();
                            end;
                        end);
                    end;
                end);
                v6:Add(function() -- Line: 502
                    -- upvalues: u12 (copy), u19 (copy), u9 (copy)
                    table.clear(u12);
                    u19:Unhook("PreMove", u9);
                end);
            end;

            local v22 = Player.Name .. "UIHighlight";
            local v23 = workspace.Effects:FindFirstChild(v22);

            if v23 then
                v23:Destroy();
            end;

            local Highlight = Instance.new("Highlight");
            Highlight.Adornee = Character;
            Highlight.Name = v22;
            Highlight.Parent = workspace.Effects;
            Highlight.FillColor = Color3.new(1, 1, 1);
            Highlight.FillTransparency = 1;
            Highlight.OutlineColor = Color3.new(1, 1, 1);
            Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
            Highlight.OutlineTransparency = 0.15;
            Highlight.Enabled = true;
            v6:Add(Highlight);
            u1.PlaySound(Character, "UIAuraSFX");
            local v24 = game:GetService("TweenService"):Create(Highlight, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                OutlineTransparency = 0.4,
                FillTransparency = 0.9,
                OutlineColor = Color3.fromRGB(155, 180, 255)
            });
            v24:Play();
            v6:Add(v24);
            v6:AttachToInstance(Character);
        end
    }
};