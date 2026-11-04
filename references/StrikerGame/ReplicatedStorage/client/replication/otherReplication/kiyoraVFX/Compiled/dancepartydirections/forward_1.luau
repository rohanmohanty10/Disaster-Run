 
 

return {
    { 6, function(p1, p2) -- Line: 3
            shared.vfx.emit(p2["Dance Party Front"].Up, p2["Dance Party Front"].Swing, p2["Dance Party Front"].Spinnydih4, p1.Ball.Impact, p1.Ball.Crescents);
        end },
    { 37, function(p3, p4) -- Line: 8
            shared.vfx.emit(p4["Dance Party Front"].Spinnydih3, p4["Dance Party Front"].Up.Attachment);
        end },
    { 58, function(p5, p6) -- Line: 13
            shared.vfx.emit(p5.Ball.Impact, p5.Ball.Crescents);
        end }
};