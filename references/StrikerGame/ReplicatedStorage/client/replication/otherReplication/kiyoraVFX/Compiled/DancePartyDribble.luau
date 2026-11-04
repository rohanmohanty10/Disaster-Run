 

 

return {
    { 12, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Ball.Impact, p1.Ball.Crescents);
        end },
    { 24, function(p3, p4) -- Line: 8
            shared.vfx.emit(p3.Ball.Impact, p3.Ball.Crescents);
        end },
    { 34, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6["Dance Party Right"].Hand);
        end },
    { 54, function(p7, p8) -- Line: 18
            shared.vfx.emit(p8["Dance Party Dribble"].Spinnydih2, p7.Ball.Impact, p7.Ball.Crescents);
        end },
    { 76, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.Ball.Impact, p9.Ball.Crescents);
        end },
    { 116, function(p11, p12) -- Line: 28
            shared.vfx.emit(p12["Dance Party Dribble"].Spinnydih, p11.Ball.Impact, p11.Ball.Crescents);
        end },
    { 132, function(p13, p14) -- Line: 33
            shared.vfx.emit(p13.Ball.Impact, p13.Ball.Crescents);
        end },
    { 170, function(p15, p16) -- Line: 38
            shared.vfx.emit(p16["Dance Party Dribble"].Swing, p16["Dance Party Dribble"].Spinnydih3, p15.Ball.Impact, p15.Ball.Crescents);
        end },
    { 192, function(p17, p18) -- Line: 43
            shared.vfx.emit(p17.Ball.Impact, p17.Ball.Crescents);
        end }
};