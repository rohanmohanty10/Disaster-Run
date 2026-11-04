  

local RunService = game:GetService("RunService");

return function(p1, p2) -- Line: 3
    -- upvalues: RunService (copy)
    local AwakeningService = require(game.ServerScriptService.KnitServer.Services.AwakeningService);

    if RunService:IsStudio() then
        return AwakeningService:GrantStudioAwakening(p2, 100) and "Awakening bar filled. Use your normal awakening input to play the cutscene." or "That player\'s awakening stats are not ready.";
    end;

    _G._overrideAwaken = p2;
    AwakeningService.GiveAwakening = 3;
end;