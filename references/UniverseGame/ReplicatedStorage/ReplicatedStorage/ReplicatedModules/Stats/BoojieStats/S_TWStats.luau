  

 

local v1 = {};
local u2 = {};
v1["S/TW"] = u2;
local PathShortcuts = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local v3 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckActive = true,
    CheckTimestop = true
};
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local v4 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local u5 = {};
local u6 = {};
local u7 = {
    Inker = {}
};
local RunService = game:GetService("RunService");
require(game.ReplicatedStorage.ReplicatedModules.Stands);

local function defaultCombo(u8, u9) -- Line: 29
    -- upvalues: u2 (copy), u7 (copy), u5 (copy), Knit (copy), u6 (copy), Animations (copy), RunService (copy)
    return function(u10, p11, p12) -- Line: 30
        -- upvalues: u2 (ref), u8 (copy), u7 (ref), u5 (ref), Knit (ref), u6 (ref), Animations (ref), RunService (ref), u9 (copy)
        local v13 = p12 or game.Players.LocalPlayer;
        local u14 = p12 or v13.Character;
        local v15;

        if v13.Data:FindFirstChild("Skin") then
            v15 = v13.Data.Skin:GetAttribute("SkinName") or nil;
        else
            v15 = nil;
        end;

        local v16 = u2[u8];

        if v16.LMB then
            v16 = v16.LMB;
        end;

        if not u7["The World"] then
            u7["The World"] = {};
        end;

        if not u7["The World"][v13.Name] then
            u7["The World"][v13.Name] = {};
        end;

        local u17 = u7["The World"][v13.Name];

        if not u17[u8] then
            u17[u8] = 1;
        end;

        if not u17[u10] then
            u17[u10] = true;
            local u18 = u17[u8];
            local v19 = v16.AnimSpeed or u5;
            local v20 = v16.StandOff and not Knit.CollectionService:HasTag(u14, "Summoned") and "StandOff-" or "";
            local u21 = v16.Standoff or v16;
            local v22 = "The World";
            local v23;

            if u6["The World"] then
                v23 = u6["The World"][u10] or u10;
            else
                v23 = u10;
            end;

            local v24 = v20 .. v23 .. "-" .. u18;

            if v15 then
                local v25, v26 = Animations.SearchAnim(v15, v24);

                if v25 then
                    if not v26 then
                        v15 = v22;
                    end;
                else
                    v15 = v22;
                end;
            else
                v15 = v22;
            end;

            local u27;

            if RunService:IsClient() then
                u27 = Animations.playClient(v15, v24, nil, v19[u18]);
            else
                u27 = Animations.playClient(v15, v24, nil, v19[u18], u14.Humanoid, true);
            end;

            task.spawn(function() -- Line: 72
                -- upvalues: RunService (ref), u14 (copy), Knit (ref), u10 (copy), u27 (ref), u18 (copy), u21 (copy), u17 (copy), u8 (ref), u9 (ref)
                if RunService:IsClient() then
                    u14.Values.Active.Value = "temp";
                    Knit.Remotes.InputFunc:InvokeServer(u10);
                end;

                if u27.Looped then
                    u27:Stop();
                end;

                if u18 == u21.MaxCombo then
                    u17[u8] = 1;
                else
                    local v28 = u17;
                    local v29 = u8;
                    v28[v29] = v28[v29] + 1;
                end;

                coroutine.wrap(function() -- Line: 83
                    -- upvalues: u17 (ref), u8 (ref), u9 (ref), u21 (ref)
                    local v30 = u17[u8];
                    wait((u9 or 1.5) + u21.ComboTick);

                    if v30 == u17[u8] then
                        u17[u8] = 1;
                    end;
                end)();
                wait(u21.ComboTick);
                u17[u10] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

u2.Summon = {
    Cooldown = 0.25,
    AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
    callbacks = {
        client = function(p31, p32, p33) -- Line: 105, Name: client
            -- upvalues: Knit (copy), Animations (copy)
            if Knit.CollectionService:HasTag(p32, "STW") then
                return;
            end;

            if Knit.CollectionService:HasTag(p32, "Summoned") then
                if p31 == nil then
                    Animations.stopClient("The World", "StandIdle", p32, true);

                    return;
                end;

                Animations.stopClient("The World", "StandIdle");

                return;
            end;

            if p31 == nil then
                Animations.playClient("The World", "StandIdle", nil, nil, p32:FindFirstChildWhichIsA("Humanoid"), true);

                return;
            end;

            Animations.playClient("The World", "StandIdle");
        end
    }
};
u2["LMB Combo"] = {
    MoveName = "LMB Combo",
    Cooldown = 0.2,
    Stun = 0.4,
    Damage = 8,
    UltimateProgress = 8,
    MaxCombo = 4,
    ComboTick = 0.3,
    Checks = v3,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 4,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v4,
    Sound = { { "rbxassetid://6706982964", 0.8, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    AnimSpeed = {
        [4] = 2
    },
    Jab = {
        Damage = 6.5,
        Stun = 0.4,
        ComboTick = 0.1,
        Knockback = { 20, 0.15 },
        HitAnimation = v4,
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://5581386321", 0.4, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4.25)
        }
    },

    CustomInvoke = function() -- Line: 172, Name: CustomInvoke
        -- upvalues: Knit (copy)
        local Character = game.Players.LocalPlayer.Character;

        if Knit.CollectionService:HasTag(Character, "Summoned") then
            Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("LMB");

            return;
        end;

        Character.Values.Active.Value = "temp";
        Knit.Remotes.InputFunc:InvokeServer("LMB");
    end,

    callbacks = {
        client = function(p34, p35) -- Line: 186, Name: client
            -- upvalues: Knit (copy), Animations (copy)
            if Knit.CollectionService:HasTag(p35, "Summoned") then
                return;
            end;

            if game:GetService("CollectionService"):HasTag(p35, "Crouching") then
                Animations.playClient("ShadowDio", "Crawl Jab");

                return;
            end;

            Animations.playClient("ShadowDio", "Jab");
        end
    }
};
u2.EMoves = {
    Checks = v3,
    Barrage = {
        Cooldown = 10,
        AfterMove = true,
        Length = 2.8,
        Damage = 1.3,
        UltimateProgress = 5,
        Stun = 0.4,
        Checks = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitAnimation = v4,
        Sound = { { "rbxassetid://6706982698", 0.5, 0, false } }
    },
    HighKick = {
        Damage = 35,
        Stun = 0.375,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 75, 0.2 },
        Remotes = { { "FX", "HeavyEffect" } },
        Sound = { { "rbxassetid://5581325281", 0.6, 0, false } },
        HitAnimation = v4,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, -0.75, -4.5)
        }
    },

    CustomInvoke = function(p36, p37, p38) -- Line: 237, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        local Character = game.Players.LocalPlayer.Character;

        if not Knit.CollectionService:HasTag(Character, "Summoned") then
            Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("E");

            return;
        end;

        local u39 = p38 or game.Players.LocalPlayer;
        local u40 = p38 or u39.Character;

        if u39.Cooldowns:FindFirstChild("Barrage") then
            return;
        end;

        if not game:GetService("CollectionService"):HasTag(u40, "Tandeming") and game:GetService("CollectionService"):HasTag(u40, "Summoned") then
            if game:GetService("CollectionService"):HasTag(u40, "Summoned") then
                local v41 = u39:IsA("Player") and Animations.playClient("The World", "Barrage") or Animations.playClient("The World", "Barrage", nil, nil, u40:FindFirstChildWhichIsA("Humanoid"), true);
                v41:Play(0.2, 1, 1.5);
                local v42;

                if u39:IsA("Player") then
                    v42 = Animations.playClient("The World", "AttackPose");
                else
                    v42 = Animations.playClient("The World", "AttackPose", nil, nil, u40:FindFirstChildWhichIsA("Humanoid"), true);
                end;

                if v42 then
                    v42:Play();
                end;

                coroutine.resume(coroutine.create(function() -- Line: 264
                    -- upvalues: u40 (copy), u39 (copy), Knit (ref)
                    u40.Values.Active.Value = "temp";

                    if u39:IsA("Player") then
                        Knit.Remotes.InputFunc:InvokeServer("E");

                        return;
                    end;

                    require(game.ServerScriptService.Main.MainFunctions):Move(u40, "E");
                end));
                local v43 = tick();

                repeat
                    wait(0.025);
                until tick() - v43 > 2.8 or u39:IsA("Player") and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E);

                v41:Stop();

                if v42 then
                    v42:Stop();
                end;
            end;

            return;
        end;

        if u39:IsA("Player") then
            Animations.playClient("The World", "RoundhouseKick");

            return;
        end;

        Animations.playClient("The World", "RoundhouseKick", nil, nil, u40:FindFirstChildWhichIsA("Humanoid"), true);
    end
};
u2.RMoves = {
    Checks = v3,
    Donut = {
        Damage = 38.35,
        UltimateProgress = 65,
        Cooldown = 15,
        BlockBreak = true,
        StandOffCooldown = 10,
        StandOnCooldown = 10,
        Stun = 1.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitAnimation = { "rbxassetid://6762858645" }
    },
    Swipe = {
        Damage = 25,
        Cooldown = 10,
        Stun = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://5581325281", 0.6, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, -0.75, -3.5)
        }
    },

    CustomInvoke = function(p44, p45, p46) -- Line: 333, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        local Character = game.Players.LocalPlayer.Character;

        if not Knit.CollectionService:HasTag(Character, "Summoned") then
            Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("R");

            return;
        end;

        local u47 = p46 or game.Players.LocalPlayer;
        local u48 = p46 or u47.Character;

        if u47.Cooldowns:FindFirstChild("Donut") then
            return;
        end;

        if game:GetService("CollectionService"):HasTag(u48, "Summoned") then
            if u47.Cooldowns:FindFirstChild("R") then
                return;
            end;

            spawn(function() -- Line: 344
                -- upvalues: u48 (copy), u47 (copy), Knit (ref)
                u48.Values.Active.Value = "temp";

                if u47:IsA("Player") then
                    Knit.Remotes.InputFunc:InvokeServer("R");

                    return;
                end;

                require(game.ServerScriptService.Main.MainFunctions):Move(u48, "R");
            end);

            if u47:IsA("Model") then
                Animations.playClient("The World", "Donut", nil, nil, u48:FindFirstChildWhichIsA("Humanoid"), true);
            else
                Animations.playClient("The World", "Donut");
            end;

            local v49;

            if u47:IsA("Model") then
                v49 = Animations.playClient("The World", "AttackPose", nil, nil, u48:FindFirstChildWhichIsA("Humanoid"), true);
            else
                v49 = Animations.playClient("The World", "AttackPose");
            end;

            v49:Play();
            wait(1.1);
            v49:Stop();
        end;
    end,

    callbacks = {
        client = function(p50, p51) -- Line: 377, Name: client
            -- upvalues: Animations (copy)
            if game:GetService("CollectionService"):HasTag(p51, "Summoned") then
                return;
            end;

            if p50.Cooldowns:FindFirstChild("Swipe") then
                return;
            end;

            if game:GetService("CollectionService"):HasTag(p51, "Crouching") then
                Animations.playClient("ShadowDio", "Crawl Swipe");

                return;
            end;

            Animations.playClient("ShadowDio", "Swipe");
        end
    }
};
u2.TMoves = {
    Checks = v3,
    Checkmate = {
        Damage = 30,
        UltimateProgress = 25,
        Stun = 0.25,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v4,
        Knockback = { 20, 0.1 },
        Sound = { { "rbxassetid://6750490488", 2, 0, false } }
    },
    KnifeBarrage = {
        Damage = 1.2,
        Stun = 0.3,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 20, 0.1 },
        Sound = { { "rbxassetid://6750490488", 0.4, 0, false } },
        HitAnimation = v4
    },
    SpaceRipper = {
        Damage = 30,
        Stun = 0.3,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Sound = { { "rbxassetid://6750490488", 0.4, 0, false } },
        HitAnimation = v4
    },

    CustomInvoke = function(p52, p53, p54) -- Line: 427, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy), RunService (copy)
        local Character = game.Players.LocalPlayer.Character;

        if Knit.CollectionService:HasTag(Character, "Summoned") then
            local u55 = p54 or game.Players.LocalPlayer;
            local u56 = p54 or u55.Character;
            task.spawn(function() -- Line: 433
                -- upvalues: u55 (copy), u56 (copy), Knit (ref), Animations (ref)
                local v57 = os.clock();
                local v58 = false;

                while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T) do
                    if os.clock() - v57 >= 0.2 then
                        v58 = true;
                        break;
                    end;

                    task.wait();
                end;

                if v58 then
                    if u55.Cooldowns:FindFirstChild("STANDOFF-T") then
                        return;
                    end;

                    coroutine.resume(coroutine.create(function() -- Line: 461
                        -- upvalues: u56 (ref), Knit (ref)
                        u56.Values.Active.Value = "temp";
                        Knit.Remotes.InputFunc:InvokeServer("T", false);
                    end));
                    Animations.playClient("The World", "JosephKnife");

                    return;
                end;

                if u55.Cooldowns:FindFirstChild("STANDON-T") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 447
                    -- upvalues: u56 (ref), Knit (ref)
                    u56.Values.Active.Value = "temp";
                    Knit.Remotes.InputFunc:InvokeServer("T", true);
                end));
                local v59 = Animations.playClient("The World", "Checkmate", nil, nil, u56.Humanoid, true);
                local v60 = Animations.playClient("The World", "AttackPose", nil, nil, u56.Humanoid, true);
                v59:Play(0.15, 1, 1);
                v60:Play(0.15, 1, 1);
                wait(1);
                v60:Stop();
            end);

            return not RunService:IsClient() and "Server";
        end;

        local v61 = os.clock();
        local v62 = false;

        while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.T) do
            if os.clock() - v61 >= 0.2 then
                v62 = true;
                break;
            end;

            task.wait();
        end;

        print(v62);
        Character.Values.Active.Value = "temp";
        Knit.Remotes.InputFunc:InvokeServer("T", not v62);
    end
};
u2.YMoves = {
    Checks = v3,
    RoadRoller = {
        Damage = 3,
        UltimateProgress = 1,
        BlockBreak = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p63) -- Line: 490, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p63.Name;
            end
        },
        HitAnimation = v4,
        Knockback = { 20, 0.1 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 18,
            Offset = CFrame.new(0, -5, 0)
        }
    },
    BloodSuck = {
        Cooldown = 0.15,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p64) -- Line: 505, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p64.Name;
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 3.8,
            Offset = CFrame.new(0, 0, -4)
        }
    },

    CustomInvoke = function(p65, p66, p67) -- Line: 515, Name: CustomInvoke
        -- upvalues: Knit (copy), RunService (copy), Animations (copy)
        if Knit.CollectionService:HasTag(game.Players.LocalPlayer.Character, "Summoned") then
            local LocalPlayer = game.Players.LocalPlayer;
            local u68 = p67 or LocalPlayer.Character;
            local v69 = RunService:IsServer();

            if Knit.CollectionService:HasTag(u68, "Summoned") then
                if v69 then
                    return "Server";
                end;

                if LocalPlayer.Cooldowns:FindFirstChild("STANDON-Y") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 525
                    -- upvalues: u68 (copy), Knit (ref)
                    u68.Values.Active.Value = "temp";
                    Knit.Remotes.InputFunc:InvokeServer("Y");
                end));
            end;
        else
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;

            if LocalPlayer.Cooldowns:FindFirstChild("BloodSuck") or LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-Y") then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 536
                -- upvalues: Character (copy), Knit (ref)
                Character.Values.Active.Value = "temp";
                Knit.Remotes.InputFunc:InvokeServer("Y");
            end));
            Animations.playClient("ShadowDio", "Blood Suck Attempt");
        end;
    end
};
u2.FMoves = {
    Checks = v3,

    CustomInvoke = function(p70, p71, p72) -- Line: 547, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        if not Knit.CollectionService:HasTag(game.Players.LocalPlayer.Character, "Summoned") then
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;

            if LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-F") or workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") == true then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 583
                -- upvalues: Character (copy), Knit (ref)
                Character.Values.Active.Value = "temp";
                Knit.Remotes.InputFunc:InvokeServer("F");
            end));
            Animations.playClient("ShadowDio", "Timestop");

            return;
        end;

        local u73 = p72 or game.Players.LocalPlayer;
        local u74 = p72 or u73.Character;

        if u73.Cooldowns:FindFirstChild("STANDON-F") or workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") then
            return;
        end;

        coroutine.resume(coroutine.create(function() -- Line: 556
            -- upvalues: u74 (copy), u73 (copy), Knit (ref)
            u74.Values.Active.Value = "temp";

            if u73:IsA("Player") then
                Knit.Remotes.InputFunc:InvokeServer("F");

                return;
            end;

            require(game.ServerScriptService.Main.MainFunctions):Move(u74, "F");
        end));
        local v75 = 0.75;
        local v76;

        if u73:IsA("Player") then
            local v77 = u73.Data:FindFirstChild("Skin") and u73.Data.Skin:GetAttribute("SkinName") or nil;
            v75 = v77 and v77 == "Arcade" and 1 or v75;
            v76 = Animations.playClient("The World", "TS");
        else
            v76 = Animations.playClient("The World", "TS", nil, nil, u74:FindFirstChildWhichIsA("Humanoid"), true);
        end;

        v76:Play(0.1, 1, v75);
    end
};
u2.GMoves = {
    Checks = v3,
    DebrisSlam = {
        Cooldown = 10,
        Damage = 45,
        UltimateProgress = 45,
        Stun = 0.3,
        Checks = v3,
        Knockback = { 65, 0.5 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, 0, -5)
        },
        HitAnimation = v4,
        InfoTable = {
            Effects = {
                HitEffect1 = {}
            }
        },
        Remotes = { { "FX", "Kur HitEffect" } }
    },
    StandUppercut = {
        Damage = 11,
        Cooldown = 7,
        Stun = 0.9,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart", "Exception" },
        Sound = { { "rbxassetid://5581325281", 0.6, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    callbacks = {
        client = function(p78, p79) -- Line: 636, Name: client
            -- upvalues: Knit (copy), Animations (copy), RunService (copy)
            if not Knit.CollectionService:HasTag(p79, "Summoned") then
                if p78.Cooldowns:FindFirstChild("Stand Uppercut") then
                    return;
                end;

                return;
            end;

            if p78.Cooldowns:FindFirstChild("DebrisSlam") then
                return;
            end;

            Animations.playClient("The World", "GroundSlam", nil, nil, p79.Humanoid, RunService:IsServer());
            local v80 = Animations.playClient("The World", "AttackPose", nil, nil, p79.Humanoid, RunService:IsServer());
            v80:Play();
            wait(1.1);
            v80:Stop();
        end
    },

    CustomInvoke = function(p81, p82, p83) -- Line: 654, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;

        if Knit.CollectionService:HasTag(Character, "Summoned") then
            Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("G", false);

            return;
        end;

        local v84 = os.clock();
        local v85 = false;

        while game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.G) do
            if os.clock() - v84 >= 0.2 then
                v85 = true;
                break;
            end;

            task.wait();
        end;

        if not (v85 or LocalPlayer.Cooldowns:FindFirstChild("Stand Uppercut")) then
            Animations.playClient("ShadowDio", "Stand Uppercut");
        end;

        Character.Values.Active.Value = "temp";
        Knit.Remotes.InputFunc:InvokeServer("G", v85);
    end
};
u2.HMoves = {
    Checks = v3,
    StopSign = {
        Damage = 25,
        UltimateProgress = 25,
        BlockBreak = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p86) -- Line: 682, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p86.Name;
            end
        },
        HitAnimation = v4,
        Knockback = { 20, 0.1 },
        Sound = { { "rbxassetid://6750490488", 2, 0, false } }
    },
    Punishment = {
        Cooldown = 15,
        Damage = 35,
        Stun = 1.25,
        BlockBreak = true,
        LeaveParts = { "StandHumanoidRootPart", "Exception" },
        Remotes = { { "FX", "HeavyEffect" } },
        Sound = { { "rbxassetid://6883695371", 1, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Offset = CFrame.new(0, -0.75, -3.5)
        }
    },

    CustomInvoke = function(p87, p88, p89) -- Line: 711, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local u90 = p89 or LocalPlayer.Character;
        local v91 = game:GetService("RunService"):IsServer();

        if not Knit.CollectionService:HasTag(u90, "Summoned") then
            game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("H");

            return;
        end;

        if v91 then
            Animations.playClient("The World", "SignSlam", nil, nil, u90.Humanoid, v91);
        else
            if LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-Y") then
                return;
            end;

            Animations.playClient("The World", "SignSlam");
        end;

        if v91 then
            return "Server", "SUB-Y";
        end;

        coroutine.resume(coroutine.create(function() -- Line: 725
            -- upvalues: u90 (copy), Knit (ref)
            u90.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("H");
        end));
    end
};
u2.VMoves = {
    Checks = v3,
    Teleport = {
        Cooldown = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p92) -- Line: 742, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p92.Name;
            end
        }
    },

    CustomInvoke = function(p93) -- Line: 744, Name: CustomInvoke
        -- upvalues: Knit (copy), Animations (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local _ = LocalPlayer.Character;

        if LocalPlayer.Cooldowns:FindFirstChild("Teleport") then
            return;
        end;

        coroutine.resume(coroutine.create(function() -- Line: 750
            -- upvalues: Knit (ref)
            game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("V");
        end));
        local v94 = Animations.playClient("The World", "TeleportPose");
        wait(0.5);
        v94.TimePosition = 0.6;
    end
};
u2.BMoves = {
    Checks = v3,

    CustomInvoke = function(p95) -- Line: 763, Name: CustomInvoke
        -- upvalues: Knit (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-B") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        coroutine.resume(coroutine.create(function() -- Line: 769
            -- upvalues: Character (copy), Knit (ref)
            Character.Values.Active.Value = "temp";
            Knit.Remotes.InputFunc:InvokeServer("B");
        end));
    end
};
u2.UMoves = {
    Checks = v3,
    callbacks = {
        client = function(p96, p97, p98) -- Line: 779, Name: client
            -- upvalues: Knit (copy), Animations (copy)
            if Knit.CollectionService:HasTag(p97, "Summoned") then
                return;
            end;

            if Knit.CollectionService:HasTag(p97, "STW") then
                Animations.stopClient("ShadowDio", "ShadowStandIdle");

                return;
            end;

            Animations.playClient("ShadowDio", "ShadowStandIdle");
            Animations.playClient("ShadowDio", "Summon");
        end
    }
};
u2.Pose = {
    DoNotDeactivate = true,
    Cooldown = 2,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = false,
        CheckTimestop = true,

        ExtraCheck = function(p99) -- Line: 795, Name: ExtraCheck
            return p99.Character.Values.Active.Value == "" and true or p99.Character.Values.Active.Value == "P";
        end
    },
    callbacks = {
        client = function(p100, p101, p102) -- Line: 798, Name: client
            -- upvalues: Knit (copy), Animations (copy)
            local v103 = Knit.CollectionService:HasTag(p101, "Summoned") and "The World" or "ShadowDio";

            if Knit.CollectionService:HasTag(p101, "Posing") then
                Animations.stopClient("The World", "PoseIdle");
                Animations.stopClient("ShadowDio", "ShadowPoseIdle");
                local BinaryStringValue = Instance.new("BinaryStringValue");
                BinaryStringValue.Name = "P";
                BinaryStringValue.Parent = p100.Cooldowns;

                while true do
                    wait(0.025);
                    local v104 = 0;

                    for _, child in pairs(p100.Cooldowns:GetChildren()) do
                        if child.Name == "P" then
                            v104 = v104 + 1;
                        end;
                    end;

                    if v104 == 2 then
                        BinaryStringValue:Destroy();

                        return;
                    end;
                end;
            else
                local v105 = nil;
                local v106 = nil;

                if v103 == "The World" then
                    Animations.playClient(v103, "PoseTransitionStand");
                    v105 = Animations.playClient(v103, "PoseTransitionUser");
                else
                    v106 = Animations.playClient(v103, "ShadowPoseTransition");
                end;

                if v105 then
                    v105.Stopped:Wait();
                end;

                if v106 then
                    v106.Stopped:Wait();
                end;

                if v103 == "The World" then
                    Animations.playClient(v103, "PoseIdle");
                else
                    Animations.playClient(v103, "ShadowPoseIdle");
                end;

                local BinaryStringValue = Instance.new("BinaryStringValue");
                BinaryStringValue.Name = "P";
                BinaryStringValue.Parent = p100.Cooldowns;

                while true do
                    wait(0.025);
                    local v107 = 0;

                    for _, child in pairs(p100.Cooldowns:GetChildren()) do
                        if child.Name == "P" then
                            v107 = v107 + 1;
                        end;
                    end;

                    if v107 == 2 then
                        BinaryStringValue:Destroy();

                        return;
                    end;
                end;
            end;
        end
    }
};
u2.Taunt = {
    Checks = {
        CheckStunned = false,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = false,
        CheckTimestop = true
    },
    Quotes = { { "You are next.", "rbxassetid://6883711772", {}, 2, 2.5 }, { "You\'re looking at me, aren\'t you!", "rbxassetid://4845894614", {}, 2 }, { "What is it that you desire?", "rbxassetid://6883712770", {}, 2 } }
};
u2.Jab = u2["LMB Combo"].Jab;
u2.Barrage = u2.EMoves.Barrage;
u2["High Kick"] = u2.EMoves.HighKick;
u2.Donut = u2.RMoves.Donut;
u2.Swipe = u2.RMoves.Swipe;
u2.Checkmate = u2.TMoves.Checkmate;
u2["Knife Barrage"] = u2.TMoves.KnifeBarrage;
u2["Space Ripper"] = u2.TMoves.SpaceRipper;
u2.RoadRoller = u2.YMoves.RoadRoller;
u2.BloodSuck = u2.YMoves.BloodSuck;
u2.DebrisSlam = u2.GMoves.DebrisSlam;
u2["Stand Uppercut"] = u2.GMoves.StandUppercut;
u2["Stop Sign"] = u2.HMoves.StopSign;
u2.Punishment = u2.HMoves.Punishment;
u2.Teleport = u2.VMoves.Teleport;

return v1;