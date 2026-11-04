 
 

return {
    Description = "USED FOR ADMIN ABUSE DO NOT USE MUCH",
    Name = script.Name,
    Group = script.Parent.Name,
    Args = { {
            Type = "string",
            Name = "question",
            Description = "questn"
        }, {
            Type = "string",
            Name = "option 1",
            Description = "one"
        }, {
            Type = "string",
            Name = "option 2",
            Description = "emm dwah?"
        }, {
            Type = "positiveInteger",
            Name = "duration",
            Description = "segundo italian?"
        }, {
            Type = "boolean",
            Name = "global",
            Description = "true if you wanna do globally false if this server only ",
            Optional = false
        } }
};