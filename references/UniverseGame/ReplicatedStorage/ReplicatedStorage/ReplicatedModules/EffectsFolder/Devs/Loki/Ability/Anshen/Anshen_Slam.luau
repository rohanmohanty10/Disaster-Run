  

 

local Anshen = game.ReplicatedStorage["Client Assets"]:FindFirstChild("Anshen");
local ShiftObjectHue = require(game.ReplicatedStorage.ReplicatedModules:WaitForChild("Petal"))("Util").ShiftObjectHue;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2) -- Line: 7
    -- upvalues: Anshen (copy), ShiftObjectHue (copy), EffectsHandler (copy)
    if not p1 or typeof(p1) ~= "Vector3" then
        return;
    end;

    local u3 = Anshen.AnshenSlam:FindFirstChild("Slam"):Clone();
    u3.Position = p1;
    u3.Parent = workspace.Terrain;
    local v4 = p2 or 0;

    for _, child in pairs(u3:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            ShiftObjectHue(child, v4);

            if child:GetAttribute("EmitCount") then
                child:Emit(child:GetAttribute("EmitCount"));
            end;
        end;
    end;

    EffectsHandler.CallEffect("Anshen_Shockwave", p1, 2);
    task.delay(3, function() -- Line: 27
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;