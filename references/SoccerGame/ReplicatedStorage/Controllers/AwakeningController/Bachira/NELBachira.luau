  

return function(u1, u2) -- Line: 1
    u1.Camera.Cutscene = true;
    u2.Character.Values.InCutscene.Value = true;
    u2.PlayerGui.InGameUI.Enabled = false;
    task.delay(18, function() -- Line: 7
        -- upvalues: u1 (copy), u2 (copy)
        u1.Camera.Cutscene = false;

        if u2.Team ~= game.Teams.Visitor then
            u2.PlayerGui.InGameUI.Enabled = true;
        end;

        u1:Awakening();
    end);
end;