 
 

return {
    Name = "setPlrValueOffline",
    Description = "Sets the player\'s data index to the specified value",
    Aliases = { "setPlrOff" },
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "Target player (from userid)"
        }, {
            Type = "dataIndex",
            Name = "data index",
            Description = "eg. \"Money\" or \"Customization Inventory GoalEffects\""
        }, {
            Type = "any",
            Name = "value",
            Description = "Value to set the data index to"
        } }
};