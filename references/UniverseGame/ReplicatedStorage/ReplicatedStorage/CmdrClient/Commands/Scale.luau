  

 

return {
    Name = "scale",
    Description = "Scale players; affects hitboxes.",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "HOS", "Admins" },
    Args = { {
            Type = "players",
            Name = "players",
            Description = "The player(s) to modify"
        }, {
            Type = "number",
            Name = "scale",
            Description = "The scale to be applied.",
            Default = 1
        }, {
            Type = "number",
            Name = "hitbox scale multiplier",
            Description = "The hitbox scale multiplier, derived from character scale.",
            Default = 1,
            Optional = true
        }, {
            Type = "number",
            Name = "sound scale",
            Description = "The sound playback speed scale to be applied.",
            Default = 1,
            Optional = true
        } }
};