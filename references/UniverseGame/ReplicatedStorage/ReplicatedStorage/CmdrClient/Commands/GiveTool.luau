  

 

return {
    Name = "givetool",
    Description = "give yourself a tool from ug\'s tool selection",
    Aliases = { "tool" },
    Group = { "ScriptDevs", "HeadDevs", "PublicTesters", "HOS" },
    Args = { {
            Type = "itemname",
            Name = "toolname",
            Description = "the tool name"
        }, {
            Type = "number",
            Name = "Amount",
            Description = "the amount of tools to add",
            Optional = true
        } }
};