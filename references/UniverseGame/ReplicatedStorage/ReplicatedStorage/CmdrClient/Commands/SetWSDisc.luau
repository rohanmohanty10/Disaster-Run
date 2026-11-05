  

 

return {
    Name = "setwsdisc",
    Description = "Sets Ability Disc for Whitesnake",
    Aliases = { "setwhitesnakedisc" },
    Group = { "ScriptDevs", "HeadDevs", "HOS", "Devs", "Admins" },
    Args = { {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        }, {
            Type = "string",
            Name = "Ability Name",
            Description = "Ability Name, Id-Number also works",
            Optional = true,
            Default = nil
        }, {
            Type = "trait",
            Name = "Trait",
            Description = "Trait Name",
            Optional = true,
            Default = nil
        }, {
            Type = "boolean",
            Name = "Hexed Trait",
            Description = "Trait Hexed Variant",
            Optional = true,
            Default = nil
        }, {
            Type = "string",
            Name = "Skin Name",
            Description = "Skin Name, Id-Number also works",
            Optional = true,
            Default = nil
        }, {
            Type = "number",
            Name = "Unusual Hue",
            Description = "Unusual Hue",
            Optional = true,
            Default = nil
        }, {
            Type = "number",
            Name = "Unusual Charm",
            Description = "Unusual Charm",
            Optional = true,
            Default = nil
        }, {
            Type = "boolean",
            Name = "Chroma",
            Description = "Is Unusual Chroma",
            Optional = true,
            Default = nil
        } }
};