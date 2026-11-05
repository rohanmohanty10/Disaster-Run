  

 

game:GetService("Debris");

return function(p1, ...) -- Line: 2
    local _ = task.wait;
    ({
        MoonHit = function(p2, p3, p4) -- Line: 5
        end,

        UmbraHit = function(p5, p6, p7) -- Line: 18
        end,

        YoneHit = function(p8, p9, p10) -- Line: 31
        end,

        YasHit = function(p11, p12, p13) -- Line: 45
        end
    })[p1](...);
end;