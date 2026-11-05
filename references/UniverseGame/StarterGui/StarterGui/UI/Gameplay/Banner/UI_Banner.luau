  

 

return function(p1) -- Line: 1
    p1.Knit.OnStart():await();
    local u2 = require(script.BannerUI).new(script.Parent, p1);

    function p1.ShowGachaBanner(p3) -- Line: 9
        -- upvalues: u2 (copy)
        u2:Load();
    end;
end;