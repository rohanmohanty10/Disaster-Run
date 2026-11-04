 
 

return {
    Name = "customrig",
    Description = "Makes the specified player use their own rig",
    Aliases = { "rig" },
    Args = { {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        }, {
            Type = "boolean",
            Name = "toggle",
            Description = "Defaults to true",
            Optional = true
        } }
};