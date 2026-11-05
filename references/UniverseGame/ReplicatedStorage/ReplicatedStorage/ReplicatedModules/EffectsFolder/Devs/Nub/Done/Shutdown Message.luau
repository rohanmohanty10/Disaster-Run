  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1) -- Line: 2
    -- upvalues: LocalPlayer (copy)
    local v2 = game:GetService("ReplicatedStorage")["Client Assets"].ShutdownTemplate:Clone();
    v2.Text = p1 or v2.Text;
    v2.Parent = LocalPlayer.PlayerGui.Core;
end;