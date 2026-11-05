  

 

local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = nil;
local u2 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: PathShortcuts (copy), u1 (ref), u2 (ref), Knit (copy)
    u1 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
    u2 = Knit.GetService("EffectService");
end);
local u20 = {
    FormData = {
        Mayhem = {
            Layout = 1,
            CoreColor = "Secondary",
            LabelAnimation = "Mayhem",
            MusicName = "D-Mode-D - Shriek (RevivedMakesMusic Mix)",
            PoseMusicName = "D-Mode-D - Shriek",
            PrimaryColor = Color3.fromRGB(64, 0, 0),
            SecondaryColor = Color3.new(1, 0, 0),
            Font = Enum.Font.Antique,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 72,
                Saturation = 0.75,
                Value = 0.9
            }
        },
        Purity = {
            Layout = 2,
            LabelBrightness = 1.5,
            CoreColor = "Primary",
            MusicName = "RevivedMakesMusic - VITALITY",
            PrimaryColor = Color3.new(0, 1, 1),
            SecondaryColor = Color3.new(1, 1, 1),
            Font = Enum.Font.Code,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = 36,
                Saturation = 0.9,
                Value = 1
            },
            PoseMusicName = { "Under Night In-Birth II - Icefield White Knight II (UNI2 Mix)", "Guilty Gear Xrd -SIGN- - The Lily of Steel" }
        },
        Corruption = {
            Layout = 3,
            CoreColor = "Secondary",
            MusicName = "Touhou 15.5 AocF ~ Night Falls - Evening Star",
            PrimaryColor = Color3.new(),
            SecondaryColor = Color3.fromRGB(90, 0, 255),
            Font = Enum.Font.Antique,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 54,
                Saturation = 0.75,
                Value = 0.85
            },
            PoseMusicName = { "P-Wave - ...Obliterate", "Touhou 07 Youyoumu ~ Perfect Cherry Blossom - Necrofantasia" }
        },
        Equinox = {
            Layout = 4,
            CoreColor = "Primary",
            SwordColor = "Secondary",
            MusicName = "xi - Vanitas",
            PrimaryColor = Color3.new(),
            SecondaryColor = Color3.new(1, 1, 1),
            Font = Enum.Font.Fantasy,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = (1 / 0),
                Saturation = 1,
                Value = 1
            },
            PoseMusicName = { "M2U - Dual Fractal", "Guilty Gear X - Awe of She" }
        },
        Divinity = {
            Layout = 5,
            LabelBrightness = 1.5,
            CoreColor = "Secondary",
            MusicName = "Under Night In-Birth - Blood Drain -Again-",
            PrimaryColor = Color3.new(1, 1, 1),
            SecondaryColor = Color3.fromRGB(255, 255, 128),
            Font = Enum.Font.SciFi,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 9.2,
                Saturation = 1,
                Value = 1
            },
            PoseMusicName = { "Kingdom Hearts 2.5 - Fate of the Unknown", "Persona 5 Strikers - Demiurge II: Negai" }
        },
        Destiny = {
            Layout = 6,
            CoreColor = "Secondary",
            MusicName = "DM Dokuro - Servants of the Scourage",
            PrimaryColor = Color3.new(1, 1, 1),
            SecondaryColor = Color3.fromRGB(180, 128, 255),
            Font = Enum.Font.Code,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 55.4,
                Saturation = 0.45,
                Value = 1
            },
            PoseMusicName = { "zero-project - Infinity", "ziki_7 - Breaking The Red Dawn" }
        },
        Rainbow = {
            Layout = 51,
            LabelBrightness = 2.75,
            CoreColor = "Primary",
            MusicName = "Camellia - Speedrun",
            PrimaryColor = Color3.fromRGB(255, 15, 35),
            SecondaryColor = Color3.new(1, 1, 1),
            Font = Enum.Font.Cartoon,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = 72,
                Saturation = 1,
                Value = 1
            },
            PoseMusicName = { "Kitsune² - Rainbow Tylenol", "Cobranix - FaZed Out" }
        },
        Omega = {
            Layout = 7,
            DisplayText = "ΩMEGA",
            CoreColor = "Secondary",
            WingAnimation = "Razor",
            MusicName = "WAiKURO - AMAZING MIGHTYYYY!!!!",
            PrimaryColor = Color3.fromRGB(12, 12, 24),
            SecondaryColor = Color3.fromRGB(61, 78, 192),
            Font = Enum.Font.SciFi,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 46.4,
                Saturation = 0.45,
                Value = 0.9
            },
            PoseMusicName = { "cybermiso - Surveiller et punir", "Tekken 8 - STORM RISING (Climax)" }
        },
        Catastrophe = {
            Layout = 45,
            ColorAnimation = "PrimarySecondaryTweens",
            CoreColor = "Secondary",
            WingAnimation = "Razor",
            MusicName = "DM Dokuro - Universal Collapse",
            PrimaryColor = Color3.fromRGB(16, 10, 255),
            SecondaryColor = Color3.fromRGB(183, 7, 255),
            Font = Enum.Font.Fondamento,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 56.4,
                Saturation = 0.95,
                Value = 0.9
            },
            PoseMusicName = { "Noah - Trackless Wilderness", "Powerless - Lost Desire (Instrumental)" }
        },
        Pandora = {
            Layout = 8,
            CoreColor = "Secondary",
            MusicName = "NegaRen - Breaking Boundaries",
            PoseMusicName = "あきやまうに - Chartreuse Gladius",
            PrimaryColor = Color3.new(1, 1, 1),
            SecondaryColor = Color3.fromRGB(159, 111, 183),
            Font = Enum.Font.Fantasy,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 55.4,
                Saturation = 0.45,
                Value = 1
            },

            Callback = function(u3) -- Line: 289, Name: Callback
                -- upvalues: u1 (ref), RunService (copy), u2 (ref)
                local u4 = 0;
                local u5 = u1.GetSound(u3.Character, "Pandora Clock SFX");
                u3.FormTrove:Add(RunService.PostSimulation:Connect(function(p6) -- Line: 292
                    -- upvalues: u4 (ref), u5 (copy), u3 (copy), u2 (ref)
                    u4 = u4 + p6;

                    while u4 > 4 do
                        u4 = u4 - 4;
                        u5:Play();
                        local v7 = u3.Character["Right Arm"];
                        u2.FireAllClients("Emit Particle V3", {
                            AbilityName = "Umbra",
                            SkinName = "MAYHEM",
                            Path = "MAYHEM_Assets/Effects/ShockwaveEffect",
                            IgnoreUnusuals = true,
                            IgnoreSkinShift = true,
                            Origin = u3.RootPart,
                            Offset = CFrame.new(0, -2.95, 0)
                        });
                        u2.FireAllClients("Emit Particle V3", {
                            AbilityName = "Umbra",
                            SkinName = "MAYHEM",
                            Path = "MAYHEM_Assets/Effects/WatchEffect",
                            IgnoreUnusuals = true,
                            IgnoreSkinShift = true,
                            Origin = v7,
                            Offset = CFrame.new(0, -0.2, 0) * CFrame.Angles(0, 3.141592653589793, 0),
                            AttachTo = {
                                MakePartP0 = true,
                                MakePartParent = true,
                                Part = v7,
                                Offset = CFrame.new(0, -0.2, 0) * CFrame.Angles(0, 3.141592653589793, 0)
                            }
                        });
                    end;
                end));
            end
        },
        Chaos = {
            Layout = 50,
            CoreColor = "Primary",
            SwordColor = "Secondary",
            MusicName = "DM Dokuro - Return of Slime",
            PrimaryColor = Color3.new(0.1, 0.1, 0.1),
            SecondaryColor = Color3.new(1, 1, 1),
            Font = Enum.Font.Arcade,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            PoseMusicName = { "Aeriu Ika - Blood Rushing To My Head", "RevivedMakesMusic - Not-In-Control" },
            HSVShift = {
                HueShift = (0 / 0),
                Saturation = 1,
                Value = 1
            },

            Callback = function(u8) -- Line: 348, Name: Callback
                -- upvalues: RunService (copy), TweenService (copy)
                local u9 = {};

                for _, child in u8.Wings:GetChildren() do
                    if child:IsA("Folder") and (child:FindFirstChild("Wing") and string.find(child.Name, "Left")) then
                        table.insert(u9, child.Wing);
                    end;
                end;

                local u10 = Random.new();
                local Label = u8.Label.Label;
                local u11 = {
                    Label = {},
                    Wings = {}
                };
                local u12 = TweenInfo.new(0.125, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
                local u13 = u12.Time + 0.08;
                local u14 = u13;
                u8.FormTrove:Add(function() -- Line: 363
                    -- upvalues: u11 (copy)
                    table.clear(u11);
                end);
                u8.FormTrove:Add(RunService.PostSimulation:Connect(function(p15) -- Line: 366
                    -- upvalues: u14 (ref), u13 (copy), u11 (copy), TweenService (ref), Label (copy), u12 (copy), u8 (copy), u9 (copy), u10 (copy)
                    u14 = u14 + p15;

                    if u13 < u14 then
                        u14 = 0;
                        local v16 = BrickColor.Random();
                        local u17 = u11.Label[v16] or TweenService:Create(Label, u12, {
                            TextStrokeColor3 = v16.Color
                        });

                        if not u11.Label[v16] then
                            u11.Label[v16] = u17;
                            u8.FormTrove:Add(function() -- Line: 377
                                -- upvalues: u17 (copy)
                                u17:Cancel();
                            end);
                        end;

                        u17:Play();

                        for _, v in u9 do
                            u11.Wings[v] = u11.Wings[v] or {};
                            local v18 = BrickColor.Random();
                            local u19 = u11.Wings[v][v18];

                            if not u11.Wings[v][v18] then
                                TweenInfo.new(u12.Time + u10:NextNumber(-0.07, 0.07), u12.EasingStyle, u12.EasingDirection);
                                u19 = TweenService:Create(v, u12, {
                                    Color = v18.Color
                                });
                                u11.Wings[v][v18] = u19;
                                u8.FormTrove:Add(function() -- Line: 392
                                    -- upvalues: u19 (ref)
                                    u19:Cancel();
                                end);
                            end;

                            u19:Play();
                        end;
                    end;
                end));
            end
        },
        SHD = {
            Layout = 20,
            LabelBrightness = 1.5,
            CoreColor = "Secondary",
            WingAnimation = "Razor",
            WingAnimationSpeed = 0.45,
            MusicName = "Dollscythe - Flashes",
            PrimaryColor = Color3.fromRGB(191, 230, 255),
            SecondaryColor = Color3.fromRGB(255, 102, 204),
            Font = Enum.Font.Arcade,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 64,
                Saturation = 0.625,
                Value = 1
            },
            PoseMusicName = { "aran - Maholova", "KzuTsT - Finding the Way Home" }
        },
        Crazed = {
            Layout = 9,
            CoreColor = "Secondary",
            WingAnimation = "Razor",
            LabelAnimation = "Crazed",
            MusicName = "Kaneko Chiharu - iLLnes LiLin",
            PrimaryColor = Color3.fromRGB(12, 12, 12),
            SecondaryColor = Color3.fromRGB(0, 32, 96),
            Font = Enum.Font.Code,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 44,
                Saturation = 1,
                Value = 0.25
            },
            PoseMusicName = { "Silentroom - Nhelv", "Calamity Unofficial OST - Playing with Firepower" }
        },
        FallenX = {
            Layout = 10,
            CoreColor = "Secondary",
            WingAnimation = "Razor",
            WingAnimationSpeed = 0.625,
            MusicName = "Endymion - Fallen Shepherd",
            PrimaryColor = Color3.fromRGB(128, 255, 255),
            SecondaryColor = Color3.fromRGB(255, 176, 0),
            Font = Enum.Font.Antique,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 8.2,
                Saturation = 1,
                Value = 1
            },
            PoseMusicName = { "suzu - 宿星審判", "Lemi. - Ruler of Stratification" }
        },
        Calamity = {
            Layout = 44,
            CoreColor = "Primary",
            MusicName = "DM Dokuro - Scourage of The Universe",
            PrimaryColor = Color3.fromRGB(64, 0, 255),
            SecondaryColor = Color3.fromRGB(128, 0, 255),
            Font = Enum.Font.Fantasy,
            Wings = {
                Right = {
                    All = true,
                    Color = "Secondary"
                },
                Left = {
                    All = true,
                    Color = "Secondary"
                }
            },
            HSVShift = {
                HueShift = 54,
                Saturation = 1,
                Value = 1
            },
            PoseMusicName = { "DM Dokuro - Fly of Beelzebub", "Mournfinale - World Vanquisher" }
        },
        Boing = {
            Layout = 60,
            CoreColor = "Secondary",
            MusicName = "X-Coast - Da Boing Boing Trak",
            PrimaryColor = Color3.new(0.45, 1, 0.2),
            SecondaryColor = Color3.fromRGB(194, 255, 172),
            Font = Enum.Font.Cartoon,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = 20,
                Saturation = 0.9,
                Value = 1
            },
            PoseMusicName = { "Toobu - Infectious (Low Quality)", "Lokan - Anger Control" }
        },
        Love = {
            Layout = 22,
            CoreColor = "Secondary",
            MusicName = "RevivedMakesMusic - Etheral Echos",
            PrimaryColor = Color3.new(1, 0.575, 1),
            SecondaryColor = Color3.fromRGB(255, 165, 228),
            Font = Enum.Font.Highway,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary"
                },
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = 63.6,
                Saturation = 0.4,
                Value = 1
            },
            PoseMusicName = { "maritumix - 514", "litmus* - Lover\'s Trick", "Taiko no Tatsujin - mint tears" }
        },
        Neptunian = {
            Layout = 21,
            CoreColor = "Secondary",
            MusicName = "Under Night In-Birth II - Beat Eat Nest (UNI2 Mix)",
            PrimaryColor = Color3.fromRGB(117, 53, 255),
            SecondaryColor = Color3.fromRGB(35, 196, 255),
            Font = Enum.Font.RobotoCondensed,
            Wings = {
                Right = {
                    All = true,
                    Color = "Primary",
                    Middle = {
                        Color = "Secondary"
                    }
                },
                Left = {
                    All = true,
                    Color = "Primary",
                    Middle = {
                        Color = "Secondary"
                    }
                }
            },
            HSVShift = {
                HueShift = 51.8,
                Saturation = 0.75,
                Value = 1
            },
            PoseMusicName = { "Resident Evil 6 - The Mercenaries", "Mega Dimension Neptunia VII - Absolute", "Tekken 7 - Heat Haze Shadow (2nd)" }
        },
        Violence = {
            CustomForm = true,
            Layout = 80,
            CoreColor = "Secondary",
            MusicName = "RevivedMakesMusic - VIOLENCE: INCOMPACITATE",
            PoseMusicName = "",
            PrimaryColor = Color3.fromRGB(75, 0, 0),
            SecondaryColor = Color3.new(),
            Font = Enum.Font.RobotoCondensed,
            Wings = {
                Left = {
                    All = true,
                    Color = "Primary"
                }
            },
            HSVShift = {
                HueShift = 72,
                Saturation = 1,
                Value = 0.5
            }
        }
    },
    AllForms = { "Mayhem", "Purity", "Corruption", "Equinox", "Divinity", "Destiny", "Rainbow", "Omega", "Catastrophe", "Pandora", "Chaos", "SHD", "Crazed", "FallenX", "Calamity", "Boing", "Love", "Neptunian" },
    RareForms = { "Mayhem", "Rainbow" },
    ContributorList = { 98888707, 369981372, 24239820, 21141528, 2400613198, 137157364, 2802743960, 2224298089, 47916090 }
};

function u20.CheckContributor(p21) -- Line: 674
    -- upvalues: u20 (copy)
    local v22 = p21:GetAttribute("GroupRank");

    return (table.find(u20.ContributorList, p21.UserId) or v22 and v22 >= 248) and true or false;
end;

return u20;