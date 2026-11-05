  

 

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EasyVisuals = require(ReplicatedStorage.ClientLibrary.EasyVisuals);

local function Lerp(p1, p2, p3) -- Line: 14
    return p1:Lerp(p2, p3);
end;

local function Quad(p4, p5, p6, p7) -- Line: 18
    -- upvalues: Lerp (copy)
    return Lerp(p4:Lerp(p5, p7), p5:Lerp(p6, p7), p7);
end;

local v73 = {
    TITLE_1 = {
        Name = "Over Heaven",
        Achievement = "ACHIEVEMENT_40",
        Color = Color3.fromHex("#f4f768"),

        NameCallback = function(p8, p9) -- Line: 27, Name: NameCallback
            return `{p9.Player.DisplayName} {p8.Name}`;
        end
    },
    TITLE_2 = {
        Name = "Enshadowed",
        Achievement = "ACHIEVEMENT_50",
        Color = Color3.fromHex("#4c178e")
    },
    TITLE_3 = {
        Name = "Peacemaker",
        Achievement = "ACHIEVEMENT_10000",
        Color = Color3.fromHex("#03e3f5")
    },
    TITLE_4 = {
        Name = "Vigilante",
        Achievement = "ACHIEVEMENT_10001",
        Color = Color3.fromHex("#ec2a2e")
    },
    TITLE_5 = {
        Name = "Stylish Bandit Slayer",
        Achievement = "ACHIEVEMENT_10003",
        Color = Color3.fromHex("#af9fa0")
    },
    TITLE_6 = {
        Name = "Raider",
        Achievement = "ACHIEVEMENT_10007",
        Color = Color3.fromHex("#f43a45")
    },
    TITLE_7 = {
        Name = "Stardust Crusader",
        Achievement = "ACHIEVEMENT_10011",
        Color = Color3.fromHex("#0800ff")
    },
    TITLE_8 = {
        Name = "Jusoshi",
        Achievement = "ACHIEVEMENT_10015",
        Color = Color3.fromHex("#28e716")
    },
    TITLE_9 = {
        Name = "Jujutsushi",
        Achievement = "ACHIEVEMENT_10019",
        Color = Color3.fromHex("#91bf8d")
    },
    TITLE_10 = {
        Name = "Intruder",
        Achievement = "ACHIEVEMENT_10023",
        Color = Color3.fromHex("#fe8833")
    },
    TITLE_11 = {
        Name = "Gangster",
        Achievement = "ACHIEVEMENT_11000",
        Color = Color3.fromHex("#ffe63b")
    },
    TITLE_12 = {
        Name = "Demon Slayer",
        Achievement = "ACHIEVEMENT_11001",
        Color = Color3.fromHex("#cf0000")
    },
    TITLE_13 = {
        Name = "Special Grade Slayer",
        Achievement = "ACHIEVEMENT_11002",
        Color = Color3.fromHex("#4cff8b")
    },
    TITLE_14 = {
        Name = "The Honored One",
        Achievement = "ACHIEVEMENT_11003",
        Color = Color3.fromHex("#4cc8ff")
    },
    TITLE_15 = {
        Name = "Dragon Slayer",
        Achievement = "ACHIEVEMENT_11005",
        Color = Color3.fromHex("#e25020")
    },
    TITLE_16 = {
        Name = "Soul Hunter",
        Achievement = "ACHIEVEMENT_22003",
        Color = Color3.fromHex("#000000")
    },
    TITLE_17 = {
        Name = "Apex Of Power",
        Achievement = "ACHIEVEMENT_25003",
        Color = Color3.fromHex("#ffdf21")
    },
    TITLE_18 = {
        Name = "True Ascendent",
        Achievement = "ACHIEVEMENT_25101",
        Color = Color3.fromHex("#ffffff")
    },
    TITLE_19 = {
        Name = "Gambler",
        Achievement = "ACHIEVEMENT_25204",
        Color = Color3.fromHex("#4eff1c")
    },
    TITLE_20 = {
        Name = "Gacha Addict",
        Achievement = "ACHIEVEMENT_25205",
        Color = Color3.fromHex("#ffc71c")
    },
    TITLE_21 = {
        Name = "Collector",
        Achievement = "ACHIEVEMENT_25404",
        Color = Color3.fromHex("#1c3fff")
    },
    TITLE_22 = {
        Name = "Crafter",
        Achievement = "ACHIEVEMENT_25504",
        Color = Color3.fromHex("#c71cff")
    },
    TITLE_23 = {
        Name = "Tower Climber",
        Achievement = "ACHIEVEMENT_25604",
        Color = Color3.fromHex("#ff1c84")
    },
    TITLE_24 = {
        Name = "Shady Trader",
        Achievement = "ACHIEVEMENT_2204",
        Color = Color3.fromHex("#921cff")
    },
    TITLE_25 = {
        Name = "Underworld Merchant",
        Achievement = "ACHIEVEMENT_2404",
        Color = Color3.fromHex("#dd1818")
    },
    TITLE_26 = {
        Name = "RKER",
        Achievement = "ACHIEVEMENT_20005",
        Color = Color3.fromHex("#7d0000")
    },
    TITLE_27 = {
        Name = "Ruler of UG 👑",
        Achievement = "ACHIEVEMENT_20006",
        Color = Color3.fromHex("#ffed17"),

        Callback = function(p10, p11, p12) -- Line: 160, Name: Callback
            -- upvalues: ParticleHandler (copy)
            local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
            local v13 = game.Players:GetPlayerFromCharacter(p11);

            if not (v13 and v13.Settings.TitleAuras.Value) then
                return;
            end;

            local v14 = p12:Clone(ReplicatedStorage2["Client Assets"].Titles.UGRuler.Crown);
            v14.Parent = p11.Head;
            ParticleHandler.AttachTo(v14, {
                Part = p11.Head,
                Offset = CFrame.new(0, -0.6, 0)
            });
        end
    },
    TITLE_28 = {
        Name = "Skill Issue",
        Achievement = "ACHIEVEMENT_21001",
        Color = Color3.fromHex("#966a00")
    },
    TITLE_29 = {
        Name = "🤡"
    },
    TITLE_30 = {
        Name = "🤫☝️🧏"
    },
    TITLE_31 = {
        Name = "Baroque Works Contractor",
        Color = Color3.fromHex("#000000")
    },
    TITLE_32 = {
        Name = "Higashikata\'s Killer",
        Color = Color3.fromHex("#FF45BE")
    },
    TITLE_33 = {
        Name = "Slick Moves",
        Achievement = "ACHIEVEMENT_50000",
        Color = Color3.fromRGB(77, 255, 12)
    },
    TITLE_34 = {
        Name = "The Dragon of Dojima",
        Achievement = "ACHIEVEMENT_50003",
        Color = Color3.fromRGB(255, 1, 14)
    },
    TITLE_35 = {
        Name = "Kur\'s Blessing",
        Achievement = "ACHIEVEMENT_50006",
        Color = Color3.fromRGB(137, 33, 255)
    },
    TITLE_36 = {
        Name = "The Devil\'s Luck",
        Achievement = "ACHIEVEMENT_50010",
        Color = Color3.fromRGB(54, 14, 255)
    },
    TITLE_37 = {
        Name = "Worst Generation",
        Achievement = "ACHIEVEMENT_50011",
        Color = Color3.fromRGB(255, 110, 248)
    },
    TITLE_38 = {
        Name = "Warlord of the Sea",
        Achievement = "ACHIEVEMENT_50012",
        Color = Color3.fromRGB(129, 179, 255)
    },
    TITLE_39 = {
        Name = "Yonko",
        Achievement = "ACHIEVEMENT_50013",
        Color = Color3.fromRGB(0, 0, 0)
    },
    TITLE_40 = {
        Name = "Ruthless Assassin",
        Achievement = "ACHIEVEMENT_50016",
        Color = Color3.fromRGB(88, 0, 1)
    },
    TITLE_41 = {
        Name = "The Rejuvenated",
        Achievement = "ACHIEVEMENT_50019",
        Color = Color3.fromRGB(255, 46, 49),

        NameCallback = function(p15, p16) -- Line: 235, Name: NameCallback
            return `{p16.Player.DisplayName}, {p15.Name}`;
        end
    },
    TITLE_42 = {
        Name = "The Accursed Commander",
        Achievement = "ACHIEVEMENT_50022",
        Color = Color3.fromRGB(204, 75, 255),

        NameCallback = function(p17, p18) -- Line: 243, Name: NameCallback
            return `{p18.Player.DisplayName}, {p17.Name}`;
        end
    },
    TITLE_43 = {
        Name = "Fruit Muncher",
        Achievement = "ACHIEVEMENT_50025",
        Color = Color3.fromRGB(255, 163, 33)
    },
    TITLE_44 = {
        Name = "The Ghost Rider",
        Color = Color3.fromRGB(255, 64, 0),

        NameCallback = function(p19, p20) -- Line: 255, Name: NameCallback
            return `{p20.Player.DisplayName}, {p19.Name}`;
        end
    },
    TITLE_45 = {
        Name = "GLaDOS",
        Achievement = "ACHIEVEMENT_50028",
        Color = Color3.fromRGB(11, 214, 255)
    },
    TITLE_46 = {
        Name = "Nah, I\'d Win",
        Achievement = "ACHIEVEMENT_50031",
        Color = Color3.fromRGB(0, 0, 0)
    },
    TITLE_47 = {
        Name = "Universal",
        Achievement = "ACHIEVEMENT_50032",
        Color = Color3.fromRGB(0, 0, 0)
    },
    TITLE_48 = {
        Name = "In Shambles",
        Achievement = "ACHIEVEMENT_50035",
        Color = Color3.fromRGB(85, 153, 255),

        NameCallback = function(p21, p22) -- Line: 278, Name: NameCallback
            return `{p22.Player.DisplayName} {p21.Name}`;
        end
    },
    TITLE_49 = {
        Name = "ROOM!",
        Achievement = "ACHIEVEMENT_50038",
        Color = Color3.fromRGB(176, 230, 255)
    },
    TITLE_50 = {
        Name = "Heartless",
        Achievement = "ACHIEVEMENT_50041",
        Color = Color3.fromRGB(255, 0, 251)
    },
    TITLE_51 = {
        Name = "Empress of Love",
        Achievement = "ACHIEVEMENT_50044",
        Color = Color3.fromRGB(229, 126, 255)
    },
    TITLE_52 = {
        Name = "Pilot",
        Achievement = "ACHIEVEMENT_50047",
        Color = Color3.fromRGB(63, 255, 42)
    },
    TITLE_53 = {
        Name = "Driver",
        Achievement = "ACHIEVEMENT_50050",
        Color = Color3.fromRGB(184, 102, 255)
    },
    TITLE_54 = {
        Name = "Mighty Adventurer",
        Achievement = "ACHIEVEMENT_50053",
        Color = Color3.fromRGB(149, 149, 149)
    },
    TITLE_55 = {
        Name = "Bloodborn",
        Color = Color3.fromRGB(150, 0, 2)
    },
    TITLE_56 = {
        Name = "Winter\'s Legacy",
        Color = Color3.fromRGB(255, 255, 255)
    },
    TITLE_57 = {
        Name = "Donator",
        Color = Color3.fromRGB(17, 255, 0)
    },
    TITLE_58 = {
        Name = "The Eminence In Shadow",
        Color = Color3.fromRGB(0, 0, 0)
    },
    TITLE_60 = {
        Name = "Protector Of Time",
        Achievement = "ACHIEVEMENT_50056",
        Color = Color3.fromRGB(161, 206, 255)
    },
    TITLE_62 = {
        Name = "Sun God Nika",
        Color = Color3.fromRGB(232, 144, 35)
    },
    TITLE_63 = {
        Name = "The Disgraced One",
        Color = Color3.fromRGB(86, 0, 0)
    },
    TITLE_64 = {
        Name = "Apostate of a Crowned Curse",
        Achievement = "ACHIEVEMENT_50062",
        Color = Color3.fromRGB(154, 62, 0)
    },
    TITLE_65 = {
        Name = "The Infamous Zenin",
        Color = Color3.fromRGB(0, 0, 0)
    },
    TITLE_66 = {
        Name = "Sacred Treasure Unsealed",
        Color = Color3.fromRGB(255, 215, 0)
    },
    TITLE_67 = {
        Name = "Painting A New Era",
        Color = Color3.fromRGB(255, 215, 0)
    },
    TITLE_68 = {
        Name = "Rays Of Hope Shine Black",
        Achievement = "ACHIEVEMENT_50059",
        Color = Color3.fromRGB(81, 0, 0)
    },
    TITLE_69 = {
        Name = "Unbridled Requited Love",
        Color = Color3.fromRGB(195, 72, 138)
    },
    TITLE_70 = {
        Name = "A King Commands A General",
        Color = Color3.fromRGB(255, 162, 0)
    },
    TITLE_71 = {
        Name = "Everlasting Goroshi",
        Color = Color3.fromRGB(0, 0, 128)
    },
    TITLE_72 = {
        Name = "Grimharrow",
        Color = Color3.fromRGB(255, 85, 0)
    },
    TITLE_73 = {
        Name = "Σ",
        Color = Color3.fromRGB(0, 255, 204)
    },
    TITLE_74 = {
        Name = "Patriot of the Parallel",
        Color = Color3.fromRGB(158, 239, 255),

        NameCallback = function(p23, p24) -- Line: 386, Name: NameCallback
            return `{p24.Player.DisplayName}, {p23.Name}`;
        end
    },
    TITLE_75 = {
        Name = "Master of the Golden Ratio",
        Color = Color3.fromRGB(191, 255, 107),
        StrokeColor = Color3.new(1, 0.772549, 0.403922),

        NameCallback = function(p25, p26) -- Line: 394, Name: NameCallback
            return `{p26.Player.DisplayName}, {p25.Name}`;
        end
    },
    TITLE_76 = {
        Name = "The awakening Spin",
        Color = Color3.fromRGB(191, 91, 186)
    },
    TITLE_77 = {
        Name = "Spiral Evolution",
        Color = Color3.fromRGB(221, 91, 221)
    },
    TITLE_78 = {
        Name = "Piercer of Dimensions",
        Color = Color3.fromRGB(255, 78, 252),

        NameCallback = function(p27, p28) -- Line: 409, Name: NameCallback
            return `{p28.Player.DisplayName}, {p27.Name}`;
        end
    },
    TITLE_79 = {
        Name = "Conqueror of Infinite Rotation",
        Color = Color3.fromRGB(255, 200, 0),
        StrokeColor = Color3.fromRGB(255, 78, 252),

        NameCallback = function(p29, p30) -- Line: 417, Name: NameCallback
            return `{p30.Player.DisplayName}, {p29.Name}`;
        end
    },
    TITLE_80 = {
        Name = "is Frozen in Fear",
        Color = Color3.fromRGB(74, 144, 226),

        NameCallback = function(p31, p32) -- Line: 426, Name: NameCallback
            return `{p32.Player.DisplayName} {p31.Name}`;
        end
    },
    TITLE_81 = {
        Name = "The Grouch",
        Color = Color3.fromRGB(150, 113, 23),

        NameCallback = function(p33, p34) -- Line: 434, Name: NameCallback
            return `{p34.Player.DisplayName}, {p33.Name}`;
        end
    },
    TITLE_82 = {
        Name = "Slayer of the Grumpy Yule",
        Color = Color3.fromRGB(194, 24, 7)
    },
    TITLE_83 = {
        Name = "Holiday Hater",
        Color = Color3.fromRGB(107, 15, 26),

        NameCallback = function(p35, p36) -- Line: 446, Name: NameCallback
            return `{p36.Player.DisplayName}, {p35.Name}`;
        end
    },
    TITLE_84 = {
        Name = "Winter\'s Test Subject",
        Color = Color3.fromRGB(180, 216, 231)
    },
    TITLE_85 = {
        Name = "Grimpus Rival",
        Color = Color3.fromRGB(226, 88, 34)
    },
    TITLE_86 = {
        Name = "Jolly",
        Color = Color3.fromRGB(132, 204, 98),

        NameCallback = function(p37, p38) -- Line: 462, Name: NameCallback
            return `{p37.Name} {p38.Player.DisplayName}`;
        end
    },
    TITLE_87 = {
        Name = "Evil Incarnate",
        Color = Color3.fromRGB(189, 0, 0)
    },
    TITLE_88 = {
        Name = "Space Ripper",
        Achievement = "ACHIEVEMENT_50065",
        Color = Color3.fromRGB(80, 15, 159)
    },
    TITLE_89 = {
        Name = "Bloodsight",
        Achievement = "ACHIEVEMENT_50068",
        Color = Color3.fromRGB(176, 0, 3),

        Callback = function(p39, p40, p41) -- Line: 482, Name: Callback
            -- upvalues: ParticleHandler (copy)
            local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
            local v42 = game.Players:GetPlayerFromCharacter(p40);

            if not (v42 and v42.Settings.TitleAuras.Value) then
                return;
            end;

            local u43 = ReplicatedStorage2["Client Assets"].Titles.Bloodsight.Head:Clone();
            u43.Parent = p40.Head;
            u43.Name = "Bloodsight_Aura";
            ParticleHandler.AttachTo(u43, {
                Part = p40.Head
            });
            ParticleHandler.EnableParticle(u43, true);
            p41:Add(function() -- Line: 498
                -- upvalues: ParticleHandler (ref), u43 (copy)
                ParticleHandler.EnableParticle(u43, false);
                ParticleHandler.DestroyEmit(u43);
            end);
        end
    },
    TITLE_90 = {
        Name = "Voidwalker",
        Achievement = "ACHIEVEMENT_50071",
        Color = Color3.fromRGB(0, 0, 0),

        Callback = function(p44, p45, p46) -- Line: 509, Name: Callback
            local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
            game:GetService("TweenService");
            local v47 = game.Players:GetPlayerFromCharacter(p45);

            if not (v47 and v47.Settings.TitleAuras.Value) then
                return;
            end;

            local Voidwalker = ReplicatedStorage2["Client Assets"].Titles.Voidwalker;

            for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Right Leg", "Left Leg" } do
                local v48 = p45:FindFirstChild(v);

                if v48 then
                    local v49 = next;
                    local v50, v51 = Voidwalker:GetChildren();

                    for _, v2 in v49, v50, v51 do
                        local u52 = v2:Clone();
                        u52.Parent = v48;
                        u52.Enabled = true;
                        p46:Add(function() -- Line: 528
                            -- upvalues: u52 (copy)
                            if u52 then
                                u52.Enabled = false;
                                task.delay(u52.Lifetime.Max, u52.Destroy, u52);
                            end;
                        end);
                    end;
                end;
            end;
        end
    },
    TITLE_91 = {
        Name = "Bloodfiend",
        Achievement = "ACHIEVEMENT_50074",
        Color = Color3.fromRGB(195, 0, 3),

        Callback = function(p53, u54, u55) -- Line: 543, Name: Callback
            -- upvalues: RunService (copy), ParticleHandler (copy)
            local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
            local v56 = game.Players:GetPlayerFromCharacter(u54);

            if not (v56 and v56.Settings.TitleAuras.Value) then
                return;
            end;

            local Aura = ReplicatedStorage2["Client Assets"].Titles.Bloodfiend.Aura;

            for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Right Leg", "Left Leg" } do
                local v57 = u54:FindFirstChild(v);

                if v57 then
                    local v58 = next;
                    local v59, v60 = Aura:GetChildren();

                    for _, v2 in v58, v59, v60 do
                        local u61 = v2:Clone();
                        u61.Parent = v57;
                        u61.Enabled = true;
                        u55:Add(function() -- Line: 561
                            -- upvalues: u61 (copy)
                            if u61 then
                                u61.Enabled = false;
                                task.delay(u61.Lifetime.Max, u61.Destroy, u61);
                            end;
                        end);
                    end;
                end;
            end;

            task.spawn(function() -- Line: 570
                -- upvalues: ReplicatedStorage2 (copy), u55 (copy), u54 (copy), RunService (ref)
                local Trail = ReplicatedStorage2["Client Assets"].Titles.Bloodfiend.Trail;
                local u62 = 0;
                task.spawn(function() -- Line: 576
                    -- upvalues: u55 (ref), Trail (copy), u54 (ref), RunService (ref), u62 (ref)
                    local u63 = u55:Clone(Trail);
                    u63.Parent = workspace.Effects;
                    local Head = u54.Head;
                    u55:Connect(RunService.Heartbeat, function(p64) -- Line: 584
                        -- upvalues: u62 (ref), Head (copy), u63 (copy)
                        u62 = (u62 + p64 * 3.141592653589793) % 6.283185307179586;
                        local v65 = Head.Position + Vector3.new(0, 1, 0);
                        local v66 = math.cos(u62) * 2;
                        local v67 = math.sin(u62) * 2;
                        u63.Position = v65 + Vector3.new(v66, 0, v67);
                    end);
                    task.wait(0.4);
                end);
            end);
            local u68 = ReplicatedStorage2["Client Assets"].Titles.Bloodfiend.Pool:Clone();
            u68.Parent = u54;
            u68.Name = "Bloodfiend_Pool";
            ParticleHandler.AttachTo(u68, {
                Part = u54.HumanoidRootPart,
                Offset = CFrame.new(0, 3, 0)
            });
            ParticleHandler.EnableParticle(u68, true);
            u55:Add(function() -- Line: 606
                -- upvalues: ParticleHandler (ref), u68 (copy)
                ParticleHandler.EnableParticle(u68, false);
                ParticleHandler.DestroyEmit(u68);
            end);
        end
    },
    TITLE_92 = {
        Name = "Strange",
        Achievement = "ACHIEVEMENT_3401",
        Color = Color3.fromHex("#CF6A32"),

        NameCallback = function(p69, p70) -- Line: 618, Name: NameCallback
            return `{p69.Name} {p70.Player.DisplayName}`;
        end
    },
    TITLE_93 = {
        Name = "Unremarkable",
        Achievement = "ACHIEVEMENT_3402",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_94 = {
        Name = "Scarcely Lethal",
        Achievement = "ACHIEVEMENT_3403",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_95 = {
        Name = "Mildly Menacing",
        Achievement = "ACHIEVEMENT_3404",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_96 = {
        Name = "Somewhat Threatening",
        Achievement = "ACHIEVEMENT_3405",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_97 = {
        Name = "Uncharitable",
        Achievement = "ACHIEVEMENT_3406",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_98 = {
        Name = "Notably Dangerous",
        Achievement = "ACHIEVEMENT_3407",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_99 = {
        Name = "Sufficiently Lethal",
        Achievement = "ACHIEVEMENT_3408",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_100 = {
        Name = "Truly Feared",
        Achievement = "ACHIEVEMENT_3409",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_101 = {
        Name = "Spectacularly Lethal",
        Achievement = "ACHIEVEMENT_3410",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_102 = {
        Name = "Spattered",
        Achievement = "ACHIEVEMENT_3411",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_103 = {
        Name = "Wicked Nasty",
        Achievement = "ACHIEVEMENT_3412",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_104 = {
        Name = "Postively Inhumane",
        Achievement = "ACHIEVEMENT_3413",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_105 = {
        Name = "Totally Ordinary",
        Achievement = "ACHIEVEMENT_3414",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_106 = {
        Name = "Face-Melting",
        Achievement = "ACHIEVEMENT_3415",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_107 = {
        Name = "Rage-Inducing",
        Achievement = "ACHIEVEMENT_3416",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_108 = {
        Name = "Server-Clearing",
        Achievement = "ACHIEVEMENT_3417",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_109 = {
        Name = "EPIX",
        Achievement = "ACHIEVEMENT_3418",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_110 = {
        Name = "LEGENDARIE",
        Achievement = "ACHIEVEMENT_3419",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_111 = {
        Name = "AUSTRALIAN",
        Achievement = "ACHIEVEMENT_3420",
        Color = Color3.fromHex("#CF6A32")
    },
    TITLE_112 = {
        Name = "HALE\'S OWN",
        Achievement = "ACHIEVEMENT_3421",
        Color = Color3.fromHex("#CF6A32"),

        NameCallback = function(p71, p72) -- Line: 738, Name: NameCallback
            return `{p71.Name} {p72.Player.DisplayName}`;
        end
    },
    TITLE_113 = {
        Name = "The Eternal Reward",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_114 = {
        Name = "Met The Spy",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_115 = {
        Name = "Unusual Effect",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_116 = {
        Name = "Cloaked with a Dagger",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_117 = {
        Name = "Real Good, Son",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_118 = {
        Name = "MEDIC!",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_119 = {
        Name = "Bonk!",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_120 = {
        Name = "Pootis",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_121 = {
        Name = "W+M1 Enthusiast",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_122 = {
        Name = "Getta Load of Dis Guy",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_123 = {
        Name = "No Scope Required",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_124 = {
        Name = "Sandvich Consumer",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_125 = {
        Name = "Mann of Honor",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_126 = {
        Name = "One Mann Army",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_127 = {
        Name = "Mann of Mystery",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_128 = {
        Name = "Mann Up",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_129 = {
        Name = "A Man of Fine Taste",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_130 = {
        Name = "Gentle Mann’s Assassin",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_131 = {
        Name = "Your Best Friend",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_132 = {
        Name = "May I borrow Your Title",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_133 = {
        Name = "Big Earner",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_134 = {
        Name = "Gott Mit Uns",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_135 = {
        Name = "Top Notch Sharpshooter",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_136 = {
        Name = "Your Colleague",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_137 = {
        Name = "Knife to Meet You",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_139 = {
        Name = "On Fire (Literally)",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_140 = {
        Name = "War Crime Committer",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_141 = {
        Name = "Six-String Stinger",
        Color = Color3.fromRGB(252, 151, 255)
    },
    TITLE_142 = {
        Name = "The Big Guy’s Lunch",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_143 = {
        Name = "Tough Break",
        Color = Color3.fromRGB(207, 129, 255)
    },
    TITLE_144 = {
        Name = "Key of Kason",
        Color = Color3.fromHex("#d1e3ff")
    }
};
local v74 = {
    Name = "Visitor",
    Font = Enum.Font.Nunito
};
local v75 = Color3.fromRGB(255, 234, 217);
local v76 = Color3.fromRGB(255, 155, 88);
local v77 = Color3.fromRGB(255, 82, 82);
v74.Color = v75:Lerp(v76, 0.1111111111111111):Lerp(v76:Lerp(v77, 0.1111111111111111), 0.1111111111111111);
v73.TITLE_145 = v74;
local v78 = {
    Name = "Intern",
    Font = Enum.Font.Nunito
};
local v79 = Color3.fromRGB(255, 234, 217);
local v80 = Color3.fromRGB(255, 155, 88);
local v81 = Color3.fromRGB(255, 82, 82);
v78.Color = v79:Lerp(v80, 0.2222222222222222):Lerp(v80:Lerp(v81, 0.2222222222222222), 0.2222222222222222);
v73.TITLE_146 = v78;
local v82 = {
    Name = "Research Assistant",
    Font = Enum.Font.Nunito
};
local v83 = Color3.fromRGB(255, 234, 217);
local v84 = Color3.fromRGB(255, 155, 88);
local v85 = Color3.fromRGB(255, 82, 82);
v82.Color = v83:Lerp(v84, 0.3333333333333333):Lerp(v84:Lerp(v85, 0.3333333333333333), 0.3333333333333333);
v73.TITLE_147 = v82;
local v86 = {
    Name = "Junior Researcher",
    Font = Enum.Font.Nunito
};
local v87 = Color3.fromRGB(255, 234, 217);
local v88 = Color3.fromRGB(255, 155, 88);
local v89 = Color3.fromRGB(255, 82, 82);
v86.Color = v87:Lerp(v88, 0.4444444444444444):Lerp(v88:Lerp(v89, 0.4444444444444444), 0.4444444444444444);
v73.TITLE_148 = v86;
local v90 = {
    Name = "Researcher",
    Font = Enum.Font.Nunito
};
local v91 = Color3.fromRGB(255, 234, 217);
local v92 = Color3.fromRGB(255, 155, 88);
local v93 = Color3.fromRGB(255, 82, 82);
v90.Color = v91:Lerp(v92, 0.5555555555555556):Lerp(v92:Lerp(v93, 0.5555555555555556), 0.5555555555555556);
v73.TITLE_149 = v90;
local v94 = {
    Name = "Senior Researcher",
    Font = Enum.Font.Nunito
};
local v95 = Color3.fromRGB(255, 234, 217);
local v96 = Color3.fromRGB(255, 155, 88);
local v97 = Color3.fromRGB(255, 82, 82);
v94.Color = v95:Lerp(v96, 0.6666666666666666):Lerp(v96:Lerp(v97, 0.6666666666666666), 0.6666666666666666);
v73.TITLE_150 = v94;
local v98 = {
    Name = "Lead Researcher",
    Font = Enum.Font.Nunito
};
local v99 = Color3.fromRGB(255, 234, 217);
local v100 = Color3.fromRGB(255, 155, 88);
local v101 = Color3.fromRGB(255, 82, 82);
v98.Color = v99:Lerp(v100, 0.7777777777777778):Lerp(v100:Lerp(v101, 0.7777777777777778), 0.7777777777777778);
v73.TITLE_151 = v98;
local v102 = {
    Name = "Scientist",
    Font = Enum.Font.Nunito
};
local v103 = Color3.fromRGB(255, 234, 217);
local v104 = Color3.fromRGB(255, 155, 88);
local v105 = Color3.fromRGB(255, 82, 82);
v102.Color = v103:Lerp(v104, 1):Lerp(v104:Lerp(v105, 1), 1);
v73.TITLE_152 = v102;
local v106 = {
    Name = "Chief Scientist",
    Font = Enum.Font.Nunito
};
local v107 = Color3.fromRGB(255, 234, 217);
local v108 = Color3.fromRGB(255, 155, 88);
local v109 = Color3.fromRGB(255, 82, 82);
v106.Color = v107:Lerp(v108, 1):Lerp(v108:Lerp(v109, 1), 1);
v73.TITLE_153 = v106;
v73.TITLE_154 = {
    Name = "Gateway \"Certified\"",
    Font = Enum.Font.Nunito,
    Color = Color3.fromRGB(64, 156, 255)
};
v73.TITLE_155 = {
    Name = "Starstruck",
    FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    Color = Color3.fromRGB(221, 135, 255)
};
v73.TITLE_156 = {
    Name = "Heir of Burden",
    FontFace = Font.new("rbxassetid://12187368317", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    Color = Color3.fromRGB(64, 99, 255)
};
v73.TITLE_157 = {
    Name = "The Anomaly",
    FontFace = Font.new("rbxassetid://12187370928", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    Color = Color3.fromRGB(85, 170, 255)
};
v73.TITLE_158 = {
    Name = "Easy Target",
    Color = Color3.fromRGB(162, 162, 162),

    NameCallback = function(p110, p111) -- Line: 945, Name: NameCallback
        return `{p111.Player.DisplayName}, {p110.Name}`;
    end
};
v73.TITLE_159 = {
    Name = "Actual Thief",
    Color = Color3.fromRGB(179, 39, 41),

    NameCallback = function(p112, p113) -- Line: 953, Name: NameCallback
        return `{p113.Player.DisplayName}, {p112.Name}`;
    end
};
v73.TITLE_160 = {
    Name = "Chief Logistics Officer",
    Color = Color3.fromRGB(254, 191, 4),

    NameCallback = function(p114, p115) -- Line: 961, Name: NameCallback
        return `{p115.Player.DisplayName}, {p114.Name}`;
    end,

    Callback = function(p116, p117, p118) -- Line: 964, Name: Callback
        local TweenService = game:GetService("TweenService");
        local Title = p116.Title;
        Color3.fromRGB(254, 191, 4);
        local v119 = Color3.fromRGB(206, 130, 0);
        Title.Rotation = -5;
        local v120 = TweenService:Create(Title, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            TextColor3 = v119
        });
        local v121 = TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Rotation = 5
        });
        v120:Play();
        v121:Play();
        p118:Add(v120);
        p118:Add(v121);
        p118:Add(function() -- Line: 987
            -- upvalues: Title (copy)
            Title.Rotation = 0;
        end);
    end
};
v73.TITLE_161 = {
    Name = "Priority-Class Courier",
    Color = Color3.fromRGB(254, 135, 38)
};
v73.TITLE_162 = {
    Name = "GOLD GOLD GOLD!",
    Color = Color3.fromRGB(254, 170, 24),

    Callback = function(p122, p123, p124) -- Line: 1001, Name: Callback
        local RunService2 = game:GetService("RunService");
        local Title = p122.Title;
        local u125 = 0;
        p124:Add((RunService2.Heartbeat:Connect(function() -- Line: 1006
            -- upvalues: u125 (ref), Title (copy)
            u125 = (u125 + 2) % 360;
            Title.TextColor3 = Color3.fromHSV(u125 / 360, 0.8, 1);
        end)));
    end
};
v73.TITLE_163 = {
    Name = "The Camellite Guardian",
    Color = Color3.fromRGB(206, 127, 254),

    Callback = function(p126, p127, p128) -- Line: 1018, Name: Callback
        if not p126 then
            return;
        end;

        local Title = p126.Title;
        local Parent = p126.Parent;
        local u129 = p128:Clone(Parent);
        local Content = u129:FindFirstChild("Content");

        if not Content then
            u129:Destroy();

            return;
        end;

        for _, child in Content:GetChildren() do
            if child.Name ~= "Title" then
                child:Destroy();
            end;
        end;

        u129.Name = "_fakehud";
        Title.Visible = false;
        p128:Add(function() -- Line: 1040
            -- upvalues: Title (copy)
            Title.Visible = true;
        end);
        p128:Connect(Parent:GetPropertyChangedSignal("Enabled"), function() -- Line: 1043
            -- upvalues: u129 (copy), Parent (copy)
            u129.Enabled = Parent.Enabled;
        end);
        u129.Brightness = 3;
        u129.Parent = Parent;
        local Title2 = Content:FindFirstChild("Title");
        Title2.TextColor3 = Color3.new(1, 1, 1);
        local UIGradient = Instance.new("UIGradient");
        p128:Add(UIGradient);
        UIGradient.Rotation = 90;
        UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromHex("#da83ff")), ColorSequenceKeypoint.new(1, Color3.fromHex("#ff743d")) });
        UIGradient.Parent = Title2;
    end
};
v73.TITLE_164 = {
    Name = "Δ",
    FontFace = Font.new("rbxasset://fonts/families/Guru.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal),
    Color = Color3.fromRGB(49, 255, 56),

    Callback = function(p130, p131, u132) -- Line: 1068, Name: Callback
        if not p130 then
            return;
        end;

        local TweenService = game:GetService("TweenService");
        local Title = p130.Title;
        local Parent = p130.Parent;
        local u133 = u132:Clone(Parent);
        local Content = u133:FindFirstChild("Content");

        if not Content then
            u133:Destroy();

            return;
        end;

        for _, child in Content:GetChildren() do
            if child.Name ~= "Title" then
                child:Destroy();
            end;
        end;

        u133.Name = "_fakehud";
        Title.Visible = false;
        u132:Add(function() -- Line: 1091
            -- upvalues: Title (copy)
            Title.Visible = true;
        end);
        u132:Connect(Parent:GetPropertyChangedSignal("Enabled"), function() -- Line: 1094
            -- upvalues: u133 (copy), Parent (copy)
            u133.Enabled = Parent.Enabled;
        end);
        u133.Brightness = 3;
        u133.Parent = Parent;
        local Title2 = Content:FindFirstChild("Title");
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Size = UDim2.fromScale(0.8, 1);
        ImageLabel.AnchorPoint = Vector2.one * 0.5;
        ImageLabel.Position = Title2.Position;
        ImageLabel.ZIndex = -10;
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = "rbxassetid://6673021984";
        ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0);
        u132:Add(ImageLabel);
        task.spawn(function() -- Line: 1113
            -- upvalues: TweenService (copy), ImageLabel (copy), u132 (copy)
            local v134 = TweenService:Create(ImageLabel, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
                ImageTransparency = 0.5
            });
            v134:Play();
            u132:Add(v134);
        end);
        local UIGradient = Instance.new("UIGradient");
        u132:Add(UIGradient);
        UIGradient.Rotation = 90;
        UIGradient.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0)) });
        UIGradient.Parent = Title2;
        ImageLabel.Parent = Content;
    end
};
v73.TITLE_165 = {
    Name = "yearns for the mines ⛏️",
    Color = Color3.fromRGB(175, 64, 255),

    NameCallback = function(p135, p136) -- Line: 1141, Name: NameCallback
        return `{p136.Player.DisplayName} {p135.Name}`;
    end
};
v73.TITLE_166 = {
    Name = "Space Hazard",
    Color = Color3.fromRGB(26, 20, 31)
};
v73.TITLE_167 = {
    Name = "Ordinary Life",
    Color = Color3.new(0.290196, 0.788235, 1),

    NameCallback = function(p137, p138) -- Line: 1154, Name: NameCallback
        return `{p138.Player.DisplayName}'s {p137.Name}`;
    end
};
v73.TITLE_10000 = {
    Name = "Developer",
    Color = Color3.fromRGB(110, 37, 255)
};
v73.TITLE_10001 = {
    Name = "MAYHEM",
    Color = Color3.new(0.25, 0, 0),
    StrokeColor = Color3.new(1, 0, 0),
    Font = Enum.Font.Antique,

    Callback = function(p139, p140, p141) -- Line: 1170, Name: Callback
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        local TweenService = game:GetService("TweenService");
        local EffectsHandler = require(ReplicatedStorage2.ReplicatedModules.EffectsHandler);
        local Title = p139.Title;
        local u142 = TweenService:Create(Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            TextStrokeColor3 = Color3.new()
        });
        local u143 = TweenService:Create(Title, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            TextStrokeColor3 = Title.TextStrokeColor3
        });
        p141:Add(function() -- Line: 1182
            -- upvalues: u143 (copy), u142 (copy)
            u143:Cancel();
            u142:Cancel();
            u142:Destroy();
            u143:Destroy();
        end);
        u142:Play();
        p141:Connect(u142.Completed, function(p144) -- Line: 1191
            -- upvalues: u143 (copy), EffectsHandler (copy), u142 (copy)
            if p144 == Enum.TweenStatus.Canceled then
                return;
            end;

            u143:Play();
            EffectsHandler.Wait(0.375);
            u142:Play();
        end);
    end
};
v73.TITLE_10002 = {
    Name = ":3",
    Color = Color3.fromRGB(255, 143, 231)
};
v73.TITLE_61 = {
    Name = "🐺",
    Color = Color3.fromRGB(0, 0, 0)
};
v73.TITLE_59 = {
    Name = "Master Of Time",
    Color = Color3.fromRGB(134, 255, 168)
};
v73.TITLE_200 = {
    Name = "Devil May Cry",
    Color = Color3.new(1, 1, 1),

    Callback = function(p145, p146, p147) -- Line: 1218, Name: Callback
        -- upvalues: EasyVisuals (copy)
        local HumanoidRootPart = p146.HumanoidRootPart;
        local v148 = p147:Clone(p145.Parent);
        v148.Name = "TitleHud";
        local Title = p145.Title;
        v148:ClearAllChildren();
        v148.LightInfluence = 0;
        v148.Brightness = 1.5;
        Title.Parent = v148;
        v148.Adornee = HumanoidRootPart;
        v148.Parent = HumanoidRootPart;
        p147:Add(EasyVisuals.new(Title, "DMC", 0.5));
    end
};
v73.TITLE_201 = {
    Name = "The First One",
    FontFace = Font.new("rbxassetid://12187376739", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
    Color = Color3.fromRGB(255, 0, 4),

    Callback = function(p149, p150, p151) -- Line: 1242, Name: Callback
        local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
        game:GetService("TweenService");
        local v152 = game.Players:GetPlayerFromCharacter(p150);

        if not (v152 and v152.Settings.TitleAuras.Value) then
            return;
        end;

        local FirstOne = ReplicatedStorage2["Client Assets"].Titles.FirstOne;

        for _, v in { "Head", "Torso", "Left Arm", "Right Arm", "Right Leg", "Left Leg" } do
            local v153 = p150:FindFirstChild(v);

            if v153 then
                local v154 = next;
                local v155, v156 = FirstOne:GetChildren();

                for _, v2 in v154, v155, v156 do
                    local u157 = v2:Clone();
                    u157.Parent = v153;
                    u157.Enabled = true;
                    p151:Add(function() -- Line: 1261
                        -- upvalues: u157 (copy)
                        if u157 then
                            u157.Enabled = false;
                            task.delay(u157.Lifetime.Max, u157.Destroy, u157);
                        end;
                    end);
                end;
            end;
        end;
    end
};

return v73;