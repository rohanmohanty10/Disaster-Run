  

 

local Petal = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
Petal("New");
local u1 = Petal("Util");

return function(p2, p3, p4, p5, p6) -- Line: 5
    -- upvalues: u1 (copy)
    if p2 then
        if typeof(p3) == "Instance" then
            if p3:IsA("BasePart") then
                p3 = p3.CFrame * (p4 or CFrame.identity);
            elseif p3:IsA("Attachment") then
                p3 = p3.WorldCFrame * (p4 or CFrame.identity);
            end;
        end;

        local u7 = p6 and u1.ShiftObjectHueAbsolute or u1.ShiftObjectHue;
        local u8 = p2:Clone();
        u8.CFrame = p3;
        u8.Parent = workspace.Terrain;
        local u9 = p5 or 0;
        local u10 = 0;

        for _, child in pairs(u8:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 25
                    -- upvalues: u7 (copy), child (copy), u9 (ref), u10 (ref)
                    u7(child, u9);
                    local v11 = child:GetAttribute("EmitDelay");
                    local v12 = child:GetAttribute("EmitCount") or child.Rate;
                    local v13 = child.Lifetime.Max + (v11 or 0);

                    if u10 < v13 then
                        u10 = v13;
                    end;

                    if v11 and v11 > 0 then
                        local _ = v13 + v11;
                        task.wait(v11);
                    end;

                    child:Emit(v12);
                end);
            end;
        end;

        task.defer(function() -- Line: 42
            -- upvalues: u10 (ref), u8 (copy)
            task.wait(u10 + 0.5);
            u8:Destroy();
        end);
    end;
end;