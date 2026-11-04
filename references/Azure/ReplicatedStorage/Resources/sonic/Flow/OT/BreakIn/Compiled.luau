 
 

local function Emitir(p1) -- Line: 2
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            local u2 = descendant:GetAttribute("EmitCount") or 0;
            local u3 = descendant:GetAttribute("EmitDuration") or 0;
            local v4 = descendant:GetAttribute("EmitDelay") or 0;
            task.delay(v4, function() -- Line: 9
                -- upvalues: descendant (copy), u2 (copy), u3 (copy)
                descendant:Emit(u2);

                if u3 > 0 then
                    descendant.Enabled = true;
                    task.delay(u3, function() -- Line: 14
                        -- upvalues: descendant (ref)
                        descendant.Enabled = false;
                    end);
                end;
            end);
        end;
    end;
end;

return {
    { 40, function(p5) -- Line: 24
            -- upvalues: Emitir (copy)
            local Snap = p5:FindFirstChild("Snap", true);

            if Snap then
                Emitir(Snap);
            end;

            local SnapWind = p5:FindFirstChild("SnapWind", true);

            if SnapWind then
                Emitir(SnapWind);
            end;

            shared.vfx.emit(p5.WindSnap);
            shared.vfx.emit(p5.WindSnap2);
            shared.vfx.emit(p5.WindSnap3);
        end },
    { 75, function(p6) -- Line: 39
            -- upvalues: Emitir (copy)
            local GlitchEffect = p6:FindFirstChild("GlitchEffect", true);

            if GlitchEffect then
                Emitir(GlitchEffect);
            end;
        end }
};