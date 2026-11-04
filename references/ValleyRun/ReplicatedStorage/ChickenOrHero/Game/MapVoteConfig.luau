 

 

return table.freeze({
    Enabled = true,
    DefaultMap = "Map1",
    FirstMap = nil,
    ForcedMap = nil,
    FirstVoteMap = "Map7",
    BallotSize = 3,
    VoteSeconds = 12,
    ArrivalBreatherSeconds = 4,
    AfterSummarySeconds = 0.5,
    BackgroundBlurSize = 8,
    ResultSeconds = 2,
    NoAbilities = table.freeze({
        Id = "Map1NoAbilities",
        MapId = "Map1",
        Every = 3,
        Subtitle = "No abilities, items or perks.",
        Tag = "NO ABILITIES",
        TagColor = "danger",
        Accent = Color3.fromRGB(255, 80, 80)
    }),
    Maps = table.freeze({
        {
            Id = "Map1",
            Image = "rbxassetid://118928125383155",
            Name = "THE VALLEY",
            Subtitle = "The original crossing.",
            Accent = Color3.fromRGB(129, 211, 178)
        },
        {
            Id = "Map2",
            Image = "rbxassetid://128003512471527",
            Name = "THE BARN",
            Subtitle = "Huss across the hay.",
            Accent = Color3.fromRGB(238, 192, 124)
        },
        {
            Id = "Map3",
            Image = "rbxassetid://121281123525186",
            FFlag = "Map3Enabled",
            Name = "HOMETOWN",
            Subtitle = "Around the town fountain.",
            LimitedTime = false,
            Accent = Color3.fromRGB(150, 190, 255)
        },
        {
            Id = "Map4",
            Image = "rbxassetid://94809754138696",
            FFlag = "Map4Enabled",
            Name = "SCHOOL YARD",
            Subtitle = "Recess on the blacktop.",
            PreviewParts = 900,
            PreviewPerPiece = 4,
            Accent = Color3.fromRGB(236, 124, 96)
        },
        {
            Id = "Map5",
            Image = "rbxassetid://129055586713812",
            FFlag = "Map5Enabled",
            Name = "HAUNTED WOODS",
            Subtitle = "Something\'s out there tonight.",
            LimitedTime = true,
            PreviewParts = 800,
            PreviewOnField = true,
            Accent = Color3.fromRGB(176, 120, 255),
            PreviewKeep = {
                Share = 0.35,
                Names = { "Tree1", "Tree2", "DeadTree" }
            }
        },
        {
            Id = "Map6",
            Image = "rbxassetid://124227752367333",
            FFlag = "Map6Enabled",
            Name = "THE CARNIVAL",
            Subtitle = "Step right up, if you dare.",
            LimitedTime = true,
            PreviewParts = 800,
            PreviewOnField = true,
            Accent = Color3.fromRGB(255, 96, 72)
        },
        {
            Id = "Map7",
            Image = "rbxassetid://90420960199301",
            FFlag = "Map7Enabled",
            Name = "HAUNTED SHIP",
            Subtitle = "No crew. No captain. No way off.",
            LimitedTime = true,
            PreviewParts = 800,
            PreviewOnField = true,
            Accent = Color3.fromRGB(90, 255, 200)
        }
    })
});