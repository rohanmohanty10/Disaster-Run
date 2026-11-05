  

 

local function u2(p1) -- Line: 1
    if p1 then
        if typeof(p1) ~= "table" then
            return false;
        end;

        for _, v in pairs(p1) do
            if typeof(v) ~= "CFrame" then
                return false;
            end;
        end;

        return true;
    end;

    warn("POINTS NOT GIVEN");
end;

return function(p3, p4, p5, p6, p7) -- Line: 17
    -- upvalues: u2 (copy)
    if not p6 then
        warn("NO SEGMENTS GIVEN");

        return;
    end;

    if u2({ p3, p4, p5 }) then
        local Position = p3.Position;
        local Position2 = p4.Position;
        local Position3 = p5.Position;
        local v8 = { Position, Position2, Position3 };

        if p7 then
            for i = 1, 3 do
                local v9 = v8[i];
                local Part = Instance.new("Part");
                Part.Size = Vector3.new(1, 1, 1);
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.Color = Color3.fromRGB(255, 0, 0);
                Part.Material = Enum.Material.Neon;
                Part.Position = v9;
                Part.Parent = workspace.Effects;
                game.Debris:AddItem(Part, 1);
            end;
        end;

        local v10 = {};

        for i = 0, 1, 1 / p6 do
            v10[#v10 + 1] = (1 - i) ^ 2 * Position + (1 - i) * 2 * i * Position2 + i ^ 2 * Position3;
        end;

        return v10;
    end;

    warn("NOT PASSED");
end;