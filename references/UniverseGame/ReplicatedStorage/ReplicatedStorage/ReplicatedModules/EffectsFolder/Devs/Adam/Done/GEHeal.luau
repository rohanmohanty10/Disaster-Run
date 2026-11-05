  

 

return function(p1, p2) -- Line: 1
    local v3;

    if p2:FindFirstChild("Stand") then
        if p2.Stand["Stand Right Arm"]:FindFirstChild("ArmFlair") then
            v3 = p2.Stand["Stand Right Arm"].ArmFlair;
        else
            v3 = p1.Stand["Stand Right Arm"].ArmFlair;
        end;
    else
        v3 = p1.Stand["Stand Right Arm"].ArmFlair;
    end;

    local v4 = v3:Clone();
    v4.Parent = p1:FindFirstChild("Torso") or (p1.PrimaryPart or p1.HumanoidRootPart);

    for _, child in pairs(v4:GetChildren()) do
        if child.Name == "ParticleEmitter" then
            for _, child2 in pairs(p1:GetChildren()) do
                if child2:IsA("BasePart") and child2.Transparency < 1 then
                    local v5 = child:Clone();
                    v5.Parent = child2;
                    v5:Emit(v5.Rate);
                    task.delay(v5.Lifetime.Max, v5.Destroy, v5);
                end;
            end;
        else
            child:Emit(child.Rate);
        end;
    end;

    task.delay(7, v4.Destroy, v4);
end;