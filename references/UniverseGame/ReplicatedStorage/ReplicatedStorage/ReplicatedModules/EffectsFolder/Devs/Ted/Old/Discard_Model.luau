  

 

local PhysicsService = game:GetService("PhysicsService");

return function(p1, p2, p3, p4, u5) -- Line: 3
    -- upvalues: PhysicsService (copy)
    local u6 = p1:Clone();
    local PrimaryPart = u6.PrimaryPart;

    for _, child in pairs(u6:GetChildren()) do
        if child:IsA("Motor6D") then
            child:Destroy();
        end;
    end;

    for _, child in pairs(u6:GetChildren()) do
        if child:IsA("BasePart") then
            PhysicsService:SetPartCollisionGroup(child, "FX");
            child.CanCollide = true;
            child.Transparency = 0;
        end;
    end;

    u6.Parent = workspace.CurrentCamera;

    if p2 then
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000);

        if p4 then
            BodyVelocity.Velocity = PrimaryPart.Velocity + PrimaryPart.CFrame:VectorToWorldSpace(p2) * (p3 or 1);
        else
            BodyVelocity.Velocity = p2 * (p3 or 1);
        end;

        BodyVelocity.Parent = PrimaryPart;
        task.delay(0.25, function() -- Line: 34
            -- upvalues: BodyVelocity (copy)
            if BodyVelocity then
                BodyVelocity:Destroy();
            end;
        end);
    end;

    if u5 then
        local u7 = nil;
        u7 = PrimaryPart.Touched:Connect(function(p8) -- Line: 42
            -- upvalues: u6 (copy), u7 (ref), u5 (copy), PrimaryPart (copy)
            if not p8:IsDescendantOf(u6) then
                if not p8.CanCollide then
                    return;
                end;

                u7:Disconnect();
                u7 = nil;
                local v9 = u5:Clone();
                v9.Parent = PrimaryPart;
                v9:Play();
            end;
        end);
    end;

    task.delay(5, function() -- Line: 58
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;