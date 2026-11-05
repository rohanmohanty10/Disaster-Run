  

 

return function(u1) -- Line: 1
    function u1.Emit(u2, p3) -- Line: 2
        local v4 = u2:GetAttribute("EmitDelay");
        local u5 = p3 or (u2:GetAttribute("EmitCount") or u2.Rate);
        local v6 = u2.Lifetime.Max + (v4 or 0);

        if v4 and v4 > 0 then
            task.delay(v4, function() -- Line: 7
                -- upvalues: u2 (copy), u5 (copy)
                u2:Emit(u5);
            end);

            return v6;
        end;

        u2:Emit(u5);

        return v6;
    end;

    function u1.Weld(p7, p8, p9, p10, p11) -- Line: 16
        local Weld = Instance.new("Weld");
        Weld.Part0 = p7;
        Weld.Part1 = p8;
        Weld.Parent = p9 or Weld.Part0;
        Weld.C0 = p10 or CFrame.new();
        Weld.C1 = p11 or CFrame.new();

        return Weld;
    end;

    function u1.LoopedEmit(p12) -- Line: 26
        -- upvalues: u1 (copy)
        local ParentObject = p12.ParentObject;
        local v13 = p12.DestroyTime or 1;
        local CustomAmount = p12.CustomAmount;
        local _ = p12.NoDestroy;

        for _, descendant in pairs(ParentObject:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") then
                local v14 = u1.Emit(descendant, CustomAmount);

                if v13 < v14 then
                    v13 = v14;
                end;
            end;
        end;

        game.Debris:AddItem(ParentObject, v13);
    end;
end;