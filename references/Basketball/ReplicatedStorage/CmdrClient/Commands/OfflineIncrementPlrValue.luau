 
 

return {
    Name = "incrementPlrValueOffline",
    Description = "Increments the player\'s data index by the specified value",
    Aliases = { "incPlrOff" },
    Args = { {
            Type = "number",
            Name = "userid",
            Description = "Target player (from userid)"
        }, {
            Type = "dataIndex",
            Name = "data index",
            Description = "eg. \"Money\" or \"Customization Inventory GoalEffects\""
        }, {
            Type = "number",
            Name = "value",
            Description = "Value to increment the data index by"
        } }
};