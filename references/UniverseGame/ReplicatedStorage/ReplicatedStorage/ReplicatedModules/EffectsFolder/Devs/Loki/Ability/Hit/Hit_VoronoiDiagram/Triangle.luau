  

 

return function(u1) -- Line: 2
    return function(p2, p3, p4, p5) -- Line: 2
        -- upvalues: u1 (copy)
        local v6 = {
            {
                Longest = p4 - p2,
                Other = p3 - p2,
                Origin = p2
            },
            {
                Longest = p2 - p3,
                Other = p4 - p3,
                Origin = p3
            },
            {
                Longest = p3 - p4,
                Other = p2 - p4,
                Origin = p4
            }
        };
        local v7 = v6[1];

        for i = 2, #v6 do
            if v6[i].Longest.magnitude > v7.Longest.magnitude then
                v7 = v6[i];
            end;
        end;

        local v8 = v7.Longest.unit:Dot(v7.Other.unit);
        local v9 = math.acos(v8);
        local v10 = math.cos(v9) * v7.Other.magnitude;
        local v11 = v7.Longest.magnitude - v10;
        local v12 = math.sin(v9) * v7.Other.magnitude;
        local v13 = v7.Origin + v7.Other * 0.5;
        local v14 = v7.Origin + v7.Longest + (v7.Other - v7.Longest) * 0.5;
        local unit = v7.Longest:Cross(v7.Other).unit;
        local unit2 = unit:Cross(v7.Longest).unit;
        local unit3 = v7.Longest.unit;
        local v15 = CFrame.new(v13.x, v13.y, v13.z, -unit.x, unit2.x, unit3.x, -unit.y, unit2.y, unit3.y, -unit.z, unit2.z, unit3.z);
        local v16 = CFrame.new(v14.x, v14.y, v14.z, unit.x, unit2.x, -unit3.x, unit.y, unit2.y, -unit3.y, unit.z, unit2.z, -unit3.z);
        local v17 = u1:GetPart();
        v17.Size = vector.create(0.5, v12, v10);
        v17.Parent = p5;
        v17.T1.Face = Enum.NormalId.Right;
        local v18 = u1:GetPart();
        v18.Size = vector.create(0.5, v12, v11);
        v18.Parent = p5;
        v17.T1.Transparency = 1;
        v18.T1.Transparency = 1;

        return v17, v18, v15, v16;
    end;
end;