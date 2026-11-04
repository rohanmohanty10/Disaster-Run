 

 

local SpeedScale = require(script.Parent.Parent.Movement.MovementConfig).SpeedScale;

return table.freeze({
    MaxMatchPlayers = (1 / 0),
    MinPlayers = 2,
    Countdown = 5,
    SetupTime = 2,
    FirstSetupTime = 6,
    ResultsTime = 2.5,
    PostMatchLobbyTime = 20,
    SelectionTime = 10,
    ChoiceTime = 8,
    HeroTime = 20,
    RunTime = 30,
    CleanEscapesToWin = 3,
    LateJoinAsCatcher = false,
    PlayerCollisions = false,
    Tick = 0.05,
    MapName = "Map1",
    CharacterReadyTimeout = 6,
    Tackle = table.freeze({
        Duration = 0.4,
        Recovery = 0.6,
        Cooldown = 1.1,
        DistanceMultiplier = 1.15,
        RunDistanceMultiplier = 1.45,
        BoostStrength = 0.7,
        MaxDistance = 15,
        Animation = "DaggerDive",
        Width = 3.4,
        Height = 5,
        Reach = 4,
        RunnerRadius = 0.9,
        Distance = 4 * SpeedScale,
        Variants = table.freeze({ table.freeze({
                Name = "Short Dive",
                MinSpeedRatio = 0,
                Reach = 4,
                Distance = 2 * SpeedScale
            }), table.freeze({
                Name = "Medium Dive",
                MinSpeedRatio = 0.4,
                Reach = 4.75,
                Distance = 4 * SpeedScale
            }), table.freeze({
                Name = "Long Dive",
                MinSpeedRatio = 0.8,
                Reach = 5.5,
                Distance = 7 * SpeedScale
            }) }),
        HumanBox = table.freeze({
            Width = 4,
            Height = 5,
            RunnerRadius = 1.1,
            Reach = table.freeze({
                ["Short Dive"] = 4.5,
                ["Medium Dive"] = 5.5,
                ["Long Dive"] = 6.5
            })
        })
    })
});