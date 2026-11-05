  

 

local u1 = {};
local v2 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
};
local v3 = { "rbxassetid://10506585922", "rbxassetid://10506586710", "rbxassetid://10506587599" };
local u4 = {
    Inker = {}
};
game:GetService("PhysicsService");
game:GetService("TweenService");
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local Stands = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local Skins = require(game.ReplicatedStorage.ReplicatedModules.Skins);
require(game.ReplicatedStorage.ReplicatedModules.Enums);
local CollectionService = game:GetService("CollectionService");
local InputFunc = game.ReplicatedStorage.Remotes.InputFunc;
local _ = CFrame.Angles;
local _ = math.rad;
local Stands2 = require(game.ReplicatedStorage.ReplicatedModules.Stands);
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local Output = PathShortcuts.RemotesPath.Output;

local function Lerp(p5, p6, p7) -- Line: 32
    return p5 + (p6 - p5) * p7;
end;

local u8 = {};
local u9 = {};

local function defaultCombo(u10, u11) -- Line: 39
    -- upvalues: Stands (copy), u1 (copy), u4 (copy), u8 (copy), CollectionService (copy), u9 (copy), Animations (copy), RunService (copy), InputFunc (copy)
    return function(u12, p13, p14) -- Line: 40
        -- upvalues: Stands (ref), u1 (ref), u10 (copy), u4 (ref), u8 (ref), CollectionService (ref), u9 (ref), Animations (ref), RunService (ref), InputFunc (ref), u11 (copy)
        local v15 = p14 or game.Players.LocalPlayer;
        local u16 = p14 or v15.Character;
        local v17 = Stands[v15.Data.Ability.Value];
        local v18;

        if v15.Data:FindFirstChild("Skin") then
            v18 = v15.Data.Skin:GetAttribute("SkinName") or nil;
        else
            v18 = nil;
        end;

        local v19 = u1.Stats[v17][u10];

        if not u4[v17][v15.Name] then
            u4[v17][v15.Name] = {};
        end;

        local u20 = u4[v17][v15.Name];

        if not u20[u10] then
            u20[u10] = 1;
        end;

        if not u20[u12] then
            u20[u12] = true;
            local u21 = u20[u10];
            local v22 = v19.AnimSpeed or u8;
            local v23 = v19.StandOff and not CollectionService:HasTag(u16, "Summoned") and "StandOff-" or "";
            local u24 = v19.Standoff or v19;
            local v25;

            if u9[v17] then
                v25 = u9[v17][u12] or u12;
            else
                v25 = u12;
            end;

            local v26 = v23 .. v25 .. "-" .. u21;

            if v18 then
                local v27, v28 = Animations.SearchAnim(v18, v26);

                if v27 then
                    if not v28 then
                        v18 = v17;
                    end;
                else
                    v18 = v17;
                end;
            else
                v18 = v17;
            end;

            local u29;

            if RunService:IsClient() then
                u29 = Animations.playClient(v18, v26, nil, v22[u21]);
            else
                u29 = Animations.playClient(v18, v26, nil, v22[u21], u16.Humanoid, true);
            end;

            task.spawn(function() -- Line: 76
                -- upvalues: RunService (ref), u16 (copy), InputFunc (ref), u12 (copy), u29 (ref), u21 (copy), u24 (copy), u20 (copy), u10 (ref), u11 (ref)
                if RunService:IsClient() then
                    u16.Values.Active.Value = "temp";
                    InputFunc:InvokeServer(u12);
                end;

                if u29.Looped then
                    u29:Stop();
                end;

                if u21 == u24.MaxCombo then
                    u20[u10] = 1;
                else
                    local v30 = u20;
                    local v31 = u10;
                    v30[v31] = v30[v31] + 1;
                end;

                coroutine.wrap(function() -- Line: 87
                    -- upvalues: u20 (ref), u10 (ref), u11 (ref), u24 (ref)
                    local v32 = u20[u10];
                    wait((u11 or 1.5) + u24.ComboTick);

                    if v32 == u20[u10] then
                        u20[u10] = 1;
                    end;
                end)();
                wait(u24.ComboTick);
                u20[u12] = nil;
            end);

            return not RunService:IsClient() and "Server";
        end;
    end;
end;

local InputTracker = require(game.ReplicatedStorage.ClientModules.InputTracker);

local function CheckSummoner(p33) -- Line: 137
    local v34 = game.Players:GetPlayerFromCharacter(p33) or p33;

    return not (v34:FindFirstChild("Values") and v34.Values:FindFirstChild("Summoner")) and "" or v34.Values.Summoner.Value;
end;

local function weldcon(p35, p36, p37) -- Line: 146
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p36;
    WeldConstraint.Part1 = p37;
    WeldConstraint.Parent = p36;
end;

local function findNearest(p38, p39, p40, p41) -- Line: 152
    -- upvalues: CollectionService (copy)
    local v42 = p41 or {};

    if p40 then
        local v43 = {};

        for _, child in ipairs(workspace.Living:GetChildren()) do
            if CollectionService:HasTag(child, "Hitable") and not table.find(v42, child) then
                local v44 = child:IsA("Model") and child.PrimaryPart or child:FindFirstChild("HumanoidRootPart");

                if v44 and (v44.Position - p38.Position).Magnitude <= p39 then
                    table.insert(v43, child);
                end;
            end;
        end;

        return v43;
    end;

    local v45 = nil;

    for _, child in ipairs(workspace.Living:GetChildren()) do
        if CollectionService:HasTag(child, "Hitable") and not table.find(v42, child) then
            local v46 = child:IsA("Model") and child.PrimaryPart or child:FindFirstChild("HumanoidRootPart");

            if v46 then
                local Magnitude = (v46.Position - p38.Position).Magnitude;

                if Magnitude < p39 then
                    v45 = child;
                    p39 = Magnitude;
                end;
            end;
        end;
    end;

    return v45, p39;
end;

local function deepCopy(p47) -- Line: 185
    -- upvalues: deepCopy (copy)
    local v48 = {};

    for i, v in pairs(p47) do
        if type(v) == "table" then
            local v = deepCopy(v) or v;
        end;

        v48[i] = v;
    end;

    return v48;
end;

local v49 = {
    ["Senator Armstrong"] = {
        ["You Freak!"] = {
            Cooldown = 0.1,
            Damage = 15,
            Stun = 0.5,
            Checks = v2
        },
        ["Try University of Texas"] = {
            Cooldown = 0.1,
            Damage = 10,
            Stun = 0.1,
            Checks = v2
        },
        ["Don\'t Mess With This Senator!"] = {
            Cooldown = 0.1,
            Damage = 20,
            Stun = 2,
            Checks = v2
        },
        ["I\'m Giving You Another Shot"] = {
            Cooldown = 0.1,
            Damage = 20,
            Stun = 2,
            Checks = v2
        },
        ["This Is How I Work!"] = {
            Cooldown = 0.1,
            Checks = v2
        },
        ["Try Again!"] = {
            Cooldown = 0.1,
            Damage = 25,
            Stun = 3,
            Checks = v2
        },
        ["I Don\'t Have Time For This"] = {
            Cooldown = 0.1,
            Damage = 25,
            Stun = 3,
            Checks = v2
        },
        ["Can\'t Fret Over Every Egg"] = {
            Checks = v2
        }
    }
};
local v50 = {};
local v51 = {
    Cooldown = 0.35,
    Stun = 0.4,
    Damage = 10,
    MaxCombo = 5,
    ComboTick = 0.3,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 9,
        Offset = CFrame.new(0, 0, 0)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://157299184", 2, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    AnimSpeed = {
        [4] = 2
    }
};
local u52 = "LMB Combo";
local u53 = 0.75;

function v51.CustomInvoke(u54, p55, p56) -- Line: 40
    -- upvalues: Stands (copy), u1 (copy), u52 (copy), u4 (copy), u8 (copy), CollectionService (copy), u9 (copy), Animations (copy), RunService (copy), InputFunc (copy), u53 (copy)
    local v57 = p56 or game.Players.LocalPlayer;
    local u58 = p56 or v57.Character;
    local v59 = Stands[v57.Data.Ability.Value];
    local v60;

    if v57.Data:FindFirstChild("Skin") then
        v60 = v57.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v60 = nil;
    end;

    local v61 = u1.Stats[v59][u52];

    if not u4[v59][v57.Name] then
        u4[v59][v57.Name] = {};
    end;

    local u62 = u4[v59][v57.Name];

    if not u62[u52] then
        u62[u52] = 1;
    end;

    if not u62[u54] then
        u62[u54] = true;
        local u63 = u62[u52];
        local v64 = v61.AnimSpeed or u8;
        local v65 = v61.StandOff and not CollectionService:HasTag(u58, "Summoned") and "StandOff-" or "";
        local u66 = v61.Standoff or v61;
        local v67;

        if u9[v59] then
            v67 = u9[v59][u54] or u54;
        else
            v67 = u54;
        end;

        local v68 = v65 .. v67 .. "-" .. u63;

        if v60 then
            local v69, v70 = Animations.SearchAnim(v60, v68);

            if v69 then
                if not v70 then
                    v60 = v59;
                end;
            else
                v60 = v59;
            end;
        else
            v60 = v59;
        end;

        local u71;

        if RunService:IsClient() then
            u71 = Animations.playClient(v60, v68, nil, v64[u63]);
        else
            u71 = Animations.playClient(v60, v68, nil, v64[u63], u58.Humanoid, true);
        end;

        task.spawn(function() -- Line: 76
            -- upvalues: RunService (ref), u58 (copy), InputFunc (ref), u54 (copy), u71 (ref), u63 (copy), u66 (copy), u62 (copy), u52 (ref), u53 (ref)
            if RunService:IsClient() then
                u58.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u54);
            end;

            if u71.Looped then
                u71:Stop();
            end;

            if u63 == u66.MaxCombo then
                u62[u52] = 1;
            else
                local v72 = u62;
                local v73 = u52;
                v72[v73] = v72[v73] + 1;
            end;

            coroutine.wrap(function() -- Line: 87
                -- upvalues: u62 (ref), u52 (ref), u53 (ref), u66 (ref)
                local v74 = u62[u52];
                wait((u53 or 1.5) + u66.ComboTick);

                if v74 == u62[u52] then
                    u62[u52] = 1;
                end;
            end)();
            wait(u66.ComboTick);
            u62[u54] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v50["LMB Combo"] = v51;
