  

 

local _ = game.ReplicatedStorage["Client Assets"];

return {
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
    },
    ["Bloodshed Hit"] = {
        SoundId = 124942148159902,
        Volume = 2
    },
    ["Lesson 4 Hit"] = {
        SoundId = 100537550416936,
        Volume = 2
    },
    ["LMB Hit"] = {
        SoundId = 110520137346209,
        Volume = 2
    },
    ["LMB Finisher Hit"] = {
        SoundId = 124664276254407,
        Volume = 2
    },
    ["Nail Barrage Hit"] = {
        SoundId = 139679550115284,
        Volume = 2
    },
    ["Nail Barrage Finisher"] = {
        SoundId = 125230031923091,
        Volume = 2
    }
};