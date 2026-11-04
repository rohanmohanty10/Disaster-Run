 
 

return {
    { 187, function(p1) -- Line: 3
            local function Emitir(p2) -- Line: 4
                for _, descendant in pairs(p2:GetDescendants()) do
                    if descendant:IsA("ParticleEmitter") then
                        local u3 = descendant:GetAttribute("EmitCount") or 0;
                        local u4 = descendant:GetAttribute("EmitDuration") or 0;
                        local v5 = descendant:GetAttribute("EmitDelay") or 0;
                        task.delay(v5, function() -- Line: 11
                            -- upvalues: descendant (copy), u3 (copy), u4 (copy)
                            descendant:Emit(u3);

                            if u4 > 0 then
                                descendant.Enabled = true;
                                task.delay(u4, function() -- Line: 16
                                    -- upvalues: descendant (ref)
                                    descendant.Enabled = false;
                                end);
                            end;
                        end);
                    end;
                end;
            end;

            local DioImpact = p1:FindFirstChild("DioImpact", true);

            if DioImpact then
                Emitir(DioImpact);
            end;
        end }
};