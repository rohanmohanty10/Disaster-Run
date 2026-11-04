  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");

return function(p1) -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    if p1 then
        p1 = p1.Team;
    end;

    if not p1 then
        return false;
    end;

    local v2 = ReplicatedStorage.GameValues:FindFirstChild(p1.Name);

    if v2 then
        v2 = v2:FindFirstChild("ChemReactionCD");
    end;

    if not v2 then
        return false;
    end;

    local v3 = v2.Value - workspace:GetServerTimeNow();

    if v3 > 0 then
        return v3;
    end;

    return false;
end;