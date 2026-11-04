  

local Players = game:GetService("Players");
game:GetService("StarterPlayer");
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 11, Name: getCharacter
    -- upvalues: LocalPlayer (copy)
    local Character = (p1 or LocalPlayer).Character;
    local v2;

    if Character then
        v2 = Character:FindFirstChild("HumanoidRootPart");
    else
        v2 = Character;
    end;

    local v3;

    if Character then
        v3 = Character:FindFirstChild("Values");
    else
        v3 = Character;
    end;

    local v4;

    if Character then
        v4 = Character:FindFirstChild("Humanoid");
    else
        v4 = Character;
    end;

    if Character and (v2 and v3) then
        return Character, v2, v4, v3;
    end;
end;