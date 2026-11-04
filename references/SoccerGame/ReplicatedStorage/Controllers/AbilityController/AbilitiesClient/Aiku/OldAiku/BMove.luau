  

game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local script_SixthSense = require(script.SixthSense);
local script_Territory = require(script.Territory);

return function(p1, p2, p3) -- Line: 12
    -- upvalues: script_Territory (copy), script_SixthSense (copy)
    if p3.Values.IsInPenalty.Value then
        if p3:GetAttribute("SixthSense") then
            script_Territory(p1, p2, p3);

            return;
        end;

        script_SixthSense(p1, p2, p3);
    end;
end;