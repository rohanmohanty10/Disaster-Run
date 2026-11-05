  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return {
    Name = "addunusual",
    Description = "generates an unusual id on currently equipped skin",
    Aliases = {},
    Group = { "ScriptDevs", "PublicTesters", "Devs", "HOS", "HeadDevs", "Admins" },
    Args = {
        {
            Type = "number",
            Name = "pattern id",
            Description = "custom hue id 0-72\n nan: Black\n inf: White",
            Optional = true
        },
        {
            Type = "number",
            Name = "charm id",
            Optional = true,
            Description = `custom charm id 1-{require(ReplicatedStorage.ReplicatedModules.PVEPackage.CharmsHandler).GetTotal()}`
        },
        {
            Type = "boolean",
            Name = "remove",
            Description = "removes the unusual",
            Optional = true
        },
        {
            Type = "boolean",
            Name = "chroma",
            Description = "rgb chroma unusual",
            Optional = true
        },
        {
            Type = "boolean",
            Name = "tradelock",
            Description = "tradelocks the item, by default is yes & only scripter+ can edit",
            Optional = true
        }
    }
};