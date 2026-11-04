 

 

return {
    { 6, function(p1, p2) -- Line: 3
            shared.vfx.emit(p1.Ball.Impact, p1.Ball.Crescents, p2["Dance Party Left"].Up, p2["Dance Party Left"].Swing, p2["Dance Party Left"].Spinnydih4);
        end },
    { 36, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4["Dance Party Left"].Up.Attachment, p4["Dance Party Left"].Spinnydih3);
        end },
    { 58, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.Ball.Impact, p5.Ball.Crescents);
        end }
};