 

 

return table.freeze({
    Modes = table.freeze({ "Normal", "DonkeyKong", "CrossyRoad", "FFACatchers", "BladeBall" }),
    ModeNames = table.freeze({
        Normal = "Normal",
        DonkeyKong = "Donkey Kong",
        CrossyRoad = "Crossy Road",
        FFACatchers = "FFA Chasers",
        BladeBall = "Huss Ball"
    }),
    ModeMaps = table.freeze({}),
    Actions = table.freeze({
        SetMode = true,
        SetMap = true,
        SetLead = true,
        SetStarter = true,
        Freeze = true,
        EndMatch = true,
        Fly = true,
        Hold = true,
        Kick = true,
        Ban = true,
        Unban = true,
        Invite = true,
        Sync = true,
        TourSet = true,
        TourStart = true,
        TourEnd = true
    }),
    Tournament = table.freeze({
        MaxMatches = 10,
        Tiers = 3,
        MaxTop = 30,
        MaxPoints = 50,
        MaxBasePoints = 20,
        MaxLmsPoints = 20,
        MaxCatchPoints = 10,
        MaxRevivePoints = 5,
        IdleSeconds = 8,
        Defaults = table.freeze({
            matches = 5,
            basePoints = 1,
            lmsPoints = 10,
            catchPoints = 2,
            revivePoints = 1,
            abilities = "None",
            top = table.freeze({ 10, 5, 1 }),
            points = table.freeze({ 2, 3, 4 })
        }),
        Abilities = table.freeze({ "All", "None", "Runner", "Catcher" }),
        AbilityNames = table.freeze({
            All = "Everyone",
            None = "No Abilities",
            Runner = "Only Runners",
            Catcher = "Only Chasers"
        })
    })
});