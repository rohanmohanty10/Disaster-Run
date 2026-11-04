 

 

return {
    { 0, function(p1) -- Line: 3
            for _, descendant in ipairs(p1.Mark:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 4, function(p2) -- Line: 12
            for _, descendant in ipairs(p2.Hit:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end },
    { 27, function(p3, p4) -- Line: 21
            local ReplicatedStorage = game:GetService("ReplicatedStorage");
            local MeshEmitModule = require(ReplicatedStorage.util.MeshEmitModule);
            local v5 = {};

            for i = 1, 4 do
                local u6 = p3.Meshes["Mesh" .. i]:Clone();
                u6:PivotTo(p4.CFrame);
                v5["aaa" .. i] = u6;
                task.delay(10, function() -- Line: 31
                    -- upvalues: u6 (copy)
                    pcall(game.Destroy, u6);
                end);
                local _ = i;
            end;

            for _, v in v5 do
                MeshEmitModule(v.Start);
            end;

            for _, descendant in ipairs(p3.Shoot:GetDescendants()) do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(shared.allvfxcheck and shared.allvfxcheck() and 0 or descendant:GetAttribute("EmitCount"));
                end;
            end;
        end }
};