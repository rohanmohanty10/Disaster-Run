  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.BaseStatsModule);
require(PathShortcuts.EnumsModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Knit.GetService("EffectService");
local v2 = {
    Inherit = {
        AbilityName = "King of Curses"
    },
    Stats = {},
    Animations = {
        Action2 = {
            ["LMB-1"] = 89968142102380,
            ["LMB-2"] = 134799362947976,
            ["LMB-3"] = 132377978826122,
            ["LMB-4"] = 133939184577914,
            SpecialIdle = 83009915195071,
            SpecialTransition = 130504156976727
        },
        Idle = {
            Idle = 95718792280735
        }
    },
    Sounds = require(script.Sounds),
    QuoteInfo = require(script.Quotes),
    Resources = require(script.Resources)
};
v2.Stats["Rush Attack"] = {
    ["LMB-1"] = {
        HitSounds = { v2.Resources.RushAttack1SFX }
    },
    ["LMB-2"] = {
        HitSounds = { v2.Resources.RushAttack2SFX }
    },
    ["LMB-3"] = {
        HitSounds = { v2.Resources.RushAttack3SFX }
    },
    ["LMB-4"] = {
        HitSounds = { v2.Resources.RushAttack4SFX }
    }
};
v2.Stats["Fiendish Rush"] = {
    Strike = {
        HitSounds = { v2.Resources.FiendishRushSFX }
    },
    Kick = {
        HitSounds = { v2.Resources.FiendishRushSFX }
    }
};
v2.Stats["Axe Kick (Air)"] = {
    Kick = {
        HitSounds = { v2.Resources.AxeKickAerialSFX }
    }
};
v2.Stats["Dismantle (Air)"] = {
    Dismantle = {
        HitSounds = { v2.Resources.DismantleAerialHit }
    }
};
v2.Stats["Skull Crasher"] = {
    Slam = {
        HitSounds = { v2.Resources.SkullCrasherHit }
    }
};
v2.Stats.Pose = {
    From = "Combat.Pose",
    Callbacks = {
        PoseTransition = function(p3, p4) -- Line: 108, Name: PoseTransition
            -- upvalues: AssetHandler (copy), u1 (copy), ParticleHandler (copy)
            local Character = p3.Character;
            local _ = p3.Stats;
            local _ = p3.AbilityModel;
            local Trove = p4.Trove;

            if Character:GetAttribute("SpecialPose") then
                local v5 = AssetHandler.GetAsset("Particles/CursedEnergy/Arm", {
                    AbilityName = "The Vessel"
                });
                local v6, v7 = (Character:GetAttribute("MeterColor") or Color3.fromRGB(255, 114, 116)):ToHSV();

                for _, v in { "Right Arm", "Left Arm" } do
                    local v8 = Character:FindFirstChild(v);

                    if v8 then
                        u1.FireAllClients({
                            {
                                Name = "Emit Particle V3",
                                Data = {
                                    {
                                        Path = "Particles/CursedEnergy/Summon",
                                        AutoSerialize = true,
                                        AbilityName = "The Vessel",
                                        SkinName = nil,
                                        AttachTo = {
                                            Part = v8
                                        },
                                        HSVShift = {
                                            Hue = v6,
                                            Saturation = v7
                                        }
                                    }
                                }
                            }
                        });
                        local v9 = Trove:Clone(v5);
                        v9.Parent = v8;
                        ParticleHandler.AttachTo(v9, {
                            Part = v8
                        });
                        ParticleHandler.HSVShiftParticles(v9, {
                            Hue = v6,
                            Saturation = v7
                        });
                        ParticleHandler.EnableAllParticles(v9, true);
                    end;
                end;

                return;
            end;

            local v10 = game.ServerScriptService.ServerLibrary.AbilityMoves:FindFirstChild("King of Curses", true);
            local Common = require(v10.Common);
            local v11 = AssetHandler.CloneAsset("Models/Throne", p3);
            p4.Trove:Add(v11);
            Common:HSVShiftParticles(v11, p3);
            local Motor6D = Instance.new("Motor6D");
            Motor6D.Part0 = p3.RootPart;
            Motor6D.Part1 = v11.ThronePart;
            Motor6D.C0 = CFrame.new(-0.081, -2.588, 0.161);
            Motor6D.Parent = v11.ThronePart;
            v11.Parent = Character;
        end,

        Transformer = function(p12) -- Line: 173, Name: Transformer
            -- upvalues: TableUtil (copy)
            local v13 = TableUtil.Copy(p12.Stats, true);

            if not p12.Character:GetAttribute("SpecialPose") then
                v13.PoseMusic = "PoseMusic" .. math.random(1, 2);

                return v13;
            end;

            v13.PoseMusic = "SpecialPoseMusic";
            v13.StartAnim = "SpecialTransition";
            v13.LoopAnim = "SpecialIdle";

            return v13;
        end
    }
};

return v2;