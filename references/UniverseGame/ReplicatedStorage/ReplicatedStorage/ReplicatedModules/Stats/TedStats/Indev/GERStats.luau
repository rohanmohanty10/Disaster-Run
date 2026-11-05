  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
game.ReplicatedStorage:WaitForChild("Client Assets");
local CollectionService = game:GetService("CollectionService");
local InputFunc = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InputFunc");
require(game.ReplicatedStorage:WaitForChild("Xtal"));
local v1 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };
local v2 = {};

repeat
    task.wait();
until Knit.ClientAssets;

v2.GER = {
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
        AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(213, 115, 61)), ColorSequenceKeypoint.new(1, Color3.fromRGB(165, 0, 75)) }),
        callbacks = {
            client = function(p3, p4, p5) -- Line: 32, Name: client
                -- upvalues: Knit (copy), Animations (copy)
                if Knit.CollectionService:HasTag(p4, "Summoned") then
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
        Damage = 8,
        Stun = 0.75,
        Knockback = { 5, 0.05 },
        PilotKnockback = true,
        HitAnimation = v1,
        Sound = { { "rbxassetid://8283374745", 1.5, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "LightEffectGER" } },
        ["LMB-4"] = {
            Damage = 12.5,
            Stun = 0.25,
            PilotKnockback = true,
            Knockback = { 75, 0.3, Vector3.new(0, 10, 0) },
            Sound = { { "rbxassetid://8283375301", 5, 0, false } }
        },
        Callbacks = {
            PreAnim = function(p6, p7) -- Line: 91, Name: PreAnim
                local v8, _, _ = unpack(p6);
                local Character = v8.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
                local _ = Character.Stand;
            end,

            PostAnim = function(p9, p10) -- Line: 98, Name: PostAnim
                local v11, _, _ = unpack(p9);
                local Character = v11.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
                local _ = Character.Stand;
            end,

            PreHit = function(p12, p13) -- Line: 105, Name: PreHit
                local _ = require(game.ServerScriptService.Main.Moves.Functions.Utils).MoveUtils.DeepCopy;
                local v14, _, _ = unpack(p12);
                local Character = v14.Character;
                local _ = Character.Humanoid;
                local _ = Character.HumanoidRootPart;
            end
        }
    },
    Barrage = {
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        MoveCooldown = 1,
        Length = 3,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Damage = 1.25,
        Knockback = { 5, 0.05 },
        Stun = 0.5,
        HitAnimation = v1,
        Sound = { { "rbxassetid://10374230221", 1, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "BarrageHitEffect" } },
        Finisher = {
            BlockBreak = true,
            Damage = 12.25,
            Stun = 0.5,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6,
                Offset = CFrame.new(0, 0, -5.65)
            },
            Knockback = { 50, 0.3, Vector3.new(5, 25, 0) },
            Sound = { { "rbxassetid://10374229911", 1.5, 0, false } },
            HitAnimation = v1,
            Remotes = { { "FX", "HitEffect V2", "HeavyEffectGER" } }
        }
    },
    ["Heavy Attack"] = {
        Cooldown = 1,
        BlockBreak = true,
        Damage = 12.25,
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
        HitAnimation = v1,
        Remotes = { { "FX", "HitEffect V2", "HeavyEffectGER" } }
    },
    ["Return To Zero"] = {
        Cooldown = 1,
        KeepCounter = true,
        BlockBreak = true,
        Damage = 12.25,
        Stun = 0.5,
        Checks = {
            CheckSummoned = true,
            CheckStunned = false,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = false
        },
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Knockback = { 50, 0.3, Vector3.new(5, 25, 0) },
        Sound = { { "rbxassetid://10374229911", 1.5, 0, false } },
        HitAnimation = v1,
        Remotes = { { "FX", "HitEffect V2", "HeavyEffectGER" } }
    },
    ["Unreachable Truth"] = {
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Cooldown = 1,
        Hitbox = {
            Type = "Magnitude",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = 6,
            Offset = CFrame.new(0, 0, -5.65)
        },
        Damage = 1.25,
        Knockback = { 5, 0.05 },
        Stun = 0.5,
        HitAnimation = v1,
        Sound = { { "rbxassetid://10374230221", 1, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "BarrageHitEffect" } },
        Finisher = {
            BlockBreak = true,
            Damage = 12.25,
            Stun = 0.5,
            Hitbox = {
                Type = "Magnitude",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = 6,
                Offset = CFrame.new(0, 0, -5.65)
            },
            Knockback = { 50, 0.3, Vector3.new(5, 25, 0) },
            Sound = { { "rbxassetid://10374229911", 1.5, 0, false } },
            HitAnimation = v1,
            Remotes = { { "FX", "HitEffect V2", "HeavyEffectGER" } }
        }
    },
    ["Berserk Senses V2"] = {
        Cooldown = 1,
        Damage = 1,
        Stun = 1,
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Hitbox = {
            Type = "Region3",
            RelativePart = "Stand.StandHumanoidRootPart",
            Size = Vector3.new(8, 8, 12),
            Offset = CFrame.new(0, 0, -1.75)
        },
        Knockback = { 5, 0.05 },
        HitAnimation = v1,
        Sound = { { "rbxassetid://8283374745", 1.5, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "LightEffectGER" } },
        Punch = {
            Damage = 35,
            Stun = 6,
            Remotes = { { "FX", "HitEffect V2", "HeavyEffectGER" } },
            Knockback = { 60, 0.4, Vector3.new(5, 25, 0) }
        }
    },
    ["Debris Projectile"] = {
        Cooldown = 1,
        Damage = 12.5,
        Stun = 0.1,
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },
        Sound = { { "rbxassetid://10653836510", 1.5, 0, false } },
        Remotes = { { "FX", "HitEffect V2", "Beamhit" } },
        HitAnimation = v1
    },
    ["Life Giver"] = {
        Cooldown = 1,
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        }
    },
    ["Pursuit Rush"] = {
        Cooldown = 1,
        Checks = {
            CheckSummoned = true,
            CheckStunned = true,
            CheckDisabled = true,
            CheckActive = true,
            CheckTimestop = true
        },

        CustomInvoke = function(p15) -- Line: 275, Name: CustomInvoke
            -- upvalues: CollectionService (copy), InputFunc (copy)
            local LocalPlayer = game.Players.LocalPlayer;
            local Character = LocalPlayer.Character;
            local v16 = LocalPlayer:GetMouse();
            local v17 = OverlapParams.new();
            v17.FilterType = Enum.RaycastFilterType.Whitelist;
            v17.FilterDescendantsInstances = { workspace.Living };
            v17.MaxParts = 300;
            local v18 = workspace:GetPartBoundsInRadius(v16.Hit.Position, 75, v17);
            local v19 = {};

            for _, v in pairs(v18) do
                local v20 = v.Parent:FindFirstChildOfClass("Humanoid");

                if v20 and (not v19[v.Parent] and (not v:IsDescendantOf(Character) and (not CollectionService:HasTag(Character, "Piloting") or game.Players:GetPlayerFromCharacter(v.Parent)))) and CollectionService:HasTag(v.Parent, "Hitable") then
                    v19[v.Parent] = v20;
                end;
            end;

            local v21 = nil;
            local v22 = nil;

            for i, _ in pairs(v19) do
                local v23 = i:FindFirstChild("HumanoidRootPart") or i:FindFirstChildOfClass("BasePart");

                if v23 then
                    local Magnitude = (v16.Hit.Position - v23.Position).Magnitude;

                    if not v21 or Magnitude < v22 then
                        v22 = Magnitude;
                        v21 = i;
                    end;
                end;
            end;

            Character.Values.Active.Value = "temp";
            InputFunc:InvokeServer("V", v21);
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

            ExtraCheck = function(p24) -- Line: 319, Name: ExtraCheck
                return p24.Character.Values.Active.Value == "" and true or p24.Character.Values.Active.Value == "P";
            end
        },
        callbacks = {
            client = function(p25, p26, p27) -- Line: 322, Name: client
                -- upvalues: CollectionService (copy), Animations (copy)
                if CollectionService:HasTag(p26, "Posing") then
                    Animations.stopClient("Whitesnake", "PoseIdle");
                    Animations.stopClient("Whitesnake", "PilotPoseIdle");
                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p25.Cooldowns;

                    while true do
                        wait(0.025);
                        local v28 = 0;

                        for _, child in pairs(p25.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v28 = v28 + 1;
                            end;
                        end;

                        if v28 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                else
                    if CollectionService:HasTag(p26, "Piloting") then
                        Animations.playClient("Whitesnake", "PilotPoseTransition").Stopped:Wait();
                        Animations.playClient("Whitesnake", "PilotPoseIdle");
                    else
                        Animations.playClient("Whitesnake", "PoseTransition").Stopped:Wait();
                        Animations.playClient("Whitesnake", "PoseIdle");
                    end;

                    local BinaryStringValue = Instance.new("BinaryStringValue");
                    BinaryStringValue.Name = "P";
                    BinaryStringValue.Parent = p25.Cooldowns;

                    while true do
                        wait(0.025);
                        local v29 = 0;

                        for _, child in pairs(p25.Cooldowns:GetChildren()) do
                            if child.Name == "P" then
                                v29 = v29 + 1;
                            end;
                        end;

                        if v29 == 2 then
                            BinaryStringValue:Destroy();

                            return;
                        end;
                    end;
                end;
            end
        }
    }
};

return v2;