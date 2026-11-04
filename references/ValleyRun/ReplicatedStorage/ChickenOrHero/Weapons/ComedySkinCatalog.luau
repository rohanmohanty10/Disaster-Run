 

 

local v1 = {
    Order = { "CluckBasher", "BananaBlade", "PizzaPunisher", "Bonker", "Football", "Futbol" },
    Skins = {
        CluckBasher = {
            Name = "CLUCK BASHER",
            Subtitle = "The first joke lands hardest.",
            Description = "A squeaky chicken with serious rewards. Earn +5 coins per completed match while equipped.",
            Model = "CluckBasher",
            SoundProfile = "CluckBasher",
            Collection = "COMEDY COLLECTION",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 210, 76)
        },
        BananaBlade = {
            Name = "BANANA BLADE",
            Subtitle = "Peel out before they catch you.",
            Description = "A slippery edge with extra experience. Earn +10 XP per completed match while equipped.",
            Model = "BananaBlade",
            SoundProfile = "BananaBlade",
            Collection = "COMEDY COLLECTION",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 227, 92)
        },
        PizzaPunisher = {
            Name = "PIZZA PUNISHER",
            Subtitle = "Served hot. Hits harder.",
            Description = "A slice worth chasing. Earn +2 gems per completed match while equipped.",
            Model = "PizzaPunisher",
            SoundProfile = "PizzaPunisher",
            Collection = "COMEDY COLLECTION",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(239, 104, 77)
        },
        Bonker = {
            Name = "BONKER",
            Subtitle = "No edge. All bonk.",
            Description = "A clown\'s mallet with a painted grin. It doesn\'t slice. It just goes BONK.",
            Model = "Bonker",
            SoundProfile = "Bonker",
            HitEffect = "Splat",
            Collection = "COMEDY COLLECTION",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 86, 108)
        },
        Football = {
            Name = "FOOTBALL",
            Subtitle = "Limited · Game day",
            Description = "Trucking (R): shoulder a Chaser right before their hit lands. Hero and last runners get the full game-day show. Comes with the Touchdown emote.",
            Model = "Football",
            Show = "GameDay",
            SoundProfile = "SportsBall",
            HitSoundProfile = "BaseDagger",
            Collection = "GAME DAY",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(196, 122, 64)
        },
        Futbol = {
            Name = "FUTBOL",
            Subtitle = "Limited · Match day",
            Description = "Step Over (R): fake one way, then burst the other. Runners dribble it all match, and Hero and last runners get the full match-day show. Comes with the Ball Juggle emote.",
            Model = "Futbol",
            Show = "MatchDay",
            SoundProfile = "SportsBall",
            HitSoundProfile = "BaseDagger",
            Collection = "MATCH DAY",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(96, 200, 120)
        },
        iSlice = {
            Name = "iSlice",
            Subtitle = "Just a slice",
            Description = "Now 40% thinner and 100% sharper. Charger sold separately.",
            Model = "iSlice",
            SoundProfile = "iSlice",
            Collection = "COMEDY COLLECTION",
            Available = false,
            EquipReady = true,
            Accent = Color3.fromRGB(255, 247, 244)
        }
    }
};
table.freeze(v1.Order);
table.freeze(v1.Skins);

return table.freeze(v1);