v50["Lightning Dash"] = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },

    CustomInvoke = function(p75) -- Line: 618, Name: CustomInvoke
        -- upvalues: InputTracker (copy), InputFunc (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("LDash") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        local u76 = InputTracker:IsKeyDown(Enum.KeyCode.W) and "Foward" or (InputTracker:IsKeyDown(Enum.KeyCode.A) and "Left" or (InputTracker:IsKeyDown(Enum.KeyCode.S) and "Backwards" or (InputTracker:IsKeyDown(Enum.KeyCode.D) and "Right" or "Foward")));
        coroutine.resume(coroutine.create(function() -- Line: 636
            -- upvalues: Character (copy), InputFunc (ref), u76 (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("Q", u76, Character.HumanoidRootPart.CFrame);
        end));
    end
};
v50["Thundering Leap"] = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },

    CustomInvoke = function(p77) -- Line: 644, Name: CustomInvoke
        -- upvalues: InputFunc (copy), Animations (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("TLeap") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        Character.Humanoid.WalkSpeed = 0;
        Character.Humanoid.JumpPower = 0;
        coroutine.resume(coroutine.create(function() -- Line: 651
            -- upvalues: Character (copy), InputFunc (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("T");
            Character.Humanoid.WalkSpeed = 16;
            Character.Humanoid.JumpPower = 50;
        end));
        Animations.playClient("Dragon Sage", "ThunderingLeap");
    end
};
v50["Monk Shield"] = {
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    callbacks = {
        client = function(p78, p79, p80) -- Line: 662, Name: client
            -- upvalues: InputTracker (copy)
            repeat
                wait();
            until not InputTracker:IsKeyDown(Enum.KeyCode.G);
        end
    }
};
v50["Lightning Drop"] = {
    Damage = 75,
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
        Offset = CFrame.new(0, 0, -4)
    },

    CustomInvoke = function(p81) -- Line: 677, Name: CustomInvoke
        -- upvalues: InputFunc (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("LDrop") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        coroutine.resume(coroutine.create(function() -- Line: 683
            -- upvalues: Character (copy), InputFunc (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("R");
        end));
    end
};
v50["Seismic Toss"] = {
    Damage = 25,
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
        Size = 6,
        Offset = CFrame.new(0, 0, 0)
    },
    Remotes = { { "FX", "HitEffect" } },
    HitAnimation = v3,

    CustomInvoke = function(p82) -- Line: 702, Name: CustomInvoke
        -- upvalues: InputFunc (copy), Animations (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("LElbow") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        coroutine.resume(coroutine.create(function() -- Line: 708
            -- upvalues: Character (copy), InputFunc (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("F");
        end));
        Animations.playClient("Dragon Sage", "GrabAttempt");
    end
};
v50["Electric Smite"] = {
    Damage = 50,
    Stun = 2,
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
        Size = 6,
        Offset = CFrame.new(0, 0, 0)
    },
    Remotes = { { "FX", "HitEffect" } },
    HitAnimation = v3,

    CustomInvoke = function(p83) -- Line: 729, Name: CustomInvoke
        -- upvalues: InputFunc (copy), Animations (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("LElbow") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        Character.Humanoid.WalkSpeed = 0;
        Character.Humanoid.JumpPower = 0;
        coroutine.resume(coroutine.create(function() -- Line: 736
            -- upvalues: Character (copy), InputFunc (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("Y");
            Character.Humanoid.WalkSpeed = 16;
            Character.Humanoid.JumpPower = 50;
        end));
        Animations.playClient("Dragon Sage", "ElectricSmite");
    end
};
v50["Lightning Elbow"] = {
    Damage = 50,
    Stun = 2,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    Hitbox = {
        Type = "Region3",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = Vector3.new(6, 6, 35),
        Offset = CFrame.new(0, 0, -17.5)
    },
    Remotes = { { "FX", "HitEffect" } },

    CustomInvoke = function(p84) -- Line: 756, Name: CustomInvoke
        -- upvalues: InputFunc (copy), Animations (copy)
        if game.Players.LocalPlayer.Cooldowns:FindFirstChild("LElbow") then
            return;
        end;

        local Character = game.Players.LocalPlayer.Character;
        Character.Humanoid.WalkSpeed = 0;
        Character.Humanoid.JumpPower = 0;
        coroutine.resume(coroutine.create(function() -- Line: 763
            -- upvalues: Character (copy), InputFunc (ref)
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("E");
            Character.Humanoid.WalkSpeed = 16;
            Character.Humanoid.JumpPower = 50;
        end));
        Animations.playClient("Dragon Sage", "LElbow");
    end
};
v49["Dragon Sage"] = v50;
v49["The World"] = {
    Pose = {
        DoNotDeactivate = true,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = false,
            CheckTimestop = true,

            ExtraCheck = function(p85) -- Line: 775, Name: ExtraCheck
                return p85.Character.Values.Active.Value == "" and true or p85.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p86, p87, p88) -- Line: 778, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p87, "Posing") then
                    Animations.stopClient("The World", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p86.Cooldowns;

                    while true do
                        wait(0.025);
                        local v89 = 0;

                        for _, child in pairs(p86.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v89 = v89 + 1;
                            end;
                        end;

                        if v89 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    local v90, _ = Animations.FindAnim("The World", "PoseTransition");
                    local v91;

                    if p86.Data.Skin:GetAttribute("SkinName") == "Arcade" then
                        Animations.playClient("The World", "PoseTransitionStand");
                        v91 = Animations.playClient("The World", "PoseTransitionUser");
                    elseif v90 then
                        v91 = Animations.playClient("The World", "PoseTransition");
                    else
                        Animations.playClient("The World", "PoseTransitionStand");
                        v91 = Animations.playClient("The World", "PoseTransitionUser");
                    end;

                    v91.Stopped:Wait();
                    Animations.playClient("The World", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p86.Cooldowns;

                    while true do
                        wait(0.025);
                        local v92 = 0;

                        for _, child in pairs(p86.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v92 = v92 + 1;
                            end;
                        end;

                        if v92 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    Summon = {
        Cooldown = 1.5,
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
            client = function(p93, p94, p95) -- Line: 843, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p94, "Summoned") then
                    if p93 == nil then
                        Animations.stopClient("The World", "StandIdle", p94, true);

                        return;
                    end;

                    Animations.stopClient("The World", "StandIdle");

                    return;
                end;

                if p93 == nil then
                    Animations.playClient("The World", "StandIdle", nil, nil, p94:FindFirstChildWhichIsA("Humanoid"), true);

                    return;
                end;

                Animations.playClient("The World", "StandIdle");
            end
        }
    },
    Barrage = {
        Cooldown = 10,
        AfterMove = true,
        Length = 2.8,
        Damage = 1.3,
        UltimateProgress = 5,
        Stun = 0.4,
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706982698", 0.5, 0, false } },

        CustomInvoke = function(p96, p97, p98) -- Line: 877, Name: CustomInvoke
            -- upvalues: Animations (copy), InputFunc (copy), InputTracker (copy)
            local u99 = p98 or game.Players.LocalPlayer;
            local u100 = p98 or u99.Character;

            if not game:GetService("CollectionService"):HasTag(u100, "Tandeming") and game:GetService("CollectionService"):HasTag(u100, "Summoned") then
                if game:GetService("CollectionService"):HasTag(u100, "Summoned") then
                    local v101;

                    if u99:IsA("Player") then
                        v101 = Animations.playClient("The World", "AttackPose");
                    else
                        v101 = Animations.playClient("The World", "AttackPose", nil, nil, u100:FindFirstChildWhichIsA("Humanoid"), true);
                    end;

                    if v101 then
                        v101:Play();
                    end;

                    coroutine.resume(coroutine.create(function() -- Line: 906
                        -- upvalues: u100 (copy), u99 (copy), InputFunc (ref)
                        u100.Values.Active.Value = "temp";

                        if u99:IsA("Player") then
                            InputFunc:InvokeServer("E");

                            return;
                        end;

                        require(game.ServerScriptService.Main.MainFunctions):Move(u100, "E");
                    end));
                    local v102 = tick();

                    repeat
                        wait(0.025);
                    until tick() - v102 > 2.8 or u99:IsA("Player") and not InputTracker:IsKeyDown(Enum.KeyCode.E);

                    if v101 then
                        v101:Stop();
                    end;
                end;

                return;
            end;

            if u99:IsA("Player") then
                Animations.playClient("The World", "RoundhouseKick");

                return;
            end;

            Animations.playClient("The World", "RoundhouseKick", nil, nil, u100:FindFirstChildWhichIsA("Humanoid"), true);
        end,

        TimestoppedRemotes = { { "FX", "TimestopHit" } },
        InfoTable = {
            Effects = {
                Bleed = {
                    LightEmission = -0.1,
                    Speed = 1.2,
                    Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4) })
                },
                BarragekurEffect = {
                    LightEmission = 0.2,
                    Speed = 5,
                    RotSpeed = 0,
                    Rotation = 0,
                    Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 4) })
                }
            }
        },
        HitData = {
            Color = Color3.new(1, 0.776471, 0.0941176)
        },
        Remotes = { { "FX", "Kur HitEffect" }, { "FX", "HitEffect" } }
    },
    Tandem = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            Cooldown = 15,
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4.5)
        },
        callbacks = {
            client = function(p103, p104, p105) -- Line: 967, Name: client
                -- upvalues: Animations (copy)
                local v106 = Animations.playClient("The World", "WRY");
                v106:Play(0.1, 1, 1.5);
                wait(1);
                v106:Stop();
                local v107 = Animations.playClient("The World", "DashAttackPose");
                Animations.playClient("The World", "Tandem"):Play();
                wait(1);
                v107:Stop();
            end
        }
    },
    DebrisSlam = {
        Cooldown = 10,
        Damage = 45,
        UltimateProgress = 45,
        Stun = 0.3,
        Checks = v2,
        Knockback = { 65, 0.5 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 12,
            Offset = CFrame.new(0, 0, -5)
        },
        HitAnimation = v3,
        InfoTable = {
            Effects = {
                HitEffect1 = {}
            }
        },
        Remotes = { { "FX", "Kur HitEffect" } },
        callbacks = {
            client = function(p108, p109, p110) -- Line: 1003, Name: client
                -- upvalues: Animations (copy), RunService (copy)
                Animations.playClient("The World", "GroundSlam", nil, nil, p109.Humanoid, RunService:IsServer());
                local v111 = Animations.playClient("The World", "AttackPose", nil, nil, p109.Humanoid, RunService:IsServer());
                v111:Play();
                wait(1.1);
                v111:Stop();
            end
        }
    },
    NoseGrab = {
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 3,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Sound = { { "rbxassetid://6467631645", 1, 0, false } },
        callbacks = {
            client = function(p112, p113, p114) -- Line: 1023, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("The World", "GrabThrow");
            end,

            finish = function(p115, p116, p117) -- Line: 1026, Name: finish
            end,

            hit = function(p118, p119, p120, p121) -- Line: 1028, Name: hit
            end
        }
    },
    BloodSuck = {
        Cooldown = 30,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p122) -- Line: 1033, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p122.Name;
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4)
        },

        CustomInvoke = function(p123, p124, p125) -- Line: 1044, Name: CustomInvoke
            -- upvalues: InputFunc (copy), Animations (copy), RunService (copy)
            local v126 = p125 or game.Players.LocalPlayer;
            local u127 = p125 or v126.Character;

            if not v126.Cooldowns:FindFirstChild("B") then
                coroutine.resume(coroutine.create(function() -- Line: 1048
                    -- upvalues: u127 (copy), InputFunc (ref)
                    u127.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("B");
                end));
                Animations.playClient("The World", "BloodSuckAttempt", nil, nil, u127.Humanoid, true);

                return not RunService:IsClient() and "Server";
            end;
        end
    },
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
            Size = 6.5,
            Offset = CFrame.new(0, 0, -6.5)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitAnimation = { "rbxassetid://6762858645" },

        CustomInvoke = function(p128, p129, p130) -- Line: 1080, Name: CustomInvoke
            -- upvalues: InputFunc (copy), Animations (copy)
            local u131 = p130 or game.Players.LocalPlayer;
            local u132 = p130 or u131.Character;

            if game:GetService("CollectionService"):HasTag(u132, "Summoned") then
                if u131.Cooldowns:FindFirstChild("R") then
                    return;
                end;

                spawn(function() -- Line: 1085
                    -- upvalues: u132 (copy), u131 (copy), InputFunc (ref)
                    u132.Values.Active.Value = "temp";

                    if u131:IsA("Player") then
                        InputFunc:InvokeServer("R");

                        return;
                    end;

                    require(game.ServerScriptService.Main.MainFunctions):Move(u132, "R");
                end);

                if u131:IsA("Model") then
                    Animations.playClient("The World", "Donut", nil, nil, u132:FindFirstChildWhichIsA("Humanoid"), true);
                else
                    Animations.playClient("The World", "Donut");
                end;

                local v133;

                if u131:IsA("Model") then
                    v133 = Animations.playClient("The World", "AttackPose", nil, nil, u132:FindFirstChildWhichIsA("Humanoid"), true);
                else
                    v133 = Animations.playClient("The World", "AttackPose");
                end;

                v133:Play();
                wait(1.1);
                v133:Stop();
            end;
        end
    },
    Teleport = {
        Cooldown = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p134) -- Line: 1115, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p134.Name;
            end
        },

        CustomInvoke = function(p135, p136, p137) -- Line: 1116, Name: CustomInvoke
            -- upvalues: RunService (copy), Animations (copy), InputFunc (copy)
            if not RunService:IsClient() then
                local v138 = Animations.playClient("The World", "TeleportPose", nil, nil, p137.Humanoid, true);
                wait(0.5);
                v138.TimePosition = 0.6;

                return "Server";
            end;

            local Character = game.Players.LocalPlayer.Character;
            coroutine.resume(coroutine.create(function() -- Line: 1125
                -- upvalues: Character (copy), InputFunc (ref)
                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("V");
            end));
            local v139 = Animations.playClient("The World", "TeleportPose");
            wait(0.5);
            v139.TimePosition = 0.6;
        end
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
            Damage = 25,
            Stun = 0.5,
            Knockback = { 75, 0.3, Vector3.new(0, 35, 0) },
            Remotes = { { "FX", "HeavyEffect" } },
            Sound = { { "rbxassetid://7243326637", 1, 0, false } }
        },
        HitAnimation = v3,
        Knockback = { 5, 0.05 },
        Sound = { { "rbxassetid://6706982964", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        Callbacks = {}
    },
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

            ExtraCheck = function(p140) -- Line: 1196, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p140.Name;
            end
        },
        HitAnimation = v3,
        Knockback = { 20, 0.1 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 7.5,
            Offset = CFrame.new(0, 0, -3)
        },
        Landed = {
            Unblockable = true,
            Damage = 3,
            UltimateProgress = 1,
            BlockBreak = true,
            Stun = 1,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 36,
                Offset = CFrame.new(0, 0, -3)
            },
            HitAnimation = v3,
            Knockback = { 20, 0.1 }
        },

        CustomInvoke = function(p141, p142, p143) -- Line: 1226, Name: CustomInvoke
            -- upvalues: RunService (copy), CollectionService (copy), InputFunc (copy), Animations (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local u144 = p143 or LocalPlayer.Character;
            local v145 = RunService:IsServer();

            if CollectionService:HasTag(u144, "Summoned") then
                if v145 then
                    return "Server";
                end;

                if LocalPlayer.Cooldowns:FindFirstChild("STANDON-Y") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 1233
                    -- upvalues: u144 (copy), InputFunc (ref)
                    u144.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("Y");
                end));

                return;
            end;

            if v145 then
                Animations.playClient("The World", "SignSlam", nil, nil, u144.Humanoid, v145);
            else
                if LocalPlayer.Cooldowns:FindFirstChild("STANDOFF-Y") then
                    return;
                end;

                Animations.playClient("The World", "SignSlam");
            end;

            if v145 then
                return "Server", "SUB-Y";
            end;

            coroutine.resume(coroutine.create(function() -- Line: 1247
                -- upvalues: u144 (copy), InputFunc (ref)
                u144.Values.Active.Value = "temp";
                InputFunc:InvokeServer("SUB-Y");
            end));
        end
    },
    ["Stop Sign"] = {
        Damage = 25,
        UltimateProgress = 25,
        BlockBreak = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p146) -- Line: 1255, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p146.Name;
            end
        },
        HitAnimation = v3,
        Knockback = { 20, 0.1 },
        Sound = { { "rbxassetid://6750490488", 2, 0, false } }
    },
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
        HitAnimation = v3,
        Knockback = { 20, 0.1 },
        Sound = { { "rbxassetid://6750490488", 2, 0, false } },

        CustomInvoke = function(p147, p148, p149) -- Line: 1277, Name: CustomInvoke
            -- upvalues: CollectionService (copy), InputFunc (copy), Animations (copy), RunService (copy)
            local u150 = p149 or game.Players.LocalPlayer;
            local u151 = p149 or u150.Character;
            task.spawn(function() -- Line: 1280
                -- upvalues: CollectionService (ref), u151 (copy), u150 (copy), InputFunc (ref), Animations (ref)
                if not CollectionService:HasTag(u151, "Summoned") then
                    if u150.Cooldowns:FindFirstChild("STANDOFF-T") then
                        return;
                    end;

                    coroutine.resume(coroutine.create(function() -- Line: 1299
                        -- upvalues: u151 (ref), InputFunc (ref)
                        u151.Values.Active.Value = "temp";
                        InputFunc:InvokeServer("T");
                    end));
                    Animations.playClient("The World", "JosephKnife");

                    return;
                end;

                if u150.Cooldowns:FindFirstChild("STANDON-T") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 1285
                    -- upvalues: u151 (ref), InputFunc (ref)
                    u151.Values.Active.Value = "temp";
                    InputFunc:InvokeServer("T");
                end));
                local v152 = Animations.playClient("The World", "Checkmate", nil, nil, u151.Humanoid, true);
                local v153 = Animations.playClient("The World", "AttackPose", nil, nil, u151.Humanoid, true);
                v152:Play(0.15, 1, 1);
                v153:Play(0.15, 1, 1);
                wait(1);
                v153:Stop();
            end);

            return not RunService:IsClient() and "Server";
        end
    },
    Timestop = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },

        CustomInvoke = function(p154, p155, p156) -- Line: 1312, Name: CustomInvoke
            -- upvalues: CollectionService (copy), InputFunc (copy), Animations (copy)
            local u157 = p156 or game.Players.LocalPlayer;
            local u158 = p156 or u157.Character;

            if not CollectionService:HasTag(u158, "Summoned") then
                if u157.Cooldowns:FindFirstChild("STANDOFF-F") then
                    return;
                end;

                coroutine.resume(coroutine.create(function() -- Line: 1343
                    -- upvalues: u158 (copy), u157 (copy), InputFunc (ref)
                    u158.Values.Active.Value = "temp";

                    if u157:IsA("Player") then
                        InputFunc:InvokeServer("F");

                        return;
                    end;

                    require(game.ServerScriptService.Main.MainFunctions):Move(u158, "F");
                end));

                return;
            end;

            if u157.Cooldowns:FindFirstChild("STANDON-F") or workspace.Mechanics.TimeStopped:GetAttribute("Cooldown") then
                return;
            end;

            coroutine.resume(coroutine.create(function() -- Line: 1319
                -- upvalues: u158 (copy), u157 (copy), InputFunc (ref)
                u158.Values.Active.Value = "temp";

                if u157:IsA("Player") then
                    InputFunc:InvokeServer("F");

                    return;
                end;

                require(game.ServerScriptService.Main.MainFunctions):Move(u158, "F");
            end));
            local v159 = 0.75;
            local v160;

            if u157:IsA("Player") then
                local v161 = u157.Data:FindFirstChild("Skin") and u157.Data.Skin:GetAttribute("SkinName") or nil;
                v159 = v161 and v161 == "Arcade" and 1 or v159;
                v160 = Animations.playClient("The World", "TS");
            else
                v160 = Animations.playClient("The World", "TS", nil, nil, u158:FindFirstChildWhichIsA("Humanoid"), true);
            end;

            v160:Play(0.1, 1, v159);
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
        Quotes = { { "Oh, you\'re coming towards me? You\'re coming to me, #playername, rather than running away?", "rbxassetid://9073321814", {
                    ["Oh, you\'re coming towards me? You\'re coming to me, DIO"] = 0.95
                }, 2, 4 }, { "You\'re next.", "rbxassetid://7098543229", {}, 2, 3 }, { "This is... The World.", "rbxassetid://7098547035", {
                    ["Ho..."] = 1.2,
                    ["Ho... Instead of running away.."] = 1
                }, 3 } }
    }
};
v49["Demon Lord"] = {
    ["Area Timestop"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p162, p163) -- Line: 1747, Name: client
            end
        }
    },
    ["Devil Eyes"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p164, p165) -- Line: 1757, Name: client
            end
        }
    },
    ["Dark Ball"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p166, p167) -- Line: 1767, Name: client
            end
        }
    },
    ["Lightning Strike"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p168, p169) -- Line: 1777, Name: client
            end
        }
    },
    Regenerate = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p170, p171) -- Line: 1787, Name: client
            end
        }
    }
};
v49.Garuto = {
    ["LMB Combo"] = {
        Damage = 12,
        Cooldown = 0.1,
        Stun = 0.85,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(0, 193, 155)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -2.25)
        }
    },
    EMoves = {
        Damage = 8,
        Cooldown = 0.1,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(0, 193, 155)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -2.25)
        }
    },
    QMoves = {
        Damage = 8,
        Cooldown = 0.1,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(0, 193, 155)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -2.25)
        }
    }
};
v49["Uber Oni"] = {
    Misogi = {
        Cooldown = 6,
        Stun = 1.2,
        Damage = 55,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, 0)
        },
        Remotes = { { "FX", "HitEffect" } },

        CustomInvoke = function(p172) -- Line: 1883, Name: CustomInvoke
            -- upvalues: Animations (copy), InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local v173 = LocalPlayer:GetMouse();

            if v173.Target.Name == "HumanoidRootPart" or (v173.Target.Name == "Torso" or (v173.Target.Name == "StandHumanoidRootPart" or v173.Target.Name == "Handle")) then
                local Parent = v173.Target.Parent;

                if Parent.Name == "Stand" or Parent:IsA("Accessory") then
                    Parent = v173.Target.Parent.Parent;
                end;

                local v174 = Animations.playClient("Uber Oni", "Misogi");
                LocalPlayer.Character.Humanoid.WalkSpeed = 0;
                LocalPlayer.Character.Humanoid.JumpPower = 0;
                wait(0.5);
                InputFunc:InvokeServer(p172, Parent);
                LocalPlayer.Character.Humanoid.WalkSpeed = 16;
                LocalPlayer.Character.Humanoid.JumpPower = 50;
                v174:AdjustSpeed(5);
                wait(0.5);
                v174:AdjustSpeed(0.01);
                wait(0.5);
                v174:AdjustSpeed(1);
            end;
        end
    },
    RisingDragon = {
        Damage = 25,
        Cooldown = 2,
        Stun = 1.2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 7,
            Offset = CFrame.new(0, 0, 0)
        },
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://367499850", 2, 0, false } },
        callbacks = {
            client = function(p175, p176, p177) -- Line: 1926, Name: client
                -- upvalues: Animations (copy)
                local u178 = Animations.playClient("Uber Oni", "RisingDragon");
                u178:AdjustSpeed(0.1);
                coroutine.wrap(function() -- Line: 1929
                    -- upvalues: u178 (copy)
                    wait(0.1);
                    u178:AdjustSpeed(0.95);
                end)();
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Parent = p176.HumanoidRootPart;
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Velocity = p176.HumanoidRootPart.CFrame.lookVector * 30;

                for _ = 1, 35 do
                    BodyVelocity.Velocity = p176.HumanoidRootPart.CFrame.lookVector * 30;
                    wait();
                end;

                BodyVelocity:Destroy();
            end,

            finish = function(p179, p180, p181) -- Line: 1944, Name: finish
            end,

            hit = function(p182, p183, p184, p185) -- Line: 1946, Name: hit
            end
        }
    },
    LegBreaker = {
        Damage = 25,
        Cooldown = 2,
        Stun = 4,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5,
            Offset = CFrame.new(0, 0, -1)
        },
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://2270168878", 2, 0, false } },
        callbacks = {
            client = function(p186, p187, p188) -- Line: 1970, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Uber Oni", "LegBreaker");
            end,

            finish = function(p189, p190, p191) -- Line: 1973, Name: finish
            end,

            hit = function(p192, p193, p194, p195) -- Line: 1975, Name: hit
            end
        }
    },
    DemonFlipM2 = {
        Damage = 10,
        Cooldown = 2,
        Stun = 1.2,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5,
            Offset = CFrame.new(0, 0, 0)
        },
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://367499850", 2, 0, false } },
        callbacks = {
            client = function(p196, p197, p198) -- Line: 1999, Name: client
                -- upvalues: Animations (copy)
                local v199 = Animations.playClient("Uber Oni", "Flip2");
                v199:AdjustSpeed(0.7);
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Parent = p197.HumanoidRootPart;
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Velocity = p197.HumanoidRootPart.CFrame.lookVector * 25;

                for i = 1, 35 do
                    if i == 15 then
                        v199:AdjustSpeed(1);
                    end;

                    BodyVelocity.Velocity = p197.HumanoidRootPart.CFrame.lookVector * 25;
                    wait();
                end;

                BodyVelocity:Destroy();
            end,

            finish = function(p200, p201, p202) -- Line: 2016, Name: finish
            end,

            hit = function(p203, p204, p205, p206) -- Line: 2018, Name: hit
            end
        }
    },
    Rampage = {
        Cooldown = 2,
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
            Size = 8,
            Offset = CFrame.new(0, 0, -4)
        },
        callbacks = {
            client = function(p207, p208, p209) -- Line: 2036, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Uber Oni", "Rampage");
                wait(0.7);
                local v210 = Animations.playClient("Uber Oni", "DemonStep");
                local BodyVelocity = Instance.new("BodyVelocity");
                BodyVelocity.Parent = p208.HumanoidRootPart;
                BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
                BodyVelocity.P = (1 / 0);
                BodyVelocity.Velocity = p208.HumanoidRootPart.CFrame.lookVector * 50;

                for _ = 1, 15 do
                    if p208.HumanoidRootPart.Anchored then
                        break;
                    end;

                    BodyVelocity.Velocity = p208.HumanoidRootPart.CFrame.lookVector * 50;
                    wait();
                end;

                BodyVelocity:Destroy();
                v210:Stop();
            end,

            finish = function(p211, p212, p213) -- Line: 2055, Name: finish
            end,

            hit = function(p214, p215, p216, p217) -- Line: 2057, Name: hit
            end
        }
    },
    ["Consuming Flames"] = {
        Cooldown = 2,
        Stun = 1.2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 50,
            Offset = CFrame.new(0, 0, 0)
        },
        callbacks = {
            client = function(p218, p219, p220) -- Line: 2075, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Uber Oni", "ConsumingFlames"):AdjustSpeed(2);
            end,

            finish = function(p221, p222, p223) -- Line: 2079, Name: finish
            end,

            hit = function(p224, p225, p226, p227) -- Line: 2081, Name: hit
            end
        }
    },
    ["Demon Step"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },

        CustomInvoke = function(p228) -- Line: 2088, Name: CustomInvoke
            -- upvalues: Animations (copy), InputTracker (copy), InputFunc (copy)
            local Character = game.Players.LocalPlayer.Character;
            local v229 = Animations.playClient("Uber Oni", "DemonStep");
            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.Parent = Character.HumanoidRootPart;
            BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);
            BodyVelocity.P = (1 / 0);

            if InputTracker:IsKeyDown(Enum.KeyCode.S) then
                BodyVelocity.Velocity = Character.HumanoidRootPart.CFrame.lookVector * -50;
            else
                BodyVelocity.Velocity = Character.HumanoidRootPart.CFrame.lookVector * 50;
            end;

            game.Debris:AddItem(BodyVelocity, 0.25);
            InputFunc:InvokeServer(p228);
            v229:Stop();
        end
    }
};
v49.Ruined = {
    Thrust = {
        Cooldown = 10,
        Stun = 1.2,
        Damage = 55,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5,
            Offset = CFrame.new(0, 0, 0)
        },
        Remotes = { { "FX", "HitEffect" } },
        callbacks = {
            client = function(p230, p231, p232) -- Line: 2125, Name: client
                print("Reaper Thrust called.");
            end
        }
    }
};
v49["Made In Heaven"] = {
    Pose = {
        DoNotDeactivate = true,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = false,
            CheckTimestop = true,

            ExtraCheck = function(p233) -- Line: 2134, Name: ExtraCheck
                return p233.Character.Values.Active.Value == "" and true or p233.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p234, p235, p236) -- Line: 2137, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p235, "Posing") then
                    Animations.stopClient("Made In Heaven", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p234.Cooldowns;

                    while true do
                        wait(0.025);
                        local v237 = 0;

                        for _, child in pairs(p234.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v237 = v237 + 1;
                            end;
                        end;

                        if v237 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Made In Heaven", "Pose").Stopped:Wait();
                    Animations.playClient("Made In Heaven", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p234.Cooldowns;

                    while true do
                        wait(0.025);
                        local v238 = 0;

                        for _, child in pairs(p234.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v238 = v238 + 1;
                            end;
                        end;

                        if v238 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    Summon = {
        Cooldown = 1.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart", "KnifePart", "KnifeMain" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(11, 113, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(185, 175, 255)) }),
        callbacks = {
            client = function(p239, p240, p241) -- Line: 2190, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p240, "Summoned") then
                    Animations.stopClient("Made In Heaven", "StandIdle");

                    return;
                end;

                Animations.playClient("Made In Heaven", "StandIdle");
            end
        }
    },
    TESTMOVE = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p242) -- Line: 2200, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p242.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        callbacks = {
            client = function(p243, p244, p245) -- Line: 2208, Name: client
            end,

            finish = function(p246, p247, p248) -- Line: 2211, Name: finish
            end,

            hit = function(p249, p250, p251, p252) -- Line: 2213, Name: hit
            end
        }
    },
    ["LMB Combo V3"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
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
            Damage = 25,
            Knockback = { 65, 0.4, Vector3.new(0, 15, 0) },
            Remotes = { { "FX", "HeavyEffect" } },
            Sound = { { "rbxassetid://6742547599", 5, 0, false } }
        },
        ["StandOff-LMB-4"] = {
            Damage = 25,
            Knockback = { 65, 0.4, Vector3.new(0, 15, 0) },
            Remotes = { { "FX", "HeavyEffect" } },
            Sound = { { "rbxassetid://6742547599", 5, 0, false } }
        },
        HitAnimation = v3,
        Knockback = { 5, 0.05 },
        Sound = { { "rbxassetid://6750270946", 1, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0.670588, 0.670588, 1)
        },
        Callbacks = {
            StateChecker = function(p253, p254) -- Line: 2288, Name: StateChecker
                -- upvalues: CollectionService (copy)
                local v255, v256, _ = unpack(p253);
                local v257 = p254.TableUtil.Copy(v256, true);

                if not CollectionService:HasTag(v255.Character, "Summoned") then
                    v257.CustomPrefix = "StandOff-LMB";
                end;

                if workspace.Mechanics.TimeAcc.Value == true and workspace.Mechanics.TimeAcc:GetAttribute("User") == v255.Name then
                    v257.ActualCooldown = v257.ActualCooldown / 2;
                end;

                return v257;
            end
        }
    },
    BurstBarrage = {
        Length = 0.9,
        Cooldown = 0.1,
        Damage = 5,
        Stun = 0.3,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p258) -- Line: 2303, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p258.Character, "Tandeming");
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -4.5)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6750270946", 1, 0, false } },

        CustomInvoke = function(p259) -- Line: 2317, Name: CustomInvoke
            -- upvalues: Animations (copy), InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;

            if not game:GetService("CollectionService"):HasTag(Character, "Summoned") then
                if LocalPlayer.Cooldowns:FindFirstChild("BuurstPunches") then
                    return;
                end;

                InputFunc:InvokeServer("E");

                return;
            end;

            if LocalPlayer.Cooldowns:FindFirstChild("MBarrage") then
                return;
            end;

            Animations.playClient("Made In Heaven", "BurstBarrage"):Play();
            coroutine.resume(coroutine.create(function() -- Line: 2335
                -- upvalues: Character (copy), InputFunc (ref)
                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("E");
            end));
        end,

        TimestoppedRemotes = { { "FX", "TimestopHit" } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0.670588, 0.670588, 1)
        }
    },
    Knives = {
        Cooldown = 0.1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p260) -- Line: 2358, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p260.Character, "Tandeming");
            end
        },
        Remotes = { { "FX", "HeavyEffect" } },
        callbacks = {
            client = function(p261, p262, p263) -- Line: 2364, Name: client
                -- upvalues: Animations (copy)
                if game:GetService("CollectionService"):HasTag(p262, "Summoned") then
                    if p261.Cooldowns:FindFirstChild("Toolate") then
                        return;
                    end;

                    Animations.playClient("Made In Heaven", "BackDashKnives");

                    return;
                end;

                if p261.Cooldowns:FindFirstChild("QuadrupleKnives") then
                    return;
                end;

                Animations.playClient("Made In Heaven", "BackDashKnives");
            end,

            finish = function(p264, p265, p266) -- Line: 2373, Name: finish
            end,

            hit = function(p267, p268, p269, p270) -- Line: 2375, Name: hit
            end
        }
    },
    MiHYMovesY = {
        Cooldown = 0.1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p271) -- Line: 2380, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p271.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        callbacks = {
            client = function(p272, p273, p274) -- Line: 2389, Name: client
            end,

            finish = function(p275, p276, p277) -- Line: 2392, Name: finish
            end,

            hit = function(p278, p279, p280, p281) -- Line: 2394, Name: hit
            end
        }
    },
    TimeAccelerate = {
        Checks = v2,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5.5,
            Offset = CFrame.new(0, 0, -4.5)
        },
        callbacks = {
            client = function(p282, p283, p284) -- Line: 2407, Name: client
            end,

            finish = function(p285, p286, p287) -- Line: 2410, Name: finish
            end,

            hit = function(p288, p289, p290, p291) -- Line: 2412, Name: hit
            end
        }
    },
    Teleport = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p292) -- Line: 2417, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p292.Character, "Tandeming");
            end
        },

        CustomInvoke = function(p293) -- Line: 2418, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            InputFunc:InvokeServer(p293, game.Players.LocalPlayer:GetMouse().Hit.Position);
        end
    },
    ["Last Strike"] = {
        Cooldown = 0.1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p294) -- Line: 2426, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p294.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5.5,
            Offset = CFrame.new(0, 0, -2)
        },
        callbacks = {
            client = function(p295, p296, p297) -- Line: 2435, Name: client
            end,

            finish = function(p298, p299, p300) -- Line: 2438, Name: finish
            end,

            hit = function(p301, p302, p303, p304) -- Line: 2440, Name: hit
            end
        }
    },
    Chop = {
        Damage = 35,
        Cooldown = 7,
        Stun = 0.75,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p305) -- Line: 2445, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p305.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Knockback = { 10, 0.3, Vector3.new(0, 35, 0) },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -4.5)
        },
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.new(1, 0.137255, 0.109804)
        },
        callbacks = {
            client = function(p306, p307, p308) -- Line: 2465, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Made In Heaven", "Chop");
            end,

            finish = function(p309, p310, p311) -- Line: 2468, Name: finish
            end,

            hit = function(p312, p313, p314, p315) -- Line: 2470, Name: hit
            end
        }
    },
    QuickJab = {
        Damage = 30,
        Stun = 0.75,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p316) -- Line: 2475, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p316.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Knockback = { 75, 0.25, Vector3.new(0, 35, 0) },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 5.5,
            Offset = CFrame.new(0, 0.15, -5.5)
        },
        Sound = { { "rbxassetid://6742547599", 3, 0, false } },
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.new(1, 0.137255, 0.109804)
        },
        callbacks = {
            client = function(p317, p318, p319) -- Line: 2496, Name: client
                -- upvalues: Animations (copy)
                if game:GetService("CollectionService"):HasTag(p318, "Summoned") then
                    if p317.Cooldowns:FindFirstChild("Hasty Slice") then
                        return;
                    end;

                    Animations.playClient("Made In Heaven", "QuickJab");

                    return;
                end;

                if p317.Cooldowns:FindFirstChild("Hasty Slice") then
                    return;
                end;

                print("STAND OFF R");
            end,

            finish = function(p320, p321, p322) -- Line: 2505, Name: finish
            end,

            hit = function(p323, p324, p325, p326) -- Line: 2507, Name: hit
            end
        }
    },
    Taunt = {
        Checks = {
            CheckStunned = false,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = true
        },
        Quotes = { { "Your fate ends here.", "rbxassetid://9062266634", {
                    ["Oh Lord in Heaven, "] = 1
                }, 2, 2 }, { "You fail to understand your fate... You must die here.", "rbxassetid://9062263839", {
                    ["You fail to understand your fate..."] = 1.25
                }, 2, 1.5 }, { "I will realize the will of God in this world. You are incapable of it.", "rbxassetid://9062260426", {
                    ["I will realize the will of God in this world."] = 1.15
                }, 2, 1.5 } }
    }
};
local v360 = {
    Summon = {
        Cooldown = 2,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = false
        },
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 255, 186)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
        callbacks = {
            client = function(p327, p328, p329) -- Line: 2552, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p328, "Summoned") then
                    Animations.stopClient("Inker", "StandIdle");

                    return;
                end;

                Animations.playClient("Inker", "StandIdle");
            end
        }
    },
    Teleport = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p330) -- Line: 2562, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p330.Character, "Tandeming");
            end
        },

        CustomInvoke = function(p331) -- Line: 2563, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            InputFunc:InvokeServer(p331, game.Players.LocalPlayer:GetMouse().Hit.Position);
        end
    },
    Flight = {
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(u332, p333, p334) -- Line: 2574, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p333, "FLIGHT") then
                    Animations.stopClient("Inker", "glide");
                    CollectionService:RemoveTag(p333, "FLIGHT");

                    return;
                end;

                CollectionService:AddTag(p333, "FLIGHT");
                local v335 = Animations.playClient("Inker", "glide");
                wait(v335.Length * 0.9);
                v335:AdjustSpeed(0);
                coroutine.wrap(function() -- Line: 2581
                    -- upvalues: u332 (copy)
                    require(script.OldMovesFolder.ClientMoves).Flight(u332, 50);
                end)();
            end
        }
    },
    Ultimate = {
        Cooldown = 2,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p336, p337, p338) -- Line: 2602, Name: client
            end
        }
    },
    RMove = {
        Cooldown = 2,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p339, p340, p341) -- Line: 2611, Name: client
            end
        }
    },
    Bullets = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p342, p343, p344) -- Line: 2627, Name: client
            end
        }
    },
    TMoves = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p345) -- Line: 2632, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p345.Character, "Mounted");
            end
        },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 17)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 167, 67)) }),
        callbacks = {
            client = function(p346, p347, p348) -- Line: 2638, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p347, "Summoned") then
                    return;
                end;

                Animations.playClient("C-Moon", "Gunshots");
            end
        }
    },
    GroundSlam = {
        Damage = 100,
        Cooldown = 3,
        Stun = 1,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p349) -- Line: 2648, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p349.Character, "Tandeming");
            end
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 15,
            Offset = CFrame.new(0, 0, -5)
        },
        SpecificRemotes = { { "Target", "FX", "CameraShake", "Medium" } },
        callbacks = {
            client = function(p350, p351, p352) -- Line: 2663, Name: client
                -- upvalues: Animations (copy)
                local v353 = Animations.playClient("Star Platinum", "GroundSlam");
                wait(v353.Length * 0.8);
                v353:Stop();
            end
        }
    },
    ["Void Warp"] = {
        Damage = 30,
        Cooldown = 0.3,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 10,
            Offset = CFrame.new()
        },
        BallData = {
            StartColor = Color3.fromRGB(85, 255, 127),
            EndColor = Color3.fromRGB(85, 255, 127)
        },
        callbacks = {},

        CustomInvoke = function(p354) -- Line: 2686, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local v355 = LocalPlayer:GetMouse();
            LocalPlayer.Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer(p354, v355.Hit);
        end
    },
    TimeStop = {
        StandName = "Inker",
        Cooldown = 8,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p356) -- Line: 2695, Name: ExtraCheck
                return not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown");
            end
        },
        callbacks = {
            client = function(p357, p358, p359) -- Line: 2698, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Inker", "Timestop");
            end
        }
    }
};
local v361 = {
    Cooldown = 0.2,
    Stun = 3,
    Damage = 25,
    MaxCombo = 4,
    ComboTick = 0.3,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://6706979361", 1, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    AnimSpeed = {
        [4] = 2
    }
};
local u362 = "LMB Combo";
local u363 = 0.75;

