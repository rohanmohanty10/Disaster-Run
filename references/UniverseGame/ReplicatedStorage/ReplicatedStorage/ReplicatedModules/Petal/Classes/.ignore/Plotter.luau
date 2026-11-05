  

 

return function(p1) -- Line: 1
    local u2 = p1("New");
    local u3 = p1("Util");
    local u4 = {};
    u4.__index = u4;

    function u4.new() -- Line: 8
        -- upvalues: u4 (copy)
        return setmetatable({
            f = nil
        }, u4);
    end;

    function u4.Plot(p5, p6, p7) -- Line: 13
        -- upvalues: u2 (copy), u3 (copy)
        p5.f = p6;
        local u8 = u2("Model")({
            Name = "Plot"
        });
        local v9 = u2("Collection");

        for i = 0, p7 do
            local v10 = p5.f(i);
            local v11 = u2("Part")({
                Anchored = true,
                Size = Vector3.new(0.1, 0.1, 0.1),
                Material = "Neon",
                Transparency = 1,
                Name = "PlotPoint" .. i,
                Parent = u8
            });
            v9:Add(v11);
            v11.Position = Vector3.new(0, 10, 0) + Vector3.new(i * (p7 / 100), v10, 0);
        end;

        v9:forEach(function(p12, p13, p14) -- Line: 36
            -- upvalues: u3 (ref), u2 (ref), u8 (copy)
            local v15 = p12:atIndex(p14 + 1);
            local v16 = 360 / p12:Len();

            if v15 then
                local v17 = CFrame.new(p13.Position, v15.Position) * CFrame.new(0, 0, -u3.Magnitude(p13.Position, v15.Position) / 2);
                u2("Part")({
                    Anchored = true,
                    Material = "Neon",
                    Size = Vector3.new(0.5, 0.5, u3.Magnitude(p13.Position, v15.Position)),
                    Parent = u8,
                    CFrame = v17,
                    Color = Color3.fromHSV(v16 * p14 / 360, 0.7, 0.7)
                });
            end;
        end);
        u8.Parent = workspace;
    end;

    return u4;
end;