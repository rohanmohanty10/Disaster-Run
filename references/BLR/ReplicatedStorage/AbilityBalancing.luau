  

if script.Parent ~= game:GetService("ReplicatedStorage") then
    error("required the static flow balancing module. require the one in ReplicatedStorage");
end;

return {
    SnuffyAwakening = {
        Duration = 9,
        BallRange = 75
    },
    SnuffyRationalPerfectDefense = {
        Cooldown = 30,
        Duration = 4,
        BallRange = 75
    },
    SnuffyPhoenixIntercept = {
        Cooldown = 30,
        Duration = 9.7,
        BallRange = 75,
        PassRange = 200,
        PassSpeed = 180
    },
    SnuffyRebellion = {
        Cooldown = 120,
        Duration = 10,
        ArmWindow = 4.25,
        EnemyRange = 15,
        GoalBoxRange = 15
    },
    DragonicVolley = {
        Cooldown = 40,
        JumpHeight = 100,
        ActivationRangePlayer = 125,
        ShotPower = 185,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    DragonDrive = {
        Cooldown = 40,
        JumpHeight = 110,
        ActivationRangePlayer = 125,
        ShotPower = 180,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    DragonHeader = {
        Cooldown = 40,
        JumpHeight = 50,
        ActivationRangePlayer = 125,
        ShotPower = 175,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    FastShot = {
        Cooldown = 30,
        ShotPower = 190,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    BearClaw = {
        Cooldown = 70
    },
    SuperReflexes = {
        Cooldown = 90,
        PassRange = 330,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    Basilisk = {
        Cooldown = 50,
        ShotPower = 80,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        ActivationRangePlayer = 230,
        ShotDuration = 3,
        ActivationRangeBall = 80
    },
    Cobra = {
        Cooldown = 30,
        ActivationRangePlayer = 25
    },
    Viper = {
        Cooldown = 100,
        ShotPower = 260,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        ActivationRangeBall = 25
    },
    DirectShot = {
        Cooldown = 35,
        ShotPower = 135,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    Fadeaway = {
        Cooldown = 30,
        ActivationRangePlayer = 16
    },
    FinalShot = {
        Cooldown = 70,
        ShotTiltVector = Vector3.new(0, 0.2, 0),
        ShotPower = 168.75
    },
    ExplosiveAcceleration = {
        Cooldown = 37,
        MoveSpeedValue = 130,
        StaminaUsage = 10
    },
    NoBreakDribble = {
        Cooldown = 25,
        MoveSpeedValue = 150,
        StaminaUsage = 10
    },
    SwiftIntercept = {
        Cooldown = 40,
        JumpHeight = 100
    },
    VelocityDash = {
        Cooldown = 0.8,
        MoveSpeedValue = 80,
        StaminaUsage = 0
    },
    VelocityShot = {
        Cooldown = 35,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        ShotPower = 140,
        ShotPowerMax = 180
    },
    ChopFeint = {
        Cooldown = 30,
        TravelDistance = 60,
        FeintDistance = 10
    },
    LionSteal = {
        Cooldown = 40,
        ActivationRangePlayer = 16,
        TravelDistance = 60
    },
    Camouflage = {
        TravelDistance = 19
    },
    CloseQuartersDribble = {
        TravelDistance = 50
    },
    CrossElasticoNutmeg = {
        TravelDistance = 40,
        ActivationRangePlayer = 16,
        Cooldown = 30
    },
    OppositeDirection = {
        TravelDistance = 40,
        ActivationRangePlayer = 16,
        Cooldown = 30
    },
    Trivela = {
        ShotPower = 130
    },
    ChameleonDefense = {
        ActivationRangeBall = 60,
        Cooldown = 40
    },
    ReoSerpentRedirect = {
        Cooldown = 58,
        ShotPower = 140,
        ShotTiltVector = Vector3.new(0, 0.12, 0)
    },
    ReoTapLift = {
        Cooldown = 55,
        ShotPower = 173,
        ShotTiltVector = Vector3.new(0, 0.13, 0)
    },
    ReoGyroShot = {
        Cooldown = 55,
        ShotPower = 189.75,
        ShotTiltVector = Vector3.new(0, 0.13, 0)
    },
    ReoDragonDrive = {
        Cooldown = 56,
        ShotPower = 157.5,
        ShotTiltVector = Vector3.new(0, 0.13, 0)
    },
    ZeroResetTurn = {
        Cooldown = 35,
        Distance = 63,
        ActivationRangePlayer = 30
    },
    DirectHeelLift = {
        Cooldown = 35,
        Distance = 60,
        ActivationRangePlayer = 30,
        ShotPower = 160,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    Reverse2Stage = {
        TravelDistance = 100,
        Duration = 0.9
    },
    Reverse2StageShot = {
        TravelDistance = 40,
        Duration = 0.5
    },
    TrapDance = {
        ActivationRangeBall = 45,
        TravelDistance = 70,
        ShotPower = 135
    },
    JugglingShot = {
        TravelDistance = 40,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        ShotLockedToCharacter = true,
        ShotPower = 155,
        MaxUses = 2
    },
    Trap = {
        Height = 25,
        ForwardsDistance = 10
    },
    TrapShot = {
        ShotPower = 135,
        ShotHeight = 20,
        Visualiser_FloorOffset = Vector3.new(0, 25, 0)
    },
    SideTrapShot = {
        DashDistance = 50,
        ShotPower = 130,
        ShotHeight = 20,
        Visualiser_FloorOffset = Vector3.new(0, 25, 0)
    },
    SpaceShot = {
        ShotPower = 200
    },
    NELNagiTapLift = {
        ShotPower = 190
    },
    DeathDance = {
        ShotPower = 190
    },
    FiveStageVolley = {
        Cooldown = 70,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    TwoStageVolley = {
        Cooldown = 70,
        ShotPower = 171,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    PerfectPass = {
        PassRange = 200
    },
    CreativeDribble = {
        TravelDistance = 25,
        ActivationRangePlayer = 24
    },
    OcclusionBreak = {
        Cooldown = 60,
        TravelDistance = 35
    },
    DemonDrive = {
        Speed = 150
    },
    DemonicRush = {
        Speed = 80
    },
    UnstoppableDemonHeader = {
        Cooldown = 80,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        PenBoxRange = 100,
        MinBallHeight = 5
    },
    UnstoppableDemonShot = {
        Cooldown = 80,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        PenBoxRange = 100
    },
    ShidouXCharlesCR = {
        Cooldown = 120,
        BallCloseRange = 60,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    BigBang = {
        Cooldown = 70,
        ShotPower = 184,
        ShotTiltVector = Vector3.new(0, 0.25, 0)
    },
    DragonDriveCR = {
        Cooldown = 120,
        MinPassDistance = 85,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    Kablamo = {
        ShotPower = 145,
        ShotHeight = 25
    },
    OffBalance = {
        ActivationRangePlayer = 15,
        ShotPower = 120,
        TravelDistance = 20
    },
    ShoulderPush = {
        Cooldown = 40,
        EnemyRange = 25
    },
    Surpass = {
        Cooldown = 70,
        ShotPower = 180,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    DivineLift = {
        TravelDistance = 50
    },
    ContrarianDribble = {
        Cooldown = 40,
        TravelDistance = 35,
        ActivationRangePlayer = 14
    },
    ContrarianDefense = {
        Cooldown = 60,
        TravelDistance = 35
    },
    DartboardLens = {
        Cooldown = 60,
        MoveSpeedValue = 10
    },
    RabonaCross = {
        Cooldown = 80,
        ShotPower = 180
    },
    TheFinalBoss = {
        Cooldown = 80,
        ActivationRangePlayer = 50
    },
    LokiXCharles = {
        ShotPower = 180
    },
    SkyArcPass = {
        Cooldown = 30
    },
    StreetSweep = {
        TravelDistance = 40
    },
    LaBoba = {
        TravelDistance = 70,
        FeintDistance = 25
    },
    GyroShot = {
        ShotPower = 150
    },
    BunnyHop = {
        Cooldown = 30,
        MoveSpeedValue = 70,
        MoveSpeedDuration = 2
    },
    ScissorKick = {
        Cooldown = 30,
        ShotPower = 140,
        Visualiser_FloorOffset = Vector3.new(0, 25, 0)
    },
    LobPass = {
        Cooldown = 30,
        ActivationRangePlayer = 180
    },
    EnterStriker = {
        Cooldown = 80,
        ShotPower = 220
    },
    RabbitTrap = {
        Cooldown = 30,
        Duration = 1.75
    },
    HareInTheAir = {
        Cooldown = 80,
        ActivationRangeBall = 75,
        ShotPower = 270
    },
    CrownHopper = {
        Cooldown = 30,
        MoveSpeedValue = 90
    },
    ButterflyCounter = {
        DashDistance = 45,
        Duration = 1.14
    },
    RisingDance = {
        TravelDistance = 45
    },
    ButterflyDribble = {
        TravelDistance = 55
    },
    GingaShot = {
        ShotPower = 155
    },
    GingaStyle = {
        MoveSpeedValue = 45
    },
    Territory = {
        ActivationRangeBall = 200,
        StunDuration = 0.6,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        ShotPower = 180
    },
    SixthSense = {
        Duration = 30,
        Cooldown = 80
    },
    Ambush = {
        ActivationRangePlayer = 37,
        Cooldown = 50
    },
    Periscope = {
        Cooldown = 40,
        ActivationRangeBall = 10,
        ShotPower = 100,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    SlitherStep = {
        Cooldown = 30,
        Stamina = 10,
        MoveSpeedValue = 90,
        MoveSpeedDuration = 0.7
    },
    SnakeClear = {
        Cooldown = 50,
        ShotPower = 120
    },
    InfiniteDribbles = {
        Cooldown = 60,
        Duration = 5,
        MoveSpeedValue = 20
    },
    MonsterTrance = {
        ActivationRangePlayer = 25,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.2, 0),
        Cooldown = 100
    },
    Nutmeg = {
        Cooldown = 25,
        ActivationRangePlayer = 15,
        Stamina = 10,
        MoveSpeedValue = 5,
        MoveSpeedDuration = 1
    },
    Scissors = {
        Cooldown = 45,
        ActivationRangePlayer = 27,
        Stamina = 10
    },
    BachiraSteal = {
        Cooldown = 30,
        Stamina = 10,
        MoveSpeedValue = 5,
        MoveSpeedDuration = 2,
        ShotTiltVector = Vector3.new(0, 0.55, 0),
        ShotPower = 80
    },
    BachiraStealOff = {
        Cooldown = 30,
        Stamina = 10,
        MoveSpeedValue = 90
    },
    HighSpeedSpeedster = {
        Cooldown = 49,
        Stamina = 20,
        MoveSpeedValue = 17,
        MoveSpeedDuration = 4.5
    },
    Speedster = {
        Cooldown = 70,
        Stamina = 20,
        MoveSpeedValue = 15,
        MoveSpeedDuration = 6
    },
    GoldenDefense = {
        Cooldown = 30,
        MoveSpeedValue = 145
    },
    ZombieCounterAttack = {
        Cooldown = 120,
        ActivationRangeBall = 45,
        ShotPower = 190,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    ZombieDash = {
        Cooldown = 35,
        MoveSpeedValue = 96,
        MoveSpeedDuration = 0.75,
        ShotTiltVector = Vector3.new(0, 0.4, 0),
        ShotPower = 95
    },
    ZombieDashOff = {
        MoveSpeedValue = 82,
        MoveSpeedDuration = 0.75
    },
    ZombieDribble = {
        Cooldown = 40,
        MoveSpeedValue = 86
    },
    DivingHeader = {
        Cooldown = 50,
        MoveSpeedValue = 12,
        ActivationRangePlayer = 30
    },
    Handstand = {
        Cooldown = 70
    },
    FlowPass = {
        Cooldown = 40,
        ActivationRangePlayer = 24,
        PassRange = 150
    },
    Laser = {
        Cooldown = 25,
        PassRange = 150
    },
    DharmaChains = {
        ActivationRangePlayer = 50,
        Cooldown = 90
    },
    GeniusKillingMalicia = {
        ActivationRangePlayer = 30,
        Cooldown = 90
    },
    MonkPass = {
        ActivationRangePlayer = 100,
        Cooldown = 40
    },
    DirectPass = {
        Cooldown = 20
    },
    MaliciaGround = {
        ActivationRangePlayer = 20
    },
    MaliciaAir = {
        MoveSpeedValue = 120,
        MoveSpeedDuration = 0.5
    },
    NELDirectShot = {
        Cooldown = 35,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    NELDirectPass = {
        PassTime = 0.7,
        PassSpeed = 1.65
    },
    LeftyShot = {
        ShotPower = 180,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    KaiserCRShot = {
        ActivationRangeBall = 50,
        ShotPower = 300,
        ShotTiltVector = Vector3.new(0, 0.05, 0),
        ShotDuration = 1.5
    },
    Beinschuss = {
        Cooldown = 50,
        ActivationRangePlayer = 40,
        MoveSpeedValue = 35,
        MoveSpeedDuration = 0.25,
        ShotPower = 210,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    KaiserDribble = {
        ActivationRangePlayer = 27,
        Cooldown = 60,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.16, 0)
    },
    KaiserDribbleULT = {
        ActivationRangePlayer = 27,
        Cooldown = 60,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.16, 0)
    },
    KaiserImpact = {
        Cooldown = 45,
        MoveSpeedValue = 35,
        MoveSpeedDuration = 0.25,
        ShotPower = 205,
        ShotTiltVector = Vector3.new(0, 0.05, 0),
        ShotDuration = 0.5
    },
    KaiserVolley = {
        Cooldown = 60,
        ActivationRangePlayer = 30,
        MoveSpeedValue = 35,
        MoveSpeedDuration = 0.25,
        ShotPower = 150,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    Magnus = {
        Cooldown = 50,
        ShotPower = 290,
        ShotTiltVector = Vector3.new(0, 0.13, 0)
    },
    CrowClearance = {
        ActivationRangeBall = 45,
        Cooldown = 40
    },
    CrowTheft = {
        MoveSpeedValue = 20,
        Cooldown = 80
    },
    RavenDribble = {
        Cooldown = 40
    },
    PredatorShot = {
        ShotPower = 160,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    Devour = {
        ActivationRangeBall = 50,
        Cooldown = 80,
        ShotPower = 185,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    PowerShot = {
        ShotPower = 150,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    AirDribble = {
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.35, 0),
        Visualiser_FloorOffset = Vector3.new(0, 20, 0)
    },
    ZombieSteal = {
        Cooldown = 35,
        DashDistance = 40,
        ShotPower = 90,
        ShotTiltVector = Vector3.new(0, 0.5, 0)
    },
    ScytheSlam = {
        ActivationRangePlayer = 17,
        TravelDistance = 40
    },
    Graveyard = {
        MoveSpeedValue = 6,
        Duration = 15
    },
    ReaperTurn = {
        ActivationRangePlayer = 35
    },
    DemonHeader = {
        Cooldown = 50,
        ShotPower = 170,
        ShotDuration = 1,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    DemonicDribble = {
        Cooldown = 40,
        MoveSpeedValue = 70,
        MoveSpeedDuration = 0.9
    },
    DemonicShot = {
        Cooldown = 40,
        ShotPower = 150,
        ShotTiltVector = Vector3.new(0, 0.25, 0)
    },
    DeathsCall = {
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    DemonicOverheadKick = {
        Cooldown = 40,
        ShotPower = 140,
        ShotTiltVector = Vector3.new(0, 0.1, 0),
        MoveSpeedDuration = 0.23
    },
    Bloodlust = {
        MoveSpeedValue = 20,
        Cooldown = 30,
        Duration = 6
    },
    Feast = {
        ActivationRangeBall = 80,
        Cooldown = 70,
        ShotPower = 98,
        ShotTiltVector = Vector3.new(0, 0.13, 0)
    },
    InfernoDragonDrive = {
        ShotPower = 230,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    ExecutionShot = {
        ShotPower = 220
    },
    Accelerate = {
        Cooldown = 30
    },
    Tireless = {
        Cooldown = 100
    },
    Blast = {
        Cooldown = 100
    },
    DeathOfStriker = {
        ActivationRangePlayer = 15,
        Cooldown = 75,
        ShotPower = 80,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    UndeadMode = {
        Cooldown = 60,
        MoveSpeedValue = 20
    },
    YoMichael = {
        Cooldown = 80,
        ActivationRangeBall = 50,
        ServerActivationRangeBall = 40,
        CutsceneLength = 1.7,
        KaiserCutsceneLength = 15.25
    },
    Scorpion = {
        Cooldown = 60,
        ShotPower = 100
    },
    Curved = {
        Cooldown = 70
    },
    CrescentShot = {
        Cooldown = 35,
        ShotPower = 150
    },
    BloodDribble = {
        Cooldown = 35,
        MoveSpeedValue = 120,
        TravelDistance = 60
    },
    LunarAxis = {
        Cooldown = 35,
        ActivationRangePlayer = 10,
        TravelDistance = 15
    },
    PhysicalPressure = {
        Cooldown = 35,
        ActivationRangePlayer = 10,
        TravelDistance = 15
    },
    CrowElusion = {
        Cooldown = 35,
        ActivationRangePlayer = 20,
        TravelDistance = 70
    },
    Loser = {
        Cooldown = 50
    },
    PhantomDirectShot = {
        Cooldown = 35,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    SkullRoulette = {
        Cooldown = 35,
        ShotPower = 170,
        TravelDistance = 20
    },
    ScarletOrbit = {
        Cooldown = 80,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    CrimsonEclipse = {
        Cooldown = 50
    },
    PhantomStep = {
        Cooldown = 45,
        MoveSpeedValue = 70,
        MoveSpeedDuration = 0.8,
        ActivationRangePlayer = 30
    },
    PhantomDribble = {
        Cooldown = 50,
        MoveSpeedValue = 60,
        MoveSpeedDuration = 0.4,
        ActivationRangePlayer = 30
    },
    PhantomIllusion = {
        Cooldown = 40
    },
    BonesFlick = {
        Cooldown = 50,
        TravelDistance = 40
    },
    GiveMeBall = {
        Cooldown = 80,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    SkullShot = {
        ShotPower = 145,
        ShotTiltVector = Vector3.new(0, 0.05, 0),
        Visualiser_FloorOffset = Vector3.new(0, 30, 0),
        Cooldown = 40
    },
    HungrySkull = {
        Cooldown = 70
    },
    SkeletonImprisonment = {
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.15, 0),
        Cooldown = 70
    },
    SkeletonTrap = {
        Cooldown = 40,
        Height = 30,
        ForwardsDistance = 15
    },
    SnakeVision = {
        Cooldown = 35,
        Duration = 10
    },
    TotalClearance = {
        Cooldown = 40,
        TravelDistance = 32,
        ActivationRangePlayer = 30
    },
    SerpentWall = {
        Cooldown = 70,
        ShotPower = 95,
        ShotTiltVector = Vector3.new(0, 0.18, 0),
        ActivationRangePlayer = 230,
        ShotDuration = 3,
        ActivationRangeBall = 80
    },
    AikuSelfishCaptain = {
        Cooldown = 120,
        Duration = 13.433333333333334,
        ArrivalRange = 22,
        PressWindow = 1.5,
        PassLifetime = 4.25,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0, 0)
    },
    AikuVenomClearance = {
        Cooldown = 80,
        Duration = 8.016666666666667,
        EnemyRange = 25,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    AikuCrushingBloom = {
        Cooldown = 60,
        Duration = 6.666666666666667,
        EnemyRange = 25
    },
    Aiku100Clearance = {
        Cooldown = 80
    },
    SnakeInterception = {
        Cooldown = 45,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.1, 0),
        Height = 20,
        ForwardsDistance = 20
    },
    BeeFlick = {
        Cooldown = 35,
        TravelDistance = 45
    },
    Rouelette = {
        Cooldown = 35
    },
    MonsterShot = {
        Cooldown = 35,
        ShotPower = 135,
        ShotTiltVector = Vector3.new(0, 0.25, 0)
    },
    HeelCenter = {
        Cooldown = 45,
        ActivationRangePlayer = 150
    },
    MonsterTranceNew = {
        Cooldown = 70,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    ButterflyRoulette = {
        Cooldown = 50,
        ActivationRangePlayer = 14,
        TravelDistance = 95
    },
    ButterflyLift = {
        Cooldown = 40,
        ShotPower = 60,
        TravelDistance = 55,
        ShotTiltVector = Vector3.new(0, 0.65, 0),
        MoveSpeedValue = 7
    },
    StingerShot = {
        Cooldown = 35,
        ShotPower = 135,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    ScissorShot = {
        Cooldown = 35,
        ShotPower = 140,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    ScissorKicks = {
        Cooldown = 40
    },
    GingaMonsterNew = {
        Cooldown = 70
    },
    BeeFreestyle = {
        Cooldown = 70,
        ShotPower = 255,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    BachiraXLavinho = {
        Cooldown = 0,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    SubzeroXGBCharles = {
        Cooldown = 0,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    ElfImpact = {
        Cooldown = 35,
        ShotPower = 180
    },
    ElfVolley = {
        Cooldown = 35,
        Distance = 45,
        ActivationRangePlayer = 15,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.25, 0)
    },
    ElfDribble = {
        Cooldown = 35,
        Distance = 33,
        ActivationRangePlayer = 30
    },
    HelperDribble = {
        Cooldown = 45
    },
    EmperorsCatapult = {
        Cooldown = 45,
        StealRange = 45
    },
    Elfschuss = {
        Cooldown = 70,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    KrampusChopDribble = {
        Cooldown = 35,
        Distance = 60
    },
    BlizzardFangShot = {
        Cooldown = 35,
        ShotPower = 170
    },
    CrashSteal = {
        ActivationRangeBall = 60,
        Distance = 60,
        Cooldown = 35
    },
    PredatorKrampus = {
        Cooldown = 35,
        Duration = 10
    },
    KrampusGreed = {
        Cooldown = 45,
        StealRange = 45
    },
    KrampusStrike = {
        Cooldown = 70,
        ShotPower = 210,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    CookieDefense = {
        Cooldown = 45,
        StealRange = 55
    },
    MonsterBlast = {
        Cooldown = 70,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    GingerbreadDribble = {
        Cooldown = 40,
        ActivationRangePlayer = 14,
        Distance = 95
    },
    CookieStep = {
        Cooldown = 40,
        Distance = 45,
        ActivationRangePlayer = 10
    },
    CookieCross = {
        Cooldown = 15,
        ActivationRangePlayer = 100
    },
    GingerbreadCannon = {
        Cooldown = 35,
        ActivationRangePlayer = 350
    },
    GodspeedFreeze = {
        Cooldown = 45,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.1, 0),
        Height = 20,
        ForwardsDistance = 20
    },
    FrostAcceleration = {
        Cooldown = 40,
        MoveSpeedValue = 130,
        StaminaUsage = 20
    },
    FrostShot = {
        Cooldown = 40,
        ShotPower = 160,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    TheTunnel = {
        Cooldown = 70,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    SledDefense = {
        Cooldown = 70,
        StealRange = 70
    },
    FrostCounter = {
        Cooldown = 45,
        DashDistance = 50,
        Duration = 2
    },
    WrappedDribble = {
        Cooldown = 30,
        TravelDistance = 50
    },
    PresentStrike = {
        Cooldown = 30,
        ShotPower = 180,
        ShotTiltVector = Vector3.new(0, 0.2, 0),
        ExtraEndlag = 0.3
    },
    ClauseClashShot = {
        Cooldown = 70,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    SleighRide = {
        Cooldown = 35,
        MoveSpeedValue = 60
    },
    ChristmasStampede = {
        Cooldown = 60,
        ActivationRangeBall = 60,
        Distance = 45,
        MoveSpeedValue = 50
    },
    YetiDefense = {
        Cooldown = 70,
        StealRange = 70
    },
    ExplosiveDribbling = {
        Cooldown = 45,
        TravelDistance = 57
    },
    FlashyShot = {
        Cooldown = 45,
        ShotPower = 176,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    RocketPass = {
        Cooldown = 35,
        ActivationRangePlayer = 315
    },
    IllusiveFireworks = {
        Cooldown = 45,
        MoveSpeedValue = 5,
        MoveSpeedDuration = 0.1
    },
    FireworkRain = {
        Cooldown = 70,
        StealRange = 65
    },
    FireworkBachiraXSantaLavinho = {
        Cooldown = 60,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    ExplosiveMonster = {
        Cooldown = 70,
        ShotPower = 215,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 40
    },
    BaitDribble = {
        Cooldown = 40,
        ActivationRangePlayer = 14,
        TravelDistance = 45
    },
    PlanetHotline = {
        Cooldown = 70,
        ShotPower = 140,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Range = 60
    },
    MagicDribble = {
        Cooldown = 40,
        ActivationRangePlayer = 14,
        TravelDistance = 32
    },
    ColdLogicTurn = {
        Cooldown = 40,
        ActivationRangePlayer = 14,
        TravelDistance = 32
    },
    MagicPass = {
        Cooldown = 40,
        ActivationRangePlayer = 75,
        TravelDistance = 32
    },
    LinkPass = {
        Cooldown = 40,
        ActivationRangePlayer = 95,
        TravelDistance = 32
    },
    BelowZeroPass = {
        Cooldown = 40,
        ActivationRangePlayer = 120,
        TravelDistance = 32
    },
    IllusionCross = {
        Cooldown = 30,
        ActivationRangePlayer = 150
    },
    WeaponDisabler = {
        ActivationRangePlayer = 15,
        ShotPower = 120,
        TravelDistance = 20,
        Cooldown = 40
    },
    ANewSpell = {
        Cooldown = 70,
        PassRange = 250,
        BallRange = 60,
        BallAirHeight = 23
    },
    KaiserXNess = {
        Cooldown = 60,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.15, 0)
    },
    DestroyersDribble = {
        Cooldown = 60,
        EnemyRange = 40
    },
    CurvedFlow = {
        Cooldown = 70,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        EnemyRange = 20
    },
    CenterOfGravity = {
        Cooldown = 25,
        EnemyRange = 15,
        CutsceneLength = 9.75,
        MaxUsesPerAwakening = 2
    },
    KillShot = {
        Cooldown = 70,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        CurveAcceleration = 42,
        CurveDuration = 1.1
    },
    TwoStepsBehind = {
        Cooldown = 0,
        EnemyRange = 60,
        TeammateRange = 300,
        ShotPower = 190,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    TwoStepsBehindShot = {
        Cooldown = 30,
        ShotPower = 190,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    NoFear = {
        Cooldown = 90,
        ShotPower = 220,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        TeammateRange = 150
    },
    EgoStoppage = {
        ShotPower = 120,
        ShotTiltVector = Vector3.new(0, 0.25, 0),
        Cooldown = 80,
        EnemyRange = 42.5,
        ShotDetectDuration = 7
    },
    PredatorBreak = {
        Cooldown = 45,
        Distance = 60
    },
    ShadowBreak = {
        Cooldown = 30,
        Distance = 60,
        ActivationRangePlayer = 100
    },
    DestroyerMode = {
        Cooldown = 60,
        Duration = 8
    },
    OppressivePass = {
        Cooldown = 35,
        ActivationRangePlayer = 105,
        TravelDistance = 32
    },
    VictoryPass = {
        Cooldown = 35,
        ActivationRangePlayer = 100,
        TravelDistance = 32
    },
    Stoppage = {
        Cooldown = 40,
        ActivationRangePlayer = 20,
        MoveSpeedValue = 10
    },
    ForcedDefense = {
        Cooldown = 40,
        ActivationRangePlayer = 20
    },
    Disruption = {
        Cooldown = 55,
        ActivationRangePlayer = 20
    },
    MatchupVictory = {
        Cooldown = 40,
        ActivationRangePlayer = 190,
        TravelDistance = 32
    },
    CrowDeflect = {
        Cooldown = 40,
        JumpHeight = 100,
        ActivationRangePlayer = 125
    },
    RavenAwaken = {
        Cooldown = 90
    },
    MiroChopDribble = {
        Cooldown = 40,
        Distance = 60
    },
    KnuckleBall = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    SkyLeap = {
        Cooldown = 40,
        JumpHeight = 100,
        ActivationRangePlayer = 125,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    CrushingHeader = {
        Cooldown = 32,
        JumpHeight = 100,
        ActivationRangePlayer = 125,
        ShotPower = 145,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    AbsoluteZeroDefense = {
        Cooldown = 32,
        JumpHeight = 100,
        ActivationRangePlayer = 125,
        ShotPower = 145,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    HardFreezeCounter = {
        Cooldown = 30,
        BallRange = 40,
        PassRange = 300
    },
    PermaFrostDefense = {
        Cooldown = 35,
        Range = 125,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.7, 0)
    },
    MiracleBicycle = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    ParkourShot = {
        Cooldown = 40,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    SneakyVolley = {
        Cooldown = 40,
        ShotPower = 175,
        Distance = 25,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    Dynamo = {
        Cooldown = 27,
        ShotPower = 185,
        ActivationRangePlayer = 90,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    BunnyHopTrap = {
        Cooldown = 40,
        ShotPower = 135,
        ShotHeight = 20
    },
    EggShuffle = {
        Cooldown = 40,
        Distance = 70
    },
    MatchCutIn = {
        Cooldown = 40,
        Distance = 80
    },
    HatSteal = {
        MoveSpeedValue = 20,
        Cooldown = 30,
        Duration = 3,
        Distance = 40
    },
    CarrotGrab = {
        Cooldown = 70,
        BallRange = 90
    },
    EasterTikiTaka = {
        Cooldown = 45
    },
    DecoyStriker = {
        Cooldown = 45
    },
    SkullTrap = {
        Cooldown = 40,
        ShotPower = 170,
        ShotHeight = 20,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    EffortlessMiracle = {
        Cooldown = 30,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    SideStepDribble = {
        Cooldown = 40,
        Distance = 60
    },
    TwoGunVolley = {
        Cooldown = 70,
        ShotPower = 280,
        ShotTiltVector = Vector3.new(0, 0.12, 0)
    },
    MetaBurstPoint = {
        Cooldown = 40
    },
    VisionStoppage = {
        Cooldown = 40,
        JumpHeight = 100,
        ActivationRangePlayer = 125,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    AdaptiveWin = {
        Cooldown = 70,
        ShotPower = 190,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    ShinobiStrike = {
        Cooldown = 70,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    ["44PantherShot"] = {
        Cooldown = 70,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    DarkHorse = {
        Cooldown = 40,
        StealRange = 60
    },
    JokerShot = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.18, 0)
    },
    ElasticNutmeg = {
        Cooldown = 40
    },
    MetaDefense = {
        Cooldown = 36,
        EnemyRange = 60
    },
    CloseQuarterDribble = {
        Cooldown = 30,
        TravelDistance = 50
    },
    ChameleonVolley = {
        Cooldown = 53.5,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.12, 0),
        EnemyRange = 60
    },
    BackspinAcceleratingShot = {
        Cooldown = 35,
        ShotPower = 145,
        ActivationRangePlayer = 100
    },
    TwisterPass = {
        Cooldown = 40,
        ActivationRangePlayer = 150,
        TravelDistance = 45
    },
    Borderline = {
        Cooldown = 70,
        BallRange = 70,
        PassRange = 270
    },
    DemonShot = {
        Cooldown = 35,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.25, 0)
    },
    MagicianMirage = {
        Cooldown = 40,
        Distance = 60
    },
    MirrorShield = {
        Cooldown = 40,
        ActivationRangePlayer = 200
    },
    CurveShot = {
        Cooldown = 40,
        ShotPower = 150,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    DribbleZone = {
        Cooldown = 40
    },
    LionShot = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    StealthKillShot = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    DoubleNutmeg = {
        Cooldown = 40,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    NELChopFeint = {
        Cooldown = 30,
        TravelDistance = 60,
        FeintDistance = 10
    },
    BodyCore = {
        ActivationRangePlayer = 15,
        ShotPower = 120,
        TravelDistance = 20
    },
    TrapTower = {
        Cooldown = 60,
        MoveSpeedValue = 100
    },
    Extermination = {
        ActivationRangePlayer = 15,
        ShotPower = 120,
        TravelDistance = 60
    },
    NikoExtermination = {
        Cooldown = 80,
        GoalBoxEdgeRange = 50,
        AirborneY = 14,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.05, 0)
    },
    NikoInterceptingTrap = {
        Cooldown = 35,
        BallRange = 50
    },
    NikoCuttingEdge = {
        Cooldown = 70,
        PassRange = 270
    },
    NikoLionShot = {
        Cooldown = 30,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    RationalDefense = {
        Cooldown = 60,
        ActivationRangePlayer = 200,
        EnemyRange = 15,
        MoveSpeedValue = 130
    },
    UndeadStepPass = {
        Cooldown = 40,
        ActivationRangePlayer = 100,
        TravelDistance = 29
    },
    SendouStarStrike = {
        Cooldown = 60,
        Duration = 8.7,
        BallRange = 25,
        ShotPower = 200,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    SendouStarClear = {
        PlayerBoxRange = 20,
        Cooldown = 40,
        Duration = 5,
        ShotPower = 130,
        ShotTiltVector = Vector3.new(0, 0.35, 0)
    },
    AceShot = {
        Cooldown = 40,
        ShotPower = 170,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    LineClearance = {
        Cooldown = 40,
        MoveSpeedValue = 145
    },
    NELSnakeInterception = {
        Cooldown = 30,
        MoveSpeedValue = 80
    },
    SnakeDeflect = {
        Cooldown = 30,
        MoveSpeedValue = 120
    },
    ZantetsuLocalExpressBulletTrain = {
        Cooldown = 70,
        DashCharges = 2,
        TravelDistance = 25,
        RecastCooldown = 1.25,
        WallBackoff = 2,
        CutsceneLength = 8.766666666666667,
        ShotPower = 180,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    },
    ZantetsuExplosiveAcceleration = {
        Cooldown = 40,
        TravelDistance = 60
    },
    JetCounter = {
        Cooldown = 40,
        TravelDistance = 65
    },
    MotorCar = {
        Cooldown = 40,
        ActivationRangePlayer = 190
    },
    TerritoryShot = {
        Cooldown = 40,
        ShotPower = 160,
        ShotTiltVector = Vector3.new(0, 0.2, 0)
    },
    LeftFootedCurve = {
        Cooldown = 40,
        ShotPower = 150,
        ShotTiltVector = Vector3.new(0, 0.1, 0)
    }
};