function v361.CustomInvoke(u364, p365, p366) -- Line: 40
    -- upvalues: Stands (copy), u1 (copy), u362 (copy), u4 (copy), u8 (copy), CollectionService (copy), u9 (copy), Animations (copy), RunService (copy), InputFunc (copy), u363 (copy)
    local v367 = p366 or game.Players.LocalPlayer;
    local u368 = p366 or v367.Character;
    local v369 = Stands[v367.Data.Ability.Value];
    local v370;

    if v367.Data:FindFirstChild("Skin") then
        v370 = v367.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v370 = nil;
    end;

    local v371 = u1.Stats[v369][u362];

    if not u4[v369][v367.Name] then
        u4[v369][v367.Name] = {};
    end;

    local u372 = u4[v369][v367.Name];

    if not u372[u362] then
        u372[u362] = 1;
    end;

    if not u372[u364] then
        u372[u364] = true;
        local u373 = u372[u362];
        local v374 = v371.AnimSpeed or u8;
        local v375 = v371.StandOff and not CollectionService:HasTag(u368, "Summoned") and "StandOff-" or "";
        local u376 = v371.Standoff or v371;
        local v377;

        if u9[v369] then
            v377 = u9[v369][u364] or u364;
        else
            v377 = u364;
        end;

        local v378 = v375 .. v377 .. "-" .. u373;

        if v370 then
            local v379, v380 = Animations.SearchAnim(v370, v378);

            if v379 then
                if not v380 then
                    v370 = v369;
                end;
            else
                v370 = v369;
            end;
        else
            v370 = v369;
        end;

        local u381;

        if RunService:IsClient() then
            u381 = Animations.playClient(v370, v378, nil, v374[u373]);
        else
            u381 = Animations.playClient(v370, v378, nil, v374[u373], u368.Humanoid, true);
        end;

        task.spawn(function() -- Line: 76
            -- upvalues: RunService (ref), u368 (copy), InputFunc (ref), u364 (copy), u381 (ref), u373 (copy), u376 (copy), u372 (copy), u362 (ref), u363 (ref)
            if RunService:IsClient() then
                u368.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u364);
            end;

            if u381.Looped then
                u381:Stop();
            end;

            if u373 == u376.MaxCombo then
                u372[u362] = 1;
            else
                local v382 = u372;
                local v383 = u362;
                v382[v383] = v382[v383] + 1;
            end;

            coroutine.wrap(function() -- Line: 87
                -- upvalues: u372 (ref), u362 (ref), u363 (ref), u376 (ref)
                local v384 = u372[u362];
                wait((u363 or 1.5) + u376.ComboTick);

                if v384 == u372[u362] then
                    u372[u362] = 1;
                end;
            end)();
            wait(u376.ComboTick);
            u372[u364] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v360["LMB Combo"] = v361;
