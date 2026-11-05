  

 

local v1 = {};
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u2 = nil;
local u3 = nil;
Knit.OnStart():andThen(function() -- Line: 11
    -- upvalues: u2 (ref), Knit (copy), PathShortcuts (copy), u3 (ref)
    u2 = Knit.GetService("EffectService");
    u3 = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.Middleware).GetMiddleware("CombatService");
end);
require(PathShortcuts.KnitPath.Trove);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.EnumsModule);
local _ = PathShortcuts.ClientAssets;
local _ = ReplicatedStorage.ReplicatedModules;
local BaseStatsModule = require(PathShortcuts.BaseStatsModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u4 = {
    Name = "Output",
    Arguments = { "FX", "HitEffect V3", {
            Attacker = "__Attacker",
            Target = "__Target",
            Path = "Particles/NS_Hit",
            LookAt = "Attacker",
            IgnoreUnusuals = true
        } }
};
v1.Block = {
    From = "Combat.Block"
};
v1.Quickstep = {
    From = "Combat.Quickstep"
};
v1.Pose = {
    From = "Combat.Pose"
};
v1.Grab = {
    From = "Combat.Grab"
};
v1["Rush Attack"] = {
    From = "Combat.Rush Attack",
    Indicators = { {
            Group = "Universal",
            Visible = true
        } },
    MaxCombo = 2,
    ComboTick = 1.5,
    ["LMB-1"] = TableUtil.Reconcile({
        Speed = 1.5,
        Damage = 20,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB1" }, { 5, "Attack", {
                    Multiple = true
                } }, { 24, "Attack", {
                    Multiple = true
                } }, { 39, "Attack", {
                    Multiple = true
                } }, { 41, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 15665760078,
                Volume = 1.5
            }
        },
        HitRemotes = { u4 }
    }, BaseStatsModule.Rush_Attack),
    ["LMB-2"] = TableUtil.Reconcile({
        Damage = 40,
        Sequence = { { 0, "Start" }, { 0, "PlaySound", "LMB2" }, { 23, 27, "Attack" }, { 36, "End" } },
        HitSounds = {
            Hit = {
                SoundId = 260430117,
                Volume = 1.5,
                PlaybackSpeed = 1.1
            }
        },
        HitRemotes = { {
                Name = "Output",
                Arguments = { "FX", "HitEffect V3", {
                        Attacker = "__Attacker",
                        Target = "__Target",
                        Particle = "Particles/NS_Heavy",
                        AutoSerialize = true
                    } }
            } },
        Ragdoll = {
            Time = 1
        },
        Block = {
            Unblockable = true
        },
        Knockback = {
            RelativePart = "Attacker",
            Speed = 45,
            Velocity = Vector3.new(0, 15, 0),
            Time = 0.15
        }
    }, BaseStatsModule.Rush_Attack_Finisher),
    Callbacks = {
        StateChecker = function(p5, p6) -- Line: 146, Name: StateChecker
            -- upvalues: TableUtil (copy), u4 (copy)
            local Count = p5.CharacterState["Rush Attack"].Count;
            local v7 = TableUtil.Copy(p5.Stats, true);
            v7["LMB-" .. Count].HitRemotes = { u4 };

            return v7;
        end
    }
};
v1["Seal Fates"] = {
    Active = true,
    Actionable = {
        Active = true
    }
};
v1.Exonerate = {
    Active = true,
    Actionable = {
        Active = true
    }
};
v1["Banishing Shot"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true,
        BlockCancel = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(5, 5, 0),
        Offset = CFrame.new(0, 0, -3)
    },
    Cooldown = {
        Time = 1.5,
        AfterMove = true
    }
};
v1["Annihilation Wave"] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Block = {
        Blockable = false,
        PerfectBlockable = false,
        Unblockable = true,
        BypassCounter = true,
        BlockCancel = true
    },
    Hitbox = {
        RelativePart = "HumanoidRootPart",
        Size = Vector3.new(25, 5, 25),
        Offset = CFrame.new(0, 0, 0)
    },
    Cooldown = {
        Time = 1.5,
        AfterMove = true
    }
};
v1["\"Ianuae\""] = {
    Active = true,
    Actionable = {
        Active = true
    },
    Cooldown = {
        Time = 0.5,
        AfterMove = true
    },

    Invoke = function(p8) -- Line: 258, Name: Invoke
        -- upvalues: Knit (copy)
        local LocalPlayer = game.Players.LocalPlayer;
        local Character = LocalPlayer.Character;
        local _ = p8.Input;
        local Position = LocalPlayer:GetMouse().Hit.Position;
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart");
        local Position2 = HumanoidRootPart.Position;
        Knit.GetService("MoveInputService"):FireInput(p8.RawInput, Position2, Position, { HumanoidRootPart.CFrame:ToEulerAngles(Enum.RotationOrder.XYZ) });
    end
};
v1.Breaker = {
    From = "Combat.Breaker"
};

