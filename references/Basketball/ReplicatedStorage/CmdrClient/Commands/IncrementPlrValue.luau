 
 

return {
    Name = "incrementPlrValue",
    Description = "Increments the player\'s data index by the specified value",
    Aliases = { "incPlr", "ipv" },
    Args = { {
            Type = "dataIndex",
            Name = "data index",
            Description = "eg. \"Money\" or \"Customization Inventory GoalEffects\""
        }, {
            Type = "number",
            Name = "value",
            Description = "Value to increment the data index by"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};