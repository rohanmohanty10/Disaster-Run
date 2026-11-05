  

 

return {
    Name = "AddBounty",
    Description = "adds bounty to player",
    Aliases = { "bounty" },
    Group = { "ScriptDevs", "HeadDevs", "Devs", "PublicTesters" },
    Args = { {
            Type = "number",
            Name = "value",
            Description = "Amount of bounty to add"
        } }
};