return {
    Moveset = {
        Groups = {
            Universal = {
                Visible = true,
                Priority = 1
            },
            ["Seal Fates"] = {
                Visible = false,
                Priority = 2
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
            Pose = {
                DefaultKeybind = "P",
                Equipped = true,
                MoveCapCount = false
            },
            ["Seal Fates"] = {
                DefaultKeybind = "Q",
                Equipped = true
            },
            ["Banishing Shot"] = {
                DefaultKeybind = "T",
                Equipped = true
            },
            ["Annihilation Wave"] = {
                DefaultKeybind = "G",
                Equipped = true
            },
            Exonerate = {
                DefaultKeybind = "Z",
                State = "Seal Fates",
                Equipped = true
            },
            ["\"Ianuae\""] = {
                DefaultKeybind = "C",
                Equipped = true
            }
        }
    },
    Animations = {
        Action = {
            ["LMB-1"] = 11531353349,
            ["LMB-2"] = 13390682925,
            ["Banishing Shot"] = 15898359581,
            ["Annihilation Wave"] = 11495874205
        },
        Movement = {
            Walk = 14099633862,
            Run = 13811919323
        },
        Idle = {
            Idle = 14098348879
        }
    },
    Stats = v1,
    Sounds = {
        PoseMusic = {
            SoundId = 18371093880,
            Volume = 4,
            PlaybackSpeed = 0.59,
            Looped = true
        },
        BanishTarget = {
            SoundId = 18457870034,
            Volume = 0.9,
            PlaybackSpeed = 1
        },
        BanishShoot = {
            SoundId = 18458440269,
            Volume = 2.5,
            PlaybackSpeed = 1.15
        },
        LMB1 = {
            SoundId = 11751732915,
            Volume = 2
        },
        LMB2 = {
            SoundId = 17874177113,
            Volume = 2
        },
        MeterUp1 = {
            SoundId = 0
        },
        MeterUp2 = {
            SoundId = 0
        },
        MeterUp3 = {
            SoundId = 0
        },
        MeterUp4 = {
            SoundId = 0
        }
    },
    Metadata = {
        PostRig = function(p9) -- Line: 404, Name: PostRig
            -- upvalues: AssetHandler (copy)
            local Character = p9.Character;
            local Player = p9.Player;

            repeat
                task.wait(0.1);
            until Character:WaitForChild("Head");

            if Player then
                Player:HasAppearanceLoaded();
            end;

            local v10 = AssetHandler.GetAsset("Particles/Aura", {
                AbilityName = "The Banisher"
            });

            if v10 then
                for _, child in Character:GetChildren() do
                    if child:IsA("BasePart") and child.Name ~= "HumanoidRootPart" then
                        for _, child2 in v10:GetChildren() do
                            child2:Clone().Parent = child;
                        end;

                        if child.Name == "Head" and child:FindFirstChild("Specs") then
                            child:FindFirstChild("Specs"):Destroy();
                        end;
                    end;
                end;
            end;
        end
    }
};