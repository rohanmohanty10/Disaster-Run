 
 

return {
    Emit = function(p1) -- Line: 3, Name: Emit
        for _, descendant in p1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                local Attribute = descendant:GetAttribute("EmitCount");

                if Attribute and workspace:GetAttribute("LowQualityVFX") then
                    Attribute = Attribute / 3;
                end;

                if descendant:GetAttribute("EmitDelay") == nil or descendant:GetAttribute("EmitDelay") <= 0 then
                    if descendant:GetAttribute("EmitDuration") == nil or descendant:GetAttribute("EmitDuration") <= 0 then
                        if Attribute then
                            descendant:Emit(Attribute);
                        end;
                    else
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 24
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                else
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 12
                        -- upvalues: descendant (copy), Attribute (ref)
                        if descendant:GetAttribute("EmitDuration") == nil or descendant:GetAttribute("EmitDuration") <= 0 then
                            if Attribute then
                                descendant:Emit(Attribute);
                            end;

                            return;
                        end;

                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 15
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                end;
            end;
        end;
    end,

    BetterEmit = function(p2) -- Line: 36, Name: BetterEmit
        for _, descendant in p2:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                local Attribute = descendant:GetAttribute("EmitCount");

                if Attribute and workspace:GetAttribute("LowQualityVFX") then
                    Attribute = Attribute / 3;
                end;

                if descendant:GetAttribute("EmitDelay") and descendant:GetAttribute("EmitDelay") > 0 then
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 45
                        -- upvalues: descendant (copy), Attribute (ref)
                        if not descendant:GetAttribute("EmitDuration") or descendant:GetAttribute("EmitDuration") <= 0 then
                            if descendant:IsA("ParticleEmitter") and Attribute then
                                descendant:Emit(Attribute);
                            end;

                            return;
                        end;

                        if descendant:IsA("ParticleEmitter") and Attribute then
                            descendant:Emit(Attribute);
                        end;

                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 52
                            -- upvalues: descendant (ref)
                            descendant.Enabled = false;
                        end);
                    end);
                elseif descendant:GetAttribute("EmitDuration") and descendant:GetAttribute("EmitDuration") > 0 then
                    if descendant:IsA("ParticleEmitter") and Attribute then
                        descendant:Emit(Attribute);
                    end;

                    descendant.Enabled = true;
                    task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 65
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                elseif descendant:IsA("ParticleEmitter") and Attribute then
                    descendant:Emit(Attribute);
                end;
            end;
        end;
    end,

    Enable = function(p3, p4) -- Line: 77, Name: Enable
        for _, descendant in p3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = p4;
            end;
        end;
    end,

    DestroyEffect = function(u5, p6) -- Line: 84, Name: DestroyEffect
        task.delay(p6, function() -- Line: 85
            -- upvalues: u5 (copy)
            if u5 then
                u5:Destroy();
            end;
        end);
    end,

    ModelTransparency = function(p7, p8) -- Line: 92, Name: ModelTransparency
        for _, descendant in p7:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = p8;
            end;
        end;
    end
};