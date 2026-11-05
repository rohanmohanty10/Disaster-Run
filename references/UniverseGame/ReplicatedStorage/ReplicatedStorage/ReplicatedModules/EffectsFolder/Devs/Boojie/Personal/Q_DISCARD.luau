  

 

local PhysicsService = game:GetService("PhysicsService");

return function(p1, p2, p3, p4, u5) -- Line: 3
    -- upvalues: PhysicsService (copy)
    local u6 = p1:Clone();
    u6:BreakJoints();

    for _, child in pairs(u6:GetChildren()) do
        child:Destroy();
    end;

    u6.Transparency = 0;
    u6.CanCollide = true;
    u6.Parent = workspace.CurrentCamera;
    PhysicsService:SetPartCollisionGroup(u6, "FX");

    if p2 then
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);

        if p4 then
            BodyVelocity.Velocity = p1.Velocity + u6.CFrame:VectorToWorldSpace(p2) * (p3 or 1);
        else
            BodyVelocity.Velocity = p2 * (p3 or 1);
        end;

        BodyVelocity.Parent = u6;
        task.delay(0.1, function() -- Line: 27
            -- upvalues: BodyVelocity (copy)
            if BodyVelocity then
                BodyVelocity:Destroy();
            end;
        end);
    end;

    if u5 then
        local u7 = nil;
        u7 = u6.Touched:Connect(function(p8) -- Line: 35
            -- upvalues: u6 (copy), u7 (ref), u5 (copy)
            if not p8:IsDescendantOf(u6) then
                if not p8.CanCollide then
                    return;
                end;

                u7:Disconnect();
                u7 = nil;
                local v9 = u5:Clone();
                v9.Parent = u6;
                v9:Play();
            end;
        end);
    end;

    task.delay(5, function() -- Line: 51
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;