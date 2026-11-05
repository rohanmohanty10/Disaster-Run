  

 

return {
    Name = "playaudio",
    Description = "plays desired sound id, bypasses sound settings",
    Aliases = {},
    Group = { "ScriptDevs", "HeadDevs", "Devs", "HOS", "Admins" },
    Args = {
        {
            Type = "players",
            Name = "player(s)",
            Description = "The player(s) to modify"
        },
        {
            Type = "boolean",
            Name = "global",
            Description = "is audio global? \n(High Rank required)",
            Optional = true,
            Default = false
        },
        {
            Type = "string",
            Name = "soundid",
            Description = "id of the sound/audio \nleave blank to remove any audio",
            Optional = true
        },
        {
            Type = "number",
            Name = "volume",
            Description = "audio volume",
            Optional = true,
            Default = 1
        },
        {
            Type = "number",
            Name = "pitch",
            Description = "audio pitch",
            Optional = true,
            Default = 1
        },
        {
            Type = "boolean",
            Name = "loop",
            Description = "audio loops",
            Optional = true,
            Default = false
        },
        {
            Type = "boolean",
            Name = "no overwrite",
            Description = "prevent deleting previous audio",
            Optional = true,
            Default = false
        },
        {
            Type = "number",
            Name = "timeposition",
            Description = "starting time position",
            Optional = true
        },
        {
            Type = "number",
            Name = "maxdistance",
            Description = "max distance the audio can be heard from \n(High Rank required)",
            Optional = true,
            Default = 300
        },
        {
            Type = "number",
            Name = "mindistance",
            Description = "min distance the audio should be heard from \n(High Rank required)",
            Optional = true,
            Default = 10
        }
    }
};