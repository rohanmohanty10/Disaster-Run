  

 

local Minigame = require(script:WaitForChild("Minigame"));

return {
    _Games = {},

    CreateMinigame = function(p1) -- Line: 6, Name: CreateMinigame
        -- upvalues: Minigame (copy)
        return Minigame.new(p1);
    end
};