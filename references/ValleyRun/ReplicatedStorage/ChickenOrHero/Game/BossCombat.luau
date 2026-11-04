 

 

local v1 = {};
local u2 = nil;

function v1.fighting() -- Line: 7
    -- upvalues: u2 (ref)
    u2 = u2 or game.ReplicatedStorage.ChickenOrHero.Game:FindFirstChild("Session");
    local v3;

    if u2 == nil then
        v3 = false;
    else
        v3 = u2:GetAttribute("BossFighting") == true;
    end;

    return v3;
end;

function v1.attacker(p4) -- Line: 14
    -- upvalues: u2 (ref)
    local Attribute = p4:GetAttribute("GameRole");
    local v5;

    if Attribute == "Catcher" then
        v5 = true;
    elseif Attribute == "Runner" then
        u2 = u2 or game.ReplicatedStorage.ChickenOrHero.Game:FindFirstChild("Session");

        if u2 == nil then
            v5 = false;
        else
            v5 = u2:GetAttribute("BossFighting") == true;
        end;
    else
        v5 = false;
    end;

    return v5;
end;

function v1.record(p6, p7) -- Line: 20
    local v8;

    if p7 == nil then
        v8 = false;
    elseif p7.role == "Catcher" then
        v8 = true;
    elseif p7.role == "Runner" and p6 ~= nil then
        v8 = p6.boss == true;
    else
        v8 = false;
    end;

    return v8;
end;

return table.freeze(v1);