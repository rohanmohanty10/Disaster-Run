  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function() -- Line: 4
    -- upvalues: LocalPlayer (copy)
    local v1 = game.ReplicatedStorage["Client Assets"]["King Crimson"].TimeSkipEffect:Clone();
    v1.Parent = LocalPlayer.PlayerGui;
    v1.LocalScript.Disabled = false;
end;