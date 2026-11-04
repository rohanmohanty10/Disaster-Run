 
 

local u1 = require("@self/TailBomb");
local u2 = require("@self/StealCutscene");
local u3 = require("@self/TailDribble");

return function(p4) -- Line: 5
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    local Network = p4.Network;

    if p4.NinjaTransform == true then
        return u1(p4);
    end;

    if Network.CharValues.HasBall == true then
        return u3(p4);
    end;

    return u2(p4);
end;