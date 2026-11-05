  

 

local ReplicatedLibrary = game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary;
local AssetHandler = require(ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3, p4, p5) -- Line: 5
    -- upvalues: ParticleHandler (copy), AssetHandler (copy)
    if not p1 then
        return;
    end;

    if typeof(p2) == "Instance" then
        if p2:IsA("BasePart") then
            p2 = p2.CFrame * (p3 or CFrame.identity);
        elseif p2:IsA("Attachment") then
            p2 = p2.WorldCFrame * (p3 or CFrame.identity);
        end;
    end;

    if typeof(p2) ~= "CFrame" then
        return;
    end;

    local u6 = p1:Clone();

    if p5 ~= nil and p5.HSVData ~= nil then
        ParticleHandler.Unusualify(u6, {
            HSVData = p5.HSVData
        });
    end;

    if p4 then
        AssetHandler.ScaleAsset(u6);
    end;

    u6.CFrame = p2;
    u6.Parent = workspace.Terrain;
    local u7 = 0;

    for _, child in pairs(u6:GetChildren()) do
        if child:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 32
                -- upvalues: child (copy), u7 (ref)
                local v8 = child:GetAttribute("EmitDelay");
                local v9 = child:GetAttribute("EmitCount") or child.Rate;
                local v10 = child.Lifetime.Max + (v8 or 0);

                if u7 < v10 then
                    u7 = v10;
                end;

                if v8 and v8 > 0 then
                    local _ = v10 + v8;
                    task.wait(v8);
                end;

                child:Emit(v9);
            end);
        end;
    end;

    task.defer(function() -- Line: 48
        -- upvalues: u7 (ref), u6 (copy)
        task.wait(u7 + 0.5);
        u6:Destroy();
    end);
end;