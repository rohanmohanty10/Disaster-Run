  

local u17 = {
    number = {
        to = function(p1: number) -- Line: 5, Name: to
            return { p1 };
        end,

        from = function(p2: table) -- Line: 8, Name: from
            return p2[1];
        end
    },
    table = {
        to = function(p3: table) -- Line: 14, Name: to
            return p3;
        end,

        from = function(p4: table) -- Line: 17, Name: from
            return p4;
        end
    },
    UDim2 = {
        to = function(p5) -- Line: 23, Name: to
            return {
                p5.X.Scale,
                p5.X.Offset,
                p5.Y.Scale,
                p5.Y.Offset
            };
        end,

        from = function(p6: table) -- Line: 26, Name: from
            return UDim2.new(p6[1], math.round(p6[2]), p6[3], (math.round(p6[4])));
        end
    },
    UDim = {
        to = function(p7) -- Line: 32, Name: to
            return { p7.Scale, p7.Offset };
        end,

        from = function(p8: table) -- Line: 35, Name: from
            return UDim.new(p8[1], (math.round(p8[2])));
        end
    },
    Vector2 = {
        to = function(p9) -- Line: 41, Name: to
            return { p9.X, p9.Y };
        end,

        from = function(p10: table) -- Line: 44, Name: from
            return Vector2.new(table.unpack(p10, 1, 2));
        end
    },
    Vector3 = {
        to = function(p11: vector) -- Line: 50, Name: to
            return { p11.X, p11.Y, p11.Z };
        end,

        from = function(p12: table) -- Line: 53, Name: from
            return Vector3.new(table.unpack(p12, 1, 3));
        end
    },
    Color3 = {
        to = function(p13) -- Line: 59, Name: to
            return { p13.R, p13.G, p13.B };
        end,

        from = function(p14: table) -- Line: 62, Name: from
            return Color3.new(math.clamp(p14[1], 0, 1), math.clamp(p14[2], 0, 1), (math.clamp(p14[3], 0, 1)));
        end
    },
    CFrame = {
        to = function(p15) -- Line: 68, Name: to
            return { p15:GetComponents() };
        end,

        from = function(p16: table) -- Line: 71, Name: from
            return CFrame.new(table.unpack(p16));
        end
    }
};

return {
    to = function(p18) -- Line: 77, Name: to
        -- upvalues: u17 (copy)
        local v19 = typeof(p18);

        if u17[v19] then
            return u17[v19].to(p18);
        end;

        error((`Ripple received an unsupported value '{p18}' of type '{v19}'`));
    end,

    from = function(p20: table, p21: string) -- Line: 87, Name: from
        -- upvalues: u17 (copy)
        if u17[p21] then
            return u17[p21].from(p20);
        end;

        error((`Ripple received an unsupported value '{p20}' of type '{p21}'`));
    end,

    index = function(p22: table, p23: any) -- Line: 95, Name: index
        return p22[p23] or p22[1];
    end
};