  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets["Gold Experience Requiem"];

return {
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Light",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heavy",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    GroundHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Ground",
                AutoSerialize = true,
                Offset = Vector3.new(0, -3, 0)
            } }
    },
    BarrageHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Barrage",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    DebrisHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/DebrisHit",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    HealHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V3", {
                Attacker = "__Attacker",
                Target = "__Target",
                Path = "Particles/Heal",
                AutoSerialize = true,
                LookAt = "Attacker"
            } }
    },
    LMB1Hit = {
        SoundId = 13811775392,
        Volume = 2
    },
    LMB2Hit = {
        SoundId = 13811775392,
        Volume = 2
    },
    LMB3Hit = {
        SoundId = 13811775392,
        Volume = 2
    },
    LMB4Hit = {
        SoundId = 13811775264,
        Volume = 2
    },
    BarrageHitSound = {
        SoundId = 13811776518,
        Volume = 2
    },
    BarrageFinisherSound = {
        SoundId = 13811776291,
        Volume = 2
    },
    KickBarrageHit = {
        SoundId = 13803267126,
        Volume = 2
    },
    KickBarrageFinisher = {
        SoundId = 13803264235,
        Volume = 2
    },
    RootStabHit = {
        SoundId = 13803264707,
        Volume = 2
    },
    StrongPunchHit = {
        SoundId = 13803264806,
        Volume = 2
    },
    DebrisShotHit = {
        SoundId = 13803264513,
        Volume = 2
    },
    Heal = {
        SoundId = 13886248177,
        Volume = 2
    }
};