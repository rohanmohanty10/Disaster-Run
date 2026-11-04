  

return {
    Name = "skipperks",
    Description = "Grants every NEL team perk reward (progress perks) to test they work",
    Group = "Admin",
    Aliases = { "skipperks", "skipallperks", "testperks" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        } }
};