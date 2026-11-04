 
 

return {
    Name = "setPlrValue",
    Description = "Sets the player\'s data index to the specified value",
    Aliases = { "setPlr", "spv" },
    Args = { {
            Type = "dataIndex",
            Name = "data index",
            Description = "eg. \"Money\" or \"Customization Inventory GoalEffects\""
        }, {
            Type = "string # number ! boolean",
            Name = "value",
            Description = "Value to set the data index to"
        }, {
            Type = "player",
            Name = "player",
            Description = "Target player, defaults to LocalPlayer",
            Optional = true
        } }
};