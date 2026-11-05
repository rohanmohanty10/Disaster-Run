  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
Knit.GetService("EffectService");

return {
    Inherit = {
        AbilityName = "Reaper"
    },
    Metadata = {
        CopyQuotes = false
    },
    Animations = {
        Idle = {
            SummonedIdle = 14014443639
        },
        Action = {
            PoseTransition = 15259081492,
            PoseIdle = 15259083048,
            StandOffPoseIdle = 15259129563,
            StandOffPoseTransition = 15259336265
        }
    },
    Sounds = {
        ["LMB-1"] = {
            SoundId = "rbxassetid://15258780895",
            Volume = 1
        },
        ["LMB-2"] = {
            SoundId = "rbxassetid://15258781457",
            Volume = 1
        },
        ["LMB-3"] = {
            SoundId = "rbxassetid://15258781028",
            Volume = 1
        },
        ["LMB-4"] = {
            SoundId = "rbxassetid://15258781297",
            Volume = 1
        },
        Barrage = {
            SoundId = "rbxassetid://15258781164",
            Volume = 1
        },
        BarrageVoiceline = {
            SoundId = "rbxassetid://15258781855",
            Volume = 1
        },
        ["Summon-SFX"] = {
            SoundId = "rbxassetid://15258780685",
            Volume = 1
        },
        ["Summon-Voiceline"] = {
            SoundId = "rbxassetid://15258781611",
            Volume = 1
        },
        ["Desummon-SFX"] = {
            SoundId = "rbxassetid://15258780815",
            Volume = 1
        },
        ["ScytheRapture-1"] = {
            SoundId = "rbxassetid://15258782234",
            Volume = 1
        },
        ["ScytheRapture-2"] = {
            SoundId = "rbxassetid://15258781976",
            Volume = 1
        },
        Flourish = {
            SoundId = "rbxassetid://15258782097",
            Volume = 1
        },
        ["Flourish-Voiceline"] = {
            SoundId = "rbxassetid://15258782405",
            Volume = 1
        },
        ["ScytheSlam-Startup"] = {
            SoundId = "rbxassetid://15258782602",
            Volume = 1
        },
        ["ScytheSlam-Voiceline"] = {
            SoundId = "rbxassetid://15258783075",
            Volume = 1
        },
        ["DeathSlash-Startup"] = {
            SoundId = "rbxassetid://15258784357",
            Volume = 1
        },
        DeathSlash = {
            SoundId = "rbxassetid://15258784227",
            Volume = 1
        },
        ["DeathSlash-Voiceline"] = {
            SoundId = "rbxassetid://15258784455",
            Volume = 1
        },
        DeathSentence = {
            SoundId = "rbxassetid://15258782819",
            Volume = 1
        },
        ["DeathSentence-Voiceline"] = {
            SoundId = "rbxassetid://15258783518",
            Volume = 1
        },
        Quickdraw = {
            SoundId = "rbxassetid://15258783259",
            Volume = 1
        },
        RadialSwings = {
            SoundId = "rbxassetid://15258783877",
            Volume = 1
        },
        ["RadialSwings-Voiceline"] = {
            SoundId = "rbxassetid://15258783660",
            Volume = 1
        },
        RiftSlice = {
            SoundId = "rbxassetid://15258784100",
            Volume = 1
        },
        ["RiftSlice-Voiceline"] = {
            SoundId = "rbxassetid://15258783969",
            Volume = 1
        },
        SoulReap = {
            SoundId = "rbxassetid://15258784836",
            Volume = 1
        },
        ["SoulReap-Startup"] = {
            SoundId = "rbxassetid://15258784661",
            Volume = 1
        },
        ["SoulReap-Voiceline"] = {
            SoundId = "rbxassetid://15258784529",
            Volume = 1
        },
        SoulGain = {
            SoundId = "rbxassetid://15258785342",
            Volume = 1
        },
        MeterUp1 = {
            SoundId = "rbxassetid://15258784940",
            Volume = 1
        },
        MeterUp2 = {
            SoundId = "rbxassetid://15258785093",
            Volume = 1
        },
        MeterUp4 = {
            SoundId = "rbxassetid://15258785242",
            Volume = 1
        },
        PoseMusic1 = {
            Looped = true,
            SoundId = "rbxassetid://15258786987",
            Volume = 1.5
        },
        PoseMusic2 = {
            Looped = true,
            SoundId = "rbxassetid://18446187199",
            Volume = 2
        },
        StandOffPoseMusic = {
            Looped = true,
            SoundId = "rbxassetid://15258787662",
            Volume = 1.5
        }
    },
    Stats = {
        Summon = {
            IgnoreParts = { "Trails" }
        },
        Pose = {
            Callbacks = {
                Transformer = function(p1) -- Line: 195, Name: Transformer
                    -- upvalues: TableUtil (copy), Knit (copy)
                    local v2 = TableUtil.Copy(p1.Stats, true);

                    if Knit.CollectionService:HasTag(p1.Character, "Summoned") then
                        v2.PoseMusic = "PoseMusic" .. Random.new():NextInteger(1, 2);

                        return v2;
                    end;

                    v2.PoseMusic = "StandOffPoseMusic";
                    v2.StartAnim = "StandOffPoseTransition";
                    v2.LoopAnim = "StandOffPoseIdle";

                    return v2;
                end,

                PoseTransition = function(p3) -- Line: 206, Name: PoseTransition
                    -- upvalues: Knit (copy)
                    local Character = p3.Character;
                    local Stand = Character.Stand;
                    local v4 = { "Trails" };

                    if Knit.CollectionService:HasTag(Character, "Summoned") then
                        return;
                    end;

                    for _, descendant in Stand:GetDescendants() do
                        if descendant.Name == "Cylinder.007" then
                            descendant.Transparency = 1;
                        elseif not table.find(v4, descendant.Name) then
                            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                                descendant.Transparency = 0;
                            end;

                            if descendant.Name ~= "SwingTrail" and (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter"))) then
                                descendant.Enabled = true;
                            end;
                        end;
                    end;
                end,

                PoseEnd = function(p5) -- Line: 236, Name: PoseEnd
                    -- upvalues: Knit (copy)
                    local Character = p5.Character;
                    local Stand = Character.Stand;
                    local v6 = { "Trails" };

                    if Knit.CollectionService:HasTag(Character, "Summoned") then
                        return;
                    end;

                    for _, descendant in Stand:GetDescendants() do
                        if descendant.Name == "Cylinder.007" then
                            descendant.Transparency = 1;
                        elseif not table.find(v6, descendant.Name) then
                            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                                descendant.Transparency = 1;
                            end;

                            if descendant.Name ~= "SwingTrail" and (descendant:IsA("Beam") or (descendant:IsA("Trail") or descendant:IsA("ParticleEmitter"))) then
                                descendant.Enabled = false;
                            end;
                        end;
                    end;
                end
            }
        }
    }
};