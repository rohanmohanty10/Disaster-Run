  

 

return {
    Name = "playmusic",
    Description = "overwrite game music",
    Aliases = { "playmusic" },
    Group = { "ScriptDevs" },
    Args = { {
            Type = "number",
            Name = "soundid",
            Description = "id of sound"
        } }
};