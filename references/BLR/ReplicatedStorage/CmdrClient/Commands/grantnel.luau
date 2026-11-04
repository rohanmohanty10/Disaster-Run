  

return {
    Name = "grantnel",
    Description = "Grant a NEL perk/quest reward by its key",
    Group = "Admin",
    Aliases = { "grantnel" },
    Args = { {
            Type = "player",
            Name = "target",
            Description = "The player"
        }, {
            Type = "string",
            Name = "key",
            Description = "Perk/quest key (e.g. nel_champion, loki_speedblitz, IronThrone)"
        } }
};