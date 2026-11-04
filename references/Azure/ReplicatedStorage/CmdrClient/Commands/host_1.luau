 
 

return {
    Description = "host private server with more slots",
    Name = script.Name,
    Aliases = { "h" },
    Group = script.Parent.Name,
    Args = { {
            Type = "servertype",
            Name = "server type",
            Description = "type of server"
        } }
};