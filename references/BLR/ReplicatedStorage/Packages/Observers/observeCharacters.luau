  

local observePlayer = require(script.Parent.observePlayer);
local observeCharacter = require(script.Parent.observeCharacter);

return function(u1: function) -- Line: 22, Name: observeCharacters
    -- upvalues: observePlayer (copy), observeCharacter (copy)
    return observePlayer(function(p2) -- Line: 23
        -- upvalues: observeCharacter (ref), u1 (copy)
        return observeCharacter(p2, u1);
    end);
end;