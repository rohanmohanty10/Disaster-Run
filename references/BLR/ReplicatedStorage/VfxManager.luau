  

return {
    MaxLifetime = function(p1) -- Line: 3, Name: MaxLifetime
        local v2 = 0;

        for _, descendant in p1:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                local Max = descendant.Lifetime.Max;

                if descendant:GetAttribute("EmitDelay") then
                    Max = Max + descendant:GetAttribute("EmitDelay");
                end;

                v2 = math.max(v2, Max);
            end;
        end;

        return v2;
    end,

    Emit = function(p3) -- Line: 21, Name: Emit
        for _, descendant in p3:GetDescendants() do
            if descendant:IsA("ParticleEmitter") ~= false then
                if descendant:GetAttribute("EmitDelay") == nil or descendant:GetAttribute("EmitDelay") <= 0 then
                    if descendant:GetAttribute("EmitDuration") == nil or descendant:GetAttribute("EmitDuration") <= 0 then
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    else
                        descendant.Enabled = true;
                        task.delay(descendant:GetAttribute("EmitDuration"), function() -- Line: 30
                            -- upvalues: descendant (copy)
                            descendant.Enabled = false;
                        end);
                    end;
                else
                    task.delay(descendant:GetAttribute("EmitDelay"), function() -- Line: 25
                        -- upvalues: descendant (copy)
                        descendant:Emit(descendant:GetAttribute("EmitCount"));
                    end);
                end;
            end;
        end;
    end,

    EmitParticle = function(u4: userdata) -- Line: 39, Name: EmitParticle
        if u4:IsA("ParticleEmitter") == false then
            return;
        end;

        if u4:GetAttribute("EmitDelay") ~= nil and u4:GetAttribute("EmitDelay") > 0 then
            task.delay(u4:GetAttribute("EmitDelay"), function() -- Line: 42
                -- upvalues: u4 (copy)
                u4:Emit(u4:GetAttribute("EmitCount"));
            end);

            return;
        end;

        if u4:GetAttribute("EmitDuration") == nil or u4:GetAttribute("EmitDuration") <= 0 then
            u4:Emit(u4:GetAttribute("EmitCount"));

            return;
        end;

        u4.Enabled = true;
        task.delay(u4:GetAttribute("EmitDuration"), function() -- Line: 47
            -- upvalues: u4 (copy)
            u4.Enabled = false;
        end);
    end,

    Enable = function(p5, p6) -- Line: 55, Name: Enable
        for _, descendant in p5:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or (descendant:IsA("Beam") or descendant:IsA("Trail")) then
                descendant.Enabled = p6;
            end;
        end;
    end
};