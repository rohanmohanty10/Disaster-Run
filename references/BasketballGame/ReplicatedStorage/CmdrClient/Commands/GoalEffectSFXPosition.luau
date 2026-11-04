 
 

return {
    Name = "goaleffectsfxposition",
    Description = "Sets the position on goal effect sfx",
    Group = "LeadTester",
    Aliases = { "sfxposition" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "number",
            Name = "position",
            Description = "Defaults to false",
            Optional = true
        } }
};