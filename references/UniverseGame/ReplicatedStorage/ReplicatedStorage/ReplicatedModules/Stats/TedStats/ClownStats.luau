  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");
local CollectionService = game:GetService("CollectionService");
local InputFunc = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InputFunc");
require(game.ReplicatedStorage:WaitForChild("Xtal"));
local v2 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local v3 = {
    CheckStunned = true,
    CheckDisabled = true,
    CheckSummoned = true,
    CheckActive = true,
    CheckTimestop = true
};
local v4 = {};

repeat
    task.wait();
until Knit.ClientAssets;

v4.Clown = {
    Summon = {
        Cooldown = 0.3,
        FadeIn = 0.6,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "StandHumanoidRootPart" },
        AuraColor2 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 186, 12)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 86, 1)) }),
        callbacks = {
            client = function(p5, p6, p7) -- Line: 32, Name: client
                -- upvalues: Knit (copy), Animations (copy)
                if Knit.CollectionService:HasTag(p6, "Summoned") then
                    Animations.stopClient("Gold Experience", "StandIdle");

                    return;
                end;

                Animations.playClient("Gold Experience", "StandIdle");
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
        ActualCooldown = 1.5,
        UseStand = true,
        Startup = { 0.383, 0.383, 0.483, 0.333 },
        EndLag = { 0.35, 0.375, 0.425, 0.425 },
        ModifiedCooldowns = { 0.5, 0.5, 0.5 },
        MaxCombo = 4,
        ComboTick = 1,
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(6.3, 6.3, 7.3),
            Offset = CFrame.new(0, 0, -1.75)
        },
        Damage = (1 / 0),
        Unblockable = true,
        TrueDamage = true,
        IgnoreUnhitable = true,
        Stun = 0.75,
        Knockback = { 5, 0.05 },
        PilotKnockback = true,
        HitAnimation = v2,
        Sound = { { "rbxassetid://260430079", 3, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "ClownHitEffect" } },
        ["LMB-4"] = {
            Damage = (1 / 0),
            Unblockable = true,
            TrueDamage = true,
            IgnoreUnhitable = true,
            Stun = 0.25,
            PilotKnockback = true,
            Knockback = { 75, 0.3, Vector3.new(0, 10, 0) },
            Sound = { { "rbxassetid://260430079", 5, 0, false } }
        },
        Callbacks = {
            PreAnim = function(p8, p9) -- Line: 99, Name: PreAnim
                local v10, _, _ = unpack(p8);
                local Character = v10.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
                local _ = Character.Stand;
            end,

            PostAnim = function(p11, p12) -- Line: 106, Name: PostAnim
                local v13, _, _ = unpack(p11);
                local Character = v13.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
                local _ = Character.Stand;
            end,

            PreHit = function(p14, p15) -- Line: 113, Name: PreHit
                local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                local v16, _, _ = unpack(p14);
                local Character = v16.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
            end
        }
    },
    Barrage = {
        MoveCooldown = 1,
        Length = 3,
        Damage = (1 / 0),
        Cooldown = 1,
        Unblockable = true,
        TrueDamage = true,
        IgnoreUnhitable = true,
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
            Size = 6,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Knockback = { 5, 0.05 },
        HitAnimation = v2,
        Sound = { { "rbxassetid://260430079", 1, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "ClownHitEffect" } }
    },
    ["Strong Punch"] = {
        Cooldown = 1,
        BlockBreak = true,
        Damage = (1 / 0),
        Unblockable = true,
        TrueDamage = true,
        IgnoreUnhitable = true,
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
            Size = 6,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Knockback = { 50, 0.3, Vector3.new(5, 25, 0) },
        Sound = { { "rbxassetid://10374230301", 1.5, 0, false } },
        HitAnimation = v2,
        Remotes = { { "FX", "HitEffect V2", "ClownHitEffect" } }
    },
    Timestop = {
        StandName = "Clown",
        Cooldown = 1,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = true,
            CheckActive = true,
            CheckTimestop = true,

            ExtraCheck = function(p17) -- Line: 174, Name: ExtraCheck
                return not workspace.Mechanics.TimeStopped:GetAttribute("Cooldown");
            end
        },
        callbacks = {
            client = function(p18, p19, p20) -- Line: 177, Name: client
                -- upvalues: Animations (copy)
                Animations.playClient("Clown", "TimeStop");
            end
        }
    },
    ["Time Erase"] = {
        Cooldown = 1,
        ManualCooldown = true,
        Length = 120,
        Checks = v3
    },
    Uzi = {
        Cooldown = 1,
        Damage = (1 / 0),
        Unblockable = true,
        TrueDamage = true,
        IgnoreUnhitable = true,
        Stun = 0.25,
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Projectile",
            RelativePart = "HumanoidRootPart",
            Size = 5,
            Speed = 5,
            Projectile = "9mmBullet",
            Piercing = false,
            MaxDist = 150,
            Offset = CFrame.new(-0.85, 1, 4.375),
            AngleOffset = CFrame.Angles(0, 0, 0)
        },
        HitAnimation = v2,
        Remotes = { { "FX", "HitEffect V2", "ClownHitEffect" } }
    },
    ["Stand Jump"] = {
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    ["Insta-Dash"] = {
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    Pilot = {
        StartCooldown = 2,
        EndCooldown = 1,
        Startup = 0.5,
        Checks = {
            CheckStunned = true,
            CheckDisabled = true,
            CheckSummoned = false,
            CheckActive = true,
            CheckTimestop = true
        },
        LeaveParts = { "BETD", "heer", "StandHumanoidRootPart", "FacePart", "Right", "particle", "ground", "Pistol", "Disc" },
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(153, 103, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(47, 55, 98)) }),

        CustomInvoke = function(p21) -- Line: 227, Name: CustomInvoke
            -- upvalues: InputFunc (copy), CollectionService (copy), Knit (copy), Animations (copy), u1 (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;
            local v22 = LocalPlayer:GetMouse();
            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("U", v22.Hit.p);

            if CollectionService:HasTag(Character, "Piloting") then
                local v23 = Knit.GetController("PilotController");
                local v24 = v23:GetPilot(Character);

                if v24 then
                    Animations.stopClient("WhiteSnake", "StandIdle");
                    v23:Control(v24, {
                        HookWalkSpeed = true,
                        HookJumpPower = true,
                        HookJump = true,
                        Animations = u1.Whitesnake.Animations,
                        Radius = u1.Clown.PilotRadius,

                        Check = function() -- Line: 246, Name: Check
                            -- upvalues: CollectionService (ref), Character (copy)
                            return CollectionService:HasTag(Character, "Piloting");
                        end
                    });
                end;
            end;
        end
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

            ExtraCheck = function(p25) -- Line: 256, Name: ExtraCheck
                return p25.Character.Values.Active.Value == "" and true or p25.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p26, p27, p28) -- Line: 259, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p27, "Posing") then
                    Animations.stopClient("Whitesnake", "PoseIdle");
                    Animations.stopClient("Whitesnake", "PilotPoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p26.Cooldowns;

                    while true do
                        wait(0.025);
                        local v29 = 0;

                        for _, child in pairs(p26.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v29 = v29 + 1;
                            end;
                        end;

                        if v29 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    if CollectionService:HasTag(p27, "Piloting") then
                        Animations.playClient("Whitesnake", "PilotPoseTransition").Stopped:Wait();
                        Animations.playClient("Whitesnake", "PilotPoseIdle");
                    else
                        Animations.playClient("Whitesnake", "PoseTransition").Stopped:Wait();
                        Animations.playClient("Whitesnake", "PoseIdle");
                    end;

                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p26.Cooldowns;

                    while true do
                        wait(0.025);
                        local v30 = 0;

                        for _, child in pairs(p26.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v30 = v30 + 1;
                            end;
                        end;

                        if v30 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    },
    ["Quote V2"] = {
        DoNotActivate = true,
        DoNotDeactivate = true,
        StandName = "Clown",
        Checks = {
            CheckStunned = false,
            CheckDisabled = false,
            CheckSummoned = false,
            CheckActive = false,
            CheckTimestop = true
        }
    }
};

return v4;