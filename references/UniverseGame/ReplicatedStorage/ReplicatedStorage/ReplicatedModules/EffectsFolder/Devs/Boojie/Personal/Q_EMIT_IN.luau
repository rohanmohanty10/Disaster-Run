  

 

local ReplicatedLibrary = game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary;
local ParticleHandler = require(ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3, p4) -- Line: 4
    -- upvalues: ParticleHandler (copy)
    if not p1 then
        return;
    end;

    local u5 = p1:Clone();
    u5.CFrame = CFrame.new(0, 0, 0) * (p3 or CFrame.identity);

    if p4 ~= nil and p4.HSVData ~= nil then
        ParticleHandler.Unusualify(u5, {
            HSVData = p4.HSVData
        });
    end;

    u5.Parent = p2;
    local u6 = 0;

    for _, child in pairs(u5:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 18
                -- upvalues: child (copy), u6 (ref)
                local v7 = child:GetAttribute("EmitDelay");
                local v8 = child:GetAttribute("EmitCount") or child.Rate;
                local v9 = child.Lifetime.Max + (v7 or 0);

                if u6 < v9 then
                    u6 = v9;
                end;

                if v7 and v7 > 0 then
                    local _ = v9 + v7;
                    task.wait(v7);
                end;

                child:Emit(v8);
            end);
        end;
    end;

    task.defer(function() -- Line: 34
        -- upvalues: u6 (ref), u5 (copy)
        task.wait(u6 + 0.5);
        u5:Destroy();
    end);
end;