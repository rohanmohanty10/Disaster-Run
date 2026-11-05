  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local u1 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("RayCastOnMap");

return function(p2, p3) -- Line: 7
    -- upvalues: u1 (copy), ReplicatedStorage (copy), Debris (copy)
    local v4;

    if p2 then
        if typeof(p2) == "Vector3" then
            v4 = u1(p2, Vector3.new(0, -10, 0), true);
        else
            v4 = u1(p2.Position, Vector3.new(0, -10, 0), true);
        end;
    else
        v4 = nil;
    end;

    if v4 then
        local v5 = ReplicatedStorage["Client Assets"].Universal.DebrisRubble2:Clone();
        Debris:AddItem(v5, p3);
        v5.CFrame = CFrame.new(v4.Position);
        v5.rocks:Emit(20);
        v5.smoke.Color = ColorSequence.new(v4.Instance.Color);
        v5.smoke:Emit(20);
        v5.Parent = workspace.Effects;
    end;
end;