  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = { "rbxassetid://6867463500", "rbxassetid://6867463964", "rbxassetid://6867464323" };
local u4 = {
    StarPlatinumOVA = {},
    DTWHV = {},
    ["Gold Experience"] = {},
    ["Gold Experience (Requiem)"] = {},
    TWHV = {}
};
game:GetService("PhysicsService");
game:GetService("TweenService");
require(game.ReplicatedStorage.ReplicatedModules.Animations);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local CollectionService = game:GetService("CollectionService");
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = CFrame.Angles;
local _ = math.rad;
local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);
require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
require(game.ReplicatedStorage.ReplicatedModules.Maid);
local u5 = {};
local u6 = {};

local function defaultCombo(u7, u8) -- Line: 37
    -- upvalues: Stands (copy), u1 (copy), u4 (copy), u5 (copy), Animations (copy), u6 (copy), InputFunc (copy)
    return function(p9) -- Line: 38
        -- upvalues: Stands (ref), u1 (ref), u7 (copy), u4 (ref), u5 (ref), Animations (ref), u6 (ref), InputFunc (ref), u8 (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local v10 = Stands[LocalPlayer.Data.Ability.Value];
        local u11 = u1.Stats[v10][u7];

        if not u4[v10][LocalPlayer.Name] then
            u4[v10][LocalPlayer.Name] = {};
        end;

        local u12 = u4[v10][LocalPlayer.Name];

        if not u12[u7] then
            u12[u7] = 1;
        end;

        if u12[p9] then
            return;
        end;

        u12[p9] = true;
        local v13 = u12[u7];
        local v14;

        if u6[v10] then
            v14 = u6[v10][p9] or p9;
        else
            v14 = p9;
        end;

        Animations.playClient(v10, v14 .. "-" .. v13, nil, (u11.AnimSpeed or u5)[v13]);
        LocalPlayer.Character.Values.Active.Value = "temp";
        InputFunc:InvokeServer(p9);

        if v13 == u11.MaxCombo then
            u12[u7] = 1;
        else
            local v15 = u7;
            u12[v15] = u12[v15] + 1;
        end;

        coroutine.wrap(function() -- Line: 61
            -- upvalues: u12 (copy), u7 (ref), u8 (ref), u11 (copy)
            local v16 = u12[u7];
            wait((u8 or 1.5) + u11.ComboTick);

            if v16 == u12[u7] then
                u12[u7] = 1;
            end;
        end)();
        wait(u11.ComboTick);
        u12[p9] = nil;
    end;
end;

local function EnableSCTrails(p17, p18) -- Line: 71
    for _, descendant in pairs(p17:GetDescendants()) do
        if descendant:IsA("Trail") then
            descendant.Enabled = p18;
        end;
    end;
end;

u1.Stats = {
    DTWHV = {
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p19) -- Line: 85, Name: ExtraCheck
                    return p19.Character.Values.Active.Value == "" and true or p19.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p20, p21, p22) -- Line: 88, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p21, "Mounted") then
                        return;
                    end;

                    if CollectionService:HasTag(p21, "Posing") then
                        Animations.stopClient("DTWHV", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p20.Cooldowns;

                        while true do
                            wait(0.025);
                            local v23 = 0;

                            for _, child in pairs(p20.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v23 = v23 + 1;
                                end;
                            end;

                            if v23 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("DTWHV", "PoseTransition").Stopped:Wait();
                        Animations.playClient("DTWHV", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p20.Cooldowns;

                        while true do
                            wait(0.025);
                            local v24 = 0;

                            for _, child in pairs(p20.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v24 = v24 + 1;
                                end;
                            end;

                            if v24 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        },
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "GasCan" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 0, 127)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }),
            callbacks = {
                client = function(p25, p26, p27) -- Line: 142, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p26, "Summoned") then
                        Animations.stopClient("DTWHV", "StandIdle");

                        return;
                    end;

                    Animations.playClient("DTWHV", "StandIdle");
                end
            }
        },
        Teleport = {
            Cooldown = 6,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p28) -- Line: 154, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v29;

                    if game.Workspace.Mechanics.TimeStopped:GetAttribute("User") == p28.Name then
                        v29 = false;
                    else
                        v29 = not CollectionService:HasTag(p28.Character, "Mounted");
                    end;

                    return v29;
                end
            },

            CustomInvoke = function(p30) -- Line: 155, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer:GetMouse().Hit.Position).Magnitude > 40 then
                    return;
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local _ = LocalPlayer.Character;
                local u31 = LocalPlayer:GetMouse();
                coroutine.resume(coroutine.create(function() -- Line: 162
                    -- upvalues: InputFunc (ref), u31 (copy)
                    game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("V", u31.Hit);
                end));
            end
        },
        Barrage = {
            Cooldown = 12,
            AfterMove = true,
            Length = 3,
            Damage = 1,
            Stun = 0.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p32) -- Line: 169, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p32.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -4.5)
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            TimestoppedRemotes = { { "FX", "TimestopHitEffect", "Barrage" } },
            SpecificTimestoppedRemotes = { { "Both", "FX", "CameraShake", "Normal" } },
            TimestopSound = { { "rbxassetid://6581095753", 1, 0, false } },
            Sound = { { "rbxassetid://6706979932", 1, 0, false } },
            callbacks = {
                client = function(p33, p34, p35) -- Line: 196, Name: client
                    -- upvalues: Animations (copy), InputTracker (copy)
                    local v36 = Animations.playClient("DTWHV", "Barrage");
                    Animations.playClient("DTWHV", "AttackPose");
                    v36:AdjustSpeed(3);
                    local v37 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v37 > 3.5 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p33 or (not p33.Parent or p33.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                    v36:Stop();
                    Animations.stopClient("DTWHV", "AttackPose");
                end
            },
            Remotes = { { "FX", "HitEffect" } }
        },
        HeavyPunch = {
            Damage = 30,
            Cooldown = 8,
            Stun = 0.75,
            BlockBreak = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p38) -- Line: 213, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p38.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 50, 0.3, Vector3.new(0, 0, 0) },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://7243326637", 5, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            callbacks = {
                client = function(p39, p40, p41) -- Line: 232, Name: client
                    -- upvalues: Animations (copy)
                    local v42 = Animations.playClient("DTWHV", "HeavyPunch");
                    Animations.playClient("DTWHV", "AttackPose");
                    wait(1.2);
                    v42:Stop();
                    Animations.stopClient("DTWHV", "AttackPose");
                end
            }
        },
        Taunt = {
            DoNotActivate = true,
            DoNotDeactivate = true,
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p43) -- Line: 244, Name: ExtraCheck
                    return p43.Character.Values.Active.Value ~= "G";
                end
            },
            Quotes = { { "I won! You\'ve just proven all the weaknesses I guessed you had!", "rbxassetid://9066063641", {
                        ["I won!"] = 1,
                        ["I won! You\'ve just proven all the weaknesses"] = 0.8
                    }, 1, 2 }, { "I\'m going to cut your parts into pieces then line all of them on the ground in order!", "rbxassetid://6717177724", {
                        ["I\'m going to cut your parts"] = 0.3
                    }, 1, 2 }, { "I\'m going to teach you the meaning of the word retire!", "rbxassetid://5602096618", {
                        ["I\'m going to teach you"] = 0.8
                    }, 1, 2 }, { "Come on, make a deal with me! Give me Manhattan Island!", "rbxassetid://9066061387", {
                        ["Come on,"] = 1.3,
                        ["Come on, make a deal with me!"] = 0.8
                    }, 1, 2 } }
        },
        Timestop = {
            Cooldown = 70,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p44) -- Line: 280, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v45 = not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") and not CollectionService:HasTag(p44.Character, "Mounted");

                    return v45;
                end
            },
            callbacks = {
                client = function(p46, p47, p48) -- Line: 283, Name: client
                    -- upvalues: Animations (copy)
                    if p47.Humanoid.Health / p47.Humanoid.MaxHealth <= 0.3 then
                        Animations.playClient("DTWHV", "UrgentTS");

                        return;
                    end;

                    Animations.playClient("DTWHV", "Timestop");
                end
            }
        },
        CutsceneMove = {
            Cooldown = 75,
            AfterMove = true,
            callbacks = {
                client = function(p49, p50, p51) -- Line: 296, Name: client
                    -- upvalues: Animations (copy)
                    wait(1);
                    Animations.playClient("DTWHV", "Cutscene");
                end
            },
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p52) -- Line: 301, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v53 = not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown");

                    if v53 then
                        if workspace.Mechanics.TimeStopped.Value == false then
                            v53 = not CollectionService:HasTag(p52.Character, "Mounted");
                        else
                            v53 = false;
                        end;
                    end;

                    return v53;
                end
            }
        },
        KnifeThrow = {
            Damage = 10,
            AfterMove = true,
            Cooldown = 7.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p54) -- Line: 304, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p54.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
            callbacks = {
                client = function(p55, p56, p57) -- Line: 311, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("DTWHV", "KnifeAnim");
                end
            }
        },
        Horse = {
            Cooldown = 0,
            CooldownGetOn = 1,
            ActualCooldown = 25,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p58, u59, p60) -- Line: 323, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(u59, "Mounted") then
                        Animations.stopClient("DTWHV", "Sit");

                        return;
                    end;

                    local v61 = Animations.playClient("DTWHV", "Sit");
                    v61.Priority = Enum.AnimationPriority.Action;
                    u59.Humanoid.HipHeight = 4.5;
                    v61.Stopped:Connect(function() -- Line: 328
                        -- upvalues: u59 (copy)
                        u59.Humanoid.HipHeight = 0;
                        local Horse = u59.Horse;
                        Horse:Destroy();

                        repeat
                            wait(0.025);
                        until Horse.Parent == nil;

                        u59.Humanoid.WalkSpeed = 16;
                    end);
                end
            }
        },
        Revolver = {
            Cooldown = 8.5,
            AfterMove = true,
            Damage = 35,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p62) -- Line: 344, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p62.Character, "Mounted");
                end
            },
            CollisionSounds = {
                Default = {
                    ID = 7172258964,
                    Props = {
                        Volume = 3,
                        RollOffMaxDistance = 60
                    }
                }
            },
            HitAnimation = v3,
            Knockback = { 10, 0.05 },
            Sound = { "rbxassetid://6476021684", 2, 0, false },
            callbacks = {
                client = function(p63, p64, p65) -- Line: 362, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("DTWHV", "GunFire");
                end
            }
        },
        ["LMB Combo V3"] = {
            Checks = v2,
            Damage = 8,
            Stun = 0.5,
            Cooldown = 0.15,
            ActualCooldown = 3,
            MaxCombo = 4,
            ComboTick = 1.5,
            UseStand = true,
            Startup = { 0.25, 0.25, 0.25, 0.25 },
            EndLag = { 0.35, 0.35, 0.35, 0.35 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            AttackSpeed = {
                [4] = 2
            },
            ExtraSounds = { { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            ["LMB-4"] = {
                Knockback = { 75, 0.3, Vector3.new(0, 10, 0) },
                Sound = { { "rbxassetid://7243326637", 1, 0, false } },
                Remotes = { { "FX", "HeavyEffect" } }
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            Callbacks = {}
        },
        BarbedWire = {
            Cooldown = 12,
            Damage = 50,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p66) -- Line: 426, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p66.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Touched",
                ResetHit = 3
            },
            Sound = { "rbxassetid://6476021684", 2, 0, false },
            callbacks = {
                client = function(p67, p68, p69) -- Line: 439, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("DTWHV", "WireThrow");
                end
            }
        },
        TripleMuda = {
            Damage = 12,
            Cooldown = 15,
            AfterMove = true,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p70) -- Line: 445, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p70.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 12.5, 0.1 },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.Stand Right Arm",
                Size = 4,
                Offset = CFrame.new(0, 0, 0)
            },
            Sound = { { "rbxassetid://6706979361", 2, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            callbacks = {
                client = function(p71, p72, p73) -- Line: 465, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("DTWHV", "AttackPose");
                    Animations.playClient("DTWHV", "HeavyMuda");
                    wait(2);
                    Animations.stopClient("DTWHV", "HeavyMuda");
                    Animations.stopClient("DTWHV", "AttackPose");
                end
            }
        },
        Gasoline = {
            Cooldown = 2,
            Damage = 1,
            Unblockable = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p74) -- Line: 475, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p74.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://6721725552", 3, 0, false } },
            callbacks = {
                client = function(p75, p76, p77) -- Line: 489, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("DTWHV", "Gasoline");
                    wait(2);
                    Animations.stopClient("DTWHV", "Gasoline");
                end
            }
        }
    },
    TWHV = {
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p78) -- Line: 544, Name: ExtraCheck
                    return p78.Character.Values.Active.Value == "" and true or p78.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p79, p80, p81) -- Line: 547, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p80, "Mounted") then
                        return;
                    end;

                    if CollectionService:HasTag(p80, "Posing") then
                        Animations.stopClient("TWHV", "PoseIdle");
                        pcall(function() -- Line: 552
                            -- upvalues: Animations (ref)
                            Animations.stopClient("TWHV", "PoseTransition");
                        end);
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p79.Cooldowns;

                        while true do
                            wait(0.025);
                            local v82 = 0;

                            for _, child in pairs(p79.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v82 = v82 + 1;
                                end;
                            end;

                            if v82 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("TWHV", "PoseTransition").Stopped:Wait();

                        if CollectionService:HasTag(p80, "Posing") then
                            Animations.playClient("TWHV", "PoseIdle");
                        end;

                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p79.Cooldowns;

                        while true do
                            wait(0.025);
                            local v83 = 0;

                            for _, child in pairs(p79.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v83 = v83 + 1;
                                end;
                            end;

                            if v83 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        },
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "GasCan" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
            callbacks = {
                client = function(p84, p85, p86) -- Line: 606, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p85, "Summoned") then
                        Animations.stopClient("TWHV", "StandIdle");

                        return;
                    end;

                    Animations.playClient("TWHV", "StandIdle");
                end
            }
        },
        Teleport = {
            Cooldown = 6,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p87) -- Line: 618, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v88;

                    if game.Workspace.Mechanics.TimeStopped:GetAttribute("User") == p87.Name then
                        v88 = false;
                    else
                        v88 = not CollectionService:HasTag(p87.Character, "Mounted");
                    end;

                    return v88;
                end
            },

            CustomInvoke = function(p89) -- Line: 619, Name: CustomInvoke
                -- upvalues: InputFunc (copy)
                if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer:GetMouse().Hit.Position).Magnitude > 40 then
                    return;
                end;

                local LocalPlayer = game.Players.LocalPlayer;
                local _ = LocalPlayer.Character;
                local u90 = LocalPlayer:GetMouse();
                coroutine.resume(coroutine.create(function() -- Line: 626
                    -- upvalues: InputFunc (ref), u90 (copy)
                    game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("V", u90.Hit);
                end));
            end
        },
        Barrage = {
            Cooldown = 12,
            AfterMove = true,
            Length = 3,
            Damage = 1,
            Stun = 0.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p91) -- Line: 633, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p91.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4.5,
                Offset = CFrame.new(0, 0, -4.5)
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            TimestoppedRemotes = { { "FX", "TimestopHitEffect", "Barrage" } },
            SpecificTimestoppedRemotes = { { "Both", "FX", "CameraShake", "Normal" } },
            TimestopSound = { { "rbxassetid://6581095753", 1, 0, false } },
            Sound = { { "rbxassetid://6706979932", 1, 0, false } },
            callbacks = {
                client = function(p92, p93, p94) -- Line: 660, Name: client
                    -- upvalues: Animations (copy), InputTracker (copy)
                    local v95 = Animations.playClient("TWHV", "Barrage");
                    Animations.playClient("TWHV", "AttackPose");
                    v95:AdjustSpeed(3);
                    local v96 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v96 > 3.5 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p92 or (not p92.Parent or p92.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                    v95:Stop();
                    Animations.stopClient("TWHV", "AttackPose");
                end
            },
            Remotes = { { "FX", "HitEffect" } }
        },
        HeavyPunch = {
            Damage = 30,
            Cooldown = 8,
            Stun = 0.55,
            BlockBreak = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p97) -- Line: 677, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p97.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 75, 0.3, Vector3.new(0, 5, 0) },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 4,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://7243326637", 5, 0, false } },
            Remotes = { { "FX", "HeavyEffect" } },
            callbacks = {
                client = function(p98, p99, p100) -- Line: 696, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "HeavyPunch");
                    Animations.playClient("TWHV", "AttackPose");
                    wait(1.2);
                    Animations.stopClient("TWHV", "HeavyPunch");
                    Animations.stopClient("TWHV", "AttackPose");
                end
            }
        },
        Taunt = {
            DoNotActivate = true,
            DoNotDeactivate = true,
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p101) -- Line: 708, Name: ExtraCheck
                    return p101.Character.Values.Active.Value ~= "G";
                end
            },
            Quotes = { { "I won! You\'ve just proven all the weaknesses I guessed you had!", "rbxassetid://9073506228", {
                        ["I won!"] = 1,
                        ["I won! You\'ve just proven all the weaknesses"] = 0.8
                    }, 1, 2 }, { "I\'m going to cut your parts into pieces then line all of them on the ground in order!", "rbxassetid://6717177724", {
                        ["I\'m going to cut your parts"] = 0.3
                    }, 1, 2 }, { "I\'m going to teach you the meaning of the word retire!", "rbxassetid://5602096618", {
                        ["I\'m going to teach you"] = 0.8
                    }, 1, 2 }, { "Come on, make a deal with me! Give me Manhattan Island!", "rbxassetid://5602047840", {
                        ["Come on,"] = 1.3,
                        ["Come on, make a deal with me!"] = 0.8
                    }, 1, 2 } }
        },
        Timestop = {
            Cooldown = 70,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p102) -- Line: 744, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v103 = not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") and not CollectionService:HasTag(p102.Character, "Mounted");

                    return v103;
                end
            },
            callbacks = {
                client = function(p104, p105, p106) -- Line: 747, Name: client
                    -- upvalues: Animations (copy)
                    if p105.Humanoid.Health / p105.Humanoid.MaxHealth <= 0.3 then
                        Animations.playClient("TWHV", "UrgentTS");

                        return;
                    end;

                    Animations.playClient("TWHV", "Timestop");
                end
            }
        },
        CutsceneMove = {
            Cooldown = 75,
            AfterMove = true,
            callbacks = {
                client = function(p107, p108, p109) -- Line: 760, Name: client
                    -- upvalues: Animations (copy)
                    wait(1);
                    Animations.playClient("TWHV", "Cutscene");
                end
            },
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p110) -- Line: 765, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    local v111 = not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown");

                    if v111 then
                        if workspace.Mechanics.TimeStopped.Value == false then
                            v111 = not CollectionService:HasTag(p110.Character, "Mounted");
                        else
                            v111 = false;
                        end;
                    end;

                    return v111;
                end
            }
        },
        KnifeThrow = {
            Damage = 10,
            Cooldown = 7.5,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p112) -- Line: 768, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p112.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
            callbacks = {
                client = function(p113, p114, p115) -- Line: 774, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "KnifeAnim");
                end
            }
        },
        Horse = {
            Cooldown = 0,
            CooldownGetOn = 1,
            ActualCooldown = 25,
            AfterMove = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p116, u117, p118) -- Line: 786, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(u117, "Mounted") then
                        Animations.stopClient("TWHV", "Sit");

                        return;
                    end;

                    local v119 = Animations.playClient("TWHV", "Sit");
                    v119.Priority = Enum.AnimationPriority.Action;
                    u117.Humanoid.HipHeight = 4.5;
                    v119.Stopped:Connect(function() -- Line: 791
                        -- upvalues: u117 (copy)
                        u117.Humanoid.HipHeight = 0;
                        local Horse = u117.Horse;
                        Horse:Destroy();

                        repeat
                            wait(0.025);
                        until Horse.Parent == nil;

                        u117.Humanoid.WalkSpeed = 16;
                    end);
                end
            }
        },
        Revolver = {
            Cooldown = 8.5,
            Damage = 35,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p120) -- Line: 807, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p120.Character, "Mounted");
                end
            },
            CollisionSounds = {
                Default = {
                    ID = 7172258964,
                    Props = {
                        Volume = 3,
                        RollOffMaxDistance = 60
                    }
                }
            },
            HitAnimation = v3,
            Knockback = { 10, 0.05 },
            Sound = { "rbxassetid://6476021684", 2, 0, false },
            callbacks = {
                client = function(p121, p122, p123) -- Line: 825, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "GunFire");
                end
            }
        },
        ["LMB Combo V3"] = {
            Checks = v2,
            Damage = 8,
            Stun = 0.5,
            Cooldown = 0.15,
            ActualCooldown = 3,
            MaxCombo = 4,
            ComboTick = 1.5,
            UseStand = true,
            Startup = { 0.25, 0.25, 0.25, 0.25 },
            EndLag = { 0.35, 0.35, 0.35, 0.35 },
            ModifiedCooldowns = { 0.5, 0.75, 1 },
            AttackSpeed = {
                [4] = 2
            },
            ExtraSounds = { { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" }, { "SwingLMB" } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 8),
                Offset = CFrame.new(0, 0, -4)
            },
            ["LMB-4"] = {
                Knockback = { 75, 0.3, Vector3.new(0, 10, 0) },
                Sound = { { "rbxassetid://7243326637", 1, 0, false } },
                Remotes = { { "FX", "HeavyEffect" } }
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            Callbacks = {}
        },
        BarbedWire = {
            Cooldown = 14,
            Damage = 50,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p124) -- Line: 889, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p124.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Touched",
                ResetHit = 3
            },
            Sound = { "rbxassetid://6476021684", 2, 0, false },
            callbacks = {
                client = function(p125, p126, p127) -- Line: 902, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "WireThrow");
                end
            }
        },
        TripleMuda = {
            Damage = 12,
            Cooldown = 15,
            AfterMove = true,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p128) -- Line: 908, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p128.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Knockback = { 12.5, 0.1 },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.Stand Right Arm",
                Size = 4,
                Offset = CFrame.new(0, 0, 0)
            },
            Sound = { { "rbxassetid://6706979361", 2, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            callbacks = {
                client = function(p129, p130, p131) -- Line: 928, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "HeavyMuda");
                    Animations.playClient("TWHV", "AttackPose");
                    wait(2);
                    Animations.stopClient("TWHV", "HeavyMuda");
                    Animations.stopClient("TWHV", "AttackPose");
                end
            }
        },
        Gasoline = {
            Cooldown = 2,
            Damage = 1,
            Unblockable = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p132) -- Line: 938, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p132.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sound = { { "rbxassetid://6721725552", 1, 0, false } },
            callbacks = {
                client = function(p133, p134, p135) -- Line: 952, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("TWHV", "Gasoline");
                    wait(2);
                    Animations.stopClient("TWHV", "Gasoline");
                end
            }
        }
    },
    A_Sans = {
        ["Bone Field"] = {
            Cooldown = 1,
            AfterMove = true,
            Damage = 1.5,
            Stun = 0.1,
            Checks = {
                CheckDisabled = true,
                CheckStunned = true,
                CheckActive = true,
                CheckTimestop = true
            },
            callbacks = {
                client = function(p136, p137, p138) -- Line: 1010, Name: client
                    -- upvalues: Animations (copy)
                    Animations.playClient("Sans", "Bone Guard");
                    p137.Humanoid.AutoRotate = false;
                    wait(1.8);
                    p137.Humanoid.AutoRotate = true;
                end
            },
            Sound = { { "rbxassetid://8172043880", 1, 0, false } }
        },
        ["Bad Time"] = {
            Cooldown = 1,
            AfterMove = true,
            Checks = {
                CheckDisabled = true,
                CheckStunned = true,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        Taunt = {
            Cooldown = 1,
            Checks = {
                CheckDisabled = true,
                CheckStunned = true,
                CheckActive = true,
                CheckTimestop = true
            }
        }
    },
    ["Silver Chariot"] = {
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "Stand Torso", "Stand Head", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(239, 239, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 138, 138)) }),
            callbacks = {
                client = function(p139, u140, p141) -- Line: 1045, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    local v142 = nil;
                    local v143 = nil;

                    if not CollectionService:HasTag(u140, "Summoned") then
                        Animations.playClient("Silver Chariot", "StandIdle");
                        CollectionService:GetInstanceAddedSignal("Armor Off"):Connect(function(p144) -- Line: 1052
                            -- upvalues: u140 (copy), Animations (ref)
                            if p144 == u140 then
                                Animations.stopClient("Silver Chariot", "StandIdle");
                                Animations.playClient("Silver Chariot", "Armor Off Idle");
                            end;
                        end);
                        CollectionService:GetInstanceRemovedSignal("Armor Off"):Connect(function(p145) -- Line: 1059
                            -- upvalues: u140 (copy), Animations (ref)
                            if p145 == u140 then
                                Animations.stopClient("Silver Chariot", "Armor Off Idle");
                                Animations.playClient("Silver Chariot", "StandIdle");
                            end;
                        end);

                        return;
                    end;

                    Animations.stopClient("Silver Chariot", "StandIdle");
                    Animations.stopClient("Silver Chariot", "Armor Off Idle");

                    if v142 then
                        v142:Disconnect();
                    end;

                    if v143 then
                        v143:Disconnect();
                    end;
                end
            }
        },
        ["LMB Combo V2"] = {
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Cooldown = 0.2,
            ActualCooldown = 1.75,
            EndLag = { 0.375, 0.375, 0.375, 0.425 },
            MaxCombo = 4,
            ComboTick = 1,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5.3, 5.3, 5.3),
                Debug = false,
                Offset = CFrame.new(0, 0, -4.5)
            },
            Sounds = { "rbxassetid://10279232147", "rbxassetid://10279232147", "rbxassetid://10279232147", "rbxassetid://10279232224" },
            Damage = 8,
            Stun = 0.75,
            Knockback = { 5, 0.05 },
            HitAnimation = v3,
            Remotes = { { "FX", "HitEffect V2", "SCLMBHitEffect" } },
            ["LMB-3"] = {
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 8.5),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                }
            },
            ["LMB-4"] = {
                Damage = 15,
                Stun = 0.25,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5.3, 5.3, 8.5),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
                Remotes = { { "FX", "WS_HIT" } }
            },
            Callbacks = {
                PreAnim = function(p146, p147) -- Line: 1136, Name: PreAnim
                    -- upvalues: EnableSCTrails (copy)
                    local v148, _, _ = unpack(p146);
                    local Character = v148.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    local Stand = Character.Stand;
                    p147.Maid:GiveTask(p147.Functions:CreateJump(Character, 0));
                    EnableSCTrails(Stand, true);
                end,

                PostAnim = function(p149, p150) -- Line: 1146, Name: PostAnim
                    -- upvalues: EnableSCTrails (copy)
                    p150.Maid:Destroy();
                    local v151, _, _ = unpack(p149);
                    local Character = v151.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                    EnableSCTrails(Character.Stand, false);
                end,

                PreHit = function(p152, p153) -- Line: 1156, Name: PreHit
                    local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                    local v154, _, _ = unpack(p152);
                    local Character = v154.Character;
                    local _ = Character.Humanoid;
                    local _ = Character.HumanoidRootPart;
                end
            }
        },
        ["Rapier Thrusts"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p155) -- Line: 1168, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p155.Character, "Mounted");
                end
            },
            Cooldown = 0.2,
            Length = 2.4,
            AfterMove = true,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 4, 12),
                Debug = false,
                Offset = CFrame.new(0, 0, -6)
            },
            Damage = 1,
            Stun = 0.5,
            Knockback = { 1, 0.1 },
            Sound = { { "rbxassetid://10271929867", 1, 0, false } },
            HitAnimation = v3,
            Remotes = { { "FX", "HitEffect V2", "SCBarrageHitEffect" } },
            HitData = {
                Color = Color3.new(0.588235, 0.0392157, 0.0392157)
            },
            Finisher = {
                Damage = 15,
                Stun = 0.1,
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 4, 12),
                    Debug = false,
                    Offset = CFrame.new(0, 0, -6)
                },
                Knockback = { 50, 0.5 },
                HitAnimation = v3,
                Sound = { { "rbxassetid://7731164647", 2, 0, false } },
                Remotes = { { "FX", "Hit Effects/MoonHit" } },
                HitData = {
                    Color = Color3.new(0.00392157, 0.435294, 1)
                }
            }
        },
        ["Instant Slice"] = {
            Cooldown = 0.2,
            AfterMove = true,
            BlockBreak = true,
            Damage = 15,
            Stun = 0.3,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p156) -- Line: 1210, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p156.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 4, 12),
                Debug = false,
                Offset = CFrame.new(0, 0, -6)
            },
            Knockback = { 50, 0.5 },
            HitAnimation = v3,
            Remotes = { { "FX", "HitEffect V2", "SCRHitEffect" } },
            HitData = {
                Color = Color3.new(0.466667, 0.768627, 1)
            }
        },
        ["Ricochet Shot"] = {
            Cooldown = 0.2,
            AfterMove = true,
            Damage = 15,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p157) -- Line: 1233, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p157.Character, "Mounted");
                end
            },
            HitAnimation = v3,
            Remotes = { { "FX", "Hit Effects/MoonHit" } },
            HitData = {
                Color = Color3.new(0.466667, 0.768627, 1)
            }
        },
        ["You\'re Lying"] = {
            Cooldown = 0.2,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        ["Eye Of The Storm"] = {
            Cooldown = 0.2,
            Length = 2,
            Damage = 15,
            Stun = 0.5,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 25,
                Debug = false,
                Offset = CFrame.new(0, 0, 0)
            },
            TickStats = {
                Damage = 1,
                Stun = 0.1,
                Sound = { { "rbxassetid://10271929867", 1, 0, false } },
                Remotes = { { "FX", "HitEffect V2", "SCMultiSlashHit" } },
                HitData = {
                    Color = Color3.new(0.588235, 0.0392157, 0.0392157)
                }
            },
            Knockback = { 1, 0.1 },
            Sound = { { "rbxassetid://10271929867", 1, 0, false } },
            HitAnimation = v3,
            HitData = {
                Color = Color3.new(0.588235, 0.0392157, 0.0392157)
            }
        },
        ["Skull Piercing Thrust"] = {
            Cooldown = 0.2,
            Length = 0.4,
            Damage = 25,
            Stun = 0.75,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p158) -- Line: 1276, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p158.Character, "Mounted");
                end
            },
            Hitbox = {
                Type = "Region3",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Debug = true,
                Offset = CFrame.new(0, 0, -1)
            },
            Knockback = { 50, 0.3 },
            HitAnimation = v3
        },
        ["Piercing Finisher"] = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p159) -- Line: 1294, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p159.Character, "Mounted");
                end
            },
            Cooldown = 0.2,
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(6, 4, 12),
                Debug = false,
                Offset = CFrame.new(0, 0, -6)
            },
            Damage = 1,
            Sound = { { "rbxassetid://7731164647", 2, 0, false } },
            Remotes = { { "FX", "Hit Effects/YasHit" } },
            HitData = {
                Color = Color3.new(0.588235, 0.0392157, 0.0392157)
            },
            JabStats = {
                IgnoreUnhitable = true,
                Damage = 1,
                Sound = { { "rbxassetid://10271929867", 1, 0, false } },
                Remotes = { { "FX", "Hit Effects/YasHit" } },
                HitData = {
                    Color = Color3.new(0.588235, 0.0392157, 0.0392157)
                }
            },
            ["Final SliceStats"] = {
                IgnoreUnhitable = true,
                Damage = 15,
                Sound = { { "rbxassetid://7731164647", 2, 0, false } },
                Remotes = { { "FX", "Hit Effects/MoonHit" } },
                HitData = {
                    Color = Color3.new(0.00392157, 0.435294, 1)
                }
            },
            SliceStats = {
                IgnoreUnhitable = true,
                Damage = 8,
                Remotes = { { "FX", "WS_HIT" } },
                Sound = { { "rbxassetid://10279232147", 1, 0, false } }
            }
        },
        ["Armor Off"] = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p160) -- Line: 1331, Name: ExtraCheck
                    -- upvalues: CollectionService (copy)
                    return not CollectionService:HasTag(p160.Character, "Mounted");
                end
            }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p161) -- Line: 1336, Name: ExtraCheck
                    return p161.Character.Values.Active.Value == "" and true or p161.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p162, p163, p164) -- Line: 1339, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p163, "Posing") then
                        Animations.stopClient("Silver Chariot", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p162.Cooldowns;

                        while true do
                            wait(0.025);
                            local v165 = 0;

                            for _, child in pairs(p162.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v165 = v165 + 1;
                                end;
                            end;

                            if v165 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("Silver Chariot", "PoseTransition").Stopped:Wait();
                        Animations.playClient("Silver Chariot", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p162.Cooldowns;

                        while true do
                            wait(0.025);
                            local v166 = 0;

                            for _, child in pairs(p162.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v166 = v166 + 1;
                                end;
                            end;

                            if v166 >= 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
                end
            }
        }
    }
};
u1.Stats.StarPlatinumOVA = u1.Stats["Star Platinum"];

return u1.Stats;