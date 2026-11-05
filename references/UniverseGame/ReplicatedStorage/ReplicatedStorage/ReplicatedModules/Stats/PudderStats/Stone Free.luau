  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Animations = require(game.ReplicatedStorage.ReplicatedModules.Animations);
game.ReplicatedStorage:WaitForChild("Client Assets");
local CollectionService = game:GetService("CollectionService");
game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("InputFunc");
require(game.ReplicatedStorage:WaitForChild("Xtal"));
local v1 = { "rbxassetid://7290321324", "rbxassetid://7290325561", "rbxassetid://7290327465" };

return {
    ["Stone Free"] = {
        Summon = {
            Cooldown = 2,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            LeaveParts = { "StandHumanoidRootPart", "Stand Torso", "Stand Head", "Stand Left Arm", "Stand Right Arm", "Stand Left Leg", "Stand Right Leg" },
            AuraColour = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(34, 123, 239)), ColorSequenceKeypoint.new(1, Color3.fromRGB(230, 230, 230)) }),
            callbacks = {
                client = function(p2, p3, p4) -- Line: 38, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p3, "Summoned") then
                        Animations.stopClient("Stone Free", "StandIdle");

                        return;
                    end;

                    Animations.playClient("Stone Free", "StandIdle");
                end
            }
        },
        ["Ora Kicks"] = {
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Cooldown = 1,
            Holding = {
                Length = 3.5,
                Damage = 1,
                Stun = 0.3,
                AfterMove = true,
                Knockback = { 5, 0.05 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Offset = CFrame.new(0, 0, -3.75)
                },
                Sound = { { "rbxassetid://6753788004", 1, 0, false }, { "rbxassetid://6753787336", 1, 0, false } },
                Remotes = { { "FX", "HitEffect" }, { "FX", "StoneFreeHitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(34, 123, 239)
                },
                HitAnimation = v1
            },
            Tapped = {
                Length = 4.6,
                Damage = 1,
                Stun = 0.3,
                AfterMove = true,
                Knockback = { 5, 0.05 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Offset = CFrame.new(0, 0, -3.75)
                },
                Sound = { { "rbxassetid://6753788004", 1, 0, false }, { "rbxassetid://6753787336", 1, 0, false } },
                Remotes = { { "FX", "HitEffect" }, { "FX", "StoneFreeHitEffect" } },
                HitData = {
                    Color = Color3.fromRGB(34, 123, 239)
                },
                HitAnimation = v1,
                Finisher = {
                    Damage = 15,
                    BlockBreak = true,
                    Knockback = { 75, 0.5, Vector3.new(0, 0, 0) },
                    Hitbox = {
                        Type = "Region3",
                        RelativePart = "HumanoidRootPart",
                        Size = Vector3.new(5, 5, 8),
                        Debug = true,
                        Offset = CFrame.new(0, 0, -4)
                    },
                    Remotes = { { "FX", "HeavyEffect" }, { "FX", "StoneFreeHitEffect2" } },
                    HitData = {
                        Color = Color3.fromRGB(34, 123, 239)
                    },
                    Sound = { { "rbxassetid://6856218481", 3, 0, false } }
                }
            }
        },
        RMoves = {
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            ["Meteor Strike"] = {
                Cooldown = 1,
                Damage = 25,
                BlockBreak = true,
                Knockback = { 75, 0.5, Vector3.new(0, 0, 0) },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 8),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -4)
                },
                Remotes = { { "FX", "HeavyEffect" }, { "FX", "StoneFreeHitEffect2" } },
                HitData = {
                    Color = Color3.fromRGB(34, 123, 239)
                },
                Sound = { { "rbxassetid://6856218481", 3, 0, false } }
            },
            ["Cuff Bash"] = {
                Cooldown = 1,
                Damage = 25,
                BlockBreak = true,
                Knockback = { 75, 0.5, Vector3.new(0, 0, 0) },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(5, 5, 8),
                    Debug = true,
                    Offset = CFrame.new(0, 0, -4)
                },
                Remotes = { { "FX", "HeavyEffect" }, { "FX", "StoneFreeHitEffect2" } },
                HitData = {
                    Color = Color3.fromRGB(34, 123, 239)
                },
                Sound = { { "rbxassetid://6856218481", 3, 0, false } }
            }
        },
        ["Spider Tacks/Pitcher Fly"] = {
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Cooldown = 1,
            AfterMove = true,
            ["Spider Tacks"] = {},
            ["Pitcher Fly"] = {
                Damage = 1,
                Stun = 0.5,
                Knockback = { 5, 0.05 },
                Hitbox = {
                    Type = "Region3",
                    RelativePart = "HumanoidRootPart",
                    Size = Vector3.new(6, 6, 6),
                    Offset = CFrame.new(0, 0, -3.75)
                },
                Sound = { { "rbxassetid://8963472121", 1.5, 0, false } }
            }
        },
        ["Letterman Grapple"] = {
            Cooldown = 1,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        ["Strand Separation"] = {
            Cooldown = 1,
            Damage = 1,
            Stun = 0.3,
            Length = 4.8,
            AfterMove = true,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 5, 0.05 },
            Hitbox = {
                Type = "Region3",
                RelativePart = "Stand.StandHumanoidRootPart",
                Size = Vector3.new(6, 6, 6),
                Offset = CFrame.new(0, 0, -3.75)
            },
            Sound = { { "rbxassetid://6753788004", 1, 0, false }, { "rbxassetid://6753787336", 1, 0, false } },
            Remotes = { { "FX", "HitEffect" }, { "FX", "StoneFreeHitEffect2" } },
            HitData = {
                Color = Color3.fromRGB(34, 123, 239)
            },
            HitAnimation = v1
        },
        ["String Barrier"] = {
            Cooldown = 1,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        ["Chin Crusher"] = {
            Cooldown = 1,
            Damage = 18.5,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            },
            Knockback = { 75, 0.5, Vector3.new(0, 0, 0) },
            Hitbox = {
                Type = "Region3",
                RelativePart = "HumanoidRootPart",
                Size = Vector3.new(5, 5, 8),
                Debug = true,
                Offset = CFrame.new(0, 0, -4)
            },
            Remotes = { { "FX", "HeavyEffect" }, { "FX", "StoneFreeHitEffect2" } },
            HitData = {
                Color = Color3.fromRGB(34, 123, 239)
            },
            Sound = { { "rbxassetid://6856218481", 3, 0, false } }
        },
        ["String Guard"] = {
            Cooldown = 1,
            Checks = {
                CheckSummoned = true,
                CheckStunned = true,
                CheckDisabled = true,
                CheckActive = true,
                CheckTimestop = true
            }
        },
        Pose = {
            Cooldown = 2,
            DoNotDeactivate = true,
            Checks = {
                CheckStunned = true,
                CheckDisabled = true,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true,

                ExtraCheck = function(p5) -- Line: 302, Name: ExtraCheck
                    return p5.Character.Values.Active.Value == "" and true or p5.Character.Values.Active.Value == "P";
                end
            },
            callbacks = {
                client = function(p6, p7, p8) -- Line: 312, Name: client
                    -- upvalues: CollectionService (copy), Animations (copy)
                    if CollectionService:HasTag(p7, "Posing") then
                        Animations.stopClient("WhiteSnake", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p6.Cooldowns;

                        while true do
                            task.wait(0.025);
                            local v9 = 0;

                            for _, child in pairs(p6.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v9 = v9 + 1;
                                end;
                            end;

                            if v9 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    else
                        Animations.playClient("WhiteSnake", "PoseTransition").Stopped:Wait();
                        Animations.playClient("WhiteSnake", "PoseIdle");
                        local BinaryStringValue = Instance.new("BinaryStringValue");
                        BinaryStringValue.Name = "P";
                        BinaryStringValue.Parent = p6.Cooldowns;

                        while true do
                            task.wait(0.025);
                            local v10 = 0;

                            for _, child in pairs(p6.Cooldowns:GetChildren()) do
                                if child.Name == "P" then
                                    v10 = v10 + 1;
                                end;
                            end;

                            if v10 == 2 then
                                BinaryStringValue:Destroy();

                                return;
                            end;
                        end;
                    end;
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
            Quotes = { { "You\'ll never wake up again.", "rbxassetid://9061946812 ", {}, 2, 3.5 }, { "Humans ought to lead a life that leads them to heaven.", "rbxassetid://9061950072 ", {}, 2, 6 } }
        },
        ["Stand Taunt"] = {
            Checks = {
                CheckStunned = false,
                CheckDisabled = false,
                CheckSummoned = true,
                CheckActive = false,
                CheckTimestop = true
            },
            Quotes = { { "To be able to communicate something to someone, Jotaro had said that is a wonderful thing.", "rbxassetid://9061953863", {}, 2, 6 } }
        }
    }
};