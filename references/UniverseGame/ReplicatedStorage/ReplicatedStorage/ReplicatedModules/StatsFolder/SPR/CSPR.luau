  

 

local v1 = game:GetService("ReplicatedStorage")["Client Assets"];
local v2 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.Universal_HitVFX,
            Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0))
        }
    }
};
local v3 = {
    Name = "Output",
    Arguments = {
        "FX",
        "HitEffect V3",
        {
            Attacker = "__Attacker",
            Target = "__Target",
            AutoSerialize = true,
            LookAt = "Attacker",
            Particle = v1.Universal.UniversalHeavyVFX,
            Offset = CFrame.Angles(0, 3.141592653589793, 0),
            Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 0, 0))
        }
    }
};

return {
    Inherit = {
        AbilityName = "SPR"
    },
    Stats = {
        ["Rush Attack"] = {
            ["LMB-1"] = {
                HitRemotes = { v2 }
            },
            ["LMB-4"] = {
                HitRemotes = { v3 }
            }
        },
        Combo = {
            HitRemotes = { v2 }
        },
        ["Cursed Punches"] = {
            HitRemotes = { v2 }
        },
        ["Star Breaker"] = {
            HitRemotes = { v3 }
        },
        ["Arrow Throw"] = {
            HitRemotes = { v3 }
        },
        ["Arrow Prison"] = {
            HitRemotes = { v3 }
        },
        ["Arrow Judgement"] = {
            HitRemotes = { v3 }
        }
    },
    Sounds = {
        SummonSound = {
            SoundId = 91873623387655,
            Volume = 2
        },
        Desummon = {
            SoundId = 81610982389371,
            Volume = 2
        },
        PoseMusic = {
            SoundId = 9943519715,
            Volume = 3.25,
            PlaybackSpeed = 1,
            Looped = true
        }
    }
};