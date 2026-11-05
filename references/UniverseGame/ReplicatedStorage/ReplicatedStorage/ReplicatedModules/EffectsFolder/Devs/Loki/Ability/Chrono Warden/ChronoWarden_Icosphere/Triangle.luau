  

 

local WedgePart = Instance.new("WedgePart");
WedgePart.Anchored = true;
WedgePart.TopSurface = Enum.SurfaceType.Smooth;
WedgePart.BottomSurface = Enum.SurfaceType.Smooth;
WedgePart.Material = Enum.Material.SmoothPlastic;
WedgePart.CanCollide = false;

return function(p1, p2, p3, p4) -- Line: 8
    -- upvalues: WedgePart (copy)
    local v5 = {
        {
            longest = p3 - p1,
            other = p2 - p1,
            origin = p1
        },
        {
            longest = p1 - p2,
            other = p3 - p2,
            origin = p2
        },
        {
            longest = p2 - p3,
            other = p1 - p3,
            origin = p3
        }
    };
    local v6 = v5[1];

    for i = 2, #v5 do
        if v5[i].longest.magnitude > v6.longest.magnitude then
            v6 = v5[i];
        end;
    end;

    local v7 = v6.longest.unit:Dot(v6.other.unit);
    local v8 = math.acos(v7);
    local v9 = math.cos(v8) * v6.other.magnitude;
    local v10 = v6.longest.magnitude - v9;
    local v11 = math.sin(v8) * v6.other.magnitude;
    local v12 = v6.origin + v6.other * 0.5;
    local v13 = v6.origin + v6.longest + (v6.other - v6.longest) * 0.5;
    local unit = v6.longest:Cross(v6.other).unit;
    local unit2 = unit:Cross(v6.longest).unit;
    local unit3 = v6.longest.unit;
    local v14 = CFrame.new(v12.x, v12.y, v12.z, -unit.x, unit2.x, unit3.x, -unit.y, unit2.y, unit3.y, -unit.z, unit2.z, unit3.z);
    local v15 = CFrame.new(v13.x, v13.y, v13.z, unit.x, unit2.x, -unit3.x, unit.y, unit2.y, -unit3.y, unit.z, unit2.z, -unit3.z);
    local v16 = WedgePart:Clone();
    v16.Size = Vector3.new(0, v11, v9);
    v16.CFrame = v14;
    v16.Parent = p4 or workspace.Terrain;
    local v17 = WedgePart:Clone();
    v17.Size = Vector3.new(0, v11, v10);
    v17.CFrame = v15;
    v17.Parent = p4 or workspace.Terrain;
    local v18 = Color3.fromRGB(111, 137, 255);
    v16.Material = "SmoothPlastic";
    v17.Material = "SmoothPlastic";
    v16.Color = v18;
    v17.Color = v18;

    return v16, v17;
end;