v360.Barrage = {
    Cooldown = 0.3,
    Length = 4,
    Damage = 10,
    Stun = 1,
    Checks = v2,
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 4.5,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Sound = { { "rbxassetid://6706979932", 1, 0, false } },
    HitAnimation = v3,

    CustomInvoke = function(p385) -- Line: 2746, Name: CustomInvoke
        -- upvalues: Animations (copy), InputFunc (copy), InputTracker (copy)
        local Character = game.Players.LocalPlayer.Character;

        if game:GetService("CollectionService"):HasTag(Character, "Summoned") then
            local v386 = Animations.playClient("Inker", "Barrage");
            v386:Play(0.2, 1, 1.5);
            local v387 = Animations.playClient("Inker", "AttackPose");
            v387:Play();
            coroutine.resume(coroutine.create(function() -- Line: 2753
                -- upvalues: Character (copy), InputFunc (ref)
                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("E");
            end));
            local v388 = tick();

            repeat
                wait(0.025);
            until tick() - v388 > 4 or not InputTracker:IsKeyDown(Enum.KeyCode.E);

            v386:Stop();

            if InputTracker:IsKeyDown(Enum.KeyCode.E) then
                wait(1);
                v387:Stop();

                return;
            end;

            v387:Stop();
        end;
    end,

    TimestoppedRemotes = { { "FX", "TimestopHit" } },
    Remotes = { { "FX", "HitEffect" } }
};
v360.Pose = {
    Cooldown = 2,
    Checks = {
        CheckStunned = false,
        CheckDisabled = true,
        CheckSummoned = true,
        CheckActive = false,
        CheckTimestop = true,

        ExtraCheck = function(p389) -- Line: 2784, Name: ExtraCheck
            return p389.Character.Values.Active.Value == "" and true or p389.Character.Values.Active.Value == "P";
        end
    },
    callbacks = {
        client = function(p390, p391, p392) -- Line: 2787, Name: client
            -- upvalues: CollectionService (copy), Animations (copy)
            if CollectionService:HasTag(p391, "Posing") then
                Animations.stopClient("Inker", "Pose");
                local BinaryStringValue = Instance.new("BinaryStringValue");
                BinaryStringValue.Name = "P";
                BinaryStringValue.Parent = p390.Cooldowns;

                while true do
                    wait(1);
                    local v393 = 0;

                    for _, child in pairs(p390.Cooldowns:GetChildren()) do
                        if child.Name == "P" then
                            v393 = v393 + 1;
                        end;
                    end;

                    if v393 == 2 then
                        BinaryStringValue:Destroy();

                        return;
                    end;
                end;
            else
                local v394 = Animations.playClient("Inker", "Pose");
                wait(v394.Length * 0.8);
                v394:AdjustSpeed(0);
                local BinaryStringValue = Instance.new("BinaryStringValue");
                BinaryStringValue.Name = "P";
                BinaryStringValue.Parent = p390.Cooldowns;

                while true do
                    wait(1);
                    local v395 = 0;

                    for _, child in pairs(p390.Cooldowns:GetChildren()) do
                        if child.Name == "P" then
                            v395 = v395 + 1;
                        end;
                    end;

                    if v395 == 2 then
                        BinaryStringValue:Destroy();

                        return;
                    end;
                end;
            end;
        end
    }
};
v360.Taunt = {
    Checks = {
        CheckStunned = false,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = false,
        CheckTimestop = true
    },
    Quotes = { { "Oh, did I say something like that ?........Just forget it", "rbxassetid://6760239999", {
                ["Oh, did I say something like that ?"] = 2.3
            } } }
};
v360.HeavyPunch = {
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

        ExtraCheck = function(p396) -- Line: 2842, Name: ExtraCheck
            -- upvalues: CollectionService (copy)
            return not CollectionService:HasTag(p396.Character, "Tandeming");
        end
    },
    HitAnimation = v3,
    Knockback = { 50, 0.3, Vector3.new(0, 0, 0) },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -4.5)
    },
    Sound = { { "rbxassetid://7243326637", 4, 0, false } },
    Remotes = { { "FX", "HeavyEffect" } },
    callbacks = {
        client = function(p397, p398, p399) -- Line: 2862, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Star Platinum", "HeavyPunch");
        end
    }
};
v360["Susanoo Summon"] = {
    Cooldown = 2,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    }
};
v360["Susanoo Roar"] = {
    Cooldown = 3.25,
    Damage = 75,
    Stun = 3.25,
    AfterMove = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true,

        ExtraCheck = function(p400) -- Line: 2872, Name: ExtraCheck
            -- upvalues: CollectionService (copy)
            return CollectionService:HasTag(p400.Character, "SusanooON");
        end
    },
    HitAnimation = v3,
    Knockback = { 80, 0.3, Vector3.new(0, 55, 0) }
};
v360["Susanoo Slashes"] = {
    Cooldown = 1.15,
    Damage = 50,
    Stun = 2,
    AfterMove = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true,

        ExtraCheck = function(p401) -- Line: 2881, Name: ExtraCheck
            -- upvalues: CollectionService (copy)
            return CollectionService:HasTag(p401.Character, "SusanooON");
        end
    },
    Remotes = { { "FX", "HeavyEffect" }, { "FX", "BoxBloodParticle" } },
    Sound = { { "rbxassetid://8287430345", 2, 0, false } },
    HitAnimation = v3,
    Knockback = { 10, 0.1, Vector3.new(0, 5, 0) }
};
v49.Inker = v360;
v49["Nuclear Star"] = {
    Summon = {
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "HumanoidRootPart", "StandHumanoidRootPart" },
        callbacks = {
            client = function(p402, p403, p404) -- Line: 2903, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p403, "Summoned") then
                    Animations.stopClient("Nuclear Star", "StandIdle");

                    return;
                end;

                Animations.playClient("Nuclear Star", "StandIdle");
            end
        }
    },
    ["Strong Punch"] = {
        Damage = 25,
        Cooldown = 5,
        BlockBreak = true,
        Stun = 0.55,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 75, 0.25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -2)
        },
        Remotes = { { "FX", "HeavyEffect" } },
        HitData = {
            Color = Color3.new(0.333333, 0.666667, 1)
        },
        Sound = { { "rbxassetid://7243326637", 3, 0, false } },
        callbacks = {
            client = function(p405, p406) -- Line: 2933, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Nuclear Star", "StrongPunch");
            end
        }
    },
    ["Stellar Eruptions"] = {
        Damage = 5,
        Cooldown = 20,
        BlockBreak = true,
        Stun = 0.8,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 0, 0.25, 25 },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0, 0, 1)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 7,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://186311262", 1, 0, false } },
        callbacks = {
            client = function(p407, p408) -- Line: 2958, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Nuclear Star", "RaiseCrystals");
            end
        }
    },
    ["Stellar Dash"] = {
        Damage = 10,
        Cooldown = 25,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 0, 0.25, 25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 7,
            Offset = CFrame.new(0, 0, 0)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0.333333, 0.666667, 1)
        },
        Sound = { { "rbxassetid://186311262", 1, 0, false } },
        callbacks = {
            client = function(p409, p410) -- Line: 2982, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Nuclear Star", "CrystalDash");
            end
        }
    },
    ["Stand Jump"] = {
        Damage = 10,
        Cooldown = 15,
        BlockBreak = true,
        Stun = 1.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 0, 0.25, 25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://186311262", 1, 0, false } },
        callbacks = {
            client = function(p411, p412) -- Line: 3001, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Nuclear Star", "StandJump");
            end
        }
    },
    Barrage = {
        Damage = 0.4,
        Cooldown = 10,
        Stun = 0.4,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 5, 0.25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -2)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0.333333, 0, 1)
        },
        Sound = { { "rbxassetid://6618204174", 1, 0, false } },
        callbacks = {
            client = function(p413, p414) -- Line: 3026, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Nuclear Star", "Barrage");
            end
        }
    },
    ["Stellar Punch"] = {
        Damage = 8,
        Cooldown = 0.3333333333333333,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4,
            Offset = CFrame.new(0, 0, -2)
        },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.new(0, 0.666667, 1)
        },
        Sound = { { "rbxassetid://6618204174", 1, 0, false } },
        callbacks = {
            client = function(p415, p416) -- Line: 3051, Name: client
                -- upvalues: Animations (copy)
                if math.random(1, 2) == 1 then
                    Animations.playClient("Nuclear Star", "Punch1");

                    return;
                end;

                Animations.playClient("Nuclear Star", "Punch2");
            end
        }
    }
};
v49["δ:for the DELTA"] = {
    Pose = {
        DoNotDeactivate = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = false,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p417, p418, p419) -- Line: 3066, Name: client
                -- upvalues: Animations (copy)
                if p417.Character.Humanoid.WalkSpeed <= 12 then
                    Animations.playClient("δ:for the DELTA", "PoseEnd");
                    Animations.stopClient("δ:for the DELTA", "PoseStart");
                    Animations.stopClient("δ:for the DELTA", "PoseLoop");

                    return;
                end;

                local v420 = Animations.playClient("δ:for the DELTA", "PoseStart");

                repeat
                    wait();
                until v420.TimePosition >= 2.25;

                v420:AdjustSpeed(0);
                Animations.playClient("δ:for the DELTA", "PoseLoop");
            end
        }
    },
    Summon = {
        FadeIn = 0,
        FadeOut = 0,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart" },
        callbacks = {
            client = function(p421, p422, p423) -- Line: 3087, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p422, "Summoned") then
                    Animations.stopClient("δ:for the DELTA", "StandIdle");

                    return;
                end;

                Animations.playClient("δ:for the DELTA", "StandSummon");
                Animations.playClient("δ:for the DELTA", "StandIdle");
            end,

            server = function(p424, p425, p426) -- Line: 3095, Name: server
                print("Server callback");
            end,

            finish = function(p427, p428, p429) -- Line: 3098, Name: finish
            end
        }
    },
    Rewind = {
        Cooldown = 0,
        Length = 0,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p430) -- Line: 3103, Name: ExtraCheck
                return p430.Character.Sanity.Value >= 35;
            end
        },
        callbacks = {
            client = function(p431, p432, p433) -- Line: 3107, Name: client
                -- upvalues: Animations (copy)
                print("Rewinding now.");
                local v434 = Animations.playClient("δ:for the DELTA", "TurnBackTime");

                repeat
                    wait();
                until game.Players.LocalPlayer.Character.Sanity.Value < 35 or not v434.IsPlaying;

                print("either ran out of sanity or released key");
                Animations.stopClient("δ:for the DELTA", "TurnBackTime");
            end,

            server = function(p435, p436, p437) -- Line: 3114, Name: server
                print("Server callback");
            end,

            finish = function(p438, p439, p440) -- Line: 3117, Name: finish
                -- upvalues: Animations (copy)
                print("Rewind Key Released.");
                Animations.stopClient("δ:for the DELTA", "TurnBackTime");
            end
        }
    },
    ["Rewind End"] = {
        callbacks = {
            client = function(p441, p442, p443) -- Line: 3125, Name: client
                -- upvalues: Animations (copy)
                print("Rewind Key Released.");
                Animations.stopClient("δ:for the DELTA", "TurnBackTime");
            end
        }
    },
    ["Universal Shockwave"] = {
        Cooldown = 1,
        Length = 0,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p444) -- Line: 3132, Name: ExtraCheck
                return p444.Character.Sanity.Value >= 35;
            end
        }
    },
    ["Silent Watcher"] = {
        Cooldown = 0.5,
        Length = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p445) -- Line: 3137, Name: ExtraCheck
                local v446;

                if p445.Character.Sanity.Value >= 35 then
                    v446 = p445.Character.Humanoid.Health >= 50;
                else
                    v446 = false;
                end;

                return v446;
            end
        }
    },
    ["Silent Watcher End"] = {},
    Standstill = {
        Cooldown = 0.5,
        Length = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p447) -- Line: 3144, Name: ExtraCheck
                return p447.Character.Sanity.Value >= 35;
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 6,
            Debug = true,
            Offset = CFrame.new(0, 0, -12)
        }
    },
    ["Standstill End"] = {
        Cooldown = 0.5,
        Length = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p448) -- Line: 3156, Name: ExtraCheck
                return p448.Character.Sanity.Value >= 35;
            end
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Range = 8
        }
    },
    [true] = {}
};
local v473 = {
    Pose = {
        DoNotDeactivate = true,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = true,

            ExtraCheck = function(p449) -- Line: 3170, Name: ExtraCheck
                return p449.Character.Values.Active.Value == "" and true or p449.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p450, p451, p452) -- Line: 3173, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p451, "Posing") then
                    Animations.stopClient("Sans", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p450.Cooldowns;

                    while true do
                        wait(0.025);
                        local v453 = 0;

                        for _, child in pairs(p450.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v453 = v453 + 1;
                            end;
                        end;

                        if v453 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Sans", "PoseTransition");
                    task.wait(1.5);
                    Animations.stopClient("Sans", "PoseTransition");
                    Animations.playClient("Sans", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p450.Cooldowns;

                    while true do
                        wait(0.025);
                        local v454 = 0;

                        for _, child in pairs(p450.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v454 = v454 + 1;
                            end;
                        end;

                        if v454 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    Switch = {
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p455, p456, p457) -- Line: 3224, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Sans", "Switch");
            end
        }
    },
    End = {
        Cooldown = 35,
        Damage = 1,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitData = {
            Color = Color3.new(0.333333, 0.666667, 1)
        },
        Remotes = { { "FX", "HeavyEffect" } },
        callbacks = {
            client = function(p458, p459, p460) -- Line: 3242, Name: client
            end
        },
        Sound = { { "rbxassetid://6849041223", 1, 0, false } },
        Hitbox = {
            Type = "Target",
            RelativePart = "HumanoidRootPart"
        }
    },
    Bait = {
        Cooldown = 15,
        Damage = 6,
        Stun = 0.4,
        StunSpeed = 0,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p461, p462, p463) -- Line: 3262, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Sans", "Bait");
            end
        },
        Hitbox = {
            Type = "Target",
            RelativePart = "HumanoidRootPart"
        }
    },
    Heh = {
        Damage = 35,
        Cooldown = 25,
        Stun = 2.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitData = {
            Color = Color3.new(0.333333, 0.333333, 1)
        },
        Remotes = { { "FX", "HeavyEffect" } },
        Hitbox = {
            Type = "Target",
            RelativePart = "HumanoidRootPart"
        }
    },
    BoneLaunch = {
        Damage = 12.35,
        Cooldown = 20,
        Stun = 0.7,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 50, 0.05, Vector3.new(0, 25, 0) },
        Sound = { { "rbxassetid://6849041223", 0.5, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, 0)
        },
        callbacks = {
            client = function(p464, p465, p466) -- Line: 3303, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Sans", "BoneLaunch");
            end
        }
    },
    Teleportation = {
        Cooldown = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p467, p468, p469) -- Line: 3312, Name: client
                -- upvalues: Animations (copy)
                local HumanoidRootPart = game.Players.LocalPlayer.Character.HumanoidRootPart;
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -16);
                Animations.playClient("Sans", "Teleport");
            end
        },
        Hitbox = {
            Type = "Target",
            RelativePart = "HumanoidRootPart"
        }
    },
    GasterBlaster = {
        Damage = 35.75,
        BlockBreak = true,
        Cooldown = 7,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitData = {
            Color = Color3.new(0.333333, 1, 1)
        },
        Remotes = { { "FX", "HeavyEffect" } },
        Sound = { { "rbxassetid://6849041223", 2, 0, false } },
        callbacks = {
            client = function(p470, p471, p472) -- Line: 3337, Name: client
            end
        },
        Hitbox = {
            Type = "Target",
            RelativePart = "HumanoidRootPart"
        }
    }
};
local v474 = {
    Cooldown = 0.2,
    Stun = 0.5,
    Damage = 8,
    MaxCombo = 4,
    ComboTick = 0.3,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckActive = true,
        CheckTimestop = true
    },
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 5,
        Offset = CFrame.new(0, 0, -2.9)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    HitData = {
        Color = Color3.new(0.588235, 0.588235, 0.87451)
    },
    AnimSpeed = {
        [4] = 2
    }
};
local u475 = "LMB Combo";
local u476 = 0.75;

