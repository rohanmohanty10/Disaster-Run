  

 

return function(p1) -- Line: 1
    local _ = game:GetService("Players").LocalPlayer;
    p1.Knit.OnStart():await();
    local u2 = require(script.DamageLogUI).new(script.Parent, p1);

    function p1.ShowDamageList(p3, p4, p5, p6) -- Line: 11
        -- upvalues: u2 (copy)
        u2:Load(p4, p5, p6);
    end;
end;