  

game:GetService("ReplicatedStorage");
game:GetService("ServerScriptService");
game:GetService("Players");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");
local script_SnakeClear = require(script.SnakeClear);
local script_SlitherStep = require(script.SlitherStep);

return function(p1, p2, p3) -- Line: 12
    -- upvalues: script_SnakeClear (copy), script_SlitherStep (copy)
    if p3.Values.IsInPenalty.Value then
        return;
    end;

    if p3.Values.HasBall.Value then
        script_SnakeClear(p1, p2, p3);

        return;
    end;

    script_SlitherStep(p1, p2, p3);
end;