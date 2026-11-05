  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1) -- Line: 3
    -- upvalues: ReplicatedStorage (copy)
    if require(ReplicatedStorage.ReplicatedRoot.Core).Flags.DisableLab then
        return;
    end;

    local Knit = p1.Knit;
    Knit.OnStart():await();
    Knit.GetService("PartyService");
    local v2 = require(script.PartyMemberUI).new(script.Parent, p1);
    p1.Cache.PartyMemberList = v2;
    v2:Load();
end;