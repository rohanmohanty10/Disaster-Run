  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    if not require(ReplicatedStorage.ReplicatedRoot.Core).Flags.Arena then
        return;
    end;

    local Parent = script.Parent;
    local TextLabel = Parent:WaitForChild("TextLabel");
    Parent.Visible = true;

    local function FormatTime(p2) -- Line: 13
        return string.format("%02i:%02i", p2 / 60 % 60, p2 % 60);
    end;

    while true do
        local v3 = (workspace:GetAttribute("RoundTimer") or 0) - os.time();
        local v4 = math.max(v3, 0);
        TextLabel.Text = `Round Timer:\n{string.format("%02i:%02i", v4 / 60 % 60, v4 % 60)}`;
        task.wait(1);
    end;
end;