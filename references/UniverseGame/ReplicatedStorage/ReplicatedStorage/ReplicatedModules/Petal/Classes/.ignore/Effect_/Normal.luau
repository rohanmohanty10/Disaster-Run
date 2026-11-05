  

 

game:GetService("TweenService");

return function(p1, u2) -- Line: 3
    local u3 = p1("New");
    local u4 = p1("Math");
    local u5 = {};
    u5.__index = u5;

    function u5.new() -- Line: 10
        -- upvalues: u5 (copy), u2 (copy), u3 (copy)
        local v6 = {
            Object = nil,
            Animated = {},
            _props = {},
            _created = os.clock()
        };
        local v7 = setmetatable(v6, u5);
        local u8 = u2.Object or u3("Part")({
            Name = "Effect",
            CastShadow = false,
            Anchored = true,
            CanCollide = false,
            Parent = workspace,
            Size = Vector3.new()
        });
        v7.Object = u8;

        for i, v in pairs(u2.Properties) do
            local success, result = pcall(function() -- Line: 17
                -- upvalues: v (copy), u8 (copy), i (copy)
                if typeof(v) == "number" then
                    return;
                end;

                u8[i]:Lerp(u8[i], 1);
            end);

            if success then
                v7.Animated[i] = true;
                v7._props[i] = v;
                u8[i] = v[1];
            else
                warn(result);
            end;
        end;

        return v7;
    end;

    function u5.Update(p9) -- Line: 34
        -- upvalues: u2 (copy), u4 (copy)
        local Duration = u2.Duration;
        local v10 = u4.Min(os.clock() - p9._created, Duration);

        for i, _ in pairs(p9.Animated) do
            p9.Object[i] = p9._props[i][1]:Lerp(p9._props[i][2], v10 / Duration);
        end;

        return v10;
    end;

    function u5.Set(u11, p12) -- Line: 47
        for i = 1, #p12 do
            local v13 = p12[i];
            local u14 = v13[1];
            local u15 = v13[2];

            if u11.Animated[u14] == nil then
                local success, result = pcall(function() -- Line: 58
                    -- upvalues: u11 (copy), u14 (copy), u15 (copy)
                    u11.Object[u14] = u15;
                end);

                if not success then
                    warn(result);
                end;
            else
                u11.Animated[u14] = nil;
                u11.Object[u14] = u15;
            end;
        end;
    end;

    return u5;
end;