function v474.CustomInvoke(u477, p478, p479) -- Line: 40
    -- upvalues: Stands (copy), u1 (copy), u475 (copy), u4 (copy), u8 (copy), CollectionService (copy), u9 (copy), Animations (copy), RunService (copy), InputFunc (copy), u476 (copy)
    local v480 = p479 or game.Players.LocalPlayer;
    local u481 = p479 or v480.Character;
    local v482 = Stands[v480.Data.Ability.Value];
    local v483;

    if v480.Data:FindFirstChild("Skin") then
        v483 = v480.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v483 = nil;
    end;

    local v484 = u1.Stats[v482][u475];

    if not u4[v482][v480.Name] then
        u4[v482][v480.Name] = {};
    end;

    local u485 = u4[v482][v480.Name];

    if not u485[u475] then
        u485[u475] = 1;
    end;

    if not u485[u477] then
        u485[u477] = true;
        local u486 = u485[u475];
        local v487 = v484.AnimSpeed or u8;
        local v488 = v484.StandOff and not CollectionService:HasTag(u481, "Summoned") and "StandOff-" or "";
        local u489 = v484.Standoff or v484;
        local v490;

        if u9[v482] then
            v490 = u9[v482][u477] or u477;
        else
            v490 = u477;
        end;

        local v491 = v488 .. v490 .. "-" .. u486;

        if v483 then
            local v492, v493 = Animations.SearchAnim(v483, v491);

            if v492 then
                if not v493 then
                    v483 = v482;
                end;
            else
                v483 = v482;
            end;
        else
            v483 = v482;
        end;

        local u494;

        if RunService:IsClient() then
            u494 = Animations.playClient(v483, v491, nil, v487[u486]);
        else
            u494 = Animations.playClient(v483, v491, nil, v487[u486], u481.Humanoid, true);
        end;

        task.spawn(function() -- Line: 76
            -- upvalues: RunService (ref), u481 (copy), InputFunc (ref), u477 (copy), u494 (ref), u486 (copy), u489 (copy), u485 (copy), u475 (ref), u476 (ref)
            if RunService:IsClient() then
                u481.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u477);
            end;

            if u494.Looped then
                u494:Stop();
            end;

            if u486 == u489.MaxCombo then
                u485[u475] = 1;
            else
                local v495 = u485;
                local v496 = u475;
                v495[v496] = v495[v496] + 1;
            end;

            coroutine.wrap(function() -- Line: 87
                -- upvalues: u485 (ref), u475 (ref), u476 (ref), u489 (ref)
                local v497 = u485[u475];
                wait((u476 or 1.5) + u489.ComboTick);

                if v497 == u485[u475] then
                    u485[u475] = 1;
                end;
            end)();
            wait(u489.ComboTick);
            u485[u477] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v473["LMB Combo"] = v474;
