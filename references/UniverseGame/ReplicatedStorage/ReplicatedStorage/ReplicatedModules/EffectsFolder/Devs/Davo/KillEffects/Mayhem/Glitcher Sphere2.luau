  

 

return function(u1) -- Line: 1
    local Part = Instance.new("Part");
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Anchored = true;
    Part.TopSurface = 0;
    Part.BottomSurface = 0;
    Part.FormFactor = 3;
    Part.Material = Enum.Material.Neon;
    Part.Size = Vector3.new(1, 1, 1);
    Part.Color = u1.Color;
    Part.CFrame = u1.CFrame or u1.Position;
    Part.Transparency = u1.Transparency == "In" and 1 or 0;
    local SpecialMesh = Instance.new("SpecialMesh");
    SpecialMesh.MeshType = "Sphere";
    SpecialMesh.Parent = Part;
    SpecialMesh.Scale = u1.Scale or u1.Size;
    Part.Parent = workspace.Effects;
    local v2 = u1.Value or u1.X;
    local v3 = u1.Value2 or u1.Y;
    local v4 = u1.Value3 or u1.Z;
    local u5 = {
        X = u1.Type == "Divide" and 1 / v2 or 1 * v2,
        Y = u1.Type == "Divide" and 1 / v3 or 1 * v3,
        Z = u1.Type == "Divide" and 1 / v4 or 1 * v4
    };
    local BonusSpeed = u1.BonusSpeed;
    local u6 = 0.01 * BonusSpeed;
    local u7 = u1.Type == "Divide" and 0.01 / v2 / BonusSpeed or 0.01 * v2 * BonusSpeed;
    task.spawn(function() -- Line: 33
        -- upvalues: u5 (copy), u7 (copy), SpecialMesh (copy), BonusSpeed (copy), Part (copy), u6 (copy), u1 (copy)
        repeat
            local v8 = task.wait() * 60;
            local v9 = u5;
            v9.X = v9.X - u7 * v8;
            local v10 = u5;
            v10.Y = v10.Y - u7 * v8;
            local v11 = u5;
            v11.Z = v11.Z - u7 * v8;
            local v12 = SpecialMesh;
            v12.Scale = v12.Scale + Vector3.new(u5.X * BonusSpeed, u5.Y * BonusSpeed, u5.Z * BonusSpeed) * v8;
            local v13 = Part;
            v13.Transparency = v13.Transparency + u6 * (u1.Transparency == "In" and -1 or 1) * v8;
        until not Part or (Part.Transparency < 0 or Part.Transparency > 1);

        if Part then
            Part:Destroy();
        end;

        table.clear(u1);
        table.clear(u5);
    end);
end;