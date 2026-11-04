 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    AllowSelfToggle = false,
    ToggleKey = Enum.KeyCode.M,
    GamepadToggleKey = Enum.KeyCode.ButtonY,
    ToggleCooldown = 0.75,
    Diameter = 8,
    Color = Color3.fromRGB(160, 225, 255),
    Transparency = 0.55,
    Reflectance = 0.08,
    Density = 1.2,
    Friction = 0.6,
    Elasticity = 0.15,
    ElasticityWeight = 3,
    ParentToCharacter = true,
    BaseSpeed = 26,
    MaxSpeed = 100,
    ChargeTime = 4,
    ChargeDecayIdle = 0.7,
    ChargeDecayBrake = 1.4,
    ChargeMinInput = 0.75,
    HardCap = 160,
    GroundAccel = 140,
    BrakeAccel = 240,
    TurnAccel = 220,
    OverspeedDecel = 15,
    AirControl = 0.3,
    Responsiveness = 8,
    CoastDrag = 0.6,
    FrozenBrake = 6,
    DashKey = Enum.KeyCode.F,
    GamepadDashKey = Enum.KeyCode.ButtonL3,
    DashChargeTime = 0.8,
    DashMinSpeed = 70,
    DashMaxSpeed = 150,
    DashCooldown = 2.5,
    DashChargeBrake = 1.5,
    DashColor = Color3.fromRGB(255, 205, 100),
    JumpVelocity = 62,
    JumpCooldown = 0.3,
    JumpBuffer = 0.15,
    CoyoteTime = 0.12,
    ClashMargin = 1.25,
    ClashLagMargin = 8,
    PredictMargin = 0.6,
    PredictWindow = 0.6,
    ClashMinClosing = 32,
    ClashCooldown = 0.4,
    ClashBase = 20,
    ClashScale = 0.75,
    ClashMax = 130,
    ClashKnockMax = 140,
    ClashUp = 0.25,
    ClashEvenBand = 0.1,
    ClashWinnerFloor = 0.2,
    ClashLoserGain = 0.9,
    ClashShareExponent = 1.5,
    ClashWinnerKeep = 0.9,
    ClashWinnerStagger = 0.12,
    ClashLoserKeep = 0.35,
    ClashLoserStagger = 0.45,
    ClashEvenKeep = 0.6,
    ClashEvenStagger = 0.3,
    ClashNoExitTime = 0.5,
    VelocityHistory = 14,
    ContactReportCooldown = 0.15,
    ContactRateLimit = 10,
    ContactTolerance = 5,
    ContactSlack = 1,
    ContactMaxRewind = 0.6,
    TrailSamples = 45,
    PassThroughPlayers = false,
    ConvertWalkers = false,
    NoCollideGroups = { "DashCollide" },
    KnockReach = 2.5,
    KnockMinSpeed = 20,
    RunOverSpeed = 30,
    KnockTripSpeed = 45,
    KnockBase = 15,
    KnockScale = 0.9,
    KnockMax = 150,
    KnockCooldown = 0.6,
    KnockDownTime = 0.8,
    KnockMarbleKeep = 0.85,
    ExitKnockGrace = 0.6,
    ImpactLoss = 55,
    ImpactChargeKeep = 0.5,
    ImpactRateLimit = 4,
    HolderSpeedScale = 0.88,
    PickupMargin = 1,
    BallRadius = 0.975,
    StuckBallInset = 0.55,
    StealTouchMargin = 1.25,
    PossessionGrace = 0.2,
    StealBuffer = 0.25,
    TagBackLockout = 0.25,
    TagBackLockoutMax = 0.8,
    KickoffWindow = 2,
    RepickupLockout = 0.8,
    FumbleIntensity = 0.5,
    FumbleFullIntensity = 0.72,
    FumbleLaunchSpeed = 130,
    FumbleLaunchSpeedMax = 190,
    FumbleLaunchUp = 80,
    FumbleLaunchUpMax = 105,
    FumbleWallBias = 0.5,
    FumbleMaxAngle = 35,
    FumbleWallReach = 16,
    FumbleLockout = 1.2,
    BaseFov = 70,
    MaxFov = 88,
    CameraMinZoom = 14,
    TrailMinSpeed = 45,
    StreamAheadSpeed = 60,
    BallParkHeight = 500,
    BallCameraMinZoom = 4,
    CanEnter = nil,
    Tag = "Marble",
    MarbleGroup = "Marble",
    RiderGroup = "MarbleRider",
    WalkerGroup = "MarbleWalker",
    PassGroup = "MarblePass",
    MaxClientPosError = 10,
    Sounds = {
        Roll = "rbxassetid://9125751386",
        Wind = "rbxasset://sounds/action_falling.mp3",
        Clink = "rbxassetid://9119938301",
        Clash = "rbxasset://sounds/collide.wav",
        Impact = "rbxasset://sounds/hit.wav",
        Enter = "rbxassetid://137273815815490",
        Exit = "rbxassetid://137273815815490",
        Jump = "rbxasset://sounds/action_jump.mp3",
        Dash = "rbxassetid://9119467149"
    },

    PassParts = function() -- Line: 177, Name: PassParts
        local map = workspace:FindFirstChild("map");

        if not map then
            return {};
        end;

        local v1 = {};
        local gkbarriar = map:FindFirstChild("gkbarriar");

        if gkbarriar then
            table.insert(v1, gkbarriar);
        end;

        for _, v in { "gm1", "gm2" } do
            local v2 = map:FindFirstChild(v);

            if v2 then
                v2 = v2:FindFirstChild("Frame");
            end;

            if v2 then
                table.insert(v1, v2);
            end;
        end;

        return v1;
    end,

    IsFrozen = function(p3: userdata) -- Line: 199, Name: IsFrozen
        -- upvalues: ReplicatedStorage (copy)
        if p3:GetAttribute("frozen") then
            return true;
        end;

        local workspace2 = ReplicatedStorage:FindFirstChild("workspace");

        if not workspace2 then
            return false;
        end;

        for _, v in { "disabled", "checkgoal" } do
            local v4 = workspace2:FindFirstChild(v);

            if v4 and (v4:IsA("BoolValue") and v4.Value) then
                return true;
            end;
        end;

        return false;
    end,

    BallTemplate = function() -- Line: 217, Name: BallTemplate
        -- upvalues: ReplicatedStorage (copy)
        local Resources = ReplicatedStorage:FindFirstChild("Resources");

        if Resources then
            Resources = Resources:FindFirstChild("Ball");
        end;

        if Resources and Resources:IsA("BasePart") then
            return Resources;
        end;

        return nil;
    end
};