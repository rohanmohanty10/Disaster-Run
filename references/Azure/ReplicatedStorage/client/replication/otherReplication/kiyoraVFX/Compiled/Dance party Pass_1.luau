 
 

return {
    { 0, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Ball.Crescents, p1.Ball.Impact);
        end },
    { 30, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4["Dance Party Pass"].Spinnydih3);
        end },
    { 38, function(p5, p6) -- Line: 13
            shared.vfx.emit(p6["Dance Party Pass"].Swing, p5.Ball.Impact, p5.Ball.Crescents);
        end },
    { 56, function(p7, p8) -- Line: 18
            shared.vfx.emit(p8["Dance Party Pass"].Up2);
        end },
    { 92, function(p9, p10) -- Line: 23
            shared.vfx.emit(p9.Ball.Impact, p9.Ball.Crescents, p10["Dance Party Pass"]["Dance Party Kick"]);
        end }
};