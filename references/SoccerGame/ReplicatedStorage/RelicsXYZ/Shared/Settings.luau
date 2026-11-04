  

return {
    ProximityAudio = {
        Title = "Play music for others",
        Description = "Boombox proximity audio toggle",
        Icon = "rbxassetid://17662978470",
        RequiresBoombox = true,
        Default = false,
        Order = 1
    },
    BoomboxIdol = {
        Title = "Wear Boombox IDOL on your avatar",
        Description = "Boombox visual appearance toggle",
        Icon = "rbxassetid://17662978359",
        RequiresBoombox = true,
        Default = true,
        Order = 2
    },
    GlobalMute = {
        Title = "Mute other boomboxes",
        Description = "Boombox global mute toggle",
        Icon = "rbxassetid://17662978739",
        RequiresBoombox = false,
        Default = false,
        Order = 3
    },
    LocalMute = {
        Title = "Mute your music",
        Description = "Boombox local mute toggle",
        Icon = "rbxassetid://17662978666",
        RequiresBoombox = false,
        Default = false,
        Order = 4
    },
    AuraToggle = {
        Title = "Enable Aura Effects",
        Description = "Aura visibility toggle",
        Icon = "rbxassetid://86646413851888",
        RequiresBoombox = false,
        Default = true,
        Order = 5,
        RequiredFeatures = {
            Auras = true
        }
    }
};