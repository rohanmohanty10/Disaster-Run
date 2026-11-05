  

 

local u1 = {};
local u2 = {};
local v3 = {};
local u4 = {};
local v5 = {};
local u6 = {};
local u7 = {};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            Q = "Summon Tusk",
            One = "ACT DOWN",
            Two = "ACT UP",
            E = "Barrage",
            ["SUB-E"] = "Wormhole Barrage",
            LMB = "LMB Combo",
            R = "Scratch",
            ["SUB-R"] = "Skull Bash",
            C = "Dash",
            F = "Last Resort",
            H = "Dark Determination",
            ["SUB-F"] = "Rotational Guidance",
            G = "Wormhole Nail Shot",
            T = "Nail Shot",
            V = "Nail Glide",
            ["SUB-V"] = "Unrelenting Assault",
            X = "Block",
            B = "Herbal Tea",
            J = "Horse",
            Y = "Wormhole Crash"
        }
    },
    Animations = {
        Action = {
            Barrage = 7056069797,
            ["Strong Punch"] = 7364363789,
            ["Heavy Punch"] = 7209760261,
            Scratch = 7024678264,
            Glide = 7024676952,
            NailShot = 7032002952,
            Tea = 7058431247,
            ChargedNailShot = 7032000229,
            Wormhole = 6017451715,
            StandUp = 7038048657,
            BallEquip = 7039224922,
            BallCharge = 7039210945,
            BallRelease = 7039212218,
            Block = 7052155676,
            Sit = 5718959564,
            TuskEnter = 7065554384,
            TuskExit = 7065619313,
            Slam = 7070621142,
            Determination = 7071178699,
            ShakingCamera = 10169802618,
            Camera = 10169800701,
            BeatdownVictim = 10153048045,
            BeatdownTusk = 10153226033
        },
        Movement = {
            Run = 7037969480,
            Walk = 6877996750
        },
        Idle = {
            Idle = 7473273038,
            ACT1Idle = 5995500285,
            ACT2Idle = 10382725748,
            ACT3Idle = 10382743443,
            ACT4Idle = 10382756362
        }
    },
    Stats = {
        ["Summon Tusk"] = {
            Cooldown = 1,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 112, 190)), ColorSequenceKeypoint.new(1, Color3.fromRGB(179, 172, 255)) }),
            LeaveParts = { "StandHumanoidRootPart", "Trans" },
            callbacks = {
                client = function(p8, p9, p10) -- Line: 90, Name: client
                    -- upvalues: u1 (copy), u2 (copy)
                    if not u1:HasTag(p9, "Summoned") then
                        u2.playClient("Tusk", "ACT" .. p8.Data.ACTValue.Value .. "Idle");

                        return;
                    end;

                    u2.stopClient("Tusk", "ACT" .. 1 .. "Idle");
                    u2.stopClient("Tusk", "ACT" .. 2 .. "Idle");
                    u2.stopClient("Tusk", "ACT" .. 3 .. "Idle");
                    u2.stopClient("Tusk", "ACT" .. 4 .. "Idle");
                end
            }
        },
        ["ACT UP"] = {
            Checks = v3,

            CustomInvoke = function(p11) -- Line: 105, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy), u2 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 108
                    -- upvalues: LocalPlayer (copy), u1 (ref), Character (copy), u4 (ref), u2 (ref)
                    local ACTValue = LocalPlayer.Data.ACTValue;
                    local Cooldowns = LocalPlayer.Cooldowns;

                    if LocalPlayer["Ability Progress"].Tusk.Value < ACTValue.Value + 1 then
                        return;
                    end;

                    if Cooldowns:FindFirstChild("ACTCHANGED") or (Cooldowns:FindFirstChild("Q") or ACTValue.Value >= 4) then
                        return;
                    end;

                    if u1:HasTag(Character, "Mounted") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("Two");
                    u4:InvokeServer("Q");
                    u2.playClient("Tusk", "ACT" .. ACTValue.Value .. "Idle");
                end));
            end
        },
        ["ACT DOWN"] = {
            Checks = v3,

            CustomInvoke = function(p12) -- Line: 125, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy), u2 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 128
                    -- upvalues: LocalPlayer (copy), u1 (ref), Character (copy), u4 (ref), u2 (ref)
                    local ACTValue = LocalPlayer.Data.ACTValue;
                    local Cooldowns = LocalPlayer.Cooldowns;

                    if Cooldowns:FindFirstChild("ACTCHANGED") or (Cooldowns:FindFirstChild("Q") or ACTValue.Value <= 1) then
                        return;
                    end;

                    if u1:HasTag(Character, "Mounted") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("One");
                    u4:InvokeServer("Q");
                    u2.playClient("Tusk", "ACT" .. ACTValue.Value .. "Idle");
                end));
            end
        },
        Taunt = {
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true
            },
            Quotes = {
                {
                    "You seem to have a lot of free time on your hands.",
                    "rbxassetid://7024693947",
                    {
                        ["You seem to have..."] = 0.75
                    },
                    2,
                    3,

                    Check = function(p13, p14, p15) -- Line: 151, Name: Check
                        return p13.Data.ACTValue.Value == 1;
                    end
                },
                {
                    "Did the president send you after me?! I\'m not handing over the corpse!",
                    "rbxassetid://7024695107",
                    {
                        ["Stand up."] = 1.25
                    },
                    2,
                    2.5,
                    nil,

                    Check = function(p16, p17, p18) -- Line: 160, Name: Check
                        return p16.Data.ACTValue.Value == 1;
                    end
                },
                {
                    "I\'m gonna crush you at all costs!",
                    "rbxassetid://7024697369",
                    {},
                    2,
                    1.5,
                    nil,

                    Check = function(p19, p20, p21) -- Line: 170, Name: Check
                        return p19.Data.ACTValue.Value == 1;
                    end
                },
                {
                    "What the hell are you doing?",
                    "rbxassetid://6253979987",
                    {},
                    2,
                    2.5,

                    Check = function(p22, p23, p24) -- Line: 179, Name: Check
                        return p22.Data.ACTValue.Value == 2;
                    end
                },
                {
                    "If I\'m lost, I\'ll shoot, but I\'m not lost anymore.",
                    "rbxassetid://6254044677",
                    {
                        ["If I\'m lost, I\'ll shoot,"] = 1
                    },
                    2,
                    2,
                    nil,

                    Check = function(p25, p26, p27) -- Line: 188, Name: Check
                        return p25.Data.ACTValue.Value == 2;
                    end
                },
                {
                    "What a joke.",
                    "rbxassetid://6253981430",
                    {},
                    2,
                    1.5,

                    Check = function(p28, p29, p30) -- Line: 197, Name: Check
                        return p28.Data.ACTValue.Value == 3;
                    end
                },
                {
                    "Lesson four: show some respect.",
                    "rbxassetid://6254095894",
                    {
                        ["Lesson four:"] = 1
                    },
                    2,
                    2,
                    nil,

                    Check = function(p31, p32, p33) -- Line: 206, Name: Check
                        return p31.Data.ACTValue.Value == 3;
                    end
                },
                {
                    "I\'m not giving up.",
                    "rbxassetid://7042014947",
                    {},
                    2,
                    2,

                    Check = function(p34, p35, p36) -- Line: 215, Name: Check
                        return p34.Data.ACTValue.Value == 3;
                    end
                },
                {
                    "I\'m going to take you down.",
                    "rbxassetid://7042017049",
                    {},
                    nil,
                    nil,

                    Check = function(p37, p38, p39) -- Line: 223, Name: Check
                        return p37.Data.ACTValue.Value == 3;
                    end
                },
                {
                    "You\'re in range of the nail bullets, I\'ll take care of you immediately.",
                    "rbxassetid://6253981721",
                    {},
                    2,
                    2.5,
                    nil,

                    Check = function(p40, p41, p42) -- Line: 232, Name: Check
                        return p40.Data.ACTValue.Value == 4;
                    end
                },
                {
                    "I\'m trying to get out of this situation.",
                    "rbxassetid://7055698289",
                    {},
                    2,
                    2.5,

                    Check = function(p43, p44, p45) -- Line: 241, Name: Check
                        return p43.Data.ACTValue.Value == 4;
                    end
                },
                {
                    "It doesn\'t matter who lives or who dies, what\'s justice or what\'s right!",
                    "rbxassetid://7055698588",
                    {},
                    2,
                    3,
                    nil,

                    Check = function(p46, p47, p48) -- Line: 248, Name: Check
                        return p46.Data.ACTValue.Value == 4;
                    end
                },
                {
                    "It\'s all over.",
                    "rbxassetid://7055705456",
                    {},
                    2,
                    nil,

                    Check = function(p49, p50, p51) -- Line: 257, Name: Check
                        return p49.Data.ACTValue.Value == 4;
                    end
                }
            }
        },
        ["LMB Combo"] = {
            Damage = 10,
            Cooldown = 0.05,
            Stun = 0.5,
            InfiniteSpin = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 25, 0.05 },
            Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            HitData = {
                Color = Color3.fromRGB(193, 193, 193)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -2.25)
            }
        },
        Barrage = {
            Length = 4,
            Cooldown = 12,
            Aftermove = true,
            InfiniteSpin = true,
            Checks = v3,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -4.5)
            },
            callbacks = {
                client = function(p52, p53, p54) -- Line: 300, Name: client
                    -- upvalues: u1 (copy), u2 (copy), u6 (copy)
                    if p52.Data.ACTValue.Value ~= 4 or u1:HasTag(p53, "Mounted") then
                        return;
                    end;

                    local v55 = u2.playClient("Tusk", "Barrage");
                    local v56 = tick();

                    repeat
                        wait();
                    until tick() - v56 > 4 or (not u6:IsKeyDown(Enum.KeyCode.E) or (not p52 or (not p52.Parent or p52.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                    v55:Stop();
                end
            },

            CustomInvoke = function(p57) -- Line: 313, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 316
                    -- upvalues: LocalPlayer (copy), u1 (ref), Character (copy), u4 (ref)
                    if table.find({ 1, 2, 3 }, LocalPlayer.Data.ACTValue.Value) then
                        return;
                    end;

                    if u1:HasTag(Character, "Mounted") then
                        if LocalPlayer.Cooldowns:FindFirstChild("SUB-E") then
                            return;
                        end;

                        Character.Values.Active.Value = "temp";
                        u4:InvokeServer("SUB-E");

                        return;
                    end;

                    if LocalPlayer.Cooldowns:FindFirstChild("E") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("E");
                end));
            end
        },
        ["Wormhole Barrage"] = {
            Length = 2.7,
            Cooldown = 15,
            Aftermove = true,
            InfiniteSpin = true,
            Checks = v3,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -5.5)
            }
        },
        ["Nail Glide"] = {
            Cooldown = 15,
            Checks = v3,

            CustomInvoke = function(p58) -- Line: 348, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 351
                    -- upvalues: LocalPlayer (copy), u1 (ref), Character (copy), u4 (ref)
                    local Value = LocalPlayer.Data.ACTValue.Value;

                    if Value ~= 4 then
                        if Value == 1 then
                            if LocalPlayer.Cooldowns:FindFirstChild("V") then
                                return;
                            end;

                            Character.Values.Active.Value = "temp";
                            u4:InvokeServer("V");
                        end;

                        return;
                    end;

                    if LocalPlayer.Cooldowns:FindFirstChild("SUB-V") or u1:HasTag(Character, "Mounted") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("SUB-V");
                end));
            end
        },
        ["Unrelenting Assault"] = {
            Cooldown = 85,
            AfterMove = true,
            Damage = 3.5,
            BlockBreak = true,
            UnBlockable = true,
            Aftermove = true,
            InfiniteSpin = true,
            Checks = v3,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(125, 184, 255)
            },
            LoveTrainBD = {
                AfterMove = true,
                Damage = 1.7,
                BlockBreak = true,
                UnBlockable = true,
                InfiniteSpin = true,
                IgnoreUnhitable = true
            }
        },
        ["Wormhole Crash"] = {
            Cooldown = 10,
            Damage = 35,
            Stun = 1.2,
            InfiniteSpin = true,
            Checks = v3,
            HitAnimation = v5,
            Remotes = { { "FX", "HeavyEffect" } },
            Knockback = { 45, 0.15 },
            HitData = {
                Color = Color3.fromRGB(255, 255, 255)
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 10.5,
                HitAnimation = v5,
                Offset = CFrame.new(0, 0, 0)
            },

            CustomInvoke = function(p59) -- Line: 409, Name: CustomInvoke
                -- upvalues: u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;

                if table.find({ 1, 2, 3 }, LocalPlayer.Data.ACTValue.Value) then
                    return;
                end;

                coroutine.wrap(function() -- Line: 415
                    -- upvalues: LocalPlayer (copy), Character (copy), u4 (ref)
                    local v60 = LocalPlayer:GetMouse();
                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("Y", v60.Hit);
                end)();
            end
        },
        Scratch = {
            Cooldown = 8,
            Damage = 10,
            Stun = 1,
            BlockBreak = true,
            InfiniteSpin = true,
            Checks = v3,
            Knockback = { 35, 0.15 },
            HitAnimation = v5,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(125, 184, 255)
            },
            Sound = { { "rbxassetid://7026283615", 1, 0, false } },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                HitAnimation = v5,
                Offset = CFrame.new(0, 0, -5)
            },

            CustomInvoke = function(p61) -- Line: 446, Name: CustomInvoke
                -- upvalues: u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 449
                    -- upvalues: LocalPlayer (copy), Character (copy), u4 (ref)
                    if LocalPlayer.Data.ACTValue.Value == 4 then
                        if LocalPlayer.Cooldowns:FindFirstChild("SUB-R") then
                            return;
                        end;

                        Character.Values.Active.Value = "temp";
                        u4:InvokeServer("SUB-R");

                        return;
                    end;

                    if LocalPlayer.Cooldowns:FindFirstChild("R") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("R");
                end));
            end
        },
        ["Skull Bash"] = {
            Cooldown = 8,
            Damage = 20,
            Stun = 0.75,
            BlockBreak = true,
            InfiniteSpin = true,
            Checks = v3,
            HitAnimation = v5,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(148, 0, 2)
            },
            Sound = { { "rbxassetid://7055317022", 0.8, 0, false } },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                HitAnimation = v5,
                Offset = CFrame.new(0, 0, -5)
            }
        },
        ["Nail Shot"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },

            CustomInvoke = function(p62) -- Line: 489, Name: CustomInvoke
                -- upvalues: u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;

                if LocalPlayer.Cooldowns:FindFirstChild("T") then
                    return;
                end;

                Character.Values.Active.Value = "temp";
                u4:InvokeServer("T");
            end
        },
        ["Last Resort"] = {
            Cooldown = 12,
            AfterMove = true,
            InfiniteSpin = true,
            Checks = v3,

            CustomInvoke = function(p63) -- Line: 502, Name: CustomInvoke
                -- upvalues: u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 505
                    -- upvalues: LocalPlayer (copy), Character (copy), u4 (ref)
                    local Value = LocalPlayer.Data.ACTValue.Value;

                    if Value ~= 4 then
                        if Value == 2 or Value == 3 then
                            if LocalPlayer.Cooldowns:FindFirstChild("F") then
                                return;
                            end;

                            Character.Values.Active.Value = "temp";
                            u4:InvokeServer("F");
                        end;

                        return;
                    end;

                    if LocalPlayer.Cooldowns:FindFirstChild("SUB-F") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("SUB-F");
                end));
            end
        },
        ["Rotational Guidance"] = {
            Cooldown = 12.25,
            Damage = 9.25,
            Stun = 0.7,
            InfiniteSpin = true,
            Checks = v3,
            HitAnimation = v5,
            Remotes = { { "FX", "HeavyEffect" } },
            HitData = {
                Color = Color3.fromRGB(148, 0, 2)
            },
            Sound = { { "rbxassetid://7072545145", 3, 0, false } },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6.8,
                HitAnimation = v5,
                Offset = CFrame.new(0, 0, -7)
            }
        },
        ["Wormhole Nail Shot"] = {
            Cooldown = 10,
            Checks = v3,

            CustomInvoke = function(p64) -- Line: 545, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 548
                    -- upvalues: LocalPlayer (copy), Character (copy), u1 (ref), u4 (ref)
                    if table.find({ 1, 4 }, LocalPlayer.Data.ACTValue.Value) then
                        return;
                    end;

                    if Character.Humanoid.FloorMaterial == Enum.Material.Air or u1:HasTag(Character, "Mounted") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("G");
                end));
            end
        },
        ["Herbal Tea"] = {
            Heal = 40,
            Cooldown = 35,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p65, p66, p67) -- Line: 564, Name: client
                    -- upvalues: u2 (copy)
                    local v68 = u2.playClient("Tusk", "Tea");
                    wait(v68.Length * 0.5);
                    v68:AdjustSpeed(1);
                    wait(0.2);
                end
            }
        },
        ["Dark Determination"] = {
            Cooldown = 60,
            Awakening = true,
            Checks = {
                CheckStunned = false,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },

            CustomInvoke = function(p69) -- Line: 578, Name: CustomInvoke
                -- upvalues: u1 (copy), u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                local Humanoid = Character.Humanoid;
                coroutine.resume(coroutine.create(function() -- Line: 582
                    -- upvalues: u1 (ref), Character (copy), Humanoid (copy), LocalPlayer (copy), u4 (ref)
                    if u1:HasTag(Character, "Dark Determination") or Humanoid.Health > Humanoid.MaxHealth * 0.35 then
                        return;
                    end;

                    if LocalPlayer.Cooldowns:FindFirstChild("H") then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("H");
                end));
            end
        },
        Horse = {
            Cooldown = 0,
            CooldownGetOn = 1,
            ActualCooldown = 25,
            MoveName = "Horse",
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p70, u71, p72) -- Line: 598, Name: client
                    -- upvalues: u1 (copy), u2 (copy)
                    if table.find({ 1, 3 }, p70.Data.ACTValue.Value) then
                        return;
                    end;

                    if u1:HasTag(u71, "Mounted") then
                        u2.stopClient("Tusk", "Sit");

                        return;
                    end;

                    local v73 = u2.playClient("Tusk", "Sit");
                    v73.Priority = Enum.AnimationPriority.Action;
                    u71.Humanoid.HipHeight = 4.5;
                    v73.Stopped:Connect(function() -- Line: 606
                        -- upvalues: u71 (copy)
                        u71.Humanoid.HipHeight = 0;
                        local Horse = u71.Horse;
                        Horse:Destroy();

                        repeat
                            wait(0.025);
                        until Horse.Parent == nil;

                        u71.Humanoid.WalkSpeed = 16;
                    end);
                end
            },

            CustomInvoke = function(p74) -- Line: 620, Name: CustomInvoke
                -- upvalues: u4 (copy)
                local LocalPlayer = game.Players.LocalPlayer;
                local Character = LocalPlayer.Character;
                coroutine.resume(coroutine.create(function() -- Line: 623
                    -- upvalues: LocalPlayer (copy), Character (copy), u4 (ref)
                    if table.find({ 1, 3 }, LocalPlayer.Data.ACTValue.Value) then
                        return;
                    end;

                    Character.Values.Active.Value = "temp";
                    u4:InvokeServer("J");
                end));
            end
        },
        Block = {
            Cooldown = 0.2,
            AfterMove = true,
            HideStand = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p75, p76, p77) -- Line: 638, Name: client
                    -- upvalues: u2 (copy), u7 (copy), u6 (copy)
                    local v78 = u2.playClient(u7[p77.Value], "Block");

                    repeat
                        wait(0.001);
                    until not u6:IsKeyDown(Enum.KeyCode.X) or v78.IsPlaying == false;

                    if v78.IsPlaying then
                        v78:Stop();
                    end;
                end
            },
            Summon = {
                Cooldown = 1,
                Checks = {
                    CheckStunned = true,
                    CheckDisabled = true,
                    CheckSummoned = false,
                    CheckActive = true,
                    CheckTimestop = true
                },
                LeaveParts = { "StandHumanoidRootPart", "Trans" },
                callbacks = {
                    client = function(p79, p80, p81) -- Line: 652, Name: client
                        -- upvalues: u2 (copy), u7 (copy)
                        local UserInputService = game:GetService("UserInputService");
                        local v82 = p79 and u2.playClient(u7[p81.Value], "Block") or u2.playClient(u7[p81.Value], "Block", nil, nil, p80:FindFirstChildWhichIsA("Humanoid"), true);

                        repeat
                            wait();
                        until p79 and not UserInputService:IsKeyDown(Enum.KeyCode.X) or (p79 == nil and p80.Values.Block.Value == "None" or v82.IsPlaying == false);

                        if v82.IsPlaying then
                            v82:Stop();
                        end;
                    end
                }
            }
        }
    },
    Sounds = {
        BeatdownVoice = {
            SoundId = "rbxassetid://10468229634",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownSFX = {
            SoundId = "rbxassetid://10468229890",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SummonEffects3 = {
            SoundId = "rbxassetid://9073352876",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 1.7
        },
        SummonEffects2 = {
            SoundId = "rbxassetid://6200573157",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 1
        },
        SummonEffects1 = {
            SoundId = "rbxassetid://9062347140",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 1.5
        },
        SummonEffects4 = {
            SoundId = "rbxassetid://9073335344",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ArmVoiceline = {
            SoundId = "rbxassetid://6242428651",
            Volume = 8,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Barrage = {
            SoundId = "rbxassetid://7056257333",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageSFX = {
            SoundId = "rbxassetid://6725491459",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BarrageUser = {
            SoundId = "rbxassetid://6725495085",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Chumimiin = {
            SoundId = "rbxassetid://4540188057",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FireTemp = {
            SoundId = "rbxassetid://6049033315",
            Volume = 1.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HeavyPunch = {
            SoundId = "rbxassetid://6734569891",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB1 = {
            SoundId = "rbxassetid://6734558884",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB2 = {
            SoundId = "rbxassetid://6734559043",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB3 = {
            SoundId = "rbxassetid://6734559043",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LMB4 = {
            SoundId = "rbxassetid://6734559444",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NailShot = {
            SoundId = "rbxassetid://7019059877",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NailShotBarrage = {
            SoundId = "rbxassetid://5113629421",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NailShotBarrageVC = {
            SoundId = "rbxassetid://6734629804",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TuskClawVC = {
            SoundId = "rbxassetid://7026283106",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PunchHit = {
            SoundId = "rbxassetid://6242428055",
            Volume = 8,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Shoot = {
            SoundId = "rbxassetid://6049033315",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NailGlide = {
            SoundId = "rbxassetid://7029565541",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TuskClaw = {
            SoundId = "rbxassetid://7026282137",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SwingLMB = {
            SoundId = "rbxassetid://6706981833",
            Volume = 3,
            PlaybackSpeed = 1.600000023841858,
            Looped = false,
            TimePosition = 0
        },
        beatdown = {
            SoundId = "rbxassetid://4651887251",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        charge = {
            SoundId = "rbxassetid://5993771151",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        grab = {
            SoundId = "rbxassetid://6200317976",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        grabbarrage = {
            SoundId = "rbxassetid://6200318845",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        healed = {
            SoundId = "rbxassetid://384105511",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        infrot = {
            SoundId = "rbxassetid://6223198941",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        pose = {
            SoundId = "rbxassetid://9992375983",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        NotSo = {
            SoundId = "rbxassetid://7071859423",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        scream = {
            SoundId = "rbxassetid://5993681422",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BuryYou = {
            SoundId = "rbxassetid://7055310105",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlam = {
            SoundId = "rbxassetid://7055314863",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        wormleave = {
            SoundId = "rbxassetid://6200316572",
            Volume = 8,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ArmCrushHit = {
            SoundId = "rbxassetid://6242428324",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeReturn = {
            SoundId = "rbxassetid://7038425976",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        NailWindUp = {
            SoundId = "rbxassetid://7033790999",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeVoiceSFX = {
            SoundId = "rbxassetid://7038425056",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SpinWindUp = {
            SoundId = "rbxassetid://7033790999",
            Volume = 3,
            PlaybackSpeed = 0.699999988079071,
            Looped = false,
            TimePosition = 0
        },
        LastResort = {
            SoundId = "rbxassetid://7053540715",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Equipball = {
            SoundId = "rbxassetid://7053482462",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        LastResortSFX = {
            SoundId = "rbxassetid://7053487460",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ArmRotate = {
            SoundId = "rbxassetid://7053487955",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ThrowBall = {
            SoundId = "rbxassetid://7053482886",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BuryYouSFX = {
            SoundId = "rbxassetid://7055312535",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SlowDancer = {
            SoundId = "rbxassetid://7060310154",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        SlowDancerSFX = {
            SoundId = "rbxassetid://7060311540",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        HerbalTea = {
            SoundId = "rbxassetid://7060310814",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeBarrage = {
            SoundId = "rbxassetid://7066413759",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        screamm = {
            SoundId = "rbxassetid://6200317976",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Desummon = {
            SoundId = "rbxassetid://7066415567",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeBarrageSFX = {
            SoundId = "rbxassetid://7066223792",
            Volume = 0,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeEnter = {
            SoundId = "rbxassetid://7038424495",
            Volume = 1.2000000476837158,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Youarenotrunningaway = {
            SoundId = "rbxassetid://7070911648",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeCrush = {
            SoundId = "rbxassetid://7070913958",
            Volume = 3.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeCrushEnter = {
            SoundId = "rbxassetid://7070917233",
            Volume = 5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        WormholeCrushExit = {
            SoundId = "rbxassetid://7070918132",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        imp1 = {
            SoundId = "rbxassetid://7071753030",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Please = {
            SoundId = "rbxassetid://7071753365",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Work = {
            SoundId = "rbxassetid://7071753831",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Sigh = {
            SoundId = "rbxassetid://7071762717",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TUSKCALLOUT = {
            SoundId = "rbxassetid://7072544278",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        ORAA = {
            SoundId = "rbxassetid://7072544773",
            Volume = 4,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0.15
        },
        BeatdownAttempt = {
            SoundId = "rbxassetid://7109685010",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownHit = {
            SoundId = "rbxassetid://9062019127",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownAttemptSFXm = {
            SoundId = "rbxassetid://7109685369",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownHitSFX = {
            SoundId = "rbxassetid://9062333780",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownAttemptSFX = {
            SoundId = "rbxassetid://7109684441",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BeatdownHitm = {
            SoundId = "rbxassetid://7109689748",
            Volume = 2.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        }
    }
};