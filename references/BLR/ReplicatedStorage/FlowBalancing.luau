  

if script.Parent ~= game:GetService("ReplicatedStorage") then
    error("required the static flow balancing module. require the one in ReplicatedStorage");
end;

local function noop() -- Line: 5
end;

local v3 = setmetatable({
    ExtraHeaders = "ExtraHeaders",
    JumpAddition = "JumpAddition",
    SpeedAddition = "SpeedAddition",
    ShotPowerMultiplier = "ShotPowerMultiplier",
    ExtraDribbles = "ExtraDribbles",
    AnkleBreakRagdollTime = "AnkleBreakRagdollTime",
    HeaderPowerMultiplier = "HeaderPowerMultiplier",
    SlideCooldown = "SlideCooldown",
    DribbleDuration = "DribbleDuration",
    DribbleCooldown = "DribbleCooldown",
    PassPowerMultiplier = "PassPowerMultiplier",
    StaminaDrainMultiplier = "StaminaDrainMultiplier",
    VolleyPowerMultiplier = "VolleyPowerMultiplier",
    AccuratePassesTime = "AccuratePassesTime",
    NoBallSpeedReduction = "NoBallSpeedReduction",
    ShotChargeSpeed = "ShotChargeSpeed",
    TeamMateFlowGain = "TeamMateFlowGain",
    SlideDistanceBoost = "SlideDistanceBoost",
    PassArc = "PassArc",
    AbilityCooldown = "AbilityCooldown",
    HomingPass = "HomingPass",
    RecieveSpeed = "RecieveSpeed",
    RecieveShotPower = "RecieveShotPower",
    BallSpeedAddition = "BallSpeedAddition",
    AnkleBreakFlowGainMultiplier = "AnkleBreakFlowGainMultiplier",
    WildCardRNG = "WildCardRNG",
    ShotCurveDivisor = "ShotCurveDivisor",
    ShotCurveLaunchDivisor = "ShotCurveLaunchDivisor",
    ShotSpeedMultiplier = "ShotSpeedMultiplier",
    StealFlowGain = "StealFlowGain",
    RagdollRecoveryMultiplier = "RagdollRecoveryMultiplier"
}, {
    __index = function(p1, p2) -- Line: 40, Name: __index
        error((`invalid buff {p2}`));
    end
});

