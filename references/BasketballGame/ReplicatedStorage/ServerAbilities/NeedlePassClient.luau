 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = nil;

return function(p2) -- Line: 8
    -- upvalues: u1 (ref), Effects (copy)
    u1 = p2.MovementController;
    local v3 = u1;
    v3.Boost = v3.Boost + 5;
    task.delay(5, function() -- Line: 12
        -- upvalues: u1 (ref)
        local v4 = u1;
        v4.Boost = v4.Boost - 5;

        if u1.Boost < 0 then
            u1.Boost = 0;
        end;
    end);
    Effects:Popup("CAUGHT NEEDLE PASS. SPEED INCREASE FOR 5 SECONDS.");
end;