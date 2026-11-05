  

 

return {
    Name = "queuebanner",
    Description = "Adds an additional banner",
    Aliases = {},
    Group = { "ScriptDevs" },
    Args = { {
            Type = "number",
            Name = "queue position",
            Description = "the position for the banner to appear"
        }, {
            Type = "number",
            Name = "hours",
            Description = "how many hours it will last for"
        }, {
            Type = "strings",
            Name = "abilities",
            Description = "which abilities to add into roster"
        }, {
            Type = "string",
            Name = "banner name",
            Description = "custom name for banner",
            Optional = true
        } }
};