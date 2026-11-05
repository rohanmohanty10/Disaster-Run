  

 

return function(p1) -- Line: 1
    local LocalPlayer = game:GetService("Players").LocalPlayer;
    local Knit = p1.Knit;
    Knit.OnStart():await();
    local v2 = Knit.GetService("TraitService");
    local u3 = require(script.TraitRerollUI).new(script.Parent, p1);
    LocalPlayer.Data.Ability:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 12
        -- upvalues: u3 (copy)
        u3:Update();
    end);
    LocalPlayer.Data.Ability:GetAttributeChangedSignal("Trait"):Connect(function() -- Line: 16
        -- upvalues: u3 (copy)
        u3:Update();
    end);
    v2.TraitUpdated:Connect(function() -- Line: 20
        -- upvalues: u3 (copy)
        u3:Update();
    end);
    p1.CurrencyUpdated:Connect(function(p4) -- Line: 24
        -- upvalues: u3 (copy)
        if p4 ~= "Changed" then
            return;
        end;

        u3:UpdateCurrencies();
    end);

    function p1.ShowTraitReroll(p5) -- Line: 29
        -- upvalues: u3 (copy)
        u3:Load();
    end;
end;