  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local Core = require(game.ReplicatedStorage:WaitForChild("ReplicatedRoot").Core);

    if table.find(PathShortcuts.TestPlaces, game.PlaceId) or Core.Flags.IsTesting then
        script.Parent.Visible = true;
    else
        script.Parent.Visible = false;
    end;

    script.Parent.MouseButton1Down:Connect(function() -- Line: 12
        -- upvalues: u1 (copy)
        if u1.Player.PlayerGui.Core:FindFirstChild("StandChanger") then
            for _, child in pairs(u1.Player.PlayerGui.Core.StandChanger:GetChildren()) do
                child.Visible = not child.Visible;
            end;

            return;
        end;

        for _, child in pairs(u1.Player.PlayerGui.UserStandChanger:GetChildren()) do
            child.Visible = not child.Visible;
        end;
    end);
    script.Parent.MouseButton2Down:Connect(function() -- Line: 27
        -- upvalues: u1 (copy)
        for _, child in pairs(u1.Player.PlayerGui.UserStandChanger:GetChildren()) do
            child.Visible = not child.Visible;
        end;
    end);
end;