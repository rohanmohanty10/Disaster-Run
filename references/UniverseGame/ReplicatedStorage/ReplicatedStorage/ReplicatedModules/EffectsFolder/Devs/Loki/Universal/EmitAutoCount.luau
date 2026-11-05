  

 

return function(p1, p2) -- Line: 1
    local u3 = p1:Clone();
    local u4 = u3:IsA("Attachment") and u3 and u3 or u3:FindFirstChildOfClass("Attachment");

    if u4:IsA("Attachment") then
        u4.Parent = p2;

        for _, descendant in pairs(u4:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") and descendant:GetAttribute("EmitCount") then
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end;

    task.delay(5, function() -- Line: 16
        -- upvalues: u3 (copy), u4 (copy)
        if not u3:IsA("Attachment") then
            u3:Destroy();
        end;

        u4:Destroy();
    end);
end;