  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local GetChemicalReaction = require(ReplicatedStorage.Modules.GetChemicalReaction);
local isChemCD = require(ReplicatedStorage.Shared.utils.isChemCD);

return function(p1: userdata) -- Line: 8, Name: canRequestCR
    -- upvalues: GetChemicalReaction (copy), ReplicatedStorage (copy), isChemCD (copy)
    if not (p1 and p1.Team) then
        return false;
    end;

    local Character = p1.Character;
    local v2;

    if Character then
        v2 = Character:FindFirstChild("Values");
    else
        v2 = Character;
    end;

    if v2 then
        v2 = v2:FindFirstChild("HasBall");
    end;

    local PlayerStats = p1:FindFirstChild("PlayerStats");

    if PlayerStats then
        PlayerStats = PlayerStats:FindFirstChild("Style");
    end;

    if not (Character and (v2 and PlayerStats)) then
        return false;
    end;

    local v3, v4, v5 = GetChemicalReaction(p1, {
        requestableOnly = true
    });
    local v6;

    if v4 then
        v6 = v4.Character;
    else
        v6 = v4;
    end;

    if v6 then
        v6 = v6:FindFirstChild("HumanoidRootPart");
    end;

    if not (v3 and (v4 and (v5 and (v6 and ReplicatedStorage.Football.Value)))) then
        return false;
    end;

    if v2.Value and v5.sender == PlayerStats.Value then
        return not isChemCD(p1);
    end;

    return false;
end;