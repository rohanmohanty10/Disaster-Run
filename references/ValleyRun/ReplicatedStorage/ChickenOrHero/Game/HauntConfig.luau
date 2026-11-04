 

 

return table.freeze({
    Chance = 0.05,
    TestChance = 0.3,
    TestPlaceId = 130574217370467,
    Min = 3,
    Max = 8,
    Growth = 2,
    Cap = 20,
    Rounds = 2,
    Cooldown = 900,
    AttackDelay = 3,
    CutsceneSeconds = 3.2,
    HitsToDown = 2,
    ChaserDown = "Down",
    StrikeReach = 7.5,
    SpawnClearance = 20,
    Zombie = {
        Speed = 22,
        Aggro = 120,
        Reach = 3.4,
        Windup = 0.45,
        BiteRange = 4.8,
        Cooldown = 1.6
    },
    Skeleton = {
        Speed = 18,
        Aggro = 120,
        ThrowMin = 6,
        ThrowMax = 24,
        KeepAway = 9,
        Windup = 0.5,
        Cooldown = 2.8,
        HeadSpeed = 46,
        HeadRadius = 2.4
    },
    Sounds = table.freeze({
        Sting = { "rbxassetid://1841354543", 0.6 },
        Rise = { "rbxassetid://9125881620", 0.9 },
        ZombieGroan = { "rbxassetid://121066883602737", 0.8 },
        ZombieGroan2 = { "rbxassetid://129294628821291", 0.8 },
        ZombieGasp = { "rbxassetid://138460129900817", 0.7 },
        ZombieBite = { "rbxassetid://139746096666461", 0.9 },
        ZombieDeath = { "rbxassetid://137298984843378", 0.8 },
        SkeletonRattle = { "rbxassetid://9120921325", 0.55 },
        SkeletonThrow = { "rbxassetid://98219948033973", 0.7 },
        SkeletonBreak = { "rbxassetid://9113542694", 0.9 },
        SkeletonBreak2 = { "rbxassetid://9113546532", 0.9 },
        KillConfirm = { "rbxassetid://82803453482376", 0.6 },
        KnifeStab = { "rbxassetid://9116197517", 0.9 },
        Impact = { "rbxassetid://9113480915", 0.9 },
        Downed = { "rbxassetid://17208353912", 0.8 }
    }),
    Anims = table.freeze({
        Idle = "rbxassetid://124290622952477",
        ZombieWalk = "rbxassetid://99198240253774",
        ZombieSummon = "rbxassetid://79361541928556",
        ZombieBite = "rbxassetid://85674065679433",
        SkeletonWalk = "rbxassetid://109755481935422",
        SkeletonSummon = "rbxassetid://104284875903303",
        SkeletonThrow = "rbxassetid://87754583201194"
    })
});