v473["Bone Guard"] = {
    Cooldown = 10,
    Damage = 35,
    Stun = 0.75,
    Unblockable = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    Knockback = { 15, 0.2, Vector3.new(0, 50, 0) },
    HitAnimation = v3,
    Remotes = { { "FX", "HeavyEffect" } },
    HitData = {
        Color = Color3.fromRGB(87, 233, 255)
    },
    Sound = { { "rbxassetid://7251869128", 2, 0, false } },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 8,
        HitAnimation = v3,
        Offset = CFrame.new(0, -2, 0)
    },
    callbacks = {
        client = function(p498, p499, p500) -- Line: 3399, Name: client
            -- upvalues: Animations (copy)
            Animations.playClient("Sans", "Bone Guard");
        end
    }
};
v473["Bad Time"] = {
    Cooldown = 25,
    Suppress = true,
    Unblockable = true,
    AfterMove = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = true,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    HitData = {
        Color = Color3.new(0.431373, 0.772549, 1)
    },
    HitAnimation = v3,
    Remotes = { { "FX", "HeavyEffect" } }
};
v49.Sans = v473;
v49.DOG = {
    Attack = {
        Damage = 35,
        Cooldown = 3,
        BlockBreak = true,
        Stun = 1,
        Checks = {
            CheckStunned = false,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.25 },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -2)
        },
        Sound = { { "rbxassetid://6618204174", 1, 0, false } },
        callbacks = {
            client = function(p501, p502) -- Line: 3434, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("DOG", "StrongPunch");
            end
        }
    }
};
v49.Reaper = {
    Slash = {
        Cooldown = 0.1,
        Stun = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        Sound = { { "rbxassetid://6618204174", 0.5, 0, false } },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -5)
        }
    },
    ["Soul Torment"] = {
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, -3, -4.5)
        }
    },
    ["Lost Soul"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    ["Soul Consumption"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    Wither = {
        Damage = 30,
        Cooldown = 8,
        AfterMove = true,
        BlockBreak = true,
        Stun = 0.35,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 75, 0.3 },
        Sound = { { "rbxassetid://6893654002", 0.6, 0, false } },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 4.5,
            Offset = CFrame.new(0, 0, -5)
        },
        callbacks = {
            client = function() -- Line: 3493, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Reaper", "Wither");
            end
        }
    },
    ["Soul Embodiment"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Tween = { 0.25, Enum.EasingStyle.Linear },

        CustomInvoke = function(p503) -- Line: 3501, Name: CustomInvoke
            -- upvalues: CollectionService (copy), InputFunc (copy)
            local Character = game.Players.LocalPlayer.Character;
            coroutine.resume(coroutine.create(function() -- Line: 3504
                -- upvalues: CollectionService (ref), Character (copy), InputFunc (ref)
                if CollectionService:HasTag(Character, "Adrenaline") then
                    return;
                end;

                game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("V");
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
        Quotes = { { "Give me a break.", "rbxassetid://6929531363", {}, 2, 2.5 }, { "...My scythe can harvest my opponents fighting spirit..... yeah that\'s a lie but you lost the battle the moment you lost focus", "rbxassetid://9073403025", {
                    ["...My scythe can harvest my opponents fighting spirit....."] = 1.35
                }, 3 }, { "You\'ve got a weird make up... Don\'t ya.. I don\'t think your fit for harvesting too bad.", "rbxassetid://6929565502", {
                    ["you\'ve got a weird make up... don\'t ya.."] = 1.1
                }, 3 } }
    },
    ["Frightened Soul"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },

        CustomInvoke = function(p504) -- Line: 3544, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            if game.Players.LocalPlayer.Cooldowns:FindFirstChild("STANDON-G") then
                return;
            end;

            local Character = game.Players.LocalPlayer.Character;
            coroutine.resume(coroutine.create(function() -- Line: 3550
                -- upvalues: Character (copy), InputFunc (ref)
                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("G");
            end));
        end
    },
    ["Consecutive Slashes"] = {
        Damage = 4.5,
        Cooldown = 10,
        Stun = 0.45,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Sound = { { "rbxassetid://6893654002", 0.8, 0, false } },
        HitAnimation = v3,
        Remotes = { { "FX", "HitEffect" }, { "FX", "Kur HitEffect" } },
        InfoTable = {
            Effects = {
                Bleed = {}
            }
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 7,
            Offset = CFrame.new(0, 0, -3)
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

            ExtraCheck = function(p505) -- Line: 3582, Name: ExtraCheck
                return p505.Character.Values.Active.Value == "" and true or p505.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p506, p507, p508) -- Line: 3585, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p507, "Posing") then
                    Animations.stopClient("Reaper", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p506.Cooldowns;

                    while true do
                        wait(0.025);
                        local v509 = 0;

                        for _, child in pairs(p506.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v509 = v509 + 1;
                            end;
                        end;

                        if v509 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Reaper", "PoseTransition").Stopped:Wait();
                    Animations.playClient("Reaper", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p506.Cooldowns;

                    while true do
                        wait(0.025);
                        local v510 = 0;

                        for _, child in pairs(p506.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v510 = v510 + 1;
                            end;
                        end;

                        if v510 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
local v532 = {
    Pose = {
        DoNotDeactivate = true,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = false,
            CheckTimestop = true,

            ExtraCheck = function(p511) -- Line: 3634, Name: ExtraCheck
                return p511.Character.Values.Active.Value == "" and true or p511.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p512, p513, p514) -- Line: 3637, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p513, "Posing") then
                    Animations.stopClient("Sol", "Pose Idle Stand");
                    Animations.stopClient("Sol", "Pose Idle root");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p512.Cooldowns;

                    while true do
                        wait(0.025);
                        local v515 = 0;

                        for _, child in pairs(p512.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v515 = v515 + 1;
                            end;
                        end;

                        if v515 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Sol", "Pose Transition Stand");
                    Animations.playClient("Sol", "Pose Transition root");
                    task.wait(0.8);
                    Animations.stopClient("Sol", "Pose Transition Stand");
                    Animations.stopClient("Sol", "Pose Transition root");
                    Animations.playClient("Sol", "Pose Idle Stand");
                    Animations.playClient("Sol", "Pose Idle root");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p512.Cooldowns;

                    while true do
                        wait(0.025);
                        local v516 = 0;

                        for _, child in pairs(p512.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v516 = v516 + 1;
                            end;
                        end;

                        if v516 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    Summon = {
        Cooldown = 1.5,
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(85, 85, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)) }),
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart", "Ring" },
        callbacks = {
            client = function(p517, p518, p519) -- Line: 3697, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p518, "Summoned") then
                    Animations.stopClient("Sol", "StandIdle");

                    return;
                end;

                Animations.playClient("Sol", "StandIdle");
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
            CheckTimestop = true
        },
        Quotes = { { "Put some effort into it!", "rbxassetid://6934943788", {
                    ["Oh Lord in Heaven, "] = 1
                }, 2, 2.5 }, { "Not too bad.", "rbxassetid://6934950666", {
                    ["Stand up."] = 1.25
                }, 2 }, { "Looks like I found myself another idiot.", "rbxassetid://6934951807", {}, 2 }, { "You\'re such a joke I can\'t even think of anything to say to you.", "rbxassetid://6934953329", {}, 2 } }
    },
    Barrage = {
        Cooldown = 14,
        AfterMove = true,
        Length = 3.5,
        Damage = 0.8,
        Stun = 0.4,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p520) -- Line: 3748, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p520.Character, "Mounted");
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
        Sound = { { "rbxassetid://6925631899", 0.5, 0, false } },
        callbacks = {
            client = function(p521, p522, p523) -- Line: 3775, Name: client
                -- upvalues: Animations (copy), InputTracker (copy)
                local v524 = Animations.playClient("DTWHV", "Barrage");
                v524:AdjustSpeed(3);
                local v525 = tick();

                repeat
                    wait(0.025);
                until tick() - v525 > 3.5 or (not InputTracker:IsKeyDown(Enum.KeyCode.E) or (not p521 or (not p521.Parent or p521.Character.Humanoid:GetState() == Enum.HumanoidStateType.Dead)));

                v524:Stop();
            end
        },
        Remotes = { { "FX", "HitEffect" } }
    },
    ["Intangible Punch"] = {
        Damage = 45,
        BlockBreak = true,
        Stun = 1,
        Cooldown = 15,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 85, 0.05, Vector3.new(0, 50, 0) },
        Remotes = { { "FX", "HitEffect" } },
        Sound = { { "rbxassetid://6930419376", 1, 0, false } },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            HitAnimation = v3,
            Offset = CFrame.new(0, 0.75, -5)
        }
    },
    ["Teleport Barrage"] = {
        Damage = 2,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Remotes = { { "FX", "HeavyEffect" } },
        Sound = { { "rbxassetid://6925631899", 0.8, 0, false } },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 7,
            HitAnimation = v3,
            Offset = CFrame.new(0, 1, -6)
        },

        CustomInvoke = function(p526) -- Line: 3829, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            if game.Players.LocalPlayer.Cooldowns:FindFirstChild("STANDON-E") then
                return;
            end;

            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;
            local Target = LocalPlayer:GetMouse().Target;

            for _, child in ipairs(game.Workspace.Living:GetChildren()) do
                local v527 = game.Players:GetPlayerFromCharacter(child) or child;

                if (not (v527:FindFirstChild("Values") and v527.Values:FindFirstChild("Summoner")) and "" or v527.Values.Summoner.Value) ~= LocalPlayer.Values.Summoner.Value and (Target:IsDescendantOf(child) and (child.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude <= 20) then
                    coroutine.resume(coroutine.create(function() -- Line: 3841
                        -- upvalues: Character (copy), Target (ref), child (copy)
                        Character.Values.Active.Value = "temp";
                        Target = child.HumanoidRootPart;
                    end));
                end;
            end;

            InputFunc:InvokeServer("E", Target);
        end
    },
    ["Nuclear Fusion"] = {
        Cooldown = 25,
        Damage = 1.2,
        AfterMove = true,
        Stun = 0.3,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Remotes = { { "FX", "HeavyEffect" } }
    },
    Teleport = {
        Cooldown = 6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p528) -- Line: 3864, Name: ExtraCheck
                return game.Workspace.Mechanics.TimeStopped:GetAttribute("User") ~= p528.Name;
            end
        },

        CustomInvoke = function(p529) -- Line: 3865, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            if (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer:GetMouse().Hit.Position).Magnitude > 40 then
                return;
            end;

            local LocalPlayer = game.Players.LocalPlayer;
            local _ = LocalPlayer.Character;
            local u530 = LocalPlayer:GetMouse();
            coroutine.resume(coroutine.create(function() -- Line: 3872
                -- upvalues: InputFunc (ref), u530 (copy)
                game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("V", u530.Hit);
            end));
        end
    },
    ["Sol Star"] = {
        Cooldown = 20,
        BlockBreak = true,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Remotes = { { "FX", "HeavyEffect" } },
        Sound = { { "rbxassetid://6934988754", 0.8, 0, false } },
        HitAnimation = v3,

        CustomInvoke = function(p531) -- Line: 3892, Name: CustomInvoke
            -- upvalues: InputFunc (copy)
            local Character = game.Players.LocalPlayer.Character;
            coroutine.resume(coroutine.create(function() -- Line: 3895
                -- upvalues: Character (copy), InputFunc (ref)
                if Character.Humanoid.FloorMaterial == Enum.Material.Air then
                    return;
                end;

                game.Players.LocalPlayer.Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("F");
            end));
        end
    },
    ["Cosmic Dust"] = {
        Damage = 25,
        Stun = 1.5,
        Delay = 1.5,
        Cooldown = 10,
        Checks = v2,
        HitAnimation = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(22.5, 15, 22.5),
            Offset = CFrame.new()
        },
        Sound = { { "rbxassetid://6934988754", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(23, 145, 255)
        }
    }
};
local v533 = {
    Cooldown = 0.2,
    Stun = 0.425,
    Damage = 10,
    MaxCombo = 4,
    ComboTick = 0.3,
    Checks = v2,
    Knockback = { 5, 0.05 },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "Stand.StandHumanoidRootPart",
        Size = 4,
        Offset = CFrame.new(0, 0, -5)
    },
    HitAnimation = v3,
    Sound = { { "rbxassetid://6925631899", 0.8, 0, false } },
    Remotes = { { "FX", "HitEffect" } },
    AnimSpeed = {
        [4] = 2
    }
};
local u534 = "LMB Combo";
local u535 = 0.75;

