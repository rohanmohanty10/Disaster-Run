  

 

return function(u1) -- Line: 1
    local Type = script.Parent.Type;
    local u2 = {
        Skins = Type.Skins,
        Stands = Type.Stands,
        Items = Type.Items,
        Mounts = Type.Mounts,
        KillEffects = Type.KillEffects
    };
    u1.LastTradeTab = nil;

    function u1.SetTradeTab(p3) -- Line: 11
        -- upvalues: u2 (copy), u1 (copy)
        for i, v in pairs(u2) do
            if p3 == i then
                v.TextTransparency = 0;
            else
                v.TextTransparency = 0.5;
            end;
        end;

        u1.SetTradeInventory(p3);
    end;

    for i, v in pairs(u2) do
        v.MouseButton1Click:Connect(function() -- Line: 23
            -- upvalues: u1 (copy), i (copy)
            u1.SetTradeTab(i);
        end);
    end;
end;