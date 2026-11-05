  

 

local _ = game.ReplicatedStorage["Client Assets"];

return {
    LeaveParts = { "StandHumanoidRootPart", "Stand Head", "Stand Left Arm", "Stand Left Leg", "Stand Right Arm", "Stand Right Leg", "Stand Torso" },
    SoundInfo = {},
    SOffLMBHit = {
        SoundId = 110520137346209,
        Volume = 2
    },
    SOffLMBFinisher = {
        SoundId = 124664276254407,
        Volume = 2
    },
    BarrageHitSound = {
        SoundId = 123480372676874,
        Volume = 2
    },
    BarrageFinisherSound = {
        SoundId = 119910454405726,
        Volume = 2
    },
    HeavyHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true
            } }
    },
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true
            } }
    },
    Blood = {
        Name = "Output",
        Arguments = { "FX", "Shadow_Hit", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Hit",
                LookAt = "Attacker"
            } }
    }
};