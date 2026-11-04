  

if script:GetAttribute("expected_children") then
    for _, v in script:GetAttribute("expected_children"):split("\255") do
        script:WaitForChild(v);
    end;
end;

return {
    Kaiser = {
        BaseC = { require(script:WaitForChild("Kaiser"):WaitForChild("KaiserImpact")), "Kaiser Impact", "KaiserImpact" },
        BaseV = { require(script:WaitForChild("Kaiser"):WaitForChild("KaiserDribble")), "Emperor\'s Dribble", "KaiserDribble" },
        BaseB = { require(script:WaitForChild("Kaiser"):WaitForChild("KaiserVolley")), "Kaiser Volley", "KaiserVolley" },
        AwkC = { require(script:WaitForChild("Kaiser"):WaitForChild("Beinschuss")), "Beinschuss", "Beinschuss" },
        AwkV = { require(script:WaitForChild("Kaiser"):WaitForChild("Magnus")), "Magnus", "Magnus" },
        AwkB = { require(script:WaitForChild("Kaiser"):WaitForChild("KaiserDribbleULT")), "Emperor\'s Dribble", "KaiserDribbleULT" }
    },
    Igaguri = {
        BaseC = { require(script.Igaguri.Malicia), "Malicia", "Malicia" },
        BaseV = { require(script.Igaguri.MonkPass), "Monk Pass", "MonkPass" },
        AwkB = { require(script.Igaguri.GeniusKillingMalicia), "Genius Killing Malicia", "GeniusKillingMalicia" },
        AwkC = { require(script.Igaguri.DharmaChains), "Dharma Chains", "DharmaChains" }
    },
    Loki = {
        BaseC = { require(script.Loki.ExplosiveAcceleration), "Explosive Acceleration", "ExplosiveAcceleration" },
        BaseV = { require(script.Loki.LokiVMove), "Velocity Dash", "LokiVMove" },
        BaseB = { require(script.Loki.SwiftIntercept), "Swift Intercept", "SwiftIntercept" },
        AwkB = {
            require(script.Loki.Awakening.ItsSlow),
            "ItsSlow",
            "ItsSlow",
            Cutscene = true
        },
        AwkC = { require(script.Loki.ExplosiveAcceleration), "Explosive Acceleration", "ExplosiveAcceleration" },
        AwkV = {
            require(script.Loki.Awakening.TooSlow),
            "Too Slow",
            "TooSlow",
            Cutscene = true
        }
    },
    ["NEL Nagi"] = {
        BaseC = { require(script["NEL Nagi"].NELNagiCMove), "Trap", "NELNagiCMove" },
        BaseV = { require(script["NEL Nagi"].ZeroResetTurn), "Zero Reset Turn", "ZeroResetTurn" },
        BaseB = { require(script["NEL Nagi"].JugglingShot), "Juggling Shot", "JugglingShot" },
        AwkC = {
            require(script["NEL Nagi"].Awakening.CAwk),
            "Death Dance",
            "DeathDance",
            Cutscene = true
        },
        AwkV = {
            require(script["NEL Nagi"].Awakening.VAwk),
            "Five Stage Volley",
            "FiveStageVolley",
            Cutscene = true
        },
        AwkB = {
            require(script["NEL Nagi"].Awakening.BAwk),
            "Tap Lift",
            "TapLift",
            Cutscene = true
        }
    },
    ["McNagi Fryshiro"] = {
        BaseC = { require(script["NEL Nagi"].NELNagiCMove), "Trap", "NELNagiCMove" },
        BaseV = { require(script["NEL Nagi"].ZeroResetTurn), "Zero Reset Turn", "ZeroResetTurn" },
        BaseB = { require(script["NEL Nagi"].JugglingShot), "Juggling Shot", "JugglingShot" },
        AwkC = {
            require(script["NEL Nagi"].Awakening.CAwk),
            "Death Dance",
            "DeathDance",
            Cutscene = true
        },
        AwkV = {
            require(script["NEL Nagi"].Awakening.VAwk),
            "Five Stage Volley",
            "FiveStageVolley",
            Cutscene = true
        },
        AwkB = {
            require(script["NEL Nagi"].Awakening.BAwk),
            "Tap Lift",
            "TapLift",
            Cutscene = true
        }
    },
    Charles = {
        BaseC = { require(script.Charles.SkyArcPass), "Sky Arc Pass", "SkyArcPass" },
        BaseV = { require(script.Charles.CharlesVMove), "Contrarian Dribble", "CharlesVMove" },
        BaseB = { require(script.Charles.CharlesBMove), "Contrarian Defense", "CharlesBMove" },
        AwkC = {
            require(script.Charles.Awakening.RabonaCross),
            "Rabona Cross",
            "RabonaCross",
            Cutscene = true
        },
        AwkV = {
            require(script.Charles.Awakening.TheFinalBoss),
            "The Final Boss",
            "TheFinalBoss",
            Cutscene = true
        },
        AwkB = { require(script.Charles.CharlesBMove), "Contrarian Defense", "CharlesBMove" }
    },
    Bunny = {
        BaseC = { require(script.Bunny.BunnyCMove), "Bunny Hop", "BunnyCMove" },
        BaseV = { require(script.Bunny.BunnyVMove), "Crown Hopper", "BunnyVMove" },
        BaseB = { require(script.Bunny.RabbitTrap), "Rabbit Trap", "RabbitTrap" },
        AwkC = {
            require(script.Bunny.EnterStriker),
            "Enter Striker",
            "EnterStriker",
            Cutscene = true
        },
        AwkB = {
            require(script.Bunny.HareInTheAir),
            "Hare In The Air",
            "HareInTheAir",
            Cutscene = true
        }
    },
    Lavinho = {
        BaseC = { require(script.Lavinho.LavinhoCMove), "Rising Dance", "LavinhoCMove" },
        BaseV = { require(script.Lavinho.LavinhoVMove), "Ginga Style", "LavinhoVMove" },
        BaseB = { require(script.Lavinho.LavinhoBMove), "Butterfly Counter", "LavinhoBMove" },
        AwkB = { require(script.Lavinho.Awakening.LavinhoBMove), "Tiki Taka", "LavinhoBMove" },
        AwkC = {
            require(script.Lavinho.Awakening.ButterflyDance),
            "Butterfly Dance",
            "ButterflyDance",
            Cutscene = true
        }
    },
    ["Reaper Sae"] = {
        BaseC = { require(script["Reaper Sae"].ReaperSaeCMove), "Scythe Pass", "ReaperSaeCMove" },
        BaseV = { require(script["Reaper Sae"].ReaperSaeVMove), "Reaper Turn", "ReaperSaeVMove" },
        BaseB = { require(script["Reaper Sae"].Graveyard), "Graveyard", "Graveyard" },
        AwkC = {
            require(script["Reaper Sae"].Awakening.ReaperStep),
            "Reaper Step",
            "ReaperStep",
            Cutscene = true
        },
        AwkV = {
            require(script["Reaper Sae"].Awakening.ExecutionShot),
            "Execution Shot",
            "ExecutionShot",
            Cutscene = true
        },
        AwkB = { require(script["Reaper Sae"].Graveyard), "Graveyard", "Graveyard" }
    },
    ["Demon Shidou"] = {
        BaseC = { require(script["Demon Shidou"].DemonShidouCMove), "Demonic Dribble", "DemonShidouCMove" },
        BaseV = { require(script["Demon Shidou"].DemonShidouVMove), "Demonic Overhead Kick", "DemonShidouVMove" },
        BaseB = { require(script["Demon Shidou"].DemonShidouBMove), "Demon Header", "DemonShidouBMove" },
        AwkC = {
            require(script["Demon Shidou"].Awakening.InfernoDragonDrive),
            "Inferno Dragon Drive",
            "InfernoDragonDrive",
            Cutscene = true
        },
        AwkV = {
            require(script["Demon Shidou"].Awakening.TheGate),
            "The Gate",
            "TheGate",
            Cutscene = true
        },
        AwkB = { require(script["Demon Shidou"].DemonShidouBMove), "Demon Header", "DemonShidouBMove" }
    },
    ["Blood Moon Rin"] = {
        BaseC = { require(script["Blood Moon Rin"].CrescentShot), "Crescent Shot", "CrescentShot" },
        BaseV = { require(script["Blood Moon Rin"].BMRinVMove), "Lunar Axis", "BMRinVMove" },
        BaseB = { require(script["Blood Moon Rin"].BloodDribble), "Blood Dribble", "BloodDribble" },
        AwkC = {
            require(script["Blood Moon Rin"].Awakening.CrimsonEclipse),
            "Crimson Eclipse",
            "CrimsonEclipse",
            Cutscene = true
        },
        AwkB = {
            require(script["Blood Moon Rin"].Awakening.ScarletOrbit),
            "Scarlet Orbit",
            "ScarletOrbit",
            Cutscene = true
        }
    },
    ["Phantom Isagi"] = {
        BaseC = { require(script["Phantom Isagi"].PhantomDirectShot), "Phantom Direct Shot", "PhantomDirectShot" },
        BaseV = { require(script["Phantom Isagi"].PIsagiVMove), "Phantom Dribble", "PIsagiVMove" },
        BaseB = { require(script["Phantom Isagi"].PhantomIllusion), "Phantom Illusion", "PhantomIllusion" },
        AwkC = {
            require(script["Phantom Isagi"].Awakening.GiveMeBall),
            "Give Me The Ball.",
            "GiveMeBall",
            Cutscene = true
        },
        AwkB = {
            require(script["Phantom Isagi"].Awakening.Loser),
            "Loser.",
            "Loser",
            Cutscene = true
        }
    },
    ["Skeleton Nagi"] = {
        BaseC = { require(script["Skeleton Nagi"].SkeletonNagiCMove), "Skeleton Trap", "SkeletonNagiCMove" },
        BaseV = { require(script["Skeleton Nagi"].BonesFlick), "Bones Flick", "BonesFlick" },
        BaseB = { require(script["Skeleton Nagi"].SkullRoulette), "Skull Roulette", "SkullRoulette" },
        AwkC = {
            require(script["Skeleton Nagi"].Awakening.SkeletonImprisonment),
            "Skeleton Imprisonment",
            "SkeletonImprisonment",
            Cutscene = true
        },
        AwkB = {
            require(script["Skeleton Nagi"].Awakening.HungrySkull),
            "Hungry Hungry Skull",
            "This Field Doesn\'t Even Matter",
            Cutscene = true
        }
    }
};