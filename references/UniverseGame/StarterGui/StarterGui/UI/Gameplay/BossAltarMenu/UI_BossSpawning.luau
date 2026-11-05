  

 

return function(p1) -- Line: 1
    local _ = game:GetService("Players").LocalPlayer;
    p1.Knit.OnStart():await();
    local u2 = require(script.BossSpawnUI).new(script.Parent, p1);

    function p1.ShowAltarMenu(p3, p4) -- Line: 12
        -- upvalues: u2 (copy)
        u2:Load(p4);
    end;
end;