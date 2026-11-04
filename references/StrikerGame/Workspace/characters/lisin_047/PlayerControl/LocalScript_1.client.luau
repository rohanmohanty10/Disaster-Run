 
 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local Controls = require(LocalPlayer.PlayerScripts.PlayerModule):GetControls();
script.Parent.Changed:Connect(function(p1) -- Line: 5, Name: onChanged
    -- upvalues: Controls (copy)
    if not Controls.SetMovementEnable then
        return;
    end;

    Controls:SetMovementEnable(p1);
end);
local Value = script.Parent.Value;

if Controls.SetMovementEnable then
    Controls:SetMovementEnable(Value);
end;

script.Parent.Value = true;