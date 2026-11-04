 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local u1 = { { "BBZ Spider Try a different sport", "Heh..<animation style=\"appear\" timeBetweenStep=\"0.8\">.</animation> maybe try a different sport.", 2.65 }, { "BBZ Spider Bang", "Bang!", 0.6 }, { "BBZ Spider Nice Try", "Nice try!", 0.8 } };

return function(p2, p3) -- Line: 24
    -- upvalues: u1 (copy), SfxManager (copy), Effects (copy)
    local BlockingPlr = p3.BlockingPlr;
    local v4 = u1[p3.Rng];
    SfxManager:playSound({
        Sound = v4[1],
        Parent = BlockingPlr.Character
    });
    Effects:SubtitleV2({
        { BlockingPlr, v4[2], v4[3] }
    });
end;