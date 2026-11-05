  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local _ = PathShortcuts.ClientAssets["Weather Report"];

return {
    LightHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V2", "__Legacy", {
                ParticleName = "WRWindeffect",
                LookAt = "Attacker"
            } }
    },
    HeavyHit = {
        Name = "Output",
        Arguments = { "FX", "HitEffect V2", "__Legacy", {
                ParticleName = "WRWindeffect",
                LookAt = "Attacker"
            } }
    },

    ShockCallback = function(p1, p2) -- Line: 27, Name: ShockCallback
        -- upvalues: Knit (copy)
        local v3 = Knit.GetService("EffectService");
        local v4 = {
            Length = 1,
            Speed = 3,
            Size = 3,
            Material = "Neon",
            CFrames = { p2.Target.HumanoidRootPart.CFrame * CFrame.new(math.random(-1, 1), 0, 0), p2.Target.HumanoidRootPart.CFrame * CFrame.new(math.random(-1, 1), 0, 0) },
            Color = ColorSequence.new(Color3.fromRGB(110, 153, 202), Color3.fromRGB(82, 124, 174)),
            Curves = { 0, 0 }
        };
        v3.FireAllClients("Lightning Hit Effect", p2.Target, p1.Character, {
            HitData = { v4 }
        });
    end,

    LMB1Hit = {
        SoundId = 13137414339,
        Volume = 2
    },
    LMB2Hit = {
        SoundId = 13137414531,
        Volume = 2
    },
    LMB3Hit = {
        SoundId = 10193014837,
        Volume = 2
    },
    LMB4Hit = {
        SoundId = 10193015843,
        Volume = 2
    },
    BarrageHitSound = {
        SoundId = 13159475338,
        Volume = 1.5
    },
    BarrageFinisherSound = {
        SoundId = 13159474987,
        Volume = 2
    }
};