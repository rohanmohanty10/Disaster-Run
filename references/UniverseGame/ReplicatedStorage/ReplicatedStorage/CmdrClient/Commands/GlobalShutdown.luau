  

 

return {
    Name = "globalshutdown",
    Description = "shutdown all servers exceeding a time limit",
    Aliases = { "gs" },
    Group = { "ScriptDevs" },
    Args = { {
            Type = "number",
            Name = "time limit",
            Description = "server time limit in seconds, anything above time limit will be shutdown",
            Default = 36000
        }, {
            Type = "boolean",
            Name = "lobby only",
            Description = "Shutdown lobby servers from pvp matchmaking only",
            Optional = true
        } }
};