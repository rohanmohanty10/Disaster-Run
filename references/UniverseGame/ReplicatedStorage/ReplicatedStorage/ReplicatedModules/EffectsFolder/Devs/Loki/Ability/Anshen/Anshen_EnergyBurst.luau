  

 

local Anshen = game.ReplicatedStorage["Client Assets"]:FindFirstChild("Anshen");
local u1 = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("Petal"))("Util");

return function(p2, p3, p4) -- Line: 5
    -- upvalues: u1 (copy), Anshen (copy)
    local v5 = p2:IsA("Part") and p2 and p2 or p2:FindFirstChild("Torso");
    local v6 = p3 or 0;
    local v7 = p4 and u1.ShiftObjectHueAbsolute or u1.ShiftObjectHue;

    if not v5 then
        return;
    end;

    local u8 = Anshen.AnshenCharge:FindFirstChild("Charge"):Clone();
    u8.Position = v5.Position;
    u8.Parent = workspace.Terrain;

    for _, child in pairs(u8:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            v7(child, v6);

            if child:GetAttribute("EmitCount") then
                child:Emit(child:GetAttribute("EmitCount"));
            end;
        end;
    end;

    task.delay(2, function() -- Line: 24
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;