function v533.CustomInvoke(u536, p537, p538) -- Line: 40
    -- upvalues: Stands (copy), u1 (copy), u534 (copy), u4 (copy), u8 (copy), CollectionService (copy), u9 (copy), Animations (copy), RunService (copy), InputFunc (copy), u535 (copy)
    local v539 = p538 or game.Players.LocalPlayer;
    local u540 = p538 or v539.Character;
    local v541 = Stands[v539.Data.Ability.Value];
    local v542;

    if v539.Data:FindFirstChild("Skin") then
        v542 = v539.Data.Skin:GetAttribute("SkinName") or nil;
    else
        v542 = nil;
    end;

    local v543 = u1.Stats[v541][u534];

    if not u4[v541][v539.Name] then
        u4[v541][v539.Name] = {};
    end;

    local u544 = u4[v541][v539.Name];

    if not u544[u534] then
        u544[u534] = 1;
    end;

    if not u544[u536] then
        u544[u536] = true;
        local u545 = u544[u534];
        local v546 = v543.AnimSpeed or u8;
        local v547 = v543.StandOff and not CollectionService:HasTag(u540, "Summoned") and "StandOff-" or "";
        local u548 = v543.Standoff or v543;
        local v549;

        if u9[v541] then
            v549 = u9[v541][u536] or u536;
        else
            v549 = u536;
        end;

        local v550 = v547 .. v549 .. "-" .. u545;

        if v542 then
            local v551, v552 = Animations.SearchAnim(v542, v550);

            if v551 then
                if not v552 then
                    v542 = v541;
                end;
            else
                v542 = v541;
            end;
        else
            v542 = v541;
        end;

        local u553;

        if RunService:IsClient() then
            u553 = Animations.playClient(v542, v550, nil, v546[u545]);
        else
            u553 = Animations.playClient(v542, v550, nil, v546[u545], u540.Humanoid, true);
        end;

        task.spawn(function() -- Line: 76
            -- upvalues: RunService (ref), u540 (copy), InputFunc (ref), u536 (copy), u553 (ref), u545 (copy), u548 (copy), u544 (copy), u534 (ref), u535 (ref)
            if RunService:IsClient() then
                u540.Values.Active.Value = "temp";
                InputFunc:InvokeServer(u536);
            end;

            if u553.Looped then
                u553:Stop();
            end;

            if u545 == u548.MaxCombo then
                u544[u534] = 1;
            else
                local v554 = u544;
                local v555 = u534;
                v554[v555] = v554[v555] + 1;
            end;

            coroutine.wrap(function() -- Line: 87
                -- upvalues: u544 (ref), u534 (ref), u535 (ref), u548 (ref)
                local v556 = u544[u534];
                wait((u535 or 1.5) + u548.ComboTick);

                if v556 == u544[u534] then
                    u544[u534] = 1;
                end;
            end)();
            wait(u548.ComboTick);
            u544[u536] = nil;
        end);

        return not RunService:IsClient() and "Server";
    end;
end;

