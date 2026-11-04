 

 

return {
    { 0, function(p1, p2) -- Line: 3
            p1.Start({
                Character = p2
            });
        end },
    { 36, function(p3, p4) -- Line: 9
            p3.TragicBackGround({
                Character = p4
            });
        end },
    { 87, function(p5, p6) -- Line: 15
            p5.Step({
                Character = p6
            });
        end },
    { 93, function(p7, p8) -- Line: 21
            p7.ActualStep({
                Character = p8
            });
        end },
    { 112, function(p9, p10) -- Line: 27
            p9.Transition({
                Character = p10
            });
        end },
    { 119, function(p11, p12, p13) -- Line: 33
            p11.AuraFarm({
                Character = p12,
                Camera = p13
            });
        end },
    { 197, function(p14, p15) -- Line: 39
            p14.ActualStep2({
                Character = p15
            });
        end },
    { 210, function(p16, p17) -- Line: 45
            p16.Transition({
                Character = p17
            });
        end },
    { 217, function(p18, p19) -- Line: 51
            p18.LastAura({
                Character = p19
            });
        end }
};