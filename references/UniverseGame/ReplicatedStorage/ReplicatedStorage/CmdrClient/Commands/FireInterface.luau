  

 

return {
    Name = "FireInterface",
    Description = "Fires the given ui output function name",
    Aliases = { "fireinterface", "uioutput", "uif" },
    Group = { "ScriptDevs" },
    Args = { {
            Type = "string",
            Name = "Function Name",
            Description = "The ui output function to fire",
            Default = false
        } }
};