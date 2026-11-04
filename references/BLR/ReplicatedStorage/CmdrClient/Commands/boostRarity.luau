  

return {
    Name = "boostRarity",
    Description = "boostRarity",
    Group = "Owner",
    Aliases = { "boostRarity" },
    Args = { {
            Type = "spinType",
            Name = "spinType",
            Description = "which spin rarity to increase"
        }, {
            Type = "rarity",
            Name = "rarity",
            Description = "rarity to increase"
        }, {
            Type = "duration",
            Name = "duration",
            Description = "duration for it"
        }, {
            Type = "number",
            Name = "newChance",
            Description = "the new chance as a percent %"
        } }
};