 
 

return {
    Description = "makes selected dummy do skill",
    Name = script.Name,
    Aliases = { "dskill", "ds" },
    Group = script.Parent.Name,
    Args = { {
            Type = "string",
            Name = "what skill?",
            Description = "skill[num]/baseAwaken/Tspecialer"
        } }
};