return {
    ["Homeless Man"] = {
        VFXId = "HomelassManFlow",
        ActivateMessage = "You shouldn\'t have this. -SPAX",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(190, 26, 255),
        Stats = {
            [v3.SpeedAddition] = 8,
            [v3.ShotPowerMultiplier] = 3,
            [v3.ExtraDribbles] = 2
        }
    },
    Spade = {
        VFXId = "MeltedFlowVFX",
        ActivateMessage = "MELTED... MORE LIKE BUUUUUUURNT",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 255, 255),
        Stats = {
            [v3.SpeedAddition] = 16,
            [v3.ShotPowerMultiplier] = 1.75
        }
    },
    ["Butterfly Dancer"] = {
        VFXId = "LavinhoFlowVFX",
        ActivateMessage = "DANCER FLOW ACTIVATED",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(111, 222, 0),
        Stats = {
            [v3.ShotChargeSpeed] = 1.25,
            [v3.VolleyPowerMultiplier] = 1.2,
            [v3.DribbleCooldown] = 0.8,
            [v3.ExtraDribbles] = 3,
            [v3.AccuratePassesTime] = 0.75,
            [v3.SpeedAddition] = 4,
            [v3.NoBallSpeedReduction] = true
        }
    },
    Snake = {
        VFXId = "",
        ActivateMessage = "+2 Headers, +Header Strength, + Movement Speed, Reduced Tackle Cooldown",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(43, 255, 131),
        Stats = {
            [v3.ExtraHeaders] = 2,
            [v3.HeaderPowerMultiplier] = 1.25,
            [v3.SlideCooldown] = 2.5,
            [v3.SpeedAddition] = 2
        }
    },
    ["Crown Messenger"] = {
        VFXId = "SnuffyFlowVFX",
        ActivateMessage = "Auto-track passes, speed boost, less stamina drain, faster tackle & recovery, longer ankle breaks, +2 dribbles, -15% ability cooldowns.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 200, 40),
        Stats = {
            [v3.AccuratePassesTime] = 0.75,
            [v3.SpeedAddition] = 2.3,
            [v3.StaminaDrainMultiplier] = 0.9,
            [v3.SlideCooldown] = 2.25,
            [v3.RagdollRecoveryMultiplier] = 0.75,
            [v3.AnkleBreakRagdollTime] = 1.75,
            [v3.ExtraDribbles] = 2,
            [v3.TeamMateFlowGain] = 30,
            [v3.AbilityCooldown] = 0.85
        }
    },
    ["Master Of All Trades"] = {
        VFXId = "",
        ActivateMessage = "Faster Chameleon, speed boost, auto-track M2 passes, +1 dribble, faster tackle, stronger shots",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(193, 35, 255),
        Stats = {
            [v3.SpeedAddition] = 1.5,
            [v3.DribbleCooldown] = 0.8,
            [v3.ExtraDribbles] = 1,
            [v3.SlideCooldown] = 2.1,
            [v3.ShotPowerMultiplier] = 1.05,
            [v3.VolleyPowerMultiplier] = 1.05,
            [v3.AccuratePassesTime] = 0.75,
            [v3.AbilityCooldown] = 0.75,
            [v3.PassArc] = 0.35
        }
    },
    Ice = {
        VFXId = "HioriFlowVFX",
        ActivateMessage = "Speed boost, high-arc passes, +15 flow for teammates, and pass receivers gain a speed boost.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(107, 220, 255),
        Stats = {
            [v3.SpeedAddition] = 3,
            [v3.HomingPass] = 2.8,
            [v3.TeamMateFlowGain] = 15,
            [v3.RecieveSpeed] = 1.15
        }
    },
    ["King\'s Authority"] = {
        VFXId = "",
        ActivateMessage = "-25% tackle cooldown, - stamina loss, +ankle break ragdoll time, +Shot Power ",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 0, 0),
        Stats = {
            [v3.AnkleBreakRagdollTime] = 1.75,
            [v3.ShotPowerMultiplier] = 1.2,
            [v3.SlideCooldown] = 2.25,
            [v3.StaminaDrainMultiplier] = 0.8
        }
    },
    Singularity = {
        VFXId = "SingularityFlow",
        ActivateMessage = "+1 Dribble. Passes are more accurate, receiving grants buffs. Increased shot & volley power and movement speed.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(38, 107, 255),
        Stats = {
            [v3.ShotChargeSpeed] = 1.15,
            [v3.VolleyPowerMultiplier] = 1.2,
            [v3.ExtraDribbles] = 2,
            [v3.AccuratePassesTime] = 0.75,
            [v3.SpeedAddition] = 3,
            [v3.NoBallSpeedReduction] = true
        }
    },
    ["Target Man"] = {
        VFXId = "",
        ActivateMessage = "Stronger air volley, 1.5x Jump, 20% Speed Boost, 25% Shot Boost, 50% Header Strength Boost",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 0, 0),
        Stats = {
            [v3.HeaderPowerMultiplier] = 1.5,
            [v3.SpeedAddition] = 5,
            [v3.JumpAddition] = 4,
            [v3.ShotPowerMultiplier] = 1.25,
            [v3.VolleyPowerMultiplier] = 1.5,
            [v3.NoBallSpeedReduction] = true
        }
    },
    Easter = {
        VFXId = "EasterFlow",
        ActivateMessage = "...",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(238, 105, 255),
        Stats = {
            [v3.HeaderPowerMultiplier] = 1.2,
            [v3.SpeedAddition] = 2.5,
            [v3.JumpAddition] = 2.5,
            [v3.ShotPowerMultiplier] = 1.2
        }
    },
    Brazil = {
        VFXId = "BrazilFlow",
        ActivateMessage = "Increased shooting strength, faster speed with the ball & longer dribbles!",
        AuraFallback = "Dribbler",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(45, 190, 80),
        Stats = {
            [v3.ShotPowerMultiplier] = 1.125,
            [v3.VolleyPowerMultiplier] = 1.125,
            [v3.BallSpeedAddition] = 4,
            [v3.DribbleDuration] = 1,
            [v3.AnkleBreakFlowGainMultiplier] = 1.05
        }
    },
    Spain = {
        VFXId = "SpainFlow",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(220, 45, 45),
        Stats = {
            [v3.ShotPowerMultiplier] = 1.25,
            [v3.VolleyPowerMultiplier] = 1.25,
            [v3.WildCardRNG] = true
        }
    },
    Contrarian = {
        VFXId = "CharlesFlowAura",
        ActivateMessage = "Speed boost, high arc base pass with auto track, +10 flow to teammates, passes give speed.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 247, 11),
        Stats = {
            [v3.SpeedAddition] = 5,
            [v3.TeamMateFlowGain] = 10,
            [v3.PassArc] = 0.35
        }
    },
    ["Demon King"] = {
        VFXId = "DemonKingFlow",
        ActivateMessage = "Stronger volleys, increased shot power and speed, slightly longer tackle.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(5, 255, 5),
        Stats = {
            [v3.SlideDistanceBoost] = 6,
            [v3.VolleyPowerMultiplier] = 1.25,
            [v3.ShotPowerMultiplier] = 1.3,
            [v3.SpeedAddition] = 4,
            [v3.StaminaDrainMultiplier] = 0.9
        }
    },
    ["Ace Eater"] = {
        VFXId = "LorenzoFlow",
        ActivateMessage = "-10% ABILITY COOLDOWN, FASTER MOVEMENT, +1 DRIBBLE, +1 HEADER!",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(185, 64, 255),
        Stats = {
            [v3.ExtraDribbles] = 1,
            [v3.SpeedAddition] = 3,
            [v3.AbilityCooldown] = 0.9,
            [v3.DribbleCooldown] = 0.8,
            [v3.ExtraHeaders] = 1
        }
    },
    ["Magician Flow"] = {
        VFXId = "MagicianFlow",
        ActivateMessage = "Slight speed boost, auto track passes, recieving player gets speed boost and shot power buff.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(185, 64, 255),
        Stats = {
            [v3.SpeedAddition] = 1.5,
            [v3.HomingPass] = 2.8,
            [v3.RecieveSpeed] = 1.15,
            [v3.RecieveShotPower] = 1.15
        }
    },
    ["Awakened Genius"] = {
        VFXId = "SaeFlowAura",
        ActivateMessage = "Stronger shots that curve, faster dribble cooldown, auto-tracking passes, and reduced stamina drain.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(236, 64, 172),
        Stats = {
            [v3.ShotPowerMultiplier] = 1.2,
            [v3.VolleyPowerMultiplier] = 1.2,
            [v3.DribbleCooldown] = 0.8,
            [v3.TeamMateFlowGain] = 20,
            [v3.HomingPass] = 3.5,
            [v3.StaminaDrainMultiplier] = 0.95,
            [v3.ShotCurveDivisor] = 4,
            [v3.ShotCurveLaunchDivisor] = 3
        }
    },
    ["Destructive Impulses"] = {
        VFXId = "RinFlowAura",
        ActivateMessage = "Curved shots with strong power, faster tackle cooldown, bonus flow on steals, and faster recovery from tackles.",
        PreVFX = noop,
        PostVFX = noop,
        Color = Color3.fromRGB(255, 45, 45),
        Stats = {
            [v3.ShotPowerMultiplier] = 1.215,
            [v3.VolleyPowerMultiplier] = 1.215,
            [v3.SlideCooldown] = 1.5,
            [v3.ShotCurveDivisor] = 2.75,
            [v3.ShotCurveLaunchDivisor] = 2,
            [v3.ShotSpeedMultiplier] = 0.9,
            [v3.StealFlowGain] = 5,
            [v3.RagdollRecoveryMultiplier] = 0.6
        }
    }
};