 
 

require(game.ReplicatedStorage.util.Util);

return {
    [0] = function(p1, p2, p3) -- Line: 4
        local Character = p1.Character;

        for _, v in Character:FindFirstChild("CamWind", true):QueryDescendants("Beam") do
            v.Enabled = true;
        end;

        for _, v in Character:FindFirstChild("CubeAtmosphere", true):QueryDescendants("ParticleEmitter") do
            v.Enabled = true;
        end;
    end,

    [0.317] = function(p4, p5, p6) -- Line: 15
        local Meshes = p4.Meshes;

        for _, v in ipairs(Meshes.hand1:QueryDescendants("ParticleEmitter")) do
            v:Emit(v:GetAttribute("EmitCount") or 5);
        end;

        for _, v in ipairs(Meshes.hand2:QueryDescendants("ParticleEmitter")) do
            v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
        end;
    end,

    [0.767] = function(p7, p8, p9) -- Line: 26
        local Character = p7.Character;

        for _, v in Character:FindFirstChild("Spin", true):QueryDescendants("Trail,ParticleEmitter") do
            v.Enabled = true;
            task.delay(0.3, function() -- Line: 31
                -- upvalues: v (copy)
                v.Enabled = false;
            end);
        end;

        for _, v in Character:FindFirstChild("Cam1", true):QueryDescendants("ParticleEmitter") do
            v.Enabled = true;
            task.delay(0.4, function() -- Line: 36
                -- upvalues: v (copy)
                v.Enabled = false;
            end);
        end;
    end,

    [1.75] = function(p10, p11, p12) -- Line: 39
        local Character = p10.Character;
        local Meshes = p10.Meshes;

        for _, v in Character:FindFirstChild("Cam2", true):QueryDescendants("Beam") do
            v.Enabled = true;
            task.delay(1.55, function() -- Line: 46
                -- upvalues: v (copy)
                v.Enabled = false;
            end);
        end;

        for _, v in Character:FindFirstChild("CamSpeedlines", true):QueryDescendants("ParticleEmitter") do
            v.Enabled = true;
            task.delay(1.55, function() -- Line: 51
                -- upvalues: v (copy)
                v.Enabled = false;
            end);
        end;

        for _, v in Meshes.Steal:QueryDescendants("ParticleEmitter") do
            v:Emit(v:GetAttribute("EmitCount") or 5);
        end;

        for _, v in Character:FindFirstChild("BallVFX", true):QueryDescendants("ParticleEmitter") do
            v:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or v:GetAttribute("EmitCount"));
        end;
    end
};