 
 

local script_RealGeniusSlowMo = require(script.RealGeniusSlowMo);

return {
    [7] = function(p1) -- Line: 4
        for _, v in { p1.VFX.DynamicLightScene.Both } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("Beam") or (descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("ParticleEmitter"))) then
                    descendant.Enabled = false;
                    descendant:Clear();
                end;
            end;
        end;
    end,

    [2.08] = function(p2) -- Line: 15
        -- upvalues: script_RealGeniusSlowMo (copy)
        script_RealGeniusSlowMo.emitAndFreeze(p2.VFX.Dap, 3.6, 1.1);
    end,

    [1.77] = function(p3) -- Line: 19
        for _, v in { p3.VFX.DynamicLightScene.Both } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("Beam") or (descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("ParticleEmitter"))) then
                    descendant.Enabled = true;
                end;
            end;
        end;
    end,

    [0.88] = function(p4) -- Line: 29
        for _, v in { p4.VFX.DynamicLightScene.Kaiser } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("Beam") or (descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("ParticleEmitter"))) then
                    descendant.Enabled = true;
                    task.delay(0.81, function() -- Line: 36
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end,

    [0] = function(p5) -- Line: 41
        for _, v in { p5.VFX.DynamicLightScene.Isagi } do
            for _, descendant in v:GetDescendants() do
                if descendant:IsA("Beam") or (descendant:IsA("SpotLight") or (descendant:IsA("SurfaceLight") or descendant:IsA("ParticleEmitter"))) then
                    descendant.Enabled = true;
                    task.delay(0.855, function() -- Line: 47
                        -- upvalues: descendant (copy)
                        descendant.Enabled = false;
                    end);
                end;
            end;
        end;
    end
};