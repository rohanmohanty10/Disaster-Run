  

local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = "Isagi";
task.spawn(function() -- Line: 6
    -- upvalues: LocalPlayer (copy), u1 (ref)
    local Style = LocalPlayer:WaitForChild("PlayerStats"):WaitForChild("Style");
    u1 = Style.Value;
    Style.Changed:Connect(function(p2) -- Line: 10
        -- upvalues: u1 (ref)
        u1 = p2;
    end);
end);

return function() -- Line: 15, Name: getCurrentStyle
    -- upvalues: u1 (ref)
    return u1;
end;