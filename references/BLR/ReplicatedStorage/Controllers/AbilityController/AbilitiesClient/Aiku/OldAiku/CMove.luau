  

game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local script_Ambush = require(script.Ambush);
local script_Periscope = require(script.Periscope);

return function(p1, p2, p3) -- Line: 12
    -- upvalues: script_Periscope (copy), script_Ambush (copy)
    if workspace:FindFirstChild("Football") then
        script_Periscope(p1, p2, p3);

        return;
    end;

    script_Ambush(p1, p2, p3);
end;