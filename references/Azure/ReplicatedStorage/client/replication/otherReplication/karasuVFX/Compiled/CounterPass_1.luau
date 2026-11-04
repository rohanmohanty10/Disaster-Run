 
 

return {
    { 4, function(p1, p2) -- Line: 7
            p1.Feint({
                Character = p2
            });
        end },
    { 11, function(p3, p4) -- Line: 12
            local _ = game.ReplicatedStorage;
            p3.Jump({
                Character = p4
            });
        end },
    { 18, function(p5, p6) -- Line: 18
            p5.Grab({
                Character = p6
            });
            p5.Star({
                Character = p6
            });
        end },
    { 19, function(p7, p8) -- Line: 24
            p7.Bezier({
                Character = p8
            });
        end },
    { 39, function(p9, p10) -- Line: 29
            p9.Impact({
                Character = p10
            });
        end }
};