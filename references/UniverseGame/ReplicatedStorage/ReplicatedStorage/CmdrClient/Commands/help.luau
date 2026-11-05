  

 

return {
    Name = "help",
    Description = "Displays a list of all commands, or inspects one command.",
    Aliases = { "Help", "cmds", "Cmds" },
    Group = { "ScriptDevs", "Devs", "Admins", "Mods", "PSOwner" },
    Args = { {
            Type = "command",
            Name = "Command",
            Description = "The command to view information on",
            Optional = true
        } },

    ClientRun = function(p1, p2) -- Line: 25, Name: ClientRun
        if p2 then
            local v3 = p1.Cmdr.Registry:GetCommand(p2);
            p1:Reply(`Command: {v3.Name}`, Color3.fromRGB(230, 126, 34));

            if v3.Aliases and #v3.Aliases > 0 then
                p1:Reply(`Aliases: {table.concat(v3.Aliases, ", ")}`, Color3.fromRGB(230, 230, 230));
            end;

            p1:Reply(v3.Description, Color3.fromRGB(230, 230, 230));

            for i, v in ipairs(v3.Args) do
                p1:Reply((`#{i} {v.Name}{v.Optional == true and "?" or ""}: {v.Type} - {v.Description}`));
            end;
        else
            p1:Reply("Argument Shorthands\n-------------------\n.   Me/Self\n*   All/Everyone\n**  Others\n?   Random\n?N  List of N random values\n");
            local v4 = p1.Cmdr.Registry:GetCommands();

            for _, v in ipairs(v4) do
                p1:Reply(v.Name, Color3.fromRGB(230, 130, 59));
                p1:Reply(not v.Description and "No description" or `> {v.Description}`);
            end;
        end;

        return "";
    end
};