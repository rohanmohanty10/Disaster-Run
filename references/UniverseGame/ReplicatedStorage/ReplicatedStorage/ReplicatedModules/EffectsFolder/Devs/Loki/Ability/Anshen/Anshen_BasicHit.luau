  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local ShiftObjectHue = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("Petal"))("Util").ShiftObjectHue;

return function(p2, p3, p4, p5) -- Line: 6
    -- upvalues: u1 (copy), ShiftObjectHue (copy)
    local v6 = p2:IsA("Part") and p2 and p2 or p2:FindFirstChild("Torso");
    local v7 = p5 or 0;

    if not v6 then
        return;
    end;

    local u8 = u1.Anshen.AnshenHit.Hit:Clone();
    u8.Position = v6.Position;
    u8.Parent = workspace.Terrain;

    for _, child in pairs(u8:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            ShiftObjectHue(child, v7);

            if child:GetAttribute("EmitCount") then
                child:Emit(child:GetAttribute("EmitCount"));
            end;
        end;
    end;

    task.delay(2, function() -- Line: 23
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;