v532["LMB Combo"] = v533;
v49.Sol = v532;
v49.SINKING = {
    Pose = {
        DoNotDeactivate = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = false,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p557, p558, p559) -- Line: 3958, Name: client
                -- upvalues: Animations (copy)
                if p557.Character.Humanoid.WalkSpeed <= 12 then
                    Animations.playClient("δ:for the DELTA", "PoseEnd");
                    Animations.stopClient("δ:for the DELTA", "PoseStart");
                    Animations.stopClient("δ:for the DELTA", "PoseLoop");

                    return;
                end;

                local v560 = Animations.playClient("δ:for the DELTA", "PoseStart");

                repeat
                    wait();
                until v560.TimePosition >= 2.25;

                v560:AdjustSpeed(0);
                Animations.playClient("δ:for the DELTA", "PoseLoop");
            end
        }
    },
    Summon = {
        FadeIn = 0,
        FadeOut = 0,
        Cooldown = 2,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart" },
        callbacks = {
            client = function(p561, p562, p563) -- Line: 3979, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p562, "Summoned") then
                    Animations.stopClient("SINKING", "StandIdle");

                    return;
                end;

                Animations.playClient("SINKING", "StandIdle");
            end,

            server = function(p564, p565, p566) -- Line: 3987, Name: server
                print("Server callback");
            end,

            finish = function(p567, p568, p569) -- Line: 3990, Name: finish
            end
        }
    }
};
v49.Deathnote = {
    Toggle = {
        Cooldown = 0.25,
        Checks = {
            CheckStunned = false,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = false
        }
    }
};
v49.Anshen = {
    ["Summon Anshen"] = {
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = {}
    },
    ["LMB Combo V3"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = true,
            CheckTimestop = true
        },
        Cooldown = 0.15,
        HalfCooldown = 0.5,
        ActualCooldown = 1.5,
        Startup = { 0.3, 0.3, 0.6 },
        EndLag = { 0.35, 0.375, 0.8 },
        ModifiedCooldowns = { 0.5, 0.5, 0.5 },
        MaxCombo = 3,
        ComboTick = 1,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -6)
        },
        Damage = 10,
        Stun = 0.6,
        Knockback = { 5, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8759531468", 1.5, 0, false } },
        Remotes = { { "FX", "Anshen_BasicHit" } },
        ["LMB-2"] = {
            Damage = 10,
            Stun = 0.75,
            Knockback = { 5, 0.05 }
        },
        ["LMB-3"] = {
            Damage = 25,
            Stun = 0.5,
            Knockback = { 75, 0.3, Vector3.new(0, 10, 0) }
        },
        Callbacks = {
            PreAnim = function(p570, p571) -- Line: 4058, Name: PreAnim
                -- upvalues: Output (copy)
                local _ = p571.ComboCount;
                local v572 = unpack(p570);

                if not (v572 and v572:IsA("Player")) then
                    return;
                end;

                Output:FireAllClients("FX", "ToggleTrails", v572.Character.Stand, true);
            end,

            PostAnim = function(p573, p574) -- Line: 4067, Name: PostAnim
                -- upvalues: Output (copy)
                Output:FireAllClients("FX", "ToggleTrails", unpack(p573).Character.Stand, false);
            end,

            PreHit = function(p575, p576) -- Line: 4072, Name: PreHit
            end
        }
    },
    ["Accelerated Swing"] = {
        Stun = 0.5,
        Cooldown = 10,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8775748486", 0.8, 0, false } },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 6, 8.5),
            MaxRange = 100,
            Debug = false,
            Offset = CFrame.new(0, 2, -6)
        }
    },
    ["Overloaded Lance"] = {
        Damage = 20.5,
        Cooldown = 15,
        BlockBreak = true,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8800805271", 0.8, 0, false } }
    },
    ["Lance Retrieval"] = {
        Damage = 10,
        Cooldown = 18,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8804198795", 0.8, 0, false } }
    },
    ["Energy Charge"] = {
        Damage = 1,
        Cooldown = 25,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3
    },
    ["Cataclysm Smash"] = {
        Damage = 30,
        Cooldown = 15,
        AfterMove = true,
        Stun = 1.5,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 20,
            MaxRange = 50,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    ["Backslash Counter"] = {
        Damage = 30,
        Cooldown = 12,
        AfterMove = true,
        Stun = 1.5,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 20),
            MaxRange = 50,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    Justice = {
        Cooldown = 20,
        BlockBreak = true,
        AfterMove = true,
        Stun = 0.1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    ["Consecutive Slashes"] = {
        Cooldown = 5,
        AfterMove = false,
        Stun = 0.5,
        Damage = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(5, 5, 5),
            Offset = CFrame.new(0, 0, -4)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Finisher = {
            Stun = 1,
            Damage = 20,
            HitAnimation = v3,
            Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(7, 7, 7),
                Offset = CFrame.new(0, 0, -6)
            }
        }
    },
    ["Swift Wings"] = {
        Cooldown = 3,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    Block = {
        Cooldown = 0.2,
        AfterMove = true,
        KeepStand = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p577, p578, p579) -- Line: 4236, Name: client
                -- upvalues: Animations (copy), Stands2 (copy), InputTracker (copy)
                local v580 = Animations.playClient(Stands2[p579.Value], "Block");

                repeat
                    wait(0.001);
                until not InputTracker:IsKeyDown(Enum.KeyCode.X) or v580.IsPlaying == false;

                if v580.IsPlaying then
                    v580:Stop();
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
                client = function(p581, p582, p583) -- Line: 4250, Name: client
                    -- upvalues: Animations (copy), Stands2 (copy)
                    local UserInputService = game:GetService("UserInputService");
                    local v584 = p581 and Animations.playClient(Stands2[p583.Value], "Block") or Animations.playClient(Stands2[p583.Value], "Block", nil, nil, p582:FindFirstChildWhichIsA("Humanoid"), true);

                    repeat
                        wait();
                    until p581 and not UserInputService:IsKeyDown(Enum.KeyCode.X) or (p581 == nil and p582.Values.Block.Value == "None" or v584.IsPlaying == false);

                    if v584.IsPlaying then
                        v584:Stop();
                    end;
                end
            }
        }
    }
};
v49.Anshen_TEMP = {
    ["Summon Anshen"] = {
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = {}
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

            ExtraCheck = function(p585) -- Line: 4271, Name: ExtraCheck
                return p585.Character.Values.Active.Value == "" and true or p585.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p586, p587, p588) -- Line: 4274, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p587, "Posing") then
                    Animations.stopClient("Anshen", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p586.Cooldowns;

                    while true do
                        wait(0.025);
                        local v589 = 0;

                        for _, child in pairs(p586.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v589 = v589 + 1;
                            end;
                        end;

                        if v589 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Anshen", "PoseTransition").Stopped:Wait();
                    Animations.playClient("Anshen", "PoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p586.Cooldowns;

                    while true do
                        wait(0.025);
                        local v590 = 0;

                        for _, child in pairs(p586.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v590 = v590 + 1;
                            end;
                        end;

                        if v590 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    ["LMB Combo V3"] = {
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckSummoned = true,
            CheckTimestop = true
        },
        Cooldown = 0.15,
        HalfCooldown = 0.5,
        ActualCooldown = 2,
        Startup = { 0.25, 0.25, 0.25, 0.35 },
        EndLag = { 0.35, 0.35, 0.375, 0.75 },
        ModifiedCooldowns = { 0.5, 0.5, 0.5, 0.5 },
        ExtraSounds = { { "SwingLight" }, { "SwingLight" }, { "SwingMedium" }, { "SwingHeavy" } },
        MaxCombo = 4,
        ComboTick = 1,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 8,
            Offset = CFrame.new(0, 0, -6)
        },
        Damage = 8,
        Stun = 0.65,
        Knockback = { 5, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8759531468", 1.5, 0, false } },
        Remotes = { { "FX", "Anshen_BasicHit" } },
        ["LMB-4"] = {
            Damage = 20,
            Stun = 0.4,
            Knockback = { 75, 0.3, Vector3.new(0, 10, 0) }
        },
        Callbacks = {
            PreAnim = function(p591, p592) -- Line: 4366, Name: PreAnim
                -- upvalues: Output (copy)
                local _ = p592.ComboCount;
                local v593 = unpack(p591);

                if not (v593 and v593:IsA("Player")) then
                    return;
                end;

                Output:FireAllClients("FX", "ToggleTrails", v593.Character.Stand, true);
            end,

            PostAnim = function(p594, p595) -- Line: 4375, Name: PostAnim
                -- upvalues: Output (copy)
                Output:FireAllClients("FX", "ToggleTrails", unpack(p594).Character.Stand, false);
            end,

            PreHit = function(p596, p597) -- Line: 4380, Name: PreHit
            end
        }
    },
    ["Accelerated Swing"] = {
        Stun = 0.5,
        Cooldown = 10,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8775748486", 0.8, 0, false } },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(8.5, 6, 8.5),
            MaxRange = 100,
            Debug = false,
            Offset = CFrame.new(0, 2, -6)
        }
    },
    ["Overloaded Lance"] = {
        Damage = 20.5,
        Cooldown = 15,
        BlockBreak = true,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8800805271", 0.8, 0, false } }
    },
    ["Lance Retrieval"] = {
        Damage = 10,
        Cooldown = 18,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8804198795", 0.8, 0, false } }
    },
    ["Energy Charge"] = {
        Damage = 1,
        Cooldown = 25,
        AfterMove = true,
        Stun = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3
    },
    ["Cataclysm Smash"] = {
        Damage = 30,
        Cooldown = 15,
        AfterMove = true,
        Stun = 1.5,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 20,
            MaxRange = 50,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    ["Backslash Counter"] = {
        Damage = 30,
        Cooldown = 12,
        AfterMove = true,
        Stun = 1.5,
        BlockBreak = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(20, 20, 20),
            MaxRange = 50,
            Offset = CFrame.new(0, 0, 0)
        },
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    Justice = {
        Cooldown = 20,
        BlockBreak = true,
        AfterMove = true,
        Stun = 0.1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } }
    },
    ["Consecutive Slashes"] = {
        Cooldown = 9,
        AfterMove = false,
        Stun = 0.6,
        Damage = 5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "HumanoidRootPart",
            Size = Vector3.new(6, 6, 7),
            Offset = CFrame.new(0, 0, -6)
        },
        HitAnimation = v3,
        Sound = { { "rbxassetid://8759531468", 1, 0, false } },
        Remotes = { { "FX", "Anshen_BasicHit" } },
        Finisher = {
            Stun = 0.4,
            Damage = 15,
            HitAnimation = v3,
            Sound = { { "rbxassetid://10657941340", 1.5, 0, false } },
            Remotes = { { "FX", "Anshen_BasicHit" } },
            Knockback = { 50, 0.3, Vector3.new(0, 10, 0) },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(8, 8, 9),
                Offset = CFrame.new(0, 0, -8)
            }
        }
    },
    ["Swift Wings"] = {
        Cooldown = 3,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    Block = {
        Cooldown = 0.2,
        AfterMove = true,
        KeepStand = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        callbacks = {
            client = function(p598, p599, p600) -- Line: 4547, Name: client
                -- upvalues: Animations (copy), Stands2 (copy), InputTracker (copy)
                local v601 = Animations.playClient(Stands2[p600.Value], "Block");

                repeat
                    wait(0.001);
                until not InputTracker:IsKeyDown(Enum.KeyCode.X) or v601.IsPlaying == false;

                if v601.IsPlaying then
                    v601:Stop();
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
                client = function(p602, p603, p604) -- Line: 4561, Name: client
                    -- upvalues: Animations (copy), Stands2 (copy)
                    local UserInputService = game:GetService("UserInputService");
                    local v605 = p602 and Animations.playClient(Stands2[p604.Value], "Block") or Animations.playClient(Stands2[p604.Value], "Block", nil, nil, p603:FindFirstChildWhichIsA("Humanoid"), true);

                    repeat
                        wait();
                    until p602 and not UserInputService:IsKeyDown(Enum.KeyCode.X) or (p602 == nil and p603.Values.Block.Value == "None" or v605.IsPlaying == false);

                    if v605.IsPlaying then
                        v605:Stop();
                    end;
                end
            }
        }
    }
};
v49.Broly = {
    ["LMB Combo"] = {
        Damage = 7.5,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        Knockback = { 25, 0.05 },
        HitAnimation = v3,
        Sound = { { "rbxassetid://6706979361", 0.8, 0, false } },
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(113, 193, 84)
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Offset = CFrame.new(0, 0, -2.5)
        }
    },
    ["Gigantic Crash"] = {
        BlockBreak = true,
        Damage = 2.95,
        Cooldown = 12.5,
        AfterMove = true,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 3.85,
            Offset = CFrame.new(0, 0, -2.75)
        }
    },
    ["Eraser Blow"] = {
        Damage = 20.5,
        Cooldown = 9.75,
        AfterMove = true,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 3.85,
            Offset = CFrame.new(0, 0, -2.75)
        }
    },
    Pulverizer = {
        Damage = 7.75,
        Cooldown = 14.5,
        AfterMove = true,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 3.85,
            Offset = CFrame.new(0, 0, -2.75)
        }
    },
    ["Eraser Volley"] = {
        Cooldown = 9.5,
        AfterMove = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3
    },
    ["Gigantic Breath"] = {
        Damage = 3.35,
        BlockBreak = true,
        Cooldown = 12.25,
        AfterMove = true,
        Stun = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3
    },
    ["Planet Crusher"] = {
        Cooldown = 32.5,
        BlockBreak = true,
        AfterMove = true,
        Stun = 0.3,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Remotes = { { "FX", "HitEffect" } },
        HitData = {
            Color = Color3.fromRGB(113, 193, 84)
        }
    },
    Omegastorm = {
        Damage = 45,
        Cooldown = 18.5,
        BlockBreak = true,
        AfterMove = true,
        Stun = 0.75,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        HitAnimation = v3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "HumanoidRootPart",
            Size = 25,
            Offset = CFrame.new(0, 0, 0)
        }
    },
    ["Legendary Super Saiyan"] = {
        Awakening = true,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p606) -- Line: 4682, Name: ExtraCheck
                -- upvalues: CollectionService (copy)
                return not CollectionService:HasTag(p606.Character, "LSSJ");
            end
        },

        CustomInvoke = function(p607) -- Line: 4684, Name: CustomInvoke
            -- upvalues: CollectionService (copy), InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;
            local _ = Character.Humanoid;
            coroutine.resume(coroutine.create(function() -- Line: 4688
                -- upvalues: CollectionService (ref), Character (copy), LocalPlayer (copy), InputFunc (ref)
                if CollectionService:HasTag(Character, "LSSJ") then
                    return;
                end;

                if LocalPlayer.Cooldowns:FindFirstChild("J") then
                    return;
                end;

                Character.Values.Active.Value = "temp";
                InputFunc:InvokeServer("J");
            end));
        end
    },
    Taunt = {
        DoNotActivate = true,
        DoNotDeactivate = true,
        Checks = {
            CheckStunned = false,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = true
        },
        Quotes = { { "Grr... GRAAAAGH! (How are you doing?)", "rbxassetid://7459019315", {}, 1, 2 }, { "RAAAAAAGH! (Nice to meet you.)", "rbxassetid://7459022839", 1, 2 }, { "NRAAAAAAGH! (NRAAAAAAGH!)", "rbxassetid://7459025368", 1, 2 } }
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

            ExtraCheck = function(p608) -- Line: 4720, Name: ExtraCheck
                return p608.Character.Values.Active.Value == "" and true or p608.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p609, p610, p611) -- Line: 4723, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p610, "Posing") then
                    Animations.stopClient("Broly", "PoseTransition");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p609.Cooldowns;

                    while true do
                        wait(0.025);
                        local v612 = 0;

                        for _, child in pairs(p609.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v612 = v612 + 1;
                            end;
                        end;

                        if v612 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    Animations.playClient("Broly", "Pose").Stopped:Wait();
                    Animations.playClient("Broly", "PoseTransition");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p609.Cooldowns;

                    while true do
                        wait(0.025);
                        local v613 = 0;

                        for _, child in pairs(p609.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v613 = v613 + 1;
                            end;
                        end;

                        if v613 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};
u1.Stats = v49;
local Stats = u1.Stats;

local function getStats(p614) -- Line: 4769
    -- upvalues: Stats (copy)
    return Stats[p614];
end;

local function loadCode(p615) -- Line: 4772
    -- upvalues: Stats (copy), getStats (copy)
    local v616 = require(p615);

    for i, v in pairs(v616) do
        Stats[i] = v;
    end;

    v616.GetStats = getStats;
end;

local function iterate(p617) -- Line: 4780
    -- upvalues: loadCode (copy), iterate (copy)
    for _, child in ipairs(p617:GetChildren()) do
        if child:IsA("ModuleScript") then
            local success, result = pcall(loadCode, child);

            if not success then
                warn(result, child);
            end;
        elseif child:IsA("Folder") and child.Name ~= "MovesModule" then
            iterate(child);
        end;
    end;
end;

iterate(script);
u1.Stats.Urzan = u1.Stats.Reaper;
u1.Stats.Reakur = u1.Stats.Reaper;

for i, _ in pairs(Stats) do
    if not u4[i] then
        u4[i] = {};
    end;
end;

local u618 = false;
local v623 = {
    Cooldown = 1.5,
    Checks = {
        CheckStunned = true,
        CheckDisabled = false,
        CheckTimestop = true,
        CheckActive = true
    },

    CustomInvoke = function(p619, p620, p621) -- Line: 4816, Name: CustomInvoke
        -- upvalues: CollectionService (copy), u618 (ref)
        local v622 = p621 or (p621 or game.Players.LocalPlayer).Character;
        local Humanoid = v622.Humanoid;
        local _ = Humanoid.Health / Humanoid.MaxHealth;
        local Speed = v622.Values:FindFirstChild("Speed");
        coroutine.wrap(function() -- Line: 4823
            -- upvalues: Speed (copy)
            while workspace.Mechanics.TimeAcc.Value == true do
                if Speed:FindFirstChild("Sprint") then
                    Speed.Sprint:Destroy();
                end;

                wait(1);
            end;
        end)();

        if workspace.Mechanics.TimeAcc.Value == true then
            if Speed:FindFirstChild("Sprint") then
                Speed.Sprint:Destroy();
            end;

            return;
        end;

        if CollectionService:HasTag(v622, "Stunned") then
            return;
        end;

        if Speed then
            if u618 then
                if Speed:FindFirstChild("Sprint") then
                    Speed.Sprint:Destroy();
                end;

                u618 = false;

                return;
            end;

            u618 = true;
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 28;
            NumberValue.Name = "Sprint";
            NumberValue.Parent = Speed;
        end;
    end
};

local function createcd(p624, p625) -- Line: 4945
    local StringValue = Instance.new("StringValue", game.Players.LocalPlayer:WaitForChild("Cooldowns"));
    StringValue.Name = p624;
    game.Debris:AddItem(StringValue, p625);
end;

local _ = {
    Cooldown = 60,
    Stun = 0.75,
    BlockBreak = true,
    Checks = {
        CheckStunned = false,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    Knockback = { 60, 0.5, Vector3.new(0, 25, 0) },
    HitAnimation = v3,
    Remotes = { { "FX", "HeavyEffect" } },
    HitData = {
        Color = Color3.fromRGB(255, 167, 90)
    },
    Hitbox = {
        Type = "Magnitude",
        RelativePart = "HumanoidRootPart",
        Size = 20,
        Offset = CFrame.new(0, 0, 0)
    }
};
local v630 = {
    Cooldown = 0.15,
    AfterMove = true,
    Checks = {
        CheckStunned = true,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    callbacks = {
        client = function(p626, p627, p628) -- Line: 4957, Name: client
            -- upvalues: Animations (copy), Stands2 (copy)
            local UserInputService = game:GetService("UserInputService");
            local v629 = p626 and Animations.playClient(Stands2[p628.Value], "Block") or Animations.playClient(Stands2[p628.Value], "Block", nil, nil, p627:FindFirstChildWhichIsA("Humanoid"), true);

            repeat
                wait();
            until p626 and not UserInputService:IsKeyDown(Enum.KeyCode.X) or (p626 == nil and p627.Values.Block.Value == "None" or v629.IsPlaying == false);

            if v629.IsPlaying then
                v629:Stop();
            end;
        end
    }
};
local v648 = {
    Cooldown = 3,
    Checks = {
        CheckStunned = true,
        CheckDisabled = false,
        CheckSummoned = false,
        CheckActive = true,
        CheckTimestop = true
    },
    callbacks = {
        client = function(p631, p632, p633) -- Line: 4863, Name: client
            -- upvalues: Animations (copy), Stands2 (copy)
            if p631 and p631.Cooldowns:FindFirstChild("Dash") or p632.Cooldowns:FindFirstChild("Dash") then
                return;
            end;

            if workspace.Mechanics.TimeAcc.Value == true then
                return;
            end;

            if not p632:GetAttribute("Direction") then
                p632:SetAttribute("Direction", "backward");
            end;

            local BodyVelocity = Instance.new("BodyVelocity");
            BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
            BodyVelocity.P = (1 / 0);
            local v634 = false;
            local v635 = nil;

            if p631 then
                local v636 = game:GetService("UserInputService"):GetKeysPressed();
                local v637 = {
                    W = "front",
                    A = "left",
                    S = "back",
                    D = "right"
                };

                for _, v in pairs(v636) do
                    if v637[v.KeyCode.Name] then
                        v635 = v637[v.KeyCode.Name];
                        v634 = true;
                    end;
                end;
            else
                v634 = p632.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0);
                v635 = p632.Humanoid.MoveDirection:Dot(p632.HumanoidRootPart.CFrame.RightVector) >= 0 and "right" or "left";
            end;

            local v638 = p632.Humanoid.MoveDirection:Dot(p632.HumanoidRootPart.CFrame.LookVector);
            local v639 = math.acos(v638) * 180 / 3.141592653589793 + 0.5;
            local u640 = math.floor(v639);

            local function inRange(p641, p642) -- Line: 4904
                -- upvalues: u640 (ref)
                local v643;

                if p642 <= u640 then
                    v643 = u640 <= p641;
                else
                    v643 = false;
                end;

                return v643;
            end;

            local v644;

            if u640 >= 86 then
                v644 = u640 <= 95;
            else
                v644 = false;
            end;

            if v644 then
                if v635 == "left" then
                    p632:SetAttribute("Direction", "left");

                    if p631 then
                        Animations.playClient(Stands2[p633.Value], "LeftDash");
                    else
                        Animations.playClient(Stands2[p633.Value], "LeftDash", nil, nil, p632:FindFirstChildWhichIsA("Humanoid"), true);
                    end;
                elseif v635 == "right" then
                    p632:SetAttribute("Direction", "right");

                    if p631 then
                        Animations.playClient(Stands2[p633.Value], "RightDash");
                    else
                        Animations.playClient(Stands2[p633.Value], "RightDash", nil, nil, p632:FindFirstChildWhichIsA("Humanoid"), true);
                    end;
                end;
            else
                local v645;

                if u640 >= 0 then
                    v645 = u640 <= 85;
                else
                    v645 = false;
                end;

                if v645 then
                    p632:SetAttribute("Direction", "front");

                    if p631 then
                        Animations.playClient(Stands2[p633.Value], "ForwardDash");
                    else
                        Animations.playClient(Stands2[p633.Value], "ForwardDash", nil, nil, p632:FindFirstChildWhichIsA("Humanoid"), true);
                    end;
                else
                    local v646;

                    if u640 >= 85 then
                        v646 = u640 <= 180;
                    else
                        v646 = false;
                    end;

                    if v646 then
                        p632:SetAttribute("Direction", "back");

                        if p631 then
                            Animations.playClient(Stands2[p633.Value], "BackwardDash");
                        else
                            Animations.playClient(Stands2[p633.Value], "BackwardDash", nil, nil, p632:FindFirstChildWhichIsA("Humanoid"), true);
                        end;
                    end;
                end;
            end;

            local v647 = v634 and p632.Humanoid.MoveDirection * 50 or (p631 and Animations.playClient(Stands2[p633.Value], "BackwardDash") or Animations.playClient(Stands2[p633.Value], "BackwardDash", nil, nil, p632:FindFirstChildWhichIsA("Humanoid"), true)) and p632.HumanoidRootPart.CFrame.lookVector * -50;
            BodyVelocity.Velocity = v647;
            BodyVelocity.Parent = p632.HumanoidRootPart;
            task.delay(0.25, BodyVelocity.Destroy, BodyVelocity);
        end
    }
};

for i, v in pairs(Stats) do
    for i2, v4 in pairs(v) do
        v4.MoveName = i2;
        v4.StandName = i;

        if type(v4.From) == "string" then
            local v649 = string.split(v4.From, ".");
            local v650 = v649[1];
            local v651 = v649[2];

            if v650 and v651 then
                local v652 = Stats[v650];

                if v652 then
                    v652 = v652[v651];
                end;

                if v652 then
                    v[i2] = TableUtil.Reconcile(v4, v652);
                end;
            end;
        elseif type(v4.From) == "table" then
            for i3, v5 in pairs(v4.From) do
                local v653 = string.split(i3, ".");
                local v654 = v653[1];
                local v655 = v653[2];

                if v654 and v655 then
                    local v656 = Stats[v654];

                    if v656 then
                        v656 = v656[v655];
                    end;

                    if v656 then
                        local v657 = TableUtil.Reconcile(v[v5] or v4[v5], v656);

                        if v[v5] then
                            v[v5] = v657;
                        end;

                        if v4[v5] then
                            v4[v5] = v657;
                        end;
                    end;
                end;
            end;
        end;

        if i2 == "Taunt" then
            v4.DoNotActivate = true;
            v4.DoNotDeactivate = true;
        end;
    end;

    if not v.Sprint then
        v.Sprint = v623;
    end;

    if not v.Dash then
        v.Dash = v648;
    end;

    if not v.Block then
        v.Block = v630;

        if v.Summon then
            v.Block.Summon = v.Summon;
        end;
    end;
end;

for i, v in pairs(Skins.Funcs.GetSkins()) do
    local v658 = Stands[tonumber(i)];

    if type(Stats[v658]) == "table" then
        for _, v4 in pairs(v) do
            if Stats[v4] and Stats[v4] ~= Stats[v658] then
                Stats[v4] = TableUtil.Reconcile(Stats[v4], Stats[v658]);
                RunService:IsStudio();
            else
                Stats[v4] = Stats[v658];
            end;

            if Stats[v4] then
                for _, v5 in pairs(Stats[v4]) do
                    v5.StandName = v658;
                    v5.SkinName = v4;
                end;
            end;
        end;
    end;
end;

local function indexHandler(u659) -- Line: 5065
    return function(p660, p661) -- Line: 5066
        -- upvalues: u659 (copy)
        if p661 == "ParentTable" then
            return u659;
        end;
    end;
end;

for _, v in pairs(Stats) do
    for _, v4 in pairs(v) do
        setmetatable(v4, {
            __index = function(p662, p663) -- Line: 5066
                -- upvalues: v (copy)
                if p663 == "ParentTable" then
                    return v;
                end;
            end
        });
    end;
end;

setmetatable(Stats, {
    __index = function(p664, p665) -- Line: 5082, Name: __index
        warn("\"", p665, "\" stats not found\n", debug.traceback());
    end
});

return u1;