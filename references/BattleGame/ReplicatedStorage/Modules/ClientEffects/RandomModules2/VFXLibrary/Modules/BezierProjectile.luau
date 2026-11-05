 

return {
    SpawnProjectiles = function(p1) --[[ Name: SpawnProjectiles, Line 46 ]]
        local l__root__1 = p1.root;
        local l__projectile__2 = p1.projectile;
        local u2 = p1.onHit or function() --[[ Line: 49 ]] end;
        local v3 = p1.count or 1;
        local v4 = p1.spreadRadius or 5;
        local v5 = p1.startHeight or 5;
        local u6 = p1.duration or 1;
        local u7 = p1.arcHeight or 10;
        local v8 = p1.evenlySpaced or false;
        local u9 = p1.rotate or false;
        local v10 = p1.spawnDelay or 0;
        local u11 = p1.lifetime or 1;
        local u12 = l__root__1.Position + Vector3.new(0, v5, 0);
        for v13 = 1, v3 do
            local v14;
            if v8 then
                local v15 = v13 / v3 * 3.141592653589793 * 2;
                local v16 = math.cos(v15) * v4;
                local v17 = math.sin(v15) * v4;
                v14 = Vector3.new(v16, 0, v17);
            else
                local v18 = math.random(-v4, v4);
                v14 = Vector3.new(v18, 0, math.random(-v4, v4));
            end;
            local u19 = l__root__1.Position + v14;
            local v20 = math.random() * v10;
            task.delay(v20, function() --[[ Line: 82 ]]
                -- upvalues: l__projectile__2 (copy), u12 (copy), u19 (copy), u7 (copy), u6 (copy), u2 (copy), u11 (copy), u9 (copy)
                local u21 = l__projectile__2:Clone();
                u21.CFrame = CFrame.new(u12);
                u21.Parent = workspace.World.Visuals;
                local u22 = (u12 + u19) / 2 + Vector3.new(0, u7, 0);
                local u23 = u6 / 30;
                local u24 = 0;
                local u25 = nil;
                u25 = game:GetService("RunService").Heartbeat:Connect(function(p26) --[[ Line: 98 ]]
                    -- upvalues: u24 (ref), u23 (copy), u25 (ref), u21 (copy), u2 (ref), u11 (ref), u12 (ref), u22 (copy), u19 (ref), u9 (ref)
                    u24 = u24 + p26 / u23;
                    if u24 >= 30 then
                        u25:Disconnect();
                        if u21 and u21.Parent then
                            for _, v27 in ipairs(u21:GetChildren()) do
                                if v27:IsA("ParticleEmitter") then
                                    v27:Emit(v27:GetAttribute("EmitCount") or 30);
                                end;
                            end;
                            u2(u21.Position, u21);
                            task.delay(u11, function() --[[ Line: 109 ]]
                                -- upvalues: u21 (ref)
                                if u21 and u21.Parent then
                                    u21:Destroy();
                                end;
                            end);
                        end;
                    else
                        local v28 = u24 / 30;
                        local v29 = (1 - v28) ^ 2 * u12 + 2 * (1 - v28) * v28 * u22 + v28 ^ 2 * u19;
                        u21.CFrame = CFrame.new(v29);
                        if u9 then
                            u21.CFrame = CFrame.new(v29, v29 + (u19 - v29).Unit);
                        end;
                    end;
                end);
            end);
        end;
    end
};