  

 

local u1 = {};
local u2 = {};
local u3 = {};
local v4 = {};
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = {};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true
            }
        },
        Moves = {
            MouseButton1 = "Rush Attack",
            F = "Block",
            C = "Quickstep",
            X = "Grab",
            Q = "Activate",
            V = "Instant Teleport",
            E = "Glitch Stab",
            R = "Glitch Uppercut",
            G = "Glitch Abomination",
            T = "Code Volley",
            Y = "Regenerate",
            B = "Blaster",
            P = "Pose"
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 7074784464,
            ["LMB-2"] = 7074785215,
            ["LMB-3"] = 7074785861,
            Stab = 7074768593,
            HeavyHit = 5888090779,
            FunnyStab = 5838697879,
            Uppercut = 5838699307,
            OLDM1 = 5888090413,
            OLDM2 = 5888090566,
            GroundSlam = 7114553506,
            Heal = 5854734790
        },
        Movement = {
            Run = 7074565976,
            Walk = 7074566537
        },
        Idle = {
            Idle = 7074564343
        }
    },
    Stats = {
        Activate = {
            Cooldown = 0.15,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p11, p12, p13) -- Line: 25, Name: client
                end
            }
        },
        Pose = {
            DoNotDeactivate = true,
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p14) -- Line: 32, Name: ExtraCheck
                    return p14.Character.Values.Active.Value == "" and true or p14.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p15, p16, p17) -- Line: 35, Name: client
                    -- upvalues: u1 (copy)
                    if not u1:HasTag(p16, "Posing") then
                        if not u1:HasTag(p16, "Posing") then
                            local BinaryStringValue = Instance.new("BinaryStringValue");
                            BinaryStringValue.Name = "P";
                            BinaryStringValue.Parent = p15.Cooldowns;
                            local v18;

                            repeat
                                wait(0.025);
                                v18 = 0;

                                for _, child in pairs(p15.Cooldowns:GetChildren()) do
                                    if child.Name == "P" then
                                        v18 = v18 + 1;
                                    end;
                                end;
                            until v18 == 2;

                            BinaryStringValue:Destroy();
                        end;

                        return;
                    end;

                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p15.Cooldowns;

                    while true do
                        wait(0.025);
                        local v19 = 0;

                        for _, child in pairs(p15.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v19 = v19 + 1;
                            end;
                        end;

                        if v19 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end
            }
        },
        Regenerate = {
            Heal = 45,
            Cooldown = 0.25,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p20) -- Line: 76, Name: ExtraCheck
                    local v21;

                    if p20.Character.Values:FindFirstChild("Overwrite").Value == false then
                        v21 = p20.Character.Humanoid.Health < 500;
                    else
                        v21 = false;
                    end;

                    return v21;
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p22, p23, p24) -- Line: 82, Name: client
                end
            }
        },
        Blaster = {
            Stun = 0.8,
            Damage = 35,
            BlockBreak = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p25) -- Line: 89, Name: ExtraCheck
                    return p25.Character.Values:FindFirstChild("Overwrite").Value == false;
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            Remotes = { { "FX", "HeavyEffect" } },
            HitAnimation = v4,
            Knockback = { 55, 0.25, Vector3.new(0, -25, 0) },
            Sound = { { "rbxassetid://7054954001", 3, 0.2, false } },
            callbacks = {
                client = function(p26, p27, p28) -- Line: 106, Name: client
                end
            }
        },
        ["Instant Teleport"] = {
            Cooldown = 0.25,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                Exception = function(p29) -- Line: 114, Name: Exception
                    if p29.Character.Values.Active.Value == "Q" then
                        print(p29.Character.Values.Active.Value, "FOUND");

                        return true;
                    end;

                    if p29.Character.Values.Active.Value == "E" then
                        print(p29.Character.Values.Active.Value, "FOUND");

                        return true;
                    end;

                    print(p29.Character.Values.Active.Value, "NOT FOUND");

                    return false;
                end,

                ExtraCheck = function(p30) -- Line: 135, Name: ExtraCheck
                    return p30.Character.Values:FindFirstChild("Overwrite").Value == true;
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                CustomInvoke = function(p31) -- Line: 140, Name: CustomInvoke
                    -- upvalues: u3 (copy)
                    local LocalPlayer = game.Players.LocalPlayer;
                    local v32 = LocalPlayer:GetMouse();
                    LocalPlayer.Character.Values.Active.Value = "temp";

                    if v32.Target and v32.Target.Parent:FindFirstChild("HumanoidRootPart") then
                        u3:InvokeServer(p31, v32.Target);
                    end;
                end
            }
        },
        ["LMB Combo"] = {
            Cooldown = 0.2,
            Stun = 0.55,
            Damage = 8,
            MaxCombo = 3,
            ComboTick = 0.3,
            Checks = {},
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "HumanoidRootPart",
                Size = 5,
                Offset = CFrame.new(0, 0, -5)
            },
            HitAnimation = v4,
            Sound = { { "rbxassetid://7577185389", 3, 0, false } },
            Remotes = { { "FX", "HitEffect" } },
            AnimSpeed = { 2, 2, 2 },

            CustomInvoke = function(u33, p34, p35) -- Line: 181, Name: CustomInvoke
                -- upvalues: u5 (copy), u8 (copy), u6 (copy), u9 (copy), u1 (copy), u10 (copy), u2 (copy), u7 (copy), u3 (copy)
                local v36 = p35 or game.Players.LocalPlayer;
                local u37 = p35 or v36.Character;
                local v38 = u5[v36.Data.Ability.Value];
                local v39 = u8.Stats[v38]["LMB Combo"];

                if not u6[v38][v36.Name] then
                    u6[v38][v36.Name] = {};
                end;

                local u40 = u6[v38][v36.Name];

                if not u40["LMB Combo"] then
                    u40["LMB Combo"] = 1;
                end;

                if not u40[u33] then
                    u40[u33] = true;
                    local u41 = u40["LMB Combo"];
                    local v42 = v39.AnimSpeed or u9;
                    local v43 = v39.StandOff and not u1:HasTag(u37, "Summoned") and "StandOff-" or "";
                    local u44 = v39.Standoff or v39;
                    local u45;

                    if u10:IsClient() then
                        local v46;

                        if u7[v38] then
                            v46 = u7[v38][u33] or u33;
                        else
                            v46 = u33;
                        end;

                        u45 = u2.playClient(v38, v43 .. v46 .. "-" .. u41, nil, v42[u41]);
                        u45.TimePosition = 0.3;
                    else
                        local v47;

                        if u7[v38] then
                            v47 = u7[v38][u33] or u33;
                        else
                            v47 = u33;
                        end;

                        u45 = u2.playClient(v38, v43 .. v47 .. "-" .. u41, nil, v42[u41], u37.Humanoid, true);
                        u45.TimePosition = 0.3;
                    end;

                    task.spawn(function() -- Line: 209
                        -- upvalues: u10 (ref), u37 (copy), u3 (ref), u33 (copy), u45 (ref), u41 (copy), u44 (copy), u40 (copy)
                        if u10:IsClient() then
                            u37.Values.Active.Value = "temp";
                            u3:InvokeServer(u33);
                        end;

                        if u45.Looped then
                            u45:Stop();
                        end;

                        if u41 == u44.MaxCombo then
                            u40["LMB Combo"] = 1;
                        else
                            local v48 = u40;
                            v48["LMB Combo"] = v48["LMB Combo"] + 1;
                        end;

                        coroutine.wrap(function() -- Line: 220
                            -- upvalues: u40 (ref), u44 (ref)
                            local v49 = u40["LMB Combo"];
                            wait(0.75 + u44.ComboTick);

                            if v49 == u40["LMB Combo"] then
                                u40["LMB Combo"] = 1;
                            end;
                        end)();
                        wait(u44.ComboTick);
                        u40[u33] = nil;
                    end);

                    return not u10:IsClient() and "Server";
                end;
            end
        },
        ["Code Volley"] = {
            Cooldown = 0.2,
            Checks = {
                CheckStunned = true,
                Exception = "Q",
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p50, p51, p52) -- Line: 237, Name: client
                end
            }
        },
        ["Glitch Abomination"] = {
            Cooldown = 0.2,
            Checks = {
                CheckStunned = true,
                Exception = "Q",
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p53) -- Line: 243, Name: ExtraCheck
                    return p53.Character.Values:FindFirstChild("Overwrite").Value == false;
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p54, p55, p56) -- Line: 247, Name: client
                end
            }
        },
        ["Glitch Stab"] = {
            Cooldown = 0.2,
            Checks = {
                CheckStunned = true,
                Exception = "Q",
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true,

                ExtraCheck = function(p57) -- Line: 253, Name: ExtraCheck
                    return p57.Character.Values:FindFirstChild("Overwrite").Value == true;
                end
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p58, p59, p60) -- Line: 257, Name: client
                end
            }
        },
        ["Glitch Uppercut"] = {
            Cooldown = 0.2,
            Checks = {
                CheckStunned = true,
                Exception = "Q",
                CheckDisabled = true,
                CheckSummoned = false,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
            callbacks = {
                client = function(p61, p62, p63) -- Line: 267, Name: client
                end
            }
        }
    },
    Sounds = {
        TSummon = {
            SoundId = "rbxassetid://5847727981",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TBrrr = {
            SoundId = "rbxassetid://5847728350",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        },
        heal = {
            SoundId = "rbxassetid://7104236745",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        awkCHG = {
            SoundId = "rbxassetid://5679060347",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        awkFIRE = {
            SoundId = "rbxassetid://5679060863",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        p1 = {
            SoundId = "rbxassetid://9062326991",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        p2 = {
            SoundId = "rbxassetid://2534981574",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        p3 = {
            SoundId = "rbxassetid://9066039601",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        funnyteleportsound = {
            SoundId = "rbxassetid://5563980633",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Summon = {
            SoundId = "rbxassetid://7077629625",
            Volume = 3,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        heavyhit = {
            SoundId = "rbxassetid://7054953364",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        hit = {
            SoundId = "rbxassetid://7054951991",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        TeleportSFX = {
            SoundId = "rbxassetid://7064602964",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        DSummon = {
            SoundId = "rbxassetid://7077629970",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Impact = {
            SoundId = "rbxassetid://7071753831",
            Volume = 1,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        imp1 = {
            SoundId = "rbxassetid://7071753030",
            Volume = 0.5,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        imp12 = {
            SoundId = "rbxassetid://7071753030",
            Volume = 2,
            PlaybackSpeed = 0.699999988079071,
            Looped = false,
            TimePosition = 0
        },
        Act = {
            SoundId = "rbxassetid://7054953364",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        MoveArm = {
            SoundId = "rbxassetid://6955512196",
            Volume = 1,
            PlaybackSpeed = 0.699999988079071,
            Looped = false,
            TimePosition = 1
        },
        Slash = {
            SoundId = "rbxassetid://7083945741",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GlitchTp = {
            SoundId = "rbxassetid://7083946917",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Hit1 = {
            SoundId = "rbxassetid://7083946402",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        Hit2 = {
            SoundId = "rbxassetid://7083947294",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OvFinisher = {
            SoundId = "rbxassetid://7090091192",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        OVGlitchStart = {
            SoundId = "rbxassetid://7090090502",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FStartup = {
            SoundId = "rbxassetid://7094592182",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        FFalling = {
            SoundId = "rbxassetid://7094592637",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        GroundSlam = {
            SoundId = "rbxassetid://7094593247",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlasterStart = {
            SoundId = "rbxassetid://7125172969",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        BlasterEnd = {
            SoundId = "rbxassetid://7125173698",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = false,
            TimePosition = 0
        },
        PoseMusic = {
            SoundId = "rbxassetid://9477687293",
            Volume = 2,
            PlaybackSpeed = 1,
            Looped = true,
            TimePosition = 0
        }
    }
};