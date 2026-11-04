 
 

local v1 = {};

local function lerp(p2, p3, p4) -- Line: 3
    return p2 + (p3 - p2) * p4;
end;

local function spawnSingleProjectile(u5, u6, p7, u8, u9, u10, u11) -- Line: 7
    local u12 = p7:Clone();
    u12.CFrame = CFrame.new(u5);
    u12.Parent = workspace.Effects;
    local u13 = tick();
    local u14 = nil;
    u14 = game:GetService("RunService").Heartbeat:Connect(function() -- Line: 14
        -- upvalues: u13 (copy), u9 (copy), u12 (copy), u8 (copy), u6 (copy), u14 (ref), u5 (copy), u10 (copy), u11 (copy)
        local v15 = (tick() - u13) / u9;

        if v15 >= 1 then
            u12:Destroy();

            if u8 then
                u8(u6, nil);
            end;

            u14:Disconnect();

            return;
        end;

        local v16 = u5;
        local v17 = u5 + Vector3.new(0, u10, 0);
        local v18 = u6 + Vector3.new(0, u10, 0);
        local v19 = v16 + (v17 - v16) * v15;
        local v20 = v17 + (v18 - v17) * v15;
        local v21 = v19 + (v20 - v19) * v15;
        local v22 = v21 + (v20 + (v18 + (u6 - v18) * v15 - v20) * v15 - v21) * v15;
        u12.Position = v22;

        if u11 then
            u12.CFrame = CFrame.new(v22) * CFrame.Angles(0, v15 * 6.283185307179586, 0);
        end;
    end);
end;

function v1.SpawnProjectiles(p23) -- Line: 46
    local root = p23.root;
    local projectile = p23.projectile;
    local u24 = p23.onHit or function() -- Line: 49
    end;
    local v25 = p23.count or 1;
    local v26 = p23.spreadRadius or 5;
    local u27 = p23.duration or 1;
    local u28 = p23.arcHeight or 10;
    local v29 = p23.evenlySpaced or false;
    local u30 = p23.rotate or false;
    local v31 = p23.spawnDelay or 0;
    local u32 = p23.lifetime or 1;
    local u33 = root.Position + Vector3.new(0, p23.startHeight or 5, 0);

    for i = 1, v25 do
        local v34;

        if v29 then
            local v35 = i / v25 * 3.141592653589793 * 2;
            local v36 = math.cos(v35) * v26;
            local v37 = math.sin(v35) * v26;
            v34 = Vector3.new(v36, 0, v37);
        else
            local math_random_ret = math.random(-v26, v26);
            v34 = Vector3.new(math_random_ret, 0, math.random(-v26, v26));
        end;

        local u38 = root.Position + v34;
        local v39 = math.random() * v31;
        task.delay(v39, function() -- Line: 82
            -- upvalues: projectile (copy), u33 (copy), u38 (copy), u28 (copy), u27 (copy), u24 (copy), u32 (copy), u30 (copy)
            local u40 = projectile:Clone();
            u40.CFrame = CFrame.new(u33);
            u40.Parent = workspace.Effects;
            local u41 = (u33 + u38) / 2 + Vector3.new(0, u28, 0);
            local u42 = u27 / 30;
            local u43 = 0;

            local function bezierPoint(p44, p45, p46, p47) -- Line: 93
                return (1 - p44) ^ 2 * p45 + 2 * (1 - p44) * p44 * p46 + p44 ^ 2 * p47;
            end;

            local u48 = nil;
            u48 = game:GetService("RunService").Heartbeat:Connect(function(p49) -- Line: 98
                -- upvalues: u43 (ref), u42 (copy), u48 (ref), u40 (copy), u24 (ref), u32 (ref), u33 (ref), u41 (copy), u38 (ref), u30 (ref)
                u43 = u43 + p49 / u42;

                if u43 >= 30 then
                    u48:Disconnect();

                    if u40 and u40.Parent then
                        for _, child in ipairs(u40:GetChildren()) do
                            if child:IsA("ParticleEmitter") then
                                child:Emit(child:GetAttribute("EmitCount") or 30);
                            end;
                        end;

                        u24(u40.Position, u40);
                        task.delay(u32, function() -- Line: 109
                            -- upvalues: u40 (ref)
                            if u40 and u40.Parent then
                                u40:Destroy();
                            end;
                        end);
                    end;
                else
                    local v50 = u43 / 30;
                    local v51 = (1 - v50) ^ 2 * u33 + 2 * (1 - v50) * v50 * u41 + v50 ^ 2 * u38;
                    u40.CFrame = CFrame.new(v51);

                    if u30 then
                        u40.CFrame = CFrame.new(v51, v51 + (u38 - v51).Unit);
                    end;
                end;
            end);
        end);
        local _ = i;
    end;
end;

return v1;