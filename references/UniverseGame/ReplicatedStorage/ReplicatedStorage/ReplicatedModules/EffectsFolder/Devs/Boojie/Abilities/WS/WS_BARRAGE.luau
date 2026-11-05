  

 

local Q_BARRAGE_EFFECT = require(script.Parent.Parent.Parent.Personal.Q_BARRAGE_EFFECT);
local Skins = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Skins);
local u1 = game.ReplicatedStorage:WaitForChild("Client Assets");

return function(p2, p3, p4) -- Line: 5
    -- upvalues: Skins (copy), u1 (copy), Q_BARRAGE_EFFECT (copy)
    local v5;

    if p2 then
        v5 = p2:FindFirstChild("Data");
    else
        v5 = p2;
    end;

    local v6 = nil;

    if v5 and v5:FindFirstChild("Skin") then
        v6 = Skins.Funcs.GetSkin(p2.Data.Ability.Value, p2.Data.Skin.Value) or v6;
    end;

    local Whitesnake = u1.Whitesnake;

    if v6 then
        v6 = Whitesnake:FindFirstChild(v6);
    end;

    local ArmEffect = Whitesnake.ArmEffect;

    if v6 then
        ArmEffect = v6:FindFirstChild("ArmEffect") or v6;
    end;

    return Q_BARRAGE_EFFECT(p3, ArmEffect, p4);
end;