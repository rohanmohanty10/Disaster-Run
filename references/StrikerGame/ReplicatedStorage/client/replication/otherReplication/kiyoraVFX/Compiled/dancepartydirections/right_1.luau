 
 

return {
    { 6, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2["Dance Party Right"].Spinnydih4, p2["Dance Party Right"].Swing, p2["Dance Party Right"].Up, p1.Ball.Impact, p1.Ball.Crescents);
        end },
    { 36, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4["Dance Party Right"].Up, p4["Dance Party Right"].Spinnydih3);
        end },
    { 58, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.Ball.Impact, p5.Ball.Crescents);
        end }
};