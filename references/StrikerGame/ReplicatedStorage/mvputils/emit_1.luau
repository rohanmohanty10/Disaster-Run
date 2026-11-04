 
 

return function(p1) -- Line: 1
    for _, descendant in p1:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local Attribute = descendant:GetAttribute("EmitDelay");

            if Attribute then
                task.delay(Attribute, function() -- Line: 8
                    -- upvalues: descendant (copy)
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end);
            else
                descendant:Emit(descendant:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;