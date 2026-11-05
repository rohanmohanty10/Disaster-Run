  

 

game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace").CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local TableUtil = require(Knit.Util.TableUtil);
require(ReplicatedStorage.ReplicatedModules.Enums);
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
PathShortcuts.RemotesPath:WaitForChild("UIOutput");
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = nil;
local u5;

if game:GetService("RunService"):IsServer() then
    local v6 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("Dragon Knight", true);
    u5 = require(v6.Common);
    require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware);
else
    u5 = nil;
end;

Knit.OnStart():andThen(function() -- Line: 37
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u3 (ref), u4 (ref)
    u1 = Knit.GetService("RigService");
    u2 = Knit.GetService("EffectService");
    u3 = Knit.GetService("TagService");
    u4 = Knit.GetService("AnimationService");
end);
local v7 = {
    ["Light Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    ["Heavy Hit"] = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    }
};

return {
    Stats = {
        Pose = {
            From = "Combat.Pose"
        },
        ["Rush Attack"] = {
            From = "Combat.Rush Attack",
            MaxCombo = 4,
            ComboTick = 1,
            ["LMB-1"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p8, p9, p10) -- Line: 85
                            -- upvalues: u2 (ref)
                            local Character = p10.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                Orientation = CFrame.Angles(-10, 60, -180),
                                SkinName = p10.SkinName,
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.17453292519943295, 1.0471975511965976, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-2"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p11, p12, p13) -- Line: 115
                            -- upvalues: u2 (ref)
                            local Character = p13.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                SkinName = p13.SkinName,
                                Orientation = CFrame.Angles(-20, -20, 0),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, -0.3490658503988659, 0)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-3"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 18, function(p14, p15, p16) -- Line: 145
                            -- upvalues: u2 (ref)
                            local Character = p16.Character;
                            u2.FireAllClients("DK Slashes", Character, {
                                SkinName = p16.SkinName,
                                Orientation = CFrame.Angles(-20, 45, -180),
                                Origin = Character.HumanoidRootPart.CFrame * CFrame.Angles(-0.3490658503988659, 0.7853981633974483, -3.141592653589793)
                            });
                        end },
                    { 18, 28, "Attack" },
                    { 25, "End" }
                },
                HitRemotes = { v7["Light Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196893782,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack),
            ["LMB-4"] = TableUtil.Reconcile({
                Speed = 1.25,
                Sequence = {
                    { 0, "Start" },
                    { 14, function(p17, p18, p19) -- Line: 175
                            -- upvalues: u2 (ref)
                            local Character = p19.Character;
                            local v20 = p19.RootPart or Character:FindFirstChild("HumanoidRootPart");
                            u2.FireAllClients("Emit Particle V3", {
                                Path = "Particles/LMBPierce",
                                AutoSerialize = true,
                                Origin = v20.CFrame * CFrame.new(0, 0, -3.4) * CFrame.Angles(1.5707963267948966, 0, 0),
                                Player = p19.Player,
                                Scale = Character:GetScale()
                            });
                        end },
                    { 14, 30, "Attack" },
                    { 32, "End" }
                },
                HitRemotes = { v7["Heavy Hit"] },
                HitSounds = {
                    Hit = {
                        SoundId = 17196902660,
                        Volume = 1
                    }
                }
            }, BaseStatsModule.Rush_Attack_Finisher),
            Callbacks = {
                PreAnim = function(p21) -- Line: 204, Name: PreAnim
                    -- upvalues: u5 (ref)
                    u5:ManageAura({
                        Enabled = true,
                        Trails = false,
                        Character = p21.Character
                    });
                end,

                PostAnim = function(p22) -- Line: 212, Name: PostAnim
                    -- upvalues: u5 (ref)
                    u5:ManageAura({
                        Enabled = false,
                        Trails = false,
                        Character = p22.Character
                    });
                end
            }
        },
        Block = {
            From = "Combat.Block"
        },
        Quickstep = {
            From = "Combat.Quickstep"
        },
        Grab = {
            From = "Combat.Grab",
            Indicators = { {
                    Group = "Universal",
                    InputText = "%s",
                    Visible = true
                } },
            Grab = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Hit", "__Attacker", "__Target" }
                    } }
            },
            Throw = {
                HitRemotes = { {
                        Name = "Output",
                        Arguments = { "FX", "Universal_Grab_Throw", "__Attacker", "__Target" }
                    } }
            }
        }
    },
    Moveset = {
        DefaultMoveState = "Universal",
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            }
        },
        MovesInfo = {
            ["Rush Attack"] = {
                DefaultKeybind = "MouseButton1",
                Equipped = true,
                MoveCapCount = false
            },
            Block = {
                DefaultKeybind = "F",
                Equipped = true,
                MoveCapCount = false
            },
            Grab = {
                DefaultKeybind = "X",
                Equipped = true,
                MoveCapCount = false
            },
            Quickstep = {
                DefaultKeybind = "C",
                Equipped = true,
                MoveCapCount = false
            },
            Pose = {
                DefaultKeybind = "P",
                Equipped = true
            }
        }
    },
    Sounds = {},
    Animations = {
        Action = {
            ["LMB-1"] = 17083452478,
            ["LMB-2"] = 17087038533,
            ["LMB-3"] = 17087045810,
            ["LMB-4"] = 17087049883,
            PoseTransition = 17231016843,
            PoseIdle = 17231005858
        },
        Movement = {
            Walk = 10421345302,
            Run = 10421341888
        },
        Idle = {
            Idle = 17360504775
        }
    }
};