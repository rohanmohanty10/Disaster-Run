  

 

return {
    Name = "spectate",
    Description = "spectate a player",
    Aliases = { "watch" },
    Group = { "ScriptDevs", "Admins", "Mods", "HeadDevs", "Devs" },
    Args = { {
            Type = "player",
            Name = "Target",
            Description = "Target name to spectate"
        } },

    Run = function(p1, p2) -- Line: 14, Name: Run
        local Executor = p1.Executor;

        if p2 == Executor then
            return;
        end;

        local Character = p2.Character;
        local v3;

        if Character then
            v3 = Character.PrimaryPart;
        else
            v3 = Character;
        end;

        if not (Character and v3) then
            return `Target {p2.Name} is not currently available.`;
        end;

        Executor:AddReplicationFocus(v3);
    end,

    ClientRun = function(p4, p5) -- Line: 29, Name: ClientRun
        local CurrentCamera = workspace.CurrentCamera;
        local Executor = p4.Executor;
        local Character = Executor.Character;
        local v6;

        if Character then
            v6 = Character:FindFirstChildOfClass("Humanoid");
        else
            v6 = Character;
        end;

        if Character then
            Character = Character.PrimaryPart;
        end;

        if p5 == Executor then
            CurrentCamera.CameraSubject = v6 or Character;

            return "Stopped spectating.";
        end;

        local Character2 = p5.Character;
        local v7;

        if Character2 then
            v7 = Character2:FindFirstChildOfClass("Humanoid");
        else
            v7 = Character2;
        end;

        local v8;

        if Character2 then
            v8 = Character2.PrimaryPart;
        else
            v8 = Character2;
        end;

        if not (Character2 and (v7 or v8)) then
            return `Could not spectate {p5.Name}.`;
        end;

        p4.Dispatcher:Send(p4.RawText, p4.Data);
        CurrentCamera.CameraSubject = v7 or v8;

        return `Now spectating {p5.Name}.`;
    end
};