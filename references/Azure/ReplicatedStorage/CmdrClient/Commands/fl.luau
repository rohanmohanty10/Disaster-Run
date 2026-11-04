 

 

return {
    Description = "extra flows per team. to disable flows refer to disableFlow",
    Name = script.Name,
    Aliases = { "fl" },
    Group = script.Parent.Name,
    Args = { {
            Type = "number",
            Name = "how much do u want.",
            Description = "default is zero"
        } }
};