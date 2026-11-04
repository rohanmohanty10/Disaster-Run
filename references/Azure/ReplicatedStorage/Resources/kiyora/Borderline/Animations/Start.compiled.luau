 
 

return {
    { 8, function(p1) -- Line: 3
            shared.vfx.emit(p1.Ball.Thing);
        end },
    { 18, function(p2) -- Line: 8
            shared.vfx.emit(p2.Head.nagieyes2, p2.Head.nagieyes1);
        end },
    { 94, function(p3) -- Line: 13
            shared.vfx.emit(p3.Head.nagieyes1.Burst, p3.Head.nagieyes2.Burst, p3.Head.nagieyes2.wind1, p3.Head.nagieyes1.wind1);
        end }
};