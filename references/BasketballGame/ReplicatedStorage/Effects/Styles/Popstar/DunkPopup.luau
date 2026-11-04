 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local u1 = {
    Success = { "Good work!", "Nice work!", "Wow! That was great!", "Wow! What an incredible performance!", "Yeah! That\'s what I\'m talking about!", "Perfect!" },
    Fail = { "I know you can do better than that.", "I know you can do more than that.", "Disappointing." }
};

return function(p2, p3) -- Line: 21
    -- upvalues: Effects (copy), u1 (copy)
    if p3.Success then
        Effects:Popup((`{u1.Success[math.random(1, #u1.Success)]} +{math.round(p3.Value * 100)}% {p3.Value >= 0.25 and "MAX" or ""} Dribbling speed!`));

        return;
    end;

    Effects:Popup((`{u1.Fail[math.random(1, #u1.Fail)]} Dribbling speed reset!`));
end;