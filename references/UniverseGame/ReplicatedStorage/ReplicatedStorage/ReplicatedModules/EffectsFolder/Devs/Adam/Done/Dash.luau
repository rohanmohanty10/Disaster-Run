  

 

return function(p1, p2, p3) -- Line: 1
    local v4 = RaycastParams.new();
    v4.FilterDescendantsInstances = { p1 };
    v4.FilterType = Enum.RaycastFilterType.Blacklist;
    v4.CollisionGroup = "Map";
    local v5 = workspace:Raycast(p1.PrimaryPart.Position, Vector3.new(0, -5, 0), v4);

    if v5 then
        local v6 = game.ReplicatedStorage["Client Assets"].Universal.DashTrail:Clone();
        v6.CFrame = p1.PrimaryPart.CFrame * CFrame.new(0, -4.5, 0);
        v6.Anchored = false;
        v6.CanCollide = false;
        v6.Size = Vector3.new(0, 0, 0);
        v6.DashParticle.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, v5.Instance.Color), ColorSequenceKeypoint.new(1, v5.Instance.Color) });
        v6.DashParticle.Enabled = false;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Part0 = p1.PrimaryPart;
        WeldConstraint.Part1 = v6;
        WeldConstraint.Parent = v6;
        v6.Parent = workspace.Effects;
        task.delay(v6.DashParticle.Lifetime.Max + 1, v6.Destroy, v6);

        for _ = 1, p2 or 4 do
            v6.DashParticle:Emit(10);
            wait(0.1);
        end;
    end;
end;