 

 

return {
    Description = "ban die. lol.wwwwwwwwww (but only temporary), so more like a rest.",
    Name = script.Name,
    Aliases = { "tempban" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "user id",
            Description = "userid to temporarily ban."
        }, {
            Type = "string",
            Name = "duration",
            Description = "examples: 1d, 1w, 12h, 30m."
        }, {
            Type = "string",
            Name = "reason",
            Description = "ban reason."
        }, {
            Type = "string",
            Name = "exclude alt accounts",
            Description = "true / false."
        } }
};