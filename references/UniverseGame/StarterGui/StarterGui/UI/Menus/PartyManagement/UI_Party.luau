  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");

return function(p1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    if require(ReplicatedStorage.ReplicatedRoot.Core).Flags.DisableLab then
        return;
    end;

    local _ = game:GetService("Players").LocalPlayer;
    local Knit = p1.Knit;
    Knit.OnStart():await();
    Knit.GetService("PartyService");
    require(script.PartyUI).new(script.Parent, p1):Load();
end;