  

 

return function(p1, p2, p3) -- Line: 1
    if p1 then
        if typeof(p2) == "Instance" then
            if p2:IsA("BasePart") then
                p2 = p2.CFrame * (p3 or CFrame.identity);
            elseif p2:IsA("Attachment") then
                p2 = p2.WorldCFrame * (p3 or CFrame.identity);
            end;
        end;

        if p2 == nil then
            return;
        end;

        local u4 = p1:Clone();
        u4.CFrame = p2;
        u4.Parent = workspace.Terrain;
        local u5 = 0;

        for _, descendant in pairs(u4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 20
                    -- upvalues: descendant (copy), u5 (ref)
                    local v6 = descendant:GetAttribute("EmitDelay");
                    local v7 = descendant:GetAttribute("EmitCount") or descendant.Rate;
                    local v8 = descendant.Lifetime.Max + (v6 or 0);

                    if u5 < v8 then
                        u5 = v8;
                    end;

                    if v6 and v6 > 0 then
                        local _ = v8 + v6;
                        task.wait(v6);
                    end;

                    descendant:Emit(v7);
                end);
            end;
        end;

        task.defer(function() -- Line: 36
            -- upvalues: u5 (ref), u4 (copy)
            task.wait(u5 + 0.5);
            u4:Destroy();
        end);
    end;
end;