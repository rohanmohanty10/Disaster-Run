  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2, p3) -- Line: 3
    -- upvalues: ParticleHandler (copy)
    local HitData = p3.HitData;

    if not HitData then
        return;
    end;

    local Effect = HitData.Effect;

    if not Effect then
        return;
    end;

    local v4;

    if p2 then
        v4 = p2:FindFirstChild("HumanoidRootPart");
    else
        v4 = p2;
    end;

    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if HumanoidRootPart then
        local u5 = Effect:Clone();
        local v6;

        if v4 then
            v6 = CFrame.lookAt(HumanoidRootPart.Position, v4.Position);
        else
            v6 = HumanoidRootPart.CFrame;
        end;

        u5.CFrame = v6 * (HitData.Offset or CFrame.identity);
        ParticleHandler.Unusualify(u5, {
            Character = p2
        });
        u5.Parent = workspace.Terrain;
        local u7 = 0;

        for _, child in pairs(u5:GetChildren()) do
            if child:IsA("ParticleEmitter") then
                task.spawn(function() -- Line: 26
                    -- upvalues: child (copy), u7 (ref)
                    local v8 = child:GetAttribute("EmitDelay");
                    local v9 = child:GetAttribute("EmitCount") or child.Rate;
                    local v10 = child.Lifetime.Max + (v8 or 0);

                    if u7 < v10 then
                        u7 = v10;
                    end;

                    if v8 and v8 > 0 then
                        local _ = v10 + v8;
                        task.wait(v8);
                    end;

                    child:Emit(v9);
                end);
            end;
        end;

        task.defer(function() -- Line: 42
            -- upvalues: u7 (ref), u5 (copy)
            task.wait(u7 + 0.5);
            u5:Destroy();
        end);
    end;
end;